Task 2
======

See the modified source file `data_plot.jl`.

![x-section](img/task-2.png)

The excitation threshold is about 11.55 eV.
The ionization threshold is about 16.00 eV.

Task 3
======

See the modified source file `data_plot.jl`.
The following code writes the converted data to a tab-separated file:

```julia
using DelimitedFiles

# Write the results to file
outfile = "csev$(i).dat"
println("Writing $filename...")
writedlm(outfile, [x y])
```