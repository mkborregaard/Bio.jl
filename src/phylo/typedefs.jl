
@doc """
PhyExtension allows defining arbitrary metadata to annotate nodes.

This allows the PhyNode type to support any phylogenetic tree format that includes annotations (e.g. PhyloXML, NeXML), and allows programmatic extension of nodes with annotations.
""" ->
type PhyExtension{T}
  value::T
end

@doc """
PhyNode represents a node in a phylogenetic tree.

A node can have:

- `name`
- `branchlength`
- one or more `extensions`
- a reference to its `parent` PhyNode
- reference to one or more `children`

""" ->
type PhyNode
  name::String
  branchlength::Float64
  extensions::Vector{PhyExtension}
  children::Vector{PhyNode}
  parent::PhyNode
  PhyNode() = (x = new("", -1.0, PhyNode[], PhyNode[]); x.parent = x)
end

#=
A note about the default no-argument constructor. You'll notice it incompletely initializes the instance of PhyNode,
before filling in the Parent field with a reference to itself. This means the node has no parent and so could be a root,
it could also just be a node that has been created, perhaps in a function, but will be added to another  of nodes subsequently
in order to build up a tree. Alternatively the user could have just popped it off the tree. I figured a self referential
node would be the best way to do this rather than have #undef values lurking. It also allows removal of a parent from a node for something like
say the cutting / pruning of a subtree, since you simply need to  the parent field to point to itself, whereas to my knowlege, once a var in Julia
is  it cannot be made #undef.
 =#

function PhyNode(name::String = "", branchlength::Float64 = -1.0, ext::Vector{PhyExtension} = PhyExtension[])
  x = PhyNode()
  name!(x, name)
  branchlength!(x, branchlength)
  x.extensions = ext
  x.parent = parent || x
  return x
end

function PhyNode(parent::PhyNode)
  x = PhyNode()
  parent!(x, parent)
  x.parent = x
  return x
end

function PhyNode(name::String = "", branchlength::Float64 = -1.0, ext::Vector{PhyExtension} = PhyExtension[], parent::PhyNode)
  x = PhyNode()
  name!(x, name)
  branchlength!(x, branchlength)
  parent!(x, parent)
  return x
end

function PhyNode(label::String)
  x = PhyNode()
  name!(x, label)
  return x
end

function PhyNode(label::String, branchlength::Float64)
  x = PhyNode()
  name!(x, label)
  branchlength!(x, branchlength)
  x.extensions = ext
  x.parent = parent
  return x
end

### Node Manipulation / methods on the PhyNode type...

## ting information from a node...

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function isempty(x::PhyNode)
  return x.name == "" && x.branchlength == -1.0 && !hasextensions(x) && !haschildren(x) && parentisself(x)
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function getname(x::PhyNode)
  return x.name
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function getbranchlength(x::PhyNode)
  return x.branchlength
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function isleaf(x::PhyNode)
  return hasparent(x) && !haschildren(x)
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function haschildren(x::PhyNode)
  return length(x.children) > 0
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function haschild(parent::PhyNode, child::PhyNode)
  return in(child, parent.children)
end

@doc """
Test whether a node is empty.
""" {
    :parameters => {(:x, "The PhyNode to test.")},
    :returns => (Bool)
    } ->
function hasextensions(x::PhyNode)
  return length(x.extensions) > 0
end

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
function parentisself(x::PhyNode)
  return x.parent === x
end

function hasparent(x::PhyNode)
  return !parentisself(x)
end

# Should x.Children that is returned be a copy? x.Children is an array of
# refs to the child nodes, so x.Children is mutable.
function children(x::PhyNode)
  return x.children
end

function siblings(x::PhyNode)
  if hasparent(x)
    return children(x.parent)
  end
end

function parent(x::PhyNode)
  if parentisself(x)
    println("Node does not have a parent. It is self referential.")
  end
  return x.parent
end

function isroot(x::PhyNode)
  return parentisself(x) && haschildren(x)
end

function isunlinked(x::PhyNode)
  return parentisself(x) && !haschildren(x)
end

function islinked(x::PhyNode)
  return hasparent(x) || haschildren(x)
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

