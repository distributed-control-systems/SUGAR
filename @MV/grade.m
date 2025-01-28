function r= grade(self,k)


% GRADE - Projects the multivector onto a specified grade.
%
% Syntax:
%   r = grade(self, k)
%
% Description:
%   This function projects a multivector onto the specified grade k.
%   It retains compatibility with previous implementations and provides
%   completeness to the multivector functionalities.
%
% Input:
%   self - (MV) The multivector object from which the grade projection
%           is to be obtained.
%   k - (integer) The grade to project onto.
%
% Output:
%   r - (MV) The resulting multivector after projecting onto the specified
%           grade.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   grade1_mv = grade(mv, 1);  % Projects the multivector onto grade 1
%   disp(grade1_mv); % Displays the projected multivector
%
% Note:
%   The function checks if the requested grade is valid within the algebra
%   and performs the projection accordingly. It also handles changes of
%   basis for conformal geometric algebra (CGA).


% Original grade projector.... we keep this function for compatibility
% reasons and for cmpleteness
    % Mother vecor space size?
    n=sum(self.Lsignature);
    % Did you ask for a grade that is not in this algebra?
    if k>n
        error("There is no such a grade in this MV");
        return
    end

    % Get the blades structure of the algebra
    PPP=MV.Blades(self.Lsignature);
    % We are going to get the matrix representation of our vector

    % Take care, in CGA you must perform a change of basis
    if self.REPR=="CGA"
        [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
        val=self.vector;
        z=(Stamp==0);
        m=Msigns.*val(Stamp+z);
        m(z)=0;
    else
        m=self.matrix;
    end
    % Remove the elements that do not belong to the grade
    K=m.*PPP{k+1};
    % First column 
    K=K(:,1).';
    % Thats it
    r=MV(K,self.Lsignature,self.REPR);

end


