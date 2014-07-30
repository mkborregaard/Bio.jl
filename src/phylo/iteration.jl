#==================================# 
# Iteration and traversal of trees #
#==================================#

# Ben J. Ward, 2014.

abstract PhylogenyIterator

immutable DepthFirst <: PhylogenyIterator
    start::PhyNode
end

function DepthFirst(x::Phylogeny)
  DepthFirst(x.root)
end

immutable BreadthFirst <: PhylogenyIterator
    start::PhyNode
end

function BreadthFirst(x::Phylogeny)
  BreadthFirst(x.root)
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

function Base.start(x::BreadthFirst)
  state = Queue(PhyNode)
  enqueue!(state, x.start)
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

function Base.next(x::BreadthFirst, state::Queue{Deque{PhyNode}})
  current::PhyNode = dequeue!(state)
  for i in current.children
    enqueue!(state, i)
  end
  return current, state
end

function Base.next(x::Tip2Root, state::(PhyNode,Bool))
  return state[1], (state[1].parent, isroot(state[1]))
end

function Base.done(x::DepthFirst, state::Stack{Deque{PhyNode}})
  return length(state) == 0 ? true : false
end

function Base.done(x::BreadthFirst, state::Queue{Deque{PhyNode}})
  return length(state) == 0 ? true : false
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