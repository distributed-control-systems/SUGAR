classdef (InferiorClasses = {?sym}) MV
    properties
        Lsignature
        matrix
        vec
        Basis
    end
    methods
        function obj=MV(val, signature)
            if nargin==0
                obj.Basis={};
                obj.Lsignature=[];
                obj.matrix=[];
                obj.vec=[];
            end
            if nargin==2
                obj.Lsignature=signature;
                n=sum(signature);
                m=length(val);
                if 2^n==m
                    obj.vec=val;
                    obj.matrix=sym(zeros(2^n));
                    % Signature table
                    % syms s1 s2 s3
                    s1=1;
                    s2=-1;
                    s3=0;
                    S=ones(1,n)*s3;

                    for k=1:n
                        if k<=signature(1)
                            S(k)=s1;
                        end
                        if k>signature(1)&&k<=(signature(1)+signature(2))
                            S(k)=s2;
                        end
                    end

                    %basis
                    v=1:n;
                    counter=2;
                    Basis=cell(1,2^n);
                    Basis{1}="0";
                    for k=1:n
                        C = nchoosek(v,k);
                        [f,c]=size(C);
                        for item=1:f
                            b=strrep(num2str(C(item,:)),"  ",",");
                            Basis{counter}=b;
                            counter=counter+1;
                        end
                    end
                    % Lets create its matrix representation
                    %For each element of the basis perform the product
                    Basis_count=length(Basis);
                    matrix=zeros(Basis_count,Basis_count);
                    for column=1:Basis_count
                        for row=1:Basis_count
                            Order=Basis{row}+","+Basis{column};
                            final_element="";
                            % Check what is left and sign
                            names=split(Order,',')';
                            names=cellfun(@str2num,convertStringsToChars(names));
                            masc=(names~=0);
                            names=names(masc);
                            values=unique(names,'sorted');
                            [ol,ic]=sort(names);
                            signo=1;
                            % Sign due to permutations
                            for k=1:length(names)
                                signo=signo*(-1)^(sum(names(1:k)>names(k)));
                            end
                            % Sign due to repetitions
                            for k=1:length(values)
                                number_in_vector= sum(names==values(k));
                                disapearing=fix(number_in_vector/2);
                                remaining=mod(number_in_vector,2);
                                signo=signo*(  S(values(k))  )^(disapearing);
                                if remaining==1
                                    if strlength(final_element)==0
                                        final_element=num2str(values(k));
                                    else
                                        final_element=final_element+","+num2str(values(k));
                                    end
                                end
                            end
                            names;
                            signo;
                            final_element;
                            if strlength(final_element)==0
                                final_element="0";
                            end
                            destination=find([Basis{:}] == final_element);
                            obj.matrix(destination,column)=signo*val(row);
                        end
                    end
                    obj.Basis=Basis;
                else
                    error('The numer of elements of the vector do not match the Clifford algebra signature')
                end
            end
        end
        %-----------------------------------------------------------------------------------------------
        function r=uminus(obj)
            [f,c]=size(obj);
            if f==1 && c==1
                r=MV();
                r.Lsignature=obj.Lsignature;
                r.Basis=obj.Basis;
                r.matrix=-obj.matrix;
                r.vec=-obj.vec;
            else
                for i=1:f
                    for j=1:c
                        r(i,j)=-obj(i,j);
                    end
                end
            end
        end
        %-----------------------------------------------------------------------------------------------
        function r=plus(obj1,obj2)
            [f,c]=size(obj1);
            if f==1 && c==1
                if class(obj1)=="double" || class(obj1)=="sym"
                    v=obj2.vec*0;
                    v(1)=obj1;
                    obj1=MV(v,obj2.Lsignature);
                end
                if class(obj2)=="double" || class(obj2)=="sym"
                    v=obj1.vec*0;
                    v(1)=obj2;
                    obj2=MV(v,obj1.Lsignature);
                end
                if obj1.Lsignature==obj2.Lsignature
                    r=MV(obj1.vec+obj2.vec,obj1.Lsignature);
                else
                    error("Objects comming from different algebras cannot be added")
                end
            else
                for i=1:f
                    for j=1:c
                        r(i,j)=obj1(i,j)+obj2(i,j);
                    end
                end
            end
        end
        %-------------------------------------------------------------------------------------------------------
        function r=minus(obj1,obj2)
            [f,c]=size(obj1);
            if f==1 && c==1
                if obj1.Lsignature==obj2.Lsignature
                    r=MV(obj1.vec-obj2.vec,obj1.Lsignature);
                else
                    error("Objects comming from different algebras cannot be substracted")
                end
            else
                for i=1:f
                    for j=1:c
                        r(i,j)=obj1(i,j)-obj2(i,j);
                    end
                end
            end

        end
        %------------------------------------------------------------------------------------------------
        function r=mpower(obj,k)
            [o1f,o1c]=size(obj);
            if (o1f==1 && o1c==1)
                r=MV();
                r.Basis=obj.Basis;
                r.Lsignature=obj.Lsignature;

                r.matrix=obj.matrix^k;
                r.vec=r.matrix(:,1).';
            else
                if (o1f==o1c)
                    filas=o1f;
                    columnas=o1c;
                    SUPER_MATRIX=to_SUPER_MATRIX(obj);
                    SUPER_POWER=SUPER_MATRIX^k;
                    r=from_SUPER_MATRIX(obj,SUPER_POWER);
                else
                    error("Non square matrices are not invertible")
                end
            end

        end

        %------------------------------------------------------------------------------------------------


        function determinante = det(self)
            % Verificar si la matriz es cuadrada
            [filas, columnas] = size(self);
            if filas ~= columnas
                error('In order to compute a determinant it is required to provide a sqyare matriz.');
            end

            % Caso base: matriz 1x1
            if filas == 1
                determinante = self(1, 1);
                return;
            end

            % Calcular el determinante recursivamente utilizando el método de cofactores
            determinante = 0;
            for i = 1:filas
                cofactor = (-1)^(i+1) * self(1, i) * det(self.Submatrix(1, i));
                determinante = determinante + cofactor;
            end
        end
        %------------------------------------------------------------------------------------------------
        function inversa = inv(self)
            %The inverse of a MV or a matrix of MVs
            [filas, columnas] = size(self);
            if filas ~= columnas
                error('In order to compute the inverse a square matrix is required, otherwise try with pinv');
            end
            % Caso base: matriz 1x1
            if filas == 1
                r=MV();
                r.Basis=self.Basis;
                r.Lsignature=self.Lsignature;

                r.matrix=self.matrix^(-1);
                r.vec=r.matrix(:,1).';
                inversa = r;
                return;
            end

            % Calcular la inversa con el algoritmo de "me lo he scado de la
            % manga"

            %construimos una matriz de matrices
            dimension=2^sum(self(1,1).Lsignature);
            SUPER_MATRIX=to_SUPER_MATRIX(self);
