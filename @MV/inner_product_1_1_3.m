function r=inner_product_1_1_3(a,b)
   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32]=pCell{:};
   r=[a1*b1 + a2*b2 - a3*b3 + a7*b7,...
      a1*b2 + a2*b1 + a3*b7 - a7*b3,...
      a1*b3 + a3*b1 + a2*b7 - a7*b2,...
      a1*b4 + a4*b1 + a2*b8 - a8*b2 - a3*b11 + a11*b3 + a7*b17 + a17*b7,...
      a1*b5 + a5*b1 + a2*b9 - a9*b2 - a3*b12 + a12*b3 + a7*b18 + a18*b7,...
      a1*b6 + a6*b1 + a2*b10 - a10*b2 - a3*b13 + a13*b3 + a7*b19 + a19*b7,...
      a1*b7 + a7*b1,...
      a1*b8 + a8*b1 + a3*b17 + a17*b3,...
      a1*b9 + a9*b1 + a3*b18 + a18*b3,...
      a1*b10 + a10*b1 + a3*b19 + a19*b3,...
      a1*b11 + a11*b1 + a2*b17 + a17*b2,...
      a1*b12 + a12*b1 + a2*b18 + a18*b2,...
      a1*b13 + a13*b1 + a2*b19 + a19*b2,...
      a1*b14 + a14*b1 + a2*b20 + a20*b2 - a3*b23 - a23*b3 + a7*b27 + a27*b7,...
      a1*b15 + a15*b1 + a2*b21 + a21*b2 - a3*b24 - a24*b3 + a7*b28 + a28*b7,...
      a1*b16 + a16*b1 + a2*b22 + a22*b2 - a3*b25 - a25*b3 + a7*b29 + a29*b7,...
      a1*b17 + a17*b1,...
      a1*b18 + a18*b1,...
      a1*b19 + a19*b1,...
      a1*b20 + a20*b1 + a3*b27 - a27*b3,...
      a1*b21 + a21*b1 + a3*b28 - a28*b3,...
      a1*b22 + a22*b1 + a3*b29 - a29*b3,...
      a1*b23 + a23*b1 + a2*b27 - a27*b2,...
      a1*b24 + a24*b1 + a2*b28 - a28*b2,...
      a1*b25 + a25*b1 + a2*b29 - a29*b2,...
      a1*b26 + a26*b1 + a2*b30 - a30*b2 - a3*b31 + a31*b3 + a7*b32 + a32*b7,...
      a1*b27 + a27*b1,...
      a1*b28 + a28*b1,...
      a1*b29 + a29*b1,...
      a1*b30 + a30*b1 + a3*b32 + a32*b3,...
      a1*b31 + a31*b1 + a2*b32 + a32*b2,...
      a1*b32 + a32*b1];
end

