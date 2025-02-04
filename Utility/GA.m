function GA(sig,options)
% GA  Declares a Geometric Algebra in the current workspace.
%
%   GA(SIG) initializes the Geometric Algebra ℝ{SIG} and assigns basis 
%   multivectors to the caller's workspace. SIG is a vector defining 
%   the metric signature.
%
%   GA(SIG, 'verbose') enables detailed output, displaying the declared 
%   basis elements and their properties.
%
%   Output:
%     - Basis multivectors assigned to the workspace.
%     - Grade slicing variables G0, G1, ..., Gn for extracting components.
%     - Algebra information stored in 'algebra' and 'algebra_info'.
%
%   Example:
%     GA([1 1 1]);  % Declares ℝ{1,1,1}
%     GA([1 1 1], 'verbose');  % Declares with detailed output
%
%   The basis elements can be accessed as variables in the workspace.
%   Grade slicing can be done using A(Gx) or A{Gx}.
%
% See also MV, CGA
al="ℝ{"+ num2str(sig)+"}\n";
algebra="The actual Algebra is ℝ{"+ num2str(sig)+"} where:\n";
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
        fprintf("Declaring [\b"+Basis{k}+"]\b as syntactic sugar, [\be0]\b=1\n")
        
        end
        algebra=algebra+"\t[\b"+Basis{k}+"]\b is syntactic sugar, [\be0]\b=1\n";
        assignin('caller',Basis{k},b)
  
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
        fprintf("Declaring [\b" + Basis{k}+"]\b such that [\b"+Basis{k}+"]\b·[\b"+Basis{k}+"]\b="+num2str(double(num))+ "\n")

        end
        algebra=algebra+ "\t[\b"+ Basis{k}+"]\b is such that [\b"+Basis{k}+"]\b·[\b"+Basis{k}+"]\b="+num2str(double(num))+ "\n";
        assignin('caller',Basis{k},b)
    end

    vec=ones(1,2^m);
test=MV(vec,sig);
if options=="verbose"
fprintf(" \n")
end
algebra=algebra+"Some MV have been added to your workspace in order to easy slicing and grade extraction, which are:\n";
for k=0:sum(sig)

    g=test.grade(k);
    if options=="verbose"
    fprintf("Declaring G"+num2str(k)+" for grade slicing as "+ str(g) +" \n")
    end
    algebra=algebra+"\t G"+num2str(k)+" for grade "+num2str(k)+" slicing as G"+num2str(k)+"="+ str(g) +" \n";
    assignin('caller',"G"+num2str(k),g)
end
algebra=algebra+"use them like A(Gx) to retrive ⟨A⟩x's components on grade x\nor like A{Gx} to retrive the ⟨A⟩x itself\n";
assignin('caller',"algebra_info",info(algebra))
assignin('caller',"algebra",info(al))
if options=="verbose"
fprintf(" \n")

end