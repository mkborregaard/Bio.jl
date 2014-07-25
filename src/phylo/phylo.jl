module Phylo

  ## Exported Methods and Types
  export PhyXExtension,
    PhyXElement,
    PhyXTree,
    getLabel,
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
    setLabel!,
    setBranchLength!,
    graft!,
    prune!

  ## Load Package Files
  include(Pkg.dir("Bio", "src", "phylo", "typedefs.jl"))
end
