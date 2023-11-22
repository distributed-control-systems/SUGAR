classdef (InferiorClasses = {?sym}) MV
    properties 

        REPR=""
    end
    properties (GetAccess=public,SetAccess=private)
        Lsignature
        matrix
        Signs
    end
    properties (GetAccess=private,SetAccess=private)
        Basis
        vec
    end
    
    
    methods        
        function obj=MV(val, signature,representation)
                if nargin==0
                    obj.Basis={};
                    obj.Lsignature=[];
                    obj.matrix=[];
                    obj.vec=[];
                    obj.Signs=[];
                    obj.REPR="";
                end
                if nargin>1
                    [Basis,Stamp,Msigns,Signs]=MV.structuredef(signature);
                    if nargin==3
                        obj.REPR=representation;
                    else
                        obj.REPR="";
                    end
                    obj.Lsignature=signature;
                    n=sum(signature);
                    m=length(val);
                    if 2^n==m
                        if obj.REPR=="CGA"
                            [Matrix,Labels]=MV.CGA_matrix(signature);
                            vec=val*Matrix^-1;
                            obj.vec=vec;
                            obj.Signs=Signs;
                            z=((Stamp)==0);
                            obj.matrix=Msigns.*vec(Stamp+z);%m;
                            obj.matrix(z)=0;
                            obj.Basis=Basis;
                        else
                            obj.vec=val;
                            obj.Signs=Signs;
                            z=((Stamp)==0);
                            obj.matrix=Msigns.*val(Stamp+z);%m;
                            obj.matrix(z)=0;
                            obj.Basis=Basis;
                        end
                    else
                        error('The numer of elements of the vector do not match the Clifford algebra signature')
                    end
                end
            end
        r= abs(self)
        r= sin(self)
        r= cos(self)
        r= log(self)
        r=tan(self)
        r=sqrt(obj1)
        r= and(obj1,obj2)
        r= apply(obj,f)
        asCGA(obj)
        r= clean(self)
        r= collect(self)
        r= conj(self)
        determinante = det(self)
        disp(obj1)
        r= dual(self)
        r= eq(obj1,obj2)
        r= exp(self)
        r= expand(self)
        r= grade(self,k)
        r= info(self)
        inversa = inv(self)
        r= latex(obj1)
        r= latex_str(obj1)
        r= length(self)
        r= maininvolution(self)
        r= minus(obj1,obj2)
        r= mpower(obj,k)
        r= mtimes(obj1,obj2)
        r= normalize(self)
        n = numargumentsfromsubscript(obj,s,indexingcontext)
        inversa = pinv(self)
         plot(self)
        r= plus(obj1,obj2)
        r= power(obj1,obj2)
        r= reverse(self)
        r= simplify(self)
        r= str(obj1)
        r= subs(self,varargin)
        varargout= subsref(objs,subs)
        r= super(self)
        r= times(obj1,obj2)
        r= uminus(obj)
        v= vector(obj)
        r=mrdivide(A,B)
        r=ctranspose(obj)

    end
    methods (Access = private)
        submatriz = submatrix(matriz, fila, columna)
        r= from_SUPER_MATRIX(self,m)
        mx= get_matrix_repr(self)
        r= to_SUPER_MATRIX(self) 
        

       
    end
    methods(Static=true,Hidden=true)

        r= outter(obj1,obj2)

    r=outter_product_0_0_0(a,b)
