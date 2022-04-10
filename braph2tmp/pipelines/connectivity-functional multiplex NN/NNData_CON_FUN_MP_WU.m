classdef NNData_CON_FUN_MP_WU < NNData
	% NNData_CON_FUN_MP_WU produces a dataset to train or test a neural netowrk model for connectivity data and functional data.
	% It is a subclass of <a href="matlab:help NNData">NNData</a>.
	%
	% 
	%
	% The list of NNData_CON_FUN_MP_WU properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>input_type</strong> 	INPUT_TYPE (data, option) is the input type for training or testing the NN.
	%  <strong>6</strong> <strong>g</strong> 	G (data, item) is the graph for calculating the graph measures.
	%  <strong>7</strong> <strong>measures</strong> 	MEASURES (data, classlist) is the graph measures as input to NN.
	%  <strong>8</strong> <strong>target_name</strong> 	TARGET_NAME (data, string) is the name of the traget.
	%  <strong>9</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects defined as SubjectFUN class.
	%  <strong>10</strong> <strong>gr_nn</strong> 	GR_NN (result, group) is a group of NN subjects.
	%  <strong>11</strong> <strong>repetition</strong> 	REPETITION(parameter, scalar) is the number of repetitions.
	%  <strong>12</strong> <strong>frequencyrulemin</strong> 	FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value.
	%  <strong>13</strong> <strong>frequencyrulemax</strong> 	FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value.
	%  <strong>14</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>15</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%
	% NNData_CON_FUN_MP_WU methods (constructor):
	% NNData_CON_FUN_MP_WU - constructor
	%
	% NNData_CON_FUN_MP_WU methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in data for neural network/error.
	%  existsProp - checks whether property exists in data for neural network/error.
	%  getPropNumber - returns the property number of data for neural network.
	%  getProps - returns the property list of data for neural network.
	%  getDescription - returns the description of the data for neural network.
	%  getName - returns the name of the data for neural network.
	%  getClass - returns the class of the data for neural network.
	%
	% NNData_CON_FUN_MP_WU methods:
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
	% NNData_CON_FUN_MP_WU methods (operators):
	%  isequal - determines whether two NNData_CON_FUN_MP_WU are equal (values, locked)
	%
	% NNData_CON_FUN_MP_WU methods (display):
	%  tostring - string with information about the NNData_CON_FUN_MP_WU
	%  disp - displays information about the NNData_CON_FUN_MP_WU
	%  tree - displays the element of NNData_CON_FUN_MP_WU
	%
	% NNData_CON_FUN_MP_WU method (element list):
	%  getElementList - returns a list with all subelements of NNData_CON_FUN_MP_WU
	%
	% NNData_CON_FUN_MP_WU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNData_CON_FUN_MP_WU
	%
	% NNData_CON_FUN_MP_WU method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNData_CON_FUN_MP_WU
	%
	% NNData_CON_FUN_MP_WU methods (copy):
	%  copy - copies the NNData_CON_FUN_MP_WU
	%  deepclone - deep-clones the NNData_CON_FUN_MP_WU
	%  clone - clones the NNData_CON_FUN_MP_WU
	%
	% NNData_CON_FUN_MP_WU methods (inspection, Static):
	%  getClass - returns NNData_CON_FUN_MP_WU
	%  getName - returns the name of NNData_CON_FUN_MP_WU
	%  getDescription - returns the description of NNData_CON_FUN_MP_WU
	%  getProps - returns the property list of NNData_CON_FUN_MP_WU
	%  getPropNumber - returns the property number of NNData_CON_FUN_MP_WU
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
	% NNData_CON_FUN_MP_WU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNData_CON_FUN_MP_WU methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNData_CON_FUN_MP_WU methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNData_CON_FUN_MP_WU methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNData_CON_FUN_MP_WU properties (Constant).
	%  REPETITION - 11
	%  REPETITION_TAG - 'repetition'
	%  REPETITION_CATEGORY - 'p'
	%  REPETITION_FORMAT - 'nn'
	%  FREQUENCYRULEMIN - 12
	%  FREQUENCYRULEMIN_TAG - 'frequencyrulemin'
	%  FREQUENCYRULEMIN_CATEGORY - 'p'
	%  FREQUENCYRULEMIN_FORMAT - 'nn'
	%  FREQUENCYRULEMAX - 13
	%  FREQUENCYRULEMAX_TAG - 'frequencyrulemax'
	%  FREQUENCYRULEMAX_CATEGORY - 'p'
	%  FREQUENCYRULEMAX_FORMAT - 'nn'
	%  CORRELATION_RULE - 14
	%  CORRELATION_RULE_TAG - 'correlation_rule'
	%  CORRELATION_RULE_CATEGORY - 'p'
	%  CORRELATION_RULE_FORMAT - 'op'
	%  NEGATIVE_WEIGHT_RULE - 15
	%  NEGATIVE_WEIGHT_RULE_TAG - 'negative_weight_rule'
	%  NEGATIVE_WEIGHT_RULE_CATEGORY - 'p'
	%  NEGATIVE_WEIGHT_RULE_FORMAT - 'op'
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
	%  INPUT_TYPE - 5
	%  INPUT_TYPE_TAG - 'input_type'
	%  INPUT_TYPE_CATEGORY - 'd'
	%  INPUT_TYPE_FORMAT - 'op'
	%  G - 6
	%  G_TAG - 'g'
	%  G_CATEGORY - 'd'
	%  G_FORMAT - 'it'
	%  MEASURES - 7
	%  MEASURES_TAG - 'measures'
	%  MEASURES_CATEGORY - 'd'
	%  MEASURES_FORMAT - 'cl'
	%  TARGET_NAME - 8
	%  TARGET_NAME_TAG - 'target_name'
	%  TARGET_NAME_CATEGORY - 'd'
	%  TARGET_NAME_FORMAT - 'st'
	%  GR - 9
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  GR_NN - 10
	%  GR_NN_TAG - 'gr_nn'
	%  GR_NN_CATEGORY - 'r'
	%  GR_NN_FORMAT - 'it'
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
		REPETITION = NNData.getPropNumber() + 1;
		REPETITION_TAG = 'repetition';
		REPETITION_CATEGORY = Category.PARAMETER;
		REPETITION_FORMAT = Format.SCALAR;
		
		FREQUENCYRULEMIN = NNData.getPropNumber() + 2;
		FREQUENCYRULEMIN_TAG = 'frequencyrulemin';
		FREQUENCYRULEMIN_CATEGORY = Category.PARAMETER;
		FREQUENCYRULEMIN_FORMAT = Format.SCALAR;
		
		FREQUENCYRULEMAX = NNData.getPropNumber() + 3;
		FREQUENCYRULEMAX_TAG = 'frequencyrulemax';
		FREQUENCYRULEMAX_CATEGORY = Category.PARAMETER;
		FREQUENCYRULEMAX_FORMAT = Format.SCALAR;
		
		CORRELATION_RULE = NNData.getPropNumber() + 4;
		CORRELATION_RULE_TAG = 'correlation_rule';
		CORRELATION_RULE_CATEGORY = Category.PARAMETER;
		CORRELATION_RULE_FORMAT = Format.OPTION;
		
		NEGATIVE_WEIGHT_RULE = NNData.getPropNumber() + 5;
		NEGATIVE_WEIGHT_RULE_TAG = 'negative_weight_rule';
		NEGATIVE_WEIGHT_RULE_CATEGORY = Category.PARAMETER;
		NEGATIVE_WEIGHT_RULE_FORMAT = Format.OPTION;
	end
	methods (Static) % inspection methods
		function nnd_class = getClass()
			%GETCLASS returns the class of the data for neural network.
			%
			% CLASS = NNData_CON_FUN_MP_WU.GETCLASS() returns the class 'NNData_CON_FUN_MP_WU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NND.GETCLASS() returns the class of the data for neural network NND.
			%  CLASS = Element.GETCLASS(NND) returns the class of 'NND'.
			%  CLASS = Element.GETCLASS('NNData_CON_FUN_MP_WU') returns 'NNData_CON_FUN_MP_WU'.
			%
			% See also getName, getDescription.
			
			nnd_class = 'NNData_CON_FUN_MP_WU';
		end
		function nnd_name = getName()
			%GETNAME returns the name of the data for neural network.
			%
			% NAME = NNData_CON_FUN_MP_WU.GETNAME() returns the name of the 'data for neural network'.
			%  Data For Neural Network.
			%
			% Alternative forms to call this method are:
			%  NAME = NND.GETNAME() returns the name of the data for neural network NND.
			%  NAME = Element.GETNAME(NND) returns the name of 'NND'.
			%  NAME = Element.GETNAME('NNData_CON_FUN_MP_WU') returns the name of 'NNData_CON_FUN_MP_WU'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nnd_name = 'Data For Neural Network';
		end
		function nnd_description = getDescription()
			%GETDESCRIPTION returns the description of the data for neural network.
			%
			% STR = NNData_CON_FUN_MP_WU.GETDESCRIPTION() returns the description of the 'data for neural network'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NND.GETDESCRIPTION() returns the description of the data for neural network NND.
			%  STR = Element.GETDESCRIPTION(NND) returns the description of 'NND'.
			%  STR = Element.GETDESCRIPTION('NNData_CON_FUN_MP_WU') returns the description of 'NNData_CON_FUN_MP_WU'.
			%
			% See also getClass, getName.
			
			nnd_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of data for neural network.
			%
			% PROPS = NNData_CON_FUN_MP_WU.GETPROPS() returns the property list of data for neural network.
			%
			% PROPS = NNData_CON_FUN_MP_WU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NND.GETPROPS([CATEGORY]) returns the property list of the data for neural network NND.
			%  PROPS = Element.GETPROPS(NND[, CATEGORY]) returns the property list of 'NND'.
			%  PROPS = Element.GETPROPS('NNData_CON_FUN_MP_WU'[, CATEGORY]) returns the property list of 'NNData_CON_FUN_MP_WU'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNData.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						NNData.getProps(Category.PARAMETER)
						NNData_CON_FUN_MP_WU.REPETITION
						NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
						NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
						NNData_CON_FUN_MP_WU.CORRELATION_RULE
						NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
						];
				case Category.DATA
					prop_list = [
						NNData.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						NNData.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						NNData.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						NNData.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						NNData.getProps()
						NNData_CON_FUN_MP_WU.REPETITION
						NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
						NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
						NNData_CON_FUN_MP_WU.CORRELATION_RULE
						NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of data for neural network.
			%
			% N = NNData_CON_FUN_MP_WU.GETPROPNUMBER() returns the property number of data for neural network.
			%
			% Alternative forms to call this method are:
			%  N = NND.GETPROPNUMBER() returns the property number of the data for neural network NND.
			%  N = Element.GETPROPNUMBER(NND) returns the property number of 'NND'.
			%  N = Element.GETPROPNUMBER('NNData_CON_FUN_MP_WU') returns the property number of 'NNData_CON_FUN_MP_WU'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 15;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in data for neural network/error.
			%
			% CHECK = NNData_CON_FUN_MP_WU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NND.EXISTSPROP(PROP) checks whether PROP exists for NND.
			%  CHECK = Element.EXISTSPROP(NND, PROP) checks whether PROP exists for NND.
			%  CHECK = Element.EXISTSPROP(NNData_CON_FUN_MP_WU, PROP) checks whether PROP exists for NNData_CON_FUN_MP_WU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NND.EXISTSPROP(PROP) throws error if PROP does NOT exist for NND.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  Element.EXISTSPROP(NND, PROP) throws error if PROP does NOT exist for NND.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  Element.EXISTSPROP(NNData_CON_FUN_MP_WU, PROP) throws error if PROP does NOT exist for NNData_CON_FUN_MP_WU.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15 ]);
			else
				assert( ...
					NNData_CON_FUN_MP_WU.existsProp(prop), ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNData_CON_FUN_MP_WU.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in data for neural network/error.
			%
			% CHECK = NNData_CON_FUN_MP_WU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NND.EXISTSTAG(TAG) checks whether TAG exists for NND.
			%  CHECK = Element.EXISTSTAG(NND, TAG) checks whether TAG exists for NND.
			%  CHECK = Element.EXISTSTAG(NNData_CON_FUN_MP_WU, TAG) checks whether TAG exists for NNData_CON_FUN_MP_WU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NND.EXISTSTAG(TAG) throws error if TAG does NOT exist for NND.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  Element.EXISTSTAG(NND, TAG) throws error if TAG does NOT exist for NND.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  Element.EXISTSTAG(NNData_CON_FUN_MP_WU, TAG) throws error if TAG does NOT exist for NNData_CON_FUN_MP_WU.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nndata_con_fun_mp_wu_tag_list = { 'id'  'label'  'notes'  'waitbar'  'input_type'  'g'  'measures'  'target_name'  'gr'  'gr_nn'  'repetition'  'frequencyrulemin'  'frequencyrulemax'  'correlation_rule'  'negative_weight_rule' };
				
				check = any(strcmpi(tag, nndata_con_fun_mp_wu_tag_list));
			else
				assert( ...
					NNData_CON_FUN_MP_WU.existsTag(tag), ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNData_CON_FUN_MP_WU'] ...
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
			%  PROPERTY = NND.GETPROPPROP(POINTER) returns property number of POINTER of NND.
			%  PROPERTY = Element.GETPROPPROP(NNData_CON_FUN_MP_WU, POINTER) returns property number of POINTER of NNData_CON_FUN_MP_WU.
			%  PROPERTY = NND.GETPROPPROP(NNData_CON_FUN_MP_WU, POINTER) returns property number of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nndata_con_fun_mp_wu_tag_list = { 'id'  'label'  'notes'  'waitbar'  'input_type'  'g'  'measures'  'target_name'  'gr'  'gr_nn'  'repetition'  'frequencyrulemin'  'frequencyrulemax'  'correlation_rule'  'negative_weight_rule' };
				
				tag = pointer;
				NNData_CON_FUN_MP_WU.existsTag(tag);
				
				prop = find(strcmpi(tag, nndata_con_fun_mp_wu_tag_list));
			else % numeric
				prop = pointer;
				NNData_CON_FUN_MP_WU.existsProp(prop);
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
			%  TAG = NND.GETPROPTAG(POINTER) returns tag of POINTER of NND.
			%  TAG = Element.GETPROPTAG(NNData_CON_FUN_MP_WU, POINTER) returns tag of POINTER of NNData_CON_FUN_MP_WU.
			%  TAG = NND.GETPROPTAG(NNData_CON_FUN_MP_WU, POINTER) returns tag of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNData_CON_FUN_MP_WU.existsTag(tag);
			else % numeric
				prop = pointer;
				NNData_CON_FUN_MP_WU.existsProp(prop);
				
				switch prop
					case NNData_CON_FUN_MP_WU.REPETITION
						tag = NNData_CON_FUN_MP_WU.REPETITION_TAG;
					case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
						tag = NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN_TAG;
					case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
						tag = NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX_TAG;
					case NNData_CON_FUN_MP_WU.CORRELATION_RULE
						tag = NNData_CON_FUN_MP_WU.CORRELATION_RULE_TAG;
					case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
						tag = NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE_TAG;
					otherwise
						tag = getPropTag@NNData(prop);
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
			%  CATEGORY = NND.GETPROPCATEGORY(POINTER) returns category of POINTER of NND.
			%  CATEGORY = Element.GETPROPCATEGORY(NNData_CON_FUN_MP_WU, POINTER) returns category of POINTER of NNData_CON_FUN_MP_WU.
			%  CATEGORY = NND.GETPROPCATEGORY(NNData_CON_FUN_MP_WU, POINTER) returns category of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					prop_category = NNData_CON_FUN_MP_WU.REPETITION_CATEGORY;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					prop_category = NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN_CATEGORY;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					prop_category = NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX_CATEGORY;
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					prop_category = NNData_CON_FUN_MP_WU.CORRELATION_RULE_CATEGORY;
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					prop_category = NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNData(prop);
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
			%  FORMAT = NND.GETPROPFORMAT(POINTER) returns format of POINTER of NND.
			%  FORMAT = Element.GETPROPFORMAT(NNData_CON_FUN_MP_WU, POINTER) returns format of POINTER of NNData_CON_FUN_MP_WU.
			%  FORMAT = NND.GETPROPFORMAT(NNData_CON_FUN_MP_WU, POINTER) returns format of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					prop_format = NNData_CON_FUN_MP_WU.REPETITION_FORMAT;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					prop_format = NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN_FORMAT;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					prop_format = NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX_FORMAT;
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					prop_format = NNData_CON_FUN_MP_WU.CORRELATION_RULE_FORMAT;
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					prop_format = NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE_FORMAT;
				otherwise
					prop_format = getPropFormat@NNData(prop);
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
			%  DESCRIPTION = NND.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NND.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNData_CON_FUN_MP_WU, POINTER) returns description of POINTER of NNData_CON_FUN_MP_WU.
			%  DESCRIPTION = NND.GETPROPDESCRIPTION(NNData_CON_FUN_MP_WU, POINTER) returns description of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					prop_description = 'REPETITION(parameter, scalar) is the number of repetitions.';
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					prop_description = 'FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value.';
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					prop_description = 'FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value.';
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type.';
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.';
				case NNData_CON_FUN_MP_WU.INPUT_TYPE
					prop_description = 'INPUT_TYPE (data, option) is the input type for training or testing the NN.';
				case NNData_CON_FUN_MP_WU.G
					prop_description = 'G (data, item) is the graph for calculating the graph measures.';
				case NNData_CON_FUN_MP_WU.GR
					prop_description = 'GR (data, item) is a group of subjects defined as SubjectFUN class.';
				case NNData_CON_FUN_MP_WU.GR_NN
					prop_description = 'GR_NN (result, group) is a group of NN subjects.';
				otherwise
					prop_description = getPropDescription@NNData(prop);
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
			%  SETTINGS = NND.GETPROPSETTINGS(POINTER) returns settings of POINTER of NND.
			%  SETTINGS = Element.GETPROPSETTINGS(NNData_CON_FUN_MP_WU, POINTER) returns settings of POINTER of NNData_CON_FUN_MP_WU.
			%  SETTINGS = NND.GETPROPSETTINGS(NNData_CON_FUN_MP_WU, POINTER) returns settings of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST;
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case NNData_CON_FUN_MP_WU.INPUT_TYPE
					prop_settings = {'adjacency_matrices' 'graph_measures'};
				case NNData_CON_FUN_MP_WU.GR_NN
					prop_settings = 'NNGroup';
				otherwise
					prop_settings = getPropSettings@NNData(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNData_CON_FUN_MP_WU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNData_CON_FUN_MP_WU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NND.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NND.
			%  DEFAULT = Element.GETPROPDEFAULT(NNData_CON_FUN_MP_WU, POINTER) returns the default value of POINTER of NNData_CON_FUN_MP_WU.
			%  DEFAULT = NND.GETPROPDEFAULT(NNData_CON_FUN_MP_WU, POINTER) returns the default value of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					prop_default = 1;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					prop_default = 0;
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					prop_default = Inf;
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case NNData_CON_FUN_MP_WU.G
					prop_default = MultiplexWU();
				case NNData_CON_FUN_MP_WU.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP');
				case NNData_CON_FUN_MP_WU.GR_NN
					prop_default = NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'));
				otherwise
					prop_default = getPropDefault@NNData(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNData_CON_FUN_MP_WU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNData_CON_FUN_MP_WU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NND.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NND.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNData_CON_FUN_MP_WU, POINTER) returns the conditioned default value of POINTER of NNData_CON_FUN_MP_WU.
			%  DEFAULT = NND.GETPROPDEFAULTCONDITIONED(NNData_CON_FUN_MP_WU, POINTER) returns the conditioned default value of POINTER of NNData_CON_FUN_MP_WU.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			prop_default = NNData_CON_FUN_MP_WU.conditioning(prop, NNData_CON_FUN_MP_WU.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NND.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NND.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NND.
			%  CHECK = Element.CHECKPROP(NNData_CON_FUN_MP_WU, PROP, VALUE) checks VALUE format for PROP of NNData_CON_FUN_MP_WU.
			%  CHECK = NND.CHECKPROP(NNData_CON_FUN_MP_WU, PROP, VALUE) checks VALUE format for PROP of NNData_CON_FUN_MP_WU.
			% 
			% NND.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NND.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NND.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  Element.CHECKPROP(NNData_CON_FUN_MP_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNData_CON_FUN_MP_WU.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			%  NND.CHECKPROP(NNData_CON_FUN_MP_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNData_CON_FUN_MP_WU.
			%   Error id: [BRAPH2:NNData_CON_FUN_MP_WU:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				case NNData_CON_FUN_MP_WU.REPETITION
					check = Format.checkFormat(Format.SCALAR, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMIN
					check = Format.checkFormat(Format.SCALAR, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.FREQUENCYRULEMAX
					check = Format.checkFormat(Format.SCALAR, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.CORRELATION_RULE
					check = Format.checkFormat(Format.OPTION, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(Format.OPTION, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.INPUT_TYPE
					check = Format.checkFormat(Format.OPTION, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				case NNData_CON_FUN_MP_WU.GR_NN
					check = Format.checkFormat(Format.GROUP, value, NNData_CON_FUN_MP_WU.getPropSettings(prop));
				otherwise
					check = checkProp@NNData(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData_CON_FUN_MP_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNData_CON_FUN_MP_WU.getPropTag(prop) ' (' NNData_CON_FUN_MP_WU.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nnd = NNData_CON_FUN_MP_WU(varargin)
			% NNData_CON_FUN_MP_WU() creates a data for neural network.
			%
			% NNData_CON_FUN_MP_WU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNData_CON_FUN_MP_WU(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNData_CON_FUN_MP_WU properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>input_type</strong> 	INPUT_TYPE (data, option) is the input type for training or testing the NN.
			%  <strong>6</strong> <strong>g</strong> 	G (data, item) is the graph for calculating the graph measures.
			%  <strong>7</strong> <strong>measures</strong> 	MEASURES (data, classlist) is the graph measures as input to NN.
			%  <strong>8</strong> <strong>target_name</strong> 	TARGET_NAME (data, string) is the name of the traget.
			%  <strong>9</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects defined as SubjectFUN class.
			%  <strong>10</strong> <strong>gr_nn</strong> 	GR_NN (result, group) is a group of NN subjects.
			%  <strong>11</strong> <strong>repetition</strong> 	REPETITION(parameter, scalar) is the number of repetitions.
			%  <strong>12</strong> <strong>frequencyrulemin</strong> 	FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value.
			%  <strong>13</strong> <strong>frequencyrulemax</strong> 	FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value.
			%  <strong>14</strong> <strong>correlation_rule</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>15</strong> <strong>negative_weight_rule</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%
			% See also Category, Format, set, check.
			
			nnd = nnd@NNData(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNData_CON_FUN_MP_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= NNData.getPropNumber()
						value = conditioning@NNData(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnd, prop)
		
			switch prop
				case NNData_CON_FUN_MP_WU.GR_NN
					if nnd.get('WAITBAR')
					    wb = waitbar(0, 'Constructing NN input ...', 'Name', BRAPH2.NAME);
					    set_braph2icon(wb)
					end
					
					gr = nnd.get('GR');
					T = nnd.get('REPETITION');
					fmin = nnd.get('FREQUENCYRULEMIN');
					fmax = nnd.get('FREQUENCYRULEMAX');
					nn_gr = NNGroup( ...
					    'SUB_CLASS', 'NNSubject', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
					    );
					
					nn_gr.lock('SUB_CLASS');
					
					nn_gr.set( ...
					    'ID', gr.get('ID'), ...
					    'LABEL', gr.get('LABEL'), ...
					    'NOTES', gr.get('NOTES') ...
					    );
					
					atlas = BrainAtlas();
					if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
					    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
					end
					
					nn_sub_dict = nn_gr.get('SUB_DICT');
					
					for i = 1:1:gr.get('SUB_DICT').length()
					    A = cell(1, 2);
						sub = gr.get('SUB_DICT').getItem(i);
					    CON_FUN_MP = sub.getr('CON_FUN_MP');
					    
					    % CON data
					    A(1) = CON_FUN_MP(1);
					    
					    % FUN data
					    data = CON_FUN_MP{2};
					    fs = 1 / T;
					    
					    if fmax > fmin && T > 0
					        NFFT = 2 * ceil(size(data, 1) / 2);
					        ft = fft(data, NFFT);  % Fourier transform
					        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					        ft(f < fmin | f > fmax, :) = 0;
					        data = ifft(ft, NFFT);
					    end
					    
					    A(2) = {Correlation.getAdjacencyMatrix(data, nnd.get('CORRELATION_RULE'), nnd.get('NEGATIVE_WEIGHT_RULE'))};
					    
					    g = MultiplexWU( ...
					        'ID', ['g ' sub.get('ID')], ...
					        'B', A ...
					        );
					    
					    if string(nnd.get('INPUT_TYPE')) == "adjacency_matrices"
					        adj = g.get('A'); 
					        input = {adj{1} adj{4}};
					
					    elseif string(nnd.get('INPUT_TYPE')) == "graph_measures"
					        input_nodal = [];
					        input_binodal = [];
					        input_global = [];
					        mlist = nnd.get('MEASURES');
					        for j = 1:length(mlist)
					            if Measure.is_nodal(mlist{j})
					                input_nodal = [input_nodal; cell2mat(g.getMeasure(mlist{j}).get('M'))];
					            elseif Measure.is_global(mlist{j})
					                input_global = [input_global; cell2mat(g.getMeasure(mlist{j}).get('M'))];
					            else
					                input_binodal = [input_binodal; cell2mat(g.getMeasure(mlist{j}).get('M'))];
					            end
					        end
					        input = {input_nodal input_global input_binodal};
					    end
					
					    nn_sub = NNSubject( ...
					        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
					        'BA', atlas, ...
					        'age', sub.get('age'), ...
					        'sex', sub.get('sex'), ...
					        'G', g, ...
					        'INPUT', input, ...
					        'TARGET_NAME', nnd.get('TARGET_NAME') ...
					        );
					
					    nn_sub_dict.add(nn_sub);
					
					    if nnd.get('WAITBAR')
					        waitbar(.30 + .70 * i / gr.get('SUB_DICT').length(), wb, ['Constructing subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length())  ' in ' gr.get('ID') ' ...'])
					    end
					end
					
					nn_gr.set('sub_dict', nn_sub_dict);
					
					if nnd.get('WAITBAR')
					    close(wb)
					end
					
					value = nn_gr;
					
				otherwise
					value = calculateValue@NNData(nnd, prop);
					
			end
		end
	end
end
