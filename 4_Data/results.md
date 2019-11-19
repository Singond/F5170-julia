Exercise 1
==========
See the modified file `simple_plot.jl`.
The following snippet plots the desired functions:

```julia
for n in 1:5
    plot!(x, sin.(n*x)./x, c=colors[n], label=latexstring("sinc($(n)x)"))
end
```

Running the `simple_plot.jl` script produces the following figure:

![sinc](img/task-1.png)

Exercise 2
==========
See the modified file `data_plot.jl`. Running the script plots the data
and prints the minimum electron energy in each series.
The excitation threshold is about 11.55 eV, while the ionization threshold
is about 16.00 eV.

![x-section](img/task-2.png)

Exercise 3
==========
See the modified file `data_plot.jl`.
The following code writes the converted data to a tab-separated file:

```julia
using DelimitedFiles

# Write the results to file
outfile = "csev$(i).dat"
println("Writing $filename...")
writedlm(outfile, [x y])
```

Exercise 4
==========

Matrix inverse
--------------
The inverse of a matrix can be calculated by the `Base.inv` function:

```julia
julia> A = [1 0 0 0; 0 5 0 0; 0 0 5 0; 0 0 0 4]
4×4 Array{Int64,2}:
 1  0  0  0
 0  5  0  0
 0  0  5  0
 0  0  0  4

julia> inv(A)
4×4 Array{Float64,2}:
 1.0  0.0  0.0  0.0
 0.0  0.2  0.0  0.0
 0.0  0.0  0.2  0.0
 0.0  0.0  0.0  0.25
```

If we try to invert a singular matrix, we expect an error to be thrown.
Indeed, calling `inv` on a singular matrix throws `SingularException`:

```julia
julia> S = [8 4 4; 3 7 5; 2 1 1]
3×3 Array{Int64,2}:
 8  4  4
 3  7  5
 2  1  1

julia> inv(S)
ERROR: LinearAlgebra.SingularException(3)
```

The `myinv` function
--------------------
In order to test the `myinv` function, run the script in `test_myinv.jl`.
It generates a random matrix, calculates its inverse using `myinv`
and prints the largest deviation of an element from the expected value.
This is an example of its output:

```
julia> include("test_myinv.jl")
Imprecision: 6.9310267721271176e-15
Imprecision: 2.3507257768863537e-14
Imprecision: 1.6350070966974443e-14
Imprecision: 1.7136353176691748e-15
Imprecision: 4.722769462762844e-15
Imprecision: 2.1453167516260684e-15
Imprecision: 8.778105812563701e-16
Imprecision: 9.70164737529098e-16
Imprecision: 6.318670182969587e-15
Imprecision: 3.9106562770315805e-15
```

Passing a non-square matrix to the function returns nothing and prints
a warning message:

```julia
julia> myinv([1 2 3; 4 2 3])
Not a square matrix!
```

Also, invoking `myinv` with a singular matrix returns nothing:

```julia
julia> myinv([4 2; 2 1])
Matrix is singular!
```

### Rank check
See the modified file `inverse_matrix.jl`. A check has been added that warns
the user if the matrix rank exceeds 10; but allows the execution to continue:

`inverse_matrix.jl`:
```julia
...
	# Allow inverting higher-rank matrices, but issue a warning
	if rank(mat) > 10
		println("The rank of a matrix is greater than 10!")
	end
...
```

```
julia> include("inverse_matrix.jl")
myinv (generic function with 1 method)

julia> myinv(rand(11,11))
The rank of a matrix is greater than 10!
11×11 Array{Float64,2}:
...
```
