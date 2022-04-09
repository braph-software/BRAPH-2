%% ¡header!
ETA < Element (et, Element Test A) tests single-valued and ensemble props.

%%% ¡description!
Tests the methods set, get, and check for all properties categories and formats.
It also checks the use of reproducible randomness, the conditioning, 
and the restoring of a property after a failed check value. 
It checks both single-valued and ensemble properties.

%%% ¡seealso!
Element, Category, Format

%% ¡props!

%%% ¡prop!
PROP_EMPTY_M (metadata, empty) is a metadata, empty.

%%% ¡prop!
PROP_STRING_M (metadata, string) is a metadata, string.

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

%%% ¡prop!
PROP_NET_D (data, net) is a data, net.

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
PROP_EMPTY_F (figure, empty) is a figure, empty.

%%% ¡prop!
PROP_STRING_F (figure, string) is a figure, string.

%%% ¡prop!
PROP_LOGICAL_F (figure, logical) is a figure, logical.

%%% ¡prop!
PROP_OPTION_F (figure, option) is a figure, option.

%%% ¡prop!
PROP_CLASS_F (figure, class) is a figure, class.

%%% ¡prop!
PROP_CLASSLIST_F (figure, classlist) is a figure, classlist.

%%% ¡prop!
PROP_ITEM_F (figure, item) is a figure, item.

%%% ¡prop!
PROP_ITEMLIST_F (figure, itemlist) is a figure, itemlist.

%%% ¡prop!
PROP_IDICT_F (figure, idict) is a figure, idict.

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
PROP_EMPTY_G (gui, empty) is a gui, empty.

%%% ¡prop!
PROP_STRING_G (gui, string) is a gui, string.

%%% ¡prop!
PROP_LOGICAL_G (gui, logical) is a gui, logical.

%%% ¡prop!
PROP_OPTION_G (gui, option) is a gui, option.

%%% ¡prop!
PROP_CLASS_G (gui, class) is a gui, class.

%%% ¡prop!
PROP_CLASSLIST_G (gui, classlist) is a gui, classlist.

%%% ¡prop!
PROP_ITEM_G (gui, item) is a gui, item.

%%% ¡prop!
PROP_ITEMLIST_G (gui, itemlist) is a gui, itemlist.

%%% ¡prop!
PROP_IDICT_G (gui, idict) is a gui, idict.

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
PROP_NET_G (gui, net) is a result, net.