function r = GAsym(name, sig)
    % This function takes two input arguments:
    % name: a string that represents the base name for symbolic variables
    % sig: an array of integers used to define the structure or dimensions
    % The function constructs a symbolic expression based on a multivector
    % and returns the resulting expression as 'r'.
    
    % Initialize a multivector 'b' using the function MV 
    % The multivector is created with a dimension of 2^sum(sig) 
    % and 'sig' as additional parameters.
    b = MV(ones(1, 2^sum(sig)), sig);
    
    % Get the basis names from the multivector 'b'
    names = b.BasisNames;
    
    % Initialize a symbolic variable 'k' for the first element
    k = sym([name, '0']);  % Create a symbolic variable based on the name and append '0'
    
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
