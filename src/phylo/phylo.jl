module Phylo

using Base.Intrinsics

import Base: getindex, length, start, next, done 

import DataStructures: Queue, enqueue!, dequeue!, Stack, Queue, Deque
  ## Exported Methods and Types
  export PhyExtension, PhyNode, Phylogeny, getName, getBranchLength,
    isLeaf, hasChildren, parentIsSelf, hasParent, getChildren,
    getSiblings, getParent, isRoot, isNode, setName!,
    setBranchLength!, graft!, prune!, search, searchAll, 
    generateIndex, DepthFirst, BreadthFirst, Tip2Root

  ## Load Package Files
  include(Pkg.dir("Bio", "src", "phylo", "typedefs.jl"))
end
