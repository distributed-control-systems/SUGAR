function cayley(sig,options)
%%cayley(tbl,options) 
% This function creates an algebra that obeys the exterior product given
% by the caley table decribed in tbl. 
% tbl is n by n aray of strings containing the product rules.
% The first coulm of tbl must be the names of the basis themselves
% The first row of tbl must be names of the bases themselves
% The first element of the first row and column should be the identity
% element of the product.
% Each i,j position of the table must be the result of the product of basis
% i with basis j, plus an optional "-" sign, do not use "+" signs.
%
% Example:
% tbl=["e0","e1","e2","e3","e4"
%      "e1","e2","e3","e4", "0"
%      "e2","e3","e4", "0", "0"
%      "e3","e4", "0", "0", "0"
%      "e4", "0", "0", "0", "0"]
%
% Example: (2d projective geometric algebra, [2 0 1] )
% tbl= ["e0"   "e1"    "e2"    "e3"   "e12"  "e13"    "e23"   "e123"
%       "e1"   "e0"    "e12"   "e13"  "e2"   "e3"     "e123"  "e23" 
%       "e2"   "-e12"  "e0"    "e23"  "-e1"  "-e123"  "e3"    "-e13"
%       "e3"   "-e13"  "-e23"  "0"    "e123" "0"      "0"     "0"   
%       "e12"  "-e2"   "e1"    "e123" "-e0"  "-e23"   "e13"   "-e3" 
%       "e13"  "-e3"   "-e123" "0"    "e23"  "0"      "0"     "0"   
%       "e23"  "e123"  "-e3"   "0"    "-e13" "0"      "0"     "0"   
%       "e123" "e23"   "-e13"  "0"    "-e3"  "0"      "0"     "0"  ]
% 
% The posible options is just "verbose" to see into screen whic variables
% are created in the workspace.

al="ℝ onto cayley table\n";


if nargin==1
    options="";
end
    m=length(sig(:,1));
    vec=zeros(1,m);
    test=MV(vec,sig);
    k=1;
    vec=zeros(1,m);
        vec(k)=1;
        b=MV(vec,sig);
        
        vv=zeros(1,m);
        vv(1)=1;
        Basis=test.BasisNames;
        if options=="verbose"
        fprintf("Declaring [\b"+Basis{k}+"]\b as syntactic sugar, [\be0]\b=1\n")
        
        end
        %algebra=algebra+"\t[\b"+Basis{k}+"]\b is syntactic sugar, [\be0]\b=1\n";
        assignin('caller',Basis{k},b)
  
    for k=2:m
        vec=zeros(1,m);
        vec(k)=1;
        b=MV(vec,sig);
        
        if options=="verbose"
        fprintf("Declaring [\b" + Basis{k}+"]\b \n")

        end
        %algebra=algebra+ "\t[\b"+ Basis{k}+"]\b \n";
        assignin('caller',Basis{k},b)
    end

    

if options=="verbose"
    fprintf("which obey the cayley multiplication table\n")
    for i=1:m
        for j=1:m
            fprintf(sig(i,j)+"\t");
        end
        fprintf("\n");
    end

    algebra="The actual Algebra is ℝ onto cayley table\n" ;
    for i=1:m
        for j=1:m
            algebra=algebra+sig(i,j)+"\t";
            al=al+sig(i,j)+"\t";
        end
            algebra=algebra+"\n";
            al=al+"\n";
    end
   
assignin('caller',"algebra_info",info(algebra))
assignin('caller',"algebra",info(al))
end