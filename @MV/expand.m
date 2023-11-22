function r= expand(self)
    % Overload of the symbolic function expand
    if class(self)~="MV"
        error("When asking for expand the parameter must be a multivector")
    else
        [f,c]=size(self);
        % Is it a mtraix?
        if f*c==1
            % Just apply expand to each coeficient
            r=MV(expand(self.vec),self.Lsignature);
        else
            %Lets go element by element
            for k=1:f
                for kk=1:c
                    r(k,kk)=expand(self(k,kk));
                end
            end
        end

    end
end

