
module Phylo

using Docile
@docstrings {"../../doc/phylo.md"}

using Base.Intrinsics

import Base: getindex, length, start, next, done, isempty

import DataStructures: Queue, enqueue!, dequeue!, Stack, Queue, Deque

export

  # PhyNode and associated methods
  PhyNode, getname, getbranchlength, isleaf,
  haschildren, parentisself, hasparent, getchildren,
  getsiblings, getparent, isroot, isnode, setname!,
  setbranchlength!, ispreterminal, issemipreterminal,
  getdescendents, getterminaldescendents, countchildren,
  isintree,

  PhyExtension,

  # Phylogeny and associated methods
  Phylogeny, isrooted, isrerootable, root!,
  setrerootable!, graft!, prune!, pruneregraft!, search,
  searchall, generateindex,

  # PhylogenyIterator and associated methods
  PhylogenyIterator, DepthFirst, BreadthFirst, Tip2Root,
  getmrca, hasextensions, getroot, pathbetween

include("nodes.jl")
include("phylogeny.jl")
include("iteration.jl")

end # module Phylo
