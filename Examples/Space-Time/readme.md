# Geometric Algebra (1,3,0) and Spacetime in Relativity

Geometric Algebra (GA) is a powerful mathematical framework that extends traditional vector algebra to handle rotations, reflections, and other transformations in a unified way. The notation **(1,3,0)** refers to the signature of the algebra used in describing the spacetime of special relativity, specifically **Minkowski spacetime**.

## Signature (1,3,0)
In this signature:
- The **1** corresponds to one time dimension, which contibutes with positive sign to the metric.
- The **3** represents the three spatial dimensions, which are treated differently from time due to the minus sign in the signature.
- The **0** means there are no degenerate dimensions.

Thus, the (1,3,0) algebra can model **Minkowski spacetime**, which is the foundation for Einstein's theory of Special Relativity.

In order to generate such algebra in sugar you just call the funtion GA with the right signature

```matlab
>> GA([1 3 0])
````
and you get the required basis vectors in order to operate in the algebra.

### Events in sapce-time
In special relativity, events are described by **spacetime vectors** (also called 4-vectors). These 4-vectors are naturally represented using geometric algebra.

```matlab
>> syms x y z t real
>> event=t*e1+x*e2+y*e3+z*e4

event = 

( t )*e1+( x )*e2+( y )*e3+( z )*e4
```


### Metric and Inner Product
In this algebra, the inner product between two vectors depends on whether they are time or space components. If **x** is a vector in this space, the metric is defined as:

\[
x \cdot x = t^2 - x_1^2 - x_2^2 - x_3^2
\]

Where:
- \(t\) is the time component.
- \(x_1, x_2, x_3\) are the spatial components.

This reflects the idea that time is treated differently from space, which is crucial for the Lorentz transformations of special relativity.

In Sugar, the way to operate such an example is to declare symbolic position and time and the inner product reveals naturally

```matlab
>> syms x y z t real
>> event=t*e1+x*e2+y*e3+z*e4

event = 

( t )*e1+( x )*e2+( y )*e3+( z )*e4
>> event.*event

ans = 

( t^2 - x^2 - y^2 - z^2 )*e0
```
### Example: Lorentz Transformation in MATLAB

The file `Lorentz.m` demonstrates how to apply **Lorentz transformations** using Geometric Algebra in a coordinate-free manner. The code models two scenarios:

1. **Simultaneous Lightning Strikes**:
    - In this example, two lightning strikes occur simultaneously at different locations (a tree at the origin and a pole 20 km away) in the Earth's reference frame at \( t = 10 \, \mu s \).
    - The code calculates the time at which these events are observed by a rocket moving at 0.5 times the speed of light (\( 0.5c \)) in the positive x-direction.
    - The Lorentz transformation is applied to convert the events from the Earth's frame to the rocket's frame.
    - The expected result shows that, in the rocket’s frame, the lightning strikes do not occur at the same time, illustrating the **relativity of simultaneity**.

2. **Observer Moving at 0.5c**:
    - This second example examines how a static event at coordinates (1,1,0,0) is seen by an observer traveling at \( 0.5c \).
    - Using the Lorentz transformation, the code computes the time and position of the event as observed in the moving frame.

The transformation is handled using rotors, which simplify the calculation of Lorentz boosts in Geometric Algebra. The code leverages **MATLAB** to perform these operations and provides expected outputs that reflect the relativistic nature of spacetime.

#### Key Features of the Script:
- **Space-time units**: The calculations use light-seconds as the unit for both time and space.
- **Lorentz Transformation**: The transformation is applied using a rotor defined as `exp(atanh(rocket_speed)*0.5*e12)`, which boosts the events to the rocket’s frame.


