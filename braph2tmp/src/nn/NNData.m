classdef NNData < Element
	% NNData produces a dataset to train or test a neural netowrk model.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% 
	%
	% The list of NNData properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>input_type</strong> 	INPUT_TYPE (data, option) is the input type for training or testing the NN.
	%  <strong>6</strong> <strong>g</strong> 	G (data, item) is the graph for calculating the graph measures.
	%  <strong>7</strong> <strong>measures</strong> 	MEASURES (data, classlist) is the graph measures as input to NN.
	%  <strong>8</strong> <strong>target_name</strong> 	TARGET_NAME (data, string) is the name of the traget.
	%  <strong>9</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects defined as SubjectCON class.
	%  <strong>10</strong> <strong>gr_nn</strong> 	GR_NN (result, item) is a group of NN subjects.
	%
	% NNData methods (constructor):
	% NNData - constructor
	%
	% NNData methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in data for neural network/error.
	%  existsProp - checks whether property exists in data for neural network/error.
	%  getPropNumber - returns the property number of data for neural network.
	%  getProps - returns the property list of data for neural network.
	%  getDescription - returns the description of the data for neural network.
	%  getName - returns the name of the data for neural network.
	%  getClass - returns the class of the data for neural network.
	%
	% NNData methods:
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
	% NNData methods (operators):
	%  isequal - determines whether two NNData are equal (values, locked)
	%
	% NNData methods (display):
	%  tostring - string with information about the NNData
	%  disp - displays information about the NNData
	%  tree - displays the element of NNData
	%
	% NNData method (element list):
	%  getElementList - returns a list with all subelements of NNData
	%
	% NNData method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNData
	%
	% NNData method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNData
	%
	% NNData methods (copy):
	%  copy - copies the NNData
	%  deepclone - deep-clones the NNData
	%  clone - clones the NNData
	%
	% NNData methods (inspection, Static):
	%  getClass - returns NNData
	%  getName - returns the name of NNData
	%  getDescription - returns the description of NNData
	%  getProps - returns the property list of NNData
	%  getPropNumber - returns the property number of NNData
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
	% NNData methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNData methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNData methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNData methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNData properties (Constant).
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
	%  INPUT_TYPE - 5
	%  INPUT_TYPE_TAG - 'input_type'
	%  INPUT_TYPE_CATEGORY - 'd'
	%  INPUT_TYPE_FORMAT - 'op'
	%  G - 6
	%  G_TAG - 'g'
	%  G_CATEGORY - 'd'
	%  G_FORMAT - 'it'
	%  MEASURES - 7
	%  MEASURES_TAG - 'measures'
	%  MEASURES_CATEGORY - 'd'
	%  MEASURES_FORMAT - 'cl'
	%  TARGET_NAME - 8
	%  TARGET_NAME_TAG - 'target_name'
	%  TARGET_NAME_CATEGORY - 'd'
	%  TARGET_NAME_FORMAT - 'st'
	%  GR - 9
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  GR_NN - 10
	%  GR_NN_TAG - 'gr_nn'
	%  GR_NN_CATEGORY - 'r'
	%  GR_NN_FORMAT - 'it'
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
		
		INPUT_TYPE = 5;
		INPUT_TYPE_TAG = 'input_type';
		INPUT_TYPE_CATEGORY = Category.DATA;
		INPUT_TYPE_FORMAT = Format.OPTION;
		
		G = 6;
		G_TAG = 'g';
		G_CATEGORY = Category.DATA;
		G_FORMAT = Format.ITEM;
		
		MEASURES = 7;
		MEASURES_TAG = 'measures';
		MEASURES_CATEGORY = Category.DATA;
		MEASURES_FORMAT = Format.CLASSLIST;
		
		TARGET_NAME = 8;
		TARGET_NAME_TAG = 'target_name';
		TARGET_NAME_CATEGORY = Category.DATA;
		TARGET_NAME_FORMAT = Format.STRING;
		
		GR = 9;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		GR_NN = 10;
		GR_NN_TAG = 'gr_nn';
		GR_NN_CATEGORY = Category.RESULT;
		GR_NN_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function nnd_class = getClass()
			%GETCLASS returns the class of the data for neural network.
			%
			% CLASS = NNData.GETCLASS() returns the class 'NNData'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NND.GETCLASS() returns the class of the data for neural network NND.
			%  CLASS = Element.GETCLASS(NND) returns the class of 'NND'.
			%  CLASS = Element.GETCLASS('NNData') returns 'NNData'.
			%
			% See also getName, getDescription.
			
			nnd_class = 'NNData';
		end
		function nnd_name = getName()
			%GETNAME returns the name of the data for neural network.
			%
			% NAME = NNData.GETNAME() returns the name of the 'data for neural network'.
			%  Data For Neural Network.
			%
			% Alternative forms to call this method are:
			%  NAME = NND.GETNAME() returns the name of the data for neural network NND.
			%  NAME = Element.GETNAME(NND) returns the name of 'NND'.
			%  NAME = Element.GETNAME('NNData') returns the name of 'NNData'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nnd_name = 'Data For Neural Network';
		end
		function nnd_description = getDescription()
			%GETDESCRIPTION returns the description of the data for neural network.
			%
			% STR = NNData.GETDESCRIPTION() returns the description of the 'data for neural network'.
			%  which is:
			%
			%  
			%
			% Alternative forms to call this method are:
			%  STR = NND.GETDESCRIPTION() returns the description of the data for neural network NND.
			%  STR = Element.GETDESCRIPTION(NND) returns the description of 'NND'.
			%  STR = Element.GETDESCRIPTION('NNData') returns the description of 'NNData'.
			%
			% See also getClass, getName.
			
			nnd_description = [
				'' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of data for neural network.
			%
			% PROPS = NNData.GETPROPS() returns the property list of data for neural network.
			%
			% PROPS = NNData.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NND.GETPROPS([CATEGORY]) returns the property list of the data for neural network NND.
			%  PROPS = Element.GETPROPS(NND[, CATEGORY]) returns the property list of 'NND'.
			%  PROPS = Element.GETPROPS('NNData'[, CATEGORY]) returns the property list of 'NNData'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNData.LABEL
						NNData.NOTES
						NNData.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNData.ID
						NNData.INPUT_TYPE
						NNData.G
						NNData.MEASURES
						NNData.TARGET_NAME
						NNData.GR
						];
				case Category.RESULT
					prop_list = [
						NNData.GR_NN
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNData.ID
						NNData.LABEL
						NNData.NOTES
						NNData.WAITBAR
						NNData.INPUT_TYPE
						NNData.G
						NNData.MEASURES
						NNData.TARGET_NAME
						NNData.GR
						NNData.GR_NN
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of data for neural network.
			%
			% N = NNData.GETPROPNUMBER() returns the property number of data for neural network.
			%
			% Alternative forms to call this method are:
			%  N = NND.GETPROPNUMBER() returns the property number of the data for neural network NND.
			%  N = Element.GETPROPNUMBER(NND) returns the property number of 'NND'.
			%  N = Element.GETPROPNUMBER('NNData') returns the property number of 'NNData'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 10;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in data for neural network/error.
			%
			% CHECK = NNData.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NND.EXISTSPROP(PROP) checks whether PROP exists for NND.
			%  CHECK = Element.EXISTSPROP(NND, PROP) checks whether PROP exists for NND.
			%  CHECK = Element.EXISTSPROP(NNData, PROP) checks whether PROP exists for NNData.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNData:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NND.EXISTSPROP(PROP) throws error if PROP does NOT exist for NND.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  Element.EXISTSPROP(NND, PROP) throws error if PROP does NOT exist for NND.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  Element.EXISTSPROP(NNData, PROP) throws error if PROP does NOT exist for NNData.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10 ]);
			else
				assert( ...
					NNData.existsProp(prop), ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNData.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in data for neural network/error.
			%
			% CHECK = NNData.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NND.EXISTSTAG(TAG) checks whether TAG exists for NND.
			%  CHECK = Element.EXISTSTAG(NND, TAG) checks whether TAG exists for NND.
			%  CHECK = Element.EXISTSTAG(NNData, TAG) checks whether TAG exists for NNData.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNData:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NND.EXISTSTAG(TAG) throws error if TAG does NOT exist for NND.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  Element.EXISTSTAG(NND, TAG) throws error if TAG does NOT exist for NND.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  Element.EXISTSTAG(NNData, TAG) throws error if TAG does NOT exist for NNData.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nndata_tag_list = { 'id'  'label'  'notes'  'waitbar'  'input_type'  'g'  'measures'  'target_name'  'gr'  'gr_nn' };
				
				check = any(strcmpi(tag, nndata_tag_list));
			else
				assert( ...
					NNData.existsTag(tag), ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNData'] ...
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
			%  PROPERTY = NND.GETPROPPROP(POINTER) returns property number of POINTER of NND.
			%  PROPERTY = Element.GETPROPPROP(NNData, POINTER) returns property number of POINTER of NNData.
			%  PROPERTY = NND.GETPROPPROP(NNData, POINTER) returns property number of POINTER of NNData.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nndata_tag_list = { 'id'  'label'  'notes'  'waitbar'  'input_type'  'g'  'measures'  'target_name'  'gr'  'gr_nn' };
				
				tag = pointer;
				NNData.existsTag(tag);
				
				prop = find(strcmpi(tag, nndata_tag_list));
			else % numeric
				prop = pointer;
				NNData.existsProp(prop);
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
			%  TAG = NND.GETPROPTAG(POINTER) returns tag of POINTER of NND.
			%  TAG = Element.GETPROPTAG(NNData, POINTER) returns tag of POINTER of NNData.
			%  TAG = NND.GETPROPTAG(NNData, POINTER) returns tag of POINTER of NNData.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNData.existsTag(tag);
			else % numeric
				prop = pointer;
				NNData.existsProp(prop);
				
				switch prop
					case NNData.ID
						tag = NNData.ID_TAG;
					case NNData.LABEL
						tag = NNData.LABEL_TAG;
					case NNData.NOTES
						tag = NNData.NOTES_TAG;
					case NNData.WAITBAR
						tag = NNData.WAITBAR_TAG;
					case NNData.INPUT_TYPE
						tag = NNData.INPUT_TYPE_TAG;
					case NNData.G
						tag = NNData.G_TAG;
					case NNData.MEASURES
						tag = NNData.MEASURES_TAG;
					case NNData.TARGET_NAME
						tag = NNData.TARGET_NAME_TAG;
					case NNData.GR
						tag = NNData.GR_TAG;
					case NNData.GR_NN
						tag = NNData.GR_NN_TAG;
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
			%  CATEGORY = NND.GETPROPCATEGORY(POINTER) returns category of POINTER of NND.
			%  CATEGORY = Element.GETPROPCATEGORY(NNData, POINTER) returns category of POINTER of NNData.
			%  CATEGORY = NND.GETPROPCATEGORY(NNData, POINTER) returns category of POINTER of NNData.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					prop_category = NNData.ID_CATEGORY;
				case NNData.LABEL
					prop_category = NNData.LABEL_CATEGORY;
				case NNData.NOTES
					prop_category = NNData.NOTES_CATEGORY;
				case NNData.WAITBAR
					prop_category = NNData.WAITBAR_CATEGORY;
				case NNData.INPUT_TYPE
					prop_category = NNData.INPUT_TYPE_CATEGORY;
				case NNData.G
					prop_category = NNData.G_CATEGORY;
				case NNData.MEASURES
					prop_category = NNData.MEASURES_CATEGORY;
				case NNData.TARGET_NAME
					prop_category = NNData.TARGET_NAME_CATEGORY;
				case NNData.GR
					prop_category = NNData.GR_CATEGORY;
				case NNData.GR_NN
					prop_category = NNData.GR_NN_CATEGORY;
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
			%  FORMAT = NND.GETPROPFORMAT(POINTER) returns format of POINTER of NND.
			%  FORMAT = Element.GETPROPFORMAT(NNData, POINTER) returns format of POINTER of NNData.
			%  FORMAT = NND.GETPROPFORMAT(NNData, POINTER) returns format of POINTER of NNData.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					prop_format = NNData.ID_FORMAT;
				case NNData.LABEL
					prop_format = NNData.LABEL_FORMAT;
				case NNData.NOTES
					prop_format = NNData.NOTES_FORMAT;
				case NNData.WAITBAR
					prop_format = NNData.WAITBAR_FORMAT;
				case NNData.INPUT_TYPE
					prop_format = NNData.INPUT_TYPE_FORMAT;
				case NNData.G
					prop_format = NNData.G_FORMAT;
				case NNData.MEASURES
					prop_format = NNData.MEASURES_FORMAT;
				case NNData.TARGET_NAME
					prop_format = NNData.TARGET_NAME_FORMAT;
				case NNData.GR
					prop_format = NNData.GR_FORMAT;
				case NNData.GR_NN
					prop_format = NNData.GR_NN_FORMAT;
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
			%  DESCRIPTION = NND.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NND.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNData, POINTER) returns description of POINTER of NNData.
			%  DESCRIPTION = NND.GETPROPDESCRIPTION(NNData, POINTER) returns description of POINTER of NNData.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis.';
				case NNData.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis.';
				case NNData.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis.';
				case NNData.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
				case NNData.INPUT_TYPE
					prop_description = 'INPUT_TYPE (data, option) is the input type for training or testing the NN.';
				case NNData.G
					prop_description = 'G (data, item) is the graph for calculating the graph measures.';
				case NNData.MEASURES
					prop_description = 'MEASURES (data, classlist) is the graph measures as input to NN.';
				case NNData.TARGET_NAME
					prop_description = 'TARGET_NAME (data, string) is the name of the traget.';
				case NNData.GR
					prop_description = 'GR (data, item) is a group of subjects defined as SubjectCON class.';
				case NNData.GR_NN
					prop_description = 'GR_NN (result, item) is a group of NN subjects.';
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
			%  SETTINGS = NND.GETPROPSETTINGS(POINTER) returns settings of POINTER of NND.
			%  SETTINGS = Element.GETPROPSETTINGS(NNData, POINTER) returns settings of POINTER of NNData.
			%  SETTINGS = NND.GETPROPSETTINGS(NNData, POINTER) returns settings of POINTER of NNData.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNData.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNData.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNData.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNData.INPUT_TYPE
					prop_settings = {'adjacency_matrices' 'graph_measures' 'structural_data'};
				case NNData.G
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNData.MEASURES
					prop_settings = {'Measure'};
				case NNData.TARGET_NAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNData.GR
					prop_settings = 'Group';
				case NNData.GR_NN
					prop_settings = 'NNGroup';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNData.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNData.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NND.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NND.
			%  DEFAULT = Element.GETPROPDEFAULT(NNData, POINTER) returns the default value of POINTER of NNData.
			%  DEFAULT = NND.GETPROPDEFAULT(NNData, POINTER) returns the default value of POINTER of NNData.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					prop_default = Format.getFormatDefault(Format.STRING, NNData.getPropSettings(prop));
				case NNData.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, NNData.getPropSettings(prop));
				case NNData.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, NNData.getPropSettings(prop));
				case NNData.WAITBAR
					prop_default = true;
				case NNData.INPUT_TYPE
					prop_default = Format.getFormatDefault(Format.OPTION, NNData.getPropSettings(prop));
				case NNData.G
					prop_default = GraphWU();
				case NNData.MEASURES
					prop_default = {'DegreeAv', 'Degree'};
				case NNData.TARGET_NAME
					prop_default = 'diagnosis';
				case NNData.GR
					prop_default = Group();
				case NNData.GR_NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNData.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNData.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNData.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NND.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NND.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNData, POINTER) returns the conditioned default value of POINTER of NNData.
			%  DEFAULT = NND.GETPROPDEFAULTCONDITIONED(NNData, POINTER) returns the conditioned default value of POINTER of NNData.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNData.getPropProp(pointer);
			
			prop_default = NNData.conditioning(prop, NNData.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NND.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NND.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NND.
			%  CHECK = Element.CHECKPROP(NNData, PROP, VALUE) checks VALUE format for PROP of NNData.
			%  CHECK = NND.CHECKPROP(NNData, PROP, VALUE) checks VALUE format for PROP of NNData.
			% 
			% NND.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNData:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NND.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NND.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  Element.CHECKPROP(NNData, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNData.
			%   Error id: [BRAPH2:NNData:WrongInput]
			%  NND.CHECKPROP(NNData, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNData.
			%   Error id: [BRAPH2:NNData:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNData.getPropProp(pointer);
			
			switch prop
				case NNData.ID
					check = Format.checkFormat(Format.STRING, value, NNData.getPropSettings(prop));
				case NNData.LABEL
					check = Format.checkFormat(Format.STRING, value, NNData.getPropSettings(prop));
				case NNData.NOTES
					check = Format.checkFormat(Format.STRING, value, NNData.getPropSettings(prop));
				case NNData.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, NNData.getPropSettings(prop));
				case NNData.INPUT_TYPE
					check = Format.checkFormat(Format.OPTION, value, NNData.getPropSettings(prop));
				case NNData.G
					check = Format.checkFormat(Format.ITEM, value, NNData.getPropSettings(prop));
				case NNData.MEASURES
					check = Format.checkFormat(Format.CLASSLIST, value, NNData.getPropSettings(prop));
				case NNData.TARGET_NAME
					check = Format.checkFormat(Format.STRING, value, NNData.getPropSettings(prop));
				case NNData.GR
					check = Format.checkFormat(Format.ITEM, value, NNData.getPropSettings(prop));
				case NNData.GR_NN
					check = Format.checkFormat(Format.ITEM, value, NNData.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNData:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNData.getPropTag(prop) ' (' NNData.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nnd = NNData(varargin)
			% NNData() creates a data for neural network.
			%
			% NNData(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNData(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNData properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>input_type</strong> 	INPUT_TYPE (data, option) is the input type for training or testing the NN.
			%  <strong>6</strong> <strong>g</strong> 	G (data, item) is the graph for calculating the graph measures.
			%  <strong>7</strong> <strong>measures</strong> 	MEASURES (data, classlist) is the graph measures as input to NN.
			%  <strong>8</strong> <strong>target_name</strong> 	TARGET_NAME (data, string) is the name of the traget.
			%  <strong>9</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects defined as SubjectCON class.
			%  <strong>10</strong> <strong>gr_nn</strong> 	GR_NN (result, item) is a group of NN subjects.
			%
			% See also Category, Format, set, check.
			
			nnd = nnd@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNData.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnd, prop)
		
			switch prop
				otherwise
					value = calculateValue@Element(nnd, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(nnd, prop, varargin)
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
				case NNData.INPUT_TYPE
					pr = PPNNData_Input_Type('EL', nnd, 'PROP', NNData.INPUT_TYPE, varargin{:});
					
				case NNData.MEASURES
					pr = PPNNData_Measures('EL', nnd, 'PROP', NNData.MEASURES, varargin{:});
					
				case NNData.GR_NN
					pr = PPNNData_GR_NN('EL', nnd, 'PROP', NNData.GR_NN, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(nnd, prop, varargin{:});
					
			end
		end
	end
end
