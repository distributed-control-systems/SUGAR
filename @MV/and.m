function r= and(obj1,obj2)
    if obj1.Lsignature==obj2.Lsignature
        rd=obj1.dual*obj2.dual;
        r=rd.dual;
    else
        error("Signatures don't agree in the product")
    end

end
