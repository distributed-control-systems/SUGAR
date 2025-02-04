function R=make_rotation(amount,direction)
% MAKE_ROTATION  Constructs a rotor for a rotation transformation.
%
%   R = MAKE_ROTATION(AMOUNT, DIRECTION) generates a rotor that performs
%   a rotation by the specified angle around a given bivector direction.
%
%   Inputs:
%     - amount: Scalar representing the rotation angle (in radians).
%     - direction: Multivector representing the bivector defining the rotation axis.
%
%   Output:
%     - R: Rotor representing the rotation transformation.
%
%   Description:
%     This function constructs a rotor in Conformal Geometric Algebra (CGA)
%     for a rotation transformation. It extracts the pure bivector part of
%     the input `direction`, ensures it is unitary, and then computes the
%     exponential form of the rotation rotor.
%
%     The function supports CGA(4,1) and CGA(3,1). If a non-pure bivector is
%     provided, a warning is displayed, and only the bivector part is used.
%
%   Example:
%     CGA(2); % Build up a 2d conformal algebra
%     direction = e12;  % Example bivector, just a rotation
%     R = make_rotation(pi/4, direction);
%
%   See also MV, EXP
    bv=direction.grade(2);
    % We make non general code to retrive the pure bivecto part, for shure ther
    % is a more imteligent way to do this
    M3=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    M2=[ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    % Filter based on signature
    if direction.Lsignature==[4,1,0]
        M=M3;
        bvv=direction.vector.*M;
    elseif direction.Lsignature==[3,1,0]
        M=M2;
        bvv=direction.vector.*M;
    else
        error("The make_rotation function expect a CGA(2,3) enviroment")
    end
    bvv=direction.vector.*M;
    if bvv~=direction.vector
        warning("Discarding non pure bivector parts");
    end

    sqr=bvv*bvv.';
    % Now, we expect a unitary bivector
    
    if class(sqr)=="double"
    if sqr~=1
        warning("Reducing to unit bivector form")
        bv=MV(direction.vector/sqr,direction.Lsignature,direction.REPR);
    end
    else
        warning("Reducing symbolic description to unit bivector form")
        bv=MV(direction.vector/sqr,direction.Lsignature,direction.REPR);
    end
    
    %Finally the exponential form, instead of precomputing it we make the slow
    %computation
    k=exp((amount/2)*bv);
    if class(k.vector)=="double"
        S=abs(k.vector)>1e-6;
        R=MV(k.vector.*S,direction.Lsignature,direction.REPR);
    else
        R=k;
    end
    
end
