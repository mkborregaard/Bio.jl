module Bio

abstract AbstractParser
abstract FileFormat

include("StringFields.jl")
include("Ragel.jl")
include("seq/Seq.jl")
include("intervals/Intervals.jl")
include("align/Align.jl")
include("annotations.jl")
include("tools/tools.jl")
include("phylo/Phylo.jl")

using .Phylo

end
