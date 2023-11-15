function [M,new_basis_names]= CGA_matrix(sig)
    % So , how do you perform a basis change in a geometric algebra?
    % Maybe there are more clever ways to do this, but I got here after
    % hours thinking, it works.

    % The real problem relys in the fact that in CGA the variable change is
    % done over e+ and e- do generate n0 and ni. But the rest of blades of
    % the algebra also change in some way. Here we compute the matrix that
    % performs this change from standard basis to CGA basis

    % Store results for reutilization
    persistent signatures
    persistent Ms
    persistent labels
    if isempty (signatures)
        Ms{10,10,10}=0;
        labels{10,10,10}=0;
        signatures{10,10,10}=0;
    end


    %check viability
    if sig(1)<1 || sig(2)<1
        error("There is no CGA representation for this algebra")
    end
    
    % Did we compute this before?
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        % NO, let's go
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;

        % Algebra size
        s=sum(sig);
        % All posible vectors in this algebra
        suport=eye(2^s);

        % Original basis
        BASIS=[];
        % Lets go one by one...
        for i=1:2^s
            BASIS=[BASIS MV(suport(i,:),sig)];
        end


        % Get the structure of the new basis
        structure=MV.full_algebra_basis_coefs(sig);


        %define n0 and ni internally
        n0=0.5*BASIS(sig(1)+sig(2)+1)-0.5*BASIS(sig(1)+1);
        ni=BASIS(sig(1)+1)+BASIS(sig(1)+sig(2)+1);
        
        % define e0 internally
        e0=BASIS(1);
        % The old basis names
        labels_old=e0.Basis;

        %The new basis of the vector space (these are blade 1), not the
        %algebra
        BASIS_N=[BASIS(1) n0 BASIS(2:sig(1)) BASIS(sig(1)+2:sig(1)+sig(2)) BASIS(sig(1)+sig(2)+2:sig(1)+sig(2)+sig(3)+1) ni];

        % Take care with the labels... we must keepp the Mother
        % Algebra original basis labels in order to no disturb
        % the user... THIS IS HARD

        
        %.....................
        mother_signature=sig-[1,1,0];
        single_basis=sum(mother_signature);
        num_el=2^single_basis;
        t=MV([1:num_el],mother_signature);
        mother_names=t.BasisNames;
        single_mother_names=mother_names(2:single_basis+1);

        LABELS_N={labels_old{1} "n0" single_mother_names{:} "ni"};
        %........................

        % Form the new basis itself
        B=[];
        % And new labels
        L={};
        num_el=length(structure);

        %Let's bulid the new basis and basis' names... Later I realized that a regex would be more clean... 
        for j=1:num_el
            element=structure{j};
            [m,n]=size(element);
            P=1;
            La="";

            last_leter_is_e=0;
            new_leter_is_e=0;
            for k=1:n
                % THIS IS THE IMPORTANT LINE
                P=P.^BASIS_N(element(k)+1);
                
                new_leter_is_e=contains(LABELS_N{element(k)+1},"e");
                if last_leter_is_e && new_leter_is_e
                    R=extractAfter(LABELS_N{element(k)+1},"e");
                    La=La+R;
                else
                    La=La+LABELS_N{element(k)+1};
                end
                last_leter_is_e=contains(LABELS_N{element(k)+1},"e");
            end
            B=[B P];
            L=[L La];
        end

        % Now we have the new basis, lets compute the change
        % matrix...
        s=sum(sig);
        B=[BASIS_N(1) B];
        L=[LABELS_N(1) L];
        M_=zeros(2^s);
        for i=1:2^s
            M_(i,:)=B(i).vec;
        end
        
        %Store them
        Ms{sig(1)+1,sig(2)+1,sig(3)+1} =M_^-1;
        labels{sig(1)+1,sig(2)+1,sig(3)+1} =L;
    end
    
    %Return the values 
    M=Ms{sig(1)+1,sig(2)+1,sig(3)+1};
    new_basis_names=labels{sig(1)+1,sig(2)+1,sig(3)+1};
end

