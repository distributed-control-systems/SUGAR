function r= latex(obj1)
    % Nice function to get the Latex representation of a MV. It save some
    % time tiping in a document
    [f,c]=size(obj1);
    % Is it a matrix?
    if f*c==1
        % No
        % Thet the latex string
        r=obj1.latex_str();

    else
        % Yes...
        % Start by opening a matrix
        r="\left[\begin{array}{";
        for i=1:c
            r=r+"c";
        end
        r=r+"}";
        % End of matrix declaration
        for i=1:f
            for j=1:c
                % Go one by one geting the latex string
                r=r+obj1(i,j).latex_str();
                % separator
                r=r+"  &  ";
            end
            %size(r)
            r=extractBefore(r,strlength(r)-2);
            % New line
            r=r+"\\ ";
        end
        % End array
        r=r+"\end{array}\right]";
    end
end


