function r=asech(obj)


% ASECH - Computes the arc hyperbolic secant (asech) of a multivector (MV) object.
%
% Syntax:
%   r = asech(obj)
%
% Description:
%   This function applies the arc hyperbolic secant function to the
%   input multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc hyperbolic secant of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = asech(mv);
%   disp(r); % Displays the resultant multivector


% Computes the asech of a MV
    r=fun(obj,@(x,x_)asech(x));
end

