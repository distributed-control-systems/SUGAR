function r= mpower(obj,k)


% MPOWER - Raises a multivector or a matrix of multivectors to a power.
%
% Syntax:
%   r = mpower(obj, k)
%
% Description:
%   This function computes the k-th power of a multivector or a square
%   matrix of multivectors. If the input is a multivector, it raises the
%   multivector's matrix representation to the power k. If the input is
%   a square matrix, it computes the power of the entire matrix.
%
% Input:
%   obj - (MV or matrix of MV) The multivector or square matrix to be raised to a power.
%   k - (double) The exponent to which the multivector or matrix is raised.
%
% Output:
%   r - (MV or matrix of MV) The resulting multivector or matrix after raising to the power k.
%
% Example:
%   mv = MV([1, 2], [1, 0]);
%   result = mpower(mv, 2);  % Raises the multivector to the power of 2
%   disp(result); % Displays the resulting multivector
%
% Note:
%   The function handles both the case of a single multivector and a
%   square matrix of multivectors. It returns the matrix representation
%   of the result.


    [o1f,o1c]=size(obj);
    if (o1f==1 && o1c==1)
        r=MV();
        r.Basis=obj.Basis;
        r.Lsignature=obj.Lsignature;
        r.Signs=obj.Signs;
        r.REPR=obj.REPR;
        r.matrix=obj.matrix^k;
        r.vec=r.matrix(:,1).';
    else
        if (o1f==o1c)
            filas=o1f;
            columnas=o1c;
            SUPER_MATRIX=to_SUPER_MATRIX(obj);
            SUPER_POWER=SUPER_MATRIX^k;
            r=from_SUPER_MATRIX(obj,SUPER_POWER);
            % ALERT... The representation is lost

        else
            error("Non square matrices are not invertible")
        end
    end

end



