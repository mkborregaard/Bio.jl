#==================================#
#  Definition of the Phylo module  #
#==================================#

# Ben J. Ward, 2014.

module Phylo

using Docile
#@docstrings(manual = ["../../docs/phylo/phylo.md"])

using Base.Intrinsics

using LightXML: XMLElement, get_elements_by_tagname, attribute

import Base: getindex, setindex!, length, start, next, done, isempty, isequal, parent, delete!, search

import DataStructures: Queue, enqueue!, dequeue!, Stack, Queue, Deque

export

  # PhyNode and associated methods
  PhyNode, getname, getbranchlength, isleaf,
  haschildren, parentisself, hasparent, getchildren,
  getsiblings, getparent, isroot, isnode, setname!,
  setbranchlength!, ispreterminal, issemipreterminal,
  getdescendents, getterminaldescendents, countchildren,
  isintree,

  # Phylogeny and associated methods
  Phylogeny, isrooted, isrerootable, root!,
  setrerootable!, graft!, prune!, pruneregraft!, search,
  searchall, generateindex,

  # PhylogenyIterator and associated methods
  PhylogenyIterator, DepthFirst, BreadthFirst, Tip2Root,
  getmrca, hasextensions, getroot, pathbetween

include("nodes.jl")
include("phylogeny.jl")
include("treeio.jl")
include("iteration.jl")
include("annotation.jl")

end # module Phylo
