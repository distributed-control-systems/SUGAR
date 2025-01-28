function  plot(self)


% PLOT - Plots the multivector in the appropriate conformal geometric algebra (CGA) representation.
%
% Syntax:
%   plot(self)
%
% Description:
%   This function selects the appropriate plotting function based on the
%   signature of the conformal geometric algebra (CGA) of the multivector.
%   It currently supports two specific CGA representations: CGA4 (3,1,0) and CGA5 (4,1,0).
%   If the multivector's signature matches one of these, the corresponding plot function
%   is called. If the signature does not match any of the supported CGA signatures,
%   an error is thrown.
%
% Input:
%   self - (MV) The multivector object to be plotted.
%
% Example:
%  CGA(2,"verbose")
% % Generate three points with a random component
% off=1*rand*e1+1*rand*e2;
% p1=push(e1+off);
% p2=push(e2+off);
% p3=push(-e1+off);
%
% point=p1;
% dipole=point.^p2;
% circle=dipole.^p3;
% flat_point=p1.^ni;
% line=p1.^p2.^ni;
%
% %
% clc
% point
% point.plot()
% point.info()
% %
% point.dual
% point.dual.plot()
% point.dual.info()
% %
% dipole
% dipole.plot()
% dipole.info()
%
% %
% dipole.dual
% dipole.dual.plot()
% dipole.dual.info()
% %
% circle
% circle.plot()
% circle.info()
% %
% circle.dual
% circle.dual.plot()
% circle.dual.info()
%   plot(mv);  % Calls cgaplot2 for CGA representation
%
% Notes:
%   - This function currently supports plotting for CGA4 (2D) and CGA5 (3D) only.
%   - For unsupported signatures, an error will be raised.
%
% See also:
%   cgaplot2, cgaplot3


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


