import Base.delete!, Base.isequal, Base.getindex

@doc meta("""
PhyExtension allows defining arbitrary metadata to annotate nodes.

This allows the PhyNode type to support any phylogenetic tree format that includes annotations (e.g. PhyloXML, NeXML), and allows programmatic extension of nodes with annotations.
""", section = "PhyExtension") ->
type PhyExtension{T}
  value::T
end

@doc meta("""
PhyNode represents a node in a phylogenetic tree.

A node can have:

- `name`
- `branchlength`
- one or more `extensions`
- a reference to its `parent` PhyNode
- reference to one or more `children`

""", section = "PhyNode") ->
type PhyNode
  name::String
  branchlength::Float64
  confidence::Float64
  extensions::Vector{PhyExtension}
  children::Vector{PhyNode}
  parent::PhyNode
end

@doc meta("""
Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional when creating PhyNodes:

```julia
one = PhyNode()
two = PhyNode(name = "two",
              branchlength = 1.0,
              parent = one)
```

""",
  section = "PhyNode",
  parameters = Dict(
    (:name,
     "The name of the node (optional). Defaults to an empty string, indicating the node has no name."),
    (:branchlength,
     "The branch length of the node from its parent (optional). Defaults to `-1.0`, indicating an unknown branch length."),
    (:ext,
     "An array of zero or more PhyExtensions (optional). Defaults to an empty array, i.e. `[]`, indicating there are no extensions."),
    (:parent,
     "The parent node (optional). Defaults to a self-reference, indicating the node has no parent.")),
  returns = (PhyNode)
) ->
function PhyNode(name::String = "", branchlength::Float64 = -1.0, confidence::Float64 = -1.0, ext::Vector{PhyExtension} = PhyExtension[], children::Vector{PhyNode} = PhyNode[], parent = nothing)
    x = new()
    name!(x, name)
    branchlength!(x, branchlength)
    confidence!(x, confidence)
    x.extensions = ext
    if parent != nothing
      graft!(parent, x)
    else
      x.parent = x
    end
    x.children = PhyNode[]
    for child in children
      graft!(x, child)
    end
    return x
end


@doc """
Test whether the branchlength in the node is known (i.e. is not -1.0).
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns =>(Bool)
} ->
function blisknown(x::PhyNode)
  return !x.branchlength == -1.0
end

@doc """
Test whether the confidence in the node is known (i.e. is not -1.0).
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns =>(Bool)
} ->
function confisknown(x::PhyNode)
  return !x.confidence == -1.0
end

@doc """
Get the confidence of the node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to return the confidence of.")},
  :returns =>(Float64)
} ->
function confidence(x::PhyNode)
  return x.confidence
end

@doc """
Set the confidence of the node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to set the confidence of."), (:conf, "The value of the confidence to be set.")},
  :returns =>(Float64)
} ->
function confidence!(x::PhyNode, conf::Float64)
  x.confidence = conf
end

@doc """
Set the confidence of the node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to set the confidence of."), (:conf, "The value of the confidence to be set.")},
  :returns =>(Float64)
} ->
function confidence!(x::PhyNode, conf::Nothing)
  x.confidence = -1.0
end

@doc """
Test whether a node is empty.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isempty(x::PhyNode)
  return x.name == "" && x.branchlength == -1.0 && !hasextensions(x) && !haschildren(x) && parentisself(x)
end

@doc """
Get the name of a PhyNode.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get the name of.")},
  :returns => (Bool)
} ->
function getname(x::PhyNode)
  return x.name
end

@doc """
Get the branch length of a PhyNode.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get the branch length of.")},
  :returns => (Float64)
} ->
function getbranchlength(x::PhyNode)
  return x.branchlength
end

@doc """
Test whether a node is a leaf.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isleaf(x::PhyNode)
  return hasparent(x) && !haschildren(x)
end

@doc """
Test whether a node has children.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function haschildren(x::PhyNode)
  return length(x.children) > 0
end

@doc """
Test whether a node is the parent of another specific node.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The potential parent PhyNode to test."),
    (:child, "The potential child PhyNode to test.")
  },
  :returns => (Bool)
} ->
function haschild(parent::PhyNode, child::PhyNode)
  return in(child, parent.children)
end

@doc """
Test whether a node has extensions.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function hasextensions(x::PhyNode)
  return length(x.extensions) > 0
end

