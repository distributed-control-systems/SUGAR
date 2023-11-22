function r= fun(self,F)
    % TODO, Some functions return complex values, so there are many posibilities 
    % expressing the MV with complex xoeficients into a MV without complex coeficients 
    % I'm still deciding which is the best way to perform this operation

    % Apply a function to a MV or an array of MVs
    if class(self)~="MV"
        error("When asking for functions the parameter must be a multivector")
    else
        [f,c]=size(self);
        % Is it a matrix?
        if f*c==1
            %No 
            intermediate= funm(self.matrix,F);
            r=MV(intermediate(:,1).',self.Lsignature);
            r.REPR=self.REPR;
        else
            %Super matrix function...
            SUPER_MATRIX=to_SUPER_MATRIX(self);
            SUPER_EXP=funm(SUPER_MATRIX,F);
            %Reconstruct the matrix of MV
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    end
end