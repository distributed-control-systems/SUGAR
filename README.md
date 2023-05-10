# SUGAR
Wellcome to sugar lib, sugar stands for **Slow** and **Ugly** Geometric Algebra Routines, so, you are advised.

#Basic functions
Next we explain the basic operations in sugar environment

## basis(), declare a set of basis with a given signature
This is useful for shorthand multi-vector creation, for instance:

	>>basis([1,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1

If we want to create a basis for complex numbers

	>>basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=-1

## Declaring multi-vectors
There are two ways to declare a multi-vector, the first one is to provide the complete set of coefficients of the multi-vectors and the signature 

	>> MV([1 1 2 3],[2,0,0])

	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 2 )e2 ( 3 )e12
The second one is to use a shorthand notation after calling the basis function
	
	>> basis([2,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> 1+e1+2*e2+3*e12
	
	ans = 
	
	 ( 1 )e0 ( 1 )e1 ( 2 )e2 ( 3 )e12
which turns to be the same multi-vector as before.

Sugar also supports symbolic coefficients, but some care must be taken (the **ugly** part of sugar), For instance, we will face problems whenever a symbolic variable precedes a multi-vector basis:

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

which allows you to declare multi-vectors with symbolic coefficients

## Multi-vector properties
The properties associated with a multi-vector are:

* The signature
* The vector coefficients
* The matrix representation
* The basis related to the multi-vector

Lets show them by example

	>> basis([2,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> a=1+e1+e2-e12 %Declare a simple multivector
	
	a = 
	
	 ( 1 )e0 ( 1 )e1 ( 1 )e2 ( -1 )e12
	>>% Retrieve the algebra signature to which it belongs
	>> a.Lsignature 
	
	ans =
	
	       2              0              0      
	        
	>>% Vector representation of the coefficients
	>> a.vec  	
	
	ans =
	
	       1              1              1             -1       
	
	>>% Matrix representation of the coefficients
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

## Blades, Grades and coefficients as multi-vectors
"element()" is a method in the multi-vector object that allows you to retrieve any element or sets of elements as a multi-vector

	>> basis([2,1,0])
	Declaring e0 as syntactic sugar, e0=1
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
	Declaring e0 as syntactic sugar, e0=1
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


## Basic multi-vector operations
Plus and Minus operations are allowed among multi-vectors

	>> basis([1,1,0])
	Declaring e0 as syntactic sugar, e0=1
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


The most important operation over multi-vectors is the geometric product denoted by "*"

We can check that CL[0,1,0] is really the complex number system making a geometric product

	>>basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
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
Due to the fact that symbolic coefficients are supported is easy to retrieve the expression of the geometric product in this algebra, going back to the example on complex numbers:
	
	>>syms a b c d real
	>>basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
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

Also, there is no general division ("/") operator, due to de fact that the "/" does not define the precedence of the operands. Whenever you need to perform divisions you should first retrieve the inverse of the divisor, and the perform a standard geometric product. (even more **ugly**, isn't it?)

## Powers of multi-vectors to integer numbers

There are many ways in sugar to perform this operation (look into the section "functions of multi-vectors") , but the operator ^os overloaded to perform powers of multi-vectors. Remember a^b performs $a^b$, is not a shorthand to exterior product. The nice thing is that it is easy to find multi-vector inverses. (**This section is still under development**)

	>> basis([1,1,0])
	Declaring e0 as syntactic sugar, e0=1
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

But, as you should know, you may encounter multi vectors that don't have inverse, for instance:

	>> basis([1,0,1])
	Declaring e0 as syntactic sugar, e0=1
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

There are other cases where this situation may reproduce. Specially on algebras or multi vectors with negative basis.

## Powers of multi-vectors to multi-vectors

Look into next section 


## Functions of multi-vectors
Sugar allows you to compute (the **slow** part of sugar) a function of a multi-vector. The way to do it is to use the method "apply()" which gets as argument a lambda function. For instance, using the well-known algebra CL([0,1,0]) for the complex numbers, lets compute the exponential of a function:


	>> syms a b x y real
	>> basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	>> y=e1*b
	
	y = 
	
	 ( b )*e1
	>> y.apply(@(x)exp(x))
	
	ans = 
	
	 ( cos(b) )*e0 ( sin(b) )*e1


But in CL([1,0,0]) the same operation turns out to be

	>> basis([1,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1
	>> y=e1*b
	
	y = 
	
	 ( b )*e1
	>> y.apply(@(x)exp(x))
	
	ans = 
	
	 ( cosh(b) )*e0 ( sinh(b) )*e1

General functions on multi-vectors are allowed, but the expressions may become really nasty.

Using double lambda functions we can declare our own functions on multi-vectors, take care to avoid shading standard Matlab functions. For instance:

	>> syms a b x y real
	>> basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	
	>> expMV(2*e1)
	
	ans = 
	
	 ( cos(2) )*e0 ( sin(2) )*e1

Symbolic coefficients are also allowed

	>> syms a b x y w t real
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	>> expMV(e1*w*t)
	
	ans = 
	
	 ( cos(t*w) )*e0 ( sin(t*w) )*e1

This is in general supported on any multi-vector with real or symbolic coefficients (but uses to be **slow**)

## Matrices of multi-vectors
Sugar allows you to create matrices where the components are multi-vectors (Do no use mixed components).

For instance:

	>> basis([1,1,0])
	Declaring e0 as syntactic sugar, e0=1
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
And, in some cases (this is still under development), matrix inversion

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

We still miss the operation of matrix functions over matrices of multi-vectors...  