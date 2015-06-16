module Align

using Compat
using Docile
using Docile: @doc, @doc_str
using Base.Intrinsics

import Base: convert, getindex, show, length, start, next, done, copy, reverse,
             show, endof, ==

include("operations.jl")
include("anchors.jl")


end