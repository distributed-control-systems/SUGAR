function r= fun(self,F)
    if class(self)~="MV"
        error("When asking for functions the parameter must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1
            intermediate= funm(self.matrix,F);
            r=MV(intermediate(:,1).',self.Lsignature);
            r.REPR=self.REPR;
        else
            %Super matrix exponential... 

            SUPER_MATRIX=to_SUPER_MATRIX(self);
            SUPER_EXP=funm(SUPER_MATRIX,F);
            %construimos la matriz resultante
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    end
end