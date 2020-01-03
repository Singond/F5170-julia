using Plots
pyplot()

using DifferentialEquations
using LinearAlgebra

# Parameters of the problem
struct Params
	charge              # Particle charge
	mass                # Particle mass
	elfield             # Electric field acting on particle
	magfield            # Magnetic field acting on particle
end

function derivs!(dy, y, p::Params, t)
	# y[1:3] is position; y[4:6] is velocity
	dy[1:3] = y[4:6]
	dy[4:6] = p.charge/p.mass * (p.elfield + y[4:6] × p.magfield)
end

const elemcharge = 1.602E-19      # Elementary charge [C]
const electronmass = 9.109E-31    # Mass of an electron [kg]

elfield = [0.0, 1, 0]
magfield = [0.0, 0, 2]
initposition = [0.0, 0, 0]
initvelocity = [-1.0, 0, 0]

p = Params(elemcharge, electronmass, elfield, magfield)
y0 = [initposition initvelocity]
tspan = (0.0, 1.0E-10)
prob = ODEProblem(derivs!, y0, tspan, p)

sol = solve(prob)

plot(sol, vars=(1,2))

#t = range(tspan[1],length=1000,stop=tspan[2])
#a = sol(t)'[:,1:3]
#
#x = a[:,1]
#y = a[:,2]
#z = a[:,3]
#
#plot(x,y)
