function r = GAsym(name, sig)
% GAsym  Creates a symbolic multivector in a Geometric Algebra.
%
%   R = GAsym(NAME, SIG) generates a symbolic multivector using the basis
%   elements of a Geometric Algebra defined by the signature SIG. The 
%   symbolic coefficients are prefixed by NAME.
%
%   R = GAsYM(NAME) infers the signature from the existing algebra in the
%   workspace (assumed to be stored in `e0`).
%
%   Inputs:
%     - NAME: A string representing the prefix for symbolic variables.
%     - SIG : A vector defining the signature of the Geometric Algebra.
%
%   Output:
%     - R: A symbolic multivector constructed using the algebra basis.
%
%   Features:
%     - Uses `MV` to construct a multivector with symbolic coefficients.
%     - Generates basis names dynamically and assigns symbolic variables.
%     - Supports automatic signature detection from an existing algebra.
%
%   Example:
%     r = GAsym('a', [3,1,0]);  % Creates a symbolic multivector in ℝ{3,1,0}
%
% See also GA, MV
    if nargin==1
        e=evalin("caller","e0");
        sig=e.Lsignature;
    end

    b = MV(ones(1, 2^sum(sig)), sig);
    
    % Get the basis names from the multivector 'b'
    names = b.BasisNames;
    
    % Initialize a symbolic variable 'k' for the first element
    k = sym(name+ "0", 'real');  % Create a symbolic variable based on the name and append '0'
    
    % Multiply the first element of the multivector 'b' with the symbolic variable
    V = k * b{1};
    
    % Loop through the remaining basis names to construct the full symbolic expression
    for i = 2:length(names)
        n = names{i};  % Get the current basis name
        
        % Create a symbolic variable by stripping 'e' from the name and converting the rest to a symbol
        k = sym(name + strrep(n, 'e', ''));
        
        % Add the product of the symbolic variable and the corresponding element of 'b' to 'V'
        V = V + k * b{i};
    end
    
    % Return the final symbolic expression
    r = V;
end
