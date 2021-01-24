%% ¡header!
Callback < Element (cb, callback) is a callback for a property of an element.

%%% ¡class_attributes!
Sealed = true

%%% ¡description!
A callback refers to a property of another element.

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
    if isempty(cb.get('TAG')) && prop ~=0
        cb.set('TAG', el.getPropTag(prop));
    end
end

%% ¡methods!
function str = tostring(cb, varargin)
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