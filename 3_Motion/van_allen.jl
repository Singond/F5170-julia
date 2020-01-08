using Plots
pyplot()

using DifferentialEquations
using LinearAlgebra #vector norm
using Statistics #mean function

include("common.jl")

function derivs!(dy,y,p,t)
    dy[1:3] = y[4:6]
    dy[4:6] = p[1]/p[2]*(p[3] + y[4:6] × (bfield(y[1:3],p[4])))
end

function bfield(r,M)
    if M[1] != 0 || M[2] != 0
        throw(ArgumentError("This implementation assumes that M is parallel to z"))
    end
    x, y, z = r
    rr = hypot(r...)
    return ((permeability*M[3])/(4pi*rr^5)) * [3x*z, 3y*z, 3z^2 - rr^2]
end

function sphe2cart(r,ϕ,θ)
    #From spherical coordinates creates Cartesian vector
    r*[sin(θ)*cos(ϕ),sin(θ)*sin(ϕ),cos(θ)]
end

E = zeros(3)
magM = [0, 0, 809E20] #Calculate it!
q = 1.60217662e-19
m = 1.6726219e-27
c = 3e8
re = 6.38e6
Ek_ev = 5e7

#Velocity
v = sphe2cart(c/sqrt(1+m*c^2/Ek_ev/abs(q)),0,π/4)
#Position
r = sphe2cart(2.5*re,0,π/2)
#State vector
y0 = [r...,v...] #Three dots are used to unpack the array.

p = [q,m,E,magM]
tspan = (0.0,25.0)
prob = ODEProblem(derivs!,y0,tspan,p)

sol = solve(prob)

plt = plot(sol,vars=(1,2,3), label="proton", linewidth=1,
        xlabel="x", ylabel="y", zlabel="z")

#This is the part where we visualize a few field lines.
function fieldline(B,M,ϕ)
    #This function creates field lines of magnetic field from a dipole.
    #I do not understand why this works but email me if you do!
    xyz = [ sphe2cart(re*2.5*sin(θ)^2,ϕ,θ) for θ in range(-π,stop=π,length=100) ]
    x = [i[1] for i in xyz]
    y = [i[2] for i in xyz]
    z = [i[3] for i in xyz]
    (x,y,z)
end

mean_B = mean(norm.([bfield(sol'[i,1:3],magM) for i in 1:size(sol,2)]))
for i in range(0, stop=2*π, length=10)
    plot!(fieldline(mean_B,magM[3],i)...,c="red", label="")
end
Plots.gui() #If you use `plot` inside a for-loop you have to use this to update the figure.
saveimg("van-allen.png")
display(plt)
