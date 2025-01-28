function r= super(self)


% SUPER Convert a multivector to its "super matrix" representation.
%
% SYNTAX:
%   r = super(self)
%
% DESCRIPTION:
%   This function converts the multivector (MV) into its corresponding
%   "super matrix" representation. Note that the function is poorly named
%   and is marked for removal in future versions.
%
% INPUT:
%   self : An instance of the multivector (MV) class.
%
% OUTPUT:
%   r : The "super matrix" representation of the multivector.
%
% NOTES:
%   - This function is deprecated and will be removed in a future release.
%   - Consider using `to_SUPER_MATRIX` directly instead.
%
% EXAMPLES:
%   % Convert a multivector to its super matrix representation
%   mv = MV([1, 2, 3], [1, -1, 0]);
%   r = super(mv);
%
%   % Display the result
%   disp(r);
%
% TODO:
%   - Remove this function in future releases.
%
% See also MV, to_SUPER_MATRIX


    % Bad name, I guess i don't use it, and it will be removed in future
    % verssions
    r=self.to_SUPER_MATRIX();
end


