function r= reverse(self)
    K=sum(self.Lsignature);
    vec=self.vec*0;
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j-1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);

end