r=outter_product_0_0_1(a,b)
r=outter_product_0_0_2(a,b)
r=outter_product_0_0_3(a,b)
r=outter_product_0_0_4(a,b)
r=outter_product_0_0_5(a,b)
r=outter_product_0_0_6(a,b)
r=outter_product_0_1_0(a,b)
r=outter_product_0_1_1(a,b)
r=outter_product_0_1_2(a,b)
r=outter_product_0_1_3(a,b)
r=outter_product_0_1_4(a,b)
r=outter_product_0_1_5(a,b)
r=outter_product_0_2_0(a,b)
r=outter_product_0_2_1(a,b)
r=outter_product_0_2_2(a,b)
r=outter_product_0_2_3(a,b)
r=outter_product_0_2_4(a,b)
r=outter_product_0_3_0(a,b)
r=outter_product_0_3_1(a,b)
r=outter_product_0_3_2(a,b)
r=outter_product_0_3_3(a,b)
r=outter_product_0_4_0(a,b)
r=outter_product_0_4_1(a,b)
r=outter_product_0_4_2(a,b)
r=outter_product_0_5_0(a,b)
r=outter_product_0_5_1(a,b)
r=outter_product_0_6_0(a,b)
r=outter_product_1_0_0(a,b)
r=outter_product_1_0_1(a,b)
r=outter_product_1_0_2(a,b)
r=outter_product_1_0_3(a,b)
r=outter_product_1_0_4(a,b)
r=outter_product_1_0_5(a,b)
r=outter_product_1_1_0(a,b)
r=outter_product_1_1_1(a,b)
r=outter_product_1_1_2(a,b)
r=outter_product_1_1_3(a,b)
r=outter_product_1_1_4(a,b)
r=outter_product_1_2_0(a,b)
r=outter_product_1_2_1(a,b)
r=outter_product_1_2_2(a,b)
r=outter_product_1_2_3(a,b)
r=outter_product_1_3_0(a,b)
r=outter_product_1_3_1(a,b)
r=outter_product_1_3_2(a,b)
r=outter_product_1_4_0(a,b)
r=outter_product_1_4_1(a,b)
r=outter_product_1_5_0(a,b)
r=outter_product_2_0_0(a,b)
r=outter_product_2_0_1(a,b)
r=outter_product_2_0_2(a,b)
r=outter_product_2_0_3(a,b)
r=outter_product_2_0_4(a,b)
r=outter_product_2_1_0(a,b)
r=outter_product_2_1_1(a,b)
r=outter_product_2_1_2(a,b)
r=outter_product_2_1_3(a,b)
r=outter_product_2_2_0(a,b)
r=outter_product_2_2_1(a,b)
r=outter_product_2_2_2(a,b)
r=outter_product_2_3_0(a,b)
r=outter_product_2_3_1(a,b)
r=outter_product_2_4_0(a,b)
r=outter_product_3_0_0(a,b)
r=outter_product_3_0_1(a,b)
r=outter_product_3_0_2(a,b)
r=outter_product_3_0_3(a,b)
r=outter_product_3_1_0(a,b)
r=outter_product_3_1_1(a,b)
r=outter_product_3_1_2(a,b)
r=outter_product_3_2_0(a,b)
r=outter_product_3_2_1(a,b)
r=outter_product_3_3_0(a,b)
r=outter_product_4_0_0(a,b)
r=outter_product_4_0_1(a,b)
r=outter_product_4_0_2(a,b)
r=outter_product_4_1_0(a,b)
r=outter_product_4_1_1(a,b)
r=outter_product_4_2_0(a,b)
r=outter_product_5_0_0(a,b)
r=outter_product_5_0_1(a,b)
r=outter_product_5_1_0(a,b)
r=outter_product_6_0_0(a,b)

r= inner(obj1,obj2)

