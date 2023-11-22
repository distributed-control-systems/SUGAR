function r= simplify(self)
    % Overload the symbolic simplify function by applying it to each
    % coeficient of the MV
    % TODO this function requires more work to cover all cases, we have
    % implemented the basic usage
    if class(self)~="MV"
        error("When asking for simplify the parameter must be a multivector")
    else
        [f,c]=size(self);
        % Is this a scalar?
        if f*c==1
            % yes, apply simplify to each element
            r=MV(simplify(self.vec),self.Lsignature);
            r.REPR=self.REPR;
        else
            % No, go element by element
            for k=1:f
                for kk=1:c
                    r(k,kk)=simplify(self(k,kk));
                end
            end
        end
    end
end

