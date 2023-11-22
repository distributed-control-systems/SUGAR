function r= exp(self)
    % Exponential function of a MV
    % This is the only function that is not asking for "fun" application
    if class(self)~="MV"
        error("When asking for exponential the parameter must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1
            intermediate=expm(self.matrix);
            r=MV(intermediate(:,1).',self.Lsignature);
            r.REPR=self.REPR;
        else
            %Super matrix exponential... 
            SUPER_MATRIX=to_SUPER_MATRIX(self);
            % Compute the exponential
            SUPER_EXP=expm(SUPER_MATRIX);
            %Rebuild the matrix of MVs
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    end
end

