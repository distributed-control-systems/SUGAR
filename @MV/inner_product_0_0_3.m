function r=inner_product_0_0_3(a,b)


% INNER_PRODUCT_0_0_3 - Computes the inner product of two multivectors in the (0,0,3) algebra.
%
% Syntax:
%   r = inner_product_0_0_3(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,0,3) algebra, where each input is represented with eight components.
%   It returns the result as an eight-element array.
%
% Input:
%   a - (1x8 array) A multivector in the (0,0,3) algebra with eight components.
%   b - (1x8 array) A multivector in the (0,0,3) algebra with eight components.
%
% Output:
%   r - (1x8 array) The result of the inner product, represented as an eight-element array.
%
% Example:
%   a = MV([1, 2, 3, 4, 5, 6, 7, 8], [0, 0, 3]);
%   b = MV([8, 7, 6, 5, 4, 3, 2, 1], [0, 0, 3]);
%   r = inner_product_0_0_3(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a4*b1,...
      a1*b5 + a5*b1,...
      a1*b6 + a6*b1,...
      a1*b7 + a7*b1,...
      a1*b8 + a8*b1];
end


