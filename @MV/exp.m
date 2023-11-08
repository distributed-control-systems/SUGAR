function r= exp(self)
    if class(self)~="MV"
        error("When asking for exponential the parameter must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1
            intermediate=expm(self.matrix);
            r=MV(intermediate(:,1).',self.Lsignature);
            r.REPR=self.REPR;
        else
            %Super matrix exponential... not sure of this operation

            SUPER_MATRIX=to_SUPER_MATRIX(self);

            SUPER_EXP=expm(SUPER_MATRIX);
            %construimos la matriz resultante
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    end
end

