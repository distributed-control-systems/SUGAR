function r= from_SUPER_MATRIX(self,M)
    [filas,columnas]=size(self);
    dimension=2^sum(self(1,1).Lsignature);
    inversa=self*0;
    f=0;
    for i=1:dimension:filas*dimension
        f=f+1;
        c=0;
        for j=1:dimension:columnas*dimension
            c=c+1;
            inversa(f,c).matrix=M(i:i+dimension-1,j:j+dimension-1);
            inversa(f,c).vec=inversa(f,c).matrix(:,1).';
        end
    end
    r=inversa;
end


