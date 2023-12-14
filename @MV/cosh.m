function r=cosh(obj)
% Computes the cosh of a MV
    r=fun(obj,@(x,x_)cosh(x));
end
