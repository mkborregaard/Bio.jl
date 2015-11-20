#=================================================================#
# Representing and manipulating phylogenies using connected nodes #
#=================================================================#

# Phylogeny Node Type
# --------------------

"""
PhyNode represents a node in a phylogenetic tree.

A node can have:

- `name`
- `branchlength`
- a reference to its `parent` PhyNode
- reference to one or more `children`
"""
type PhyNode
    name::String
    branchlength::Nullable{Float64}
    confidence::Nullable{Float64}
    children::Vector{PhyNode}
    parent::PhyNode
    """
    Create a PhyNode.
    PhyNodes represent nodes in a phylogenetic tree. All arguments are optional
    when creating PhyNodes:

    **Example:**
    one = PhyNode()
    two = PhyNode(name = "two", branchlength = 1.0, parent = one)

    **Parameters:**
    * `name`:         The name of the node (optional). Defaults to an empty string, indicating
                      the node has no name.

    * `branchlength`: The branch length of the node from its parent (optional).
                      Because branch lengths can be not applicable (cladograms), or not known.
                      The value is Nullable, and is null by default.

    * `confidence`:   A Nullable Floating point value that can represent confidence for that clade (optional).
                      Such confidences are usually Maximum Likelihood values or Bootstrap
                      values.

    * `children`:     A Vector containing references to the PhyNodes that are children of this node (optional).
                      Default to an empty vector.

    * `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                      the node has no parent.
"""
    function PhyNode(name::String = "",
                     branchlength::Nullable{Float64} = Nullable{Float64}(),
                     confidence::Nullable{Float64} = Nullable{Float64}(),
                     children::Vector{PhyNode} = PhyNode[],
                     parent = nothing)
        x = new()
        name!(x, name)
        branchlength!(x, branchlength)
        confidence!(x, confidence)
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
end


"""
Create a PhyNode.
PhyNodes represent nodes in a phylogenetic tree. All arguments are optional
when creating PhyNodes:

**Example:**
one = PhyNode()
two = PhyNode(name = "two", branchlength = 1.0, parent = one)

**Parameters:**
* `name`:         The name of the node (optional). Defaults to an empty string, indicating
                  the node has no name.

* `branchlength`: A floating point value representing the branch length of the
                  node from its parent (optional). Because branch lengths can be
                  not applicable (cladograms), or not known.
                  The value is Nullable, and is null by default.
                  If it is negative, it will be treated as NA or unknown (null).

* `confidence`:   Floating point value that can represent confidence for that clade (optional).
                  Such confidences are usually Maximum Likelihood values or Bootstrap
                  values. If it is negative, it will be treated as NA or unknown (null).

* `children`:     A Vector containing references to the PhyNodes that are children of this node (optional).
                  Default to an empty vector.

* `parent`:       The parent node (optional). Defaults to a self-reference, indicating
                  the node has no parent.
"""
function PhyNode(name::String = "",
                 branchlength::Float64 = -1.0,
                 confidence::Float64 = -1.0,
                 children::Vector{PhyNode} = PhyNode[],
                 parent = nothing)

    bl = branchlength < 0 ? Nullable{Float64}() : Nullable{Float64}(branchlength)
    conf = confidence < 0 ? Nullable{Float64}() : Nullable{Float64}(confidence)

    return PhyNode(name, bl, conf, children, parent)
end



# Basic methods, accessing and manipulating fields of individual nodes
#----------------------------------------------------------------------

"""
Basic show method for a PhyNode.
"""
function Base.show(io::IO, n::PhyNode)
    if isempty(n.children)
        print(io, n.name)
    else
        print(io, "(")
        print(io, join(map(string, n.children), ","))
        print(io, ")")
    end
end


"""
Get the name of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the name of.
"""
function name(x::PhyNode)
    return x.name
end


"""
Set the name of a PhyNode.

**Parameters:**

* `x`:    The PhyNode to set the name of.

* `name`: The name to give the PhyNode.
"""
function name!(x::PhyNode, name::String)
    x.name = name
end


"""
Test whether the branchlength in the node is known (i.e. is not Null).

**Parameters:**

* `x`:  The PhyNode to test.
"""
function blisknown(x::PhyNode)
    return !isnull(x.branchlength)
end


"""
Get the branch length of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the branch length of.
* `replace_unknown`: The value to return if the branchlength is null.
"""
function branchlength(x::PhyNode, replace_unknown::Float64)
    return get(x.branchlength, replace_unknown)
