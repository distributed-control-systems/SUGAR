function r=inner_product_1_1_1(a,b)
   pCell = num2cell(a);
   [a1, a2, a3, a4, a5, a6, a7, a8]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4, b5, b6, b7, b8]=pCell{:};
   r=[a1*b1 + a2*b2 - a3*b3 + a5*b5,...
      a1*b2 + a2*b1 + a3*b5 - a5*b3,...
      a1*b3 + a3*b1 + a2*b5 - a5*b2,...
      a1*b4 + a4*b1 + a2*b6 - a6*b2 - a3*b7 + a7*b3 + a5*b8 + a8*b5,...
      a1*b5 + a5*b1,...
      a1*b6 + a6*b1 + a3*b8 + a8*b3,...
      a1*b7 + a7*b1 + a2*b8 + a8*b2,...
      a1*b8 + a8*b1];
end

