function structure= full_algebra_basis_coefs(sig)
    persistent signatures
    persistent structures
    if isempty (signatures)
        structures{10,10,10}=0;
        signatures{10,10,10}=0;
    end
    if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
        BASE=num2cell(1:sum(sig));
        Last=BASE;
        BASE_FIN=BASE;
        cb=length(BASE);
        while ~isempty(Last)
            cl=length(Last);
            llenado={};
            for i=1:cl
                for j=1:cb
                    L_=Last{i};
                    B_=BASE{j};
                    L_=L_(end);
                    B_=B_(end);
                    if (sum(Last{i}==BASE{j})==0) && (L_<B_)
                        RR=[Last{i} BASE{j}];
                        llenado=[llenado, RR];
                    end
                end
            end
            Last=llenado;
            BASE_FIN=[BASE_FIN llenado];
        end
        signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
        structures{sig(1)+1,sig(2)+1,sig(3)+1}=BASE_FIN;
    end
    structure=structures{sig(1)+1,sig(2)+1,sig(3)+1};
end

