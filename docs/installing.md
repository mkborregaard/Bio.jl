# Install Bio.jl using the Julia package manager

Julia's package manager can be used to install Bio.jl:
    
    Pkg.add("Bio.jl")

If you want a more bleeding edge version than the current release use
the `checkout` function:

    Pkg.checkout("Bio")

To checkout a more recent version of the package, than the officially 
registered version.

Alternatively, if you know someone working on a module or feature for
Bio.jl core on their fork, clone their Fork with `Pkg.clone()`.

Refer to the [Julia Packages documentation](http://julia.readthedocs.org/en/latest/manual/packages/)
for furthr details on package installation and using packages on the bleeding-edge.
