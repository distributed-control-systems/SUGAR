function loger(text,level)
% Development support
    if level>=MV.LogLevel
        fprintf(text);
    end
end