%% ¡header!
ETA < Element (et, test Element A) tests props.

%%% ¡description!
Tests the methods set, get, and check for all properties categories and formats.
It also checks the use of reproducible randomness, the conditioning, 
and the restoring of a property after a failed check value.

%%% ¡seealso!
Element, Category, Format

%% ¡props!

%%% ¡prop!
PROP_EMPTY_M (metadata, empty) is a metadata, empty.

%%% ¡prop!
PROP_STRING_M (metadata, string) is a metadata, string.
%%%% ¡gui!
pr = PlotPropString('EL', et, 'PROP', ETA.PROP_STRING_M, varargin{:});

%%% ¡prop!
PROP_LOGICAL_M (metadata, logical) is a metadata, logical.

%%% ¡prop!
PROP_OPTION_M (metadata, option) is a metadata, option.
%%%% ¡settings!
{'one' 'two' 'three'}

%%% ¡prop!
PROP_CLASS_M (metadata, class) is a metadata, class.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEM_M (metadata, item) is a metadata, item.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_IDICT_M (metadata, idict) is a metadata, idict.
%%%% ¡settings!
'ETA'

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
PROP_MARKERSTYLE_M (metadata, markerstyle) is a metadata, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_M (metadata, markersize) is a metadata, markersize.

%%% ¡prop!
PROP_LINESTYLE_M (metadata, linestyle) is a metadata, markersize.

%%% ¡prop!
PROP_LINEWIDTH_M (metadata, linewidth) is a metadata, linewidth.

%%% ¡prop!
PROP_EMPTY_P (parameter, empty) is a parameter, empty.

%%% ¡prop!
PROP_STRING_P (parameter, string) is a parameter, string.

%%% ¡prop!
PROP_LOGICAL_P (parameter, logical) is a parameter, logical.

%%% ¡prop!
PROP_OPTION_P (parameter, option) is a parameter, option.
%%%% ¡settings!
{'one' 'two' 'three'}
%%%% ¡default!
'two'

%%% ¡prop!
PROP_CLASS_P (parameter, class) is a parameter, class.
%%%% ¡settings!
'Element'
%%%% ¡default!
'ETA'

%%% ¡prop!
PROP_CLASSLIST_P (parameter, classlist) is a parameter, classlist.
%%%% ¡settings!
'Element'
%%%% ¡default!
{'Element' 'NoValue' 'ETA'}

%%% ¡prop!
PROP_ITEM_P (parameter, item) is a parameter, item.
%%%% ¡settings!
'Element'
%%%% ¡default!
ETA()

%%% ¡prop!
PROP_ITEMLIST_P (parameter, itemlist) is a parameter, itemlist.
%%%% ¡settings!
'Element'
%%%% ¡default!
{ETA ETA ETA}

%%% ¡prop!
PROP_IDICT_P (parameter, idict) is a parameter, idict.

%%% ¡prop!
PROP_SCALAR_P (parameter, scalar) is a parameter, scalar.
%%%% ¡default!
pi
%%%% ¡check_value!
check = value >= 0;

%%% ¡prop!
PROP_RVECTOR_P (parameter, rvector) is a parameter, rvector.

%%% ¡prop!
PROP_CVECTOR_P (parameter, cvector) is a parameter, cvector.

%%% ¡prop!
PROP_MATRIX_P (parameter, matrix) is a parameter, matrix.

%%% ¡prop!
PROP_SMATRIX_P (parameter, smatrix) is a parameter, smatrix.

%%% ¡prop!
PROP_CELL_P (parameter, cell) is a parameter, cell.

%%% ¡prop!
PROP_NET_P (parameter, net) is a parameter, net.

%%% ¡prop!
PROP_COLOR_P (parameter, color) is a parameter, color.

%%% ¡prop!
PROP_ALPHA_P (parameter, alpha) is a parameter, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_P (parameter, markerstyle) is a parameter, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_P (parameter, markersize) is a parameter, markersize.

%%% ¡prop!
PROP_LINESTYLE_P (parameter, linestyle) is a parameter, markersize.

%%% ¡prop!
PROP_LINEWIDTH_P (parameter, linewidth) is a parameter, linewidth.

%%% ¡prop!
PROP_EMPTY_D (data, empty) is a data, empty.

%%% ¡prop!
PROP_STRING_D (data, string) is a data, string.

%%% ¡prop!
PROP_LOGICAL_D (data, logical) is a data, logical.

%%% ¡prop!
PROP_OPTION_D (data, option) is a data, option.

%%% ¡prop!
PROP_CLASS_D (data, class) is a data, class.

%%% ¡prop!
PROP_CLASSLIST_D (data, classlist) is a data, classlist.

%%% ¡prop!
PROP_ITEM_D (data, item) is a data, item.

