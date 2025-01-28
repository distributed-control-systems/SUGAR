function r= exp(self)


% EXP - Computes the exponential of a multivector.
%
% Syntax:
%   r = exp(self)
%
% Description:
%   This function calculates the exponential of a multivector using its
%   matrix representation. It handles both single multivectors and matrices
%   of multivectors, utilizing matrix exponentiation methods.
%
% Input:
%   self - (MV) The multivector object for which the exponential is to be computed.
%
% Output:
%   r - (MV) The resulting multivector after applying the exponential function.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   exp_mv = exp(mv);  % Computes the exponential of the multivector
%   disp(exp_mv); % Displays the resulting multivector
%
% Note:
%   This function does not use the "fun" application method because
%   the exponential function is computed directly using matrix exponentiation.


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


