function r=parametrize(obj,ff)
[f,c]=size(obj);
if f*c==1
if class(imag(obj.vector))=="double"
    if any((imag(obj.vector)))
        syms Z
        r=MV((real(obj.vector)),obj.Lsignature)+MV((imag(obj.vector))*Z,obj.Lsignature);
        fprintf("The solution to the "+strrep(ff,"@(x,x_)","")+" function is parametrized by any multivector Z such that Z*Z+1=0")
    end
elseif class(imag(obj.vector))=="sym"
    try 
        v=double(simplify(imag(obj.vector)));
        if any(v)
            syms Z
            r=MV(simplify(real(obj.vector)),obj.Lsignature)+MV(simplify(imag(obj.vector))*Z,obj.Lsignature);
            fprintf("The solution to the "+strrep(ff,"@(x,x_)","")+" function is parametrized by any multivector Z such that Z*Z+1=0")
        else
            r=MV(simplify(real(r.vector)),obj.Lsignature);
        end
    catch
        syms Z
        vector=subs(simplify(r.vector),1i,Z);
        %r=MV(simplify(real(r.vector)),obj.Lsignature)+MV(simplify(imag(r.vector))*Z,obj.Lsignature);
        r=MV(vector,obj.Lsignature)
        fprintf("The solution to the "+ff+" function is parametrized by  Z such that Z*Z+1=0")
    end
end
else
    % TODO
    r=obj;
end