function r= times(obj1,obj2)


% TIMES Overload the .* operator for the inner product of multivectors.
%
% SYNTAX:
%   r = times(obj1, obj2)
%
% DESCRIPTION:
%   This function overloads the `.*` operator to compute the inner
%   product of two multivectors (MV) in a geometric algebra. The
%   result is a new multivector.
%
% INPUT:
%   obj1 : The first multivector (MV) object.
%   obj2 : The second multivector (MV) object.
%
% OUTPUT:
%   r : A new multivector (MV) object representing the inner product
%       of the two input multivectors.
%
% NOTES:
%   - This function provides a shorthand for `MV.inner(obj1, obj2)`.
%   - Ensure that the inputs are compatible multivectors.
%
% EXAMPLES:
%   % Create two multivector objects
%   mv1 = MV([1, 2, 3, 2], [2, 0, 0]);
%   mv2 = MV([4, 5, 6, 4], [2, 0, 0]);
%   % Compute their inner product
%   r = mv1 .* mv2;
%
%   % Display the result
%   disp(r);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%
% See also MV, inner


    %Overload .^ to inner product 
    r=MV.inner(obj1,obj2);
end


