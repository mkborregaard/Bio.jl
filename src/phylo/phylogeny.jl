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
function name!(x::Phylogeny, name::String)
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
function root(x::Phylogeny)
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

@doc """
Root a tree at the midpoint between the two most distant taxa.

This method modifies the `tree` variable.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to root."),
  }
} ->
function root!(tree::Phylogeny, newbl::Float64 = -1.0)
  midpoint = findmidpoint(tree)
  root!(tree, midpoint, newbl)
end

@doc """
Find the maximum branch length in a dictionary mapping nodes to their branch lengths.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:dict, "The dictionary.")
  },
  :returns => (Int)
} ->
function maxindict(dictionary::Dict)
  keyvalpairs = collect(dictionary)
  values = [i[2] for i in keyvalpairs]
  matches = maximum(values) .== values
  return keyvalpairs[matches][1]
end

@doc """
Find the node that is furthest from the root of a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search.")
  },
  :returns => (PhyNode)
} ->
function furthestfromroot(tree::Phylogeny)
  distances = distance(tree)
  return maxindict(distances, x -> maximum(x) .== x)
end

@doc """
Find the leaf that is furthest from a given node in a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny containing the nodes."),
    (:node, "The PhyNode find the furthest node from.")
  },
  :returns => (PhyNode)
} ->
function furthestleaf(tree::Phylogeny, node::PhyNode)
  distances = {i => distance(tree, node, i) for i in terminaldescendents(root(tree))}
  return maxindict(distances)
end

@doc """
Find the midpoint of a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to find the midpoint of.")
  },
  :returns => (Bool)
} ->
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
function root!(tree::Phylogeny,
               outgroup::Vector{PhyNode},
               newbl::Float64 = -1.0)
  o = mrca(outgroup)
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
  # 3 - Check the new branch length for the outgroup
  # is between 0.0 and the old previous branchlength.
  previousbranchlength = branchlength(outgroup)
  @assert 0.0 <= newbl <= previousbranchlength
  # 4 - Check that the proposed outgroup is indeed part of the tree.
  if !isintree(tree, outgroup)
    error("The specified outgroup is not part of the phylogeny.")
  end

  #  the path from the outgroup to the root, excluding the root.
  outgrouppath = collect(Tip2Root(outgroup))[2:end - 1]

  # Edge case, the outgroup to be the new root
  # is terminal or the new branch length is not nothing,
  # we need a new root with a branch to the outgroup.
  if isleaf(outgroup) || newbl != 0.0
    newroot = PhyNode("NewRoot", branchlength(root(tree)))
    pruneregraft!(outgroup, newroot, newbl)
    if length(outgrouppath) == 0
      # There aren't any nodes between the outgroup
      # and origional group to rearrange.
      newparent = newroot
    else
      parent = splice!(outgrouppath, 1)
      previousbranchlength, parent.branchlength = parent.branchlength, previousbranchlength - branchlength(outgroup)
      pruneregraft!(parent, newroot)
      newparent = parent
    end
  else
    # Use the provided outgroup as a
    # trifurcating root if the node is not a leaf / newbl is 0.0.
    newroot = newparent = outgroup
    branchlength!(newroot, branchlength(root(tree)))
  end

  # Now we trace the outgroup lineage back,
  # reattaching the subclades under the new root!
  for parent in outgrouppath
    #prune!(newparent)
    previousbranchlength, parent.branchlength =
      parent.branchlength, previousbranchlength
    pruneregraft!(parent, newparent)
    newparent = parent
  end

  # Now we have two s of connected PhyNodes.
  # One begins the with the new root and contains the
  # nodes rearranged as per the backtracking process
  # along outgrouppath. The other is the nodes still
  # connected to the old root.
  # This needs to be resolved.

  # If the old root only has one child, it was bifurcating,
  # and if so, must be removed and the branch lengths resolved,
  # appropriately.
  if countchildren(tree.root) == 1
    ingroup = children(root(tree))[1]
    branchlength!(ingroup, branchlength(ingroup) + previousbranchlength)
    pruneregraft!(ingroup, newparent)
  else
    # If the root has more than one child,
    # then it needs to be kept as an internal node.
    branchlength!(tree.root, previousbranchlength)
    graft!(newparent, tree.root)
  end

  # TODO / FUTURE IMPROVEMENT - COPYING OF OLD ROOT ATTRIBUTES OR DATA TO NEW ROOT.

  tree.root = newroot
  tree.rooted = true
end

# This is probably unnecessary given root puts the rooted flag to true.
# perhaps and unroot! method is more appropriate.
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
function rerootable!(x::Phylogeny, rerootable::Bool)
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
function terminals(x::Phylogeny)
  return terminaldescendents(x.root)
end

@doc """
Get one or more nodes by name.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search."),
    (:names, "The names of the nodes to get.")
  },
  :returns => (Vector{PhyNode})
} ->
function getindex(tree::Phylogeny, names::String...)
  return searchall(DepthFirst(tree), x -> in(name(x), names))
end

@doc """
Get one nodes by name.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search."),
    (:names, "The name of the nodes to get.")
  },
  :returns => (PhyNode)
} ->
function getindex(tree::Phylogeny, name::String)
  return search(DepthFirst(tree), x -> name(x) == name)
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
      error("You are trying to build an index dict " *
            "of a tree with clades of the same name.")
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
  p = pathbetween(tree, n1, n2)
  a = mrca(n1, n2)
  filter!((x) -> !x === a, p)
  return sum(distanceof, p)
end

@doc """
Find the number of edges in the shortest path between two nodes in a tree.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to search in."),
    (:n1, "The first node."),
    (:n2, "The second node.")
  },
  :returns => (Int)
} ->
function depth(tree::Phylogeny, n1::PhyNode, n2::PhyNode)
  p = pathbetween(tree, n1, n2)
  return length(p) == 1 ? 0 : length(p) - 1
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
Find the distance of each node from the root.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to measure.")
  },
  :returns => (Bool)
} ->
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

@doc """
Find the depth of each node from the root.
""" {
  :section => "Phylogeny",
  :parameters => {
    (:tree, "The Phylogeny to measure.")
  },
  :returns => (Bool)
} ->
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

@doc """
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.
This function sets the root of the phylogeny object to an empty node, as the root, and so the entire structure of the tree,
has been moved to the tree containing the specified parent PhyNode.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add the root of phylogeny too."),
    (:child, "The Phylogeny for which the root is to be attached to the input parent PhyNode.")
  }
} -> 
function graft!(parent::PhyNode, child::Phylogeny)
  graft!(parent, root(children))
  root_unsafe!(child, PhyNode())
end

@doc """
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.
""" {
  :section => "PhyNode",
  :parameters => {
    (:parent, "The PhyNode to add the root of phylogeny too."),
    (:child, "The Phylogeny for which the root is to be attached to the input parent PhyNode."),
    (:bl, "Branch length that the ")
  }
} ->
function graft!(parent::PhyNode, child::Phylogeny, bl::Float64)
  branchlength!(root(children), bl)
  graft!(parent, child)
end

@doc """
Set the root field of a Phylogeny variable.

**warning** This is different from the other `root!` methods, which rearrange the structure of a Phylogeny, rooting it based on an outgroup or midpoint.
rather, this function simply alters the root field. Generally this should not be used, except as a step in other methods. Careless use of this could result in loosing part of a tree for instance.
""" {
  :section => "PhyNode",
  :parameters => {
    (:tree, "The phylogeny for which the root is to be set."),
    (:node, "The PhyNode that is to become the root of the tree.")
  }
} ->
function root_unsafe!(tree::Phylogeny, node::PhyNode)
  tree.root = node
end
