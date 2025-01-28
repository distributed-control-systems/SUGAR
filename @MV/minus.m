function r= minus(obj1,obj2)


% MINUS - Subtracts one multivector from another.
%
% Syntax:
%   r = minus(obj1, obj2)
%
% Description:
%   This function performs subtraction between two multivectors or
%   between a multivector and a scalar. If either operand is a scalar,
%   it is converted to a multivector before performing the subtraction.
%
% Input:
%   obj1 - (MV or scalar) The first multivector or scalar.
%   obj2 - (MV or scalar) The second multivector or scalar to be subtracted.
%
% Output:
%   r - (MV) The resulting multivector after subtraction.
%
% Example:
%   mv1 = MV([3, 5], [0, 1, 0]);
%   mv2 = MV([1, 2], [0, 1, 0]);
%   result = minus(mv1, mv2);  % Subtracts mv2 from mv1
%   disp(result); % Displays the resulting multivector
%
% Note:
%   The function ensures that both multivectors belong to the same algebra
%   and handles conversions of scalars to multivectors as necessary.


    [f,c]=size(obj1);
    if f==1 && c==1
        if class(obj1)=="double" || class(obj1)=="sym"
            %v=obj2.vec*0;
            %v(1)=obj1;
            obj1=MV([obj1 zeros(1,2^sum(obj2.Lsignature)-1)],obj2.Lsignature,obj2.REPR);
%             obj1.Basis=obj2.Basis;
%             obj1.Lsignature=obj2.Lsignature;
%             obj1.vec=v;
%             obj1.Signs=obj2.Signs;
%             obj1.REPR=obj2.REPR;
%             obj1.matrix=obj1.get_matrix_repr();
%             %obj1=MV(v,obj2.Lsignature);
        end
        if class(obj2)=="double" || class(obj2)=="sym"
            v=obj1.vec*0;
            v(1)=obj2;
            obj2=MV();
            obj2.Basis=obj1.Basis;
            obj2.Lsignature=obj1.Lsignature;
            obj2.vec=v;
            obj2.Signs=obj1.Signs;
            obj2.REPR=obj1.REPR;
            obj2.matrix=obj2.get_matrix_repr();

            %obj2=MV(v,obj1.Lsignature);
        end
        if obj1.Lsignature==obj2.Lsignature
            r=MV();
            r.Basis=obj1.Basis;
            r.Lsignature=obj1.Lsignature;
            r.vec=obj1.vec-obj2.vec;
            r.Signs=obj1.Signs;
            r.REPR=obj1.REPR;
            r.matrix=r.get_matrix_repr();
            %r=MV(obj1.vec+obj2.vec,obj1.Lsignature);
        else
            error("Objects comming from different algebras cannot be added")
        end
    else
        for i=1:f
            for j=1:c
                r(i,j)=obj1(i,j)-obj2(i,j);
            end
        end
    end
end



