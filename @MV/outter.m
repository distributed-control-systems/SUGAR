function r= outter(obj1,obj2)


% OUTTER - Computes the outer product of two multivectors.
%
% Syntax:
%   r = outter(obj1, obj2)
%
% Description:
%   This function calculates the outer product between two multivectors or
%   a multivector and a scalar. The outer product is computed element-wise
%   based on the algebra's structure and may either use a precoded function
%   or a slower explicit computation if the dimensions are large.
%
% Input:
%   obj1 - (MV or scalar) The first operand of the outer product.
%   obj2 - (MV) The second operand of the outer product (must be a multivector).
%
% Output:
%   r - (MV) The result of the outer product, represented as a multivector.
%
% Example:
%   mv1 = MV([1, 2, 3, 4], [2, 0]);
%   mv2 = MV([5, 6, 7, 8], [2, 0]);
%   result = outter(mv1, mv2);  % Computes the outer product of mv1 and mv2
%   disp(result);  % Displays the resulting multivector
%
% Note:
%   If one of the inputs is a scalar (e.g., double or symbolic), it will
%   be promoted to a multivector with the same signature as the second operand.
%   The function also includes precoded outer product functions for efficiency
%   when dealing with small algebras.


    % TODO add options to perform a matrix outter product

    %Outer product implementation
    % Sometimes people try to make otter with a scalar
    %TODO, check the reverse option
    if class(obj1)=="double" | class(obj1)=="sym"
        s=sum(obj2.Lsignature);
        v=zeros(1,2^s);
        v(1)=obj1;
        obj1=MV(v,obj2.Lsignature);
        obj1.REPR=obj2.REPR;
    end
    % Both objects do have the same signature
    if obj1.Lsignature==obj2.Lsignature
        % The size of the mother vector space
        n=sum(obj1.Lsignature);
        % We have a set of precoded outer functions 
        precoded=7;
        % If ot is not precoded perform the slow computation
        if n>=precoded
            % Let's apply the putter product formula
            % Get the blades structure
            B=MV.Blades(obj1.Lsignature);
            M1=obj1.matrix;
            M2=obj2.matrix;
            M=M1*0;
            % Go blade by blade
            for i=0:n
                for j=0:n
                    M=M+(M1.*B{i+1})*(M2.*B{j+1}).*B{i+j+1};
                end
            end
            v=M(:,1).';
            r=MV(v,obj1.Lsignature);
        % In case that this is precoded use the precoded function
        elseif n<precoded
            f=MV.precoded_outer_product_function(obj1.Lsignature);
            v=f(obj1.vec,obj2.vec);
            r=MV(v,obj1.Lsignature);
        end
        % Do no forget the representation
        if obj1.REPR=="CGA" || obj2.REPR=="CGA"
            r.REPR="CGA";
        end
    else
        error("Multivectors must belong to the same algebra ")
    end
end


