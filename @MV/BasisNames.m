function Labels= BasisNames(obj)


% BASENAMES - Returns the basis names associated with the multivector's algebra.
%
% Syntax:
%   Labels = BasisNames(obj)
%
% Description:
%   This function retrieves the names of the basis elements corresponding to
%   the algebra of the multivector represented by the object `obj`. If the
%   multivector is represented in the Conformal Geometric Algebra (CGA),
%   it computes the basis names using the CGA matrix representation.
%
% Input:
%   obj - (MV) The multivector object for which the basis names are to be retrieved.
%
% Output:
%   Labels - (cell array) A cell array containing the names of the basis elements.
%
% Example:
%   mv = MV([...], [1, 1, 0]);
%   basisNames = mv.BasisNames();
%   disp(basisNames); % Displays the basis names
%
% Note:
%   The function checks if the representation of the multivector is CGA. If so,
%   it uses the `CGA_matrix` method to obtain the appropriate labels.


    % This function returns the basis names asociated with the obj's algebra

    % Check for CGA
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
    else
        Labels=obj.Basis;
    end
end


