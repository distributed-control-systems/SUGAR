classdef (InferiorClasses = {?sym}) MV


% This class provides functionality to create, manipulate, and perform operations on multivectors
% in the context of geometric (Clifford) algebra.
%
% Properties:
%   REPR          - (string) Representation identifier for the multivector.
%   Lsignature    - Signature of the geometric algebra, defining the structure of the multivector.
%   matrix        - Matrix representation of the multivector in the algebra.
%   Signs         - Sign information relevant to the multivector structure.
%   Basis         - Basis elements of the algebra, private access.
%   vec           - Vector representation of the multivector, private access.
%
% Methods:
%   MV            - Constructor for initializing an MV object based on input values and algebra signature.
%   laplace       - Computes the Laplace transform of the multivector.
%   ilaplace      - Computes the inverse Laplace transform.
%   abs, log, sin, cos, etc. - Various trigonometric and hyperbolic functions applied to the multivector.
%   clean, collect, conj - Functions for manipulating and simplifying the multivector.
%   inverse       - Computes the inverse of the multivector.
%   plot          - Visual representation of the multivector.
%   rand          - Generates a random multivector for a given signature.
%   CGA_matrix    - Generates the conformal geometric algebra matrix for a given signature.
%   structuredef  - Defines the algebraic structure based on the provided signature.
%   LogLevel      - Sets or retrieves the log level for debugging or output control.
%   allow_multivaluated_functions - Enables or disables multi-valuated functions.


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
                    if class(signature)=='double'
                        n=sum(signature);
                        nn=2^n;
                    elseif class(signature)=='string'
                        nn=size(signature,1);
                    else
                        error('Unreconized signature style');
                    end
                    m=length(val);
                    if nn==m
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
        r=laplace(self,varargin)
        r=ilaplace(self,varargin)

        r= abs(self)
        r= log(self)
        r=sin(self)
        r=asin(self)
        r=sinh(self)
        r=asinh(self)
        r=cos(self)
        r=acos(self)
        r=cosh(self)
        r=acosh(self)
        r=tan(self)
        r=atan(self)
        r=tanh(self)
        r=atanh(self)
        r=cot(self)
        r=acot(self)
        r=coth(self)
        r=acoth(self)
        r=csc(self)
        r=acsc(self)
        r=csch(self)
        r=acsch(self)
        r=sec(self)
        r=asec(self)
        r=sech(self)
        r=asech(self)
        r= not(self)
        r=sqrt(obj1)
        r= and(obj1,obj2)
        r= apply(obj,f)
        asCGA(obj)
        r= clean(self)
        r= collect(self)
        r= conj(self)
        r=tangent(self,k)
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
        rp= parametrize(r,ff)

       
    end
    methods(Static=true,Hidden=true)

        r=reveal()

        r= outer(obj1,obj2)

    r=outer_product_0_0_0(a,b)
r=outer_product_0_0_1(a,b)
r=outer_product_0_0_2(a,b)
r=outer_product_0_0_3(a,b)
r=outer_product_0_0_4(a,b)
r=outer_product_0_0_5(a,b)
r=outer_product_0_0_6(a,b)
r=outer_product_0_1_0(a,b)
r=outer_product_0_1_1(a,b)
r=outer_product_0_1_2(a,b)
r=outer_product_0_1_3(a,b)
r=outer_product_0_1_4(a,b)
r=outer_product_0_1_5(a,b)
r=outer_product_0_2_0(a,b)
r=outer_product_0_2_1(a,b)
r=outer_product_0_2_2(a,b)
r=outer_product_0_2_3(a,b)
r=outer_product_0_2_4(a,b)
r=outer_product_0_3_0(a,b)
r=outer_product_0_3_1(a,b)
r=outer_product_0_3_2(a,b)
r=outer_product_0_3_3(a,b)
r=outer_product_0_4_0(a,b)
r=outer_product_0_4_1(a,b)
r=outer_product_0_4_2(a,b)
r=outer_product_0_5_0(a,b)
r=outer_product_0_5_1(a,b)
r=outer_product_0_6_0(a,b)
r=outer_product_1_0_0(a,b)
r=outer_product_1_0_1(a,b)
r=outer_product_1_0_2(a,b)
r=outer_product_1_0_3(a,b)
r=outer_product_1_0_4(a,b)
r=outer_product_1_0_5(a,b)
r=outer_product_1_1_0(a,b)
r=outer_product_1_1_1(a,b)
r=outer_product_1_1_2(a,b)
r=outer_product_1_1_3(a,b)
r=outer_product_1_1_4(a,b)
r=outer_product_1_2_0(a,b)
r=outer_product_1_2_1(a,b)
r=outer_product_1_2_2(a,b)
r=outer_product_1_2_3(a,b)
r=outer_product_1_3_0(a,b)
r=outer_product_1_3_1(a,b)
r=outer_product_1_3_2(a,b)
r=outer_product_1_4_0(a,b)
r=outer_product_1_4_1(a,b)
r=outer_product_1_5_0(a,b)
r=outer_product_2_0_0(a,b)
r=outer_product_2_0_1(a,b)
r=outer_product_2_0_2(a,b)
r=outer_product_2_0_3(a,b)
r=outer_product_2_0_4(a,b)
r=outer_product_2_1_0(a,b)
r=outer_product_2_1_1(a,b)
r=outer_product_2_1_2(a,b)
r=outer_product_2_1_3(a,b)
r=outer_product_2_2_0(a,b)
r=outer_product_2_2_1(a,b)
r=outer_product_2_2_2(a,b)
r=outer_product_2_3_0(a,b)
r=outer_product_2_3_1(a,b)
r=outer_product_2_4_0(a,b)
r=outer_product_3_0_0(a,b)
r=outer_product_3_0_1(a,b)
r=outer_product_3_0_2(a,b)
r=outer_product_3_0_3(a,b)
r=outer_product_3_1_0(a,b)
r=outer_product_3_1_1(a,b)
r=outer_product_3_1_2(a,b)
r=outer_product_3_2_0(a,b)
r=outer_product_3_2_1(a,b)
r=outer_product_3_3_0(a,b)
r=outer_product_4_0_0(a,b)
r=outer_product_4_0_1(a,b)
r=outer_product_4_0_2(a,b)
r=outer_product_4_1_0(a,b)
r=outer_product_4_1_1(a,b)
r=outer_product_4_2_0(a,b)
r=outer_product_5_0_0(a,b)
r=outer_product_5_0_1(a,b)
r=outer_product_5_1_0(a,b)
r=outer_product_6_0_0(a,b)

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
         if isempty(level)
             level=0;
         end
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
    
    
    function out = allow_multivaluated_functions(data)
         persistent allow;
         if isempty(allow)
             allow=0;
         end
         if nargin
            if class(data)=="double" 
                if data==0 | data ==1
                allow = data;
                else
                    error("This is a true/false parameter, use 0 for false and 1 for true when setting it")
                end
            else
                error("This is a true/false parameter, use 0 for false and 1 for true when setting it")
            end
         end
         out = allow;
    end

function r=rand(signature)
            r=MV(rand(1,2^sum(signature)),signature);

        end

        [M,new_basis_names]= CGA_matrix(sig)
        [basis,stamp,msigns,signs]= structuredef(sig)
        [stamp,sign]= dualizer(sig)
        b= Blades(sig)
        
        f= precoded_inner_product_function(n)
        f= precoded_outer_product_function(n)
        
        structure= full_algebra_basis_coefs(sig)

    end
end

