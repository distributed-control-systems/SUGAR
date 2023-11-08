function r= collect(self)
    if class(self)~="MV"
        error("When asking for collect the object must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1

            r=MV(collect(self.vec),self.Lsignature);
        else
            %hay que ir fila a fila
            for k=1:f
                for kk=1:c
                    r(k,kk)=collect(self(k,kk));
                end
            end
        end

    end
end


