function r=log(obj)
% Base e logarithm of a MV
    r=fun(obj,@(x,x_)log(x));
     if any(imag(r.vector))
        syms Z
        r=MV(real(r.vector),obj.Lsignature)+MV(imag(r.vector)*Z,obj.Lsignature);
        fprintf("The solution to the log function is parametrized by  Z such that Z*Z+1=0")
    end
end