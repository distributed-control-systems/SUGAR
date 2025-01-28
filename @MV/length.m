function r= length(self)


% LENGTH - Computes the magnitude (length) of a multivector.
%
% Syntax:
%   r = length(self)
%
% Description:
%   This function calculates the magnitude of a multivector by
%   computing the inner product of the multivector with its
%   reverse and taking the square root of the first component
%   of the resulting vector.
%
% Input:
%   self - (MV) The multivector object for which the magnitude is to be computed.
%
% Output:
%   r - (double) The magnitude of the multivector.
%
% Example:
%   mv = MV([3, 4], [1, 0]);
%   mag = length(mv);  % Computes the magnitude of the multivector
%   disp(mag); % Displays the magnitude
%
% Note:
%   The function uses the concept of the reverse of a multivector and
%   assumes the first component of the inner product result contains
%   the squared magnitude.


    % Recover magnitude of a MV
    k=self*self.reverse;
    l=k.vector;
    r=sqrt(abs(l(1)));
end


