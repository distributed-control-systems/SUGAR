function V= vector(obj)


% VECTOR Return an array of coefficients for a multivector.
%
% SYNTAX:
%   V = vector(obj)
%
% DESCRIPTION:
%   This function returns an array of coefficients representing the
%   multivector (MV). If the multivector is in Conformal Geometric Algebra
%   (CGA) format, the coefficients are transformed using the corresponding
%   basis change matrix. Otherwise, it simply returns the original
%   coefficient array.
%
% INPUT:
%   obj : A multivector (MV) object.
%
% OUTPUT:
%   V : An array of coefficients. If the representation is CGA, the array
%       is transformed; otherwise, the original coefficients are returned.
%
% NOTES:
%   - For CGA representations, the coefficients are transformed using
%     `CGA_matrix` and the associated basis labels.
%
% EXAMPLES:
%   % Create a multivector in CGA representation
%   mv = MV([1, 2, 3, 4], [1, 1, 0], 'CGA');
%   % Get the coefficients
%   V = vector(mv);
%   or
%   V = mv.vector();
%   or
%   V=mv.vector;
%
%   % Display the result
%   disp(V);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%
% See also MV, CGA_matrix


    % Return an array of coefficients, but taking into account that it
    % could be a CGA description
    if obj.REPR=="CGA"
        [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
        V=obj.vec*Matrix;
    else
        V=obj.vec;
    end
end


