function r=asinh(obj)


% ASINH - Computes the arc hyperbolic sine (asinh) of a multivector (MV) object.
%
% Syntax:
%   r = asinh(obj)
%
% Description:
%   This function applies the arc hyperbolic sine function to the
%   input multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc hyperbolic sine of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = asinh(mv);
%   disp(r); % Displays the resultant multivector


% Computes the asinh of a MV
    r=fun(obj,@(x,x_)asinh(x));
end

