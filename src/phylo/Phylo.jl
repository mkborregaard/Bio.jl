module Phylo

using Base.Intrinsics

import Base: getindex, length, start, next, done 

import DataStructures: Queue, enqueue!, dequeue!, Stack, Queue, Deque
  ## Exported Methods and Types
  export PhyNode, getname, getbranchlength, isleaf, haschildren, 
  parentisself, hasparent, getchildren, getsiblings, getparent, 
  isroot, isnode, setname!, setbranchlength!, ispreterminal, issemipreterminal,
  getdescendents, getterminaldescendents, PhyExtension,  Phylogeny, 
  isrooted, isrerootable, setroot!, setrooted!, setrerootable!,
  graft!, prune!, search, searchall, generateindex, PhylogenyIterator, 
  DepthFirst, BreadthFirst, Tip2Root, getmrca

  ## Load Package Files
  include(Pkg.dir("Bio", "src", "phylo", "typedefs.jl"))
end
