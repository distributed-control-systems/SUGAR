function submatriz = Submatrix(matriz, fila, columna)
    submatriz = matriz;
    submatriz(fila, :) = [];
    submatriz(:, columna) = [];
end

