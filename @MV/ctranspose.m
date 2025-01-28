function r= ctranspose(self)


% CTRANSPOSE - Overloads the conjugate transpose operator (').
%
% Syntax:
%   r = ctranspose(self)
%
% Description:
%   This function overloads the conjugate transpose operator for the
%   multivector class. It computes the conjugate of a single multivector
%   or performs the conjugate transpose on a matrix of multivectors.
%
% Input:
%   self - (MV) The multivector object for which the conjugate transpose
%           is to be computed.
%
% Output:
%   r - (MV) The conjugate transposed multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   conj_transpose_mv = mv';  % Uses the overloaded operator
%   disp(conj_transpose_mv); % Displays the conjugate transpose of the multivector
%
% Note:
%   If the multivector is a single element, it returns the conjugate.
%   If it is a matrix of multivectors, it performs the conjugate transpose.


    % Overload of the operator '
    [f,c]=size(self);
    % Is it a matrix?
    if f*c==1
        % No, call the conjugate involution
        r=self.conj();
    else
        % yes
        % Transpose and conjugate involution
        for i=1:f
            for j=1:c
                r(j,i)=conj(self(i,j));
            end
        end
    end
end
