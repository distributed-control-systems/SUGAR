function r=outter_product_1_3_0(a,b)


% OUTTER_PRODUCT_1_3_0 - Computes the outter product of two multivectors in the (1,3,0) algebra.
%
% Syntax:
%   r = outter_product_1_3_0(a, b)
%
% Description:
%   This function calculates the outter product of two multivectors in the
%   (1,3,0) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (1,3,0) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (1,3,0) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [1,3,0]);
%   b = MV([...], [1,3,0]);
%   r = outter_product_1_3_0(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a4*b1,...
      a1*b5 + a5*b1,...
      a2*b3 - a3*b2 + a1*b6 + a6*b1,...
      a2*b4 - a4*b2 + a1*b7 + a7*b1,...
      a2*b5 - a5*b2 + a1*b8 + a8*b1,...
      a3*b4 - a4*b3 + a1*b9 + a9*b1,...
      a3*b5 - a5*b3 + a1*b10 + a10*b1,...
      a4*b5 - a5*b4 + a1*b11 + a11*b1,...
      a4*b6 - a3*b7 + a6*b4 - a7*b3 + a2*b9 + a9*b2 + a1*b12 + a12*b1,...
      a5*b6 - a3*b8 + a6*b5 - a8*b3 + a2*b10 + a10*b2 + a1*b13 + a13*b1,...
      a5*b7 - a4*b8 + a7*b5 - a8*b4 + a2*b11 + a11*b2 + a1*b14 + a14*b1,...
      a3*b11 - a4*b10 + a5*b9 + a9*b5 - a10*b4 + a11*b3 + a1*b15 + a15*b1,...
      a1*b16 + a2*b15 - a3*b14 + a4*b13 - a5*b12 + a6*b11 - a7*b10 + a8*b9 + a9*b8 - a10*b7 + a11*b6 + a12*b5 - a13*b4 + a14*b3 - a15*b2 + a16*b1];
end


