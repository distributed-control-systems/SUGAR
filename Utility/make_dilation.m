function R=make_dilation(amount)
    n0= evalin('base','n0');
    ni= evalin('base','ni');
    
    n0ni=n0.^ni;
    k=exp(-(amount/2)*n0ni);
    if class(k.vector)=="double"
        S=abs(k.vector)>1e-6;
        R=MV(k.vector.*S,n0ni.Lsignature,n0ni.REPR);
    else
        R=k;
    end
end
