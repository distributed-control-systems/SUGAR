function r=tangent(self,varargin)
    % This function extract the tangent space of order K of the
    % multivector.
    % It only works for differential geometric algebras, but if you use it
    % with a GA multivector you will get nothing.
    cayley(self.Lsignature);
    if nargin==1
        k=1;
    elseif nargin==2
        k=varargin{1};
    end
    r=0*e0;
    v=self.vector;
    names=self.BasisNames;
    idx=zeros(1,length(names));
    for i=1:length(names)
        if length(char(strrep(regexprep(names{i},'\d',''),"e","")))==k
            idx(i)=1;
            if length(char(regexprep(names{i},"D+\d","")))==0
                r=r+v(i)*e0;
            else
                r=r+v(i)*eval(regexprep(names{i},"D+\d",""));
            end
        end
    end
    v=self.vector;
    %r=MV(v.*idx,self.Lsignature);
end