r=inner_product_0_0_0(a,b)
r=inner_product_0_0_1(a,b)
r=inner_product_0_0_2(a,b)
r=inner_product_0_0_3(a,b)
r=inner_product_0_0_4(a,b)
r=inner_product_0_0_5(a,b)
r=inner_product_0_0_6(a,b)
r=inner_product_0_1_0(a,b)
r=inner_product_0_1_1(a,b)
r=inner_product_0_1_2(a,b)
r=inner_product_0_1_3(a,b)
r=inner_product_0_1_4(a,b)
r=inner_product_0_1_5(a,b)
r=inner_product_0_2_0(a,b)
r=inner_product_0_2_1(a,b)
r=inner_product_0_2_2(a,b)
r=inner_product_0_2_3(a,b)
r=inner_product_0_2_4(a,b)
r=inner_product_0_3_0(a,b)
r=inner_product_0_3_1(a,b)
r=inner_product_0_3_2(a,b)
r=inner_product_0_3_3(a,b)
r=inner_product_0_4_0(a,b)
r=inner_product_0_4_1(a,b)
r=inner_product_0_4_2(a,b)
r=inner_product_0_5_0(a,b)
r=inner_product_0_5_1(a,b)
r=inner_product_0_6_0(a,b)
r=inner_product_1_0_0(a,b)
r=inner_product_1_0_1(a,b)
r=inner_product_1_0_2(a,b)
r=inner_product_1_0_3(a,b)
r=inner_product_1_0_4(a,b)
r=inner_product_1_0_5(a,b)
r=inner_product_1_1_0(a,b)
r=inner_product_1_1_1(a,b)
r=inner_product_1_1_2(a,b)
r=inner_product_1_1_3(a,b)
r=inner_product_1_1_4(a,b)
r=inner_product_1_2_0(a,b)
r=inner_product_1_2_1(a,b)
r=inner_product_1_2_2(a,b)
r=inner_product_1_2_3(a,b)
r=inner_product_1_3_0(a,b)
r=inner_product_1_3_1(a,b)
r=inner_product_1_3_2(a,b)
r=inner_product_1_4_0(a,b)
r=inner_product_1_4_1(a,b)
r=inner_product_1_5_0(a,b)
r=inner_product_2_0_0(a,b)
r=inner_product_2_0_1(a,b)
r=inner_product_2_0_2(a,b)
r=inner_product_2_0_3(a,b)
r=inner_product_2_0_4(a,b)
r=inner_product_2_1_0(a,b)
r=inner_product_2_1_1(a,b)
r=inner_product_2_1_2(a,b)
r=inner_product_2_1_3(a,b)
r=inner_product_2_2_0(a,b)
r=inner_product_2_2_1(a,b)
r=inner_product_2_2_2(a,b)
r=inner_product_2_3_0(a,b)
r=inner_product_2_3_1(a,b)
r=inner_product_2_4_0(a,b)
r=inner_product_3_0_0(a,b)
r=inner_product_3_0_1(a,b)
r=inner_product_3_0_2(a,b)
r=inner_product_3_0_3(a,b)
r=inner_product_3_1_0(a,b)
r=inner_product_3_1_1(a,b)
r=inner_product_3_1_2(a,b)
r=inner_product_3_2_0(a,b)
r=inner_product_3_2_1(a,b)
r=inner_product_3_3_0(a,b)
 r=inner_product_4_0_0(a,b)
 r=inner_product_4_0_1(a,b)
 r=inner_product_4_0_2(a,b)
 r=inner_product_4_1_0(a,b)
 r=inner_product_4_1_1(a,b)
 r=inner_product_4_2_0(a,b)
 r=inner_product_5_0_0(a,b)
 r=inner_product_5_0_1(a,b)
 r=inner_product_5_1_0(a,b)
    r=inner_product_6_0_0(a,b)
 loger(text,level)
 

    end
    methods (Static=true)
    function out = LogLevel(data)
         persistent level;
         if nargin
            if class(data)=="double" 
                if data>=0 & data <4
                level = data;
                else
                    error("LogLevels are integer numbers from 0 to 3")
                end
            else
                error("LogLevels are integer numbers from 0 to 3")
            end
         end
         out = level;
      end
function r=rand(signature)
            r=MV(rand(1,2^sum(signature)),signature);

        end

        [M,new_basis_names]= CGA_matrix(sig)
        [basis,stamp,msigns,signs]= structuredef(sig)
        [stamp,sign]= dualizer(sig)
        b= Blades(sig)
        
        f= precoded_inner_product_function(n)
        f= precoded_outter_product_function(n)
        
        structure= full_algebra_basis_coefs(sig)

    end
end
