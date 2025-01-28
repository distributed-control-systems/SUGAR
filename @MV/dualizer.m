function [stamp,sign]= dualizer(sig)


% DUALIZER - Computes the structure of the dual space for any algebra.
%
% Syntax:
%   [stamp, sign] = dualizer(sig)
%
% Description:
%   This special function computes the indices (stamps) and the signs
%   associated with the dual space of a given algebra based on its signature.
%   The function caches results for previously computed signatures to improve
%   efficiency and avoid redundant calculations.
%
% Input:
%   sig - (1x3 array) The signature of the algebra in the form [p, q, r].
%
% Output:
%   stamp - (array) The indices of the dual vector corresponding to the given algebra.
%   sign - (array) The signs for the dual space elements.
%
% Example:
%   [stamp, sign] = dualizer([2, 1, 0]);
%
% Note:
%   The function uses persistent variables to cache the results of previous
%   computations for the same algebra signature. This allows for efficient
%   retrieval without recalculating the dual structure.


    % This is a special function that computes the structure of the sual
    % space for any algebra

    persistent stamps
    persistent signatures
    persistent signs
    if isempty(stamps)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        signs{10,10,10}=0;
    end
    % Did we acces this function with this signature before?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % NO, so lets compute everithing
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        % Lets compute stamps, just reverse the vector
        n=sum(sig);
        dim=2^n;
        v=dim:-1:1;
        % Stamps are the indices of the dual vector
        stamps{sig(1)+1,sig(2)+1,sig(3)+1}=v;

        %lets compute the signs, to do so just multipy by
        %pseudoscalar in a full positive equivalent basis
        ss=zeros(1,2^n);
        for i=1:2^n
            z=zeros(1,2^n);
            zz=zeros(1,2^n);
            z(i)=1;
            zz(end-i+1)=1;
            elemento1=MV(z,sig);
            elemento2=MV(zz,sig);
            res=elemento1*elemento2;
            ss(i)=sum(res.vec);
        end
        signs{sig(1)+1,sig(2)+1,sig(3)+1}=ss;
    end

    stamp=stamps{sig(1)+1,sig(2)+1,sig(3)+1};
    sign=signs{sig(1)+1,sig(2)+1,sig(3)+1};

end


