function r= from_SUPER_MATRIX(self,M)
    % This function recovers the matrix of MVs from a supermatrix
    % decription
    [rows,columns]=size(self);
    % The algebra dimenssion
    dimension=2^sum(self(1,1).Lsignature);
    % Reserve some space
    r=self*0;
    f=0;
    % Go element by element reconstructing the MV
    for i=1:dimension:rows*dimension
        f=f+1;
        c=0;
        for j=1:dimension:columns*dimension
            c=c+1;
            r(f,c).matrix=M(i:i+dimension-1,j:j+dimension-1);
            r(f,c).vec=r(f,c).matrix(:,1).';
        end
    end
end


