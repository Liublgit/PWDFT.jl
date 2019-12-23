using Test

include("PWDFT_cuda.jl")

using Random

function main()

    Random.seed!(1234)

    atoms = Atoms(xyz_string=
    """
    3

    Si   0.0  0.0  0.0
    Si   0.0  1.51  0.0
    Si   1.5  0.0  0.0
    """, LatVecs=gen_lattice_sc(5.0))

    pspfiles = ["../../pseudopotentials/pade_gth/Si-q4.gth"]
    ecutwfc = 5.0

    Nspin = 1

    Ham = CuHamiltonian( atoms, pspfiles, ecutwfc, use_symmetry=false, Nspin=Nspin )

    Npoints = prod(Ham.pw.Ns)

    psiks = rand_CuBlochWavefunc( Ham )
    Rhoe = calc_rhoe( Ham, psiks )

    update!( Ham, Rhoe )
    
    E_Ps_loc, E_Hartree, E_xc = calc_E_local( Ham )

    E_Ps_nloc = calc_E_Ps_nloc( Ham, psiks )

    @printf("E_Ps_loc  = %18.10f\n", E_Ps_loc)
    @printf("E_Hartree = %18.10f\n", E_Hartree)
    @printf("E_xc      = %18.10f\n", E_xc)
    @printf("E_Ps_nloc = %18.10f\n", E_Ps_nloc)

    #
    # Compare with CPU calculation
    #
    Nkspin = length(psiks)
    Ham_cpu = Hamiltonian( atoms, pspfiles, ecutwfc, use_symmetry=false, Nspin=Nspin )
    psiks_cpu = BlochWavefunc(undef, Nkspin)
    for i in 1:Nkspin
        psiks_cpu[i] = collect(psiks[i])
    end

    Rhoe_cpu = calc_rhoe( Ham_cpu, psiks_cpu )
    update!( Ham_cpu, Rhoe_cpu )

    E_Ps_loc_cpu, E_Hartree_cpu, E_xc_cpu = calc_E_local( Ham_cpu )

    E_Ps_nloc_cpu = calc_E_Ps_nloc( Ham_cpu, psiks_cpu )

    @printf("E_Ps_loc_cpu  = %18.10f\n", E_Ps_loc_cpu)
    @printf("E_Hartree_cpu = %18.10f\n", E_Hartree_cpu)
    @printf("E_xc_cpu      = %18.10f\n", E_xc_cpu)
    @printf("E_Ps_nloc_cpu = %18.10f\n", E_Ps_nloc_cpu)

    @test E_Ps_nloc ≈ E_Ps_nloc_cpu

    println("Pass here")
end

main()