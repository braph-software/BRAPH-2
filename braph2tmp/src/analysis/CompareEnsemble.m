classdef CompareEnsemble < Element
	% CompareEnsemble is a comparison between two ensemble-based analyses.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% CompareEnsemble compares two ensemble-based analyses, 
	% which need to be of the same class.
	%
	% The list of CompareEnsemble properties is:
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
	% CompareEnsemble methods (constructor):
	% CompareEnsemble - constructor
	%
	% CompareEnsemble methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in ensemble-based comparison/error.
	%  existsProp - checks whether property exists in ensemble-based comparison/error.
	%  getPropNumber - returns the property number of ensemble-based comparison.
	%  getProps - returns the property list of ensemble-based comparison.
	%  getDescription - returns the description of the ensemble-based comparison.
	%  getName - returns the name of the ensemble-based comparison.
	%  getClass - returns the class of the ensemble-based comparison.
	%
	% CompareEnsemble methods:
	%  getPerm - returns the permuted analyses.
	%  getComparison - E returns comparison.
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
	% CompareEnsemble methods (operators):
	%  isequal - determines whether two CompareEnsemble are equal (values, locked)
	%
	% CompareEnsemble methods (display):
	%  tostring - string with information about the CompareEnsemble
	%  disp - displays information about the CompareEnsemble
	%  tree - displays the element of CompareEnsemble
	%
	% CompareEnsemble method (element list):
	%  getElementList - returns a list with all subelements of CompareEnsemble
	%
	% CompareEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the CompareEnsemble
	%
	% CompareEnsemble method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the CompareEnsemble
	%
	% CompareEnsemble methods (copy):
	%  copy - copies the CompareEnsemble
	%  deepclone - deep-clones the CompareEnsemble
	%  clone - clones the CompareEnsemble
	%
	% CompareEnsemble methods (inspection, Static):
	%  getClass - returns CompareEnsemble
	%  getName - returns the name of CompareEnsemble
	%  getDescription - returns the description of CompareEnsemble
	%  getProps - returns the property list of CompareEnsemble
	%  getPropNumber - returns the property number of CompareEnsemble
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
	% CompareEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareEnsemble methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% CompareEnsemble methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% CompareEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% CompareEnsemble properties (Constant).
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
	% See also AnalyzeEnsemble, ComparisonEnsemble.
	
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
			%GETCLASS returns the class of the ensemble-based comparison.
			%
			% CLASS = CompareEnsemble.GETCLASS() returns the class 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the ensemble-based comparison C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('CompareEnsemble') returns 'CompareEnsemble'.
			%
			% See also getName, getDescription.
			
			c_class = 'CompareEnsemble';
		end
		function c_name = getName()
			%GETNAME returns the name of the ensemble-based comparison.
			%
			% NAME = CompareEnsemble.GETNAME() returns the name of the 'ensemble-based comparison'.
			%  Ensemble-Based Comparison.
			%
			% Alternative forms to call this method are:
			%  NAME = C.GETNAME() returns the name of the ensemble-based comparison C.
			%  NAME = Element.GETNAME(C) returns the name of 'C'.
			%  NAME = Element.GETNAME('CompareEnsemble') returns the name of 'CompareEnsemble'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			c_name = 'Ensemble-Based Comparison';
		end
		function c_description = getDescription()
			%GETDESCRIPTION returns the description of the ensemble-based comparison.
			%
			% STR = CompareEnsemble.GETDESCRIPTION() returns the description of the 'ensemble-based comparison'.
			%  which is:
			%
			%  CompareEnsemble compares two ensemble-based analyses, 
			%  which need to be of the same class.
			%
			% Alternative forms to call this method are:
			%  STR = C.GETDESCRIPTION() returns the description of the ensemble-based comparison C.
			%  STR = Element.GETDESCRIPTION(C) returns the description of 'C'.
			%  STR = Element.GETDESCRIPTION('CompareEnsemble') returns the description of 'CompareEnsemble'.
			%
			% See also getClass, getName.
			
			c_description = [
				'CompareEnsemble compares two ensemble-based analyses, ' ...
				'which need to be of the same class.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based comparison.
			%
			% PROPS = CompareEnsemble.GETPROPS() returns the property list of ensemble-based comparison.
			%
			% PROPS = CompareEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the ensemble-based comparison C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('CompareEnsemble'[, CATEGORY]) returns the property list of 'CompareEnsemble'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						CompareEnsemble.LABEL
						CompareEnsemble.NOTES
						CompareEnsemble.WAITBAR
						CompareEnsemble.VERBOSE
						CompareEnsemble.INTERRUPTIBLE
						CompareEnsemble.MEMORIZE
						];
				case Category.PARAMETER
					prop_list = [
						CompareEnsemble.P
						CompareEnsemble.LONGITUDINAL
						];
				case Category.DATA
					prop_list = [
						CompareEnsemble.ID
						CompareEnsemble.A1
						CompareEnsemble.A2
						];
				case Category.RESULT
					prop_list = [
						CompareEnsemble.PERM_SEEDS
						CompareEnsemble.A1_PERM_DICT
						CompareEnsemble.A2_PERM_DICT
						CompareEnsemble.CP_DICT
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						CompareEnsemble.ID
						CompareEnsemble.LABEL
						CompareEnsemble.NOTES
						CompareEnsemble.WAITBAR
						CompareEnsemble.VERBOSE
						CompareEnsemble.INTERRUPTIBLE
						CompareEnsemble.MEMORIZE
						CompareEnsemble.P
						CompareEnsemble.LONGITUDINAL
						CompareEnsemble.A1
						CompareEnsemble.A2
						CompareEnsemble.PERM_SEEDS
						CompareEnsemble.A1_PERM_DICT
						CompareEnsemble.A2_PERM_DICT
						CompareEnsemble.CP_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of ensemble-based comparison.
			%
			% N = CompareEnsemble.GETPROPNUMBER() returns the property number of ensemble-based comparison.
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER() returns the property number of the ensemble-based comparison C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('CompareEnsemble') returns the property number of 'CompareEnsemble'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 15;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(CompareEnsemble, PROP) checks whether PROP exists for CompareEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(CompareEnsemble, PROP) throws error if PROP does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 ]);
			else
				assert( ...
					CompareEnsemble.existsProp(prop), ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareEnsemble.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(CompareEnsemble, TAG) checks whether TAG exists for CompareEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(CompareEnsemble, TAG) throws error if TAG does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				compareensemble_tag_list = { 'id'  'label'  'notes'  'waitbar'  'verbose'  'interruptible'  'memorize'  'p'  'longitudinal'  'a1'  'a2'  'perm_seeds'  'a1_perm_dict'  'a2_perm_dict'  'cp_dict' };
				
				check = any(strcmpi(tag, compareensemble_tag_list));
			else
				assert( ...
					CompareEnsemble.existsTag(tag), ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for CompareEnsemble'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%  PROPERTY = C.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				compareensemble_tag_list = { 'id'  'label'  'notes'  'waitbar'  'verbose'  'interruptible'  'memorize'  'p'  'longitudinal'  'a1'  'a2'  'perm_seeds'  'a1_perm_dict'  'a2_perm_dict'  'cp_dict' };
				
				tag = pointer;
				CompareEnsemble.existsTag(tag);
				
				prop = find(strcmpi(tag, compareensemble_tag_list));
			else % numeric
				prop = pointer;
				CompareEnsemble.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%  TAG = C.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				CompareEnsemble.existsTag(tag);
			else % numeric
				prop = pointer;
				CompareEnsemble.existsProp(prop);
				
				switch prop
					case CompareEnsemble.ID
						tag = CompareEnsemble.ID_TAG;
					case CompareEnsemble.LABEL
						tag = CompareEnsemble.LABEL_TAG;
					case CompareEnsemble.NOTES
						tag = CompareEnsemble.NOTES_TAG;
					case CompareEnsemble.WAITBAR
						tag = CompareEnsemble.WAITBAR_TAG;
					case CompareEnsemble.VERBOSE
						tag = CompareEnsemble.VERBOSE_TAG;
					case CompareEnsemble.INTERRUPTIBLE
						tag = CompareEnsemble.INTERRUPTIBLE_TAG;
					case CompareEnsemble.MEMORIZE
						tag = CompareEnsemble.MEMORIZE_TAG;
					case CompareEnsemble.P
						tag = CompareEnsemble.P_TAG;
					case CompareEnsemble.LONGITUDINAL
						tag = CompareEnsemble.LONGITUDINAL_TAG;
					case CompareEnsemble.A1
						tag = CompareEnsemble.A1_TAG;
					case CompareEnsemble.A2
						tag = CompareEnsemble.A2_TAG;
					case CompareEnsemble.PERM_SEEDS
						tag = CompareEnsemble.PERM_SEEDS_TAG;
					case CompareEnsemble.A1_PERM_DICT
						tag = CompareEnsemble.A1_PERM_DICT_TAG;
					case CompareEnsemble.A2_PERM_DICT
						tag = CompareEnsemble.A2_PERM_DICT_TAG;
					case CompareEnsemble.CP_DICT
						tag = CompareEnsemble.CP_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%  CATEGORY = C.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					prop_category = CompareEnsemble.ID_CATEGORY;
				case CompareEnsemble.LABEL
					prop_category = CompareEnsemble.LABEL_CATEGORY;
				case CompareEnsemble.NOTES
					prop_category = CompareEnsemble.NOTES_CATEGORY;
				case CompareEnsemble.WAITBAR
					prop_category = CompareEnsemble.WAITBAR_CATEGORY;
				case CompareEnsemble.VERBOSE
					prop_category = CompareEnsemble.VERBOSE_CATEGORY;
				case CompareEnsemble.INTERRUPTIBLE
					prop_category = CompareEnsemble.INTERRUPTIBLE_CATEGORY;
				case CompareEnsemble.MEMORIZE
					prop_category = CompareEnsemble.MEMORIZE_CATEGORY;
				case CompareEnsemble.P
					prop_category = CompareEnsemble.P_CATEGORY;
				case CompareEnsemble.LONGITUDINAL
					prop_category = CompareEnsemble.LONGITUDINAL_CATEGORY;
				case CompareEnsemble.A1
					prop_category = CompareEnsemble.A1_CATEGORY;
				case CompareEnsemble.A2
					prop_category = CompareEnsemble.A2_CATEGORY;
				case CompareEnsemble.PERM_SEEDS
					prop_category = CompareEnsemble.PERM_SEEDS_CATEGORY;
				case CompareEnsemble.A1_PERM_DICT
					prop_category = CompareEnsemble.A1_PERM_DICT_CATEGORY;
				case CompareEnsemble.A2_PERM_DICT
					prop_category = CompareEnsemble.A2_PERM_DICT_CATEGORY;
				case CompareEnsemble.CP_DICT
					prop_category = CompareEnsemble.CP_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%  FORMAT = C.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					prop_format = CompareEnsemble.ID_FORMAT;
				case CompareEnsemble.LABEL
					prop_format = CompareEnsemble.LABEL_FORMAT;
				case CompareEnsemble.NOTES
					prop_format = CompareEnsemble.NOTES_FORMAT;
				case CompareEnsemble.WAITBAR
					prop_format = CompareEnsemble.WAITBAR_FORMAT;
				case CompareEnsemble.VERBOSE
					prop_format = CompareEnsemble.VERBOSE_FORMAT;
				case CompareEnsemble.INTERRUPTIBLE
					prop_format = CompareEnsemble.INTERRUPTIBLE_FORMAT;
				case CompareEnsemble.MEMORIZE
					prop_format = CompareEnsemble.MEMORIZE_FORMAT;
				case CompareEnsemble.P
					prop_format = CompareEnsemble.P_FORMAT;
				case CompareEnsemble.LONGITUDINAL
					prop_format = CompareEnsemble.LONGITUDINAL_FORMAT;
				case CompareEnsemble.A1
					prop_format = CompareEnsemble.A1_FORMAT;
				case CompareEnsemble.A2
					prop_format = CompareEnsemble.A2_FORMAT;
				case CompareEnsemble.PERM_SEEDS
					prop_format = CompareEnsemble.PERM_SEEDS_FORMAT;
				case CompareEnsemble.A1_PERM_DICT
					prop_format = CompareEnsemble.A1_PERM_DICT_FORMAT;
				case CompareEnsemble.A2_PERM_DICT
					prop_format = CompareEnsemble.A2_PERM_DICT_FORMAT;
				case CompareEnsemble.CP_DICT
					prop_format = CompareEnsemble.CP_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the comparison.';
				case CompareEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the comparison.';
				case CompareEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the comparison.';
				case CompareEnsemble.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
				case CompareEnsemble.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) sets whether to write the progress of the comparisons.';
				case CompareEnsemble.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (metadata, scalar) sets whether the comparison computation is interruptible for multitasking.';
				case CompareEnsemble.MEMORIZE
					prop_description = 'MEMORIZE (metadata, logical) sets whether to memorize the permuted analysis.';
				case CompareEnsemble.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case CompareEnsemble.LONGITUDINAL
					prop_description = 'LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.';
				case CompareEnsemble.A1
					prop_description = 'A1 (data, item) is the first analysis to compare.';
				case CompareEnsemble.A2
					prop_description = 'A2 (data, item) is the second analysis to compare.';
				case CompareEnsemble.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case CompareEnsemble.A1_PERM_DICT
					prop_description = 'A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.';
				case CompareEnsemble.A2_PERM_DICT
					prop_description = 'A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.';
				case CompareEnsemble.CP_DICT
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
			%  SETTINGS = Element.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%  SETTINGS = C.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareEnsemble.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareEnsemble.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CompareEnsemble.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareEnsemble.MEMORIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareEnsemble.LONGITUDINAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.A1
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.A2
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CompareEnsemble.A1_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.A2_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.CP_DICT
					prop_settings = 'ComparisonEnsemble';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					prop_default = Format.getFormatDefault(Format.STRING, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.VERBOSE
					prop_default = false;
				case CompareEnsemble.INTERRUPTIBLE
					prop_default = .001;
				case CompareEnsemble.MEMORIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.P
					prop_default = 1e+4;
				case CompareEnsemble.LONGITUDINAL
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			prop_default = CompareEnsemble.conditioning(prop, CompareEnsemble.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			%  CHECK = C.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  C.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.ID
					check = Format.checkFormat(Format.STRING, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.LABEL
					check = Format.checkFormat(Format.STRING, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.NOTES
					check = Format.checkFormat(Format.STRING, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.VERBOSE
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.INTERRUPTIBLE
					check = Format.checkFormat(Format.SCALAR, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.MEMORIZE
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.P
					check = Format.checkFormat(Format.SCALAR, value, CompareEnsemble.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case CompareEnsemble.LONGITUDINAL
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM_SEEDS
					check = Format.checkFormat(Format.RVECTOR, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1_PERM_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2_PERM_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.CP_DICT
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareEnsemble.getPropTag(prop) ' (' CompareEnsemble.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function c = CompareEnsemble(varargin)
			% CompareEnsemble() creates a ensemble-based comparison.
			%
			% CompareEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareEnsemble(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CompareEnsemble properties is:
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
			prop = CompareEnsemble.getPropProp(pointer);
			
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
				case CompareEnsemble.A1
					check = isa(value, c.get('A2').getClass());
					
				case CompareEnsemble.A2
					check = isa(value, c.get('A1').getClass());
					
				otherwise
					[check, msg] = checkValue@Element(c, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(c, prop)
		
			switch prop
				case CompareEnsemble.PERM_SEEDS
					rng(c.getPropSeed(CompareEnsemble.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, c.get('P'));
					
				case CompareEnsemble.A1_PERM_DICT
					rng(c.getPropSeed(CompareEnsemble.A1_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
				case CompareEnsemble.A2_PERM_DICT
					rng(c.getPropSeed(CompareEnsemble.A2_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
				case CompareEnsemble.CP_DICT
					rng(c.getPropSeed(CompareEnsemble.CP_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'ComparisonEnsemble', 'IT_KEY', 4);
					
				otherwise
					value = calculateValue@Element(c, prop);
					
			end
		end
	end
	methods % methods
		function cp = getComparison(c, measure_class, varargin)
		    %GETComparisonE returns comparison.
		    %
		    % CP = GETMEASURE(G, MEASURE_CLASS) checks if the comparison exists in the
		    %  comparison dictionary CP_DICT. If not, it creates a new comparison
		    %  CP of class MEASURE_CLASS. The user must call getValue() for the new
		    %  comparison CP to retrieve the value of the comparison. 
		    %
		    % See also ComparisonEnsemble.
		    
		    [wb, varargin] = get_and_remove_from_varargin([], 'waitbar', varargin{:});
		    
		    if ~isempty(wb)
		        c.set('waitbar', true);
		    end
		
		    cp_dict = c.memorize('CP_DICT');
		    if cp_dict.containsKey(measure_class)
		        cp = cp_dict.getItem(measure_class);
		    else
		        cp = ComparisonEnsemble( ...
		            'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
		            'MEASURE', measure_class, ...
		            'MEASUREPARAM', eval([measure_class '()']), ...
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
		
		        gdict1 = c.get('A1').get('G_DICT').get('IT_LIST');
		        gdict2 = c.get('A2').get('G_DICT').get('IT_LIST');
		        
		        subs1_gdict1 = cellfun(@(x, y) {x, y}, subs1, gdict1, 'UniformOutput', false);
		        subs2_gdict2 = cellfun(@(x, y) {x, y}, subs2, gdict2, 'UniformOutput', false);
		
		        [subs1_gdict1_perm, subs2_gdict2_perm] = permutation(subs1_gdict1, subs2_gdict2, c.get('LONGITUDINAL'));
		
		        a1_perm = c.get('A1').clone();
		        a1_perm.set( ...
		            'ID', [c.get('A1').get('ID') ' permutation ' int2str(i)], ...
		            'GR', c.get('A1').get('GR').clone() ...
		            )
		        a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
		        a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs1_gdict1_perm))
		        a1_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs1_gdict1_perm))
		
		        a2_perm = c.get('A2').clone();
		        a2_perm.set( ...
		            'ID', [c.get('A2').get('ID') ' permutation ' int2str(i)], ...
		            'GR', c.get('A2').get('GR').clone() ...
		            )
		        a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
		        a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs2_gdict2_perm))
		        a2_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs2_gdict2_perm))
		        
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
				case CompareEnsemble.NOTES
					pr = PlotPropString('EL', c, 'PROP', CompareEnsemble.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case CompareEnsemble.CP_DICT
					a1 = c.get('A1');
					pr = a1.getPPCompareEnsemble_CPDict('EL', c, 'PROP', CompareEnsemble.CP_DICT, 'WAITBAR', true, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(c, prop, varargin{:});
					
			end
		end
	end
end
