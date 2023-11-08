function r= plot(self)
    if self.Lsignature==[3,1,0]
        cgaplot2(self);
    elseif self.Lsignature==[4,1,0]
        cgaplot3(self);
    else
        error("The plot function is just implemented for CGA objects")
    end
end

