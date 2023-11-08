function V= vector(obj)
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
        V=obj.vec*Matrix;
    else
        V=obj.vec;
    end
end

