function n = numArgumentsFromSubscript(obj,s,indexingContext)


% NUMARGUMENTSFROMSUBSCRIPT - Returns the number of arguments from a subscript expression.
%
% Syntax:
%   n = numArgumentsFromSubscript(obj, s, indexingContext)
%
% Description:
%   This function determines the number of arguments in a subscript expression
%   depending on the indexing context (either Expression or Statement). The
%   function helps in managing how subscripts are used for indexing objects
%   in a custom class.
%
% Input:
%   obj - (Object) The object being indexed.
%   s - (Subscript) The subscript being used to index into the object.
%   indexingContext - (matlab.mixin.util.IndexingContext) The context of indexing,
%                     which can be either an Expression or a Statement.
%
% Output:
%   n - (Integer) The number of arguments in the subscript.
%
% Example:
%   obj = MyClass();
%   n = numArgumentsFromSubscript(obj, s, indexingContext);
%   disp(n);  % Displays the number of arguments in the subscript
%
% Note:
%   The function checks the indexing context and calculates the number of arguments
%   accordingly. In the context of an Expression or Statement, it returns 1. In other
%   cases, it calculates the length of the subscripts used.


    if indexingContext == matlab.mixin.util.IndexingContext.Expression
        n = 1;
    elseif indexingContext == matlab.mixin.util.IndexingContext.Statement
        n=1;
    else
        n = length(s(1).subs{:});
    end
end


