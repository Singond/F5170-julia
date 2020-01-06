Exercise 1
==========
See the modified file `motion.jl`.

The mass and charge of the particle have been set to those of an electron
and positron. The fields and initial conditions have been set as follows:
```julia
elfield = [0.0, 1, 0]
magfield = [0.0, 0, 2]
initposition = [0.0, 0, 0]
initvelocity = [-1.0, 0, 0]
```

For both particles, we observe an E-B drift in the direction of the x-axis:

![drift](img/epdrift.png)