%%% ¡prop!
PROP_ITEMLIST_D (data, itemlist) is a data, itemlist.

%%% ¡prop!
PROP_IDICT_D (data, idict) is a data, idict.

%%% ¡prop!
PROP_SCALAR_D (data, scalar) is a data, scalar.

%%% ¡prop!
PROP_RVECTOR_D (data, rvector) is a data, rvector.

%%% ¡prop!
PROP_CVECTOR_D (data, cvector) is a data, cvector.

%%% ¡prop!
PROP_MATRIX_D (data, matrix) is a data, matrix.

%%% ¡prop!
PROP_SMATRIX_D (data, smatrix) is a data, smatrix.

%%% ¡prop!
PROP_CELL_D (data, cell) is a data, cell.
%%%% ¡conditioning!
if isnumeric(value)
    value = {value};
end

%%% ¡prop!
PROP_NET_D (data, net) is a data, net.

%%% ¡prop!
PROP_COLOR_D (data, color) is a data, color.

%%% ¡prop!
PROP_ALPHA_D (data, alpha) is a data, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_D (data, markerstyle) is a data, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_D (data, markersize) is a data, markersize.

%%% ¡prop!
PROP_LINESTYLE_D (data, linestyle) is a data, markersize.

%%% ¡prop!
PROP_LINEWIDTH_D (data, linewidth) is a data, linewidth.

%%% ¡prop!
PROP_EMPTY_F (figure, empty) is a figure, empty.

%%% ¡prop!
PROP_STRING_F (figure, string) is a figure, string.

%%% ¡prop!
PROP_LOGICAL_F (figure, logical) is a figure, logical.

%%% ¡prop!
PROP_OPTION_F (figure, option) is a figure, option.
%%%% ¡settings!
{'one' 'two' 'three'}

%%% ¡prop!
PROP_CLASS_F (figure, class) is a figure, class.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_CLASSLIST_F (figure, classlist) is a figure, classlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEM_F (figure, item) is a figure, item.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEMLIST_F (figure, itemlist) is a figure, itemlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_IDICT_F (figure, idict) is a figure, idict.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_SCALAR_F (figure, scalar) is a figure, scalar.

%%% ¡prop!
PROP_RVECTOR_F (figure, rvector) is a figure, rvector.

%%% ¡prop!
PROP_CVECTOR_F (figure, cvector) is a figure, cvector.

%%% ¡prop!
PROP_MATRIX_F (figure, matrix) is a figure, matrix.

%%% ¡prop!
PROP_SMATRIX_F (figure, smatrix) is a figure, smatrix.

%%% ¡prop!
PROP_CELL_F (figure, cell) is a figure, cell.

%%% ¡prop!
PROP_NET_F (figure, net) is a figure, net.

%%% ¡prop!
PROP_COLOR_F (figure, color) is a figure, color.

%%% ¡prop!
PROP_ALPHA_F (figure, alpha) is a figure, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_F (figure, markerstyle) is a figure, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_F (figure, markersize) is a figure, markersize.

%%% ¡prop!
PROP_LINESTYLE_F (figure, linestyle) is a figure, markersize.

%%% ¡prop!
PROP_LINEWIDTH_F (figure, linewidth) is a figure, linewidth.

%%% ¡prop!
PROP_EMPTY_G (gui, empty) is a gui, empty.

%%% ¡prop!
PROP_STRING_G (gui, string) is a gui, string.

%%% ¡prop!
PROP_LOGICAL_G (gui, logical) is a gui, logical.

%%% ¡prop!
PROP_OPTION_G (gui, option) is a gui, option.
%%%% ¡settings!
{'one' 'two' 'three'}

%%% ¡prop!
PROP_CLASS_G (gui, class) is a gui, class.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_CLASSLIST_G (gui, classlist) is a gui, classlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEM_G (gui, item) is a gui, item.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_ITEMLIST_G (gui, itemlist) is a gui, itemlist.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_IDICT_G (gui, idict) is a gui, idict.
%%%% ¡settings!
'ETA'

%%% ¡prop!
PROP_SCALAR_G (gui, scalar) is a gui, scalar.

%%% ¡prop!
PROP_RVECTOR_G (gui, rvector) is a gui, rvector.

%%% ¡prop!
PROP_CVECTOR_G (gui, cvector) is a gui, cvector.

%%% ¡prop!
PROP_MATRIX_G (gui, matrix) is a gui, matrix.

%%% ¡prop!
PROP_SMATRIX_G (gui, smatrix) is a gui, smatrix.

%%% ¡prop!
PROP_CELL_G (gui, cell) is a gui, cell.

%%% ¡prop!
PROP_NET_G (gui, net) is a gui, net.

