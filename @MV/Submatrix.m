function submatriz = Submatrix(matriz, fila, columna)


% SUBMATRIX Extract a submatrix by removing a specific row and column.
%
% SYNTAX:
%   submatriz = Submatrix(matriz, fila, columna)
%
% DESCRIPTION:
%   This function removes the specified row and column from the input
%   matrix and returns the resulting submatrix.
%
% INPUT:
%   matriz : The input matrix from which the submatrix is extracted.
%   fila   : The index of the row to be removed.
%   columna: The index of the column to be removed.
%
% OUTPUT:
%   submatriz : The resulting matrix after removing the specified row
%               and column.
%
% EXAMPLES:
%   % Define a 3x3 matrix
%   A = [1 2 3; 4 5 6; 7 8 9];
%   % Remove the second row and third column
%   B = Submatrix(A, 2, 3);
%   % B is [1 2; 7 8]
%
% NOTES:
%   - Indices must be valid for the dimensions of the input matrix.
%
% See also: MATLAB indexing
%Auxiliary function to select a submatrix from a matrix


    %Auxiliary function to select a submatrix from a matrix
    submatriz = matriz;
    submatriz(fila, :) = [];
    submatriz(:, columna) = [];
end


