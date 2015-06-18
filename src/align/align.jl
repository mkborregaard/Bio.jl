module Align

using Compat
using Docile
using Docile: @doc, @doc_str
using Base.Intrinsics
using Base.Order: Ordering

import Base: convert, getindex, show, length, start, next, done, copy, reverse,
             show, endof, ==, !=, <, >, <=, >=

import Base.Order: lt

include("operations.jl")
include("anchors.jl")


end