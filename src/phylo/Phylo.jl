module Phylo
  import DataStructures: Queue, enqueue!, dequeue!, Stack
  ## Exported Methods and Types
  export PhyExtension,
    PhyNode,
    Phylogeny,
    getName,
    getBranchLength,
    isLeaf,
    hasChildren,
    parentIsSelf,
    hasParent,
    getChildren,
    getSiblings,
    getParent,
    isRoot,
    isNode,
    setName!,
    setBranchLength!,
    graft!,
    prune!,
    search,
    searchAll,
    TreeTraverser,
    TraverserDF,
    TraverserBF,
    next!,
    getCurrent,
    upNext,
    getHistory,
    hasReachedEnd,
    generateIndex


  ## Load Package Files
  include(Pkg.dir("Bio", "src", "phylo", "typedefs.jl"))
end
