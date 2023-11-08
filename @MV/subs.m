function r= subs(self,varargin)
    if class(self)=="MV"
        SM=self.to_SUPER_MATRIX();
        %%varargin

        if nargin==3
            SUPER_EXP=subs(SM,varargin{1},varargin{2});
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        elseif nargin==1
            SUPER_EXP=subs(SM);
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    else
        r=subs(self,varargin{1},varargin{2});
    end
end

