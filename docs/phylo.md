# Bio.Phylo

## Exported
---

#### countchildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Int,)

Count the number of children of a node.

**Parameters:**

* `x`: The PhyNode to count the children of.


**source:**
[Bio/src/phylo/nodes.jl:392](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L392)

---

#### generateindex(tree::Bio.Phylo.Phylogeny)
Generate an index mapping names to nodes

**Parameters:**
* `tree`: The Phylogeny to index.


**source:**
[Bio/src/phylo/phylogeny.jl:359](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L359)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Graft a node onto another node, create a parent-child relationship between them.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:576](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L576)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode, branchlength::Float64)

Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.

**Parameters:**

* `parent`:       The PhyNode to add a child to.

* `child`:        The PhyNode to add as a child.

* `branchlength`: The branch length between parent and child.



**source:**
[Bio/src/phylo/nodes.jl:597](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L597)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.Phylogeny)
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.
This function sets the root of the phylogeny object to an empty node, as the root, and so the entire structure of the tree,
has been moved to the tree containing the specified parent PhyNode.

**Parameters:**

* `parent`: The PhyNode to add the root of phylogeny too.
* `child`:  The Phylogeny for which the root is to be attached to the input parent PhyNode.


**source:**
[Bio/src/phylo/phylogeny.jl:485](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L485)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.Phylogeny, bl::Float64)
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.

**Parameters:**
* `parent`: The PhyNode to add the root of phylogeny too.
* `child`:  The Phylogeny for which the root is to be attached to the input parent PhyNode.
* `bl`:     Branch length connecting the parent node to the grafted phylogeny.


**source:**
[Bio/src/phylo/phylogeny.jl:498](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L498)

---

#### graft!(parent::Bio.Phylo.PhyNode, children::Array{Bio.Phylo.PhyNode, 1})

Graft one or more nodes onto another node, create a parent-child relationship between each of the grafted nodes and the node they are grafted onto.

**Parameters:**

* `parent`:   The PhyNode to add a child to.

* `children`: The array of PhyNodes to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:612](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L612)

---

#### haschildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:209](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L209)

---

#### hasparent(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has a parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:253](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L253)

---

#### isintree(tree::Bio.Phylo.Phylogeny, clade::Bio.Phylo.PhyNode)
Test whether a given node is in a given tree.

**Parameters:**
* `tree`:   The Phylogeny to check.
* `clade`:  The PhyNode to check.


**source:**
[Bio/src/phylo/phylogeny.jl:110](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L110)

---

#### isleaf(x::Bio.Phylo.PhyNode)

  func_name(args...) -> (Bool,)

Test whether a node is a leaf.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:195](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L195)

---

#### ispreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is preterminal i.e. It's children are all leaves.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:360](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L360)

---

#### isrerootable(x::Bio.Phylo.Phylogeny)

    func_name(args...) -> (Bool,)

Test whether a Phylogeny is re-rootable.

**Parameters:**

* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:87](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L87)

---

#### isroot(x::Bio.Phylo.PhyNode)
Test whether a node is the root node.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:308](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L308)

---

#### isrooted(x::Bio.Phylo.Phylogeny)
Test whether a Phylogeny is rooted.

**Parameters:**

* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:73](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L73)

---

#### issemipreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is semi-preterminal i.e. Some of it's children are leaves, but not all are.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:377](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L377)

---

#### parentisself(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is its own parent. See PhyNode().

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:239](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L239)

---

#### pathbetween(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the shortest path between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in .
* `n1`:   The first node.
* `n2`:   The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:379](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L379)

---

#### prune!(x::Bio.Phylo.PhyNode)

Destroy the relationship between a PhyNode `x` and its parent, returning the PhyNode.

This method cleanly removes the PhyNode `x` from its parent's `children` array, and removes the `parent` reference from the PhyNode `x`. All other fields of the `child` are left intact.

**Parameters:**

* `x`: The PhyNode prune from its parent.


**source:**
[Bio/src/phylo/nodes.jl:628](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L628)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode)

Prune a PhyNode from its parent and graft it to another parent.

**Parameters:**

* `prune`:    The PhyNode to remove from its parent.

* `graftto`:  The PhyNode to become the new parent of `prune`.


**source:**
[Bio/src/phylo/nodes.jl:648](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L648)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode, branchlength::Float64)

Prune a PhyNode from its parent and graft it to another parent, setting the branch length.

