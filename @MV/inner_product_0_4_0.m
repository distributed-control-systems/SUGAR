function r=inner_product_0_4_0(a,b)


% INNER_PRODUCT_0_4_0 - Computes the inner product of two multivectors in the (0,4,0) algebra.
%
% Syntax:
%   r = inner_product_0_4_0(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,4,0) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (0,4,0) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (0,4,0) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [0, 4, 0]);
%   b = MV([...], [0, 4, 0]);
%   r = inner_product_0_4_0(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16]=pCell{:};
   r=[a1*b1 - a2*b2 - a3*b3 - a4*b4 - a5*b5 - a6*b6 - a7*b7 - a8*b8 - a9*b9 - a10*b10 - a11*b11 + a12*b12 + a13*b13 + a14*b14 + a15*b15 + a16*b16,...
      a1*b2 + a2*b1 + a3*b6 - a6*b3 + a4*b7 - a7*b4 + a5*b8 - a8*b5 - a9*b12 - a12*b9 - a10*b13 - a13*b10 - a11*b14 - a14*b11 - a15*b16 + a16*b15,...
      a1*b3 + a3*b1 - a2*b6 + a6*b2 + a4*b9 - a9*b4 + a5*b10 - a10*b5 + a7*b12 + a12*b7 + a8*b13 + a13*b8 - a11*b15 - a15*b11 + a14*b16 - a16*b14,...
      a1*b4 + a4*b1 - a2*b7 + a7*b2 - a3*b9 + a9*b3 + a5*b11 - a11*b5 - a6*b12 - a12*b6 + a8*b14 + a14*b8 + a10*b15 + a15*b10 - a13*b16 + a16*b13,...
      a1*b5 + a5*b1 - a2*b8 + a8*b2 - a3*b10 + a10*b3 - a4*b11 + a11*b4 - a6*b13 - a13*b6 - a7*b14 - a14*b7 - a9*b15 - a15*b9 + a12*b16 - a16*b12,...
      a1*b6 + a6*b1 - a4*b12 - a12*b4 - a5*b13 - a13*b5 - a11*b16 - a16*b11,...
      a1*b7 + a7*b1 + a3*b12 + a12*b3 - a5*b14 - a14*b5 + a10*b16 + a16*b10,...
      a1*b8 + a8*b1 + a3*b13 + a13*b3 + a4*b14 + a14*b4 - a9*b16 - a16*b9,...
      a1*b9 + a9*b1 - a2*b12 - a12*b2 - a5*b15 - a15*b5 - a8*b16 - a16*b8,...
      a1*b10 + a10*b1 - a2*b13 - a13*b2 + a4*b15 + a15*b4 + a7*b16 + a16*b7,...
      a1*b11 + a11*b1 - a2*b14 - a14*b2 - a3*b15 - a15*b3 - a6*b16 - a16*b6,...
      a1*b12 + a12*b1 + a5*b16 - a16*b5,...
      a1*b13 + a13*b1 - a4*b16 + a16*b4,...
      a1*b14 + a14*b1 + a3*b16 - a16*b3,...
      a1*b15 + a15*b1 - a2*b16 + a16*b2,...
      a1*b16 + a16*b1];
end


