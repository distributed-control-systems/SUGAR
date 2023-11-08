function mx= get_matrix_repr(self)
    [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
    val=self.vec;
    z=(Stamp==0);
    mx=Msigns.*val(Stamp+z);
    mx(z)=0;
end

