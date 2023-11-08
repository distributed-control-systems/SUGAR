function r= latex_str(obj1)
    if obj1.REPR=="CGA"
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        vec=obj1.vec*Matrix;  %%% CUIDADO
        r="";
        for k=1:length(vec)
            if vec(k)~=0
                if class(vec(k))=="double"
                    r=r+"+\left("+vec(k)+"\right)"+regexprep(Labels(k),"[0-9]+","_{$0}");
                else
                    r=r+"+\left("+latex(vec(k))+"\right)"+regexprep(Labels(k),"[0-9]+","_{$0}");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);

    else



        r="";
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                if class(obj1.vec(k))=="double"
                    r=r+"+\left("+obj1.vec(k)+"\right)"+regexprep(obj1.Basis{k},"[0-9]+","_{$0}");
                else
                    r=r+"+\left("+latex(obj1.vec(k))+"\right)"+regexprep(obj1.Basis{k},"[0-9]+","_{$0}");
                end
            end

        end
        if r==""
            r="  0 ";
        end
        r=extractAfter(r,1);
    end
end

