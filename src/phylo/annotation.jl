#========================================================#
# Types and methods for the annotation of nodes of trees #
#========================================================#

# Ben J. Ward 2015.
"""
A type-alias: Dictionaries with keys of type `PhyNode` and values of type `T`
are aliased as Nodeannotations{T}.
"""
typealias Nodeannotations{T} Dict{PhyNode, T}


function getannotations(x::Phylogeny, name::Symbol)
    x.annotations[name]
end

function setannotations!{T}(x::Phylogeny, name::Symbol, ann::Nodeannotations{T})
    filter!((k, v) -> in(k, descendents(x.root)), ann)
    x.annotations[name] = ann #
end

@enum Nodecoverage tipsandnodes=1 tipsonly=2 nodesonly=3

# a version of setannotations that supplies a default value to all nodes
function setannotations!{T}(x::Phylogeny, name::Symbol, ann::Nodeannotations{T}, default::T, cover::Nodecoverage = tipsandnodes)
    if cover == tipsandnodes
        targetnodes = descendents(x.root)
    elseif cover == tipsonly
        targetnodes = terminaldescendants(x.root)
    elseif cover == nodesonly
        targetnodes = setdiff(descendents(x.root), terminaldescendants(x.root))
    end

    filter!((k, v) -> in(k, targetnodes), ann)
    filter!(x -> in(x, keys(ann)), targetnodes)

    for(node in targetnodes)
        ann[node] = default
    end

    x.annotations[name] = ann #
end

# a type assertion to ensure type stability
function getannotations{T}(x::Phylogeny, name::Symbol, ::Type{T})
   if !haskey(x.annotations, name)
       error("no annotation of that name")
   end

   ret = x.annotations[name]
   if !isa(ret, Nodeannotations{T})
       error("$name is of type $(typeof(ret))")
   end
   ret
end


function getindex{T}(x::Phylogeny, name::Symbol, ::Type{T})
    getannotations(x, name, T)
end

function getindex(x::Phylogeny, name::Symbol)
    getannotations(x, name)
end


function setindex!{T}(x::Phylogeny, name::Symbol, annotation::Nodeannotations{T})
    setannotations!(x, name, annotation)
end


function setindex!{T}(x::Phylogeny, name::Symbol, ann::Nodeannotations{T}, default::T, cover::Nodecoverage = tipsandnodes)
    setannotations(x, name, ann, default, cover)
end

# Returns an array with the names of annotations
function annotations(x::Phylogeny)
    collect(keys(x.annotations))
end

# Returns a dict with names and types of annotations
function annotationtypes(x::Phylogeny)
    [k => typeof(collect(values(v))[1]) for (k,v) in x.annotations] #This does not look like an efficient implementation, I am sure there is a better way to do this
end
