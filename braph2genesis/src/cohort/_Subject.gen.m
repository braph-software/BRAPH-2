%% ¡header!
Subject < Element (sub, subject) is a subject.

%%% ¡description!
Subject provides the methods necessary for all subjects. 
Instances of this element should not be created. 
Use one of its subelements instead.

%%% ¡seealso!
Element, BrainAtlas, Group

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.

%% ¡methods!
function str = tostring(sub, varargin)
    %TOSTRING string with information about the subject.
    %
    % STR = TOSTRING(SUB) returns a string with information about the subject.
    %
    % STR = TOSTRING(SUB, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(SUB, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = [class(sub) ' ' sub.getPropTag(1) ' = ' tostring(sub.get(1)) '.'];

    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
