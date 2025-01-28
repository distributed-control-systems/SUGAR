function r= dual(self)


% DUAL - Computes the dual of the multivector.
%
% Syntax:
%   r = dual(self)
%
% Description:
%   This function calculates the dual of the multivector represented by
%   the object `self`. The computation of the dual depends on the type
%   of algebra being used (e.g., CGA or standard geometric algebra).
%   Special handling is included for cases with different signatures.
%
% Input:
%   self - (MV) The multivector object for which the dual is to be computed.
%
% Output:
%   r - (MV) The computed dual multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   dual_mv = mv.dual();  % Computes the dual of the multivector
%   disp(dual_mv); % Displays the dual multivector
%
% Note:
%   The function differentiates between CGA representations and standard
%   vector representations, handling the pseudoscalar differently in each case.


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
elseif self.Lsignature(end)==0
    %num of basis
    S=sum(self.Lsignature);
    %a zero vector in the right algebra
    v=zeros(1,2^S);
    v(end)=1;
    % The pseudoscalar
    I=MV(v,self.Lsignature);
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


