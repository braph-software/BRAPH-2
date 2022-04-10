classdef Group < Element
	% Group is a group of subjects.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Group represents a group of subjects whose class is defined in the property SUB_CLASS.
	% Group provides the methods necessary to handle groups of subjects. 
	% It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
	% whose methods can be used to inspect, add or remove subjects.
	%
	% The list of Group properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group of subjects.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group of subjects.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group of subjects.
	%  <strong>4</strong> <strong>sub_class</strong> 	SUB_CLASS (parameter, class) is the class of the subjects of the group.
	%  <strong>5</strong> <strong>sub_dict</strong> 	SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
	%
	% Group methods (constructor):
	% Group - constructor
	%
	% Group methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in group of subjects/error.
	%  existsProp - checks whether property exists in group of subjects/error.
	%  getPropNumber - returns the property number of group of subjects.
	%  getProps - returns the property list of group of subjects.
	%  getDescription - returns the description of the group of subjects.
	%  getName - returns the name of the group of subjects.
	%  getClass - returns the class of the group of subjects.
	%  getGUIMenuExport - sets a figure menu.
	%  getGUIMenuImport - sets a figure menu.
	%
	% Group methods:
	%  getPlotProp - returns a prop plot.
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
	% Group methods (operators):
	%  isequal - determines whether two Group are equal (values, locked)
	%
	% Group methods (display):
	%  tostring - string with information about the Group
	%  disp - displays information about the Group
	%  tree - displays the element of Group
	%
	% Group method (element list):
	%  getElementList - returns a list with all subelements of Group
	%
	% Group method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Group
	%
	% Group method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Group
	%
	% Group methods (copy):
	%  copy - copies the Group
	%  deepclone - deep-clones the Group
	%  clone - clones the Group
	%
	% Group methods (inspection, Static):
	%  getClass - returns Group
	%  getName - returns the name of Group
	%  getDescription - returns the description of Group
	%  getProps - returns the property list of Group
	%  getPropNumber - returns the property number of Group
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
	% Group methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Group methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Group methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Group methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Group properties (Constant).
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  LABEL - 2
	%  LABEL_TAG - 'label'
	%  LABEL_CATEGORY - 'm'
	%  LABEL_FORMAT - 'st'
	%  NOTES - 3
	%  NOTES_TAG - 'notes'
	%  NOTES_CATEGORY - 'm'
	%  NOTES_FORMAT - 'st'
	%  SUB_CLASS - 4
	%  SUB_CLASS_TAG - 'sub_class'
	%  SUB_CLASS_CATEGORY - 'p'
	%  SUB_CLASS_FORMAT - 'ca'
	%  SUB_DICT - 5
	%  SUB_DICT_TAG - 'sub_dict'
	%  SUB_DICT_CATEGORY - 'd'
	%  SUB_DICT_FORMAT - 'di'
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
	% See also Element, Subject, IndexedDictionary.
	
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = 2;
		LABEL_TAG = 'label';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = 3;
		NOTES_TAG = 'notes';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		SUB_CLASS = 4;
		SUB_CLASS_TAG = 'sub_class';
		SUB_CLASS_CATEGORY = Category.PARAMETER;
		SUB_CLASS_FORMAT = Format.CLASS;
		
		SUB_DICT = 5;
		SUB_DICT_TAG = 'sub_dict';
		SUB_DICT_CATEGORY = Category.DATA;
		SUB_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function gr_class = getClass()
			%GETCLASS returns the class of the group of subjects.
			%
			% CLASS = Group.GETCLASS() returns the class 'Group'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GR.GETCLASS() returns the class of the group of subjects GR.
			%  CLASS = Element.GETCLASS(GR) returns the class of 'GR'.
			%  CLASS = Element.GETCLASS('Group') returns 'Group'.
			%
			% See also getName, getDescription.
			
			gr_class = 'Group';
		end
		function gr_name = getName()
			%GETNAME returns the name of the group of subjects.
			%
			% NAME = Group.GETNAME() returns the name of the 'group of subjects'.
			%  Group Of Subjects.
			%
			% Alternative forms to call this method are:
			%  NAME = GR.GETNAME() returns the name of the group of subjects GR.
			%  NAME = Element.GETNAME(GR) returns the name of 'GR'.
			%  NAME = Element.GETNAME('Group') returns the name of 'Group'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			gr_name = 'Group Of Subjects';
		end
		function gr_description = getDescription()
			%GETDESCRIPTION returns the description of the group of subjects.
			%
			% STR = Group.GETDESCRIPTION() returns the description of the 'group of subjects'.
			%  which is:
			%
			%  Group represents a group of subjects whose class is defined in the property SUB_CLASS.
			%  Group provides the methods necessary to handle groups of subjects. 
			%  It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
			%  whose methods can be used to inspect, add or remove subjects.
			%
			% Alternative forms to call this method are:
			%  STR = GR.GETDESCRIPTION() returns the description of the group of subjects GR.
			%  STR = Element.GETDESCRIPTION(GR) returns the description of 'GR'.
			%  STR = Element.GETDESCRIPTION('Group') returns the description of 'Group'.
			%
			% See also getClass, getName.
			
			gr_description = [
				'Group represents a group of subjects whose class is defined in the property SUB_CLASS.' ...
				'Group provides the methods necessary to handle groups of subjects. ' ...
				'It manages the subjects as an indexed dictionary of subjects SUB_DICT, ' ...
				'whose methods can be used to inspect, add or remove subjects.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group of subjects.
			%
			% PROPS = Group.GETPROPS() returns the property list of group of subjects.
			%
			% PROPS = Group.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GR.GETPROPS([CATEGORY]) returns the property list of the group of subjects GR.
			%  PROPS = Element.GETPROPS(GR[, CATEGORY]) returns the property list of 'GR'.
			%  PROPS = Element.GETPROPS('Group'[, CATEGORY]) returns the property list of 'Group'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Group.LABEL
						Group.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						Group.SUB_CLASS
						];
				case Category.DATA
					prop_list = [
						Group.ID
						Group.SUB_DICT
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
						Group.ID
						Group.LABEL
						Group.NOTES
						Group.SUB_CLASS
						Group.SUB_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of group of subjects.
			%
			% N = Group.GETPROPNUMBER() returns the property number of group of subjects.
			%
			% Alternative forms to call this method are:
			%  N = GR.GETPROPNUMBER() returns the property number of the group of subjects GR.
			%  N = Element.GETPROPNUMBER(GR) returns the property number of 'GR'.
			%  N = Element.GETPROPNUMBER('Group') returns the property number of 'Group'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in group of subjects/error.
			%
			% CHECK = Group.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSPROP(PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(GR, PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(Group, PROP) checks whether PROP exists for Group.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Group:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSPROP(PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSPROP(GR, PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSPROP(Group, PROP) throws error if PROP does NOT exist for Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					Group.existsProp(prop), ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Group.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group of subjects/error.
			%
			% CHECK = Group.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSTAG(TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(GR, TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(Group, TAG) checks whether TAG exists for Group.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Group:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSTAG(TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSTAG(GR, TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSTAG(Group, TAG) throws error if TAG does NOT exist for Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				group_tag_list = { 'id'  'label'  'notes'  'sub_class'  'sub_dict' };
				
				check = any(strcmpi(tag, group_tag_list));
			else
				assert( ...
					Group.existsTag(tag), ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Group'] ...
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
			%  PROPERTY = GR.GETPROPPROP(POINTER) returns property number of POINTER of GR.
			%  PROPERTY = Element.GETPROPPROP(Group, POINTER) returns property number of POINTER of Group.
			%  PROPERTY = GR.GETPROPPROP(Group, POINTER) returns property number of POINTER of Group.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				group_tag_list = { 'id'  'label'  'notes'  'sub_class'  'sub_dict' };
				
				tag = pointer;
				Group.existsTag(tag);
				
				prop = find(strcmpi(tag, group_tag_list));
			else % numeric
				prop = pointer;
				Group.existsProp(prop);
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
			%  TAG = GR.GETPROPTAG(POINTER) returns tag of POINTER of GR.
			%  TAG = Element.GETPROPTAG(Group, POINTER) returns tag of POINTER of Group.
			%  TAG = GR.GETPROPTAG(Group, POINTER) returns tag of POINTER of Group.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Group.existsTag(tag);
			else % numeric
				prop = pointer;
				Group.existsProp(prop);
				
				switch prop
					case Group.ID
						tag = Group.ID_TAG;
					case Group.LABEL
						tag = Group.LABEL_TAG;
					case Group.NOTES
						tag = Group.NOTES_TAG;
					case Group.SUB_CLASS
						tag = Group.SUB_CLASS_TAG;
					case Group.SUB_DICT
						tag = Group.SUB_DICT_TAG;
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
			%  CATEGORY = GR.GETPROPCATEGORY(POINTER) returns category of POINTER of GR.
			%  CATEGORY = Element.GETPROPCATEGORY(Group, POINTER) returns category of POINTER of Group.
			%  CATEGORY = GR.GETPROPCATEGORY(Group, POINTER) returns category of POINTER of Group.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					prop_category = Group.ID_CATEGORY;
				case Group.LABEL
					prop_category = Group.LABEL_CATEGORY;
				case Group.NOTES
					prop_category = Group.NOTES_CATEGORY;
				case Group.SUB_CLASS
					prop_category = Group.SUB_CLASS_CATEGORY;
				case Group.SUB_DICT
					prop_category = Group.SUB_DICT_CATEGORY;
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
			%  FORMAT = GR.GETPROPFORMAT(POINTER) returns format of POINTER of GR.
			%  FORMAT = Element.GETPROPFORMAT(Group, POINTER) returns format of POINTER of Group.
			%  FORMAT = GR.GETPROPFORMAT(Group, POINTER) returns format of POINTER of Group.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					prop_format = Group.ID_FORMAT;
				case Group.LABEL
					prop_format = Group.LABEL_FORMAT;
				case Group.NOTES
					prop_format = Group.NOTES_FORMAT;
				case Group.SUB_CLASS
					prop_format = Group.SUB_CLASS_FORMAT;
				case Group.SUB_DICT
					prop_format = Group.SUB_DICT_FORMAT;
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
			%  DESCRIPTION = GR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Group, POINTER) returns description of POINTER of Group.
			%  DESCRIPTION = GR.GETPROPDESCRIPTION(Group, POINTER) returns description of POINTER of Group.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					prop_description = 'ID (data, string) is a few-letter code for the group of subjects.';
				case Group.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group of subjects.';
				case Group.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group of subjects.';
				case Group.SUB_CLASS
					prop_description = 'SUB_CLASS (parameter, class) is the class of the subjects of the group.';
				case Group.SUB_DICT
					prop_description = 'SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.';
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
			%  SETTINGS = GR.GETPROPSETTINGS(POINTER) returns settings of POINTER of GR.
			%  SETTINGS = Element.GETPROPSETTINGS(Group, POINTER) returns settings of POINTER of Group.
			%  SETTINGS = GR.GETPROPSETTINGS(Group, POINTER) returns settings of POINTER of Group.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Group.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Group.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Group.SUB_CLASS
					prop_settings = 'Subject';
				case Group.SUB_DICT
					prop_settings = 'Subject';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Group.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Group.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULT(Group, POINTER) returns the default value of POINTER of Group.
			%  DEFAULT = GR.GETPROPDEFAULT(Group, POINTER) returns the default value of POINTER of Group.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					prop_default = Format.getFormatDefault(Format.STRING, Group.getPropSettings(prop));
				case Group.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Group.getPropSettings(prop));
				case Group.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Group.getPropSettings(prop));
				case Group.SUB_CLASS
					prop_default = Format.getFormatDefault(Format.CLASS, Group.getPropSettings(prop));
				case Group.SUB_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Group.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Group.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Group.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Group, POINTER) returns the conditioned default value of POINTER of Group.
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(Group, POINTER) returns the conditioned default value of POINTER of Group.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			prop_default = Group.conditioning(prop, Group.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GR.
			%  CHECK = Element.CHECKPROP(Group, PROP, VALUE) checks VALUE format for PROP of Group.
			%  CHECK = GR.CHECKPROP(Group, PROP, VALUE) checks VALUE format for PROP of Group.
			% 
			% GR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Group:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.CHECKPROP(Group, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  GR.CHECKPROP(Group, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.ID
					check = Format.checkFormat(Format.STRING, value, Group.getPropSettings(prop));
				case Group.LABEL
					check = Format.checkFormat(Format.STRING, value, Group.getPropSettings(prop));
				case Group.NOTES
					check = Format.checkFormat(Format.STRING, value, Group.getPropSettings(prop));
				case Group.SUB_CLASS
					check = Format.checkFormat(Format.CLASS, value, Group.getPropSettings(prop));
				case Group.SUB_DICT
					check = Format.checkFormat(Format.IDICT, value, Group.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Group.getPropTag(prop) ' (' Group.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function gr = Group(varargin)
			% Group() creates a group of subjects.
			%
			% Group(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Group(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Group properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group of subjects.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group of subjects.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group of subjects.
			%  <strong>4</strong> <strong>sub_class</strong> 	SUB_CLASS (parameter, class) is the class of the subjects of the group.
			%  <strong>5</strong> <strong>sub_dict</strong> 	SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
			%
			% See also Category, Format, set, check.
			
			gr = gr@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Group.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(gr, prop, varargin)
			%GETPLOTPROP returns a prop plot.
			%
			% PR = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
			%
			% PR = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
			%
			% See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
			%  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
			%  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.
			
			switch prop
				case Group.NOTES
					pr = PlotPropString('EL', gr, 'PROP', Group.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case Group.SUB_DICT
					pr = PPGroup_SUBDict('EL', gr, 'PROP', Group.SUB_DICT, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(gr, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			eval([el.get('SUB_CLASS') '.getGUIMenuImport(el, menu_import, pe)']);
			im_sub_menus = get(menu_import, 'Children');
			delete(im_sub_menus(end)); % delete one sub menu to import JSON
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			eval([el.get('SUB_CLASS') '.getGUIMenuExport(el, menu_export, pe)']);
			ex_sub_menus = get(menu_export, 'Children');
			delete(ex_sub_menus(end)); % delete one sub menu to export JSON
			
		end
	end
end
