function r= and(obj1,obj2)


% AND - Computes the wedge product (vee) of two multivectors.
%
% Syntax:
%   r = and(obj1, obj2)
%
% Description:
%   This function computes the wedge product of two multivectors (MV)
%   represented by the objects obj1 and obj2. The wedge product is defined
%   as the dual of the product of the duals of the input multivectors.
%
% Input:
%   obj1 - (MV) The first multivector whose wedge product is to be computed.
%   obj2 - (MV) The second multivector whose wedge product is to be computed.
%
% Output:
%   r - (MV) The resulting multivector after computing the wedge product.
%
% Example:
%   mv1 = MV([1, 2, 3], [1, 1, 0]);
%   mv2 = MV([4, 5, 6], [1, 1, 0]);
%   result = and(mv1, mv2);
%   disp(result); % Displays the result of the wedge product
%
% Note:
%   The function checks if the signatures of both multivectors are the same.
%   If they are not, an error is raised.



    % This function computes the vee of two MV
    % !(!o1.^!o2)
    if obj1.Lsignature==obj2.Lsignature
        rd=obj1.dual.^obj2.dual;
        r=rd.dual;
    else
        error("Signatures don't agree in the product")
    end
end


