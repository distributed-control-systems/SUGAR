function mx= get_matrix_repr(self)
    % Just the matrix representation from a set of coefficients

    %Get the Algebra structure
    [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
    val=self.vec;
    % Apply it to the vector to get a matrix
    z=(Stamp==0);
    mx=Msigns.*val(Stamp+z);
    mx(z)=0;
end

