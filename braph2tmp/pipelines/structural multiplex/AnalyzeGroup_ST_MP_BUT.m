classdef AnalyzeGroup_ST_MP_BUT < AnalyzeGroup
	% AnalyzeGroup_ST_MP_BUT is a graph analysis using structural multiplex data of fixed threshold.
	% It is a subclass of <a href="matlab:help AnalyzeGroup">AnalyzeGroup</a>.
	%
	% 
	%
	% The list of AnalyzeGroup_ST_MP_BUT properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.
	%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
	%  <strong>6</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>7</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%  <strong>8</strong> <strong>thresholds</strong> 	THRESHOLDS (parameter, rvector) is the vector of thresholds.
	%
	% AnalyzeGroup_ST_MP_BUT methods (constructor):
	% AnalyzeGroup_ST_MP_BUT - constructor
	%
	% AnalyzeGroup_ST_MP_BUT methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph analysis with structural multiplex data of fixed threshold/error.
	%  existsProp - checks whether property exists in graph analysis with structural multiplex data of fixed threshold/error.
	%  getPropNumber - returns the property number of graph analysis with structural multiplex data of fixed threshold.
	%  getProps - returns the property list of graph analysis with structural multiplex data of fixed threshold.
	%  getDescription - returns the description of the graph analysis with structural multiplex data of fixed threshold.
	%  getName - returns the name of the graph analysis with structural multiplex data of fixed threshold.
	%  getClass - returns the class of the graph analysis with structural multiplex data of fixed threshold.
	%
	% AnalyzeGroup_ST_MP_BUT methods:
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
	% AnalyzeGroup_ST_MP_BUT methods (operators):
	%  isequal - determines whether two AnalyzeGroup_ST_MP_BUT are equal (values, locked)
	%
	% AnalyzeGroup_ST_MP_BUT methods (display):
	%  tostring - string with information about the AnalyzeGroup_ST_MP_BUT
	%  disp - displays information about the AnalyzeGroup_ST_MP_BUT
	%  tree - displays the element of AnalyzeGroup_ST_MP_BUT
	%
	% AnalyzeGroup_ST_MP_BUT method (element list):
	%  getElementList - returns a list with all subelements of AnalyzeGroup_ST_MP_BUT
	%
	% AnalyzeGroup_ST_MP_BUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the AnalyzeGroup_ST_MP_BUT
	%
	% AnalyzeGroup_ST_MP_BUT method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the AnalyzeGroup_ST_MP_BUT
	%
	% AnalyzeGroup_ST_MP_BUT methods (copy):
	%  copy - copies the AnalyzeGroup_ST_MP_BUT
	%  deepclone - deep-clones the AnalyzeGroup_ST_MP_BUT
	%  clone - clones the AnalyzeGroup_ST_MP_BUT
	%
	% AnalyzeGroup_ST_MP_BUT methods (inspection, Static):
	%  getClass - returns AnalyzeGroup_ST_MP_BUT
	%  getName - returns the name of AnalyzeGroup_ST_MP_BUT
	%  getDescription - returns the description of AnalyzeGroup_ST_MP_BUT
	%  getProps - returns the property list of AnalyzeGroup_ST_MP_BUT
	%  getPropNumber - returns the property number of AnalyzeGroup_ST_MP_BUT
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
	% AnalyzeGroup_ST_MP_BUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup_ST_MP_BUT methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% AnalyzeGroup_ST_MP_BUT methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% AnalyzeGroup_ST_MP_BUT methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% AnalyzeGroup_ST_MP_BUT properties (Constant).
	%  CORRELATION_RULE - 6
	%  CORRELATION_RULE_TAG - 'correlation_rule'
	%  CORRELATION_RULE_CATEGORY - 'p'
	%  CORRELATION_RULE_FORMAT - 'op'
	%  NEGATIVE_WEIGHT_RULE - 7
	%  NEGATIVE_WEIGHT_RULE_TAG - 'negative_weight_rule'
	%  NEGATIVE_WEIGHT_RULE_CATEGORY - 'p'
	%  NEGATIVE_WEIGHT_RULE_FORMAT - 'op'
	%  THRESHOLDS - 8
	%  THRESHOLDS_TAG - 'thresholds'
	%  THRESHOLDS_CATEGORY - 'p'
	%  THRESHOLDS_FORMAT - 'nr'
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
	
	properties (Constant) % properties
		CORRELATION_RULE = AnalyzeGroup.getPropNumber() + 1;
		CORRELATION_RULE_TAG = 'correlation_rule';
		CORRELATION_RULE_CATEGORY = Category.PARAMETER;
		CORRELATION_RULE_FORMAT = Format.OPTION;
		
		NEGATIVE_WEIGHT_RULE = AnalyzeGroup.getPropNumber() + 2;
		NEGATIVE_WEIGHT_RULE_TAG = 'negative_weight_rule';
		NEGATIVE_WEIGHT_RULE_CATEGORY = Category.PARAMETER;
		NEGATIVE_WEIGHT_RULE_FORMAT = Format.OPTION;
		
		THRESHOLDS = AnalyzeGroup.getPropNumber() + 3;
		THRESHOLDS_TAG = 'thresholds';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with structural multiplex data of fixed threshold.
			%
			% CLASS = AnalyzeGroup_ST_MP_BUT.GETCLASS() returns the class 'AnalyzeGroup_ST_MP_BUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with structural multiplex data of fixed threshold A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup_ST_MP_BUT') returns 'AnalyzeGroup_ST_MP_BUT'.
			%
			% See also getName, getDescription.
			
			a_class = 'AnalyzeGroup_ST_MP_BUT';
		end
		function a_name = getName()
			%GETNAME returns the name of the graph analysis with structural multiplex data of fixed threshold.
			%
			% NAME = AnalyzeGroup_ST_MP_BUT.GETNAME() returns the name of the 'graph analysis with structural multiplex data of fixed threshold'.
			%  Graph Analysis With Structural Multiplex Data Of Fixed Threshold.
			%
			% Alternative forms to call this method are:
			%  NAME = A.GETNAME() returns the name of the graph analysis with structural multiplex data of fixed threshold A.
			%  NAME = Element.GETNAME(A) returns the name of 'A'.
			%  NAME = Element.GETNAME('AnalyzeGroup_ST_MP_BUT') returns the name of 'AnalyzeGroup_ST_MP_BUT'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			a_name = 'Graph Analysis With Structural Multiplex Data Of Fixed Threshold';
		end
		function a_description = getDescription()
			%GETDESCRIPTION returns the description of the graph analysis with structural multiplex data of fixed threshold.
			%
			% STR = AnalyzeGroup_ST_MP_BUT.GETDESCRIPTION() returns the description of the 'graph analysis with structural multiplex data of fixed threshold'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = A.GETDESCRIPTION() returns the description of the graph analysis with structural multiplex data of fixed threshold A.
			%  STR = Element.GETDESCRIPTION(A) returns the description of 'A'.
			%  STR = Element.GETDESCRIPTION('AnalyzeGroup_ST_MP_BUT') returns the description of 'AnalyzeGroup_ST_MP_BUT'.
			%
			% See also getClass, getName.
			
			a_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with structural multiplex data of fixed threshold.
			%
			% PROPS = AnalyzeGroup_ST_MP_BUT.GETPROPS() returns the property list of graph analysis with structural multiplex data of fixed threshold.
			%
			% PROPS = AnalyzeGroup_ST_MP_BUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with structural multiplex data of fixed threshold A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup_ST_MP_BUT'[, CATEGORY]) returns the property list of 'AnalyzeGroup_ST_MP_BUT'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						AnalyzeGroup.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						AnalyzeGroup.getProps(Category.PARAMETER)
						AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
						AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
						AnalyzeGroup_ST_MP_BUT.THRESHOLDS
						];
				case Category.DATA
					prop_list = [
						AnalyzeGroup.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						AnalyzeGroup.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						AnalyzeGroup.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						AnalyzeGroup.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						AnalyzeGroup.getProps()
						AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
						AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
						AnalyzeGroup_ST_MP_BUT.THRESHOLDS
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph analysis with structural multiplex data of fixed threshold.
			%
			% N = AnalyzeGroup_ST_MP_BUT.GETPROPNUMBER() returns the property number of graph analysis with structural multiplex data of fixed threshold.
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER() returns the property number of the graph analysis with structural multiplex data of fixed threshold A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup_ST_MP_BUT') returns the property number of 'AnalyzeGroup_ST_MP_BUT'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with structural multiplex data of fixed threshold/error.
			%
			% CHECK = AnalyzeGroup_ST_MP_BUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup_ST_MP_BUT, PROP) checks whether PROP exists for AnalyzeGroup_ST_MP_BUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup_ST_MP_BUT, PROP) throws error if PROP does NOT exist for AnalyzeGroup_ST_MP_BUT.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					AnalyzeGroup_ST_MP_BUT.existsProp(prop), ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup_ST_MP_BUT.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with structural multiplex data of fixed threshold/error.
			%
			% CHECK = AnalyzeGroup_ST_MP_BUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup_ST_MP_BUT, TAG) checks whether TAG exists for AnalyzeGroup_ST_MP_BUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup_ST_MP_BUT, TAG) throws error if TAG does NOT exist for AnalyzeGroup_ST_MP_BUT.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_st_mp_but_tag_list = { 'id'  'label'  'notes'  'gr'  'g'  'correlation_rule'  'negative_weight_rule'  'thresholds' };
				
				check = any(strcmpi(tag, analyzegroup_st_mp_but_tag_list));
			else
				assert( ...
					AnalyzeGroup_ST_MP_BUT.existsTag(tag), ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup_ST_MP_BUT'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup_ST_MP_BUT, POINTER) returns property number of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup_ST_MP_BUT, POINTER) returns property number of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_st_mp_but_tag_list = { 'id'  'label'  'notes'  'gr'  'g'  'correlation_rule'  'negative_weight_rule'  'thresholds' };
				
				tag = pointer;
				AnalyzeGroup_ST_MP_BUT.existsTag(tag);
				
				prop = find(strcmpi(tag, analyzegroup_st_mp_but_tag_list));
			else % numeric
				prop = pointer;
				AnalyzeGroup_ST_MP_BUT.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(AnalyzeGroup_ST_MP_BUT, POINTER) returns tag of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  TAG = A.GETPROPTAG(AnalyzeGroup_ST_MP_BUT, POINTER) returns tag of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				AnalyzeGroup_ST_MP_BUT.existsTag(tag);
			else % numeric
				prop = pointer;
				AnalyzeGroup_ST_MP_BUT.existsProp(prop);
				
				switch prop
					case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
						tag = AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE_TAG;
					case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
						tag = AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE_TAG;
					case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
						tag = AnalyzeGroup_ST_MP_BUT.THRESHOLDS_TAG;
					otherwise
						tag = getPropTag@AnalyzeGroup(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup_ST_MP_BUT, POINTER) returns category of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup_ST_MP_BUT, POINTER) returns category of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					prop_category = AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE_CATEGORY;
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					prop_category = AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE_CATEGORY;
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					prop_category = AnalyzeGroup_ST_MP_BUT.THRESHOLDS_CATEGORY;
				otherwise
					prop_category = getPropCategory@AnalyzeGroup(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup_ST_MP_BUT, POINTER) returns format of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup_ST_MP_BUT, POINTER) returns format of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					prop_format = AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE_FORMAT;
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					prop_format = AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE_FORMAT;
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					prop_format = AnalyzeGroup_ST_MP_BUT.THRESHOLDS_FORMAT;
				otherwise
					prop_format = getPropFormat@AnalyzeGroup(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup_ST_MP_BUT, POINTER) returns description of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup_ST_MP_BUT, POINTER) returns description of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type.';
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.';
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case AnalyzeGroup_ST_MP_BUT.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.';
				case AnalyzeGroup_ST_MP_BUT.G
					prop_description = 'G (result, item) is the graph obtained from this analysis.';
				otherwise
					prop_description = getPropDescription@AnalyzeGroup(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup_ST_MP_BUT, POINTER) returns settings of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup_ST_MP_BUT, POINTER) returns settings of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST;
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case AnalyzeGroup_ST_MP_BUT.G
					prop_settings = 'MultiplexBUT';
				otherwise
					prop_settings = getPropSettings@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup_ST_MP_BUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_ST_MP_BUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup_ST_MP_BUT, POINTER) returns the default value of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup_ST_MP_BUT, POINTER) returns the default value of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					prop_default = Correlation.PEARSON;
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.ZERO;
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					prop_default = 0;
				case AnalyzeGroup_ST_MP_BUT.GR
					prop_default = Group('SUB_CLASS', 'SubjectST_MP');
				case AnalyzeGroup_ST_MP_BUT.G
					prop_default = MultiplexBUT();
				otherwise
					prop_default = getPropDefault@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup_ST_MP_BUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_ST_MP_BUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_ST_MP_BUT, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_ST_MP_BUT.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_ST_MP_BUT, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_ST_MP_BUT.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			prop_default = AnalyzeGroup_ST_MP_BUT.conditioning(prop, AnalyzeGroup_ST_MP_BUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeGroup_ST_MP_BUT, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_ST_MP_BUT.
			%  CHECK = A.CHECKPROP(AnalyzeGroup_ST_MP_BUT, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_ST_MP_BUT.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  Element.CHECKPROP(AnalyzeGroup_ST_MP_BUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_ST_MP_BUT.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			%  A.CHECKPROP(AnalyzeGroup_ST_MP_BUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_ST_MP_BUT.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_MP_BUT:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_MP_BUT.CORRELATION_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_ST_MP_BUT.getPropSettings(prop));
				case AnalyzeGroup_ST_MP_BUT.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_ST_MP_BUT.getPropSettings(prop));
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					check = Format.checkFormat(Format.RVECTOR, value, AnalyzeGroup_ST_MP_BUT.getPropSettings(prop));
				case AnalyzeGroup_ST_MP_BUT.G
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_ST_MP_BUT.getPropSettings(prop));
				otherwise
					check = checkProp@AnalyzeGroup(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_MP_BUT:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup_ST_MP_BUT.getPropTag(prop) ' (' AnalyzeGroup_ST_MP_BUT.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function a = AnalyzeGroup_ST_MP_BUT(varargin)
			% AnalyzeGroup_ST_MP_BUT() creates a graph analysis with structural multiplex data of fixed threshold.
			%
			% AnalyzeGroup_ST_MP_BUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup_ST_MP_BUT(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeGroup_ST_MP_BUT properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.
			%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
			%  <strong>6</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>7</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%  <strong>8</strong> <strong>thresholds</strong> 	THRESHOLDS (parameter, rvector) is the vector of thresholds.
			%
			% See also Category, Format, set, check.
			
			a = a@AnalyzeGroup(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = AnalyzeGroup_ST_MP_BUT.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= AnalyzeGroup.getPropNumber()
						value = conditioning@AnalyzeGroup(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop)
		
			switch prop
				case AnalyzeGroup_ST_MP_BUT.G
					gr = a.get('GR');
					data_list = cellfun(@(x) x.get('ST_MP'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
					atlas = BrainAtlas();
					if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
					    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
					end
					
					if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
					    age_list = cellfun(@(x) x.get('age'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
					    age = cat(2, age_list{:})';
					    sex_list = cellfun(@(x) x.get('sex'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
					    sex = zeros(size(age));
					    for i=1:length(sex_list)
					        switch lower(sex_list{i})
					            case 'female'
					                sex(i) = 1;
					            case 'male'
					                sex(i) = 0;
					            otherwise
					                sex(i) = -1;
					        end
					    end
					    covariates = [age, sex];
					end
					
					if isempty(data_list)
					    A ={[], []};
					else
					    L = gr.get('SUB_DICT').getItem(1).get('L');  % number of layers
					    br_number = gr.get('SUB_DICT').getItem(1).get('ba').get('BR_DICT').length();  % number of regions
					    data = cell(L, 1);
					    for i=1:L
					        data_layer = zeros(length(data_list), br_number);
					        for j=1:length(data_list)
					            sub_cell = data_list{j};
					            data_layer(j, :) = sub_cell{i}';
					        end
					        data(i) = {data_layer};
					    end
					    
					    A = cell(1, L);
					    for i = 1:L
					        if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
					            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), covariates)};
					        else
					            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
					        end
					    end
					end
					thresholds = a.get('THRESHOLDS'); % this is a vector
					
					g = MultiplexBUT( ...
					    'ID', ['g ' gr.get('ID')], ...
					    'B', A, ...
					    'THRESHOLDS', thresholds, ...
					    'BRAINATLAS', atlas ...
					    );
					
					value = g;
					
				otherwise
					value = calculateValue@AnalyzeGroup(a, prop);
					
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
		    
		    pr = PPCompareGroup_CPDict_ST_MP_BUT(varargin{:});
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
				case AnalyzeGroup_ST_MP_BUT.THRESHOLDS
					pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeGroup_ST_MP_BUT.THRESHOLDS, 'MAX', 1, 'MIN', 0, varargin{:});
					
				case AnalyzeGroup_ST_MP_BUT.G
					pr = PPAnalyzeGroupMP_G('EL', a, 'PROP', AnalyzeGroup_ST_MP_BUT.G, 'WAITBAR', true, varargin{:});
					
				otherwise
					pr = getPlotProp@AnalyzeGroup(a, prop, varargin{:});
					
			end
		end
	end
end
