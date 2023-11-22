function inverse = pinv(self)
    %The pseudoinverse of a MV or a matrix of MVs
    [f, c] = size(self);
    if f ~= c
        % A non square matrix of multivectors, so we get the supermatrix
        % representation
        SUPER_MATRIX=to_SUPER_MATRIX(self);
        % Compute the pseudoinverse
        SUPER_INVERSE=pinv(SUPER_MATRIX);
        % Recover the matrix of MV
        inverse=from_SUPER_MATRIX(self.',SUPER_INVERSE').';
        return
    end
    % The gave me a scalar
    if f*c == 1
        r=MV();
        r.Basis=self.Basis;
        r.Lsignature=self.Lsignature;
        r.Signs=self.Signs;
        r.REPR=self.REPR;
        r.matrix=self.matrix^(-1);
        r.vec=r.matrix(:,1).';
        inverse = r;
        return;
    end

    % we should not get here, but here we are, a square matrix of MV
    SUPER_MATRIX=to_SUPER_MATRIX(self);
    % Compute the pseudoinverse
     SUPER_INVERSE=pinv(SUPER_MATRIX);
    % Recover the matrix of MV
    inverse=from_SUPER_MATRIX(self,SUPER_INVERSE);
    
end


