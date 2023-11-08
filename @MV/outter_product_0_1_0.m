function r=outter_product_0_1_0(a,b)
   pCell = num2cell(a);
   [a1, a2]=pCell{:};
   pCell = num2cell(b);
   [b1, b2]=pCell{:};
   r=[a1*b1,...
      a1*b2 + a2*b1];
end