%%% ¡prop!
PROP_COLOR_G (gui, color) is a gui, color.

%%% ¡prop!
PROP_ALPHA_G (gui, alpha) is a gui, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_G (gui, markerstyle) is a gui, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_G (gui, markersize) is a gui, markersize.

%%% ¡prop!
PROP_LINESTYLE_G (gui, linestyle) is a gui, markersize.

%%% ¡prop!
PROP_LINEWIDTH_G (gui, linewidth) is a gui, linewidth.

%%% ¡prop!
PROP_EMPTY_R (result, empty) is a result, empty.

%%% ¡prop!
PROP_STRING_R (result, string) is a result, string.

%%% ¡prop!
PROP_LOGICAL_R (result, logical) is a result, logical.

%%% ¡prop!
PROP_OPTION_R (result, option) is a result, option.

%%% ¡prop!
PROP_CLASS_R (result, class) is a result, class.

%%% ¡prop!
PROP_CLASSLIST_R (result, classlist) is a result, classlist.

%%% ¡prop!
PROP_ITEM_R (result, item) is a result, item.

%%% ¡prop!
PROP_ITEMLIST_R (result, itemlist) is a result, itemlist.

%%% ¡prop!
PROP_IDICT_R (result, idict) is a result, idict.

%%% ¡prop!
PROP_SCALAR_R (result, scalar) is a result, scalar.

%%% ¡prop!
PROP_RVECTOR_R (result, rvector) is a result, rvector.

%%% ¡prop!
PROP_CVECTOR_R (result, cvector) is a result, cvector.

%%% ¡prop!
PROP_MATRIX_R (result, matrix) is a result, matrix.

%%% ¡prop!
PROP_SMATRIX_R (result, smatrix) is a result, smatrix.

%%% ¡prop!
PROP_CELL_R (result, cell) is a result, cell.

%%% ¡prop!
PROP_NET_R (result, net) is a result, net.

%%% ¡prop!
PROP_COLOR_R (result, color) is a result, color.

%%% ¡prop!
PROP_ALPHA_R (result, alpha) is a result, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_R (result, markerstyle) is a result, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_R (result, markersize) is a result, markersize.

%%% ¡prop!
PROP_LINESTYLE_R (result, linestyle) is a result, markersize.

%%% ¡prop!
PROP_LINEWIDTH_R (result, linewidth) is a result, linewidth.

%%% ¡prop!
PROP_EMPTY_R_CALC (result, empty) is a result, empty.
%%%% ¡calculate!
value = et.get('PROP_EMPTY_P');

%%% ¡prop!
PROP_STRING_R_CALC (result, string) is a result, string.
%%%% ¡calculate!
value = ['P: ' et.get('PROP_STRING_P') ' D:' et.get('PROP_STRING_D')];

%%% ¡prop!
PROP_LOGICAL_R_CALC (result, logical) is a result, logical.
%%%% ¡calculate!
value = xor(et.get('PROP_LOGICAL_P'), et.get('PROP_LOGICAL_D'));

%%% ¡prop!
PROP_OPTION_R_CALC (result, option) is a result, option.
%%%% ¡settings!
[ETA.getPropSettings('PROP_OPTION_D') ETA.getPropSettings('PROP_OPTION_P')]
%%%% ¡calculate!
options = ETA.getPropSettings('PROP_OPTION_R_CALC');
option = et.get('PROP_OPTION_P');
value = options{find(strcmpi(option, options))};

%%% ¡prop!
PROP_CLASS_R_CALC (result, class) is a result, class.

%%% ¡prop!
PROP_CLASSLIST_R_CALC (result, classlist) is a result, classlist.

%%% ¡prop!
PROP_ITEM_R_CALC (result, item) is a result, item.

%%% ¡prop!
PROP_ITEMLIST_R_CALC (result, itemlist) is a result, itemlist.

%%% ¡prop!
PROP_IDICT_R_CALC (result, idict) is a result, idict.

%%% ¡prop!
PROP_SCALAR_R_CALC (result, scalar) is a result, scalar.
%%%% ¡calculate!
value = et.get('PROP_SCALAR_P') + et.get('PROP_SCALAR_D') + et.get('PROP_SCALAR_R');

%%% ¡prop!
PROP_RVECTOR_R_CALC (result, rvector) is a result, rvector.

%%% ¡prop!
PROP_CVECTOR_R_CALC (result, cvector) is a result, cvector.

%%% ¡prop!
PROP_MATRIX_R_CALC (result, matrix) is a result, matrix.
%%%% ¡calculate!
value = rand(10);

%%% ¡prop!
PROP_SMATRIX_R_CALC (result, smatrix) is a result, smatrix.

