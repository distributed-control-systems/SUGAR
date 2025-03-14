function r=inner_product_1_1_0(a,b)


% INNER_PRODUCT_1_1_0 - Computes the inner product of two multivectors in the (1,1,0) algebra.
%
% Syntax:
%   r = inner_product_1_1_0(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (1,1,0) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (1,1,0) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (1,1,0) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [1, 1, 0]);
%   b = MV([...], [1, 1, 0]);
%   r = inner_product_1_1_0(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4]=pCell{:};
   r=[a1*b1 + a2*b2 - a3*b3 + a4*b4,...
      a1*b2 + a2*b1 + a3*b4 - a4*b3,...
      a1*b3 + a3*b1 + a2*b4 - a4*b2,...
      a1*b4 + a4*b1];
end


