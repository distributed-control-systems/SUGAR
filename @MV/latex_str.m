function r= latex_str(obj1)
    % This function provides the latex string, taking into account that the
    % MV may be a CGA MV

    % Is it CGA?
    if obj1.REPR=="CGA"
         % Yes
         % Change of basis
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        vec=obj1.vec*Matrix; 
        % Lets go
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
    % Not CGA
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

