function inverse = inv(self)


% INV - Computes the inverse of a multivector or a matrix of multivectors.
%
% Syntax:
%   inverse = inv(self)
%
% Description:
%   This function calculates the inverse of a multivector or a matrix of
%   multivectors. If the input is a single multivector, it computes the
%   inverse of its matrix representation. For a matrix of multivectors,
%   it first converts it to a supermatrix, computes the inverse, and
%   then reconstructs the multivector matrix.
%
% Input:
%   self - (MV) The multivector object for which the inverse is to be computed.
%
% Output:
%   inverse - (MV) The resulting multivector or matrix of multivectors
%              after applying the inverse operation.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   inv_mv = inv(mv);  % Computes the inverse of the multivector
%   disp(inv_mv); % Displays the inverse multivector
%
% Note:
%   The function checks if the input is a square matrix before attempting
%   to compute the inverse. If the input is not square, it raises an error
%   and suggests using the pseudo-inverse instead.


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


