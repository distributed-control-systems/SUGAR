function r= info(self)
    % Specific CGA function to recover object infomation
    try
    if self.Lsignature==[3,1,0]
        r=get_info2(self);
    elseif self.Lsignature==[4,1,0]
        r=get_info3(self);
    else
        error("The info function is just implemented for CGA4 and CGA5 objects")
    end
    catch
        error("The info function is just implemented for CGA4 and CGA5 objects")
    end
end

