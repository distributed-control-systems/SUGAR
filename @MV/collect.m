function r= collect(self,arg2)


% COLLECT - Overloads the collect function for multivectors.
%
% Syntax:
%   r = collect(self)
%   r = collect(self, arg2)
%
% Description:
%   This function provides an overloaded implementation of the collect
%   method for multivectors (MV). It allows for the collection of terms
%   within a multivector, optionally using a second argument for additional
%   processing.
%
% Input:
%   self - (MV) The multivector object on which to perform the collection.
%   arg2 - (optional) Additional argument for the collect function, if needed.
%
% Output:
%   r - (MV) The result of the collection operation applied to the multivector.
%
% Example:
%   mv = MV([1, 2, 3], [1, 1, 0]);
%   collected_mv = collect(mv);
%   disp(collected_mv); % Displays the collected multivector
%
% Note:
%   The function checks whether the object is indeed a multivector and handles
%   both single multivectors and matrices of multivectors accordingly.


    % Overload of collect function
    if class(self)~="MV"
        error("When asking for collect the object must be a multivector")
    else
        [f,c]=size(self);
        % Is it a matrix
        if f*c==1
            % Call the original collect
            if nargin==1
                r=MV(collect(self.vec),self.Lsignature);
            elseif nargin==2
                r=MV(collect(self.vec,arg2),self.Lsignature);
            end
        else
            %We have a matrix, lets go element by element
            for k=1:f
                for kk=1:c
                    if nargin==1
                        r(k,kk)=collect(self(k,kk));
                    elseif nargin==2
                        r(k,kk)=collect(self(k,kk),arg2);
                    end
                end
            end
        end

    end
end



