classdef info
    properties 
        data=""
    end
    methods        
        function obj=info(val)
            obj.data=val;
        end
        function disp(obj)
            fprintf(obj.data);
        end
    end
end
