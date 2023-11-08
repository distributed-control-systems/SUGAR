function f= precoded_inner_product_function(sig)
    persistent functions
    if isempty(functions)
        for i=0:6
            for j=0:6-i
                for k=0:6-i-j
                    functions{i+1,j+1,k+1}=eval("@MV.inner_product_"+num2str(i)+"_"+num2str(j)+"_"+num2str(k));
                end
            end
    end
    
end
f=functions{sig(1)+1,sig(2)+1,sig(3)+1};
end

