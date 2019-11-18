using Plots
using LaTeXStrings
pyplot()

colors =  [:red,:green,:blue,:magenta,:black,:yellow,:cyan]
x = range(0, 2*pi; length=1000)

plot()
for n in 1:5
    plot!(x,sin.(n*x)./x,c=colors[n],label = latexstring("x^{$(n)}"))
end
Plots.gui()
