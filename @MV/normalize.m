function r= normalize(self)
    % Normalize the size of a multi-vector
    l=length(self);
    if l>1e-6
        % Just divide by its length
        r=MV(self.vector/l,self.Lsignature,self.REPR);
    else
        % Here we have a problem, if the size of the vector is too
        % small..... I don't know what to return
        r=self;
    end
end

