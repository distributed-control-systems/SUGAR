function [Basis,Stamp,Msigns,Signs]= structuredef(sig)
    persistent stamps;
    persistent signatures;
    persistent basis;
    persistent msigns;
    persistent signs;
    persistent bnames;
    if isempty (signatures)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        basis{10,10,10}=0;
        msigns{10,10,10}=0;
        signs{10,10,10}=0;
        bnames{10,10,10}=0;
    end
    % So, this is just a way to speed up repetitive
    % computations in my code

    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        % do all stuf
        signature=sig;
        n=sum(signature);
        val=1:2^n;
        m=length(val);
        if 2^n==m
            vec=val;
            s1=1;
            s2=-1;
            s3=0;
            S=ones(1,n)*s3;
            for k=1:n
                if k<=signature(1)
                    S(k)=s1;
                end
                if k>signature(1)&&k<=(signature(1)+signature(2))
                    S(k)=s2;
                end
            end
            Signs=S;
            %basis
            v=1:n;
            counter=2;
            Basis=cell(1,2^n);
            Basis{1}="0";
            for k=1:n
                C = nchoosek(v,k);
                [f,c]=size(C);
                for item=1:f
                    b=strrep(num2str(C(item,:)),"  ",",");
                    Basis{counter}=b;
                    counter=counter+1;
                end
            end
            % Lets create its matrix representation
            %For each element of the basis perform the product
            Basis_count=length(Basis);
            matrix={};%cell(zeros(Basis_count,Basis_count));
            for column=1:Basis_count
                for row=1:Basis_count
                    Order=Basis{row}+","+Basis{column};
                    final_element="";
                    % Check what is left and sign
                    names=split(Order,',')';
                    names=cellfun(@str2num,convertStringsToChars(names));
                    masc=(names~=0);
                    names=names(masc);
                    values=unique(names,'sorted');
                    [ol,ic]=sort(names);
                    signo=1;
                    % Sign due to permutations
                    for k=1:length(names)
                        signo=signo*(-1)^(sum(names(1:k)>names(k)));
                    end
                    % Sign due to repetitions
                    for k=1:length(values)
                        number_in_vector= sum(names==values(k));
                        disapearing=fix(number_in_vector/2);
                        remaining=mod(number_in_vector,2);
                        signo=signo*(  S(values(k))  )^(disapearing);
                        if remaining==1
                            if strlength(final_element)==0
                                final_element=num2str(values(k));
                            else
                                final_element=final_element+","+num2str(values(k));
                            end
                        end
                    end
                    if strlength(final_element)==0
                        final_element="0";
                    end
                    destination=find([Basis{:}] == final_element);
                    matrix{destination,column}=signo*val(row);
                end
            end



            matrix=cell2sym(matrix);
            try
                matrix=double(matrix);
            catch
            end
            %matrix=m
            % end stuff
        end
        %TEST
        for j=1:length(Basis)
            BasisN{j}="e"+strrep(Basis{j},",","");
        end
        stamps{sig(1)+1,sig(2)+1,sig(3)+1}=abs(double(matrix));
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=sig;
        basis{sig(1)+1,sig(2)+1,sig(3)+1}=BasisN;%Basis;

        msigns{sig(1)+1,sig(2)+1,sig(3)+1}=sign(matrix);
        signs{sig(1)+1,sig(2)+1,sig(3)+1}=Signs;
        bnames{sig(1)+1,sig(2)+1,sig(3)+1}=BasisN;
    end
    Stamp= stamps{sig(1)+1,sig(2)+1,sig(3)+1};
    Basis=basis{sig(1)+1,sig(2)+1,sig(3)+1};
    Msigns=msigns{sig(1)+1,sig(2)+1,sig(3)+1};
    Signs=signs{sig(1)+1,sig(2)+1,sig(3)+1};

end

