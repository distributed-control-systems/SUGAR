function r=log(obj)


% LOG - Computes the natural logarithm (base e) of a multivector.
%
% Syntax:
%   r = log(obj)
%
% Description:
%   This function calculates the natural logarithm of a multivector
%   by applying the logarithm function to each coefficient of the
%   multivector.
%
% Input:
%   obj - (MV) The multivector object for which the logarithm is to be computed.
%
% Output:
%   r - (MV) The resulting multivector after applying the logarithm.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   log_mv = log(mv);  % Computes the natural logarithm of the multivector
%   disp(log_mv); % Displays the resulting multivector
%
% Note:
%   The function utilizes a generic function application (`fun`) to
%   apply the logarithm to each element of the multivector's coefficients.


% Base e logarithm of a MV
r=fun(obj,@(x,x_)log(x));
end
