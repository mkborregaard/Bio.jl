#========================================================#
# Types and methods for the annotation of nodes of trees #
#========================================================#

# Ben J. Ward 2015.

typealias NodeAnnotations{T} Dict{PhyNode, T}

type TreeAnnotations{T}
  x::Phylogeny
  annotations::NodeAnnotations{T}
end

function TreeAnnotations{T}(x::PhyNode)
  return TreeAnnotations(x, NodeAnnotations{T}())
end

function Base.getindex{T}(x::TreeAnnotations{T}, index::PhyNode)
  return x.annotations[index]
end

function Base.setindex!{T}(x::TreeAnnotations{T}, item::T, clade::PhyNode)
  x.annotations[clade] = item
end