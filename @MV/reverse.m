function r= reverse(self)
    % Reverse a MV, using the standard formula
    % The size of the mother vector space equals the numbers of grades of
    % the algebra
    if class(self.Lsignature)=="double"
        %This is a GA vector
        K=sum(self.Lsignature);
    else
        %Cayley based vector or DGA vector
        K=ceil(log2(size(self.Lsignature,1)));

    end
    
    vec=self.vec*0;
    %Go blade by blade
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j-1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
    
end

