function r= length(self)
    % Recover magnitude of a MV
    k=self*self.reverse;
    l=k.vector;
    r=sqrt(abs(l(1)));
end

