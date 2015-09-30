
#TODO branch colors given as a PhyNode to colorant dict. Default black. vertical lines divided in two, so they can share color with descendant and be in same context. Line joins between horizontal and vertical lines. Italic speciesnames. More flexible scaling of names and linewidths. Nodelabels with symbols. Edgelabels with e.g. confidence. Radial plot. Names in different context from plot.

function phyplot(phy::Phylogeny; line_width = 0.2, font_size = 1, show_tips = 50, edgecolor::Union(Colorant, Dict{PhyNode, Number}, Dict{PhyNode, Colorant}) = colorant"black") #instead use Nodeannotations!
    x, y, parx, descy, tip = findxy(phy)

    spec = [name(tip) for tip in termdec(phy)]
    spec = spec[length(spec):-1:1]

    specspace = maximum(y) > show_tips ? div(Int(maximum(y)), show_tips) : 1
    showspecs = specspace:specspace:Int(maximum(y))
    xtext = x[tip][showspecs] .* 1.03
    ytext = y[tip][showspecs]
    spec = spec[showspecs]

    if isa(edgecolor, Dict{PhyNode, Number})
        edgecolor = createcolors(edgecolor) #TODO I think there is a function in Colors for this
    end

    if isa(edgecolor, Dict{PhyNode, Colorant})
        horiz_stroke = [edgecolor[node] for node in collect(DepthFirst(phy))]
        vert1_stroke = [edgecolor[children(node)[1]] for node in collect(DepthFirst(phy))[!tip]] #should not be DepthFirst, but an array of the internal nodes, eg setdiff from the tips
        vert2_stroke = [edgecolor[children(node)[end]] for node in collect(DepthFirst(phy))[!tip]]

    elseif isa(edgecolor, Colorant)
        horiz_stroke = vert1_stroke = vert2_stroke = edgecolor
    end

    plotobject = PhyloPlot(x, y, horiz_stroke, vert1_stroke, vert2_stroke, xtext, ytext, ztext, font_size, line_width)

    if (typ == "fan")
        render_phylogram(plotobject)
    elseif (typ == "phylogram")
        render_phylogram(plotobject)
    else
        error("Undefinded type!")
end

@enum nodesym circle=1 square=2 rectangle=3

type NodeFormat{C <: Colorant, S <: AbstractString}
    fill::Nodeannotations{C}
    stroke::Nodeannotations{C}
    strokewidth::Nodeannotations{measure}
    label_above::Nodeannotations{S}
    label_below::Nodeannotations{S}
    symbol::nodesym
    symbol_size::Nodeannotations{Float64}
end

type PhyloPlot {C <: Colorant, S <: AbstractString}
    x::Array{Float64}
    y::Array{Float64} #or is this a Dict? Better, I think
    horiz_stroke::Union(C, AbstractArray{C})
    vert1_stroke::Union(C, AbstractArray{C})
    vert2_stroke::Union(C, AbstractArray{C})
    xtext::Array{Float64}
    ytext::Array{Float64}
    xtext::Array{S}
    font_size::Float64
    line_width::Float64
end


function render_phylogram(x::PhyloPlot)
    horizontal_lines = compose_segments(x, y, parx, y) #now I moved these down but do not have parx and descy - wait for Dict
    vertical_lines1 = compose_segments(x, descy[:,1], x, y)[!tip]
    vertical_lines2 = compose_segments(x, y, x, descy[:,2])[!tip]
# I should also move text down.
    compose(
        context(units = UnitBox(-0.02*maximum(x.x),-3.,maximum(x.x)*1.3, maximum(x.y)*1.1)),
            (context(), line(x.horizontal_lines), stroke(x.horiz_stroke)),
            (context(), line(x.vertical_lines1), stroke(x.vert1_stroke)),
            (context(), line(x.vertical_lines2), stroke(x.vert2_stroke)),
            (context(), text(x.xtext, x.ytext, x.spec), fontsize(x.font_size)),  linewidth(x.line_width)
            )
    x.x, x.y
end

function compose_segments(x1::Float64, y1::Float64, x2::Float64, y2::Float64)
    [(x1[i], y1[i]), (x2[i], y2[i])]
end

function phyplot2(phy::Phylogeny; line_width = 0.2, font_size = 2, show_tips = 30)
    x, y = findxy2(phy)
    horizontal_lines = [compose_segments(x[node], y[node], x[parent(node)], y[node]) for node in keys(x)]
    vertical_lines1 = [compose_segments(x[node], y[children(node)[1]], x[node], y[node]) for node in keys(x)]
    vertical_lines2 = [compose_segments(x[node], y[node], x[node], y[children(node)[end]]) for node in keys(x)]

    specspace = maximum(y) > show_tips ? div(Int(maximum(y)), show_tips) : 1
    showspecs = termdec(phy)[specspace:specspace:Int(maximum(y))]

    spec = map(showspecs) do sp
        x[sp], y[sp], name(sp)
    end

    compose(
        context(units = UnitBox(-0.02*maximum(x),-3.,maximum(x)*1.3, maximum(y)*1.1)),
            (context(), line(horizontal_lines), stroke(colorant"black")),
            (context(), line(vertical_lines1), stroke(colorant"black")),
            (context(), line(vertical_lines2), stroke(colorant"black")),
            (context(), text(spec), fontsize(font_size)),  line_width(linewidth)
        )
    x, y
end


function findxy2(phy::Phylogeny)
    height = [tip => i for (i, tip) in enumerate(termdec(phy))]

    function loc2(clade::PhyNode)
        if !in(clade, height)
            for subclade in children(clade)
                loc2(subclade)
            end
        end
        ch_heigths = [heights[child] for child in children(clade)]
        height[clade] = (maximum(ch_heigths) + minimum(ch_heights)) / 2.
    end

    loc2(phy.root)

    depth = Dict(phy.root => 0)
    for(clade in DepthFirst(phy))
        if !parentisself
            depth[clade] = depth[parent(clade)] + branchlength(clade)
        end
    end

    depth, height
end


function findxy(phy::Phylogeny)
    seen_tips = Vector{Int}(0)
    is_tip = Vector{Bool}(0)
    y_position = Vector{Float64}(0)
    x_position = Vector{Float64}(0)
    parent_xpos = Vector{Float64}(0)
    nodenum = (i = 0; for j in DepthFirst(phy) i += 1 end; i)
    desc_ypos = zeros(nodenum, 2)

    function _loc(node::PhyNode, parentx::Float64)
        xpos =  parentx + branchlength(node, 0.)
        if isleaf(node)
            ypos = sum(seen_tips)
            push!(seen_tips, 1)
            desc_y = [0, 0]
        else
            ys = []
            for daughter in children(node)
                push!(ys, _loc(daughter, xpos))
            end
            desc_y = [ys[1]; ys[end]]
            ypos = mean(desc_y)
        end
        push!(x_position, xpos)
        push!(is_tip, isleaf(node))
        push!(y_position, ypos)
        push!(parent_xpos, parentx)
        desc_ypos[length(y_position), :] = desc_y
        ypos
    end

    _loc(phy.root, 0.)
    x_position, y_position, parent_xpos, desc_ypos, is_tip
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
