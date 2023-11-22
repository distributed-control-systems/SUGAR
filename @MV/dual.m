function r= dual(self)
% This function requires some extra work, because we are using different
% descriptions of duality, depending on the algebra, which is strange.

if self.REPR=="CGA"
    %num of basis
    S=sum(self.Lsignature);
    %a zero vector in the right algebra
    v=zeros(1,2^S);
    v(end)=1;
    % The pseudoscalar
    I=MV(v,self.Lsignature,"CGA");
    % TODO, clearly, this is not going to work in a conformal algebra with
    % zero basis....
    r=self*I;
else
    % This is a dual of an standart vector, not CGA
    % We make a complement for each component
    % Recover the complement structure
    [stamp,sign]=self.dualizer(self.Lsignature);
    %Aply the complement structure
    r=MV(self.vec(stamp).*sign,self.Lsignature);
end
r.REPR=self.REPR;
end

