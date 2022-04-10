classdef NNClassifierDataSplit < NNDataSplit
	% NNClassifierDataSplit split a dataset into training set and validation set for classification.
	% It is a subclass of <a href="matlab:help NNDataSplit">NNDataSplit</a>.
	%
	% 
	%
	% The list of NNClassifierDataSplit properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>gr_train</strong> 	GR_TRAIN (result, item) is a group of NN subjects for the training set.
	%  <strong>6</strong> <strong>gr_val</strong> 	GR_VAL (result, item) is a group of NN subjects for the validation set.
	%  <strong>7</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
	%  <strong>8</strong> <strong>feature_selection_analysis</strong> 	FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
	%  <strong>9</strong> <strong>gr_train_fs</strong> 	GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
	%  <strong>10</strong> <strong>gr_val_fs</strong> 	GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.
	%  <strong>11</strong> <strong>gr1</strong> 	GR1 (data, item) is a group of NN subjects.
	%  <strong>12</strong> <strong>gr2</strong> 	GR2 (data, item) is a group of NN subjects.
	%  <strong>13</strong> <strong>split_gr1</strong> 	SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
	%  <strong>14</strong> <strong>split_gr2</strong> 	SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
	%
	% NNClassifierDataSplit methods (constructor):
	% NNClassifierDataSplit - constructor
	%
	% NNClassifierDataSplit methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in data split for a neural network classifier/error.
	%  existsProp - checks whether property exists in data split for a neural network classifier/error.
	%  getPropNumber - returns the property number of data split for a neural network classifier.
	%  getProps - returns the property list of data split for a neural network classifier.
	%  getDescription - returns the description of the data split for a neural network classifier.
	%  getName - returns the name of the data split for a neural network classifier.
	%  getClass - returns the class of the data split for a neural network classifier.
	%
	% NNClassifierDataSplit methods:
	%  getPlotProp - returns a prop plot.
	%  mutual_information_analysis - computes the mutual information value.
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
	% NNClassifierDataSplit methods (operators):
	%  isequal - determines whether two NNClassifierDataSplit are equal (values, locked)
	%
	% NNClassifierDataSplit methods (display):
	%  tostring - string with information about the NNClassifierDataSplit
	%  disp - displays information about the NNClassifierDataSplit
	%  tree - displays the element of NNClassifierDataSplit
	%
	% NNClassifierDataSplit method (element list):
	%  getElementList - returns a list with all subelements of NNClassifierDataSplit
	%
	% NNClassifierDataSplit method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNClassifierDataSplit
	%
	% NNClassifierDataSplit method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNClassifierDataSplit
	%
	% NNClassifierDataSplit methods (copy):
	%  copy - copies the NNClassifierDataSplit
	%  deepclone - deep-clones the NNClassifierDataSplit
	%  clone - clones the NNClassifierDataSplit
	%
	% NNClassifierDataSplit methods (inspection, Static):
	%  getClass - returns NNClassifierDataSplit
	%  getName - returns the name of NNClassifierDataSplit
	%  getDescription - returns the description of NNClassifierDataSplit
	%  getProps - returns the property list of NNClassifierDataSplit
	%  getPropNumber - returns the property number of NNClassifierDataSplit
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
	% NNClassifierDataSplit methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierDataSplit methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNClassifierDataSplit methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNClassifierDataSplit methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNClassifierDataSplit properties (Constant).
	%  GR1 - 11
	%  GR1_TAG - 'gr1'
	%  GR1_CATEGORY - 'd'
	%  GR1_FORMAT - 'it'
	%  GR2 - 12
	%  GR2_TAG - 'gr2'
	%  GR2_CATEGORY - 'd'
	%  GR2_FORMAT - 'it'
	%  SPLIT_GR1 - 13
	%  SPLIT_GR1_TAG - 'split_gr1'
	%  SPLIT_GR1_CATEGORY - 'd'
	%  SPLIT_GR1_FORMAT - 'nr'
	%  SPLIT_GR2 - 14
	%  SPLIT_GR2_TAG - 'split_gr2'
	%  SPLIT_GR2_CATEGORY - 'd'
	%  SPLIT_GR2_FORMAT - 'nr'
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
	%  WAITBAR - 4
	%  WAITBAR_TAG - 'waitbar'
	%  WAITBAR_CATEGORY - 'm'
	%  WAITBAR_FORMAT - 'lo'
	%  GR_TRAIN - 5
	%  GR_TRAIN_TAG - 'gr_train'
	%  GR_TRAIN_CATEGORY - 'r'
	%  GR_TRAIN_FORMAT - 'it'
	%  GR_VAL - 6
	%  GR_VAL_TAG - 'gr_val'
	%  GR_VAL_CATEGORY - 'r'
	%  GR_VAL_FORMAT - 'it'
	%  FEATURE_MASK - 7
	%  FEATURE_MASK_TAG - 'feature_mask'
	%  FEATURE_MASK_CATEGORY - 'd'
	%  FEATURE_MASK_FORMAT - 'll'
	%  FEATURE_SELECTION_ANALYSIS - 8
	%  FEATURE_SELECTION_ANALYSIS_TAG - 'feature_selection_analysis'
	%  FEATURE_SELECTION_ANALYSIS_CATEGORY - 'r'
	%  FEATURE_SELECTION_ANALYSIS_FORMAT - 'll'
	%  GR_TRAIN_FS - 9
	%  GR_TRAIN_FS_TAG - 'gr_train_fs'
	%  GR_TRAIN_FS_CATEGORY - 'r'
	%  GR_TRAIN_FS_FORMAT - 'it'
	%  GR_VAL_FS - 10
	%  GR_VAL_FS_TAG - 'gr_val_fs'
	%  GR_VAL_FS_CATEGORY - 'r'
	%  GR_VAL_FS_FORMAT - 'it'
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
		GR1 = NNDataSplit.getPropNumber() + 1;
		GR1_TAG = 'gr1';
		GR1_CATEGORY = Category.DATA;
		GR1_FORMAT = Format.ITEM;
		
		GR2 = NNDataSplit.getPropNumber() + 2;
		GR2_TAG = 'gr2';
		GR2_CATEGORY = Category.DATA;
		GR2_FORMAT = Format.ITEM;
		
		SPLIT_GR1 = NNDataSplit.getPropNumber() + 3;
		SPLIT_GR1_TAG = 'split_gr1';
		SPLIT_GR1_CATEGORY = Category.DATA;
		SPLIT_GR1_FORMAT = Format.RVECTOR;
		
		SPLIT_GR2 = NNDataSplit.getPropNumber() + 4;
		SPLIT_GR2_TAG = 'split_gr2';
		SPLIT_GR2_CATEGORY = Category.DATA;
		SPLIT_GR2_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function nnds_class = getClass()
			%GETCLASS returns the class of the data split for a neural network classifier.
			%
			% CLASS = NNClassifierDataSplit.GETCLASS() returns the class 'NNClassifierDataSplit'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNDS.GETCLASS() returns the class of the data split for a neural network classifier NNDS.
			%  CLASS = Element.GETCLASS(NNDS) returns the class of 'NNDS'.
			%  CLASS = Element.GETCLASS('NNClassifierDataSplit') returns 'NNClassifierDataSplit'.
			%
			% See also getName, getDescription.
			
			nnds_class = 'NNClassifierDataSplit';
		end
		function nnds_name = getName()
			%GETNAME returns the name of the data split for a neural network classifier.
			%
			% NAME = NNClassifierDataSplit.GETNAME() returns the name of the 'data split for a neural network classifier'.
			%  Data Split For A Neural Network Classifier.
			%
			% Alternative forms to call this method are:
			%  NAME = NNDS.GETNAME() returns the name of the data split for a neural network classifier NNDS.
			%  NAME = Element.GETNAME(NNDS) returns the name of 'NNDS'.
			%  NAME = Element.GETNAME('NNClassifierDataSplit') returns the name of 'NNClassifierDataSplit'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nnds_name = 'Data Split For A Neural Network Classifier';
		end
		function nnds_description = getDescription()
			%GETDESCRIPTION returns the description of the data split for a neural network classifier.
			%
			% STR = NNClassifierDataSplit.GETDESCRIPTION() returns the description of the 'data split for a neural network classifier'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNDS.GETDESCRIPTION() returns the description of the data split for a neural network classifier NNDS.
			%  STR = Element.GETDESCRIPTION(NNDS) returns the description of 'NNDS'.
			%  STR = Element.GETDESCRIPTION('NNClassifierDataSplit') returns the description of 'NNClassifierDataSplit'.
			%
			% See also getClass, getName.
			
			nnds_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of data split for a neural network classifier.
			%
			% PROPS = NNClassifierDataSplit.GETPROPS() returns the property list of data split for a neural network classifier.
			%
			% PROPS = NNClassifierDataSplit.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNDS.GETPROPS([CATEGORY]) returns the property list of the data split for a neural network classifier NNDS.
			%  PROPS = Element.GETPROPS(NNDS[, CATEGORY]) returns the property list of 'NNDS'.
			%  PROPS = Element.GETPROPS('NNClassifierDataSplit'[, CATEGORY]) returns the property list of 'NNClassifierDataSplit'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNDataSplit.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						NNDataSplit.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						NNDataSplit.getProps(Category.DATA)
						NNClassifierDataSplit.GR1
						NNClassifierDataSplit.GR2
						NNClassifierDataSplit.SPLIT_GR1
						NNClassifierDataSplit.SPLIT_GR2
						];
				case Category.RESULT
					prop_list = [
						NNDataSplit.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						NNDataSplit.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						NNDataSplit.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						NNDataSplit.getProps()
						NNClassifierDataSplit.GR1
						NNClassifierDataSplit.GR2
						NNClassifierDataSplit.SPLIT_GR1
						NNClassifierDataSplit.SPLIT_GR2
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of data split for a neural network classifier.
			%
			% N = NNClassifierDataSplit.GETPROPNUMBER() returns the property number of data split for a neural network classifier.
			%
			% Alternative forms to call this method are:
			%  N = NNDS.GETPROPNUMBER() returns the property number of the data split for a neural network classifier NNDS.
			%  N = Element.GETPROPNUMBER(NNDS) returns the property number of 'NNDS'.
			%  N = Element.GETPROPNUMBER('NNClassifierDataSplit') returns the property number of 'NNClassifierDataSplit'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 14;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in data split for a neural network classifier/error.
			%
			% CHECK = NNClassifierDataSplit.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNDS.EXISTSPROP(PROP) checks whether PROP exists for NNDS.
			%  CHECK = Element.EXISTSPROP(NNDS, PROP) checks whether PROP exists for NNDS.
			%  CHECK = Element.EXISTSPROP(NNClassifierDataSplit, PROP) checks whether PROP exists for NNClassifierDataSplit.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNDS.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  Element.EXISTSPROP(NNDS, PROP) throws error if PROP does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  Element.EXISTSPROP(NNClassifierDataSplit, PROP) throws error if PROP does NOT exist for NNClassifierDataSplit.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14 ]);
			else
				assert( ...
					NNClassifierDataSplit.existsProp(prop), ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierDataSplit.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in data split for a neural network classifier/error.
			%
			% CHECK = NNClassifierDataSplit.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNDS.EXISTSTAG(TAG) checks whether TAG exists for NNDS.
			%  CHECK = Element.EXISTSTAG(NNDS, TAG) checks whether TAG exists for NNDS.
			%  CHECK = Element.EXISTSTAG(NNClassifierDataSplit, TAG) checks whether TAG exists for NNClassifierDataSplit.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNDS.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  Element.EXISTSTAG(NNDS, TAG) throws error if TAG does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  Element.EXISTSTAG(NNClassifierDataSplit, TAG) throws error if TAG does NOT exist for NNClassifierDataSplit.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifierdatasplit_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_train'  'gr_val'  'feature_mask'  'feature_selection_analysis'  'gr_train_fs'  'gr_val_fs'  'gr1'  'gr2'  'split_gr1'  'split_gr2' };
				
				check = any(strcmpi(tag, nnclassifierdatasplit_tag_list));
			else
				assert( ...
					NNClassifierDataSplit.existsTag(tag), ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNClassifierDataSplit'] ...
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
			%  PROPERTY = NNDS.GETPROPPROP(POINTER) returns property number of POINTER of NNDS.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierDataSplit, POINTER) returns property number of POINTER of NNClassifierDataSplit.
			%  PROPERTY = NNDS.GETPROPPROP(NNClassifierDataSplit, POINTER) returns property number of POINTER of NNClassifierDataSplit.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnclassifierdatasplit_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_train'  'gr_val'  'feature_mask'  'feature_selection_analysis'  'gr_train_fs'  'gr_val_fs'  'gr1'  'gr2'  'split_gr1'  'split_gr2' };
				
				tag = pointer;
				NNClassifierDataSplit.existsTag(tag);
				
				prop = find(strcmpi(tag, nnclassifierdatasplit_tag_list));
			else % numeric
				prop = pointer;
				NNClassifierDataSplit.existsProp(prop);
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
			%  TAG = NNDS.GETPROPTAG(POINTER) returns tag of POINTER of NNDS.
			%  TAG = Element.GETPROPTAG(NNClassifierDataSplit, POINTER) returns tag of POINTER of NNClassifierDataSplit.
			%  TAG = NNDS.GETPROPTAG(NNClassifierDataSplit, POINTER) returns tag of POINTER of NNClassifierDataSplit.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNClassifierDataSplit.existsTag(tag);
			else % numeric
				prop = pointer;
				NNClassifierDataSplit.existsProp(prop);
				
				switch prop
					case NNClassifierDataSplit.GR1
						tag = NNClassifierDataSplit.GR1_TAG;
					case NNClassifierDataSplit.GR2
						tag = NNClassifierDataSplit.GR2_TAG;
					case NNClassifierDataSplit.SPLIT_GR1
						tag = NNClassifierDataSplit.SPLIT_GR1_TAG;
					case NNClassifierDataSplit.SPLIT_GR2
						tag = NNClassifierDataSplit.SPLIT_GR2_TAG;
					otherwise
						tag = getPropTag@NNDataSplit(prop);
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
			%  CATEGORY = NNDS.GETPROPCATEGORY(POINTER) returns category of POINTER of NNDS.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierDataSplit, POINTER) returns category of POINTER of NNClassifierDataSplit.
			%  CATEGORY = NNDS.GETPROPCATEGORY(NNClassifierDataSplit, POINTER) returns category of POINTER of NNClassifierDataSplit.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					prop_category = NNClassifierDataSplit.GR1_CATEGORY;
				case NNClassifierDataSplit.GR2
					prop_category = NNClassifierDataSplit.GR2_CATEGORY;
				case NNClassifierDataSplit.SPLIT_GR1
					prop_category = NNClassifierDataSplit.SPLIT_GR1_CATEGORY;
				case NNClassifierDataSplit.SPLIT_GR2
					prop_category = NNClassifierDataSplit.SPLIT_GR2_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNDataSplit(prop);
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
			%  FORMAT = NNDS.GETPROPFORMAT(POINTER) returns format of POINTER of NNDS.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierDataSplit, POINTER) returns format of POINTER of NNClassifierDataSplit.
			%  FORMAT = NNDS.GETPROPFORMAT(NNClassifierDataSplit, POINTER) returns format of POINTER of NNClassifierDataSplit.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					prop_format = NNClassifierDataSplit.GR1_FORMAT;
				case NNClassifierDataSplit.GR2
					prop_format = NNClassifierDataSplit.GR2_FORMAT;
				case NNClassifierDataSplit.SPLIT_GR1
					prop_format = NNClassifierDataSplit.SPLIT_GR1_FORMAT;
				case NNClassifierDataSplit.SPLIT_GR2
					prop_format = NNClassifierDataSplit.SPLIT_GR2_FORMAT;
				otherwise
					prop_format = getPropFormat@NNDataSplit(prop);
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
			%  DESCRIPTION = NNDS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNDS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierDataSplit, POINTER) returns description of POINTER of NNClassifierDataSplit.
			%  DESCRIPTION = NNDS.GETPROPDESCRIPTION(NNClassifierDataSplit, POINTER) returns description of POINTER of NNClassifierDataSplit.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					prop_description = 'GR1 (data, item) is a group of NN subjects.';
				case NNClassifierDataSplit.GR2
					prop_description = 'GR2 (data, item) is a group of NN subjects.';
				case NNClassifierDataSplit.SPLIT_GR1
					prop_description = 'SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.';
				case NNClassifierDataSplit.SPLIT_GR2
					prop_description = 'SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.';
				case NNClassifierDataSplit.GR_TRAIN
					prop_description = 'GR_TRAIN (result, item) is a group of NN subjects for the training set.';
				case NNClassifierDataSplit.GR_VAL
					prop_description = 'GR_VAL (result, item) is a group of NN subjects for the validation set.';
				case NNClassifierDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_description = 'FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.';
				case NNClassifierDataSplit.GR_TRAIN_FS
					prop_description = 'GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.';
				case NNClassifierDataSplit.GR_VAL_FS
					prop_description = 'GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.';
				otherwise
					prop_description = getPropDescription@NNDataSplit(prop);
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
			%  SETTINGS = NNDS.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNDS.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierDataSplit, POINTER) returns settings of POINTER of NNClassifierDataSplit.
			%  SETTINGS = NNDS.GETPROPSETTINGS(NNClassifierDataSplit, POINTER) returns settings of POINTER of NNClassifierDataSplit.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					prop_settings = 'NNGroup';
				case NNClassifierDataSplit.GR2
					prop_settings = 'NNGroup';
				case NNClassifierDataSplit.SPLIT_GR1
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNClassifierDataSplit.SPLIT_GR2
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNClassifierDataSplit.GR_TRAIN
					prop_settings = 'NNGroup';
				case NNClassifierDataSplit.GR_VAL
					prop_settings = 'NNGroup';
				case NNClassifierDataSplit.GR_TRAIN_FS
					prop_settings = 'NNGroup';
				case NNClassifierDataSplit.GR_VAL_FS
					prop_settings = 'NNGroup';
				otherwise
					prop_settings = getPropSettings@NNDataSplit(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierDataSplit.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierDataSplit.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNDS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNDS.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierDataSplit, POINTER) returns the default value of POINTER of NNClassifierDataSplit.
			%  DEFAULT = NNDS.GETPROPDEFAULT(NNClassifierDataSplit, POINTER) returns the default value of POINTER of NNClassifierDataSplit.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR2
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.SPLIT_GR1
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.SPLIT_GR2
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR_TRAIN_FS
					prop_default = NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'));
				case NNClassifierDataSplit.GR_VAL_FS
					prop_default = NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'));
				otherwise
					prop_default = getPropDefault@NNDataSplit(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierDataSplit.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierDataSplit.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNDS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNDS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierDataSplit, POINTER) returns the conditioned default value of POINTER of NNClassifierDataSplit.
			%  DEFAULT = NNDS.GETPROPDEFAULTCONDITIONED(NNClassifierDataSplit, POINTER) returns the conditioned default value of POINTER of NNClassifierDataSplit.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			prop_default = NNClassifierDataSplit.conditioning(prop, NNClassifierDataSplit.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNDS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNDS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNDS.
			%  CHECK = Element.CHECKPROP(NNClassifierDataSplit, PROP, VALUE) checks VALUE format for PROP of NNClassifierDataSplit.
			%  CHECK = NNDS.CHECKPROP(NNClassifierDataSplit, PROP, VALUE) checks VALUE format for PROP of NNClassifierDataSplit.
			% 
			% NNDS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNDS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNDS.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  Element.CHECKPROP(NNClassifierDataSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierDataSplit.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			%  NNDS.CHECKPROP(NNClassifierDataSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierDataSplit.
			%   Error id: [BRAPH2:NNClassifierDataSplit:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.GR1
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR2
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.SPLIT_GR1
					check = Format.checkFormat(Format.RVECTOR, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.SPLIT_GR2
					check = Format.checkFormat(Format.RVECTOR, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR_TRAIN
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR_VAL
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR_TRAIN_FS
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				case NNClassifierDataSplit.GR_VAL_FS
					check = Format.checkFormat(Format.ITEM, value, NNClassifierDataSplit.getPropSettings(prop));
				otherwise
					check = checkProp@NNDataSplit(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierDataSplit.getPropTag(prop) ' (' NNClassifierDataSplit.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nnds = NNClassifierDataSplit(varargin)
			% NNClassifierDataSplit() creates a data split for a neural network classifier.
			%
			% NNClassifierDataSplit(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierDataSplit(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierDataSplit properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>gr_train</strong> 	GR_TRAIN (result, item) is a group of NN subjects for the training set.
			%  <strong>6</strong> <strong>gr_val</strong> 	GR_VAL (result, item) is a group of NN subjects for the validation set.
			%  <strong>7</strong> <strong>feature_mask</strong> 	FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
			%  <strong>8</strong> <strong>feature_selection_analysis</strong> 	FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
			%  <strong>9</strong> <strong>gr_train_fs</strong> 	GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
			%  <strong>10</strong> <strong>gr_val_fs</strong> 	GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.
			%  <strong>11</strong> <strong>gr1</strong> 	GR1 (data, item) is a group of NN subjects.
			%  <strong>12</strong> <strong>gr2</strong> 	GR2 (data, item) is a group of NN subjects.
			%  <strong>13</strong> <strong>split_gr1</strong> 	SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
			%  <strong>14</strong> <strong>split_gr2</strong> 	SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
			%
			% See also Category, Format, set, check.
			
			nnds = nnds@NNDataSplit(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNClassifierDataSplit.getPropProp(pointer);
			
			switch prop
				case NNClassifierDataSplit.SPLIT_GR1
					if length(value) == 1 & value < 1
					    num_val = floor(value * nnds.get('GR1').get('SUB_DICT').length());
					    num_train = nnds.get('GR1').get('SUB_DICT').length() - num_val;
					    value = [ones(1, num_val), zeros(1, num_train)];
					    value = value(randperm(length(value)));
					    value = find(value == 1);
					end
					
				case NNClassifierDataSplit.SPLIT_GR2
					if length(value) == 1 & value < 1
					    num_val = floor(value * nnds.get('GR2').get('SUB_DICT').length());
					    num_train = nnds.get('GR2').get('SUB_DICT').length() - num_val;
					    value = [ones(1, num_val), zeros(1, num_train)];
					    value = value(randperm(length(value)));
					    value = find(value == 1);
					end
					
				otherwise
					if prop <= NNDataSplit.getPropNumber()
						value = conditioning@NNDataSplit(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnds, prop)
		
			switch prop
				case NNClassifierDataSplit.GR_TRAIN
					if nnds.get('WAITBAR')
					    wb = waitbar(0, 'Constructing the training set ...', 'Name', BRAPH2.NAME);
					    set_braph2icon(wb)
					end
					
					% init a NNGroup
					nnGroup = 'GR1';
					train_nn_gr = NNGroup( ...
					    'SUB_CLASS', nnds.get(nnGroup).get('SUB_CLASS'), ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					    );
					
					train_nn_gr.set( ...
					    'ID', nnds.get(nnGroup).get('ID'), ...
					    'LABEL', nnds.get(nnGroup).get('LABEL'), ...
					    'NOTES', nnds.get(nnGroup).get('NOTES') ...
					    );
					
					% setup counter for waitbar
					counter = 0;
					num_sub_all = length(setdiff(1:nnds.get('GR1').get('SUB_DICT').length(), nnds.get('SPLIT_GR1'))) + length(setdiff(1:nnds.get('GR2').get('SUB_DICT').length(), nnds.get('SPLIT_GR2')));
					
					% add subejcts from all groups
					sub_dict = train_nn_gr.get('SUB_DICT');
					
					if nnds.get('GR1').get('SUB_DICT').length() > 0
					    subs = nnds.get('GR1').get('SUB_DICT').getItems();
					    selected_idx = setdiff(1:length(subs), nnds.get('SPLIT_GR1'));
					    selected_subs = subs(selected_idx);
					    for i = 1:1:length(selected_subs)
					        sub = selected_subs{i};
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					        counter = counter + 1;
					        if nnds.get('WAITBAR')
					            waitbar(.30 + .70 * counter / num_sub_all, wb, ['Constructing training set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
					        end
					    end
					end
					
					if nnds.get('GR2').get('SUB_DICT').length() > 0
					    subs = nnds.get('GR2').get('SUB_DICT').getItems();
					    selected_idx = setdiff(1:length(subs), nnds.get('SPLIT_GR2'));
					    selected_subs = subs(selected_idx);
					    for i = 1:1:length(selected_subs)
					        sub = selected_subs{i};
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					        counter = counter + 1;
					        if nnds.get('WAITBAR')
					            waitbar(.30 + .70 * counter / num_sub_all, wb, ['Constructing training set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
					        end
					    end
					end
					
					if nnds.get('WAITBAR')
					    close(wb)
					end
					
					if sub_dict.length() > 0
					    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
					    targets = onehotencode(categorical(target_names), 1);
					    for i = 1:1:sub_dict.length()
					        sub_dict.getItem(i).set('TARGET', {targets(:, i)'});
					    end
					end
					
					train_nn_gr.set('SUB_DICT', sub_dict);
					
					value = train_nn_gr;
					
				case NNClassifierDataSplit.GR_VAL
					if nnds.get('WAITBAR')
					    wb = waitbar(0, 'Constructing the validation set ...', 'Name', BRAPH2.NAME);
					    set_braph2icon(wb)
					end
					
					% init a NNGroup
					nnGroup = 'GR1';
					val_nn_gr = NNGroup( ...
					    'SUB_CLASS', nnds.get(nnGroup).get('SUB_CLASS'), ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					    );
					
					val_nn_gr.set( ...
					    'ID', nnds.get(nnGroup).get('ID'), ...
					    'LABEL', nnds.get(nnGroup).get('LABEL'), ...
					    'NOTES', nnds.get(nnGroup).get('NOTES') ...
					    );
					
					% setup counter for waitbar
					counter = 0;
					num_sub_all = length(nnds.get('SPLIT_GR1')) + length(nnds.get('SPLIT_GR2'));
					
					% add subejcts from all groups
					sub_dict = val_nn_gr.get('SUB_DICT');
					
					if nnds.get('GR1').get('SUB_DICT').length() > 0
					    subs = nnds.get('GR1').get('SUB_DICT').getItems();
					    selected_idx = nnds.get('SPLIT_GR1');
					    selected_subs = subs(selected_idx);
					    for i = 1:1:length(selected_subs)
					        sub = selected_subs{i};
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					        counter = counter + 1;
					        if nnds.get('WAITBAR')
					            waitbar(.30 + .70 * counter / num_sub_all, wb, ['Constructing validation set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
					        end
					    end
					end
					
					if nnds.get('GR2').get('SUB_DICT').length() > 0
					    subs = nnds.get('GR2').get('SUB_DICT').getItems();
					    selected_idx = nnds.get('SPLIT_GR2');
					    selected_subs = subs(selected_idx);
					    for i = 1:1:length(selected_subs)
					        sub = selected_subs{i};
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					        counter = counter + 1;
					        if nnds.get('WAITBAR')
					            waitbar(.30 + .70 * counter / num_sub_all, wb, ['Constructing validation set, ' num2str(100 * counter / num_sub_all, '%.0f') '% done...'])
					        end
					    end
					end
					
					if sub_dict.length() > 0
					    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
					    targets = onehotencode(categorical(target_names), 1);
					    for i = 1:1:sub_dict.length()
					        sub_dict.getItem(i).set('TARGET', {targets(:, i)'});
					    end
					end
					
					val_nn_gr.set('SUB_DICT', sub_dict);
					
					if nnds.get('WAITBAR')
					    close(wb)
					end
					
					value = val_nn_gr;
					
				case NNClassifierDataSplit.FEATURE_SELECTION_ANALYSIS
					percentile = cell2mat(nnds.get('FEATURE_MASK'));
					gr_train = nnds.memorize('GR_TRAIN');
					data = cellfun(@(x) x.get('INPUT'), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);
					
					if nnds.get('GR_TRAIN').get('SUB_DICT').length == 0
					    value = {};
					else
					    if nnds.get('WAITBAR')
					        wb = waitbar(0, 'Initialing feature selection on training set ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    y = cellfun(@(x) cell2mat(x.get('TARGET')), gr_train.get('SUB_DICT').getItems(), 'UniformOutput', false);
					    y = cell2mat(y);
					    label = y(1, :);
					    num_feature_cluster = length(data{1});
					    value = cell(size(data{1}));
					    
					    % setup counter for waitbar
					    counter = 0;
					    num_feature_all = 0;
					    for k = 1:1:num_feature_cluster
					        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
					        num_feature_all = num_feature_all + numel(data_per_cluster{k});
					    end
					
					    for k = 1:1:num_feature_cluster
					        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
					        mask = zeros(size(data_per_cluster{k}));
					        if ~isempty(mask)
					            for i = 1:numel(mask)
					                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
					                if(any(isinf(data_per_feature)))
					                    mask(i) = 0;
					                else
					                    mask(i) = nnds.mutual_information_analysis(data_per_feature, label, 5);
					                end
					                counter = counter + 1;
					                if nnds.get('WAITBAR')
					                    waitbar(.30 + .70 * counter / num_feature_all, wb, ['Performing feature selection, ' num2str(100 * counter / num_feature_all, '%.0f') '% done...'])
									end
					            end
					
					            [~, idx_all] = sort(mask(:), 'descend');
					            num_top_idx = ceil(percentile * numel(mask));
					            mask(idx_all(1:num_top_idx)) = 1;
					            mask(idx_all(end - (length(idx_all) - num_top_idx - 1):end)) = 0;
					        end
					        value{k} = mask;
					    end
					    if nnds.get('WAITBAR')
					        close(wb)
					    end
					end
					
				case NNClassifierDataSplit.GR_TRAIN_FS
					nn_gr = nnds.memorize('GR_TRAIN');
					feature_mask = nnds.get('FEATURE_MASK');
					if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
					    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
					end
					
					if nn_gr.get('SUB_DICT').length() == 0
					    value = NNGroup();
					else
					    nn_gr_fs = NNGroup( ...
					        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					        );
					
					    nn_gr_fs.set( ...
					        'ID', nn_gr.get('ID'), ...
					        'LABEL', nn_gr.get('LABEL'), ...
					        'NOTES', nn_gr.get('NOTES') ...
					        );
					
					    sub_dict = nn_gr_fs.get('SUB_DICT');
					
					    for i = 1:1:nn_gr.get('SUB_DICT').length()
					        sub = nn_gr.get('SUB_DICT').getItem(i);
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', feature_mask,...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					    end
					    nn_gr_fs.set('SUB_DICT', sub_dict);
					    value = nn_gr_fs;
					end
					
				case NNClassifierDataSplit.GR_VAL_FS
					nn_gr = nnds.memorize('GR_VAL');
					feature_mask = nnds.get('FEATURE_MASK');
					if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
					    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
					end
					
					if nn_gr.get('SUB_DICT').length() == 0
					    value = NNGroup();
					else
					    nn_gr_fs = NNGroup( ...
					        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
					        );
					
					    nn_gr_fs.set( ...
					        'ID', nn_gr.get('ID'), ...
					        'LABEL', nn_gr.get('LABEL'), ...
					        'NOTES', nn_gr.get('NOTES') ...
					        );
					
					    sub_dict = nn_gr_fs.get('SUB_DICT');
					
					    for i = 1:1:nn_gr.get('SUB_DICT').length()
					        sub = nn_gr.get('SUB_DICT').getItem(i);
					        sub_copy = NNSubject( ...
					            'ID', sub.get('ID'), ...
					            'LABEL', sub.get('LABEL'), ...
					            'NOTES', sub.get('NOTES'),...
					            'G', sub.get('G'),...
					            'INPUT', sub.get('INPUT'),...
					            'INPUT_LABEL', sub.get('INPUT_LABEL'), ...
					            'FEATURE_MASK', feature_mask,...
					            'TARGET_NAME', sub.get('TARGET_NAME'),...
					            'TARGET', sub.get('TARGET'),...
					            'PREDICTION', sub.get('PREDICTION'),...
					            'BA', sub.get('BA'),...
					            'AGE', sub.get('AGE'),...
					            'SEX', sub.get('SEX')...
					            );
					        sub_dict.add(sub_copy);
					    end
					    nn_gr_fs.set('SUB_DICT', sub_dict);
					    value = nn_gr_fs;
					end
					
				otherwise
					value = calculateValue@NNDataSplit(nnds, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(nnds, prop, varargin)
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
				case NNClassifierDataSplit.SPLIT_GR1
					pr = PlotPropSmartVector('EL', nnds, 'PROP', NNClassifierDataSplit.SPLIT_GR1, 'MAX', 10000000, 'MIN', 0, varargin{:});
					
				case NNClassifierDataSplit.SPLIT_GR2
					pr = PlotPropSmartVector('EL', nnds, 'PROP', NNClassifierDataSplit.SPLIT_GR2, 'MAX', 10000000, 'MIN', 0, varargin{:});
					
				otherwise
					pr = getPlotProp@NNDataSplit(nnds, prop, varargin{:});
					
			end
		end
	end
end