**Parameters:**

* `prune`:        The PhyNode to remove from its parent.

* `graftto`:      The PhyNode to become the new parent of `prune`.

* `branchlength`: The branch length.


**source:**
[Bio/src/phylo/nodes.jl:665](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L665)

---

#### root!(tree::Bio.Phylo.Phylogeny)
Root a tree at the midpoint between the two most distant taxa.

This method modifies the `tree` variable.

**Parameters:**
* `tree`: The Phylogeny to root.


**source:**
[Bio/src/phylo/phylogeny.jl:123](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L123)

---

#### root!(tree::Bio.Phylo.Phylogeny, newbl::Float64)
Root a tree at the midpoint between the two most distant taxa.

This method modifies the `tree` variable.

**Parameters:**
* `tree`: The Phylogeny to root.


**source:**
[Bio/src/phylo/phylogeny.jl:123](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L123)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Array{Bio.Phylo.PhyNode, 1})
Root a tree using a given array of nodes as the outgroup, and optionally setting the branch length.

**Parameters:**
* `tree`: The Phylogeny to root.
* `outgroup`: An array of PhyNodes to use as outgroup.
* `newbl`: The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:196](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L196)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Array{Bio.Phylo.PhyNode, 1}, newbl::Float64)
Root a tree using a given array of nodes as the outgroup, and optionally setting the branch length.

**Parameters:**
* `tree`: The Phylogeny to root.
* `outgroup`: An array of PhyNodes to use as outgroup.
* `newbl`: The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:196](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L196)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Bio.Phylo.PhyNode)
Root a tree using a given node as the outgroup, and optionally setting the branch length,

**Parameters:**
* `tree`:     The Phylogeny to root.
* `outgroup`: A PhyNode to use as outgroup.
* `newbl`:    The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:211](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L211)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Bio.Phylo.PhyNode, newbl::Float64)
Root a tree using a given node as the outgroup, and optionally setting the branch length,

**Parameters:**
* `tree`:     The Phylogeny to root.
* `outgroup`: A PhyNode to use as outgroup.
* `newbl`:    The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:211](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L211)

---

#### Bio.Phylo.PhyNode
PhyNode represents a node in a phylogenetic tree.

A node can have:

- `name`
- `branchlength`
- a reference to its `parent` PhyNode
- reference to one or more `children`



**source:**
[Bio/src/phylo/nodes.jl:11](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L11)

---

#### Bio.Phylo.Phylogeny
Phylogeny represents a phylogenetic tree.

A tree can have:

- `name`
- `root`
- `rooted`
- `rerootable`



**source:**
[Bio/src/phylo/phylogeny.jl:11](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L11)

---

#### Bio.Phylo.PhylogenyIterator
PhylogenyIterator is an abstract type that defines a family of iterators
for traversing trees in various ways, including BreadthFirst, and DepthFirst, or from a tip to a root.

**source:**
[Bio/src/phylo/iteration.jl:9](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/iteration.jl#L9)

## Internal
---

#### addchild_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Add a node to the `children` array of another node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.



**source:**
[Bio/src/phylo/nodes.jl:543](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L543)

---

#### blisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the branchlength in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:77](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L77)

---

#### branchlength!(x::Bio.Phylo.PhyNode, bl::Float64)

    func_name(args...) -> (Float64,)

Set the branch length of a PhyNode.

**This method modifies the PhyNode.**

**Parameters:**

* `x`:  The PhyNode to set the branchlength of.

* `bl`: The branch length to give the PhyNode. Either a Float64 value or `nothing`.


**source:**
[Bio/src/phylo/nodes.jl:488](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L488)

---

#### branchlength(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the branch length of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the branch length of.


**source:**
[Bio/src/phylo/nodes.jl:181](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L181)

---

#### call(::Type{Bio.Phylo.BreadthFirst}, x::Bio.Phylo.Phylogeny)
Construct a BreadthFirst iterator for a tree.

**source:**
[Bio/src/phylo/iteration.jl:24](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/iteration.jl#L24)

---

#### call(::Type{Bio.Phylo.Phylogeny}, name::AbstractString, root::Bio.Phylo.PhyNode, rooted::Bool, rerootable::Bool)
Create a Phylogeny with a name, root node, and set whether it is rooted and whether
it is re-rootable.

**Parameters:**

* `name`:       The name of the tree.

* `root`:       The root node.

* `rooted`:     Whether the tree is rooted.

* `rerootable`: Whether the tree is re-rootable.


**source:**
[Bio/src/phylo/phylogeny.jl:34](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L34)

---

#### children(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the children of a node.

**Parameters:**

* `x`: The PhyNode to get children for.


**source:**
[Bio/src/phylo/nodes.jl:267](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L267)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Float64)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.


**source:**
[Bio/src/phylo/nodes.jl:121](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L121)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Void)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.