function countchildren(x::PhyNode)
  return length(x.children)
end


# A node returning true for isPreTerminal, would also return true for this function.
function issemipreterminal(x::PhyNode)
  areleaves = [isleaf(i) for i in x.children]
  return any(areleaves) && !all(areleaves)
end


function descendents(x::PhyNode)
  return collect(PhyNode, DepthFirst(x))
end


function terminaldescendents(x::PhyNode)
  return searchall(DepthFirst(x), isleaf)
end


# Test that the posanc node is ancestral to the given nodes.
function isancestral(posanc::PhyNode, nodes::Array{PhyNode})
  return all([in(node, descendents(posanc)) for node in nodes])
end


# I'm not sure this is the best way to  the MRCA of a  of nodes, but I think it's valid: As you climb a tree from any specified tip to the root.
# if you keep checking the terminal descendents as you climb - the first node you hit that has all specified nodes as terminal descendents is
# the MRCA. I found it dificult to choose the best way as if you want the mrca of 2 fairly related nodes, you'll  the answer sooner searching from tips 2 root,
# however this would take longer.
function mrca(nodes::Vector{PhyNode})
  paths = [collect(Tip2Root(i)) for i in nodes]
  convergence = intersect(paths...)
  return convergence[1]
end



## ting information on a node...

function name!(x::PhyNode, name::String)
  x.name = name
end


function branchlength!(x::PhyNode, bl::Float64)
  x.branchlength = bl
end


# Following unsafe functions maniplulate the ting and manipulation of parental and child links.
# They should not be used unless absolutely nessecery - the prune and graft methods ensure the
# bidirectional links between PhyNodes are built and broken cleanly.

# Removing a parent makes a node self referential in the Parent field like a root node.
# Avoids possible pesky #undef fields.
function removeparent_unsafe!(x::PhyNode)
  parent_unsafe!(x, x)
end


function parent_unsafe!(parent::PhyNode, child::PhyNode)
  child.parent = parent
end


function addchild_unsafe!(parent::PhyNode, child::PhyNode)
  if haschild(parent, child)
    error("The child node is already a child of the parent.")
  end
  push!(parent.children, child)
end


function removechild_unsafe!(parent::PhyNode, child::PhyNode)
  filter!(x -> !(x === child), parent.children)
end


function graft!(parent::PhyNode, child::PhyNode)
  # When grafting a subtree to another tree, or node to a node. You make sure that if it already has a parent.
  # its reference is removed from the parents Children field.
  if hasparent(child)
    error("This node is already attached to a parent.")
  end
  parent_unsafe!(parent, child)
  addchild_unsafe!(parent, child)
end


function graft!(parent::PhyNode, child::PhyNode, branchlength::Float64)
    graft!(parent, child)
    branchlength!(child, branchlength)
end


function graft!(parent::PhyNode, children::Vector{PhyNode})
  for i in children
    graft!(parent, i)
  end
end


function prune!(x::PhyNode)
  if hasparent(x)
    # You must make sure the parent of this node from which you are pruning, does not contain a reference to it.
    removechild_unsafe!(x.parent, x)
    removeparent_unsafe!(x)
    return x
  else
    error("Can't prune from this node, it is either a single node without parents or children, or is a root of a tree / subtree.")
  end
end


function pruneregraft!(prune::PhyNode, graftto::PhyNode)
  x = prune!(prune)
  graft!(graftto, x)
end

function pruneregraft!(prune::PhyNode, graftto::PhyNode, branchlength::Float64)
  x = prune!(prune)
  graft!(graftto, x, branchlength)
end

function delete!(x::PhyNode)
  deleted = prune!(x)
  graft!(parent(deleted), children(deleted))
end

function detach!(x::PhyNode)
  detached = prune!(x)
  return Phylogeny("", detached)
end

function detach!(x::PhyNode, name::String, rooted::Bool, rerootable::Bool)
  detached = prune!(x)
  return Phylogeny(name, detached, rooted, rerootable)
end


function isequal(x::PhyNode, y::PhyNode)
  bl = x.branchlength == y.branchlength
  n = x.name == y.name
  exts = x.extensions == y.extensions
  return all([bl, n, exts])
end


