#=================================================================================# 
# Recurvive extendible type for representation of phylogenetic trees in in Julia. #
#=================================================================================#

# Ben J. Ward, 2014.

# Extension type - parametric
type PhyXExtension{T}
  value::T
end

# Node type.
type PhyXElement
  Label::String
  BranchLength::Float64
  Extensions::Array{PhyXExtension, 1}
  Children::Array{PhyXElement, 1}
  Parent::PhyXElement
  PhyXElement() = (x = new("", 0.0, PhyXElement[], PhyXElement[]); x.Parent = x)
end

#=
A note about the default no-argument constructor. You'll notice it incompletely initializes the instance of PhyXElement,
before filling in the Parent field with a reference to itself. This means the node has no parent and so could be a root,
it could also just be a node that has been created, perhaps in a function, but will be added to another set of nodes subsequently
in order to build up a tree. Alternatively the user could have just popped it off the tree. I figured a self referential
node would be the best way to do this rather than have #undef values lurking. It also allows removal of a parent from a node for something like
say the cutting / pruning of a subtree.
 =#


# Node constructors.
function PhyXElement(label::String, branchlength::Float64, ext::Array{PhyXExtension, 1}, parent::PhyXElement)
  x = PhyXElement()
  setLabel!(x, label)
  setBranchLength!(x, branchlength)
  x.Extensions = ext
  setParent!(x, parent)
  return x
end

function PhyXElement(parent::PhyXElement)
  x = PhyXElement()
  setParent!(x, parent)
  return x
end

function PhyXElement(branchlength::Float64, parent::PhyXElement)
  x = PhyXElement()
  setBranchLength!(x, branchlength)
  setParent!(x, parent)
  return x
end

function PhyXElement(label::String)
  x = PhyXElement()
  setLabel!(x, label)
  return x
end

# Tree type.
type PhyXTree
  Name::String
  Root::PhyXElement
  Rooted::Bool
  Rerootable::Bool
end

### Node Manipulation / methods on the PhyXElement type...

## Getting information from a node...

function getLabel(x::PhyXElement)
  return x.Label
end

function getBranchLength(x::PhyXElement)
  return x.BranchLength
end

function isLeaf(x::PhyXElement)
  return !hasChildren(x)
end

function hasChildren(x::PhyXElement)
  return length(x.Children) > 0 ? true : false
end

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
function parentIsSelf(x::PhyXElement)
  return x.Parent == x ? true : false
end

function hasParent(x::PhyXElement)
  return !parentIsSelf(x) ? true : false
end

# Should x.Children that is returned be a copy? x.Children is an array of
# refs to the child nodes, so x.Children is mutable.
function getChildren(x::PhyXElement)
  return x.Children
end

function getSiblings(x::PhyXElement)
  if hasParent(x)
    return getChildren(x.Parent)
  end
end

function getParent(x::PhyXElement)
  if parentIsSelf(x)
    println("Node does not have a parent. It is self referential.")
  end
  return x.Parent
end

function isRoot(x::PhyXElement)
  return parentIsSelf(x) && hasChildren(x) ? true : false
end

function isNode(x::PhyXElement)
  return hasParent(x) && hasChildren(x) ? true : false
end



 
















function setLabel!(x::PhyXElement, label::String)
  x.Label = label
end


## Branch length manipulation...

# Returns value of branch length of the given node. 


# Sets the value of the branch length of the given node, to the provided value.
function setBranchLength!(x::PhyXElement, bl::Float64)
  x.BranchLength = bl
end

# Find if given node is a Leaf node, or is the root node, set a node as the root.







## Functions for linking nodes and building trees.

# getParent returns a reference to the parent node of the node provided to the function.


function setParent!(x::PhyXElement, parent::PhyXElement)
  x.Parent = parent
end

# Removing a parent makes a node self referential in the Parent field like a root node.
# Avoids possible pesky #undef fields.  
function removeParent!(x::PhyXElement)
  x.Parent = x
end



function addChild!(parent::PhyXElement, child::PhyXElement)
  if !in(child, parent.Children)
    if isdefined(child, :Parent)
      filter!(x -> x == child, child.Parent.Children)
    end
    push!(parent.Children, child)
    child.Parent = parent
  else
    error("The parent Node already has Child node")
  end
end

function removeChild!(Parent::PhyXElement, Child::PhyXElement)
  filter!(x -> x == Child, Parent.Children)
end

function removeChild!(Parent::PhyXElement)
  Parent.Children = PhyXElement[]
end


function addSiblings!(x::PhyXElement, Siblings::PhyXElement...)
    for i in Siblings
      addChild!(x.Parent, i)
    end
end
