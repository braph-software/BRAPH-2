%% ¡header!
Callback < Element (cb, callback) is a callback for a property of an element.

%%% ¡class_attributes!
Sealed = true

%%% ¡description!
A callback refers to a property of another element, which are identified 
by its properties EL and PROP/TAG.
No element can be a subclass of Callback.

%%% ¡seealso!
Element

%% ¡props!

%%% ¡prop!
EL (data, item) is the callback element.

%%% ¡prop!
PROP (data, scalar) is the callback property number.
%%%% ¡postprocessing!
el = cb.get('EL');
if ~isa(el, 'NoValue')
    tag = cb.get('TAG');
    if cb.get('PROP') == 0 && ~isempty(tag)
        cb.set('PROP', el.getPropProp(tag));
    end
end

%%% ¡prop!
TAG (data, string) is the callback property tag.
%%%% ¡postprocessing!
el = cb.get('EL');
if ~isa(el, 'NoValue')
    prop = cb.get('PROP');
    if isempty(cb.get('TAG')) && prop ~= 0
        cb.set('TAG', el.getPropTag(prop));
    end
end

%% ¡methods!
function str = tostring(cb, varargin)
    %TOSTRING returns a string representing the callback.
    %
    % STRING = TOSTRING(CB) returns a string representing the callbck CB.
    %
    % STRING = TOSTRING(CB, N) trims the string to the first N characters.
    %
    % STRING = TOSTRING(CB, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also tostring.

    el = cb.get('EL');
    prop = cb.get('PROP');
    tag = cb.get('TAG');
    if ~isa(el, 'NoValue')
        str = [class(cb) ' for ' upper(tag) '(' tostring(prop) ') of ' tostring(el)];
    else
        str = [class(cb) ' for ' tostring(el)];
    end
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end