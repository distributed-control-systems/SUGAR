function r= latex_str(obj1)


% LATEX_STR - Generates the LaTeX string representation of a multivector.
%
% Syntax:
%   r = latex_str(obj1)
%
% Description:
%   This function provides the LaTeX string representation of a multivector,
%   taking into account whether the multivector is based on conformal geometric
%   algebra (CGA) or not. It formats the coefficients and their corresponding
%   basis labels for proper LaTeX output.
%
% Input:
%   obj1 - (MV) The multivector object for which the LaTeX string representation
%           is to be generated.
%
% Output:
%   r - (string) The LaTeX representation of the multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   latex_representation = latex_str(mv);  % Gets the LaTeX representation
%   disp(latex_representation); % Displays the LaTeX string
%
% Note:
%   The function checks if the multivector is of type CGA and performs a
%   change of basis accordingly. It formats the output to ensure that
%   numerical coefficients are displayed properly in LaTeX.


    % This function provides the latex string, taking into account that the
    % MV may be a CGA MV

    % Is it CGA?
    if obj1.REPR=="CGA"
         % Yes
         % Change of basis
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        vec=obj1.vec*Matrix; 
        % Lets go
        r="";
        for k=1:length(vec)
            if vec(k)~=0
                if class(vec(k))=="double"
                    r=r+"+\left("+vec(k)+"\right)"+regexprep(Labels(k),"[0-9]+","_{$0}");
                else
                    r=r+"+\left("+latex(vec(k))+"\right)"+regexprep(Labels(k),"[0-9]+","_{$0}");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    else
    % Not CGA
        r="";
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                if class(obj1.vec(k))=="double"
                    r=r+"+\left("+obj1.vec(k)+"\right)"+regexprep(obj1.Basis{k},"[0-9]+","_{$0}");
                else
                    r=r+"+\left("+latex(obj1.vec(k))+"\right)"+regexprep(obj1.Basis{k},"[0-9]+","_{$0}");
                end
            end

        end
        if r==""
            r="  0 ";
        end
        r=extractAfter(r,1);
    end
end


