function structure= full_algebra_basis_coefs(sig)


% FULL_ALGEBRA_BASIS_COEFS - Computes the basis combinations for a given algebra.
%
% Syntax:
%   structure = full_algebra_basis_coefs(sig)
%
% Description:
%   This function generates the combinations of basis names for a given
%   algebra based on its signature. The combinations are computed without
%   repetition and are arranged in lexicographic order. The results are cached
%   for efficient retrieval in subsequent calls.
%
% Input:
%   sig - (1x3 array) The signature of the algebra in the form [p, q, r].
%
% Output:
%   structure - (cell array) The computed basis combinations for the algebra.
%
% Example:
%   basis_structure = full_algebra_basis_coefs([2, 1, 0]);
%
% Note:
%   The function uses persistent variables to cache results for previously
%   computed signatures to improve efficiency.


    % So, once you have an Algebra, which are the basis names that we must
    % print on the screen? This function computes such combinations

    persistent signatures
    persistent structures
    if isempty (signatures)
        structures{10,10,10}=0;
        signatures{10,10,10}=0;
    end
    % Did we enter this function with this signature before?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % No, lets build the basis combinations without repetition and with
        % lexicografic order
        BASE=num2cell(1:sum(sig));
        for i=2:sum(sig)
            V=nchoosek(1:sum(sig),i);
            elements=size(V,1);
            for j=1:elements
                BASE=[BASE V(j,:)];
            end
        end
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        structures{sig(1)+1,sig(2)+1,sig(3)+1}=BASE;
    end
    structure=structures{sig(1)+1,sig(2)+1,sig(3)+1};
end


