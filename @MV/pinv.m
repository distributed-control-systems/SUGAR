function inverse = pinv(self)


% PINV - Computes the pseudoinverse of a multivector or a matrix of multivectors.
%
% Syntax:
%   inverse = pinv(self)
%
% Description:
%   This function calculates the pseudoinverse of a multivector (MV) or
%   a matrix of MVs. If the input is a non-square matrix, the function
%   computes the pseudoinverse by converting the matrix to a supermatrix
%   representation and then applies MATLAB's `pinv` function. The pseudoinverse
%   of a scalar MV is computed by inverting its matrix representation.
%
% Input:
%   self - (MV) A multivector or a matrix of multivectors.
%
% Output:
%   inverse - (MV) The pseudoinverse of the input multivector or matrix of MVs.
%
% Example:
%   mv1 = MV([1, 2, 3, 4], [2, 0, 0]);
%   mv2 = MV([5, 6, 7, 8], [2, 0, 0]);
%   M=[mv1 mv2]
%   mv_inv = pinv(M);
%   disp(mv_inv);  % Displays the pseudoinverse of the multivector
%
% Notes:
%   - The pseudoinverse is calculated using MATLAB's built-in `pinv` for matrices
%     and the inverse of the matrix representation for scalar multivectors.
%   - If a square matrix of MVs is provided, the function computes the pseudoinverse
%     by transforming the matrix into its supermatrix form and applying the `pinv` function.


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



