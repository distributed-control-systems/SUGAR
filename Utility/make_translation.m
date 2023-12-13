function R=make_translation(amount,direction)
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
