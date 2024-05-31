function B= Blades(sig)
    % Special (STATIC) function to select the elements of a matrix representation
    % Given a matrix representation of a MV, the blade selection can be
    % done using thesse matrices , just point wise multiplication
    
    % Storage for reutilization, first ime we compute them, the rest of time
    % we just recover them

    persistent signatures
    persistent blades
    %%30/5/2024 here I add a modification in order to support Calyley
    %%defined algebras
            
    % The "C" prefix is for Cayley defined algebras
    persistent Csignatures
    persistent Cblades

    if isempty (signatures)
        blades{10,10,10}=0;
        signatures{10,10,10}=0;
        Csignatures={};
        Cblades={};
    end
    if class(sig)=='double'
    % Have we computed the matrices for this algebra?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % No, So the blades structure must be build
        % Algebra size
        n=sum(sig); 

        % Blades sizes
        A=pascal(n+1,1);
        sizes=abs(A(end,:));
        Ssizes=cumsum(sizes);

        % An empy vector
        v=zeros(1,2^n);
        v(1)=1;
        % Request the structure builders for this algebra
        [Basis,stamp,Msigns,Signs]=MV.structuredef(sig);

        % In the case of having null basis ...
        z=((stamp)==0);
        % Bulid the  matrix representation of the vector v
        b=v(stamp+z);
        b(z)=0;
        
        
        blades{sig(1)+1,sig(2)+1,sig(3)+1}{1}=b; % Blade 0 
        % For each possible blade
        for k=2:length(sizes)
            % Zero vector
            v=zeros(1,2^n);
            % Set to one those corresponding to blade k with pascal
            % triangle help
            v(Ssizes(k-1)+1:Ssizes(k))=1;
            z=((stamp)==0);
            b=v(stamp+z);%m;
            b(z)=0;
            % append blade k
            blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=b;
        end
        for k=(n+2):2*(n+1)
            % nullify the rest of entries
            blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=stamp*0;
        end
        % Mark this signature as already computed
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
    end
    B=blades{sig(1)+1,sig(2)+1,sig(3)+1};
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %cayley
    elseif class(sig)=='string'
    [sr,sc]=size(sig);
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

            %--------------


            % No, So the blades structure must be build
        % Algebra size
        n=ceil(log2(sc)); 

        % Blades sizes
        A=pascal(n+1,1);
        sizes=abs(A(end,:));
        Ssizes=cumsum(sizes);

        % An empy vector
        v=zeros(1,2^n);
        v(1)=1;
        % Request the structure builders for this algebra
        [Basis,stamp,Msigns,Signs]=MV.structuredef(sig);

        % In the case of having null basis ...
        z=((stamp)==0);
        % Bulid the  matrix representation of the vector v
        b=v(stamp+z);
        b(z)=0;
        
        
        Cblades{end+1}{1}=b; % Blade 0 
        
        % For each possible blade 
        % sadly this is not working because the
        % blades are not in order....
        names=sig(1,:);
        %regexprep(names(jj),'D\d+','D') D folowed by number
        %strrep(regexprep(names(jj),'D\d+','D'),"e"."") and e for nothing
        len = arrayfun( @(jj) length(char(strrep(regexprep(names(jj),'D\d+','D'),"e",""))) ,1:size(names,2));
        for k=2:length(sizes)
            % Zero vector
            v=zeros(1,2^n);
                          
            v(len==k-1)=1;
            v(1)=0;
            z=((stamp)==0);
            b=v(stamp+z);%m;
            b(z)=0;
            % append blade k
            Cblades{end}{k}=b;
        end
        for k=(n+2):2*(n+1)
            % nullify the rest of entries
            Cblades{end}{k}=stamp*0;
        end
        % Mark this signature as already computed
        Csignatures{end+1}=sig;
        cayley_exists=length(Csignatures);

            %---------------
        end

        B=Cblades{cayley_exists};

    else
        error('Unreconized signature')
    end
    % Return the blade
    
end


