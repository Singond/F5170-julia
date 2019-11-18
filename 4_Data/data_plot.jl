using Plots
using DelimitedFiles

pyplot()

const electronvolt = 1.602E-19      # [J]
const boltzmann = 8.617E-5          # [eV/K]
colors =  [:red,:green,:blue]

plot()
for i in 1:3
    filename = "csk$(i).dat"
    f = open(filename)
    data = readlines(filename)
    close(f)

    x = Vector{Float64}()
    y = Vector{Float64}()
    for i in data
        a = parse.(Float64,split(i,'\t'))
        push!(x,a[1])
        push!(y,a[2])
    end

    # Remove x,y pair if y = 0
    t = .!(iszero.(y))
    x = x[t]
    y = y[t]

    # Rescale to make the plot more readable
    x = x*boltzmann;            # Convert to eV
    logy = log10.(y);           # Use log scale

    # Print minimum x-value
    println("File $(i): min x = $(minimum(x))")

    plot!(x, logy, c=colors[i], label=filename, xlim=[0; 80],
        xlabel="Electron energy [K]",
        ylabel=latexstring("Collision cross-section [\$\\log_{10}\\ \\mathrm{m}^2\$]"))

    # Write the results to file
    outfile = "csev$(i).dat"
    println("Writing $filename...")
    writedlm(outfile, [x y])
end
Plots.gui()
