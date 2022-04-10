classdef NNDataSplit < Element
	% NNDataSplit split a dataset into training set and validation set.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% 
	%
	% The list of NNDataSplit properties is:
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
	%
	% NNDataSplit methods (constructor):
	% NNDataSplit - constructor
	%
	% NNDataSplit methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in data split for neural network/error.
	%  existsProp - checks whether property exists in data split for neural network/error.
	%  getPropNumber - returns the property number of data split for neural network.
	%  getProps - returns the property list of data split for neural network.
	%  getDescription - returns the description of the data split for neural network.
	%  getName - returns the name of the data split for neural network.
	%  getClass - returns the class of the data split for neural network.
	%
	% NNDataSplit methods:
	%  mutual_information_analysis - computes the mutual information value.
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
	% NNDataSplit methods (operators):
	%  isequal - determines whether two NNDataSplit are equal (values, locked)
	%
	% NNDataSplit methods (display):
	%  tostring - string with information about the NNDataSplit
	%  disp - displays information about the NNDataSplit
	%  tree - displays the element of NNDataSplit
	%
	% NNDataSplit method (element list):
	%  getElementList - returns a list with all subelements of NNDataSplit
	%
	% NNDataSplit method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNDataSplit
	%
	% NNDataSplit method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNDataSplit
	%
	% NNDataSplit methods (copy):
	%  copy - copies the NNDataSplit
	%  deepclone - deep-clones the NNDataSplit
	%  clone - clones the NNDataSplit
	%
	% NNDataSplit methods (inspection, Static):
	%  getClass - returns NNDataSplit
	%  getName - returns the name of NNDataSplit
	%  getDescription - returns the description of NNDataSplit
	%  getProps - returns the property list of NNDataSplit
	%  getPropNumber - returns the property number of NNDataSplit
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
	% NNDataSplit methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataSplit methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNDataSplit methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNDataSplit methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNDataSplit properties (Constant).
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
		
		WAITBAR = 4;
		WAITBAR_TAG = 'waitbar';
		WAITBAR_CATEGORY = Category.METADATA;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		GR_TRAIN = 5;
		GR_TRAIN_TAG = 'gr_train';
		GR_TRAIN_CATEGORY = Category.RESULT;
		GR_TRAIN_FORMAT = Format.ITEM;
		
		GR_VAL = 6;
		GR_VAL_TAG = 'gr_val';
		GR_VAL_CATEGORY = Category.RESULT;
		GR_VAL_FORMAT = Format.ITEM;
		
		FEATURE_MASK = 7;
		FEATURE_MASK_TAG = 'feature_mask';
		FEATURE_MASK_CATEGORY = Category.DATA;
		FEATURE_MASK_FORMAT = Format.CELL;
		
		FEATURE_SELECTION_ANALYSIS = 8;
		FEATURE_SELECTION_ANALYSIS_TAG = 'feature_selection_analysis';
		FEATURE_SELECTION_ANALYSIS_CATEGORY = Category.RESULT;
		FEATURE_SELECTION_ANALYSIS_FORMAT = Format.CELL;
		
		GR_TRAIN_FS = 9;
		GR_TRAIN_FS_TAG = 'gr_train_fs';
		GR_TRAIN_FS_CATEGORY = Category.RESULT;
		GR_TRAIN_FS_FORMAT = Format.ITEM;
		
		GR_VAL_FS = 10;
		GR_VAL_FS_TAG = 'gr_val_fs';
		GR_VAL_FS_CATEGORY = Category.RESULT;
		GR_VAL_FS_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function nnds_class = getClass()
			%GETCLASS returns the class of the data split for neural network.
			%
			% CLASS = NNDataSplit.GETCLASS() returns the class 'NNDataSplit'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNDS.GETCLASS() returns the class of the data split for neural network NNDS.
			%  CLASS = Element.GETCLASS(NNDS) returns the class of 'NNDS'.
			%  CLASS = Element.GETCLASS('NNDataSplit') returns 'NNDataSplit'.
			%
			% See also getName, getDescription.
			
			nnds_class = 'NNDataSplit';
		end
		function nnds_name = getName()
			%GETNAME returns the name of the data split for neural network.
			%
			% NAME = NNDataSplit.GETNAME() returns the name of the 'data split for neural network'.
			%  Data Split For Neural Network.
			%
			% Alternative forms to call this method are:
			%  NAME = NNDS.GETNAME() returns the name of the data split for neural network NNDS.
			%  NAME = Element.GETNAME(NNDS) returns the name of 'NNDS'.
			%  NAME = Element.GETNAME('NNDataSplit') returns the name of 'NNDataSplit'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nnds_name = 'Data Split For Neural Network';
		end
		function nnds_description = getDescription()
			%GETDESCRIPTION returns the description of the data split for neural network.
			%
			% STR = NNDataSplit.GETDESCRIPTION() returns the description of the 'data split for neural network'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NNDS.GETDESCRIPTION() returns the description of the data split for neural network NNDS.
			%  STR = Element.GETDESCRIPTION(NNDS) returns the description of 'NNDS'.
			%  STR = Element.GETDESCRIPTION('NNDataSplit') returns the description of 'NNDataSplit'.
			%
			% See also getClass, getName.
			
			nnds_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of data split for neural network.
			%
			% PROPS = NNDataSplit.GETPROPS() returns the property list of data split for neural network.
			%
			% PROPS = NNDataSplit.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNDS.GETPROPS([CATEGORY]) returns the property list of the data split for neural network NNDS.
			%  PROPS = Element.GETPROPS(NNDS[, CATEGORY]) returns the property list of 'NNDS'.
			%  PROPS = Element.GETPROPS('NNDataSplit'[, CATEGORY]) returns the property list of 'NNDataSplit'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNDataSplit.LABEL
						NNDataSplit.NOTES
						NNDataSplit.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNDataSplit.ID
						NNDataSplit.FEATURE_MASK
						];
				case Category.RESULT
					prop_list = [
						NNDataSplit.GR_TRAIN
						NNDataSplit.GR_VAL
						NNDataSplit.FEATURE_SELECTION_ANALYSIS
						NNDataSplit.GR_TRAIN_FS
						NNDataSplit.GR_VAL_FS
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNDataSplit.ID
						NNDataSplit.LABEL
						NNDataSplit.NOTES
						NNDataSplit.WAITBAR
						NNDataSplit.GR_TRAIN
						NNDataSplit.GR_VAL
						NNDataSplit.FEATURE_MASK
						NNDataSplit.FEATURE_SELECTION_ANALYSIS
						NNDataSplit.GR_TRAIN_FS
						NNDataSplit.GR_VAL_FS
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of data split for neural network.
			%
			% N = NNDataSplit.GETPROPNUMBER() returns the property number of data split for neural network.
			%
			% Alternative forms to call this method are:
			%  N = NNDS.GETPROPNUMBER() returns the property number of the data split for neural network NNDS.
			%  N = Element.GETPROPNUMBER(NNDS) returns the property number of 'NNDS'.
			%  N = Element.GETPROPNUMBER('NNDataSplit') returns the property number of 'NNDataSplit'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 10;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in data split for neural network/error.
			%
			% CHECK = NNDataSplit.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNDS.EXISTSPROP(PROP) checks whether PROP exists for NNDS.
			%  CHECK = Element.EXISTSPROP(NNDS, PROP) checks whether PROP exists for NNDS.
			%  CHECK = Element.EXISTSPROP(NNDataSplit, PROP) checks whether PROP exists for NNDataSplit.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNDS.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  Element.EXISTSPROP(NNDS, PROP) throws error if PROP does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  Element.EXISTSPROP(NNDataSplit, PROP) throws error if PROP does NOT exist for NNDataSplit.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10 ]);
			else
				assert( ...
					NNDataSplit.existsProp(prop), ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataSplit.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in data split for neural network/error.
			%
			% CHECK = NNDataSplit.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNDS.EXISTSTAG(TAG) checks whether TAG exists for NNDS.
			%  CHECK = Element.EXISTSTAG(NNDS, TAG) checks whether TAG exists for NNDS.
			%  CHECK = Element.EXISTSTAG(NNDataSplit, TAG) checks whether TAG exists for NNDataSplit.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNDS.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  Element.EXISTSTAG(NNDS, TAG) throws error if TAG does NOT exist for NNDS.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  Element.EXISTSTAG(NNDataSplit, TAG) throws error if TAG does NOT exist for NNDataSplit.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nndatasplit_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_train'  'gr_val'  'feature_mask'  'feature_selection_analysis'  'gr_train_fs'  'gr_val_fs' };
				
				check = any(strcmpi(tag, nndatasplit_tag_list));
			else
				assert( ...
					NNDataSplit.existsTag(tag), ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNDataSplit'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNDataSplit, POINTER) returns property number of POINTER of NNDataSplit.
			%  PROPERTY = NNDS.GETPROPPROP(NNDataSplit, POINTER) returns property number of POINTER of NNDataSplit.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nndatasplit_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_train'  'gr_val'  'feature_mask'  'feature_selection_analysis'  'gr_train_fs'  'gr_val_fs' };
				
				tag = pointer;
				NNDataSplit.existsTag(tag);
				
				prop = find(strcmpi(tag, nndatasplit_tag_list));
			else % numeric
				prop = pointer;
				NNDataSplit.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNDataSplit, POINTER) returns tag of POINTER of NNDataSplit.
			%  TAG = NNDS.GETPROPTAG(NNDataSplit, POINTER) returns tag of POINTER of NNDataSplit.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNDataSplit.existsTag(tag);
			else % numeric
				prop = pointer;
				NNDataSplit.existsProp(prop);
				
				switch prop
					case NNDataSplit.ID
						tag = NNDataSplit.ID_TAG;
					case NNDataSplit.LABEL
						tag = NNDataSplit.LABEL_TAG;
					case NNDataSplit.NOTES
						tag = NNDataSplit.NOTES_TAG;
					case NNDataSplit.WAITBAR
						tag = NNDataSplit.WAITBAR_TAG;
					case NNDataSplit.GR_TRAIN
						tag = NNDataSplit.GR_TRAIN_TAG;
					case NNDataSplit.GR_VAL
						tag = NNDataSplit.GR_VAL_TAG;
					case NNDataSplit.FEATURE_MASK
						tag = NNDataSplit.FEATURE_MASK_TAG;
					case NNDataSplit.FEATURE_SELECTION_ANALYSIS
						tag = NNDataSplit.FEATURE_SELECTION_ANALYSIS_TAG;
					case NNDataSplit.GR_TRAIN_FS
						tag = NNDataSplit.GR_TRAIN_FS_TAG;
					case NNDataSplit.GR_VAL_FS
						tag = NNDataSplit.GR_VAL_FS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataSplit, POINTER) returns category of POINTER of NNDataSplit.
			%  CATEGORY = NNDS.GETPROPCATEGORY(NNDataSplit, POINTER) returns category of POINTER of NNDataSplit.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					prop_category = NNDataSplit.ID_CATEGORY;
				case NNDataSplit.LABEL
					prop_category = NNDataSplit.LABEL_CATEGORY;
				case NNDataSplit.NOTES
					prop_category = NNDataSplit.NOTES_CATEGORY;
				case NNDataSplit.WAITBAR
					prop_category = NNDataSplit.WAITBAR_CATEGORY;
				case NNDataSplit.GR_TRAIN
					prop_category = NNDataSplit.GR_TRAIN_CATEGORY;
				case NNDataSplit.GR_VAL
					prop_category = NNDataSplit.GR_VAL_CATEGORY;
				case NNDataSplit.FEATURE_MASK
					prop_category = NNDataSplit.FEATURE_MASK_CATEGORY;
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_category = NNDataSplit.FEATURE_SELECTION_ANALYSIS_CATEGORY;
				case NNDataSplit.GR_TRAIN_FS
					prop_category = NNDataSplit.GR_TRAIN_FS_CATEGORY;
				case NNDataSplit.GR_VAL_FS
					prop_category = NNDataSplit.GR_VAL_FS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNDataSplit, POINTER) returns format of POINTER of NNDataSplit.
			%  FORMAT = NNDS.GETPROPFORMAT(NNDataSplit, POINTER) returns format of POINTER of NNDataSplit.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					prop_format = NNDataSplit.ID_FORMAT;
				case NNDataSplit.LABEL
					prop_format = NNDataSplit.LABEL_FORMAT;
				case NNDataSplit.NOTES
					prop_format = NNDataSplit.NOTES_FORMAT;
				case NNDataSplit.WAITBAR
					prop_format = NNDataSplit.WAITBAR_FORMAT;
				case NNDataSplit.GR_TRAIN
					prop_format = NNDataSplit.GR_TRAIN_FORMAT;
				case NNDataSplit.GR_VAL
					prop_format = NNDataSplit.GR_VAL_FORMAT;
				case NNDataSplit.FEATURE_MASK
					prop_format = NNDataSplit.FEATURE_MASK_FORMAT;
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_format = NNDataSplit.FEATURE_SELECTION_ANALYSIS_FORMAT;
				case NNDataSplit.GR_TRAIN_FS
					prop_format = NNDataSplit.GR_TRAIN_FS_FORMAT;
				case NNDataSplit.GR_VAL_FS
					prop_format = NNDataSplit.GR_VAL_FS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataSplit, POINTER) returns description of POINTER of NNDataSplit.
			%  DESCRIPTION = NNDS.GETPROPDESCRIPTION(NNDataSplit, POINTER) returns description of POINTER of NNDataSplit.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis.';
				case NNDataSplit.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis.';
				case NNDataSplit.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis.';
				case NNDataSplit.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
				case NNDataSplit.GR_TRAIN
					prop_description = 'GR_TRAIN (result, item) is a group of NN subjects for the training set.';
				case NNDataSplit.GR_VAL
					prop_description = 'GR_VAL (result, item) is a group of NN subjects for the validation set.';
				case NNDataSplit.FEATURE_MASK
					prop_description = 'FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.';
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_description = 'FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.';
				case NNDataSplit.GR_TRAIN_FS
					prop_description = 'GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.';
				case NNDataSplit.GR_VAL_FS
					prop_description = 'GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataSplit, POINTER) returns settings of POINTER of NNDataSplit.
			%  SETTINGS = NNDS.GETPROPSETTINGS(NNDataSplit, POINTER) returns settings of POINTER of NNDataSplit.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNDataSplit.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNDataSplit.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNDataSplit.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNDataSplit.GR_TRAIN
					prop_settings = 'NNGroup';
				case NNDataSplit.GR_VAL
					prop_settings = 'NNGroup';
				case NNDataSplit.FEATURE_MASK
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataSplit.GR_TRAIN_FS
					prop_settings = 'NNGroup';
				case NNDataSplit.GR_VAL_FS
					prop_settings = 'NNGroup';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataSplit.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataSplit.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNDS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNDS.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataSplit, POINTER) returns the default value of POINTER of NNDataSplit.
			%  DEFAULT = NNDS.GETPROPDEFAULT(NNDataSplit, POINTER) returns the default value of POINTER of NNDataSplit.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					prop_default = Format.getFormatDefault(Format.STRING, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.WAITBAR
					prop_default = true;
				case NNDataSplit.GR_TRAIN
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_VAL
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.FEATURE_MASK
					prop_default = num2cell(0.05);
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					prop_default = Format.getFormatDefault(Format.CELL, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_TRAIN_FS
					prop_default = NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'));
				case NNDataSplit.GR_VAL_FS
					prop_default = NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataSplit.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataSplit.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNDS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNDS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataSplit, POINTER) returns the conditioned default value of POINTER of NNDataSplit.
			%  DEFAULT = NNDS.GETPROPDEFAULTCONDITIONED(NNDataSplit, POINTER) returns the conditioned default value of POINTER of NNDataSplit.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			prop_default = NNDataSplit.conditioning(prop, NNDataSplit.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNDataSplit, PROP, VALUE) checks VALUE format for PROP of NNDataSplit.
			%  CHECK = NNDS.CHECKPROP(NNDataSplit, PROP, VALUE) checks VALUE format for PROP of NNDataSplit.
			% 
			% NNDS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNDataSplit:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNDS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNDS.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  Element.CHECKPROP(NNDataSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataSplit.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			%  NNDS.CHECKPROP(NNDataSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataSplit.
			%   Error id: [BRAPH2:NNDataSplit:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.ID
					check = Format.checkFormat(Format.STRING, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.LABEL
					check = Format.checkFormat(Format.STRING, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.NOTES
					check = Format.checkFormat(Format.STRING, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_TRAIN
					check = Format.checkFormat(Format.ITEM, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_VAL
					check = Format.checkFormat(Format.ITEM, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.FEATURE_MASK
					check = Format.checkFormat(Format.CELL, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.FEATURE_SELECTION_ANALYSIS
					check = Format.checkFormat(Format.CELL, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_TRAIN_FS
					check = Format.checkFormat(Format.ITEM, value, NNDataSplit.getPropSettings(prop));
				case NNDataSplit.GR_VAL_FS
					check = Format.checkFormat(Format.ITEM, value, NNDataSplit.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataSplit:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataSplit.getPropTag(prop) ' (' NNDataSplit.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nnds = NNDataSplit(varargin)
			% NNDataSplit() creates a data split for neural network.
			%
			% NNDataSplit(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataSplit(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDataSplit properties is:
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
			%
			% See also Category, Format, set, check.
			
			nnds = nnds@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNDataSplit.getPropProp(pointer);
			
			switch prop
				case NNDataSplit.FEATURE_MASK
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
		function value = calculateValue(nnds, prop)
		
			switch prop
				otherwise
					value = calculateValue@Element(nnds, prop);
					
			end
		end
	end
	methods % methods
		function score = mutual_information_analysis(nnds, X, Y, n)
		    %MUTUAL_INFORMATION_ANALYSIS computes the mutual information value.
		    % 
		    % SCORE = MUTUAL_INFORMATION_ANALYSIS(NND, X, Y, n) compute the mutual
		    %  information SCORE of two discrete variables X and Y. These two vectors
		    %  must have the same length. The higher value of the score, the
		    %  closer connection between X and Y.
		
		    x_max = max(X, [], 2);
		    x_min = min(X, [], 2);
		    x_range = (x_max - x_min) / n;
		    if x_max - x_min < 1e-6
		        score = 0;
		        return;
		    end
		    if size(Y, 1) ~= 1
		        prob_matr = zeros(n, size(Y, 1));
		        for i = 1 : size(X,2)
		            x_dim = ceil((X(:, i) - x_min) / x_range);
		            if x_dim < 1
		                x_dim = 1;
		            elseif x_dim > n
		                x_dim = n;
		            end
		            y_dim = find(Y(:, i) == 1);
		            prob_matr(x_dim, y_dim) = prob_matr(x_dim, y_dim) + 1;
		        end
		    else
		        y_max = max(Y, [], 2);
		        y_min = min(Y, [], 2);
		        y_range = (y_max - y_min) / n;
		        prob_matr = zeros(n, n);
		        for i = 1 : size(X, 2)
		            x_dim = ceil((X(:, i) - x_min) / x_range);
		            if x_dim < 1
		                x_dim = 1;
		            elseif x_dim > n
		                x_dim = n;
		            end
		            y_dim = ceil((Y(:, i) - y_min) / y_range);
		            if y_dim < 1
		                y_dim = 1;
		            elseif y_dim > n
		                y_dim = n;
		            end
		            prob_matr(x_dim, y_dim) = prob_matr(x_dim, y_dim) + 1;
		        end
		    end
		    p_y = sum(prob_matr, 1) / size(X, 2);
		    p_y_x = prob_matr ./ (sum(prob_matr, 2) + 1e-6);
		    p_y(p_y == 0) = 1e-6;
		    p_y_x(p_y_x == 0) = 1e-6;
		    
		    score = sum(sum(prob_matr / size(X, 2) .* log(p_y_x))) - sum(p_y .* log(p_y));
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
				case NNDataSplit.GR_TRAIN
					pr = PPNNData_GR_NN('EL', nnds, 'PROP', NNDataSplit.GR_TRAIN, varargin{:});
					
				case NNDataSplit.GR_VAL
					pr = PPNNData_GR_NN('EL', nnds, 'PROP', NNDataSplit.GR_VAL, varargin{:});
					
				case NNDataSplit.FEATURE_MASK
					pr = PlotPropSmartVector('EL', nnds, 'PROP', NNDataSplit.FEATURE_MASK, 'MAX', 10000000, 'MIN', 0, varargin{:});
					
				case NNDataSplit.GR_TRAIN_FS
					pr = PPNNData_GR_NN('EL', nnds, 'PROP', NNDataSplit.GR_TRAIN_FS, varargin{:});
					
				case NNDataSplit.GR_VAL_FS
					pr = PPNNData_GR_NN('EL', nnds, 'PROP', NNDataSplit.GR_VAL_FS, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(nnds, prop, varargin{:});
					
			end
		end
	end
end
