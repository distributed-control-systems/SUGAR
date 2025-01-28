function r=inner_product_0_1_2(a,b)


% INNER_PRODUCT_0_1_2 - Computes the inner product of two multivectors in the (0,1,2) algebra.
%
% Syntax:
%   r = inner_product_0_1_2(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,1,2) algebra, where each input is represented with eight components.
%   It returns the result as an eight-element array.
%
% Input:
%   a - (MV) A multivector in the (0,1,2) algebra with eight components.
%   b - (MV) A multivector in the (0,1,2) algebra with eight components.
%
% Output:
%   r - (1x8 array) The result of the inner product, represented as an eight-element array.
%
% Example:
%   a = MV([3, 5, 7, 9, 1, 2, 3, 4], [0, 1, 2]);
%   b = MV([4, 2, 6, 8, 1, 5, 7, 9], [0, 1, 2]);
%   r = inner_product_0_1_2(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8]=pCell{:};
   r=[a1*b1 - a2*b2,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1 - a2*b5 + a5*b2,...
      a1*b4 + a4*b1 - a2*b6 + a6*b2,...
      a1*b5 + a5*b1,...
      a1*b6 + a6*b1,...
      a1*b7 + a7*b1 - a2*b8 - a8*b2,...
      a1*b8 + a8*b1];
end


