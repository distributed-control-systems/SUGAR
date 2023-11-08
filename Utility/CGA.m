function CGA(n,options)
if nargin==1
    options="";
end

[f,c]=size(n);
if f*c==1
    signature=[n+1,1,0];
else
    signature=n+[1,1,0];
end
fprintf('Be patient, this will take some time...\n')
if options=="verbose"
fprintf('\n ---- CGA BASIS -----\n')
end
% fprintf('General basis declaration\n')

elements=[];
m=sum(signature);
vec=zeros(1,2^m);
test=MV(vec,signature,"CGA");
Basis=test.BasisNames;
k=1;
vec=zeros(1,2^m);
vec(k)=1;
b=MV(vec,signature,"CGA");
Q=b*b;
vv=zeros(1,2^m);
vv(1)=1;
if options=="verbose"
fprintf("Declaring "+Basis{k}+" as syntatic sugar, e0=1\n")
end
b.REPR="CGA";
assignin('base',Basis{k},b)
elements=[elements b];
vec=zeros(1,2^m);
vec(k)=1;
b=MV(vec,signature);
for k=2:2^m
    vec=zeros(1,2^m);
    vec(k)=1;
    b=MV(vec,signature,"CGA");
    Q=b*b;
    vv=zeros(1,2^m);
    vv(1)=1;
    num=table(Q.vector).Var1(1);
    %fprintf("Declaring "+Basis{k}+" such that "+Basis{k}+"·"+Basis{k}+"="+num2str(double(num))+ "\n")
    b.REPR="CGA";
    %assignin('base',Basis{k},b)
    elements=[elements b];
end

%-----------------------------------------


for k=2:2^m
    b=elements(k);
    num=b*b;
   if options=="verbose"
    fprintf("Declaring "+Basis{k}+" such that "+Basis{k}+"·"+Basis{k}+"="+num2str(num(1))+ "\n")
   end
    assignin('base',Basis{k},b)
end
%----------------------------------------



%last_p=elements(signature(1)+1);
%last_n=elements(signature(1)+signature(2)+1);

%n0=0.5*last_n-0.5*last_p;

%assignin('base',"n0",n0);
%ni=last_p+last_n;
%assignin('base',"ni",ni)

%I=1*elements(1);
%for k=1:n
%I=I*elements(k+1);
%end
%I=n0.^I.^ni;
v=zeros(1,2^sum(signature));
v(end)=1;
I=MV(v,signature,"CGA");
assignin('base',"I",I)

vec=ones(1,2^m);
test=MV(vec,signature,"CGA");
if options=="verbose"
fprintf(" \n")
end
for k=0:sum(signature)

    g=test.grade(k);
   if options=="verbose"
    fprintf("Declaring G"+num2str(k)+" for grade slicing as "+str(g)+" \n")
   end
    assignin('base',"G"+num2str(k),g)
end
if options=="verbose"
fprintf(" \n")
end

%         fprintf('\n ---- CGA BASIS -----\n')
%         for j=2:n+1
%             num=elements(j)*elements(j);
%             num=table(num.vector).Var1(1);
%             fprintf("CGA basis e"+(j-1)+" such that e"+(j-1)+"·e"+(j-1)+"="+num2str(double(num))+ "\n")
%         end




%         fprintf("Declared CGA pseudoscalar I \n")
%         num=n0*n0;
%         num=table(num.vector).Var1(1);
%         fprintf("CGA basis n0 such that n0·n0="+num2str(double(num))+ "\n")
%         num=ni*ni;
%         num=table(num.vector).Var1(1);
%         fprintf("CGA basis ni such that ni·ni="+num2str(double(num))+ "\n")
n0=elements(find(Basis=="n0"));
ni=elements(find(Basis=="ni"));

push=@(x)n0+x+1/2*x*x*ni;
point  = @(coord) n0 +elements(3:n+2)*coord.' + 0.5*(coord*coord.')*ni;
E=n0.^ni;
Ei=E^-1;
pull=@(p)((p*(-p.*ni)^-1).^E)*Ei;
normal=@(p)p*(-p.*ni)^-1;

%%line   = (a,b,c)=>!(a*1e1 + b*1e2 + c*ni),
%%circle = (x,y,r)=>!(point(x,y) - r**2/2*ni);
assignin('base',"push",push)
assignin('base',"pull",pull)
assignin('base',"point",point)
assignin('base',"normal",normal)
if options=="verbose"
fprintf("push, pull, normal and point are now available \n")
end