classdef (InferiorClasses = {?sym}) MV
    properties
        Lsignature
        matrix
        vec
        Basis
        Signs
    end
    methods
        function obj=MV(val, signature)
            if nargin==0
                obj.Basis={};
                obj.Lsignature=[];
                obj.matrix=[];
                obj.vec=[];
                obj.Signs=[];
            end
            if nargin==2
                [Basis,Stamp,Msigns,Signs]=MV.structuredef(signature);
                obj.Lsignature=signature;
                n=sum(signature);
                m=length(val);
                if 2^n==m
                    obj.vec=val;
                    obj.Signs=Signs;
                    z=((Stamp)==0);
                    obj.matrix=Msigns.*val(Stamp+z);%m;
                    obj.matrix(z)=0;
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
                r.Signs=obj.Signs;
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
                    obj1=MV();
                    obj1.Basis=obj2.Basis;
                    obj1.Lsignature=obj2.Lsignature;
                    obj1.vec=v;
                    obj1.Signs=obj2.Signs;
                    obj1.matrix=obj1.get_matrix_repr();
                    %obj1=MV(v,obj2.Lsignature);
                end
                if class(obj2)=="double" || class(obj2)=="sym"
                    v=obj1.vec*0;
                    v(1)=obj2;
                    obj2=MV();
                    obj2.Basis=obj1.Basis;
                    obj2.Lsignature=obj1.Lsignature;
                    obj2.vec=v;
                    obj2.Signs=obj1.Signs;
                    obj2.matrix=obj2.get_matrix_repr();

                    %obj2=MV(v,obj1.Lsignature);
                end
                if obj1.Lsignature==obj2.Lsignature
                    r=MV();
                    r.Basis=obj1.Basis;
                    r.Lsignature=obj1.Lsignature;
                    r.vec=obj1.vec+obj2.vec;
                    r.Signs=obj1.Signs;
                    r.matrix=r.get_matrix_repr();
                    %r=MV(obj1.vec+obj2.vec,obj1.Lsignature);
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
                if class(obj1)=="double" || class(obj1)=="sym"
                    v=obj2.vec*0;
                    v(1)=obj1;
                    obj1=MV();
                    obj1.Basis=obj2.Basis;
                    obj1.Lsignature=obj2.Lsignature;
                    obj1.vec=v;
                    obj1.Signs=obj2.Signs;
                    obj1.matrix=obj1.get_matrix_repr();
                    %obj1=MV(v,obj2.Lsignature);
                end
                if class(obj2)=="double" || class(obj2)=="sym"
                    v=obj1.vec*0;
                    v(1)=obj2;
                    obj2=MV();
                    obj2.Basis=obj1.Basis;
                    obj2.Lsignature=obj1.Lsignature;
                    obj2.vec=v;
                    obj2.Signs=obj1.Signs;
                    obj2.matrix=obj2.get_matrix_repr();

                    %obj2=MV(v,obj1.Lsignature);
                end
                if obj1.Lsignature==obj2.Lsignature
                    r=MV();
                    r.Basis=obj1.Basis;
                    r.Lsignature=obj1.Lsignature;
                    r.vec=obj1.vec-obj2.vec;
                    r.Signs=obj1.Signs;
                    r.matrix=r.get_matrix_repr();
                    %r=MV(obj1.vec+obj2.vec,obj1.Lsignature);
                else
                    error("Objects comming from different algebras cannot be added")
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
                r.Signs=obj.Signs;
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

                        r=MV();
                        r.Basis=obj1.Basis;
                        r.Lsignature=obj2.Lsignature;
                        %sim
                        r.vec=(matrix(:,1)).';
                        r.Signs=obj1.Signs;
                        %sim
                        r.matrix=(matrix);

                        %r=MV(simplify(matrix(:,1)).',obj1.Lsignature);
                    else
                        error("Signatures don't agree in the product")
                    end
                end
                %MV-num, num-MV
                if (class(obj1)=="MV" && (class(obj2)=="double"||class(obj2)=="sym"))
                    r=MV();
                    r.vec=obj1.vec*obj2;
                    r.Basis=obj1.Basis;
                    r.Signs=obj1.Signs;
                    r.Lsignature=obj1.Lsignature;
                    r.matrix=obj1.matrix*obj2;
                end
                if (class(obj2)=="MV" && (class(obj1)=="double"||class(obj1)=="sym"))
                    r=MV();
                    r.vec=obj2.vec*obj1;
                    r.Basis=obj2.Basis;
                    r.Signs=obj2.Signs;
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
                                p.Signs=obj1(1,1).Signs;
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
        end
        %------------------------------------------------------------------------------------------------
        function r=apply(obj,f)
            F=sym(f);
            p=funm(obj.matrix,F);
            %TODO This should be made in a different way, MV() and set all vaues
            r=MV(simplify(p(:,1)).',obj.Lsignature);
        end
        %-------------------------------------------------------------------------------------------------
        function r=str(obj1)
            r="";
            for k=1:length(obj1.vec)
                if obj1.vec(k)~=0
                    if class(obj1.vec(k))=="double"
                        r=r+"+("+obj1.vec(k)+")e"+strrep(obj1.Basis{k},",","");
                    else
                        r=r+"+("+char(obj1.vec(k))+")<strong>e"+strrep(obj1.Basis{k}+"</strong>",",","");
                    end
                end
            end
            if r==""
                r=" 0 ";
            end
            r=extractAfter(r,1);
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
                            r=r+"+( "+obj1.vec(k)+" )<strong>e"+strrep(obj1.Basis{k}+"</strong>",",","");
                        else
                            r=r+"+( "+char(obj1.vec(k))+" )<strong>e"+strrep(obj1.Basis{k}+"</strong>",",","");
                        end
                    end

                end

                if r==""
                    r=" 0 ";
                end
                r=extractAfter(r,1);
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
        %-------------------------------------------------------------------------------------------------
        function asCGA(obj1)
            [f,c]=size(obj1);
            if f==1 && c==1
                r="";
                nv=obj1.vec;
                %Tenemos que separar n0 y ni y pornerlos al principio y al
                %final
                %extracción de coeficientes

                SS=obj1.Lsignature;
                sz=sum(SS);
                syms a [1 sz-2] real
                syms a0
                syms n0 ni
                eval("a"+num2str(sz-1)+"= -1*n0+1/2*ni;");
                eval("a"+num2str(sz)+"= 1*n0+1/2*ni;");
                expresion=0;
                for k=1:2^sz
                    elemento=strrep("a"+obj1.Basis{k},",","*a");
                    expresion=expresion+obj1.vec(k)*eval(elemento);
                end
                
                for k=2:5
                expresion=subs(expand(expresion),n0^k,0);
                expresion=subs(expand(expresion),ni^k,0);
                end
                expresion=strrep(strrep(strrep(char(expand(expresion)),"*",""),"n0","<strong>n0</strong>"),"ni","<strong>ni</strong>");

                for k=0:sz
                    expresion=strrep(expresion,"a"+num2str(k),"<strong>e"+num2str(k)+"</strong>");
                end





                fprintf(expresion+"\n");
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
        function r=exp(self)
            if class(self)~="MV"
                error("When asking for exponential the parameter must be a multivector")
            else
                [f,c]=size(self);
                if f*c==1
                    intermediate=expm(self.matrix);
                    r=MV(intermediate(:,1).',self.Lsignature);
                else
                    %Super matrix exponential... not sure of this operation

                    SUPER_MATRIX=to_SUPER_MATRIX(self);

                    SUPER_EXP=expm(SUPER_MATRIX);
                    %construimos la matriz resultante
                    r=from_SUPER_MATRIX(self,SUPER_EXP);
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
        %--------------------------------------------------------------
        %--------------------------------------------------------------
        function r=subs(self,varargin)
            SM=self.to_SUPER_MATRIX();
            %%varargin

            if nargin==3
                SUPER_EXP=subs(SM,varargin{1},varargin{2});
                r=from_SUPER_MATRIX(self,SUPER_EXP);
            elseif nargin==1
                SUPER_EXP=subs(SM);
                r=from_SUPER_MATRIX(self,SUPER_EXP);
            end

        end
        %--------------------------------------------------------------

        function r=maininvolution(self)
            K=sum(self.Lsignature);
            vec=self.vec*0;
            for j=0:K
                el=self.grade(j)*(-1)^j;
                vec=vec+el.vec;
            end
            r=MV(vec,self.Lsignature);
        end
        %--------------------------------------------------------------

        function r=reverse(self)
            K=sum(self.Lsignature);
            vec=self.vec*0;
            for j=0:K
                el=self.grade(j)*(-1)^(j*(j-1)/2);
                vec=vec+el.vec;
            end
            r=MV(vec,self.Lsignature);

        end
        %--------------------------------------------------------------

        function r=conj(self)
            K=sum(self.Lsignature);
            vec=self.vec*0;
            for j=0:K
                el=self.grade(j)*(-1)^(j*(j+1)/2);
                vec=vec+el.vec;
            end
            r=MV(vec,self.Lsignature);

        end
        %--------------------------------------------------------------

        function r=grade(self,k)
            n=sum(self.Lsignature);
            if k>n
                error("There is no such a grade in this MV");
                return
            end
            PPP=MV.Blades(self.Lsignature);
            K=self.matrix.*PPP{k+1};
            K=K(:,1).';
            r=MV(K,self.Lsignature);
        end
        %--------------------------------------------------------------
        function r=power(obj1,obj2)
            %Outer product implementation
            if obj1.Lsignature==obj2.Lsignature
                n=sum(obj1.Lsignature);
                B=MV.Blades(obj1.Lsignature);
                M1=obj1.matrix;
                M2=obj2.matrix;
                M=M1*0;
                for i=0:n
                    for j=0:n
                        M=M+(M1.*B{i+1})*(M2.*B{j+1}).*B{i+j+1};
                    end
                end
                v=M(:,1).';
                r=MV(v,obj1.Lsignature);
            else
                error("Multivectors must belong to the same algebra ")
            end

        end 
        %--------------------------------------------------------------
        function r=times(obj1,obj2)
            %Outer product implementation
            if obj1.Lsignature==obj2.Lsignature
                n=sum(obj1.Lsignature);
                B=MV.Blades(obj1.Lsignature);
                M1=obj1.matrix;
                M2=obj2.matrix;
                M=M1*0;
                for i=0:n
                    for j=0:n
                        M=M+(M1.*B{i+1})*(M2.*B{j+1}).*B{abs(i-j)+1};
                    end
                end
                v=M(:,1).';
                r=MV(v,obj1.Lsignature);
            else
                error("Multivectors must belong to the same algebra ")
            end

        end 
        function r=dual(self)
            [stamp,sign]=self.dualizer(self.Lsignature);
            r=MV(self.vec(stamp).*sign,self.Lsignature);
        end
    end
    methods (Access = private)
        function r=copy(self)
            r=MV();
            r.Basis=self.Basis;
            r.Lsignature=self.Lsignature;
            r.vec=self.vec;
            r.matrix=self.matrix;
            r.Signs=self.Signs;
        end
        function mx=get_matrix_repr(self)
            [Basis,Stamp,Msigns,Signs]=MV.structuredef(self.Lsignature);
            val=self.vec;
            z=(Stamp==0);
            mx=Msigns.*val(Stamp+z);
            mx(z)=0;
        end
        function submatriz = Submatrix(matriz, fila, columna)
            submatriz = matriz;
            submatriz(fila, :) = [];
            submatriz(:, columna) = [];
        end
        function r=to_SUPER_MATRIX(self)
            [filas,columnas]=size(self);
            dimension=2^sum(self(1,1).Lsignature);
            SUPER_MATRIX=sym(zeros(filas*dimension,columnas*dimension));
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
    methods (Static=true)
        function [Basis,Stamp,Msigns,Signs]=structuredef(sig)
            persistent stamps;
            persistent signatures;
            persistent basis;
            persistent msigns;
            persistent signs;
            if isempty (signatures)
                stamps{10,10,10}=0;
                signatures{10,10,10}=0;
                basis{10,10,10}=0;
                msigns{10,10,10}=0;
                signs{10,10,10}=0;
            end
            % So, this is just a way to speed up repetitive
            % computations in my code

            if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
                signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
                % do all stuf
                signature=sig;
                n=sum(signature);
                val=1:2^n;
                m=length(val);
                if 2^n==m
                    vec=val;
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
                    Signs=S;
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
                    matrix={};%cell(zeros(Basis_count,Basis_count));
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
                            if strlength(final_element)==0
                                final_element="0";
                            end
                            destination=find([Basis{:}] == final_element);
                            matrix{destination,column}=signo*val(row);
                        end
                    end
                    matrix=cell2sym(matrix);
                    %matrix=m
                    % end stuff
                end
                stamps{sig(1)+1,sig(2)+1,sig(3)+1}=abs(double(matrix));
                signatures{sig(1)+1,sig(2)+1,sig(3)+1}=sig;
                basis{sig(1)+1,sig(2)+1,sig(3)+1}=Basis;
                msigns{sig(1)+1,sig(2)+1,sig(3)+1}=sign(matrix);
                signs{sig(1)+1,sig(2)+1,sig(3)+1}=Signs;
            end
            Stamp= stamps{sig(1)+1,sig(2)+1,sig(3)+1};
            Basis=basis{sig(1)+1,sig(2)+1,sig(3)+1};
            Msigns=msigns{sig(1)+1,sig(2)+1,sig(3)+1};
            Signs=signs{sig(1)+1,sig(2)+1,sig(3)+1};

        end
        function [stamp,sign]=dualizer(sig)
            persistent stamps
            persistent signatures
            persistent signs
            if isempty(stamps)
                stamps{10,10,10}=0;
                signatures{10,10,10}=0;
                signs{10,10,10}=0;
            end
            if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
                % Lets compute stamps, just reverse the vector
                n=sum(sig);
                dim=2^n;
                v=dim:-1:1;
                stamps{sig(1)+1,sig(2)+1,sig(3)+1}=v;

                %lets compute the signs, to do so just multipy by
                %pseudoscalar in a full positive equivalent basis
                ss=zeros(1,2^n);
                ps=zeros(1,2^n);
                ps(end)=1;
                ps=MV(ps,[n,0,0]);
                for i=1:2^n
                    z=zeros(1,2^n);
                    zz=zeros(1,2^n);
                    z(i)=1;
                    zz(end-i+1)=1;
                    elemento1=MV(z,sig);
                    elemento2=MV(zz,sig);
                    res=elemento1*elemento2;
                    ss(i)=sum(res.vec);
                end
                signs{sig(1)+1,sig(2)+1,sig(3)+1}=ss;
            end
            
            stamp=stamps{sig(1)+1,sig(2)+1,sig(3)+1};
            sign=signs{sig(1)+1,sig(2)+1,sig(3)+1};

        end
        function B=Blades(sig)
            persistent signatures
            persistent blades
            if isempty (signatures)
                blades{10,10,10}=0;
                signatures{10,10,10}=0;
            end
            if isempty(signatures{sig(1)+1,sig(2)+1,sig(3)+1})
                
                % So the blades structure must be buid
                n=sum(sig);
                A=pascal(n+1,1);
                sizes=abs(A(end,:));
                Ssizes=cumsum(sizes);
                v=zeros(1,2^n);
                v(1)=1;
                [Basis,stamp,Msigns,Signs]=MV.structuredef(sig);
                b=v(stamp);
                blades{sig(1)+1,sig(2)+1,sig(3)+1}{1}=b;
                for k=2:length(sizes)
                    v=zeros(1,2^n);
                    v(Ssizes(k-1)+1:Ssizes(k))=1;
                    b=v(stamp);
                    blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=b;
                end
                for k=(n+2):2*(n+1)
                    blades{sig(1)+1,sig(2)+1,sig(3)+1}{k}=stamp*0;
                end
                signatures{sig(1)+1,sig(2)+1,sig(3)+1}=1;
            end
            B=blades{sig(1)+1,sig(2)+1,sig(3)+1};

        end
    end
end