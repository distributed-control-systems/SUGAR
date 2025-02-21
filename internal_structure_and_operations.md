# How are multivectors represented in SUGAR?

In SUGAR, **multivectors (MV)** are internally represented as **matrices**. This means that when one adds two multivectors, SUGAR is actually performing matrix addition. Similarly, when one applies a function to a multivector, a known formula is applied to its corresponding matrix representation. This approach ensures that multivector operations remain consistent and efficient while leveraging MATLAB’s built-in matrix computation capabilities.

## Why use matrices?

The primary reason for using matrices is efficiency. Since MATLAB is optimized for matrix computations, this representation enables us to perform calculations much more effectively. Rather than designing a separate computational framework for multivectors, SUGAR takes advantage of MATLAB’s strengths. 

Moreover, the matrices used in SUGAR (with specific structural signs) belong to the space $\mathbb{R}^{2^{(p+q+r)}\times 2^{(p+q+r)}}$, which is **isomorphic** to the Clifford algebra **𝒞𝐿(p, q, r)** over the real numbers. In simpler terms, one can perform all operations on multivectors using matrix algebra while preserving their geometric properties. 

Finally, this approach allows us to leverage **symbolic computations** when necessary. When working with **symbolic multivectors**, SUGAR ensures that matrix representations align with symbolic algebraic structures, allowing for analytical solutions and algebraic simplifications without numerical approximation errors.

## How can you view the matrix representation?

By default, the underlying matrix representation is hidden as it is managed internally. However, if you are curious, you can explicitly request it. The following example demonstrates how:

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

## Why is this useful?

Since MATLAB is fundamentally designed for **matrix computations**, this approach enables engineers to seamlessly integrate geometric algebra into their workflows. SUGAR is built to help engineers and researchers **understand and apply** geometric algebra efficiently, and what better way to do so than by leveraging MATLAB’s powerful matrix operations?

By structuring multivectors in this way, several advantages are achieved:

- **Speed:** Matrix operations are highly optimized in MATLAB, enabling rapid computations even for complex algebraic structures.
- **Simplicity:** Users can work with multivectors without needing to understand the underlying matrix representation—unless they explicitly choose to.
- **Flexibility:** The same framework supports numerical and symbolic computations, making it applicable to both theoretical research and practical engineering problems.
- **Scalability:** Since multivectors in higher dimensions involve larger computational structures, the matrix representation scales efficiently without excessive performance overhead.

## Constructing a specific algebra representation

If the user is curious about constructing a specific algebra representation, the following simple code can be used:

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

While this representation may not be unique, having a single consistent representation allows one to perform computations reliably.

The authors of SUGAR encourage anyone to explore the representations for **dual numbers [0,0,1]** and **quaternions [0,2,0]**.

## How SUGAR handles multivector operations

SUGAR represents information on-screen and executes operations internally using matrix representations. The following example illustrates how operations are performed:

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

Notice that the results are identical. Internally, SUGAR stores the **matrix representation** and uses it to perform fundamental operations such as **addition, subtraction, and geometric algebra multiplication**. When an inverse is required, it is the matrix representation the one that gets inverted.

## Advanced operations

In SUGAR, general functions applied to multivectors are internally executed using the matrix representation, and then the first column is extracted to visualize the result.

### Inner and outer products

The **inner and outer products** of multivectors are computed using explicit formulas rather than the matrix representation. In these cases, SUGAR directly utilizes the vector representation instead of the matrix representation.

## Recovering multivector components from the matrix representation

To retrieve the **multivector components**, SUGAR simply extracts the first column of the matrix representation.

## Constructing a matrix representation from a multivector

Among various possible matrix representations, SUGAR adopts a straightforward approach: stacking transformed rows of the multivector into a matrix. Here's an example:

```matlab
>> GA([2 1 0]) % Two positive bases, one negative
>> e0.BasisNames

ans =

  1×8 cell array

    {["e0"]}    {["e1"]}    {["e2"]}    {["e3"]}    {["e12"]}    {["e13"]}    {["e23"]}    {["e123"]}
```

Since the algebra contains **8 basis elements**, a multivector as the following one can be defined:

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

Finally, SUGAR **transposes the matrix** to match internal storage conventions.

## Special representations

Certain algebras, such as **conformalized algebras**, require a special basis transformation. While internally SUGAR operates using the standard basis, results displayed on-screen undergo a final transformation to ensure correct visualization and interpretation.

This ensures that computations align with the expected algebraic structure while maintaining internal consistency.

---

Enjoy exploring multivectors with SUGAR!
