function r=inner_product_0_0_1(a,b)


% INNER_PRODUCT_0_0_1 - Computes the inner product of two multivectors in the (0,0,1) algebra.
%
% Syntax:
%   r = inner_product_0_0_1(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,0,1) algebra, where each input is represented with two components.
%   It returns the result as a two-element array.
%
% Input:
%   a - (1x2 array) A multivector in the (0,0,1) algebra with two components.
%   b - (1x2 array) A multivector in the (0,0,1) algebra with two components.
%
% Output:
%   r - (1x2 array) The result of the inner product, represented as a two-element array.
%
% Example:
%   a = MV([3, 5], [0, 0, 1]);
%   b = MV([4, 2], [0, 0, 1]);
%   r = inner_product_0_0_1(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2]=pCell{:};
   pCell = num2cell(b);
   [b1, b2]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1];
end


