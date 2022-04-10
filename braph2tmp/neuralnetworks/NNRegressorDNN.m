classdef NNRegressorDNN < NNBase
	% NNRegressorDNN is a neural network regressor.
	% It is a subclass of <a href="matlab:help NNBase">NNBase</a>.
	%
	% 
	%
	% The list of NNRegressorDNN properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the neural network.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the neural network.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the neural network.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects containing the information for training the neural network.
	%  <strong>5</strong> <strong>model</strong> 	MODEL (result, cell) is a trained neural network regressor.
	%  <strong>6</strong> <strong>layers</strong> 	LAYERS (data, rvector) is a vector representing the number of neurons in each layer.
	%  <strong>7</strong> <strong>batch</strong> 	BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
	%  <strong>8</strong> <strong>epochs</strong> 	EPOCHS (data, scalar) is a maximum number of epochs.
	%  <strong>9</strong> <strong>shuffle</strong> 	SHUFFLE (data, option) is an option for data shuffling.
	%  <strong>10</strong> <strong>solver</strong> 	SOLVER (data, option) is an option for the solver.
	%  <strong>11</strong> <strong>verbose</strong> 	VERBOSE (data, logical) is an indicator to display trining progress information.
	%  <strong>12</strong> <strong>plot_training</strong> 	PLOT_TRAINING (data, logical) is an option for the plot of training-progress.
	%  <strong>13</strong> <strong>plot_layers</strong> 	PLOT_LAYERS (data, logical) is an option for the plot of the layers.
	%  <strong>14</strong> <strong>input_format</strong> 	INPUT_FORMAT (data, string) is the data format of network inputs.
	%
	% NNRegressorDNN methods (constructor):
	% NNRegressorDNN - constructor
	%
	% NNRegressorDNN methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in regressor with dense layers/error.
	%  existsProp - checks whether property exists in regressor with dense layers/error.
	%  getPropNumber - returns the property number of regressor with dense layers.
	%  getProps - returns the property list of regressor with dense layers.
	%  getDescription - returns the description of the regressor with dense layers.
	%  getName - returns the name of the regressor with dense layers.
	%  getClass - returns the class of the regressor with dense layers.
	%
	% NNRegressorDNN methods:
	%  reconstruct_targets - reconstructs the targets for NN
	%  reconstruct_inputs - reconstructs the inputs for NN
	%  to_net - transforms the saved neural network
	%  getPlotProp - returns a prop plot.
	%  from_net - saves the newtork object as the binary format in braph.
	%  check_nn_toolboxes - checks whether the deep-learning-required toolboxes are installed.
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
	% NNRegressorDNN methods (operators):
	%  isequal - determines whether two NNRegressorDNN are equal (values, locked)
	%
	% NNRegressorDNN methods (display):
	%  tostring - string with information about the NNRegressorDNN
	%  disp - displays information about the NNRegressorDNN
	%  tree - displays the element of NNRegressorDNN
	%
	% NNRegressorDNN method (element list):
	%  getElementList - returns a list with all subelements of NNRegressorDNN
	%
	% NNRegressorDNN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNRegressorDNN
	%
	% NNRegressorDNN method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNRegressorDNN
	%
	% NNRegressorDNN methods (copy):
	%  copy - copies the NNRegressorDNN
	%  deepclone - deep-clones the NNRegressorDNN
	%  clone - clones the NNRegressorDNN
	%
	% NNRegressorDNN methods (inspection, Static):
	%  getClass - returns NNRegressorDNN
	%  getName - returns the name of NNRegressorDNN
	%  getDescription - returns the description of NNRegressorDNN
	%  getProps - returns the property list of NNRegressorDNN
	%  getPropNumber - returns the property number of NNRegressorDNN
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
	% NNRegressorDNN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorDNN methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNRegressorDNN methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNRegressorDNN methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNRegressorDNN properties (Constant).
	%  LAYERS - 6
	%  LAYERS_TAG - 'layers'
	%  LAYERS_CATEGORY - 'd'
	%  LAYERS_FORMAT - 'nr'
	%  BATCH - 7
	%  BATCH_TAG - 'batch'
	%  BATCH_CATEGORY - 'd'
	%  BATCH_FORMAT - 'nn'
	%  EPOCHS - 8
	%  EPOCHS_TAG - 'epochs'
	%  EPOCHS_CATEGORY - 'd'
	%  EPOCHS_FORMAT - 'nn'
	%  SHUFFLE - 9
	%  SHUFFLE_TAG - 'shuffle'
	%  SHUFFLE_CATEGORY - 'd'
	%  SHUFFLE_FORMAT - 'op'
	%  SOLVER - 10
	%  SOLVER_TAG - 'solver'
	%  SOLVER_CATEGORY - 'd'
	%  SOLVER_FORMAT - 'op'
	%  VERBOSE - 11
	%  VERBOSE_TAG - 'verbose'
	%  VERBOSE_CATEGORY - 'd'
	%  VERBOSE_FORMAT - 'lo'
	%  PLOT_TRAINING - 12
	%  PLOT_TRAINING_TAG - 'plot_training'
	%  PLOT_TRAINING_CATEGORY - 'd'
	%  PLOT_TRAINING_FORMAT - 'lo'
	%  PLOT_LAYERS - 13
	%  PLOT_LAYERS_TAG - 'plot_layers'
	%  PLOT_LAYERS_CATEGORY - 'd'
	%  PLOT_LAYERS_FORMAT - 'lo'
	%  INPUT_FORMAT - 14
	%  INPUT_FORMAT_TAG - 'input_format'
	%  INPUT_FORMAT_CATEGORY - 'd'
	%  INPUT_FORMAT_FORMAT - 'st'
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
	%  MODEL - 5
	%  MODEL_TAG - 'model'
	%  MODEL_CATEGORY - 'r'
	%  MODEL_FORMAT - 'll'
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
		LAYERS = NNBase.getPropNumber() + 1;
		LAYERS_TAG = 'layers';
		LAYERS_CATEGORY = Category.DATA;
		LAYERS_FORMAT = Format.RVECTOR;
		
		BATCH = NNBase.getPropNumber() + 2;
		BATCH_TAG = 'batch';
		BATCH_CATEGORY = Category.DATA;
		BATCH_FORMAT = Format.SCALAR;
		
		EPOCHS = NNBase.getPropNumber() + 3;
		EPOCHS_TAG = 'epochs';
		EPOCHS_CATEGORY = Category.DATA;
		EPOCHS_FORMAT = Format.SCALAR;
		
		SHUFFLE = NNBase.getPropNumber() + 4;
		SHUFFLE_TAG = 'shuffle';
		SHUFFLE_CATEGORY = Category.DATA;
		SHUFFLE_FORMAT = Format.OPTION;
		
		SOLVER = NNBase.getPropNumber() + 5;
		SOLVER_TAG = 'solver';
		SOLVER_CATEGORY = Category.DATA;
		SOLVER_FORMAT = Format.OPTION;
		
		VERBOSE = NNBase.getPropNumber() + 6;
		VERBOSE_TAG = 'verbose';
		VERBOSE_CATEGORY = Category.DATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		PLOT_TRAINING = NNBase.getPropNumber() + 7;
		PLOT_TRAINING_TAG = 'plot_training';
		PLOT_TRAINING_CATEGORY = Category.DATA;
		PLOT_TRAINING_FORMAT = Format.LOGICAL;
		
		PLOT_LAYERS = NNBase.getPropNumber() + 8;
		PLOT_LAYERS_TAG = 'plot_layers';
		PLOT_LAYERS_CATEGORY = Category.DATA;
		PLOT_LAYERS_FORMAT = Format.LOGICAL;
		
		INPUT_FORMAT = NNBase.getPropNumber() + 9;
		INPUT_FORMAT_TAG = 'input_format';
		INPUT_FORMAT_CATEGORY = Category.DATA;
		INPUT_FORMAT_FORMAT = Format.STRING;
	end
	methods (Static) % inspection methods
		function nn_class = getClass()
			%GETCLASS returns the class of the regressor with dense layers.
			%
			% CLASS = NNRegressorDNN.GETCLASS() returns the class 'NNRegressorDNN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the regressor with dense layers NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNRegressorDNN') returns 'NNRegressorDNN'.
			%
			% See also getName, getDescription.
			
			nn_class = 'NNRegressorDNN';
		end
		function nn_name = getName()
			%GETNAME returns the name of the regressor with dense layers.
			%
			% NAME = NNRegressorDNN.GETNAME() returns the name of the 'regressor with dense layers'.
			%  Regressor With Dense Layers.
			%
			% Alternative forms to call this method are:
			%  NAME = NN.GETNAME() returns the name of the regressor with dense layers NN.
			%  NAME = Element.GETNAME(NN) returns the name of 'NN'.
			%  NAME = Element.GETNAME('NNRegressorDNN') returns the name of 'NNRegressorDNN'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nn_name = 'Regressor With Dense Layers';
		end
		function nn_description = getDescription()
			%GETDESCRIPTION returns the description of the regressor with dense layers.
			%
			% STR = NNRegressorDNN.GETDESCRIPTION() returns the description of the 'regressor with dense layers'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NN.GETDESCRIPTION() returns the description of the regressor with dense layers NN.
			%  STR = Element.GETDESCRIPTION(NN) returns the description of 'NN'.
			%  STR = Element.GETDESCRIPTION('NNRegressorDNN') returns the description of 'NNRegressorDNN'.
			%
			% See also getClass, getName.
			
			nn_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of regressor with dense layers.
			%
			% PROPS = NNRegressorDNN.GETPROPS() returns the property list of regressor with dense layers.
			%
			% PROPS = NNRegressorDNN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the regressor with dense layers NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNRegressorDNN'[, CATEGORY]) returns the property list of 'NNRegressorDNN'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNBase.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						NNBase.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						NNBase.getProps(Category.DATA)
						NNRegressorDNN.LAYERS
						NNRegressorDNN.BATCH
						NNRegressorDNN.EPOCHS
						NNRegressorDNN.SHUFFLE
						NNRegressorDNN.SOLVER
						NNRegressorDNN.VERBOSE
						NNRegressorDNN.PLOT_TRAINING
						NNRegressorDNN.PLOT_LAYERS
						NNRegressorDNN.INPUT_FORMAT
						];
				case Category.RESULT
					prop_list = [
						NNBase.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						NNBase.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						NNBase.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						NNBase.getProps()
						NNRegressorDNN.LAYERS
						NNRegressorDNN.BATCH
						NNRegressorDNN.EPOCHS
						NNRegressorDNN.SHUFFLE
						NNRegressorDNN.SOLVER
						NNRegressorDNN.VERBOSE
						NNRegressorDNN.PLOT_TRAINING
						NNRegressorDNN.PLOT_LAYERS
						NNRegressorDNN.INPUT_FORMAT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of regressor with dense layers.
			%
			% N = NNRegressorDNN.GETPROPNUMBER() returns the property number of regressor with dense layers.
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER() returns the property number of the regressor with dense layers NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNRegressorDNN') returns the property number of 'NNRegressorDNN'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 14;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in regressor with dense layers/error.
			%
			% CHECK = NNRegressorDNN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNRegressorDNN, PROP) checks whether PROP exists for NNRegressorDNN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  Element.EXISTSPROP(NNRegressorDNN, PROP) throws error if PROP does NOT exist for NNRegressorDNN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14 ]);
			else
				assert( ...
					NNRegressorDNN.existsProp(prop), ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorDNN.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in regressor with dense layers/error.
			%
			% CHECK = NNRegressorDNN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNRegressorDNN, TAG) checks whether TAG exists for NNRegressorDNN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  Element.EXISTSTAG(NNRegressorDNN, TAG) throws error if TAG does NOT exist for NNRegressorDNN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressordnn_tag_list = { 'id'  'label'  'notes'  'gr'  'model'  'layers'  'batch'  'epochs'  'shuffle'  'solver'  'verbose'  'plot_training'  'plot_layers'  'input_format' };
				
				check = any(strcmpi(tag, nnregressordnn_tag_list));
			else
				assert( ...
					NNRegressorDNN.existsTag(tag), ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNRegressorDNN'] ...
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
			%  PROPERTY = NN.GETPROPPROP(POINTER) returns property number of POINTER of NN.
			%  PROPERTY = Element.GETPROPPROP(NNRegressorDNN, POINTER) returns property number of POINTER of NNRegressorDNN.
			%  PROPERTY = NN.GETPROPPROP(NNRegressorDNN, POINTER) returns property number of POINTER of NNRegressorDNN.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnregressordnn_tag_list = { 'id'  'label'  'notes'  'gr'  'model'  'layers'  'batch'  'epochs'  'shuffle'  'solver'  'verbose'  'plot_training'  'plot_layers'  'input_format' };
				
				tag = pointer;
				NNRegressorDNN.existsTag(tag);
				
				prop = find(strcmpi(tag, nnregressordnn_tag_list));
			else % numeric
				prop = pointer;
				NNRegressorDNN.existsProp(prop);
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
			%  TAG = NN.GETPROPTAG(POINTER) returns tag of POINTER of NN.
			%  TAG = Element.GETPROPTAG(NNRegressorDNN, POINTER) returns tag of POINTER of NNRegressorDNN.
			%  TAG = NN.GETPROPTAG(NNRegressorDNN, POINTER) returns tag of POINTER of NNRegressorDNN.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNRegressorDNN.existsTag(tag);
			else % numeric
				prop = pointer;
				NNRegressorDNN.existsProp(prop);
				
				switch prop
					case NNRegressorDNN.LAYERS
						tag = NNRegressorDNN.LAYERS_TAG;
					case NNRegressorDNN.BATCH
						tag = NNRegressorDNN.BATCH_TAG;
					case NNRegressorDNN.EPOCHS
						tag = NNRegressorDNN.EPOCHS_TAG;
					case NNRegressorDNN.SHUFFLE
						tag = NNRegressorDNN.SHUFFLE_TAG;
					case NNRegressorDNN.SOLVER
						tag = NNRegressorDNN.SOLVER_TAG;
					case NNRegressorDNN.VERBOSE
						tag = NNRegressorDNN.VERBOSE_TAG;
					case NNRegressorDNN.PLOT_TRAINING
						tag = NNRegressorDNN.PLOT_TRAINING_TAG;
					case NNRegressorDNN.PLOT_LAYERS
						tag = NNRegressorDNN.PLOT_LAYERS_TAG;
					case NNRegressorDNN.INPUT_FORMAT
						tag = NNRegressorDNN.INPUT_FORMAT_TAG;
					otherwise
						tag = getPropTag@NNBase(prop);
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
			%  CATEGORY = NN.GETPROPCATEGORY(POINTER) returns category of POINTER of NN.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorDNN, POINTER) returns category of POINTER of NNRegressorDNN.
			%  CATEGORY = NN.GETPROPCATEGORY(NNRegressorDNN, POINTER) returns category of POINTER of NNRegressorDNN.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					prop_category = NNRegressorDNN.LAYERS_CATEGORY;
				case NNRegressorDNN.BATCH
					prop_category = NNRegressorDNN.BATCH_CATEGORY;
				case NNRegressorDNN.EPOCHS
					prop_category = NNRegressorDNN.EPOCHS_CATEGORY;
				case NNRegressorDNN.SHUFFLE
					prop_category = NNRegressorDNN.SHUFFLE_CATEGORY;
				case NNRegressorDNN.SOLVER
					prop_category = NNRegressorDNN.SOLVER_CATEGORY;
				case NNRegressorDNN.VERBOSE
					prop_category = NNRegressorDNN.VERBOSE_CATEGORY;
				case NNRegressorDNN.PLOT_TRAINING
					prop_category = NNRegressorDNN.PLOT_TRAINING_CATEGORY;
				case NNRegressorDNN.PLOT_LAYERS
					prop_category = NNRegressorDNN.PLOT_LAYERS_CATEGORY;
				case NNRegressorDNN.INPUT_FORMAT
					prop_category = NNRegressorDNN.INPUT_FORMAT_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNBase(prop);
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
			%  FORMAT = NN.GETPROPFORMAT(POINTER) returns format of POINTER of NN.
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorDNN, POINTER) returns format of POINTER of NNRegressorDNN.
			%  FORMAT = NN.GETPROPFORMAT(NNRegressorDNN, POINTER) returns format of POINTER of NNRegressorDNN.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					prop_format = NNRegressorDNN.LAYERS_FORMAT;
				case NNRegressorDNN.BATCH
					prop_format = NNRegressorDNN.BATCH_FORMAT;
				case NNRegressorDNN.EPOCHS
					prop_format = NNRegressorDNN.EPOCHS_FORMAT;
				case NNRegressorDNN.SHUFFLE
					prop_format = NNRegressorDNN.SHUFFLE_FORMAT;
				case NNRegressorDNN.SOLVER
					prop_format = NNRegressorDNN.SOLVER_FORMAT;
				case NNRegressorDNN.VERBOSE
					prop_format = NNRegressorDNN.VERBOSE_FORMAT;
				case NNRegressorDNN.PLOT_TRAINING
					prop_format = NNRegressorDNN.PLOT_TRAINING_FORMAT;
				case NNRegressorDNN.PLOT_LAYERS
					prop_format = NNRegressorDNN.PLOT_LAYERS_FORMAT;
				case NNRegressorDNN.INPUT_FORMAT
					prop_format = NNRegressorDNN.INPUT_FORMAT_FORMAT;
				otherwise
					prop_format = getPropFormat@NNBase(prop);
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
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorDNN, POINTER) returns description of POINTER of NNRegressorDNN.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNRegressorDNN, POINTER) returns description of POINTER of NNRegressorDNN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					prop_description = 'LAYERS (data, rvector) is a vector representing the number of neurons in each layer.';
				case NNRegressorDNN.BATCH
					prop_description = 'BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.';
				case NNRegressorDNN.EPOCHS
					prop_description = 'EPOCHS (data, scalar) is a maximum number of epochs.';
				case NNRegressorDNN.SHUFFLE
					prop_description = 'SHUFFLE (data, option) is an option for data shuffling.';
				case NNRegressorDNN.SOLVER
					prop_description = 'SOLVER (data, option) is an option for the solver.';
				case NNRegressorDNN.VERBOSE
					prop_description = 'VERBOSE (data, logical) is an indicator to display trining progress information.';
				case NNRegressorDNN.PLOT_TRAINING
					prop_description = 'PLOT_TRAINING (data, logical) is an option for the plot of training-progress.';
				case NNRegressorDNN.PLOT_LAYERS
					prop_description = 'PLOT_LAYERS (data, logical) is an option for the plot of the layers.';
				case NNRegressorDNN.INPUT_FORMAT
					prop_description = 'INPUT_FORMAT (data, string) is the data format of network inputs.';
				case NNRegressorDNN.MODEL
					prop_description = 'MODEL (result, cell) is a trained neural network regressor.';
				otherwise
					prop_description = getPropDescription@NNBase(prop);
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
			%  SETTINGS = NN.GETPROPSETTINGS(POINTER) returns settings of POINTER of NN.
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorDNN, POINTER) returns settings of POINTER of NNRegressorDNN.
			%  SETTINGS = NN.GETPROPSETTINGS(NNRegressorDNN, POINTER) returns settings of POINTER of NNRegressorDNN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorDNN.BATCH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorDNN.EPOCHS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorDNN.SHUFFLE
					prop_settings = {'once' 'never' 'every-epoch'};
				case NNRegressorDNN.SOLVER
					prop_settings = {'adam' 'sgdm' 'rmsprop'};
				case NNRegressorDNN.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNRegressorDNN.PLOT_TRAINING
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNRegressorDNN.PLOT_LAYERS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNRegressorDNN.INPUT_FORMAT
					prop_settings = Format.getFormatSettings(Format.STRING);
				otherwise
					prop_settings = getPropSettings@NNBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorDNN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorDNN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorDNN, POINTER) returns the default value of POINTER of NNRegressorDNN.
			%  DEFAULT = NN.GETPROPDEFAULT(NNRegressorDNN, POINTER) returns the default value of POINTER of NNRegressorDNN.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					prop_default = [];
				case NNRegressorDNN.BATCH
					prop_default = 4;
				case NNRegressorDNN.EPOCHS
					prop_default = 200;
				case NNRegressorDNN.SHUFFLE
					prop_default = Format.getFormatDefault(Format.OPTION, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.SOLVER
					prop_default = Format.getFormatDefault(Format.OPTION, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.VERBOSE
					prop_default = false;
				case NNRegressorDNN.PLOT_TRAINING
					prop_default = true;
				case NNRegressorDNN.PLOT_LAYERS
					prop_default = false;
				case NNRegressorDNN.INPUT_FORMAT
					prop_default = 'BCSS';
				otherwise
					prop_default = getPropDefault@NNBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorDNN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorDNN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorDNN, POINTER) returns the conditioned default value of POINTER of NNRegressorDNN.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNRegressorDNN, POINTER) returns the conditioned default value of POINTER of NNRegressorDNN.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			prop_default = NNRegressorDNN.conditioning(prop, NNRegressorDNN.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NN.
			%  CHECK = Element.CHECKPROP(NNRegressorDNN, PROP, VALUE) checks VALUE format for PROP of NNRegressorDNN.
			%  CHECK = NN.CHECKPROP(NNRegressorDNN, PROP, VALUE) checks VALUE format for PROP of NNRegressorDNN.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  Element.CHECKPROP(NNRegressorDNN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorDNN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			%  NN.CHECKPROP(NNRegressorDNN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorDNN.
			%   Error id: [BRAPH2:NNRegressorDNN:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				case NNRegressorDNN.LAYERS
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.BATCH
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.EPOCHS
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.SHUFFLE
					check = Format.checkFormat(Format.OPTION, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.SOLVER
					check = Format.checkFormat(Format.OPTION, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.VERBOSE
					check = Format.checkFormat(Format.LOGICAL, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.PLOT_TRAINING
					check = Format.checkFormat(Format.LOGICAL, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.PLOT_LAYERS
					check = Format.checkFormat(Format.LOGICAL, value, NNRegressorDNN.getPropSettings(prop));
				case NNRegressorDNN.INPUT_FORMAT
					check = Format.checkFormat(Format.STRING, value, NNRegressorDNN.getPropSettings(prop));
				otherwise
					check = checkProp@NNBase(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorDNN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorDNN.getPropTag(prop) ' (' NNRegressorDNN.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nn = NNRegressorDNN(varargin)
			% NNRegressorDNN() creates a regressor with dense layers.
			%
			% NNRegressorDNN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorDNN(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorDNN properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the neural network.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the neural network.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the neural network.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects containing the information for training the neural network.
			%  <strong>5</strong> <strong>model</strong> 	MODEL (result, cell) is a trained neural network regressor.
			%  <strong>6</strong> <strong>layers</strong> 	LAYERS (data, rvector) is a vector representing the number of neurons in each layer.
			%  <strong>7</strong> <strong>batch</strong> 	BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
			%  <strong>8</strong> <strong>epochs</strong> 	EPOCHS (data, scalar) is a maximum number of epochs.
			%  <strong>9</strong> <strong>shuffle</strong> 	SHUFFLE (data, option) is an option for data shuffling.
			%  <strong>10</strong> <strong>solver</strong> 	SOLVER (data, option) is an option for the solver.
			%  <strong>11</strong> <strong>verbose</strong> 	VERBOSE (data, logical) is an indicator to display trining progress information.
			%  <strong>12</strong> <strong>plot_training</strong> 	PLOT_TRAINING (data, logical) is an option for the plot of training-progress.
			%  <strong>13</strong> <strong>plot_layers</strong> 	PLOT_LAYERS (data, logical) is an option for the plot of the layers.
			%  <strong>14</strong> <strong>input_format</strong> 	INPUT_FORMAT (data, string) is the data format of network inputs.
			%
			% See also Category, Format, set, check.
			
			nn = nn@NNBase(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNRegressorDNN.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= NNBase.getPropNumber()
						value = conditioning@NNBase(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nn, prop)
			switch prop
				case NNRegressorDNN.LAYERS
					if isempty(nn.get('LAYERS'))
					    if nn.get('GR').get('SUB_DICT').length() > 0
					        [inputs, num_features] = nn.reconstruct_inputs(nn.get('GR'));
					        value = [floor(1.5 * num_features) floor(1.5 * num_features)];
					        nn.set('LAYERS', value);
					    end
					end
					
				otherwise
					postprocessing@NNBase(nn, prop);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nn, prop)
		
			switch prop
				case NNRegressorDNN.MODEL
					if nn.check_nn_toolboxes()
					    % get inputs
					    nn_gr = nn.get('GR');
					    if nn_gr.get('SUB_DICT').length() == 0
					        value = {};
					    else
					        [inputs, num_features] = nn.reconstruct_inputs(nn_gr);
					        [targets, classes] = nn.reconstruct_targets(nn_gr);
					        
					        % init layers
					        numLayer = nn.get('LAYERS');
					        layers = [imageInputLayer([1 1 num_features], 'Name', 'input')];
					        for i = 1:1:length(numLayer)
					            layers = [layers
					                fullyConnectedLayer(numLayer(i), 'Name', ['fc' num2str(i)])
					                batchNormalizationLayer('Name', ['batchNormalization' num2str(i)])
					                ];
					        end
					        layers = [layers
					            reluLayer('Name', 'relu1')
					            fullyConnectedLayer(1, 'Name', 'fc_output')
					            regressionLayer('Name', 'output')
					            ];
					
					        % plot layers
					        if nn.get('PLOT_LAYERS')
					            lgraph = layerGraph(layers);
					            figure
					            plot(lgraph)
					        end
					
					        % specify trianing parameters
					        if nn.get('PLOT_TRAINING')
					            plot_training = 'training-progress';
					        else
					            plot_training = 'none';
					        end
					
					        options = trainingOptions(nn.get('SOLVER'), ...
					            'MiniBatchSize', nn.get('BATCH'), ...
					            'MaxEpochs', nn.get('EPOCHS'), ...
					            'Shuffle', nn.get('SHUFFLE'), ...
					            'Plots', plot_training, ...
					            'Verbose', nn.get('VERBOSE'));
					
					        % train the neural network
					        net = trainNetwork(inputs, targets, layers, options);
					
					        % transform the net object to a cell
					        value = nn.from_net(net);
					    end
					    
					else
					    value = {};
					end
					
				otherwise
					value = calculateValue@NNBase(nn, prop);
					
			end
		end
	end
	methods % methods
		function net = to_net(nn, saved_nn)
		    %TO_NET transforms the saved neural network 
		    % in braph to a build-in object in matlab.
		    %
		    % NET = TO_NET(NN) transforms the saved neural network in braph
		    %  to a build-in object in matlab. Firstly the saved neural network
		    %  in braph is exported as an ONNX file, and then the file is 
		    %  imported as a build-in neural network object in matlab.
		    %  Typically, this method is called internally when a saved neural 
		    %  network model is evaluated by a test data.
		    
		    net = to_net@NNBase(nn, saved_nn, nn.get('INPUT_FORMAT'), "regression");
		end
		function [inputs, num_features] = reconstruct_inputs(nn, gr)
		%RECONSTRUCT_INPUTS reconstructs the inputs for NN
		%
		% [INPUTS, NUM_FEATURES] = RECONSTRUCT_INPUTS(NN, NN_GR) reconstructs the
		%   inputs from NN group. According to the tyep of this fully-connected NN,
		%   this function will flatten the input into a vector for each datapoint
		%   and return the number of features for input layer as well.
		
		    if gr.get('SUB_DICT').length() == 0
		        inputs = [];
		        num_features = 0;
		    else
		        mask = gr.get('SUB_DICT').getItem(1).get('FEATURE_MASK');
		        inputs = [];
		        inputs_tmp = gr.get('INPUTS');
		        for i = 1:1:gr.get('SUB_DICT').length()
		            input = inputs_tmp{i};
		            input_per_sub = cellfun(@(x, y) x(y == 1), input, mask, 'UniformOutput', false);
		            input_per_sub = cell2mat(input_per_sub');
		            inputs = [inputs input_per_sub];
		        end
		        num_features = length(inputs(:, 1));
		        inputs = reshape(inputs, [1, 1, num_features, gr.get('SUB_DICT').length()]);
		    end
		end
		function [targets, classes] = reconstruct_targets(nn, gr)
		%RECONSTRUCT_INPUTS reconstructs the targets for NN
		%
		% [TARGETS, CLASSES] = RECONSTRUCT_TARGETS(NN, GR) reconstructs the targets
		%  from NN group, by concatenating the target of NN Subjects.
		%  CLASSES is the categories name of the targets.
		    
		    if gr.get('SUB_DICT').length() == 0
		        targets = [];
		        classes = [];
		    else
		        targets = gr.get('TARGETS');
		        targets = cellfun(@(x) cell2mat(x),targets, 'UniformOutput', false);
		        targets = cell2mat(targets);
		        targets = targets';
		        classes = categories(categorical(cellfun(@(x) x.get('TARGET_NAME'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false)));
		    end
		end
	end
	methods % GUI
		function pr = getPlotProp(nn, prop, varargin)
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
				case NNRegressorDNN.LAYERS
					pr = PlotPropSmartVector('EL', nn, 'PROP', NNRegressorDNN.LAYERS, 'MAX', 100000, 'MIN', 1, varargin{:});
					
				otherwise
					pr = getPlotProp@NNBase(nn, prop, varargin{:});
					
			end
		end
	end
end
