#=================================================================================# 
# Recurvive extendible type for representation of phylogenetic trees in in Julia. #
#=================================================================================#

# Ben J. Ward, 2014.

# Extension type - parametric
type PhyExtension{T}
  value::T
end

# Node type.
type PhyNode
  name::String
  branchlength::Float64
  extensions::Vector{PhyExtension}
  children::Vector{PhyNode}
  parent::PhyNode
  PhyNode() = (x = new("", 0.0, PhyNode[], PhyNode[]); x.parent = x)
end

#=
A note about the default no-argument constructor. You'll notice it incompletely initializes the instance of PhyNode,
before filling in the Parent field with a reference to itself. This means the node has no parent and so could be a root,
it could also just be a node that has been created, perhaps in a function, but will be added to another set of nodes subsequently
in order to build up a tree. Alternatively the user could have just popped it off the tree. I figured a self referential
node would be the best way to do this rather than have #undef values lurking. It also allows removal of a parent from a node for something like
say the cutting / pruning of a subtree, since you simply need to set the parent field to point to itself, whereas to my knowlege, once a var in Julia
is set it cannot be made #undef.
 =#

# Node constructors.
function PhyNode(label::String, branchlength::Float64, ext::Array{PhyExtension, 1}, parent::PhyNode)
  x = PhyNode()
  setname!(x, label)
  setbranchlength!(x, branchlength)
  x.extensions = ext
  setparent!(x, parent)
  return x
end

function PhyNode(parent::PhyNode)
  x = PhyNode()
  setparent!(x, parent)
  return x
end

function PhyNode(branchlength::Float64, parent::PhyNode)
  x = PhyNode()
  setbranchlength!(x, branchlength)
  setparent!(x, parent)
  return x
end

function PhyNode(label::String)
  x = PhyNode()
  setname!(x, label)
  return x
end

### Node Manipulation / methods on the PhyNode type...

## Getting information from a node...

function isempty(x::PhyNode)
  return x.name == "" && x.branchlength == 0.0 && !hasextensions(x) && !haschildren(x) && parentisself(x)
end

function getname(x::PhyNode)
  return x.name
end

function getbranchlength(x::PhyNode)
  return x.branchlength
end

function isleaf(x::PhyNode)
  return hasparent(x) && !haschildren(x)
end

function haschildren(x::PhyNode)
  return length(x.children) > 0
end

function hasextensions(x::PhyNode)
  return length(x.extensions) > 0
end

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
function parentisself(x::PhyNode)
  return x.parent == x
end

function hasparent(x::PhyNode)
  return !parentisself(x)
end

# Should x.Children that is returned be a copy? x.Children is an array of
# refs to the child nodes, so x.Children is mutable.
function getchildren(x::PhyNode)
  return x.children
end

function getsiblings(x::PhyNode)
  if hasparent(x)
    return getchildren(x.parent)
  end
end

function getparent(x::PhyNode)
  if parentisself(x)
    println("Node does not have a parent. It is self referential.")
  end
  return x.parent
end

function isroot(x::PhyNode)
  return parentisself(x) && haschildren(x)
end

function isnode(x::PhyNode)
  return hasparent(x) && haschildren(x)
end

function ispreterminal(x::PhyNode)
  if isleaf(x)
    return false
  end
  return all([isleaf(i) for i in x.children])
end

# A node returning true for isPreTerminal, would also return true for this function.
function issemipreterminal(x::PhyNode)
  areleaves = [isleaf(i) for i in x.children]
  return any(areleaves) && !all(areleaves)
end

function getdescendents(x::PhyNode)
  return collect(PhyNode, DepthFirst(x))
end

function getterminaldescendents(x::PhyNode)
  return searchall(DepthFirst(x), isleaf)
end

# Test that the posanc node is ancestral to the given nodes.
function isancestral(posanc::PhyNode, nodes::Array{PhyNode})
  return all([in(node, getdescendents(posanc)) for node in nodes])
end

