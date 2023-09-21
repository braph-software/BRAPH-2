classdef NNClassifierMLP_Evaluator < NNEvaluator
	%NNClassifierMLP_Evaluator evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).
	%
	% The list of NNClassifierMLP_Evaluator properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for the classification task.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for the classification task.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.
	%  <strong>7</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network classifier.
	%  <strong>8</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
	%  <strong>9</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.
	%  <strong>10</strong> <strong>AUC</strong> 	AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.
	%  <strong>11</strong> <strong>MACRO_AUC</strong> 	MACRO_AUC (result, scalar) provides the metric of the average AUC value.
	%  <strong>12</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix.
	%  <strong>13</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
	%  <strong>14</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>15</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
	%
	% NNClassifierMLP_Evaluator methods (constructor):
	%  NNClassifierMLP_Evaluator - constructor
	%
	% NNClassifierMLP_Evaluator methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% NNClassifierMLP_Evaluator methods (display):
	%  tostring - string with information about the neural network evaluator for classification
	%  disp - displays information about the neural network evaluator for classification
	%  tree - displays the tree of the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for classification are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for classification as b2 file
	%  load - loads a BRAPH2 neural network evaluator for classification from a b2 file
	%
	% NNClassifierMLP_Evaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for classification
	%  getSubclasses - returns all subclasses of NNClassifierMLP_Evaluator
	%  getProps - returns the property list of the neural network evaluator for classification
	%  getPropNumber - returns the property number of the neural network evaluator for classification
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% NNClassifierMLP_Evaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_Evaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_Evaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_Evaluator methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_Evaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_Evaluator constants</a>.
	%
	%
	% See also NNDataPoint_CON_CLA, NNClassifierMLP.
	
	properties (Constant) % properties
		GROUND_TRUTH = 9; %CET: Computational Efficiency Trick
		GROUND_TRUTH_TAG = 'GROUND_TRUTH';
		GROUND_TRUTH_CATEGORY = 6;
		GROUND_TRUTH_FORMAT = 3;
		
		AUC = 10; %CET: Computational Efficiency Trick
		AUC_TAG = 'AUC';
		AUC_CATEGORY = 5;
		AUC_FORMAT = 12;
		
		MACRO_AUC = 11; %CET: Computational Efficiency Trick
		MACRO_AUC_TAG = 'MACRO_AUC';
		MACRO_AUC_CATEGORY = 5;
		MACRO_AUC_FORMAT = 11;
		
		C_MATRIX = 12; %CET: Computational Efficiency Trick
		C_MATRIX_TAG = 'C_MATRIX';
		C_MATRIX_CATEGORY = 5;
		C_MATRIX_FORMAT = 14;
		
		P = 13; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		PERM_SEEDS = 14; %CET: Computational Efficiency Trick
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = 5;
		PERM_SEEDS_FORMAT = 12;
		
		FEATURE_IMPORTANCE = 15; %CET: Computational Efficiency Trick
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = 5;
		FEATURE_IMPORTANCE_FORMAT = 16;
	end
	methods % constructor
		function nne = NNClassifierMLP_Evaluator(varargin)
			%NNClassifierMLP_Evaluator() creates a neural network evaluator for classification.
			%
			% NNClassifierMLP_Evaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_Evaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierMLP_Evaluator properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for the classification task.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for the classification task.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.
			%  <strong>7</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network classifier.
			%  <strong>8</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
			%  <strong>9</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.
			%  <strong>10</strong> <strong>AUC</strong> 	AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.
			%  <strong>11</strong> <strong>MACRO_AUC</strong> 	MACRO_AUC (result, scalar) provides the metric of the average AUC value.
			%  <strong>12</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix.
			%  <strong>13</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
			%  <strong>14</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>15</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
			%
			% See also Category, Format.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator for classification.
			%
			% CLASS = NNClassifierMLP_Evaluator.GETCLASS() returns the class 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for classification NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_Evaluator') returns 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNClassifierMLP_Evaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for classification.
			%
			% LIST = NNClassifierMLP_Evaluator.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for classification NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_Evaluator') returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNClassifierMLP_Evaluator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for classification.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS() returns the property list of neural network evaluator for classification
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for classification NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_Evaluator'[, CATEGORY]) returns the property list of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = [3 13];
				case 4 % Category.DATA
					prop_list = [4 7 8];
				case 5 % Category.RESULT
					prop_list = [10 11 12 14 15];
				case 6 % Category.QUERY
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for classification.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER() returns the property number of neural network evaluator for classification.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for classification
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for classification NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_Evaluator') returns the property number of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 2;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for classification/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) checks whether PROP exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) throws error if PROP does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_Evaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for classification/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) checks whether TAG exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) throws error if TAG does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'MACRO_AUC'  'C_MATRIX'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_Evaluator.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'MACRO_AUC'  'C_MATRIX'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%  TAG = NNE.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnclassifiermlp_evaluator_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'MACRO_AUC'  'C_MATRIX'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' };
				tag = nnclassifiermlp_evaluator_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_category_list = { 1  1  3  4  2  2  4  4  6  5  5  5  3  5  5 };
			prop_category = nnclassifiermlp_evaluator_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_format_list = { 2  2  8  2  2  2  8  8  3  12  11  14  11  12  16 };
			prop_format = nnclassifiermlp_evaluator_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_description_list = { 'NAME (constant, string) is the name of the neural network evaluator for the classification task.'  'DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.'  'TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.'  'ID (data, string) is a few-letter code for the neural network evaluator for the classification task.'  'LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.'  'NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.'  'NN (data, item) contains a trained neural network classifier.'  'D (data, item) is the dataset to evaluate the neural network model.'  'GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.'  'AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.'  'MACRO_AUC (result, scalar) provides the metric of the average AUC value.'  'C_MATRIX (result, matrix) provides the confusion matrix.'  'P (parameter, scalar) is the permutation number.'  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.' };
			prop_description = nnclassifiermlp_evaluator_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_settings = Format.getFormatSettings(3);
				case 10 % NNClassifierMLP_Evaluator.AUC
					prop_settings = Format.getFormatSettings(12);
				case 11 % NNClassifierMLP_Evaluator.MACRO_AUC
					prop_settings = Format.getFormatSettings(11);
				case 12 % NNClassifierMLP_Evaluator.C_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 13 % NNClassifierMLP_Evaluator.P
					prop_settings = Format.getFormatSettings(11);
				case 14 % NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_settings = Format.getFormatSettings(12);
				case 15 % NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 3 % NNClassifierMLP_Evaluator.TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator';
				case 7 % NNClassifierMLP_Evaluator.NN
					prop_settings = 'NNClassifierMLP';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_default = Format.getFormatDefault(3, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 10 % NNClassifierMLP_Evaluator.AUC
					prop_default = Format.getFormatDefault(12, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 11 % NNClassifierMLP_Evaluator.MACRO_AUC
					prop_default = Format.getFormatDefault(11, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 12 % NNClassifierMLP_Evaluator.C_MATRIX
					prop_default = Format.getFormatDefault(14, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 13 % NNClassifierMLP_Evaluator.P
					prop_default = 1e+2;
				case 14 % NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_default = Format.getFormatDefault(12, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 15 % NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 1 % NNClassifierMLP_Evaluator.NAME
					prop_default = 'NNClassifierMLP_Evaluator';
				case 2 % NNClassifierMLP_Evaluator.DESCRIPTION
					prop_default = 'A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset. NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).';
				case 3 % NNClassifierMLP_Evaluator.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 4 % NNClassifierMLP_Evaluator.ID
					prop_default = 'NNClassifierMLP_Evaluator ID';
				case 5 % NNClassifierMLP_Evaluator.LABEL
					prop_default = 'NNClassifierMLP_Evaluator label';
				case 6 % NNClassifierMLP_Evaluator.NOTES
					prop_default = 'NNClassifierMLP_Evaluator notes';
				case 7 % NNClassifierMLP_Evaluator.NN
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_Evaluator.conditioning(prop, NNClassifierMLP_Evaluator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			%  CHECK = NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			%  NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case 9 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					check = Format.checkFormat(3, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 10 % NNClassifierMLP_Evaluator.AUC
					check = Format.checkFormat(12, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 11 % NNClassifierMLP_Evaluator.MACRO_AUC
					check = Format.checkFormat(11, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 12 % NNClassifierMLP_Evaluator.C_MATRIX
					check = Format.checkFormat(14, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 13 % NNClassifierMLP_Evaluator.P
					check = Format.checkFormat(11, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 14 % NNClassifierMLP_Evaluator.PERM_SEEDS
					check = Format.checkFormat(12, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 15 % NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 3 % NNClassifierMLP_Evaluator.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 7 % NNClassifierMLP_Evaluator.NN
					check = Format.checkFormat(8, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_Evaluator.getPropTag(prop) ' (' NNClassifierMLP_Evaluator.getFormatTag(NNClassifierMLP_Evaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 9 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					targets = nne.get('D').get('TARGETS');
					if isempty(targets)
					    value = {''};
					else
					    for i = 1:length(targets)
					        value(i, :) = targets{i};
					    end
					end
					
				case 10 % NNClassifierMLP_Evaluator.AUC
					rng_settings_ = rng(); rng(nne.getPropSeed(10), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					if isempty(predictions)
					    value = [];
					else
					    class_names = nne.get('NN').get('MODEL').Layers(end).Classes;
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    value = rocNet.AUC;
					end
					
					rng(rng_settings_)
					
				case 11 % NNClassifierMLP_Evaluator.MACRO_AUC
					rng_settings_ = rng(); rng(nne.getPropSeed(11), 'twister')
					
					auc = nne.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    value = double(mean(auc));
					end
					
					rng(rng_settings_)
					
				case 12 % NNClassifierMLP_Evaluator.C_MATRIX
					rng_settings_ = rng(); rng(nne.getPropSeed(12), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					[~, maxIndices] = max(predictions, [], 2);
					predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));
					if isempty(predictions)
					    value = [];
					else
					    classNames = nne.get('NN').get('MODEL').Layers(end).Classes;
					    for i = 1:length(predictions)
					        classified(i) = classNames(predictions(i, :));
					    end
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    value = confusionmat(classified, ground_truth);
					end
					
					rng(rng_settings_)
					
				case 14 % NNClassifierMLP_Evaluator.PERM_SEEDS
					rng_settings_ = rng(); rng(nne.getPropSeed(14), 'twister')
					
					value = randi(intmax('uint32'), 1, nne.get('P'));
					
					rng(rng_settings_)
					
				case 15 % NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nne.getPropSeed(15), 'twister')
					
					all_fi = nne.get('NN').get('FEATURE_IMPORTANCE', nne.get('D'), nne.get('P'), nne.get('PERM_SEEDS'));
					if isempty(cell2mat(all_fi))
					    value = {};
					else
					    average_fi = zeros(size(all_fi{1}));
					    for i = 1:numel(all_fi)
					        % Add the current cell contents to the averageCell
					        average_fi = average_fi + all_fi{i};
					    end
					    average_fi = average_fi / numel(all_fi);
					    value = {average_fi};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@NNEvaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
end
