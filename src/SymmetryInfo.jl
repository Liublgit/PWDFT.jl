struct SymmetryInfo
    Nsyms::Int64
    s::Array{Int64,3}
    inv_s::Array{Int64,3}
    ft::Array{Float64,2}
    non_symmorphic::Array{Bool,1}
end

# Dummy SymmetryInfo
function SymmetryInfo()
    Nsyms = 1
    s = zeros(Int64,3,3,1)
    s[1,1,1] = 1
    s[2,2,1] = 1
    s[3,3,1] = 1
    inv_s = copy(s)
    ft = zeros(3,1)
    non_symmorphic = [false]
    return SymmetryInfo(Nsyms, s, inv_s, ft, non_symmorphic)
end

function SymmetryInfo( atoms::Atoms )
    Nsyms, s, ft = spg_get_symmetry(atoms)    
    inv_s = zeros(Int64,3,3,Nsyms)

    for isym = 1:Nsyms
        inv_s[:,:,isym] = Base.convert(Array{Int64,2}, inv(s[:,:,isym]))
    end

    non_symmorphic = zeros(Bool,Nsyms)
    SMALL = 1e-10
    for isym = 1:Nsyms
        non_symmorphic[isym] = ( (abs(ft[1,isym]) >= SMALL) ||
                                 (abs(ft[2,isym]) >= SMALL) ||
                                 (abs(ft[3,isym]) >= SMALL) )
    end

    return SymmetryInfo(Nsyms, s, inv_s, ft, non_symmorphic)
end

include("SymmetryInfo_io.jl")