end


"""
Get the branch length of a PhyNode.

**Parameters:**

* `x`: The PhyNode to get the branch length of.
"""
function branchlength(x::PhyNode)
    return get(x.branchlength)
end


"""
Set the branch length of a PhyNode.

**Parameters:**

* `x`:  The PhyNode to set the branchlength of.

* `bl`: The branch length to give the PhyNode, as a Float64 value.
"""
function branchlength!(x::PhyNode, bl::Float64)
    x.branchlength = Nullable{Float64}(bl)
end


"""
Set the branchlength of a PhyNode.

**Parameters:**

* `x`:  The PhyNode to set the branchlength of.

* `bl`: The branch length to give the PhyNode, as a Nullable{Float64}.
"""
function branchlength!(x::PhyNode, bl::Nullable{Float64})
    x.branchlength = bl
end


"""
Set the branchlength of a PhyNode.

**Parameters:**

* `x`:  The PhyNode to the set the branchlength of.

* `bl`: The branchlength to give the PhyNode, in this case nothing.
"""
function branchlength!(x::PhyNode, bl::Nothing)
    x.branchlength = Nullable{Float64}()
end


"""
Set the branchlength of a PhyNode.

**Parameters:**

* `x`:  The PhyNode to the set the branchlength of.

In this case, since no other value is provided, the branchlength is set as null.
"""
function branchlength!(x::PhyNode)
    x.branchlength = Nullable{Float64}()
end


"""
Test whether the confidence in the node is known (i.e. is not Null).

**Parameters:**

* `x`:  The PhyNode to test.
"""
function confisknown(x::PhyNode)
    return !isnull(x.confidence)
end


"""
Get the confidence of the node.

**Parameters:**

* `x`:  The PhyNode to return the confidence of.
* `replace_unknown`: The value to return if the confidence is null.
"""
function confidence(x::PhyNode, replace_unknown::Float64)
    return get(x.confidence, replace_unknown)
end


"""
Get the confidence of the node.

**Parameters:**

* `x`:  The PhyNode to return the confidence of.
"""
function confidence(x::PhyNode)
    return get(x.confidence)
end


"""
Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.

* `conf`: The value of the confidence to be set.
"""
function confidence!(x::PhyNode, conf::Float64)
    x.confidence = Nullable{Float64}(conf)
end


"""
Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.
* `conf`: The value of the confidence to be set.
"""
function confidence!(x::PhyNode, conf::Float64)
    x.confidence = Nullable{Float64}(conf)
end


"""
Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.
* `conf`: The value of the confidence to be set.
"""
function confidence!(x::PhyNode, conf::Nullable{Float64})
    x.confidence = conf
end


"""
Set the confidence of the node.

**Parameters:**

* `x`:    The PhyNode to set the confidence of.
* `conf`: The value of the confidence to set. In this case nothing / na / null.
"""
function confidence!(x::PhyNode, conf::Nothing)
    x.confidence = Nullable{Float64}()
end


"""
Set the confidence of the node.

**Parameters:**

* `x`: The PhyNode to set the confidence of.

In this method, since there is no second argument for the confidence value provided.
The confidence value is set to null.
"""
function confidence!(x::PhyNode)
    x.confidence = Nullable{Float64}()
end


"""
Get the children of a node.

**Parameters:**

* `x`: The PhyNode to get children for.
"""
function children(x::PhyNode)
    return x.children
end


"""
Add a node to the `children` array of another node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.

"""
function addchild_unsafe!(parent::PhyNode, child::PhyNode)
    if haschild(parent, child)
        error("The child node is already a child of the parent.")
    end
    push!(parent.children, child)
end


"""
Remove a node from the `children` array of another node.

**Warning:** this method is considered unsafe because it does not destroy any two-way link between parent and child. If you want to remove a child from a node, you should use `prune!()`, which does ensure the two-way link is destroyed.

**Parameters:**

* `parent`:

* `child`:
"""
function removechild_unsafe!(parent::PhyNode, child::PhyNode)
    filter!(x -> !(x === child), parent.children)
end


"""
Get the parent of a node.

**Parameters:**

* `x`: The PhyNode to get the parent of.
"""
function parent(x::PhyNode)
    if parentisself(x)
        warn("Node does not have a parent. It is self referential.")
    end
    return x.parent
end


"""
Remove the parent of a `PhyNode` (thus setting the parent property to be self-referential).

**Parameters:**

* `x`: The PhyNode to remove the parent of.
"""
function parent_unsafe!(x::PhyNode)
    x.parent = x
