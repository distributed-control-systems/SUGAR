function r= to_SUPER_MATRIX(self)


% TO_SUPER_MATRIX Convert a matrix of multivectors into a "super matrix."
%
% SYNTAX:
%   r = to_SUPER_MATRIX(self)
%
% DESCRIPTION:
%   This function constructs a large matrix ("super matrix") where each
%   element corresponds to the matrix representation of a multivector
%   in a matrix of multivectors. It is particularly useful for applying
%   functions such as `exp`, `log`, or other matrix operations on
%   multivector matrices.
%
% INPUT:
%   self : A matrix of multivectors (MV) objects.
%
% OUTPUT:
%   r : The resulting "super matrix," which is a symbolic or numeric
%       matrix depending on the presence of symbolic variables in the
%       multivector elements.
%
% NOTES:
%   - If any element of the multivector matrix contains symbolic
%     variables, the output will be a symbolic matrix.
%   - If all elements are numeric, the output will be converted to
%     a numeric (double) matrix.
%
% EXAMPLES:
%   % Create a 2x2 matrix of multivectors
%   mv1 = MV([1, 2, 3, 0], [2, 0, 0]);
%   mv2 = MV([3, 4, -1, -5], [2, 0, 0]);
%   matrix_of_mv = [mv1, mv2; mv2, mv1];
%
%   % Convert it to a super matrix
%   super_matrix = to_SUPER_MATRIX(matrix_of_mv);
%
%   % Display the result
%   disp(super_matrix);
%
% REFERENCES:
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, exp, log


    % Whenever you wanna compute the exp or the log or any function of a
    % matrix of multivectors you face a problem. This function composes a
    % BIG matrix ehere each element is the matrix representation of each
    % element of the matrix of multivectors
    [f,c]=size(self);
    dimension=2^sum(self(1,1).Lsignature);
    % As I don't know a priori if the elements of the matrix of
    % multivectors will have any symbolic variable I create a symbolic
    % matrix in order to accomodate any symbolic component
    SUPER_MATRIX=sym(zeros(f*dimension,c*dimension));
    row=0;
    for i=1:dimension:f*dimension
        row=row+1;
        column=0;
        for j=1:dimension:c*dimension
            column=column+1;
            SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(row,column).matrix;
        end
    end
    %try to convert to double, only if ALL the components are numeric....
    try
        r=double(SUPER_MATRIX);
    catch
        r=SUPER_MATRIX;
    end

end


