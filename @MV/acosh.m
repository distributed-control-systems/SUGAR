function r=acosh(obj)
% Computes the acosh of a MV
    r=fun(obj,@(x,x_)acosh(x));
end
