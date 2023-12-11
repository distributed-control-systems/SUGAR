function r= and(obj1,obj2)

    % This function computes the vee of two MV
    % !(!o1.^!o2)
    if obj1.Lsignature==obj2.Lsignature
        rd=obj1.dual.^obj2.dual;
        r=rd.dual;
    else
        error("Signatures don't agree in the product")
    end
end

