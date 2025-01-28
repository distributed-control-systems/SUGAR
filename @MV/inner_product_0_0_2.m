function r=inner_product_0_0_2(a,b)


% INNER_PRODUCT_0_0_2 - Computes the inner product of two multivectors in the (0,0,2) algebra.
%
% Syntax:
%   r = inner_product_0_0_2(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,0,2) algebra, where each input is represented with four components.
%   It returns the result as a four-element array.
%
% Input:
%   a - (1x4 array) A multivector in the (0,0,2) algebra with four components.
%   b - (1x4 array) A multivector in the (0,0,2) algebra with four components.
%
% Output:
%   r - (1x4 array) The result of the inner product, represented as a four-element array.
%
% Example:
%   a = MV([3, 5, 7, 9], [0, 0, 2]);
%   b = MV([4, 2, 6, 8], [0, 0, 2]);
%   r = inner_product_0_0_2(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a4*b1];
end


