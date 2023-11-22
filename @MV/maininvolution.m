function r= maininvolution(self)
% The main involution of a MV
    K=sum(self.Lsignature);
    vec=self.vec*0;
    for j=0:K
        el=self.grade(j)*(-1)^j;
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end

