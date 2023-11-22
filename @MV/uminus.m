function r= uminus(obj)
    % overload the unary minus operator, so you can erite -e1
    [f,c]=size(obj);
    if f==1 && c==1
        r=MV();
        r.Lsignature=obj.Lsignature;
        r.Basis=obj.Basis;
        r.matrix=-obj.matrix;
        r.Signs=obj.Signs;
        r.REPR=obj.REPR;
        r.vec=-obj.vec;
    else
        for i=1:f
            for j=1:c
                r(i,j)=-obj(i,j);
            end
        end
    end
end

