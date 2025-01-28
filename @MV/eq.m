function r= eq(obj1,obj2)


% EQ - Overloads the equality operator for multivectors.
%
% Syntax:
%   r = eq(obj1, obj2)
%
% Description:
%   This function overloads the equality operator to compare two
%   multivectors. It checks whether the multivectors belong to the
%   same algebra and whether their components are equal.
%
% Input:
%   obj1 - (MV) The first multivector to be compared.
%   obj2 - (MV) The second multivector to be compared.
%
% Output:
%   r - (logical) Returns 1 (true) if the multivectors are equal,
%       and 0 (false) otherwise. An error is thrown if the multivectors
%       do not belong to the same algebra.
%
% Example:
%   mv1 = MV([1, 2, 3], [1, 1, 0]);
%   mv2 = MV([1, 2, 3], [1, 1, 0]);
%   isEqual = eq(mv1, mv2);  % Checks if mv1 and mv2 are equal
%
% Note:
%   The function checks the signature of the multivectors to ensure
%   they belong to the same algebra before comparing their components.


    % Overloading equality function
    % The MV must belong to the same algebra
    if obj1.Lsignature==obj2.Lsignature
        % The MV must have the same components
        if(obj1.vec==obj2.vec)
            r=1;
        else
            r=0;
        end
    else
        error("Multivectors must belong to the same algebra ")
    end

end


