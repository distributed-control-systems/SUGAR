function r=atan(obj)


% ATAN - Computes the arc tangent (atan) of a multivector (MV) object.
%
% Syntax:
%   r = atan(obj)
%
% Description:
%   This function applies the arc tangent function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc tangent of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = atan(mv);
%   disp(r); % Displays the resultant multivector


% Computes the atan of a MV
    r=fun(obj,@(x,x_)atan(x));
end

