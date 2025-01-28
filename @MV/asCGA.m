function asCGA(obj)


% AS_CGA - Displays the multivector in the CGA (Conformal Geometric Algebra) basis.
%
% Syntax:
%   asCGA(obj)
%
% Description:
%   This function performs a basis change to represent the multivector (MV)
%   in the conformal geometric algebra basis. It computes the necessary
%   transformation matrix and the corresponding basis labels, and then
%   displays the multivector in this new basis.
%
% Input:
%   obj - (MV) The multivector object that is to be displayed in the CGA basis.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   mv.asCGA(); % Displays the multivector in the CGA basis
%
% Note:
%   The function checks if the object is a single multivector or an array of
%   multivectors and processes accordingly.


    % This function performs a basis change in order to diplay the MV in
    % cga basis

    % Get the matrix that represents the change and the corresponding
    % labels for the basis

    [Matrix,Labels]=obj.CGA_matrix(obj.Lsignature);

    % Get the vector representation in the new basis
    vec=obj.vector;

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
                    if isnan(vec(k))
                        val="NaN";
                    else
                        val=vec(k);
                    end
                    r=r+"+( "+val+" )*[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            else
                if ~isequal(vec(k),sym(0))
                    r=r+"+( "+char(vec(k))+" )*[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
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



