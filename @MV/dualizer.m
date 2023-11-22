function [stamp,sign]= dualizer(sig)
    % This is a special function that computes the structure of the sual
    % space for any algebra

    persistent stamps
    persistent signatures
    persistent signs
    if isempty(stamps)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        signs{10,10,10}=0;
    end
    % Did we acces this function with this signature before?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % NO, so lets compute everithing
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        % Lets compute stamps, just reverse the vector
        n=sum(sig);
        dim=2^n;
        v=dim:-1:1;
        % Stamps are the indices of the dual vector
        stamps{sig(1)+1,sig(2)+1,sig(3)+1}=v;

        %lets compute the signs, to do so just multipy by
        %pseudoscalar in a full positive equivalent basis
        ss=zeros(1,2^n);
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

