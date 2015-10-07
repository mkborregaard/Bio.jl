

include("/Users/michael/src/github.com/julia_packages/Bio.jl/src/phylo/phylo.jl")
using Compose, Colors, Phylo


typealias NodeAnnotations{T} Dict{PhyNode, T}

type TreeAnnotations{T}
    phylogeny::Phylogeny
    annotations::NodeAnnotations{T}
end

function TreeAnnotations{T}(x::Phylogeny, ::Type{T})
    return TreeAnnotations(x, NodeAnnotations{T}())
end

@enum nodesym circle=1 square=2 rect=3
@enum textpos auto=1 alignright=2 alignleft=3 above=4

type NodeFormat{S<:AbstractString}
    fill::NodeAnnotations{Colorant}
    stroke::NodeAnnotations{Colorant}
    strokewidth::NodeAnnotations{Measure}
    label_above::NodeAnnotations{S}
    label_below::NodeAnnotations{S}
    symbol::nodesym
    symbol_size::NodeAnnotations{Float64}
    align_label_above::textpos
    align_label_below::textpos
end

type EdgeFormat
    line_width::Float64
    line_color::NodeAnnotations{Colorant}
end

type TipFormat{S<:AbstractString}
    labels::NodeAnnotations{S}
    alignment::textpos
    font_size::Float64
    symbol::nodesym
    symbol_stroke::NodeAnnotations{Colorant}
end

type PhyloPlot{S<:AbstractString}
    x::NodeAnnotations{Float64}
    y::NodeAnnotations{Float64} #or is this a Dict? Better, I think
    tipformat::TipFormat{S}
    edgeformat::EdgeFormat
    nodeformat::NodeFormat{S}
end

function compose_segments(x1::Float64, y1::Float64, x2::Float64, y2::Float64)
    [(x1, y1), (x2, y2)]
end

function termdec(phy::Phylogeny)
    termdec(phy.root)
end

function termdec(node::PhyNode) #replacements for terminaldescendents which isn't working
    ret = Array{PhyNode, 1}(0)
    for i in DepthFirst(node)
        if isleaf(i)
            push!(ret, i)
        end
    end
    ret
end


##### the one to be edited
function phyplot(phy::Phylogeny; edges::EdgeFormat = EdgeFormat(), nodes::NodeFormat = NodeFormat(), tips::TipFormat = TipFormat()) #replace with a kwargs sloop like in GadFly
    x, y = findxy(phy)
    internals = setdiff(keys(x), termdec(phy))
    horizontal_lines = [compose_segments(x[node], y[node], x[parent(node)], y[node]) for node in keys(x)]
    vertical_lines1 = [compose_segments(x[node], y[children(node)[1]], x[node], y[node]) for node in internals]
    vertical_lines2 = [compose_segments(x[node], y[node], x[node], y[children(node)[end]]) for node in internals]

    specspace = maximum(values(y)) > show_tips ? div(Int(maximum(values(y))), show_tips) : 1
    showspecs = termdec(phy)[specspace:specspace:Int(maximum(values(y)))]

    xtext = [x[sp] * 1.02 for sp in showspecs]
    ytext = [y[sp] for sp in showspecs]
    namestext = [name(sp) for sp in showspecs]


#Add the formats here one by one
    compose(
        context(units = UnitBox(-0.02*maximum(values(x)),-3.,maximum(values(x))*1.3, maximum(values(y))*1.1)),
            (context(), line(horizontal_lines), stroke(colorant"black")),
            (context(), line(vertical_lines1), stroke(colorant"black")),
            (context(), line(vertical_lines2), stroke(colorant"black")),
    (context(), text(xtext, ytext, namestext), fontsize(tips.font_size)),  linewidth(tips.line_width)
        )
    x, y
end

function findxy(phy::Phylogeny)
    height = [tip => float(i) for (i, tip) in enumerate(termdec(phy))]

    function loc(clade::PhyNode)
        if !in(clade, keys(height))
            for subclade in children(clade)
                loc(subclade)
            end
        end
        if !isleaf(clade)
            ch_heights = [height[child] for child in children(clade)]
            height[clade] = (maximum(ch_heights) + minimum(ch_heights)) / 2.
        end
    end

    loc(phy.root)

    depth = NodeAnnotations{Float64}(phy.root => 0)
    for(clade in DepthFirst(phy))
        if !parentisself(clade)
            depth[clade] = depth[parent(clade)] + branchlength(clade)
        end
    end

    depth, height
end


###############################

phy, annot = readnewick("/Users/michael/test.tree")

    height = [tip => float(i) for (i, tip) in enumerate(termdec(phy))]

    function loc(clade::PhyNode)
        if !in(clade, keys(height))
            for subclade in children(clade)
                loc(subclade)
            end
        end
        if !isleaf(clade)
            ch_heights = [height[child] for child in children(clade)]
            height[clade] = (maximum(ch_heights) + minimum(ch_heights)) / 2.
        end
    end

    loc(phy.root)

    depth = NodeAnnotations{Float64}(phy.root => 0)
    for(clade in DepthFirst(phy))
        if !parentisself(clade)
            depth[clade] = depth[parent(clade)] + branchlength(clade)
        end
    end

