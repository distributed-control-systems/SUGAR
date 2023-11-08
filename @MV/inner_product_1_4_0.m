function r=inner_product_1_4_0(a,b)
   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, a32]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32]=pCell{:};
   r=[a1*b1 + a2*b2 - a3*b3 - a4*b4 - a5*b5 - a6*b6 + a7*b7 + a8*b8 + a9*b9 + a10*b10 - a11*b11 - a12*b12 - a13*b13 - a14*b14 - a15*b15 - a16*b16 - a17*b17 - a18*b18 - a19*b19 - a20*b20 - a21*b21 - a22*b22 + a23*b23 + a24*b24 + a25*b25 + a26*b26 - a27*b27 - a28*b28 - a29*b29 - a30*b30 + a31*b31 + a32*b32,...
      a1*b2 + a2*b1 + a3*b7 - a7*b3 + a4*b8 - a8*b4 + a5*b9 - a9*b5 + a6*b10 - a10*b6 - a11*b17 - a17*b11 - a12*b18 - a18*b12 - a13*b19 - a19*b13 - a14*b20 - a20*b14 - a15*b21 - a21*b15 - a16*b22 - a22*b16 - a23*b27 + a27*b23 - a24*b28 + a28*b24 - a25*b29 + a29*b25 - a26*b30 + a30*b26 + a31*b32 + a32*b31,...
      a1*b3 + a3*b1 + a2*b7 - a7*b2 + a4*b11 - a11*b4 + a5*b12 - a12*b5 + a6*b13 - a13*b6 - a8*b17 - a17*b8 - a9*b18 - a18*b9 - a10*b19 - a19*b10 - a14*b23 - a23*b14 - a15*b24 - a24*b15 - a16*b25 - a25*b16 - a20*b27 + a27*b20 - a21*b28 + a28*b21 - a22*b29 + a29*b22 - a26*b31 + a31*b26 + a30*b32 + a32*b30,...
      a1*b4 + a4*b1 + a2*b8 - a8*b2 - a3*b11 + a11*b3 + a5*b14 - a14*b5 + a6*b15 - a15*b6 + a7*b17 + a17*b7 - a9*b20 - a20*b9 - a10*b21 - a21*b10 + a12*b23 + a23*b12 + a13*b24 + a24*b13 - a16*b26 - a26*b16 + a18*b27 - a27*b18 + a19*b28 - a28*b19 - a22*b30 + a30*b22 + a25*b31 - a31*b25 - a29*b32 - a32*b29,...
      a1*b5 + a5*b1 + a2*b9 - a9*b2 - a3*b12 + a12*b3 - a4*b14 + a14*b4 + a6*b16 - a16*b6 + a7*b18 + a18*b7 + a8*b20 + a20*b8 - a10*b22 - a22*b10 - a11*b23 - a23*b11 + a13*b25 + a25*b13 + a15*b26 + a26*b15 - a17*b27 + a27*b17 + a19*b29 - a29*b19 + a21*b30 - a30*b21 - a24*b31 + a31*b24 + a28*b32 + a32*b28,...
      a1*b6 + a6*b1 + a2*b10 - a10*b2 - a3*b13 + a13*b3 - a4*b15 + a15*b4 - a5*b16 + a16*b5 + a7*b19 + a19*b7 + a8*b21 + a21*b8 + a9*b22 + a22*b9 - a11*b24 - a24*b11 - a12*b25 - a25*b12 - a14*b26 - a26*b14 - a17*b28 + a28*b17 - a18*b29 + a29*b18 - a20*b30 + a30*b20 + a23*b31 - a31*b23 - a27*b32 - a32*b27,...
      a1*b7 + a7*b1 - a4*b17 - a17*b4 - a5*b18 - a18*b5 - a6*b19 - a19*b6 - a14*b27 - a27*b14 - a15*b28 - a28*b15 - a16*b29 - a29*b16 + a26*b32 + a32*b26,...
      a1*b8 + a8*b1 + a3*b17 + a17*b3 - a5*b20 - a20*b5 - a6*b21 - a21*b6 + a12*b27 + a27*b12 + a13*b28 + a28*b13 - a16*b30 - a30*b16 - a25*b32 - a32*b25,...
      a1*b9 + a9*b1 + a3*b18 + a18*b3 + a4*b20 + a20*b4 - a6*b22 - a22*b6 - a11*b27 - a27*b11 + a13*b29 + a29*b13 + a15*b30 + a30*b15 + a24*b32 + a32*b24,...
      a1*b10 + a10*b1 + a3*b19 + a19*b3 + a4*b21 + a21*b4 + a5*b22 + a22*b5 - a11*b28 - a28*b11 - a12*b29 - a29*b12 - a14*b30 - a30*b14 - a23*b32 - a32*b23,...
      a1*b11 + a11*b1 + a2*b17 + a17*b2 - a5*b23 - a23*b5 - a6*b24 - a24*b6 + a9*b27 + a27*b9 + a10*b28 + a28*b10 - a16*b31 - a31*b16 - a22*b32 - a32*b22,...
      a1*b12 + a12*b1 + a2*b18 + a18*b2 + a4*b23 + a23*b4 - a6*b25 - a25*b6 - a8*b27 - a27*b8 + a10*b29 + a29*b10 + a15*b31 + a31*b15 + a21*b32 + a32*b21,...
      a1*b13 + a13*b1 + a2*b19 + a19*b2 + a4*b24 + a24*b4 + a5*b25 + a25*b5 - a8*b28 - a28*b8 - a9*b29 - a29*b9 - a14*b31 - a31*b14 - a20*b32 - a32*b20,...
      a1*b14 + a14*b1 + a2*b20 + a20*b2 - a3*b23 - a23*b3 - a6*b26 - a26*b6 + a7*b27 + a27*b7 + a10*b30 + a30*b10 - a13*b31 - a31*b13 - a19*b32 - a32*b19,...
      a1*b15 + a15*b1 + a2*b21 + a21*b2 - a3*b24 - a24*b3 + a5*b26 + a26*b5 + a7*b28 + a28*b7 - a9*b30 - a30*b9 + a12*b31 + a31*b12 + a18*b32 + a32*b18,...
      a1*b16 + a16*b1 + a2*b22 + a22*b2 - a3*b25 - a25*b3 - a4*b26 - a26*b4 + a7*b29 + a29*b7 + a8*b30 + a30*b8 - a11*b31 - a31*b11 - a17*b32 - a32*b17,...
      a1*b17 + a17*b1 + a5*b27 - a27*b5 + a6*b28 - a28*b6 - a16*b32 - a32*b16,...
      a1*b18 + a18*b1 - a4*b27 + a27*b4 + a6*b29 - a29*b6 + a15*b32 + a32*b15,...
      a1*b19 + a19*b1 - a4*b28 + a28*b4 - a5*b29 + a29*b5 - a14*b32 - a32*b14,...
      a1*b20 + a20*b1 + a3*b27 - a27*b3 + a6*b30 - a30*b6 - a13*b32 - a32*b13,...
      a1*b21 + a21*b1 + a3*b28 - a28*b3 - a5*b30 + a30*b5 + a12*b32 + a32*b12,...
      a1*b22 + a22*b1 + a3*b29 - a29*b3 + a4*b30 - a30*b4 - a11*b32 - a32*b11,...
      a1*b23 + a23*b1 + a2*b27 - a27*b2 + a6*b31 - a31*b6 - a10*b32 - a32*b10,...
      a1*b24 + a24*b1 + a2*b28 - a28*b2 - a5*b31 + a31*b5 + a9*b32 + a32*b9,...
      a1*b25 + a25*b1 + a2*b29 - a29*b2 + a4*b31 - a31*b4 - a8*b32 - a32*b8,...
      a1*b26 + a26*b1 + a2*b30 - a30*b2 - a3*b31 + a31*b3 + a7*b32 + a32*b7,...
      a1*b27 + a27*b1 - a6*b32 - a32*b6,...
      a1*b28 + a28*b1 + a5*b32 + a32*b5,...
      a1*b29 + a29*b1 - a4*b32 - a32*b4,...
      a1*b30 + a30*b1 + a3*b32 + a32*b3,...
      a1*b31 + a31*b1 + a2*b32 + a32*b2,...
      a1*b32 + a32*b1];
end

