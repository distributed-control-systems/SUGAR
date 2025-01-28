function loger(text,level)


% LOGER - Logs a message to the console based on the specified log level.
%
% Syntax:
%   loger(text, level)
%
% Description:
%   This function is used for development support. It prints a message
%   to the console if the specified log level is greater than or equal
%   to the current log level set in the MV class.
%
% Input:
%   text - (string) The message to be logged.
%   level - (double) The log level for the message.
%
% Example:
%   loger('This is a debug message.', 2);  % Logs the message if the current log level is <= 2
%
% Note:
%   The log level can be used to control the verbosity of log messages,
%   allowing developers to filter out less important messages during
%   development or debugging.


% Development support
    if level>=MV.LogLevel
        fprintf(text);
    end
end