@doc """
Phylogeny represents a phylogenetic tree.

A tree can have:

- `name`
- `root`
- `rooted`
- `rerootable`

""" ->
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
  name!(x, name)
  x.root = root
  x.rooted = rooted
  rerootable!(x, rerootable)
  return x
end

function Phylogeny(root::PhyNode)
  x = Phylogeny()
  x.root = root
  return x
end


function isempty(x::Phylogeny)
  return isempty(x.root)
end


function name!(x::Phylogeny, name::String)
  x.name = name
end


function isrooted(x::Phylogeny)
  return x.rooted
end


function isrerootable(x::Phylogeny)
  return x.rerootable
end


function root(x::Phylogeny)
  return x.root
end

function isintree(tree::Phylogeny, clade::PhyNode)
  s = search(BreadthFirst(tree), x -> x === clade)
  return typeof(s) == PhyNode
end

function maxindict(dictionary::Dict, op::Function)
  keyvalpairs = collect(dictionary)
  values = [i[2] for i in keyvalpairs]
  matches = maximum(values) .== values
  return keyvalpairs[matches][1]
end

function furthestfromroot(tree::Phylogeny)
  distances = distance(tree)
  return maxindict(distances, x -> maximum(x) .== x)
end

function furthestleaf(tree::Phylogeny, node::PhyNode)
  distances = {i => distance(tree, node, i) for i in terminaldescendents(root(tree))}
  return maxindict(distances)
end

function findmidpoint(tree::Phylogeny)
  furthestfromroot, ffrdist = furthestfromroot(tree)
  furthestfromleaf, ffldist = furthestleaf(tree, furthestfromroot)
  outgroup = furthestfromroot
  middistance = ffldist / 2.0
  cdist = 0.0
  current = furthestfromroot
  while true
    cdist += branchlength(current)
    if cdist > middistance
      break
    else
      current = parent(current)
    end
  end
  return current
end

function root!(tree::Phylogeny, newbl::Float64 = -1.0)
  midpoint = findmidpoint(tree)
  root!(tree, midpoint, newbl)
end

function root!(tree::Phylogeny, outgroup::Vector{PhyNode}, newbl::Float64 = -1.0)
  o = mrca(outgroup)
  root!(tree, o, newbl)
end

function root!(tree::Phylogeny, outgroup::PhyNode, newbl::Float64 = -1.0)
  # Check for errors and edge cases first as much as possible.
  # 1 - The tree is not rerootable.
  if !isrerootable(tree)
    error("Phylogeny is not rerootable!")
  end
  # 2 - The specified outgroup is already the root.
  if isroot(outgroup)
    error("New root is already the root!")
  end
  # 3 - Check the new branch length for the outgroup is between 0.0 and the old previous branchlength.
  previousbranchlength = branchlength(outgroup)
  @assert 0.0 <= newbl <= previousbranchlength
  # 4 - Check that the proposed outgroup is indeed part of the tree.
  if !isintree(tree, outgroup)
    error("The specified outgroup is not part of the phylogeny.")
  end

  #  the path from the outgroup to the root, excluding the root.
  outgrouppath = collect(Tip2Root(outgroup))[2:end - 1]

  # Edge case, the outgroup to be the new root is terminal or the new branch length is not nothing,
  # we need a new root with a branch to the outgroup.
  if isleaf(outgroup) || newbl != 0.0
    newroot = PhyNode("NewRoot", branchlength(root(tree)))
    pruneregraft!(outgroup, newroot, newbl)
    if length(outgrouppath) == 0
      # There aren't any nodes between the outgroup and origional group to rearrange.
      newparent = newroot
    else
      parent = splice!(outgrouppath, 1)
      previousbranchlength, parent.branchlength = parent.branchlength, previousbranchlength - branchlength(outgroup)
      pruneregraft!(parent, newroot)
      newparent = parent
    end
  else
    # Use the provided outgroup as a a trifurcating root if the node is not a leaf / newbl is 0.0.
    newroot = newparent = outgroup
    branchlength!(newroot, branchlength(root(tree)))
  end

  # Now we trace the outgroup lineage back, reattaching the subclades under the new root!
  for parent in outgrouppath
    #prune!(newparent)
    previousbranchlength, parent.branchlength = parent.branchlength, previousbranchlength
    pruneregraft!(parent, newparent)
    newparent = parent
  end

  # Now we have two s of connected PhyNodes. One begins the with the new root and contains the
  # nodes rearranged as per the backtracking process along outgrouppath. The other is the nodes still connected to the old root.
  # This needs to be resolved.

  # If the old root only has one child, it was bifurcating, and if so, must be removed and the branch lengths resolved,
  # appropriately.
  if countchildren(tree.root) == 1
    ingroup = children(root(tree))[1]
    branchlength!(ingroup, branchlength(ingroup) + previousbranchlength)
    pruneregraft!(ingroup, newparent)
  else
    # If the root has more than one child, then it needs to be kept as an internal node.
    branchlength!(tree.root, previousbranchlength)
    graft!(newparent, tree.root)
  end

  # TODO / FUTURE IMPROVEMENT - COPYING OF OLD ROOT ATTRIBUTES OR DATA TO NEW ROOT.

  tree.root = newroot
  tree.rooted = true
