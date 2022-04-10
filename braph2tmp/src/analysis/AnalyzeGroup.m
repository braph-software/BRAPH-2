classdef AnalyzeGroup < Element
	% AnalyzeGroup is a group-based graph analysis.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.
	% Instances of this class should not be created. 
	% Use one of its subclasses instead.
	%
	% The list of AnalyzeGroup properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class.
	%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
	%
	% AnalyzeGroup methods (constructor):
	% AnalyzeGroup - constructor
	%
	% AnalyzeGroup methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in group-based graph analysis/error.
	%  existsProp - checks whether property exists in group-based graph analysis/error.
	%  getPropNumber - returns the property number of group-based graph analysis.
	%  getProps - returns the property list of group-based graph analysis.
	%  getDescription - returns the description of the group-based graph analysis.
	%  getName - returns the name of the group-based graph analysis.
	%  getClass - returns the class of the group-based graph analysis.
	%
	% AnalyzeGroup methods:
	%  getPPCompareGroup_CPDict - returns the comparison plot panel compatible with the analysis.
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
	% AnalyzeGroup methods (operators):
	%  isequal - determines whether two AnalyzeGroup are equal (values, locked)
	%
	% AnalyzeGroup methods (display):
	%  tostring - string with information about the AnalyzeGroup
	%  disp - displays information about the AnalyzeGroup
	%  tree - displays the element of AnalyzeGroup
	%
	% AnalyzeGroup method (element list):
	%  getElementList - returns a list with all subelements of AnalyzeGroup
	%
	% AnalyzeGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the AnalyzeGroup
	%
	% AnalyzeGroup method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the AnalyzeGroup
	%
	% AnalyzeGroup methods (copy):
	%  copy - copies the AnalyzeGroup
	%  deepclone - deep-clones the AnalyzeGroup
	%  clone - clones the AnalyzeGroup
	%
	% AnalyzeGroup methods (inspection, Static):
	%  getClass - returns AnalyzeGroup
	%  getName - returns the name of AnalyzeGroup
	%  getDescription - returns the description of AnalyzeGroup
	%  getProps - returns the property list of AnalyzeGroup
	%  getPropNumber - returns the property number of AnalyzeGroup
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
	% AnalyzeGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% AnalyzeGroup methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% AnalyzeGroup methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% AnalyzeGroup properties (Constant).
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
	%  GR - 4
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  G - 5
	%  G_TAG - 'g'
	%  G_CATEGORY - 'r'
	%  G_FORMAT - 'it'
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
	% See also CompareGroup.
	
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
		
		GR = 4;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		G = 5;
		G_TAG = 'g';
		G_CATEGORY = Category.RESULT;
		G_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function a_class = getClass()
			%GETCLASS returns the class of the group-based graph analysis.
			%
			% CLASS = AnalyzeGroup.GETCLASS() returns the class 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the group-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup') returns 'AnalyzeGroup'.
			%
			% See also getName, getDescription.
			
			a_class = 'AnalyzeGroup';
		end
		function a_name = getName()
			%GETNAME returns the name of the group-based graph analysis.
			%
			% NAME = AnalyzeGroup.GETNAME() returns the name of the 'group-based graph analysis'.
			%  Group-Based Graph Analysis.
			%
			% Alternative forms to call this method are:
			%  NAME = A.GETNAME() returns the name of the group-based graph analysis A.
			%  NAME = Element.GETNAME(A) returns the name of 'A'.
			%  NAME = Element.GETNAME('AnalyzeGroup') returns the name of 'AnalyzeGroup'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			a_name = 'Group-Based Graph Analysis';
		end
		function a_description = getDescription()
			%GETDESCRIPTION returns the description of the group-based graph analysis.
			%
			% STR = AnalyzeGroup.GETDESCRIPTION() returns the description of the 'group-based graph analysis'.
			%  which is:
			%
			%  AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.
			%  Instances of this class should not be created. 
			%  Use one of its subclasses instead.
			%
			% Alternative forms to call this method are:
			%  STR = A.GETDESCRIPTION() returns the description of the group-based graph analysis A.
			%  STR = Element.GETDESCRIPTION(A) returns the description of 'A'.
			%  STR = Element.GETDESCRIPTION('AnalyzeGroup') returns the description of 'AnalyzeGroup'.
			%
			% See also getClass, getName.
			
			a_description = [
				'AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.' ...
				'Instances of this class should not be created. ' ...
				'Use one of its subclasses instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based graph analysis.
			%
			% PROPS = AnalyzeGroup.GETPROPS() returns the property list of group-based graph analysis.
			%
			% PROPS = AnalyzeGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the group-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup'[, CATEGORY]) returns the property list of 'AnalyzeGroup'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						AnalyzeGroup.LABEL
						AnalyzeGroup.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						AnalyzeGroup.ID
						AnalyzeGroup.GR
						];
				case Category.RESULT
					prop_list = [
						AnalyzeGroup.G
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						AnalyzeGroup.ID
						AnalyzeGroup.LABEL
						AnalyzeGroup.NOTES
						AnalyzeGroup.GR
						AnalyzeGroup.G
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of group-based graph analysis.
			%
			% N = AnalyzeGroup.GETPROPNUMBER() returns the property number of group-based graph analysis.
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER() returns the property number of the group-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup') returns the property number of 'AnalyzeGroup'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup, PROP) checks whether PROP exists for AnalyzeGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup, PROP) throws error if PROP does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					AnalyzeGroup.existsProp(prop), ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup, TAG) checks whether TAG exists for AnalyzeGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup, TAG) throws error if TAG does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_tag_list = { 'id'  'label'  'notes'  'gr'  'g' };
				
				check = any(strcmpi(tag, analyzegroup_tag_list));
			else
				assert( ...
					AnalyzeGroup.existsTag(tag), ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_tag_list = { 'id'  'label'  'notes'  'gr'  'g' };
				
				tag = pointer;
				AnalyzeGroup.existsTag(tag);
				
				prop = find(strcmpi(tag, analyzegroup_tag_list));
			else % numeric
				prop = pointer;
				AnalyzeGroup.existsProp(prop);
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%  TAG = A.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				AnalyzeGroup.existsTag(tag);
			else % numeric
				prop = pointer;
				AnalyzeGroup.existsProp(prop);
				
				switch prop
					case AnalyzeGroup.ID
						tag = AnalyzeGroup.ID_TAG;
					case AnalyzeGroup.LABEL
						tag = AnalyzeGroup.LABEL_TAG;
					case AnalyzeGroup.NOTES
						tag = AnalyzeGroup.NOTES_TAG;
					case AnalyzeGroup.GR
						tag = AnalyzeGroup.GR_TAG;
					case AnalyzeGroup.G
						tag = AnalyzeGroup.G_TAG;
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					prop_category = AnalyzeGroup.ID_CATEGORY;
				case AnalyzeGroup.LABEL
					prop_category = AnalyzeGroup.LABEL_CATEGORY;
				case AnalyzeGroup.NOTES
					prop_category = AnalyzeGroup.NOTES_CATEGORY;
				case AnalyzeGroup.GR
					prop_category = AnalyzeGroup.GR_CATEGORY;
				case AnalyzeGroup.G
					prop_category = AnalyzeGroup.G_CATEGORY;
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					prop_format = AnalyzeGroup.ID_FORMAT;
				case AnalyzeGroup.LABEL
					prop_format = AnalyzeGroup.LABEL_FORMAT;
				case AnalyzeGroup.NOTES
					prop_format = AnalyzeGroup.NOTES_FORMAT;
				case AnalyzeGroup.GR
					prop_format = AnalyzeGroup.GR_FORMAT;
				case AnalyzeGroup.G
					prop_format = AnalyzeGroup.G_FORMAT;
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis.';
				case AnalyzeGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis.';
				case AnalyzeGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis.';
				case AnalyzeGroup.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class.';
				case AnalyzeGroup.G
					prop_description = 'G (result, item) is the graph obtained from this analysis.';
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeGroup.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeGroup.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeGroup.GR
					prop_settings = 'Group';
				case AnalyzeGroup.G
					prop_settings = 'Graph';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.GR
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.G
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			prop_default = AnalyzeGroup.conditioning(prop, AnalyzeGroup.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			%  CHECK = A.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  A.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.ID
					check = Format.checkFormat(Format.STRING, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.LABEL
					check = Format.checkFormat(Format.STRING, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.NOTES
					check = Format.checkFormat(Format.STRING, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.GR
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.G
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup.getPropTag(prop) ' (' AnalyzeGroup.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function a = AnalyzeGroup(varargin)
			% AnalyzeGroup() creates a group-based graph analysis.
			%
			% AnalyzeGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeGroup properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class.
			%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
			%
			% See also Category, Format, set, check.
			
			a = a@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop)
		
			switch prop
				case AnalyzeGroup.G
					rng(a.getPropSeed(AnalyzeGroup.G), 'twister')
					
					value = Graph();
					
				otherwise
					value = calculateValue@Element(a, prop);
					
			end
		end
	end
	methods % methods
		function pr = getPPCompareGroup_CPDict(a, varargin) 
		    %GEPPPCOMPAREGROUP_CPDICT returns the comparison plot panel compatible with the analysis.
		    %
		    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison plot panel
		    %  that is compatible with the analyze group.
		    %
		    % See also CompareGroup.
		    
		    pr = PropPlotIDict(varargin{:});
		end
	end
	methods % GUI
		function pr = getPlotProp(a, prop, varargin)
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
				case AnalyzeGroup.NOTES
					pr = PlotPropString('EL', a, 'PROP', AnalyzeGroup.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case AnalyzeGroup.G
					pr = PPAnalyzeGroup_G('EL', a, 'PROP', AnalyzeGroup.G, 'WAITBAR', true, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(a, prop, varargin{:});
					
			end
		end
	end
end
