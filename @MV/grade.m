function r= grade(self,k)
% Original grade projector.... we keep this function for compatibility
% reasons and for cmpleteness
    % Mother vecor space size?
    n=sum(self.Lsignature);
    % Did you ask for a grade that is not in this algebra?
    if k>n
        error("There is no such a grade in this MV");
        return
    end

    % Get the blades structure of the algebra
    PPP=MV.Blades(self.Lsignature);
    % We are going to get the matrix representation of our vector

    % Take care, in CGA you must perform a change of basis
    if self.REPR=="CGA"
        [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
        val=self.vector;
        z=(Stamp==0);
        m=Msigns.*val(Stamp+z);
        m(z)=0;
    else
        m=self.matrix;
    end
    % Remove the elements that do not belong to the grade
    K=m.*PPP{k+1};
    % First column 
    K=K(:,1).';
    % Thats it
    r=MV(K,self.Lsignature,self.REPR);

end

