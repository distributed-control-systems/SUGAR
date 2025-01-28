function r=tan(obj)


% TAN Calculate the tangent of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = tan(obj)
%
% DESCRIPTION:
%   This function computes the tangent (tan) of a multivector (MV) in a
%   geometric algebra.
%
% INPUT:
%   obj : An instance of the multivector (MV) class containing:
%
% OUTPUT:
%   r : A new multivector (MV) object representing the tangent of the
%       input multivector.
%
% NOTES:
%   - The function is defined over the domain where the tangent is
%     mathematically valid.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Compute the tangent
%   r = tan(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, sin, cos


% Computes the tan of a MV
    r=fun(obj,@(x,x_)tan(x));
end

