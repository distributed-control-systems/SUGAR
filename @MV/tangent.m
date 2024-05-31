function r=tangent(self,k)
    % This function extract the tangent space of order K of the
    % multivector.
    % It only works for differential geometric algebras, but if you use it
    % with a GA multivector you will get nothing.
    names=self.BasisNames;
    idx=zeros(1,length(names));
    for i=1:length(names)
        if length(char(strrep(regexprep(names{i},'\d',''),"e","")))==k
            idx(i)=1;
        end
    end
    v=self.vector;
    r=MV(v.*idx,self.Lsignature);
end