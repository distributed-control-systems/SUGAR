function r= expand(self)
    if class(self)~="MV"
        error("When asking for expand the parameter must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1

            r=MV(expand(self.vec),self.Lsignature);
        else
            %hay que ir fila a fila
            for k=1:f
                for kk=1:c
                    r(k,kk)=expand(self(k,kk));
                end
            end
        end

    end
end

