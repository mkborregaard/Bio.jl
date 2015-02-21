# Bio.Phylo
The `Bio.Phylo` submodule provides phylogenetic tools for [BioJulia](index.html).

The module exposes types for phylogenetic trees, nodes in trees, and annotations for nodes.

Methods are provided for building, manipulating, accessing and measuring trees and their nodes.


## Exported
---

#### countchildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Int,)

Count the number of children of a node.

**Parameters:**

* `x`: The PhyNode to count the children of.


**source:**
[Bio/src/phylo/nodes.jl:430](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L430)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Graft a node onto another node, create a parent-child relationship between them.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:614](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L614)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode, branchlength::Float64)

Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.

**Parameters:**

* `parent`:       The PhyNode to add a child to.

* `child`:        The PhyNode to add as a child.

* `branchlength`: The branch length between parent and child.



**source:**
[Bio/src/phylo/nodes.jl:635](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L635)

---

#### graft!(parent::Bio.Phylo.PhyNode, children::Array{Bio.Phylo.PhyNode, 1})

Graft one or more nodes onto another node, create a parent-child relationship between each of the grafted nodes and the node they are grafted onto.

**Parameters:**

* `parent`:   The PhyNode to add a child to.

* `children`: The array of PhyNodes to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:650](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L650)

---

#### haschildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:225](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L225)

---

#### hasextensions(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has extensions.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:255](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L255)

---

#### hasparent(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has a parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:283](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L283)

---

#### isleaf(x::Bio.Phylo.PhyNode)

  func_name(args...) -> (Bool,)

Test whether a node is a leaf.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:211](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L211)

---

#### ispreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is preterminal i.e. It's children are all leaves.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:398](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L398)

---

#### isroot(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)
Test whether a node is the root node.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:343](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L343)

---

#### issemipreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is semi-preterminal i.e. Some of it's children are leaves, but not all are.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:415](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L415)

---

#### parentisself(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is its own parent. See PhyNode().

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:269](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L269)

---

#### prune!(x::Bio.Phylo.PhyNode)

Destroy the relationship between a PhyNode `x` and its parent, returning the PhyNode.

This method cleanly removes the PhyNode `x` from its parent's `children` array, and removes the `parent` reference from the PhyNode `x`. All other fields of the `child` are left intact.

**Parameters:**

* `x`: The PhyNode prune from its parent.


**source:**
[Bio/src/phylo/nodes.jl:666](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L666)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode)

Prune a PhyNode from its parent and graft it to another parent.

**Parameters:**

* `prune`:    The PhyNode to remove from its parent.

* `graftto`:  The PhyNode to become the new parent of `prune`.


**source:**
[Bio/src/phylo/nodes.jl:686](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L686)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode, branchlength::Float64)

Prune a PhyNode from its parent and graft it to another parent, setting the branch length.

**Parameters:**

* `prune`:        The PhyNode to remove from its parent.

* `graftto`:      The PhyNode to become the new parent of `prune`.

* `branchlength`: The branch length.


**source:**
[Bio/src/phylo/nodes.jl:703](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L703)

---

#### Bio.Phylo.PhyExtension{T}
PhyExtension allows defining arbitrary metadata to annotate nodes.

This allows the PhyNode type to support any phylogenetic tree format 
that includes annotations (e.g. PhyloXML, NeXML), and allows programmatic 
extension of nodes with annotations.


**source:**
[Bio/src/phylo/nodes.jl:9](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L9)

---

#### Bio.Phylo.PhyNode
PhyNode represents a node in a phylogenetic tree.

A node can have:

- `name`
- `branchlength`
- one or more `extensions`
- a reference to its `parent` PhyNode
- reference to one or more `children`



**source:**
[Bio/src/phylo/nodes.jl:25](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L25)

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
[Bio/src/phylo/nodes.jl:581](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L581)

---

#### blisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the branchlength in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:93](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L93)

---

#### branchlength!(x::Bio.Phylo.PhyNode, bl::Float64)

    func_name(args...) -> (Float64,)

Set the branch length of a PhyNode.

**This method modifies the PhyNode.**

**Parameters:**

* `x`:  The PhyNode to set the branchlength of.

* `bl`: The branch length to give the PhyNode. Either a Float64 value or `nothing`.


**source:**
[Bio/src/phylo/nodes.jl:526](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L526)

---

#### branchlength(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the branch length of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the branch length of.


**source:**
[Bio/src/phylo/nodes.jl:197](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L197)

---

#### call(::Type{Bio.Phylo.PhyNode})

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString)

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString, branchlength::Float64)

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString, branchlength::Float64, confidence::Float64)

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString, branchlength::Float64, confidence::Float64, ext::Array{Bio.Phylo.PhyExtension{T}, 1})

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString, branchlength::Float64, confidence::Float64, ext::Array{Bio.Phylo.PhyExtension{T}, 1}, children::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### call(::Type{Bio.Phylo.PhyNode}, name::AbstractString, branchlength::Float64, confidence::Float64, ext::Array{Bio.Phylo.PhyExtension{T}, 1}, children::Array{Bio.Phylo.PhyNode, 1}, parent)

    func_name(args...) -> (PhyNode,)

Create a PhyNode.

PhyNodes represent nodes in a phylogenetic tree. All arguments are optional 
when creating PhyNodes:

**Example:**

    one = PhyNode()
    two = PhyNode(name = "two",
      branchlength = 1.0,
      parent = one)

**Parameters:**

* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: The branch length of the node from its parent (optional).
                  Defaults to `-1.0`, indicating an unknown branch length.

* `ext`:          An array of zero or more PhyExtensions (optional). Defaults to an empty
                  array, i.e. `[]`, indicating there are no extensions.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.


