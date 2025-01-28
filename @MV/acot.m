function r=acot(obj)


% ACOT - Computes the arc cotangent (acot) of a multivector (MV) object.
%
% Syntax:
%   r = acot(obj)
%
% Description:
%   This function applies the arc cotangent function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc cotangent of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = acot(mv);
%   disp(r); % Displays the resultant multivector


% Computes the acot of a MV
    r=fun(obj,@(x,x_)acot(x));
end

