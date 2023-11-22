function basis(sig,options)
% Just for backuards compatibility.
% We have decided that the right way to generate an algebra should be GA or
% CGA
    warning("basis() is deprecated, use GA() instead\n ")
    if nargin==1
        GA(sig)
    else
        GA(sig,options)
    end
end