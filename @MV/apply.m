function r= apply(obj,f)
    %F=sym(f);
    F=f;
    p=funm(obj.matrix,F);
    %TODO This should be made in a different way, MV() and set all vaues
    r=MV((p(:,1)).',obj.Lsignature);
    r.REPR=obj.REPR;
end

