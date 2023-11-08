function r= inner(obj1,obj2)
    %Inner product implementation
    if obj1.Lsignature==obj2.Lsignature
        n=sum(obj1.Lsignature);
        precoded=7;
        if n>=precoded
            B=MV.Blades(obj1.Lsignature);
            M1=obj1.matrix;
            M2=obj2.matrix;
            M=M1*0;
            for i=0:n
                for j=0:n
                    M=M+(M1.*B{i+1})*(M2.*B{j+1}).*B{abs(i-j)+1};
                end
            end
            v=M(:,1).';

            r=MV(v,obj1.Lsignature);
        elseif n<precoded
            f=MV.precoded_inner_product_function(obj1.Lsignature);
            v=f(obj1.vec,obj2.vec);
            r=MV(v,obj1.Lsignature);
        end
        if obj1.REPR=="CGA" || obj2.REPR=="CGA"
            r.REPR="CGA";
        end




    else
        error("Multivectors must belong to the same algebra ")
    end

end