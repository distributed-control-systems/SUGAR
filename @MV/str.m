function r= str(obj1)
    % Get a text string that represents the object
    % If this is a CGA object a variable change must be aplyed
    if obj1.REPR=="CGA"
        % Get the basis change matrix, and the labels of the new basis
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        % Aply it to the vector
        vec=obj1.vec*Matrix;
        % Start geting the text description, component by component, adding
        % the basis name
        r="";
        for k=1:length(vec)
            if vec(k)~=0
                if class(vec(k))=="double"
                    if isnan(vec(k))
                        val="NaN";
                    else
                        val=vec(k);
                    end
                    r=r+"+( "+val+" )[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                else
                    r=r+"+( "+char(vec(k))+" )[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    else
        % For GA multivectors no change of basis is required
        r="";
        % Go one by one generating the representation
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                if class(obj1.vec(k))=="double"
                    r=r+"+("+obj1.vec(k)+")[\b"+obj1.Basis{k}+"]\b ";%e"+strrep(obj1.Basis{k},",","");
                else
                    r=r+"+("+char(obj1.vec(k))+")[\b"+obj1.Basis{k}+"]\b "; %e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end
        end
        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    end
end

