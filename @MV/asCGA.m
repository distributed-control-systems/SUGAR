function asCGA(obj)
    % This function performs a basis change in order to diplay the MV in
    % cga basis

    % Get the matrix that represents the change and the corresponding
    % labels for the basis

    [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);

    % Get the vector representation in the new basis
    vec=obj.vec*Matrix;

    % Lets return a string that represents the vector into the screen... 
    [f,c]=size(obj);

    %Is it a MV or an array of MV
    if f==1 && c==1
        r="";
        % Lets go component by component, adding the correspondin label in
        % the new basis
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
        % And print the result 
        fprintf(r+"\n");
    else
        % We have an array, lets go one by one
        % TODO correct aligment of columns and column juping, just like
        % arrays
        for i=1:f
            for j=1:c
                r=obj1(i,j).str();
                fprintf(r)
                fprintf("    "); % Poor alignment
            end
            fprintf("\n");
        end
    end

end


