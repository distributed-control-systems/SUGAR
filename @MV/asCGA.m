function asCGA(obj)

    [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);
    vec=obj.vec*Matrix;

    [f,c]=size(obj);
    if f==1 && c==1
        r="";
        for k=1:length(vec)

            if class(vec(k))=="double" 
                if vec(k)~=0
                    r=r+"+( "+vec(k)+" )<strong>"+Labels(k)+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            else
                if ~isequal(vec(k),sym(0))
                    r=r+"+( "+char(vec(k))+" )<strong>"+Labels(k)+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end


        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
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


