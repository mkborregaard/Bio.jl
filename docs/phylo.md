# Bio.Phylo
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




## Exported
---

#### countchildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Int,)

Count the number of children of a node.

**Parameters:**

* `x`: The PhyNode to count the children of.


**source:**
[Bio/src/phylo/nodes.jl:422](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L422)

---

#### generateindex(tree::Bio.Phylo.Phylogeny)
Generate an index mapping names to nodes

**Parameters:**
* `tree`: The Phylogeny to index.


**source:**
[Bio/src/phylo/phylogeny.jl:359](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L359)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Graft a node onto another node, create a parent-child relationship between them.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:606](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L606)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode, branchlength::Float64)

Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.

**Parameters:**

* `parent`:       The PhyNode to add a child to.

* `child`:        The PhyNode to add as a child.

* `branchlength`: The branch length between parent and child.



**source:**
[Bio/src/phylo/nodes.jl:627](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L627)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.Phylogeny)
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.
This function sets the root of the phylogeny object to an empty node, as the root, and so the entire structure of the tree,
has been moved to the tree containing the specified parent PhyNode.

**Parameters:**

* `parent`: The PhyNode to add the root of phylogeny too.
* `child`:  The Phylogeny for which the root is to be attached to the input parent PhyNode.


**source:**
[Bio/src/phylo/phylogeny.jl:485](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L485)

---

#### graft!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.Phylogeny, bl::Float64)
Graft a Phylogeny to the node of another tree, creates a parent-child relationship between the input node, and the root of the input phylogeny.

**Parameters:**
* `parent`: The PhyNode to add the root of phylogeny too.
* `child`:  The Phylogeny for which the root is to be attached to the input parent PhyNode.
* `bl`:     Branch length connecting the parent node to the grafted phylogeny.


**source:**
[Bio/src/phylo/phylogeny.jl:498](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L498)

---

#### graft!(parent::Bio.Phylo.PhyNode, children::Array{Bio.Phylo.PhyNode, 1})

Graft one or more nodes onto another node, create a parent-child relationship between each of the grafted nodes and the node they are grafted onto.

**Parameters:**

* `parent`:   The PhyNode to add a child to.

* `children`: The array of PhyNodes to add as a child.


**source:**
[Bio/src/phylo/nodes.jl:642](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L642)

---

#### haschildren(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:225](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L225)

---

#### hasextensions(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has extensions.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:255](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L255)

---

#### hasparent(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node has a parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:283](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L283)

---

#### isintree(tree::Bio.Phylo.Phylogeny, clade::Bio.Phylo.PhyNode)
Test whether a given node is in a given tree.

**Parameters:**
* `tree`:   The Phylogeny to check.
* `clade`:  The PhyNode to check.


**source:**
[Bio/src/phylo/phylogeny.jl:110](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L110)

---

#### isleaf(x::Bio.Phylo.PhyNode)

  func_name(args...) -> (Bool,)

Test whether a node is a leaf.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:211](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L211)

---

#### ispreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is preterminal i.e. It's children are all leaves.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:390](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L390)

---

#### isrerootable(x::Bio.Phylo.Phylogeny)

    func_name(args...) -> (Bool,)

Test whether a Phylogeny is re-rootable.

**Parameters:**

* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:87](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L87)

---

#### isroot(x::Bio.Phylo.PhyNode)
Test whether a node is the root node.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:338](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L338)

---

#### isrooted(x::Bio.Phylo.Phylogeny)
Test whether a Phylogeny is rooted.

**Parameters:**

* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:73](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L73)

---

#### issemipreterminal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is semi-preterminal i.e. Some of it's children are leaves, but not all are.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:407](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L407)

---

#### parentisself(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is its own parent. See PhyNode().

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:269](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L269)

---

#### pathbetween(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the shortest path between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in .
* `n1`:   The first node.
* `n2`:   The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:379](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L379)

---

#### prune!(x::Bio.Phylo.PhyNode)

Destroy the relationship between a PhyNode `x` and its parent, returning the PhyNode.

This method cleanly removes the PhyNode `x` from its parent's `children` array, and removes the `parent` reference from the PhyNode `x`. All other fields of the `child` are left intact.

