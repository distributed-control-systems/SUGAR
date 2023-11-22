function inverse = inv(self)
    %The inverse of a MV or a matrix of MVs
    [f, c] = size(self);
    if f ~= c
        error('In order to compute the inverse a square matrix is required, otherwise try with pinv');
    end
    % Is it a matrix?
    if f == 1
        % No
        r=MV();
        r.Basis=self.Basis;
        r.Lsignature=self.Lsignature;
        r.Signs=self.Signs;
        r.REPR=self.REPR;
        % Inverse of the matrix representation
        r.matrix=self.matrix^(-1);
        r.vec=r.matrix(:,1).';
        inverse = r;
        return;
    end

   
    % So.... this is a matrix....
    
    % Get the superMatrix representation
    SUPER_MATRIX=to_SUPER_MATRIX(self);
    % Compute the inverse
    SUPER_INVERSE=inv(SUPER_MATRIX);
    % Reconstruct a matrix of MVs
    inverse=from_SUPER_MATRIX(self,SUPER_INVERSE);
 end

