function r=outer_product_0_1_1(a,b)


% OUTTER_PRODUCT_0_1_1 - Computes the outer product of two multivectors in the (0,1,1) algebra.
%
% Syntax:
%   r = outer_product_0_1_1(a, b)
%
% Description:
%   This function calculates the outer product of two multivectors in the
%   (0,1,1) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (0,1,1) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (0,1,1) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the outer product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [0,1,1]);
%   b = MV([...], [0,1,1]);
%   r = outer_product_0_1_1(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a2*b3 - a3*b2 + a4*b1];
end


