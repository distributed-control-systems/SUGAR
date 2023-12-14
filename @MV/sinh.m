function r=sinh(obj)
% Computes the sinh of a MV
    r=fun(obj,@(x,x_)sinh(x));
end
