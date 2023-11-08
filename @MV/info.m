function r= info(self)
    if self.Lsignature==[3,1,0]
        r=get_info2(self);
    elseif self.Lsignature==[4,1,0]
        r=get_info3(self);
    else
        error("The info function is just implemented for CGA objects")
    end
end

