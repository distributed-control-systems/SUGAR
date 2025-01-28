function r=inner_product_1_0_3(a,b)


% INNER_PRODUCT_1_0_3 - Computes the inner product of two multivectors in the (1,0,3) algebra.
%
% Syntax:
%   r = inner_product_1_0_3(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (1,0,3) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (1,0,3) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (1,0,3) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [1, 0, 3]);
%   b = MV([...], [1, 0, 3]);
%   r = inner_product_1_0_3(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16]=pCell{:};
   r=[a1*b1 + a2*b2,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1 + a2*b6 - a6*b2,...
      a1*b4 + a4*b1 + a2*b7 - a7*b2,...
      a1*b5 + a5*b1 + a2*b8 - a8*b2,...
      a1*b6 + a6*b1,...
      a1*b7 + a7*b1,...
      a1*b8 + a8*b1,...
      a1*b9 + a9*b1 + a2*b12 + a12*b2,...
      a1*b10 + a10*b1 + a2*b13 + a13*b2,...
      a1*b11 + a11*b1 + a2*b14 + a14*b2,...
      a1*b12 + a12*b1,...
      a1*b13 + a13*b1,...
      a1*b14 + a14*b1,...
      a1*b15 + a15*b1 + a2*b16 - a16*b2,...
      a1*b16 + a16*b1];
end


