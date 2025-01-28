function r= conj(self)


% CONJ - Computes the conjugate of the multivector.
%
% Syntax:
%   r = conj(self)
%
% Description:
%   This function calculates the conjugate of the multivector represented
%   by the object `self`. The conjugate is defined by summing the graded
%   components of the multivector, applying a sign based on the grade of
%   each component.
%
% Input:
%   self - (MV) The multivector object for which the conjugate is to be computed.
%
% Output:
%   r - (MV) The conjugate multivector obtained after computation.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   conj_mv = conj(mv);
%   disp(conj_mv); % Displays the conjugate of the multivector
%
% Note:
%   The conjugation is computed using the formula that involves the grades
%   of the multivector components. The sign alternates based on the grade.


    %size of the vector space 
    K=sum(self.Lsignature);
    vec=self.vec*0;
    %direct defenition of conjugation
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j+1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end


