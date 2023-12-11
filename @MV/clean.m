function r= clean(self)
% Reove those nasty e-16 whn doing numerical computations
[f,c]=size(self);
% Is this a matrix?
if f*c==1
    k=self.vector;
    % We don't expect complex numbers here
    M=abs(k)>1e-6;
    % Rebuid the vector
    r=MV(self.vector.*M,self.Lsignature,self.REPR);
else

    R=self;
    for i=1:f
        for j=1:c
            % Clean each element
            R(i,j)=R(i,j).clean();
        end
    end
    r=R;
end
end

