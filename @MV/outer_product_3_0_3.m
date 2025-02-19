function r=outer_product_3_0_3(a,b)


% OUTTER_PRODUCT_3_0_3 - Computes the outer product of two multivectors in the (3,0,3) algebra.
%
% Syntax:
%   r = outer_product_3_0_3(a, b)
%
% Description:
%   This function calculates the outer product of two multivectors in the
%   (3,0,3) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (3,0,3) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (3,0,3) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the outer product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [3,0,3]);
%   b = MV([...], [3,0,3]);
%   r = outer_product_3_0_3(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32, a33, a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44, a45, a46, a47, a48, a49, a50, a51, a52, a53, a54, a55, a56, a57, a58, a59, a60, a61, a62, a63, a64]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33, b34, b35, b36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47, b48, b49, b50, b51, b52, b53, b54, b55, b56, b57, b58, b59, b60, b61, b62, b63, b64]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1,...
      a1*b4 + a4*b1,...
      a1*b5 + a5*b1,...
      a1*b6 + a6*b1,...
      a1*b7 + a7*b1,...
      a2*b3 - a3*b2 + a1*b8 + a8*b1,...
      a2*b4 - a4*b2 + a1*b9 + a9*b1,...
      a2*b5 - a5*b2 + a1*b10 + a10*b1,...
      a2*b6 - a6*b2 + a1*b11 + a11*b1,...
      a2*b7 - a7*b2 + a1*b12 + a12*b1,...
      a3*b4 - a4*b3 + a1*b13 + a13*b1,...
      a3*b5 - a5*b3 + a1*b14 + a14*b1,...
      a3*b6 - a6*b3 + a1*b15 + a15*b1,...
      a3*b7 - a7*b3 + a1*b16 + a16*b1,...
      a4*b5 - a5*b4 + a1*b17 + a17*b1,...
      a4*b6 - a6*b4 + a1*b18 + a18*b1,...
      a4*b7 - a7*b4 + a1*b19 + a19*b1,...
      a5*b6 - a6*b5 + a1*b20 + a20*b1,...
      a5*b7 - a7*b5 + a1*b21 + a21*b1,...
      a6*b7 - a7*b6 + a1*b22 + a22*b1,...
      a4*b8 - a3*b9 + a8*b4 - a9*b3 + a2*b13 + a13*b2 + a1*b23 + a23*b1,...
      a5*b8 - a3*b10 + a8*b5 - a10*b3 + a2*b14 + a14*b2 + a1*b24 + a24*b1,...
      a6*b8 - a3*b11 + a8*b6 - a11*b3 + a2*b15 + a15*b2 + a1*b25 + a25*b1,...
      a7*b8 - a3*b12 + a8*b7 - a12*b3 + a2*b16 + a16*b2 + a1*b26 + a26*b1,...
      a5*b9 - a4*b10 + a9*b5 - a10*b4 + a2*b17 + a17*b2 + a1*b27 + a27*b1,...
      a6*b9 - a4*b11 + a9*b6 - a11*b4 + a2*b18 + a18*b2 + a1*b28 + a28*b1,...
      a7*b9 - a4*b12 + a9*b7 - a12*b4 + a2*b19 + a19*b2 + a1*b29 + a29*b1,...
      a6*b10 - a5*b11 + a10*b6 - a11*b5 + a2*b20 + a20*b2 + a1*b30 + a30*b1,...
      a7*b10 - a5*b12 + a10*b7 - a12*b5 + a2*b21 + a21*b2 + a1*b31 + a31*b1,...
      a7*b11 - a6*b12 + a11*b7 - a12*b6 + a2*b22 + a22*b2 + a1*b32 + a32*b1,...
      a5*b13 - a4*b14 + a13*b5 - a14*b4 + a3*b17 + a17*b3 + a1*b33 + a33*b1,...
      a6*b13 - a4*b15 + a13*b6 - a15*b4 + a3*b18 + a18*b3 + a1*b34 + a34*b1,...
      a7*b13 - a4*b16 + a13*b7 - a16*b4 + a3*b19 + a19*b3 + a1*b35 + a35*b1,...
      a6*b14 - a5*b15 + a14*b6 - a15*b5 + a3*b20 + a20*b3 + a1*b36 + a36*b1,...
      a7*b14 - a5*b16 + a14*b7 - a16*b5 + a3*b21 + a21*b3 + a1*b37 + a37*b1,...
      a7*b15 - a6*b16 + a15*b7 - a16*b6 + a3*b22 + a22*b3 + a1*b38 + a38*b1,...
      a6*b17 - a5*b18 + a17*b6 - a18*b5 + a4*b20 + a20*b4 + a1*b39 + a39*b1,...
      a7*b17 - a5*b19 + a17*b7 - a19*b5 + a4*b21 + a21*b4 + a1*b40 + a40*b1,...
      a7*b18 - a6*b19 + a18*b7 - a19*b6 + a4*b22 + a22*b4 + a1*b41 + a41*b1,...
      a5*b22 - a6*b21 + a7*b20 + a20*b7 - a21*b6 + a22*b5 + a1*b42 + a42*b1,...
      a10*b13 - a9*b14 + a13*b10 - a14*b9 + a8*b17 + a17*b8 + a4*b24 - a5*b23 + a23*b5 - a24*b4 - a3*b27 + a27*b3 + a2*b33 - a33*b2 + a1*b43 + a43*b1,...
      a11*b13 - a9*b15 + a13*b11 - a15*b9 + a8*b18 + a18*b8 + a4*b25 - a6*b23 + a23*b6 - a25*b4 - a3*b28 + a28*b3 + a2*b34 - a34*b2 + a1*b44 + a44*b1,...
      a12*b13 - a9*b16 + a13*b12 - a16*b9 + a8*b19 + a19*b8 + a4*b26 - a7*b23 + a23*b7 - a26*b4 - a3*b29 + a29*b3 + a2*b35 - a35*b2 + a1*b45 + a45*b1,...
      a11*b14 - a10*b15 + a14*b11 - a15*b10 + a8*b20 + a20*b8 + a5*b25 - a6*b24 + a24*b6 - a25*b5 - a3*b30 + a30*b3 + a2*b36 - a36*b2 + a1*b46 + a46*b1,...
      a12*b14 - a10*b16 + a14*b12 - a16*b10 + a8*b21 + a21*b8 + a5*b26 - a7*b24 + a24*b7 - a26*b5 - a3*b31 + a31*b3 + a2*b37 - a37*b2 + a1*b47 + a47*b1,...
      a12*b15 - a11*b16 + a15*b12 - a16*b11 + a8*b22 + a22*b8 + a6*b26 - a7*b25 + a25*b7 - a26*b6 - a3*b32 + a32*b3 + a2*b38 - a38*b2 + a1*b48 + a48*b1,...
      a11*b17 - a10*b18 + a17*b11 - a18*b10 + a9*b20 + a20*b9 + a5*b28 - a6*b27 + a27*b6 - a28*b5 - a4*b30 + a30*b4 + a2*b39 - a39*b2 + a1*b49 + a49*b1,...
      a12*b17 - a10*b19 + a17*b12 - a19*b10 + a9*b21 + a21*b9 + a5*b29 - a7*b27 + a27*b7 - a29*b5 - a4*b31 + a31*b4 + a2*b40 - a40*b2 + a1*b50 + a50*b1,...
      a12*b18 - a11*b19 + a18*b12 - a19*b11 + a9*b22 + a22*b9 + a6*b29 - a7*b28 + a28*b7 - a29*b6 - a4*b32 + a32*b4 + a2*b41 - a41*b2 + a1*b51 + a51*b1,...
      a10*b22 - a11*b21 + a12*b20 + a20*b12 - a21*b11 + a22*b10 - a5*b32 + a6*b31 - a7*b30 + a30*b7 - a31*b6 + a32*b5 + a2*b42 - a42*b2 + a1*b52 + a52*b1,...
      a15*b17 - a14*b18 + a17*b15 - a18*b14 + a13*b20 + a20*b13 + a5*b34 - a6*b33 + a33*b6 - a34*b5 - a4*b36 + a36*b4 + a3*b39 - a39*b3 + a1*b53 + a53*b1,...
      a16*b17 - a14*b19 + a17*b16 - a19*b14 + a13*b21 + a21*b13 + a5*b35 - a7*b33 + a33*b7 - a35*b5 - a4*b37 + a37*b4 + a3*b40 - a40*b3 + a1*b54 + a54*b1,...
      a16*b18 - a15*b19 + a18*b16 - a19*b15 + a13*b22 + a22*b13 + a6*b35 - a7*b34 + a34*b7 - a35*b6 - a4*b38 + a38*b4 + a3*b41 - a41*b3 + a1*b55 + a55*b1,...
      a14*b22 - a15*b21 + a16*b20 + a20*b16 - a21*b15 + a22*b14 - a5*b38 + a6*b37 - a7*b36 + a36*b7 - a37*b6 + a38*b5 + a3*b42 - a42*b3 + a1*b56 + a56*b1,...
      a17*b22 - a18*b21 + a19*b20 + a20*b19 - a21*b18 + a22*b17 + a4*b42 - a5*b41 + a6*b40 - a7*b39 + a39*b7 - a40*b6 + a41*b5 - a42*b4 + a1*b57 + a57*b1,...
      a15*b27 - a14*b28 + a17*b25 - a18*b24 - a24*b18 + a25*b17 + a27*b15 - a28*b14 + a13*b30 + a20*b23 + a23*b20 + a30*b13 + a10*b34 - a11*b33 - a33*b11 + a34*b10 - a9*b36 - a36*b9 + a8*b39 + a39*b8 - a5*b44 + a6*b43 + a43*b6 - a44*b5 + a4*b46 + a46*b4 - a3*b49 - a49*b3 + a2*b53 + a53*b2 + a1*b58 + a58*b1,...
      a16*b27 - a14*b29 + a17*b26 - a19*b24 - a24*b19 + a26*b17 + a27*b16 - a29*b14 + a13*b31 + a21*b23 + a23*b21 + a31*b13 + a10*b35 - a12*b33 - a33*b12 + a35*b10 - a9*b37 - a37*b9 + a8*b40 + a40*b8 - a5*b45 + a7*b43 + a43*b7 - a45*b5 + a4*b47 + a47*b4 - a3*b50 - a50*b3 + a2*b54 + a54*b2 + a1*b59 + a59*b1,...
      a16*b28 - a15*b29 + a18*b26 - a19*b25 - a25*b19 + a26*b18 + a28*b16 - a29*b15 + a13*b32 + a22*b23 + a23*b22 + a32*b13 + a11*b35 - a12*b34 - a34*b12 + a35*b11 - a9*b38 - a38*b9 + a8*b41 + a41*b8 - a6*b45 + a7*b44 + a44*b7 - a45*b6 + a4*b48 + a48*b4 - a3*b51 - a51*b3 + a2*b55 + a55*b2 + a1*b60 + a60*b1,...
      a14*b32 - a15*b31 + a16*b30 + a20*b26 - a21*b25 + a22*b24 + a24*b22 - a25*b21 + a26*b20 + a30*b16 - a31*b15 + a32*b14 - a10*b38 + a11*b37 - a12*b36 - a36*b12 + a37*b11 - a38*b10 + a8*b42 + a42*b8 + a5*b48 - a6*b47 + a7*b46 + a46*b7 - a47*b6 + a48*b5 - a3*b52 - a52*b3 + a2*b56 + a56*b2 + a1*b61 + a61*b1,...
      a17*b32 - a18*b31 + a19*b30 + a20*b29 - a21*b28 + a22*b27 + a27*b22 - a28*b21 + a29*b20 + a30*b19 - a31*b18 + a32*b17 + a9*b42 - a10*b41 + a11*b40 - a12*b39 - a39*b12 + a40*b11 - a41*b10 + a42*b9 - a4*b52 + a5*b51 - a6*b50 + a7*b49 + a49*b7 - a50*b6 + a51*b5 - a52*b4 + a2*b57 + a57*b2 + a1*b62 + a62*b1,...
      a13*b42 - a14*b41 + a15*b40 - a16*b39 + a17*b38 - a18*b37 + a19*b36 + a20*b35 - a21*b34 + a22*b33 + a33*b22 - a34*b21 + a35*b20 + a36*b19 - a37*b18 + a38*b17 - a39*b16 + a40*b15 - a41*b14 + a42*b13 + a3*b57 - a4*b56 + a5*b55 - a6*b54 + a7*b53 + a53*b7 - a54*b6 + a55*b5 - a56*b4 + a57*b3 + a1*b63 + a63*b1,...
      a1*b64 + a2*b63 - a3*b62 + a4*b61 - a5*b60 + a6*b59 - a7*b58 + a8*b57 - a9*b56 + a10*b55 - a11*b54 + a12*b53 + a13*b52 - a14*b51 + a15*b50 - a16*b49 + a17*b48 - a18*b47 + a19*b46 + a20*b45 - a21*b44 + a22*b43 + a23*b42 - a24*b41 + a25*b40 - a26*b39 + a27*b38 - a28*b37 + a29*b36 + a30*b35 - a31*b34 + a32*b33 - a33*b32 + a34*b31 - a35*b30 - a36*b29 + a37*b28 - a38*b27 + a39*b26 - a40*b25 + a41*b24 - a42*b23 + a43*b22 - a44*b21 + a45*b20 + a46*b19 - a47*b18 + a48*b17 - a49*b16 + a50*b15 - a51*b14 + a52*b13 + a53*b12 - a54*b11 + a55*b10 - a56*b9 + a57*b8 + a58*b7 - a59*b6 + a60*b5 - a61*b4 + a62*b3 - a63*b2 + a64*b1];
end


