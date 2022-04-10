classdef NNRegressorCrossValidation < Element
	% NNRegressorCrossValidation cross-validate the performance of neural network regressors with a dataset.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% 
	%
	% The list of NNRegressorCrossValidation properties is:
	%  <strong>1</strong> <strong>kfold</strong> 	KFOLD (data, scalar) is the number of folds.
	%  <strong>2</strong> <strong>repetition</strong> 	REPETITION (data, scalar) is the number of repetitions.
	%  <strong>3</strong> <strong>gr</strong> 	GR (data, item) is is a group of subjects.
	%  <strong>4</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
	%  <strong>5</strong> <strong>split_kfold</strong> 	SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.
	%  <strong>6</strong> <strong>nnds_dict</strong> 	NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
	%  <strong>7</strong> <strong>nn_dict</strong> 	NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.
	%  <strong>8</strong> <strong>nne_dict</strong> 	NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
	%  <strong>9</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
	%  <strong>10</strong> <strong>rmse</strong> 	RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.
	%  <strong>11</strong> <strong>contribution_map</strong> 	CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
	%
	% NNRegressorCrossValidation methods (constructor):
	% NNRegressorCrossValidation - constructor
	%
	% NNRegressorCrossValidation methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in cross-validation for neural network regressor/error.
	%  existsProp - checks whether property exists in cross-validation for neural network regressor/error.
	%  getPropNumber - returns the property number of cross-validation for neural network regressor.
	%  getProps - returns the property list of cross-validation for neural network regressor.
	%  getDescription - returns the description of the cross-validation for neural network regressor.
	%  getName - returns the name of the cross-validation for neural network regressor.
	%  getClass - returns the class of the cross-validation for neural network regressor.
	%
	% NNRegressorCrossValidation methods:
	%  get_CI - calculates the 95% confidence interval.
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
	% NNRegressorCrossValidation methods (operators):
	%  isequal - determines whether two NNRegressorCrossValidation are equal (values, locked)
	%
	% NNRegressorCrossValidation methods (display):
	%  tostring - string with information about the NNRegressorCrossValidation
	%  disp - displays information about the NNRegressorCrossValidation
	%  tree - displays the element of NNRegressorCrossValidation
	%
	% NNRegressorCrossValidation method (element list):
	%  getElementList - returns a list with all subelements of NNRegressorCrossValidation
	%
	% NNRegressorCrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNRegressorCrossValidation
	%
	% NNRegressorCrossValidation method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNRegressorCrossValidation
	%
	% NNRegressorCrossValidation methods (copy):
	%  copy - copies the NNRegressorCrossValidation
	%  deepclone - deep-clones the NNRegressorCrossValidation
	%  clone - clones the NNRegressorCrossValidation
	%
	% NNRegressorCrossValidation methods (inspection, Static):
	%  getClass - returns NNRegressorCrossValidation
	%  getName - returns the name of NNRegressorCrossValidation
	%  getDescription - returns the description of NNRegressorCrossValidation
	%  getProps - returns the property list of NNRegressorCrossValidation
	%  getPropNumber - returns the property number of NNRegressorCrossValidation
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
	% NNRegressorCrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorCrossValidation methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNRegressorCrossValidation methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNRegressorCrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNRegressorCrossValidation properties (Constant).
	%  KFOLD - 1
	%  KFOLD_TAG - 'kfold'
	%  KFOLD_CATEGORY - 'd'
	%  KFOLD_FORMAT - 'nn'
	%  REPETITION - 2
	%  REPETITION_TAG - 'repetition'
	%  REPETITION_CATEGORY - 'd'
	%  REPETITION_FORMAT - 'nn'
	%  GR - 3
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  FEATURE_MASK - 4
	%  FEATURE_MASK_TAG - 'feature_mask'
	%  FEATURE_MASK_CATEGORY - 'd'
	%  FEATURE_MASK_FORMAT - 'll'
	%  SPLIT_KFOLD - 5
	%  SPLIT_KFOLD_TAG - 'split_kfold'
	%  SPLIT_KFOLD_CATEGORY - 'r'
	%  SPLIT_KFOLD_FORMAT - 'll'
	%  NNDS_DICT - 6
	%  NNDS_DICT_TAG - 'nnds_dict'
	%  NNDS_DICT_CATEGORY - 'r'
	%  NNDS_DICT_FORMAT - 'di'
	%  NN_DICT - 7
	%  NN_DICT_TAG - 'nn_dict'
	%  NN_DICT_CATEGORY - 'r'
	%  NN_DICT_FORMAT - 'di'
	%  NNE_DICT - 8
	%  NNE_DICT_TAG - 'nne_dict'
	%  NNE_DICT_CATEGORY - 'r'
	%  NNE_DICT_FORMAT - 'di'
	%  GR_PREDICTION - 9
	%  GR_PREDICTION_TAG - 'gr_prediction'
	%  GR_PREDICTION_CATEGORY - 'r'
	%  GR_PREDICTION_FORMAT - 'it'
	%  RMSE - 10
	%  RMSE_TAG - 'rmse'
	%  RMSE_CATEGORY - 'r'
	%  RMSE_FORMAT - 'nn'
	%  CONTRIBUTION_MAP - 11
	%  CONTRIBUTION_MAP_TAG - 'contribution_map'
	%  CONTRIBUTION_MAP_CATEGORY - 'r'
	%  CONTRIBUTION_MAP_FORMAT - 'nm'
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
		KFOLD = 1;
		KFOLD_TAG = 'kfold';
		KFOLD_CATEGORY = Category.DATA;
		KFOLD_FORMAT = Format.SCALAR;
		
		REPETITION = 2;
		REPETITION_TAG = 'repetition';
		REPETITION_CATEGORY = Category.DATA;
		REPETITION_FORMAT = Format.SCALAR;
		
		GR = 3;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		FEATURE_MASK = 4;
		FEATURE_MASK_TAG = 'feature_mask';
		FEATURE_MASK_CATEGORY = Category.DATA;
		FEATURE_MASK_FORMAT = Format.CELL;
		
		SPLIT_KFOLD = 5;
		SPLIT_KFOLD_TAG = 'split_kfold';
		SPLIT_KFOLD_CATEGORY = Category.RESULT;
		SPLIT_KFOLD_FORMAT = Format.CELL;
		
		NNDS_DICT = 6;
		NNDS_DICT_TAG = 'nnds_dict';
		NNDS_DICT_CATEGORY = Category.RESULT;
		NNDS_DICT_FORMAT = Format.IDICT;
		
		NN_DICT = 7;
		NN_DICT_TAG = 'nn_dict';
		NN_DICT_CATEGORY = Category.RESULT;
		NN_DICT_FORMAT = Format.IDICT;
		
		NNE_DICT = 8;
		NNE_DICT_TAG = 'nne_dict';
		NNE_DICT_CATEGORY = Category.RESULT;
		NNE_DICT_FORMAT = Format.IDICT;
		
		GR_PREDICTION = 9;
		GR_PREDICTION_TAG = 'gr_prediction';
		GR_PREDICTION_CATEGORY = Category.RESULT;
		GR_PREDICTION_FORMAT = Format.ITEM;
		
		RMSE = 10;
		RMSE_TAG = 'rmse';
		RMSE_CATEGORY = Category.RESULT;
		RMSE_FORMAT = Format.SCALAR;
		
		CONTRIBUTION_MAP = 11;
		CONTRIBUTION_MAP_TAG = 'contribution_map';
		CONTRIBUTION_MAP_CATEGORY = Category.RESULT;
		CONTRIBUTION_MAP_FORMAT = Format.MATRIX;
	end
	methods (Static) % inspection methods
		function nncv_class = getClass()
			%GETCLASS returns the class of the cross-validation for neural network regressor.
			%
			% CLASS = NNRegressorCrossValidation.GETCLASS() returns the class 'NNRegressorCrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the cross-validation for neural network regressor NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNRegressorCrossValidation') returns 'NNRegressorCrossValidation'.
			%
			% See also getName, getDescription.
			
			nncv_class = 'NNRegressorCrossValidation';
		end
		function nncv_name = getName()
			%GETNAME returns the name of the cross-validation for neural network regressor.
			%
			% NAME = NNRegressorCrossValidation.GETNAME() returns the name of the 'cross-validation for neural network regressor'.
			%  Cross-Validation For Neural Network Regressor.
			%
			% Alternative forms to call this method are:
			%  NAME = NNCV.GETNAME() returns the name of the cross-validation for neural network regressor NNCV.
			%  NAME = Element.GETNAME(NNCV) returns the name of 'NNCV'.
			%  NAME = Element.GETNAME('NNRegressorCrossValidation') returns the name of 'NNRegressorCrossValidation'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nncv_name = 'Cross-Validation For Neural Network Regressor';
		end
		function nncv_description = getDescription()
			%GETDESCRIPTION returns the description of the cross-validation for neural network regressor.
			%
			% STR = NNRegressorCrossValidation.GETDESCRIPTION() returns the description of the 'cross-validation for neural network regressor'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNCV.GETDESCRIPTION() returns the description of the cross-validation for neural network regressor NNCV.
			%  STR = Element.GETDESCRIPTION(NNCV) returns the description of 'NNCV'.
			%  STR = Element.GETDESCRIPTION('NNRegressorCrossValidation') returns the description of 'NNRegressorCrossValidation'.
			%
			% See also getClass, getName.
			
			nncv_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cross-validation for neural network regressor.
			%
			% PROPS = NNRegressorCrossValidation.GETPROPS() returns the property list of cross-validation for neural network regressor.
			%
			% PROPS = NNRegressorCrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the cross-validation for neural network regressor NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNRegressorCrossValidation'[, CATEGORY]) returns the property list of 'NNRegressorCrossValidation'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNRegressorCrossValidation.KFOLD
						NNRegressorCrossValidation.REPETITION
						NNRegressorCrossValidation.GR
						NNRegressorCrossValidation.FEATURE_MASK
						];
				case Category.RESULT
					prop_list = [
						NNRegressorCrossValidation.SPLIT_KFOLD
						NNRegressorCrossValidation.NNDS_DICT
						NNRegressorCrossValidation.NN_DICT
						NNRegressorCrossValidation.NNE_DICT
						NNRegressorCrossValidation.GR_PREDICTION
						NNRegressorCrossValidation.RMSE
						NNRegressorCrossValidation.CONTRIBUTION_MAP
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNRegressorCrossValidation.KFOLD
						NNRegressorCrossValidation.REPETITION
						NNRegressorCrossValidation.GR
						NNRegressorCrossValidation.FEATURE_MASK
						NNRegressorCrossValidation.SPLIT_KFOLD
						NNRegressorCrossValidation.NNDS_DICT
						NNRegressorCrossValidation.NN_DICT
						NNRegressorCrossValidation.NNE_DICT
						NNRegressorCrossValidation.GR_PREDICTION
						NNRegressorCrossValidation.RMSE
						NNRegressorCrossValidation.CONTRIBUTION_MAP
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of cross-validation for neural network regressor.
			%
			% N = NNRegressorCrossValidation.GETPROPNUMBER() returns the property number of cross-validation for neural network regressor.
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER() returns the property number of the cross-validation for neural network regressor NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNRegressorCrossValidation') returns the property number of 'NNRegressorCrossValidation'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 11;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in cross-validation for neural network regressor/error.
			%
			% CHECK = NNRegressorCrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNRegressorCrossValidation, PROP) checks whether PROP exists for NNRegressorCrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNRegressorCrossValidation, PROP) throws error if PROP does NOT exist for NNRegressorCrossValidation.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11 ]);
			else
				assert( ...
					NNRegressorCrossValidation.existsProp(prop), ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorCrossValidation.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cross-validation for neural network regressor/error.
			%
			% CHECK = NNRegressorCrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNRegressorCrossValidation, TAG) checks whether TAG exists for NNRegressorCrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNRegressorCrossValidation, TAG) throws error if TAG does NOT exist for NNRegressorCrossValidation.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressorcrossvalidation_tag_list = { 'kfold'  'repetition'  'gr'  'feature_mask'  'split_kfold'  'nnds_dict'  'nn_dict'  'nne_dict'  'gr_prediction'  'rmse'  'contribution_map' };
				
				check = any(strcmpi(tag, nnregressorcrossvalidation_tag_list));
			else
				assert( ...
					NNRegressorCrossValidation.existsTag(tag), ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNRegressorCrossValidation'] ...
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
			%  PROPERTY = NNCV.GETPROPPROP(POINTER) returns property number of POINTER of NNCV.
			%  PROPERTY = Element.GETPROPPROP(NNRegressorCrossValidation, POINTER) returns property number of POINTER of NNRegressorCrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNRegressorCrossValidation, POINTER) returns property number of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressorcrossvalidation_tag_list = { 'kfold'  'repetition'  'gr'  'feature_mask'  'split_kfold'  'nnds_dict'  'nn_dict'  'nne_dict'  'gr_prediction'  'rmse'  'contribution_map' };
				
				tag = pointer;
				NNRegressorCrossValidation.existsTag(tag);
				
				prop = find(strcmpi(tag, nnregressorcrossvalidation_tag_list));
			else % numeric
				prop = pointer;
				NNRegressorCrossValidation.existsProp(prop);
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
			%  TAG = NNCV.GETPROPTAG(POINTER) returns tag of POINTER of NNCV.
			%  TAG = Element.GETPROPTAG(NNRegressorCrossValidation, POINTER) returns tag of POINTER of NNRegressorCrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNRegressorCrossValidation, POINTER) returns tag of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNRegressorCrossValidation.existsTag(tag);
			else % numeric
				prop = pointer;
				NNRegressorCrossValidation.existsProp(prop);
				
				switch prop
					case NNRegressorCrossValidation.KFOLD
						tag = NNRegressorCrossValidation.KFOLD_TAG;
					case NNRegressorCrossValidation.REPETITION
						tag = NNRegressorCrossValidation.REPETITION_TAG;
					case NNRegressorCrossValidation.GR
						tag = NNRegressorCrossValidation.GR_TAG;
					case NNRegressorCrossValidation.FEATURE_MASK
						tag = NNRegressorCrossValidation.FEATURE_MASK_TAG;
					case NNRegressorCrossValidation.SPLIT_KFOLD
						tag = NNRegressorCrossValidation.SPLIT_KFOLD_TAG;
					case NNRegressorCrossValidation.NNDS_DICT
						tag = NNRegressorCrossValidation.NNDS_DICT_TAG;
					case NNRegressorCrossValidation.NN_DICT
						tag = NNRegressorCrossValidation.NN_DICT_TAG;
					case NNRegressorCrossValidation.NNE_DICT
						tag = NNRegressorCrossValidation.NNE_DICT_TAG;
					case NNRegressorCrossValidation.GR_PREDICTION
						tag = NNRegressorCrossValidation.GR_PREDICTION_TAG;
					case NNRegressorCrossValidation.RMSE
						tag = NNRegressorCrossValidation.RMSE_TAG;
					case NNRegressorCrossValidation.CONTRIBUTION_MAP
						tag = NNRegressorCrossValidation.CONTRIBUTION_MAP_TAG;
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
			%  CATEGORY = NNCV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNCV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorCrossValidation, POINTER) returns category of POINTER of NNRegressorCrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNRegressorCrossValidation, POINTER) returns category of POINTER of NNRegressorCrossValidation.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					prop_category = NNRegressorCrossValidation.KFOLD_CATEGORY;
				case NNRegressorCrossValidation.REPETITION
					prop_category = NNRegressorCrossValidation.REPETITION_CATEGORY;
				case NNRegressorCrossValidation.GR
					prop_category = NNRegressorCrossValidation.GR_CATEGORY;
				case NNRegressorCrossValidation.FEATURE_MASK
					prop_category = NNRegressorCrossValidation.FEATURE_MASK_CATEGORY;
				case NNRegressorCrossValidation.SPLIT_KFOLD
					prop_category = NNRegressorCrossValidation.SPLIT_KFOLD_CATEGORY;
				case NNRegressorCrossValidation.NNDS_DICT
					prop_category = NNRegressorCrossValidation.NNDS_DICT_CATEGORY;
				case NNRegressorCrossValidation.NN_DICT
					prop_category = NNRegressorCrossValidation.NN_DICT_CATEGORY;
				case NNRegressorCrossValidation.NNE_DICT
					prop_category = NNRegressorCrossValidation.NNE_DICT_CATEGORY;
				case NNRegressorCrossValidation.GR_PREDICTION
					prop_category = NNRegressorCrossValidation.GR_PREDICTION_CATEGORY;
				case NNRegressorCrossValidation.RMSE
					prop_category = NNRegressorCrossValidation.RMSE_CATEGORY;
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					prop_category = NNRegressorCrossValidation.CONTRIBUTION_MAP_CATEGORY;
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
			%  FORMAT = NNCV.GETPROPFORMAT(POINTER) returns format of POINTER of NNCV.
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorCrossValidation, POINTER) returns format of POINTER of NNRegressorCrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNRegressorCrossValidation, POINTER) returns format of POINTER of NNRegressorCrossValidation.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					prop_format = NNRegressorCrossValidation.KFOLD_FORMAT;
				case NNRegressorCrossValidation.REPETITION
					prop_format = NNRegressorCrossValidation.REPETITION_FORMAT;
				case NNRegressorCrossValidation.GR
					prop_format = NNRegressorCrossValidation.GR_FORMAT;
				case NNRegressorCrossValidation.FEATURE_MASK
					prop_format = NNRegressorCrossValidation.FEATURE_MASK_FORMAT;
				case NNRegressorCrossValidation.SPLIT_KFOLD
					prop_format = NNRegressorCrossValidation.SPLIT_KFOLD_FORMAT;
				case NNRegressorCrossValidation.NNDS_DICT
					prop_format = NNRegressorCrossValidation.NNDS_DICT_FORMAT;
				case NNRegressorCrossValidation.NN_DICT
					prop_format = NNRegressorCrossValidation.NN_DICT_FORMAT;
				case NNRegressorCrossValidation.NNE_DICT
					prop_format = NNRegressorCrossValidation.NNE_DICT_FORMAT;
				case NNRegressorCrossValidation.GR_PREDICTION
					prop_format = NNRegressorCrossValidation.GR_PREDICTION_FORMAT;
				case NNRegressorCrossValidation.RMSE
					prop_format = NNRegressorCrossValidation.RMSE_FORMAT;
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					prop_format = NNRegressorCrossValidation.CONTRIBUTION_MAP_FORMAT;
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
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNCV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorCrossValidation, POINTER) returns description of POINTER of NNRegressorCrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNRegressorCrossValidation, POINTER) returns description of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					prop_description = 'KFOLD (data, scalar) is the number of folds.';
				case NNRegressorCrossValidation.REPETITION
					prop_description = 'REPETITION (data, scalar) is the number of repetitions.';
				case NNRegressorCrossValidation.GR
					prop_description = 'GR (data, item) is is a group of subjects.';
				case NNRegressorCrossValidation.FEATURE_MASK
					prop_description = 'FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.';
				case NNRegressorCrossValidation.SPLIT_KFOLD
					prop_description = 'SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.';
				case NNRegressorCrossValidation.NNDS_DICT
					prop_description = 'NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.';
				case NNRegressorCrossValidation.NN_DICT
					prop_description = 'NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.';
				case NNRegressorCrossValidation.NNE_DICT
					prop_description = 'NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.';
				case NNRegressorCrossValidation.GR_PREDICTION
					prop_description = 'GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.';
				case NNRegressorCrossValidation.RMSE
					prop_description = 'RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.';
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					prop_description = 'CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.';
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
			%  SETTINGS = NNCV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNCV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorCrossValidation, POINTER) returns settings of POINTER of NNRegressorCrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNRegressorCrossValidation, POINTER) returns settings of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorCrossValidation.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorCrossValidation.GR
					prop_settings = 'NNGroup';
				case NNRegressorCrossValidation.FEATURE_MASK
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNRegressorCrossValidation.SPLIT_KFOLD
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNRegressorCrossValidation.NNDS_DICT
					prop_settings = 'NNRegressorDataSplit';
				case NNRegressorCrossValidation.NN_DICT
					prop_settings = 'NNRegressorDNN';
				case NNRegressorCrossValidation.NNE_DICT
					prop_settings = 'NNRegressorEvaluator';
				case NNRegressorCrossValidation.GR_PREDICTION
					prop_settings = 'NNGroup';
				case NNRegressorCrossValidation.RMSE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					prop_settings = Format.getFormatSettings(Format.MATRIX);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorCrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorCrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorCrossValidation, POINTER) returns the default value of POINTER of NNRegressorCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNRegressorCrossValidation, POINTER) returns the default value of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					prop_default = 5;
				case NNRegressorCrossValidation.REPETITION
					prop_default = 1;
				case NNRegressorCrossValidation.GR
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.FEATURE_MASK
					prop_default = num2cell(0.05);
				case NNRegressorCrossValidation.SPLIT_KFOLD
					prop_default = Format.getFormatDefault(Format.CELL, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.NNDS_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit');
				case NNRegressorCrossValidation.NN_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNRegressorDNN');
				case NNRegressorCrossValidation.NNE_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator');
				case NNRegressorCrossValidation.GR_PREDICTION
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.RMSE
					prop_default = Format.getFormatDefault(Format.SCALAR, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					prop_default = Format.getFormatDefault(Format.MATRIX, NNRegressorCrossValidation.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorCrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorCrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorCrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNRegressorCrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorCrossValidation.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			prop_default = NNRegressorCrossValidation.conditioning(prop, NNRegressorCrossValidation.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNCV.
			%  CHECK = Element.CHECKPROP(NNRegressorCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorCrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNRegressorCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorCrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  Element.CHECKPROP(NNRegressorCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorCrossValidation.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			%  NNCV.CHECKPROP(NNRegressorCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorCrossValidation.
			%   Error id: [BRAPH2:NNRegressorCrossValidation:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.KFOLD
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.REPETITION
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.GR
					check = Format.checkFormat(Format.ITEM, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.FEATURE_MASK
					check = Format.checkFormat(Format.CELL, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.SPLIT_KFOLD
					check = Format.checkFormat(Format.CELL, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.NNDS_DICT
					check = Format.checkFormat(Format.IDICT, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.NN_DICT
					check = Format.checkFormat(Format.IDICT, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.NNE_DICT
					check = Format.checkFormat(Format.IDICT, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.GR_PREDICTION
					check = Format.checkFormat(Format.ITEM, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.RMSE
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorCrossValidation.getPropSettings(prop));
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					check = Format.checkFormat(Format.MATRIX, value, NNRegressorCrossValidation.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorCrossValidation.getPropTag(prop) ' (' NNRegressorCrossValidation.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nncv = NNRegressorCrossValidation(varargin)
			% NNRegressorCrossValidation() creates a cross-validation for neural network regressor.
			%
			% NNRegressorCrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorCrossValidation(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorCrossValidation properties is:
			%  <strong>1</strong> <strong>kfold</strong> 	KFOLD (data, scalar) is the number of folds.
			%  <strong>2</strong> <strong>repetition</strong> 	REPETITION (data, scalar) is the number of repetitions.
			%  <strong>3</strong> <strong>gr</strong> 	GR (data, item) is is a group of subjects.
			%  <strong>4</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
			%  <strong>5</strong> <strong>split_kfold</strong> 	SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.
			%  <strong>6</strong> <strong>nnds_dict</strong> 	NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
			%  <strong>7</strong> <strong>nn_dict</strong> 	NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.
			%  <strong>8</strong> <strong>nne_dict</strong> 	NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
			%  <strong>9</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
			%  <strong>10</strong> <strong>rmse</strong> 	RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.
			%  <strong>11</strong> <strong>contribution_map</strong> 	CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
			%
			% See also Category, Format, set, check.
			
			nncv = nncv@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNRegressorCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorCrossValidation.FEATURE_MASK
					if ~iscell(value) & isnumeric(value)
					    value = num2cell(value);
					end
					
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nncv, prop)
		
			switch prop
				case NNRegressorCrossValidation.SPLIT_KFOLD
					rng(nncv.getPropSeed(NNRegressorCrossValidation.SPLIT_KFOLD), 'twister')
					
					num_per_class = nncv.get('GR').get('SUB_DICT').length;
					kfold = nncv.get('KFOLD');
					shuffle_indexes = randperm(num_per_class, num_per_class);
					num_per_fold = floor(num_per_class / kfold);
					r_times = rem(num_per_class, kfold);
					r = zeros(1, kfold);
					r(randperm(kfold, r_times)) = 1;
					jend = 0;
					for j = 1:kfold
					    jstart = jend + 1;
					    if j == kfold
					        index_kfold{j} = shuffle_indexes(jend+1:end);
					    else
					        jend = jend + num_per_fold + r(j);
					        index_kfold{j} = shuffle_indexes(jstart:jend);
					    end
					end
					
					value = index_kfold;
					
				case NNRegressorCrossValidation.NNDS_DICT
					rng(nncv.getPropSeed(NNRegressorCrossValidation.NNDS_DICT), 'twister')
					
					nnds_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit');
					if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
					    for i = 1:1:nncv.get('REPETITION')
					        idx_per_fold = nncv.get('SPLIT_KFOLD');
					        for j = 1:1:nncv.get('KFOLD')
					            nnds = NNRegressorDataSplit( ...
					                'ID', ['kfold ', num2str(j), ' repetition ', num2str(i)], ...
					                'GR', nncv.get('GR'), ...
					                'SPLIT', idx_per_fold{j}, ...
					                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
					                );
					
					            nnds.memorize('GR_VAL_FS');
					            nnds.memorize('GR_TRAIN_FS');
					
					            nnds_dict.add(nnds)
					        end
					    end
					end
					
					value = nnds_dict;
					
				case NNRegressorCrossValidation.NN_DICT
					rng(nncv.getPropSeed(NNRegressorCrossValidation.NN_DICT), 'twister')
					
					nn_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDNN');
					if nncv.memorize('NNDS_DICT').length() > 0
					    for i = 1:1:nncv.get('NNDS_DICT').length()
					        nnds = nncv.get('NNDS_DICT').getItem(i);
					        gr_train = nnds.get('GR_TRAIN_FS');
					
					        nn = NNRegressorDNN( ...
					                'ID', nnds.get('ID'), ...
					                'GR', gr_train, ...
					                'VERBOSE', false, ...
					                'SHUFFLE', 'every-epoch' ...
					                );
					            
					        nn_dict.add(nn)
					    end
					end
					
					value = nn_dict;
					
				case NNRegressorCrossValidation.NNE_DICT
					rng(nncv.getPropSeed(NNRegressorCrossValidation.NNE_DICT), 'twister')
					
					nne_dict = IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator');
					if nncv.memorize('NN_DICT').length() > 0
					    for i = 1:1:nncv.get('NN_DICT').length()
					        nn = nncv.get('NN_DICT').getItem(i);
					        nnds = nncv.get('NNDS_DICT').getItem(i);
					        gr_val = nnds.get('GR_VAL_FS');
					
					        nne = NNRegressorEvaluator( ...
					                'ID', nn.get('ID'), ...
					                'GR', gr_val, ...
					                'NN', nn ...
					                );
					            
					        nne_dict.add(nne)
					    end
					end
					
					value = nne_dict;
					
				case NNRegressorCrossValidation.GR_PREDICTION
					rng(nncv.getPropSeed(NNRegressorCrossValidation.GR_PREDICTION), 'twister')
					
					if nncv.memorize('NNE_DICT').length() > 0
					    gr = nncv.get('NNE_DICT').getItem(1).get('GR_PREDICTION');
					    gr_prediction = NNGroup( ...
					        'ID', gr.get('ID'), ...
					        'LABEL', gr.get('LABEL'), ...
					        'NOTES', gr.get('NOTES'), ...
					        'SUB_CLASS', gr.get('SUB_CLASS'), ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
					        );
					
					    % add subejcts from NNE_DICT
					    sub_dict = gr_prediction.get('SUB_DICT');
					
					    for i = 1:1:nncv.memorize('NNE_DICT').length()
					        nne = nncv.memorize('NNE_DICT').getItem(i);
					        for j = 1:1:nne.memorize('GR_PREDICTION').get('SUB_DICT').length()
					            sub = nne.memorize('GR_PREDICTION').get('SUB_DICT').getItem(j);
					            sub_dict.add(sub);
					        end
					    end
					
					    gr_prediction.set('SUB_DICT', sub_dict);
					else
					    gr_prediction = NNGroup();
					end
					
					value = gr_prediction;
					
				case NNRegressorCrossValidation.RMSE
					rng(nncv.getPropSeed(NNRegressorCrossValidation.RMSE), 'twister')
					
					if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = 0;
					else
					    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    preds = cell2mat(preds);
					    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    targets = cell2mat(targets);
					    value = sqrt(mean((preds - targets).^2));
					end
					
				case NNRegressorCrossValidation.CONTRIBUTION_MAP
					rng(nncv.getPropSeed(NNRegressorCrossValidation.CONTRIBUTION_MAP), 'twister')
					
					nne_dict = nncv.memorize('NNE_DICT');
					heat_map = 0;
					if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('VAL_AUC'))
					    for i = 1:1:nne_dict.length()
					        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
					        auc_val = nne_dict.getItem(i).get('AUC');
					        feature_map(feature_map == 1) = auc_val{1};
					        heat_map = heat_map + feature_map;
					    end
					    heat_map = heat_map / nne_dict.length();
					    if nncv.get('PLOT_MAP')
					        figure
					        x = [1 size(heat_map, 2)];
					        y = [0 size(heat_map, 1)];
					        image(x, y, heat_map, 'CDataMapping', 'scaled')
					        if string(nne_dict.getItem(i).get('NNData').get('INPUT_TYPE')) == 'graph_measures'
					            ticklabel = nncv.get('MEASURES');
					            fontsize = 12;
					        else
					            ticklabel = 0:size(heat_map, 2);
					            fontsize = 5;
					        end
					        xticks([1:size(heat_map, 2)]);
					        yticks([1:size(heat_map, 1)]);
					    	xticklabels(ticklabel);
					        yticklabels(0:size(heat_map, 1));
					        a = get(gca,'XTickLabel');
					        set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
					        a = get(gca,'YTickLabel');
					        set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
					        colorbar
					        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					        if ~exist(directory, 'dir')
					            mkdir(directory)
					        end
					        filename = [directory filesep 'cv_contribution_map.svg'];
					        saveas(gcf, filename);
					    end
					
					    value = heat_map;
					else
					    value = heat_map;
					end
					
				otherwise
					value = calculateValue@Element(nncv, prop);
					
			end
		end
	end
	methods % methods
		function [avg, CI] = get_CI(nncv, scores)
		    %GET_CI calculates the 95% confidence interval.
		    % 
		    % [AVG, CI] = GET_CI(NNCV, SCORES) calculates the 95% confidence interval
		    %  of the input scores which are in a form of rvector. AVG is the mean 
		    %  value of the input scores. CI are the upper and lower boundary of
		    %  the corresponding 95% confidence interval.
		
		    avg = mean(scores);
		    SEM = std(scores)/sqrt(length(scores));               
		    ts = tinv([0.025  0.975],length(scores)-1);     
		    CI = avg + ts*SEM;
		end
	end
end
