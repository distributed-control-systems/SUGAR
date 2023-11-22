function r= outter(obj1,obj2)
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
            f=MV.precoded_outter_product_function(obj1.Lsignature);
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

