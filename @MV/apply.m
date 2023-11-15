function r= apply(obj,f)
    % Given a function defined over the reals we can apply it to a
    % multivector using its matris¡x representation
    p=funm(obj.matrix,f);
    % TODO This should be made in a different way
    % These functions are multivaluated and we must choose the right value
    r=MV((p(:,1)).',obj.Lsignature);
    r.REPR=obj.REPR;
end

