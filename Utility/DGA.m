function DGA(sig,DTS,options)
%%KGA(sig, DTS,options) 
% This function creates a geometric algebra with signature [p,q,r]. 
% p stands for number of positive basis, q for number of negative basis and
% r for number of degenerate bases.
% Additionally, it adds a tangent space to de algebra corresponding to the
% description in DTS=[dimenssion, order], where dimenssion is the number of
% variables that will be used to compute the tangent space and order is the
% maximum derivative order of these variables. The user has the
% responsability to name this variables. 
% Example:
% DGA([2 0 0],[2,2]) creates the euclidean plane coordinates and adds extra
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
% Probably this is the uglyest code I've done in my live, but I'm in a
% hurry and this is what we get. At some point I will reformat it and erase
% this comment.
% The problem is that the cayley tables are defined with text strings and
% matlab is horrible working with strings....😅

GA(sig);
%n=sum(sig);
Names=e0.BasisNames;
vec="[";
for i=1:length(Names)
    vec=vec+" "+Names{i};
end
vec=vec+"]";
M=eval(vec);
tb=M.'*M;
CAL=arrayfun(@(x) char(x),tb);
CAL=strrep(CAL,"( 1 )*","");
CAL=strrep(CAL,"( -1 )*","-");

%Now... we have to suplement the table with the extra bases.... firs we
%must create them
Extra=[];
for i=1:DTS(1)
    for j=1:DTS(2)
        Extra=[Extra char(ones([1 j])*'D')+""+num2str(i)];
        
    end
end
% Alternativa....


% These new bases do form bivectors when dimenssion is biger than 1 
% So we still have to add the cross bases
% Lets use THE MOST HORRIBLE trick to generate them
% Don't do this at home, it's dangerous
if DTS(1)>1 && DTS(2)>1
%%%%%%%% TRICK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test=MV(1:2^(sum(DTS)),[0 0 sum(DTS)]);
New_mv=test.BasisNames;
for i=sum(DTS)+1:length(New_mv)-1
    index=char(strrep(New_mv{i+1},"e",""));
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
        if (length(char(regexprep(mv,'[\d+]','')))<=DTS(2))
            Extra=[Extra mv];
        end
    end
    
end
%%%%%%%% END TRICK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

len = arrayfun( @(jj) length(char(regexprep(Extra(jj),'\d+','')))+str2double("0."+strrep(Extra(jj),"D","")) ,1:size(Extra,2));
[ ~, ix ] = sort( len );
Extra=Extra(ix);

% and its related cayley table ....
%Extra_cayley=[]
for i=1:length(Extra) %rows
    for j=1:length(Extra) %Columns
        
        mv=Extra(i)+Extra(j);
        %lets count the derivative order
        if (length(char(regexprep(mv,'[\d+]','')))>DTS(2))
            result="0";
        else
            %lets count Ds before numbers
            %Ds=0;
            num=0;
            mv=char(mv);
            structure=zeros(DTS(1),1);
            for k=1:length(mv)
                if mv(k)=='D'
                    num=num+1;
                else
                    structure(str2double(mv(k)))=structure(str2double(mv(k)))+num;
                    num=0;
                end
            end
            result="";
            for k=1:DTS(1)
                if structure(k)>0
                    result=result+ char(ones(1,structure(k))*'D')+num2str(k);
                end
            end
        end
        Extra_cayley(i,j)=result;
    end
end

%%%%%%%%%%%%%%% NEW-ORIGINAL=cors

Extra_cross=[];
elements_Extra_cross_cayley={};
%Every extra element may end up multiplied by any of the already defined basis,
% so...even more elements to the basis definition 
for i=1:length(CAL(2:end,1))
    for j=1:length(Extra)
        Extra_cross=[Extra_cross CAL(i+1,1)+Extra(j)];
        elements_Extra_cross_cayley{end+1}=[CAL(i+1,1),Extra(j)];
    end
