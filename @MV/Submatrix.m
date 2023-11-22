function submatriz = Submatrix(matriz, fila, columna)
    %Auxiliary function to select a submatrix from a matrix
    submatriz = matriz;
    submatriz(fila, :) = [];
    submatriz(:, columna) = [];
end

