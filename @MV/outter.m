function r= outter(obj1,obj2)
    %Outer product implementation
    if class(obj1)=="double" | class(obj1)=="sym"
        s=sum(obj2.Lsignature);
        v=zeros(1,2^s);
        v(1)=obj1;
        obj1=MV(v,obj2.Lsignature);
        obj1.REPR=obj2.REPR;
    end
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
                    M=M+(M1.*B{i+1})*(M2.*B{j+1}).*B{i+j+1};
                end
            end
            v=M(:,1).';
            r=MV(v,obj1.Lsignature);
        elseif n<precoded
            f=MV.precoded_outter_product_function(obj1.Lsignature);
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

