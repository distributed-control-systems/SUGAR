function GA(sig,options)
if nargin==1
    options="";
end
    m=sum(sig);
    vec=zeros(1,2^m);
    test=MV(vec,sig);
    k=1;
    vec=zeros(1,2^m);
        vec(k)=1;
        b=MV(vec,sig);
        Q=b*b;
        vv=zeros(1,2^m);
        vv(1)=1;
        Basis=test.BasisNames;
        if options=="verbose"
        fprintf("Declaring "+Basis{k}+" as syntactic sugar, e0=1\n")
        end
        assignin('base',Basis{k},b)
  
    for k=2:2^m
        vec=zeros(1,2^m);
        vec(k)=1;
        b=MV(vec,sig);
        Q=b*b;
        vv=zeros(1,2^m);
        vv(1)=1;
        vs=Q.vector;
        num=vs(1);%Q.coefs(MV(vv,signature));
        if options=="verbose"
        fprintf("Declaring " + Basis{k}+" such that "+Basis{k}+"·"+Basis{k}+"="+num2str(double(num))+ "\n")
        end
        assignin('base',Basis{k},b)
    end

    vec=ones(1,2^m);
test=MV(vec,sig);
if options=="verbose"
fprintf(" \n")
end
for k=0:sum(sig)

    g=test.grade(k);
    if options=="verbose"
    fprintf("Declaring G"+num2str(k)+" for grade slicing as "+ str(g) +" \n")
    end
    assignin('base',"G"+num2str(k),g)
end
if options=="verbose"
fprintf(" \n")
end