end
%and some extra cayley sectors to compute


for i=1:length(Extra_cross)
    for j=1:length(Extra_cross)
        %we must chek both caley tables that already exist
        %the result is a mix
        %find result in CAL
        e1=elements_Extra_cross_cayley{i};
        e2=elements_Extra_cross_cayley{j};
        %where is e1(1) in the original cayey table
        row=CAL(:,1)==e1(1);
        %where is e2(1) in the original cayey table
        column=CAL(1,:)==e2(1);

        result=CAL(row,column);

        %where is e1(2) in the Extra_cayley table
        row=(Extra==e1(2));
        %where is e2(2) in the Extra_cayley table
        column=(Extra==e2(2));
        
        %is it 0?
        if Extra_cayley(row,column)=="0"
            result="0";
        elseif CAL(row,column)=="0"
            result="0"
        else
            % conmutativity of elements 
            %how many basis in e1(2)?
            left=length(char(regexprep(e1(2),"\d+","")));
            %how many basis in e2(1)?
            right= length(char(strrep(e2(1),"e","")));
            
            total=right*left;
            s=(-1)^total;
            if s==1
                sign="";
            else
                sign="-";
            end
            result=strrep(sign+result+Extra_cayley(row,column),"--","");
        end

        Extra_cayley_cross(i,j)=result;
    end
end

% Still missing some products....
%%%%%%%%%%%%%%% ORIGINAL-CROSS
%%%%%%%%%%%%%%% CROSS-ORIGINAL (signs!!!)
for i=1:length(CAL(2:end,1))
    for j=1:length(Extra_cross)
            row=i+1;
            e2=regexprep(Extra_cross(j),'D+\d+','');
            e1=CAL(row,1);
            column=CAL(1,:)==e2;
            %Lets avoid the conmutativity by now and lets see what happens
            start=regexp(Extra_cross(j),'D+\d+');
            text=char(Extra_cross(j));

            if CAL(row,column)=="0 "
                Extra_cayley_cross_12(i,j)="0";
                Extra_cayley_cross_21(j,i)="0";
            else
                result=CAL(row,column)+text(start:end);
                Extra_cayley_cross_12(i,j)=result;
           
            % we have to cross e1 trough text(start:end) and change the
            % sign due to the transpose...
            %first, how mani bases will i cross in text(start:end)
            
            

                


            num_diff_bases=length(strrep(regexprep(text(start:end),'\d',''),"e","")); %number of Ds
            % Extreme care must be taken, this will fail wheneber the bases
            % go beyound 10...
            num_crossing_bases=length(char(strrep(e1,"e","")));
            total=num_crossing_bases*num_diff_bases;
            
            
            s=(-1)^total;
            if s==-1
                sign="-";
            else
                sign="";
            end

            result=CAL(column,row)+text(start:end);
            Extra_cayley_cross_21(j,i)=strrep(sign+result,"--","");
            end
    end
end

%%%%%%%%%%%%%%% ORIGINAL- NEW
%%%%%%%%%%%%%%% NEW - ORIGINAL

for i=1:length(CAL(2:end,1))
    for j=1:length(Extra)
            e1=CAL(i+1,1);
            e2=Extra(j);
            result=e1+e2;
            Extra_cayley_cross_13(i,j)=result;

            
            num_diff_bases=length(regexprep(e2,'\d','')); %number of Ds
            % Extreme care must be taken, this will fail wheneber the bases
            % go beyound 10...
            num_crossing_bases=length(char(strrep(e1,"e","")));
            total=num_crossing_bases*num_diff_bases;
            s=(-1)^total;
            if s==1
                sign="";
            else
                sign="-";
            end
            result=CAL(i+1,1)+e2;

            Extra_cayley_cross_31(j,i)=strrep(sign+result,"--","");
    end
end

