function V= vector(obj)
    % Return an array of coefficients, but taking into account that it
    % could be a CGA description
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
        V=obj.vec*Matrix;
    else
        V=obj.vec;
    end
end

