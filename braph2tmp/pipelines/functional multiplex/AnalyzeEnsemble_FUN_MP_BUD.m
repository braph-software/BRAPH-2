classdef AnalyzeEnsemble_FUN_MP_BUD < AnalyzeEnsemble
	% AnalyzeEnsemble_FUN_MP_BUD is a graph analysis using functional multiplex data of fixed density.
	% It is a subclass of <a href="matlab:help AnalyzeEnsemble">AnalyzeEnsemble</a>.
	%
	% 
	%
	% The list of AnalyzeEnsemble_FUN_MP_BUD properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
	%  <strong>5</strong> <strong>g_dict</strong> 	G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.
	%  <strong>6</strong> <strong>me_dict</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%  <strong>7</strong> <strong>repetition</strong> 	REPETITION(parameter, scalar) is the number of repetitions
	%  <strong>8</strong> <strong>frequencyrulemin</strong> 	FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
	%  <strong>9</strong> <strong>frequencyrulemax</strong> 	FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
	%  <strong>10</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>11</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%  <strong>12</strong> <strong>densities</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (constructor):
	% AnalyzeEnsemble_FUN_MP_BUD - constructor
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph analysis with functional multiplex data of fixed density/error.
	%  existsProp - checks whether property exists in graph analysis with functional multiplex data of fixed density/error.
	%  getPropNumber - returns the property number of graph analysis with functional multiplex data of fixed density.
	%  getProps - returns the property list of graph analysis with functional multiplex data of fixed density.
	%  getDescription - returns the description of the graph analysis with functional multiplex data of fixed density.
	%  getName - returns the name of the graph analysis with functional multiplex data of fixed density.
	%  getClass - returns the class of the graph analysis with functional multiplex data of fixed density.
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods:
	%  getPPCompareEnsemble_CPDict - returns the comparison ensemble plot panel compatible with the analysis.
	%  getPlotProp - returns a prop plot.
	%  getMeasureEnsemble - measure.
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
	% AnalyzeEnsemble_FUN_MP_BUD methods (operators):
	%  isequal - determines whether two AnalyzeEnsemble_FUN_MP_BUD are equal (values, locked)
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (display):
	%  tostring - string with information about the AnalyzeEnsemble_FUN_MP_BUD
	%  disp - displays information about the AnalyzeEnsemble_FUN_MP_BUD
	%  tree - displays the element of AnalyzeEnsemble_FUN_MP_BUD
	%
	% AnalyzeEnsemble_FUN_MP_BUD method (element list):
	%  getElementList - returns a list with all subelements of AnalyzeEnsemble_FUN_MP_BUD
	%
	% AnalyzeEnsemble_FUN_MP_BUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the AnalyzeEnsemble_FUN_MP_BUD
	%
	% AnalyzeEnsemble_FUN_MP_BUD method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the AnalyzeEnsemble_FUN_MP_BUD
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (copy):
	%  copy - copies the AnalyzeEnsemble_FUN_MP_BUD
	%  deepclone - deep-clones the AnalyzeEnsemble_FUN_MP_BUD
	%  clone - clones the AnalyzeEnsemble_FUN_MP_BUD
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (inspection, Static):
	%  getClass - returns AnalyzeEnsemble_FUN_MP_BUD
	%  getName - returns the name of AnalyzeEnsemble_FUN_MP_BUD
	%  getDescription - returns the description of AnalyzeEnsemble_FUN_MP_BUD
	%  getProps - returns the property list of AnalyzeEnsemble_FUN_MP_BUD
	%  getPropNumber - returns the property number of AnalyzeEnsemble_FUN_MP_BUD
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
	% AnalyzeEnsemble_FUN_MP_BUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% AnalyzeEnsemble_FUN_MP_BUD properties (Constant).
	%  REPETITION - 7
	%  REPETITION_TAG - 'repetition'
	%  REPETITION_CATEGORY - 'p'
	%  REPETITION_FORMAT - 'nn'
	%  FREQUENCYRULEMIN - 8
	%  FREQUENCYRULEMIN_TAG - 'frequencyrulemin'
	%  FREQUENCYRULEMIN_CATEGORY - 'p'
	%  FREQUENCYRULEMIN_FORMAT - 'nn'
	%  FREQUENCYRULEMAX - 9
	%  FREQUENCYRULEMAX_TAG - 'frequencyrulemax'
	%  FREQUENCYRULEMAX_CATEGORY - 'p'
	%  FREQUENCYRULEMAX_FORMAT - 'nn'
	%  CORRELATION_RULE - 10
	%  CORRELATION_RULE_TAG - 'correlation_rule'
	%  CORRELATION_RULE_CATEGORY - 'p'
	%  CORRELATION_RULE_FORMAT - 'op'
	%  NEGATIVE_WEIGHT_RULE - 11
	%  NEGATIVE_WEIGHT_RULE_TAG - 'negative_weight_rule'
	%  NEGATIVE_WEIGHT_RULE_CATEGORY - 'p'
	%  NEGATIVE_WEIGHT_RULE_FORMAT - 'op'
	%  DENSITIES - 12
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
	%  G_DICT - 5
	%  G_DICT_TAG - 'g_dict'
	%  G_DICT_CATEGORY - 'r'
	%  G_DICT_FORMAT - 'di'
	%  ME_DICT - 6
	%  ME_DICT_TAG - 'me_dict'
	%  ME_DICT_CATEGORY - 'r'
	%  ME_DICT_FORMAT - 'di'
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
		REPETITION = AnalyzeEnsemble.getPropNumber() + 1;
		REPETITION_TAG = 'repetition';
		REPETITION_CATEGORY = Category.PARAMETER;
		REPETITION_FORMAT = Format.SCALAR;
		
		FREQUENCYRULEMIN = AnalyzeEnsemble.getPropNumber() + 2;
		FREQUENCYRULEMIN_TAG = 'frequencyrulemin';
		FREQUENCYRULEMIN_CATEGORY = Category.PARAMETER;
		FREQUENCYRULEMIN_FORMAT = Format.SCALAR;
		
		FREQUENCYRULEMAX = AnalyzeEnsemble.getPropNumber() + 3;
		FREQUENCYRULEMAX_TAG = 'frequencyrulemax';
		FREQUENCYRULEMAX_CATEGORY = Category.PARAMETER;
		FREQUENCYRULEMAX_FORMAT = Format.SCALAR;
		
		CORRELATION_RULE = AnalyzeEnsemble.getPropNumber() + 4;
		CORRELATION_RULE_TAG = 'correlation_rule';
		CORRELATION_RULE_CATEGORY = Category.PARAMETER;
		CORRELATION_RULE_FORMAT = Format.OPTION;
		
		NEGATIVE_WEIGHT_RULE = AnalyzeEnsemble.getPropNumber() + 5;
		NEGATIVE_WEIGHT_RULE_TAG = 'negative_weight_rule';
		NEGATIVE_WEIGHT_RULE_CATEGORY = Category.PARAMETER;
		NEGATIVE_WEIGHT_RULE_FORMAT = Format.OPTION;
		
		DENSITIES = AnalyzeEnsemble.getPropNumber() + 6;
		DENSITIES_TAG = 'densities';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with functional multiplex data of fixed density.
			%
			% CLASS = AnalyzeEnsemble_FUN_MP_BUD.GETCLASS() returns the class 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with functional multiplex data of fixed density A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble_FUN_MP_BUD') returns 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% See also getName, getDescription.
			
			a_class = 'AnalyzeEnsemble_FUN_MP_BUD';
		end
		function a_name = getName()
			%GETNAME returns the name of the graph analysis with functional multiplex data of fixed density.
			%
			% NAME = AnalyzeEnsemble_FUN_MP_BUD.GETNAME() returns the name of the 'graph analysis with functional multiplex data of fixed density'.
			%  Graph Analysis With Functional Multiplex Data Of Fixed Density.
			%
			% Alternative forms to call this method are:
			%  NAME = A.GETNAME() returns the name of the graph analysis with functional multiplex data of fixed density A.
			%  NAME = Element.GETNAME(A) returns the name of 'A'.
			%  NAME = Element.GETNAME('AnalyzeEnsemble_FUN_MP_BUD') returns the name of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			a_name = 'Graph Analysis With Functional Multiplex Data Of Fixed Density';
		end
		function a_description = getDescription()
			%GETDESCRIPTION returns the description of the graph analysis with functional multiplex data of fixed density.
			%
			% STR = AnalyzeEnsemble_FUN_MP_BUD.GETDESCRIPTION() returns the description of the 'graph analysis with functional multiplex data of fixed density'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = A.GETDESCRIPTION() returns the description of the graph analysis with functional multiplex data of fixed density A.
			%  STR = Element.GETDESCRIPTION(A) returns the description of 'A'.
			%  STR = Element.GETDESCRIPTION('AnalyzeEnsemble_FUN_MP_BUD') returns the description of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% See also getClass, getName.
			
			a_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with functional multiplex data of fixed density.
			%
			% PROPS = AnalyzeEnsemble_FUN_MP_BUD.GETPROPS() returns the property list of graph analysis with functional multiplex data of fixed density.
			%
			% PROPS = AnalyzeEnsemble_FUN_MP_BUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with functional multiplex data of fixed density A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble_FUN_MP_BUD'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						AnalyzeEnsemble.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						AnalyzeEnsemble.getProps(Category.PARAMETER)
						AnalyzeEnsemble_FUN_MP_BUD.REPETITION
						AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
						AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
						AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
						AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
						AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
						];
				case Category.DATA
					prop_list = [
						AnalyzeEnsemble.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						AnalyzeEnsemble.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						AnalyzeEnsemble.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						AnalyzeEnsemble.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						AnalyzeEnsemble.getProps()
						AnalyzeEnsemble_FUN_MP_BUD.REPETITION
						AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
						AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
						AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
						AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
						AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph analysis with functional multiplex data of fixed density.
			%
			% N = AnalyzeEnsemble_FUN_MP_BUD.GETPROPNUMBER() returns the property number of graph analysis with functional multiplex data of fixed density.
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER() returns the property number of the graph analysis with functional multiplex data of fixed density A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble_FUN_MP_BUD') returns the property number of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 12;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_FUN_MP_BUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP) checks whether PROP exists for AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12 ]);
			else
				assert( ...
					AnalyzeEnsemble_FUN_MP_BUD.existsProp(prop), ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble_FUN_MP_BUD.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_FUN_MP_BUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble_FUN_MP_BUD, TAG) checks whether TAG exists for AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble_FUN_MP_BUD, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzeensemble_fun_mp_bud_tag_list = { 'id'  'label'  'notes'  'gr'  'g_dict'  'me_dict'  'repetition'  'frequencyrulemin'  'frequencyrulemax'  'correlation_rule'  'negative_weight_rule'  'densities' };
				
				check = any(strcmpi(tag, analyzeensemble_fun_mp_bud_tag_list));
			else
				assert( ...
					AnalyzeEnsemble_FUN_MP_BUD.existsTag(tag), ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble_FUN_MP_BUD'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzeensemble_fun_mp_bud_tag_list = { 'id'  'label'  'notes'  'gr'  'g_dict'  'me_dict'  'repetition'  'frequencyrulemin'  'frequencyrulemax'  'correlation_rule'  'negative_weight_rule'  'densities' };
				
				tag = pointer;
				AnalyzeEnsemble_FUN_MP_BUD.existsTag(tag);
				
				prop = find(strcmpi(tag, analyzeensemble_fun_mp_bud_tag_list));
			else % numeric
				prop = pointer;
				AnalyzeEnsemble_FUN_MP_BUD.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				AnalyzeEnsemble_FUN_MP_BUD.existsTag(tag);
			else % numeric
				prop = pointer;
				AnalyzeEnsemble_FUN_MP_BUD.existsProp(prop);
				
				switch prop
					case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
						tag = AnalyzeEnsemble_FUN_MP_BUD.REPETITION_TAG;
					case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
						tag = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN_TAG;
					case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
						tag = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX_TAG;
					case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
						tag = AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE_TAG;
					case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
						tag = AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE_TAG;
					case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
						tag = AnalyzeEnsemble_FUN_MP_BUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@AnalyzeEnsemble(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.REPETITION_CATEGORY;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN_CATEGORY;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX_CATEGORY;
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE_CATEGORY;
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE_CATEGORY;
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_category = AnalyzeEnsemble_FUN_MP_BUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@AnalyzeEnsemble(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.REPETITION_FORMAT;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN_FORMAT;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX_FORMAT;
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE_FORMAT;
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE_FORMAT;
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_format = AnalyzeEnsemble_FUN_MP_BUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@AnalyzeEnsemble(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_description = 'REPETITION(parameter, scalar) is the number of repetitions';
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					prop_description = 'FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value';
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					prop_description = 'FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value';
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type.';
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.';
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case AnalyzeEnsemble_FUN_MP_BUD.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.';
				case AnalyzeEnsemble_FUN_MP_BUD.ME_DICT
					prop_description = 'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.';
				case AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					prop_description = 'G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.';
				otherwise
					prop_description = getPropDescription@AnalyzeEnsemble(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST;
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					prop_settings = 'MultiplexBUD';
				otherwise
					prop_settings = getPropSettings@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_default = 1;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					prop_default = 0;
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					prop_default = Inf;
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_default = 0;
				case AnalyzeEnsemble_FUN_MP_BUD.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN_MP');
				case AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
				otherwise
					prop_default = getPropDefault@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble_FUN_MP_BUD.conditioning(prop, AnalyzeEnsemble_FUN_MP_BUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  A.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMIN
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.FREQUENCYRULEMAX
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(Format.OPTION, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					check = Format.checkFormat(Format.RVECTOR, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				otherwise
					check = checkProp@AnalyzeEnsemble(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble_FUN_MP_BUD:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble_FUN_MP_BUD.getPropTag(prop) ' (' AnalyzeEnsemble_FUN_MP_BUD.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function a = AnalyzeEnsemble_FUN_MP_BUD(varargin)
			% AnalyzeEnsemble_FUN_MP_BUD() creates a graph analysis with functional multiplex data of fixed density.
			%
			% AnalyzeEnsemble_FUN_MP_BUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble_FUN_MP_BUD(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble_FUN_MP_BUD properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
			%  <strong>5</strong> <strong>g_dict</strong> 	G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.
			%  <strong>6</strong> <strong>me_dict</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%  <strong>7</strong> <strong>repetition</strong> 	REPETITION(parameter, scalar) is the number of repetitions
			%  <strong>8</strong> <strong>frequencyrulemin</strong> 	FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
			%  <strong>9</strong> <strong>frequencyrulemax</strong> 	FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
			%  <strong>10</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>11</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%  <strong>12</strong> <strong>densities</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
			%
			% See also Category, Format, set, check.
			
			a = a@AnalyzeEnsemble(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= AnalyzeEnsemble.getPropNumber()
						value = conditioning@AnalyzeEnsemble(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop)
		
			switch prop
				case AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
					gr = a.get('GR');
					node_labels = '';
					
					if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0    
					    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
					end
					
					T = a.get('REPETITION');
					fmin = a.get('FREQUENCYRULEMIN');
					fmax = a.get('FREQUENCYRULEMAX');
					densities = a.get('DENSITIES'); % this is a vector
					for i = 1:1:gr.get('SUB_DICT').length()
					    A = cell(1, 2);
						sub = gr.get('SUB_DICT').getItem(i);
					    FUN_MP = sub.getr('FUN_MP');
					    L = sub.get('L');
					    
					    for j = 1:1:L
					        data = FUN_MP{j};
					        fs = 1 / T;
					        
					        if fmax > fmin && T > 0
					            NFFT = 2 * ceil(size(data, 1) / 2);
					            ft = fft(data, NFFT);  % Fourier transform
					            f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					            ft(f < fmin | f > fmax, :) = 0;
					            data = ifft(ft, NFFT);
					        end
					        
					        A(j) = {Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
					    end
					    
					    g = MultiplexBUD( ...
					        'ID', ['g ' sub.get('ID')], ...
					        'B', A, ...
					        'DENSITIES', densities, ...
					        'BRAINATLAS', atlas ...
					        );
					    g_dict.add(g)
					end
					
					value = g_dict;
					
				otherwise
					value = calculateValue@AnalyzeEnsemble(a, prop);
					
			end
		end
	end
	methods % methods
		function pr = getPPCompareEnsemble_CPDict(a, varargin) 
		    %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
		    %
		    % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
		    %  that is compatible with the analyze ensemble.
		    %
		    % See also CompareEnsemble.
		    
		    pr = PPCompareEnsembleMP_FUN_CPDict_BUD(varargin{:});
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
				case AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeEnsemble_FUN_MP_BUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case AnalyzeEnsemble_FUN_MP_BUD.ME_DICT
					pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_MP_BUD.ME_DICT, 'WAITBAR', true, varargin{:});
					
				otherwise
					pr = getPlotProp@AnalyzeEnsemble(a, prop, varargin{:});
					
			end
		end
	end
end
