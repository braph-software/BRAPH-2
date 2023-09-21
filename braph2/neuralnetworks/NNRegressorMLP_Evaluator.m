classdef NNRegressorMLP_Evaluator < NNEvaluator
	%NNRegressorMLP_Evaluator evaluates the performance of a multi-layer perceptron regressor with a given dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset.
	% NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).
	%
	% The list of NNRegressorMLP_Evaluator properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for the regression task.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for the regression task.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.
	%  <strong>7</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network regressor.
	%  <strong>8</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
	%  <strong>9</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, matrix) returns the matrix of ground truth derived from the targets.
	%  <strong>10</strong> <strong>CORR</strong> 	CORR (result, rvector) provides the metric of the correlation of coefficients.
	%  <strong>11</strong> <strong>DET</strong> 	DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
	%  <strong>12</strong> <strong>MAE</strong> 	MAE (result, rvector) provides the metric of the mean absolute error.
	%  <strong>13</strong> <strong>MSE</strong> 	MSE (result, rvector) provides the metric of the mean squared error.
	%  <strong>14</strong> <strong>RMSE</strong> 	RMSE (result, rvector) provides the metric of the root mean squared error.
	%  <strong>15</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
	%  <strong>16</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>17</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
	%
	% NNRegressorMLP_Evaluator methods (constructor):
	%  NNRegressorMLP_Evaluator - constructor
	%
	% NNRegressorMLP_Evaluator methods:
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
	% NNRegressorMLP_Evaluator methods (display):
	%  tostring - string with information about the neural network evaluator for regressor
	%  disp - displays information about the neural network evaluator for regressor
	%  tree - displays the tree of the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for regressor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for regressor as b2 file
	%  load - loads a BRAPH2 neural network evaluator for regressor from a b2 file
	%
	% NNRegressorMLP_Evaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for regressor
	%  getSubclasses - returns all subclasses of NNRegressorMLP_Evaluator
	%  getProps - returns the property list of the neural network evaluator for regressor
	%  getPropNumber - returns the property number of the neural network evaluator for regressor
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
	% NNRegressorMLP_Evaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_Evaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_Evaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_Evaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_Evaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_Evaluator constants</a>.
	%
	%
	% See also NNDataPoint_CON_REG, NNRegressorMLP.
	
	properties (Constant) % properties
		GROUND_TRUTH = 9; %CET: Computational Efficiency Trick
		GROUND_TRUTH_TAG = 'GROUND_TRUTH';
		GROUND_TRUTH_CATEGORY = 6;
		GROUND_TRUTH_FORMAT = 14;
		
		CORR = 10; %CET: Computational Efficiency Trick
		CORR_TAG = 'CORR';
		CORR_CATEGORY = 5;
		CORR_FORMAT = 12;
		
		DET = 11; %CET: Computational Efficiency Trick
		DET_TAG = 'DET';
		DET_CATEGORY = 5;
		DET_FORMAT = 12;
		
		MAE = 12; %CET: Computational Efficiency Trick
		MAE_TAG = 'MAE';
		MAE_CATEGORY = 5;
		MAE_FORMAT = 12;
		
		MSE = 13; %CET: Computational Efficiency Trick
		MSE_TAG = 'MSE';
		MSE_CATEGORY = 5;
		MSE_FORMAT = 12;
		
		RMSE = 14; %CET: Computational Efficiency Trick
		RMSE_TAG = 'RMSE';
		RMSE_CATEGORY = 5;
		RMSE_FORMAT = 12;
		
		P = 15; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		PERM_SEEDS = 16; %CET: Computational Efficiency Trick
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = 5;
		PERM_SEEDS_FORMAT = 12;
		
		FEATURE_IMPORTANCE = 17; %CET: Computational Efficiency Trick
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = 5;
		FEATURE_IMPORTANCE_FORMAT = 16;
	end
	methods % constructor
		function nne = NNRegressorMLP_Evaluator(varargin)
			%NNRegressorMLP_Evaluator() creates a neural network evaluator for regressor.
			%
			% NNRegressorMLP_Evaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_Evaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorMLP_Evaluator properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for the regression task.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for the regression task.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.
			%  <strong>7</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network regressor.
			%  <strong>8</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
			%  <strong>9</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, matrix) returns the matrix of ground truth derived from the targets.
			%  <strong>10</strong> <strong>CORR</strong> 	CORR (result, rvector) provides the metric of the correlation of coefficients.
			%  <strong>11</strong> <strong>DET</strong> 	DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
			%  <strong>12</strong> <strong>MAE</strong> 	MAE (result, rvector) provides the metric of the mean absolute error.
			%  <strong>13</strong> <strong>MSE</strong> 	MSE (result, rvector) provides the metric of the mean squared error.
			%  <strong>14</strong> <strong>RMSE</strong> 	RMSE (result, rvector) provides the metric of the root mean squared error.
			%  <strong>15</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
			%  <strong>16</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>17</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
			%
			% See also Category, Format.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator for regressor.
			%
			% CLASS = NNRegressorMLP_Evaluator.GETCLASS() returns the class 'NNRegressorMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for regressor NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_Evaluator') returns 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNRegressorMLP_Evaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for regressor.
			%
			% LIST = NNRegressorMLP_Evaluator.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for regressor NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_Evaluator') returns all subclasses of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNRegressorMLP_Evaluator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for regressor.
			%
			% PROPS = NNRegressorMLP_Evaluator.GETPROPS() returns the property list of neural network evaluator for regressor
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_Evaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for regressor NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_Evaluator'[, CATEGORY]) returns the property list of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = [3 15];
				case 4 % Category.DATA
					prop_list = [4 7 8];
				case 5 % Category.RESULT
					prop_list = [10 11 12 13 14 16 17];
				case 6 % Category.QUERY
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for regressor.
			%
			% N = NNRegressorMLP_Evaluator.GETPROPNUMBER() returns the property number of neural network evaluator for regressor.
			%
			% N = NNRegressorMLP_Evaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for regressor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for regressor NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_Evaluator') returns the property number of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 17;
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
					prop_number = 7;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for regressor/error.
			%
			% CHECK = NNRegressorMLP_Evaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_Evaluator, PROP) checks whether PROP exists for NNRegressorMLP_Evaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_Evaluator, PROP) throws error if PROP does NOT exist for NNRegressorMLP_Evaluator.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_Evaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for regressor/error.
			%
			% CHECK = NNRegressorMLP_Evaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_Evaluator, TAG) checks whether TAG exists for NNRegressorMLP_Evaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_Evaluator, TAG) throws error if TAG does NOT exist for NNRegressorMLP_Evaluator.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'CORR'  'DET'  'MAE'  'MSE'  'RMSE'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_Evaluator.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_Evaluator, POINTER) returns property number of POINTER of NNRegressorMLP_Evaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNRegressorMLP_Evaluator, POINTER) returns property number of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'CORR'  'DET'  'MAE'  'MSE'  'RMSE'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_Evaluator, POINTER) returns tag of POINTER of NNRegressorMLP_Evaluator.
			%  TAG = NNE.GETPROPTAG(NNRegressorMLP_Evaluator, POINTER) returns tag of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnregressormlp_evaluator_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'NN'  'D'  'GROUND_TRUTH'  'CORR'  'DET'  'MAE'  'MSE'  'RMSE'  'P'  'PERM_SEEDS'  'FEATURE_IMPORTANCE' };
				tag = nnregressormlp_evaluator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_Evaluator, POINTER) returns category of POINTER of NNRegressorMLP_Evaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNRegressorMLP_Evaluator, POINTER) returns category of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluator_category_list = { 1  1  3  4  2  2  4  4  6  5  5  5  5  5  3  5  5 };
			prop_category = nnregressormlp_evaluator_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_Evaluator, POINTER) returns format of POINTER of NNRegressorMLP_Evaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNRegressorMLP_Evaluator, POINTER) returns format of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluator_format_list = { 2  2  8  2  2  2  8  8  14  12  12  12  12  12  11  12  16 };
			prop_format = nnregressormlp_evaluator_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_Evaluator, POINTER) returns description of POINTER of NNRegressorMLP_Evaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNRegressorMLP_Evaluator, POINTER) returns description of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluator_description_list = { 'NAME (constant, string) is the name of the neural network evaluator for the regression task.'  'DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.'  'TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.'  'ID (data, string) is a few-letter code for the neural network evaluator for the regression task.'  'LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.'  'NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.'  'NN (data, item) contains a trained neural network regressor.'  'D (data, item) is the dataset to evaluate the neural network model.'  'GROUND_TRUTH (query, matrix) returns the matrix of ground truth derived from the targets.'  'CORR (result, rvector) provides the metric of the correlation of coefficients.'  'DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.'  'MAE (result, rvector) provides the metric of the mean absolute error.'  'MSE (result, rvector) provides the metric of the mean squared error.'  'RMSE (result, rvector) provides the metric of the root mean squared error.'  'P (parameter, scalar) is the permutation number.'  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.' };
			prop_description = nnregressormlp_evaluator_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_Evaluator, POINTER) returns settings of POINTER of NNRegressorMLP_Evaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNRegressorMLP_Evaluator, POINTER) returns settings of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_settings = Format.getFormatSettings(14);
				case 10 % NNRegressorMLP_Evaluator.CORR
					prop_settings = Format.getFormatSettings(12);
				case 11 % NNRegressorMLP_Evaluator.DET
					prop_settings = Format.getFormatSettings(12);
				case 12 % NNRegressorMLP_Evaluator.MAE
					prop_settings = Format.getFormatSettings(12);
				case 13 % NNRegressorMLP_Evaluator.MSE
					prop_settings = Format.getFormatSettings(12);
				case 14 % NNRegressorMLP_Evaluator.RMSE
					prop_settings = Format.getFormatSettings(12);
				case 15 % NNRegressorMLP_Evaluator.P
					prop_settings = Format.getFormatSettings(11);
				case 16 % NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_settings = Format.getFormatSettings(12);
				case 17 % NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 3 % NNRegressorMLP_Evaluator.TEMPLATE
					prop_settings = 'NNRegressorMLP_Evaluator';
				case 7 % NNRegressorMLP_Evaluator.NN
					prop_settings = 'NNRegressorMLP';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_Evaluator, POINTER) returns the default value of POINTER of NNRegressorMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNRegressorMLP_Evaluator, POINTER) returns the default value of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_default = Format.getFormatDefault(14, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 10 % NNRegressorMLP_Evaluator.CORR
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 11 % NNRegressorMLP_Evaluator.DET
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 12 % NNRegressorMLP_Evaluator.MAE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 13 % NNRegressorMLP_Evaluator.MSE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 14 % NNRegressorMLP_Evaluator.RMSE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 15 % NNRegressorMLP_Evaluator.P
					prop_default = 1e+2;
				case 16 % NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 17 % NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 1 % NNRegressorMLP_Evaluator.NAME
					prop_default = 'NNRegressorMLP_Evaluator';
				case 2 % NNRegressorMLP_Evaluator.DESCRIPTION
					prop_default = 'A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset. NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).';
				case 3 % NNRegressorMLP_Evaluator.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 4 % NNRegressorMLP_Evaluator.ID
					prop_default = 'NNRegressorMLP_Evaluator ID';
				case 5 % NNRegressorMLP_Evaluator.LABEL
					prop_default = 'NNRegressorMLP_Evaluator label';
				case 6 % NNRegressorMLP_Evaluator.NOTES
					prop_default = 'NNRegressorMLP_Evaluator notes';
				case 7 % NNRegressorMLP_Evaluator.NN
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_Evaluator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_Evaluator.conditioning(prop, NNRegressorMLP_Evaluator.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_Evaluator.
			%  CHECK = NNE.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_Evaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNRegressorMLP_Evaluator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: BRAPH2:NNRegressorMLP_Evaluator:WrongInput
			%  Element.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_Evaluator.
			%   Error id: BRAPH2:NNRegressorMLP_Evaluator:WrongInput
			%  NNE.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_Evaluator.
			%   Error id: BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case 9 % NNRegressorMLP_Evaluator.GROUND_TRUTH
					check = Format.checkFormat(14, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 10 % NNRegressorMLP_Evaluator.CORR
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 11 % NNRegressorMLP_Evaluator.DET
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 12 % NNRegressorMLP_Evaluator.MAE
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 13 % NNRegressorMLP_Evaluator.MSE
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 14 % NNRegressorMLP_Evaluator.RMSE
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 15 % NNRegressorMLP_Evaluator.P
					check = Format.checkFormat(11, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 16 % NNRegressorMLP_Evaluator.PERM_SEEDS
					check = Format.checkFormat(12, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 17 % NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 3 % NNRegressorMLP_Evaluator.TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case 7 % NNRegressorMLP_Evaluator.NN
					check = Format.checkFormat(8, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_Evaluator.getPropTag(prop) ' (' NNRegressorMLP_Evaluator.getFormatTag(NNRegressorMLP_Evaluator.getPropFormat(prop)) ').'] ...
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
				case 9 % NNRegressorMLP_Evaluator.GROUND_TRUTH
					targets = nne.get('D').get('TARGETS');
					if isempty(targets)
					    value = [];
					else
					    for i = 1:length(targets)
					        value(i, :) = cell2mat(targets{i});
					    end
					end
					
				case 10 % NNRegressorMLP_Evaluator.CORR
					rng_settings_ = rng(); rng(nne.getPropSeed(10), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
					        value(i) = corr_matrix(1, 2);
					    end
					end
					
					rng(rng_settings_)
					
				case 11 % NNRegressorMLP_Evaluator.DET
					rng_settings_ = rng(); rng(nne.getPropSeed(11), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
					        value(i) = corr_matrix(1, 2)^2;
					    end
					end
					
					rng(rng_settings_)
					
				case 12 % NNRegressorMLP_Evaluator.MAE
					rng_settings_ = rng(); rng(nne.getPropSeed(12), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = mean(abs(predictions(:, i) - ground_truth(:, i)));
					    end
					end
					
					rng(rng_settings_)
					
				case 13 % NNRegressorMLP_Evaluator.MSE
					rng_settings_ = rng(); rng(nne.getPropSeed(13), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = mean((predictions(:, i) - ground_truth(:, i)).^2);
					    end
					end
					
					rng(rng_settings_)
					
				case 14 % NNRegressorMLP_Evaluator.RMSE
					rng_settings_ = rng(); rng(nne.getPropSeed(14), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = sqrt(mean((predictions(:, i) - ground_truth(:, i)).^2));
					    end
					end
					
					rng(rng_settings_)
					
				case 16 % NNRegressorMLP_Evaluator.PERM_SEEDS
					rng_settings_ = rng(); rng(nne.getPropSeed(16), 'twister')
					
					value = randi(intmax('uint32'), 1, nne.get('P'));
					
					rng(rng_settings_)
					
				case 17 % NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nne.getPropSeed(17), 'twister')
					
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