function r= normalize(self)
    % Normalize the size of a multi-vector
    l=length(self);
    
        % Just divide by its length
        r=MV(self.vector/l,self.Lsignature,self.REPR);
    
end

