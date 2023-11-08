function disp(obj1)
    [f,c]=size(obj1);
    if f==1 && c==1
        if obj1.REPR=="CGA"
            obj1.asCGA
            return
        end


        r="";
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                if class(obj1.vec(k))=="double"
                    r=r+"+( "+obj1.vec(k)+" )<strong>"+obj1.Basis{k}+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                else
                    r=r+"+( "+char(obj1.vec(k))+" )<strong>"+obj1.Basis{k}+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
        %                     r=r+ " ---> algebra ( " ;
        %                     for k=1:length(obj1.Lsignature)
        %                         r=r+obj1.Lsignature(k) +" ";
        %                     end
        %                     r=r+")";

        fprintf(r+"\n");
    else
        for i=1:f
            for j=1:c
                r=obj1(i,j).str();
                fprintf(r)
                fprintf("    ");
            end
            fprintf("\n");
        end
    end
end