%%% ¡prop!
PROP_CELL_R_CALC (result, cell) is a result, cell.
%%%% ¡calculate!
value = cellfun(@(x) rand(x), {1 2 3; 4 5 6}, 'UniformOutput', false);

%%% ¡prop!
PROP_NET_R_CALC (result, net) is a result, net.

%%% ¡prop!
PROP_COLOR_R_CALC (result, color) is a result, color.

%%% ¡prop!
PROP_ALPHA_R_CALC (result, alpha) is a result, alpha.

%%% ¡prop!
PROP_MARKERSTYLE_R_CALC (result, markerstyle) is a result, markerstyle.

%%% ¡prop!
PROP_MARKERSIZE_R_CALC (result, markersize) is a result, markersize.

%%% ¡prop!
PROP_LINESTYLE_R_CALC (result, linestyle) is a result, markersize.

%%% ¡prop!
PROP_LINEWIDTH_R_CALC (result, linewidth) is a result, linewidth.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Empty
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA();
assert(isempty(et.get('PROP_EMPTY_R_CALC')))

%%% ¡test!
%%%% ¡name!
String
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA('PROP_STRING_P', 'param', 'PROP_STRING_D', 'data');
assert(ischar(et.get('PROP_STRING_R_CALC')))

%%% ¡test!
%%%% ¡name!
Logical
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA('PROP_LOGICAL_P', true, 'PROP_LOGICAL_D', false);
assert(islogical(et.get('PROP_LOGICAL_R_CALC')))

%%% ¡test!
%%%% ¡name!
Option
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA('PROP_OPTION_P', 'two');
assert(any(strcmpi(et.get('PROP_OPTION_P'), et.get('PROP_OPTION_R_CALC'))))

%%% ¡test!
%%%% ¡name!
Matrix & randomness
%%%% ¡probability!
.01
%%%% ¡code!
et_1 = ETA();
value_1 = et_1.get('PROP_MATRIX_R_CALC');
assert(isequal(value_1, et_1.get('PROP_MATRIX_R_CALC')))

et_2 = ETA();
value_2 = et_2.get('PROP_MATRIX_R_CALC');
assert(isequal(value_2, et_2.get('PROP_MATRIX_R_CALC')))

assert(~isequal(value_1, value_2)) % different values!

rng(0)
et_3 = ETA();
value_3 = et_3.get('PROP_MATRIX_R_CALC');
assert(isequal(value_3, et_3.get('PROP_MATRIX_R_CALC')))

rng(0)
et_4 = ETA();
value_4 = et_4.get('PROP_MATRIX_R_CALC');
assert(isequal(value_4, et_4.get('PROP_MATRIX_R_CALC')))

assert(isequal(value_4, value_4)) % same values!

%%% ¡test!
%%%% ¡name!
Scalar & prop backup
%%%% ¡probability!
.01
%%%% ¡code!
et_1 = ETA('PROP_SCALAR_D', 2);
assert(et_1.get('PROP_SCALAR_R_CALC') == pi + 2)

et_2 = ETA('PROP_SCALAR_D', 2);
et_2.set('PROP_SCALAR_P', 1)
assert(et_2.get('PROP_SCALAR_R_CALC') == 1 + 2)

warning('off', [BRAPH2.STR ':ETA'])
et_2.set('PROP_SCALAR_P', 100)
assert(et_2.get('PROP_SCALAR_R_CALC') == 1 + 2) % i.e. it has not been updated
warning('on', [BRAPH2.STR ':ETA'])

et_3 = ETA('PROP_SCALAR_D', 2);
assert_with_error('varargin{1}.set(''PROP_SCALAR_P'', -2)', ...
    [BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT], ...
    et_3)
assert(et_3.get('PROP_SCALAR_R_CALC') == pi + 2)

et_4 = ETA('PROP_SCALAR_D', 2);
assert_with_error('varargin{1}.set(''PROP_SCALAR_P'', ''a'')', ...
    [BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT], ...
    et_4)
assert(et_4.get('PROP_SCALAR_R_CALC') == pi + 2)

%%% ¡test!
%%%% ¡name!
Cell & conditioning
%%%% ¡probability!
.01
%%%% ¡code!
assert_with_error('et = ETA(''PROP_SCALAR_P'', rand(5));', ...
    [BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT])
et = ETA('PROP_CELL_D', rand(5));

%%% ¡test!
%%%% ¡name!
Deep copy NoValue
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA();
et_copy = et.copy();
assert(et_copy.getr(5) == et.getr(5) && ...
    et_copy.getr(5) ~= NoValue() && ...
    et.getr(5) ~= NoValue(), ...
    [BRAPH2.STR ':ETA:' BRAPH2.BUG_COPY], ...
    'All NoValue objects must point to the same object instance for computational efficiency.')