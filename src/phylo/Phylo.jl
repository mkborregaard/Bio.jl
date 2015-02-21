#==================================#
#  Definition of the Phylo module  #
#==================================#

# Ben J. Ward, 2014.

module Phylo

using Docile
@docstrings(manual = ["../../docs/phylo/phylo.md"])

using Base.Intrinsics

import LightXML

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
include("treeio.jl")

end # module Phylo
