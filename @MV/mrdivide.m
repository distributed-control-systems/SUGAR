function r=mrdivide(A,B)


% MRDIVIDE - Performs matrix right division for multivectors.
%
% Syntax:
%   r = mrdivide(A, B)
%
% Description:
%   This function implements right division for multivectors or
%   scalar values. It allows the user to divide a multivector or matrix
%   of multivectors by another multivector or scalar.
%
% Input:
%   A - (MV or double) The numerator multivector or scalar.
%   B - (MV or double) The denominator multivector or scalar.
%
% Output:
%   r - (MV) The result of the division operation.
%
% Example:
%   mv1 = MV([2, 4], [1, 0]);
%   mv2 = MV([1, 2], [1, 0]);
%   result = mrdivide(mv1, mv2);  % Divides mv1 by mv2
%   disp(result); % Displays the resulting multivector
%
% Note:
%   The function supports division by a scalar (double) and by a
%   multivector. When dividing by a multivector, the function computes
%   the inverse of the multivector before performing the multiplication.


if class(B)=="double"
        r=1/B*A;
elseif class(B)=="MV"

    r=A*(B)^-1;
else
    error("something went wrong");
end
end
