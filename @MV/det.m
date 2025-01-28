function determinant = det(self)


% DET - Computes the determinant of a matrix of multivectors.
%
% Syntax:
%   determinant = det(self)
%
% Description:
%   This function calculates the determinant of a matrix where each element
%   is a multivector. The computation is performed using the cofactor
%   expansion method, allowing for the handling of matrices comprised of
%   multivector elements.
%
% Input:
%   self - (MV) The multivector object representing a square matrix of multivectors.
%
% Output:
%   determinant - (scalar) The computed determinant of the matrix of multivectors.
%
% Example:
%   A = [[MV([1, 0], [1, 0, 0]), MV([0, 1], [1, 0, 0])], ...
%             [MV([1, 1], [1, 0, 0]), MV([1, 0], [1, 0, 0][0, 1])]];
%   determinant = det(A);  % Computes the determinant of the multivector matrix
%   disp(determinant); % Displays the determinant value
%
% Note:
%   The function checks if the matrix is square and handles trivial cases
%   (1x1 matrix of multivectors) directly. The determinant is computed
%   recursively using cofactor expansion.


    % Is this a square matrix
    [f, c] = size(self);
    if f ~= c
        error('In order to compute a determinant it is required to provide a square matrix.');
    end

    %  1x1 matrix.... trivial
    if f == 1
        determinant = self(1, 1);
        return;
    end

    % Cofactor based det computation
    determinant = 0;
    for i = 1:f
        cofactor = (-1)^(i+1) * self(1, i) * det(self.Submatrix(1, i));
        determinant = determinant + cofactor;
    end
end


