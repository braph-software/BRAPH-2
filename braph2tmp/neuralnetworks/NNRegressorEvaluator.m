classdef NNRegressorEvaluator < NNEvaluator
	% NNRegressorEvaluator evaluates the performance of a neural network regressor with a specific dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% 
	%
	% The list of NNRegressorEvaluator properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
	%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model that needs to be evaluated.
	%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
	%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
	%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
	%  <strong>8</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the feature map.
	%  <strong>9</strong> <strong>rmse</strong> 	RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.
	%  <strong>10</strong> <strong>scatter_plot</strong> 	SCATTER_PLOT (result, scalar) creates a scatter plot with circular markers at the locations specified by predictions and targets.
	%
	% NNRegressorEvaluator methods (constructor):
	% NNRegressorEvaluator - constructor
	%
	% NNRegressorEvaluator methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in evaluator for a neural network regressor/error.
	%  existsProp - checks whether property exists in evaluator for a neural network regressor/error.
	%  getPropNumber - returns the property number of evaluator for a neural network regressor.
	%  getProps - returns the property list of evaluator for a neural network regressor.
	%  getDescription - returns the description of the evaluator for a neural network regressor.
	%  getName - returns the name of the evaluator for a neural network regressor.
	%  getClass - returns the class of the evaluator for a neural network regressor.
	%
	% NNRegressorEvaluator methods:
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
	% NNRegressorEvaluator methods (operators):
	%  isequal - determines whether two NNRegressorEvaluator are equal (values, locked)
	%
	% NNRegressorEvaluator methods (display):
	%  tostring - string with information about the NNRegressorEvaluator
	%  disp - displays information about the NNRegressorEvaluator
	%  tree - displays the element of NNRegressorEvaluator
	%
	% NNRegressorEvaluator method (element list):
	%  getElementList - returns a list with all subelements of NNRegressorEvaluator
	%
	% NNRegressorEvaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNRegressorEvaluator
	%
	% NNRegressorEvaluator method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNRegressorEvaluator
	%
	% NNRegressorEvaluator methods (copy):
	%  copy - copies the NNRegressorEvaluator
	%  deepclone - deep-clones the NNRegressorEvaluator
	%  clone - clones the NNRegressorEvaluator
	%
	% NNRegressorEvaluator methods (inspection, Static):
	%  getClass - returns NNRegressorEvaluator
	%  getName - returns the name of NNRegressorEvaluator
	%  getDescription - returns the description of NNRegressorEvaluator
	%  getProps - returns the property list of NNRegressorEvaluator
	%  getPropNumber - returns the property number of NNRegressorEvaluator
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
	% NNRegressorEvaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorEvaluator methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNRegressorEvaluator methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNRegressorEvaluator methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNRegressorEvaluator properties (Constant).
	%  PLOT_MAP - 8
	%  PLOT_MAP_TAG - 'plot_map'
	%  PLOT_MAP_CATEGORY - 'd'
	%  PLOT_MAP_FORMAT - 'lo'
	%  RMSE - 9
	%  RMSE_TAG - 'rmse'
	%  RMSE_CATEGORY - 'r'
	%  RMSE_FORMAT - 'nn'
	%  SCATTER_PLOT - 10
	%  SCATTER_PLOT_TAG - 'scatter_plot'
	%  SCATTER_PLOT_CATEGORY - 'r'
	%  SCATTER_PLOT_FORMAT - 'nn'
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
	%  NN - 4
	%  NN_TAG - 'nn'
	%  NN_CATEGORY - 'd'
	%  NN_FORMAT - 'it'
	%  GR - 5
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  GR_PREDICTION - 6
	%  GR_PREDICTION_TAG - 'gr_prediction'
	%  GR_PREDICTION_CATEGORY - 'r'
	%  GR_PREDICTION_FORMAT - 'it'
	%  FEATURE_MAP - 7
	%  FEATURE_MAP_TAG - 'feature_map'
	%  FEATURE_MAP_CATEGORY - 'r'
	%  FEATURE_MAP_FORMAT - 'll'
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
		PLOT_MAP = NNEvaluator.getPropNumber() + 1;
		PLOT_MAP_TAG = 'plot_map';
		PLOT_MAP_CATEGORY = Category.DATA;
		PLOT_MAP_FORMAT = Format.LOGICAL;
		
		RMSE = NNEvaluator.getPropNumber() + 2;
		RMSE_TAG = 'rmse';
		RMSE_CATEGORY = Category.RESULT;
		RMSE_FORMAT = Format.SCALAR;
		
		SCATTER_PLOT = NNEvaluator.getPropNumber() + 3;
		SCATTER_PLOT_TAG = 'scatter_plot';
		SCATTER_PLOT_CATEGORY = Category.RESULT;
		SCATTER_PLOT_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function nne_class = getClass()
			%GETCLASS returns the class of the evaluator for a neural network regressor.
			%
			% CLASS = NNRegressorEvaluator.GETCLASS() returns the class 'NNRegressorEvaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the evaluator for a neural network regressor NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNRegressorEvaluator') returns 'NNRegressorEvaluator'.
			%
			% See also getName, getDescription.
			
			nne_class = 'NNRegressorEvaluator';
		end
		function nne_name = getName()
			%GETNAME returns the name of the evaluator for a neural network regressor.
			%
			% NAME = NNRegressorEvaluator.GETNAME() returns the name of the 'evaluator for a neural network regressor'.
			%  Evaluator For A Neural Network Regressor.
			%
			% Alternative forms to call this method are:
			%  NAME = NNE.GETNAME() returns the name of the evaluator for a neural network regressor NNE.
			%  NAME = Element.GETNAME(NNE) returns the name of 'NNE'.
			%  NAME = Element.GETNAME('NNRegressorEvaluator') returns the name of 'NNRegressorEvaluator'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nne_name = 'Evaluator For A Neural Network Regressor';
		end
		function nne_description = getDescription()
			%GETDESCRIPTION returns the description of the evaluator for a neural network regressor.
			%
			% STR = NNRegressorEvaluator.GETDESCRIPTION() returns the description of the 'evaluator for a neural network regressor'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNE.GETDESCRIPTION() returns the description of the evaluator for a neural network regressor NNE.
			%  STR = Element.GETDESCRIPTION(NNE) returns the description of 'NNE'.
			%  STR = Element.GETDESCRIPTION('NNRegressorEvaluator') returns the description of 'NNRegressorEvaluator'.
			%
			% See also getClass, getName.
			
			nne_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of evaluator for a neural network regressor.
			%
			% PROPS = NNRegressorEvaluator.GETPROPS() returns the property list of evaluator for a neural network regressor.
			%
			% PROPS = NNRegressorEvaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the evaluator for a neural network regressor NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNRegressorEvaluator'[, CATEGORY]) returns the property list of 'NNRegressorEvaluator'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNEvaluator.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						NNEvaluator.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						NNEvaluator.getProps(Category.DATA)
						NNRegressorEvaluator.PLOT_MAP
						];
				case Category.RESULT
					prop_list = [
						NNEvaluator.getProps(Category.RESULT)
						NNRegressorEvaluator.RMSE
						NNRegressorEvaluator.SCATTER_PLOT
						];
				case Category.FIGURE
					prop_list = [
						NNEvaluator.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						NNEvaluator.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						NNEvaluator.getProps()
						NNRegressorEvaluator.PLOT_MAP
						NNRegressorEvaluator.RMSE
						NNRegressorEvaluator.SCATTER_PLOT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of evaluator for a neural network regressor.
			%
			% N = NNRegressorEvaluator.GETPROPNUMBER() returns the property number of evaluator for a neural network regressor.
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER() returns the property number of the evaluator for a neural network regressor NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNRegressorEvaluator') returns the property number of 'NNRegressorEvaluator'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 10;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in evaluator for a neural network regressor/error.
			%
			% CHECK = NNRegressorEvaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNRegressorEvaluator, PROP) checks whether PROP exists for NNRegressorEvaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNRegressorEvaluator, PROP) throws error if PROP does NOT exist for NNRegressorEvaluator.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10 ]);
			else
				assert( ...
					NNRegressorEvaluator.existsProp(prop), ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorEvaluator.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in evaluator for a neural network regressor/error.
			%
			% CHECK = NNRegressorEvaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNRegressorEvaluator, TAG) checks whether TAG exists for NNRegressorEvaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNRegressorEvaluator, TAG) throws error if TAG does NOT exist for NNRegressorEvaluator.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressorevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map'  'plot_map'  'rmse'  'scatter_plot' };
				
				check = any(strcmpi(tag, nnregressorevaluator_tag_list));
			else
				assert( ...
					NNRegressorEvaluator.existsTag(tag), ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNRegressorEvaluator'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNRegressorEvaluator, POINTER) returns property number of POINTER of NNRegressorEvaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNRegressorEvaluator, POINTER) returns property number of POINTER of NNRegressorEvaluator.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressorevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map'  'plot_map'  'rmse'  'scatter_plot' };
				
				tag = pointer;
				NNRegressorEvaluator.existsTag(tag);
				
				prop = find(strcmpi(tag, nnregressorevaluator_tag_list));
			else % numeric
				prop = pointer;
				NNRegressorEvaluator.existsProp(prop);
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNRegressorEvaluator, POINTER) returns tag of POINTER of NNRegressorEvaluator.
			%  TAG = NNE.GETPROPTAG(NNRegressorEvaluator, POINTER) returns tag of POINTER of NNRegressorEvaluator.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNRegressorEvaluator.existsTag(tag);
			else % numeric
				prop = pointer;
				NNRegressorEvaluator.existsProp(prop);
				
				switch prop
					case NNRegressorEvaluator.PLOT_MAP
						tag = NNRegressorEvaluator.PLOT_MAP_TAG;
					case NNRegressorEvaluator.RMSE
						tag = NNRegressorEvaluator.RMSE_TAG;
					case NNRegressorEvaluator.SCATTER_PLOT
						tag = NNRegressorEvaluator.SCATTER_PLOT_TAG;
					otherwise
						tag = getPropTag@NNEvaluator(prop);
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorEvaluator, POINTER) returns category of POINTER of NNRegressorEvaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNRegressorEvaluator, POINTER) returns category of POINTER of NNRegressorEvaluator.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					prop_category = NNRegressorEvaluator.PLOT_MAP_CATEGORY;
				case NNRegressorEvaluator.RMSE
					prop_category = NNRegressorEvaluator.RMSE_CATEGORY;
				case NNRegressorEvaluator.SCATTER_PLOT
					prop_category = NNRegressorEvaluator.SCATTER_PLOT_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNEvaluator(prop);
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorEvaluator, POINTER) returns format of POINTER of NNRegressorEvaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNRegressorEvaluator, POINTER) returns format of POINTER of NNRegressorEvaluator.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					prop_format = NNRegressorEvaluator.PLOT_MAP_FORMAT;
				case NNRegressorEvaluator.RMSE
					prop_format = NNRegressorEvaluator.RMSE_FORMAT;
				case NNRegressorEvaluator.SCATTER_PLOT
					prop_format = NNRegressorEvaluator.SCATTER_PLOT_FORMAT;
				otherwise
					prop_format = getPropFormat@NNEvaluator(prop);
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorEvaluator, POINTER) returns description of POINTER of NNRegressorEvaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNRegressorEvaluator, POINTER) returns description of POINTER of NNRegressorEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					prop_description = 'PLOT_MAP (data, logical) is an option for the plot of the feature map.';
				case NNRegressorEvaluator.RMSE
					prop_description = 'RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.';
				case NNRegressorEvaluator.SCATTER_PLOT
					prop_description = 'SCATTER_PLOT (result, scalar) creates a scatter plot with circular markers at the locations specified by predictions and targets.';
				case NNRegressorEvaluator.NN
					prop_description = 'NN (data, item) is a neural network model that needs to be evaluated.';
				case NNRegressorEvaluator.GR_PREDICTION
					prop_description = 'GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.';
				otherwise
					prop_description = getPropDescription@NNEvaluator(prop);
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorEvaluator, POINTER) returns settings of POINTER of NNRegressorEvaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNRegressorEvaluator, POINTER) returns settings of POINTER of NNRegressorEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNRegressorEvaluator.RMSE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorEvaluator.SCATTER_PLOT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorEvaluator.NN
					prop_settings = 'NNRegressorDNN';
				case NNRegressorEvaluator.GR_PREDICTION
					prop_settings = 'NNGroup';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorEvaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorEvaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorEvaluator, POINTER) returns the default value of POINTER of NNRegressorEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNRegressorEvaluator, POINTER) returns the default value of POINTER of NNRegressorEvaluator.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					prop_default = false;
				case NNRegressorEvaluator.RMSE
					prop_default = Format.getFormatDefault(Format.SCALAR, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.SCATTER_PLOT
					prop_default = Format.getFormatDefault(Format.SCALAR, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.NN
					prop_default = NNRegressorDNN();
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorEvaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorEvaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorEvaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNRegressorEvaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorEvaluator.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			prop_default = NNRegressorEvaluator.conditioning(prop, NNRegressorEvaluator.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNRegressorEvaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorEvaluator.
			%  CHECK = NNE.CHECKPROP(NNRegressorEvaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorEvaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  Element.CHECKPROP(NNRegressorEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorEvaluator.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			%  NNE.CHECKPROP(NNRegressorEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorEvaluator.
			%   Error id: [BRAPH2:NNRegressorEvaluator:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorEvaluator.PLOT_MAP
					check = Format.checkFormat(Format.LOGICAL, value, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.RMSE
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.SCATTER_PLOT
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.NN
					check = Format.checkFormat(Format.ITEM, value, NNRegressorEvaluator.getPropSettings(prop));
				case NNRegressorEvaluator.GR_PREDICTION
					check = Format.checkFormat(Format.ITEM, value, NNRegressorEvaluator.getPropSettings(prop));
				otherwise
					check = checkProp@NNEvaluator(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorEvaluator.getPropTag(prop) ' (' NNRegressorEvaluator.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nne = NNRegressorEvaluator(varargin)
			% NNRegressorEvaluator() creates a evaluator for a neural network regressor.
			%
			% NNRegressorEvaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorEvaluator(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorEvaluator properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
			%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model that needs to be evaluated.
			%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
			%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
			%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
			%  <strong>8</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the feature map.
			%  <strong>9</strong> <strong>rmse</strong> 	RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.
			%  <strong>10</strong> <strong>scatter_plot</strong> 	SCATTER_PLOT (result, scalar) creates a scatter plot with circular markers at the locations specified by predictions and targets.
			%
			% See also Category, Format, set, check.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNRegressorEvaluator.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= NNEvaluator.getPropNumber()
						value = conditioning@NNEvaluator(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop)
		
			switch prop
				case NNRegressorEvaluator.RMSE
					rng(nne.getPropSeed(NNRegressorEvaluator.RMSE), 'twister')
					
					if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = 0;
					else
					    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    preds = cell2mat(preds);
					    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    targets = cell2mat(targets);
					    value = sqrt(mean((preds - targets).^2));
					end
					
				case NNRegressorEvaluator.SCATTER_PLOT
					rng(nne.getPropSeed(NNRegressorEvaluator.SCATTER_PLOT), 'twister')
					
					if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = 0;
					else
					    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    preds = cell2mat(preds);
					    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    targets = cell2mat(targets);
					    figure
					    scatter(preds, targets);
					    hold on
					    plot([min(preds) max(preds)], [min(targets) max(targets)]);
					    hold off
					    plot()
					    xlabel('Prediction')
					    ylabel('Target')
					    title('Scatter plot for regression')
					    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					    if ~exist(directory, 'dir')
					        mkdir(directory)
					    end
					    filename = [directory filesep 'roc.svg'];
					    saveas(gcf, filename);
					    value = 0;
					end
					
					
					% TODO: visulazie the feature maps for all cases
					% % % selected_idx = nne.get('NNDATA').get('FEATURE_MASK');
					% % % if length(selected_idx) == 1 && abs(selected_idx) <= 1
					% % %     selected_idx = nne.get('NNDATA').get('FEATURE_MASK_ANALYSIS');
					% % % end
					% % % if ~isempty(selected_idx)
					% % %     switch string(nne.get('NNDATA').get('INPUT_TYPE'))
					% % %         case 'graph_measures'
					% % %             feature = nne.get('NNDATA').get('MEASURES');
					% % %             fm = zeros(1, length(feature));
					% % %             x_ticklabel = feature;
					% % %             y_ticklabel = '';
					% % %             fontsize = 12;
					% % % 
					% % %         case 'adjacency_matrices'
					% % %             feature = nne.get('NNDATA').get('TRAIN_G_DICT').getItem(1).get('A');
					% % %             fm = zeros(length(feature{1}));
					% % %             x_ticklabel = 0:size(fm, 2);
					% % %             y_ticklabel = 0:size(fm, 1);
					% % %             fontsize = 5;
					% % % 
					% % %         case 'structural_data'
					% % %             data = nne.get('NNDATA').data_construction(nne.get('NNDATA').get('GR'));
					% % %             feature = data{1};
					% % %             fm = zeros(1, length(feature));
					% % %             br = nne.get('NNDATA').get('GR').get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').getItems();
					% % %             br = cellfun(@(v)v.get('ID'), br, 'UniformOutput', false);
					% % %             x_ticklabel = br;
					% % %             y_ticklabel = '';
					% % %             fontsize = 5;
					% % %         otherwise
					% % %     end
					% % % 
					% % %     fm(selected_idx) = 1;
					% % % 
					% % %     if nne.get('PLOT_MAP')
					% % %         figure
					% % %         x = [1 size(fm, 2)];
					% % %         y = [0 size(fm, 1)];
					% % %         image(x, y, fm, 'CDataMapping', 'scaled')
					% % % 
					% % %         xticks([1:size(fm, 2)]);
					% % %         yticks([1:size(fm, 1)]);
					% % %         xticklabels(x_ticklabel);
					% % %         yticklabels(y_ticklabel);
					% % %         a = get(gca,'XTickLabel');
					% % %         set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
					% % %         a = get(gca,'YTickLabel');
					% % %         set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
					% % %         colorbar
					% % %         directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					% % %         if ~exist(directory, 'dir')
					% % %             mkdir(directory)
					% % %         end
					% % %         filename = [directory filesep 'connection_mask.svg'];
					% % %         saveas(gcf, filename);
					% % %     end
					% % % 
					% % %     value = fm;
					% % % else
					% % %     value = [];
					% % % end
					
				case NNRegressorEvaluator.GR_PREDICTION
					if nne.get('GR').get('SUB_DICT').length() == 0
					    value = NNGroup();
					else
					    nn = nne.get('NN');
					    nn_gr = nne.get('GR');
					    inputs = nn.reconstruct_inputs(nn_gr);
					    net = nn.to_net(nn.get('MODEL'));
					    predictions = net.predict(inputs);
					
					    nn_gr_pred = NNGroup( ...
					        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					        );
					
					    nn_gr_pred.set( ...
					        'ID', nn_gr.get('ID'), ...
					        'LABEL', nn_gr.get('LABEL'), ...
					        'NOTES', nn_gr.get('NOTES') ...
					        );
					
					    % add subejcts
					    sub_dict = nn_gr_pred.get('SUB_DICT');
					    subs = nn_gr.get('SUB_DICT').getItems();
					    for i = 1:1:length(subs)
					        sub = subs{i}.deepclone();
					        sub.set('PREDICTION', {predictions(i)});
					        sub_dict.add(sub);
					    end
					    nn_gr_pred.set('SUB_DICT', sub_dict);
					
					    value = nn_gr_pred;
					end
					
				otherwise
					value = calculateValue@NNEvaluator(nne, prop);
					
			end
		end
	end
end
