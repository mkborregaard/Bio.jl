#==================================#
# Iteration and traversal of trees #
#==================================#

# Ben J. Ward, 2014.

@Docile.doc """
`PhylogenyIterator` is an abstract type that defines a family of iterators
for traversing trees in various ways, including `BreadthFirst`, and `DepthFirst`,
or from a tip to a root.
""" ->
abstract PhylogenyIterator

@Docile.doc """
A type for implementing breadth-first traversal of any 
`Phylogeny`.

A `BreathFirst` phylogeny iterator contains:

- A `PhyNode` that the iterator will `start` at.
""" ->
immutable BreadthFirst <: PhylogenyIterator
  start::PhyNode
  function BreadthFirst(start::PhyNode)
    if isempty(start)
      error("Node provided to start iteration is empty!")
    end
    return new(start)
  end
end

typealias BreadthFirstState Queue{Deque{PhyNode}} 

@Docile.doc """
Construct a BreadthFirst iterator for a tree.

**Parameters**
* `x`: A Phylogeny variable you want to traverse in breadth-first order. 
""" ->
function BreadthFirst(x::Phylogeny)
  return BreadthFirst(x.root)
end

@Docile.doc """
Start iterating through a `Phylogeny` with a `BreadthFirst` iterator.

**Parameters**
* `x`: A `BreadthFirst` iterator to start iterating with.
""" ->
function Base.start(x::BreadthFirst)
  state::BreadthFirstState = Queue(PhyNode)
  enqueue!(state, x.start)
  return state
end

@Docile.doc """
Step to the next node when iterating over a `Phylogeny`.

**Parameters:**
* `x`: `Breadthfirst` iterator.
* `state`: A `Queue` that contains the next nodes to be iterated over.
""" ->
function Base.next(x::BreadthFirst, state::BreadthFirstState)
  current::PhyNode = dequeue!(state)
  for i in current.children
    enqueue!(state, i)
  end
  return current, state
end

@Docile.doc """
Check whether the iterator is at the last node in a phylogeny and is therefore
done iterating.

**Parameters:**
* `x`: A `BreadthFirst` `PhylogenyIterator`.
* `state`: a `Queue` containing the nodes that are to be visited imminently.
""" ->
function Base.done(x::BreadthFirst, state::BreadthFirstState)
  return length(state) == 0
end

@Docile.doc """
A type for implementing depth-first traversal of any 
`Phylogeny`.

A `DepthFirst` phylogeny iterator contains:

- A `PhyNode` that the iterator will `start` at.
""" ->
immutable DepthFirst <: PhylogenyIterator
  start::PhyNode
  function DepthFirst(x::PhyNode)
    if isempty(x)
      error("Node provided to start iteration is empty!")
    end
    return new(x)
  end
end

@Docile.doc """
Construct a DepthFirst iterator for a tree.

**Parameters**
* `x`: A Phylogeny variable you want to traverse in depth-first order. 
""" ->
function DepthFirst(x::Phylogeny)
  return DepthFirst(x.root)
end

typealias DepthFirstState Stack{PhyNode} 

@Docile.doc """
Start iterating through a `Phylogeny` with a `DepthFirst` iterator.

**Parameters**
* `x`: A `DepthFirst` iterator to start iterating with.
""" ->
function Base.start(x::DepthFirst)
  state = Stack(PhyNode)
  push!(state, x.start)
  return state
end

@Docile.doc """
Step to the next node when iterating over a `Phylogeny`.

**Parameters:**
* `x`: `Depthfirst` iterator.
* `state`: A `Stack` that contains the nodes of a `Phylogeny` that are to be visited.  
""" ->
function Base.next(x::DepthFirst, state::DepthFirstState)
  current::PhyNode = pop!(state)
  for i in current.children
    push!(state, i)
  end
  return current, state
end

@Docile.doc """
Check whether the iterator is at the last node in a phylogeny and is therefore
done iterating.

**Parameters:**
* `x`: A `DepthFirst` `PhylogenyIterator`.
* `state`: a `Stack` containing the nodes that are to be visited imminently.
""" ->
function Base.done(x::DepthFirst, state::DepthFirstState)
  return length(state) == 0
