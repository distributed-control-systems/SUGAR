function r=sech(obj)


% SECH Calculate the hyperbolic secant of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = sech(obj)
%
% DESCRIPTION:
%   This function computes the hyperbolic secant (sech) of a multivector (MV) in a
%   geometric algebra.
%
% INPUT:
%   obj : An instance of the multivector (MV) class containing:
%
%
% OUTPUT:
%   r : A new multivector (MV) object representing the hyperbolic secant
%       of the input multivector.
%
% NOTES:
%   - The function is defined over the domain where the hyperbolic secant is
%     mathematically valid.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Compute the hyperbolic secant
%   r = sech(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, cosh, sinh


% Computes the sech of a MV
    r=fun(obj,@(x,x_)sech(x));
end

