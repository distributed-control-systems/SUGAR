function r=log(obj)
% Base e logarithm of a MV
r=fun(obj,@(x,x_)log(x));
% if class(imag(r.vector))=="double"
%     if any((imag(r.vector)))
%         syms Z
%         r=MV(simplify(real(r.vector)),obj.Lsignature)+MV(simplify(imag(r.vector))*Z,obj.Lsignature);
%         fprintf("The solution to the log function is parametrized by  Z such that Z*Z+1=0")
%     end
% elseif class(imag(r.vector))=="sym"
%     try 
%         v=double(simplify(imag(r.vector)));
%         if any(v)
%             syms Z
%             r=MV(simplify(real(r.vector)),obj.Lsignature)+MV(simplify(imag(r.vector))*Z,obj.Lsignature);
%             fprintf("The solution to the log function is parametrized by  Z such that Z*Z+1=0")
%         else
%             r=MV(simplify(real(r.vector)),obj.Lsignature);
%         end
%     catch
%         syms Z
%         vector=subs(simplify(r.vector),1i,Z);
%         %r=MV(simplify(real(r.vector)),obj.Lsignature)+MV(simplify(imag(r.vector))*Z,obj.Lsignature);
%         r=MV(vector,obj.Lsignature)
%         fprintf("The solution to the log function is parametrized by  Z such that Z*Z+1=0")
%     end
% end
end