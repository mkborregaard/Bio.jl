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
  Name::String
  BranchLength::Float64
  Extensions::Array{PhyExtension, 1}
  Children::Array{PhyNode, 1}
  Parent::PhyNode
  PhyNode() = (x = new("", 0.0, PhyNode[], PhyNode[]); x.Parent = x)
end

#=
A note about the default no-argument constructor. You'll notice it incompletely initializes the instance of PhyNode,
before filling in the Parent field with a reference to itself. This means the node has no parent and so could be a root,
it could also just be a node that has been created, perhaps in a function, but will be added to another set of nodes subsequently
in order to build up a tree. Alternatively the user could have just popped it off the tree. I figured a self referential
node would be the best way to do this rather than have #undef values lurking. It also allows removal of a parent from a node for something like
say the cutting / pruning of a subtree.
 =#


# Node constructors.
function PhyNode(label::String, branchlength::Float64, ext::Array{PhyExtension, 1}, parent::PhyNode)
  x = PhyNode()
  setName!(x, label)
  setBranchLength!(x, branchlength)
  x.Extensions = ext
  setParent!(x, parent)
  return x
end

function PhyNode(parent::PhyNode)
  x = PhyNode()
  setParent!(x, parent)
  return x
end

function PhyNode(branchlength::Float64, parent::PhyNode)
  x = PhyNode()
  setBranchLength!(x, branchlength)
  setParent!(x, parent)
  return x
end

function PhyNode(label::String)
  x = PhyNode()
  setName!(x, label)
  return x
end


### Node Manipulation / methods on the PhyNode type...

## Getting information from a node...

function getName(x::PhyNode)
  return x.Name
end

function getBranchLength(x::PhyNode)
  return x.BranchLength
end

function isLeaf(x::PhyNode)
  return !isRoot(x) && !isNode(x) ? true : false
end

function hasChildren(x::PhyNode)
  return length(x.Children) > 0 ? true : false
end

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
function parentIsSelf(x::PhyNode)
  return x.Parent == x ? true : false
end

function hasParent(x::PhyNode)
  return !parentIsSelf(x) ? true : false
end

# Should x.Children that is returned be a copy? x.Children is an array of
# refs to the child nodes, so x.Children is mutable.
function getChildren(x::PhyNode)
  return x.Children
end

function getSiblings(x::PhyNode)
  if hasParent(x)
    return getChildren(x.Parent)
  end
end

function getParent(x::PhyNode)
  if parentIsSelf(x)
    println("Node does not have a parent. It is self referential.")
  end
  return x.Parent
end

function isRoot(x::PhyNode)
  return parentIsSelf(x) && hasChildren(x) ? true : false
end

function isNode(x::PhyNode)
  return hasParent(x) && hasChildren(x) ? true : false
end


## Setting information on a node...
 
function setName!(x::PhyNode, name::String)
  x.Name = name
end

function setBranchLength!(x::PhyNode, bl::Float64)
  x.BranchLength = bl
end

# Removing a parent makes a node self referential in the Parent field like a root node.
# Avoids possible pesky #undef fields.  
function removeParent!(x::PhyNode)
  setParent!(x, x)
end

function setParent!(child::PhyNode, parent::PhyNode)
  child.Parent = parent
end

function addChild!(parent::PhyNode, child::PhyNode)
  push!(parent.Children, child)
end

function removeChild!(parent::PhyNode, child::PhyNode)
  filter!(x -> !(x == child), parent.Children)
end

function graft!(parent::PhyNode, child::PhyNode)
  # When grafting a subtree to another tree, or node to a node. You make sure that if it already has a parent.
  # Its reference is removed from the parents Children field.
  if hasParent(child)
    removeChild!(child.Parent, child)
  end
  setParent!(child, parent)
  addChild!(parent, child)
end

function graft!(parent::PhyNode, child::PhyNode, branchlength::Float64)
    graft!(parent, child)
    setBranchLength!(child, branchlength)
