function r= to_SUPER_MATRIX(self)
    [filas,columnas]=size(self);
    dimension=2^sum(self(1,1).Lsignature);
    SUPER_MATRIX=sym(zeros(filas*dimension,columnas*dimension));
    f=0;
    for i=1:dimension:filas*dimension
        f=f+1;
        c=0;
        for j=1:dimension:columnas*dimension
            c=c+1;
            SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
        end
    end
    %try to convert to double
    try
        r=double(SUPER_MATRIX);
    catch
        r=SUPER_MATRIX;
    end

end

