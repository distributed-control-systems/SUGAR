function B= Blades(sig)
    % Special (STATIC) function to select the elements of a matrix representation
    % Given a matrix representation of a MV, the blade selection can be
    % done using thesse matrices , just point wise multiplication
    
    % Storage for reutilization, first ime we compute them, the rest of time
    % we just recover them

    persistent signatures
    persistent blades
    if isempty (signatures)
        blades{10,10,10}=0;
        signatures{10,10,10}=0;
    end

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
    % Return the blade
    B=blades{sig(1)+1,sig(2)+1,sig(3)+1};
end


