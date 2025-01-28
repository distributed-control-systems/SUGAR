function r=inner_product_0_0_0(a,b)


% INNER_PRODUCT_0_0_0 - Computes the inner product of two multivectors in the (0,0,0) algebra.
%
% Syntax:
%   r = inner_product_0_0_0(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,0,0) algebra, where both inputs are scalars. It returns the product
%   as a scalar result.
%
% Input:
%   a - (1x1 array) A multivector in the (0,0,0) algebra.
%   b - (1x1 array) A multivector in the (0,0,0) algebra.
%0
% Output:
%   r - (1x1 array) The result of the inner product, computed as a * b.
%
% Example:
%   a = MV([3], [0, 0, 0]);
%   b = MV([4], [0, 0, 0]);
%   r = inner_product_0_0_0(a.vector, b.vector);
%   disp(r); % Displays 12


   pCell = num2cell(a);
   a1=pCell{:};
   pCell = num2cell(b);
   b1=pCell{:};
   r=a1*b1;
end


