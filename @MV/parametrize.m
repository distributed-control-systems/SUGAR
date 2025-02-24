function r=parametrize(obj,ff)


% PARAMETRIZE - Parametrizes the vector of a multivector, especially useful
% for handling multivectors with complex components.
%
% Syntax:
%   r = parametrize(obj, ff)
%
% Description:
%   This function checks whether the components of the multivector are
%   complex and parametrizes them accordingly. If the vector has an imaginary
%   part, it creates a symbolic multivector `Z` such that `Z*Z + 1 = 0`.
%   The result is returned as a new multivector. This is typically useful
%   when solving for complex-valued solutions in the algebra.
%
% Input:
%   obj - (MV) A multivector object to be parametrized.
%   ff - (Function) A function handle in string format that represents the
%        function to be parametrized.
%
% Output:
%   r - (MV) The parametrized multivector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [2, 0]);
%   result = parametrize(mv, '@(x,x_)log(x)');
%   disp(result);  % Displays the parametrized multivector
%
% Note:
%   This function supports both real and symbolic values for the multivector's
%   components. If the imaginary part is present, the function creates a symbolic
%   representation for the solution.


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
