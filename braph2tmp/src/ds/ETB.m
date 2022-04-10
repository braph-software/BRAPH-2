classdef ETB < Element
	% ETB tests JSON.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Tests the JSON encoding and decoding.
	%
	% The list of ETB properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain region.
	%  <strong>2</strong> <strong>prop_empty_m</strong> 	PROP_EMPTY_M (metadata, empty) is a metadata, empty.
	%  <strong>3</strong> <strong>prop_string_p</strong> 	PROP_STRING_P (parameter, string) is a parameter, string.
	%  <strong>4</strong> <strong>prop_logical_m</strong> 	PROP_LOGICAL_M (metadata, logical) is a metadata, logical.
	%  <strong>5</strong> <strong>prop_option_m</strong> 	PROP_OPTION_M (metadata, option) is a metadata, option.
	%  <strong>6</strong> <strong>prop_class_m</strong> 	PROP_CLASS_M (metadata, class) is a metadata, class.
	%  <strong>7</strong> <strong>prop_classlist_m</strong> 	PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
	%  <strong>8</strong> <strong>prop_item_m</strong> 	PROP_ITEM_M (metadata, item) is a metadata, item.
	%  <strong>9</strong> <strong>prop_itemlist_m</strong> 	PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
	%  <strong>10</strong> <strong>prop_idict_m</strong> 	PROP_IDICT_M (metadata, idict) is a metadata, idict.
	%  <strong>11</strong> <strong>prop_scalar_m</strong> 	PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.
	%  <strong>12</strong> <strong>prop_rvector_m</strong> 	PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.
	%  <strong>13</strong> <strong>prop_cvector_m</strong> 	PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.
	%  <strong>14</strong> <strong>prop_matrix_m</strong> 	PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.
	%  <strong>15</strong> <strong>prop_smatrix_m</strong> 	PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.
	%  <strong>16</strong> <strong>prop_cell_m</strong> 	PROP_CELL_M (metadata, cell) is a metadata, cell.
	%
	% ETB methods (constructor):
	% ETB - constructor
	%
	% ETB methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element B/error.
	%  existsProp - checks whether property exists in test Element B/error.
	%  getPropNumber - returns the property number of test Element B.
	%  getProps - returns the property list of test Element B.
	%  getDescription - returns the description of the test Element B.
	%  getName - returns the name of the test Element B.
	%  getClass - returns the class of the test Element B.
	%
	% ETB methods:
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% ETB methods (operators):
	%  isequal - determines whether two ETB are equal (values, locked)
	%
	% ETB methods (display):
	%  tostring - string with information about the ETB
	%  disp - displays information about the ETB
	%  tree - displays the element of ETB
	%
	% ETB method (element list):
	%  getElementList - returns a list with all subelements of ETB
	%
	% ETB method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETB
	%
	% ETB method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETB
	%
	% ETB methods (copy):
	%  copy - copies the ETB
	%  deepclone - deep-clones the ETB
	%  clone - clones the ETB
	%
	% ETB methods (inspection, Static):
	%  getClass - returns ETB
	%  getName - returns the name of ETB
	%  getDescription - returns the description of ETB
	%  getProps - returns the property list of ETB
	%  getPropNumber - returns the property number of ETB
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% ETB methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETB methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETB methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETB methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETB properties (Constant).
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  PROP_EMPTY_M - 2
	%  PROP_EMPTY_M_TAG - 'prop_empty_m'
	%  PROP_EMPTY_M_CATEGORY - 'm'
	%  PROP_EMPTY_M_FORMAT - 'em'
	%  PROP_STRING_P - 3
	%  PROP_STRING_P_TAG - 'prop_string_p'
	%  PROP_STRING_P_CATEGORY - 'p'
	%  PROP_STRING_P_FORMAT - 'st'
	%  PROP_LOGICAL_M - 4
	%  PROP_LOGICAL_M_TAG - 'prop_logical_m'
	%  PROP_LOGICAL_M_CATEGORY - 'm'
	%  PROP_LOGICAL_M_FORMAT - 'lo'
	%  PROP_OPTION_M - 5
	%  PROP_OPTION_M_TAG - 'prop_option_m'
	%  PROP_OPTION_M_CATEGORY - 'm'
	%  PROP_OPTION_M_FORMAT - 'op'
	%  PROP_CLASS_M - 6
	%  PROP_CLASS_M_TAG - 'prop_class_m'
	%  PROP_CLASS_M_CATEGORY - 'm'
	%  PROP_CLASS_M_FORMAT - 'ca'
	%  PROP_CLASSLIST_M - 7
	%  PROP_CLASSLIST_M_TAG - 'prop_classlist_m'
	%  PROP_CLASSLIST_M_CATEGORY - 'm'
	%  PROP_CLASSLIST_M_FORMAT - 'cl'
	%  PROP_ITEM_M - 8
	%  PROP_ITEM_M_TAG - 'prop_item_m'
	%  PROP_ITEM_M_CATEGORY - 'm'
	%  PROP_ITEM_M_FORMAT - 'it'
	%  PROP_ITEMLIST_M - 9
	%  PROP_ITEMLIST_M_TAG - 'prop_itemlist_m'
	%  PROP_ITEMLIST_M_CATEGORY - 'm'
	%  PROP_ITEMLIST_M_FORMAT - 'il'
	%  PROP_IDICT_M - 10
	%  PROP_IDICT_M_TAG - 'prop_idict_m'
	%  PROP_IDICT_M_CATEGORY - 'm'
	%  PROP_IDICT_M_FORMAT - 'di'
	%  PROP_SCALAR_M - 11
	%  PROP_SCALAR_M_TAG - 'prop_scalar_m'
	%  PROP_SCALAR_M_CATEGORY - 'm'
	%  PROP_SCALAR_M_FORMAT - 'nn'
	%  PROP_RVECTOR_M - 12
	%  PROP_RVECTOR_M_TAG - 'prop_rvector_m'
	%  PROP_RVECTOR_M_CATEGORY - 'm'
	%  PROP_RVECTOR_M_FORMAT - 'nr'
	%  PROP_CVECTOR_M - 13
	%  PROP_CVECTOR_M_TAG - 'prop_cvector_m'
	%  PROP_CVECTOR_M_CATEGORY - 'm'
	%  PROP_CVECTOR_M_FORMAT - 'nc'
	%  PROP_MATRIX_M - 14
	%  PROP_MATRIX_M_TAG - 'prop_matrix_m'
	%  PROP_MATRIX_M_CATEGORY - 'm'
	%  PROP_MATRIX_M_FORMAT - 'nm'
	%  PROP_SMATRIX_M - 15
	%  PROP_SMATRIX_M_TAG - 'prop_smatrix_m'
	%  PROP_SMATRIX_M_CATEGORY - 'm'
	%  PROP_SMATRIX_M_FORMAT - 'ns'
	%  PROP_CELL_M - 16
	%  PROP_CELL_M_TAG - 'prop_cell_m'
	%  PROP_CELL_M_CATEGORY - 'm'
	%  PROP_CELL_M_FORMAT - 'll'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
	%
	% See also Element.
	
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		PROP_EMPTY_M = 2;
		PROP_EMPTY_M_TAG = 'prop_empty_m';
		PROP_EMPTY_M_CATEGORY = Category.METADATA;
		PROP_EMPTY_M_FORMAT = Format.EMPTY;
		
		PROP_STRING_P = 3;
		PROP_STRING_P_TAG = 'prop_string_p';
		PROP_STRING_P_CATEGORY = Category.PARAMETER;
		PROP_STRING_P_FORMAT = Format.STRING;
		
		PROP_LOGICAL_M = 4;
		PROP_LOGICAL_M_TAG = 'prop_logical_m';
		PROP_LOGICAL_M_CATEGORY = Category.METADATA;
		PROP_LOGICAL_M_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_M = 5;
		PROP_OPTION_M_TAG = 'prop_option_m';
		PROP_OPTION_M_CATEGORY = Category.METADATA;
		PROP_OPTION_M_FORMAT = Format.OPTION;
		
		PROP_CLASS_M = 6;
		PROP_CLASS_M_TAG = 'prop_class_m';
		PROP_CLASS_M_CATEGORY = Category.METADATA;
		PROP_CLASS_M_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_M = 7;
		PROP_CLASSLIST_M_TAG = 'prop_classlist_m';
		PROP_CLASSLIST_M_CATEGORY = Category.METADATA;
		PROP_CLASSLIST_M_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_M = 8;
		PROP_ITEM_M_TAG = 'prop_item_m';
		PROP_ITEM_M_CATEGORY = Category.METADATA;
		PROP_ITEM_M_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_M = 9;
		PROP_ITEMLIST_M_TAG = 'prop_itemlist_m';
		PROP_ITEMLIST_M_CATEGORY = Category.METADATA;
		PROP_ITEMLIST_M_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_M = 10;
		PROP_IDICT_M_TAG = 'prop_idict_m';
		PROP_IDICT_M_CATEGORY = Category.METADATA;
		PROP_IDICT_M_FORMAT = Format.IDICT;
		
		PROP_SCALAR_M = 11;
		PROP_SCALAR_M_TAG = 'prop_scalar_m';
		PROP_SCALAR_M_CATEGORY = Category.METADATA;
		PROP_SCALAR_M_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_M = 12;
		PROP_RVECTOR_M_TAG = 'prop_rvector_m';
		PROP_RVECTOR_M_CATEGORY = Category.METADATA;
		PROP_RVECTOR_M_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_M = 13;
		PROP_CVECTOR_M_TAG = 'prop_cvector_m';
		PROP_CVECTOR_M_CATEGORY = Category.METADATA;
		PROP_CVECTOR_M_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_M = 14;
		PROP_MATRIX_M_TAG = 'prop_matrix_m';
		PROP_MATRIX_M_CATEGORY = Category.METADATA;
		PROP_MATRIX_M_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_M = 15;
		PROP_SMATRIX_M_TAG = 'prop_smatrix_m';
		PROP_SMATRIX_M_CATEGORY = Category.METADATA;
		PROP_SMATRIX_M_FORMAT = Format.SMATRIX;
		
		PROP_CELL_M = 16;
		PROP_CELL_M_TAG = 'prop_cell_m';
		PROP_CELL_M_CATEGORY = Category.METADATA;
		PROP_CELL_M_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element B.
			%
			% CLASS = ETB.GETCLASS() returns the class 'ETB'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element B ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETB') returns 'ETB'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETB';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element B.
			%
			% NAME = ETB.GETNAME() returns the name of the 'test Element B'.
			%  Test Element B.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element B ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETB') returns the name of 'ETB'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element B';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element B.
			%
			% STR = ETB.GETDESCRIPTION() returns the description of the 'test Element B'.
			%  which is:
			%
			%  Tests the JSON encoding and decoding.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element B ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETB') returns the description of 'ETB'.
			%
			% See also getClass, getName.
			
			et_description = [
				'Tests the JSON encoding and decoding.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element B.
			%
			% PROPS = ETB.GETPROPS() returns the property list of test Element B.
			%
			% PROPS = ETB.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element B ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETB'[, CATEGORY]) returns the property list of 'ETB'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ETB.PROP_EMPTY_M
						ETB.PROP_LOGICAL_M
						ETB.PROP_OPTION_M
						ETB.PROP_CLASS_M
						ETB.PROP_CLASSLIST_M
						ETB.PROP_ITEM_M
						ETB.PROP_ITEMLIST_M
						ETB.PROP_IDICT_M
						ETB.PROP_SCALAR_M
						ETB.PROP_RVECTOR_M
						ETB.PROP_CVECTOR_M
						ETB.PROP_MATRIX_M
						ETB.PROP_SMATRIX_M
						ETB.PROP_CELL_M
						];
				case Category.PARAMETER
					prop_list = [
						ETB.PROP_STRING_P
						];
				case Category.DATA
					prop_list = [
						ETB.ID
						];
				case Category.RESULT
					prop_list = [
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						ETB.ID
						ETB.PROP_EMPTY_M
						ETB.PROP_STRING_P
						ETB.PROP_LOGICAL_M
						ETB.PROP_OPTION_M
						ETB.PROP_CLASS_M
						ETB.PROP_CLASSLIST_M
						ETB.PROP_ITEM_M
						ETB.PROP_ITEMLIST_M
						ETB.PROP_IDICT_M
						ETB.PROP_SCALAR_M
						ETB.PROP_RVECTOR_M
						ETB.PROP_CVECTOR_M
						ETB.PROP_MATRIX_M
						ETB.PROP_SMATRIX_M
						ETB.PROP_CELL_M
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element B.
			%
			% N = ETB.GETPROPNUMBER() returns the property number of test Element B.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element B ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETB') returns the property number of 'ETB'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 16;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element B/error.
			%
			% CHECK = ETB.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETB, PROP) checks whether PROP exists for ETB.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  Element.EXISTSPROP(ETB, PROP) throws error if PROP does NOT exist for ETB.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 ]);
			else
				assert( ...
					ETB.existsProp(prop), ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETB.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element B/error.
			%
			% CHECK = ETB.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETB, TAG) checks whether TAG exists for ETB.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  Element.EXISTSTAG(ETB, TAG) throws error if TAG does NOT exist for ETB.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				etb_tag_list = { 'id'  'prop_empty_m'  'prop_string_p'  'prop_logical_m'  'prop_option_m'  'prop_class_m'  'prop_classlist_m'  'prop_item_m'  'prop_itemlist_m'  'prop_idict_m'  'prop_scalar_m'  'prop_rvector_m'  'prop_cvector_m'  'prop_matrix_m'  'prop_smatrix_m'  'prop_cell_m' };
				
				check = any(strcmpi(tag, etb_tag_list));
			else
				assert( ...
					ETB.existsTag(tag), ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETB'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = ET.GETPROPPROP(POINTER) returns property number of POINTER of ET.
			%  PROPERTY = Element.GETPROPPROP(ETB, POINTER) returns property number of POINTER of ETB.
			%  PROPERTY = ET.GETPROPPROP(ETB, POINTER) returns property number of POINTER of ETB.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				etb_tag_list = { 'id'  'prop_empty_m'  'prop_string_p'  'prop_logical_m'  'prop_option_m'  'prop_class_m'  'prop_classlist_m'  'prop_item_m'  'prop_itemlist_m'  'prop_idict_m'  'prop_scalar_m'  'prop_rvector_m'  'prop_cvector_m'  'prop_matrix_m'  'prop_smatrix_m'  'prop_cell_m' };
				
				tag = pointer;
				ETB.existsTag(tag);
				
				prop = find(strcmpi(tag, etb_tag_list));
			else % numeric
				prop = pointer;
				ETB.existsProp(prop);
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = ET.GETPROPTAG(POINTER) returns tag of POINTER of ET.
			%  TAG = Element.GETPROPTAG(ETB, POINTER) returns tag of POINTER of ETB.
			%  TAG = ET.GETPROPTAG(ETB, POINTER) returns tag of POINTER of ETB.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETB.existsTag(tag);
			else % numeric
				prop = pointer;
				ETB.existsProp(prop);
				
				switch prop
					case ETB.ID
						tag = ETB.ID_TAG;
					case ETB.PROP_EMPTY_M
						tag = ETB.PROP_EMPTY_M_TAG;
					case ETB.PROP_STRING_P
						tag = ETB.PROP_STRING_P_TAG;
					case ETB.PROP_LOGICAL_M
						tag = ETB.PROP_LOGICAL_M_TAG;
					case ETB.PROP_OPTION_M
						tag = ETB.PROP_OPTION_M_TAG;
					case ETB.PROP_CLASS_M
						tag = ETB.PROP_CLASS_M_TAG;
					case ETB.PROP_CLASSLIST_M
						tag = ETB.PROP_CLASSLIST_M_TAG;
					case ETB.PROP_ITEM_M
						tag = ETB.PROP_ITEM_M_TAG;
					case ETB.PROP_ITEMLIST_M
						tag = ETB.PROP_ITEMLIST_M_TAG;
					case ETB.PROP_IDICT_M
						tag = ETB.PROP_IDICT_M_TAG;
					case ETB.PROP_SCALAR_M
						tag = ETB.PROP_SCALAR_M_TAG;
					case ETB.PROP_RVECTOR_M
						tag = ETB.PROP_RVECTOR_M_TAG;
					case ETB.PROP_CVECTOR_M
						tag = ETB.PROP_CVECTOR_M_TAG;
					case ETB.PROP_MATRIX_M
						tag = ETB.PROP_MATRIX_M_TAG;
					case ETB.PROP_SMATRIX_M
						tag = ETB.PROP_SMATRIX_M_TAG;
					case ETB.PROP_CELL_M
						tag = ETB.PROP_CELL_M_TAG;
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = ET.GETPROPCATEGORY(POINTER) returns category of POINTER of ET.
			%  CATEGORY = Element.GETPROPCATEGORY(ETB, POINTER) returns category of POINTER of ETB.
			%  CATEGORY = ET.GETPROPCATEGORY(ETB, POINTER) returns category of POINTER of ETB.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					prop_category = ETB.ID_CATEGORY;
				case ETB.PROP_EMPTY_M
					prop_category = ETB.PROP_EMPTY_M_CATEGORY;
				case ETB.PROP_STRING_P
					prop_category = ETB.PROP_STRING_P_CATEGORY;
				case ETB.PROP_LOGICAL_M
					prop_category = ETB.PROP_LOGICAL_M_CATEGORY;
				case ETB.PROP_OPTION_M
					prop_category = ETB.PROP_OPTION_M_CATEGORY;
				case ETB.PROP_CLASS_M
					prop_category = ETB.PROP_CLASS_M_CATEGORY;
				case ETB.PROP_CLASSLIST_M
					prop_category = ETB.PROP_CLASSLIST_M_CATEGORY;
				case ETB.PROP_ITEM_M
					prop_category = ETB.PROP_ITEM_M_CATEGORY;
				case ETB.PROP_ITEMLIST_M
					prop_category = ETB.PROP_ITEMLIST_M_CATEGORY;
				case ETB.PROP_IDICT_M
					prop_category = ETB.PROP_IDICT_M_CATEGORY;
				case ETB.PROP_SCALAR_M
					prop_category = ETB.PROP_SCALAR_M_CATEGORY;
				case ETB.PROP_RVECTOR_M
					prop_category = ETB.PROP_RVECTOR_M_CATEGORY;
				case ETB.PROP_CVECTOR_M
					prop_category = ETB.PROP_CVECTOR_M_CATEGORY;
				case ETB.PROP_MATRIX_M
					prop_category = ETB.PROP_MATRIX_M_CATEGORY;
				case ETB.PROP_SMATRIX_M
					prop_category = ETB.PROP_SMATRIX_M_CATEGORY;
				case ETB.PROP_CELL_M
					prop_category = ETB.PROP_CELL_M_CATEGORY;
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = ET.GETPROPFORMAT(POINTER) returns format of POINTER of ET.
			%  FORMAT = Element.GETPROPFORMAT(ETB, POINTER) returns format of POINTER of ETB.
			%  FORMAT = ET.GETPROPFORMAT(ETB, POINTER) returns format of POINTER of ETB.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					prop_format = ETB.ID_FORMAT;
				case ETB.PROP_EMPTY_M
					prop_format = ETB.PROP_EMPTY_M_FORMAT;
				case ETB.PROP_STRING_P
					prop_format = ETB.PROP_STRING_P_FORMAT;
				case ETB.PROP_LOGICAL_M
					prop_format = ETB.PROP_LOGICAL_M_FORMAT;
				case ETB.PROP_OPTION_M
					prop_format = ETB.PROP_OPTION_M_FORMAT;
				case ETB.PROP_CLASS_M
					prop_format = ETB.PROP_CLASS_M_FORMAT;
				case ETB.PROP_CLASSLIST_M
					prop_format = ETB.PROP_CLASSLIST_M_FORMAT;
				case ETB.PROP_ITEM_M
					prop_format = ETB.PROP_ITEM_M_FORMAT;
				case ETB.PROP_ITEMLIST_M
					prop_format = ETB.PROP_ITEMLIST_M_FORMAT;
				case ETB.PROP_IDICT_M
					prop_format = ETB.PROP_IDICT_M_FORMAT;
				case ETB.PROP_SCALAR_M
					prop_format = ETB.PROP_SCALAR_M_FORMAT;
				case ETB.PROP_RVECTOR_M
					prop_format = ETB.PROP_RVECTOR_M_FORMAT;
				case ETB.PROP_CVECTOR_M
					prop_format = ETB.PROP_CVECTOR_M_FORMAT;
				case ETB.PROP_MATRIX_M
					prop_format = ETB.PROP_MATRIX_M_FORMAT;
				case ETB.PROP_SMATRIX_M
					prop_format = ETB.PROP_SMATRIX_M_FORMAT;
				case ETB.PROP_CELL_M
					prop_format = ETB.PROP_CELL_M_FORMAT;
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ET.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETB, POINTER) returns description of POINTER of ETB.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETB, POINTER) returns description of POINTER of ETB.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain region.';
				case ETB.PROP_EMPTY_M
					prop_description = 'PROP_EMPTY_M (metadata, empty) is a metadata, empty.';
				case ETB.PROP_STRING_P
					prop_description = 'PROP_STRING_P (parameter, string) is a parameter, string.';
				case ETB.PROP_LOGICAL_M
					prop_description = 'PROP_LOGICAL_M (metadata, logical) is a metadata, logical.';
				case ETB.PROP_OPTION_M
					prop_description = 'PROP_OPTION_M (metadata, option) is a metadata, option.';
				case ETB.PROP_CLASS_M
					prop_description = 'PROP_CLASS_M (metadata, class) is a metadata, class.';
				case ETB.PROP_CLASSLIST_M
					prop_description = 'PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.';
				case ETB.PROP_ITEM_M
					prop_description = 'PROP_ITEM_M (metadata, item) is a metadata, item.';
				case ETB.PROP_ITEMLIST_M
					prop_description = 'PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.';
				case ETB.PROP_IDICT_M
					prop_description = 'PROP_IDICT_M (metadata, idict) is a metadata, idict.';
				case ETB.PROP_SCALAR_M
					prop_description = 'PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.';
				case ETB.PROP_RVECTOR_M
					prop_description = 'PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.';
				case ETB.PROP_CVECTOR_M
					prop_description = 'PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.';
				case ETB.PROP_MATRIX_M
					prop_description = 'PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.';
				case ETB.PROP_SMATRIX_M
					prop_description = 'PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.';
				case ETB.PROP_CELL_M
					prop_description = 'PROP_CELL_M (metadata, cell) is a metadata, cell.';
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = ET.GETPROPSETTINGS(POINTER) returns settings of POINTER of ET.
			%  SETTINGS = Element.GETPROPSETTINGS(ETB, POINTER) returns settings of POINTER of ETB.
			%  SETTINGS = ET.GETPROPSETTINGS(ETB, POINTER) returns settings of POINTER of ETB.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETB.PROP_EMPTY_M
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETB.PROP_STRING_P
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETB.PROP_LOGICAL_M
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETB.PROP_OPTION_M
					prop_settings = {'one' 'two' 'three'};
				case ETB.PROP_CLASS_M
					prop_settings = 'ETB';
				case ETB.PROP_CLASSLIST_M
					prop_settings = 'ETB';
				case ETB.PROP_ITEM_M
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ETB.PROP_ITEMLIST_M
					prop_settings = 'ETB';
				case ETB.PROP_IDICT_M
					prop_settings = 'ETB';
				case ETB.PROP_SCALAR_M
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETB.PROP_RVECTOR_M
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETB.PROP_CVECTOR_M
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETB.PROP_MATRIX_M
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETB.PROP_SMATRIX_M
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETB.PROP_CELL_M
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETB.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETB.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETB, POINTER) returns the default value of POINTER of ETB.
			%  DEFAULT = ET.GETPROPDEFAULT(ETB, POINTER) returns the default value of POINTER of ETB.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					prop_default = Format.getFormatDefault(Format.STRING, ETB.getPropSettings(prop));
				case ETB.PROP_EMPTY_M
					prop_default = Format.getFormatDefault(Format.EMPTY, ETB.getPropSettings(prop));
				case ETB.PROP_STRING_P
					prop_default = Format.getFormatDefault(Format.STRING, ETB.getPropSettings(prop));
				case ETB.PROP_LOGICAL_M
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETB.getPropSettings(prop));
				case ETB.PROP_OPTION_M
					prop_default = Format.getFormatDefault(Format.OPTION, ETB.getPropSettings(prop));
				case ETB.PROP_CLASS_M
					prop_default = Format.getFormatDefault(Format.CLASS, ETB.getPropSettings(prop));
				case ETB.PROP_CLASSLIST_M
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETB.getPropSettings(prop));
				case ETB.PROP_ITEM_M
					prop_default = Format.getFormatDefault(Format.ITEM, ETB.getPropSettings(prop));
				case ETB.PROP_ITEMLIST_M
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETB.getPropSettings(prop));
				case ETB.PROP_IDICT_M
					prop_default = Format.getFormatDefault(Format.IDICT, ETB.getPropSettings(prop));
				case ETB.PROP_SCALAR_M
					prop_default = Format.getFormatDefault(Format.SCALAR, ETB.getPropSettings(prop));
				case ETB.PROP_RVECTOR_M
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETB.getPropSettings(prop));
				case ETB.PROP_CVECTOR_M
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETB.getPropSettings(prop));
				case ETB.PROP_MATRIX_M
					prop_default = Format.getFormatDefault(Format.MATRIX, ETB.getPropSettings(prop));
				case ETB.PROP_SMATRIX_M
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETB.getPropSettings(prop));
				case ETB.PROP_CELL_M
					prop_default = Format.getFormatDefault(Format.CELL, ETB.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETB.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETB.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETB, POINTER) returns the conditioned default value of POINTER of ETB.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETB, POINTER) returns the conditioned default value of POINTER of ETB.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETB.getPropProp(pointer);
			
			prop_default = ETB.conditioning(prop, ETB.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ET.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ET.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ET.
			%  CHECK = Element.CHECKPROP(ETB, PROP, VALUE) checks VALUE format for PROP of ETB.
			%  CHECK = ET.CHECKPROP(ETB, PROP, VALUE) checks VALUE format for PROP of ETB.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETB:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  Element.CHECKPROP(ETB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETB.
			%   Error id: [BRAPH2:ETB:WrongInput]
			%  ET.CHECKPROP(ETB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETB.
			%   Error id: [BRAPH2:ETB:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETB.getPropProp(pointer);
			
			switch prop
				case ETB.ID
					check = Format.checkFormat(Format.STRING, value, ETB.getPropSettings(prop));
				case ETB.PROP_EMPTY_M
					check = Format.checkFormat(Format.EMPTY, value, ETB.getPropSettings(prop));
				case ETB.PROP_STRING_P
					check = Format.checkFormat(Format.STRING, value, ETB.getPropSettings(prop));
				case ETB.PROP_LOGICAL_M
					check = Format.checkFormat(Format.LOGICAL, value, ETB.getPropSettings(prop));
				case ETB.PROP_OPTION_M
					check = Format.checkFormat(Format.OPTION, value, ETB.getPropSettings(prop));
				case ETB.PROP_CLASS_M
					check = Format.checkFormat(Format.CLASS, value, ETB.getPropSettings(prop));
				case ETB.PROP_CLASSLIST_M
					check = Format.checkFormat(Format.CLASSLIST, value, ETB.getPropSettings(prop));
				case ETB.PROP_ITEM_M
					check = Format.checkFormat(Format.ITEM, value, ETB.getPropSettings(prop));
				case ETB.PROP_ITEMLIST_M
					check = Format.checkFormat(Format.ITEMLIST, value, ETB.getPropSettings(prop));
				case ETB.PROP_IDICT_M
					check = Format.checkFormat(Format.IDICT, value, ETB.getPropSettings(prop));
				case ETB.PROP_SCALAR_M
					check = Format.checkFormat(Format.SCALAR, value, ETB.getPropSettings(prop));
				case ETB.PROP_RVECTOR_M
					check = Format.checkFormat(Format.RVECTOR, value, ETB.getPropSettings(prop));
				case ETB.PROP_CVECTOR_M
					check = Format.checkFormat(Format.CVECTOR, value, ETB.getPropSettings(prop));
				case ETB.PROP_MATRIX_M
					check = Format.checkFormat(Format.MATRIX, value, ETB.getPropSettings(prop));
				case ETB.PROP_SMATRIX_M
					check = Format.checkFormat(Format.SMATRIX, value, ETB.getPropSettings(prop));
				case ETB.PROP_CELL_M
					check = Format.checkFormat(Format.CELL, value, ETB.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETB:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETB.getPropTag(prop) ' (' ETB.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETB(varargin)
			% ETB() creates a test Element B.
			%
			% ETB(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETB(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETB properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain region.
			%  <strong>2</strong> <strong>prop_empty_m</strong> 	PROP_EMPTY_M (metadata, empty) is a metadata, empty.
			%  <strong>3</strong> <strong>prop_string_p</strong> 	PROP_STRING_P (parameter, string) is a parameter, string.
			%  <strong>4</strong> <strong>prop_logical_m</strong> 	PROP_LOGICAL_M (metadata, logical) is a metadata, logical.
			%  <strong>5</strong> <strong>prop_option_m</strong> 	PROP_OPTION_M (metadata, option) is a metadata, option.
			%  <strong>6</strong> <strong>prop_class_m</strong> 	PROP_CLASS_M (metadata, class) is a metadata, class.
			%  <strong>7</strong> <strong>prop_classlist_m</strong> 	PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
			%  <strong>8</strong> <strong>prop_item_m</strong> 	PROP_ITEM_M (metadata, item) is a metadata, item.
			%  <strong>9</strong> <strong>prop_itemlist_m</strong> 	PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
			%  <strong>10</strong> <strong>prop_idict_m</strong> 	PROP_IDICT_M (metadata, idict) is a metadata, idict.
			%  <strong>11</strong> <strong>prop_scalar_m</strong> 	PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.
			%  <strong>12</strong> <strong>prop_rvector_m</strong> 	PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.
			%  <strong>13</strong> <strong>prop_cvector_m</strong> 	PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.
			%  <strong>14</strong> <strong>prop_matrix_m</strong> 	PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.
			%  <strong>15</strong> <strong>prop_smatrix_m</strong> 	PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.
			%  <strong>16</strong> <strong>prop_cell_m</strong> 	PROP_CELL_M (metadata, cell) is a metadata, cell.
			%
			% See also Category, Format, set, check.
			
			et = et@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETB.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
