function r=inner_product_0_1_1(a,b)


% INNER_PRODUCT_0_1_1 - Computes the inner product of two multivectors in the (0,1,1) algebra.
%
% Syntax:
%   r = inner_product_0_1_1(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,1,1) algebra, where each input is represented with four components.
%   It returns the result as a four-element array.
%
% Input:
%   a - (MV) A multivector in the (0,1,1) algebra with four components.
%   b - (MV) A multivector in the (0,1,1) algebra with four components.
%
% Output:
%   r - (1x4 array) The result of the inner product, represented as a four-element array.
%
% Example:
%   a = MV([3, 5, 7, 9], [0, 1, 1]);
%   b = MV([4, 2, 6, 8], [0, 1, 1]);
%   r = inner_product_0_1_1(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4]=pCell{:};
   r=[a1*b1 - a2*b2,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1 - a2*b4 + a4*b2,...
      a1*b4 + a4*b1];
end


