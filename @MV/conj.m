function r= conj(self)
    %size of the vector space 
    K=sum(self.Lsignature);
    vec=self.vec*0;
    %direct defenition of conjugation
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j+1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end

