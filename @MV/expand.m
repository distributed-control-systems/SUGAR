function r= expand(self)


% EXPAND - Overloads the symbolic expand function for multivectors.
%
% Syntax:
%   r = expand(self)
%
% Description:
%   This function overloads the symbolic expand operation for multivectors.
%   It allows for the expansion of the components of the multivector, either
%   for a single multivector or for a matrix of multivectors.
%
% Input:
%   self - (MV) The multivector object to be expanded.
%
% Output:
%   r - (MV) The expanded multivector resulting from the operation.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   expanded_mv = expand(mv);  % Expands the multivector
%   disp(expanded_mv); % Displays the expanded multivector
%
% Note:
%   The function checks if the input is a multivector and handles both
%   single multivectors and matrices of multivectors accordingly.


    % Overload of the symbolic function expand
    if class(self)~="MV"
        error("When asking for expand the parameter must be a multivector")
    else
        [f,c]=size(self);
        % Is it a mtraix?
        if f*c==1
            % Just apply expand to each coeficient
            r=MV(expand(self.vec),self.Lsignature);
        else
            %Lets go element by element
            for k=1:f
                for kk=1:c
                    r(k,kk)=expand(self(k,kk));
                end
            end
        end

    end
end


