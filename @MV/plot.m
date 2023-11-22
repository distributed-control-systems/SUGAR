function  plot(self)
% Plotting property for CGA
%Choose the plotting algebra
    if self.Lsignature==[3,1,0]
        % Call the right function
        cgaplot2(self);
    elseif self.Lsignature==[4,1,0]
        % Call the right function
        cgaplot3(self);
    else
        % Right now we are unable to plot any other conformalization
        error("The plot function is just implemented for CGA objects")
    end
end

