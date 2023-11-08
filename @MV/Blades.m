function B= Blades(sig)
    persistent signatures
    persistent blades
    if isempty (signatures)
        blades{10,10,10}=0;
        signatures{10,10,10}=0;
    end
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})

        % So the blades structure must be buid
        n=sum(sig);
        A=pascal(n+1,1);
        sizes=abs(A(end,:));
        Ssizes=cumsum(sizes);
        v=zeros(1,2^n);
        v(1)=1;
        [Basis,stamp,Msigns,Signs]=MV.structuredef(sig);


        z=((stamp)==0);
        b=v(stamp+z);%m;
        b(z)=0;

        %b=v(stamp);
        blades{sig(1)+1,sig(2)+1,sig(3)+1}{1}=b;
        for k=2:length(sizes)
            v=zeros(1,2^n);
            v(Ssizes(k-1)+1:Ssizes(k))=1;
            z=((stamp)==0);
            b=v(stamp+z);%m;
            b(z)=0;
            blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=b;
        end
        for k=(n+2):2*(n+1)
            blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=stamp*0;
        end
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
    end
    B=blades{sig(1)+1,sig(2)+1,sig(3)+1};

end


