function r=mrdivide(A,B)
if class(B)=="double"
        r=1/B*A;
elseif class(B)=="MV"

    r=A*(B)^-1;
else
    error("something went wrong");
end
end