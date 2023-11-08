function n = numArgumentsFromSubscript(obj,s,indexingContext)
    if indexingContext == matlab.mixin.util.IndexingContext.Expression
        n = 1;
    elseif indexingContext == matlab.mixin.util.IndexingContext.Statement
        n=1;
    else
        n = length(s(1).subs{:});
    end
end