%%
%%%%%%%%%%%%%%% CROSS-NEW
%%%%%%%%%%%%%%% NEW-CROSS
for i=1:length(Extra_cross)
    for j=1:length(Extra)
            
            e1=regexprep(Extra_cross(i),'D+\d+','');
            %Lets avoid the conmutativity by now and lets see what happens
            start=regexp(Extra_cross(i),'D+\d+');
            text=char(Extra_cross(i));
            e1_remain=text(start:end);
            %which row do I find e1_remain?
            row=Extra==e1_remain;
             column=j;
            e2=Extra_cayley(row,column);
            if e2=="0"
                Extra_cayley_cross_23(i,j)="0";
            else
                Extra_cayley_cross_23(i,j)=e1+e2;
            end
            
            % Once again we have to count swaps of basis....
            
            left_new_basis=length(char((regexprep(Extra(j),"\d+",""))));
            right_old_basis= length(char(strrep(regexprep(Extra_cross(i),"D+\d+",""),"e","")));
            
            %num of swaps
            total=left_new_basis*right_old_basis;
            s=(-1)^total;
            if s==1
                sign="";
            else
                sign="-";
            end
            if e2=="0"
                Extra_cayley_cross_32(j,i)="0";
            else
                Extra_cayley_cross_32(j,i)=strrep(sign+e1+e2,"--","");
            end

    end
end

%be aware... if sig was [0 0 0] then there is no Extra_cayley_cross_12
if ~exist('Extra_cayley_cross_12')
    Extra_cayley_cross_12=[];
    Extra_cayley_cross_21=[];
end
if ~exist('Extra_cayley_cross_13')
    Extra_cayley_cross_13=[];
    Extra_cayley_cross_31=[];
end
if ~exist('Extra_cayley_cross_32')
    Extra_cayley_cross_32=[];
    Extra_cayley_cross_23=[];
end
if ~exist('Extra_cayley_cross')
    Extra_cayley_cross=[];
    Extra_cayley_cross=[];
