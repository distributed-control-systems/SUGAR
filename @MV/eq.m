function r= eq(obj1,obj2)
    % Overloading equality function
    % The MV must belong to the same algebra
    if obj1.Lsignature==obj2.Lsignature
        % The MV must have the same components
        if(obj1.vec==obj2.vec)
            r=1;
        else
            r=0;
        end
    else
        error("Multivectors must belong to the same algebra ")
    end

end