**Parameters:**

* `x`: The PhyNode prune from its parent.


**source:**
[Bio/src/phylo/nodes.jl:658](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L658)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode)

Prune a PhyNode from its parent and graft it to another parent.

**Parameters:**

* `prune`:    The PhyNode to remove from its parent.

* `graftto`:  The PhyNode to become the new parent of `prune`.


**source:**
[Bio/src/phylo/nodes.jl:678](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L678)

---

#### pruneregraft!(prune::Bio.Phylo.PhyNode, graftto::Bio.Phylo.PhyNode, branchlength::Float64)

Prune a PhyNode from its parent and graft it to another parent, setting the branch length.

**Parameters:**

* `prune`:        The PhyNode to remove from its parent.

* `graftto`:      The PhyNode to become the new parent of `prune`.

* `branchlength`: The branch length.


**source:**
[Bio/src/phylo/nodes.jl:695](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L695)

---

#### root!(tree::Bio.Phylo.Phylogeny)
Root a tree at the midpoint between the two most distant taxa.

This method modifies the `tree` variable.

**Parameters:**
* `tree`: The Phylogeny to root.


**source:**
[Bio/src/phylo/phylogeny.jl:123](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L123)

---

#### root!(tree::Bio.Phylo.Phylogeny, newbl::Float64)
Root a tree at the midpoint between the two most distant taxa.

This method modifies the `tree` variable.

**Parameters:**
* `tree`: The Phylogeny to root.


**source:**
[Bio/src/phylo/phylogeny.jl:123](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L123)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Array{Bio.Phylo.PhyNode, 1})
Root a tree using a given array of nodes as the outgroup, and optionally setting the branch length.

**Parameters:**
* `tree`: The Phylogeny to root.
* `outgroup`: An array of PhyNodes to use as outgroup.
* `newbl`: The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:196](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L196)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Array{Bio.Phylo.PhyNode, 1}, newbl::Float64)
Root a tree using a given array of nodes as the outgroup, and optionally setting the branch length.

**Parameters:**
* `tree`: The Phylogeny to root.
* `outgroup`: An array of PhyNodes to use as outgroup.
* `newbl`: The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:196](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L196)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Bio.Phylo.PhyNode)
Root a tree using a given node as the outgroup, and optionally setting the branch length,

**Parameters:**
* `tree`:     The Phylogeny to root.
* `outgroup`: A PhyNode to use as outgroup.
* `newbl`:    The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:211](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L211)

---

#### root!(tree::Bio.Phylo.Phylogeny, outgroup::Bio.Phylo.PhyNode, newbl::Float64)
Root a tree using a given node as the outgroup, and optionally setting the branch length,

**Parameters:**
* `tree`:     The Phylogeny to root.
* `outgroup`: A PhyNode to use as outgroup.
* `newbl`:    The new branch length (optional).


**source:**
[Bio/src/phylo/phylogeny.jl:211](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L211)

---

#### Bio.Phylo.PhyExtension{T}
PhyExtension allows defining arbitrary metadata to annotate nodes.

This allows the PhyNode type to support any phylogenetic tree format 
that includes annotations (e.g. PhyloXML, NeXML), and allows programmatic 
extension of nodes with annotations.


**source:**
[Bio/src/phylo/nodes.jl:9](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L9)

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
[Bio/src/phylo/nodes.jl:25](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L25)

---

#### Bio.Phylo.Phylogeny
Phylogeny represents a phylogenetic tree.

A tree can have:

- `name`
- `root`
- `rooted`
- `rerootable`



**source:**
[Bio/src/phylo/phylogeny.jl:11](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L11)

---

#### Bio.Phylo.PhylogenyIterator
PhylogenyIterator is an abstract type that defines a family of iterators
for traversing trees in various ways, including BreadthFirst, and DepthFirst, or from a tip to a root.

