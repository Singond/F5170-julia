const elemcharge = 1.602E-19      # Elementary charge [C]
const electronmass = 9.109E-31    # Mass of an electron [kg]
const protonmass = 1.673E-27    # Mass of an electron [kg]
const permeability = 4pi*1E-7       # Permeability of free space [H/m]

function saveimg(name::AbstractString)
	imgdir = "img"
	if !isdir(imgdir)
		mkdir(imgdir)
	end
	filename = imgdir * "/" * name
	println("Saving $(filename)...")
	savefig(filename)
end
