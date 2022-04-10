classdef ComparisonEnsemble < Element
	% ComparisonEnsemble contains the results of an ensemble-based comparison.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.
	% Specifically, it contains the one-tailed and two-tailed p-values 
	% and the 95%% confidence interval.
	%
	% The list of ComparisonEnsemble properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the ensemble-based comparison results.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based comparison results.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based comparison results.
	%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
	%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters.
	%  <strong>6</strong> <strong>c</strong> 	C (data, item) is the ensemble-based comparison.
	%  <strong>7</strong> <strong>diff</strong> 	DIFF (result, cell) is the ensemble comparison value.
	%  <strong>8</strong> <strong>p1</strong> 	P1 (result, cell) is the one-tailed p-value.
	%  <strong>9</strong> <strong>p2</strong> 	P2 (result, cell) is the two-tailed p-value.
	%  <strong>10</strong> <strong>cil</strong> 	CIL (result, cell) is the lower value of the 95%% confidence interval.
	%  <strong>11</strong> <strong>ciu</strong> 	CIU (result, cell) is the upper value of the 95%% confidence interval.
	%
	% ComparisonEnsemble methods (constructor):
	% ComparisonEnsemble - constructor
	%
	% ComparisonEnsemble methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in ensemble-based comparison results/error.
	%  existsProp - checks whether property exists in ensemble-based comparison results/error.
	%  getPropNumber - returns the property number of ensemble-based comparison results.
	%  getProps - returns the property list of ensemble-based comparison results.
	%  getDescription - returns the description of the ensemble-based comparison results.
	%  getName - returns the name of the ensemble-based comparison results.
	%  getClass - returns the class of the ensemble-based comparison results.
	%
	% ComparisonEnsemble methods:
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
	% ComparisonEnsemble methods (operators):
	%  isequal - determines whether two ComparisonEnsemble are equal (values, locked)
	%
	% ComparisonEnsemble methods (display):
	%  tostring - string with information about the ComparisonEnsemble
	%  disp - displays information about the ComparisonEnsemble
	%  tree - displays the element of ComparisonEnsemble
	%
	% ComparisonEnsemble method (element list):
	%  getElementList - returns a list with all subelements of ComparisonEnsemble
	%
	% ComparisonEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ComparisonEnsemble
	%
	% ComparisonEnsemble method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ComparisonEnsemble
	%
	% ComparisonEnsemble methods (copy):
	%  copy - copies the ComparisonEnsemble
	%  deepclone - deep-clones the ComparisonEnsemble
	%  clone - clones the ComparisonEnsemble
	%
	% ComparisonEnsemble methods (inspection, Static):
	%  getClass - returns ComparisonEnsemble
	%  getName - returns the name of ComparisonEnsemble
	%  getDescription - returns the description of ComparisonEnsemble
	%  getProps - returns the property list of ComparisonEnsemble
	%  getPropNumber - returns the property number of ComparisonEnsemble
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
	% ComparisonEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemble methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ComparisonEnsemble methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ComparisonEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ComparisonEnsemble properties (Constant).
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
	% See also CompareEnsemble, AnalyzeEnsemble.
	
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
			%GETCLASS returns the class of the ensemble-based comparison results.
			%
			% CLASS = ComparisonEnsemble.GETCLASS() returns the class 'ComparisonEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CP.GETCLASS() returns the class of the ensemble-based comparison results CP.
			%  CLASS = Element.GETCLASS(CP) returns the class of 'CP'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemble') returns 'ComparisonEnsemble'.
			%
			% See also getName, getDescription.
			
			cp_class = 'ComparisonEnsemble';
		end
		function cp_name = getName()
			%GETNAME returns the name of the ensemble-based comparison results.
			%
			% NAME = ComparisonEnsemble.GETNAME() returns the name of the 'ensemble-based comparison results'.
			%  Ensemble-Based Comparison Results.
			%
			% Alternative forms to call this method are:
			%  NAME = CP.GETNAME() returns the name of the ensemble-based comparison results CP.
			%  NAME = Element.GETNAME(CP) returns the name of 'CP'.
			%  NAME = Element.GETNAME('ComparisonEnsemble') returns the name of 'ComparisonEnsemble'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			cp_name = 'Ensemble-Based Comparison Results';
		end
		function cp_description = getDescription()
			%GETDESCRIPTION returns the description of the ensemble-based comparison results.
			%
			% STR = ComparisonEnsemble.GETDESCRIPTION() returns the description of the 'ensemble-based comparison results'.
			%  which is:
			%
			%  ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.
			%  Specifically, it contains the one-tailed and two-tailed p-values 
			%  and the 95%% confidence interval.
			%
			% Alternative forms to call this method are:
			%  STR = CP.GETDESCRIPTION() returns the description of the ensemble-based comparison results CP.
			%  STR = Element.GETDESCRIPTION(CP) returns the description of 'CP'.
			%  STR = Element.GETDESCRIPTION('ComparisonEnsemble') returns the description of 'ComparisonEnsemble'.
			%
			% See also getClass, getName.
			
			cp_description = [
				'ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.' ...
				'Specifically, it contains the one-tailed and two-tailed p-values ' ...
				'and the 95%% confidence interval.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based comparison results.
			%
			% PROPS = ComparisonEnsemble.GETPROPS() returns the property list of ensemble-based comparison results.
			%
			% PROPS = ComparisonEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CP.GETPROPS([CATEGORY]) returns the property list of the ensemble-based comparison results CP.
			%  PROPS = Element.GETPROPS(CP[, CATEGORY]) returns the property list of 'CP'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemble'[, CATEGORY]) returns the property list of 'ComparisonEnsemble'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ComparisonEnsemble.LABEL
						ComparisonEnsemble.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						ComparisonEnsemble.ID
						ComparisonEnsemble.MEASURE
						ComparisonEnsemble.MEASUREPARAM
						ComparisonEnsemble.C
						];
				case Category.RESULT
					prop_list = [
						ComparisonEnsemble.DIFF
						ComparisonEnsemble.P1
						ComparisonEnsemble.P2
						ComparisonEnsemble.CIL
						ComparisonEnsemble.CIU
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						ComparisonEnsemble.ID
						ComparisonEnsemble.LABEL
						ComparisonEnsemble.NOTES
						ComparisonEnsemble.MEASURE
						ComparisonEnsemble.MEASUREPARAM
						ComparisonEnsemble.C
						ComparisonEnsemble.DIFF
						ComparisonEnsemble.P1
						ComparisonEnsemble.P2
						ComparisonEnsemble.CIL
						ComparisonEnsemble.CIU
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of ensemble-based comparison results.
			%
			% N = ComparisonEnsemble.GETPROPNUMBER() returns the property number of ensemble-based comparison results.
			%
			% Alternative forms to call this method are:
			%  N = CP.GETPROPNUMBER() returns the property number of the ensemble-based comparison results CP.
			%  N = Element.GETPROPNUMBER(CP) returns the property number of 'CP'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemble') returns the property number of 'ComparisonEnsemble'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 11;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based comparison results/error.
			%
			% CHECK = ComparisonEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSPROP(PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(CP, PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemble, PROP) checks whether PROP exists for ComparisonEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSPROP(PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSPROP(CP, PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemble, PROP) throws error if PROP does NOT exist for ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11 ]);
			else
				assert( ...
					ComparisonEnsemble.existsProp(prop), ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemble.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based comparison results/error.
			%
			% CHECK = ComparisonEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSTAG(TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(CP, TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemble, TAG) checks whether TAG exists for ComparisonEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSTAG(TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSTAG(CP, TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemble, TAG) throws error if TAG does NOT exist for ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				comparisonensemble_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'c'  'diff'  'p1'  'p2'  'cil'  'ciu' };
				
				check = any(strcmpi(tag, comparisonensemble_tag_list));
			else
				assert( ...
					ComparisonEnsemble.existsTag(tag), ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemble'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemble, POINTER) returns property number of POINTER of ComparisonEnsemble.
			%  PROPERTY = CP.GETPROPPROP(ComparisonEnsemble, POINTER) returns property number of POINTER of ComparisonEnsemble.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				comparisonensemble_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'c'  'diff'  'p1'  'p2'  'cil'  'ciu' };
				
				tag = pointer;
				ComparisonEnsemble.existsTag(tag);
				
				prop = find(strcmpi(tag, comparisonensemble_tag_list));
			else % numeric
				prop = pointer;
				ComparisonEnsemble.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsemble, POINTER) returns tag of POINTER of ComparisonEnsemble.
			%  TAG = CP.GETPROPTAG(ComparisonEnsemble, POINTER) returns tag of POINTER of ComparisonEnsemble.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ComparisonEnsemble.existsTag(tag);
			else % numeric
				prop = pointer;
				ComparisonEnsemble.existsProp(prop);
				
				switch prop
					case ComparisonEnsemble.ID
						tag = ComparisonEnsemble.ID_TAG;
					case ComparisonEnsemble.LABEL
						tag = ComparisonEnsemble.LABEL_TAG;
					case ComparisonEnsemble.NOTES
						tag = ComparisonEnsemble.NOTES_TAG;
					case ComparisonEnsemble.MEASURE
						tag = ComparisonEnsemble.MEASURE_TAG;
					case ComparisonEnsemble.MEASUREPARAM
						tag = ComparisonEnsemble.MEASUREPARAM_TAG;
					case ComparisonEnsemble.C
						tag = ComparisonEnsemble.C_TAG;
					case ComparisonEnsemble.DIFF
						tag = ComparisonEnsemble.DIFF_TAG;
					case ComparisonEnsemble.P1
						tag = ComparisonEnsemble.P1_TAG;
					case ComparisonEnsemble.P2
						tag = ComparisonEnsemble.P2_TAG;
					case ComparisonEnsemble.CIL
						tag = ComparisonEnsemble.CIL_TAG;
					case ComparisonEnsemble.CIU
						tag = ComparisonEnsemble.CIU_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemble, POINTER) returns category of POINTER of ComparisonEnsemble.
			%  CATEGORY = CP.GETPROPCATEGORY(ComparisonEnsemble, POINTER) returns category of POINTER of ComparisonEnsemble.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					prop_category = ComparisonEnsemble.ID_CATEGORY;
				case ComparisonEnsemble.LABEL
					prop_category = ComparisonEnsemble.LABEL_CATEGORY;
				case ComparisonEnsemble.NOTES
					prop_category = ComparisonEnsemble.NOTES_CATEGORY;
				case ComparisonEnsemble.MEASURE
					prop_category = ComparisonEnsemble.MEASURE_CATEGORY;
				case ComparisonEnsemble.MEASUREPARAM
					prop_category = ComparisonEnsemble.MEASUREPARAM_CATEGORY;
				case ComparisonEnsemble.C
					prop_category = ComparisonEnsemble.C_CATEGORY;
				case ComparisonEnsemble.DIFF
					prop_category = ComparisonEnsemble.DIFF_CATEGORY;
				case ComparisonEnsemble.P1
					prop_category = ComparisonEnsemble.P1_CATEGORY;
				case ComparisonEnsemble.P2
					prop_category = ComparisonEnsemble.P2_CATEGORY;
				case ComparisonEnsemble.CIL
					prop_category = ComparisonEnsemble.CIL_CATEGORY;
				case ComparisonEnsemble.CIU
					prop_category = ComparisonEnsemble.CIU_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemble, POINTER) returns format of POINTER of ComparisonEnsemble.
			%  FORMAT = CP.GETPROPFORMAT(ComparisonEnsemble, POINTER) returns format of POINTER of ComparisonEnsemble.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					prop_format = ComparisonEnsemble.ID_FORMAT;
				case ComparisonEnsemble.LABEL
					prop_format = ComparisonEnsemble.LABEL_FORMAT;
				case ComparisonEnsemble.NOTES
					prop_format = ComparisonEnsemble.NOTES_FORMAT;
				case ComparisonEnsemble.MEASURE
					prop_format = ComparisonEnsemble.MEASURE_FORMAT;
				case ComparisonEnsemble.MEASUREPARAM
					prop_format = ComparisonEnsemble.MEASUREPARAM_FORMAT;
				case ComparisonEnsemble.C
					prop_format = ComparisonEnsemble.C_FORMAT;
				case ComparisonEnsemble.DIFF
					prop_format = ComparisonEnsemble.DIFF_FORMAT;
				case ComparisonEnsemble.P1
					prop_format = ComparisonEnsemble.P1_FORMAT;
				case ComparisonEnsemble.P2
					prop_format = ComparisonEnsemble.P2_FORMAT;
				case ComparisonEnsemble.CIL
					prop_format = ComparisonEnsemble.CIL_FORMAT;
				case ComparisonEnsemble.CIU
					prop_format = ComparisonEnsemble.CIU_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemble, POINTER) returns description of POINTER of ComparisonEnsemble.
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(ComparisonEnsemble, POINTER) returns description of POINTER of ComparisonEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the ensemble-based comparison results.';
				case ComparisonEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ensemble-based comparison results.';
				case ComparisonEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ensemble-based comparison results.';
				case ComparisonEnsemble.MEASURE
					prop_description = 'MEASURE (data, string) is the measure class.';
				case ComparisonEnsemble.MEASUREPARAM
					prop_description = 'MEASUREPARAM(data, item) provides the measure parameters.';
				case ComparisonEnsemble.C
					prop_description = 'C (data, item) is the ensemble-based comparison.';
				case ComparisonEnsemble.DIFF
					prop_description = 'DIFF (result, cell) is the ensemble comparison value.';
				case ComparisonEnsemble.P1
					prop_description = 'P1 (result, cell) is the one-tailed p-value.';
				case ComparisonEnsemble.P2
					prop_description = 'P2 (result, cell) is the two-tailed p-value.';
				case ComparisonEnsemble.CIL
					prop_description = 'CIL (result, cell) is the lower value of the 95%% confidence interval.';
				case ComparisonEnsemble.CIU
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemble, POINTER) returns settings of POINTER of ComparisonEnsemble.
			%  SETTINGS = CP.GETPROPSETTINGS(ComparisonEnsemble, POINTER) returns settings of POINTER of ComparisonEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonEnsemble.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonEnsemble.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonEnsemble.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ComparisonEnsemble.MEASUREPARAM
					prop_settings = 'Measure';
				case ComparisonEnsemble.C
					prop_settings = 'CompareEnsemble';
				case ComparisonEnsemble.DIFF
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonEnsemble.P1
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonEnsemble.P2
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonEnsemble.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonEnsemble.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemble, POINTER) returns the default value of POINTER of ComparisonEnsemble.
			%  DEFAULT = CP.GETPROPDEFAULT(ComparisonEnsemble, POINTER) returns the default value of POINTER of ComparisonEnsemble.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.MEASUREPARAM
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.C
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.DIFF
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.P1
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.P2
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.CIL
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.CIU
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonEnsemble.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemble, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemble.
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(ComparisonEnsemble, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemble.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			prop_default = ComparisonEnsemble.conditioning(prop, ComparisonEnsemble.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsemble, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemble.
			%  CHECK = CP.CHECKPROP(ComparisonEnsemble, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemble.
			% 
			% CP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.CHECKPROP(ComparisonEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  CP.CHECKPROP(ComparisonEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemble.ID
					check = Format.checkFormat(Format.STRING, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.LABEL
					check = Format.checkFormat(Format.STRING, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.NOTES
					check = Format.checkFormat(Format.STRING, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.MEASURE
					check = Format.checkFormat(Format.STRING, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.MEASUREPARAM
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.C
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.DIFF
					check = Format.checkFormat(Format.CELL, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.P1
					check = Format.checkFormat(Format.CELL, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.P2
					check = Format.checkFormat(Format.CELL, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.CIL
					check = Format.checkFormat(Format.CELL, value, ComparisonEnsemble.getPropSettings(prop));
				case ComparisonEnsemble.CIU
					check = Format.checkFormat(Format.CELL, value, ComparisonEnsemble.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemble.getPropTag(prop) ' (' ComparisonEnsemble.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function cp = ComparisonEnsemble(varargin)
			% ComparisonEnsemble() creates a ensemble-based comparison results.
			%
			% ComparisonEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemble(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonEnsemble properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the ensemble-based comparison results.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based comparison results.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based comparison results.
			%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
			%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters.
			%  <strong>6</strong> <strong>c</strong> 	C (data, item) is the ensemble-based comparison.
			%  <strong>7</strong> <strong>diff</strong> 	DIFF (result, cell) is the ensemble comparison value.
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
			prop = ComparisonEnsemble.getPropProp(pointer);
			
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
				case ComparisonEnsemble.DIFF
					rng(cp.getPropSeed(ComparisonEnsemble.DIFF), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = diff;
					
				case ComparisonEnsemble.P1
					rng(cp.getPropSeed(ComparisonEnsemble.P1), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = p1;
					
				case ComparisonEnsemble.P2
					rng(cp.getPropSeed(ComparisonEnsemble.P2), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = p2;
					
				case ComparisonEnsemble.CIL
					rng(cp.getPropSeed(ComparisonEnsemble.CIL), 'twister')
					
					[diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp);
					value = ci_lower;
					
				case ComparisonEnsemble.CIU
					rng(cp.getPropSeed(ComparisonEnsemble.CIU), 'twister')
					
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
		    % [P1, P2, CIL, CIU] = CALCULATE_RESULTS(CP) calcultes the one-talied
		    %  p-value P1, the two-tailed p-value P2, the lower bound of the confidence
		    %  interval CIL, and the the upper bound of the confidence interval.
		    %  Typically, this methos is only called internally.
		
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
		        wb = waitbar(0, 'Comparing ensemble analyses ...', 'Name', BRAPH2.NAME);
		        set_braph2icon(wb)
		    end
		
		    % Pre-calculate and save measures of all subjects
		    ms1 = cellfun(@(x) x.getMeasure(measure_class, varargin{:}).memorize('M'), c.get('A1').memorize('G_DICT').getItems, 'UniformOutput', false);
		    ms2 = cellfun(@(x) x.getMeasure(measure_class, varargin{:}).memorize('M'), c.get('A2').memorize('G_DICT').getItems, 'UniformOutput', false);
		    
		    % Measure for groups 1 and 2, and their difference
		    m1 = c.get('A1').getMeasureEnsemble(measure_class).memorize('M');
		    m2 = c.get('A2').getMeasureEnsemble(measure_class).memorize('M');
		    diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);
		
		    % Permutations
		    P = c.get('P'); %#ok<*PROPLC>
		
		    m1_perms = cell(1, P);
		    m2_perms = cell(1, P);
		    diff_perms = cell(1, P);
		
		    start = tic;
		    seeds = c.memorize('PERM_SEEDS');
		    for p = 1:1:P
		        % [a1_perm, a2_perm] = c.getPerm(i, memorize);
		        % 
		        % m1_perms{1, i} = a1_perm.getMeasureEnsemble(measure_class).memorize('M');
		        % m2_perms{1, i} = a2_perm.getMeasureEnsemble(measure_class).memorize('M');
		        % diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
		        
		        rng(seeds(p), 'twister')
		        
		        [ms1_perm, ms2_perm] = permutation(ms1, ms2, c.get('LONGITUDINAL'));
		        
		        ms1_av = cell(size(ms1_perm{1}));
		        ms2_av = cell(size(ms1_perm{1}));
		        for i = 1:1:size(ms1_perm{1}, 1)
		            for j = 1:1:size(ms1_perm{1}, 2)
		                
		                ms1_perm_ij = cellfun(@(x) x{i, j}, ms1_perm, 'UniformOutput', false);
		                ms1_av{i, j} = mean(cat(ndims(ms1_perm_ij{1}) + 1, ms1_perm_ij{:}), ndims(ms1_perm_ij{1}) + 1);
		                
		                ms2_perm_ij = cellfun(@(x) x{i, j}, ms2_perm, 'UniformOutput', false);
		                ms2_av{i, j} = mean(cat(ndims(ms2_perm_ij{1}) + 1, ms2_perm_ij{:}), ndims(ms2_perm_ij{1}) + 1);
		            end
		        end
		        m1_perms{1, p} = ms1_av;
		        m2_perms{1, p} = ms2_av;
		        diff_perms{1, p} = cellfun(@(x, y) y - x, m1_perms{1, p}, m2_perms{1, p}, 'UniformOutput', false);
		
		        if c.get('WAITBAR')
		            waitbar(i / P, wb, ['Permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...']);
		        end
		        if c.get('VERBOSE')
		            disp(['** PERMUTATION TEST - sampling #' int2str(p) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
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
				case ComparisonEnsemble.DIFF
					pr = PPComparisonEnsemble_Diff('EL', cp, 'PROP', ComparisonEnsemble.DIFF, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(cp, prop, varargin{:});
					
			end
		end
	end
end
