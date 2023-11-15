function r= collect(self,arg2)
    % Overload of collect function
    if class(self)~="MV"
        error("When asking for collect the object must be a multivector")
    else
        [f,c]=size(self);
        % Is it a matrix
        if f*c==1
            % Call the original collect
            if nargin==1
                r=MV(collect(self.vec),self.Lsignature);
            elseif nargin==2
                r=MV(collect(self.vec,arg2),self.Lsignature);
            end
        else
            %We have a matrix, lets go element by element
            for k=1:f
                for kk=1:c
                    if nargin==1
                        r(k,kk)=collect(self(k,kk));
                    elseif nargin==2
                        r(k,kk)=collect(self(k,kk),arg2);
                    end
                end
            end
        end

    end
end