end

function prune!(x::PhyNode)
  if hasParent(x)
    # You must make sure the parent of this node from which you are pruning, does not contain a reference to it.
    removeChild!(x.Parent, x)
    removeParent!(x)
    return x
  else
    error("Can't prune from this node, it is either a single node without parents or children, or is a root of a tree / subtree.")
  end
end

# Tree type.
type Phylogeny
  Name::String
  Root::PhyNode
  Rooted::Bool
  Rerootable::Bool

  Phylogeny() = new("", PhyNode(), false, true)
end

# Phylogeny constructors...
function Phylogeny(name::String, root::PhyNode, rooted::Bool, rerootable::Bool)
  x = Phylogeny()
  setName!(x, name)
  setRoot!(x, root)
  setRooted!(x, rooted)
  setRerootable!(x, rerootable)
  return x
end

function setName!(x::Phylogeny, name::String)
  x.Name = name
end

function isRooted(x::Phylogeny)
  return x.Rooted
end

function isRerootable(x::Phylogeny)
  return x.Rerootable
end

function setRoot!(x::Phylogeny, y::PhyNode)
  x.Root = y
end

function setRooted!(x::Phylogeny, rooted::Bool)
  x.Rooted = rooted
end

function setRerootable!(x::Phylogeny, rerootable::Bool)
  x.Rerootable = rerootable
end




function search(traverser::TreeTraverser, condition::Function)
  while true
    println("Looking at node $(getName(getCurrent(traverser)))")
    if condition(getCurrent(traverser))
      return getCurrent(traverser)
    end
    if hasReachedEnd(traverser)
      break
    end
    next!(traverser)
  end
end

function searchAll(traverser::TreeTraverser, condition::Function)
  matches::Array{PhyNode, 1} = PhyNode[]
  while true
    println("Looking at node $(getName(getCurrent(traverser)))")
    if condition(getCurrent(traverser))
      push!(matches, getCurrent(traverser))
    end
    if hasReachedEnd(traverser)
      break
    end
    next!(traverser)
  end
  return matches
end


# The traverser types help a coder with traversing a tree according to a breadth first or a depth first manner. 
# An example of their use is in the searching methods.
abstract TreeTraverser

type TraverserCore
  Start::PhyNode
  Behind::Stack
  History::Array{PhyNode, 1}
  Current::PhyNode
end

type TraverserDF <: TreeTraverser
	Ahead::Stack
	Core::TraverserCore
	function TraverserDF(tree::Phylogeny)
    x = new(Stack(PhyNode), TraverserCore(tree.Root, Stack(PhyNode), PhyNode[], tree.Root))
    for i in x.Core.Current.Children
      push!(x.Ahead, i)
    end
    return x
  end
end

type TraverserBF <: TreeTraverser
  Ahead::Queue
  Core::TraverserCore
  function TraverserBF(tree::Phylogeny)
    x = new(Queue(PhyNode), TraverserCore(tree.Root, Stack(PhyNode), PhyNode[], tree.Root))
    for i in x.Core.Current.Children
      enqueue!(x.Ahead, i)
    end
    return x
  end
end

function next!(x::TraverserDF)
  push!(x.Core.Behind, x.Core.Current)
  x.Core.Current = pop!(x.Ahead)
  for i in x.Core.Current.Children
  	push!(x.Ahead, i)
  end
end

function next!(x::TraverserBF)
  push!(x.Core.Behind, x.Core.Current)
  x.Core.Current = dequeue!(x.Ahead)
  for i in x.Core.Current.Children
    enqueue!(x.Ahead, i)
  end
end

function getCurrent(x::TreeTraverser)
  return x.Core.Current
end

function upNext(x::TreeTraverser)
  return x.Ahead
end

function getHistory(x::TreeTraverser)
  return x.Core.History
end

function hasReachedEnd(x::TreeTraverser)
  length(x.Ahead) > 0 ? false : true
end


