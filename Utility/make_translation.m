function R=make_translation(amount,direction)
% MAKE_TRANSLATION  Constructs a translator for a translation transformation.
%
%   R = MAKE_TRANSLATION(AMOUNT, DIRECTION) generates a translator that
%   represents a translation by the given amount along a specified direction.
%
%   Inputs:
%     - amount: Scalar representing the translation magnitude.
%     - direction: Multivector representing the translation direction.
%
%   Output:
%     - R: Translator representing the translation transformation.
%
%   Description:
%     This function constructs a translator in Conformal Geometric Algebra (CGA)
%     for a translation transformation. It extracts the pure vector part of
%     the input `direction`, ensures it is unitary, and then computes the
%     exponential form of the translator using the ideal element `ni`.
%
%     The function supports CGA(2) and CGA(3). If a non-pure vector is
%     provided, a warning is displayed, and only the vector part is used.
%
%   Example:
%     CGA(2); % Build the conformal algebra
%     direction = e1+e2;  % Example translation vector
%     R = make_translation(2.5, direction);
%
%   See also MV, EXP
    bv=direction.grade(2);
    % We make non general code to retrive the pure bivecto part, for shure
    % there is a more imteligent way to do this
    M3=[0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    M2=[ 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    % Filter based on signature
    if direction.Lsignature==[4,1,0]
        M=M3;
        ni=MV([0 0 0 0 0 1 zeros(1 ,32-6)],[4,1,0],"CGA");
    elseif direction.Lsignature==[3,1,0]
        M=M2;
        ni=MV([0 0 0 0 1 zeros(1 ,16-5)],[3,1,0],"CGA");
    else
        error("The make_translation function expect a CGA(2,3) enviroment")
    end
    bvv=direction.vector.*M;
    if bvv~=direction.vector
        warning("Discarding non pure vector parts");
    end

    sqr=bvv*bvv.';
    % Now, we expect a unitary bivector
    
    if class(sqr)=="double"
        if sqr~=1
            warning("Reducing to unit vector form")
            bv=MV(bvv/sqr,direction.Lsignature,direction.REPR);
        else
            bv=MV(bvv,direction.Lsignature,direction.REPR);
        end
    else
        warning("Reducing symbolic description to unit vector form")
        bv=MV(bvv/sqr,direction.Lsignature,direction.REPR);
    end
    
    %Finally the exponential form, instead of precomputing it we make the slow
    %computation


    k=exp((amount/2)*bv*ni);
    if class(k.vector)=="double"
        S=abs(k.vector)>1e-6;
        R=MV(k.vector.*S,direction.Lsignature,direction.REPR);
    else
        R=k;
    end
end
