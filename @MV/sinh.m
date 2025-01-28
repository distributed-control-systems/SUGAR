function r=sinh(obj)


% SINH Calculate the hyperbolic sine of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = sinh(obj)
%
% DESCRIPTION:
%   This function computes the hyperbolic sine (sinh) of a multivector (MV) in a
%   geometric algebra.
%
% INPUT:
%   obj : An instance of the multivector (MV) class containing:
%
% OUTPUT:
%   r : A new multivector (MV) object representing the hyperbolic sine
%       of the input multivector.
%
% NOTES:
%   - The function is defined over the domain where the hyperbolic sine is
%     mathematically valid.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Compute the hyperbolic sine
%   r = sinh(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, cosh, tanh


% Computes the sinh of a MV
    r=fun(obj,@(x,x_)sinh(x));
end

