function r= mtimes(obj1,obj2)


% MTIMES - Multiplies two multivectors or a multivector with a scalar.
%
% Syntax:
%   r = mtimes(obj1, obj2)
%
% Description:
%   This function performs multiplication between two multivectors or
%   between a multivector and a scalar. It can handle different types
%   of multiplication, including multivector-multivector,
%   multivector-scalar, and scalar-multivector.
%
% Input:
%   obj1 - (MV or scalar) The first operand, which can be a multivector or a scalar.
%   obj2 - (MV or scalar) The second operand, which can be a multivector or a scalar.
%
% Output:
%   r - (MV) The resulting multivector after multiplication.
%
% Example:
%   mv1 = MV([1, 2], [1, 0]);
%   mv2 = MV([3, 4], [1, 0]);
%   result = mtimes(mv1, mv2);  % Multiplies mv1 by mv2
%   disp(result); % Displays the resulting multivector
%
% Note:
%   The function checks the types of the inputs and applies the appropriate
%   multiplication logic based on their classes and dimensions.


    % Determine product kind,
    % Matrix-Matrix,Matrix-scalar,scalar-Matrix, scalar-scalar
    [f1,c1]=size(obj1);
    [f2,c2]=size(obj2);

    if (f1+c1+f2+c2)==4 %scalar-scalar
        %Decide product nature MV-num, num-Mv, Mv-Mv
        %MV-MV
        if  class(obj1)=="MV" && class(obj2)=="MV"
            %is it alowed with the given signatures?

            if obj1.Lsignature==obj2.Lsignature
                matrix=obj1.matrix*obj2.matrix;

                r=MV();
                r.Basis=obj1.Basis;
                r.Lsignature=obj2.Lsignature;
                %sim
                r.vec=(matrix(:,1)).';
                r.Signs=obj1.Signs;
                r.REPR=obj1.REPR;
                %sim
                r.matrix=(matrix);

                %r=MV(simplify(matrix(:,1)).',obj1.Lsignature);
            else
                error("Signatures don't agree in the product")
            end
        end
        %MV-num, num-MV
        if (class(obj1)=="MV" && (class(obj2)=="double"||class(obj2)=="sym"))
            r=MV();
            r.vec=obj1.vec*obj2;
            r.Basis=obj1.Basis;
            r.Signs=obj1.Signs;
            r.REPR=obj1.REPR;
            r.Lsignature=obj1.Lsignature;
            r.matrix=obj1.matrix*obj2;
        end
        if (class(obj2)=="MV" && (class(obj1)=="double"||class(obj1)=="sym"))
            r=MV();
            r.vec=obj2.vec*obj1;
            r.Basis=obj2.Basis;
            r.Signs=obj2.Signs;
            r.REPR=obj2.REPR;
            r.Lsignature=obj2.Lsignature;
            r.matrix=obj2.matrix*obj1;
        end
        % Non scalar product, al least one element is matrix
    else
        %check Matrix-Matrix,Matrix-scalar,scalar-Matrix
        %scalar-Matrix
        if (f1+c1)==2
            for i=1:f2
                for j=1:c2
                    r(i,j)=obj1*obj2(i,j);
                end
            end

        end
        %Matrix-scalar
        if (f2+c2)==2
            for i=1:f1
                for j=1:c1
                    r(i,j)=obj1(i,j)*obj2;
                end
            end

        end
        %Matrix-Matrix
        if (f1+c1)>2 && (f2+c2)>2
            %check sizes
            if c1==f2
                for i=1:f1
                    for j=1:c2

                        p=MV();
                        if class(obj1)=="MV"
                            p.Basis=obj1(i,1).Basis;
                            p.Lsignature=obj1(i,1).Lsignature;
                            p.vec=(obj1(1,1).vec)*0;
                            p.Signs=obj1(1,1).Signs;
                            p.REPR=obj1(1,1).REPR;
                            p.matrix=(obj1(1,1).matrix)*0;
                        elseif class(obj2)=="MV"
                            p.Basis=obj2(i,1).Basis;
                            p.Lsignature=obj2(i,1).Lsignature;
                            p.vec=(obj2(1,1).vec)*0;
                            p.Signs=obj2(1,1).Signs;
                            p.REPR=obj2(1,1).REPR;
                            p.matrix=(obj2(1,1).matrix)*0;
                        else
                            error('None of the object is oc class MV')
                            return
                        end
                        for k=1:c1
                            p = p+obj1(i,k)*obj2(k,j);
                        end
                        %%% cal la representació matricial
                        r(i,j)=p;
                    end
                end
            else
                error('Wrong matrix dimenssions')
            end
        end
    end
end


