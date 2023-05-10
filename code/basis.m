function basis(signature)
    m=sum(signature);
    vec=zeros(1,2^m);
    test=MV(vec,signature);
    k=1;
    vec=zeros(1,2^m);
        vec(k)=1;
        b=MV(vec,signature);
        Q=b*b;
        vv=zeros(1,2^m);
        vv(1)=1;
        
        fprintf("Declaring e"+strrep(test.Basis{k},",","")+" as syntactic sugar, e0=1\n")
        assignin('base',"e"+strrep(test.Basis{k},",",""),b)
  
    for k=2:2^m
        vec=zeros(1,2^m);
        vec(k)=1;
        b=MV(vec,signature);
        Q=b*b;
        vv=zeros(1,2^m);
        vv(1)=1;
        num=Q.coefs(MV(vv,signature));
        fprintf("Declaring e"+strrep(test.Basis{k},",","")+" such that e"+strrep(test.Basis{k},",","")+"·e"+strrep(test.Basis{k},",","")+"="+num2str(double(num))+ "\n")
        assignin('base',"e"+strrep(test.Basis{k},",",""),b)
    end
