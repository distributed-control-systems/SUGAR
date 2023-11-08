function r= normalize(self)
    l=length(self);
    if l>1e-6
        r=MV(self.vector/l,self.Lsignature,self.REPR);
    else
        r=self;
    end
end

