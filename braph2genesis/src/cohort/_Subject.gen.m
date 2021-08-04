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
function str = tostring(el, varargin)
    %TOSTRING string with information about the element.
    %
    % STR = TOSTRING(EL) returns a string with information about the element.
    %
    % STR = TOSTRING(EL, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(EL, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    if el.getPropNumber() > 0
        % str = char(join([class(el) 'with properties' cellfun(@(prod) el.getPropTag(prod), num2cell(Element.getProps(el)'), 'UniformOutput', false)]));
        str = [class(el) ' ' el.getPropTag(1) ' = ' tostring(el.get(1)) '.'];
    else
        str = [class(el) ' without properties.'];
    end
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
