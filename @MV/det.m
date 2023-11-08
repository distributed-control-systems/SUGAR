function determinante = det(self)
    % Verificar si la matriz es cuadrada
    [filas, columnas] = size(self);
    if filas ~= columnas
        error('In order to compute a determinant it is required to provide a square matrix.');
    end

    % Caso base: matriz 1x1
    if filas == 1
        determinante = self(1, 1);
        return;
    end

    % Calcular el determinante recursivamente utilizando el método de cofactores
    determinante = 0;
    for i = 1:filas
        cofactor = (-1)^(i+1) * self(1, i) * det(self.Submatrix(1, i));
        determinante = determinante + cofactor;
    end
end