%             SUPER_MATRIX=zeros(filas*dimension,columnas*dimension);
%             f=0;
%             for i=1:dimension:filas*dimension
%                 f=f+1;
%                 c=0;
%                 for j=1:dimension:columnas*dimension
%                     c=c+1;
%                     SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
%                 end
%             end
            SUPER_INVERSE=inv(SUPER_MATRIX);
            %construimos la matriz resultante
            inversa=from_SUPER_MATRIX(self,SUPER_INVERSE);
%             inversa=self*0;
%             f=0;
%             for i=1:dimension:filas*dimension
%                 f=f+1;
%                 c=0;
%                 for j=1:dimension:columnas*dimension
%                     c=c+1;
%                     inversa(f,c).matrix=SUPER_INVERSE(i:i+dimension-1,j:j+dimension-1);
%                     inversa(f,c).vec=inversa(f,c).matrix(:,1).';
%                 end
%             end


        end
        %------------------------------------------------------------------------------------------------
        function inversa = pinv(self)
            %The inverse of a MV or a matrix of MVs
            [filas, columnas] = size(self);
            if filas ~= columnas
                
                SUPER_MATRIX=to_SUPER_MATRIX(self);
                SUPER_INVERSE=pinv(SUPER_MATRIX);
                inversa=from_SUPER_MATRIX(self.',SUPER_INVERSE);
                return
            end
            % Caso base: matriz 1x1
            if filas == 1
                r=MV();
                r.Basis=self.Basis;
                r.Lsignature=self.Lsignature;

                r.matrix=self.matrix^(-1);
                r.vec=r.matrix(:,1).';
                inversa = r;
                return;
            end

            % Calcular la inversa con el algoritmo de "me lo he scado de la
            % manga"

            %construimos una matriz de matrices
            %dimension=2^sum(self(1,1).Lsignature);
            SUPER_MATRIX=to_SUPER_MATRIX(self);
%             SUPER_MATRIX=zeros(filas*dimension,columnas*dimension);
%             f=0;
%             for i=1:dimension:filas*dimension
%                 f=f+1;
%                 c=0;
%                 for j=1:dimension:columnas*dimension
%                     c=c+1;
%                     SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
%                 end
%             end
            SUPER_INVERSE=inv(SUPER_MATRIX);
            %construimos la matriz resultante
            inversa=from_SUPER_MATRIX(self,SUPER_INVERSE);
%             inversa=self*0;
%             f=0;
%             for i=1:dimension:filas*dimension
%                 f=f+1;
%                 c=0;
%                 for j=1:dimension:columnas*dimension
%                     c=c+1;
%                     inversa(f,c).matrix=SUPER_INVERSE(i:i+dimension-1,j:j+dimension-1);
%                     inversa(f,c).vec=inversa(f,c).matrix(:,1).';
%                 end
%             end


        end



        %------------------------------------------------------------------------------------------------
        
        %------------------------------------------------------------------------------------------------
        
        function r=mtimes(obj1,obj2)
            % Determine product kind,
            % Matrix-Matrix,Matrix-scalar,scalar-Matrix, scalar-scalar
            [f1,c1]=size(obj1);
            [f2,c2]=size(obj2);

            if (f1+c1+f2+c2)==4 %scalar-scalar
                %Decide product nature MV-num, num-Mv, Mv-Mv
                %MV-MV
                if  class(obj1)=="MV" && class(obj2)=="MV"
                    %is it alowed with the given signatures?
                    if obj1.Lsignature==obj2.Lsignature
                        matrix=obj1.matrix*obj2.matrix;
                        r=MV(simplify(matrix(:,1)).',obj1.Lsignature);
                    else
                        error("Signatures don't agree in the product")
                    end
                end
                %MV-num, num-MV
                if (class(obj1)=="MV" && (class(obj2)=="double"||class(obj2)=="sym"))
                    r=MV();
                    r.vec=obj1.vec*obj2;
                    r.Basis=obj1.Basis;
                    r.Lsignature=obj1.Lsignature;
                    r.matrix=obj1.matrix*obj2;
                end
                if (class(obj2)=="MV" && (class(obj1)=="double"||class(obj1)=="sym"))
                    r=MV();
                    r.vec=obj2.vec*obj1;
                    r.Basis=obj2.Basis;
                    r.Lsignature=obj2.Lsignature;
                    r.matrix=obj2.matrix*obj1;
                end
                % Non scalar product, al least one element is matrix
            else
                %check Matrix-Matrix,Matrix-scalar,scalar-Matrix
                %scalar-Matrix
                if (f1+c1)==2
                    for i=1:f2
                        for j=1:c2
                            r(i,j)=obj1*obj2(i,j);
                        end
                    end

                end
                %Matrix-scalar
                if (f2+c2)==2
                    for i=1:f1
                        for j=1:c1
                            r(i,j)=obj1(i,j)*obj2;
                        end
                    end

                end
                %Matrix-Matrix
                if (f1+c1)>2 && (f2+c2)>2
                    %check sizes
                    if c1==f2
                        for i=1:f1
                            for j=1:c2

                                p=MV();
                                p.Basis=obj1(i,1).Basis;
                                p.Lsignature=obj1(i,1).Lsignature;
                                p.vec=(obj1(1,1).vec)*0;
                                p.matrix=(obj1(1,1).matrix)*0;
                                for k=1:c1
                                    p = p+obj1(i,k)*obj2(k,j);
                                end
                                %%% cal la representació matricial
                                r(i,j)=p;
                            end
                        end
                    else
                        error('Wrong matrix dimenssions')
                    end
                end
            end









            % % %             if  class(obj1)=="MV" && class(obj2)=="MV"
            % % %                 %check if it is an array or not
            % % %                 [o1f,o1c]=size(obj1);
            % % %                 [o2f,o2c]=size(obj2);
            % % %                 if (o1f>1 || o1c>1 || o2f>1 || o2c>1)
            % % %                     %This is a matrix product
            % % %                     r(1:o1f,1:o2c)=MV(zeros(1,length(obj1(1,1).Basis)),obj1(1,1).Lsignature);
            % % %                     for i=1:o1f
            % % %
            % % %                         for j=1:o2c
            % % %
            % % %                             p=MV();
            % % %                             p.Basis=obj1(i,1).Basis;
            % % %                             p.Lsignature=obj1(i,1).Lsignature;
            % % %                             p.vec=(obj1(1,1).vec)*0;
            % % %                             p.matrix=(obj1(1,1).matrix)*0;
            % % %                             for k=1:o1c
            % % %                                 p = p+obj1(i,k)*obj2(k,j);
            % % %                             end
            % % %                             %%% cal la representació matricial
            % % %                             r(i,j)=p;
            % % %                         end
            % % %                     end
            % % %                 else
            % % %                     % TODO check that this is unnecesary
            % % %                     M=obj1.matrix*obj2.matrix;
            % % %                     r=MV(simplify(M(:,1).'),obj1.Lsignature);
            % % %                 end
            % % %             else
            % % %                 %number MV
            % % %                 if (class(obj1)=="double"||class(obj1)=="sym") && class(obj2)=="MV"
            % % %                     [fn,cn]=size(obj1);
            % % %                     [f,c]=size(obj2);
            % % %                     if f==1 && c==1
            % % %                         if fn==1 && cn==1
            % % %                             r=MV(obj1*obj2.vec,obj2.Lsignature);
            % % %                         else
            % % %                             r=[MV()];
            % % %                             for i=1:fn
            % % %                                 for j=1:cn
            % % %                                     r(i,j)=obj1(i,j)*obj2;
            % % %                                 end
            % % %                             end
            % % %                         end
            % % %
            % % %                     else
            % % %                         r=[MV()];
            % % %                         for i=1:f
            % % %                             for j=1:c
            % % %                                 r(i,j)=obj1*obj2(i,j);
            % % %                             end
            % % %                         end
            % % %                     end
            % % %
            % % %                 end
            % % %                 %MV number
            % % %                 if  class(obj1)=="MV" && (class(obj2)=="double"||class(obj2)=="sym")
            % % %                     [fn,cn]=size(obj2);
            % % %                     [f,c]=size(obj1);
            % % %                     %MV scalar
            % % %                     if f==1 && c==1
            % % %                         % number scalar
            % % %                         if fn==1 && cn==1
            % % %                             r=MV(obj1.vec*obj2,obj1.Lsignature);
            % % %                         % number matrix
            % % %                         else
            % % %                             r=[MV()];
            % % %                             for i=1:fn
            % % %                                 for j=1:cn
            % % %                                     r(i,j)=obj1*obj2(i,j);
            % % %                                 end
            % % %                             end
            % % %                         end
            % % %                     %Mv matrix
            % % %                     else
            % % %                         r=[MV()];
            % % %                         [fn,cn]=size(obj2);
            % % %                         %number scalar
            % % %                         if fn==1 && cn==1
            % % %                             for i=1:f
            % % %                                 for j=1:c
            % % %                                     r(i,j)=obj1(i,j)*obj2;
            % % %                                 end
            % % %                             end
            % % %                         %number matrix
            % % %                         else
            % % %
            % % %
            % % %
            % % %
            % % %                         end
            % % %                 end
            % % %             end

        end
        %------------------------------------------------------------------------------------------------
        function r=apply(obj,f)
            % %             e=unique(eig(obj.matrix));
            % %             As={};
            % %             for i=1:length(e)
            % %                 Ai=eye(length(obj.Basis));
            % %                 for j=1:length(e)
            % %                     if i~=j
            % %                         Ai=Ai*(1/(e(i)-e(j))*(obj.matrix-e(j)*eye(length(obj.Basis))));
            % %                     end
            % %                 end
            % %                 As{i}=Ai;
            % %             end
            % %             p=0;
            % %             for i=1:length(e)
            % %                 p=p+f(e(i))*As{i};
            % %             end
            F=sym(f);
            p=funm(obj.matrix,F);
            r=MV(simplify(p(:,1)).',obj.Lsignature);
        end
        %-------------------------------------------------------------------------------------------------
        function r=str(obj1)
            r="";
            for k=1:length(obj1.vec)
                if obj1.vec(k)~=0
                    if class(obj1.vec(k))=="double"
                        r=r+" ("+obj1.vec(k)+")e"+strrep(obj1.Basis{k},",","");
                    else
                        r=r+" ("+char(obj1.vec(k))+")*e"+strrep(obj1.Basis{k},",","");
                    end
                end

            end
            if r==""
                r=" 0 ";
            end
        end
        %-------------------------------------------------------------------------------------------------

        function r=latex_str(obj1)
            r="";
            for k=1:length(obj1.vec)
                if obj1.vec(k)~=0
                    if class(obj1.vec(k))=="double"
                        r=r+"+\left("+obj1.vec(k)+"\right)e_{"+strrep(obj1.Basis{k},",","")+"}";
                    else
                        r=r+"+\left("+latex(obj1.vec(k))+"\right)e_{"+strrep(obj1.Basis{k},",","")+"}";
                    end
                end

            end
            if r==""
                r="  0 ";
            end
            r=extractAfter(r,1);
        end
        %-------------------------------------------------------------------------------------------------
        function disp(obj1)
            [f,c]=size(obj1);
            if f==1 && c==1
                r="";
                for k=1:length(obj1.vec)
                    if obj1.vec(k)~=0
                        if class(obj1.vec(k))=="double"
                            r=r+" ( "+obj1.vec(k)+" )e"+strrep(obj1.Basis{k},",","");
                        else
                            r=r+" ( "+char(obj1.vec(k))+" )*e"+strrep(obj1.Basis{k},",","");
                        end
                    end

                end
                if r==""
                    r=" 0 ";
                end

                %                     r=r+ " ---> algebra ( " ;
                %                     for k=1:length(obj1.Lsignature)
                %                         r=r+obj1.Lsignature(k) +" ";
                %                     end
                %                     r=r+")";

                fprintf(r+"\n");
            else
                for i=1:f
                    for j=1:c
                        r=obj1(i,j).str();
                        fprintf(r)
                        fprintf("    ");
                    end
                    fprintf("\n");
                end
            end
        end

        %---------------------------------------------------------------------
        function r=element(self,obj)
            if class(obj)~="MV"
                error("When asking for components the parameter must be a multivector")
            else
                mascara=(obj.vec==0);
                nv=self.vec;
                nv(mascara)=0;
                r=MV(nv,self.Lsignature);


            end
        end
        %---------------------------------------------------------------------
        function r=coefs(self,obj)
            if class(obj)~="MV"
                error("When asking for components the parameter must be a multivector")
            else
                mascara=(obj.vec~=0);
                r=self.vec(mascara).';

            end
        end
        %---------------------------------------------------------------------
        function r=simplify(self)

            if class(self)~="MV"
                error("When asking for simplify the parameter must be a multivector")
            else
                [f,c]=size(self);
                if f*c==1
                    r=MV(simplify(self.vec),self.Lsignature);
                else
                    %hay que ir fila a fila
                    for k=1:f
                        for kk=1:c
                            r(k,kk)=simplify(self(k,kk));
                        end
                    end
                end
            end
        end
        %---------------------------------------------------------------------
        function r=expand(self)
            if class(self)~="MV"
                error("When asking for expand the parameter must be a multivector")
            else
                [f,c]=size(self);
                if f*c==1

                    r=MV(expand(self.vec),self.Lsignature);
                else
                    %hay que ir fila a fila
                    for k=1:f
                        for kk=1:c
                            r(k,kk)=expand(self(k,kk));
                        end
                    end
                end

            end
        end
        %---------------------------------------------------------------------
        function r=collect(self)
            if class(self)~="MV"
                error("When asking for collect the object must be a multivector")
            else
                [f,c]=size(self);
                if f*c==1

                    r=MV(collect(self.vec),self.Lsignature);
                else
                    %hay que ir fila a fila
                    for k=1:f
                        for kk=1:c
                            r(k,kk)=collect(self(k,kk));
                        end
                    end
                end

            end
        end

        %---------------------------------------------------------------------
        function r=latex(obj1)
            [f,c]=size(obj1);
            if f==1 && c==1
                r=obj1.latex_str()

            else
                r="\left[\begin{array}{";
                for i=1:c
                    r=r+"c";
                end
                r=r+"}";
                for i=1:f
                    for j=1:c
                        r=r+obj1(i,j).latex_str();

                        r=r+"  &  ";
                    end
                    %size(r)
                    r=extractBefore(r,strlength(r)-2);
                    r=r+"\\ ";
                end
                r=r+"\end{array}\right]";
            end
        end
       
        %--------------------------------------------------------------
        function r=super(self)
            r=self.to_SUPER_MATRIX();
        end
    end
    methods (Access = private)
        function submatriz = Submatrix(matriz, fila, columna)
            submatriz = matriz;
            submatriz(fila, :) = [];
            submatriz(:, columna) = [];
        end
        function r=to_SUPER_MATRIX(self)
            [filas,columnas]=size(self);
            dimension=2^sum(self(1,1).Lsignature);
            SUPER_MATRIX=zeros(filas*dimension,columnas*dimension);
            f=0;
            for i=1:dimension:filas*dimension
                f=f+1;
                c=0;
                for j=1:dimension:columnas*dimension
                    c=c+1;
                    SUPER_MATRIX(i:i+dimension-1,j:j+dimension-1)=self(f,c).matrix;
                end
            end
            r=sym(SUPER_MATRIX);
        
        end
        function r=from_SUPER_MATRIX(self,M)
            [filas,columnas]=size(self);
            dimension=2^sum(self(1,1).Lsignature);
            inversa=self*0;
            f=0;
            for i=1:dimension:filas*dimension
                f=f+1;
                c=0;
                for j=1:dimension:columnas*dimension
                    c=c+1;
                    inversa(f,c).matrix=M(i:i+dimension-1,j:j+dimension-1);
                    inversa(f,c).vec=inversa(f,c).matrix(:,1).';
                end
            end
            r=inversa;
        end
    end
end