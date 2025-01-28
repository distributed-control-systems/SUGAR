function r= latex(obj1)


% LATEX - Generates the LaTeX representation of a multivector.
%
% Syntax:
%   r = latex(obj1)
%
% Description:
%   This function creates a LaTeX string representation of a multivector
%   or a matrix of multivectors. It is designed to facilitate easy
%   inclusion of multivector representations in LaTeX documents.
%
% Input:
%   obj1 - (MV) The multivector object for which the LaTeX representation
%           is to be generated.
%
% Output:
%   r - (string) The LaTeX representation of the multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   latex_representation = latex(mv);  % Gets the LaTeX representation
%   disp(latex_representation); % Displays the LaTeX string
%
% Note:
%   The function checks whether the input is a single multivector or a
%   matrix of multivectors and generates the corresponding LaTeX format
%   accordingly.


    % Nice function to get the Latex representation of a MV. It save some
    % time tiping in a document
    [f,c]=size(obj1);
    % Is it a matrix?
    if f*c==1
        % No
        % Thet the latex string
        r=obj1.latex_str();

    else
        % Yes...
        % Start by opening a matrix
        r="\left[\begin{array}{";
        for i=1:c
            r=r+"c";
        end
        r=r+"}";
        % End of matrix declaration
        for i=1:f
            for j=1:c
                % Go one by one geting the latex string
                r=r+obj1(i,j).latex_str();
                % separator
                r=r+"  &  ";
            end
            %size(r)
            r=extractBefore(r,strlength(r)-2);
            % New line
            r=r+"\\ ";
        end
        % End array
        r=r+"\end{array}\right]";
    end
end