**source:**
[Bio/src/phylo/iteration.jl:9](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/iteration.jl#L9)

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
[Bio/src/phylo/nodes.jl:573](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L573)

---

#### blisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the branchlength in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:93](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L93)

---

#### branchlength!(x::Bio.Phylo.PhyNode, bl::Float64)

    func_name(args...) -> (Float64,)

Set the branch length of a PhyNode.

**This method modifies the PhyNode.**

**Parameters:**

* `x`:  The PhyNode to set the branchlength of.

* `bl`: The branch length to give the PhyNode. Either a Float64 value or `nothing`.


**source:**
[Bio/src/phylo/nodes.jl:518](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L518)

---

#### branchlength(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the branch length of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the branch length of.


**source:**
[Bio/src/phylo/nodes.jl:197](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L197)

---

#### call(::Type{Bio.Phylo.BreadthFirst}, x::Bio.Phylo.Phylogeny)
Construct a BreadthFirst iterator for a tree.

**source:**
[Bio/src/phylo/iteration.jl:24](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/iteration.jl#L24)

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
[Bio/src/phylo/phylogeny.jl:34](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L34)

---

#### children(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the children of a node.

**Parameters:**

* `x`: The PhyNode to get children for.


**source:**
[Bio/src/phylo/nodes.jl:297](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L297)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Float64)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.


**source:**
[Bio/src/phylo/nodes.jl:137](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L137)

---

#### confidence!(x::Bio.Phylo.PhyNode, conf::Void)

    func_name(args...) -> (Float64,)

Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.




**source:**
[Bio/src/phylo/nodes.jl:155](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L155)

---

#### confidence(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Float64,)

Get the confidence of the node.

**Parameters:**

* `x`:  The PhyNode to return the confidence of.


**source:**
[Bio/src/phylo/nodes.jl:121](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L121)

---

#### confisknown(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether the confidence in the node is known (i.e. is not -1.0).

**Parameters:**

* `x`:  The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:107](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L107)

---

#### delete!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Delete a node, destroying the relationships between it and its parent, and it and its children. The children of the node become the children of the node's former parent.

Returns the deleted node.

**Parameter:**

* `x`: The PhyNode to delete.


**source:**
[Bio/src/phylo/nodes.jl:712](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L712)

---

#### depth(tree::Bio.Phylo.Phylogeny)
Find the depth of each node from the root.

**Parameters:**

* `tree`: The Phylogeny to measure.


**source:**
[Bio/src/phylo/phylogeny.jl:463](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L463)

---

#### depth(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the number of edges in the shortest path between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`: The first node.
* `n2`: The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:420](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L420)

---

#### descendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the descendents of a node.

**Parameters:**

* `x`: The PhyNode to get the descendents of.



**source:**
[Bio/src/phylo/nodes.jl:437](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L437)

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
[Bio/src/phylo/nodes.jl:736](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L736)

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
[Bio/src/phylo/nodes.jl:736](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L736)

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
[Bio/src/phylo/nodes.jl:736](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L736)

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
[Bio/src/phylo/nodes.jl:736](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L736)

---

#### distance(tree::Bio.Phylo.Phylogeny)
Find the distance of each node from the root.

**Parameters:**
* `tree`: The Phylogeny to measure.


**source:**
[Bio/src/phylo/phylogeny.jl:443](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L443)

---

