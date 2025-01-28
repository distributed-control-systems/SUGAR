function r=acosh(obj)


% ACOSH - Computes the arc hyperbolic cosine (acosh) of a multivector (MV) object.
%
% Syntax:
%   r = acosh(obj)
%
% Description:
%   This function applies the arc hyperbolic cosine function to the
%   input multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object correspondingo to the arc
%       hyperbolic cosine of the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = acosh(mv);
%   disp(r); % Displays the resultant multivector


% Computes the acosh of a MV
    r=fun(obj,@(x,x_)acosh(x));
end

