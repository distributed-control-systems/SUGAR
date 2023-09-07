# SUGAR
Wellcome to sugar lib, sugar stands for **Slow** and **Ugly** Geometric Algebra Routines, so, you are advised.

SUGAR was created to fulfill my personal requirements for symbolic geometric algebra computations, which may not align with your specific needs. If you require additional functionality that is not currently implemented, I encourage you to implement it yourself. Please avoid burdening me with your specific requirements, as I am uninterested and unwilling to invest any of my time in solving your problems, so, you are advised. If, for any reason, you implement new functionality to the library, I encourage you to publish them, as I have done for you. 
 
I provide this introduction to ensure transparency about the library's capabilities. My intention is to present the information in an unbiased manner, allowing you to make an informed decision about whether it aligns with your requirements. We kindly ask you to read the accompanying documentation to evaluate if the library is suitable for your specific needs.

# Basic functions

In the following section, we will outline the fundamental operations within the sugar environment.

## basis(), declare a set of basis with a given signature
This is useful for shorthand multi-vector creation, for instance:

	>>basis([1,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1

If we want to create a basis for complex numbers

	>>basis([0,1,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=-1

Or for instance, quaternion-based algebra

	>> basis([0,2,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=-1

## Declaring multi-vectors
There are two ways to declare a multi-vector, the first one is to provide the complete set of coefficients of the multi-vectors and the signature 

	>> MV([1 1 2 3],[2,0,0])

	ans = 
	
	 ( 1 )e0+( 1 )e1+( 2 )e2+( 3 )e12
	 
The second one is to use a shorthand notation after calling the basis function
	
	>> basis([2,0,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> 1+e1+2*e2+3*e12
	
	ans = 
	
	 ( 1 )e0+( 1 )e1+( 2 )e2+( 3 )e12
which turns out to be the same multi-vector as before.

Sugar also supports symbolic coefficients, which allows you to make generalized computations and to solve some parameter based problems. For instance :

	>>syms x
	>>x*e1
	ans = 	

	 ( x )*e1	

this is the corner stone that grants you the extraordinary abilities you may be searching for.

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
	
	 ( 1 )e0+( 1 )e1+( 1 )e2+( -1 )e12
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
	
	 ( 1 )e0+( 2 )e1+( 5 )e2+( 7 )e13
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
	
	 ( 1 )e0+( 2 )e1+( 5 )e2+( 7 )e13
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
In order to get a grade from a multivector you can use the "grade(k)" function, wich is in charge of extracting the grade k from the multivector

	>> basis([2,0,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	>> syms x0 x1 x2 x12
	>> a=x0+x1*e1+x2*e2+x12*e12
	
	a = 
	
	( x0 )e0+( x1 )e1+( x2 )e2+( x12 )e12
	>> a.grade(0)
	
	ans = 
	
	( x0 )e0
	>> a.grade(1)
	
	ans = 
	
	( x1 )e1+( x2 )e2
	>> a.grade(2)
	
	ans = 
	
	( x12 )e12


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
	
	 ( 7 )*e0+( 9 )*e1
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

The specific operations of inner (scalar) and outer (wedge) products may be done using the overloaded operators ".*" and ".^" (there is a dot in front of them, take care). Next example over quaternions may clarify it





Also, there is no general division ("/") operator, due to de fact that the "/" does not define the precedence of the operands. Whenever you need to perform divisions you should first retrieve the inverse of the divisor, and then, perform a standard geometric product. (even more **ugly**, isn't it?)

## Powers of multi-vectors to integer numbers

There are many ways in sugar to perform this operation (look into the section "functions of multi-vectors") , but the operator ^ is overloaded to perform powers of multi-vectors. Remember a^b performs $a^b$, is not a shorthand to exterior product. The nice thing is that it is easy to find multi-vector inverses. 

	>> basis([1,1,0])
	Declaring e0 as syntactic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
		 
	>> x=1+2*e1+3*e12
	
	x = 
	
	 ( 1 )e0+( 2 )e1+( 3 )e12
	
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/12 )*e0+( 1/6 )*e1+( 1/4 )*e12
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
	>> x=1+2*e1+3*e12. %This one works as expected
	
	x = 
	
	 ( 1 )e0 ( 2 )e1 ( 3 )e12
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/3 )*e0 ( 2/3 )*e1 ( 1 )*e12
	
	>> x=3*e2 % This one fails in this algebra
	
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
# Other functions

## Latex(multi-vector)
 
 In order to allow expresing a multi-vector in scientific documentation we provide a latex() finction that translates a matrix of multi-vectors or a multi-vector to latex notation.
 
 The usage is evident in next snippet
 
	 >> basis([1,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
	>> M=[e1 e1+e2; e2 e2-e1]
	
	M = 
	
	 (1)e1     (1)e1 (1)e2    
	 (1)e2     (-1)e1 (1)e2    
	>> latex(M)
	
	
	ans = 
	
	    "\left[\begin{array}{cc}\left(1\right)e_{1}  &  \left(1\right)e_{1}+\left(1\right)e_{2}  \\ \left(1\right)e_{2}  &  \left(-1\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]"


which should be interpreted by a latex engine as 

$\left[\begin{array}{cc}\left(1\right)e_{1}  &  \left(1\right)e_{1}+\left(1\right)e_{2}  \\ \left(1\right)e_{2}  &  \left(-1\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]$

This feature also works for symbolic coefficients

	>> syms a b c d
	>> basis([1,1,0])
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
	>> M=[e1*a e1+e2*(b+c); e2*c e2-e1*a]
	
	M = 
	
	 (a)*e1     (1)*e1 (b + c)*e2    
	 (c)*e2     (-a)*e1 (1)*e2    
	>> latex(M)
	
	ans = 
	
	    "\left[\begin{array}{cc}\left(a\right)e_{1}  &  \left(1\right)e_{1}+\left(b+c\right)e_{2}  \\ \left(c\right)e_{2}  &  \left(-a\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]"

which should be interpreted by a latex engine as 

$\left[\begin{array}{cc}\left(a\right)e_{1}  &  \left(1\right)e_{1}+\left(b+c\right)e_{2}  \\ \left(c\right)e_{2}  &  \left(-a\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]$