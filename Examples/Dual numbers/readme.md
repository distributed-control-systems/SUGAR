
# Dual Numbers

**Dual numbers** are an extension of real numbers, useful in automatic differentiation and differential geometry. They are defined similarly to complex numbers, but with a key difference: instead of involving the imaginary unit `i`, they introduce a new element `ε` (epsilon), where `ε^2 = 0` but `ε ≠ 0`.

A dual number `z` can be written as:
```
z = a + bε
```
where `a` and `b` are real numbers, and `ε` is the infinitesimal unit, satisfying the property that `ε^2 = 0`.

## Arithmetic with Dual Numbers

### Addition
If you have two dual numbers:
```
z1 = a1 + b1ε
z2 = a2 + b2ε
```
The sum is straightforward:
```
z1 + z2 = (a1 + a2) + (b1 + b2)ε
```

### Multiplication
Multiplying dual numbers follows similar rules to multiplying binomials, but using the special property of `ε`:
```
z1 * z2 = (a1 + b1ε) * (a2 + b2ε)
       = a1a2 + (a1b2 + a2b1)ε + b1b2ε^2
       = a1a2 + (a1b2 + a2b1)ε  (since ε^2 = 0)
```

### Example
Let's take two dual numbers:
```
z1 = 3 + 2ε
z2 = 1 + 4ε
```
- **Addition**:  
  ```
  z1 + z2 = (3 + 1) + (2 + 4)ε = 4 + 6ε
  ```
- **Multiplication**:  
  ```
  z1 * z2 = (3 * 1) + (3 * 4 + 2 * 1)ε = 3 + (12 + 2)ε = 3 + 14ε
  ```

### Geometric Interpretation
Dual numbers are often used to represent infinitesimal translations or to compute derivatives. The dual part (`bε`) can represent the slope (derivative) of a function, and the real part (`a`) represents the function value.

For instance, if `f(x) = x^2`, then:
```
f(1 + ε) = (1 + ε)^2 = 1 + 2ε
```
Here, `1` is the function value at `x = 1`, and `2ε` gives the derivative at that point (`2x` at `x = 1`).


# Dual Numbers in sugar

In Sugar is quite easy to generate the structure of dual numbers, just call 
```matlab
GA([0 0 1])
```

This call creates an algebra with 0 positive basis, 0 negative basis and one degenerate basis, which is caled e1.

Now, in order to use it jast call to evaluate numérically any function, for instance
```matlab
>> sin(pi/2+e1)

ans = 

( 1 )*e0 +( 1 )*e1 
````
you retrive the value of the function at pi/2 and the value of the derivative of the function at that point.

Ypu can also use symbolic variables to do so. Next example illustrates this point:
```matlab
>> syms x real
>> sin(x+e1)

ans = 

( sin(x) )*e0+( cos(x) )*e1
````
In the file autodiff.m in this folder you will find some other examples.
