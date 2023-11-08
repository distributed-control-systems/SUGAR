function r= clean(self)
    k=self.vector;
    M=abs(k)>1e-6;
    r=MV(self.vector.*M,self.Lsignature,self.REPR);
end