#### distance(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode)
Find the distance between a node and the root of a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`:   The node.


**source:**
[Bio/src/phylo/phylogeny.jl:432](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L432)

---

#### distance(tree::Bio.Phylo.Phylogeny, n1::Bio.Phylo.PhyNode, n2::Bio.Phylo.PhyNode)
Find the distance between two nodes in a tree.

**Parameters:**
* `tree`: The Phylogeny to search in.
* `n1`:   The first node.
* `n2`:   The second node.


**source:**
[Bio/src/phylo/phylogeny.jl:399](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L399)

---

#### distanceof(x::Bio.Phylo.PhyNode)
Find the distance of a node from its parent. This is different from branch length, because it handles the situation where branch length is unknown. It is only used when the distances between nodes are calculated.

The method is necessary because unknown branch lengths are represented as -1.0.
If all branch lengths are unknown, the tree is a cladogram, and it is still useful to be able to compare relative distances. If individual branch lengths are unknown, they should not affect the calculation of path distances. To satisfy both of these cases, we use machine epsilon as the minimal distance.

**Parameters:**

* `x`: A PhyNode.



**source:**
[Bio/src/phylo/nodes.jl:771](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L771)

---

#### findmidpoint(tree::Bio.Phylo.Phylogeny)
Find the midpoint of a tree.

**Parameters:**
* `tree`: The Phylogeny to find the midpoint of.


**source:**
[Bio/src/phylo/phylogeny.jl:170](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L170)

---

#### furthestfromroot(tree::Bio.Phylo.Phylogeny)
Find the node that is furthest from the root of a tree.

**Parameters:**
* `tree` The Phylogeny to search.


**source:**
[Bio/src/phylo/phylogeny.jl:147](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L147)

---

#### furthestleaf(tree::Bio.Phylo.Phylogeny, node::Bio.Phylo.PhyNode)
Find the leaf that is furthest from a given node in a tree.

  **Parameters:**
  * `tree`: The Phylogeny containing the nodes.
  * `node`: The PhyNode find the furthest node from.


**source:**
[Bio/src/phylo/phylogeny.jl:159](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L159)

---

#### getindex(tree::Bio.Phylo.Phylogeny, name::AbstractString)
Get one node by name.

**Parameters:**
* `tree`:  The Phylogeny to search.
* `names`: The name of the nodes to get.


**source:**
[Bio/src/phylo/phylogeny.jl:344](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L344)

---

#### getindex(tree::Bio.Phylo.Phylogeny, names::Array{AbstractString, 1})
Get one or more nodes by name.

**Parameters:**
* `tree`:  The Phylogeny to search.
* `names`: The names of the nodes to get.


**source:**
[Bio/src/phylo/phylogeny.jl:333](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L333)

---

#### haschild(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is the parent of another specific node.

**Parameters:**

* `parent`: The potential parent PhyNode to test.

* `child`:  The potential child PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:241](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L241)

---

#### isancestral(posanc::Bio.Phylo.PhyNode, nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (Bool,)

Test whether a node is ancesteral to one or more other nodes.

**Parameters:**

* `posanc`: The PhyNode to test.

* `nodes`: An array of `PhyNode`s that the test node must be ancestral to.


**source:**
[Bio/src/phylo/nodes.jl:467](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L467)

---

#### isempty(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is empty.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:169](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L169)

---

#### isempty(x::Bio.Phylo.Phylogeny)
Test whether a phylogeny is empty.

**Parameters:**
* `x`: The Phylogeny to test.


**source:**
[Bio/src/phylo/phylogeny.jl:49](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L49)

---

#### isequal(x::Bio.Phylo.PhyNode, y::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether two PhyNodes are equal. Specifically, test whether all three of `branchlength`, `name` and `extensions` are equal.

**Parameters:**

* `x`: The left PhyNode to compare.

* `y`: The right PhyNode to compare.


**source:**
[Bio/src/phylo/nodes.jl:753](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L753)

---

#### isinternal(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is internal, i.e. has a parent and one or more children.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:376](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L376)

---

#### islinked(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Test whether a node is linked, i.e. has one or more children and/or a parent.
**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:362](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L362)

---

#### isunlinked(x::Bio.Phylo.PhyNode)
Test whether a node is unlinked, i.e. has no children and no parent.

**Parameters:**

* `x`: The PhyNode to test.


**source:**
[Bio/src/phylo/nodes.jl:349](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L349)

---

#### maxindict(dictionary::Dict{K, V})
Find the maximum branch length in a dictionary mapping nodes to their branch lengths.
  
**Parameters:**
* `dict`: The dictionary.


**source:**
[Bio/src/phylo/phylogeny.jl:134](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L134)

---

#### mrca(nodes::Array{Bio.Phylo.PhyNode, 1})

    func_name(args...) -> (PhyNode,)

Get the most recent common ancestor of an array of nodes.

**Parameters:**

* `nodes`:  An array of `PhyNode`s to find the most common ancestor of.


**source:**
[Bio/src/phylo/nodes.jl:482](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L482)

---

#### name!(x::Bio.Phylo.PhyNode, name::AbstractString)

    func_name(args...) -> (Bool,)

Set the name of a PhyNode.

**Parameters:**

* `x`:    The PhyNode to set the name of.

* `name`: The name to give the PhyNode.


**source:**
[Bio/src/phylo/nodes.jl:500](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L500)

---

#### name!(x::Bio.Phylo.Phylogeny, name::AbstractString)
Set the name of a Phylogeny

**Parameters:**

* `x`:    The Phylogeny to set the name of.

* `name`: The name to set.


**source:**
[Bio/src/phylo/phylogeny.jl:62](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L62)

---

#### name(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the name of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the name of.


**source:**
[Bio/src/phylo/nodes.jl:183](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L183)

---

#### parent(x::Bio.Phylo.PhyNode)
Get the parent of a node.

**Parameters:**

* `x`: The PhyNode to get the parent of.


**source:**
[Bio/src/phylo/nodes.jl:324](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L324)

---

#### parent_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Set the parent of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`:  The PhyNode to set as parent.