end


"""
Set the parent of a node.

**Warning:** this method is considered unsafe because it does not build the two-way link between parent and child. If you want to add a child to a node, you should use `graft!()`, which does ensure the two-way link is built.

**Parameters:**

* `parent`:  The PhyNode to set as parent.

* `child`:   The PhyNode to set the parent of.
"""
function parent_unsafe!(parent::PhyNode, child::PhyNode)
    child.parent = parent
end



# Methods that test nodes for various charateristics
#----------------------------------------------------

"""
Test whether a node is empty.

**Parameters:**

* `x`: The PhyNode to test.
"""
function isempty(x::PhyNode)
    return x.name == "" && isnull(x.branchlength) && !haschildren(x) && parentisself(x) && isnull(x.confidence)
end


"""
Test whether a node is a leaf.

**Parameters:**

* `x`: The PhyNode to test.
"""
function isleaf(x::PhyNode)
    return hasparent(x) && !haschildren(x)
end


"""
Test whether a node has children.

**Parameters:**

* `x`: The PhyNode to test.
"""
function haschildren(x::PhyNode)
    return length(x.children) > 0
end


"""
Test whether a node is the parent of another specific node.

**Parameters:**

* `parent`: The potential parent PhyNode to test.

* `child`:  The potential child PhyNode to test.
"""
function haschild(parent::PhyNode, child::PhyNode)
    return in(child, parent.children)
end


"""
Test whether a node is its own parent. See PhyNode().

**Parameters:**

* `x`: The PhyNode to test.
"""
function parentisself(x::PhyNode)
    return x.parent === x
end


"""
Test whether a node has a parent.

**Parameters:**

* `x`: The PhyNode to test.
"""
function hasparent(x::PhyNode)
    return !parentisself(x)
end


"""
Test whether a node is the root node.

**Parameters:**

* `x`: The PhyNode to test.
"""
function isroot(x::PhyNode)
    return parentisself(x) && haschildren(x)
end


"""
Test whether a node is unlinked, i.e. has no children and no parent.

**Parameters:**

* `x`: The PhyNode to test.
"""
function isunlinked(x::PhyNode)
    return parentisself(x) && !haschildren(x)
end


"""
Test whether a node is linked, i.e. has one or more children and/or a parent.
**Parameters:**

* `x`: The PhyNode to test.
"""
function islinked(x::PhyNode)
    return hasparent(x) || haschildren(x)
end


"""
Test whether a node is internal, i.e. has a parent and one or more children.

**Parameters:**

* `x`: The PhyNode to test.
"""
function isinternal(x::PhyNode)
    return hasparent(x) && haschildren(x)
end


"""
Test whether a node is preterminal i.e. It's children are all leaves.

**Parameters:**

* `x`: The PhyNode to test.
"""
function ispreterminal(x::PhyNode)
    if isleaf(x)
        return false
    end
    return all([isleaf(i) for i in x.children])
end


"""
Test whether a node is semi-preterminal i.e. Some of it's children are leaves, but not all are.

**Parameters:**

* `x`: The PhyNode to test.
"""
function issemipreterminal(x::PhyNode)
    areleaves = [isleaf(i) for i in x.children]
    return any(areleaves) && !all(areleaves)
end


"""
Test whether a node is ancesteral to one or more other nodes.

**Parameters:**

* `posanc`: The PhyNode to test.

* `nodes`: An array of `PhyNode`s that the test node must be ancestral to.
"""
function isancestral(posanc::PhyNode, nodes::Vector{PhyNode})
    desc = descendants(posanc)
    return all([in(node, desc) for node in nodes])
end


"""
Test whether two PhyNodes are equal. Implemented by testing for identity

**Parameters:**

* `x`: The left PhyNode to compare.

* `y`: The right PhyNode to compare.
"""
function isequal(x::PhyNode, y::PhyNode)
    return is(x, y)
end



# Advanced calculations and manipulation of nodes,
# including safe pruning and regrafting
#--------------------------------------------------

"""
Count the number of children of a node.

**Parameters:**

* `x`: The PhyNode to count the children of.
"""
function countchildren(x::PhyNode)
    return length(x.children)
end


"""
Get the siblings of a node. Included in output is the input node.

**Parameters:**

* `x`: The PhyNode to get siblings for.
"""
function siblings(x::PhyNode)
    if hasparent(x)
        return filter(y -> !(y === x), x.parent.children)
    end
