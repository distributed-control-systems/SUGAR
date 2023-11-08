function [stamp,sign]= dualizer(sig)
    persistent stamps
    persistent signatures
    persistent signs
    if isempty(stamps)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        signs{10,10,10}=0;
    end
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        % Lets compute stamps, just reverse the vector
        n=sum(sig);
        dim=2^n;
        v=dim:-1:1;
        stamps{sig(1)+1,sig(2)+1,sig(3)+1}=v;

        %lets compute the signs, to do so just multipy by
        %pseudoscalar in a full positive equivalent basis
        ss=zeros(1,2^n);
        ps=zeros(1,2^n);
        ps(end)=1;
        ps=MV(ps,[n,0,0]);
        for i=1:2^n
            z=zeros(1,2^n);
            zz=zeros(1,2^n);
            z(i)=1;
            zz(end-i+1)=1;
            elemento1=MV(z,sig);
            elemento2=MV(zz,sig);
            res=elemento1*elemento2;
            ss(i)=sum(res.vec);
        end
        signs{sig(1)+1,sig(2)+1,sig(3)+1}=ss;
    end

    stamp=stamps{sig(1)+1,sig(2)+1,sig(3)+1};
    sign=signs{sig(1)+1,sig(2)+1,sig(3)+1};

end

