classdef info
    % INFO  Auxiliary class for storing and displaying information.
%
%   This class is designed to store text-based information and display it
%   when needed. It is particularly useful for keeping track of the active
%   geometric algebra in the workspace.
%
%   Usage:
%     obj = INFO(VAL) creates an instance of the INFO class with the
%     specified value `VAL` as its stored data.
%
%   Properties:
%     - `data`: A string containing the stored information.
%
%   Methods:
%     - `info(val)`: Constructor that initializes the stored data.
%     - `disp(obj)`: Displays the stored information in the command window.
%
%   Example:
%     algebra_info = info("Active algebra: CGA3");
%     disp(algebra_info);
%
%   Features:
%     - Simple and lightweight storage of text-based information.
%     - Easily integrates with other functions and classes.
%     - Provides a formatted display of the stored information.
%
% See also DISP
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
