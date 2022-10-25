%% ¡header!
ETB < Element (et, test Element B) tests JSON.

%%% ¡description!
Tests the JSON encoding and decoding.

%%% ¡seealso!
Element

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain region.

%%% ¡prop!
PROP_EMPTY_M (metadata, empty) is a metadata, empty.

%%% ¡prop!
PROP_STRING_P (parameter, string) is a parameter, string.

%%% ¡prop!
PROP_LOGICAL_M (metadata, logical) is a metadata, logical.

%%% ¡prop!
PROP_OPTION_M (metadata, option) is a metadata, option.
%%%% ¡settings!
{'one' 'two' 'three'}

%%% ¡prop!
PROP_CLASS_M (metadata, class) is a metadata, class.
%%%% ¡settings!
'ETB'

%%% ¡prop!
PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
%%%% ¡settings!
'ETB'

%%% ¡prop!
PROP_ITEM_M (metadata, item) is a metadata, item.
%%% ¡settings!
'ETB'

%%% ¡prop!
PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
%%%% ¡settings!
'ETB'

%%% ¡prop!
PROP_IDICT_M (metadata, idict) is a metadata, idict.
%%%% ¡settings!
'ETB'

%%% ¡prop!
PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.

%%% ¡prop!
PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.

%%% ¡prop!
PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.

%%% ¡prop!
PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.

%%% ¡prop!
PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.

%%% ¡prop!
PROP_CELL_M (metadata, cell) is a metadata, cell.

%%% ¡prop!
PROP_NET_M (metadata, net) is a metadata, net.

%%% ¡prop!
PROP_COLOR_M (metadata, color) is a metadata, color.

%%% ¡prop!
PROP_ALPHA_M (metadata, alpha) is a metadata, alpha.

%%% ¡prop!
PROP_SIZE_M (metadata, size) is a metadata, size.

%%% ¡prop!
PROP_MARKER_M (metadata, marker) is a metadata, marker.

%%% ¡prop!
PROP_LINE_M (metadata, line) is a metadata, size.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
JSON
%%%% ¡probability!
.01
%%%% ¡code!
et = ETB();

et.set('PROP_EMPTY_M', []) % 1
et.set('PROP_STRING_P', 'a new ''''string') % 2
et.set('PROP_LOGICAL_M', true) % 3
et.set('PROP_OPTION_M', 'two') % 4
et.set('PROP_CLASS_M', 'ETB') % 5
et.set('PROP_CLASSLIST_M', {'ETB'}) % 6
et.set('PROP_ITEM_M', ETB()) % 7
et.set('PROP_ITEMLIST_M', {ETB(), ETB(), ETB(), ETB(), ETB()}) % 8
et.set('PROP_IDICT_M', IndexedDictionary('ID', 'dict M', ...
    'it_class', 'ETB', ...
    'it_key', 3, ...
    'it_list', { ...
        ETB('PROP_STRING_P', '1') ...
        ETB('PROP_STRING_P', '2') ...
        ETB('PROP_STRING_P', '3') ...
        ETB('PROP_STRING_P', '4') ...
        ETB('PROP_STRING_P', '5') ...
        ETB('PROP_STRING_P', '6') ...
        } ...
    )) % 9 
et.set('PROP_SCALAR_M', 3.14) % 10
et.set('PROP_RVECTOR_M', [1:1:10]) % 11
et.set('PROP_CVECTOR_M', [1:1:10]') % 12
et.set('PROP_MATRIX_M', [1:1:4]' * [1:1:3]) % 13
et.set('PROP_SMATRIX_M', eye(10)) % 14
et.set('PROP_CELL_M', {ones(2), ones(3); ones(4), 1}) % 15
%TODO: add NET
et.set('PROP_COLOR_M', [1 0 0]) % 17
et.set('PROP_ALPHA_M', .5) % 18
et.set('PROP_SIZE_M', 5) % 19
et.set('PROP_MARKER_M', '.') % 20
et.set('PROP_LINE_M', '--') % 21

[json, struct, el_list] = encodeJSON(et);

% json = regexprep(json, '{"class":', '\\n{"class":'); 
% json = regexprep(json, ',"props":[{', ',"props":[\\n\\t{');
% json = regexprep(json, '},{', '},{\\n\\t');
% json = regexprep(json, '"prop":', '\\n\\t"prop":');
% json = regexprep(json, '"tag":', '\\n\\t"tag":');
% json = regexprep(json, '"value":', '\\n\\t"value":');
% json = regexprep(json, ',"seed":', ',\\n\\t"seed":');
% json = regexprep(json, ',"locked":', ',\\n\\t"locked":');
% json = regexprep(json, ',"checked":', ',\\n\\t"checked":');
% json = regexprep(json, '},{', '\\n\\t},{');
% disp(json)

[et_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);

assert(isequal(et_dec, et))