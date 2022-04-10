classdef AnalyzeGroup_ST_BUD < AnalyzeGroup
	% AnalyzeGroup_ST_BUD is a graph analysis using structural data of fixed density.
	% It is a subclass of <a href="matlab:help AnalyzeGroup">AnalyzeGroup</a>.
	%
	% 
	%
	% The list of AnalyzeGroup_ST_BUD properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectST.
	%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
	%  <strong>6</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>7</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%  <strong>8</strong> <strong>densities</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
	%
	% AnalyzeGroup_ST_BUD methods (constructor):
	% AnalyzeGroup_ST_BUD - constructor
	%
	% AnalyzeGroup_ST_BUD methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph analysis with structural data of fixed density/error.
	%  existsProp - checks whether property exists in graph analysis with structural data of fixed density/error.
	%  getPropNumber - returns the property number of graph analysis with structural data of fixed density.
	%  getProps - returns the property list of graph analysis with structural data of fixed density.
	%  getDescription - returns the description of the graph analysis with structural data of fixed density.
	%  getName - returns the name of the graph analysis with structural data of fixed density.
	%  getClass - returns the class of the graph analysis with structural data of fixed density.
	%
	% AnalyzeGroup_ST_BUD methods:
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
	% AnalyzeGroup_ST_BUD methods (operators):
	%  isequal - determines whether two AnalyzeGroup_ST_BUD are equal (values, locked)
	%
	% AnalyzeGroup_ST_BUD methods (display):
	%  tostring - string with information about the AnalyzeGroup_ST_BUD
	%  disp - displays information about the AnalyzeGroup_ST_BUD
	%  tree - displays the element of AnalyzeGroup_ST_BUD
	%
	% AnalyzeGroup_ST_BUD method (element list):
	%  getElementList - returns a list with all subelements of AnalyzeGroup_ST_BUD
	%
	% AnalyzeGroup_ST_BUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the AnalyzeGroup_ST_BUD
	%
	% AnalyzeGroup_ST_BUD method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the AnalyzeGroup_ST_BUD
	%
	% AnalyzeGroup_ST_BUD methods (copy):
	%  copy - copies the AnalyzeGroup_ST_BUD
	%  deepclone - deep-clones the AnalyzeGroup_ST_BUD
	%  clone - clones the AnalyzeGroup_ST_BUD
	%
	% AnalyzeGroup_ST_BUD methods (inspection, Static):
	%  getClass - returns AnalyzeGroup_ST_BUD
	%  getName - returns the name of AnalyzeGroup_ST_BUD
	%  getDescription - returns the description of AnalyzeGroup_ST_BUD
	%  getProps - returns the property list of AnalyzeGroup_ST_BUD
	%  getPropNumber - returns the property number of AnalyzeGroup_ST_BUD
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
	% AnalyzeGroup_ST_BUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup_ST_BUD methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% AnalyzeGroup_ST_BUD methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% AnalyzeGroup_ST_BUD methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% AnalyzeGroup_ST_BUD properties (Constant).
	%  CORRELATION_RULE - 6
	%  CORRELATION_RULE_TAG - 'correlation_rule'
	%  CORRELATION_RULE_CATEGORY - 'p'
	%  CORRELATION_RULE_FORMAT - 'op'
	%  NEGATIVE_WEIGHT_RULE - 7
	%  NEGATIVE_WEIGHT_RULE_TAG - 'negative_weight_rule'
	%  NEGATIVE_WEIGHT_RULE_CATEGORY - 'p'
	%  NEGATIVE_WEIGHT_RULE_FORMAT - 'op'
	%  DENSITIES - 8
	%  DENSITIES_TAG - 'densities'
	%  DENSITIES_CATEGORY - 'p'
	%  DENSITIES_FORMAT - 'nr'
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
		
		DENSITIES = AnalyzeGroup.getPropNumber() + 3;
		DENSITIES_TAG = 'densities';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with structural data of fixed density.
			%
			% CLASS = AnalyzeGroup_ST_BUD.GETCLASS() returns the class 'AnalyzeGroup_ST_BUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with structural data of fixed density A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup_ST_BUD') returns 'AnalyzeGroup_ST_BUD'.
			%
			% See also getName, getDescription.
			
			a_class = 'AnalyzeGroup_ST_BUD';
		end
		function a_name = getName()
			%GETNAME returns the name of the graph analysis with structural data of fixed density.
			%
			% NAME = AnalyzeGroup_ST_BUD.GETNAME() returns the name of the 'graph analysis with structural data of fixed density'.
			%  Graph Analysis With Structural Data Of Fixed Density.
			%
			% Alternative forms to call this method are:
			%  NAME = A.GETNAME() returns the name of the graph analysis with structural data of fixed density A.
			%  NAME = Element.GETNAME(A) returns the name of 'A'.
			%  NAME = Element.GETNAME('AnalyzeGroup_ST_BUD') returns the name of 'AnalyzeGroup_ST_BUD'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			a_name = 'Graph Analysis With Structural Data Of Fixed Density';
		end
		function a_description = getDescription()
			%GETDESCRIPTION returns the description of the graph analysis with structural data of fixed density.
			%
			% STR = AnalyzeGroup_ST_BUD.GETDESCRIPTION() returns the description of the 'graph analysis with structural data of fixed density'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = A.GETDESCRIPTION() returns the description of the graph analysis with structural data of fixed density A.
			%  STR = Element.GETDESCRIPTION(A) returns the description of 'A'.
			%  STR = Element.GETDESCRIPTION('AnalyzeGroup_ST_BUD') returns the description of 'AnalyzeGroup_ST_BUD'.
			%
			% See also getClass, getName.
			
			a_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with structural data of fixed density.
			%
			% PROPS = AnalyzeGroup_ST_BUD.GETPROPS() returns the property list of graph analysis with structural data of fixed density.
			%
			% PROPS = AnalyzeGroup_ST_BUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with structural data of fixed density A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup_ST_BUD'[, CATEGORY]) returns the property list of 'AnalyzeGroup_ST_BUD'.
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
						AnalyzeGroup_ST_BUD.CORRELATION_RULE
						AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
						AnalyzeGroup_ST_BUD.DENSITIES
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
						AnalyzeGroup_ST_BUD.CORRELATION_RULE
						AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
						AnalyzeGroup_ST_BUD.DENSITIES
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph analysis with structural data of fixed density.
			%
			% N = AnalyzeGroup_ST_BUD.GETPROPNUMBER() returns the property number of graph analysis with structural data of fixed density.
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER() returns the property number of the graph analysis with structural data of fixed density A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup_ST_BUD') returns the property number of 'AnalyzeGroup_ST_BUD'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with structural data of fixed density/error.
			%
			% CHECK = AnalyzeGroup_ST_BUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup_ST_BUD, PROP) checks whether PROP exists for AnalyzeGroup_ST_BUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup_ST_BUD, PROP) throws error if PROP does NOT exist for AnalyzeGroup_ST_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					AnalyzeGroup_ST_BUD.existsProp(prop), ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup_ST_BUD.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with structural data of fixed density/error.
			%
			% CHECK = AnalyzeGroup_ST_BUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup_ST_BUD, TAG) checks whether TAG exists for AnalyzeGroup_ST_BUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup_ST_BUD, TAG) throws error if TAG does NOT exist for AnalyzeGroup_ST_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_st_bud_tag_list = { 'id'  'label'  'notes'  'gr'  'g'  'correlation_rule'  'negative_weight_rule'  'densities' };
				
				check = any(strcmpi(tag, analyzegroup_st_bud_tag_list));
			else
				assert( ...
					AnalyzeGroup_ST_BUD.existsTag(tag), ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup_ST_BUD'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup_ST_BUD, POINTER) returns property number of POINTER of AnalyzeGroup_ST_BUD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup_ST_BUD, POINTER) returns property number of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzegroup_st_bud_tag_list = { 'id'  'label'  'notes'  'gr'  'g'  'correlation_rule'  'negative_weight_rule'  'densities' };
				
				tag = pointer;
				AnalyzeGroup_ST_BUD.existsTag(tag);
				
				prop = find(strcmpi(tag, analyzegroup_st_bud_tag_list));
			else % numeric
				prop = pointer;
				AnalyzeGroup_ST_BUD.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(AnalyzeGroup_ST_BUD, POINTER) returns tag of POINTER of AnalyzeGroup_ST_BUD.
			%  TAG = A.GETPROPTAG(AnalyzeGroup_ST_BUD, POINTER) returns tag of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				AnalyzeGroup_ST_BUD.existsTag(tag);
			else % numeric
				prop = pointer;
				AnalyzeGroup_ST_BUD.existsProp(prop);
				
				switch prop
					case AnalyzeGroup_ST_BUD.CORRELATION_RULE
						tag = AnalyzeGroup_ST_BUD.CORRELATION_RULE_TAG;
					case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
						tag = AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE_TAG;
					case AnalyzeGroup_ST_BUD.DENSITIES
						tag = AnalyzeGroup_ST_BUD.DENSITIES_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup_ST_BUD, POINTER) returns category of POINTER of AnalyzeGroup_ST_BUD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup_ST_BUD, POINTER) returns category of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					prop_category = AnalyzeGroup_ST_BUD.CORRELATION_RULE_CATEGORY;
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					prop_category = AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE_CATEGORY;
				case AnalyzeGroup_ST_BUD.DENSITIES
					prop_category = AnalyzeGroup_ST_BUD.DENSITIES_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup_ST_BUD, POINTER) returns format of POINTER of AnalyzeGroup_ST_BUD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup_ST_BUD, POINTER) returns format of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					prop_format = AnalyzeGroup_ST_BUD.CORRELATION_RULE_FORMAT;
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					prop_format = AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE_FORMAT;
				case AnalyzeGroup_ST_BUD.DENSITIES
					prop_format = AnalyzeGroup_ST_BUD.DENSITIES_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup_ST_BUD, POINTER) returns description of POINTER of AnalyzeGroup_ST_BUD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup_ST_BUD, POINTER) returns description of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type.';
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.';
				case AnalyzeGroup_ST_BUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case AnalyzeGroup_ST_BUD.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectST.';
				case AnalyzeGroup_ST_BUD.G
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup_ST_BUD, POINTER) returns settings of POINTER of AnalyzeGroup_ST_BUD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup_ST_BUD, POINTER) returns settings of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST;
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case AnalyzeGroup_ST_BUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case AnalyzeGroup_ST_BUD.G
					prop_settings = 'MultigraphBUD';
				otherwise
					prop_settings = getPropSettings@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup_ST_BUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_ST_BUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup_ST_BUD, POINTER) returns the default value of POINTER of AnalyzeGroup_ST_BUD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup_ST_BUD, POINTER) returns the default value of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					prop_default = Correlation.PEARSON;
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.ZERO;
				case AnalyzeGroup_ST_BUD.DENSITIES
					prop_default = 0;
				case AnalyzeGroup_ST_BUD.GR
					prop_default = Group('SUB_CLASS', 'SubjectST');
				case AnalyzeGroup_ST_BUD.G
					prop_default = MultigraphBUD();
				otherwise
					prop_default = getPropDefault@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup_ST_BUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_ST_BUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_ST_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_ST_BUD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_ST_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_ST_BUD.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			prop_default = AnalyzeGroup_ST_BUD.conditioning(prop, AnalyzeGroup_ST_BUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeGroup_ST_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_ST_BUD.
			%  CHECK = A.CHECKPROP(AnalyzeGroup_ST_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_ST_BUD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  Element.CHECKPROP(AnalyzeGroup_ST_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_ST_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			%  A.CHECKPROP(AnalyzeGroup_ST_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_ST_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_ST_BUD:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_ST_BUD.CORRELATION_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_ST_BUD.getPropSettings(prop));
				case AnalyzeGroup_ST_BUD.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_ST_BUD.getPropSettings(prop));
				case AnalyzeGroup_ST_BUD.DENSITIES
					check = Format.checkFormat(Format.RVECTOR, value, AnalyzeGroup_ST_BUD.getPropSettings(prop));
				case AnalyzeGroup_ST_BUD.G
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_ST_BUD.getPropSettings(prop));
				otherwise
					check = checkProp@AnalyzeGroup(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_ST_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup_ST_BUD.getPropTag(prop) ' (' AnalyzeGroup_ST_BUD.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function a = AnalyzeGroup_ST_BUD(varargin)
			% AnalyzeGroup_ST_BUD() creates a graph analysis with structural data of fixed density.
			%
			% AnalyzeGroup_ST_BUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup_ST_BUD(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeGroup_ST_BUD properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectST.
			%  <strong>5</strong> <strong>g</strong> 	G (result, item) is the graph obtained from this analysis.
			%  <strong>6</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>7</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%  <strong>8</strong> <strong>densities</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
			%
			% See also Category, Format, set, check.
			
			a = a@AnalyzeGroup(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = AnalyzeGroup_ST_BUD.getPropProp(pointer);
			
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
				case AnalyzeGroup_ST_BUD.G
					gr = a.get('GR');
					node_labels = '';
					data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
					data = cat(2, data_list{:})'; % correlation is a column based operation
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
					    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), [age, sex]);
					else
					    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
					end
					
					densities = a.get('DENSITIES'); % this is a vector
					
					g = MultigraphBUD( ...
					    'ID', ['g ' gr.get('ID')], ...
					    'B', A, ...
					    'DENSITIES', densities, ...
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
		    
		    pr = PPCompareGroup_CPDict_ST_BUD(varargin{:});
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
				case AnalyzeGroup_ST_BUD.DENSITIES
					pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				otherwise
					pr = getPlotProp@AnalyzeGroup(a, prop, varargin{:});
					
			end
		end
	end
end
