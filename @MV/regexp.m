function r=regexp(self,reg)
    %Match regular expression on basis and return them (case sensitive)
    [m,n]=size(self);
    if m+n==2
        obj=self(1,1);
    names=self.BasisNames;
    r=0;
    vals=obj.vector;
    for i=1:length(names)
        if isempty(regexp(names{i},reg, 'once'))
        else
            v=zeros(1,length(obj.vector));
            v(i)=1;
            b=MV(v,obj.Lsignature);
            r=r+vals(i)*b;
        end
    end
    else
        error("Not implemented for matrices of MV");
    end