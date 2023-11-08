function inversa = pinv(self)
    %The inverse of a MV or a matrix of MVs
    [filas, columnas] = size(self);
    if filas ~= columnas

        SUPER_MATRIX=to_SUPER_MATRIX(self);
        SUPER_INVERSE=pinv(SUPER_MATRIX);
        inversa=from_SUPER_MATRIX(self.',SUPER_INVERSE);
        return
    end
    % Caso base: matriz 1x1
    if filas == 1
        r=MV();
        r.Basis=self.Basis;
        r.Lsignature=self.Lsignature;
        r.Signs=self.Signs;
        r.REPR=self.REPR;
        r.matrix=self.matrix^(-1);
        r.vec=r.matrix(:,1).';
        inversa = r;
        return;
    end

    % Calcular la inversa con el algoritmo de "me lo he scado de la
    % manga"

    %construimos una matriz de matrices
    %dimension=2^sum(self(1,1).Lsignature);
    SUPER_MATRIX=to_SUPER_MATRIX(self);
    %             SUPER_MATRIX=zeros(filas*dimension,columnas*dimension);
    %             f=0;
    %             for i=1:dimension:filas*dimension
    %                 f=f+1;
    %                 c=0;
    %                 for j=1:dimension:columnas*dimension
    %                     c=c+1;
    %                     SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
    %                 end
    %             end
    SUPER_INVERSE=inv(SUPER_MATRIX);
    %construimos la matriz resultante
    inversa=from_SUPER_MATRIX(self,SUPER_INVERSE);
    %             inversa=self*0;
    %             f=0;
    %             for i=1:dimension:filas*dimension
    %                 f=f+1;
    %                 c=0;
    %                 for j=1:dimension:columnas*dimension
    %                     c=c+1;
    %                     inversa(f,c).matrix=SUPER_INVERSE(i:i+dimension-1,j:j+dimension-1);
    %                     inversa(f,c).vec=inversa(f,c).matrix(:,1).';
    %                 end
    %             end


end


