
#TODO branch colors given as a PhyNode to colorant dict. Default black. vertical lines divided in two, so they can share color with descendant and be in same context. Line joins between horizontal and vertical lines. Italic speciesnames. More flexible scaling of names and linewidths. Nodelabels with symbols. Edgelabels with e.g. confidence. Radial plot. Names in different context from plot.

@enum nodesym circle=1 square=2 rectangle=3
@enum textpos auto=1 alignright=2 alignleft=3 above=4

type NodeFormat{C <: Colorant, S <: AbstractString}
    fill::Nodeannotations{C}
    stroke::Nodeannotations{C}
    strokewidth::Nodeannotations{measure}
    label_above::Nodeannotations{S}
    label_below::Nodeannotations{S}
    symbol::nodesym
    symbol_size::Nodeannotations{Float64}
    align_label_above::textpos
    align_label_below::textpos
end

type EdgeFormat{C <: Colorant}
    line_width::Float64
    line_color::Nodeannotations{C}
end

type TipFormat{C <: Colorant, S <: AbstractString}
    labels::Nodeannotations{S}
    alignment::textpos
    font_size::Float64
    symbol::nodesym
    symbol_stroke::Nodeannotations{C}



type PhyloPlot {C <: Colorant, S <: AbstractString}
    x::Nodeannotations{Float64}
    y::Nodeannotations{Float64} #or is this a Dict? Better, I think
    TipFormat{C, S}
    EdgeFormat{C, S}
    NodeFormat{C, S}
end


function compose_segments(x1::Float64, y1::Float64, x2::Float64, y2::Float64)
    [(x1[i], y1[i]), (x2[i], y2[i])]
end

function phyplot(phy::Phylogeny; edges::EdgeFormat = EdgeFormat(), nodes::NodeFormat = NodeFormat(), tips::TipFormat = TipFormat()) #replace with a kwargs sloop like in GadFly
    x, y = findxy2(phy)
    horizontal_lines = [compose_segments(x[node], y[node], x[parent(node)], y[node]) for node in keys(x)]
    vertical_lines1 = [compose_segments(x[node], y[children(node)[1]], x[node], y[node]) for node in keys(x)]
    vertical_lines2 = [compose_segments(x[node], y[node], x[node], y[children(node)[end]]) for node in keys(x)]

    specspace = maximum(y) > show_tips ? div(Int(maximum(y)), show_tips) : 1
    showspecs = termdec(phy)[specspace:specspace:Int(maximum(y))]

    spec = map(showspecs) do sp
        x[sp], y[sp], name(sp)
    end

#Add the formats here one by one
    compose(
        context(units = UnitBox(-0.02*maximum(x),-3.,maximum(x)*1.3, maximum(y)*1.1)),
            (context(), line(horizontal_lines), stroke(colorant"black")),
            (context(), line(vertical_lines1), stroke(colorant"black")),
            (context(), line(vertical_lines2), stroke(colorant"black")),
            (context(), text(spec), fontsize(tips.font_size)),  linewidth(tips.line_width)
        )
    x, y
end


function findxy(phy::Phylogeny)
    height = [tip => i for (i, tip) in enumerate(termdec(phy))]

    function loc(clade::PhyNode)
        if !in(clade, height)
            for subclade in children(clade)
                loc(subclade)
            end
        end
        ch_heigths = [heights[child] for child in children(clade)]
        height[clade] = (maximum(ch_heigths) + minimum(ch_heights)) / 2.
    end

    loc(phy.root)

    depth = Nodeannotations(phy.root => 0)
    for(clade in DepthFirst(phy))
        if !parentisself
            depth[clade] = depth[parent(clade)] + branchlength(clade)
        end
    end

    depth, height
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
