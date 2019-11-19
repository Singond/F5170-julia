include("inverse_matrix.jl")

# Test the `myinv` function on random matrices
for i in 1:10
	# Generate random 8x8 matrix. We expect this matrix to be regular
	# (ie. non-singular), because it is made from randomly generated
	# numbers and it is extremely unlikely that any two rows or columns
	# will be linearly dependent.
	A = rand(8, 8)
	# Calculate its inverse
	B = myinv(A)
	# Calculate A*B - I (where I is the identity matrix) and find the
	# largest element of the resulting matrix. In theory, this should
	# be zero, but in reality, we will see a small value, which is due
	# to the inherently limited precision of floating-point arithmetic.
	Z = A*B - I
	m = maximum(abs.(Z))
	println("Imprecision: $m")
end
