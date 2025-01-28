function r= str(obj1)


% STR Convert a multivector to a formatted string representation.
%
% SYNTAX:
%   r = str(obj1)
%
% DESCRIPTION:
%   This function converts a multivector (MV) into a formatted text string
%   representation, taking into account the basis elements and their labels.
%   For Conformal Geometric Algebra (CGA) objects, it applies a basis change
%   before generating the string. For standard Geometric Algebra (GA) objects,
%   no basis change is applied.
%
% INPUT:
%   obj1 : An instance of the multivector (MV) class containing:
%          - vec: The vector representation of the MV.
%          - Lsignature: The signature of the algebra.
%          - REPR: The representation type ('CGA' or 'GA').
%          - Basis: The labels for the basis elements of the MV.
%
% OUTPUT:
%   r : A string representing the multivector, formatted with its basis
%       components and coefficients.
%
% NOTES:
%   - For CGA objects, a basis change is applied using `CGA_matrix`.
%   - Coefficients are formatted as numbers or symbolic expressions,
%     depending on their type.
%
% EXAMPLES:
%   % Create a CGA multivector object
%   mv = MV([1, 2, 3, 0], [1, 1, 0], 'CGA');
%   % Convert it to a string
%   str_mv = str(mv);
%
%   % Display the string
%   disp(str_mv); % This contains the special orange characters of the
%   basis
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, CGA_matrix


    % Get a text string that represents the object
    % If this is a CGA object a variable change must be aplyed
    if obj1.REPR=="CGA"
        % Get the basis change matrix, and the labels of the new basis
        [Matrix,Labels]=obj1.CGA_matrix(obj1.Lsignature);
        % Aply it to the vector
        vec=obj1.vec*Matrix;
        % Start geting the text description, component by component, adding
        % the basis name
        r="";
        for k=1:length(vec)
            if vec(k)~=0
                if class(vec(k))=="double"
                    if isnan(vec(k))
                        val="NaN";
                    else
                        val=vec(k);
                    end
                    r=r+"+( "+val+" )[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                else
                    r=r+"+( "+char(vec(k))+" )[\b"+Labels(k)+"]\b ";%e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end

        end

        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    else
        % For GA multivectors no change of basis is required
        r="";
        % Go one by one generating the representation
        for k=1:length(obj1.vec)
            if obj1.vec(k)~=0
                if class(obj1.vec(k))=="double"
                    r=r+"+("+obj1.vec(k)+")*[\b"+obj1.Basis{k}+"]\b ";%e"+strrep(obj1.Basis{k},",","");
                else
                    r=r+"+("+char(obj1.vec(k))+")*[\b"+obj1.Basis{k}+"]\b "; %e"+strrep(obj1.Basis{k}+"</strong>",",","");
                end
            end
        end
        if r==""
            r=" 0 ";
        end
        r=extractAfter(r,1);
    end
end


