function r=sin(obj)


% SIN Calculate the sine of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = sin(obj)
%
% DESCRIPTION:
%   This function computes the sine of a multivector (MV) in a
%   geometric algebra.
%
% INPUT:
%   obj : An instance of the multivector (MV) class containing:
%
% OUTPUT:
%   r : A new multivector (MV) object representing the sine of the
%       input multivector.
%
% NOTES:
%   - The function is defined over the domain where the sine is
%     mathematically valid.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Compute the sine
%   r = sin(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, cos, tan


% Computes the sin of a MV
    r=fun(obj,@(x,x_)sin(x));
end