end



# This is probably unnessecery given root puts the rooted flag to true.
# perhaps and unroot! method is more appropriate.
function unroot!(x::Phylogeny)
  x.rooted = false
end

function rerootable!(x::Phylogeny, rerootable::Bool)
  x.rerootable = rerootable
end

function terminals(x::Phylogeny)
  return terminaldescendents(x.root)
end


#=
index is used to  a node by name. For a large tree, repeatedly calling this may not be performance optimal.
To address this, I provide a method to create a dictionary based index for accessing nodes without search. This is the
generateIndex method.
I'm uncertain whether it is better to  index with a singe search of all the nodes - searchAll, or to do many
individual search()-es.
=#

function Base.getindex(tree::Phylogeny, names::String...)
  return searchall(DepthFirst(tree), x -> in(name(x), names))
end

function generateindex(tree::Phylogeny)
  output = Dict{String, PhyNode}()
  for i = BreadthFirst(tree)
    if haskey(output, name(i))
      error("You are trying to build an index dict of a tree with clades of the same name.")
    end
    output[name(i)] = i
  end
  return output
end

function pathbetween(tree::Phylogeny, n1::PhyNode, n2::PhyNode)
  if !isintree(tree, n1) || !isintree(tree, n2)
    error("One of the nodes is not present in the tree.")
  end
  p1::Vector{PhyNode} = collect(Tip2Root(n1))
  p2::Vector{PhyNode} = collect(Tip2Root(n2))
  inter::Vector{PhyNode} = intersect(p1, p2)
  filter!((x) -> !in(x, inter), p1)
  filter!((x) -> !in(x, inter), p2)
  return [p1, inter[1], reverse(p2)]
end

# Get the distances between nodes in a given phylogenetic tree.
# In distance calculations if a branchlength is unknown then the value is taken as the machine epsilon.

function distanceof(x::PhyNode)
  bl = branchlength(x)
  return bl == -1.0 ? eps() : bl
end

function distance(tree::Phylogeny, n1::PhyNode, n2::PhyNode)
  p = pathbetween(tree, n1, n2) # Not nessecery to check n1 and n2 is in tree as pathbetween, on which this function depends, does the check.
  return length(p) == 1 ? 0.0 : sum(distanceof, p)
end

function depth(tree::Phylogeny, n1::PhyNode, n2::PhyNode)
  p = pathbetween(tree, n1, n2)
  return length(p) == 1 ? 0 : length(p) - 1
end

function distance(tree::Phylogeny)
  distances = Dict()
  function updatedistances(node, currentdist)
    distances[node] = currentdist
    for child in children(node)
      newdist = currentdist + distanceof(child)
      updatedistances(child, newdist)
    end
  end
  updatedistances(root(tree), distanceof(root(tree)))
  return distances
end

function depth(tree::Phylogeny)
  depths = Dict()
  function updatedepths(node, currentdepth)
    depths[node] = currentdepth
    for child in children(node)
      updatedepths(child, currentdepth + 1)
    end
  end
  updatedepths(root(tree), 0)
  return depths
end
