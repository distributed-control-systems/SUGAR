# CGA Basics Tutorial
*A step-by-step guide to Conformal Geometric Algebra (CGA) in MATLAB with SUGAR.*

---

## 1. Introduction to CGA in MATLAB
Conformal Geometric Algebra (CGA) provides an elegant mathematical framework for handling geometric transformations, intersections, and dual representations. This tutorial introduces the core functionalities using MATLAB.

To start using CGA in 2D or 3D, initialize the algebra with:

```matlab
CGA(2) % For 2D Conformal Geometric Algebra
CGA(3, "verbose") % For 3D CGA with detailed output
```

The `"verbose"` mode provides additional information about operations performed.

---

## 2. Constructing Basic Geometric Objects

### 2.1 Points and their CGA Representation
A point in Euclidean space `(a, b)` can be represented in CGA as:

```matlab
syms a b
P = a*e1 + b*e2; % Euclidean coordinates
P_CGA = n0 + P + (1/2) * P .* P * ni; % CGA representation
P_CGA = push(P); % Performs the same operation
```


- The **inner product** of a point with itself is always **zero**.
- The **dual representation** of a point can be obtained using:

```matlab
P_CGA_d = dual(P_CGA);
P_CGA_d = P_CGA.dual; % Performs the same operation
```

To **extract the Euclidean coordinates** from a CGA point:

```matlab
E = n0 .^ ni;
Ei = E^-1;
P_eucl = ((P_CGA * (-P_CGA .* ni)^-1) .^ E) * Ei;
P_eucl = pull(P_CGA); % Does the same in one step
```

---

### 2.2 Constructing and Plotting Geometric Entities
We can construct more complex objects using **outer products (`.^`)**:

| **Object**   | **Construction** |
|-------------|----------------|
| **Point**   | `P = push(P_eucliedean);` |
| **Dipole**  | `dipole = P .^ P2;` |
| **Circle**  | `circle = dipole .^ P3;` |
| **Sphere**  | `sphere = circle .^ P4;` |
| **Line**    | `line = P1 .^ P2 .^ ni;` |
| **Plane**   | `plane = P1 .^ P2 .^ P3 .^ ni;` |

To plot any geometric object:

```matlab
circle.plot(); % Plots the CGA representation of a circle
sphere.plot(); % Plots the sphere
```

To display additional information:

```matlab
circle.info();
```

---

## 3. Understanding Duality in CGA
CGA allows objects to be represented in two ways: **standard form** and **dual form**. The dual of any object can be computed using:

```matlab
dual_circle = circle.dual;
dual_circle.plot(); % Plot dual representation
dual_circle.info(); % Display details
```

---

## 4. Intersecting Objects

### 4.1 Intersecting Two Circles
To find the intersection between two circles:

```matlab
r = 2; % Circle radius
C1 = push(-1*e1 + 1*e2) - 1/2 * r^2 * ni; % Define first circle
C2 = push(1*e1) - 1/2 * r^2 * ni; % Define second circle

C1.plot();
hold on
C2.plot();

% Compute the intersection using the dual operator
DP = dual(normal(C1) .^ normal(C2));
DP.plot();
grid on
```

---

## 5. Transformations in CGA

### 5.1 Rotation
A point or object can be rotated by constructing a rotor:

```matlab
R = make_rotation(pi/4, e12); % Rotation by π/4 around e12 plane

% Apply rotation to a point
P_rotated = R.reverse * P * R;
```

### 5.2 Translation
Translation is performed similarly using a translator:

```matlab
T = make_translation(4, -e1); % Translate by 4 units along -e1
P_translated = T.reverse * P * T;
```

### 5.3 Dilation (Scaling)
Objects can be scaled using a dilation transformation:

```matlab
D = make_dilation(1.5); % Scale factor of 1.5
P_scaled = D.reverse * P * D;
```

### 5.4 Inversion
Inversion can be applied using a reference object, such as a circle:

```matlab
C = Circle(1, 1, 1.5); % Define a reference circle
I = make_inverssion(C); % Compute the inversion transformation

% Apply inversion to a point
P_inverted = C.reverse * P * C;
```

---

## 6. Animating Intersections
To animate a moving circle intersecting another:

```matlab
for off = 6:-0.1:-16
    p1c2 = push(5*e1 + off*e1);
    p2c2 = push(-e1 + off*e1);
    p3c2 = push(2*e1 + 2.5*e2 + off*e1);
    C2 = normalize(p1c2 .^ p2c2 .^ p3c2);

    hold off
    C1.plot();
    hold on
    C2.plot();

    % Compute and plot intersection
    intersection = (dual((dual(C1)) .^ (dual(C2))));
    intersection.plot();

    grid on
    xlim([-17, 6])
    ylim([-10, 8])
    drawnow();
end
```

---



## 8. References
- **Geometric Algebra for Physicists** – Chris Doran & Anthony Lasenby
- **Applications of Clifford Algebras in Engineering, Mathematics, and Physics**
