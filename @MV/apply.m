function r= apply(obj,f)


% APPLY - Applies a function to a multivector using its matrix representation.
%
% Syntax:
%   r = apply(obj, f)
%
% Description:
%   This function takes a function defined over the real numbers and applies
%   it to a multivector by utilizing its matrix representation. The result
%   is returned as a new multivector.
%
% Input:
%   obj - (MV) The multivector on which the function is to be applied.
%   f - (function handle) A function handle representing the function to apply
%       to the components of the multivector.
%
% Output:
%   r - (MV) The resulting multivector after applying the function.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   result = apply(mv, @(x) x^2); % Applies the square function
%   disp(result); % Displays the resulting multivector
%
% Note:
%   The current implementation utilizes the function `funm`, which allows
%   the application of the function to the matrix representation of the
%   multivector. Future improvements could involve handling multivalued
%   functions more effectively.


    % Given a function defined over the reals we can apply it to a
    % multivector using its matris¡x representation
    p=funm(obj.matrix,@(x,x_)f(x));
    % TODO This should be made in a different way
    % These functions are multivaluated and we must choose the right value
    r=MV((p(:,1)).',obj.Lsignature);
    r.REPR=obj.REPR;
end


