    function [Basis,Stamp,Msigns,Signs]= structuredef(sig)


% STRUCTUREDEF Define the algebraic structure for multivectors.
%
% SYNTAX:
%   [Basis, Stamp, Msigns, Signs] = structuredef(sig)
%
% DESCRIPTION:
%   This function initializes and stores the structure of possible
%   geometric algebra (GA) or conformal geometric algebra (CGA)
%   configurations in persistent variables for efficient reuse.
%   It handles both p,q,r-defined algebras and Cayley table-defined algebras.
%
% INPUT:
%   sig : A signature vector [p, q, r] for GA or a Cayley table matrix
%         defining the algebra structure.
%
% OUTPUT:
%   Basis  : Cell array containing the basis elements of the algebra.
%   Stamp  : Matrix representation for transforming multivectors.
%   Msigns : Matrix of signs representing multiplication rules.
%   Signs  : Vector of squared blade values for the basis elements.
%
% NOTES:
%   - For p,q,r algebras, the basis and matrix representation are
%     constructed from the signature.
%   - For Cayley table-defined algebras, the basis and matrix representation
%     are derived directly from the table.
%   - The function uses persistent variables to store precomputed data,
%     ensuring efficiency during repeated calls.
%
% EXAMPLES:
%   % Define a p,q,r algebra
%   [Basis, Stamp, Msigns, Signs] = structuredef([3, 2, 1]);
%
%   % Define an algebra using a Cayley table
%   cayleyTable = ["1" "e1" "e2"; "e1" "-1" "e12"; "e2" "-e12" "1"];
%   [Basis, Stamp, Msigns, Signs] = structuredef(cayleyTable);
%
% REFERENCES:
%   - Geometric Algebra for Physicists, Chris Doran and Anthony Lasenby
%   - Applications of Clifford Algebras in Engineering, Mathematics,
%     and Physics
%
% See also MV, CGA_matrix


        % THIS IS THE HEART OF SUGAR
        % All the structure is set up in this static function. We save all
        % posible algebras structures in static variables. In this way, every
        % time a multivector is created we just recober everithing from here
    
        %%28/5/2024 here I add a modification in order to support Calyley
        %%defined algebras
            
        % The "C" prefix is for Cayley defined algebras


        % Signatures is just to set a flag on the algebras where the structure
        % has ben computed, once it has been computed we know that everything
        % is stored in the rest of the variables
        persistent signatures Csignatures;
        % Stambps converts to matrix representation. Is a fast way to transform
        % from vector to matrix
        persistent stamps Cstamps;
        % The basis indices (ie 1, 2, 3, 1-2,1-3 etc... ) that comes with every vector, in reality we don't
        % need this longer, but we keep it, al tleast forn now
        persistent basis Cbasis;
        % The signs that the matrix representation should have, they depend on
        % the p,q,r algebra
        persistent msigns Cmsigns;
        % The value of the squared blades
        persistent signs Csigns;
        % The text names of the basis
        persistent bnames Cbnames;

        
    
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

            % Calyley defined algebras storing variables
            Cstamps={};
            Csignatures={};
            Cbasis={};
            Cmsigns={};
            Csigns={};
            Cbnames={};

        end
