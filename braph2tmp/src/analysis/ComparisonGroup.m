classdef ComparisonGroup < Element
	% ComparisonGroup contains the results of a group-based comparison.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% ComparisonGroup contains the results of a group-based comparison for a given measure.
	% Specifically, it contains the one-tailed and two-tailed p-values 
	% and the 95%% confidence interval.
	%
	% The list of ComparisonGroup properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group-based comparison results.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group-based comparison results.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group-based comparison results.
	%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
	%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters. 
	%  <strong>6</strong> <strong>c</strong> 	C (data, item) is the group-based comparison.
	%  <strong>7</strong> <strong>diff</strong> 	DIFF (result, cell) is the group comparison value.
	%  <strong>8</strong> <strong>p1</strong> 	P1 (result, cell) is the one-tailed p-value.
	%  <strong>9</strong> <strong>p2</strong> 	P2 (result, cell) is the two-tailed p-value.
	%  <strong>10</strong> <strong>cil</strong> 	CIL (result, cell) is the lower value of the 95%% confidence interval.
	%  <strong>11</strong> <strong>ciu</strong> 	CIU (result, cell) is the upper value of the 95%% confidence interval.
	%
	% ComparisonGroup methods (constructor):
	% ComparisonGroup - constructor
	%
	% ComparisonGroup methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in group-based comparison results/error.
	%  existsProp - checks whether property exists in group-based comparison results/error.
	%  getPropNumber - returns the property number of group-based comparison results.
	%  getProps - returns the property list of group-based comparison results.
	%  getDescription - returns the description of the group-based comparison results.
	%  getName - returns the name of the group-based comparison results.
	%  getClass - returns the class of the group-based comparison results.
	%
	% ComparisonGroup methods:
	%  calculate_results - calculates the comparison results.
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
	% ComparisonGroup methods (operators):
	%  isequal - determines whether two ComparisonGroup are equal (values, locked)
	%
	% ComparisonGroup methods (display):
	%  tostring - string with information about the ComparisonGroup
	%  disp - displays information about the ComparisonGroup
	%  tree - displays the element of ComparisonGroup
	%
	% ComparisonGroup method (element list):
	%  getElementList - returns a list with all subelements of ComparisonGroup
	%
	% ComparisonGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ComparisonGroup
	%
	% ComparisonGroup method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ComparisonGroup
	%
	% ComparisonGroup methods (copy):
	%  copy - copies the ComparisonGroup
	%  deepclone - deep-clones the ComparisonGroup
	%  clone - clones the ComparisonGroup
	%
	% ComparisonGroup methods (inspection, Static):
	%  getClass - returns ComparisonGroup
	%  getName - returns the name of ComparisonGroup
	%  getDescription - returns the description of ComparisonGroup
	%  getProps - returns the property list of ComparisonGroup
	%  getPropNumber - returns the property number of ComparisonGroup
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
	% ComparisonGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroup methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ComparisonGroup methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ComparisonGroup methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ComparisonGroup properties (Constant).
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
	%  MEASURE - 4
	%  MEASURE_TAG - 'measure'
	%  MEASURE_CATEGORY - 'd'
	%  MEASURE_FORMAT - 'st'
	%  MEASUREPARAM - 5
	%  MEASUREPARAM_TAG - 'measureparam'
	%  MEASUREPARAM_CATEGORY - 'd'
	%  MEASUREPARAM_FORMAT - 'it'
	%  C - 6
	%  C_TAG - 'c'
	%  C_CATEGORY - 'd'
	%  C_FORMAT - 'it'
	%  DIFF - 7
	%  DIFF_TAG - 'diff'
	%  DIFF_CATEGORY - 'r'
	%  DIFF_FORMAT - 'll'
	%  P1 - 8
	%  P1_TAG - 'p1'
	%  P1_CATEGORY - 'r'
	%  P1_FORMAT - 'll'
	%  P2 - 9
	%  P2_TAG - 'p2'
	%  P2_CATEGORY - 'r'
	%  P2_FORMAT - 'll'
	%  CIL - 10
	%  CIL_TAG - 'cil'
	%  CIL_CATEGORY - 'r'
	%  CIL_FORMAT - 'll'
	%  CIU - 11
	%  CIU_TAG - 'ciu'
	%  CIU_CATEGORY - 'r'
	%  CIU_FORMAT - 'll'
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
	% See also CompareGroup, AnalyzeGroup.
	
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
		
		MEASURE = 4;
		MEASURE_TAG = 'measure';
		MEASURE_CATEGORY = Category.DATA;
		MEASURE_FORMAT = Format.STRING;
		
		MEASUREPARAM = 5;
		MEASUREPARAM_TAG = 'measureparam';
		MEASUREPARAM_CATEGORY = Category.DATA;
		MEASUREPARAM_FORMAT = Format.ITEM;
		
		C = 6;
		C_TAG = 'c';
		C_CATEGORY = Category.DATA;
		C_FORMAT = Format.ITEM;
		
		DIFF = 7;
		DIFF_TAG = 'diff';
		DIFF_CATEGORY = Category.RESULT;
		DIFF_FORMAT = Format.CELL;
		
		P1 = 8;
		P1_TAG = 'p1';
		P1_CATEGORY = Category.RESULT;
		P1_FORMAT = Format.CELL;
		
		P2 = 9;
		P2_TAG = 'p2';
		P2_CATEGORY = Category.RESULT;
		P2_FORMAT = Format.CELL;
		
		CIL = 10;
		CIL_TAG = 'cil';
		CIL_CATEGORY = Category.RESULT;
		CIL_FORMAT = Format.CELL;
		
		CIU = 11;
		CIU_TAG = 'ciu';
		CIU_CATEGORY = Category.RESULT;
		CIU_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function cp_class = getClass()
			%GETCLASS returns the class of the group-based comparison results.
			%
			% CLASS = ComparisonGroup.GETCLASS() returns the class 'ComparisonGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CP.GETCLASS() returns the class of the group-based comparison results CP.
			%  CLASS = Element.GETCLASS(CP) returns the class of 'CP'.
			%  CLASS = Element.GETCLASS('ComparisonGroup') returns 'ComparisonGroup'.
			%
			% See also getName, getDescription.
			
			cp_class = 'ComparisonGroup';
		end
		function cp_name = getName()
			%GETNAME returns the name of the group-based comparison results.
			%
			% NAME = ComparisonGroup.GETNAME() returns the name of the 'group-based comparison results'.
			%  Group-Based Comparison Results.
			%
			% Alternative forms to call this method are:
			%  NAME = CP.GETNAME() returns the name of the group-based comparison results CP.
			%  NAME = Element.GETNAME(CP) returns the name of 'CP'.
			%  NAME = Element.GETNAME('ComparisonGroup') returns the name of 'ComparisonGroup'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			cp_name = 'Group-Based Comparison Results';
		end
		function cp_description = getDescription()
			%GETDESCRIPTION returns the description of the group-based comparison results.
			%
			% STR = ComparisonGroup.GETDESCRIPTION() returns the description of the 'group-based comparison results'.
			%  which is:
			%
			%  ComparisonGroup contains the results of a group-based comparison for a given measure.
			%  Specifically, it contains the one-tailed and two-tailed p-values 
			%  and the 95%% confidence interval.
			%
			% Alternative forms to call this method are:
			%  STR = CP.GETDESCRIPTION() returns the description of the group-based comparison results CP.
			%  STR = Element.GETDESCRIPTION(CP) returns the description of 'CP'.
			%  STR = Element.GETDESCRIPTION('ComparisonGroup') returns the description of 'ComparisonGroup'.
			%
			% See also getClass, getName.
			
			cp_description = [
				'ComparisonGroup contains the results of a group-based comparison for a given measure.' ...
				'Specifically, it contains the one-tailed and two-tailed p-values ' ...
				'and the 95%% confidence interval.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based comparison results.
			%
			% PROPS = ComparisonGroup.GETPROPS() returns the property list of group-based comparison results.
			%
			% PROPS = ComparisonGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CP.GETPROPS([CATEGORY]) returns the property list of the group-based comparison results CP.
			%  PROPS = Element.GETPROPS(CP[, CATEGORY]) returns the property list of 'CP'.
			%  PROPS = Element.GETPROPS('ComparisonGroup'[, CATEGORY]) returns the property list of 'ComparisonGroup'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ComparisonGroup.LABEL
						ComparisonGroup.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						ComparisonGroup.ID
						ComparisonGroup.MEASURE
						ComparisonGroup.MEASUREPARAM
						ComparisonGroup.C
						];
				case Category.RESULT
					prop_list = [
						ComparisonGroup.DIFF
						ComparisonGroup.P1
						ComparisonGroup.P2
						ComparisonGroup.CIL
						ComparisonGroup.CIU
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						ComparisonGroup.ID
						ComparisonGroup.LABEL
						ComparisonGroup.NOTES
						ComparisonGroup.MEASURE
						ComparisonGroup.MEASUREPARAM
						ComparisonGroup.C
						ComparisonGroup.DIFF
						ComparisonGroup.P1
						ComparisonGroup.P2
						ComparisonGroup.CIL
						ComparisonGroup.CIU
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of group-based comparison results.
			%
			% N = ComparisonGroup.GETPROPNUMBER() returns the property number of group-based comparison results.
			%
			% Alternative forms to call this method are:
			%  N = CP.GETPROPNUMBER() returns the property number of the group-based comparison results CP.
			%  N = Element.GETPROPNUMBER(CP) returns the property number of 'CP'.
			%  N = Element.GETPROPNUMBER('ComparisonGroup') returns the property number of 'ComparisonGroup'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 11;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based comparison results/error.
			%
			% CHECK = ComparisonGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSPROP(PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(CP, PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(ComparisonGroup, PROP) checks whether PROP exists for ComparisonGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSPROP(PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSPROP(CP, PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroup, PROP) throws error if PROP does NOT exist for ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11 ]);
			else
				assert( ...
					ComparisonGroup.existsProp(prop), ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroup.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based comparison results/error.
			%
			% CHECK = ComparisonGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSTAG(TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(CP, TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(ComparisonGroup, TAG) checks whether TAG exists for ComparisonGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSTAG(TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSTAG(CP, TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroup, TAG) throws error if TAG does NOT exist for ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				comparisongroup_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'c'  'diff'  'p1'  'p2'  'cil'  'ciu' };
				
				check = any(strcmpi(tag, comparisongroup_tag_list));
			else
				assert( ...
					ComparisonGroup.existsTag(tag), ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ComparisonGroup'] ...
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
			%  PROPERTY = CP.GETPROPPROP(POINTER) returns property number of POINTER of CP.
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroup, POINTER) returns property number of POINTER of ComparisonGroup.
			%  PROPERTY = CP.GETPROPPROP(ComparisonGroup, POINTER) returns property number of POINTER of ComparisonGroup.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				comparisongroup_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'c'  'diff'  'p1'  'p2'  'cil'  'ciu' };
				
				tag = pointer;
				ComparisonGroup.existsTag(tag);
				
				prop = find(strcmpi(tag, comparisongroup_tag_list));
			else % numeric
				prop = pointer;
				ComparisonGroup.existsProp(prop);
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
			%  TAG = CP.GETPROPTAG(POINTER) returns tag of POINTER of CP.
			%  TAG = Element.GETPROPTAG(ComparisonGroup, POINTER) returns tag of POINTER of ComparisonGroup.
			%  TAG = CP.GETPROPTAG(ComparisonGroup, POINTER) returns tag of POINTER of ComparisonGroup.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ComparisonGroup.existsTag(tag);
			else % numeric
				prop = pointer;
				ComparisonGroup.existsProp(prop);
				
				switch prop
					case ComparisonGroup.ID
						tag = ComparisonGroup.ID_TAG;
					case ComparisonGroup.LABEL
						tag = ComparisonGroup.LABEL_TAG;
					case ComparisonGroup.NOTES
						tag = ComparisonGroup.NOTES_TAG;
					case ComparisonGroup.MEASURE
						tag = ComparisonGroup.MEASURE_TAG;
					case ComparisonGroup.MEASUREPARAM
						tag = ComparisonGroup.MEASUREPARAM_TAG;
					case ComparisonGroup.C
						tag = ComparisonGroup.C_TAG;
					case ComparisonGroup.DIFF
						tag = ComparisonGroup.DIFF_TAG;
					case ComparisonGroup.P1
						tag = ComparisonGroup.P1_TAG;
					case ComparisonGroup.P2
						tag = ComparisonGroup.P2_TAG;
					case ComparisonGroup.CIL
						tag = ComparisonGroup.CIL_TAG;
					case ComparisonGroup.CIU
						tag = ComparisonGroup.CIU_TAG;
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
			%  CATEGORY = CP.GETPROPCATEGORY(POINTER) returns category of POINTER of CP.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroup, POINTER) returns category of POINTER of ComparisonGroup.
			%  CATEGORY = CP.GETPROPCATEGORY(ComparisonGroup, POINTER) returns category of POINTER of ComparisonGroup.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					prop_category = ComparisonGroup.ID_CATEGORY;
				case ComparisonGroup.LABEL
					prop_category = ComparisonGroup.LABEL_CATEGORY;
				case ComparisonGroup.NOTES
					prop_category = ComparisonGroup.NOTES_CATEGORY;
				case ComparisonGroup.MEASURE
					prop_category = ComparisonGroup.MEASURE_CATEGORY;
				case ComparisonGroup.MEASUREPARAM
					prop_category = ComparisonGroup.MEASUREPARAM_CATEGORY;
				case ComparisonGroup.C
					prop_category = ComparisonGroup.C_CATEGORY;
				case ComparisonGroup.DIFF
					prop_category = ComparisonGroup.DIFF_CATEGORY;
				case ComparisonGroup.P1
					prop_category = ComparisonGroup.P1_CATEGORY;
				case ComparisonGroup.P2
					prop_category = ComparisonGroup.P2_CATEGORY;
				case ComparisonGroup.CIL
					prop_category = ComparisonGroup.CIL_CATEGORY;
				case ComparisonGroup.CIU
					prop_category = ComparisonGroup.CIU_CATEGORY;
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
			%  FORMAT = CP.GETPROPFORMAT(POINTER) returns format of POINTER of CP.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroup, POINTER) returns format of POINTER of ComparisonGroup.
			%  FORMAT = CP.GETPROPFORMAT(ComparisonGroup, POINTER) returns format of POINTER of ComparisonGroup.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					prop_format = ComparisonGroup.ID_FORMAT;
				case ComparisonGroup.LABEL
					prop_format = ComparisonGroup.LABEL_FORMAT;
				case ComparisonGroup.NOTES
					prop_format = ComparisonGroup.NOTES_FORMAT;
				case ComparisonGroup.MEASURE
					prop_format = ComparisonGroup.MEASURE_FORMAT;
				case ComparisonGroup.MEASUREPARAM
					prop_format = ComparisonGroup.MEASUREPARAM_FORMAT;
				case ComparisonGroup.C
					prop_format = ComparisonGroup.C_FORMAT;
				case ComparisonGroup.DIFF
					prop_format = ComparisonGroup.DIFF_FORMAT;
				case ComparisonGroup.P1
					prop_format = ComparisonGroup.P1_FORMAT;
				case ComparisonGroup.P2
					prop_format = ComparisonGroup.P2_FORMAT;
				case ComparisonGroup.CIL
					prop_format = ComparisonGroup.CIL_FORMAT;
				case ComparisonGroup.CIU
					prop_format = ComparisonGroup.CIU_FORMAT;
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
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroup, POINTER) returns description of POINTER of ComparisonGroup.
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(ComparisonGroup, POINTER) returns description of POINTER of ComparisonGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the group-based comparison results.';
				case ComparisonGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group-based comparison results.';
				case ComparisonGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group-based comparison results.';
				case ComparisonGroup.MEASURE
					prop_description = 'MEASURE (data, string) is the measure class.';
				case ComparisonGroup.MEASUREPARAM
					prop_description = 'MEASUREPARAM(data, item) provides the measure parameters. ';
				case ComparisonGroup.C
					prop_description = 'C (data, item) is the group-based comparison.';
				case ComparisonGroup.DIFF
					prop_description = 'DIFF (result, cell) is the group comparison value.';
				case ComparisonGroup.P1
					prop_description = 'P1 (result, cell) is the one-tailed p-value.';
				case ComparisonGroup.P2
					prop_description = 'P2 (result, cell) is the two-tailed p-value.';
				case ComparisonGroup.CIL
					prop_description = 'CIL (result, cell) is the lower value of the 95%% confidence interval.';
				case ComparisonGroup.CIU
					prop_description = 'CIU (result, cell) is the upper value of the 95%% confidence interval.';
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
			%  SETTINGS = CP.GETPROPSETTINGS(POINTER) returns settings of POINTER of CP.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroup, POINTER) returns settings of POINTER of ComparisonGroup.
			%  SETTINGS = CP.GETPROPSETTINGS(ComparisonGroup, POINTER) returns settings of POINTER of ComparisonGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonGroup.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonGroup.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonGroup.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonGroup.MEASUREPARAM
					prop_settings = 'Measure';
				case ComparisonGroup.C
					prop_settings = 'CompareGroup';
				case ComparisonGroup.DIFF
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.P1
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.P2
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroup, POINTER) returns the default value of POINTER of ComparisonGroup.
			%  DEFAULT = CP.GETPROPDEFAULT(ComparisonGroup, POINTER) returns the default value of POINTER of ComparisonGroup.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.MEASUREPARAM
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.C
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.DIFF
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P1
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P2
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIL
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIU
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroup, POINTER) returns the conditioned default value of POINTER of ComparisonGroup.
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(ComparisonGroup, POINTER) returns the conditioned default value of POINTER of ComparisonGroup.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			prop_default = ComparisonGroup.conditioning(prop, ComparisonGroup.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CP.
			%  CHECK = Element.CHECKPROP(ComparisonGroup, PROP, VALUE) checks VALUE format for PROP of ComparisonGroup.
			%  CHECK = CP.CHECKPROP(ComparisonGroup, PROP, VALUE) checks VALUE format for PROP of ComparisonGroup.
			% 
			% CP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ComparisonGroup:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.CHECKPROP(ComparisonGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  CP.CHECKPROP(ComparisonGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.ID
					check = Format.checkFormat(Format.STRING, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.LABEL
					check = Format.checkFormat(Format.STRING, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.NOTES
					check = Format.checkFormat(Format.STRING, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.MEASURE
					check = Format.checkFormat(Format.STRING, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.MEASUREPARAM
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.C
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.DIFF
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P1
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P2
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIL
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIU
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroup.getPropTag(prop) ' (' ComparisonGroup.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function cp = ComparisonGroup(varargin)
			% ComparisonGroup() creates a group-based comparison results.
			%
			% ComparisonGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroup(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonGroup properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group-based comparison results.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group-based comparison results.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group-based comparison results.
			%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
			%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters. 
			%  <strong>6</strong> <strong>c</strong> 	C (data, item) is the group-based comparison.
			%  <strong>7</strong> <strong>diff</strong> 	DIFF (result, cell) is the group comparison value.
			%  <strong>8</strong> <strong>p1</strong> 	P1 (result, cell) is the one-tailed p-value.
			%  <strong>9</strong> <strong>p2</strong> 	P2 (result, cell) is the two-tailed p-value.
			%  <strong>10</strong> <strong>cil</strong> 	CIL (result, cell) is the lower value of the 95%% confidence interval.
			%  <strong>11</strong> <strong>ciu</strong> 	CIU (result, cell) is the upper value of the 95%% confidence interval.
			%
			% See also Category, Format, set, check.
			
			cp = cp@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cp, prop)
		
			switch prop
				case ComparisonGroup.DIFF
					rng(cp.getPropSeed(ComparisonGroup.DIFF), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = diff;
					
				case ComparisonGroup.P1
					rng(cp.getPropSeed(ComparisonGroup.P1), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = p1;
					
				case ComparisonGroup.P2
					rng(cp.getPropSeed(ComparisonGroup.P2), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = p2;
					
				case ComparisonGroup.CIL
					rng(cp.getPropSeed(ComparisonGroup.CIL), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = ci_lower;
					
				case ComparisonGroup.CIU
					rng(cp.getPropSeed(ComparisonGroup.CIU), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = ci_upper;
					
				otherwise
					value = calculateValue@Element(cp, prop);
					
			end
		end
	end
	methods % methods
		function [diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp)
		    %CALCULATE_RESULTS calculates the comparison results.
		    %
		    % [DIFF, P1, P2, CIL, CIU] = CALCULATE_RESULTS(CP) calcultes the
		    %  difference, the one-tailed p-value P1, the two-tailed p-value P2,
		    %  the lower bound of the confidence interval CIL, and the the upper
		    %  bound of the confidence interval. 
		    %  Typically, this method is only called internally.
		
		    measure_class = cp.get('MEASURE');
		    if isempty(cp.get('MEASURE'))
		        diff = {};
		        p1 = {};
		        p2 = {};
		        ci_lower = {};
		        ci_upper = {};
		        return
		    end
		    
			% get parameters from example measure
		    core_measure = cp.get('MEASUREPARAM');
		    j = 1;
		    varargin = {};
		    if Measure.getPropNumber() ~= core_measure.getPropNumber()
		        for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
		            if ~isa(core_measure.getr(i), 'NoValue')
		                varargin{j} = core_measure.getPropTag(i);
		                varargin{j + 1} = core_measure.getr(i);
		            end
		            j = j + 2;
		        end
		        varargin = varargin(~cellfun('isempty', varargin));
		    end
		    
		    c = cp.get('C');
		    if c.get('WAITBAR')
		        wb = waitbar(0, 'Comparing group analyses ...', 'Name', BRAPH2.NAME);
		        set_braph2icon(wb)
		    end    
		
		    % Measure for groups 1 and 2, and their difference
		    m1 = c.get('A1').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
		    m2 = c.get('A2').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
		    diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);
		
		    % Permutations
		    P = c.get('P'); %#ok<*PROPLC>
		
		    m1_perms = cell(1, P);
		    m2_perms = cell(1, P);
		    diff_perms = cell(1, P);
		
		    start = tic;
		    for i = 1:1:P
		        [a1_perm, a2_perm] = c.getPerm(i, c.get('MEMORIZE'));
		
		        m1_perms{1, i} = a1_perm.memorize('G').getMeasure(measure_class).memorize('M');
		        m2_perms{1, i} = a2_perm.memorize('G').getMeasure(measure_class).memorize('M');
		        diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
		
		        if c.get('WAITBAR')
		            waitbar(i / P, wb, ['Permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...']);
		        end
		        if c.get('VERBOSE')
		            disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
		        end
		        if c.get('INTERRUPTIBLE')
		            pause(c.get('INTERRUPTIBLE'))
		        end        
		    end
		    
		    if c.get('WAITBAR')
		        close(wb)
		    end
		
		    % Statistical analysis
		    p1 = cell(size(diff));
		    p2 = cell(size(diff));
		    ci_lower = cell(size(diff));
		    ci_upper = cell(size(diff));
		    for i = 1:1:size(diff, 1)
		        for j = 1:1:size(diff, 2)
		            p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
		            p2(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
		            qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
		            ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
		            ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
		        end
		    end
		end
	end
	methods % GUI
		function pr = getPlotProp(cp, prop, varargin)
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
				case ComparisonGroup.DIFF
					pr = PPComparisonGroup_Diff('EL', cp, 'PROP', ComparisonGroup.DIFF, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(cp, prop, varargin{:});
					
			end
		end
	end
end
