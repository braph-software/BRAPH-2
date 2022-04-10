classdef NNBase < Element
	% NNBase is a base neural network.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% NNBase provides the methods necessary for setting up neural networks.
	% Instances of this class should not be created. 
	% Use one of its subclasses instead.
	%
	% The list of NNBase properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the neural network.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the neural network.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the neural network.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects containing the information for training the neural network.
	%  <strong>5</strong> <strong>model</strong> 	MODEL (result, cell) is a trained neural network.
	%
	% NNBase methods (constructor):
	% NNBase - constructor
	%
	% NNBase methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in base neural network/error.
	%  existsProp - checks whether property exists in base neural network/error.
	%  getPropNumber - returns the property number of base neural network.
	%  getProps - returns the property list of base neural network.
	%  getDescription - returns the description of the base neural network.
	%  getName - returns the name of the base neural network.
	%  getClass - returns the class of the base neural network.
	%
	% NNBase methods:
	%  to_net - transforms the saved neural network
	%  from_net - saves the newtork object as the binary format in braph.
	%  check_nn_toolboxes - checks whether the deep-learning-required toolboxes are installed.
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
	% NNBase methods (operators):
	%  isequal - determines whether two NNBase are equal (values, locked)
	%
	% NNBase methods (display):
	%  tostring - string with information about the NNBase
	%  disp - displays information about the NNBase
	%  tree - displays the element of NNBase
	%
	% NNBase method (element list):
	%  getElementList - returns a list with all subelements of NNBase
	%
	% NNBase method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NNBase
	%
	% NNBase method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the NNBase
	%
	% NNBase methods (copy):
	%  copy - copies the NNBase
	%  deepclone - deep-clones the NNBase
	%  clone - clones the NNBase
	%
	% NNBase methods (inspection, Static):
	%  getClass - returns NNBase
	%  getName - returns the name of NNBase
	%  getDescription - returns the description of NNBase
	%  getProps - returns the property list of NNBase
	%  getPropNumber - returns the property number of NNBase
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
	% NNBase methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNBase methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% NNBase methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% NNBase methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% NNBase properties (Constant).
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
		
		GR = 4;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		MODEL = 5;
		MODEL_TAG = 'model';
		MODEL_CATEGORY = Category.RESULT;
		MODEL_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function nn_class = getClass()
			%GETCLASS returns the class of the base neural network.
			%
			% CLASS = NNBase.GETCLASS() returns the class 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the base neural network NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNBase') returns 'NNBase'.
			%
			% See also getName, getDescription.
			
			nn_class = 'NNBase';
		end
		function nn_name = getName()
			%GETNAME returns the name of the base neural network.
			%
			% NAME = NNBase.GETNAME() returns the name of the 'base neural network'.
			%  Base Neural Network.
			%
			% Alternative forms to call this method are:
			%  NAME = NN.GETNAME() returns the name of the base neural network NN.
			%  NAME = Element.GETNAME(NN) returns the name of 'NN'.
			%  NAME = Element.GETNAME('NNBase') returns the name of 'NNBase'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			nn_name = 'Base Neural Network';
		end
		function nn_description = getDescription()
			%GETDESCRIPTION returns the description of the base neural network.
			%
			% STR = NNBase.GETDESCRIPTION() returns the description of the 'base neural network'.
			%  which is:
			%
			%  NNBase provides the methods necessary for setting up neural networks.
			%  Instances of this class should not be created. 
			%  Use one of its subclasses instead.
			%
			% Alternative forms to call this method are:
			%  STR = NN.GETDESCRIPTION() returns the description of the base neural network NN.
			%  STR = Element.GETDESCRIPTION(NN) returns the description of 'NN'.
			%  STR = Element.GETDESCRIPTION('NNBase') returns the description of 'NNBase'.
			%
			% See also getClass, getName.
			
			nn_description = [
				'NNBase provides the methods necessary for setting up neural networks.' ...
				'Instances of this class should not be created. ' ...
				'Use one of its subclasses instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of base neural network.
			%
			% PROPS = NNBase.GETPROPS() returns the property list of base neural network.
			%
			% PROPS = NNBase.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the base neural network NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNBase'[, CATEGORY]) returns the property list of 'NNBase'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						NNBase.LABEL
						NNBase.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						NNBase.ID
						NNBase.GR
						];
				case Category.RESULT
					prop_list = [
						NNBase.MODEL
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						NNBase.ID
						NNBase.LABEL
						NNBase.NOTES
						NNBase.GR
						NNBase.MODEL
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of base neural network.
			%
			% N = NNBase.GETPROPNUMBER() returns the property number of base neural network.
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER() returns the property number of the base neural network NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNBase') returns the property number of 'NNBase'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in base neural network/error.
			%
			% CHECK = NNBase.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNBase, PROP) checks whether PROP exists for NNBase.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NNBase, PROP) throws error if PROP does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					NNBase.existsProp(prop), ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNBase.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in base neural network/error.
			%
			% CHECK = NNBase.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNBase, TAG) checks whether TAG exists for NNBase.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NNBase, TAG) throws error if TAG does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				nnbase_tag_list = { 'id'  'label'  'notes'  'gr'  'model' };
				
				check = any(strcmpi(tag, nnbase_tag_list));
			else
				assert( ...
					NNBase.existsTag(tag), ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for NNBase'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%  PROPERTY = NN.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				nnbase_tag_list = { 'id'  'label'  'notes'  'gr'  'model' };
				
				tag = pointer;
				NNBase.existsTag(tag);
				
				prop = find(strcmpi(tag, nnbase_tag_list));
			else % numeric
				prop = pointer;
				NNBase.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%  TAG = NN.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				NNBase.existsTag(tag);
			else % numeric
				prop = pointer;
				NNBase.existsProp(prop);
				
				switch prop
					case NNBase.ID
						tag = NNBase.ID_TAG;
					case NNBase.LABEL
						tag = NNBase.LABEL_TAG;
					case NNBase.NOTES
						tag = NNBase.NOTES_TAG;
					case NNBase.GR
						tag = NNBase.GR_TAG;
					case NNBase.MODEL
						tag = NNBase.MODEL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%  CATEGORY = NN.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					prop_category = NNBase.ID_CATEGORY;
				case NNBase.LABEL
					prop_category = NNBase.LABEL_CATEGORY;
				case NNBase.NOTES
					prop_category = NNBase.NOTES_CATEGORY;
				case NNBase.GR
					prop_category = NNBase.GR_CATEGORY;
				case NNBase.MODEL
					prop_category = NNBase.MODEL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%  FORMAT = NN.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					prop_format = NNBase.ID_FORMAT;
				case NNBase.LABEL
					prop_format = NNBase.LABEL_FORMAT;
				case NNBase.NOTES
					prop_format = NNBase.NOTES_FORMAT;
				case NNBase.GR
					prop_format = NNBase.GR_FORMAT;
				case NNBase.MODEL
					prop_format = NNBase.MODEL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network.';
				case NNBase.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network.';
				case NNBase.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network.';
				case NNBase.GR
					prop_description = 'GR (data, item) is a group of NN subjects containing the information for training the neural network.';
				case NNBase.MODEL
					prop_description = 'MODEL (result, cell) is a trained neural network.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%  SETTINGS = NN.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNBase.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNBase.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case NNBase.GR
					prop_settings = 'NNGroup';
				case NNBase.MODEL
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					prop_default = Format.getFormatDefault(Format.STRING, NNBase.getPropSettings(prop));
				case NNBase.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, NNBase.getPropSettings(prop));
				case NNBase.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, NNBase.getPropSettings(prop));
				case NNBase.GR
					prop_default = Format.getFormatDefault(Format.ITEM, NNBase.getPropSettings(prop));
				case NNBase.MODEL
					prop_default = Format.getFormatDefault(Format.CELL, NNBase.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			prop_default = NNBase.conditioning(prop, NNBase.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			%  CHECK = NN.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  NN.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.ID
					check = Format.checkFormat(Format.STRING, value, NNBase.getPropSettings(prop));
				case NNBase.LABEL
					check = Format.checkFormat(Format.STRING, value, NNBase.getPropSettings(prop));
				case NNBase.NOTES
					check = Format.checkFormat(Format.STRING, value, NNBase.getPropSettings(prop));
				case NNBase.GR
					check = Format.checkFormat(Format.ITEM, value, NNBase.getPropSettings(prop));
				case NNBase.MODEL
					check = Format.checkFormat(Format.CELL, value, NNBase.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNBase.getPropTag(prop) ' (' NNBase.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function nn = NNBase(varargin)
			% NNBase() creates a base neural network.
			%
			% NNBase(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNBase(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNBase properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the neural network.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the neural network.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the neural network.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is a group of NN subjects containing the information for training the neural network.
			%  <strong>5</strong> <strong>model</strong> 	MODEL (result, cell) is a trained neural network.
			%
			% See also Category, Format, set, check.
			
			nn = nn@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nn, prop)
		
			switch prop
				otherwise
					value = calculateValue@Element(nn, prop);
					
			end
		end
	end
	methods % methods
		function installed = check_nn_toolboxes(nn)
		    %CHECK_NN_TOOLBOXES checks whether the deep-learning-required toolboxes are installed.
		    %
		    % INSTALLED = CHECK_NN_TOOLBOXES(NN) checks the installation of the toolboxes:
		    %  "Deep Learning Toolbox" and 
		    %  "Deep learning Toolbox Converter for ONNX Model Format" installation status. 
		    %  If they are not installed, then it throws a warning.
		    %  Typically, this method is only called internally when training
		    %  any subclass of the neural networks.
		    
		    addons = matlab.addons.installedAddons;
		    installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
		    if ~installed
		        warning(['Some of the required deep-learning toolboxs are not installed. ' ...
		            'Please, refer to ' ...
		            '<a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> ' ...
		            'and ' ...
		            '<a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>'])
		    end
		end
		function nn_cell = from_net(nn, net)
		    %FROM_NET saves the newtork object as the binary format in braph.
		    % 
		    % NN_CELL = FROM_NET(NN, NET) transforms the build-in neural network
		    %  object NET to a cell format. Firstly, the NET is exported to an
		    %  ONNX file and then the file is imported as the binary format which 
		    %  can be saved as cell in braph.
		    %  Typically, this method is called internally when a neural network
		    %  model is trained and ready to be saved in braph.
		    %
		    % See also to_net.
		    
		    w = warning('query','MATLAB:mir_warning_unrecognized_pragma');
		    warning('off', 'MATLAB:mir_warning_unrecognized_pragma');
		
		    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_from_matlab_to_be_erased'];
		    if ~exist(directory, 'dir')
		        mkdir(directory)
		    end
		    filename = [directory filesep 'nn_from_matlab_to_be_erased.onnx'];
		
		    exportONNXNetwork(net, filename);
		    
		    fileID = fopen(filename);
		    nn_cell = {fread(fileID)};	
		    fclose(fileID);
		    
		    rmdir(directory, 's')
		    warning(w.state, 'MATLAB:mir_warning_unrecognized_pragma')
		end
		function net = to_net(nn, saved_nn, varargin)
		    %TO_NET transforms the saved neural network 
		    % in braph to a build-in object in matlab.
		    %
		    % NET = TO_NET(NN) transforms the saved neural network in braph
		    %  to a build-in object in matlab. Firstly the saved neural network
		    %  in braph is exported as an ONNX file, and then the file is 
		    %  imported as a build-in neural network object in matlab.
		    %  Typically, this method is called internally when a saved neural 
		    %  network model is evaluated by a test data.
		    %
		    % See also from_net.
		    
		    w_matlab = warning('query','MATLAB:mir_warning_unrecognized_pragma');
		    warning('off', 'MATLAB:mir_warning_unrecognized_pragma');
		    w_nnet = warning('query','nnet_cnn:internal:cnn:analyzer:NetworkAnalyzer:NetworkHasWarnings');
		    warning('off','nnet_cnn:internal:cnn:analyzer:NetworkAnalyzer:NetworkHasWarnings');
		
		    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_from_braph_to_be_erased'];
		    if ~exist(directory, 'dir')
		        mkdir(directory)
		    end
		    filename = [directory filesep 'nn_from_braph_to_be_erased.onnx'];
		
		    fileID = fopen(filename, 'w');
		    fwrite(fileID, saved_nn{1});
		    fclose(fileID);
		    
		    if length(varargin) == 3
		        format = varargin{1};
		        type = varargin{2};
		        class_name = varargin{3};
		        net = importONNXNetwork(filename, "InputDataFormats", format, "OutputLayerType", type, "Classes", class_name);
		    elseif length(varargin) == 2
		        format = varargin{1};
		        type = varargin{2};
		        net = importONNXNetwork(filename, "InputDataFormats", format, "OutputLayerType", type);
		    else
		        lgraph = importONNXLayers(filename, "InputDataFormats", "BCSS");
		        net = assembleNetwork(lgraph);
		    end
		    
		    rmdir(directory, 's');
		    warning(w_matlab.state, 'MATLAB:mir_warning_unrecognized_pragma');
		    warning(w_nnet.state,'nnet_cnn:internal:cnn:analyzer:NetworkAnalyzer:NetworkHasWarnings');
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
				case NNBase.MODEL
					pr = PPNNBase_Model('EL', nn, 'PROP', nn.MODEL, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(nn, prop, varargin{:});
					
			end
		end
	end
end
