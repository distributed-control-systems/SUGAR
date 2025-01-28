function r=acoth(obj)


% ACOTH - Computes the arc hyperbolic cotangent (acoth) of a multivector (MV) object.
%
% Syntax:
%   r = acoth(obj)
%
% Description:
%   This function applies the arc hyperbolic cotangent function to the
%   input multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc hyperbolic cotangent of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = acoth(mv);
%   disp(r); % Displays the resultant multivector


% Computes the acoth of a MV
    r=fun(obj,@(x,x_)acoth(x));
end

