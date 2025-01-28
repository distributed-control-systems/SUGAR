function r= fun(self,F)


% FUN - Applies a function to a multivector or an array of multivectors.
%
% Syntax:
%   r = fun(self, F)
%
% Description:
%   This function applies a specified function F to a multivector object
%   or a matrix of multivectors. The implementation takes into account
%   potential complexities with functions returning complex values. The
%   function handles the transformation of multivector coefficients as
%   needed.
%
% Input:
%   self - (MV) The multivector object to which the function is applied.
%   F - (function handle) The function to apply to the multivector.
%
% Output:
%   r - (MV) The resulting multivector after applying the function.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   result_mv = fun(mv, @(x) x^2);  % Applies the square function to the multivector
%   disp(result_mv); % Displays the resulting multivector
%
% Note:
%   The function checks if the input is a multivector and manages the
%   application of the function for both single multivectors and matrices
%   of multivectors. It also considers how to handle complex coefficients.


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
            if MV.allow_multivaluated_functions()
                r=parametrize(r,char(F));
            end
        else
            %Super matrix function...
            SUPER_MATRIX=to_SUPER_MATRIX(self);
            SUPER_EXP=funm(SUPER_MATRIX,F);
            %Reconstruct the matrix of MV
            r=from_SUPER_MATRIX(self,SUPER_EXP);
            if MV.allow_multivaluated_functions()
                r=parametrize(r,char(F));
            end
        end
    end
end
