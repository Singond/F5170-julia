using LinearAlgebra

function myinv(mat::Matrix)
    s = size(mat)
    if s[1] != s[2]
        println("Not a square matrix!")
        return nothing
    elseif det(mat) == 0
        println("Matrix is singular!")
        return nothing
	else
		# Allow inverting higher-rank matrices, but issue a warning
		if rank(mat) > 10
			println("The rank of a matrix is greater than 10!")
		end
        return inv(mat)
    end
end
