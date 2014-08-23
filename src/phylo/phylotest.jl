# Testscript for Bio.jl phylo.

a = Bio.PhyNode("A.")
b = Bio.PhyNode("B.")
c = Bio.PhyNode("C.")
d = Bio.PhyNode("D.")
e = Bio.PhyNode("E.")
f = Bio.PhyNode("F.")
g = Bio.PhyNode("G.")
h = Bio.PhyNode("H.")
i = Bio.PhyNode("I.")

Bio.graft!(f, b, c)
Bio.graft!(g, d, e)
Bio.graft!(h, f, g)
Bio.graft!(i, a, h)

tree = Bio.Phylogeny("TestTree", i, false, true)

outgroup = g