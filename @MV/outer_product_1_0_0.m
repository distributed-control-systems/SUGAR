function r=outer_product_1_0_0(a,b)


% OUTTER_PRODUCT_1_0_0 - Computes the outer product of two multivectors in the (1,0,0) algebra.
%
% Syntax:
%   r = outer_product_1_0_0(a, b)
%
% Description:
%   This function calculates the outer product of two multivectors in the
%   (1,0,0) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (1,0,0) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (1,0,0) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the outer product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [1,0,0]);
%   b = MV([...], [1,0,0]);
%   r = outer_product_1_0_0(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2]=pCell{:};
   pCell = num2cell(b);
   [b1, b2]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1];
end


