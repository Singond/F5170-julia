using Plots
using LaTeXStrings
pyplot()

colors =  [:red,:orange,:gold,:green,:blue,:indigo,:violet]
x = range(0, 2*pi; length=1000)

plot()
for n in 1:5
    plot!(x,sin.(n*x)./x,c=colors[n],label = latexstring("sinc($(n)x)"))
end
Plots.gui()
