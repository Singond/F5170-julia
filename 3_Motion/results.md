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

The solution is then calculated in a time interval of length 1E-10 s.
For both particles, we observe an E-B drift in the direction of the x-axis
(this is consistent with theory).
Each particle completes five gyration cycles in the specified interval.

![Electron and positron drift](img/epdrift.png)

Exercise 2
==========
Again, see the file `motion.jl`. A section has been added to calculate
the motion of a proton.
```julia
# Proton
p = Params(elemcharge, protonmass, elfield, magfield)
tspan = (0.0, 1.0E-7)
sol = solve(ODEProblem(derivs!, y0, tspan, p))
plot(sol, vars=(1,2), label="proton")
```

As can be seen in the code listing, the time span of the solution
has been increased by three orders of magnitude in order to see
at least a few full cycles.

The calculated trajectory is in the following figure:

![Proton drift](img/protondrift.png)

Clearly, the radius of oscillation is much greater for proton: more than
by three orders of magnitude.
The drift velocity ratio of proton and electron can be estimated
by comparing the two plots: The proton drifted about 1000x further
in 1000x longer time interval, showing a linear relationship.
In other words, the drift velocity has not changed, which is in line
with theoretical predictions.