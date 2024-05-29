function KGA(sig,DTS,options)
%%KGA(sig, DTS,options) 
% This function creates a geometric algebra with signature [p,q,r]. 
% p stands for number of positive basis, q for number of negative basis and
% r for number of degenerate bases.
% Additionally, it adds a tangent space to de algebra corresponding to the
% description in DTS=[dimenssion, deep], where dimenssion is the number of
% variables that will be used to compute the tangent space and deep is the
% maximum derivative order of these variables. The user has the
% responsability to name this variables. 
% Example:
% KGA([2 0 0],[2,2]) creates the euclidean plane coordinates and adds extra
% basis to compute its tangent space. The user may declare the symbolic
% vriables x and y to represent such coordinates and the MV variables
% X=x+D1
% Y=y+D2
% Then, when using these variables for buidling expressions like
%
% Z=X^2+sin(3*Y)
%
% The MV Z will contain the usual 2d euclidian plane variables plus 
% D1 derivative of Z whith respect to x
% D2 derivative of Z with respect to y
% DD1 second derivative with respect to x
% D1D2 cros term of the second derivative
% DD2 second derivative with respect to y

%%
GA(sig);
n=sum(sig);
Names=e0.BasisNames;
vec="["
for i=1:length(Names)
    vec=vec+" "+Names{i};
end
vec=vec+"]";
M=eval(vec);
tb=M.'*M;
CAL=arrayfun(@(x) char(x),tb);
CAL=strrep(CAL,"( 1 )*","");
CAL=strrep(CAL,"( -1 )*","-")

%Now... we have to suplement the table with the extra bases.... firs we
%must create them
Extra=[];
for i=1:DTS(1)
    for j=1:DTS(2)
        Extra=[Extra char(ones([1 j])*'D')+""+num2str(i)];
        
    end
end


% These new bases do form bivectors when dimenssion is biger than 1 
% So we still have to add the cross bases
% Lets use THE MOST HORRIBLE trick to generate them
% Don't do this at home, it's dangerous

%%%%%%%% TRICK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test=MV([1:2^sum(DTS)],[0 0 sum(DTS)]);
New_mv=test.BasisNames;
for i=sum(DTS)+1:length(New_mv)-1
    index=char(strrep(New_mv{i+1},"e",""))
    mv="";
    ind=[-1];
    for j=1:length(index)
        bb=char(Extra(str2double(index(j))));
        if sum(ind==str2double(bb(end)))==0
        mv=mv+Extra(str2double(index(j)));
        ind=[ind str2double(bb(end))];
        else
            mv="";
            break
            
        end
    end
    if mv~=""
        Extra=[Extra mv];
    end
    
end
%%%%%%%% END TRICK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Extra_cross=[];
%Every extra element may end up multiplied by any of the already defined basis,
% so...even more elements to the basis definition 
for i=1:length(CAL(:,1))
    for j=1:length(Extra)
        Extra_cross=[Extra_cross CAL(i,1)+Extra(j)];
    end
end


% Now we have all the new vectors and bivectors and trivectors and.... 
% let's fill up the cayley table, which turns out to be a really big table!!!
% the submatrix correspondoing to the derivatives is very simple




Extra
Extra_cross
%%

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