end
% Finally we have all the combinations!!!
% Build the table
FINAL=[CAL                                    [Extra_cross;Extra_cayley_cross_12 ] [Extra;Extra_cayley_cross_13]
       [Extra_cross' Extra_cayley_cross_21 ]  Extra_cayley_cross                    Extra_cayley_cross_23 
       [Extra' Extra_cayley_cross_31]        Extra_cayley_cross_32                Extra_cayley           ];
        
% Last round, remove those nasty e0
for i=2:size(FINAL,1)
    for j=2:size(FINAL,2)


         fn=strrep(FINAL(i,j),"e0","");
         if fn=="-" || fn==""

         else
             
            FINAL(i,j)=fn;
         end
    end
end

for i=1:size(FINAL,1)
    for j=1:size(FINAL,2)
        if FINAL(i,j)==""
            FINAL(i,j)="e0"
        end
    end
end

sig_o=sig;
sig=FINAL;
al="Differential GA ["+ num2str(sig_o)+ "] ["+ num2str(DTS) +"]\n";
if nargin==2
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

    algebra="The  Algebra is a Differential GA ["+ num2str(sig_o) + "] ["+ num2str(DTS) +"]\n" ;
    for i=1:m
        for j=1:m
            algebra=algebra+sig(i,j)+"\t";
            %al=al+sig(i,j)+"\t";
        end
            algebra=algebra+"\n";
            %al=al+"\n";
    end
   
assignin('caller',"algebra_info",info(algebra))
assignin('caller',"algebra",info(al))

% % % % %%
% % % % 
% % % % al="ℝ onto cayley table\n";
% % % % 
% % % % 
% % % % if nargin==1
% % % %     options="";
% % % % end
% % % %     m=length(sig(:,1));
% % % %     vec=zeros(1,m);
% % % %     test=MV(vec,sig);
% % % %     k=1;
% % % %     vec=zeros(1,m);
% % % %         vec(k)=1;
% % % %         b=MV(vec,sig);
% % % %         
% % % %         vv=zeros(1,m);
% % % %         vv(1)=1;
% % % %         Basis=test.BasisNames;
% % % %         if options=="verbose"
% % % %         fprintf("Declaring [\b"+Basis{k}+"]\b as syntactic sugar, [\be0]\b=1\n")
% % % %         
% % % %         end
% % % %         %algebra=algebra+"\t[\b"+Basis{k}+"]\b is syntactic sugar, [\be0]\b=1\n";
% % % %         assignin('caller',Basis{k},b)
% % % %   
% % % %     for k=2:m
% % % %         vec=zeros(1,m);
% % % %         vec(k)=1;
% % % %         b=MV(vec,sig);
% % % %         
% % % %         if options=="verbose"
% % % %         fprintf("Declaring [\b" + Basis{k}+"]\b \n")
% % % % 
% % % %         end
% % % %         %algebra=algebra+ "\t[\b"+ Basis{k}+"]\b \n";
% % % %         assignin('caller',Basis{k},b)
% % % %     end
% % % % 
% % % %     
% % % % 
% % % % if options=="verbose"
% % % %     fprintf("which obey the cayley multiplication table\n")
% % % %     for i=1:m
% % % %         for j=1:m
% % % %             fprintf(sig(i,j)+"\t");
% % % %         end
% % % %         fprintf("\n");
% % % %     end
% % % % 
% % % %     algebra="The actual Algebra is ℝ onto cayley table\n" ;
% % % %     for i=1:m
% % % %         for j=1:m
% % % %             algebra=algebra+sig(i,j)+"\t";
% % % %             al=al+sig(i,j)+"\t";
% % % %         end
% % % %             algebra=algebra+"\n";
% % % %             al=al+"\n";
% % % %     end
% % % %    
% % % % assignin('caller',"algebra_info",info(algebra))
% % % % assignin('caller',"algebra",info(al))
% % % % end
% % % % end
% % % % 
% % % %     
% % % %     
% % % %     function tbl=mix_tbl_generator(v1, v2 , C1, C2)
% % % %     Extra_cross=[];
% % % %     elements_Extra_cross_cayley={}
% % % %     %Every extra element may end up multiplied by any of the already defined basis,
% % % %     % so...even more elements to the basis definition 
% % % % for i=1:length(v1)
% % % %     for j=1:length(v2)
% % % %         Extra_cross=[Extra_cross v1(i)+v2(j)];
% % % %         elements_Extra_cross_cayley{end+1}=[v1(i),v2(j)];
% % % %     end
% % % % end
% % % % %and some extra cayley sectors to compute
% % % % 
% % % % for i=1:length(Extra_cross)
% % % %     for j=1:length(Extra_cross)
% % % %         %we must chek both caley tables that already exist
% % % %         %the result is a mix
% % % %         %find result in CAL
% % % %         e1=elements_Extra_cross_cayley{i};
% % % %         e2=elements_Extra_cross_cayley{j};
% % % %         %where is e1(1) in the original cayey table
% % % %         row=find(CAL(:,1)==e1(1));
% % % %         %where is e2(1) in the original cayey table
% % % %         column=find(CAL(1,:)==e2(1));
% % % % 
% % % %         result=CAL(row,column);
% % % % 
% % % %         %where is e1(2) in the Extra_cayley table
% % % %         row=find(Extra==e1(2));
% % % %         %where is e2(2) in the Extra_cayley table
% % % %         column=find(Extra==e2(2));
% % % %         
% % % %         %is it 0?
% % % %         if Extra_cayley(row,column)=="0"
% % % %             result="0";
% % % %         else
% % % %             %Lets avoid the conmutativity by now and lets see what happens
% % % %             result=result+Extra_cayley(row,column);
% % % %         end
% % % % 
% % % %         tbl(i,j)=result;
% % % %     end
% % % % end

end