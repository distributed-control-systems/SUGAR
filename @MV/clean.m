function r= clean(self)
[f,c]=size(self);
if f*c==1
    k=self.vector;
    M=abs(k)>1e-6;
    r=MV(self.vector.*M,self.Lsignature,self.REPR);
else
    R=self;
    for i=1:f
        for j=1:c
        R(i,j)=R(i,j).clean();
        end
    end
    r=R
end
end

