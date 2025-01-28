function r=asin(obj)


% ASIN - Computes the arc sine (asin) of a multivector (MV) object.
%
% Syntax:
%   r = asin(obj)
%
% Description:
%   This function applies the arc sine function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc sine of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = asin(mv);
%   disp(r); % Displays the resultant multivector


% Computes the asin of a MV
    r=fun(obj,@(x,x_)asin(x));
end