end

@Docile.doc """
A type for implementing tip-to-root traversal of any 
`Phylogeny`.

A `Tip2Root` phylogeny iterator contains:

- A `PhyNode` that the iterator will `start` at.
""" ->
immutable Tip2Root <: PhylogenyIterator
  start::PhyNode
  function Tip2Root(x::PhyNode)
    if isempty(x)
      error("Node provided to start iteration is empty!")
    end
    return new(x)
  end
end

typealias Tip2RootState Tuple{PhyNode, Bool}

@Docile.doc """
Start iterating through a `Phylogeny` with a `Tip2Root` iterator.

**Parameters**
* `x`: A `Tip2Root` iterator to start iterating with.
""" -> 
function Base.start(x::Tip2Root)
  return (x.start, false)
end

@Docile.doc """
Step to the next node when iterating over a `Phylogeny`.

**Parameters:**
* `x`: A `Tip2Root` iterator.
* `state`: A `Tuple` that contains the node to be visited and whether the root has been reached. 
""" ->
function Base.next(x::Tip2Root, state::Tip2RootState)
  return state[1], (state[1].parent, isroot(state[1]))
end

@Docile.doc """
Check whether the iterator is at the last node in a phylogeny and is therefore
done iterating.

**Parameters:**
* `x`: A `Tip2Root` `PhylogenyIterator`.
* `state`: a `Tuple` containing the `PhyNode` that is to be visited next, and whether the root has been reached.
""" ->
function Base.done(x::Tip2Root, state::Tip2RootState)
  return state[2]
end

@Docile.doc """
Begin iteration over an individual PhyNode i.e. all other PhyNodes connected to it,
so parent and children.

**Parameters:**
* `x`: A PhyNode to iterate over.
""" ->
function Base.start(x::PhyNode)
  if parentisself(x)
    return (1, x.children)
  else
    return (1, [x.children, x.parent])
  end
end

@Docile.doc """
Step to the next node when iterating over a `Phylogeny`.

**Parameters:**
* `x`: A `PhyNode`.
* `state`: A `Tuple` that contains the index of the `Array` of `PhyNodes` to visit and the array itself.
""" ->
function Base.next(x::PhyNode, state::Tuple{Int64, Array{PhyNode, 1}})
  current::PhyNode = state[2][state[1]]
  return current, (state[1] + 1, state[2])
end

@Docile.doc """
Check whether iteration over all connections of a PhyNode is complete.

**Parameters:**
* `x`: A `PhyNode`.
* `state`: A `Tuple` that contains the index of the `Array` of `PhyNodes` to visit and the array itself.
""" ->
function Base.done(x::PhyNode, state::(Int64, Array{PhyNode, 1}))
  return state[1] > length(state[2])
end

@Docile.doc """
Iterate over a `Phylogeny` and return a reference to the first `PhyNode` 
that matches a given condition.

**Parameters:** 
* `it`: One of any type of `PhylogenyIterator`. This dictates the order in which nodes will be searched.
* `condition`: A `Function` that accepts a `PhyNode` as the first and only argument, and returns a Bool.
""" ->
function search{T}(it::T <: PhylogenyIterator, condition::Function)
  for i = it
    # I feel like the function should catch occasions where the provided condition does not return a Bool.
    if condition(i)
      return i
    end
  end
end

@Docile.doc """
Iterate over a `Phylogeny` and return an array of references to all `PhyNode`s 
that match a given condition.

**Parameters:** 
* `it`: One of any type of `PhylogenyIterator`. This dictates the order in which nodes will be searched.
* `condition`: A `Function` that accepts a `PhyNode` as the first and only argument, and returns a Bool.
""" ->
function searchall{T}(it::T <: PhylogenyIterator, condition::Function)
  matches::Array{PhyNode, 1} = PhyNode[]
  for i = it
    # I feel like the function should catch occasions where the provided condition does not return a Bool.
    if condition(i)
      push!(matches, i)
    end
  end
  return matches
end