@doc """
Test whether a node is its own parent. See PhyNode().
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function parentisself(x::PhyNode)
  return x.parent === x
end

@doc """
Test whether a node has a parent.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function hasparent(x::PhyNode)
  return !parentisself(x)
end


@doc """
Get the children of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get children for.")},
  :returns => (Vector{PhyNode})
} ->
function getchildren(x::PhyNode)
  return x.children
end

@doc """
Get the siblings of a node. Included in output is the input node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get siblings for.")},
  :returns => (Vector{PhyNode})
} ->
function getsiblings(x::PhyNode)
  if hasparent(x)
    return children(x.parent)
  end
end

@doc """
Get the parent of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get the parent of.")},
  :returns => (PhyNode)
} ->
function getparent(x::PhyNode)
  if parentisself(x)
    println("Node does not have a parent. It is self referential.")
  end
  return x.parent
end

@doc """
Test whether a node is the root node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isroot(x::PhyNode)
  return parentisself(x) && haschildren(x)
end

@doc """
Test whether a node is unlinked, i.e. has no children and no parent.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isunlinked(x::PhyNode)
  return parentisself(x) && !haschildren(x)
end

@doc """
Test whether a node is linked, i.e. has one or more children and/or a parent.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function islinked(x::PhyNode)
  return hasparent(x) || haschildren(x)
end

@doc """
Test whether a node is internal, i.e. has a parent and one or more children.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isinternal(x::PhyNode)
  return hasparent(x) && haschildren(x)
end

@doc """
Test whether a node is preterminal i.e. It's children are all leaves.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function ispreterminal(x::PhyNode)
  if isleaf(x)
    return false
  end
  return all([isleaf(i) for i in x.children])
end

@doc """
Test whether a node is semi-preterminal i.e. Some of it's children are leaves, but not all are.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function issemipreterminal(x::PhyNode)
  areleaves = [isleaf(i) for i in x.children]
  return any(areleaves) && !all(areleaves)
end

@doc """
Count the number of children of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to count the children of.")},
  :returns => (Int)
} ->
function countchildren(x::PhyNode)
  return length(x.children)
end

@doc """
Get the descendents of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get descendents of.")},
  :returns => (Vector{PhyNode})
} ->
function getdescendents(x::PhyNode)
  return collect(PhyNode, DepthFirst(x))
end

@doc """
Get the terminal descendents of a node. i.e. Nodes that are leaves, which have the input node as an ancestor.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get ther terminal descendents of.")},
  :returns => (Bool)
} ->
function getterminaldescendents(x::PhyNode)
  return searchall(DepthFirst(x), isleaf)
end


@doc """
Test whether a node is ancesteral to one or more other nodes.
""" {
  :section => "PhyNode",
  :parameters => {
    (:posanc, "The PhyNode to test."),
    (:nodes, "An array of `PhyNode`s that the test node must be ancestral to.")
  },
  :returns => (Bool)
} ->
function isancestral(posanc::PhyNode, nodes::Vector{PhyNode})
  desc = descendents(posanc)
  return all([in(node, desc) for node in nodes])
end


@doc """
Get the most recent common ancestor of an array of nodes.
""" {
  :section => "PhyNode",
  :parameters => {
    (:nodes, "An array of `PhyNode`s to find the most common ancestor of.")
  },
  :returns => (PhyNode)
} ->
function getmrca(nodes::Vector{PhyNode})
  paths = [collect(Tip2Root(i)) for i in nodes]
  convergence = intersect(paths...)
  return convergence[1]
end

@doc """
Set the name of a PhyNode.
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode to set the name of."),
    (:name, "The name to give the PhyNode.")
  },
  :returns => (Bool)
} ->
function setname!(x::PhyNode, name::String)
  x.name = name
end

@doc """
Set the branch length of a PhyNode.
**This method modifies the PhyNode.**
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode to set the branchlength of."),
    (:bl, "The branch length to give the PhyNode.")
  },
  :returns => (Float64)
} ->
function setbranchlength!(x::PhyNode, bl::Float64)
  x.branchlength = bl
end

function branchlength!(x::PhyNode, bl::Nothing)
  x.branchlength = -1.0
end

@doc """
Remove the parent of a node (thus setting the parent property to be self-referential).
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode to remove the parent of."),
  },
  :returns => (PhyNode)
} ->
function removeparent_unsafe!(x::PhyNode)
  parent_unsafe!(x, x)
end

@doc """
Set the parent of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to set as parent."),
    (:child, "The PhyNode to set the parent of.")
  },
  :returns => (PhyNode)
} ->
function parent_unsafe!(parent::PhyNode, child::PhyNode)
  child.parent = parent
