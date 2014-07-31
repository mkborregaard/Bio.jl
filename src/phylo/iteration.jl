#==================================# 
# Iteration and traversal of trees #
#==================================#

# Ben J. Ward, 2014.

abstract PhylogenyIterator

type BreadthFirst <: PhylogenyIterator
    start::PhyNode
    ahead::Queue{Deque{PhyNode}}
    visited::Array{PhyNode}
    BreadthFirst(start::PhyNode) = new(start, Queue(PhyNode), PhyNode[])
end

function BreadthFirst(x::Phylogeny)
  BreadthFirst(x.root)
end

function Base.start(x::BreadthFirst)
  enqueue!(x.ahead, x.start)
  nothing
end

function Base.next(x::BreadthFirst, Nothing)
  current::PhyNode = dequeue!(x.ahead)
  push!(x.visited, current)
  for i in current.children
    if !in(i, x.visited)
      enqueue!(x.ahead, i)
    end
  end
  return current, nothing
end

function Base.done(x::BreadthFirst, Nothing)
  return length(x.ahead) == 0
end


immutable DepthFirst <: PhylogenyIterator
    start::PhyNode
end

function DepthFirst(x::Phylogeny)
  DepthFirst(x.root)
end

immutable Tip2Root <: PhylogenyIterator
    start::PhyNode
end

function Base.start(x::PhyNode)
  if parentisself(x)
    return (1, x.children)
  else
    return (1, [x.children, x.parent])
  end
end

function Base.next(x::PhyNode, state::(Int64, Array{PhyNode, 1}))
  current::PhyNode = state[2][state[1]]
  return current, (state[1] + 1, state[2])
end

function Base.done(x::PhyNode, state::(Int64, Array{PhyNode, 1}))
  return state[1] > length(state[2])
end

function Base.start(x::DepthFirst)
  state = Stack(PhyNode)
  push!(state, x.start)
  return state
end



function Base.start(x::Tip2Root)
  return (x.start, false)
end

function Base.next(x::DepthFirst, state::Stack{Deque{PhyNode}})
  current::PhyNode = pop!(state)
  for i in current.children
    push!(state, i)
  end
  return current, state
end



function Base.next(x::Tip2Root, state::(PhyNode,Bool))
  return state[1], (state[1].parent, isroot(state[1]))
end

function Base.done(x::DepthFirst, state::Stack{Deque{PhyNode}})
  return length(state) == 0
end



function Base.done(x::Tip2Root, state::(PhyNode,Bool))
  return state[2] 
end

function search(it::PhylogenyIterator, condition::Function)
  for i = it
    if condition(i)
      return i
    end
  end
end

function searchall(it::PhylogenyIterator, condition::Function)
  matches::Array{PhyNode, 1} = PhyNode[]
  for i = it
    if condition(i)
      push!(matches, i)
    end
  end
  return matches
end