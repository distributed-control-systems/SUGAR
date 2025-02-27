function r=limit(self,varargin)


% LIMIT - Computes the limit of a symbolic multivector.
%
% Syntax:
%   r = limit(self, varargin)
%
% Description:
%   This function calculates the limit of a multivector
%   or a matrix of multivectors. It applies the limit to
%   each coefficient of the multivector, handling both single multivectors
%   and arrays of multivectors.
%
% Input:
%   self - (MV) The multivector object for which the Laplace transform
%           is to be computed.
%   varargin - Additional arguments to pass to the laplace function for
%              each coefficient. Thesse ara the same of the symbolic
%              function LIMIT, help sym/limit. 
%
% Output:
%   r - (MV) The resulting multivector after applying the limit.
%
% Example:
%    GA([2 0 0])
%    syms t
%    P=MV([t^2/2, 3/(t-1),t, 0],[2 0 0]);
%    limit(P,t,1)
%    limit(P,t,2)
%
% Note:
%   The function checks if the input is a single multivector or a matrix
%   of multivectors and applies the limit accordingly.


    [f,c]=size(self);
    if f*c==1
        % make the laplace transform of each coefficient
        r=MV(limit(self.vector,varargin{:}),self.Lsignature,self.REPR);
    else
        r=self*0
        for i=1:f
            for i=1:c
                r(i,j)=limit(self(i,j),varargin{:});
            end
        end
    end
end
