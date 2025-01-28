function r= info(self)


% INFO - Retrieves information about the multivector object.
%
% Syntax:
%   r = info(self)
%
% Description:
%   This function is specific to conformal geometric algebra (CGA) and
%   retrieves detailed information about the multivector object based on
%   its signature. It is currently implemented for specific signatures
%   corresponding to CGA4 and CGA5.
%
% Input:
%   self - (MV) The multivector object for which information is to be
%           retrieved.
%
% Output:
%   r - (various) The information retrieved from the multivector object,
%       returned in a format defined by the respective information
%       retrieval functions.
%
% Example:
%   mv = MV([1, 2, 3], [3, 1, 0]);
%   info_data = info(mv);  % Retrieves information about the multivector
%
% Note:
%   The function checks the signature of the multivector and calls the
%   appropriate information retrieval function based on the specific
%   conformal algebra.


    % Specific CGA function to recover object infomation
    if self.Lsignature==[3,1,0]
        r=get_info2(self);
    elseif self.Lsignature==[4,1,0]
        r=get_info3(self);
    else
        error("The info function is just implemented for CGA4 and CGA5 objects")
    end
end


