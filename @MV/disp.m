function disp(obj1)
    % This is the function required by matlab to print on the screen the
    % value of a class.
    
    % Some care must be taken to take into account that some MVs are CGA
    % based, and thus a variable change must be aplied and a change of
    % basis names should be performed before displaying

    [f,c]=size(obj1);

    % Is it a matrix?
    if f==1 && c==1
        % No

        % Is this a CGA object
        if obj1.REPR=="CGA"
            % Yes, rely on a dedicated printing function
            obj1.asCGA
            return
        end

        % So, is a GA MV
        r="";

        % Lets go for the coeficients, one by one and lets print the value
        % and the correspondin blade
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                % Care, it could be a symbolic or a numerical coefficient
                if class(obj1.vec(k))=="double"
                    if isnan(obj1.vec(k))
                        val="NaN";
                    else
                        val=obj1.vec(k);
                    end
                    % extend representation and pretty print the basis
                    r=r+"+( "+val+" )<strong>"+obj1.Basis{k}+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                else
                    % extend representation and pretty print the basis
                    r=r+"+( "+char(obj1.vec(k))+" )<strong>"+obj1.Basis{k}+"</strong>";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
        % Finally, print on the screen
        fprintf(r+"\n");
    else
        % We have a matrix of MV
        % Let's go one by one printing its value
        % TODO we do not respect column sizes here, as a result the output
        % is really bloated for MV of real diferent sizes
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

