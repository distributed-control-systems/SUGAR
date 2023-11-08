function r= latex(obj1)
    [f,c]=size(obj1);
    if f==1 && c==1
        r=obj1.latex_str();

    else
        r="\left[\begin{array}{";
        for i=1:c
            r=r+"c";
        end
        r=r+"}";
        for i=1:f
            for j=1:c
                r=r+obj1(i,j).latex_str();

                r=r+"  &  ";
            end
            %size(r)
            r=extractBefore(r,strlength(r)-2);
            r=r+"\\ ";
        end
        r=r+"\end{array}\right]";
    end
end


