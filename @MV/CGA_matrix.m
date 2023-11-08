function [M,new_basis_names]= CGA_matrix(sig)
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
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        s=sum(sig);
        suport=eye(2^s);
        BASIS=[];  %Original basis

        for i=1:2^s
            BASIS=[BASIS MV(suport(i,:),sig)];
        end

        % Get the structure of the new basis
        structure=MV.full_algebra_basis_coefs(sig);

        %define n0 and ni internally

        n0=0.5*BASIS(sig(1)+sig(2)+1)-0.5*BASIS(sig(1)+1);
        ni=BASIS(sig(1)+1)+BASIS(sig(1)+sig(2)+1);

        e0=BASIS(1);
        labels_old=e0.Basis;

        BASIS_N=[BASIS(1) n0 BASIS(2:sig(1)) BASIS(sig(1)+2:sig(1)+sig(2)) BASIS(sig(1)+sig(2)+2:sig(1)+sig(2)+sig(3)+1) ni];

        % Take care with the labels... we must keepp the Mother
        % Algebra original basis labels in order to no disturb
        % the user... THIS IS HARD

        %LABELS_N={labels_old{1} "n0" labels_old{2:sig(1)} labels_old{sig(1)+2:sig(1)+sig(2)} labels_old{sig(1)+sig(2)+2:sig(1)+sig(2)+sig(3)+1} "ni"};
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
        for j=1:num_el
            element=structure{j};
            [m,n]=size(element);
            P=1;
            La="";

            last_leter_is_e=0;
            new_leter_is_e=0;
            for k=1:n

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


        Ms{sig(1)+1,sig(2)+1,sig(3)+1} =M_^-1;
        labels{sig(1)+1,sig(2)+1,sig(3)+1} =L;


    end
    M=Ms{sig(1)+1,sig(2)+1,sig(3)+1};
    new_basis_names=labels{sig(1)+1,sig(2)+1,sig(3)+1};

end

