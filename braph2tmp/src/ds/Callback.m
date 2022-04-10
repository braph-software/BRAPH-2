classdef (Sealed = true) Callback < Element
	% Callback is a callback for a property of an element.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% A callback refers to a property of another element, which are identified 
	% by its properties EL and PROP/TAG.
	% No element can be a subclass of Callback.
	%
	% The list of Callback properties is:
	%  <strong>1</strong> <strong>el</strong> 	EL (data, item) is the callback element.
	%  <strong>2</strong> <strong>prop</strong> 	PROP (data, scalar) is the callback property number.
	%  <strong>3</strong> <strong>tag</strong> 	TAG (data, string) is the callback property tag.
	%
	% Callback methods (constructor):
	% Callback - constructor
	%
	% Callback methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in callback/error.
	%  existsProp - checks whether property exists in callback/error.
	%  getPropNumber - returns the property number of callback.
	%  getProps - returns the property list of callback.
	%  getDescription - returns the description of the callback.
	%  getName - returns the name of the callback.
	%  getClass - returns the class of the callback.
	%
	% Callback methods:
	%  tostring - returns a string representing the callback.
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
	% Callback methods (operators):
	%  isequal - determines whether two Callback are equal (values, locked)
	%
	% Callback methods (display):
	%  tostring - string with information about the Callback
	%  disp - displays information about the Callback
	%  tree - displays the element of Callback
	%
	% Callback method (element list):
	%  getElementList - returns a list with all subelements of Callback
	%
	% Callback method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Callback
	%
	% Callback method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Callback
	%
	% Callback methods (copy):
	%  copy - copies the Callback
	%  deepclone - deep-clones the Callback
	%  clone - clones the Callback
	%
	% Callback methods (inspection, Static):
	%  getClass - returns Callback
	%  getName - returns the name of Callback
	%  getDescription - returns the description of Callback
	%  getProps - returns the property list of Callback
	%  getPropNumber - returns the property number of Callback
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
	% Callback methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Callback methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Callback methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Callback methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Callback properties (Constant).
	%  EL - 1
	%  EL_TAG - 'el'
	%  EL_CATEGORY - 'd'
	%  EL_FORMAT - 'it'
	%  PROP - 2
	%  PROP_TAG - 'prop'
	%  PROP_CATEGORY - 'd'
	%  PROP_FORMAT - 'nn'
	%  TAG - 3
	%  TAG_TAG - 'tag'
	%  TAG_CATEGORY - 'd'
	%  TAG_FORMAT - 'st'
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
		EL = 1;
		EL_TAG = 'el';
		EL_CATEGORY = Category.DATA;
		EL_FORMAT = Format.ITEM;
		
		PROP = 2;
		PROP_TAG = 'prop';
		PROP_CATEGORY = Category.DATA;
		PROP_FORMAT = Format.SCALAR;
		
		TAG = 3;
		TAG_TAG = 'tag';
		TAG_CATEGORY = Category.DATA;
		TAG_FORMAT = Format.STRING;
	end
	methods (Static) % inspection methods
		function cb_class = getClass()
			%GETCLASS returns the class of the callback.
			%
			% CLASS = Callback.GETCLASS() returns the class 'Callback'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CB.GETCLASS() returns the class of the callback CB.
			%  CLASS = Element.GETCLASS(CB) returns the class of 'CB'.
			%  CLASS = Element.GETCLASS('Callback') returns 'Callback'.
			%
			% See also getName, getDescription.
			
			cb_class = 'Callback';
		end
		function cb_name = getName()
			%GETNAME returns the name of the callback.
			%
			% NAME = Callback.GETNAME() returns the name of the 'callback'.
			%  Callback.
			%
			% Alternative forms to call this method are:
			%  NAME = CB.GETNAME() returns the name of the callback CB.
			%  NAME = Element.GETNAME(CB) returns the name of 'CB'.
			%  NAME = Element.GETNAME('Callback') returns the name of 'Callback'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			cb_name = 'Callback';
		end
		function cb_description = getDescription()
			%GETDESCRIPTION returns the description of the callback.
			%
			% STR = Callback.GETDESCRIPTION() returns the description of the 'callback'.
			%  which is:
			%
			%  A callback refers to a property of another element, which are identified 
			%  by its properties EL and PROP/TAG.
			%  No element can be a subclass of Callback.
			%
			% Alternative forms to call this method are:
			%  STR = CB.GETDESCRIPTION() returns the description of the callback CB.
			%  STR = Element.GETDESCRIPTION(CB) returns the description of 'CB'.
			%  STR = Element.GETDESCRIPTION('Callback') returns the description of 'Callback'.
			%
			% See also getClass, getName.
			
			cb_description = [
				'A callback refers to a property of another element, which are identified ' ...
				'by its properties EL and PROP/TAG.' ...
				'No element can be a subclass of Callback.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of callback.
			%
			% PROPS = Callback.GETPROPS() returns the property list of callback.
			%
			% PROPS = Callback.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CB.GETPROPS([CATEGORY]) returns the property list of the callback CB.
			%  PROPS = Element.GETPROPS(CB[, CATEGORY]) returns the property list of 'CB'.
			%  PROPS = Element.GETPROPS('Callback'[, CATEGORY]) returns the property list of 'Callback'.
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
						Callback.EL
						Callback.PROP
						Callback.TAG
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
						Callback.EL
						Callback.PROP
						Callback.TAG
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of callback.
			%
			% N = Callback.GETPROPNUMBER() returns the property number of callback.
			%
			% Alternative forms to call this method are:
			%  N = CB.GETPROPNUMBER() returns the property number of the callback CB.
			%  N = Element.GETPROPNUMBER(CB) returns the property number of 'CB'.
			%  N = Element.GETPROPNUMBER('Callback') returns the property number of 'Callback'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 3;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in callback/error.
			%
			% CHECK = Callback.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CB.EXISTSPROP(PROP) checks whether PROP exists for CB.
			%  CHECK = Element.EXISTSPROP(CB, PROP) checks whether PROP exists for CB.
			%  CHECK = Element.EXISTSPROP(Callback, PROP) checks whether PROP exists for Callback.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Callback:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CB.EXISTSPROP(PROP) throws error if PROP does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSPROP(CB, PROP) throws error if PROP does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSPROP(Callback, PROP) throws error if PROP does NOT exist for Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3 ]);
			else
				assert( ...
					Callback.existsProp(prop), ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Callback.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in callback/error.
			%
			% CHECK = Callback.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CB.EXISTSTAG(TAG) checks whether TAG exists for CB.
			%  CHECK = Element.EXISTSTAG(CB, TAG) checks whether TAG exists for CB.
			%  CHECK = Element.EXISTSTAG(Callback, TAG) checks whether TAG exists for Callback.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Callback:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CB.EXISTSTAG(TAG) throws error if TAG does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSTAG(CB, TAG) throws error if TAG does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSTAG(Callback, TAG) throws error if TAG does NOT exist for Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				callback_tag_list = { 'el'  'prop'  'tag' };
				
				check = any(strcmpi(tag, callback_tag_list));
			else
				assert( ...
					Callback.existsTag(tag), ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Callback'] ...
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
			%  PROPERTY = CB.GETPROPPROP(POINTER) returns property number of POINTER of CB.
			%  PROPERTY = Element.GETPROPPROP(Callback, POINTER) returns property number of POINTER of Callback.
			%  PROPERTY = CB.GETPROPPROP(Callback, POINTER) returns property number of POINTER of Callback.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				callback_tag_list = { 'el'  'prop'  'tag' };
				
				tag = pointer;
				Callback.existsTag(tag);
				
				prop = find(strcmpi(tag, callback_tag_list));
			else % numeric
				prop = pointer;
				Callback.existsProp(prop);
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
			%  TAG = CB.GETPROPTAG(POINTER) returns tag of POINTER of CB.
			%  TAG = Element.GETPROPTAG(Callback, POINTER) returns tag of POINTER of Callback.
			%  TAG = CB.GETPROPTAG(Callback, POINTER) returns tag of POINTER of Callback.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Callback.existsTag(tag);
			else % numeric
				prop = pointer;
				Callback.existsProp(prop);
				
				switch prop
					case Callback.EL
						tag = Callback.EL_TAG;
					case Callback.PROP
						tag = Callback.PROP_TAG;
					case Callback.TAG
						tag = Callback.TAG_TAG;
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
			%  CATEGORY = CB.GETPROPCATEGORY(POINTER) returns category of POINTER of CB.
			%  CATEGORY = Element.GETPROPCATEGORY(Callback, POINTER) returns category of POINTER of Callback.
			%  CATEGORY = CB.GETPROPCATEGORY(Callback, POINTER) returns category of POINTER of Callback.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					prop_category = Callback.EL_CATEGORY;
				case Callback.PROP
					prop_category = Callback.PROP_CATEGORY;
				case Callback.TAG
					prop_category = Callback.TAG_CATEGORY;
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
			%  FORMAT = CB.GETPROPFORMAT(POINTER) returns format of POINTER of CB.
			%  FORMAT = Element.GETPROPFORMAT(Callback, POINTER) returns format of POINTER of Callback.
			%  FORMAT = CB.GETPROPFORMAT(Callback, POINTER) returns format of POINTER of Callback.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					prop_format = Callback.EL_FORMAT;
				case Callback.PROP
					prop_format = Callback.PROP_FORMAT;
				case Callback.TAG
					prop_format = Callback.TAG_FORMAT;
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
			%  DESCRIPTION = CB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Callback, POINTER) returns description of POINTER of Callback.
			%  DESCRIPTION = CB.GETPROPDESCRIPTION(Callback, POINTER) returns description of POINTER of Callback.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					prop_description = 'EL (data, item) is the callback element.';
				case Callback.PROP
					prop_description = 'PROP (data, scalar) is the callback property number.';
				case Callback.TAG
					prop_description = 'TAG (data, string) is the callback property tag.';
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
			%  SETTINGS = CB.GETPROPSETTINGS(POINTER) returns settings of POINTER of CB.
			%  SETTINGS = Element.GETPROPSETTINGS(Callback, POINTER) returns settings of POINTER of Callback.
			%  SETTINGS = CB.GETPROPSETTINGS(Callback, POINTER) returns settings of POINTER of Callback.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case Callback.PROP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Callback.TAG
					prop_settings = Format.getFormatSettings(Format.STRING);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Callback.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Callback.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CB.
			%  DEFAULT = Element.GETPROPDEFAULT(Callback, POINTER) returns the default value of POINTER of Callback.
			%  DEFAULT = CB.GETPROPDEFAULT(Callback, POINTER) returns the default value of POINTER of Callback.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					prop_default = Format.getFormatDefault(Format.ITEM, Callback.getPropSettings(prop));
				case Callback.PROP
					prop_default = Format.getFormatDefault(Format.SCALAR, Callback.getPropSettings(prop));
				case Callback.TAG
					prop_default = Format.getFormatDefault(Format.STRING, Callback.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Callback.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Callback.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Callback, POINTER) returns the conditioned default value of POINTER of Callback.
			%  DEFAULT = CB.GETPROPDEFAULTCONDITIONED(Callback, POINTER) returns the conditioned default value of POINTER of Callback.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			prop_default = Callback.conditioning(prop, Callback.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CB.
			%  CHECK = Element.CHECKPROP(Callback, PROP, VALUE) checks VALUE format for PROP of Callback.
			%  CHECK = CB.CHECKPROP(Callback, PROP, VALUE) checks VALUE format for PROP of Callback.
			% 
			% CB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Callback:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.CHECKPROP(Callback, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  CB.CHECKPROP(Callback, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case Callback.EL
					check = Format.checkFormat(Format.ITEM, value, Callback.getPropSettings(prop));
				case Callback.PROP
					check = Format.checkFormat(Format.SCALAR, value, Callback.getPropSettings(prop));
				case Callback.TAG
					check = Format.checkFormat(Format.STRING, value, Callback.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Callback:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Callback.getPropTag(prop) ' (' Callback.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function cb = Callback(varargin)
			% Callback() creates a callback.
			%
			% Callback(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Callback(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Callback properties is:
			%  <strong>1</strong> <strong>el</strong> 	EL (data, item) is the callback element.
			%  <strong>2</strong> <strong>prop</strong> 	PROP (data, scalar) is the callback property number.
			%  <strong>3</strong> <strong>tag</strong> 	TAG (data, string) is the callback property tag.
			%
			% See also Category, Format, set, check.
			
			cb = cb@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Callback.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(cb, prop)
			switch prop
				case Callback.PROP
					el = cb.get('EL');
					if ~isa(el, 'NoValue')
					    tag = cb.get('TAG');
					    if cb.get('PROP') == 0 && ~isempty(tag)
					        cb.set('PROP', el.getPropProp(tag));
					    end
					end
					
				case Callback.TAG
					el = cb.get('EL');
					if ~isa(el, 'NoValue')
					    prop = cb.get('PROP');
					    if isempty(cb.get('TAG')) && prop ~= 0
					        cb.set('TAG', el.getPropTag(prop));
					    end
					end
					
				otherwise
					postprocessing@Element(cb, prop);
					
			end
		end
	end
	methods % methods
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
	end
end
