![alt "Image of the workspace after executing the GA([2,0,0]) command"](./images/sugar.svg "Image of the workspace after executing the GA([2,0,0]) command")

# SUGAR
Welcome to the SUGAR library! SUGAR stands for **Symbolic** and **User-friendly** Geometric Algebra Routines. This package is accompanied by a paper (doi of the preprint version at arXiv: [2403.16634](https://arxiv.org/abs/2403.16634))

Sugar is an open source engineer-friendly toolbox for Matlab licensed under the MIT License that allows computing with geometric algebras (GAs), and in particular, it supports symbolic computations, and both numeric and symbolic computations are available in high-dimensional GAs. SUGAR is specially targeted to be used in engineering applications. To this end, it is designed to represent geometric elements and transformations in 2D and 3D projective and conformal geometric algebras intuitively, aligning with computations commonly found in the literature. In addition, it handles numerical and symbolical functions of multivectors such as, for instance, the exponential, logarithm, sinus and cosinus functions, among others. These features make SUGAR suitable for various engineering fields, including robotics, control systems, and power electronics.

# Installation Guide

In order to add SUGAR to your Matlab distribution please follow these next steps:

1. **Obtaining the Repository:**
   
   You can clone or download the SUGAR repository to a location on your computer. This can be done via the command line or directly through GitHub's interface:

   - To clone using the command line, type the following command:
     ```
     $ git clone https://github.com/distributed-control-systems/SUGAR.git
     ```
   - Alternatively, you can download the repo using the dropdown menu from the green "Code" button on GitHub:

     ![Code menu](./images/drop_down.png "Dropdown menu located at the Code button")

	 And unzip the downloaded file to anywere on your computer.

2. **Adding SUGAR to Matlab:**
   
   **Method 1: GUI based**

   To integrate SUGAR into Matlab, add the downloaded folder with its subfolders to your Matlab path:
   
   - Open the Matlab home menu and click on "Set Path":

     ![Matlab Home menu](./images/matlab_home.png "Matlab home menu")

   - In the dialog that appears select "Add with Subfolders", navigate to the SUGAR folder you just downloaded and click on "Apply".
   	![Matlab Home menu](./images/path.png "Matlab home menu")

	**Method 2: command line based**
	In the Matlab command window type

		>> addpath(genpath('sugar_foldr_name'));
		>> savepath;
	
	where sugar_folder_name is the absolute path of the folder where you downloaded SUGAR.

Congratulations! You have successfully installed SUGAR in Matlab. To start using SUGAR and exploring its functionalities, proceed with the following sections of this guide.

Please note, this guide does not cover the basics of geometric algebra. For those interested in learning more about geometric algebra, we recommend visiting [The Bivector Website](https://bivector.net), which offers excellent resources for beginners.

# Basic functions

In the following section, we will outline the fundamental operations within the SUGAR environment.

## GA( [p,q,r] ), declare the set of basis elements spanning an algebra of signature (p,q,r)
This is useful for shorthand multivector creation. If the "verbose" option is provided, you will receive information about all the variables created in the MATLAB workspace. For instance:

	>> GA([1,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
		
	Declaring G0 for grade slicing as (1)e0 
	Declaring G1 for grade slicing as (1)e1

If we want to create a basis for complex numbers:

	>> GA([0,1,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	
	Declaring G0 for grade slicing as (1)e0 
	Declaring G1 for grade slicing as (1)e1 

Or, for instance, for quaternions:

	>> GA([0,2,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)e0 
	Declaring G1 for grade slicing as (1)e1+(1)e2 
	Declaring G2 for grade slicing as (1)e12 

Alternatively, you can call it without the "verbose" option, which initializes the algebra with no written text on its basis elements.

The command 'GA' creates a set of new variables that are declared in the workspace. Try this: clean up all variables and initialize a specific algebra to check which variables are created.

	>> clear all
	>> GA([2,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)e0 
	Declaring G1 for grade slicing as (1)e1+(1)e2 
	Declaring G2 for grade slicing as (1)e12 

Which results in a workspace containing thesse variables!

![alt "Image of the workspace after executing the GA([2,0,0]) command"](./images/workspace1.png "Image of the workspace after executing the GA([2,0,0]) command")

Once the algebra has been initialized, the new set of variables can be used in order to define multivectors. Let us inspect the created variables:

	>> e1

	e1 = 

	( 1 )e1
	>> e2

	e2 = 

	( 1 )e2
	>> e12

	e12 = 

	( 1 )e12

You can operate with these variables in different ways:

	>> e1*e2

	ans = 

	( 1 )*e12
	>> e2*e1

	ans = 

	( -1 )*e12
	>> e1+e2

	ans = 

	( 1 )*e1+( 1 )*e2
	>> e2+e12

	ans = 

	( 1 )*e2+( 1 )*e12
In addition, the algebra basic properties behave as expected:

	>> e1*e1

	ans = 

	( 1 )e0
	>> e2*e2

	ans = 

	( 1 )e0
	>> e12*e12

	ans = 

	( -1 )*e0 
Note that *e0* denotes the scalar part of a multivector, which in GA literature is simply represented by 1. If there is only the *e0* component, then the expression is a scalar of the field over which the algebra has been initialized (typically the field of real or complex numbers).

## Declaring multivectors
There are two ways to declare a multivector, the first one is to provide the complete set of coefficients of the multivector and the signature ([p,q,r]) of the algebra to which it belongs:

	>> MV([1 1 2 3],[2,0,0])

	ans = 
	
	 ( 1 )*e0+( 1 )*e1+( 2 )*e2+( 3 )*e12
This way of declaring multivectors is usefull in some cases, but it turns out to be dificult for hihg-dimensional algebras.	 
The second one is to use a shorthand notation after initializing the algebra and its basis elements:
	
	>> GA([2,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)*e0 
	Declaring G1 for grade slicing as (1)*e1+(1)*e2 
	Declaring G2 for grade slicing as (1)*e12 
	
	>> 1+e1+2*e2+3*e12

	ans = 

	( 1 )*e0+( 1 )*e1+( 2 )*e2+( 3 )*e12
which turns out to be the same multivector as before.

This multivector can be assigned to a variable into the workspace:

	>>A=1+e1+2*e2+3*e12

	A = 

	( 1 )*e0+( 1 )*e1+( 2 )*e2+( 3 )*e12

which can be used to perform computations.

SUGAR also supports multivectors with symbolic coefficients. For instance:

	>>syms x
	>>x*e1
	ans = 	

	 ( x )*e1	

## Multivector properties
The properties associated with a multivector are:

* The signature of the algebra to which it belongs.
* Its coefficients.
* Its matrix representation (with ortogonal basis vectors).
* The basis elements used in the multivector.

Let us show them with an example:

	>> GA([2,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)*e0 
	Declaring G1 for grade slicing as (1)*e1+(1)*e2 
	Declaring G2 for grade slicing as (1)*e12 
	
	>> a=1+e1+e2-e12 % Declare a simple multivector

	a = 

	( 1 )*e0+( 1 )*e1+( 1 )*e2+( -1 )*e12
	>> % Retrieve the signature of the algebra to which it belongs
	>> a.Lsignature

	ans =

		2     0     0

	>> % Retrieve the multivector coefficients as an array
	>> a.vector

	ans =

		1     1     1    -1

	>> % Retrieve the matrix representation of the multivector
	>> a.matrix

	ans =

		 1     1     1     1
		 1     1    -1    -1
		 1     1     1     1
		-1    -1     1     1

	>> a.BasisNames	% Retrieve the basis elements used in the multivector

	ans =

	1×4 cell array

		{["e0"]}    {["e1"]}    {["e2"]}    {["e12"]}

## Slicing, and recovering components of a multivector
SUGAR allows for a natural slicing of the multivector into its basis elements, but the indexing is vector-based and independent of the basis element's name (i.e., it only returns the coefficient of each basis element).

	>> syms x y z t real
	>> GA([2,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)*e0 
	Declaring G1 for grade slicing as (1)*e1+(1)*e2 
	Declaring G2 for grade slicing as (1)*e12 
	
	>> A=x*e0 + y*e1 + z*e2 + t*e12 % Declare a MV with symbolic coefficients 

	A = 

	( x )*e0+( y )*e1+( z )*e2+( t )*e12
	>> A(1)
	
	ans =
	
	x
	
	>> A(2)
	
	ans =
	
	y

Its possible to use the standard Matblab notation to retrieve the coefficients of a part of the multivector:

	>> A(1:2)
	
	ans =
	
	[x, y]
	
	>> A(2:4)
	
	ans =
	
	[y, z, t]

It is also possible to slice the multivector using the name of the basis elements:

	>> A(e1)
	
	ans =
	
	y
	
	>> A(e12)
	
	ans =
	
	t
But when using basis element names, requesting a range is not possible:

	>> A(e1:e12)
	Operator ':' is not supported for operands of type 'MV'.

But can be done using the following command (where the addition here plays the role of the logic command AND): 

	>> A(e1+e2+e12)
	
	ans =
	
	[y, z, t]

In case one wants to retrieve a part of the multivector (including its basis elements) instead of only its coefficients, the command is:

	>> A{1}

	ans = 

	( x )*e0
	>> A{2}

	ans = 

	( y )*e1
	>> A{1:2}

	ans = 

	( x )*e0+( y )*e1
	>> A{2:4}

	ans = 

	( y )*e1+( z )*e2+( t )*e12
	>> A{e1}

	ans = 

	( y )*e1
	>> A{e2}

	ans = 

	( z )*e2
	>> A{e1+e2}

	ans = 

	( y )*e1+( z )*e2

This feature allows one to retrieve any grade *k* element from a multivector, as they are variables stored in the workspace: 

	>> GA([2,0,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=1
	Declaring e12 such that e12·e12=-1
	
	Declaring G0 for grade slicing as (1)*e0 
	Declaring G1 for grade slicing as (1)*e1+(1)*e2 
	Declaring G2 for grade slicing as (1)*e12 

So, when retrieving grade k coefficients, one can use either method:

	>> A(G1)
	
	ans =
	
	[y, z]
	
	>> A{G1}

	ans = 

	( y )*e1+( z )*e2

In any case, there is a specific function to retrive the multivector components of a given grade, namely:

	>> A.grade(1)

	ans = 

	( y )*e1+( z )*e2

## Basic multivector operations

### Table of operators
| Name | Ascii | operator |
|:----------|:----------:|:----------:|
| Addition of A and B||A+B|
| Substrac B from A||A-B|
| Geometric product of A and B  |    | A*B   |
| Inner Product of A and B  |    | A.*B   |
| Outer Product of A and B  |    | A.^B   |
| Scalar power of A to k| | A^k|
| Vee of A and B| dual(A.dual*B.dual) | A&B|
| Dual of A| A.dual or dual(A)| |
| Reverse of A| A.reverse or reverse(A)| ~A|
| Conjugate of A| A.conjugate or conjugate(A)|A'|
| Inverse of A| inv(A)|A^-1|


### Basic multivector operations
Addition and subtraction operations are naturally defined for multivectors:

	>> GA([1,1,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=1
	Declaring e2 such that e2·e2=-1
	Declaring e12 such that e12·e12=1
	
	Declaring G0 for grade slicing as (1)*e0 
	Declaring G1 for grade slicing as (1)*e1+(1)*e2 
	Declaring G2 for grade slicing as (1)*e12 
	>> A=1+e1+e2+e12
	
	A = 
	
	 ( 1 )*e0 ( 1 )*e1 ( 1 )*e2 ( 1 )*e12
	>> B=-3*e12
	
	B = 
	
	 ( -3 )*e12
	>> A+B
	
	ans = 
	
	 ( 1 )*e0 ( 1 )*e1 ( 1 )*e2 ( -2 )*e12
	>> A-B
	
	ans = 
	
	 ( 1 )*e0 ( 1 )*e1 ( 1 )*e2 ( 4 )*e12


The most important operation over multivectors is the geometric product, which in SUGAR is denoted by "*".

For instance, to check that GA[0,1,0] is really the complex numbers, i.e., that the geometric product behaves just as the product between complex numbers, one can run:

	>> GA([0,1,0],"verbose")
	Declaring e0 as syntatic sugar, e0=1
	Declaring e1 such that e1·e1=-1
	
	Declaring G0 for grade slicing as (1)e0 
	Declaring G1 for grade slicing as (1)e1 
	
	>> C1=1+2*e1;
	>> C2=5-1*e1;
	>> C1*C2
	
	ans = 
	
	 ( 7 )*e0+( 9 )*e1
	>> 
Now, doing the same operation in complex notation results in:

	>> C1=1+2*1i;	
	>> C2=5-1*1i;
	>> C1*C2
	
	ans =
	
	       7        +    9i      
Since symbolic coefficients are supported, it is easy to retrieve the expression of the geometric product in this algebra:
	
	>>syms a b c d real
	>>GA([0,1,0])
	>>C1=e0*a+e1*b 

	C1 = 
	
	 ( a )*e0 ( b )*e1
	>> C2=e0*c+e1*d

	C2 = 
	
	 ( c )*e0 ( d )*e1
	>> C3=C1*C2
	
	C3 = 
	
	 ( a*c - b*d )*e0 ( a*d + b*c )*e1
	>> equations_of_product=C3([1,2])'
	
	equations_of_product =
	
	a*c - b*d
	a*d + b*c

which coincides with the product between complex numbers.

Inner (scalar) and outer (wedge) products are performed using the overloaded operators ‘.*’ and ‘.^’ (note the leading dot). The following example with quaternions illustrates their use:

First, the quaternion algebra is initialized:

	>> GA([0 2 0])


Now, two unitary quaternions are defined:

	>> A=sym(1/5)+sym(2/5)*e1+sym(2/5)*e2+sym(4/5)*e12

	A = 

	( 1/5 )e0+( 2/5 )e1+( 2/5 )e2+( 4/5 )e12
	>> B=sym(1/2)-sym(1/2)*e1+sym(1/2)*e2+sym(1/2)*e12

	B = 

	( 1/2 )e0+( -1/2 )e1+( 1/2 )e2+( 1/2 )e12


The inner product is computed as:

	>> A.*B

	ans = 

	( -3/10 )e0+( -1/10 )e1+( -3/10 )e2+( 1/2 )e12

while the outer product is computed as:

	>> A.^B

	ans = 

	( 1/10 )e0+( 1/10 )e1+( 3/10 )e2+( 9/10 )e12


In addition, one can compare the obtained results with [Ganja.js cheat sheet](https://observablehq.com/@enkimute/ganja-js-cheat-sheets). One diference relies on the fact that in SUGAR one can use symbolic cofficients.

There is no general division (’/’) operator, because ‘/’ does not define operand precedence. Whenever you need to perform divisions you should first retrieve the inverse of the divisor, and then, perform a standard geometric product. 

## Powers of multivectors raised to integer values

In SUGAR, there are several ways of performing power operations (e.g., using a function as explained in the Section "Functions of multivectors"). One of the most simple ways is via the overloaded operator ^, which performs powers of multivectors raised to integer values. Notice that a^b performs $a^b$, and it is not a shorthand of the outer or wedge product. A nice feature is that powers allows for an easy way of finding multivector inverses. 

	>> GA([1,1,0])
	>> x=1+2*e1+3*e12
	
	x = 
	
	 ( 1 )*e0+( 2 )*e1+( 3 )*e12
	
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/12 )*e0+( 1/6 )*e1+( 1/4 )*e12
	>> x*x_inv
	
	ans = 
	
	 ( 1 )*e0
	>> x_inv*x
	
	ans = 
	
	 ( 1 )*e0 

However, some multivectors do not have inverse. For instance:

	>> GA([1,0,1])
	>> x=1+2*e1+3*e12. %This one works as expected
	
	x = 
	
	 ( 1 )*e0 ( 2 )*e1 ( 3 )*e12
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( -1/3 )*e0 ( 2/3 )*e1 ( 1 )*e12
	
	>> x=3*e2 %This one fails as it has no inverse in this algebra
	
	x = 
	
	 ( 3 )*e2
	>> x_inv=x^-1
	
	x_inv = 
	
	 ( Inf )*e0

## Functions of multivectors

SUGAR provides a **comprehensive set of mathematical functions** for **multivectors (MV)**, supporting both **numeric and symbolic** computations. This enables users to apply familiar **trigonometric, exponential, logarithmic, and other mathematical operations** directly to multivectors, making complex algebraic manipulations straightforward.

### Basic functions for multivectors

SUGAR supports the following fundamental functions for **multivectors**:

- **Trigonometric Functions**: `sin`, `cos`, `tan`, `cot`, `sec`, `csc`
- **Hyperbolic Functions**: `sinh`, `cosh`, `tanh`, `coth`, `sech`, `csch`
- **Exponential and Logarithmic Functions**: `exp`, `log`
- **Power Functions**: `sqrt`, `^` (power operator)

Each of these functions is **fully overloaded** to operate on **multivectors** just as they would on standard MATLAB scalars or vectors.

## Applying functions to multivectors

#### Direct function calls
Many mathematical functions can be **directly applied** to multivectors:

	>> GA([2,0,0]);  % Define a geometric algebra
	>> A = e1 + e2;  % Declare a simple multivector
	>> B = sin(A);   % Compute the sine of A
	>> C = exp(A);   % Compute the exponential of A


These functions are **symbolically evaluated** whenever possible, but they can also be computed numerically when the multivector has numeric coefficients.

#### Custom function application: `apply()` method
For **more advanced function definitions**, SUGAR allows users to **apply custom functions** to each element of a multivector using the `apply()` method:

	>> syms x;
	>> GA([0,1,0]); % Define complex numbers algebra
	>> A = e1 * x;
	>> B = A.apply(@(x) exp(x))
	ans =
	( cos(x) )*e0 + ( sin(x) )*e1

This is particularly useful when working with **symbolic calculations**.

By using double lambda functions, customized functions on multivectors can be declared. Be sure to avoid shadowing standard Matlab functions. For instance:

	>> syms a b x y real
	>> GA([0,1,0])
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	
	>> expMV(2*e1)
	
	ans = 
	
	 ( cos(2) )*e0 ( sin(2) )*e1

Symbolic coefficients are also allowed:

	>> syms a b x y w t real
	>> expMV=@(y)y.apply(@(x)exp(x))
	
	expMV =
	
	  function_handle with value:
	
	    @(y)y.apply(@(x)exp(x))
	
	>> expMV(e1*w*t)
	
	ans = 
	
	 ( cos(t*w) )*e0 ( sin(t*w) )*e1

This is generally supported for any multivector with real or symbolic coefficients (though it tends to be slow).

## Matrices of multivectors
SUGAR allows one to create matrices where the components are multivectors. For instance:

	>> GA([1,1,0])
	>> M=[e1 e1+e2; e2 e2-e1]
	
	M = 
	
	 (1)*e1     (1)*e1  (1)*e2    
	 (1)*e2     (-1)*e1 (1)*e2   

One can perform operations with these matrices. For instance:

	>>M*M
	
	ans = 
	
	 (1)*e12     (-1)*e0 (3)*e12    
	 (-1)*e0 (-2)*e12     (-1)*e0 (-1)*e12  
And, in some cases, even matrix inversion:

	>> M2=M^-1
	
	M2 = 
	
	 (1/2)*e1 (1/2)*e2     (1/2)*e1 (-1/2)*e2    
	 (-1/2)*e2             (-1/2)*e1    
	>> M2*M
	
	ans = 
	
	 (1)*e0     0     
	 0      (1)*e0    
	>> M*M2
	
	ans = 
	
	 (1)*e0     0     
	 0      (1)*e0    

# Other functions

## Latex (multivector)
 
To enable multivector representation in scientific documentation, we provide a `latex()` function that converts a matrix of multivectors or a multivector into LaTeX notation.
 
The following example illustrates its usage:
 
	>> GA([1,1,0])
	>> M=[e1 e1+e2; e2 e2-e1]
	
	M = 
	
	 (1)*e1     (1)*e1 (1)*e2    
	 (1)*e2     (-1)e1 (1)*e2    
	>> latex(M)
	
	
	ans = 
	
	    "\left[\begin{array}{cc}\left(1\right)e_{1}  &  \left(1\right)e_{1}+\left(1\right)e_{2}  \\ \left(1\right)e_{2}  &  \left(-1\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]"


which should be interpreted by a LaTeX engine as:

$\left[\begin{array}{cc}\left(1\right)e_{1}  &  \left(1\right)e_{1}+\left(1\right)e_{2}  \\ \left(1\right)e_{2}  &  \left(-1\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]$

This feature also works for symbolic coefficients:

	>> syms a b c d
	>> GA([1,1,0])
	>> M=[e1*a e1+e2*(b+c); e2*c e2-e1*a]
	
	M = 
	
	 (a)*e1     (1)*e1 (b + c)*e2    
	 (c)*e2     (-a)*e1 (1)*e2    
	>> latex(M)
	
	ans = 
	
	    "\left[\begin{array}{cc}\left(a\right)e_{1}  &  \left(1\right)e_{1}+\left(b+c\right)e_{2}  \\ \left(c\right)e_{2}  &  \left(-a\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]"

which should be interpreted by a latex engine as:

$$\left[\begin{array}{cc}\left(a\right)e_{1}  &  \left(1\right)e_{1}+\left(b+c\right)e_{2}  \\ \left(c\right)e_{2}  &  \left(-a\right)e_{1}+\left(1\right)e_{2}  \\ \end{array}\right]$$

