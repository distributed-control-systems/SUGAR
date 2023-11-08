function r= str(obj1)
    if obj1.REPR=="CGA"
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        vec=obj1.vec*Matrix;  %%% CUIDADO
        r="";
        for k=1:length(vec)
            if vec(k)~=0
                if class(vec(k))=="double"
                    r=r+"+( "+vec(k)+" )<strong>"+Labels(k)+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                else
                    r=r+"+( "+char(vec(k))+" )<strong>"+Labels(k)+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
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
                    r=r+"+("+obj1.vec(k)+")<strong>"+obj1.Basis{k}+"</strong>";%e"+strrep(obj1.Basis{k},",","");
                else
                    r=r+"+("+char(obj1.vec(k))+")<strong>"+obj1.Basis{k}+"</strong>"; %e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end
        end
        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    end
end

