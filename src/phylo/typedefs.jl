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
  extensions::Array{PhyExtension, 1}
  children::Array{PhyNode, 1}
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

function getname(x::PhyNode)
  return x.name
end

function getbranchlength(x::PhyNode)
  return x.branchlength
end

function isleaf(x::PhyNode)
  return !isroot(x) && !isnode(x) ? true : false
end

function haschildren(x::PhyNode)
  return length(x.children) > 0 ? true : false
end

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
function parentisself(x::PhyNode)
  return x.parent == x ? true : false
end

function hasparent(x::PhyNode)
  return !parentisself(x) ? true : false
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
  return parentisself(x) && haschildren(x) ? true : false
end

function isnode(x::PhyNode)
  return hasparent(x) && haschildren(x) ? true : false
end

function ispreterminal(x::PhyNode)
  return all([isleaf(i) for i in x.children])
end

# A node returning true for isPreTerminal, would also return true for this function.
function issemipreterminal(x::PhyNode)
  return any([isleaf(i) for i in x.children])
end

function getdescendents(x::PhyNode)
  return collect(DepthFirst(x))
end

function getterminaldescendents(x::PhyNode)
  return searchall(DepthFirst(x), isleaf)
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
  x.root = y
end

function setrooted!(x::Phylogeny, rooted::Bool)
  x.rooted = rooted
end

function setrerootable!(x::Phylogeny, rerootable::Bool)
  x.rerootable = rerootable
end

abstract PhylogenyIterator

immutable DepthFirst <: PhylogenyIterator
    start::PhyNode
end

function DepthFirst(x::Phylogeny)
  DepthFirst(x.root)
end

immutable BreadthFirst <: PhylogenyIterator
    start::PhyNode
end

function BreadthFirst(x::Phylogeny)
  DepthFirst(x.root)
end

immutable Tip2Root <: PhylogenyIterator
    start::PhyNode
end

function Base.start(x::DepthFirst)
  state = Stack(PhyNode)
  push!(state, x.start)
  return state
end

function Base.start(x::BreadthFirst)
  state = Queue(PhyNode)
  enqueue!(state, x.start)
  return state
end

function Base.start(x::Tip2Root)
  return (x.start, false)
end

function Base.next(x::DepthFirst, state::Stack{Deque{PhyNode}})
  current::PhyNode = pop!(state)
  for i in current.children
    push!(state, i)
  end
  return current, state
end

function Base.next(x::BreadthFirst, state::Queue{Deque{PhyNode}})
  current::PhyNode = dequeue!(state)
  for i in current.children
    enqueue!(state, i)
  end
  return current, state
end

function Base.next(x::Tip2Root, state::(PhyNode,Bool))
  return state[1], (state[1].parent, isroot(state[1]))
end

function Base.done(x::DepthFirst, state::Stack{Deque{PhyNode}})
  return length(state) == 0 ? true : false
end

function Base.done(x::BreadthFirst, state::Queue{Deque{PhyNode}})
  return length(state) == 0 ? true : false
end

function Base.done(x::Tip2Root, state::(PhyNode,Bool))
  return state[2] 
end

function search(it::PhylogenyIterator, condition::Function)
  for i = it
    if condition(i)
      return i
    end
  end
end

function searchall(it::PhylogenyIterator, condition::Function)
  matches::Array{PhyNode, 1} = PhyNode[]
  for i = it
    if condition(i)
      push!(matches, i)
    end
  end
  return matches
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





