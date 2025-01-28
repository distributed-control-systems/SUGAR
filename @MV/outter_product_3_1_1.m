function r=outter_product_3_1_1(a,b)


% OUTTER_PRODUCT_3_1_1 - Computes the outter product of two multivectors in the (3,1,1) algebra.
%
% Syntax:
%   r = outter_product_3_1_1(a, b)
%
% Description:
%   This function calculates the outter product of two multivectors in the
%   (3,1,1) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (3,1,1) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (3,1,1) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [3,1,1]);
%   b = MV([...], [3,1,1]);
%   r = outter_product_3_1_1(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a4*b1,...
      a1*b5 + a5*b1,...
      a1*b6 + a6*b1,...
      a2*b3 - a3*b2 + a1*b7 + a7*b1,...
      a2*b4 - a4*b2 + a1*b8 + a8*b1,...
      a2*b5 - a5*b2 + a1*b9 + a9*b1,...
      a2*b6 - a6*b2 + a1*b10 + a10*b1,...
      a3*b4 - a4*b3 + a1*b11 + a11*b1,...
      a3*b5 - a5*b3 + a1*b12 + a12*b1,...
      a3*b6 - a6*b3 + a1*b13 + a13*b1,...
      a4*b5 - a5*b4 + a1*b14 + a14*b1,...
      a4*b6 - a6*b4 + a1*b15 + a15*b1,...
      a5*b6 - a6*b5 + a1*b16 + a16*b1,...
      a4*b7 - a3*b8 + a7*b4 - a8*b3 + a2*b11 + a11*b2 + a1*b17 + a17*b1,...
      a5*b7 - a3*b9 + a7*b5 - a9*b3 + a2*b12 + a12*b2 + a1*b18 + a18*b1,...
      a6*b7 - a3*b10 + a7*b6 - a10*b3 + a2*b13 + a13*b2 + a1*b19 + a19*b1,...
      a5*b8 - a4*b9 + a8*b5 - a9*b4 + a2*b14 + a14*b2 + a1*b20 + a20*b1,...
      a6*b8 - a4*b10 + a8*b6 - a10*b4 + a2*b15 + a15*b2 + a1*b21 + a21*b1,...
      a6*b9 - a5*b10 + a9*b6 - a10*b5 + a2*b16 + a16*b2 + a1*b22 + a22*b1,...
      a5*b11 - a4*b12 + a11*b5 - a12*b4 + a3*b14 + a14*b3 + a1*b23 + a23*b1,...
      a6*b11 - a4*b13 + a11*b6 - a13*b4 + a3*b15 + a15*b3 + a1*b24 + a24*b1,...
      a6*b12 - a5*b13 + a12*b6 - a13*b5 + a3*b16 + a16*b3 + a1*b25 + a25*b1,...
      a4*b16 - a5*b15 + a6*b14 + a14*b6 - a15*b5 + a16*b4 + a1*b26 + a26*b1,...
      a9*b11 - a8*b12 + a11*b9 - a12*b8 + a7*b14 + a14*b7 + a4*b18 - a5*b17 + a17*b5 - a18*b4 - a3*b20 + a20*b3 + a2*b23 - a23*b2 + a1*b27 + a27*b1,...
      a10*b11 - a8*b13 + a11*b10 - a13*b8 + a7*b15 + a15*b7 + a4*b19 - a6*b17 + a17*b6 - a19*b4 - a3*b21 + a21*b3 + a2*b24 - a24*b2 + a1*b28 + a28*b1,...
      a10*b12 - a9*b13 + a12*b10 - a13*b9 + a7*b16 + a16*b7 + a5*b19 - a6*b18 + a18*b6 - a19*b5 - a3*b22 + a22*b3 + a2*b25 - a25*b2 + a1*b29 + a29*b1,...
      a8*b16 - a9*b15 + a10*b14 + a14*b10 - a15*b9 + a16*b8 - a4*b22 + a5*b21 - a6*b20 + a20*b6 - a21*b5 + a22*b4 + a2*b26 - a26*b2 + a1*b30 + a30*b1,...
      a11*b16 - a12*b15 + a13*b14 + a14*b13 - a15*b12 + a16*b11 + a3*b26 - a4*b25 + a5*b24 - a6*b23 + a23*b6 - a24*b5 + a25*b4 - a26*b3 + a1*b31 + a31*b1,...
      a1*b32 + a2*b31 - a3*b30 + a4*b29 - a5*b28 + a6*b27 + a7*b26 - a8*b25 + a9*b24 - a10*b23 + a11*b22 - a12*b21 + a13*b20 + a14*b19 - a15*b18 + a16*b17 + a17*b16 - a18*b15 + a19*b14 + a20*b13 - a21*b12 + a22*b11 - a23*b10 + a24*b9 - a25*b8 + a26*b7 + a27*b6 - a28*b5 + a29*b4 - a30*b3 + a31*b2 + a32*b1];
end


