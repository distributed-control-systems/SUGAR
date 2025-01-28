function r= uminus(obj)


% UMINUS Overload the unary minus operator for multivectors.
%
% SYNTAX:
%   r = -obj
%
% DESCRIPTION:
%   This function overloads the unary minus operator `-` for the
%   multivector (MV) class, allowing expressions like `-e1`. It negates
%   the components of a multivector or a matrix of multivectors.
%
% INPUT:
%   obj : A multivector (MV) or a matrix of multivectors.
%
% OUTPUT:
%   r : A multivector (MV) or matrix of multivectors with all components
%       negated.
%
% NOTES:
%   - The function supports both single multivectors and matrices of
%     multivectors.
%
% EXAMPLES:
%   % Create a multivector
%   mv = MV([1, 2, 3, 4], [2, 0, 0]);
%   % Negate the multivector
%   neg_mv = -mv;
%
%   % Display the result
%   disp(neg_mv);
%
%   % Create a matrix of multivectors
%   mv_matrix = [mv, mv; mv, mv];
%   % Negate the matrix of multivectors
%   neg_matrix = -mv_matrix;
%
%   % Display the result
%   disp(neg_matrix);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%
% See also MV, uplus


    % overload the unary minus operator, so you can erite -e1
    [f,c]=size(obj);
    if f==1 && c==1
        r=MV();
        r.Lsignature=obj.Lsignature;
        r.Basis=obj.Basis;
        r.matrix=-obj.matrix;
        r.Signs=obj.Signs;
        r.REPR=obj.REPR;
        r.vec=-obj.vec;
    else
        for i=1:f
            for j=1:c
                r(i,j)=-obj(i,j);
            end
        end
    end
end


