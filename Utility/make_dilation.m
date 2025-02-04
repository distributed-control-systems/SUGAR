function R=make_dilation(amount)
% MAKE_DILATION  Constructs a bivector representing a dilation transformation.
%
%   R = MAKE_DILATION(AMOUNT) generates a rotor that performs a dilation
%   transformation in Conformal Geometric Algebra (CGA). The dilation is
%   parameterized by the scalar `AMOUNT`, which determines the scaling factor.
%
%   Input:
%     - amount: Scalar value representing the logarithm of the dilation factor.
%
%   Output:
%     - R: Multivector representing the dilation rotor.
%
%   Description:
%     The function retrieves the null basis vectors `n0` and `ni` from the
%     workspace and constructs the bivector `n0 .^ ni`. The dilation rotor
%     is computed as `exp(-(amount/2) * (n0 .^ ni))`.
%
%   Special Cases:
%     - If the rotor contains only near-zero coefficients (below 1e-6), 
%       they are filtered out for numerical stability.
%
%   Example:
%     R = make_dilation(0.5);
%
%   See also EXP, MV
    n0= evalin('base','n0');
    ni= evalin('base','ni');
    
    n0ni=n0.^ni;
    k=exp(-(amount/2)*n0ni);
    if class(k.vector)=="double"
        S=abs(k.vector)>1e-6;
        R=MV(k.vector.*S,n0ni.Lsignature,n0ni.REPR);
    else
        R=k;
    end
end
