classdef NNClassifierCrossValidation < Element
	% NNClassifierCrossValidation cross-validate the performance of neural network classifiers with a dataset.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% 
	%
	% The list of NNClassifierCrossValidation properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the cross validation.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the cross validation.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the cross validation.
	%  <strong>4</strong> <strong>kfold</strong> 	KFOLD (data, scalar) is the number of folds.
	%  <strong>5</strong> <strong>repetition</strong> 	REPETITION (data, scalar) is the number of repetitions.
	%  <strong>6</strong> <strong>gr1</strong> 	GR1 (data, item) is is a group of subjects.
	%  <strong>7</strong> <strong>gr2</strong> 	GR2 (data, item) is is a group of subjects.
	%  <strong>8</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
	%  <strong>9</strong> <strong>plot_cm</strong> 	PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
	%  <strong>10</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the heat map.
	%  <strong>11</strong> <strong>plot_roc</strong> 	PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
	%  <strong>12</strong> <strong>split_kfold_gr1</strong> 	SPLIT_KFOLD_GR1 (result, cell) is a vector stating which subjects belong to each fold.
	%  <strong>13</strong> <strong>split_kfold_gr2</strong> 	SPLIT_KFOLD_GR2 (result, cell) is a vector stating which subjects belong to each fold.
	%  <strong>14</strong> <strong>nnds_dict</strong> 	NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
	%  <strong>15</strong> <strong>nn_dict</strong> 	NN_DICT (result, idict) contains the NN classifiers for k folds for all repetitions.
	%  <strong>16</strong> <strong>nne_dict</strong> 	NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
	%  <strong>17</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
	%  <strong>18</strong> <strong>confusion_matrix</strong> 	CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeitions.
	%  <strong>19</strong> <strong>auc</strong> 	AUC (result, cell) is the area under the curve scores across k folds for all repetitions.
	%  <strong>20</strong> <strong>auc_ciu</strong> 	AUC_CIU (result, scalar) is the upper boundary of 95% confident internal for AUC.
	%  <strong>21</strong> <strong>auc_cil</strong> 	AUC_CIL (result, scalar) is the lower boundary of 95% confident internal for AUC.
	%  <strong>22</strong> <strong>contribution_map</strong> 	CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
	%
	% NNClassifierCrossValidation methods (constructor):
	% NNClassifierCrossValidation - constructor
	%
	% NNClassifierCrossValidation methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in cross-validation for neural network classifiers/error.
	%  existsProp - checks whether property exists in cross-validation for neural network classifiers/error.
	%  getPropNumber - returns the property number of cross-validation for neural network classifiers.
	%  getProps - returns the property list of cross-validation for neural network classifiers.
	%  getDescription - returns the description of the cross-validation for neural network classifiers.
	%  getName - returns the name of the cross-validation for neural network classifiers.
	%  getClass - returns the class of the cross-validation for neural network classifiers.
	%
	% NNClassifierCrossValidation methods:
	%  get_CI - calculates the 95% confidence interval.
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
	% NNClassifierCrossValidation methods (operators):
	%  isequal - determines whether two NNClassifierCrossValidation are equal (values, locked)
	%
	% NNClassifierCrossValidation methods (display):
	%  tostring - string with information about the NNClassifierCrossValidation
	%  disp - displays information about the NNClassifierCrossValidation
	%  tree - displays the element of NNClassifierCrossValidation
	%
	% NNClassifierCrossValidation method (element list):
	%  getElementList - returns a list with all subelements of NNClassifierCrossValidation
	%
	% NNClassifierCrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNClassifierCrossValidation
	%
	% NNClassifierCrossValidation method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNClassifierCrossValidation
	%
	% NNClassifierCrossValidation methods (copy):
	%  copy - copies the NNClassifierCrossValidation
	%  deepclone - deep-clones the NNClassifierCrossValidation
	%  clone - clones the NNClassifierCrossValidation
	%
	% NNClassifierCrossValidation methods (inspection, Static):
	%  getClass - returns NNClassifierCrossValidation
	%  getName - returns the name of NNClassifierCrossValidation
	%  getDescription - returns the description of NNClassifierCrossValidation
	%  getProps - returns the property list of NNClassifierCrossValidation
	%  getPropNumber - returns the property number of NNClassifierCrossValidation
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
	% NNClassifierCrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierCrossValidation methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNClassifierCrossValidation methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNClassifierCrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNClassifierCrossValidation properties (Constant).
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
	%  KFOLD - 4
	%  KFOLD_TAG - 'kfold'
	%  KFOLD_CATEGORY - 'd'
	%  KFOLD_FORMAT - 'nn'
	%  REPETITION - 5
	%  REPETITION_TAG - 'repetition'
	%  REPETITION_CATEGORY - 'd'
	%  REPETITION_FORMAT - 'nn'
	%  GR1 - 6
	%  GR1_TAG - 'gr1'
	%  GR1_CATEGORY - 'd'
	%  GR1_FORMAT - 'it'
	%  GR2 - 7
	%  GR2_TAG - 'gr2'
	%  GR2_CATEGORY - 'd'
	%  GR2_FORMAT - 'it'
	%  FEATURE_MASK - 8
	%  FEATURE_MASK_TAG - 'feature_mask'
	%  FEATURE_MASK_CATEGORY - 'd'
	%  FEATURE_MASK_FORMAT - 'll'
	%  PLOT_CM - 9
	%  PLOT_CM_TAG - 'plot_cm'
	%  PLOT_CM_CATEGORY - 'd'
	%  PLOT_CM_FORMAT - 'lo'
	%  PLOT_MAP - 10
	%  PLOT_MAP_TAG - 'plot_map'
	%  PLOT_MAP_CATEGORY - 'd'
	%  PLOT_MAP_FORMAT - 'lo'
	%  PLOT_ROC - 11
	%  PLOT_ROC_TAG - 'plot_roc'
	%  PLOT_ROC_CATEGORY - 'd'
	%  PLOT_ROC_FORMAT - 'lo'
	%  SPLIT_KFOLD_GR1 - 12
	%  SPLIT_KFOLD_GR1_TAG - 'split_kfold_gr1'
	%  SPLIT_KFOLD_GR1_CATEGORY - 'r'
	%  SPLIT_KFOLD_GR1_FORMAT - 'll'
	%  SPLIT_KFOLD_GR2 - 13
	%  SPLIT_KFOLD_GR2_TAG - 'split_kfold_gr2'
	%  SPLIT_KFOLD_GR2_CATEGORY - 'r'
	%  SPLIT_KFOLD_GR2_FORMAT - 'll'
	%  NNDS_DICT - 14
	%  NNDS_DICT_TAG - 'nnds_dict'
	%  NNDS_DICT_CATEGORY - 'r'
	%  NNDS_DICT_FORMAT - 'di'
	%  NN_DICT - 15
	%  NN_DICT_TAG - 'nn_dict'
	%  NN_DICT_CATEGORY - 'r'
	%  NN_DICT_FORMAT - 'di'
	%  NNE_DICT - 16
	%  NNE_DICT_TAG - 'nne_dict'
	%  NNE_DICT_CATEGORY - 'r'
	%  NNE_DICT_FORMAT - 'di'
	%  GR_PREDICTION - 17
	%  GR_PREDICTION_TAG - 'gr_prediction'
	%  GR_PREDICTION_CATEGORY - 'r'
	%  GR_PREDICTION_FORMAT - 'it'
	%  CONFUSION_MATRIX - 18
	%  CONFUSION_MATRIX_TAG - 'confusion_matrix'
	%  CONFUSION_MATRIX_CATEGORY - 'r'
	%  CONFUSION_MATRIX_FORMAT - 'nm'
	%  AUC - 19
	%  AUC_TAG - 'auc'
	%  AUC_CATEGORY - 'r'
	%  AUC_FORMAT - 'll'
	%  AUC_CIU - 20
	%  AUC_CIU_TAG - 'auc_ciu'
	%  AUC_CIU_CATEGORY - 'r'
	%  AUC_CIU_FORMAT - 'nn'
	%  AUC_CIL - 21
	%  AUC_CIL_TAG - 'auc_cil'
	%  AUC_CIL_CATEGORY - 'r'
	%  AUC_CIL_FORMAT - 'nn'
	%  CONTRIBUTION_MAP - 22
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
		
		KFOLD = 4;
		KFOLD_TAG = 'kfold';
		KFOLD_CATEGORY = Category.DATA;
		KFOLD_FORMAT = Format.SCALAR;
		
		REPETITION = 5;
		REPETITION_TAG = 'repetition';
		REPETITION_CATEGORY = Category.DATA;
		REPETITION_FORMAT = Format.SCALAR;
		
		GR1 = 6;
		GR1_TAG = 'gr1';
		GR1_CATEGORY = Category.DATA;
		GR1_FORMAT = Format.ITEM;
		
		GR2 = 7;
		GR2_TAG = 'gr2';
		GR2_CATEGORY = Category.DATA;
		GR2_FORMAT = Format.ITEM;
		
		FEATURE_MASK = 8;
		FEATURE_MASK_TAG = 'feature_mask';
		FEATURE_MASK_CATEGORY = Category.DATA;
		FEATURE_MASK_FORMAT = Format.CELL;
		
		PLOT_CM = 9;
		PLOT_CM_TAG = 'plot_cm';
		PLOT_CM_CATEGORY = Category.DATA;
		PLOT_CM_FORMAT = Format.LOGICAL;
		
		PLOT_MAP = 10;
		PLOT_MAP_TAG = 'plot_map';
		PLOT_MAP_CATEGORY = Category.DATA;
		PLOT_MAP_FORMAT = Format.LOGICAL;
		
		PLOT_ROC = 11;
		PLOT_ROC_TAG = 'plot_roc';
		PLOT_ROC_CATEGORY = Category.DATA;
		PLOT_ROC_FORMAT = Format.LOGICAL;
		
		SPLIT_KFOLD_GR1 = 12;
		SPLIT_KFOLD_GR1_TAG = 'split_kfold_gr1';
		SPLIT_KFOLD_GR1_CATEGORY = Category.RESULT;
		SPLIT_KFOLD_GR1_FORMAT = Format.CELL;
		
		SPLIT_KFOLD_GR2 = 13;
		SPLIT_KFOLD_GR2_TAG = 'split_kfold_gr2';
		SPLIT_KFOLD_GR2_CATEGORY = Category.RESULT;
		SPLIT_KFOLD_GR2_FORMAT = Format.CELL;
		
		NNDS_DICT = 14;
		NNDS_DICT_TAG = 'nnds_dict';
		NNDS_DICT_CATEGORY = Category.RESULT;
		NNDS_DICT_FORMAT = Format.IDICT;
		
		NN_DICT = 15;
		NN_DICT_TAG = 'nn_dict';
		NN_DICT_CATEGORY = Category.RESULT;
		NN_DICT_FORMAT = Format.IDICT;
		
		NNE_DICT = 16;
		NNE_DICT_TAG = 'nne_dict';
		NNE_DICT_CATEGORY = Category.RESULT;
		NNE_DICT_FORMAT = Format.IDICT;
		
		GR_PREDICTION = 17;
		GR_PREDICTION_TAG = 'gr_prediction';
		GR_PREDICTION_CATEGORY = Category.RESULT;
		GR_PREDICTION_FORMAT = Format.ITEM;
		
		CONFUSION_MATRIX = 18;
		CONFUSION_MATRIX_TAG = 'confusion_matrix';
		CONFUSION_MATRIX_CATEGORY = Category.RESULT;
		CONFUSION_MATRIX_FORMAT = Format.MATRIX;
		
		AUC = 19;
		AUC_TAG = 'auc';
		AUC_CATEGORY = Category.RESULT;
		AUC_FORMAT = Format.CELL;
		
		AUC_CIU = 20;
		AUC_CIU_TAG = 'auc_ciu';
		AUC_CIU_CATEGORY = Category.RESULT;
		AUC_CIU_FORMAT = Format.SCALAR;
		
		AUC_CIL = 21;
		AUC_CIL_TAG = 'auc_cil';
		AUC_CIL_CATEGORY = Category.RESULT;
		AUC_CIL_FORMAT = Format.SCALAR;
		
		CONTRIBUTION_MAP = 22;
		CONTRIBUTION_MAP_TAG = 'contribution_map';
		CONTRIBUTION_MAP_CATEGORY = Category.RESULT;
		CONTRIBUTION_MAP_FORMAT = Format.MATRIX;
	end
	methods (Static) % inspection methods
		function nncv_class = getClass()
			%GETCLASS returns the class of the cross-validation for neural network classifiers.
			%
			% CLASS = NNClassifierCrossValidation.GETCLASS() returns the class 'NNClassifierCrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the cross-validation for neural network classifiers NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNClassifierCrossValidation') returns 'NNClassifierCrossValidation'.
			%
			% See also getName, getDescription.
			
			nncv_class = 'NNClassifierCrossValidation';
		end
		function nncv_name = getName()
			%GETNAME returns the name of the cross-validation for neural network classifiers.
			%
			% NAME = NNClassifierCrossValidation.GETNAME() returns the name of the 'cross-validation for neural network classifiers'.
			%  Cross-Validation For Neural Network Classifiers.
			%
			% Alternative forms to call this method are:
			%  NAME = NNCV.GETNAME() returns the name of the cross-validation for neural network classifiers NNCV.
			%  NAME = Element.GETNAME(NNCV) returns the name of 'NNCV'.
			%  NAME = Element.GETNAME('NNClassifierCrossValidation') returns the name of 'NNClassifierCrossValidation'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nncv_name = 'Cross-Validation For Neural Network Classifiers';
		end
		function nncv_description = getDescription()
			%GETDESCRIPTION returns the description of the cross-validation for neural network classifiers.
			%
			% STR = NNClassifierCrossValidation.GETDESCRIPTION() returns the description of the 'cross-validation for neural network classifiers'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNCV.GETDESCRIPTION() returns the description of the cross-validation for neural network classifiers NNCV.
			%  STR = Element.GETDESCRIPTION(NNCV) returns the description of 'NNCV'.
			%  STR = Element.GETDESCRIPTION('NNClassifierCrossValidation') returns the description of 'NNClassifierCrossValidation'.
			%
			% See also getClass, getName.
			
			nncv_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cross-validation for neural network classifiers.
			%
			% PROPS = NNClassifierCrossValidation.GETPROPS() returns the property list of cross-validation for neural network classifiers.
			%
			% PROPS = NNClassifierCrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the cross-validation for neural network classifiers NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNClassifierCrossValidation'[, CATEGORY]) returns the property list of 'NNClassifierCrossValidation'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNClassifierCrossValidation.LABEL
						NNClassifierCrossValidation.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNClassifierCrossValidation.ID
						NNClassifierCrossValidation.KFOLD
						NNClassifierCrossValidation.REPETITION
						NNClassifierCrossValidation.GR1
						NNClassifierCrossValidation.GR2
						NNClassifierCrossValidation.FEATURE_MASK
						NNClassifierCrossValidation.PLOT_CM
						NNClassifierCrossValidation.PLOT_MAP
						NNClassifierCrossValidation.PLOT_ROC
						];
				case Category.RESULT
					prop_list = [
						NNClassifierCrossValidation.SPLIT_KFOLD_GR1
						NNClassifierCrossValidation.SPLIT_KFOLD_GR2
						NNClassifierCrossValidation.NNDS_DICT
						NNClassifierCrossValidation.NN_DICT
						NNClassifierCrossValidation.NNE_DICT
						NNClassifierCrossValidation.GR_PREDICTION
						NNClassifierCrossValidation.CONFUSION_MATRIX
						NNClassifierCrossValidation.AUC
						NNClassifierCrossValidation.AUC_CIU
						NNClassifierCrossValidation.AUC_CIL
						NNClassifierCrossValidation.CONTRIBUTION_MAP
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNClassifierCrossValidation.ID
						NNClassifierCrossValidation.LABEL
						NNClassifierCrossValidation.NOTES
						NNClassifierCrossValidation.KFOLD
						NNClassifierCrossValidation.REPETITION
						NNClassifierCrossValidation.GR1
						NNClassifierCrossValidation.GR2
						NNClassifierCrossValidation.FEATURE_MASK
						NNClassifierCrossValidation.PLOT_CM
						NNClassifierCrossValidation.PLOT_MAP
						NNClassifierCrossValidation.PLOT_ROC
						NNClassifierCrossValidation.SPLIT_KFOLD_GR1
						NNClassifierCrossValidation.SPLIT_KFOLD_GR2
						NNClassifierCrossValidation.NNDS_DICT
						NNClassifierCrossValidation.NN_DICT
						NNClassifierCrossValidation.NNE_DICT
						NNClassifierCrossValidation.GR_PREDICTION
						NNClassifierCrossValidation.CONFUSION_MATRIX
						NNClassifierCrossValidation.AUC
						NNClassifierCrossValidation.AUC_CIU
						NNClassifierCrossValidation.AUC_CIL
						NNClassifierCrossValidation.CONTRIBUTION_MAP
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of cross-validation for neural network classifiers.
			%
			% N = NNClassifierCrossValidation.GETPROPNUMBER() returns the property number of cross-validation for neural network classifiers.
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER() returns the property number of the cross-validation for neural network classifiers NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNClassifierCrossValidation') returns the property number of 'NNClassifierCrossValidation'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 22;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in cross-validation for neural network classifiers/error.
			%
			% CHECK = NNClassifierCrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNClassifierCrossValidation, PROP) checks whether PROP exists for NNClassifierCrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNClassifierCrossValidation, PROP) throws error if PROP does NOT exist for NNClassifierCrossValidation.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22 ]);
			else
				assert( ...
					NNClassifierCrossValidation.existsProp(prop), ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierCrossValidation.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cross-validation for neural network classifiers/error.
			%
			% CHECK = NNClassifierCrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNClassifierCrossValidation, TAG) checks whether TAG exists for NNClassifierCrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNClassifierCrossValidation, TAG) throws error if TAG does NOT exist for NNClassifierCrossValidation.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifiercrossvalidation_tag_list = { 'id'  'label'  'notes'  'kfold'  'repetition'  'gr1'  'gr2'  'feature_mask'  'plot_cm'  'plot_map'  'plot_roc'  'split_kfold_gr1'  'split_kfold_gr2'  'nnds_dict'  'nn_dict'  'nne_dict'  'gr_prediction'  'confusion_matrix'  'auc'  'auc_ciu'  'auc_cil'  'contribution_map' };
				
				check = any(strcmpi(tag, nnclassifiercrossvalidation_tag_list));
			else
				assert( ...
					NNClassifierCrossValidation.existsTag(tag), ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNClassifierCrossValidation'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierCrossValidation, POINTER) returns property number of POINTER of NNClassifierCrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNClassifierCrossValidation, POINTER) returns property number of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifiercrossvalidation_tag_list = { 'id'  'label'  'notes'  'kfold'  'repetition'  'gr1'  'gr2'  'feature_mask'  'plot_cm'  'plot_map'  'plot_roc'  'split_kfold_gr1'  'split_kfold_gr2'  'nnds_dict'  'nn_dict'  'nne_dict'  'gr_prediction'  'confusion_matrix'  'auc'  'auc_ciu'  'auc_cil'  'contribution_map' };
				
				tag = pointer;
				NNClassifierCrossValidation.existsTag(tag);
				
				prop = find(strcmpi(tag, nnclassifiercrossvalidation_tag_list));
			else % numeric
				prop = pointer;
				NNClassifierCrossValidation.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNClassifierCrossValidation, POINTER) returns tag of POINTER of NNClassifierCrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNClassifierCrossValidation, POINTER) returns tag of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNClassifierCrossValidation.existsTag(tag);
			else % numeric
				prop = pointer;
				NNClassifierCrossValidation.existsProp(prop);
				
				switch prop
					case NNClassifierCrossValidation.ID
						tag = NNClassifierCrossValidation.ID_TAG;
					case NNClassifierCrossValidation.LABEL
						tag = NNClassifierCrossValidation.LABEL_TAG;
					case NNClassifierCrossValidation.NOTES
						tag = NNClassifierCrossValidation.NOTES_TAG;
					case NNClassifierCrossValidation.KFOLD
						tag = NNClassifierCrossValidation.KFOLD_TAG;
					case NNClassifierCrossValidation.REPETITION
						tag = NNClassifierCrossValidation.REPETITION_TAG;
					case NNClassifierCrossValidation.GR1
						tag = NNClassifierCrossValidation.GR1_TAG;
					case NNClassifierCrossValidation.GR2
						tag = NNClassifierCrossValidation.GR2_TAG;
					case NNClassifierCrossValidation.FEATURE_MASK
						tag = NNClassifierCrossValidation.FEATURE_MASK_TAG;
					case NNClassifierCrossValidation.PLOT_CM
						tag = NNClassifierCrossValidation.PLOT_CM_TAG;
					case NNClassifierCrossValidation.PLOT_MAP
						tag = NNClassifierCrossValidation.PLOT_MAP_TAG;
					case NNClassifierCrossValidation.PLOT_ROC
						tag = NNClassifierCrossValidation.PLOT_ROC_TAG;
					case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
						tag = NNClassifierCrossValidation.SPLIT_KFOLD_GR1_TAG;
					case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
						tag = NNClassifierCrossValidation.SPLIT_KFOLD_GR2_TAG;
					case NNClassifierCrossValidation.NNDS_DICT
						tag = NNClassifierCrossValidation.NNDS_DICT_TAG;
					case NNClassifierCrossValidation.NN_DICT
						tag = NNClassifierCrossValidation.NN_DICT_TAG;
					case NNClassifierCrossValidation.NNE_DICT
						tag = NNClassifierCrossValidation.NNE_DICT_TAG;
					case NNClassifierCrossValidation.GR_PREDICTION
						tag = NNClassifierCrossValidation.GR_PREDICTION_TAG;
					case NNClassifierCrossValidation.CONFUSION_MATRIX
						tag = NNClassifierCrossValidation.CONFUSION_MATRIX_TAG;
					case NNClassifierCrossValidation.AUC
						tag = NNClassifierCrossValidation.AUC_TAG;
					case NNClassifierCrossValidation.AUC_CIU
						tag = NNClassifierCrossValidation.AUC_CIU_TAG;
					case NNClassifierCrossValidation.AUC_CIL
						tag = NNClassifierCrossValidation.AUC_CIL_TAG;
					case NNClassifierCrossValidation.CONTRIBUTION_MAP
						tag = NNClassifierCrossValidation.CONTRIBUTION_MAP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierCrossValidation, POINTER) returns category of POINTER of NNClassifierCrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNClassifierCrossValidation, POINTER) returns category of POINTER of NNClassifierCrossValidation.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					prop_category = NNClassifierCrossValidation.ID_CATEGORY;
				case NNClassifierCrossValidation.LABEL
					prop_category = NNClassifierCrossValidation.LABEL_CATEGORY;
				case NNClassifierCrossValidation.NOTES
					prop_category = NNClassifierCrossValidation.NOTES_CATEGORY;
				case NNClassifierCrossValidation.KFOLD
					prop_category = NNClassifierCrossValidation.KFOLD_CATEGORY;
				case NNClassifierCrossValidation.REPETITION
					prop_category = NNClassifierCrossValidation.REPETITION_CATEGORY;
				case NNClassifierCrossValidation.GR1
					prop_category = NNClassifierCrossValidation.GR1_CATEGORY;
				case NNClassifierCrossValidation.GR2
					prop_category = NNClassifierCrossValidation.GR2_CATEGORY;
				case NNClassifierCrossValidation.FEATURE_MASK
					prop_category = NNClassifierCrossValidation.FEATURE_MASK_CATEGORY;
				case NNClassifierCrossValidation.PLOT_CM
					prop_category = NNClassifierCrossValidation.PLOT_CM_CATEGORY;
				case NNClassifierCrossValidation.PLOT_MAP
					prop_category = NNClassifierCrossValidation.PLOT_MAP_CATEGORY;
				case NNClassifierCrossValidation.PLOT_ROC
					prop_category = NNClassifierCrossValidation.PLOT_ROC_CATEGORY;
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					prop_category = NNClassifierCrossValidation.SPLIT_KFOLD_GR1_CATEGORY;
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					prop_category = NNClassifierCrossValidation.SPLIT_KFOLD_GR2_CATEGORY;
				case NNClassifierCrossValidation.NNDS_DICT
					prop_category = NNClassifierCrossValidation.NNDS_DICT_CATEGORY;
				case NNClassifierCrossValidation.NN_DICT
					prop_category = NNClassifierCrossValidation.NN_DICT_CATEGORY;
				case NNClassifierCrossValidation.NNE_DICT
					prop_category = NNClassifierCrossValidation.NNE_DICT_CATEGORY;
				case NNClassifierCrossValidation.GR_PREDICTION
					prop_category = NNClassifierCrossValidation.GR_PREDICTION_CATEGORY;
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					prop_category = NNClassifierCrossValidation.CONFUSION_MATRIX_CATEGORY;
				case NNClassifierCrossValidation.AUC
					prop_category = NNClassifierCrossValidation.AUC_CATEGORY;
				case NNClassifierCrossValidation.AUC_CIU
					prop_category = NNClassifierCrossValidation.AUC_CIU_CATEGORY;
				case NNClassifierCrossValidation.AUC_CIL
					prop_category = NNClassifierCrossValidation.AUC_CIL_CATEGORY;
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					prop_category = NNClassifierCrossValidation.CONTRIBUTION_MAP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierCrossValidation, POINTER) returns format of POINTER of NNClassifierCrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNClassifierCrossValidation, POINTER) returns format of POINTER of NNClassifierCrossValidation.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					prop_format = NNClassifierCrossValidation.ID_FORMAT;
				case NNClassifierCrossValidation.LABEL
					prop_format = NNClassifierCrossValidation.LABEL_FORMAT;
				case NNClassifierCrossValidation.NOTES
					prop_format = NNClassifierCrossValidation.NOTES_FORMAT;
				case NNClassifierCrossValidation.KFOLD
					prop_format = NNClassifierCrossValidation.KFOLD_FORMAT;
				case NNClassifierCrossValidation.REPETITION
					prop_format = NNClassifierCrossValidation.REPETITION_FORMAT;
				case NNClassifierCrossValidation.GR1
					prop_format = NNClassifierCrossValidation.GR1_FORMAT;
				case NNClassifierCrossValidation.GR2
					prop_format = NNClassifierCrossValidation.GR2_FORMAT;
				case NNClassifierCrossValidation.FEATURE_MASK
					prop_format = NNClassifierCrossValidation.FEATURE_MASK_FORMAT;
				case NNClassifierCrossValidation.PLOT_CM
					prop_format = NNClassifierCrossValidation.PLOT_CM_FORMAT;
				case NNClassifierCrossValidation.PLOT_MAP
					prop_format = NNClassifierCrossValidation.PLOT_MAP_FORMAT;
				case NNClassifierCrossValidation.PLOT_ROC
					prop_format = NNClassifierCrossValidation.PLOT_ROC_FORMAT;
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					prop_format = NNClassifierCrossValidation.SPLIT_KFOLD_GR1_FORMAT;
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					prop_format = NNClassifierCrossValidation.SPLIT_KFOLD_GR2_FORMAT;
				case NNClassifierCrossValidation.NNDS_DICT
					prop_format = NNClassifierCrossValidation.NNDS_DICT_FORMAT;
				case NNClassifierCrossValidation.NN_DICT
					prop_format = NNClassifierCrossValidation.NN_DICT_FORMAT;
				case NNClassifierCrossValidation.NNE_DICT
					prop_format = NNClassifierCrossValidation.NNE_DICT_FORMAT;
				case NNClassifierCrossValidation.GR_PREDICTION
					prop_format = NNClassifierCrossValidation.GR_PREDICTION_FORMAT;
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					prop_format = NNClassifierCrossValidation.CONFUSION_MATRIX_FORMAT;
				case NNClassifierCrossValidation.AUC
					prop_format = NNClassifierCrossValidation.AUC_FORMAT;
				case NNClassifierCrossValidation.AUC_CIU
					prop_format = NNClassifierCrossValidation.AUC_CIU_FORMAT;
				case NNClassifierCrossValidation.AUC_CIL
					prop_format = NNClassifierCrossValidation.AUC_CIL_FORMAT;
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					prop_format = NNClassifierCrossValidation.CONTRIBUTION_MAP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierCrossValidation, POINTER) returns description of POINTER of NNClassifierCrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNClassifierCrossValidation, POINTER) returns description of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					prop_description = 'ID (data, string) is a few-letter code for the cross validation.';
				case NNClassifierCrossValidation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cross validation.';
				case NNClassifierCrossValidation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cross validation.';
				case NNClassifierCrossValidation.KFOLD
					prop_description = 'KFOLD (data, scalar) is the number of folds.';
				case NNClassifierCrossValidation.REPETITION
					prop_description = 'REPETITION (data, scalar) is the number of repetitions.';
				case NNClassifierCrossValidation.GR1
					prop_description = 'GR1 (data, item) is is a group of subjects.';
				case NNClassifierCrossValidation.GR2
					prop_description = 'GR2 (data, item) is is a group of subjects.';
				case NNClassifierCrossValidation.FEATURE_MASK
					prop_description = 'FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.';
				case NNClassifierCrossValidation.PLOT_CM
					prop_description = 'PLOT_CM (data, logical) is an option for the plot of the confusion matrix.';
				case NNClassifierCrossValidation.PLOT_MAP
					prop_description = 'PLOT_MAP (data, logical) is an option for the plot of the heat map.';
				case NNClassifierCrossValidation.PLOT_ROC
					prop_description = 'PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.';
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					prop_description = 'SPLIT_KFOLD_GR1 (result, cell) is a vector stating which subjects belong to each fold.';
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					prop_description = 'SPLIT_KFOLD_GR2 (result, cell) is a vector stating which subjects belong to each fold.';
				case NNClassifierCrossValidation.NNDS_DICT
					prop_description = 'NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.';
				case NNClassifierCrossValidation.NN_DICT
					prop_description = 'NN_DICT (result, idict) contains the NN classifiers for k folds for all repetitions.';
				case NNClassifierCrossValidation.NNE_DICT
					prop_description = 'NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.';
				case NNClassifierCrossValidation.GR_PREDICTION
					prop_description = 'GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.';
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					prop_description = 'CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeitions.';
				case NNClassifierCrossValidation.AUC
					prop_description = 'AUC (result, cell) is the area under the curve scores across k folds for all repetitions.';
				case NNClassifierCrossValidation.AUC_CIU
					prop_description = 'AUC_CIU (result, scalar) is the upper boundary of 95% confident internal for AUC.';
				case NNClassifierCrossValidation.AUC_CIL
					prop_description = 'AUC_CIL (result, scalar) is the lower boundary of 95% confident internal for AUC.';
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierCrossValidation, POINTER) returns settings of POINTER of NNClassifierCrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNClassifierCrossValidation, POINTER) returns settings of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNClassifierCrossValidation.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNClassifierCrossValidation.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNClassifierCrossValidation.KFOLD
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierCrossValidation.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierCrossValidation.GR1
					prop_settings = 'NNGroup';
				case NNClassifierCrossValidation.GR2
					prop_settings = 'NNGroup';
				case NNClassifierCrossValidation.FEATURE_MASK
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierCrossValidation.PLOT_CM
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierCrossValidation.PLOT_MAP
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierCrossValidation.PLOT_ROC
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierCrossValidation.NNDS_DICT
					prop_settings = 'NNClassifierDataSplit';
				case NNClassifierCrossValidation.NN_DICT
					prop_settings = 'NNClassifierDNN';
				case NNClassifierCrossValidation.NNE_DICT
					prop_settings = 'NNClassifierEvaluator';
				case NNClassifierCrossValidation.GR_PREDICTION
					prop_settings = 'NNGroup';
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierCrossValidation.AUC
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierCrossValidation.AUC_CIU
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierCrossValidation.AUC_CIL
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					prop_settings = Format.getFormatSettings(Format.MATRIX);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierCrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierCrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierCrossValidation, POINTER) returns the default value of POINTER of NNClassifierCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNClassifierCrossValidation, POINTER) returns the default value of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					prop_default = Format.getFormatDefault(Format.STRING, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.KFOLD
					prop_default = 5;
				case NNClassifierCrossValidation.REPETITION
					prop_default = 1;
				case NNClassifierCrossValidation.GR1
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.GR2
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.FEATURE_MASK
					prop_default = num2cell(0.05);
				case NNClassifierCrossValidation.PLOT_CM
					prop_default = true;
				case NNClassifierCrossValidation.PLOT_MAP
					prop_default = true;
				case NNClassifierCrossValidation.PLOT_ROC
					prop_default = true;
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NNDS_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNClassifierDataSplit');
				case NNClassifierCrossValidation.NN_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNClassifierDNN');
				case NNClassifierCrossValidation.NNE_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator');
				case NNClassifierCrossValidation.GR_PREDICTION
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC_CIU
					prop_default = Format.getFormatDefault(Format.SCALAR, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC_CIL
					prop_default = Format.getFormatDefault(Format.SCALAR, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierCrossValidation.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierCrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierCrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierCrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNClassifierCrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierCrossValidation.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			prop_default = NNClassifierCrossValidation.conditioning(prop, NNClassifierCrossValidation.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierCrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNClassifierCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierCrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  Element.CHECKPROP(NNClassifierCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierCrossValidation.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			%  NNCV.CHECKPROP(NNClassifierCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierCrossValidation.
			%   Error id: [BRAPH2:NNClassifierCrossValidation:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.ID
					check = Format.checkFormat(Format.STRING, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.LABEL
					check = Format.checkFormat(Format.STRING, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NOTES
					check = Format.checkFormat(Format.STRING, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.KFOLD
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.REPETITION
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.GR1
					check = Format.checkFormat(Format.ITEM, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.GR2
					check = Format.checkFormat(Format.ITEM, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.FEATURE_MASK
					check = Format.checkFormat(Format.CELL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.PLOT_CM
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.PLOT_MAP
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.PLOT_ROC
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					check = Format.checkFormat(Format.CELL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					check = Format.checkFormat(Format.CELL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NNDS_DICT
					check = Format.checkFormat(Format.IDICT, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NN_DICT
					check = Format.checkFormat(Format.IDICT, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.NNE_DICT
					check = Format.checkFormat(Format.IDICT, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.GR_PREDICTION
					check = Format.checkFormat(Format.ITEM, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC
					check = Format.checkFormat(Format.CELL, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC_CIU
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.AUC_CIL
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierCrossValidation.getPropSettings(prop));
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierCrossValidation.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierCrossValidation:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierCrossValidation.getPropTag(prop) ' (' NNClassifierCrossValidation.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nncv = NNClassifierCrossValidation(varargin)
			% NNClassifierCrossValidation() creates a cross-validation for neural network classifiers.
			%
			% NNClassifierCrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierCrossValidation(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierCrossValidation properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the cross validation.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the cross validation.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the cross validation.
			%  <strong>4</strong> <strong>kfold</strong> 	KFOLD (data, scalar) is the number of folds.
			%  <strong>5</strong> <strong>repetition</strong> 	REPETITION (data, scalar) is the number of repetitions.
			%  <strong>6</strong> <strong>gr1</strong> 	GR1 (data, item) is is a group of subjects.
			%  <strong>7</strong> <strong>gr2</strong> 	GR2 (data, item) is is a group of subjects.
			%  <strong>8</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
			%  <strong>9</strong> <strong>plot_cm</strong> 	PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
			%  <strong>10</strong> <strong>plot_map</strong> 	PLOT_MAP (data, logical) is an option for the plot of the heat map.
			%  <strong>11</strong> <strong>plot_roc</strong> 	PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
			%  <strong>12</strong> <strong>split_kfold_gr1</strong> 	SPLIT_KFOLD_GR1 (result, cell) is a vector stating which subjects belong to each fold.
			%  <strong>13</strong> <strong>split_kfold_gr2</strong> 	SPLIT_KFOLD_GR2 (result, cell) is a vector stating which subjects belong to each fold.
			%  <strong>14</strong> <strong>nnds_dict</strong> 	NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
			%  <strong>15</strong> <strong>nn_dict</strong> 	NN_DICT (result, idict) contains the NN classifiers for k folds for all repetitions.
			%  <strong>16</strong> <strong>nne_dict</strong> 	NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
			%  <strong>17</strong> <strong>gr_prediction</strong> 	GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
			%  <strong>18</strong> <strong>confusion_matrix</strong> 	CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeitions.
			%  <strong>19</strong> <strong>auc</strong> 	AUC (result, cell) is the area under the curve scores across k folds for all repetitions.
			%  <strong>20</strong> <strong>auc_ciu</strong> 	AUC_CIU (result, scalar) is the upper boundary of 95% confident internal for AUC.
			%  <strong>21</strong> <strong>auc_cil</strong> 	AUC_CIL (result, scalar) is the lower boundary of 95% confident internal for AUC.
			%  <strong>22</strong> <strong>contribution_map</strong> 	CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
			%
			% See also Category, Format, set, check.
			
			nncv = nncv@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNClassifierCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierCrossValidation.FEATURE_MASK
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
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR1
					rng(nncv.getPropSeed(NNClassifierCrossValidation.SPLIT_KFOLD_GR1), 'twister')
					
					num_per_class = nncv.get('GR1').get('SUB_DICT').length;
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
					
				case NNClassifierCrossValidation.SPLIT_KFOLD_GR2
					rng(nncv.getPropSeed(NNClassifierCrossValidation.SPLIT_KFOLD_GR2), 'twister')
					
					num_per_class = nncv.get('GR2').get('SUB_DICT').length;
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
					
				case NNClassifierCrossValidation.NNDS_DICT
					rng(nncv.getPropSeed(NNClassifierCrossValidation.NNDS_DICT), 'twister')
					
					nnds_dict = IndexedDictionary('IT_CLASS', 'NNClassifierDataSplit');
					if ~isa(nncv.get('GR1').getr('SUB_DICT'), 'NoValue')
					    for i = 1:1:nncv.get('REPETITION')
					        idx_per_fold_gr1 = nncv.get('SPLIT_KFOLD_GR1');
					        idx_per_fold_gr2 = nncv.get('SPLIT_KFOLD_GR2');
					        for j = 1:1:nncv.get('KFOLD')
					            nnds = NNClassifierDataSplit( ...
					                'ID', ['kfold ', num2str(j), ' repetition ', num2str(i)], ...
					                'GR1', nncv.get('GR1'), ...
					                'GR2', nncv.get('GR2'), ...
					                'SPLIT_GR1', idx_per_fold_gr1{j}, ...
					                'SPLIT_GR2', idx_per_fold_gr2{j}, ...
					                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
					                );
					
					            nnds.memorize('GR_VAL_FS');
					            nnds.memorize('GR_TRAIN_FS');
					
					            nnds_dict.add(nnds)
					        end
					    end
					end
					
					value = nnds_dict;
					
				case NNClassifierCrossValidation.NN_DICT
					rng(nncv.getPropSeed(NNClassifierCrossValidation.NN_DICT), 'twister')
					
					nn_dict = IndexedDictionary('IT_CLASS', 'NNClassifierDNN');
					if nncv.memorize('NNDS_DICT').length() > 0
					    for i = 1:1:nncv.get('NNDS_DICT').length()
					        nnds = nncv.get('NNDS_DICT').getItem(i);
					        gr_train = nnds.get('GR_TRAIN_FS');
					
					        nn = NNClassifierDNN( ...
					                'ID', nnds.get('ID'), ...
					                'GR', gr_train, ...
					                'VERBOSE', false, ...
					                'PLOT_TRAINING', false, ...
					                'SHUFFLE', 'every-epoch' ...
					                );
					            
					        nn_dict.add(nn)
					    end
					end
					
					value = nn_dict;
					
				case NNClassifierCrossValidation.NNE_DICT
					rng(nncv.getPropSeed(NNClassifierCrossValidation.NNE_DICT), 'twister')
					
					nne_dict = IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator');
					if nncv.memorize('NN_DICT').length() > 0
					    for i = 1:1:nncv.get('NN_DICT').length()
					        nn = nncv.get('NN_DICT').getItem(i);
					        nnds = nncv.get('NNDS_DICT').getItem(i);
					        gr_val = nnds.get('GR_VAL_FS');
					
					        nne = NNClassifierEvaluator( ...
					                'ID', nn.get('ID'), ...
					                'GR', gr_val, ...
					                'NN', nn ...
					                );
					            
					        nne_dict.add(nne)
					    end
					end
					
					value = nne_dict;
					
				case NNClassifierCrossValidation.GR_PREDICTION
					rng(nncv.getPropSeed(NNClassifierCrossValidation.GR_PREDICTION), 'twister')
					
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
					
				case NNClassifierCrossValidation.CONFUSION_MATRIX
					rng(nncv.getPropSeed(NNClassifierCrossValidation.CONFUSION_MATRIX), 'twister')
					
					if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
					    value = [];
					else
					    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
					    pred = cell2mat(pred);
					    pred = pred > 0.5;
					
					    % get ground truth
					    nn = nncv.get('NN_DICT').getItem(1);
					    gr = nncv.get('GR_PREDICTION');
					    [inputs, ~] = nn.reconstruct_inputs(gr);
					    [targets, classes] = nn.reconstruct_targets(gr);
					    % calculate the confusion matrix
						[cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
					    if nncv.get('PLOT_CM')
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
					
				case NNClassifierCrossValidation.AUC
					rng(nncv.getPropSeed(NNClassifierCrossValidation.AUC), 'twister')
					
					nne_dict = nncv.memorize('NNE_DICT');
					auc = {};
					X = {};
					Y = {};
					if nne_dict.length() > 0
					    for i = 1:1:nne_dict.length()
					        auc_val = nne_dict.getItem(i).get('AUC');
					        auc{i} = auc_val{1};
					        X{i} = auc_val{2};
					        Y{i} = auc_val{3};
					    end
					
					    if nncv.get('PLOT_ROC')
					        intervals = linspace(0, 1, 100);
					        mean_curve = 0;
					        for i = 1:1:nne_dict.length()
					            hline(i) = plot(X{i}, Y{i}, 'k-', 'LineWidth', 1.5);
					            hline(i).Color = [hline(i).Color 0.05];
					            hold on;
					            Xadjusted = zeros(1, length(X{i}));
					            aux= 0.00001;
					            for j = 1 : length(X{i})
					                if j ~= 1
					                    Xadjusted(j) = X{i}(j) + aux;
					                    aux = aux + 0.00001;
					                end
					            end
					            mean_curve = mean_curve + (interp1(Xadjusted, Y{i}, intervals))/nne_dict.length();
					        end
					        hline(i + 1) = plot(intervals, mean_curve, 'Color', 'Black', 'LineWidth', 3.0);
					        xlabel('False positive rate');
					        ylabel('True positive rate');
					        title('ROC for Classification');
					        legend(hline(i+1), sprintf('average ROCs (AU-ROC = %.2f)', mean(cell2mat(auc))), 'Location', 'southeast', 'FontSize', 12);
					        legend('boxoff');
					        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
					        if ~exist(directory, 'dir')
					            mkdir(directory)
					        end
					        filename = [directory filesep 'cv_roc.svg'];
					        saveas(gcf, filename);
					    end
					    value = {auc, X, Y};
					else
					    value = {};
					end
					
				case NNClassifierCrossValidation.AUC_CIU
					rng(nncv.getPropSeed(NNClassifierCrossValidation.AUC_CIU), 'twister')
					
					auc = nncv.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    [~, CI] = nncv.get_CI(auc{1});
					    value = CI(2);
					end
					
				case NNClassifierCrossValidation.AUC_CIL
					rng(nncv.getPropSeed(NNClassifierCrossValidation.AUC_CIL), 'twister')
					
					auc = nncv.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    [~, CI] = nncv.get_CI(auc{1});
					    value = CI(1);
					end
					
				case NNClassifierCrossValidation.CONTRIBUTION_MAP
					rng(nncv.getPropSeed(NNClassifierCrossValidation.CONTRIBUTION_MAP), 'twister')
					
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
	methods % GUI
		function pr = getPlotProp(nncv, prop, varargin)
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
				case NNClassifierCrossValidation.GR_PREDICTION
					pr = PPNNData_GR_NN('EL', nncv, 'PROP', NNClassifierCrossValidation.GR_PREDICTION, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(nncv, prop, varargin{:});
					
			end
		end
	end
end
