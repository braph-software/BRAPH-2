classdef (Sealed = true) NoValue < Element
	% NoValue represents a value that has not been set or calculated.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% NoValue is an element without values used to represent a value that has
	% not been set (for properties of categories METADATA, PARAMETER, DATA, FIGURE or GUI) 
	% or calculated (for properties of category RESULT). 
	% For computational efficiency, it is best to use only one instance of NV 
	% using NoValue.getNoValue(), instead of creating new instances using the 
	% constructor NoValue(). 
	% No element can be a subclass of NoValue.
	%
	% The list of NoValue properties is:
	%
	% NoValue methods (constructor):
	% NoValue - constructor
	%
	% NoValue methods (Static):
	%  getNoValue - returns a pointer to a persistent instance of NoValue.
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in NoValue/error.
	%  existsProp - checks whether property exists in NoValue/error.
	%  getPropNumber - returns the property number of NoValue.
	%  getProps - returns the property list of NoValue.
	%  getDescription - returns the description of the NoValue.
	%  getName - returns the name of the NoValue.
	%  getClass - returns the class of the NoValue.
	%
	% NoValue methods:
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
	% NoValue methods (operators):
	%  isequal - determines whether two NoValue are equal (values, locked)
	%
	% NoValue methods (display):
	%  tostring - string with information about the NoValue
	%  disp - displays information about the NoValue
	%  tree - displays the element of NoValue
	%
	% NoValue method (element list):
	%  getElementList - returns a list with all subelements of NoValue
	%
	% NoValue method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NoValue
	%
	% NoValue method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NoValue
	%
	% NoValue methods (copy):
	%  copy - copies the NoValue
	%  deepclone - deep-clones the NoValue
	%  clone - clones the NoValue
	%
	% NoValue methods (inspection, Static):
	%  getClass - returns NoValue
	%  getName - returns the name of NoValue
	%  getDescription - returns the description of NoValue
	%  getProps - returns the property list of NoValue
	%  getPropNumber - returns the property number of NoValue
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
	% NoValue methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NoValue methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NoValue methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NoValue methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NoValue properties (Constant).
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
	
	methods (Static) % static methods
		function nv = getNoValue()
		    %GETNOVALUE returns a pointer to a persistent instance of NoValue.
		    %
		    % NV = GETNOVALUE() returns a pointer to a persistent instance of NoValue.
		    %  For computational efficiency, it is best to use NoValue.getNoValue(),
		    %  instead of creating new instances using the  constructor NoValue().
		
		    persistent local_nv
		    
		    if isempty(local_nv) || ~isvalid(local_nv)
		        local_nv = NoValue();
		    end
		    nv = local_nv;
		end
	end
	methods (Static) % inspection methods
		function nv_class = getClass()
			%GETCLASS returns the class of the NoValue.
			%
			% CLASS = NoValue.GETCLASS() returns the class 'NoValue'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NV.GETCLASS() returns the class of the NoValue NV.
			%  CLASS = Element.GETCLASS(NV) returns the class of 'NV'.
			%  CLASS = Element.GETCLASS('NoValue') returns 'NoValue'.
			%
			% See also getName, getDescription.
			
			nv_class = 'NoValue';
		end
		function nv_name = getName()
			%GETNAME returns the name of the NoValue.
			%
			% NAME = NoValue.GETNAME() returns the name of the 'NoValue'.
			%  NoValue.
			%
			% Alternative forms to call this method are:
			%  NAME = NV.GETNAME() returns the name of the NoValue NV.
			%  NAME = Element.GETNAME(NV) returns the name of 'NV'.
			%  NAME = Element.GETNAME('NoValue') returns the name of 'NoValue'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nv_name = 'NoValue';
		end
		function nv_description = getDescription()
			%GETDESCRIPTION returns the description of the NoValue.
			%
			% STR = NoValue.GETDESCRIPTION() returns the description of the 'NoValue'.
			%  which is:
			%
			%  NoValue is an element without values used to represent a value that has
			%  not been set (for properties of categories METADATA, PARAMETER, DATA, FIGURE or GUI) 
			%  or calculated (for properties of category RESULT). 
			%  For computational efficiency, it is best to use only one instance of NV 
			%  using NoValue.getNoValue(), instead of creating new instances using the 
			%  constructor NoValue(). 
			%  No element can be a subclass of NoValue.
			%
			% Alternative forms to call this method are:
			%  STR = NV.GETDESCRIPTION() returns the description of the NoValue NV.
			%  STR = Element.GETDESCRIPTION(NV) returns the description of 'NV'.
			%  STR = Element.GETDESCRIPTION('NoValue') returns the description of 'NoValue'.
			%
			% See also getClass, getName.
			
			nv_description = [
				'NoValue is an element without values used to represent a value that has' ...
				'not been set (for properties of categories METADATA, PARAMETER, DATA, FIGURE or GUI) ' ...
				'or calculated (for properties of category RESULT). ' ...
				'For computational efficiency, it is best to use only one instance of NV ' ...
				'using NoValue.getNoValue(), instead of creating new instances using the ' ...
				'constructor NoValue(). ' ...
				'No element can be a subclass of NoValue.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of NoValue.
			%
			% PROPS = NoValue.GETPROPS() returns the property list of NoValue.
			%
			% PROPS = NoValue.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NV.GETPROPS([CATEGORY]) returns the property list of the NoValue NV.
			%  PROPS = Element.GETPROPS(NV[, CATEGORY]) returns the property list of 'NV'.
			%  PROPS = Element.GETPROPS('NoValue'[, CATEGORY]) returns the property list of 'NoValue'.
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
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of NoValue.
			%
			% N = NoValue.GETPROPNUMBER() returns the property number of NoValue.
			%
			% Alternative forms to call this method are:
			%  N = NV.GETPROPNUMBER() returns the property number of the NoValue NV.
			%  N = Element.GETPROPNUMBER(NV) returns the property number of 'NV'.
			%  N = Element.GETPROPNUMBER('NoValue') returns the property number of 'NoValue'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 0;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in NoValue/error.
			%
			% CHECK = NoValue.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NV.EXISTSPROP(PROP) checks whether PROP exists for NV.
			%  CHECK = Element.EXISTSPROP(NV, PROP) checks whether PROP exists for NV.
			%  CHECK = Element.EXISTSPROP(NoValue, PROP) checks whether PROP exists for NoValue.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSPROP(NV, PROP) throws error if PROP does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSPROP(NoValue, PROP) throws error if PROP does NOT exist for NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				check = any(prop == NoValue.getProps());
			else
				assert( ...
					NoValue.existsProp(prop), ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NoValue.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in NoValue/error.
			%
			% CHECK = NoValue.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NV.EXISTSTAG(TAG) checks whether TAG exists for NV.
			%  CHECK = Element.EXISTSTAG(NV, TAG) checks whether TAG exists for NV.
			%  CHECK = Element.EXISTSTAG(NoValue, TAG) checks whether TAG exists for NoValue.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSTAG(NV, TAG) throws error if TAG does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSTAG(NoValue, TAG) throws error if TAG does NOT exist for NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%
			% See also getProps, existsTag.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			persistent novalue_tag_list
			if isempty(novalue_tag_list)
				novalue_tag_list = cellfun(@(x) NoValue.getPropTag(x), num2cell(NoValue.getProps()), 'UniformOutput', false);
			end
			
			if nargout == 1
				check = any(strcmpi(tag, novalue_tag_list));
			else
				assert( ...
					NoValue.existsTag(tag), ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NoValue'] ...
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
			%  PROPERTY = NV.GETPROPPROP(POINTER) returns property number of POINTER of NV.
			%  PROPERTY = Element.GETPROPPROP(NoValue, POINTER) returns property number of POINTER of NoValue.
			%  PROPERTY = NV.GETPROPPROP(NoValue, POINTER) returns property number of POINTER of NoValue.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			persistent novalue_tag_list
			if isempty(novalue_tag_list)
				novalue_tag_list = cellfun(@(x) NoValue.getPropTag(x), num2cell(NoValue.getProps()), 'UniformOutput', false);
			end
			
			if ischar(pointer)
				tag = pointer;
				NoValue.existsTag(tag);
				
				prop = find(strcmpi(tag, novalue_tag_list));
			else % numeric
				prop = pointer;
				NoValue.existsProp(prop);
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
			%  TAG = NV.GETPROPTAG(POINTER) returns tag of POINTER of NV.
			%  TAG = Element.GETPROPTAG(NoValue, POINTER) returns tag of POINTER of NoValue.
			%  TAG = NV.GETPROPTAG(NoValue, POINTER) returns tag of POINTER of NoValue.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NoValue.existsTag(tag);
			else % numeric
				prop = pointer;
				NoValue.existsProp(prop);
				
				switch prop
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
			%  CATEGORY = NV.GETPROPCATEGORY(POINTER) returns category of POINTER of NV.
			%  CATEGORY = Element.GETPROPCATEGORY(NoValue, POINTER) returns category of POINTER of NoValue.
			%  CATEGORY = NV.GETPROPCATEGORY(NoValue, POINTER) returns category of POINTER of NoValue.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
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
			%  FORMAT = NV.GETPROPFORMAT(POINTER) returns format of POINTER of NV.
			%  FORMAT = Element.GETPROPFORMAT(NoValue, POINTER) returns format of POINTER of NoValue.
			%  FORMAT = NV.GETPROPFORMAT(NoValue, POINTER) returns format of POINTER of NoValue.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
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
			%  DESCRIPTION = NV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NoValue, POINTER) returns description of POINTER of NoValue.
			%  DESCRIPTION = NV.GETPROPDESCRIPTION(NoValue, POINTER) returns description of POINTER of NoValue.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
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
			%  SETTINGS = NV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NV.
			%  SETTINGS = Element.GETPROPSETTINGS(NoValue, POINTER) returns settings of POINTER of NoValue.
			%  SETTINGS = NV.GETPROPSETTINGS(NoValue, POINTER) returns settings of POINTER of NoValue.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NoValue.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NoValue.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NV.
			%  DEFAULT = Element.GETPROPDEFAULT(NoValue, POINTER) returns the default value of POINTER of NoValue.
			%  DEFAULT = NV.GETPROPDEFAULT(NoValue, POINTER) returns the default value of POINTER of NoValue.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NoValue.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NoValue.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NoValue, POINTER) returns the conditioned default value of POINTER of NoValue.
			%  DEFAULT = NV.GETPROPDEFAULTCONDITIONED(NoValue, POINTER) returns the conditioned default value of POINTER of NoValue.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			prop_default = NoValue.conditioning(prop, NoValue.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NV.
			%  CHECK = Element.CHECKPROP(NoValue, PROP, VALUE) checks VALUE format for PROP of NoValue.
			%  CHECK = NV.CHECKPROP(NoValue, PROP, VALUE) checks VALUE format for PROP of NoValue.
			% 
			% NV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NoValue:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.CHECKPROP(NoValue, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  NV.CHECKPROP(NoValue, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NoValue:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NoValue.getPropTag(prop) ' (' NoValue.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nv = NoValue(varargin)
			% NoValue() creates a NoValue.
			%
			% NoValue(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NoValue(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NoValue properties is:
			%
			% See also Category, Format, set, check.
			
			nv = nv@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NoValue.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
