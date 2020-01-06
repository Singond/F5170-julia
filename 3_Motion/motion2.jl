using Plots
pyplot()

using DifferentialEquations
using LinearAlgebra

const elemcharge = 1.602E-19      # Elementary charge [C]
const electronmass = 9.109E-31    # Mass of an electron [kg]

# Parameters of the problem
struct Params2
	charge              # Particle charge
	mass                # Particle mass
	elfield             # Electric field acting on particle
	y0
end

function derivs!(dy, y, p::Params2, t)
	# y[1:3] is position; y[4:6] is velocity
	dy[1:3] = y[4:6]
	magfield = [0.0, 0, (y[2]/p.y0)^2]
	dy[4:6] = p.charge/p.mass * (p.elfield + y[4:6] × magfield)
end

function saveimg(name::AbstractString)
	imgdir = "img"
	if !isdir(imgdir)
		mkdir(imgdir)
	end
	filename = imgdir * "/" * name
	println("Saving $(filename)...")
	savefig(filename)
end

elfield = [0.0, 0, 0]
initposition = [0.0, 0, 0]
initvelocity = [1, 1, 0]
yparam = 1

# Electron
p = Params2(-elemcharge, electronmass, elfield, yparam)
y0 = [initposition initvelocity]
tspan = (0.0, 0.005)
sol = solve(ODEProblem(derivs!, y0, tspan, p))
plt = plot(sol, vars=(1,2), label="electron", aspect_ratio=:equal)

# Electron
p = Params2(elemcharge, electronmass, elfield, yparam)
sol = solve(ODEProblem(derivs!, y0, tspan, p))
plot!(sol, vars=(1,2), label="positron", aspect_ratio=:equal)

saveimg("drift3.png")
