function r= ctranspose(self)
    % Overload of the operator '
    [f,c]=size(self);
    % Is it a matrix?
    if f*c==1
        % No, call the conjugate involution
        r=self.conj();
    else
        % yes
        % Transpose and conjugate involution
        for i=1:f
            for j=1:c
                r(j,i)=conj(self(i,j));
            end
        end
    end
end