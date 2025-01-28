function r=asec(obj)


% ASEC - Computes the arc secant (asec) of a multivector (MV) object.
%
% Syntax:
%   r = asec(obj)
%
% Description:
%   This function applies the arc secant function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the arc secant of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = asec(mv);
%   disp(r); % Displays the resultant multivector


% Computes the asec of a MV
    r=fun(obj,@(x,x_)asec(x));
end

