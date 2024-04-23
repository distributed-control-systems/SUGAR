function [Basis,Stamp,Msigns,Signs]= structuredef(sig)
    % THIS IS THE HEART OF SUGAR
    % All the structure is set up in this static function. We save all
    % posible algebras structures in static variables. In this way, every
    % time a multivector is created we just recober everithing from here

    
    % Signatures is just to set a flag on the algebras where the structure
    % has ben computed, once it has been computed we know that everything
    % is stored in the rest of the variables
    persistent signatures;
    % Stambps converts to matrix representation. Is a fast way to transform
    % from vector to matrix
    persistent stamps;
    % The basis indices (ie 1, 2, 3, 1-2,1-3 etc... ) that comes with every vector, in reality we don't
    % need this longer, but we keep it, al tleast forn now
    persistent basis;
    % The signs that the matrix representation should have, they depend on
    % the p,q,r algebra
    persistent msigns;
    % The value of the squared blades
    persistent signs;
    % The text names of the basis
    persistent bnames;

    if isempty (signatures)
        stamps{10,10,10}=0;
        signatures{10,10,10}=0;
        basis{10,10,10}=0;
        msigns{10,10,10}=0;
        signs{10,10,10}=0;
        bnames{10,10,10}=0;
        load('@MV/pre_defined_stamps.mat', 'stamps')
        load('@MV/pre_defined_signatures.mat', 'signatures')
        load('@MV/pre_defined_basis.mat', 'basis')
        load('@MV/pre_defined_msigns.mat', 'msigns')
        load('@MV/pre_defined_signs.mat', 'signs')
        load('@MV/pre_defined_bnames.mat', 'bnames')
    end
    if class(sig)=='string' 
        if sig=="DUMP"
            save @MV/pre_defined_stamps.mat stamps
            save @MV/pre_defined_signatures.mat signatures
            save @MV/pre_defined_basis.mat basis
            save @MV/pre_defined_msigns.mat msigns
            save @MV/pre_defined_signs.mat signs
            save @MV/pre_defined_bnames.mat bnames
            
        end    
    return
    end

    % Has been this algebra already computed?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % NO, let's build everything up
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        % do all stuff
        signature=sig;
        % Size of the mother vector space
        n=sum(signature);
        % a vector from 1 to the size of the algebra itself
        val=1:2^n;
        % no sense is 2^n.... but, I keep it
        m=length(val);
        if 2^n==m
            %vec=val;
            % The three expected values for a squared blade, take into
            % account that we may modify this such that e1^4=-1.... it
            % would be funny, right now, just standard GA

            % This allows us to change the basis definition, from p,q,r to
            % any order

            % It also allows us to change the concept, we could add an
            % extra element that squares to comples p,q,r,c etc....
            
            s1=1;  % For positive basis
            s2=-1; % For negative basis
            s3=0;  % For null basis

            S=zeros(1,n)*s3; % This line is correct do not modify it
            % The first n elements have a defined sign by the user
            for k=1:n
                if k<=signature(1)
                    S(k)=s1;
                end
                if k>signature(1)&&k<=(signature(1)+signature(2))
                    S(k)=s2;
                end
            end
            Signs=S; % So here we ave a linear description, ie [+ + + - - 0] for [p,q,r]=[3,2,1]. note the mising scalar
            
        %------------------------------------------------------------------
            %now le'ts create the basis indexs
            v=1:n;
            counter=2;
            % Basis is a cel, on each element there is an array with the
            % numbers of the involved mother vector space basis
            Basis=cell(1,2^n);
            % The first basis is just named e0
            Basis{1}="0";
            for k=1:n
                C = nchoosek(v,k);
                % Get all possible combinations
                [f,c]=size(C);
                for item=1:f
                    % Add them one by one to the cell of Basis
                    b=strrep(num2str(C(item,:)),"  ",",");
                    Basis{counter}=b;
                    counter=counter+1;
                end
            end
            % Done.

        %------------------------------------------------------------------
            % Lets create a matrix representation from a vector
            %For each element of the basis perform the product 
            Basis_count=length(Basis);
            matrix={};
            % Let's go over the matrix representation, one by one
            for column=1:Basis_count
                for row=1:Basis_count
                    % So, we have a product of two basis
                    Order=Basis{row}+","+Basis{column};
                    final_element="";
                    % Remove the comas on the description
                    names=split(Order,',')';
                    % Convert everything into chars, this limits sugar to
                    % [10 10 10] i belive
                    names=cellfun(@str2num,convertStringsToChars(names));
                    % Basis with name 0 (scalar) conmutes with everything
                    masc=(names~=0);
                    % So we remove them
                    names=names(masc);
                    % How many basis are implied in this computation?
                    values=unique(names,'sorted');
                    % sort them, because we use lexicographic order
                    [ol,ic]=sort(names);
                    % befor we start to swap elements we have positive sign
                    % in the product, signo means sign in spanish...
                    signo=1;
                    % Sign due to permutations
                    for k=1:length(names)
                        % track how many permutations do I need to order
                        % the sequence of basis names
                        signo=signo*(-1)^(sum(names(1:k)>names(k)));
                    end
                    % Sign due to repetitions, duplicated basis names are
                    % removed and the sign is changed acording to the p,q,r
                    % rule
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
                    % Store the result into the matrix of signs and go for
                    % the next element
                    matrix{destination,column}=signo*val(row);
                end
            end


            % Store signs into the static variable, to be able to recover
            % it later
            matrix=cell2sym(matrix);
            try
                matrix=double(matrix);
            catch
            end
        end

        %------------------------------------------------------------------
        % Create the basis names, just add "e" in front of the sequence of
        % numbers
        for j=1:length(Basis)
            BasisN{j}="e"+strrep(Basis{j},",","");
        end

        %Store everything into stativ cariables
        stamps{sig(1)+1,sig(2)+1,sig(3)+1}=abs(double(matrix));
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=sig;
        basis{sig(1)+1,sig(2)+1,sig(3)+1}=BasisN;

        msigns{sig(1)+1,sig(2)+1,sig(3)+1}=sign(matrix);
        signs{sig(1)+1,sig(2)+1,sig(3)+1}=Signs;
        bnames{sig(1)+1,sig(2)+1,sig(3)+1}=BasisN;
    end
    Stamp= stamps{sig(1)+1,sig(2)+1,sig(3)+1};
    Basis=basis{sig(1)+1,sig(2)+1,sig(3)+1};
    Msigns=msigns{sig(1)+1,sig(2)+1,sig(3)+1};
    Signs=signs{sig(1)+1,sig(2)+1,sig(3)+1};

end

