function R=make_inverssion(sphere)
% MAKE_INVERSSION  Constructs an inversion transformation from a sphere.
%
%   R = MAKE_INVERSSION(SPHERE) generates a rotor that represents an 
%   inversion transformation in Conformal Geometric Algebra (CGA).
%
%   Input:
%     - sphere: Multivector representing a sphere in CGA.
%
%   Output:
%     - R: Normalized multivector representing the inversion transformation.
%
%   Description:
%     The function takes a multivector `sphere`, assumed to represent a 
%     sphere in CGA, and normalizes it. The normalization ensures that 
%     the inversion transformation is properly defined.
%
%   Example:
%     CGA(2)
%     p1=point([1,0]);
%     p2=point([-1,0]);
%     p2=point([0,1]);
%     S = p1.^p2.^p3;
%     R = make_inverssion(S);
%
%   See also NORMALIZE, MV
    R=sphere.normalize;
end
