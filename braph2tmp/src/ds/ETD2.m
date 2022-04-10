classdef ETD2 < ETD1
	% ETD2 tests postprocessing.
	% It is a subclass of <a href="matlab:help ETD1">ETD1</a>.
	%
	% ETD2 tests postprocessing.
	%
	% The list of ETD2 properties is:
	%  <strong>1</strong> <strong>uno</strong> 	UNO (data, scalar) is a data synchronized with DUE and TRE.
	%  <strong>2</strong> <strong>due</strong> 	DUE (data, scalar) is a data synchronized with UNO and TRE.
	%  <strong>3</strong> <strong>tre</strong> 	TRE (data, scalar) is a data synchronized with UNO and DUE.
	%
	% ETD2 methods (constructor):
	% ETD2 - constructor
	%
	% ETD2 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element D2/error.
	%  existsProp - checks whether property exists in test Element D2/error.
	%  getPropNumber - returns the property number of test Element D2.
	%  getProps - returns the property list of test Element D2.
	%  getDescription - returns the description of the test Element D2.
	%  getName - returns the name of the test Element D2.
	%  getClass - returns the class of the test Element D2.
	%
	% ETD2 methods:
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
	% ETD2 methods (operators):
	%  isequal - determines whether two ETD2 are equal (values, locked)
	%
	% ETD2 methods (display):
	%  tostring - string with information about the ETD2
	%  disp - displays information about the ETD2
	%  tree - displays the element of ETD2
	%
	% ETD2 method (element list):
	%  getElementList - returns a list with all subelements of ETD2
	%
	% ETD2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETD2
	%
	% ETD2 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETD2
	%
	% ETD2 methods (copy):
	%  copy - copies the ETD2
	%  deepclone - deep-clones the ETD2
	%  clone - clones the ETD2
	%
	% ETD2 methods (inspection, Static):
	%  getClass - returns ETD2
	%  getName - returns the name of ETD2
	%  getDescription - returns the description of ETD2
	%  getProps - returns the property list of ETD2
	%  getPropNumber - returns the property number of ETD2
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
	% ETD2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETD2 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETD2 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETD2 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETD2 properties (Constant).
	%  UNO - 1
	%  UNO_TAG - 'uno'
	%  UNO_CATEGORY - 'd'
	%  UNO_FORMAT - 'nn'
	%  DUE - 2
	%  DUE_TAG - 'due'
	%  DUE_CATEGORY - 'd'
	%  DUE_FORMAT - 'nn'
	%  TRE - 3
	%  TRE_TAG - 'tre'
	%  TRE_CATEGORY - 'd'
	%  TRE_FORMAT - 'nn'
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
	% See also Element, Category, Format, ETD1.
	
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element D2.
			%
			% CLASS = ETD2.GETCLASS() returns the class 'ETD2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element D2 ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETD2') returns 'ETD2'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETD2';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element D2.
			%
			% NAME = ETD2.GETNAME() returns the name of the 'test Element D2'.
			%  Test Element D2.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element D2 ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETD2') returns the name of 'ETD2'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element D2';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element D2.
			%
			% STR = ETD2.GETDESCRIPTION() returns the description of the 'test Element D2'.
			%  which is:
			%
			%  ETD2 tests postprocessing.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element D2 ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETD2') returns the description of 'ETD2'.
			%
			% See also getClass, getName.
			
			et_description = [
				'ETD2 tests postprocessing.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element D2.
			%
			% PROPS = ETD2.GETPROPS() returns the property list of test Element D2.
			%
			% PROPS = ETD2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element D2 ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETD2'[, CATEGORY]) returns the property list of 'ETD2'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ETD1.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						ETD1.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						ETD1.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						ETD1.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						ETD1.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						ETD1.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						ETD1.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element D2.
			%
			% N = ETD2.GETPROPNUMBER() returns the property number of test Element D2.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element D2 ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETD2') returns the property number of 'ETD2'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 3;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element D2/error.
			%
			% CHECK = ETD2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETD2, PROP) checks whether PROP exists for ETD2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETD2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  Element.EXISTSPROP(ETD2, PROP) throws error if PROP does NOT exist for ETD2.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3 ]);
			else
				assert( ...
					ETD2.existsProp(prop), ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETD2.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element D2/error.
			%
			% CHECK = ETD2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETD2, TAG) checks whether TAG exists for ETD2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETD2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  Element.EXISTSTAG(ETD2, TAG) throws error if TAG does NOT exist for ETD2.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				etd2_tag_list = { 'uno'  'due'  'tre' };
				
				check = any(strcmpi(tag, etd2_tag_list));
			else
				assert( ...
					ETD2.existsTag(tag), ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETD2'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ETD2, POINTER) returns property number of POINTER of ETD2.
			%  PROPERTY = ET.GETPROPPROP(ETD2, POINTER) returns property number of POINTER of ETD2.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				etd2_tag_list = { 'uno'  'due'  'tre' };
				
				tag = pointer;
				ETD2.existsTag(tag);
				
				prop = find(strcmpi(tag, etd2_tag_list));
			else % numeric
				prop = pointer;
				ETD2.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ETD2, POINTER) returns tag of POINTER of ETD2.
			%  TAG = ET.GETPROPTAG(ETD2, POINTER) returns tag of POINTER of ETD2.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETD2.existsTag(tag);
			else % numeric
				prop = pointer;
				ETD2.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@ETD1(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(ETD2, POINTER) returns category of POINTER of ETD2.
			%  CATEGORY = ET.GETPROPCATEGORY(ETD2, POINTER) returns category of POINTER of ETD2.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@ETD1(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(ETD2, POINTER) returns format of POINTER of ETD2.
			%  FORMAT = ET.GETPROPFORMAT(ETD2, POINTER) returns format of POINTER of ETD2.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@ETD1(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETD2, POINTER) returns description of POINTER of ETD2.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETD2, POINTER) returns description of POINTER of ETD2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				case ETD2.UNO
					prop_description = 'UNO (data, scalar) is a data synchronized with DUE and TRE.';
				case ETD2.DUE
					prop_description = 'DUE (data, scalar) is a data synchronized with UNO and TRE.';
				case ETD2.TRE
					prop_description = 'TRE (data, scalar) is a data synchronized with UNO and DUE.';
				otherwise
					prop_description = getPropDescription@ETD1(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(ETD2, POINTER) returns settings of POINTER of ETD2.
			%  SETTINGS = ET.GETPROPSETTINGS(ETD2, POINTER) returns settings of POINTER of ETD2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@ETD1(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETD2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETD2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETD2, POINTER) returns the default value of POINTER of ETD2.
			%  DEFAULT = ET.GETPROPDEFAULT(ETD2, POINTER) returns the default value of POINTER of ETD2.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@ETD1(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETD2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETD2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETD2, POINTER) returns the conditioned default value of POINTER of ETD2.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETD2, POINTER) returns the conditioned default value of POINTER of ETD2.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETD2.getPropProp(pointer);
			
			prop_default = ETD2.conditioning(prop, ETD2.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ETD2, PROP, VALUE) checks VALUE format for PROP of ETD2.
			%  CHECK = ET.CHECKPROP(ETD2, PROP, VALUE) checks VALUE format for PROP of ETD2.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETD2:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  Element.CHECKPROP(ETD2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETD2.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			%  ET.CHECKPROP(ETD2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETD2.
			%   Error id: [BRAPH2:ETD2:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@ETD1(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETD2.getPropTag(prop) ' (' ETD2.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETD2(varargin)
			% ETD2() creates a test Element D2.
			%
			% ETD2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETD2(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETD2 properties is:
			%  <strong>1</strong> <strong>uno</strong> 	UNO (data, scalar) is a data synchronized with DUE and TRE.
			%  <strong>2</strong> <strong>due</strong> 	DUE (data, scalar) is a data synchronized with UNO and TRE.
			%  <strong>3</strong> <strong>tre</strong> 	TRE (data, scalar) is a data synchronized with UNO and DUE.
			%
			% See also Category, Format, set, check.
			
			et = et@ETD1(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETD2.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= ETD1.getPropNumber()
						value = conditioning@ETD1(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(et, prop)
			switch prop
				case ETD2.UNO
					if ~isa(et.getr('UNO'), 'NoValue') && isa(et.getr('DUE'), 'NoValue') && isa(et.getr('TRE'), 'NoValue')
					    et.set('DUE', et.get('UNO'), 'TRE', et.get('UNO'))
					end
					
				case ETD2.DUE
					if isa(et.getr('UNO'), 'NoValue') && ~isa(et.getr('DUE'), 'NoValue') && isa(et.getr('TRE'), 'NoValue')
					    et.set('UNO', et.get('DUE'), 'TRE', et.get('DUE'))
					end
					
				case ETD2.TRE
					if isa(et.getr('UNO'), 'NoValue') && isa(et.getr('DUE'), 'NoValue') && ~isa(et.getr('TRE'), 'NoValue')
					    et.set('UNO', et.get('TRE'), 'DUE', et.get('TRE'))
					end
					
				otherwise
					postprocessing@ETD1(et, prop);
					
			end
		end
	end
end
