function r= reverse(self)
    % Reverse a MV, using the standard formula
    % The size of the mother vector space equals the numbers of grades of
    % the algebra
    K=sum(self.Lsignature);
    vec=self.vec*0;
    %Go blade by blade
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j-1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end

