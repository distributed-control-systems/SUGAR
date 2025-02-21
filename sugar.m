% SUGAR - Symbolic and User-friendly Geometric Algebra Routines
% Version 1.0.0
% 
% Sugar is an open-source, engineer-friendly toolbox for MATLAB that allows
% computing with geometric algebras (GAs). It supports symbolic and numeric
% computations, with special emphasis on applications in engineering fields 
% such as robotics, control systems, and power electronics.
% 
% Installation:
%   1. Clone or download the repository from:
%      https://github.com/distributed-control-systems/SUGAR.git
%   2. Add the folder (with subfolders) to the MATLAB path:
%      >> addpath(genpath('path_to_sugar'));
%      >> savepath;
%
% Basic Functions:
%   GA([p, q, r])      - Declare a basis with the given algebra signature.
%   GAsym('var')       - Create a symbolic multivector.
%   MV([coeffs], [sig])- Declare a multivector using explicit coefficients.
%
% Algebra Operations:
%   A * B             - Geometric product of two multivectors.
%   A .* B            - Inner product of two multivectors.
%   A .^ B            - Outer product (wedge product).
%   A + B, A - B      - Addition and subtraction.
%   inv(A)            - Compute the inverse of a multivector.
%   A.grade(k)        - Extract the k-grade part of A.
%
% Multivector Properties:
%   A.vector          - Retrieve the coefficients of the multivector.
%   A.matrix          - Get the matrix representation.
%   A.Lsignature      - Returns the signature of the algebra.
%   A.BasisNames      - Returns the basis names of the algebra.
%
% Advanced Functions:
%   sin(A), cos(A)    - Compute trigonometric functions of a multivector.
%   exp(A), log(A)    - Exponential and logarithm of a multivector.
%   dual(A)           - Compute the dual of a multivector.
%   A.reverse         - Reverse of a multivector.
%   A.conjugate       - Clifford conjugation.
%
% Matrix Operations:
%   M = [A, B; C, D]  - Construct a matrix of multivectors.
%   M * N             - Matrix multiplication of multivectors.
%   inv(M)            - Compute the inverse of a multivector matrix.
%
% Display and Export:
%   latex(A)          - Convert a multivector to LaTeX format.
%   disp(A)           - Display multivector information.
%
% For more information on a specific function, use:
%   >> help sugar.function_name
%
%
% Authors: Manel Velasco, Isiah Zaplana, Arnau Dória-Cerezo and Pau Martí
% Organization: Universitat Politècnica de Catalunya
% Date: 04/02/2025
