classdef NNClassifierEvaluator < NNEvaluator
	% NNClassifierEvaluator evaluates the performance of a neural network classifier with a specific dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% 
	%
	% The list of NNClassifierEvaluator properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
	%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model that needs to be evaluated.
	%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
	%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
	%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
	%  <strong>8</strong> <strong>plot_cm</strong> 	PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
	%  <strong>9</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the feature map.
	%  <strong>10</strong> <strong>plot_roc</strong> 	PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
	%  <strong>11</strong> <strong>auc</strong> 	AUC (result, cell) is an area under the curve score.
	%  <strong>12</strong> <strong>confusion_matrix</strong> 	CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
	%
	% NNClassifierEvaluator methods (constructor):
	% NNClassifierEvaluator - constructor
	%
	% NNClassifierEvaluator methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in evaluator for a neural network classifier/error.
	%  existsProp - checks whether property exists in evaluator for a neural network classifier/error.
	%  getPropNumber - returns the property number of evaluator for a neural network classifier.
	%  getProps - returns the property list of evaluator for a neural network classifier.
	%  getDescription - returns the description of the evaluator for a neural network classifier.
	%  getName - returns the name of the evaluator for a neural network classifier.
	%  getClass - returns the class of the evaluator for a neural network classifier.
	%
	% NNClassifierEvaluator methods:
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
	% NNClassifierEvaluator methods (operators):
	%  isequal - determines whether two NNClassifierEvaluator are equal (values, locked)
	%
	% NNClassifierEvaluator methods (display):
	%  tostring - string with information about the NNClassifierEvaluator
	%  disp - displays information about the NNClassifierEvaluator
	%  tree - displays the element of NNClassifierEvaluator
	%
	% NNClassifierEvaluator method (element list):
	%  getElementList - returns a list with all subelements of NNClassifierEvaluator
	%
	% NNClassifierEvaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNClassifierEvaluator
	%
	% NNClassifierEvaluator method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNClassifierEvaluator
	%
	% NNClassifierEvaluator methods (copy):
	%  copy - copies the NNClassifierEvaluator
	%  deepclone - deep-clones the NNClassifierEvaluator
	%  clone - clones the NNClassifierEvaluator
	%
	% NNClassifierEvaluator methods (inspection, Static):
	%  getClass - returns NNClassifierEvaluator
	%  getName - returns the name of NNClassifierEvaluator
	%  getDescription - returns the description of NNClassifierEvaluator
	%  getProps - returns the property list of NNClassifierEvaluator
	%  getPropNumber - returns the property number of NNClassifierEvaluator
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
	% NNClassifierEvaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierEvaluator methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNClassifierEvaluator methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNClassifierEvaluator methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNClassifierEvaluator properties (Constant).
	%  PLOT_CM - 8
	%  PLOT_CM_TAG - 'plot_cm'
	%  PLOT_CM_CATEGORY - 'd'
	%  PLOT_CM_FORMAT - 'lo'
	%  PLOT_MAP - 9
	%  PLOT_MAP_TAG - 'plot_map'
	%  PLOT_MAP_CATEGORY - 'd'
	%  PLOT_MAP_FORMAT - 'lo'
	%  PLOT_ROC - 10
	%  PLOT_ROC_TAG - 'plot_roc'
	%  PLOT_ROC_CATEGORY - 'd'
	%  PLOT_ROC_FORMAT - 'lo'
	%  AUC - 11
	%  AUC_TAG - 'auc'
	%  AUC_CATEGORY - 'r'
	%  AUC_FORMAT - 'll'
	%  CONFUSION_MATRIX - 12
	%  CONFUSION_MATRIX_TAG - 'confusion_matrix'
	%  CONFUSION_MATRIX_CATEGORY - 'r'
	%  CONFUSION_MATRIX_FORMAT - 'nm'
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
		PLOT_CM = NNEvaluator.getPropNumber() + 1;
		PLOT_CM_TAG = 'plot_cm';
		PLOT_CM_CATEGORY = Category.DATA;
		PLOT_CM_FORMAT = Format.LOGICAL;
		
		PLOT_MAP = NNEvaluator.getPropNumber() + 2;
		PLOT_MAP_TAG = 'plot_map';
		PLOT_MAP_CATEGORY = Category.DATA;
		PLOT_MAP_FORMAT = Format.LOGICAL;
		
		PLOT_ROC = NNEvaluator.getPropNumber() + 3;
		PLOT_ROC_TAG = 'plot_roc';
		PLOT_ROC_CATEGORY = Category.DATA;
		PLOT_ROC_FORMAT = Format.LOGICAL;
		
		AUC = NNEvaluator.getPropNumber() + 4;
		AUC_TAG = 'auc';
		AUC_CATEGORY = Category.RESULT;
		AUC_FORMAT = Format.CELL;
		
		CONFUSION_MATRIX = NNEvaluator.getPropNumber() + 5;
		CONFUSION_MATRIX_TAG = 'confusion_matrix';
		CONFUSION_MATRIX_CATEGORY = Category.RESULT;
		CONFUSION_MATRIX_FORMAT = Format.MATRIX;
	end
	methods (Static) % inspection methods
		function nne_class = getClass()
			%GETCLASS returns the class of the evaluator for a neural network classifier.
			%
			% CLASS = NNClassifierEvaluator.GETCLASS() returns the class 'NNClassifierEvaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the evaluator for a neural network classifier NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNClassifierEvaluator') returns 'NNClassifierEvaluator'.
			%
			% See also getName, getDescription.
			
			nne_class = 'NNClassifierEvaluator';
		end
		function nne_name = getName()
			%GETNAME returns the name of the evaluator for a neural network classifier.
			%
			% NAME = NNClassifierEvaluator.GETNAME() returns the name of the 'evaluator for a neural network classifier'.
			%  Evaluator For A Neural Network Classifier.
			%
			% Alternative forms to call this method are:
			%  NAME = NNE.GETNAME() returns the name of the evaluator for a neural network classifier NNE.
			%  NAME = Element.GETNAME(NNE) returns the name of 'NNE'.
			%  NAME = Element.GETNAME('NNClassifierEvaluator') returns the name of 'NNClassifierEvaluator'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nne_name = 'Evaluator For A Neural Network Classifier';
		end
		function nne_description = getDescription()
			%GETDESCRIPTION returns the description of the evaluator for a neural network classifier.
			%
			% STR = NNClassifierEvaluator.GETDESCRIPTION() returns the description of the 'evaluator for a neural network classifier'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNE.GETDESCRIPTION() returns the description of the evaluator for a neural network classifier NNE.
			%  STR = Element.GETDESCRIPTION(NNE) returns the description of 'NNE'.
			%  STR = Element.GETDESCRIPTION('NNClassifierEvaluator') returns the description of 'NNClassifierEvaluator'.
			%
			% See also getClass, getName.
			
			nne_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of evaluator for a neural network classifier.
			%
			% PROPS = NNClassifierEvaluator.GETPROPS() returns the property list of evaluator for a neural network classifier.
			%
			% PROPS = NNClassifierEvaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the evaluator for a neural network classifier NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNClassifierEvaluator'[, CATEGORY]) returns the property list of 'NNClassifierEvaluator'.
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
						NNClassifierEvaluator.PLOT_CM
						NNClassifierEvaluator.PLOT_MAP
						NNClassifierEvaluator.PLOT_ROC
						];
				case Category.RESULT
					prop_list = [
						NNEvaluator.getProps(Category.RESULT)
						NNClassifierEvaluator.AUC
						NNClassifierEvaluator.CONFUSION_MATRIX
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
						NNClassifierEvaluator.PLOT_CM
						NNClassifierEvaluator.PLOT_MAP
						NNClassifierEvaluator.PLOT_ROC
						NNClassifierEvaluator.AUC
						NNClassifierEvaluator.CONFUSION_MATRIX
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of evaluator for a neural network classifier.
			%
			% N = NNClassifierEvaluator.GETPROPNUMBER() returns the property number of evaluator for a neural network classifier.
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER() returns the property number of the evaluator for a neural network classifier NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNClassifierEvaluator') returns the property number of 'NNClassifierEvaluator'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 12;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in evaluator for a neural network classifier/error.
			%
			% CHECK = NNClassifierEvaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNClassifierEvaluator, PROP) checks whether PROP exists for NNClassifierEvaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNClassifierEvaluator, PROP) throws error if PROP does NOT exist for NNClassifierEvaluator.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12 ]);
			else
				assert( ...
					NNClassifierEvaluator.existsProp(prop), ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierEvaluator.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in evaluator for a neural network classifier/error.
			%
			% CHECK = NNClassifierEvaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNClassifierEvaluator, TAG) checks whether TAG exists for NNClassifierEvaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNClassifierEvaluator, TAG) throws error if TAG does NOT exist for NNClassifierEvaluator.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifierevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map'  'plot_cm'  'plot_map'  'plot_roc'  'auc'  'confusion_matrix' };
				
				check = any(strcmpi(tag, nnclassifierevaluator_tag_list));
			else
				assert( ...
					NNClassifierEvaluator.existsTag(tag), ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNClassifierEvaluator'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierEvaluator, POINTER) returns property number of POINTER of NNClassifierEvaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNClassifierEvaluator, POINTER) returns property number of POINTER of NNClassifierEvaluator.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifierevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map'  'plot_cm'  'plot_map'  'plot_roc'  'auc'  'confusion_matrix' };
				
				tag = pointer;
				NNClassifierEvaluator.existsTag(tag);
				
				prop = find(strcmpi(tag, nnclassifierevaluator_tag_list));
			else % numeric
				prop = pointer;
				NNClassifierEvaluator.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNClassifierEvaluator, POINTER) returns tag of POINTER of NNClassifierEvaluator.
			%  TAG = NNE.GETPROPTAG(NNClassifierEvaluator, POINTER) returns tag of POINTER of NNClassifierEvaluator.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNClassifierEvaluator.existsTag(tag);
			else % numeric
				prop = pointer;
				NNClassifierEvaluator.existsProp(prop);
				
				switch prop
					case NNClassifierEvaluator.PLOT_CM
						tag = NNClassifierEvaluator.PLOT_CM_TAG;
					case NNClassifierEvaluator.PLOT_MAP
						tag = NNClassifierEvaluator.PLOT_MAP_TAG;
					case NNClassifierEvaluator.PLOT_ROC
						tag = NNClassifierEvaluator.PLOT_ROC_TAG;
					case NNClassifierEvaluator.AUC
						tag = NNClassifierEvaluator.AUC_TAG;
					case NNClassifierEvaluator.CONFUSION_MATRIX
						tag = NNClassifierEvaluator.CONFUSION_MATRIX_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierEvaluator, POINTER) returns category of POINTER of NNClassifierEvaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNClassifierEvaluator, POINTER) returns category of POINTER of NNClassifierEvaluator.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					prop_category = NNClassifierEvaluator.PLOT_CM_CATEGORY;
				case NNClassifierEvaluator.PLOT_MAP
					prop_category = NNClassifierEvaluator.PLOT_MAP_CATEGORY;
				case NNClassifierEvaluator.PLOT_ROC
					prop_category = NNClassifierEvaluator.PLOT_ROC_CATEGORY;
				case NNClassifierEvaluator.AUC
					prop_category = NNClassifierEvaluator.AUC_CATEGORY;
				case NNClassifierEvaluator.CONFUSION_MATRIX
					prop_category = NNClassifierEvaluator.CONFUSION_MATRIX_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierEvaluator, POINTER) returns format of POINTER of NNClassifierEvaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNClassifierEvaluator, POINTER) returns format of POINTER of NNClassifierEvaluator.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					prop_format = NNClassifierEvaluator.PLOT_CM_FORMAT;
				case NNClassifierEvaluator.PLOT_MAP
					prop_format = NNClassifierEvaluator.PLOT_MAP_FORMAT;
				case NNClassifierEvaluator.PLOT_ROC
					prop_format = NNClassifierEvaluator.PLOT_ROC_FORMAT;
				case NNClassifierEvaluator.AUC
					prop_format = NNClassifierEvaluator.AUC_FORMAT;
				case NNClassifierEvaluator.CONFUSION_MATRIX
					prop_format = NNClassifierEvaluator.CONFUSION_MATRIX_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierEvaluator, POINTER) returns description of POINTER of NNClassifierEvaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNClassifierEvaluator, POINTER) returns description of POINTER of NNClassifierEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					prop_description = 'PLOT_CM (data, logical) is an option for the plot of the confusion matrix.';
				case NNClassifierEvaluator.PLOT_MAP
					prop_description = 'PLOT_MAP (data, logical) is an option for the plot of the feature map.';
				case NNClassifierEvaluator.PLOT_ROC
					prop_description = 'PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.';
				case NNClassifierEvaluator.AUC
					prop_description = 'AUC (result, cell) is an area under the curve score.';
				case NNClassifierEvaluator.CONFUSION_MATRIX
					prop_description = 'CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.';
				case NNClassifierEvaluator.NN
					prop_description = 'NN (data, item) is a neural network model that needs to be evaluated.';
				case NNClassifierEvaluator.GR_PREDICTION
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierEvaluator, POINTER) returns settings of POINTER of NNClassifierEvaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNClassifierEvaluator, POINTER) returns settings of POINTER of NNClassifierEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierEvaluator.PLOT_MAP
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierEvaluator.PLOT_ROC
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierEvaluator.AUC
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierEvaluator.CONFUSION_MATRIX
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierEvaluator.NN
					prop_settings = 'NNClassifierDNN';
				case NNClassifierEvaluator.GR_PREDICTION
					prop_settings = 'NNGroup';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierEvaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierEvaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierEvaluator, POINTER) returns the default value of POINTER of NNClassifierEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNClassifierEvaluator, POINTER) returns the default value of POINTER of NNClassifierEvaluator.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					prop_default = false;
				case NNClassifierEvaluator.PLOT_MAP
					prop_default = false;
				case NNClassifierEvaluator.PLOT_ROC
					prop_default = false;
				case NNClassifierEvaluator.AUC
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.CONFUSION_MATRIX
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.NN
					prop_default = NNClassifierDNN();
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierEvaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierEvaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierEvaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNClassifierEvaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierEvaluator.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			prop_default = NNClassifierEvaluator.conditioning(prop, NNClassifierEvaluator.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierEvaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierEvaluator.
			%  CHECK = NNE.CHECKPROP(NNClassifierEvaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierEvaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  Element.CHECKPROP(NNClassifierEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierEvaluator.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			%  NNE.CHECKPROP(NNClassifierEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierEvaluator.
			%   Error id: [BRAPH2:NNClassifierEvaluator:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierEvaluator.PLOT_CM
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.PLOT_MAP
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.PLOT_ROC
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.AUC
					check = Format.checkFormat(Format.CELL, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.CONFUSION_MATRIX
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.NN
					check = Format.checkFormat(Format.ITEM, value, NNClassifierEvaluator.getPropSettings(prop));
				case NNClassifierEvaluator.GR_PREDICTION
					check = Format.checkFormat(Format.ITEM, value, NNClassifierEvaluator.getPropSettings(prop));
				otherwise
					check = checkProp@NNEvaluator(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierEvaluator.getPropTag(prop) ' (' NNClassifierEvaluator.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nne = NNClassifierEvaluator(varargin)
			% NNClassifierEvaluator() creates a evaluator for a neural network classifier.
			%
			% NNClassifierEvaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierEvaluator(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierEvaluator properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
			%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model that needs to be evaluated.
			%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
			%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
			%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
			%  <strong>8</strong> <strong>plot_cm</strong> 	PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
			%  <strong>9</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the feature map.
			%  <strong>10</strong> <strong>plot_roc</strong> 	PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
			%  <strong>11</strong> <strong>auc</strong> 	AUC (result, cell) is an area under the curve score.
			%  <strong>12</strong> <strong>confusion_matrix</strong> 	CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
			%
			% See also Category, Format, set, check.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNClassifierEvaluator.getPropProp(pointer);
			
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
				case NNClassifierEvaluator.AUC
					rng(nne.getPropSeed(NNClassifierEvaluator.AUC), 'twister')
					
					if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = {};
					else
					    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    pred = cell2mat(pred);
					    nn = nne.get('NN');
					    gr = nne.get('GR');
					    [inputs, ~] = nn.reconstruct_inputs(gr);
					    [targets, classes] = nn.reconstruct_targets(gr);
					    targets = onehotdecode(targets, classes, 1);
					    [X, Y, T, auc] = perfcurve(targets, pred(2, :), classes(2));
					    if nne.get('PLOT_ROC')
					        figure
					        plot(X, Y, 'LineWidth', 3.0, 'Color', 'Black')
					        xlabel('False positive rate')
					        ylabel('True positive rate')
					        title('ROC for Classification')
					        legend(sprintf('ROC (AU-ROC = %.2f)', auc), 'Location', 'southeast', 'FontSize', 12);
					        legend('boxoff');
					        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					        if ~exist(directory, 'dir')
					            mkdir(directory)
					        end
					        filename = [directory filesep 'roc.svg'];
					        saveas(gcf, filename);
					    end
					
					    value = {auc, X, Y};
					end
					
				case NNClassifierEvaluator.CONFUSION_MATRIX
					rng(nne.getPropSeed(NNClassifierEvaluator.CONFUSION_MATRIX), 'twister')
					
					if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = [];
					else
					    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    pred = cell2mat(pred);
					    pred = pred > 0.5;
					
					    % get ground truth
					    nn = nne.get('NN');
					    gr = nne.get('GR');
					    [inputs, ~] = nn.reconstruct_inputs(gr);
					    [targets, classes] = nn.reconstruct_targets(gr);
					    % calculate the confusion matrix
						[cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
					    if nne.get('PLOT_CM')
					        figure
					        heatmap(classes, classes, cm)
					        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					        if ~exist(directory, 'dir')
					            mkdir(directory)
					        end
					        filename = [directory filesep 'confusion_matrix.svg'];
					        saveas(gcf, filename);
					    end
					
					    value = cm;
					end
					
				case NNClassifierEvaluator.GR_PREDICTION
					if nne.get('GR').get('SUB_DICT').length() == 0
					    value = NNGroup();
					else
					    nn = nne.get('NN');
					    gr = nne.get('GR');
					    inputs = nn.reconstruct_inputs(gr);
					    net = nn.to_net(nn.get('MODEL'));
					    predictions = net.predict(inputs);
					
					    gr_pred = NNGroup( ...
					        'SUB_CLASS', gr.get('SUB_CLASS'), ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					        );
					
					    gr_pred.set( ...
					        'ID', gr.get('ID'), ...
					        'LABEL', gr.get('LABEL'), ...
					        'NOTES', gr.get('NOTES') ...
					        );
					
					    % add subejcts from all groups
					    sub_dict = gr_pred.get('SUB_DICT');
					    subs = gr.get('SUB_DICT').getItems();
					    for i = 1:1:length(subs)
					        sub = subs{i}.deepclone();
					        sub.set('PREDICTION', {predictions(i, :)});
					        sub_dict.add(sub);
					    end
					    gr_pred.set('SUB_DICT', sub_dict);
					
					    value = gr_pred;
					end
					
				otherwise
					value = calculateValue@NNEvaluator(nne, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(nne, prop, varargin)
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
				case NNClassifierEvaluator.AUC
					pr = PPNNClassifierEvaluator_AUC('EL', nne, 'PROP', NNClassifierEvaluator.AUC, varargin{:});
					
				case NNClassifierEvaluator.CONFUSION_MATRIX
					pr = PPNNClassifierEvaluator_Confusion_Matrix('EL', nne, 'PROP', NNClassifierEvaluator.CONFUSION_MATRIX, varargin{:});
					
				otherwise
					pr = getPlotProp@NNEvaluator(nne, prop, varargin{:});
					
			end
		end
	end
end
