function r=inner_product_2_1_0(a,b)


% INNER_PRODUCT_2_1_0 - Computes the inner product of two multivectors in the (2,1,0) algebra.
%
% Syntax:
%   r = inner_product_2_1_0(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (2,1,0) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (2,1,0) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (2,1,0) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [2, 1, 0]);
%   b = MV([...], [2, 1, 0]);
%   r = inner_product_2_1_0(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8]=pCell{:};
   r=[a1*b1 + a2*b2 + a3*b3 - a4*b4 - a5*b5 + a6*b6 + a7*b7 + a8*b8,...
      a1*b2 + a2*b1 - a3*b5 + a5*b3 + a4*b6 - a6*b4 + a7*b8 + a8*b7,...
      a1*b3 + a3*b1 + a2*b5 - a5*b2 + a4*b7 - a7*b4 - a6*b8 - a8*b6,...
      a1*b4 + a4*b1 + a2*b6 - a6*b2 + a3*b7 - a7*b3 - a5*b8 - a8*b5,...
      a1*b5 + a5*b1 - a4*b8 - a8*b4,...
      a1*b6 + a6*b1 - a3*b8 - a8*b3,...
      a1*b7 + a7*b1 + a2*b8 + a8*b2,...
      a1*b8 + a8*b1];
end


