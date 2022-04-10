classdef NNGroup < Group
	% NNGroup is a group of subjects for a neural network analysis.
	% It is a subclass of <a href="matlab:help Group">Group</a>.
	%
	% NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.
	% NNGroup provides the ready-to-use inputs and targets from all NN subjects, for 
	% performing a neural network analysis.
	%
	% The list of NNGroup properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group of subjects.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group of subjects.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group of subjects.
	%  <strong>4</strong> <strong>sub_class</strong> 	SUB_CLASS (parameter, class) is the class of the subjects of the group.
	%  <strong>5</strong> <strong>sub_dict</strong> 	SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
	%  <strong>6</strong> <strong>inputs</strong> 	INPUTS (result, cell) is a collection of the input from all NN subjects.
	%  <strong>7</strong> <strong>targets</strong> 	TARGETS (result, cell) is a collection of the target from all NN subjects.
	%  <strong>8</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
	%
	% NNGroup methods (constructor):
	% NNGroup - constructor
	%
	% NNGroup methods (Static):
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
	% NNGroup methods:
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
	% NNGroup methods (operators):
	%  isequal - determines whether two NNGroup are equal (values, locked)
	%
	% NNGroup methods (display):
	%  tostring - string with information about the NNGroup
	%  disp - displays information about the NNGroup
	%  tree - displays the element of NNGroup
	%
	% NNGroup method (element list):
	%  getElementList - returns a list with all subelements of NNGroup
	%
	% NNGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNGroup
	%
	% NNGroup method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNGroup
	%
	% NNGroup methods (copy):
	%  copy - copies the NNGroup
	%  deepclone - deep-clones the NNGroup
	%  clone - clones the NNGroup
	%
	% NNGroup methods (inspection, Static):
	%  getClass - returns NNGroup
	%  getName - returns the name of NNGroup
	%  getDescription - returns the description of NNGroup
	%  getProps - returns the property list of NNGroup
	%  getPropNumber - returns the property number of NNGroup
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
	% NNGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNGroup methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNGroup methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNGroup methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNGroup properties (Constant).
	%  INPUTS - 6
	%  INPUTS_TAG - 'inputs'
	%  INPUTS_CATEGORY - 'r'
	%  INPUTS_FORMAT - 'll'
	%  TARGETS - 7
	%  TARGETS_TAG - 'targets'
	%  TARGETS_CATEGORY - 'r'
	%  TARGETS_FORMAT - 'll'
	%  G - 8
	%  G_TAG - 'g'
	%  G_CATEGORY - 'r'
	%  G_FORMAT - 'it'
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
	% See also Group, NNSubject.
	
	properties (Constant) % properties
		INPUTS = Group.getPropNumber() + 1;
		INPUTS_TAG = 'inputs';
		INPUTS_CATEGORY = Category.RESULT;
		INPUTS_FORMAT = Format.CELL;
		
		TARGETS = Group.getPropNumber() + 2;
		TARGETS_TAG = 'targets';
		TARGETS_CATEGORY = Category.RESULT;
		TARGETS_FORMAT = Format.CELL;
		
		G = Group.getPropNumber() + 3;
		G_TAG = 'g';
		G_CATEGORY = Category.RESULT;
		G_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function gr_class = getClass()
			%GETCLASS returns the class of the group of subjects.
			%
			% CLASS = NNGroup.GETCLASS() returns the class 'NNGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GR.GETCLASS() returns the class of the group of subjects GR.
			%  CLASS = Element.GETCLASS(GR) returns the class of 'GR'.
			%  CLASS = Element.GETCLASS('NNGroup') returns 'NNGroup'.
			%
			% See also getName, getDescription.
			
			gr_class = 'NNGroup';
		end
		function gr_name = getName()
			%GETNAME returns the name of the group of subjects.
			%
			% NAME = NNGroup.GETNAME() returns the name of the 'group of subjects'.
			%  Group Of Subjects.
			%
			% Alternative forms to call this method are:
			%  NAME = GR.GETNAME() returns the name of the group of subjects GR.
			%  NAME = Element.GETNAME(GR) returns the name of 'GR'.
			%  NAME = Element.GETNAME('NNGroup') returns the name of 'NNGroup'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			gr_name = 'Group Of Subjects';
		end
		function gr_description = getDescription()
			%GETDESCRIPTION returns the description of the group of subjects.
			%
			% STR = NNGroup.GETDESCRIPTION() returns the description of the 'group of subjects'.
			%  which is:
			%
			%  NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.
			%  NNGroup provides the ready-to-use inputs and targets from all NN subjects, for 
			%  performing a neural network analysis.
			%
			% Alternative forms to call this method are:
			%  STR = GR.GETDESCRIPTION() returns the description of the group of subjects GR.
			%  STR = Element.GETDESCRIPTION(GR) returns the description of 'GR'.
			%  STR = Element.GETDESCRIPTION('NNGroup') returns the description of 'NNGroup'.
			%
			% See also getClass, getName.
			
			gr_description = [
				'NNGroup represents a group of NNSubjects whose class is defined in the property SUB_CLASS.' ...
				'NNGroup provides the ready-to-use inputs and targets from all NN subjects, for ' ...
				'performing a neural network analysis.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group of subjects.
			%
			% PROPS = NNGroup.GETPROPS() returns the property list of group of subjects.
			%
			% PROPS = NNGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GR.GETPROPS([CATEGORY]) returns the property list of the group of subjects GR.
			%  PROPS = Element.GETPROPS(GR[, CATEGORY]) returns the property list of 'GR'.
			%  PROPS = Element.GETPROPS('NNGroup'[, CATEGORY]) returns the property list of 'NNGroup'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Group.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Group.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Group.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						Group.getProps(Category.RESULT)
						NNGroup.INPUTS
						NNGroup.TARGETS
						NNGroup.G
						];
				case Category.FIGURE
					prop_list = [
						Group.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Group.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Group.getProps()
						NNGroup.INPUTS
						NNGroup.TARGETS
						NNGroup.G
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of group of subjects.
			%
			% N = NNGroup.GETPROPNUMBER() returns the property number of group of subjects.
			%
			% Alternative forms to call this method are:
			%  N = GR.GETPROPNUMBER() returns the property number of the group of subjects GR.
			%  N = Element.GETPROPNUMBER(GR) returns the property number of 'GR'.
			%  N = Element.GETPROPNUMBER('NNGroup') returns the property number of 'NNGroup'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in group of subjects/error.
			%
			% CHECK = NNGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSPROP(PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(GR, PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(NNGroup, PROP) checks whether PROP exists for NNGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSPROP(PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  Element.EXISTSPROP(GR, PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  Element.EXISTSPROP(NNGroup, PROP) throws error if PROP does NOT exist for NNGroup.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					NNGroup.existsProp(prop), ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNGroup.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group of subjects/error.
			%
			% CHECK = NNGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSTAG(TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(GR, TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(NNGroup, TAG) checks whether TAG exists for NNGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSTAG(TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  Element.EXISTSTAG(GR, TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  Element.EXISTSTAG(NNGroup, TAG) throws error if TAG does NOT exist for NNGroup.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nngroup_tag_list = { 'id'  'label'  'notes'  'sub_class'  'sub_dict'  'inputs'  'targets'  'g' };
				
				check = any(strcmpi(tag, nngroup_tag_list));
			else
				assert( ...
					NNGroup.existsTag(tag), ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNGroup'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNGroup, POINTER) returns property number of POINTER of NNGroup.
			%  PROPERTY = GR.GETPROPPROP(NNGroup, POINTER) returns property number of POINTER of NNGroup.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nngroup_tag_list = { 'id'  'label'  'notes'  'sub_class'  'sub_dict'  'inputs'  'targets'  'g' };
				
				tag = pointer;
				NNGroup.existsTag(tag);
				
				prop = find(strcmpi(tag, nngroup_tag_list));
			else % numeric
				prop = pointer;
				NNGroup.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNGroup, POINTER) returns tag of POINTER of NNGroup.
			%  TAG = GR.GETPROPTAG(NNGroup, POINTER) returns tag of POINTER of NNGroup.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNGroup.existsTag(tag);
			else % numeric
				prop = pointer;
				NNGroup.existsProp(prop);
				
				switch prop
					case NNGroup.INPUTS
						tag = NNGroup.INPUTS_TAG;
					case NNGroup.TARGETS
						tag = NNGroup.TARGETS_TAG;
					case NNGroup.G
						tag = NNGroup.G_TAG;
					otherwise
						tag = getPropTag@Group(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNGroup, POINTER) returns category of POINTER of NNGroup.
			%  CATEGORY = GR.GETPROPCATEGORY(NNGroup, POINTER) returns category of POINTER of NNGroup.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					prop_category = NNGroup.INPUTS_CATEGORY;
				case NNGroup.TARGETS
					prop_category = NNGroup.TARGETS_CATEGORY;
				case NNGroup.G
					prop_category = NNGroup.G_CATEGORY;
				otherwise
					prop_category = getPropCategory@Group(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(NNGroup, POINTER) returns format of POINTER of NNGroup.
			%  FORMAT = GR.GETPROPFORMAT(NNGroup, POINTER) returns format of POINTER of NNGroup.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					prop_format = NNGroup.INPUTS_FORMAT;
				case NNGroup.TARGETS
					prop_format = NNGroup.TARGETS_FORMAT;
				case NNGroup.G
					prop_format = NNGroup.G_FORMAT;
				otherwise
					prop_format = getPropFormat@Group(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNGroup, POINTER) returns description of POINTER of NNGroup.
			%  DESCRIPTION = GR.GETPROPDESCRIPTION(NNGroup, POINTER) returns description of POINTER of NNGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					prop_description = 'INPUTS (result, cell) is a collection of the input from all NN subjects.';
				case NNGroup.TARGETS
					prop_description = 'TARGETS (result, cell) is a collection of the target from all NN subjects.';
				case NNGroup.G
					prop_description = 'G (result, item) is the graph obtained from this analysis.';
				otherwise
					prop_description = getPropDescription@Group(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNGroup, POINTER) returns settings of POINTER of NNGroup.
			%  SETTINGS = GR.GETPROPSETTINGS(NNGroup, POINTER) returns settings of POINTER of NNGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNGroup.TARGETS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNGroup.G
					prop_settings = Format.getFormatSettings(Format.ITEM);
				otherwise
					prop_settings = getPropSettings@Group(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNGroup, POINTER) returns the default value of POINTER of NNGroup.
			%  DEFAULT = GR.GETPROPDEFAULT(NNGroup, POINTER) returns the default value of POINTER of NNGroup.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					prop_default = Format.getFormatDefault(Format.CELL, NNGroup.getPropSettings(prop));
				case NNGroup.TARGETS
					prop_default = Format.getFormatDefault(Format.CELL, NNGroup.getPropSettings(prop));
				case NNGroup.G
					prop_default = Format.getFormatDefault(Format.ITEM, NNGroup.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Group(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNGroup, POINTER) returns the conditioned default value of POINTER of NNGroup.
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(NNGroup, POINTER) returns the conditioned default value of POINTER of NNGroup.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNGroup.getPropProp(pointer);
			
			prop_default = NNGroup.conditioning(prop, NNGroup.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNGroup, PROP, VALUE) checks VALUE format for PROP of NNGroup.
			%  CHECK = GR.CHECKPROP(NNGroup, PROP, VALUE) checks VALUE format for PROP of NNGroup.
			% 
			% GR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNGroup:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GR.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  Element.CHECKPROP(NNGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNGroup.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			%  GR.CHECKPROP(NNGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNGroup.
			%   Error id: [BRAPH2:NNGroup:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				case NNGroup.INPUTS
					check = Format.checkFormat(Format.CELL, value, NNGroup.getPropSettings(prop));
				case NNGroup.TARGETS
					check = Format.checkFormat(Format.CELL, value, NNGroup.getPropSettings(prop));
				case NNGroup.G
					check = Format.checkFormat(Format.ITEM, value, NNGroup.getPropSettings(prop));
				otherwise
					check = checkProp@Group(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNGroup.getPropTag(prop) ' (' NNGroup.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function gr = NNGroup(varargin)
			% NNGroup() creates a group of subjects.
			%
			% NNGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNGroup(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNGroup properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group of subjects.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group of subjects.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group of subjects.
			%  <strong>4</strong> <strong>sub_class</strong> 	SUB_CLASS (parameter, class) is the class of the subjects of the group.
			%  <strong>5</strong> <strong>sub_dict</strong> 	SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
			%  <strong>6</strong> <strong>inputs</strong> 	INPUTS (result, cell) is a collection of the input from all NN subjects.
			%  <strong>7</strong> <strong>targets</strong> 	TARGETS (result, cell) is a collection of the target from all NN subjects.
			%  <strong>8</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
			%
			% See also Category, Format, set, check.
			
			gr = gr@Group(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNGroup.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Group.getPropNumber()
						value = conditioning@Group(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gr, prop)
		
			switch prop
				case NNGroup.INPUTS
					rng(gr.getPropSeed(NNGroup.INPUTS), 'twister')
					
					if gr.get('SUB_DICT').length() == 0
					    inputs = {};
					else
					    inputs = cellfun(@(x) x.get('MASKED_INPUT'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
					end
					
					value = inputs;
					
				case NNGroup.TARGETS
					rng(gr.getPropSeed(NNGroup.TARGETS), 'twister')
					
					if gr.get('SUB_DICT').length() == 0
					    targets = {};
					else
					    targets = cellfun(@(x) x.get('TARGET'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
					end
					
					value = targets;
					
				case NNGroup.G
					rng(gr.getPropSeed(NNGroup.G), 'twister')
					
					sub_dict = gr.get('SUB_DICT');
					if sub_dict.length == 0
					    value = Graph();
					else
					    sub = sub_dict.getItem(1);
					    value = sub.get('G').clone;
					end
					
				otherwise
					value = calculateValue@Group(gr, prop);
					
			end
		end
	end
end
