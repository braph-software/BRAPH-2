classdef NNEvaluator < Element
	% NNEvaluator evaluates the performance of a neural network with a specific dataset.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% 
	%
	% The list of NNEvaluator properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
	%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model to be evaluated.
	%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
	%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
	%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
	%
	% NNEvaluator methods (constructor):
	% NNEvaluator - constructor
	%
	% NNEvaluator methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in evaluator for a neural network/error.
	%  existsProp - checks whether property exists in evaluator for a neural network/error.
	%  getPropNumber - returns the property number of evaluator for a neural network.
	%  getProps - returns the property list of evaluator for a neural network.
	%  getDescription - returns the description of the evaluator for a neural network.
	%  getName - returns the name of the evaluator for a neural network.
	%  getClass - returns the class of the evaluator for a neural network.
	%
	% NNEvaluator methods:
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
	% NNEvaluator methods (operators):
	%  isequal - determines whether two NNEvaluator are equal (values, locked)
	%
	% NNEvaluator methods (display):
	%  tostring - string with information about the NNEvaluator
	%  disp - displays information about the NNEvaluator
	%  tree - displays the element of NNEvaluator
	%
	% NNEvaluator method (element list):
	%  getElementList - returns a list with all subelements of NNEvaluator
	%
	% NNEvaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNEvaluator
	%
	% NNEvaluator method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNEvaluator
	%
	% NNEvaluator methods (copy):
	%  copy - copies the NNEvaluator
	%  deepclone - deep-clones the NNEvaluator
	%  clone - clones the NNEvaluator
	%
	% NNEvaluator methods (inspection, Static):
	%  getClass - returns NNEvaluator
	%  getName - returns the name of NNEvaluator
	%  getDescription - returns the description of NNEvaluator
	%  getProps - returns the property list of NNEvaluator
	%  getPropNumber - returns the property number of NNEvaluator
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
	% NNEvaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNEvaluator methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNEvaluator methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNEvaluator methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNEvaluator properties (Constant).
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
		
		NN = 4;
		NN_TAG = 'nn';
		NN_CATEGORY = Category.DATA;
		NN_FORMAT = Format.ITEM;
		
		GR = 5;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		GR_PREDICTION = 6;
		GR_PREDICTION_TAG = 'gr_prediction';
		GR_PREDICTION_CATEGORY = Category.RESULT;
		GR_PREDICTION_FORMAT = Format.ITEM;
		
		FEATURE_MAP = 7;
		FEATURE_MAP_TAG = 'feature_map';
		FEATURE_MAP_CATEGORY = Category.RESULT;
		FEATURE_MAP_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function nne_class = getClass()
			%GETCLASS returns the class of the evaluator for a neural network.
			%
			% CLASS = NNEvaluator.GETCLASS() returns the class 'NNEvaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the evaluator for a neural network NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNEvaluator') returns 'NNEvaluator'.
			%
			% See also getName, getDescription.
			
			nne_class = 'NNEvaluator';
		end
		function nne_name = getName()
			%GETNAME returns the name of the evaluator for a neural network.
			%
			% NAME = NNEvaluator.GETNAME() returns the name of the 'evaluator for a neural network'.
			%  Evaluator For A Neural Network.
			%
			% Alternative forms to call this method are:
			%  NAME = NNE.GETNAME() returns the name of the evaluator for a neural network NNE.
			%  NAME = Element.GETNAME(NNE) returns the name of 'NNE'.
			%  NAME = Element.GETNAME('NNEvaluator') returns the name of 'NNEvaluator'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nne_name = 'Evaluator For A Neural Network';
		end
		function nne_description = getDescription()
			%GETDESCRIPTION returns the description of the evaluator for a neural network.
			%
			% STR = NNEvaluator.GETDESCRIPTION() returns the description of the 'evaluator for a neural network'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNE.GETDESCRIPTION() returns the description of the evaluator for a neural network NNE.
			%  STR = Element.GETDESCRIPTION(NNE) returns the description of 'NNE'.
			%  STR = Element.GETDESCRIPTION('NNEvaluator') returns the description of 'NNEvaluator'.
			%
			% See also getClass, getName.
			
			nne_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of evaluator for a neural network.
			%
			% PROPS = NNEvaluator.GETPROPS() returns the property list of evaluator for a neural network.
			%
			% PROPS = NNEvaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the evaluator for a neural network NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNEvaluator'[, CATEGORY]) returns the property list of 'NNEvaluator'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNEvaluator.LABEL
						NNEvaluator.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNEvaluator.ID
						NNEvaluator.NN
						NNEvaluator.GR
						];
				case Category.RESULT
					prop_list = [
						NNEvaluator.GR_PREDICTION
						NNEvaluator.FEATURE_MAP
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNEvaluator.ID
						NNEvaluator.LABEL
						NNEvaluator.NOTES
						NNEvaluator.NN
						NNEvaluator.GR
						NNEvaluator.GR_PREDICTION
						NNEvaluator.FEATURE_MAP
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of evaluator for a neural network.
			%
			% N = NNEvaluator.GETPROPNUMBER() returns the property number of evaluator for a neural network.
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER() returns the property number of the evaluator for a neural network NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNEvaluator') returns the property number of 'NNEvaluator'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in evaluator for a neural network/error.
			%
			% CHECK = NNEvaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNEvaluator, PROP) checks whether PROP exists for NNEvaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNEvaluator, PROP) throws error if PROP does NOT exist for NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					NNEvaluator.existsProp(prop), ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNEvaluator.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in evaluator for a neural network/error.
			%
			% CHECK = NNEvaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNEvaluator, TAG) checks whether TAG exists for NNEvaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNEvaluator, TAG) throws error if TAG does NOT exist for NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map' };
				
				check = any(strcmpi(tag, nnevaluator_tag_list));
			else
				assert( ...
					NNEvaluator.existsTag(tag), ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNEvaluator'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNEvaluator, POINTER) returns property number of POINTER of NNEvaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNEvaluator, POINTER) returns property number of POINTER of NNEvaluator.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnevaluator_tag_list = { 'id'  'label'  'notes'  'nn'  'gr'  'gr_prediction'  'feature_map' };
				
				tag = pointer;
				NNEvaluator.existsTag(tag);
				
				prop = find(strcmpi(tag, nnevaluator_tag_list));
			else % numeric
				prop = pointer;
				NNEvaluator.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNEvaluator, POINTER) returns tag of POINTER of NNEvaluator.
			%  TAG = NNE.GETPROPTAG(NNEvaluator, POINTER) returns tag of POINTER of NNEvaluator.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNEvaluator.existsTag(tag);
			else % numeric
				prop = pointer;
				NNEvaluator.existsProp(prop);
				
				switch prop
					case NNEvaluator.ID
						tag = NNEvaluator.ID_TAG;
					case NNEvaluator.LABEL
						tag = NNEvaluator.LABEL_TAG;
					case NNEvaluator.NOTES
						tag = NNEvaluator.NOTES_TAG;
					case NNEvaluator.NN
						tag = NNEvaluator.NN_TAG;
					case NNEvaluator.GR
						tag = NNEvaluator.GR_TAG;
					case NNEvaluator.GR_PREDICTION
						tag = NNEvaluator.GR_PREDICTION_TAG;
					case NNEvaluator.FEATURE_MAP
						tag = NNEvaluator.FEATURE_MAP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNEvaluator, POINTER) returns category of POINTER of NNEvaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNEvaluator, POINTER) returns category of POINTER of NNEvaluator.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					prop_category = NNEvaluator.ID_CATEGORY;
				case NNEvaluator.LABEL
					prop_category = NNEvaluator.LABEL_CATEGORY;
				case NNEvaluator.NOTES
					prop_category = NNEvaluator.NOTES_CATEGORY;
				case NNEvaluator.NN
					prop_category = NNEvaluator.NN_CATEGORY;
				case NNEvaluator.GR
					prop_category = NNEvaluator.GR_CATEGORY;
				case NNEvaluator.GR_PREDICTION
					prop_category = NNEvaluator.GR_PREDICTION_CATEGORY;
				case NNEvaluator.FEATURE_MAP
					prop_category = NNEvaluator.FEATURE_MAP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNEvaluator, POINTER) returns format of POINTER of NNEvaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNEvaluator, POINTER) returns format of POINTER of NNEvaluator.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					prop_format = NNEvaluator.ID_FORMAT;
				case NNEvaluator.LABEL
					prop_format = NNEvaluator.LABEL_FORMAT;
				case NNEvaluator.NOTES
					prop_format = NNEvaluator.NOTES_FORMAT;
				case NNEvaluator.NN
					prop_format = NNEvaluator.NN_FORMAT;
				case NNEvaluator.GR
					prop_format = NNEvaluator.GR_FORMAT;
				case NNEvaluator.GR_PREDICTION
					prop_format = NNEvaluator.GR_PREDICTION_FORMAT;
				case NNEvaluator.FEATURE_MAP
					prop_format = NNEvaluator.FEATURE_MAP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNEvaluator, POINTER) returns description of POINTER of NNEvaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNEvaluator, POINTER) returns description of POINTER of NNEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					prop_description = 'ID (data, string) is a few-letter code for the evaluator.';
				case NNEvaluator.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the evaluator.';
				case NNEvaluator.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the evaluator.';
				case NNEvaluator.NN
					prop_description = 'NN (data, item) is a neural network model to be evaluated.';
				case NNEvaluator.GR
					prop_description = 'GR (data, item) is a group of NN subjects that the NN model will be evaluated on.';
				case NNEvaluator.GR_PREDICTION
					prop_description = 'GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.';
				case NNEvaluator.FEATURE_MAP
					prop_description = 'FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNEvaluator, POINTER) returns settings of POINTER of NNEvaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNEvaluator, POINTER) returns settings of POINTER of NNEvaluator.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNEvaluator.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNEvaluator.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNEvaluator.NN
					prop_settings = 'NNBase';
				case NNEvaluator.GR
					prop_settings = 'NNGroup';
				case NNEvaluator.GR_PREDICTION
					prop_settings = 'NNGroup';
				case NNEvaluator.FEATURE_MAP
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNEvaluator, POINTER) returns the default value of POINTER of NNEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNEvaluator, POINTER) returns the default value of POINTER of NNEvaluator.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					prop_default = Format.getFormatDefault(Format.STRING, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.GR
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.GR_PREDICTION
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.FEATURE_MAP
					prop_default = Format.getFormatDefault(Format.CELL, NNEvaluator.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNEvaluator, POINTER) returns the conditioned default value of POINTER of NNEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNEvaluator, POINTER) returns the conditioned default value of POINTER of NNEvaluator.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			prop_default = NNEvaluator.conditioning(prop, NNEvaluator.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNEvaluator, PROP, VALUE) checks VALUE format for PROP of NNEvaluator.
			%  CHECK = NNE.CHECKPROP(NNEvaluator, PROP, VALUE) checks VALUE format for PROP of NNEvaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNEvaluator:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.CHECKPROP(NNEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  NNE.CHECKPROP(NNEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.ID
					check = Format.checkFormat(Format.STRING, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.LABEL
					check = Format.checkFormat(Format.STRING, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.NOTES
					check = Format.checkFormat(Format.STRING, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.NN
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.GR
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.GR_PREDICTION
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.FEATURE_MAP
					check = Format.checkFormat(Format.CELL, value, NNEvaluator.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNEvaluator.getPropTag(prop) ' (' NNEvaluator.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nne = NNEvaluator(varargin)
			% NNEvaluator() creates a evaluator for a neural network.
			%
			% NNEvaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNEvaluator(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNEvaluator properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the evaluator.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the evaluator.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the evaluator.
			%  <strong>4</strong> <strong>nn</strong> 	NN (data, item) is a neural network model to be evaluated.
			%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
			%  <strong>6</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
			%  <strong>7</strong> <strong>feature_map</strong> 	FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
			%
			% See also Category, Format, set, check.
			
			nne = nne@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop)
		
			switch prop
				case NNEvaluator.FEATURE_MAP
					rng(nne.getPropSeed(NNEvaluator.FEATURE_MAP), 'twister')
					
					sub_dict = nne.get('GR').get('SUB_DICT');
					if sub_dict.length() == 0
					    value = {};
					else
					    value = sub_dict.getItem(1).get('FEATURE_MASK');
					end
					
				otherwise
					value = calculateValue@Element(nne, prop);
					
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
				case NNEvaluator.GR_PREDICTION
					pr = PPNNData_GR_NN('EL', nne, 'PROP', NNEvaluator.GR_PREDICTION, varargin{:});
					
				case NNEvaluator.FEATURE_MAP
					pr = PPNNEvaluator_Feature_Map('EL', nne, 'PROP', NNEvaluator.FEATURE_MAP, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(nne, prop, varargin{:});
					
			end
		end
	end
end
