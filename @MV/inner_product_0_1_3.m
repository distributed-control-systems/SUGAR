function r=inner_product_0_1_3(a,b)


% INNER_PRODUCT_0_1_3 - Computes the inner product of two multivectors in the (0,1,3) algebra.
%
% Syntax:
%   r = inner_product_0_1_3(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,1,3) algebra, where each input is represented with sixteen components.
%   It returns the result as a sixteen-element array.
%
% Input:
%   a - (MV) A multivector in the (0,1,3) algebra with sixteen components.
%   b - (MV) A multivector in the (0,1,3) algebra with sixteen components.
%
% Output:
%   r - (1x16 array) The result of the inner product, represented as a sixteen-element array.
%
% Example:
%   a = MV([3, 5, 7, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], [0, 1, 3]);
%   b = MV([4, 2, 6, 8, 1, 5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17], [0, 1, 3]);
%   r = inner_product_0_1_3(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16]=pCell{:};
   r=[a1*b1 - a2*b2,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1 - a2*b6 + a6*b2,...
      a1*b4 + a4*b1 - a2*b7 + a7*b2,...
      a1*b5 + a5*b1 - a2*b8 + a8*b2,...
      a1*b6 + a6*b1,...
      a1*b7 + a7*b1,...
      a1*b8 + a8*b1,...
      a1*b9 + a9*b1 - a2*b12 - a12*b2,...
      a1*b10 + a10*b1 - a2*b13 - a13*b2,...
      a1*b11 + a11*b1 - a2*b14 - a14*b2,...
      a1*b12 + a12*b1,...
      a1*b13 + a13*b1,...
      a1*b14 + a14*b1,...
      a1*b15 + a15*b1 - a2*b16 + a16*b2,...
      a1*b16 + a16*b1];
end