end


@doc """
Set the children of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add a child to."),
    (:child, "The PhyNode to add as a child.")
  },
  :returns => (PhyNode)
} ->
function addchild_unsafe!(parent::PhyNode, child::PhyNode)
  if haschild(parent, child)
    error("The child node is already a child of the parent.")
  end
  push!(parent.children, child)
end


function removechild_unsafe!(parent::PhyNode, child::PhyNode)
  filter!(x -> !(x === child), parent.children)
end

@doc """
Graft a node onto another node, create a parent-child relationship between them.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add a child to."),
    (:child, "The PhyNode to add as a child.")
  }
} ->
function graft!(parent::PhyNode, child::PhyNode)
  if hasparent(child)
    error("This node is already attached to a parent.")
  end
  parent_unsafe!(parent, child)
  addchild_unsafe!(parent, child)
end

@doc """
Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add a child to."),
    (:child, "The PhyNode to add as a child."),
    (:branchlength, "The branch length between parent and child.")
  }
} ->
function graft!(parent::PhyNode, child::PhyNode, branchlength::Float64)
    graft!(parent, child)
    branchlength!(child, branchlength)
end

@doc """
Graft one or more nodes onto another node, create a parent-child relationship between each of the grafted nodes and the node they are grafted onto.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add a child to."),
    (:children, "The array of PhyNodes to add as a child.")
  }
} ->
function graft!(parent::PhyNode, children::Vector{PhyNode})
  for i in children
    graft!(parent, i)
  end
end

@doc """
Destroy the relationship between a PhyNode `x` and its parent, returning the PhyNode.

This method cleanly removes the PhyNode `x` from its parent's `children` array, and removes the `parent` reference from the PhyNode `x`. All other fields of the `child` are left intact.
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode prune from its parent.")
  }
} ->
function prune!(x::PhyNode)
  if hasparent(x)
    removechild_unsafe!(x.parent, x)
    removeparent_unsafe!(x)
    return x
  else
    error("Can't prune from this node, it is either a single node without parents or children, or is a root of a tree / subtree.")
  end
end

@doc """
Prune a PhyNode from its parent and graft it to another parent.
""" {
  :section => "PhyNode",
  :parameters => {
    (:prune, "The PhyNode to remove from its parent."),
    (:graftto, "The PhyNode to become the new parent of `prune`.")
  }
} ->
function pruneregraft!(prune::PhyNode, graftto::PhyNode)
  x = prune!(prune)
  graft!(graftto, x)
end

@doc """
Prune a PhyNode from its parent and graft it to another parent, setting the branch length.
""" {
  :section => "PhyNode",
  :parameters => {
    (:prune, "The PhyNode to remove from its parent."),
    (:graftto, "The PhyNode to become the new parent of `prune`."),
    (:branchlength, "The branch length.")
  }
} ->
function pruneregraft!(prune::PhyNode, graftto::PhyNode, branchlength::Float64)
  x = prune!(prune)
  graft!(graftto, x, branchlength)
end

@doc """
Delete a node, destroying the relationships between it and its parent, and it and its children. The children of the node become the children of the node's  former parent.
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode to delete."),
  },
  :returns => (Bool)
} ->
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

@doc """
Test whether two PhyNodes are equal. Specifically, test whether all three of `branchlength`, `name` and `extensions` are equal.
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The left PhyNode to compare."),
    (:x, "The right PhyNode to compare.")
  },
  :returns => (Bool)
} ->
function isequal(x::PhyNode, y::PhyNode)
  bl = x.branchlength == y.branchlength
  n = x.name == y.name
  exts = x.extensions == y.extensions
  return all([bl, n, exts])
end

@doc """
Find the distance of a node from its parent. This is different from branch length, because it handles the situation where branch length is unknown. It is only used when the distances between nodes are calculated.

The method is necessary because unknown branch lengths are represented as -1.0.
If all branch lengths are unknown, the tree is a cladogram, and it is still useful to be able to compare relative distances. If individual branch lengths are unknown, they should not affect the calculation of path distances. To satisfy both of these cases, we use machine epsilon as the minimal distance.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search in."),
    (:n1, "The first node."),
    (:n2, "The second node.")
  },
  :returns => (Int)
} ->
function distanceof(x::PhyNode)
  bl = branchlength(x)
  return bl == -1.0 ? eps() : bl
end
