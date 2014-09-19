import Base.delete!, Base.isequal, Base.getindex

@doc """
PhyExtension allows defining arbitrary metadata to annotate nodes.

This allows the PhyNode type to support any phylogenetic tree format that includes annotations (e.g. PhyloXML, NeXML), and allows programmatic extension of nodes with annotations.
""" {
 :section => "PhyExtension"
} ->
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

""" {
 :section => "PhyNode"
} ->
type PhyNode
  name::String
  branchlength::Float64
  confidence::Float64
  extensions::Vector{PhyExtension}
  children::Vector{PhyNode}
  parent::PhyNode

  PhyNode(name = "", branchlength = -1.0, confidence = -1.0, children = PhyNode[], extensions = PhyExtension[]) = (x = new(name, branchlength, confidence, extensions, children); x.parent = x)
end

# Node constructor.
function PhyNode(parent::PhyNode, name = "", branchlength = -1.0, confidence = -1.0, children = PhyNode[], extensions = PhyExtension[])
  x = PhyNode(name, branchlength, children, extensions)
  graft!(parent, x)
  return x
end

### Node Manipulation / methods on the PhyNode type...

function blisknown(x::PhyNode)
  return !x.branchlength == -1.0
end

function confisknown(x::PhyNode)
  return !x.confidence == -1.0
end

function confidence(x::PhyNode)
  return x.confidence
end

function confidence!(x::PhyNode, conf::Float64)
  x.confidence = conf
end

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
  :returns => (Bool)
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

# Refer to the note on self referential nodes. If a node is self referential in the parent field, a warning will be printed to screen.
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

# Should x.Children that is returned be a copy? x.Children is an array of
# refs to the child nodes, so x.Children is mutable.

@doc """
Get the children of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get children for.")},
  :returns => (Array{PhyNode})
} ->
function getchildren(x::PhyNode)
  return x.children
end

@doc """
Get the siblings of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get siblings for.")},
  :returns => (Array{PhyNode})
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
Test whether a node is a node, i.e. has a parent and one or more children.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to test.")},
  :returns => (Bool)
} ->
function isnode(x::PhyNode)
  return hasparent(x) && haschildren(x)
end

@doc """
Test whether a node has is preterminal.
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
Count the number of children of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to count the children of.")},
  :returns => (Int)
} ->
function countchildren(x::PhyNode)
  return length(x.children)
end


# A node returning true for isPreTerminal, would also return true for this function.
@doc """
Test whether a node is semi-preterminal.
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
Get the descendents of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get descendents of.")},
  :returns => (Array{PhyNode})
} ->
function getdescendents(x::PhyNode)
  return collect(PhyNode, DepthFirst(x))
end

@doc """
Get the terminal descendents of a node.
""" {
  :section => "PhyNode",
  :parameters => {(:x, "The PhyNode to get ther terminal descendents of.")},
  :returns => (Bool)
} ->
function getterminaldescendents(x::PhyNode)
  return searchall(DepthFirst(x), isleaf)
end


# Test that the posanc node is ancestral to the given nodes.
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
function isancestral(posanc::PhyNode, nodes::Array{PhyNode})
  return all([in(node, descendents(posanc)) for node in nodes])
end


# I'm not sure this is the best way to the MRCA of a  of nodes, but I think it's valid: As you climb a tree from any specified tip to the root.
# if you keep checking the terminal descendents as you climb - the first node you hit that has all specified nodes as terminal descendents is
# the MRCA. I found it dificult to choose the best way as if you want the mrca of 2 fairly related nodes, you'll  the answer sooner searching from tips 2 root,
# however this would take longer.

@doc """
Get the most recent common ancestor of an array of nodes.
""" {
  :section => "PhyNode",
  :parameters => {
    (:nodes, "An array of `PhyNode`s to find the most common ancestor of.")
  },
  :returns => (Bool)
} ->
function getmrca(nodes::Vector{PhyNode})
  paths = [collect(Tip2Root(i)) for i in nodes]
  convergence = intersect(paths...)
  return convergence[1]
end


## Setting information on a node...
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
  :returns => (Bool)
} ->
function setbranchlength!(x::PhyNode, bl::Float64)
  x.branchlength = bl
end

function branchlength!(x::PhyNode, bl::Nothing)
  x.branchlength = -1.0
end


# Following unsafe functions maniplulate the ting and manipulation of parental and child links.
# They should not be used unless absolutely nessecery - the prune and graft methods ensure the
# bidirectional links between PhyNodes are built and broken cleanly.

# Removing a parent makes a node self referential in the Parent field like a root node.
# Avoids possible pesky #undef fields.
@doc """
Remove the parent of a node (thus setting the parent property to be self-referential).
""" {
  :section => "PhyNode",
  :parameters => {
    (:x, "The PhyNode to remove the parent of."),
  },
  :returns => (Bool)
} ->
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


@doc """
Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add a child to."),
    (:child, "The PhyNode to add as a child."),
    (:branchlength, "The branch length between parent and child.")
  },
  :returns => (Bool)
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
  },
  :returns => (Bool)
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
  },
  :returns => (Bool)
} ->
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
Phylogeny represents a phylogenetic tree.

A tree can have:

- `name`
- `root`
- `rooted`
- `rerootable`

