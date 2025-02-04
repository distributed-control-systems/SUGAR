# How Are Multivectors Represented in Sugar?

In Sugar, **multivectors (MV)** are internally represented as **matrices**. This means that when you add two multivectors, Sugar is actually performing matrix addition. Similarly, when you apply a function to a multivector, a known formula is applied to its corresponding matrix. This approach ensures that multivector operations remain consistent and efficient while leveraging MATLAB’s built-in matrix computation capabilities.

## Why Use Matrices?

The primary reason for using matrices is efficiency. Since MATLAB is optimized for matrix computations, this representation enables us to perform calculations much more effectively. Rather than designing a separate computational framework for multivectors, Sugar takes advantage of MATLAB’s strengths, ensuring highly efficient and reliable operations.

Moreover, the matrices used in Sugar (with specific structural signs) belong to the space $\mathbb{R}^{2^{(p+q+r)}\times 2^{(p+q+r)}}$, which is **isomorphic** to the Clifford algebra **𝒞𝐿(p, q, r)** over the real numbers. In simpler terms, we can perform all operations on multivectors using matrix algebra while preserving their geometric properties. This is crucial, as geometric algebra relies on specific transformations and structures that must be maintained for accurate mathematical modeling.

Additionally, this approach allows us to leverage **symbolic computation** when necessary. When working with **symbolic multivectors**, Sugar ensures that matrix representations align with symbolic algebraic structures, allowing for analytical solutions and algebraic simplifications without numerical approximation errors.

## How Can You View the Matrix Representation?

By default, the underlying matrix representation is hidden as it is managed internally. However, if you're curious, you can explicitly request it. The following example demonstrates how:

```matlab
>> GA([2 0 0]) % Create an algebra with 2 positive basis elements
>> a = e1 + e2 + 10*e12; % Define a multivector
>> a.matrix % Display the matrix representation of the multivector

ans =

     0     1     1   -10
     1     0    10    -1
     1   -10     0     1
    10    -1     1     0
```

Each coefficient of the multivector corresponds to a specific location in the matrix. This structured approach ensures that all multivector operations can be efficiently performed using standard **matrix arithmetic**.

## Why Is This Useful?

Since MATLAB is fundamentally designed for **matrix computations**, this approach enables engineers to seamlessly integrate geometric algebra into their workflows. Sugar is built to help engineers and researchers **understand and apply** geometric algebra efficiently, and what better way to do so than by leveraging MATLAB’s powerful matrix operations?

By structuring multivectors in this way, we achieve several advantages:

- **Speed:** Matrix operations are highly optimized in MATLAB, enabling rapid computations even for complex algebraic structures.
- **Simplicity:** Users can work with multivectors without needing to understand the underlying matrix representation—unless they explicitly choose to.
- **Flexibility:** The same framework supports numerical and symbolic computations, making it applicable to both theoretical research and practical engineering problems.
- **Scalability:** Since multivectors in higher dimensions involve larger computational structures, the matrix representation scales efficiently without excessive performance overhead.

## Constructing a Specific Algebra Representation

If you're curious about constructing a specific algebra representation, you can use the following simple code:

```matlab
>> GA([0 1 0]) % The algebra of complex numbers
>> a = GAsym('a') % Create a fully symbolic multivector

a = 

( a0 )*e0 + ( a1 )*e1

>> a.matrix
 
ans =
 
[a0, -a1]
[a1,  a0]
```

While this representation may not be unique, having a single consistent representation allows us to perform computations reliably.

I encourage you to explore the representations for **dual numbers [0,0,1]** and **quaternions [0,2,0]**.

## How Sugar Handles Multivector Operations

Sugar represents information on-screen and executes operations internally using matrix representations. The following example illustrates how operations are performed:

```matlab
>> GA([0 1 0])
>> a = GAsym('a')

a = 

( a0 )*e0 + ( a1 )*e1

>> b = GAsym('b')

b = 

( b0 )*e0 + ( b1 )*e1

>> c = a * b

c = 

( a0*b0 - a1*b1 )*e0 + ( a0*b1 + a1*b0 )*e1

>> a.matrix * b.matrix
 
ans =
 
[a0*b0 - a1*b1, - a0*b1 - a1*b0]
[a0*b1 + a1*b0,   a0*b0 - a1*b1]

>> c.matrix
 
ans =
 
[a0*b0 - a1*b1, - a0*b1 - a1*b0]
[a0*b1 + a1*b0,   a0*b0 - a1*b1]
```

As you can see, the results are identical. Internally, Sugar stores the **matrix representation** and uses it to perform fundamental operations such as **addition, subtraction, and geometric algebra multiplication**. When an inverse is required, it is the matrix that gets inverted.

## Advanced Operations

In Sugar, general functions applied to multivectors are internally executed using the matrix representation, and then the first column is extracted to visualize the result.

### Inner and Outer Products

The **inner and outer products** of multivectors are computed using explicit formulas rather than the matrix representation. In these cases, Sugar directly utilizes the vector form instead of the matrix form.

## Recovering Multivector Components from Matrix Representation

To retrieve the **multivector components**, simply extract the first column of the matrix representation.

## Constructing a Matrix Representation from a Multivector Description

Among various possible matrix representations, Sugar adopts a straightforward approach: stacking transformed rows of the multivector into a matrix. Here's an example:

```matlab
>> GA([2 1 0]) % Two positive bases, one negative
>> e0.BasisNames

ans =

  1×8 cell array

    {["e0"]}    {["e1"]}    {["e2"]}    {["e3"]}    {["e12"]}    {["e13"]}    {["e23"]}    {["e123"]}
```

Since the algebra contains **8 basis elements**, we define a multivector:

```matlab
>> A = e0 + 2*e1 - e2 + 5*e3 + e123

A = 

( 1 )*e0 + ( 2 )*e1 + ( -1 )*e2 + ( 5 )*e3 + ( 1 )*e123
```

The matrix is constructed by multiplying `A` with each basis element:

```matlab
>> M = [
     vector(A)
     vector(A*e1)
     vector(A*e2)
     vector(A*e3)
     vector(A*e12)
     vector(A*e13)
     vector(A*e23)
     vector(A*e123)
]

>> M = M'
```

Finally, Sugar **transposes the matrix** to match internal storage conventions.

## Special Representations

Certain algebras, such as **conformalized algebras**, require a special basis transformation. While internally Sugar operates using the standard basis, results displayed on-screen undergo a final transformation to ensure correct interpretation.

This ensures that computations align with the expected algebraic structure while maintaining internal consistency.

---

With this matrix-based approach, Sugar efficiently handles geometric algebra computations while ensuring compatibility with MATLAB’s matrix operations. Enjoy exploring multivectors with Sugar!