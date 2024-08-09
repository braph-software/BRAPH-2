classdef NNxMLP_FeatureImportance_CV < ConcreteElement
	%NNxMLP_FeatureImportance_CV provides the importance of features across all folds for multi-layer perceptron (MLP) using shuffled feature method.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CV)
	%  assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. 
	% The feature importance score for each feature is then averaged across all folds. 
	% It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
	%  such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.
	%
	% The list of NNxMLP_FeatureImportance_CV properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network feature importance for cross validation.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural network feature importance for cross validation.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NNCV</strong> 	NNCV (data, item) is the neural network cross validation to be tested on feature importance.
	%  <strong>10</strong> <strong>FI_TEMPLATE</strong> 	FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.
	%  <strong>11</strong> <strong>FI_LIST</strong> 	FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
	%  <strong>12</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the features. 
	%  <strong>13</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>14</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.
	%  <strong>15</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
	%  <strong>16</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display permutation progress information.
	%  <strong>17</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
	%  <strong>18</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>19</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
	%  <strong>20</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) is determined by applying bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
	%  <strong>21</strong> <strong>RESHAPED_AV_FEATURE_IMPORTANCE</strong> 	RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.
	%  <strong>22</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%  <strong>23</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
	%  <strong>24</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
	%
	% NNxMLP_FeatureImportance_CV methods (constructor):
	%  NNxMLP_FeatureImportance_CV - constructor
	%
	% NNxMLP_FeatureImportance_CV methods:
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
	% NNxMLP_FeatureImportance_CV methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportance_CV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportance_CV
	%  getProps - returns the property list of the neural network feature importace for multi-layer perceptron
	%  getPropNumber - returns the property number of the neural network feature importace for multi-layer perceptron
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
	% NNxMLP_FeatureImportance_CV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportance_CV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportance_CV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportance_CV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportance_CV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportance_CV constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportance, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation.
	
	properties (Constant) % properties
		NNCV = 9; %CET: Computational Efficiency Trick
		NNCV_TAG = 'NNCV';
		NNCV_CATEGORY = 4;
		NNCV_FORMAT = 8;
		
		FI_TEMPLATE = 10; %CET: Computational Efficiency Trick
		FI_TEMPLATE_TAG = 'FI_TEMPLATE';
		FI_TEMPLATE_CATEGORY = 3;
		FI_TEMPLATE_FORMAT = 8;
		
		FI_LIST = 11; %CET: Computational Efficiency Trick
		FI_LIST_TAG = 'FI_LIST';
		FI_LIST_CATEGORY = 5;
		FI_LIST_FORMAT = 9;
		
		P = 12; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		PERM_SEEDS = 13; %CET: Computational Efficiency Trick
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = 5;
		PERM_SEEDS_FORMAT = 12;
		
		APPLY_BONFERRONI = 14; %CET: Computational Efficiency Trick
		APPLY_BONFERRONI_TAG = 'APPLY_BONFERRONI';
		APPLY_BONFERRONI_CATEGORY = 3;
		APPLY_BONFERRONI_FORMAT = 4;
		
		APPLY_CONFIDENCE_INTERVALS = 15; %CET: Computational Efficiency Trick
		APPLY_CONFIDENCE_INTERVALS_TAG = 'APPLY_CONFIDENCE_INTERVALS';
		APPLY_CONFIDENCE_INTERVALS_CATEGORY = 3;
		APPLY_CONFIDENCE_INTERVALS_FORMAT = 4;
		
		VERBOSE = 16; %CET: Computational Efficiency Trick
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = 2;
		VERBOSE_FORMAT = 4;
		
		SIG_LEVEL = 17; %CET: Computational Efficiency Trick
		SIG_LEVEL_TAG = 'SIG_LEVEL';
		SIG_LEVEL_CATEGORY = 3;
		SIG_LEVEL_FORMAT = 11;
		
		WAITBAR = 18; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		INTERRUPTIBLE = 19; %CET: Computational Efficiency Trick
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = 9;
		INTERRUPTIBLE_FORMAT = 11;
		
		AV_FEATURE_IMPORTANCE = 20; %CET: Computational Efficiency Trick
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = 5;
		AV_FEATURE_IMPORTANCE_FORMAT = 16;
		
		RESHAPED_AV_FEATURE_IMPORTANCE = 21; %CET: Computational Efficiency Trick
		RESHAPED_AV_FEATURE_IMPORTANCE_TAG = 'RESHAPED_AV_FEATURE_IMPORTANCE';
		RESHAPED_AV_FEATURE_IMPORTANCE_CATEGORY = 5;
		RESHAPED_AV_FEATURE_IMPORTANCE_FORMAT = 16;
		
		MAP_TO_CELL = 22; %CET: Computational Efficiency Trick
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = 6;
		MAP_TO_CELL_FORMAT = 1;
		
		COUNT_ELEMENTS = 23; %CET: Computational Efficiency Trick
		COUNT_ELEMENTS_TAG = 'COUNT_ELEMENTS';
		COUNT_ELEMENTS_CATEGORY = 6;
		COUNT_ELEMENTS_FORMAT = 1;
		
		FLATTEN_CELL = 24; %CET: Computational Efficiency Trick
		FLATTEN_CELL_TAG = 'FLATTEN_CELL';
		FLATTEN_CELL_CATEGORY = 6;
		FLATTEN_CELL_FORMAT = 1;
	end
	methods % constructor
		function nnficv = NNxMLP_FeatureImportance_CV(varargin)
			%NNxMLP_FeatureImportance_CV() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportance_CV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportance_CV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportance_CV properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network feature importance for cross validation.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural network feature importance for cross validation.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NNCV</strong> 	NNCV (data, item) is the neural network cross validation to be tested on feature importance.
			%  <strong>10</strong> <strong>FI_TEMPLATE</strong> 	FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.
			%  <strong>11</strong> <strong>FI_LIST</strong> 	FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
			%  <strong>12</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the features. 
			%  <strong>13</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>14</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.
			%  <strong>15</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
			%  <strong>16</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display permutation progress information.
			%  <strong>17</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
			%  <strong>18</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>19</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
			%  <strong>20</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) is determined by applying bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
			%  <strong>21</strong> <strong>RESHAPED_AV_FEATURE_IMPORTANCE</strong> 	RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.
			%  <strong>22</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%  <strong>23</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
			%  <strong>24</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
			%
			% See also Category, Format.
			
			nnficv = nnficv@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nnficv_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportance_CV.GETCLASS() returns the class 'NNxMLP_FeatureImportance_CV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFICV.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFICV.
			%  CLASS = Element.GETCLASS(NNFICV) returns the class of 'NNFICV'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportance_CV') returns 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETCLASS(NNFICV) and Element.GETCLASS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			
			nnficv_class = 'NNxMLP_FeatureImportance_CV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportance_CV.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportance_CV'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFICV.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFICV.
			%  LIST = Element.GETSUBCLASSES(NNFICV) returns all subclasses of 'NNFICV'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportance_CV') returns all subclasses of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETSUBCLASSES(NNFICV) and Element.GETSUBCLASSES('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportance_CV'  'NNxMLP_FeatureImportanceAcrossMeasures_CV' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportance_CV.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportance_CV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFICV.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFICV.
			%  PROPS = Element.GETPROPS(NNFICV[, CATEGORY]) returns the property list of 'NNFICV'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportance_CV'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETPROPS(NNFICV) and Element.GETPROPS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 16];
				case 3 % Category.PARAMETER
					prop_list = [4 10 12 14 15 17];
				case 4 % Category.DATA
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = [11 13 20 21];
				case 6 % Category.QUERY
					prop_list = [8 22 23 24];
				case 9 % Category.GUI
					prop_list = [18 19];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance_CV.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance_CV.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFICV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFICV.
			%  N = Element.GETPROPNUMBER(NNFICV) returns the property number of 'NNFICV'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportance_CV') returns the property number of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETPROPNUMBER(NNFICV) and Element.GETPROPNUMBER('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 24;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 4;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance_CV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSPROP(PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNFICV, PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportance_CV, PROP) checks whether PROP exists for NNxMLP_FeatureImportance_CV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSPROP(NNFICV, PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportance_CV, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportance_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFICV) and Element.EXISTSPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 24 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportance_CV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance_CV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSTAG(TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNFICV, TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportance_CV, TAG) checks whether TAG exists for NNxMLP_FeatureImportance_CV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSTAG(NNFICV, TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportance_CV, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportance_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFICV) and Element.EXISTSTAG('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportance_CV.'] ...
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
			%  PROPERTY = NNFICV.GETPROPPROP(POINTER) returns property number of POINTER of NNFICV.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportance_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance_CV.
			%  PROPERTY = NNFICV.GETPROPPROP(NNxMLP_FeatureImportance_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPPROP(NNFICV) and Element.GETPROPPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFICV.GETPROPTAG(POINTER) returns tag of POINTER of NNFICV.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportance_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance_CV.
			%  TAG = NNFICV.GETPROPTAG(NNxMLP_FeatureImportance_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPTAG(NNFICV) and Element.GETPROPTAG('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportance_cv_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL' };
				tag = nnxmlp_featureimportance_cv_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFICV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFICV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportance_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportance_CV.
			%  CATEGORY = NNFICV.GETPROPCATEGORY(NNxMLP_FeatureImportance_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPCATEGORY(NNFICV) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_cv_category_list = { 1  1  1  3  4  2  2  6  4  3  5  3  5  3  3  2  3  9  9  5  5  6  6  6 };
			prop_category = nnxmlp_featureimportance_cv_category_list{prop};
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
			%  FORMAT = NNFICV.GETPROPFORMAT(POINTER) returns format of POINTER of NNFICV.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportance_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportance_CV.
			%  FORMAT = NNFICV.GETPROPFORMAT(NNxMLP_FeatureImportance_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPFORMAT(NNFICV) and Element.GETPROPFORMAT('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_cv_format_list = { 2  2  2  8  2  2  2  2  8  8  9  11  12  4  4  4  11  4  11  16  16  1  1  1 };
			prop_format = nnxmlp_featureimportance_cv_format_list{prop};
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
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFICV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportance_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportance_CV.
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(NNxMLP_FeatureImportance_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFICV) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_cv_description_list = { 'ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.'  'NAME (constant, string) is the name of the neural network feature importance for cross validation.'  'DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.'  'TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.'  'ID (data, string) is a few-letter code of the neural network feature importance for cross validation.'  'LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.'  'NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NNCV (data, item) is the neural network cross validation to be tested on feature importance.'  'FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.'  'FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.'  'P (parameter, scalar) is the permutation number that determines the statistical significance of the features. '  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.'  'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.'  'VERBOSE (metadata, logical) is an indicator to display permutation progress information.'  'SIG_LEVEL (parameter, scalar) determines the significant level.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.'  'AV_FEATURE_IMPORTANCE (result, cell) is determined by applying bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.'  'RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.'  'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.'  'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.' };
			prop_description = nnxmlp_featureimportance_cv_description_list{prop};
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
			%  SETTINGS = NNFICV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFICV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportance_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance_CV.
			%  SETTINGS = NNFICV.GETPROPSETTINGS(NNxMLP_FeatureImportance_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPSETTINGS(NNFICV) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNxMLP_FeatureImportance_CV.NNCV
					prop_settings = 'NNCrossValidation';
				case 10 % NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance';
				case 11 % NNxMLP_FeatureImportance_CV.FI_LIST
					prop_settings = 'NNxMLP_FeatureImportance';
				case 12 % NNxMLP_FeatureImportance_CV.P
					prop_settings = Format.getFormatSettings(11);
				case 13 % NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_settings = Format.getFormatSettings(12);
				case 14 % NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_settings = Format.getFormatSettings(4);
				case 15 % NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(4);
				case 16 % NNxMLP_FeatureImportance_CV.VERBOSE
					prop_settings = Format.getFormatSettings(4);
				case 17 % NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_settings = Format.getFormatSettings(11);
				case 18 % NNxMLP_FeatureImportance_CV.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 19 % NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(11);
				case 20 % NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 21 % NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 22 % NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(1);
				case 23 % NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_settings = Format.getFormatSettings(1);
				case 24 % NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_settings = Format.getFormatSettings(1);
				case 4 % NNxMLP_FeatureImportance_CV.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance_CV';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportance_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULT(NNxMLP_FeatureImportance_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDEFAULT(NNFICV) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNxMLP_FeatureImportance_CV.NNCV
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 10 % NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 11 % NNxMLP_FeatureImportance_CV.FI_LIST
					prop_default = Format.getFormatDefault(9, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 12 % NNxMLP_FeatureImportance_CV.P
					prop_default = 1e+2;
				case 13 % NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_default = Format.getFormatDefault(12, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 14 % NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_default = true;
				case 15 % NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_default = true;
				case 16 % NNxMLP_FeatureImportance_CV.VERBOSE
					prop_default = false;
				case 17 % NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_default = 0.05;
				case 18 % NNxMLP_FeatureImportance_CV.WAITBAR
					prop_default = true;
				case 19 % NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_default = .001;
				case 20 % NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 21 % NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 22 % NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 23 % NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 24 % NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 1 % NNxMLP_FeatureImportance_CV.ELCLASS
					prop_default = 'NNxMLP_FeatureImportance_CV';
				case 2 % NNxMLP_FeatureImportance_CV.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron';
				case 3 % NNxMLP_FeatureImportance_CV.DESCRIPTION
					prop_default = 'Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CV) assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. The feature importance score for each feature is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.';
				case 4 % NNxMLP_FeatureImportance_CV.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportance_CV.ID
					prop_default = 'NNxMLP_FeatureImportance_CV ID';
				case 6 % NNxMLP_FeatureImportance_CV.LABEL
					prop_default = 'NNxMLP_FeatureImportance_CV label';
				case 7 % NNxMLP_FeatureImportance_CV.NOTES
					prop_default = 'NNxMLP_FeatureImportance_CV notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFICV) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportance_CV.conditioning(prop, NNxMLP_FeatureImportance_CV.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFICV.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance_CV.
			%  CHECK = NNFICV.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance_CV.
			% 
			% NNFICV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFICV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFICV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance_CV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput
			%  NNFICV.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance_CV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFICV) and Element.CHECKPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case 9 % NNxMLP_FeatureImportance_CV.NNCV
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 10 % NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 11 % NNxMLP_FeatureImportance_CV.FI_LIST
					check = Format.checkFormat(9, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 12 % NNxMLP_FeatureImportance_CV.P
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 13 % NNxMLP_FeatureImportance_CV.PERM_SEEDS
					check = Format.checkFormat(12, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 14 % NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 15 % NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 16 % NNxMLP_FeatureImportance_CV.VERBOSE
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 17 % NNxMLP_FeatureImportance_CV.SIG_LEVEL
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 18 % NNxMLP_FeatureImportance_CV.WAITBAR
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 19 % NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 20 % NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 21 % NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 22 % NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 23 % NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 24 % NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportance_CV.TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance_CV:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportance_CV.getPropTag(prop) ' (' NNxMLP_FeatureImportance_CV.getFormatTag(NNxMLP_FeatureImportance_CV.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(nnficv, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 12 % NNxMLP_FeatureImportance_CV.P
					nnficv.memorize('FI_TEMPLATE').set('P', nnficv.getCallback('P'));
					
				case 14 % NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					nnficv.memorize('FI_TEMPLATE').set('APPLY_BONFERRONI', nnficv.getCallback('APPLY_BONFERRONI'));
					
				case 15 % NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					nnficv.memorize('FI_TEMPLATE').set('APPLY_CONFIDENCE_INTERVALS', nnficv.getCallback('APPLY_CONFIDENCE_INTERVALS'));
					
				case 17 % NNxMLP_FeatureImportance_CV.SIG_LEVEL
					nnficv.memorize('FI_TEMPLATE').set('SIG_LEVEL', nnficv.getCallback('SIG_LEVEL'));
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(nnficv, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnficv, prop, varargin)
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
				case 11 % NNxMLP_FeatureImportance_CV.FI_LIST
					rng_settings_ = rng(); rng(nnficv.getPropSeed(11), 'twister')
					
					if ~isa(nnficv.getr('FI_TEMPLATE'), 'NoValue')
					    fi_template = nnficv.get('FI_TEMPLATE');
					else
					    fi_template = NNxMLP_FeatureImportance( ...
					        'P', nnficv.get('P'), ...
					        'APPLY_BONFERRONI', nnficv.get('APPLY_BONFERRONI'), ...
					        'APPLY_CONFIDENCE_INTERVALS', nnficv.get('APPLY_CONFIDENCE_INTERVALS'), ...
					        'SIG_LEVEL', nnficv.get('SIG_LEVEL'));
					end
					
					d_list = nnficv.get('NNCV').get('D_LIST');
					nn_list = nnficv.get('NNCV').get('NN_LIST');
					fi_list = {};
					for i = 1:length(d_list)
					    fi = fi_template.copy();
					    d = d_list{i};
					    nn = nn_list{i};
					    fi.set('TEMPLATE', fi_template, 'D', d, 'NN', nn);
					    fi_list{i} = fi;
					end
					value = fi_list;
					
					rng(rng_settings_)
					
				case 13 % NNxMLP_FeatureImportance_CV.PERM_SEEDS
					rng_settings_ = rng(); rng(nnficv.getPropSeed(13), 'twister')
					
					value = randi(intmax('uint32'), 1, nnficv.get('P'));
					
					rng(rng_settings_)
					
				case 20 % NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nnficv.getPropSeed(20), 'twister')
					
					fi_list = nnficv.memorize('FI_LIST');
					fi_value_list = cellfun(@(fi) cell2mat(fi.memorize('FEATURE_IMPORTANCE')'), fi_list, 'UniformOutput', false);
					
					value = {mean(cell2mat(fi_value_list'), 1)};
					
					rng(rng_settings_)
					
				case 21 % NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nnficv.getPropSeed(21), 'twister')
					
					cell1 = nnficv.get('AV_FEATURE_IMPORTANCE');
					datasets = nnficv.get('NNCV').get('D_LIST');
					if isempty(datasets)
					    value = cell1;
					    return
					end
					cell2 = datasets{1}.get('DP_DICT').get('IT', 1).get('INPUT');
					if ~isequal(numel(cell1), numel(cell2)) 
					    cell1 = nnficv.get('MAP_TO_CELL', cell2mat(cell1), cell2);
					end
					
					value = cell1;
					
					rng(rng_settings_)
					
				case 22 % NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					if isempty(varargin)
					    value = {};
					    return
					end
					vector = varargin{1};
					cell_template = varargin{2};
					mappedCellArray = cell_template;
					index = 1;
					for i = 1:numel(cell_template)
					    cellData = cell_template{i};
					    if iscell(cellData)
					        % Map the vector to nested cell arrays recursively
					        numElements = nnficv.get('COUNT_ELEMENTS', cellData);
					        nestedVector = vector(index:index + numElements - 1);
					        mappedCellArray{i} = nnficv.get('MAP_TO_CELL', nestedVector, cellData);
					        index = index + numElements;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case 23 % NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_data = varargin{1};
					count = 0;
					for i = 1:numel(cell_data)
					    if iscell(cell_data{i})
					        count = count + nnficv.get('COUNT_ELEMENTS', cell_data{i});
					    else
					        count = count + numel(cell_data{i});
					    end
					end
					
					value = count;
					
				case 24 % NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_input = varargin{1};
					flattened_input = [];
					while ~isempty(cell_input)
					    currentData = cell_input{end};  % Get the last element from the stack
					    cell_input = cell_input(1:end-1);   % Remove the last element
					
					    if iscell(currentData)
					        % If it's a cell array, add its contents to the stack
					        cell_input = [cell_input currentData{:}];
					    else
					        % If it's numeric or other data, append it to the vector
					        flattened_input = [currentData(:); flattened_input];
					    end
					end
					value = flattened_input;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(nnficv, prop, varargin{:});
					else
						value = calculateValue@Element(nnficv, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nnficv, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 10 % NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					pr = PanelPropItem('EL', nnficv, 'PROP', 10, ...
					    'BUTTON_TEXT', ['FEATURE IMPORTANCE TEMPLATE (' nnficv.get('FI_TEMPLATE').getClass() ')'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(nnficv, prop, varargin{:});
					
			end
		end
	end
end