**source:**
[Bio/src/phylo/nodes.jl:139](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L139)

---

#### confidence(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the confidence of the node.

**Parameters:**

* `x`:  The PhyNode to return the confidence of.


**source:**
[Bio/src/phylo/nodes.jl:105](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L105)

---

#### confisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the confidence in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:91](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L91)

---

#### delete!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Delete a node, destroying the relationships between it and its parent, and it and its children. The children of the node become the children of the node's former parent.

Returns the deleted node.

**Parameter:**

* `x`: The PhyNode to delete.


**source:**
[Bio/src/phylo/nodes.jl:682](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L682)

---

#### depth(tree::Bio.Phylo.Phylogeny)
Find the depth of each node from the root.

**Parameters:**

* `tree`: The Phylogeny to measure.


**source:**
[Bio/src/phylo/phylogeny.jl:463](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L463)

---

#### depth(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the number of edges in the shortest path between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`: The first node.
* `n2`: The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:420](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L420)

---

#### descendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the descendents of a node.

**Parameters:**

* `x`: The PhyNode to get the descendents of.



**source:**
[Bio/src/phylo/nodes.jl:407](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L407)

---

#### detach!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Detach a subtree at a given node.

Returns a new Phylogeny with the detached node as root.

**Parameters:**

* `x`:          The PhyNode to detach.

* `name`:       The name of the new Phylogeny.

* `rooted`:     Whether the detached subtree is rooted.

* `rerootable`: Whether the detached subtree is rerootable.


**source:**
[Bio/src/phylo/nodes.jl:706](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L706)

---

#### detach!(x::Bio.Phylo.PhyNode, name::AbstractString)

    func_name(args...) -> (PhyNode,)

Detach a subtree at a given node.

Returns a new Phylogeny with the detached node as root.

**Parameters:**

* `x`:          The PhyNode to detach.

* `name`:       The name of the new Phylogeny.

* `rooted`:     Whether the detached subtree is rooted.

* `rerootable`: Whether the detached subtree is rerootable.


**source:**
[Bio/src/phylo/nodes.jl:706](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L706)

---

#### detach!(x::Bio.Phylo.PhyNode, name::AbstractString, rooted::Bool)

    func_name(args...) -> (PhyNode,)

Detach a subtree at a given node.

Returns a new Phylogeny with the detached node as root.

**Parameters:**

* `x`:          The PhyNode to detach.

* `name`:       The name of the new Phylogeny.

* `rooted`:     Whether the detached subtree is rooted.

* `rerootable`: Whether the detached subtree is rerootable.


**source:**
[Bio/src/phylo/nodes.jl:706](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L706)

---

#### detach!(x::Bio.Phylo.PhyNode, name::AbstractString, rooted::Bool, rerootable::Bool)

    func_name(args...) -> (PhyNode,)

Detach a subtree at a given node.

Returns a new Phylogeny with the detached node as root.

**Parameters:**

* `x`:          The PhyNode to detach.

* `name`:       The name of the new Phylogeny.

* `rooted`:     Whether the detached subtree is rooted.

* `rerootable`: Whether the detached subtree is rerootable.


**source:**
[Bio/src/phylo/nodes.jl:706](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L706)

---

#### distance(tree::Bio.Phylo.Phylogeny)
Find the distance of each node from the root.

**Parameters:**
* `tree`: The Phylogeny to measure.


**source:**
[Bio/src/phylo/phylogeny.jl:443](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L443)

---

#### distance(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode)
Find the distance between a node and the root of a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`:   The node.


**source:**
[Bio/src/phylo/phylogeny.jl:432](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L432)

---

#### distance(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the distance between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`:   The first node.
* `n2`:   The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:399](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L399)

---

#### distanceof(x::Bio.Phylo.PhyNode)
Find the distance of a node from its parent. This is different from branch length, because it handles the situation where branch length is unknown. It is only used when the distances between nodes are calculated.

