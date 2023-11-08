function r=inner_product_1_0_1(a,b)
   pCell = num2cell(a);
   [a1, a2, a3, a4]=pCell{:};
   pCell = num2cell(b);
   [b1, b2, b3, b4]=pCell{:};
   r=[a1*b1 + a2*b2,...
      a1*b2 + a2*b1,...
      a1*b3 + a3*b1 + a2*b4 - a4*b2,...
      a1*b4 + a4*b1];
end

