function variable_unit_tests()
    var_data_getters_and_setters_tests()
    moi_var_record_getters_and_setters_tests()
    variable_getters_and_setters_tests()
    return
end

function var_data_getters_and_setters_tests()

    form = createformulation()
 
     v_data = ClF.VarData(
         ; cost = 13.0, lb = -10.0, ub = 100.0, kind = ClF.Continuous,
         sense = ClF.Free, is_active = false, is_explicit = false
     )
     v = ClF.Variable(
        ClF.Id{ClF.Variable}(ClF.MasterPureVar, 23, 10), "fake_var";
        var_data = v_data
    )

    ClF._addvar!(form, v)

    @test ClF.getcurcost(form, v) == 13.0
    # @test ClF.getlb(form, v_data) == -10.0
    # @test ClF.getub(form, v_data) == 100.0

    # ClF.setcost!(form, v_data, -113.0)
    # ClF.setlb!(form, v_data, -113.0)
    # ClF.setub!(form, v_data, -113.0)

    # @test ClF.getcost(form, v_data) == -113.0
    # @test ClF.getlb(form, v_data) == -113.0
    # @test ClF.getub(form, v_data) == -113.0

    # ClF.setkind!(form, v_data, ClF.Binary)
    # @test ClF.getkind(form, v_data) == ClF.Binary
    # @test ClF.getlb(form, v_data) == 0.0
    # @test ClF.getub(form, v_data) == -113.0

    # ClF.setkind!(form, v_data, ClF.Integ)
    # @test ClF.getkind(form, v_data) == ClF.Integ
    # @test ClF.getlb(form, v_data) == 0.0
    # @test ClF.getub(form, v_data) == -113.0
    return
end

function moi_var_record_getters_and_setters_tests()

    v_rec = ClF.MoiVarRecord(
        ; index = ClF.MoiVarIndex(-15)
    )

    @test ClF.getindex(v_rec) == ClF.MoiVarIndex(-15)
    @test ClF.getbounds(v_rec) == ClF.MoiVarBound(-1)
    #@test ClF.getkind(v_rec) == ClF.MoiInteger(-1)

    ClF.setindex!(v_rec, ClF.MoiVarIndex(-20))
    ClF.setbounds!(v_rec, ClF.MoiVarBound(10))
    #ClF.setkind!(v_rec, ClF.MoiBinary(13))

    @test ClF.getindex(v_rec) == ClF.MoiVarIndex(-20)
    @test ClF.getbounds(v_rec) == ClF.MoiVarBound(10)
    #@test ClF.getkind(v_rec) == ClF.MoiBinary(13)
    return
end

function variable_getters_and_setters_tests()
    form = createformulation()
    
    v_data = ClF.VarData(
        ; cost = 13.0, lb = -10.0, ub = 100.0, kind = ClF.Continuous,
        sense = ClF.Free, is_active = false, is_explicit = false
    )

    v = ClF.Variable(
        ClF.Id{ClF.Variable}(ClF.MasterPureVar, 23, 10), "fake_var";
        var_data = v_data
    )

    ClF._addvar!(form, v)
    @test ClF.getperenecost(form, v) == ClF.getcurcost(form, v) == 13.0
    @test ClF.getperenelb(form, v) == ClF.getcurlb(form, v) == -10.0
    @test ClF.getpereneub(form, v) == ClF.getcurub(form, v) == 100.0

    ClF.setcurcost!(form, v, -134.0)
    ClF.setcurlb!(form, v, -2001.9)
    ClF.setcurub!(form, v, 2387.0)

    @test ClF.getcurcost(form, v) == -134.0
    @test ClF.getcurlb(form, v) == -2001.9
    @test ClF.getcurub(form, v) == 2387.0
    @test ClF.getperenecost(form, v) == 13.0
    @test ClF.getperenelb(form, v) == -10.0
    @test ClF.getpereneub(form, v) == 100.0

    ClF.reset!(form, v)
    @test ClF.getperenecost(form, v) == ClF.getcurcost(form, v) == 13.0
    #@test v.perene_data.lb == v.cur_data.lb == -10.0
    #@test v.perene_data.ub == v.cur_data.ub == 100.0
    #@test v.perene_data.kind == v.cur_data.kind == ClF.Continuous
    #@test v.perene_data.sense == v.cur_data.sense == ClF.Free
    #@test v.perene_data.inc_val == v.cur_data.inc_val == -1.0
    #@test v.perene_data.is_explicit == v.cur_data.is_explicit == false
    #@test v.perene_data.is_active == v.cur_data.is_active == false
    return
end
