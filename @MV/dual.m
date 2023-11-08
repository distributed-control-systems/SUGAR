function r= dual(self)
% This function requires some extra work...
if self.REPR=="CGA"
    %self.get_pseudo_scalar(self);
    S=sum(self.Lsignature);
    v=zeros(1,2^S);
    v(end)=1;
    % if S==4
    %     I=MV([0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1],self.Lsignature,"CGA");
    % end
    % if S==5
    %     I=MV([0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0    0     0     0  0     0     0     0     0     0     1],self.Lsignature,"CGA");
    % end
    I=MV(v,self.Lsignature,"CGA");
    r=self*I;
else
    [stamp,sign]=self.dualizer(self.Lsignature);
    r=MV(self.vec(stamp).*sign,self.Lsignature);
end
r.REPR=self.REPR;
end

