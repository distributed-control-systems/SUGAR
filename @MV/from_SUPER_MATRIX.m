function r= from_SUPER_MATRIX(self,M)


% FROM_SUPER_MATRIX - Recovers the matrix of multivectors from a supermatrix representation.
%
% Syntax:
%   r = from_SUPER_MATRIX(self, M)
%
% Description:
%   This function reconstructs a matrix of multivectors from its corresponding
%   supermatrix representation. The function iterates over the elements of the
%   supermatrix and builds the multivector matrix accordingly.
%
% Input:
%   self - (MV) The multivector object representing the original structure.
%   M - (matrix) The supermatrix that contains the expanded representation
%       of the multivectors.
%
% Output:
%   r - (MV) The reconstructed matrix of multivectors.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   superMatrix = to_SUPER_MATRIX(mv);  % Convert to supermatrix
%   recovered_mv = from_SUPER_MATRIX(mv, superMatrix);  % Rebuild multivector matrix
%   disp(recovered_mv); % Displays the reconstructed multivector matrix
%
% Note:
%   The function assumes that the dimensions of the supermatrix correspond
%   to the algebraic structure of the multivectors.


    % This function recovers the matrix of MVs from a supermatrix
    % decription
    [rows,columns]=size(self);
    % The algebra dimenssion
    dimension=2^sum(self(1,1).Lsignature);
    % Reserve some space
    r=self*0;
    f=0;
    % Go element by element reconstructing the MV
    for i=1:dimension:rows*dimension
        f=f+1;
        c=0;
        for j=1:dimension:columns*dimension
            c=c+1;
            r(f,c).matrix=M(i:i+dimension-1,j:j+dimension-1);
            r(f,c).vec=r(f,c).matrix(:,1).';
        end
    end
end



