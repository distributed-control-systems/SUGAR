function r= eq(obj1,obj2)
    if obj1.Lsignature==obj2.Lsignature
        if(obj1.vec==obj2.vec)
            r=1;
        else
            r=0;
        end

    else
        error("Multivectors must belong to the same algebra ")
    end

end

