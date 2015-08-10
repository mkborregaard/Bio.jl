
immutable CIGAR
    OP::Operation
    Size::Int
end

function CIGAR(op::Char, size::Int)
    return CIGAR(Operation(op), size)
end

function convert(::Type{String}, cigar::CIGAR)
    return "$(cigar.Size)$(Char(cigar.OP))"
end

function show(io::IO, cigar::CIGAR)
    write(io, convert(String, cigar))
end

typealias CIGARString Vector{CIGAR}

function convert(::Type{CIGARString}, str::String)
    matches = matchall(r"(\d+)(\w)", str)
    cigarString = Vector{CIGAR}(length(matches))
    @inbounds for i in 1:length(matches)
        m = matches[i]
        cigarString[i] = CIGAR(m[end], parse(Int, m[1:end-1]))
    end
    return cigarString
end

macro cigar_str(str)
    return CIGARString(str)
end

function convert(::Type{String}, cigar::CIGARString)
    outString = ""
    for op in cigar
        outString *= "$(op.Size)$(Char(op.OP))"
    end
    return outString
end

function show(io::IO, cigarstr::CIGARString)
    write(io, convert(String, cigarstr))
end
