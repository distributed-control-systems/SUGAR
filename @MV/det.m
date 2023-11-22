function determinant = det(self)
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

