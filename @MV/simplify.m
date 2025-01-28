function r= simplify(self)


% SIMPLIFY Simplify the coefficients of a multivector in a geometric algebra.
%
% SYNTAX:
%   r = simplify(self)
%
% DESCRIPTION:
%   This function simplifies the symbolic coefficients of a multivector (MV)
%   in a geometric algebra. It applies the MATLAB `simplify` function to each
%   coefficient in the multivector's representation. The function handles both
%   scalar multivectors and matrices of multivectors.
%
% INPUT:
%   self : An instance of the multivector (MV) class, which may contain
%          symbolic coefficients.
%
% OUTPUT:
%   r : A new multivector (or matrix of multivectors) with simplified coefficients.
%
% NOTES:
%   - This function supports symbolic coefficients, simplifying them where
%     applicable.
%   - Currently, the function implements basic usage and may require
%     additional enhancements to handle all possible edge cases.
%
% EXAMPLES:
%   % Create a symbolic multivector
%   mv = MV(sym([1, x, x^2, (x+y)*(x-y)]), [2, 0, 0]);
%   % Simplify the multivector
%   r = simplify(mv);
%
%   % Display the simplified result
%   disp(r);
%
% REFERENCES:
%   - MATLAB Symbolic Math Toolbox Documentation
%
% See also MV, sym, simplify


    % Overload the symbolic simplify function by applying it to each
    % coeficient of the MV
    % TODO this function requires more work to cover all cases, we have
    % implemented the basic usage
    if class(self)~="MV"
        error("When asking for simplify the parameter must be a multivector")
    else
        [f,c]=size(self);
        % Is this a scalar?
        if f*c==1
            % yes, apply simplify to each element
            r=MV(simplify(self.vec),self.Lsignature);
            r.REPR=self.REPR;
        else
            % No, go element by element
            for k=1:f
                for kk=1:c
                    r(k,kk)=simplify(self(k,kk));
                end
            end
        end
    end
end


