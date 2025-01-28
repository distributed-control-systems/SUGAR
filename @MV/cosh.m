function r=cosh(obj)


% COSH - Computes the hyperbolic cosine (cosh) of a multivector (MV) object.
%
% Syntax:
%   r = cosh(obj)
%
% Description:
%   This function applies the hyperbolic cosine function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the hyperbolic cosine of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = cosh(mv);
%   disp(r); % Displays the resultant multivector


% Computes the cosh of a MV
    r=fun(obj,@(x,x_)cosh(x));
end

