#==========================================#
# IO phylogenies stored in various formats #
#==========================================#

# Ben J. Ward 2015


# Recusrsiveley builds tree structure from PhyloXML format.
function buildrecursively(xmlclade::LightXML.XMLElement, extensionsArray)
  label::String = ""
  node::PhyNode = PhyNode(name = label, branchlength = (bl == nothing ? -1.0 : float(bl)), ext = PhyExtension[parsephylo(xmlclade, i) for i in extensionsArray])
  xmlchildren::Array{LightXML.XMLElement, 1} = LightXML.get_elements_by_tagname(xmlclade, "clade")
  for n in xmlchildren
    graft!(node, buildrecursively(n, extensionsArray))
  end
  return node
end

function parsephyloxml(xmltree::XMLElement, ::Type{Phylogeny}, extensions) # extensions is a tuple of types.
  # Get the first clade of the tree - the root clade in the XML, the recursiveley build up the tree structure.
  # Function assumes a tree is rerootable unless otherwise specified, and assumes it's not rooted unless otherwise specified in the file.
  # Function also assumes that there is and can only be one name for the tree.
  XML::XMLElement = get_elements_by_tagname(xmltree, "clade")[1]
  root::PhyNode = buildRecursively(XML, extensions, nothing)
  name::Array{XMLElement, 1} = get_elements_by_tagname(xmltree, "name")
  treename = length(name) == 1 ? content(name[1]) : ""
  rerootable::Bool = attribute(xmltree, "rerootable") == "false" ? true : false
  rooted::Bool = attribute(xmltree, "rooted") == "true" ? true : false
  return Phylogeny(treename, root, rooted, rerootable)
end

# Open to suggestions making this function neater re deciding on different formats. Since branching conditionally on the format variable seems less neat to me,
# than taking advantage of method dispatch. Perhaps some dummy types for the input formats to allow method dispatch would be better?

function readphyloxml(file::String, Extensions...)
  treedoc::XMLDocument = parse_file(expanduser(file))
  phylogenies::Array{XMLElement,1} = get_elements_by_tagname(root(treedoc), "phylogeny")
  if length(phylogenies) > 1
    return [parsephyloxml(i, Phylogeny, Extensions) for i in phylogenies]
  else
    return parsephyloxml(phylogenies[1], Phylogeny, Extensions)
  end
  error("No Trees found in file...")
end

function readnewick(file::String)
  instream = open(expanduser(file))
  instring = readall(instream)
  close(instream)
  newickstrings = split(instring, ';')
  newickstrings = [replace(i, r"(\r|\n|\s)", "") for i in newickstrings]
  newickstrings = newickstrings[bool([length(t) > 0 for t in newickstrings])]
  if length(newickstrings) > 1
    return [parsenewick(i) for i in newickstrings]
  else
    return parsenewick(newickstrings[1])
  end
  error("No phylogenies detected in the file.")
end

type Tokenizer
  dict::Dict{String, Regex}
  tokenizer::Regex
  function Tokenizer(x::Array{(ASCIIString, Regex), 1})
    dictvalues = [i[2] for i in x]
    stringvalues = String[i.pattern for i in dictvalues]
    combinedstring = join(stringvalues, "|")
    finalstring = "($combinedstring)"
    return new([i => j for (i, j) in x], Regex(finalstring))
  end
end

function tokenizestring(s::String, t::Tokenizer)
  return matchall(t.tokenizer, s)
end

function makenewclade()
  return PhyNode()
end

function makenewclade(parent::PhyNode)
  newclade = PhyNode()
  graft!(parent, newclade)
  return newclade
end

function processclade(node::PhyNode, valuesareconf::Bool, commentsareconf::Bool)
  # Check if the node has a name, and if values are not confidence, and there are no conf 
  # values in values or comments, and confience is not known, 
  if name(node) != "" && !(valuesareconf || commentsareconf) && !confisknown(node)
    confidence!(node, parsecondfidence(name(node)))
    if confisknown(node)
      name!(node, "")
    end 
  end
  if hasparent(node)
    parent = parent(node)
    prune!(node)
    graft!(parent, node)
    return parent
  end
end

function parseconfidence(text::String)
  try
    return float(text)
  catch
    return -1.0
  end
end

type NewickException <: Exception
  msg::String
end

Base.showerror(io::IO, e::NewickException) = print(io, "Error parsing newick string: ", e.msg)

function parsenewick(newickstring::String, commentsareconf = false, valuesareconf = false)
  # Create a definition of the tokens that appear in a newick string, and the meanings of them.
  definition = [ ("open paren", r"\("), ("close paren", r"\)"),
  ("unquoted node label", r"[^\s\(\)\[\]\'\:\;\,]+"), ("edge length", r"\:[0-9]*\.?[0-9]+([eE][+-]?[0-9]+)?"),
  ("comma", r"\,"), ("comment", r"\[(\\.|[^\]])*\]"), ("quoted node label", r"\'(\\.|[^\'])*\'"),
  ("semicolon", r"\;"), ("newline", r"\n")]
  tokenizer = Tokenizer(definition)
  # Convet the newick string into a series of tokens than can be considered in turn and understood.
  tokens = tokenizestring(strip(newickstring), tokenizer)
  # Create the first clade, i.e. the root and set the variable that points to the current clade 
  # to the root.
  root = PhyNode("Root")
  current = root
  @assert root === current
  enteringbl = false
  # Assign two variables which will keep track of the number of left and right parentheses.
  leftpcount = 0
  rightpcount = 0
  state = start(tokens)
  while !done(tokens, state)
  token, state = next(tokens, state)
    if beginswith(token, "\'")
      # This is a quoted label, characters need to be added to the clade name.
      name!(current, name(current) * token[2:end])
    elseif beginswith(token, "[")
      # This is a comment.
      # TODO produce a comment type for PhyExtentions and add it to the current clade.
      if commentsareconf
        # TODO produce a numeric support value type for PhyExtentions and add it to current clade.
      end
    elseif token == "("
      # The start of a new clade. It is a child of the current clade.
      current = makenewclade(current)
      enteringbl = false
      leftpcount += 1
    elseif token == ","
      # If the current clade is the root, it means the external parentheses are missing. 
      if current === root
        root = makenewclade()
        name!(root, "Root")
        prune!(current)
        graft!(root, current)
      end
      # Start a new child clade at the same level as the current clade. i.e. a sibling.
      parent = processclade(current, valuesareconf, commentsareconf)
      current = makenewclade(parent)
      enteringbl = false
    elseif token == ')'
      # Addition of children for the current clade is done, so we process it.
      parent = processclade(current, valuesareconf, commentsareconf)
      ### TODO need to sort out some kind of error or catch here for if a parent is not returned.
      current = parent
      enteringbl = false
      rightpcount += 1
    elseif token == ';'
      break
    elseif beginswith(token, ':')
      # This token is branchlength or confidence...
      value = float(token[2:end])
      if valuesareconf
        confidence!(current, value)
      else
        branchlength!(current, value)
      end
    elseif token == '\n'
      continue
    else
      # Current token is an unquoted node label, and so we simply need to set the clade
      # name to the token.
      name!(current, token)
    end
  end
  if leftpcount != rightpcount
    throw(NewickException("The number of left and right parentheses do not match."))
  end
  try
    token, state = next(tokens, state)
    throw(NewickException("There are characters after the semicolon in the newick string."))
  catch exception
    if isa(exception, NewickException)
      rethrow(exception)
    end
  end
  processclade(current)
  processclade(root)
  return Phylogeny("", root, true, true)
end