The method is necessary because unknown branch lengths are represented as -1.0.
If all branch lengths are unknown, the tree is a cladogram, and it is still useful to be able to compare relative distances. If individual branch lengths are unknown, they should not affect the calculation of path distances. To satisfy both of these cases, we use machine epsilon as the minimal distance.

**Parameters:**

* `x`: A PhyNode.



**source:**
[Bio/src/phylo/nodes.jl:740](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L740)

---

#### findmidpoint(tree::Bio.Phylo.Phylogeny)
Find the midpoint of a tree.

**Parameters:**
* `tree`: The Phylogeny to find the midpoint of.


**source:**
[Bio/src/phylo/phylogeny.jl:170](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L170)

---

#### furthestfromroot(tree::Bio.Phylo.Phylogeny)
Find the node that is furthest from the root of a tree.

**Parameters:**
* `tree` The Phylogeny to search.


**source:**
[Bio/src/phylo/phylogeny.jl:147](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L147)

---

#### furthestleaf(tree::Bio.Phylo.Phylogeny, node::Bio.Phylo.PhyNode)
Find the leaf that is furthest from a given node in a tree.

  **Parameters:**
  * `tree`: The Phylogeny containing the nodes.
  * `node`: The PhyNode find the furthest node from.


**source:**
[Bio/src/phylo/phylogeny.jl:159](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L159)

---

#### getindex(tree::Bio.Phylo.Phylogeny, name::AbstractString)
Get one node by name.

**Parameters:**
* `tree`:  The Phylogeny to search.
* `names`: The name of the nodes to get.


**source:**
[Bio/src/phylo/phylogeny.jl:344](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L344)

---

#### getindex(tree::Bio.Phylo.Phylogeny, names::Array{AbstractString, 1})
Get one or more nodes by name.

**Parameters:**
* `tree`:  The Phylogeny to search.
* `names`: The names of the nodes to get.


**source:**
[Bio/src/phylo/phylogeny.jl:333](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L333)

---

#### haschild(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is the parent of another specific node.

**Parameters:**

* `parent`: The potential parent PhyNode to test.

* `child`:  The potential child PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:225](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L225)

---

#### isancestral(posanc::Bio.Phylo.PhyNode, nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (Bool,)

Test whether a node is ancesteral to one or more other nodes.

**Parameters:**

* `posanc`: The PhyNode to test.

* `nodes`: An array of `PhyNode`s that the test node must be ancestral to.


**source:**
[Bio/src/phylo/nodes.jl:437](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L437)

---

#### isempty(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is empty.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:153](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L153)

---

#### isempty(x::Bio.Phylo.Phylogeny)
Test whether a phylogeny is empty.

**Parameters:**
* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:49](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L49)

---

#### isequal(x::Bio.Phylo.PhyNode, y::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether two PhyNodes are equal. Specifically, test whether all three of `branchlength`, `name` and `extensions` are equal.

**Parameters:**

* `x`: The left PhyNode to compare.

* `y`: The right PhyNode to compare.


**source:**
[Bio/src/phylo/nodes.jl:723](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L723)

---

#### isinternal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is internal, i.e. has a parent and one or more children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:346](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L346)

---

#### islinked(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is linked, i.e. has one or more children and/or a parent.
**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:332](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L332)

---

#### isunlinked(x::Bio.Phylo.PhyNode)
Test whether a node is unlinked, i.e. has no children and no parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:319](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L319)

---

#### makenewclade()
Makes a new clade when building a tree from a newick string.
This method of the function accepts no parameters and returns an empty `PhyNode`.


**source:**
[Bio/src/phylo/treeio.jl:115](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L115)

---

#### makenewclade(parent::Bio.Phylo.PhyNode)
Makes a new clade when building a tree from a newick string.

This method is used in the `parsenewick` method to take car of linking a 
newly created node to its parent on creation.

**Parameters:**

* `parent`: The parent of the to-be-created PhyNode.

**Returns:** A reference to the newly created `PhyNode`.


**source:**
[Bio/src/phylo/treeio.jl:131](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L131)

---

#### maxindict(dictionary::Dict{K, V})
Find the maximum branch length in a dictionary mapping nodes to their branch lengths.
  
**Parameters:**
* `dict`: The dictionary.


**source:**
[Bio/src/phylo/phylogeny.jl:134](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L134)

