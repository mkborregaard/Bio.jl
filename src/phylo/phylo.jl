type PhyXExtension{T}
  value::T
end

type PhyXElement
  Label::String
  Root::Bool
  Tip::Bool
  Extensions::Array{PhyXExtension}
  Parent::PhyXElement
  Children::Array{PhyXElement}

  PhyXElement(label::String, root::Bool, tip::Bool, ext::Array{PhyXExtension, 1}) = new(label, root, tip, ext)
end

function PhyXElement(label::String, root::Bool, tip::Bool, ext::Array{PhyXExtension, 1}, parent::PhyXElement)
  x = PhyXElement(label, root, tip, ext)
  x.Parent = parent
  return x
end

type PhyXTree
  Name::String
  Root::PhyXElement
  Rooted::Bool
  Rerootable::Bool
end
