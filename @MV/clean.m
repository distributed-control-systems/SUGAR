function r= clean(self)


% CLEAN - Removes small numerical errors from the multivector.
%
% Syntax:
%   r = clean(self)
%
% Description:
%   This function cleans up small numerical artifacts (e.g., very small
%   values close to zero) from the multivector, specifically those that
%   can arise from numerical computations (e.g., values on the order of
%   e-16). The function ensures that the vector components are appropriately
%   represented without negligible values.
%
% Input:
%   self - (MV) The multivector object to be cleaned.
%
% Output:
%   r - (MV) The cleaned multivector after removing small numerical errors.
%
% Example:
%   mv = MV([1e-16, 2, 3], [1, 1, 0]);
%   cleaned_mv = mv.clean();
%   disp(cleaned_mv); % Displays the cleaned multivector
%
% Note:
%   The function distinguishes between single multivectors and matrices
%   of multivectors and applies the cleaning process accordingly.


% Reove those nasty e-16 whn doing numerical computations
[f,c]=size(self);
% Is this a matrix?
if f*c==1
    k=self.vector;
    if class(k)=="double"
        % We don't expect complex numbers here
        Mr=abs(real(k))>1e-6;
        Mi=abs(imag(k))>1e-6;
        % Rebuid the vector
        r=MV(real(self.vector).*Mr+1i*imag(self.vector).*Mi,self.Lsignature,self.REPR);
    else
        r=self;
    end
else

    R=self;
    for i=1:f
        for j=1:c
            % Clean each element
            R(i,j)=R(i,j).clean();
        end
    end
    r=R;
end
end


