function basis(sig,options)
% BASIS  Deprecated function for Geometric Algebra initialization.
%
%   BASIS(SIG) calls GA(SIG) to initialize the Geometric Algebra ℝ{SIG}.
%   BASIS(SIG, OPTIONS) forwards the input arguments to GA().
%
%   This function is maintained for backward compatibility. 
%   Use GA() or CGA() instead.
%
% See also GA, CGA
    warning("basis() is deprecated, use GA() instead\n ")
    if nargin==1
        GA(sig)
    else
        GA(sig,options)
    end
end