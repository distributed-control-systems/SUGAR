function r=acos(obj)


% ACOS - Computes the arc cosine (acos) of a multivector (MV) object.
%
% Syntax:
%   r = acos(obj)
%
% Description:
%   This function applies the arc cosine function to
%   the input multivector object and returns the result
%   as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object corresponding to the arc
%       cosine of the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = acos(mv);
%   disp(r); % Displays the resultant multivector


% Computes the acos of a MV
    r=fun(obj,@(x,x_)acos(x));
end

