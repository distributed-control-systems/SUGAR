function r=coth(obj)


% COTH - Computes the hyperbolic cotangent (coth) of a multivector (MV) object.
%
% Syntax:
%   r = coth(obj)
%
% Description:
%   This function applies the hyperbolic cotangent function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the hyperbolic cotangent of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = coth(mv);
%   disp(r); % Displays the resultant multivector


% Computes the coth of a MV
    r=fun(obj,@(x,x_)coth(x));
end

