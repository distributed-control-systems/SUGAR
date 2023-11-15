function Labels= BasisNames(obj)
    % This function returns the basis names asociated with the obj's algebra

    % Check for CGA
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
    else
        Labels=obj.Basis;
    end
end