---

#### mrca(nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (PhyNode,)

Get the most recent common ancestor of an array of nodes.

**Parameters:**

* `nodes`:  An array of `PhyNode`s to find the most common ancestor of.


**source:**
[Bio/src/phylo/nodes.jl:452](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L452)

---

#### name!(x::Bio.Phylo.PhyNode, name::AbstractString)

    func_name(args...) -> (Bool,)

Set the name of a PhyNode.

**Parameters:**

* `x`:    The PhyNode to set the name of.

* `name`: The name to give the PhyNode.


**source:**
[Bio/src/phylo/nodes.jl:470](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L470)

---

#### name!(x::Bio.Phylo.Phylogeny, name::AbstractString)
Set the name of a Phylogeny

**Parameters:**

* `x`:    The Phylogeny to set the name of.

* `name`: The name to set.


**source:**
[Bio/src/phylo/phylogeny.jl:62](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L62)

---

#### name(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the name of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the name of.


**source:**
[Bio/src/phylo/nodes.jl:167](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L167)

---

#### parent(x::Bio.Phylo.PhyNode)
Get the parent of a node.

**Parameters:**

* `x`: The PhyNode to get the parent of.


**source:**
[Bio/src/phylo/nodes.jl:294](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L294)

---

#### parent_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Set the parent of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`:  The PhyNode to set as parent.

* `child`:   The PhyNode to set the parent of.


**source:**
[Bio/src/phylo/nodes.jl:524](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L524)

---

#### parseconfidence(text::AbstractString)
Parses confidence values from string - if this is not possible,
-1.0 is returned, which is the value for 'unknown' in `Phylo`.


**source:**
[Bio/src/phylo/treeio.jl:169](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L169)

---

#### parsenewick(newickstring::AbstractString)
Build a `Phylogeny` from a String formatted as a Newick string.

Newick strings are of the form `(((A,B),C),D);`.
In such strings, parentheses delimit clades, and text delimits taxa names. Somtimes accompanied
by a floating point value that may be a branch length, or clade support value.

**Paramerters:**

* `newickstring`: A newick formatted `String`.
* `commentsareconf`: `Bool` value indicating if comments provide clade support values.
* `valuessareconf`: `Bool` value indicating if values (usually branchlengths) provide clade support values.

**Returns:** A `Phylogeny` constructed from the string.


**source:**
[Bio/src/phylo/treeio.jl:209](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L209)

---

#### parsenewick(newickstring::AbstractString, commentsareconf)
Build a `Phylogeny` from a String formatted as a Newick string.

Newick strings are of the form `(((A,B),C),D);`.
In such strings, parentheses delimit clades, and text delimits taxa names. Somtimes accompanied
by a floating point value that may be a branch length, or clade support value.

**Paramerters:**

* `newickstring`: A newick formatted `String`.
* `commentsareconf`: `Bool` value indicating if comments provide clade support values.
* `valuessareconf`: `Bool` value indicating if values (usually branchlengths) provide clade support values.

**Returns:** A `Phylogeny` constructed from the string.


**source:**
[Bio/src/phylo/treeio.jl:209](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L209)

---

#### parsenewick(newickstring::AbstractString, commentsareconf, valuesareconf)
Build a `Phylogeny` from a String formatted as a Newick string.

Newick strings are of the form `(((A,B),C),D);`.
In such strings, parentheses delimit clades, and text delimits taxa names. Somtimes accompanied
by a floating point value that may be a branch length, or clade support value.

**Paramerters:**

* `newickstring`: A newick formatted `String`.
* `commentsareconf`: `Bool` value indicating if comments provide clade support values.
* `valuessareconf`: `Bool` value indicating if values (usually branchlengths) provide clade support values.

**Returns:** A `Phylogeny` constructed from the string.


**source:**
[Bio/src/phylo/treeio.jl:209](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L209)

---

#### processclade(node::Bio.Phylo.PhyNode, valuesareconf::Bool, commentsareconf::Bool)
Finishes the processing of the current clade in the newick file.

**Parameters:**

* `node`:            The `PhyNode` to finish processing.
* `valuesareconf`:   `Bool` that specifies whether the values of the clade are confidence values.
* `commentsareconf`: `Bool` that specifies if comments are confidence values.

**Returns:** The parent `PhyNode` of the `PhyNode` provided as the `node` parameter.


