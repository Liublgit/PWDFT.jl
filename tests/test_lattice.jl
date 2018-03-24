using PWDFT

include("../src/gen_lattice_pwscf.jl")

function test_fcc()
    LatVecs = gen_lattice_fcc(16.0)
    ecutwfc_Ry = 1.0

    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)

    write_xsf("fcc.xsf", LatVecs, pw.r)    
end

function test_bcc()
    LatVecs = gen_lattice_bcc(16.0)
    ecutwfc_Ry = 1.0

    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)

    write_xsf("bcc.xsf", LatVecs, pw.r)
end

function test_bcc_v2()
    LatVecs = gen_lattice_bcc_v2(16.0)
    ecutwfc_Ry = 1.0

    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)

    write_xsf("bcc_v2.xsf", LatVecs, pw.r)
end

function test_hexagonal()
    LatVecs = gen_lattice_hexagonal(16.0,5.0)
    ecutwfc_Ry = 1.0

    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)

    write_xsf("hexagonal.xsf", LatVecs, pw.r)
end

function test_trigonal()
    #
    LatVecs = gen_lattice_trigonal(16.0, 30.0)
    ecutwfc_Ry = 1.0
    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)
    write_xsf("trigonal_30.xsf", LatVecs, pw.r)    
    #
    LatVecs = gen_lattice_trigonal(16.0, 45.0)
    ecutwfc_Ry = 1.0
    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)
    write_xsf("trigonal_45.xsf", LatVecs, pw.r)
    #
    LatVecs = gen_lattice_trigonal(16.0, 60.0)
    ecutwfc_Ry = 1.0
    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)
    write_xsf("trigonal_60.xsf", LatVecs, pw.r)
    #
    LatVecs = gen_lattice_trigonal(16.0, 90.0)
    ecutwfc_Ry = 1.0
    pw = PWGrid( 0.5*ecutwfc_Ry, LatVecs)
    println(pw)
    write_xsf("trigonal_90.xsf", LatVecs, pw.r)
end

#test_fcc()
#test_bcc()
#test_bcc_v2()
#test_hexagonal()
test_trigonal()