function r=ilaplace(self,varargin)
    [f,c]=size(self);
    if f*c==1
        % make the laplace transform of each coefficient
        r=MV(ilaplace(self.vector,varargin{:}),self.Lsignature,self.REPR);
    else
        r=self*0
        for i=1:f
            for i=1:c
                r(i,j)=ilaplace(self(i,j),varargin{:});
            end
        end
    end
end