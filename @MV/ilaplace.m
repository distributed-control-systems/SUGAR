function r=ilaplace(self,varargin)


% ILAPLACE - Computes the inverse Laplace transform of a multivector.
%
% Syntax:
%   r = ilaplace(self, varargin)
%
% Description:
%   This function calculates the inverse Laplace transform of a multivector
%   or a matrix of multivectors. It applies the inverse Laplace transform to
%   each coefficient of the multivector.
%
% Input:
%   self - (MV) The multivector object for which the inverse Laplace transform
%           is to be computed.
%   varargin - Additional arguments to pass to the ilaplace function for each
%              coefficient.
%
% Output:
%   r - (MV) The resulting multivector after applying the inverse Laplace
%           transform.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   result_mv = ilaplace(mv, 's');  % Computes the inverse Laplace transform
%   disp(result_mv); % Displays the resulting multivector
%
% Note:
%   The function checks if the input is a single multivector or a matrix of
%   multivectors and applies the inverse Laplace transform accordingly.


    [f,c]=size(self);
    if f*c==1
        % make the laplace transform of each coefficient
        r=MV(ilaplace(self.vector,varargin{:}),self.Lsignature,self.REPR);
    else
        r=self*0
        for i=1:f
            for i=1:c
                r(i,j)=ilaplace(self(i,j),varargin{:});
            end
        end
    end
end
