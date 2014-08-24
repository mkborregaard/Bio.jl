# Testscript for Bio.jl phylo.

a = Bio.PhyNode("A.", 0.1)
b = Bio.PhyNode("B.", 0.2)
c = Bio.PhyNode("C.", 0.3)
d = Bio.PhyNode("D.", 0.4)
e = Bio.PhyNode("E.", 0.5)
f = Bio.PhyNode("F.", 0.6)
g = Bio.PhyNode("G.", 0.7)
h = Bio.PhyNode("H.", 0.8)
i = Bio.PhyNode("I.")

Bio.graft!(f, b, c)
Bio.graft!(g, d, e)
Bio.graft!(h, f, g)
Bio.graft!(i, a, h)

tree = Bio.Phylogeny("TestTree", i, false, true)

outgroup = g

Bio.root!(tree, g)