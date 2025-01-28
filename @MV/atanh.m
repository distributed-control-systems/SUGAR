function r=atanh(obj)


% ATANH - Computes the arc hyperbolic tangent (atanh) of a multivector (MV) object.
%
% Syntax:
%   r = atanh(obj)
%
% Description:
%   This function applies the arc hyperbolic tangent function to the
%   input multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc hyperbolic tangent of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = atanh(mv);
%   disp(r); % Displays the resultant multivector


% Computes the atanh of a MV
    r=fun(obj,@(x,x_)atanh(x));
end

