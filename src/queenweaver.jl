#=
Queen Weaver

Weaves all notebooks in scripts, outputs in public
=#

# TODO: For all jmd files in scripts
#   weave(file.jmd, output_path = "$(pwd()/public)")
using Weave
using Logging

logger = ConsoleLogger()

function weave_all(dir_in::AbstractString, dir_out::AbstractString)
    isabspath(dir_in) || error("Please enter absolute path (pwd), thanks.")
    isdir(dir_in) || error("Input directory does not exist!")
    isdir(dir_out) || error("Output directory does not exist!")

    for (root, dirs, files) in walkdir(dir_in)
        @info "Weaving files in $root"
        for file in files
            source = joinpath(root, file)
            @info "Weaving $(source)"
            weave(source; out_path = dir_out)
        end
    end
    # Weave to output directory
    return
end

weave_all("$(pwd())/scripts", "$(pwd())/public")