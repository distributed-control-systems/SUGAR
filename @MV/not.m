function r=not(self)


% NOT - Logical negation for a multivector.
%
% Syntax:
%   r = not(self)
%
% Description:
%   This function applies the reverse operation to the multivector,
%   effectively performing a logical negation on the multivector.
%
% Input:
%   self - (MV) The multivector to which the logical negation is applied.
%
% Output:
%   r - (MV) The reversed multivector, which represents the logical negation.
%
% Example:
%   mv = MV([1, 2, 3, 4], [2, 0]);
%   mv_negated = not(mv);  % Applies the negation (reverse) to mv
%   disp(mv_negated);  % Displays the negated multivector
%
% Note:
%   The function calls the `reverse` method on the multivector, which
%   is typically used to apply a reflection or reverse operation depending
%   on the algebra's definition.


    r=self.reverse();
end
