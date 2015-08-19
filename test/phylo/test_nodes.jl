# Nodes

facts("Nodes") do

    context("Empty nodes") do
        # create an empty node
        node = PhyNode()
        @fact blisknown(node) --> false
        @fact confisknown(node) --> false
        @fact isempty(node) --> true
    end

    context("Filled nodes (basic fields)") do
        # create an empty node
        node = PhyNode("test", 10.0, 0.99)
        @fact name(node) --> "test"
        @fact blisknown(node) --> true
        @fact branchlength(node) --> 10.0
        @fact confisknown(node) --> true
        @fact confidence(node) --> 0.99
        @fact isempty(node) --> false
        # remove the fields
        confidence!(node, -1.0)
        @fact confisknown(node) --> false
        branchlength!(node, -1.0)
        @fact blisknown(node) --> false
        name!(node, "")
        @fact isempty(node) --> true
    end

    context("Relationships") do

        context("Equality") do
            a = PhyNode()
            b = PhyNode()
            @fact isequal(a, b) --> true
            name!(a, "a")
            @fact isequal(a, b) --> false
            name!(b, "a")
            @fact isequal(a, b) --> true
        end

        context("Parent-child") do
            # we start with no relationship
            a = PhyNode()
            b = PhyNode()
            @fact haschildren(a) --> false
            @fact hasparent(b) --> false
            @fact parentisself(b) --> true
            @fact isunlinked(a) --> true
            @fact countchildren(a) --> 0
            @fact haschild(a, b) --> false
            # now create the parent-child relationship
            graft!(a, b)
            @fact haschildren(a) --> true
            @fact hasparent(b) --> true
            @fact parentisself(b) --> false
            @fact isunlinked(a) --> false
            @fact countchildren(a) --> 1
            @fact haschild(a, b) --> true
        end

        context("Root") do
            a = PhyNode()
            @fact isroot(a) --> false
            b = PhyNode()
            graft!(a, b)
            @fact isroot(a) --> true
            c = PhyNode()
            graft!(c, a)
            @fact isroot(a) --> false
            @fact isroot(c) --> true
        end

        context("Siblings") do
            a = PhyNode()
            b = PhyNode()
            graft!(a, b)
            @fact length(siblings(b)) --> 0
            c = PhyNode()
            graft!(a, c)
            @fact length(siblings(b)) --> 1
            @fact in(c, siblings(b)) --> true
        end

        context("Ancestor-descendant") do
            a = PhyNode()
            b = PhyNode()
            @fact isancestral(a, [b]) --> false
            graft!(a, b)
            @fact isancestral(a, [b]) --> true
            c = PhyNode()
            graft!(a, c)
            @fact isancestral(a, [c]) --> true
        end
    end

end

## Relationships
#- build and destroy relationships between nodes

## Measures
#- distances, lengths, etc.
