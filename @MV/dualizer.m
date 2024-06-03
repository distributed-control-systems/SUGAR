function [stamp,sign]= dualizer(sig)
% This is a special function that computes the structure of the sual
% space for any algebra

% The "C" prefix is for Cayley defined algebras

persistent stamps Cstamps
persistent signatures Csignatures
persistent signs Csigns

if isempty(stamps)
    stamps{10,10,10}=0;
    signatures{10,10,10}=0;
    signs{10,10,10}=0;

    Cstamps={};
    Csignatures={};
    Csigns={};

end

[sr,sc]=size(sig);

if (sr==1)
    % This is a standart p,q,r  table defined algebra

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
elseif(sr==sc)
        % This is a Calyley table defined algebra
        

        %loop to decide if the algebra already exists
        cayley_exists=0;
        for j=1:size(Csignatures,1)
            existing=size(Csignatures{j},1);
            if (existing==sr)
                if Csignatures{j}==sig
                    cayley_exists=j;
                    break;
                end
            end
        end

        if cayley_exists==0
            n=sc;

            %-----------------------------
            % one by one to compute de complement because they may be out
            % of order
            
            %Create a copy of the algebra here
            cayley(sig);
            names=sig(1,:);

            % who is the pseudoscalar here?
            I="";
            basis=[];
            for i=1:n
                if length(char(strrep(strrep(strrep(names(i),"D",""),"e",""),"0","12")))==1
                    I=I+names(i);
                    basis=[basis names(i)];
                end
            end

            complements=[I];
            for i=1:length(basis)
                    basis(i)
                    basis(basis~=basis(i));
                    res=strjoin(basis(basis~=basis(i)),"")
                    complements=[complements res]
                
            end

            %-----------------------------


        end    
        stamp=Cstamps{cayley_exists};
        sign=Csigns{cayley_exists};

end

end

