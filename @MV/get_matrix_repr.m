function mx= get_matrix_repr(self)


% GET_MATRIX_REPR - Retrieves the matrix representation of the multivector.
%
% Syntax:
%   mx = get_matrix_repr(self)
%
% Description:
%   This function computes the matrix representation of a multivector
%   from its coefficients. It utilizes the algebra structure defined
%   for the multivector's signature to transform the coefficient vector
%   into a matrix form.
%
% Input:
%   self - (MV) The multivector object for which the matrix representation
%           is to be obtained.
%
% Output:
%   mx - (matrix) The resulting matrix representation of the multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   matrix_representation = get_matrix_repr(mv);  % Gets the matrix representation
%
% Note:
%   The function retrieves the basis, stamp, signs, and other necessary
%   information from the multivector's signature to construct the matrix.


    % Just the matrix representation from a set of coefficients

    %Get the Algebra structure
    [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
    val=self.vec;
    % Apply it to the vector to get a matrix
    z=(Stamp==0);
    mx=Msigns.*val(Stamp+z);
    mx(z)=0;
end


