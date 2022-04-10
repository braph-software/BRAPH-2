classdef CompareGroup < Element
	% CompareGroup is a comparison between two group-based analyses.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% CompareGroup compares two group-based analyses, 
	% which need to be of the same class.
	%
	% The list of CompareGroup properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the comparison.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the comparison.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the comparison.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>verbose</strong> 	VERBOSE (metadata, logical) sets whether to write the progress of the comparisons.
	%  <strong>6</strong> <strong>interruptible</strong> 	INTERRUPTIBLE (metadata, scalar) sets whether the comparison computation is interruptible for multitasking.
	%  <strong>7</strong> <strong>memorize</strong> 	MEMORIZE (metadata, logical) sets whether to memorize the permuted analysis.
	%  <strong>8</strong> <strong>p</strong> 	P (parameter, scalar) is the permutation number.
	%  <strong>9</strong> <strong>longitudinal</strong> 	LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.
	%  <strong>10</strong> <strong>a1</strong> 	A1 (data, item) is the first analysis to compare.
	%  <strong>11</strong> <strong>a2</strong> 	A2 (data, item) is the second analysis to compare.
	%  <strong>12</strong> <strong>perm_seeds</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>13</strong> <strong>a1_perm_dict</strong> 	A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
	%  <strong>14</strong> <strong>a2_perm_dict</strong> 	A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
	%  <strong>15</strong> <strong>cp_dict</strong> 	CP_DICT (result, idict) contains the results of the comparison.
	%
	% CompareGroup methods (constructor):
	% CompareGroup - constructor
	%
	% CompareGroup methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in group-based comparison/error.
	%  existsProp - checks whether property exists in group-based comparison/error.
	%  getPropNumber - returns the property number of group-based comparison.
	%  getProps - returns the property list of group-based comparison.
	%  getDescription - returns the description of the group-based comparison.
	%  getName - returns the name of the group-based comparison.
	%  getClass - returns the class of the group-based comparison.
	%
	% CompareGroup methods:
	%  getPerm - returns the permuted analyses.
	%  getComparison - returns comparison.
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
	% CompareGroup methods (operators):
	%  isequal - determines whether two CompareGroup are equal (values, locked)
	%
	% CompareGroup methods (display):
	%  tostring - string with information about the CompareGroup
	%  disp - displays information about the CompareGroup
	%  tree - displays the element of CompareGroup
	%
	% CompareGroup method (element list):
	%  getElementList - returns a list with all subelements of CompareGroup
	%
	% CompareGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the CompareGroup
	%
	% CompareGroup method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the CompareGroup
	%
	% CompareGroup methods (copy):
	%  copy - copies the CompareGroup
	%  deepclone - deep-clones the CompareGroup
	%  clone - clones the CompareGroup
	%
	% CompareGroup methods (inspection, Static):
	%  getClass - returns CompareGroup
	%  getName - returns the name of CompareGroup
	%  getDescription - returns the description of CompareGroup
	%  getProps - returns the property list of CompareGroup
	%  getPropNumber - returns the property number of CompareGroup
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
	% CompareGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareGroup methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% CompareGroup methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% CompareGroup methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% CompareGroup properties (Constant).
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
	%  WAITBAR - 4
	%  WAITBAR_TAG - 'waitbar'
	%  WAITBAR_CATEGORY - 'm'
	%  WAITBAR_FORMAT - 'lo'
	%  VERBOSE - 5
	%  VERBOSE_TAG - 'verbose'
	%  VERBOSE_CATEGORY - 'm'
	%  VERBOSE_FORMAT - 'lo'
	%  INTERRUPTIBLE - 6
	%  INTERRUPTIBLE_TAG - 'interruptible'
	%  INTERRUPTIBLE_CATEGORY - 'm'
	%  INTERRUPTIBLE_FORMAT - 'nn'
	%  MEMORIZE - 7
	%  MEMORIZE_TAG - 'memorize'
	%  MEMORIZE_CATEGORY - 'm'
	%  MEMORIZE_FORMAT - 'lo'
	%  P - 8
	%  P_TAG - 'p'
	%  P_CATEGORY - 'p'
	%  P_FORMAT - 'nn'
	%  LONGITUDINAL - 9
	%  LONGITUDINAL_TAG - 'longitudinal'
	%  LONGITUDINAL_CATEGORY - 'p'
	%  LONGITUDINAL_FORMAT - 'lo'
	%  A1 - 10
	%  A1_TAG - 'a1'
	%  A1_CATEGORY - 'd'
	%  A1_FORMAT - 'it'
	%  A2 - 11
	%  A2_TAG - 'a2'
	%  A2_CATEGORY - 'd'
	%  A2_FORMAT - 'it'
	%  PERM_SEEDS - 12
	%  PERM_SEEDS_TAG - 'perm_seeds'
	%  PERM_SEEDS_CATEGORY - 'r'
	%  PERM_SEEDS_FORMAT - 'nr'
	%  A1_PERM_DICT - 13
	%  A1_PERM_DICT_TAG - 'a1_perm_dict'
	%  A1_PERM_DICT_CATEGORY - 'r'
	%  A1_PERM_DICT_FORMAT - 'di'
	%  A2_PERM_DICT - 14
	%  A2_PERM_DICT_TAG - 'a2_perm_dict'
	%  A2_PERM_DICT_CATEGORY - 'r'
	%  A2_PERM_DICT_FORMAT - 'di'
	%  CP_DICT - 15
	%  CP_DICT_TAG - 'cp_dict'
	%  CP_DICT_CATEGORY - 'r'
	%  CP_DICT_FORMAT - 'di'
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
	% See also AnalyzeGroup, ComparisonGroup.
	
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
		
		WAITBAR = 4;
		WAITBAR_TAG = 'waitbar';
		WAITBAR_CATEGORY = Category.METADATA;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		VERBOSE = 5;
		VERBOSE_TAG = 'verbose';
		VERBOSE_CATEGORY = Category.METADATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		INTERRUPTIBLE = 6;
		INTERRUPTIBLE_TAG = 'interruptible';
		INTERRUPTIBLE_CATEGORY = Category.METADATA;
		INTERRUPTIBLE_FORMAT = Format.SCALAR;
		
		MEMORIZE = 7;
		MEMORIZE_TAG = 'memorize';
		MEMORIZE_CATEGORY = Category.METADATA;
		MEMORIZE_FORMAT = Format.LOGICAL;
		
		P = 8;
		P_TAG = 'p';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		LONGITUDINAL = 9;
		LONGITUDINAL_TAG = 'longitudinal';
		LONGITUDINAL_CATEGORY = Category.PARAMETER;
		LONGITUDINAL_FORMAT = Format.LOGICAL;
		
		A1 = 10;
		A1_TAG = 'a1';
		A1_CATEGORY = Category.DATA;
		A1_FORMAT = Format.ITEM;
		
		A2 = 11;
		A2_TAG = 'a2';
		A2_CATEGORY = Category.DATA;
		A2_FORMAT = Format.ITEM;
		
		PERM_SEEDS = 12;
		PERM_SEEDS_TAG = 'perm_seeds';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		A1_PERM_DICT = 13;
		A1_PERM_DICT_TAG = 'a1_perm_dict';
		A1_PERM_DICT_CATEGORY = Category.RESULT;
		A1_PERM_DICT_FORMAT = Format.IDICT;
		
		A2_PERM_DICT = 14;
		A2_PERM_DICT_TAG = 'a2_perm_dict';
		A2_PERM_DICT_CATEGORY = Category.RESULT;
		A2_PERM_DICT_FORMAT = Format.IDICT;
		
		CP_DICT = 15;
		CP_DICT_TAG = 'cp_dict';
		CP_DICT_CATEGORY = Category.RESULT;
		CP_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function c_class = getClass()
			%GETCLASS returns the class of the group-based comparison.
			%
			% CLASS = CompareGroup.GETCLASS() returns the class 'CompareGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the group-based comparison C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('CompareGroup') returns 'CompareGroup'.
			%
			% See also getName, getDescription.
			
			c_class = 'CompareGroup';
		end
		function c_name = getName()
			%GETNAME returns the name of the group-based comparison.
			%
			% NAME = CompareGroup.GETNAME() returns the name of the 'group-based comparison'.
			%  Group-Based Comparison.
			%
			% Alternative forms to call this method are:
			%  NAME = C.GETNAME() returns the name of the group-based comparison C.
			%  NAME = Element.GETNAME(C) returns the name of 'C'.
			%  NAME = Element.GETNAME('CompareGroup') returns the name of 'CompareGroup'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			c_name = 'Group-Based Comparison';
		end
		function c_description = getDescription()
			%GETDESCRIPTION returns the description of the group-based comparison.
			%
			% STR = CompareGroup.GETDESCRIPTION() returns the description of the 'group-based comparison'.
			%  which is:
			%
			%  CompareGroup compares two group-based analyses, 
			%  which need to be of the same class.
			%
			% Alternative forms to call this method are:
			%  STR = C.GETDESCRIPTION() returns the description of the group-based comparison C.
			%  STR = Element.GETDESCRIPTION(C) returns the description of 'C'.
			%  STR = Element.GETDESCRIPTION('CompareGroup') returns the description of 'CompareGroup'.
			%
			% See also getClass, getName.
			
			c_description = [
				'CompareGroup compares two group-based analyses, ' ...
				'which need to be of the same class.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based comparison.
			%
			% PROPS = CompareGroup.GETPROPS() returns the property list of group-based comparison.
			%
			% PROPS = CompareGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the group-based comparison C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('CompareGroup'[, CATEGORY]) returns the property list of 'CompareGroup'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						CompareGroup.LABEL
						CompareGroup.NOTES
						CompareGroup.WAITBAR
						CompareGroup.VERBOSE
						CompareGroup.INTERRUPTIBLE
						CompareGroup.MEMORIZE
						];
				case Category.PARAMETER
					prop_list = [
						CompareGroup.P
						CompareGroup.LONGITUDINAL
						];
				case Category.DATA
					prop_list = [
						CompareGroup.ID
						CompareGroup.A1
						CompareGroup.A2
						];
				case Category.RESULT
					prop_list = [
						CompareGroup.PERM_SEEDS
						CompareGroup.A1_PERM_DICT
						CompareGroup.A2_PERM_DICT
						CompareGroup.CP_DICT
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						CompareGroup.ID
						CompareGroup.LABEL
						CompareGroup.NOTES
						CompareGroup.WAITBAR
						CompareGroup.VERBOSE
						CompareGroup.INTERRUPTIBLE
						CompareGroup.MEMORIZE
						CompareGroup.P
						CompareGroup.LONGITUDINAL
						CompareGroup.A1
						CompareGroup.A2
						CompareGroup.PERM_SEEDS
						CompareGroup.A1_PERM_DICT
						CompareGroup.A2_PERM_DICT
						CompareGroup.CP_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of group-based comparison.
			%
			% N = CompareGroup.GETPROPNUMBER() returns the property number of group-based comparison.
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER() returns the property number of the group-based comparison C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('CompareGroup') returns the property number of 'CompareGroup'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 15;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based comparison/error.
			%
			% CHECK = CompareGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(CompareGroup, PROP) checks whether PROP exists for CompareGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSPROP(CompareGroup, PROP) throws error if PROP does NOT exist for CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 ]);
			else
				assert( ...
					CompareGroup.existsProp(prop), ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareGroup.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based comparison/error.
			%
			% CHECK = CompareGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(CompareGroup, TAG) checks whether TAG exists for CompareGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSTAG(CompareGroup, TAG) throws error if TAG does NOT exist for CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				comparegroup_tag_list = { 'id'  'label'  'notes'  'waitbar'  'verbose'  'interruptible'  'memorize'  'p'  'longitudinal'  'a1'  'a2'  'perm_seeds'  'a1_perm_dict'  'a2_perm_dict'  'cp_dict' };
				
				check = any(strcmpi(tag, comparegroup_tag_list));
			else
				assert( ...
					CompareGroup.existsTag(tag), ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for CompareGroup'] ...
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
			%  PROPERTY = C.GETPROPPROP(POINTER) returns property number of POINTER of C.
			%  PROPERTY = Element.GETPROPPROP(CompareGroup, POINTER) returns property number of POINTER of CompareGroup.
			%  PROPERTY = C.GETPROPPROP(CompareGroup, POINTER) returns property number of POINTER of CompareGroup.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				comparegroup_tag_list = { 'id'  'label'  'notes'  'waitbar'  'verbose'  'interruptible'  'memorize'  'p'  'longitudinal'  'a1'  'a2'  'perm_seeds'  'a1_perm_dict'  'a2_perm_dict'  'cp_dict' };
				
				tag = pointer;
				CompareGroup.existsTag(tag);
				
				prop = find(strcmpi(tag, comparegroup_tag_list));
			else % numeric
				prop = pointer;
				CompareGroup.existsProp(prop);
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
			%  TAG = C.GETPROPTAG(POINTER) returns tag of POINTER of C.
			%  TAG = Element.GETPROPTAG(CompareGroup, POINTER) returns tag of POINTER of CompareGroup.
			%  TAG = C.GETPROPTAG(CompareGroup, POINTER) returns tag of POINTER of CompareGroup.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				CompareGroup.existsTag(tag);
			else % numeric
				prop = pointer;
				CompareGroup.existsProp(prop);
				
				switch prop
					case CompareGroup.ID
						tag = CompareGroup.ID_TAG;
					case CompareGroup.LABEL
						tag = CompareGroup.LABEL_TAG;
					case CompareGroup.NOTES
						tag = CompareGroup.NOTES_TAG;
					case CompareGroup.WAITBAR
						tag = CompareGroup.WAITBAR_TAG;
					case CompareGroup.VERBOSE
						tag = CompareGroup.VERBOSE_TAG;
					case CompareGroup.INTERRUPTIBLE
						tag = CompareGroup.INTERRUPTIBLE_TAG;
					case CompareGroup.MEMORIZE
						tag = CompareGroup.MEMORIZE_TAG;
					case CompareGroup.P
						tag = CompareGroup.P_TAG;
					case CompareGroup.LONGITUDINAL
						tag = CompareGroup.LONGITUDINAL_TAG;
					case CompareGroup.A1
						tag = CompareGroup.A1_TAG;
					case CompareGroup.A2
						tag = CompareGroup.A2_TAG;
					case CompareGroup.PERM_SEEDS
						tag = CompareGroup.PERM_SEEDS_TAG;
					case CompareGroup.A1_PERM_DICT
						tag = CompareGroup.A1_PERM_DICT_TAG;
					case CompareGroup.A2_PERM_DICT
						tag = CompareGroup.A2_PERM_DICT_TAG;
					case CompareGroup.CP_DICT
						tag = CompareGroup.CP_DICT_TAG;
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
			%  CATEGORY = C.GETPROPCATEGORY(POINTER) returns category of POINTER of C.
			%  CATEGORY = Element.GETPROPCATEGORY(CompareGroup, POINTER) returns category of POINTER of CompareGroup.
			%  CATEGORY = C.GETPROPCATEGORY(CompareGroup, POINTER) returns category of POINTER of CompareGroup.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					prop_category = CompareGroup.ID_CATEGORY;
				case CompareGroup.LABEL
					prop_category = CompareGroup.LABEL_CATEGORY;
				case CompareGroup.NOTES
					prop_category = CompareGroup.NOTES_CATEGORY;
				case CompareGroup.WAITBAR
					prop_category = CompareGroup.WAITBAR_CATEGORY;
				case CompareGroup.VERBOSE
					prop_category = CompareGroup.VERBOSE_CATEGORY;
				case CompareGroup.INTERRUPTIBLE
					prop_category = CompareGroup.INTERRUPTIBLE_CATEGORY;
				case CompareGroup.MEMORIZE
					prop_category = CompareGroup.MEMORIZE_CATEGORY;
				case CompareGroup.P
					prop_category = CompareGroup.P_CATEGORY;
				case CompareGroup.LONGITUDINAL
					prop_category = CompareGroup.LONGITUDINAL_CATEGORY;
				case CompareGroup.A1
					prop_category = CompareGroup.A1_CATEGORY;
				case CompareGroup.A2
					prop_category = CompareGroup.A2_CATEGORY;
				case CompareGroup.PERM_SEEDS
					prop_category = CompareGroup.PERM_SEEDS_CATEGORY;
				case CompareGroup.A1_PERM_DICT
					prop_category = CompareGroup.A1_PERM_DICT_CATEGORY;
				case CompareGroup.A2_PERM_DICT
					prop_category = CompareGroup.A2_PERM_DICT_CATEGORY;
				case CompareGroup.CP_DICT
					prop_category = CompareGroup.CP_DICT_CATEGORY;
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
			%  FORMAT = C.GETPROPFORMAT(POINTER) returns format of POINTER of C.
			%  FORMAT = Element.GETPROPFORMAT(CompareGroup, POINTER) returns format of POINTER of CompareGroup.
			%  FORMAT = C.GETPROPFORMAT(CompareGroup, POINTER) returns format of POINTER of CompareGroup.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					prop_format = CompareGroup.ID_FORMAT;
				case CompareGroup.LABEL
					prop_format = CompareGroup.LABEL_FORMAT;
				case CompareGroup.NOTES
					prop_format = CompareGroup.NOTES_FORMAT;
				case CompareGroup.WAITBAR
					prop_format = CompareGroup.WAITBAR_FORMAT;
				case CompareGroup.VERBOSE
					prop_format = CompareGroup.VERBOSE_FORMAT;
				case CompareGroup.INTERRUPTIBLE
					prop_format = CompareGroup.INTERRUPTIBLE_FORMAT;
				case CompareGroup.MEMORIZE
					prop_format = CompareGroup.MEMORIZE_FORMAT;
				case CompareGroup.P
					prop_format = CompareGroup.P_FORMAT;
				case CompareGroup.LONGITUDINAL
					prop_format = CompareGroup.LONGITUDINAL_FORMAT;
				case CompareGroup.A1
					prop_format = CompareGroup.A1_FORMAT;
				case CompareGroup.A2
					prop_format = CompareGroup.A2_FORMAT;
				case CompareGroup.PERM_SEEDS
					prop_format = CompareGroup.PERM_SEEDS_FORMAT;
				case CompareGroup.A1_PERM_DICT
					prop_format = CompareGroup.A1_PERM_DICT_FORMAT;
				case CompareGroup.A2_PERM_DICT
					prop_format = CompareGroup.A2_PERM_DICT_FORMAT;
				case CompareGroup.CP_DICT
					prop_format = CompareGroup.CP_DICT_FORMAT;
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
			%  DESCRIPTION = C.GETPROPDESCRIPTION(POINTER) returns description of POINTER of C.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareGroup, POINTER) returns description of POINTER of CompareGroup.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(CompareGroup, POINTER) returns description of POINTER of CompareGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the comparison.';
				case CompareGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the comparison.';
				case CompareGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the comparison.';
				case CompareGroup.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
				case CompareGroup.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) sets whether to write the progress of the comparisons.';
				case CompareGroup.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (metadata, scalar) sets whether the comparison computation is interruptible for multitasking.';
				case CompareGroup.MEMORIZE
					prop_description = 'MEMORIZE (metadata, logical) sets whether to memorize the permuted analysis.';
				case CompareGroup.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case CompareGroup.LONGITUDINAL
					prop_description = 'LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.';
				case CompareGroup.A1
					prop_description = 'A1 (data, item) is the first analysis to compare.';
				case CompareGroup.A2
					prop_description = 'A2 (data, item) is the second analysis to compare.';
				case CompareGroup.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case CompareGroup.A1_PERM_DICT
					prop_description = 'A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.';
				case CompareGroup.A2_PERM_DICT
					prop_description = 'A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.';
				case CompareGroup.CP_DICT
					prop_description = 'CP_DICT (result, idict) contains the results of the comparison.';
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
			%  SETTINGS = C.GETPROPSETTINGS(POINTER) returns settings of POINTER of C.
			%  SETTINGS = Element.GETPROPSETTINGS(CompareGroup, POINTER) returns settings of POINTER of CompareGroup.
			%  SETTINGS = C.GETPROPSETTINGS(CompareGroup, POINTER) returns settings of POINTER of CompareGroup.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareGroup.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareGroup.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareGroup.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareGroup.MEMORIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareGroup.LONGITUDINAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.A1
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.A2
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CompareGroup.A1_PERM_DICT
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.A2_PERM_DICT
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.CP_DICT
					prop_settings = 'ComparisonGroup';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareGroup, POINTER) returns the default value of POINTER of CompareGroup.
			%  DEFAULT = C.GETPROPDEFAULT(CompareGroup, POINTER) returns the default value of POINTER of CompareGroup.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					prop_default = Format.getFormatDefault(Format.STRING, CompareGroup.getPropSettings(prop));
				case CompareGroup.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, CompareGroup.getPropSettings(prop));
				case CompareGroup.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, CompareGroup.getPropSettings(prop));
				case CompareGroup.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareGroup.getPropSettings(prop));
				case CompareGroup.VERBOSE
					prop_default = false;
				case CompareGroup.INTERRUPTIBLE
					prop_default = .001;
				case CompareGroup.MEMORIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareGroup.getPropSettings(prop));
				case CompareGroup.P
					prop_default = 1e+4;
				case CompareGroup.LONGITUDINAL
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
				case CompareGroup.CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareGroup, POINTER) returns the conditioned default value of POINTER of CompareGroup.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(CompareGroup, POINTER) returns the conditioned default value of POINTER of CompareGroup.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			prop_default = CompareGroup.conditioning(prop, CompareGroup.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = C.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = C.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of C.
			%  CHECK = Element.CHECKPROP(CompareGroup, PROP, VALUE) checks VALUE format for PROP of CompareGroup.
			%  CHECK = C.CHECKPROP(CompareGroup, PROP, VALUE) checks VALUE format for PROP of CompareGroup.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:CompareGroup:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.CHECKPROP(CompareGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  C.CHECKPROP(CompareGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.ID
					check = Format.checkFormat(Format.STRING, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.LABEL
					check = Format.checkFormat(Format.STRING, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.NOTES
					check = Format.checkFormat(Format.STRING, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.VERBOSE
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.INTERRUPTIBLE
					check = Format.checkFormat(Format.SCALAR, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.MEMORIZE
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.P
					check = Format.checkFormat(Format.SCALAR, value, CompareGroup.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case CompareGroup.LONGITUDINAL
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM_SEEDS
					check = Format.checkFormat(Format.RVECTOR, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1_PERM_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2_PERM_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.CP_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareGroup.getPropTag(prop) ' (' CompareGroup.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function c = CompareGroup(varargin)
			% CompareGroup() creates a group-based comparison.
			%
			% CompareGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareGroup(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CompareGroup properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the comparison.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the comparison.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the comparison.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>verbose</strong> 	VERBOSE (metadata, logical) sets whether to write the progress of the comparisons.
			%  <strong>6</strong> <strong>interruptible</strong> 	INTERRUPTIBLE (metadata, scalar) sets whether the comparison computation is interruptible for multitasking.
			%  <strong>7</strong> <strong>memorize</strong> 	MEMORIZE (metadata, logical) sets whether to memorize the permuted analysis.
			%  <strong>8</strong> <strong>p</strong> 	P (parameter, scalar) is the permutation number.
			%  <strong>9</strong> <strong>longitudinal</strong> 	LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.
			%  <strong>10</strong> <strong>a1</strong> 	A1 (data, item) is the first analysis to compare.
			%  <strong>11</strong> <strong>a2</strong> 	A2 (data, item) is the second analysis to compare.
			%  <strong>12</strong> <strong>perm_seeds</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>13</strong> <strong>a1_perm_dict</strong> 	A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
			%  <strong>14</strong> <strong>a2_perm_dict</strong> 	A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
			%  <strong>15</strong> <strong>cp_dict</strong> 	CP_DICT (result, idict) contains the results of the comparison.
			%
			% See also Category, Format, set, check.
			
			c = c@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(c, prop, value)
			check = true;
			msg = ['Error while checking' tostring(c) ' ' c.getPropTag(prop) '.'];
			
			switch prop
				case CompareGroup.A1
					check = isa(value, c.get('A2').getClass());
					
				case CompareGroup.A2
					check = isa(value, c.get('A1').getClass());
					
				otherwise
					[check, msg] = checkValue@Element(c, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(c, prop)
		
			switch prop
				case CompareGroup.PERM_SEEDS
					rng(c.getPropSeed(CompareGroup.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, c.get('P'));
					
				case CompareGroup.A1_PERM_DICT
					rng(c.getPropSeed(CompareGroup.A1_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup', 'IT_KEY', 1);
					
				case CompareGroup.A2_PERM_DICT
					rng(c.getPropSeed(CompareGroup.A2_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup', 'IT_KEY', 1);
					
				case CompareGroup.CP_DICT
					rng(c.getPropSeed(CompareGroup.CP_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'ComparisonGroup', 'IT_KEY', 4);
					
				otherwise
					value = calculateValue@Element(c, prop);
					
			end
		end
	end
	methods % methods
		function cp = getComparison(c, measure_class, varargin)
		    %GETCOMPARISON returns comparison.
		    %
		    % CP = GETMEASURE(G, MEASURE_CLASS) checks if the comparison exists in the
		    %  comparison dictionary CP_DICT. If not, it creates a new comparison
		    %  CP of class MEASURE_CLASS. The user must call getValue() for the new
		    %  comparison CP to retrieve the value of the comparison. 
		    %
		    % See also ComparisonGroup.
		
		    cp_dict = c.memorize('CP_DICT');
		    if cp_dict.containsKey(measure_class)
		        cp = cp_dict.getItem(measure_class);
		    else
		        cp = ComparisonGroup( ...
		            'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
		            'MEASURE', measure_class, ...
		            'C', c, ...
		            varargin{:} ...
		            );
		        cp_dict.add(cp);
		    end
		end
		function [a1_perm, a2_perm] = getPerm(c, i, memorize)
		    %GETPERM returns the permuted analyses.
		    %
		    % [A1P, A2P] = GETPERM(C, I) retunrs the I-th permutations for the analysis
		    %  A1P and A2P. The number of perutations must be smaller than the
		    %  permutation number P, which is one of the properties of the comparison.
		    %
		    % [A1P, A2P] = GETPERM(C, I, true) memorizes the resulting permutations.
		
		    if nargin < 3
		        memorize = false;
		    end
		    
		    a1_perm_dict = c.memorize('A1_PERM_DICT');
		    a2_perm_dict = c.memorize('A2_PERM_DICT');
		    if a1_perm_dict.containsIndex(i) && a2_perm_dict.containsIndex(i)
		        % retrieves if already memorized
		        a1_perm = a1_perm_dict.getItem(i);
		        a2_perm = a2_perm_dict.getItem(i);
		    else    
		        % permutation
		        seeds = c.get('PERM_SEEDS');
		        rng(seeds(i), 'twister')
		
		        subs1 = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
		        subs2 = c.get('A2').get('GR').get('SUB_DICT').get('IT_LIST');
		
		        [subs1_perm, subs2_perm] = permutation(subs1, subs2, c.get('LONGITUDINAL'));
		
		        a1_perm = c.get('A1').clone();
		        a1_perm.set( ...
		            'ID', [c.get('A1').get('ID') ' permutation ' int2str(i)], ...
		            'GR', c.get('A1').get('GR').clone() ...
		            )
		        a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
		        a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs1_perm)
		
		        a2_perm = c.get('A2').clone();
		        a2_perm.set( ...
		            'ID', [c.get('A2').get('ID') ' permutation ' int2str(i)], ...
		            'GR', c.get('A2').get('GR').clone() ...
		            )
		        a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
		        a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs2_perm)
		
		        % memorize permutations if required
		        if memorize
		            a1_perm_dict.add(a1_perm)
		            a2_perm_dict.add(a2_perm)
		        end
		    end
		end
	end
	methods % GUI
		function pr = getPlotProp(c, prop, varargin)
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
				case CompareGroup.NOTES
					pr = PlotPropString('EL', c, 'PROP', CompareGroup.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case CompareGroup.CP_DICT
					a1 = c.get('A1');
					pr = a1.getPPCompareGroup_CPDict('EL', c, 'PROP', CompareGroup.CP_DICT, 'WAITBAR', true, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(c, prop, varargin{:});
					
			end
		end
	end
end
