function r=cos(obj)


% COS - Computes the cosine (cos) of a multivector (MV) object.
%
% Syntax:
%   r = cos(obj)
%
% Description:
%   This function applies the cosine function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the cosine of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = cos(mv);
%   disp(r); % Displays the resultant multivector


% Computes the cos of a MV
    r=fun(obj,@(x,x_)cos(x));
end