""" {
  :section => "Phylogeny"
} ->
type Phylogeny
  name::String
  root::PhyNode
  rooted::Bool
  rerootable::Bool

  Phylogeny() = new("", PhyNode(), false, true)
end

# Phylogeny constructors...
@doc """
Create a Phylogeny with a name, root node, and set whether it is rooted and whether it is re-rootable.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:name, "The name of the tree."),
    (:root, "The root node."),
    (:rooted, "Whether the tree is rooted."),
    (:rerootable, "Whether the tree is re-rootable.")
  },
  :returns => (Phylogeny)
} ->
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

@doc """
Test whether a phylogeny is empty.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to test.")
  },
  :returns => (Bool)
} ->
function isempty(x::Phylogeny)
  return isempty(x.root)
end

@doc """
Set the name of a Phylogeny
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to set the name of."),
    (:name, "The name to set.")
  }
} ->
function setname!(x::Phylogeny, name::String)
  x.name = name
end

@doc """
Test whether a Phylogeny is rooted.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to test."),
  },
  :returns => (Bool)
} ->
function isrooted(x::Phylogeny)
  return x.rooted
end

@doc """
Test whether a Phylogeny is re-rootable.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to test."),
  },
  :returns => (Bool)
} ->
function isrerootable(x::Phylogeny)
  return x.rerootable
end

@doc """
Get the root node of a Phylogeny.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to get the root of."),
  },
  :returns => (PhyNode)
} ->
function getroot(x::Phylogeny)
  return x.root
end

@doc """
Test whether a given node is in a given tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to check."),
    (:clade, "The PhyNode to check.")
  },
  :returns => (Bool)
} ->
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

@doc """
Root a tree using a given array of nodes as the outgroup, and optionally setting the branch length.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to root."),
    (:outgroup, "An array of PhyNodes to use as outgroup."),
    (:newbl, "The new branch length (optional).")
  }
} ->
function root!(tree::Phylogeny, outgroup::Vector{PhyNode}, newbl::Float64 = 0.0)
  o = getmrca(outgroup)
  root!(tree, o, newbl)
end

@doc """
Root a tree using a given node as the outgroup, and optionally setting the branch length,
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to root."),
    (:outgroup, "A PhyNode to use as outgroup."),
    (:newbl, "The new branch length (optional).")
  }
} ->
function root!(tree::Phylogeny, outgroup::PhyNode, newbl::Float64 = 0.0)
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
@doc """
Unroot a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny to unroot.")
  }
} ->
function unroot!(x::Phylogeny)
  x.rooted = false
end

@doc """
Set whether a tree is re-rootable.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny."),
    (:rerootable, "Whether the Phylogeny is re-rootable.")
  },
  :returns => (Bool)
} ->
function setrerootable!(x::Phylogeny, rerootable::Bool)
  x.rerootable = rerootable
end

@doc """
Get the terminal nodes of a phylogeny.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:x, "The Phylogeny.")
  },
  :returns => (Array)
} ->
function getterminals(x::Phylogeny)
  return getterminaldescendents(x.root)
end


#=
Index is used to a node by name. For a large tree, repeatedly calling this may not be performance optimal.
To address this, I provide a method to create a dictionary based index for accessing nodes without search. This is the
generateIndex method.

I'm uncertain whether it is better to get index with a single search of all the nodes - searchAll, or to do many
individual search()-es.
=#
@doc """
Get one or more nodes by name.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search."),
    (:names, "The names of the nodes to get.")
  },
  :returns => (Bool)
} ->
function getindex(tree::Phylogeny, names::String...)
  return searchall(DepthFirst(tree), x -> in(getname(x), names))
end

@doc """
Generate an index mapping names to nodes
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to index."),
  },
  :returns => (Dict{String, PhyNode})
} ->
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

@doc """
Find the shortest path between two nodes in a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search in ."),
    (:n1, "The first node."),
    (:n2, "The second node.")
  },
  :returns => (Array)
} ->
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


@doc """
Find the distance between two nodes in a tree.

If the tree is a phylogeny, the distance is the sum of the branch-lengths along the shortest path.

If the tree is a cladogram, the distance is the number of edges in the shortest path.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search in."),
    (:n1, "The first node."),
    (:n2, "The second node.")
  },
  :returns => (Int)
} ->
function distance(tree::Phylogeny, n1::PhyNode, n2::PhyNode)
  p = pathbetween(tree, n1, n2) # Not nessecery to check n1 and n2 is in tree as pathbetween, on which this function depends, does the check.
  return length(p) == 1 ? 0.0 : sum(distanceof, p)
end

@doc """
Find the distance between a node and the root of a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search in."),
    (:n1, "The node.")
  },
  :returns => (Int)
} ->
function distance(tree::Phylogeny, n1::PhyNode)
  p = Tip2Root(n1)
  return sum(getbranchlength, p)
end

@doc """
Find the distance of each node from the root. If `unitbl` is `true`, the distance will be the number of edges between the root and the node.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to measure."),
    (:unitbl, "Whether all branch lengths should be counted as 1.")
  },
  :returns => (Bool)
} ->
function distance(tree::Phylogeny, unitbl::Bool = false)
  if unitbl
    depthof = x -> 1
  else
    depthof = x -> getbranchlength(x)
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
