# SUGAR
Wellcome to shugar lib, sugar stands for **Slow** and **Ugly** Geometric Algebra Routines, so, you are advised.

#Basic functions

## basis(), declare a set of basis with a given signature
This is usefull for shorthand multivector creation, for instance:

	>>basis([1,0,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1

If we want to create a basis for complex numbers

	>>basis([0,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1

## Declaring multivectors
There are two ways to declare a multivector, the first one is to provide the complete set of coefficients of the multivectors and the signature 

	>> MV([1 1 2 3],[2,0,0])

	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 2 )e2 ( 3 )e12
The second one is to use a shorthand notation after calling the basis function
	
	>> basis([2,0,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> 1+e1+2*e2+3*e12
	
	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 2 )e2 ( 3 )e12
which turns to be the same multivector as before.

Sugar also suports symbolic coefficients, but some care must be taken (the **ugly** part of sugar), For instance, we will face problems whenever a symbolic variable precedes a multivector basis:

	>>syms x
	>>x*e1
	Error using sym>tomupad
	Unable to convert 'MV' to 'sym'.
	
	Error in sym (line 397)
	                S.s = tomupad(x);
	
	Error in sym/privResolveArgs (line 1184)
	                    argout{k} = sym(arg);
	
	Error in sym/privBinaryOp (line 1216)
	            args = privResolveArgs(A, B);
	
	Error in  *  (line 497)
	        X = privBinaryOp(A, B, 'symobj::mtimes');
	
	Related documentation

but it is allowed to
	
	>>e1*x
	ans = 	

	 ( x )*e1	

which allows you to declare multivectors with symbolic coefficiens

## Multivector properties
The properties asociated with a multivector are:

* The signature
* The vector coeficients
* The matrix representation
* The basis related to the multivector

Lets show them by exemple

	>> basis([2,0,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> a=1+e1+e2-e12 %Declare a simple multivector
	
	a = 
	
	 ( 1 )e0 ( 1 )e1 ( 1 )e2 ( -1 )e12
	>>% Retrive the algebra signature to which it belongs
	>> a.Lsignature 
	
	ans =
	
	       2              0              0      
	        
	>>% Vector representation of the coefficients
	>> a.vec  	
	
	ans =
	
	       1              1              1             -1       
	
	>>% Matrix representation of the coeficients
	>> a.matrix	
	 
	ans =
	 
	[ 1,  1,  1,  1]
	[ 1,  1, -1, -1]
	[ 1,  1,  1,  1]
	[-1, -1,  1,  1]

	>> a.Basis 	%Set of basis of the vector's algebra
	
	ans =
	
	  1×4 cell array
	
	    {["0"]}    {["1"]}    {["2"]}    {["1,2"]}

## Blades, Grades and coefficients as multivectors
"element()" is a method in the multivector object that allows you to retrive any elemenent or sets of elements as a multivector

	>> basis([2,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e3 such that e3·e3=-1
	Declaring e12 such that e12·e12=-1
	Declaring e13 such that e13·e13=1
	Declaring e23 such that e23·e23=1
	Declaring e123 such that e123·e123=1
	>> a=1+2*e1+5*e2+7*e13
	
	a = 
	
	 ( 1 )e0 ( 2 )e1 ( 5 )e2 ( 7 )e13
	>> a.element(e0)
	
	ans = 
	
	 ( 1 )e0
	>> a.element(e13)
	
	ans = 
	
	 ( 7 )e13
	>> a.element(e12)
	
	ans = 
	
	 0 
	>> a.element(e0+e13)
	
	ans = 
	
	 ( 1 )e0 ( 7 )e13

## Blades, Grades and coefficients as arrays
Alternatively you may need the expressions as an array, to such end there is the function "coefficients()"

	>> basis([2,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e3 such that e3·e3=-1
	Declaring e12 such that e12·e12=-1
	Declaring e13 such that e13·e13=1
	Declaring e23 such that e23·e23=1
	Declaring e123 such that e123·e123=1
	>> a=1+2*e1+5*e2+7*e13
	
	a = 
	
	 ( 1 )e0 ( 2 )e1 ( 5 )e2 ( 7 )e13
	>> a.coefs(e0)
	
	ans =
	
	       1       
	
	>> a.coefs(e13)
	
	ans =
	
	       7       
	
	>> a.coefs(e12)
	
	ans =
	
	       0       
	
	>> a.coefs(e0+e13)
	
	ans =
	
	       1       
	       7       


## Basic multivector operations
Plus and Minus operations are allowed among multivectors

	>> basis([1,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
	>> A=1+e1+e2+e12
	
	A = 
	
	 ( 1 )e0 ( 1 )e1 ( 1 )e2 ( 1 )e12
	>> B=-3*e12
	
	B = 
	
	 ( -3 )e12
	>> A+B
	
	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 1 )e2 ( -2 )e12
	>> A-B
	
	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 1 )e2 ( 4 )e12


The most important operation over multivectors is the geometric product denoted by "*"

We can check that CL[0,1,0] is really the complex number system making a geometric product

	>>basis([0,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	
	>> C1=1+2*e1;
	>> C2=5-1*e1;
	>> C1*C2
	
	ans = 
	
	 ( 7 )*e0 ( 9 )*e1
	>> 
Doing the same operation in complex notation

	>> C1=1+2*1i;	
	>> C2=5-1*1i;
	>> C1*C2
	
	ans =
	
	       7        +    9i      
Due to the fact that symbolic coefficients are supported is easy to retrive the expression of the geometric product in this algebra, going back to the exemple on complex numbers:
	
	>>syms a b c d real
	>>basis([0,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	
	>>C1=e0*a+e1*b 

	C1 = 
	
	 ( a )*e0 ( b )*e1
	>> C2=e0*c+e1*d

	C2 = 
	
	 ( c )*e0 ( d )*e1
	>> C3=C1*C2
	
	C3 = 
	
	 ( a*c - b*d )*e0 ( a*d + b*c )*e1
	>> equations_of_product=C3.coefs(e0+e1)
	 
	equations_of_product =
	 
	a*c - b*d
	a*d + b*c

On the other hand (the **ugly** part of sugar), there is no (yet) inner or exterior product declaration, you need to do them using the geometric product and elements() operation

Also, there is no general divission ("/") operator, due to de fact that the "/" does not define the precedence of the operands. Whenever you need to perform divissions you should first retrive the inverse of the divisor, and the perform a standard geometric product. (even more **ugly**, isn't it?)

## Powers of multivectors to integer numbers

There are many ways in shugar to perform this operation (look into the section "functions of multivectors") , but the operator ^os overloaded to perform powers of multivectors. Remeber a^b performs $a^b$, is not a shorthand to exterior product. The nice thing is that it is easy to find multivector inverses. (**This section is still under development**)

	>> basis([1,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
		 
	>> x=1+2*e1+3*e12
	
	x = 
	
	 ( 1 )e0 ( 2 )e1 ( 3 )e12
	
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/12 )*e0 ( 1/6 )*e1 ( 1/4 )*e12
	>> x*x_inv
	
	ans = 
	
	 ( 1 )*e0
	>> x_inv*x
	
	ans = 
	
	 ( 1 )*e0 

But, as you should know, you may encounter multivectors that don't have inverse, for instance:

	>> basis([1,0,1])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=0
	Declaring e12 such that e12·e12=0
	>> x=1+2*e1+3*e12
	
	x = 
	
	 ( 1 )e0 ( 2 )e1 ( 3 )e12
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/3 )*e0 ( 2/3 )*e1 ( 1 )*e12
	>> x=1+2*e1+3*e2
	
	x = 
	
	 ( 1 )e0 ( 2 )e1 ( 3 )e2
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/3 )*e0 ( 2/3 )*e1 ( 1 )*e2
	>> x=1+3*e2
	
	x = 
	
	 ( 1 )e0 ( 3 )e2
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( 1 )*e0 ( -3 )*e2
	>> x=3*e2
	
	x = 
	
	 ( 3 )e2
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( Inf )*e0

There are other cases where this situation may reproduce. Specially on algebras or multivectors with negative basis.

## Powers of multivectors to multivectors

Look into next section 


## Functions of multivectors
Sugar allows you to compute (the **slow** part of sugar) a function of a multivector. The way to do it is to use the method "apply()" which gets as agrument a lambda function. For instance, using the well-known algebra CL([0,1,0]) for the complex numbers, lets copmpute the exponential of a function:


	>> syms a b x y real
	>> basis([0,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	>> y=e1*b
	
	y = 
	
	 ( b )*e1
	>> y.apply(@(x)exp(x))
	
	ans = 
	
	 ( cos(b) )*e0 ( sin(b) )*e1


But in CL([1,0,0]) the same operation turns out to be

	>> basis([1,0,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	>> y=e1*b
	
	y = 
	
	 ( b )*e1
	>> y.apply(@(x)exp(x))
	
	ans = 
	
	 ( cosh(b) )*e0 ( sinh(b) )*e1

General functions on multivectors are allowed, but the expressions may becom really nasty.

Using double lambda functions we can declare our oun functions on multivectors, take care to avoid shading standard matlab functions. For instance:

	>> syms a b x y real
	>> basis([0,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	
	>> expMV(2*e1)
	
	ans = 
	
	 ( cos(2) )*e0 ( sin(2) )*e1

Symbolic coeficients are also allowed

	>> syms a b x y w t real
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	>> expMV(e1*w*t)
	
	ans = 
	
	 ( cos(t*w) )*e0 ( sin(t*w) )*e1

This is in general supported on any multivector with real or symbolic coefficients (but uses to be **slow**)

## Matrices of multivectors
Sugar allows you to create matrices where the components are multivectors (Do no use mixed components).

For instance:

	>> basis([1,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
	>> M=[e1 e1+e2; e2 e2-e1]
	
	M = 
	
	 (1)e1     (1)e1 (1)e2    
	 (1)e2     (-1)e1 (1)e2   

And then, (matrix) multiplication

	>>M*M
	
	ans = 
	
	 (1)*e12     (-1)*e0 (3)*e12    
	 (-1)*e0 (-2)*e12     (-1)*e0 (-1)*e12  
And, in some cases (this is still under development), matrix inverssion

	>> M2=M^-1
	
	M2 = 
	
	 (1/2)*e1 (1/2)*e2     (1/2)*e1 (-1/2)*e2    
	 (-1/2)*e2     (-1/2)*e1    
	>> M2*M
	
	ans = 
	
	 (1)*e0     0     
	 0      (1)*e0    
	>> M*M2
	
	ans = 
	
	 (1)*e0     0     
	 0      (1)*e0    

We still miss the operation of matrix functions over matrices of multivectors...  