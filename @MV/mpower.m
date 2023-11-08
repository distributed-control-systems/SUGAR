function r= mpower(obj,k)
    [o1f,o1c]=size(obj);
    if (o1f==1 && o1c==1)
        r=MV();
        r.Basis=obj.Basis;
        r.Lsignature=obj.Lsignature;
        r.Signs=obj.Signs;
        r.REPR=obj.REPR;
        r.matrix=obj.matrix^k;
        r.vec=r.matrix(:,1).';
    else
        if (o1f==o1c)
            filas=o1f;
            columnas=o1c;
            SUPER_MATRIX=to_SUPER_MATRIX(obj);
            SUPER_POWER=SUPER_MATRIX^k;
            r=from_SUPER_MATRIX(obj,SUPER_POWER);
            % ALERT... The representation is lost

        else
            error("Non square matrices are not invertible")
        end
    end

end


