function r= subs(self,varargin)


% SUBS Substitute variables or expressions in a multivector.
%
% SYNTAX:
%   r = subs(self, old, new)
%   r = subs(self)
%
% DESCRIPTION:
%   This function overloads the `subs` function for the multivector (MV)
%   class, allowing element-wise or coefficient-wise substitution of
%   symbolic variables or expressions. It converts the multivector into
%   its "super matrix" representation, applies the substitution, and
%   converts it back to the multivector format.
%
%   NOTE: This function is under development, and additional work is
%   required to handle all possible cases.
%
% INPUT:
%   self    : An instance of the multivector (MV) class.
%   varargin: Variable input arguments. The typical usage is:
%             - old: The variable or expression to be substituted.
%             - new: The value or expression to replace it with.
%
% OUTPUT:
%   r : A new multivector (MV) object after applying the substitution.
%
% NOTES:
%   - Currently, the function supports basic substitution scenarios.
%   - Further enhancements are planned to cover complex cases.
%
% EXAMPLES:
%   % Create a symbolic multivector
%   mv = MV(sym([x, y, z]), [2, 0, 0]);
%   % Substitute x with 5
%   r = subs(mv, x, 5);
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - MATLAB Symbolic Math Toolbox Documentation
%
% See also MV, symbolic.subs


    % Overload the subs function from symbolic class
    % This just goes element by element or coefficient by coefficient
    % aplying the required subs

    % More work has to be done to cover all posibilities

    if class(self)=="MV"
        SM=self.to_SUPER_MATRIX();
        %%varargin

        if nargin==3
            SUPER_EXP=subs(SM,varargin{1},varargin{2});
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        elseif nargin==1
            SUPER_EXP=subs(SM);
            r=from_SUPER_MATRIX(self,SUPER_EXP);
        end
    else
        r=subs(self,varargin{1},varargin{2});
    end
end