# I'm not sure this is the best way to get the MRCA of a set of nodes, but I think it's valid: As you climb a tree from any specified tip to the root.
# if you keep checking the terminal descendents as you climb - the first node you hit that has all specified nodes as terminal descendents is 
# the MRCA. I found it dificult to choose the best way as if you want the mrca of 2 fairly related nodes, you'll get the answer sooner searching from tips 2 root,
# however this would take longer 
function getmrca(nodes::Array{PhyNode})
  return search(Tip2Root(nodes[1]), x -> isancestral(x, nodes))
end


## Setting information on a node...
 
function setname!(x::PhyNode, name::String)
  x.name = name
end

function setbranchlength!(x::PhyNode, bl::Float64)
  x.branchlength = bl
end

# Removing a parent makes a node self referential in the Parent field like a root node.
# Avoids possible pesky #undef fields.  
function removeparent!(x::PhyNode)
  setparent!(x, x)
end

function setparent!(child::PhyNode, parent::PhyNode)
  child.parent = parent
end

function addchild!(parent::PhyNode, child::PhyNode)
  push!(parent.children, child)
end

function removechild!(parent::PhyNode, child::PhyNode)
  filter!(x -> !(x == child), parent.children)
end

function graft!(parent::PhyNode, child::PhyNode)
  # When grafting a subtree to another tree, or node to a node. You make sure that if it already has a parent.
  # Its reference is removed from the parents Children field.
  if hasparent(child)
    removechild!(child.parent, child)
  end
  setparent!(child, parent)
  addchild!(parent, child)
end

function graft!(parent::PhyNode, child::PhyNode, branchlength::Float64)
    graft!(parent, child)
    setbranchlength!(child, branchlength)
end

function graft!(parent::PhyNode, children::PhyNode...)
  for i in children
    graft!(parent, i)
  end
end

function prune!(x::PhyNode)
  if hasparent(x)
    # You must make sure the parent of this node from which you are pruning, does not contain a reference to it.
    removechild!(x.parent, x)
    removeparent!(x)
    return x
  else
    error("Can't prune from this node, it is either a single node without parents or children, or is a root of a tree / subtree.")
  end
end

# Tree type.
type Phylogeny
  name::String
  root::PhyNode
  rooted::Bool
  rerootable::Bool

  Phylogeny() = new("", PhyNode(), false, true)
end

# Phylogeny constructors...
function Phylogeny(name::String, root::PhyNode, rooted::Bool, rerootable::Bool)
  x = Phylogeny()
  setname!(x, name)
  setroot!(x, root)
  setrooted!(x, rooted)
  setrerootable!(x, rerootable)
  return x
end

function isempty(x::Phylogeny)
  return isempty(x.root)
end

function setname!(x::Phylogeny, name::String)
  x.name = name
end

function isrooted(x::Phylogeny)
  return x.rooted
end

function isrerootable(x::Phylogeny)
  return x.rerootable
end

function setroot!(x::Phylogeny, y::PhyNode)
  if x.rerootable == false
    error("Phylogeny is not rerootable!")
  end
  x.root = y
  x.rooted = true
end

# This is probably unnessecery given setroot puts the rooted flag to true.
# perhaps and unroot! method is more appropriate.
function setrooted!(x::Phylogeny, rooted::Bool)
  x.rooted = rooted
end

function setrerootable!(x::Phylogeny, rerootable::Bool)
  x.rerootable = rerootable
end

#=
Getindex is used to get a node by name. For a large tree, repeatedly calling this may not be performance optimal.
To address this, I provide a method to create a dictionary based index for accessing nodes without search. This is the 
generateIndex method.
I'm uncertain whether it is better to get index with a singe search of all the nodes - searchAll, or to do many 
individual search()-es.
=#

function Base.getindex(tree::Phylogeny, names::String...)
  return searchall(DepthFirst(tree), x -> in(getname(x), names))
end

function generateindex(tree::Phylogeny)
  output = Dict{String, PhyNode}()
  for i = BreadthFirst(tree)
    if haskey(output, getname(i))
      error("You are trying to build an index dict of a tree with clades of the same name.")
    end
    output[getname(i)] = i
  end
  return output
end





