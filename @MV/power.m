function r= power(obj1,obj2)


% POWER - Overload of the .^ operator to perform the outer product between two multivectors (MV).
%
% Syntax:
%   r = obj1 .^ obj2
%
% Description:
%   This function overloads the element-wise power operator (.^) to compute the outer product
%   between two multivectors (MVs). This allows the use of the operator to perform the
%   outer product instead of the standard power operation.
%
% Input:
%   obj1 - (MV) The first multivector.
%   obj2 - (MV) The second multivector.
%
% Output:
%   r - (MV) The result of the outer product of the two multivectors.
%
% Example:
%   mv1 = MV([1, 2, 3, 4], [2, 0]);
%   mv2 = MV([4, 5, 6, 7], [2, 0]);
%   mv3 = mv1 .^ mv2;  % Performs the outer product of mv1 and mv2.
%
% Notes:
%   - This overload allows for multivector outer products using the .^ operator.
%   - The operator computes the outer product of the two MVs using the `outer` function.


    %Overload .^ to outer product 
    r=MV.outer(obj1,obj2);
end