**source:**
[Bio/src/phylo/nodes.jl:64](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L64)

---

#### children(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the children of a node.

**Parameters:**

* `x`: The PhyNode to get children for.


**source:**
[Bio/src/phylo/nodes.jl:297](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L297)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Float64)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.


**source:**
[Bio/src/phylo/nodes.jl:137](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L137)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Void)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.




**source:**
[Bio/src/phylo/nodes.jl:155](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L155)

---

#### confidence(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the confidence of the node.

**Parameters:**

* `x`:  The PhyNode to return the confidence of.


**source:**
[Bio/src/phylo/nodes.jl:121](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L121)

---

#### confisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the confidence in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:107](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L107)

---

#### delete!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Delete a node, destroying the relationships between it and its parent, and it and its children. The children of the node become the children of the node's former parent.

Returns the deleted node.

**Parameter:**

* `x`: The PhyNode to delete.


**source:**
[Bio/src/phylo/nodes.jl:720](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L720)

---

#### descendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the descendents of a node.

**Parameters:**

* `x`: The PhyNode to get the descendents of.



**source:**
[Bio/src/phylo/nodes.jl:445](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L445)

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
[Bio/src/phylo/nodes.jl:744](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L744)

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
[Bio/src/phylo/nodes.jl:744](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L744)

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
[Bio/src/phylo/nodes.jl:744](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L744)

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
[Bio/src/phylo/nodes.jl:744](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L744)

---

#### distanceof(x::Bio.Phylo.PhyNode)
Find the distance of a node from its parent. This is different from branch length, because it handles the situation where branch length is unknown. It is only used when the distances between nodes are calculated.

The method is necessary because unknown branch lengths are represented as -1.0.
If all branch lengths are unknown, the tree is a cladogram, and it is still useful to be able to compare relative distances. If individual branch lengths are unknown, they should not affect the calculation of path distances. To satisfy both of these cases, we use machine epsilon as the minimal distance.

**Parameters:**

* `x`: A PhyNode.



**source:**
[Bio/src/phylo/nodes.jl:779](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L779)

---

#### haschild(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is the parent of another specific node.

**Parameters:**

* `parent`: The potential parent PhyNode to test.

* `child`:  The potential child PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:241](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L241)

---

#### isancestral(posanc::Bio.Phylo.PhyNode, nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (Bool,)

Test whether a node is ancesteral to one or more other nodes.

**Parameters:**

* `posanc`: The PhyNode to test.

* `nodes`: An array of `PhyNode`s that the test node must be ancestral to.


**source:**
[Bio/src/phylo/nodes.jl:475](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L475)

---

#### isempty(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is empty.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:169](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L169)

---

#### isequal(x::Bio.Phylo.PhyNode, y::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether two PhyNodes are equal. Specifically, test whether all three of `branchlength`, `name` and `extensions` are equal.

**Parameters:**

* `x`: The left PhyNode to compare.

* `y`: The right PhyNode to compare.


**source:**
[Bio/src/phylo/nodes.jl:761](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L761)

---

#### isinternal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is internal, i.e. has a parent and one or more children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:384](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L384)

---

#### islinked(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is linked, i.e. has one or more children and/or a parent.
**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:370](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L370)

---

#### isunlinked(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is unlinked, i.e. has no children and no parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:357](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L357)

---

#### mrca(nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (PhyNode,)

Get the most recent common ancestor of an array of nodes.

**Parameters:**

* `nodes`:  An array of `PhyNode`s to find the most common ancestor of.


**source:**
[Bio/src/phylo/nodes.jl:490](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L490)

---

#### name!(x::Bio.Phylo.PhyNode, name::AbstractString)

    func_name(args...) -> (Bool,)

Set the name of a PhyNode.

**Parameters:**

* `x`:    The PhyNode to set the name of.

* `name`: The name to give the PhyNode.


**source:**
[Bio/src/phylo/nodes.jl:508](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L508)

---

#### name(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the name of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the name of.


**source:**
[Bio/src/phylo/nodes.jl:183](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L183)

---

#### parent(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Get the parent of a node.

**Parameters:**

* `x`: The PhyNode to get the parent of.


**source:**
[Bio/src/phylo/nodes.jl:327](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L327)

---

#### parent_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Set the parent of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`:  The PhyNode to set as parent.

* `child`:   The PhyNode to set the parent of.


**source:**
[Bio/src/phylo/nodes.jl:562](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L562)

---

#### removechild_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Remove a node from the `children` array of another node.

**Warning:** this method is considered unsafe because it does not destroy any two-way link between parent and child. If you want to remove a child from a node, you should use `prune!()`, which does ensure the two-way link is destroyed.

**Parameters:**

* `parent`: 

* `child`:


**source:**
[Bio/src/phylo/nodes.jl:600](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L600)

---

#### removeparent_unsafe!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Remove the parent of a `PhyNode` (thus setting the parent property to be self-referential).

**Parameters:**

* `x`: The PhyNode to remove the parent of.


**source:**
[Bio/src/phylo/nodes.jl:544](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L544)

---

#### siblings(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the siblings of a node. Included in output is the input node.

**Parameters:**

* `x`: The PhyNode to get siblings for.


**source:**
[Bio/src/phylo/nodes.jl:311](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L311)

---

#### terminaldescendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the terminal descendents of a node. i.e. Nodes that are leaves, which have the input node as an ancestor.

**Parameters:**

* `x`: The PhyNode to get ther terminal descendents of.


**source:**
[Bio/src/phylo/nodes.jl:459](https://github.com/Ward9250/Bio.jl/tree/cfa79f96fb71ea6b394ff47e77e9a8a14708cb45/src/phylo/nodes.jl#L459)


