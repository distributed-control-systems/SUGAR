function r=inner_product_0_3_3(a,b)


% INNER_PRODUCT_0_3_3 - Computes the inner product of two multivectors in the (0,3,3) algebra.
%
% Syntax:
%   r = inner_product_0_3_3(a, b)
%
% Description:
%   This function calculates the inner product of two multivectors in the
%   (0,3,3) algebra, where each input is represented with a specific number of components.
%   It returns the result as an array of specified length.
%
% Input:
%   a - (MV) A multivector in the (0,3,3) algebra with a specific number of components. Accessed as a.vector.
%   b - (MV) A multivector in the (0,3,3) algebra with a specific number of components. Accessed as b.vector.
%
% Output:
%   r - (1xN array) The result of the inner product, represented as an array of specified length.
%
% Example:
%   a = MV([...], [0, 3, 3]);
%   b = MV([...], [0, 3, 3]);
%   r = inner_product_0_3_3(a.vector, b.vector);
%   disp(r); % Displays the result


   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32, a33, a34, a35, a36, a37, a38, a39, a40, a41, a42, a43, a44, a45, a46, a47, a48, a49, a50, a51, a52, a53, a54, a55, a56, a57, a58, a59, a60, a61, a62, a63, a64]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33, b34, b35, b36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47, b48, b49, b50, b51, b52, b53, b54, b55, b56, b57, b58, b59, b60, b61, b62, b63, b64]=pCell{:};
   r=[a1*b1 - a2*b2 - a3*b3 - a4*b4 - a8*b8 - a9*b9 - a13*b13 + a23*b23,...
      a1*b2 + a2*b1 + a3*b8 - a8*b3 + a4*b9 - a9*b4 - a13*b23 - a23*b13,...
      a1*b3 + a3*b1 - a2*b8 + a8*b2 + a4*b13 - a13*b4 + a9*b23 + a23*b9,...
      a1*b4 + a4*b1 - a2*b9 + a9*b2 - a3*b13 + a13*b3 - a8*b23 - a23*b8,...
      a1*b5 + a5*b1 - a2*b10 + a10*b2 - a3*b14 + a14*b3 - a4*b17 + a17*b4 - a8*b24 - a24*b8 - a9*b27 - a27*b9 - a13*b33 - a33*b13 + a23*b43 - a43*b23,...
      a1*b6 + a6*b1 - a2*b11 + a11*b2 - a3*b15 + a15*b3 - a4*b18 + a18*b4 - a8*b25 - a25*b8 - a9*b28 - a28*b9 - a13*b34 - a34*b13 + a23*b44 - a44*b23,...
      a1*b7 + a7*b1 - a2*b12 + a12*b2 - a3*b16 + a16*b3 - a4*b19 + a19*b4 - a8*b26 - a26*b8 - a9*b29 - a29*b9 - a13*b35 - a35*b13 + a23*b45 - a45*b23,...
      a1*b8 + a8*b1 - a4*b23 - a23*b4,...
      a1*b9 + a9*b1 + a3*b23 + a23*b3,...
      a1*b10 + a10*b1 + a3*b24 + a24*b3 + a4*b27 + a27*b4 - a13*b43 - a43*b13,...
      a1*b11 + a11*b1 + a3*b25 + a25*b3 + a4*b28 + a28*b4 - a13*b44 - a44*b13,...
      a1*b12 + a12*b1 + a3*b26 + a26*b3 + a4*b29 + a29*b4 - a13*b45 - a45*b13,...
      a1*b13 + a13*b1 - a2*b23 - a23*b2,...
      a1*b14 + a14*b1 - a2*b24 - a24*b2 + a4*b33 + a33*b4 + a9*b43 + a43*b9,...
      a1*b15 + a15*b1 - a2*b25 - a25*b2 + a4*b34 + a34*b4 + a9*b44 + a44*b9,...
      a1*b16 + a16*b1 - a2*b26 - a26*b2 + a4*b35 + a35*b4 + a9*b45 + a45*b9,...
      a1*b17 + a17*b1 - a2*b27 - a27*b2 - a3*b33 - a33*b3 - a8*b43 - a43*b8,...
      a1*b18 + a18*b1 - a2*b28 - a28*b2 - a3*b34 - a34*b3 - a8*b44 - a44*b8,...
      a1*b19 + a19*b1 - a2*b29 - a29*b2 - a3*b35 - a35*b3 - a8*b45 - a45*b8,...
      a1*b20 + a20*b1 - a2*b30 - a30*b2 - a3*b36 - a36*b3 - a4*b39 - a39*b4 - a8*b46 - a46*b8 - a9*b49 - a49*b9 - a13*b53 - a53*b13 + a23*b58 + a58*b23,...
      a1*b21 + a21*b1 - a2*b31 - a31*b2 - a3*b37 - a37*b3 - a4*b40 - a40*b4 - a8*b47 - a47*b8 - a9*b50 - a50*b9 - a13*b54 - a54*b13 + a23*b59 + a59*b23,...
      a1*b22 + a22*b1 - a2*b32 - a32*b2 - a3*b38 - a38*b3 - a4*b41 - a41*b4 - a8*b48 - a48*b8 - a9*b51 - a51*b9 - a13*b55 - a55*b13 + a23*b60 + a60*b23,...
      a1*b23 + a23*b1,...
      a1*b24 + a24*b1 - a4*b43 + a43*b4,...
      a1*b25 + a25*b1 - a4*b44 + a44*b4,...
      a1*b26 + a26*b1 - a4*b45 + a45*b4,...
      a1*b27 + a27*b1 + a3*b43 - a43*b3,...
      a1*b28 + a28*b1 + a3*b44 - a44*b3,...
      a1*b29 + a29*b1 + a3*b45 - a45*b3,...
      a1*b30 + a30*b1 + a3*b46 - a46*b3 + a4*b49 - a49*b4 - a13*b58 - a58*b13,...
      a1*b31 + a31*b1 + a3*b47 - a47*b3 + a4*b50 - a50*b4 - a13*b59 - a59*b13,...
      a1*b32 + a32*b1 + a3*b48 - a48*b3 + a4*b51 - a51*b4 - a13*b60 - a60*b13,...
      a1*b33 + a33*b1 - a2*b43 + a43*b2,...
      a1*b34 + a34*b1 - a2*b44 + a44*b2,...
      a1*b35 + a35*b1 - a2*b45 + a45*b2,...
      a1*b36 + a36*b1 - a2*b46 + a46*b2 + a4*b53 - a53*b4 + a9*b58 + a58*b9,...
      a1*b37 + a37*b1 - a2*b47 + a47*b2 + a4*b54 - a54*b4 + a9*b59 + a59*b9,...
      a1*b38 + a38*b1 - a2*b48 + a48*b2 + a4*b55 - a55*b4 + a9*b60 + a60*b9,...
      a1*b39 + a39*b1 - a2*b49 + a49*b2 - a3*b53 + a53*b3 - a8*b58 - a58*b8,...
      a1*b40 + a40*b1 - a2*b50 + a50*b2 - a3*b54 + a54*b3 - a8*b59 - a59*b8,...
      a1*b41 + a41*b1 - a2*b51 + a51*b2 - a3*b55 + a55*b3 - a8*b60 - a60*b8,...
      a1*b42 + a42*b1 - a2*b52 + a52*b2 - a3*b56 + a56*b3 - a4*b57 + a57*b4 - a8*b61 - a61*b8 - a9*b62 - a62*b9 - a13*b63 - a63*b13 + a23*b64 - a64*b23,...
      a1*b43 + a43*b1,...
      a1*b44 + a44*b1,...
      a1*b45 + a45*b1,...
      a1*b46 + a46*b1 - a4*b58 - a58*b4,...
      a1*b47 + a47*b1 - a4*b59 - a59*b4,...
      a1*b48 + a48*b1 - a4*b60 - a60*b4,...
      a1*b49 + a49*b1 + a3*b58 + a58*b3,...
      a1*b50 + a50*b1 + a3*b59 + a59*b3,...
      a1*b51 + a51*b1 + a3*b60 + a60*b3,...
      a1*b52 + a52*b1 + a3*b61 + a61*b3 + a4*b62 + a62*b4 - a13*b64 - a64*b13,...
      a1*b53 + a53*b1 - a2*b58 - a58*b2,...
      a1*b54 + a54*b1 - a2*b59 - a59*b2,...
      a1*b55 + a55*b1 - a2*b60 - a60*b2,...
      a1*b56 + a56*b1 - a2*b61 - a61*b2 + a4*b63 + a63*b4 + a9*b64 + a64*b9,...
      a1*b57 + a57*b1 - a2*b62 - a62*b2 - a3*b63 - a63*b3 - a8*b64 - a64*b8,...
      a1*b58 + a58*b1,...
      a1*b59 + a59*b1,...
      a1*b60 + a60*b1,...
      a1*b61 + a61*b1 - a4*b64 + a64*b4,...
      a1*b62 + a62*b1 + a3*b64 - a64*b3,...
      a1*b63 + a63*b1 - a2*b64 + a64*b2,...
      a1*b64 + a64*b1];
end


