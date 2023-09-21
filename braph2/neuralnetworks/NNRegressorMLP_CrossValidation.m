classdef NNRegressorMLP_CrossValidation < NNCrossValidation
	%NNRegressorMLP_CrossValidation is a process for evaluating multi-layer perceptron regressors using cross-validation.
	% It is a subclass of <a href="matlab:help NNCrossValidation">NNCrossValidation</a>.
	%
	% A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. 
	%  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
	%  This helps in assessing the generalization performance of the model and detecting overfitting.
	% 
	% To train all the neural networks for all folds, use: nncv.get('TRAIN')
	%
	% The list of NNRegressorMLP_CrossValidation properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cross-validation.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cross-validation.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the nerual cross-validation.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cross-validation.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cross-validation.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cross-validation.
	%  <strong>7</strong> <strong>KFOLDS</strong> 	KFOLDS (data, scalar) is the number of folds.
	%  <strong>8</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
	%  <strong>9</strong> <strong>D</strong> 	D (data, itemlist) is the datasets from groups to be cross-validated.
	%  <strong>10</strong> <strong>NN_TEMPLATE</strong> 	NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
	%  <strong>11</strong> <strong>NNEVALUATOR_TEMPLATE</strong> 	NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
	%  <strong>12</strong> <strong>DSP</strong> 	DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.
	%  <strong>13</strong> <strong>DCO</strong> 	DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.
	%  <strong>14</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.
	%  <strong>15</strong> <strong>NN_LIST</strong> 	NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
	%  <strong>16</strong> <strong>EVALUATOR_LIST</strong> 	EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
	%  <strong>17</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>18</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>19</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>20</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>21</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display training progress information.
	%  <strong>22</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>23</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains all neural network models for all folds.
	%  <strong>24</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
	%  <strong>25</strong> <strong>AV_CORR</strong> 	AV_CORR (result, rvector) provides the metric of the correlation of coefficients.
	%  <strong>26</strong> <strong>AV_DET</strong> 	AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
	%  <strong>27</strong> <strong>AV_MAE</strong> 	AV_MAE (result, rvector) provides the metric of the mean absolute error.
	%  <strong>28</strong> <strong>AV_MSE</strong> 	AV_MSE (result, rvector) provides the metric of the mean squared error.
	%  <strong>29</strong> <strong>AV_RMSE</strong> 	AV_RMSE (result, rvector) provides the metric of the root mean squared error.
	%  <strong>30</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.
	%
	% NNRegressorMLP_CrossValidation methods (constructor):
	%  NNRegressorMLP_CrossValidation - constructor
	%
	% NNRegressorMLP_CrossValidation methods:
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
	% NNRegressorMLP_CrossValidation methods (display):
	%  tostring - string with information about the neural network cross-validation
	%  disp - displays information about the neural network cross-validation
	%  tree - displays the tree of the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation as b2 file
	%  load - loads a BRAPH2 neural network cross-validation from a b2 file
	%
	% NNRegressorMLP_CrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation
	%  getSubclasses - returns all subclasses of NNRegressorMLP_CrossValidation
	%  getProps - returns the property list of the neural network cross-validation
	%  getPropNumber - returns the property number of the neural network cross-validation
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
	% NNRegressorMLP_CrossValidation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_CrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_CrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_CrossValidation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_CrossValidation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_CrossValidation constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	
	properties (Constant) % properties
		P = 24; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		AV_CORR = 25; %CET: Computational Efficiency Trick
		AV_CORR_TAG = 'AV_CORR';
		AV_CORR_CATEGORY = 5;
		AV_CORR_FORMAT = 12;
		
		AV_DET = 26; %CET: Computational Efficiency Trick
		AV_DET_TAG = 'AV_DET';
		AV_DET_CATEGORY = 5;
		AV_DET_FORMAT = 12;
		
		AV_MAE = 27; %CET: Computational Efficiency Trick
		AV_MAE_TAG = 'AV_MAE';
		AV_MAE_CATEGORY = 5;
		AV_MAE_FORMAT = 12;
		
		AV_MSE = 28; %CET: Computational Efficiency Trick
		AV_MSE_TAG = 'AV_MSE';
		AV_MSE_CATEGORY = 5;
		AV_MSE_FORMAT = 12;
		
		AV_RMSE = 29; %CET: Computational Efficiency Trick
		AV_RMSE_TAG = 'AV_RMSE';
		AV_RMSE_CATEGORY = 5;
		AV_RMSE_FORMAT = 12;
		
		AV_FEATURE_IMPORTANCE = 30; %CET: Computational Efficiency Trick
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = 5;
		AV_FEATURE_IMPORTANCE_FORMAT = 16;
	end
	methods % constructor
		function nncv = NNRegressorMLP_CrossValidation(varargin)
			%NNRegressorMLP_CrossValidation() creates a neural network cross-validation.
			%
			% NNRegressorMLP_CrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_CrossValidation(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorMLP_CrossValidation properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cross-validation.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cross-validation.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the nerual cross-validation.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cross-validation.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cross-validation.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cross-validation.
			%  <strong>7</strong> <strong>KFOLDS</strong> 	KFOLDS (data, scalar) is the number of folds.
			%  <strong>8</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
			%  <strong>9</strong> <strong>D</strong> 	D (data, itemlist) is the datasets from groups to be cross-validated.
			%  <strong>10</strong> <strong>NN_TEMPLATE</strong> 	NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
			%  <strong>11</strong> <strong>NNEVALUATOR_TEMPLATE</strong> 	NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
			%  <strong>12</strong> <strong>DSP</strong> 	DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.
			%  <strong>13</strong> <strong>DCO</strong> 	DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.
			%  <strong>14</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.
			%  <strong>15</strong> <strong>NN_LIST</strong> 	NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
			%  <strong>16</strong> <strong>EVALUATOR_LIST</strong> 	EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
			%  <strong>17</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>18</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>19</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>20</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>21</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display training progress information.
			%  <strong>22</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>23</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains all neural network models for all folds.
			%  <strong>24</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
			%  <strong>25</strong> <strong>AV_CORR</strong> 	AV_CORR (result, rvector) provides the metric of the correlation of coefficients.
			%  <strong>26</strong> <strong>AV_DET</strong> 	AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
			%  <strong>27</strong> <strong>AV_MAE</strong> 	AV_MAE (result, rvector) provides the metric of the mean absolute error.
			%  <strong>28</strong> <strong>AV_MSE</strong> 	AV_MSE (result, rvector) provides the metric of the mean squared error.
			%  <strong>29</strong> <strong>AV_RMSE</strong> 	AV_RMSE (result, rvector) provides the metric of the root mean squared error.
			%  <strong>30</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.
			%
			% See also Category, Format.
			
			nncv = nncv@NNCrossValidation(varargin{:});
		end
	end
	methods (Static) % inspection
		function nncv_class = getClass()
			%GETCLASS returns the class of the neural network cross-validation.
			%
			% CLASS = NNRegressorMLP_CrossValidation.GETCLASS() returns the class 'NNRegressorMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_CrossValidation') returns 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			
			nncv_class = 'NNRegressorMLP_CrossValidation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation.
			%
			% LIST = NNRegressorMLP_CrossValidation.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_CrossValidation') returns all subclasses of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNRegressorMLP_CrossValidation' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation.
			%
			% PROPS = NNRegressorMLP_CrossValidation.GETPROPS() returns the property list of neural network cross-validation
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_CrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_CrossValidation'[, CATEGORY]) returns the property list of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2];
				case 2 % Category.METADATA
					prop_list = [5 6 21 22];
				case 3 % Category.PARAMETER
					prop_list = [3 10 11 17 18 19 20 24];
				case 4 % Category.DATA
					prop_list = [4 7 8 9];
				case 5 % Category.RESULT
					prop_list = [12 13 14 15 16 25 26 27 28 29 30];
				case 6 % Category.QUERY
					prop_list = 23;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation.
			%
			% N = NNRegressorMLP_CrossValidation.GETPROPNUMBER() returns the property number of neural network cross-validation.
			%
			% N = NNRegressorMLP_CrossValidation.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_CrossValidation') returns the property number of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 30;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 2;
				case 2 % Category.METADATA
					prop_number = 4;
				case 3 % Category.PARAMETER
					prop_number = 8;
				case 4 % Category.DATA
					prop_number = 4;
				case 5 % Category.RESULT
					prop_number = 11;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation/error.
			%
			% CHECK = NNRegressorMLP_CrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_CrossValidation, PROP) checks whether PROP exists for NNRegressorMLP_CrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_CrossValidation, PROP) throws error if PROP does NOT exist for NNRegressorMLP_CrossValidation.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 30 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_CrossValidation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation/error.
			%
			% CHECK = NNRegressorMLP_CrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_CrossValidation, TAG) checks whether TAG exists for NNRegressorMLP_CrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_CrossValidation, TAG) throws error if TAG does NOT exist for NNRegressorMLP_CrossValidation.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'NN_LIST'  'EVALUATOR_LIST'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'P'  'AV_CORR'  'AV_DET'  'AV_MAE'  'AV_MSE'  'AV_RMSE'  'AV_FEATURE_IMPORTANCE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_CrossValidation.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_CrossValidation, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNRegressorMLP_CrossValidation, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'NN_LIST'  'EVALUATOR_LIST'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'P'  'AV_CORR'  'AV_DET'  'AV_MAE'  'AV_MSE'  'AV_RMSE'  'AV_FEATURE_IMPORTANCE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNCV.GETPROPTAG(POINTER) returns tag of POINTER of NNCV.
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_CrossValidation, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNRegressorMLP_CrossValidation, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnregressormlp_crossvalidation_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'NN_LIST'  'EVALUATOR_LIST'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'P'  'AV_CORR'  'AV_DET'  'AV_MAE'  'AV_MSE'  'AV_RMSE'  'AV_FEATURE_IMPORTANCE' };
				tag = nnregressormlp_crossvalidation_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNCV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNCV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_CrossValidation, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNRegressorMLP_CrossValidation, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_crossvalidation_category_list = { 1  1  3  4  2  2  4  4  4  3  3  5  5  5  5  5  3  3  3  3  2  2  6  3  5  5  5  5  5  5 };
			prop_category = nnregressormlp_crossvalidation_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_CrossValidation, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNRegressorMLP_CrossValidation, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_crossvalidation_format_list = { 2  2  8  2  2  2  11  16  9  8  8  9  9  9  9  9  11  11  5  5  4  5  1  11  12  12  12  12  12  16 };
			prop_format = nnregressormlp_crossvalidation_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidation, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidation, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_crossvalidation_description_list = { 'NAME (constant, string) is the name of the cross-validation.'  'DESCRIPTION (constant, string) is the description of the cross-validation.'  'TEMPLATE (parameter, item) is the template of the nerual cross-validation.'  'ID (data, string) is a few-letter code for the cross-validation.'  'LABEL (metadata, string) is an extended label of the cross-validation.'  'NOTES (metadata, string) are some specific notes about the cross-validation.'  'KFOLDS (data, scalar) is the number of folds.'  'SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.'  'D (data, itemlist) is the datasets from groups to be cross-validated.'  'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.'  'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.'  'DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.'  'DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.'  'D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.'  'NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.'  'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'VERBOSE (metadata, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'TRAIN (query, empty) trains all neural network models for all folds.'  'P (parameter, scalar) is the permutation number.'  'AV_CORR (result, rvector) provides the metric of the correlation of coefficients.'  'AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.'  'AV_MAE (result, rvector) provides the metric of the mean absolute error.'  'AV_MSE (result, rvector) provides the metric of the mean squared error.'  'AV_RMSE (result, rvector) provides the metric of the root mean squared error.'  'AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.' };
			prop_description = nnregressormlp_crossvalidation_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_CrossValidation, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNRegressorMLP_CrossValidation, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 24 % NNRegressorMLP_CrossValidation.P
					prop_settings = Format.getFormatSettings(11);
				case 25 % NNRegressorMLP_CrossValidation.AV_CORR
					prop_settings = Format.getFormatSettings(12);
				case 26 % NNRegressorMLP_CrossValidation.AV_DET
					prop_settings = Format.getFormatSettings(12);
				case 27 % NNRegressorMLP_CrossValidation.AV_MAE
					prop_settings = Format.getFormatSettings(12);
				case 28 % NNRegressorMLP_CrossValidation.AV_MSE
					prop_settings = Format.getFormatSettings(12);
				case 29 % NNRegressorMLP_CrossValidation.AV_RMSE
					prop_settings = Format.getFormatSettings(12);
				case 30 % NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 3 % NNRegressorMLP_CrossValidation.TEMPLATE
					prop_settings = 'NNRegressorMLP_CrossValidation';
				case 10 % NNRegressorMLP_CrossValidation.NN_TEMPLATE
					prop_settings = 'NNRegressorMLP';
				case 11 % NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNRegressorMLP_Evaluator';
				otherwise
					prop_settings = getPropSettings@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_CrossValidation, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNRegressorMLP_CrossValidation, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 24 % NNRegressorMLP_CrossValidation.P
					prop_default = 1e+2;
				case 25 % NNRegressorMLP_CrossValidation.AV_CORR
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 26 % NNRegressorMLP_CrossValidation.AV_DET
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 27 % NNRegressorMLP_CrossValidation.AV_MAE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 28 % NNRegressorMLP_CrossValidation.AV_MSE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 29 % NNRegressorMLP_CrossValidation.AV_RMSE
					prop_default = Format.getFormatDefault(12, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 30 % NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 1 % NNRegressorMLP_CrossValidation.NAME
					prop_default = 'NNRegressorMLP_CrossValidation';
				case 2 % NNRegressorMLP_CrossValidation.DESCRIPTION
					prop_default = 'A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.';
				case 3 % NNRegressorMLP_CrossValidation.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 4 % NNRegressorMLP_CrossValidation.ID
					prop_default = 'NNRegressorMLP_CrossValidation ID';
				case 5 % NNRegressorMLP_CrossValidation.LABEL
					prop_default = 'NNRegressorMLP_CrossValidation label';
				case 6 % NNRegressorMLP_CrossValidation.NOTES
					prop_default = 'NNRegressorMLP_CrossValidation notes';
				case 10 % NNRegressorMLP_CrossValidation.NN_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 11 % NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_CrossValidation.conditioning(prop, NNRegressorMLP_CrossValidation.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNCV.
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNRegressorMLP_CrossValidation:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: BRAPH2:NNRegressorMLP_CrossValidation:WrongInput
			%  Element.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidation.
			%   Error id: BRAPH2:NNRegressorMLP_CrossValidation:WrongInput
			%  NNCV.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidation.
			%   Error id: BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case 24 % NNRegressorMLP_CrossValidation.P
					check = Format.checkFormat(11, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 25 % NNRegressorMLP_CrossValidation.AV_CORR
					check = Format.checkFormat(12, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 26 % NNRegressorMLP_CrossValidation.AV_DET
					check = Format.checkFormat(12, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 27 % NNRegressorMLP_CrossValidation.AV_MAE
					check = Format.checkFormat(12, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 28 % NNRegressorMLP_CrossValidation.AV_MSE
					check = Format.checkFormat(12, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 29 % NNRegressorMLP_CrossValidation.AV_RMSE
					check = Format.checkFormat(12, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 30 % NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 3 % NNRegressorMLP_CrossValidation.TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 10 % NNRegressorMLP_CrossValidation.NN_TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case 11 % NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				otherwise
					if prop <= 23
						check = checkProp@NNCrossValidation(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_CrossValidation.getPropTag(prop) ' (' NNRegressorMLP_CrossValidation.getFormatTag(NNRegressorMLP_CrossValidation.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nncv, prop, varargin)
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
				case 25 % NNRegressorMLP_CrossValidation.AV_CORR
					rng_settings_ = rng(); rng(nncv.getPropSeed(25), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('CORR'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case 26 % NNRegressorMLP_CrossValidation.AV_DET
					rng_settings_ = rng(); rng(nncv.getPropSeed(26), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('DET'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case 27 % NNRegressorMLP_CrossValidation.AV_MAE
					rng_settings_ = rng(); rng(nncv.getPropSeed(27), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('MAE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case 28 % NNRegressorMLP_CrossValidation.AV_MSE
					rng_settings_ = rng(); rng(nncv.getPropSeed(28), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('MSE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case 29 % NNRegressorMLP_CrossValidation.AV_RMSE
					rng_settings_ = rng(); rng(nncv.getPropSeed(29), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('RMSE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case 30 % NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nncv.getPropSeed(30), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
					    e_list, 'UniformOutput', false);
					
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
					
				case 15 % NNRegressorMLP_CrossValidation.NN_LIST
					rng_settings_ = rng(); rng(nncv.getPropSeed(15), 'twister')
					
					d_list = nncv.get('D_LIST');
					
					if isempty(d_list)
					    value = {};
					else
					    for i = 1:length(d_list)
					        d_training_set{i} = d_list;
					        d_training_set{i}(i) = [];  % Exclude the i-th element
					        d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
					    end
					
					    d_training_set = d_training_set';
					
					    if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
					        nn_template = nncv.get('NN_TEMPLATE');
					    else
					        nn_template = NNRegressorMLP( ...
					            'EPOCHS', nncv.get('EPOCHS'), ...
					            'BATCH', nncv.get('BATCH'), ...
					            'SHUFFLE', nncv.get('SHUFFLE'), ...
					            'SOLVER', nncv.get('SOLVER'), ...
					            'VERBOSE', nncv.get('VERBOSE'), ...
					            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					    end
					    
					    value = cellfun(@(d) NNRegressorMLP( ...
					        'TEMPLATE', nn_template, 'D', d), ...
					        d_training_set, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case 16 % NNRegressorMLP_CrossValidation.EVALUATOR_LIST
					rng_settings_ = rng(); rng(nncv.getPropSeed(16), 'twister')
					
					d_list = nncv.get('D_LIST');
					nn_list = nncv.get('NN_LIST');
					
					if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
					    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
					else
					    nne_template = NNRegressorMLP_Evaluator( ...
					        'P', nncv.get('P'));
					end
					
					value = cellfun(@(d, nn) NNRegressorMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
					    d_list, nn_list, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 23
						value = calculateValue@NNCrossValidation(nncv, prop, varargin{:});
					else
						value = calculateValue@Element(nncv, prop, varargin{:});
					end
			end
			
		end
	end
end