* `child`:   The PhyNode to set the parent of.


**source:**
[Bio/src/phylo/nodes.jl:554](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L554)

---

#### removechild_unsafe!(parent::Bio.Phylo.PhyNode, child::Bio.Phylo.PhyNode)

Remove a node from the `children` array of another node.

**Warning:** this method is considered unsafe because it does not destroy any two-way link between parent and child. If you want to remove a child from a node, you should use `prune!()`, which does ensure the two-way link is destroyed.

**Parameters:**

* `parent`: 

* `child`:


**source:**
[Bio/src/phylo/nodes.jl:592](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L592)

---

#### removeparent_unsafe!(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (PhyNode,)

Remove the parent of a `PhyNode` (thus setting the parent property to be self-referential).

**Parameters:**

* `x`: The PhyNode to remove the parent of.


**source:**
[Bio/src/phylo/nodes.jl:536](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L536)

---

#### rerootable!(x::Bio.Phylo.Phylogeny, rerootable::Bool)
Set whether a tree is re-rootable.

**Parameters:**
* `x`:          The Phylogeny.
* `rerootable`: Whether the Phylogeny is re-rootable.


**source:**
[Bio/src/phylo/phylogeny.jl:312](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L312)

---

#### root(x::Bio.Phylo.Phylogeny)

    func_name(args...) -> (PhyNode,)
Get the root node of a Phylogeny.

**Parameters:**
* `x`: The Phylogeny to get the root of.


**source:**
[Bio/src/phylo/phylogeny.jl:99](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L99)

---

#### root_unsafe!(tree::Bio.Phylo.Phylogeny, node::Bio.Phylo.PhyNode)
Set the root field of a Phylogeny variable.

**warning** This is different from the other `root!` methods, which rearrange the structure of a Phylogeny, rooting it based on an outgroup or midpoint.
rather, this function simply alters the root field. Generally this should not be used, except as a step in other methods. Careless use of this could result in loosing part of a tree for instance.

**Parameters:**
* `tree`: The phylogeny for which the root is to be set.
* `node`: The PhyNode that is to become the root of the tree.


**source:**
[Bio/src/phylo/phylogeny.jl:513](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L513)

---

#### siblings(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Vector{PhyNode},)

Get the siblings of a node. Included in output is the input node.

**Parameters:**

* `x`: The PhyNode to get siblings for.


**source:**
[Bio/src/phylo/nodes.jl:311](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L311)

---

#### terminaldescendents(x::Bio.Phylo.PhyNode)

    func_name(args...) -> (Bool,)

Get the terminal descendents of a node. i.e. Nodes that are leaves, which have the input node as an ancestor.

**Parameters:**

* `x`: The PhyNode to get ther terminal descendents of.


**source:**
[Bio/src/phylo/nodes.jl:451](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/nodes.jl#L451)

---

#### terminals(x::Bio.Phylo.Phylogeny)
Get the terminal nodes of a phylogeny.

**Parameters:**
* `x`: The Phylogeny.


**source:**
[Bio/src/phylo/phylogeny.jl:322](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L322)

---

#### unroot!(x::Bio.Phylo.Phylogeny)
Unroot a tree.

**Parameters:**
* `x`: The Phylogeny to unroot.


**source:**
[Bio/src/phylo/phylogeny.jl:301](https://github.com/Ward9250/Bio.jl/tree/e3a4bc322041ddfa80456a49e6e6f2d8806df976/src/phylo/phylogeny.jl#L301)


