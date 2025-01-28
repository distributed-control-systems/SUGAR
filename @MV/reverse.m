function r= reverse(self)


% REVERSE Calculate the reverse of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = reverse(self)
%
% DESCRIPTION:
%   This function computes the reverse of a multivector (MV) in a
%   geometric algebra using the standard formula. The reverse is defined
%   as applying a sign change depending on the grades of the blades in
%   the multivector.
%
% INPUT:
%   self : An instance of the multivector (MV) class containing:
%          - vec: The vector representation of the MV.
%          - Lsignature: The signature of the algebra.
%          - REPR: The representation type of the MV.
%
% OUTPUT:
%   r : A new multivector (MV) object representing the reverse of the
%       input multivector.
%
% NOTES:
%   - The size of the mother vector space equals the number of grades
%     in the algebra.
%   - The reverse is computed blade by blade, applying a grade-dependent
%     sign change defined by (-1)^(j*(j-1)/2) for each grade j.
%
% EXAMPLES:
%   % Create a multivector object
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Compute the reverse
%   r = reverse(mv);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, grade


    % Reverse a MV, using the standard formula
    % The size of the mother vector space equals the numbers of grades of
    % the algebra
    K=sum(self.Lsignature);
    vec=self.vec*0;
    %Go blade by blade
    for j=0:K
        el=self.grade(j)*(-1)^(j*(j-1)/2);
        vec=vec+el.vector;
    end
    r=MV(vec,self.Lsignature,self.REPR);
end


