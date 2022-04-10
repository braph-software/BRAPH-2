classdef ETD1 < Element
	% ETD1 tests multiple values with checks.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% ETD1 tests multiple values with checks.
	%
	% The list of ETD1 properties is:
	%  <strong>1</strong> <strong>uno</strong> 	UNO (data, scalar) is a data synchronized with DUE and TRE.
	%  <strong>2</strong> <strong>due</strong> 	DUE (data, scalar) is a data synchronized with UNO and TRE.
	%  <strong>3</strong> <strong>tre</strong> 	TRE (data, scalar) is a data synchronized with UNO and DUE.
	%
	% ETD1 methods (constructor):
	% ETD1 - constructor
	%
	% ETD1 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element D1/error.
	%  existsProp - checks whether property exists in test Element D1/error.
	%  getPropNumber - returns the property number of test Element D1.
	%  getProps - returns the property list of test Element D1.
	%  getDescription - returns the description of the test Element D1.
	%  getName - returns the name of the test Element D1.
	%  getClass - returns the class of the test Element D1.
	%
	% ETD1 methods:
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
	% ETD1 methods (operators):
	%  isequal - determines whether two ETD1 are equal (values, locked)
	%
	% ETD1 methods (display):
	%  tostring - string with information about the ETD1
	%  disp - displays information about the ETD1
	%  tree - displays the element of ETD1
	%
	% ETD1 method (element list):
	%  getElementList - returns a list with all subelements of ETD1
	%
	% ETD1 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETD1
	%
	% ETD1 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETD1
	%
	% ETD1 methods (copy):
	%  copy - copies the ETD1
	%  deepclone - deep-clones the ETD1
	%  clone - clones the ETD1
	%
	% ETD1 methods (inspection, Static):
	%  getClass - returns ETD1
	%  getName - returns the name of ETD1
	%  getDescription - returns the description of ETD1
	%  getProps - returns the property list of ETD1
	%  getPropNumber - returns the property number of ETD1
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
	% ETD1 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETD1 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETD1 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETD1 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETD1 properties (Constant).
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
	% See also Element, Category, Format, ETD2.
	
	properties (Constant) % properties
		UNO = 1;
		UNO_TAG = 'uno';
		UNO_CATEGORY = Category.DATA;
		UNO_FORMAT = Format.SCALAR;
		
		DUE = 2;
		DUE_TAG = 'due';
		DUE_CATEGORY = Category.DATA;
		DUE_FORMAT = Format.SCALAR;
		
		TRE = 3;
		TRE_TAG = 'tre';
		TRE_CATEGORY = Category.DATA;
		TRE_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element D1.
			%
			% CLASS = ETD1.GETCLASS() returns the class 'ETD1'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element D1 ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETD1') returns 'ETD1'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETD1';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element D1.
			%
			% NAME = ETD1.GETNAME() returns the name of the 'test Element D1'.
			%  Test Element D1.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element D1 ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETD1') returns the name of 'ETD1'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element D1';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element D1.
			%
			% STR = ETD1.GETDESCRIPTION() returns the description of the 'test Element D1'.
			%  which is:
			%
			%  ETD1 tests multiple values with checks.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element D1 ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETD1') returns the description of 'ETD1'.
			%
			% See also getClass, getName.
			
			et_description = [
				'ETD1 tests multiple values with checks.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element D1.
			%
			% PROPS = ETD1.GETPROPS() returns the property list of test Element D1.
			%
			% PROPS = ETD1.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element D1 ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETD1'[, CATEGORY]) returns the property list of 'ETD1'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						ETD1.UNO
						ETD1.DUE
						ETD1.TRE
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
						ETD1.UNO
						ETD1.DUE
						ETD1.TRE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element D1.
			%
			% N = ETD1.GETPROPNUMBER() returns the property number of test Element D1.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element D1 ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETD1') returns the property number of 'ETD1'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 3;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element D1/error.
			%
			% CHECK = ETD1.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETD1, PROP) checks whether PROP exists for ETD1.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETD1:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  Element.EXISTSPROP(ETD1, PROP) throws error if PROP does NOT exist for ETD1.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3 ]);
			else
				assert( ...
					ETD1.existsProp(prop), ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETD1.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element D1/error.
			%
			% CHECK = ETD1.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETD1, TAG) checks whether TAG exists for ETD1.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETD1:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  Element.EXISTSTAG(ETD1, TAG) throws error if TAG does NOT exist for ETD1.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				etd1_tag_list = { 'uno'  'due'  'tre' };
				
				check = any(strcmpi(tag, etd1_tag_list));
			else
				assert( ...
					ETD1.existsTag(tag), ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETD1'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ETD1, POINTER) returns property number of POINTER of ETD1.
			%  PROPERTY = ET.GETPROPPROP(ETD1, POINTER) returns property number of POINTER of ETD1.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				etd1_tag_list = { 'uno'  'due'  'tre' };
				
				tag = pointer;
				ETD1.existsTag(tag);
				
				prop = find(strcmpi(tag, etd1_tag_list));
			else % numeric
				prop = pointer;
				ETD1.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ETD1, POINTER) returns tag of POINTER of ETD1.
			%  TAG = ET.GETPROPTAG(ETD1, POINTER) returns tag of POINTER of ETD1.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETD1.existsTag(tag);
			else % numeric
				prop = pointer;
				ETD1.existsProp(prop);
				
				switch prop
					case ETD1.UNO
						tag = ETD1.UNO_TAG;
					case ETD1.DUE
						tag = ETD1.DUE_TAG;
					case ETD1.TRE
						tag = ETD1.TRE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ETD1, POINTER) returns category of POINTER of ETD1.
			%  CATEGORY = ET.GETPROPCATEGORY(ETD1, POINTER) returns category of POINTER of ETD1.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					prop_category = ETD1.UNO_CATEGORY;
				case ETD1.DUE
					prop_category = ETD1.DUE_CATEGORY;
				case ETD1.TRE
					prop_category = ETD1.TRE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ETD1, POINTER) returns format of POINTER of ETD1.
			%  FORMAT = ET.GETPROPFORMAT(ETD1, POINTER) returns format of POINTER of ETD1.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					prop_format = ETD1.UNO_FORMAT;
				case ETD1.DUE
					prop_format = ETD1.DUE_FORMAT;
				case ETD1.TRE
					prop_format = ETD1.TRE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETD1, POINTER) returns description of POINTER of ETD1.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETD1, POINTER) returns description of POINTER of ETD1.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					prop_description = 'UNO (data, scalar) is a data synchronized with DUE and TRE.';
				case ETD1.DUE
					prop_description = 'DUE (data, scalar) is a data synchronized with UNO and TRE.';
				case ETD1.TRE
					prop_description = 'TRE (data, scalar) is a data synchronized with UNO and DUE.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ETD1, POINTER) returns settings of POINTER of ETD1.
			%  SETTINGS = ET.GETPROPSETTINGS(ETD1, POINTER) returns settings of POINTER of ETD1.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETD1.DUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETD1.TRE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETD1.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETD1.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETD1, POINTER) returns the default value of POINTER of ETD1.
			%  DEFAULT = ET.GETPROPDEFAULT(ETD1, POINTER) returns the default value of POINTER of ETD1.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					prop_default = Format.getFormatDefault(Format.SCALAR, ETD1.getPropSettings(prop));
				case ETD1.DUE
					prop_default = Format.getFormatDefault(Format.SCALAR, ETD1.getPropSettings(prop));
				case ETD1.TRE
					prop_default = Format.getFormatDefault(Format.SCALAR, ETD1.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETD1.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETD1.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETD1, POINTER) returns the conditioned default value of POINTER of ETD1.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETD1, POINTER) returns the conditioned default value of POINTER of ETD1.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETD1.getPropProp(pointer);
			
			prop_default = ETD1.conditioning(prop, ETD1.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ETD1, PROP, VALUE) checks VALUE format for PROP of ETD1.
			%  CHECK = ET.CHECKPROP(ETD1, PROP, VALUE) checks VALUE format for PROP of ETD1.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETD1:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  Element.CHECKPROP(ETD1, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETD1.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			%  ET.CHECKPROP(ETD1, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETD1.
			%   Error id: [BRAPH2:ETD1:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				case ETD1.UNO
					check = Format.checkFormat(Format.SCALAR, value, ETD1.getPropSettings(prop));
				case ETD1.DUE
					check = Format.checkFormat(Format.SCALAR, value, ETD1.getPropSettings(prop));
				case ETD1.TRE
					check = Format.checkFormat(Format.SCALAR, value, ETD1.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETD1.getPropTag(prop) ' (' ETD1.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETD1(varargin)
			% ETD1() creates a test Element D1.
			%
			% ETD1(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETD1(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETD1 properties is:
			%  <strong>1</strong> <strong>uno</strong> 	UNO (data, scalar) is a data synchronized with DUE and TRE.
			%  <strong>2</strong> <strong>due</strong> 	DUE (data, scalar) is a data synchronized with UNO and TRE.
			%  <strong>3</strong> <strong>tre</strong> 	TRE (data, scalar) is a data synchronized with UNO and DUE.
			%
			% See also Category, Format, set, check.
			
			et = et@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETD1.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(et, prop, value)
			check = true;
			msg = ['Error while checking' tostring(et) ' ' et.getPropTag(prop) '.'];
			
			switch prop
				case ETD1.UNO
					check = value == et.get('DUE') && value == et.get('TRE');
					if ~check
					    msg = 'UNO, DUE and TRE must have the same values';
					else
					    msg = 'ok';
					end
					
				case ETD1.DUE
					check = value == et.get('UNO') && value == et.get('TRE');
					if ~check
					    msg = 'UNO, DUE and TRE must have the same values';
					else
					    msg = 'ok';
					end
					
				case ETD1.TRE
					check = value == et.get('UNO') && value == et.get('DUE');
					if ~check
					    msg = 'UNO, DUE and TRE must have the same values';
					else
					    msg = 'ok';
					end
					
				otherwise
					[check, msg] = checkValue@Element(et, prop, value);
					
			end
		end
	end
end
