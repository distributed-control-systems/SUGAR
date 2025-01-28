function r=sqrt(obj)


% SQRT Calculate the square root of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = sqrt(obj)
%
% DESCRIPTION:
%   This function computes the square root of a multivector (MV) in a
%   geometric algebra.
%
% INPUT:
%   obj : An instance of the multivector (MV) class containing:
%
% OUTPUT:
%   r : A new multivector (MV) object representing the square root of the
%       input multivector.
%
% NOTES:
%   - The function applies the square root element-wise to the components
%     of the multivector.
%   - The square root is defined for non-negative arguments or complex
%     coefficients.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 4, 9, 16], [2, 0, 0]);
%   % Compute the square root
%   r = sqrt(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - MATLAB Documentation on sqrt
%
% See also MV, power, exp


    % Simple square root of a matrix...
    r=fun(obj,@(x,x_)sqrt(x));
%     if any(imag(r.vector))
%         syms Z
%         r=MV(real(r.vector),obj.Lsignature)+MV(imag(r.vector)*Z,obj.Lsignature);
%         fprintf("The solution to the sqrt function is parametrized by  Z such that Z*Z+1=0")
%     end
end
