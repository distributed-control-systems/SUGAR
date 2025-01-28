function r=csc(obj)


% CSC - Computes the cosecant (csc) of a multivector (MV) object.
%
% Syntax:
%   r = csc(obj)
%
% Description:
%   This function applies the cosecant function to the input
%   multivector object and returns the result as a new MV object.
%
% Input:
%   obj - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object that is the cosecant of
%       the input multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = csc(mv);
%   disp(r); % Displays the resultant multivector


% Computes the csc of a MV
    r=fun(obj,@(x,x_)csc(x));
end