setdiff(keys(height), keys(depth))

show_tips = 126
x, y = findxy(phy)
internals = setdiff(keys(x), termdec(phy)) #probably need to package a color vector with each as well
horizontal_lines = [compose_segments(x[node], y[node], x[parent(node)], y[node]) for node in keys(x)]
vertical_lines1 = [compose_segments(x[node], y[children(node)[1]], x[node], y[node]) for node in internals]
vertical_lines2 = [compose_segments(x[node], y[node], x[node], y[children(node)[end]]) for node in internals]

specspace = maximum(values(y)) > show_tips ? div(Int(maximum(values(y))), show_tips) : 1
showspecs = termdec(phy)[specspace:specspace:Int(maximum(values(y)))]

xtext = [x[sp] * 1.02 for sp in showspecs]
ytext = [y[sp] for sp in showspecs]
namestext = [name(sp) for sp in showspecs]


#Add the formats here one by one
compose(
    context(units = UnitBox(-0.02*maximum(values(x)),-3.,maximum(values(x))*1.3, maximum(values(y))*1.1)),
        (context(), line(horizontal_lines), stroke(colorant"black")),
        (context(), line(vertical_lines1), stroke(colorant"black")),
        (context(), line(vertical_lines2), stroke(colorant"black")),
    (context(), text(xtext, ytext, namestext), fontsize(1.)),  linewidth(0.2)
    )







#### Functions for fan plot


function anglefrompoint(point::Tuple{Number, Number})
    point[2] >= 0 ? acos(point[1]) : pi + acos(-point[1])
end

function beziercurve(start::Tuple{Number, Number}, angle::Number, center::Tuple{Number, Number})
    pt = start[1] - center[1], start[2] - center[2]
    ret = beziercurve(pt, angle)
    [(pt[1] + center[1], pt[2] + center[2]) for pt in ret]
end

function beziercurve(start::Tuple{Number, Number}, angle::Number)
    r = sqrt(start[1]^2 + start[2]^2)
    start = start[1]/r, start[2]/r
    arc = beziercurve(angle)
    ret = [rotatepoint(pt, anglefrompoint(start)) for pt in arc]
    [(r*pt[1], r*pt[2]) for pt in ret]
end

function beziercurve(angle::Number)
    L  = 4//3*tan(angle/4.)
    p1 = 1., 0.
    p2 = 1., L
    p3 = cos(angle) + L*sin(angle), sin(angle) - L*cos(angle)
    p4 = cos(angle), sin(angle)
    [p1, p2, p3, p4]
end

function rotatepoint(point::Tuple{Number, Number}, angle::Number)
    point[1]*cos(angle) - point[2]*sin(angle), point[1]*sin(angle) + point[2]*cos(angle)
end

function pointcoords(angle::Float64, radius::Float64 = 1.)
    radius*sin(angle), radius*cos(angle)
end

circval = 2pi/(1 + maximum(values(y)))
radval = 1 / maximum(values(x))

function normpoint(pt::Tuple{Float64, Float64})
    pointcoords(pt[2] * circval, pt[1] * radval)
end

function normpoint(ar::Array{Tuple{Float64, Float64},1})
    [normpoint(x) for x in ar]
end

elements = Any[]

for lin in vertical_lines1
    bez = beziercurve(normpoint(lin[1]), (lin[1][2] - lin[2][2]) * circval)
    push!(elements, compose(context(),curve(bez...), stroke(colorant"black")))
end

for lin in vertical_lines2
    bez = beziercurve(normpoint(lin[1]), (lin[1][2] - lin[2][2]) * circval)
    push!(elements, compose(context(),curve(bez...), stroke(colorant"black")))
end

rad = [normpoint(x) for x in horizontal_lines]
push!(elements, compose(context(),line(rad), stroke(colorant"black")))


haligns = Compose.HAlignment[]
valigns = Compose.VAlignment[]
txts = UTF8String[]
rots = Rotation[]
pointx = Float64[]
pointy = Float64[]

for tip in termdec(phy)
    point = normpoint((1.03*depth[tip], height[tip]))
    push!(pointx, point[1])
    push!(pointy, point[2])
    push!(valigns, Compose.VCenter())
    push!(haligns, point[1] < 0 ? Compose.HRight() : Compose.HLeft())
    push!(txts, tip.name)
    rot = point[1] < 0 ?  pi + pi/2. - height[tip]*circval : pi/2. - height[tip]*circval
    push!(rots, Rotation(rot, point))
end

compose(context(0,0,h > w ? w : h, h > w ? w : h, units = UnitBox(-1.6, -1.6, 3.2, 3.2)), 
    elements...,
    text(pointx, pointy, txts, haligns, valigns, rots),
    fontsize(4pt)
)
