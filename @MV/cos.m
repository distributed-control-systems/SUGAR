function r=cos(obj)
    % Simple cosine of a matrix....
    
    r=fun(obj,@(x,x_)cos(x));
     if any(imag(r.vector))
        syms Z
        r=MV(real(r.vector),obj.Lsignature)+MV(imag(r.vector)*Z,obj.Lsignature);
        fprintf("The solution to the cos function is parametrized by  Z such that Z*Z+1=0")
    end
end