function r= simplify(self)

    if class(self)~="MV"
        error("When asking for simplify the parameter must be a multivector")
    else
        [f,c]=size(self);
        if f*c==1
            r=MV(simplify(self.vec),self.Lsignature);
            r.REPR=self.REPR;
        else
            %hay que ir fila a fila
            for k=1:f
                for kk=1:c
                    r(k,kk)=simplify(self(k,kk));
                end
            end
        end
    end
end

