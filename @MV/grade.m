function r= grade(self,k)
    n=sum(self.Lsignature);
    if k>n
        error("There is no such a grade in this MV");
        return
    end

    PPP=MV.Blades(self.Lsignature);
    if self.REPR=="CGA"
        [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
        val=self.vector;
        z=(Stamp==0);
        m=Msigns.*val(Stamp+z);
        m(z)=0;
    else
        m=self.matrix;
    end
    K=m.*PPP{k+1};
    K=K(:,1).';
    r=MV(K,self.Lsignature,self.REPR);

end

