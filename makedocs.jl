using Docile, Lexicon, Bio

save("docs/index.md", Bio)
save("docs/phylo.md", Bio.Phylo)

run(`mkdocs build`)
run(`mkdocs build --clean`)
