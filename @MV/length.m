function r= length(self)
    k=self*self.conj;
    l=k.vector;
    r=sqrt(abs(l(1)));
end

