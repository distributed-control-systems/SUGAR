function r= maininvolution(self)


% MAININVOLUTION - Computes the main involution of a multivector.
%
% Syntax:
%   r = maininvolution(self)
%
% Description:
%   This function calculates the main involution of a multivector by
%   summing the contributions from each grade of the multivector,
%   applying a sign factor based on the grade.
%
% Input:
%   self - (MV) The multivector object for which the main involution
%           is to be computed.
%
% Output:
%   r - (MV) The resulting multivector after applying the main involution.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);  % Create a multivector
%   involuted_mv = maininvolution(mv);  % Computes the main involution
%   disp(involuted_mv); % Displays the resulting involuted multivector
%
% Note:
%   The function utilizes the grade projector to retrieve the components
%   of the multivector and applies the involution based on the defined
%   rules of the algebra.


% The main involution of a MV
    K=sum(self.Lsignature);
    vec=self.vec*0;
    for j=0:K
        el=self.grade(j)*(-1)^j;
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end


