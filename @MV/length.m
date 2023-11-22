function r= length(self)
    % Recover magnitude of a MV
    k=self*self.conj;
    l=k.vector;
    r=sqrt(abs(l(1)));
end

