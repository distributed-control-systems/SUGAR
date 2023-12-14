function r=atanh(obj)
% Computes the atanh of a MV
    r=fun(obj,@(x,x_)atanh(x));
end
