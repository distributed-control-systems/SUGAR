function Labels= BasisNames(obj)
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
    else
        Labels=obj.Basis;
    end
end

