function rename_basis_to(b_name)
    e0=evalin("caller","e0");
    BN=e0.BasisNames;
    NBN={}; 
    for i=1:length(BN)
        NBN{end+1}=strrep(BN{i},"e",b_name);
    end
    for i=1:length(NBN)
        K=evalin("caller",BN{i});
        K.Basis=NBN;
        assignin("caller",NBN{i},K)
    end