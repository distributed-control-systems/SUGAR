function r= abs(self)


% ABS - Computes the absolute value of a multivector (MV) object.
%
% Syntax:
%   r = abs(self)
%
% Description:
%   This function calculates the absolute value of the input multivector
%   and returns a new MV object containing the absolute values.
%
% Input:
%   self - (MV) An instance of the MV class, representing a multivector.
%
% Output:
%   r - (MV) A new multivector object with absolute values applied to
%       each element of the original vector.
%
% Example:
%   mv = MV([1, 2, 3, 4], [1, 1, 0]);
%   r = abs(mv);
%   disp(r); % Displays the multivector with absolute values


    r=MV(abs(self.vector),self.Lsignature,self.REPR);
end