end


"""
Get the descendants of a node.

**Parameters:**

* `x`: The PhyNode to get the descendants of.

"""
function descendants(x::PhyNode)
    if haschildren(x)
        return collect(PhyNode, DepthFirst(x))
    else
        return PhyNode[]
    end
end


"""
Get the terminal descendants of a node. i.e. Nodes that are leaves, which have the input node as an ancestor.

**Parameters:**

* `x`: The PhyNode to get ther terminal descendants of.
"""
function terminaldescendants(x::PhyNode)
    return searchall(DepthFirst(x), isleaf)
end


"""
Get the most recent common ancestor of an array of nodes.

**Parameters:**

* `nodes`:  An array of `PhyNode`s to find the most common ancestor of.
"""
function mrca(nodes::Vector{PhyNode})
    paths = [collect(Tip2Root(i)) for i in nodes]
    convergence = intersect(paths...)
    return convergence[1]
end


"""
Graft a node onto another node, create a parent-child relationship between them.

**Parameters:**

* `parent`: The PhyNode to add a child to.

* `child`:  The PhyNode to add as a child.
"""
function graft!(parent::PhyNode, child::PhyNode)
    if hasparent(child)
        error("This node is already attached to a parent.")
    end
    parent_unsafe!(parent, child)
    addchild_unsafe!(parent, child)
end


"""
Graft a node onto another node, create a parent-child relationship between them, and associatiing a branch length with the relationship.

**Parameters:**

* `parent`:       The PhyNode to add a child to.

* `child`:        The PhyNode to add as a child.

* `branchlength`: The branch length between parent and child.

"""
function graft!(parent::PhyNode, child::PhyNode, branchlength::Float64)
    graft!(parent, child)
    branchlength!(child, branchlength)
end


"""
Graft one or more nodes onto another node, create a parent-child relationship between each of the grafted nodes and the node they are grafted onto.

**Parameters:**

* `parent`:   The PhyNode to add a child to.

* `children`: The array of PhyNodes to add as a child.
"""
function graft!(parent::PhyNode, children::Vector{PhyNode})
    for i in children
        graft!(parent, i)
    end
end


"""
Destroy the relationship between a PhyNode `x` and its parent, returning the PhyNode.

This method cleanly removes the PhyNode `x` from its parent's `children` array, and removes the `parent` reference from the PhyNode `x`. All other fields of the `child` are left intact.

**Parameters:**

* `x`: The PhyNode prune from its parent.
"""
function prune!(x::PhyNode)
    if hasparent(x)
        removechild_unsafe!(x.parent, x)
        parent_unsafe!(x)
    else
        warn("Can't prune this node from its parent, no parent exists for the node.")
    end
    return x
end


"""
Prune a PhyNode from its parent and graft it to another parent.

**Parameters:**

* `prune`:    The PhyNode to remove from its parent.

* `graftto`:  The PhyNode to become the new parent of `prune`.
"""
function pruneregraft!(prune::PhyNode, graftto::PhyNode)
    x = prune!(prune)
    graft!(graftto, x)
end


"""
Prune a PhyNode from its parent and graft it to another parent, setting the branch length.

**Parameters:**

* `prune`:        The PhyNode to remove from its parent.

* `graftto`:      The PhyNode to become the new parent of `prune`.

* `branchlength`: The branch length.
"""
function pruneregraft!(prune::PhyNode, graftto::PhyNode, branchlength::Float64)
    x = prune!(prune)
    graft!(graftto, x, branchlength)
end


"""
Delete a node, destroying the relationships between it and its parent, and it and its children. The children of the node become the children of the node's former parent.

Returns the deleted node.

**Parameter:**

* `x`: The PhyNode to delete.
"""
function delete!(x::PhyNode)
    deleted = prune!(x)
    graft!(parent(deleted), children(deleted))
    return deleted
end


"""
Detach a subtree at a given node.

Returns a new Phylogeny with the detached node as root.

**Parameters:**

* `x`:          The PhyNode to detach.

* `name`:       The name of the new Phylogeny.

* `rooted`:     Whether the detached subtree is rooted.

* `rerootable`: Whether the detached subtree is rerootable.
"""
function detach!(x::PhyNode, name::String = "", rooted::Bool = true, rerootable::Bool = true)
    detached = prune!(x)
    return Phylogeny(name, detached, rooted, rerootable)
end