%         if class(sig)=='string' 
%             if sig=="DUMP"
%                 save @MV/pre_defined_stamps.mat stamps
%                 save @MV/pre_defined_signatures.mat signatures
%                 save @MV/pre_defined_basis.mat basis
%                 save @MV/pre_defined_msigns.mat msigns
%                 save @MV/pre_defined_signs.mat signs
%                 save @MV/pre_defined_bnames.mat bnames
%                 
%             end    
%         return
%         end
    
        [sr,sc]=size(sig);
    
        if (sr==1)
        % This is a standart p,q,r  table defined algebra
        % Has been this algebra already computed?
        if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
            if sum(sig>=10)>0
                error('Right now there is an algebra size limit set to p<10, q<10, r<10');
                return
            end
            if (sum(sig)>9)
                warning('This is a huge algebra, it will take some time to create the first instance, be patient please')
            end
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
                % Basis is a cell, on each element there is an array with the
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
                        %b=strrep(strrep(num2str(C(item,:)),"  ",","),",,",",");
                        % In order to manage basis numbers over 10 we use an underscore
                        % this allows us to distinguis the basis e12 from de bivector e12
                        % by naming e_12 and e12, it also allows the creation
                        % of the trivector e12_12 whic corresponds to e1e2e_12,
                        % but sadly it breaks the latex transator....  
                        b=regexprep(num2str(C(item,:)),"[ ]{2,}",","); 
                        %b=regexprep(bb,",\d{2,}",",_$0");
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
                        % Convert everything into chars
                        names=cellfun(@str2num,convertStringsToChars(names));
                               
                        % Basis with name 0 (scalar) conmutes with everything
                        masc=(names~=0);
                        % So we remove them
                        names=names(masc);
                        % How many basis are implied in this computation?
                        values=unique(names,'sorted');
                        % sort them, because we use lexicographic order
                        %%[ol,ic]=sort(names);
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
                %matrix=cell2sym(matrix);
               try
                    matrix=cell2mat(matrix);
                catch
                end
            end
    
            %------------------------------------------------------------------
            % Create the basis names, just add "e" in front of the sequence of
            % numbers
            for j=1:length(Basis)
    
                BasisN{j}="e"+strrep(   regexprep(Basis{j},",\d{2,}",",_$0")   ,",","");
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
        % the algebra does not exists, we have to create it
            
            %Ok let's go by parts...
            Signs=ones(1,sc); % right now do not take into account the signs;
% % %------------------------------------------------------------------
% %                 %now le'ts create the basis indexs
% %                 v=1:n;
% %                 counter=2;
% %                 % Basis is a cell, on each element there is an array with the
% %                 % numbers of the involved mother vector space basis
% %                 Basis=cell(1,2^n);
% %                 % The first basis is just named e0
% %                 Basis{1}="0";
% %                 for k=1:n
% %                     C = nchoosek(v,k);
% %                     % Get all possible combinations
% %                     [f,c]=size(C);
% %                     for item=1:f
% %                         % Add them one by one to the cell of Basis
% %                         % b=strrep(strrep(num2str(C(item,:)),"  ",","),",,",",");
% %                         % In order to manage basis numbers over 10 we use an underscore
% %                         % this allows us to distinguis the basis e12 from de bivector e12
% %                         % by naming e_12 and e12, it also allows the creation
% %                         % of the trivector e12_12 whic corresponds to e1e2e_12,
% %                         % but sadly it breaks the latex transator....  
% %                         b=regexprep(num2str(C(item,:)),"[ ]{2,}",","); 
% %                         %b=regexprep(bb,",\d{2,}",",_$0");
% %                         Basis{counter}=b;
% %                         counter=counter+1;
% %                     end
% %                 end
% %                 % Done.

%------------------------------------------------------------------
                % Lets create a matrix representation from a vector
                % The table itself tells us how to do this
                % The first column of the table is the original vector
                % for each column we have to replace the basis name by its
                % position on the firs column.
                matrix(1:sc,1:sc)={0}; % The matrix holding the map from the vector to the matrix representation
                %signs
                % We must take some care with the signs...

                for i=1:sc
                    matrix{i,1}=i; % the first coumn is the identity map
                end

                for j=2:sc %columns
                    for i=1:sc %rows
                        element=regexprep(sig(i,j),'^-','');

                        if element==sig(i,j)
                            signo=1;
                        else
                            signo=-1;
                        end
                        
                        index =find(sig(:,1)==element);
                        
                        if isempty(index) 
                            %There is no mapping
                        else
                            matrix{index,j}=signo*i;
                        end
                        
                    end
                end
                % the matrix is complete
                try
                    matrix=cell2mat(matrix);
                catch
                end
               

              Cstamps{end+1}=abs(double(matrix));
              Csignatures{end+1}=sig;
              Cbasis{end+1}=cellstr(sig(:,1)');
    
              Cmsigns{end+1}=sign(matrix);
              Csigns{end+1}=Signs;
              Cbnames{end+1}=cellstr(sig(:,1)');
              
            cayley_exists=length(Csignatures);




        end
        
            Stamp= Cstamps{cayley_exists};
            Basis=Cbasis{cayley_exists};
            Msigns=Cmsigns{cayley_exists};
            Signs=Csigns{cayley_exists};

        
        else
            error("The provided information is not a p,q,r algebra nor a Cayley table")
        end
    end