**source:**
[Bio/src/phylo/treeio.jl:148](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L148)

---

#### removechild_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Remove a node from the `children` array of another node.

**Warning:** this method is considered unsafe because it does not destroy any two-way link between parent and child. If you want to remove a child from a node, you should use `prune!()`, which does ensure the two-way link is destroyed.

**Parameters:**

* `parent`: 

* `child`:


**source:**
[Bio/src/phylo/nodes.jl:562](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L562)

---

#### removeparent_unsafe!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Remove the parent of a `PhyNode` (thus setting the parent property to be self-referential).

**Parameters:**

* `x`: The PhyNode to remove the parent of.


**source:**
[Bio/src/phylo/nodes.jl:506](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L506)

---

#### rerootable!(x::Bio.Phylo.Phylogeny, rerootable::Bool)
Set whether a tree is re-rootable.

**Parameters:**
* `x`:          The Phylogeny.
* `rerootable`: Whether the Phylogeny is re-rootable.


**source:**
[Bio/src/phylo/phylogeny.jl:312](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L312)

---

#### root(x::Bio.Phylo.Phylogeny)

    func_name(args...) -> (PhyNode,)
Get the root node of a Phylogeny.

**Parameters:**
* `x`: The Phylogeny to get the root of.


**source:**
[Bio/src/phylo/phylogeny.jl:99](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L99)

---

#### root_unsafe!(tree::Bio.Phylo.Phylogeny, node::Bio.Phylo.PhyNode)
Set the root field of a Phylogeny variable.

**warning** This is different from the other `root!` methods, which rearrange the structure of a Phylogeny, rooting it based on an outgroup or midpoint.
rather, this function simply alters the root field. Generally this should not be used, except as a step in other methods. Careless use of this could result in loosing part of a tree for instance.

**Parameters:**
* `tree`: The phylogeny for which the root is to be set.
* `node`: The PhyNode that is to become the root of the tree.


**source:**
[Bio/src/phylo/phylogeny.jl:513](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L513)

---

#### showerror(io::IO, e::Bio.Phylo.NewickException)
Basic function that prints NewickExceptions to screen. 


**source:**
[Bio/src/phylo/treeio.jl:191](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L191)

---

#### siblings(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the siblings of a node. Included in output is the input node.

**Parameters:**

* `x`: The PhyNode to get siblings for.


**source:**
[Bio/src/phylo/nodes.jl:281](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L281)

---

#### terminaldescendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the terminal descendents of a node. i.e. Nodes that are leaves, which have the input node as an ancestor.

**Parameters:**

* `x`: The PhyNode to get ther terminal descendents of.


**source:**
[Bio/src/phylo/nodes.jl:421](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/nodes.jl#L421)

---

#### terminals(x::Bio.Phylo.Phylogeny)
Get the terminal nodes of a phylogeny.

**Parameters:**
* `x`: The Phylogeny.


**source:**
[Bio/src/phylo/phylogeny.jl:322](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L322)

---

#### tokenizestring(s::AbstractString, t::Bio.Phylo.Tokenizer)
Break a string into a series of tokens.

**Parameters:**

* `s`: The input `String` to be broken into tokens.
* `t`: The `Tokenizer` to use when forming tokens.

**Returns:** An array of `String` tokens.


**source:**
[Bio/src/phylo/treeio.jl:107](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L107)

---

#### unroot!(x::Bio.Phylo.Phylogeny)
Unroot a tree.

**Parameters:**
* `x`: The Phylogeny to unroot.


**source:**
[Bio/src/phylo/phylogeny.jl:301](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/phylogeny.jl#L301)

---

#### Bio.Phylo.NewickException
A simple Exception type that is thrown by newick related functions when an error occurs.

**Fields:**

* `msg`: A `String` containing the message to print to screen with `showerror`. 


**source:**
[Bio/src/phylo/treeio.jl:184](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L184)

---

#### Bio.Phylo.Tokenizer
Tokenizer type that is responsible for splitting a string into token according to a
regex specification. The regex specification is stored in `dict`.

**Fields:**

* `dict`:      A Dictionary of String keys and Regex values.
* `tokenizer`: A regex that is generated from the specification.


**source:**
[Bio/src/phylo/treeio.jl:75](https://github.com/Ward9250/Bio.jl/tree/79309dfe8318e5ededee9704e7cb5c9888a2458f/src/phylo/treeio.jl#L75)


