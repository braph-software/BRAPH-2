classdef NNDataset < ConcreteElement
	%NNDataset is a dataset for neural network analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network dataset (NNDataset) represents a dataset containing datapoints whose class is defined by the DP_CLASS property.
	% NNDataset can contain all the necessary inputs and targets.
	%
	% NNDataset methods (constructor):
	%  NNDataset - constructor
	%
	% NNDataset methods:
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
	% NNDataset methods (display):
	%  tostring - string with information about the neural network data
	%  disp - displays information about the neural network data
	%  tree - displays the tree of the neural network data
	%
	% NNDataset methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network data
	%
	% NNDataset methods (save/load, Static):
	%  save - saves BRAPH2 neural network data as b2 file
	%  load - loads a BRAPH2 neural network data from a b2 file
	%
	% NNDataset method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network data
	%
	% NNDataset method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network data
	%
	% NNDataset methods (inspection, Static):
	%  getClass - returns the class of the neural network data
	%  getSubclasses - returns all subclasses of NNDataset
	%  getProps - returns the property list of the neural network data
	%  getPropNumber - returns the property number of the neural network data
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
	% NNDataset methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataset methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataset methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataset methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataset; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataset constants</a>.
	%
	%
	% See also NNDataPoint, NNDatasetCombine, NNDatasetSplit.
	
	properties (Constant) % properties
		DP_CLASS = ConcreteElement.getPropNumber() + 1;
		DP_CLASS_TAG = 'DP_CLASS';
		DP_CLASS_CATEGORY = Category.PARAMETER;
		DP_CLASS_FORMAT = Format.CLASS;
		
		DP_DICT = ConcreteElement.getPropNumber() + 2;
		DP_DICT_TAG = 'DP_DICT';
		DP_DICT_CATEGORY = Category.DATA;
		DP_DICT_FORMAT = Format.IDICT;
		
		INPUTS = ConcreteElement.getPropNumber() + 3;
		INPUTS_TAG = 'INPUTS';
		INPUTS_CATEGORY = Category.RESULT;
		INPUTS_FORMAT = Format.CELL;
		
		TARGETS = ConcreteElement.getPropNumber() + 4;
		TARGETS_TAG = 'TARGETS';
		TARGETS_CATEGORY = Category.RESULT;
		TARGETS_FORMAT = Format.CELL;
	end
	methods % constructor
		function d = NNDataset(varargin)
			%NNDataset() creates a neural network data.
			%
			% NNDataset(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataset(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			d = d@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function d_class = getClass()
			%GETCLASS returns the class of the neural network data.
			%
			% CLASS = NNDataset.GETCLASS() returns the class 'NNDataset'.
			%
			% Alternative forms to call this method are:
			%  CLASS = D.GETCLASS() returns the class of the neural network data D.
			%  CLASS = Element.GETCLASS(D) returns the class of 'D'.
			%  CLASS = Element.GETCLASS('NNDataset') returns 'NNDataset'.
			%
			% Note that the Element.GETCLASS(D) and Element.GETCLASS('NNDataset')
			%  are less computationally efficient.
			
			d_class = 'NNDataset';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network data.
			%
			% LIST = NNDataset.GETSUBCLASSES() returns all subclasses of 'NNDataset'.
			%
			% Alternative forms to call this method are:
			%  LIST = D.GETSUBCLASSES() returns all subclasses of the neural network data D.
			%  LIST = Element.GETSUBCLASSES(D) returns all subclasses of 'D'.
			%  LIST = Element.GETSUBCLASSES('NNDataset') returns all subclasses of 'NNDataset'.
			%
			% Note that the Element.GETSUBCLASSES(D) and Element.GETSUBCLASSES('NNDataset')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDataset', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network data.
			%
			% PROPS = NNDataset.GETPROPS() returns the property list of neural network data
			%  as a row vector.
			%
			% PROPS = NNDataset.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = D.GETPROPS([CATEGORY]) returns the property list of the neural network data D.
			%  PROPS = Element.GETPROPS(D[, CATEGORY]) returns the property list of 'D'.
			%  PROPS = Element.GETPROPS('NNDataset'[, CATEGORY]) returns the property list of 'NNDataset'.
			%
			% Note that the Element.GETPROPS(D) and Element.GETPROPS('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNDataset.DP_CLASS ...
						NNDataset.DP_DICT ...
						NNDataset.INPUTS ...
						NNDataset.TARGETS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						NNDataset.DP_CLASS ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNDataset.DP_DICT ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNDataset.INPUTS ...
						NNDataset.TARGETS ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network data.
			%
			% N = NNDataset.GETPROPNUMBER() returns the property number of neural network data.
			%
			% N = NNDataset.GETPROPNUMBER(CATEGORY) returns the property number of neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = D.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network data D.
			%  N = Element.GETPROPNUMBER(D) returns the property number of 'D'.
			%  N = Element.GETPROPNUMBER('NNDataset') returns the property number of 'NNDataset'.
			%
			% Note that the Element.GETPROPNUMBER(D) and Element.GETPROPNUMBER('NNDataset')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDataset.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network data/error.
			%
			% CHECK = NNDataset.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = D.EXISTSPROP(PROP) checks whether PROP exists for D.
			%  CHECK = Element.EXISTSPROP(D, PROP) checks whether PROP exists for D.
			%  CHECK = Element.EXISTSPROP(NNDataset, PROP) checks whether PROP exists for NNDataset.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataset:WrongInput]
			%
			% Alternative forms to call this method are:
			%  D.EXISTSPROP(PROP) throws error if PROP does NOT exist for D.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%  Element.EXISTSPROP(D, PROP) throws error if PROP does NOT exist for D.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%  Element.EXISTSPROP(NNDataset, PROP) throws error if PROP does NOT exist for NNDataset.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%
			% Note that the Element.EXISTSPROP(D) and Element.EXISTSPROP('NNDataset')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDataset.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataset.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network data/error.
			%
			% CHECK = NNDataset.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = D.EXISTSTAG(TAG) checks whether TAG exists for D.
			%  CHECK = Element.EXISTSTAG(D, TAG) checks whether TAG exists for D.
			%  CHECK = Element.EXISTSTAG(NNDataset, TAG) checks whether TAG exists for NNDataset.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataset:WrongInput]
			%
			% Alternative forms to call this method are:
			%  D.EXISTSTAG(TAG) throws error if TAG does NOT exist for D.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%  Element.EXISTSTAG(D, TAG) throws error if TAG does NOT exist for D.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%  Element.EXISTSTAG(NNDataset, TAG) throws error if TAG does NOT exist for NNDataset.
			%   Error id: [BRAPH2:NNDataset:WrongInput]
			%
			% Note that the Element.EXISTSTAG(D) and Element.EXISTSTAG('NNDataset')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndataset_tag_list = cellfun(@(x) NNDataset.getPropTag(x), num2cell(NNDataset.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndataset_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDataset.'] ...
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
			%  PROPERTY = D.GETPROPPROP(POINTER) returns property number of POINTER of D.
			%  PROPERTY = Element.GETPROPPROP(NNDataset, POINTER) returns property number of POINTER of NNDataset.
			%  PROPERTY = D.GETPROPPROP(NNDataset, POINTER) returns property number of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPPROP(D) and Element.GETPROPPROP('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndataset_tag_list = cellfun(@(x) NNDataset.getPropTag(x), num2cell(NNDataset.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndataset_tag_list)); % tag = pointer
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
			%  TAG = D.GETPROPTAG(POINTER) returns tag of POINTER of D.
			%  TAG = Element.GETPROPTAG(NNDataset, POINTER) returns tag of POINTER of NNDataset.
			%  TAG = D.GETPROPTAG(NNDataset, POINTER) returns tag of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPTAG(D) and Element.GETPROPTAG('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDataset.DP_CLASS
						tag = NNDataset.DP_CLASS_TAG;
					case NNDataset.DP_DICT
						tag = NNDataset.DP_DICT_TAG;
					case NNDataset.INPUTS
						tag = NNDataset.INPUTS_TAG;
					case NNDataset.TARGETS
						tag = NNDataset.TARGETS_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
				end
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
			%  CATEGORY = D.GETPROPCATEGORY(POINTER) returns category of POINTER of D.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataset, POINTER) returns category of POINTER of NNDataset.
			%  CATEGORY = D.GETPROPCATEGORY(NNDataset, POINTER) returns category of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPCATEGORY(D) and Element.GETPROPCATEGORY('NNDataset')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS
					prop_category = NNDataset.DP_CLASS_CATEGORY;
				case NNDataset.DP_DICT
					prop_category = NNDataset.DP_DICT_CATEGORY;
				case NNDataset.INPUTS
					prop_category = NNDataset.INPUTS_CATEGORY;
				case NNDataset.TARGETS
					prop_category = NNDataset.TARGETS_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = D.GETPROPFORMAT(POINTER) returns format of POINTER of D.
			%  FORMAT = Element.GETPROPFORMAT(NNDataset, POINTER) returns format of POINTER of NNDataset.
			%  FORMAT = D.GETPROPFORMAT(NNDataset, POINTER) returns format of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPFORMAT(D) and Element.GETPROPFORMAT('NNDataset')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS
					prop_format = NNDataset.DP_CLASS_FORMAT;
				case NNDataset.DP_DICT
					prop_format = NNDataset.DP_DICT_FORMAT;
				case NNDataset.INPUTS
					prop_format = NNDataset.INPUTS_FORMAT;
				case NNDataset.TARGETS
					prop_format = NNDataset.TARGETS_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = D.GETPROPDESCRIPTION(POINTER) returns description of POINTER of D.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataset, POINTER) returns description of POINTER of NNDataset.
			%  DESCRIPTION = D.GETPROPDESCRIPTION(NNDataset, POINTER) returns description of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPDESCRIPTION(D) and Element.GETPROPDESCRIPTION('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS
					prop_description = 'DP_CLASS (parameter, class) is the class of the data points';
				case NNDataset.DP_DICT
					prop_description = 'DP_DICT (data, idict) is an indexed dictionary containing the data points.';
				case NNDataset.INPUTS
					prop_description = 'INPUTS (result, cell) is a collection of the inputs from all data points.';
				case NNDataset.TARGETS
					prop_description = 'TARGETS (result, cell) is a collection of the targets from all data points.';
				case NNDataset.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the dataset for neural network analysis.';
				case NNDataset.NAME
					prop_description = 'NAME (constant, string) is the name of the dataset for neural network analysis.';
				case NNDataset.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the dataset for neural network analysis.';
				case NNDataset.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the dataset for neural network analysis.';
				case NNDataset.ID
					prop_description = 'ID (data, string) is a few-letter code for the dataset for neural network analysis.';
				case NNDataset.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the dataset for neural network analysis.';
				case NNDataset.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the dataset for neural network analysis.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = D.GETPROPSETTINGS(POINTER) returns settings of POINTER of D.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataset, POINTER) returns settings of POINTER of NNDataset.
			%  SETTINGS = D.GETPROPSETTINGS(NNDataset, POINTER) returns settings of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPSETTINGS(D) and Element.GETPROPSETTINGS('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS
					prop_settings = 'NNDataPoint';
				case NNDataset.DP_DICT
					prop_settings = 'NNDataPoint';
				case NNDataset.INPUTS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataset.TARGETS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataset.TEMPLATE
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataset.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataset.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = D.GETPROPDEFAULT(POINTER) returns the default value of POINTER of D.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataset, POINTER) returns the default value of POINTER of NNDataset.
			%  DEFAULT = D.GETPROPDEFAULT(NNDataset, POINTER) returns the default value of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPDEFAULT(D) and Element.GETPROPDEFAULT('NNDataset')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS
					prop_default = Format.getFormatDefault(Format.CLASS, NNDataset.getPropSettings(prop));
				case NNDataset.DP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, NNDataset.getPropSettings(prop));
				case NNDataset.INPUTS
					prop_default = Format.getFormatDefault(Format.CELL, NNDataset.getPropSettings(prop));
				case NNDataset.TARGETS
					prop_default = Format.getFormatDefault(Format.CELL, NNDataset.getPropSettings(prop));
				case NNDataset.ELCLASS
					prop_default = 'NNDataset';
				case NNDataset.NAME
					prop_default = 'Neural Network Dataset';
				case NNDataset.DESCRIPTION
					prop_default = 'A neural network dataset (NNDataset) represents a dataset containing datapoints whose class is defined by the DP_CLASS property. NNDataset can contain all the necessary inputs and targets.';
				case NNDataset.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataset.getPropSettings(prop));
				case NNDataset.ID
					prop_default = 'NNDataset ID';
				case NNDataset.LABEL
					prop_default = 'NNDataset label';
				case NNDataset.NOTES
					prop_default = 'NNDataset notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataset.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataset.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = D.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of D.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataset, POINTER) returns the conditioned default value of POINTER of NNDataset.
			%  DEFAULT = D.GETPROPDEFAULTCONDITIONED(NNDataset, POINTER) returns the conditioned default value of POINTER of NNDataset.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(D) and Element.GETPROPDEFAULTCONDITIONED('NNDataset')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataset.getPropProp(pointer);
			
			prop_default = NNDataset.conditioning(prop, NNDataset.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = D.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = D.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of D.
			%  CHECK = Element.CHECKPROP(NNDataset, PROP, VALUE) checks VALUE format for PROP of NNDataset.
			%  CHECK = D.CHECKPROP(NNDataset, PROP, VALUE) checks VALUE format for PROP of NNDataset.
			% 
			% D.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDataset:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  D.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of D.
			%   Error id: €BRAPH2.STR€:NNDataset:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDataset, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataset.
			%   Error id: €BRAPH2.STR€:NNDataset:€BRAPH2.WRONG_INPUT€
			%  D.CHECKPROP(NNDataset, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataset.
			%   Error id: €BRAPH2.STR€:NNDataset:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(D) and Element.CHECKPROP('NNDataset')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataset.getPropProp(pointer);
			
			switch prop
				case NNDataset.DP_CLASS % __NNDataset.DP_CLASS__
					check = Format.checkFormat(Format.CLASS, value, NNDataset.getPropSettings(prop));
				case NNDataset.DP_DICT % __NNDataset.DP_DICT__
					check = Format.checkFormat(Format.IDICT, value, NNDataset.getPropSettings(prop));
				case NNDataset.INPUTS % __NNDataset.INPUTS__
					check = Format.checkFormat(Format.CELL, value, NNDataset.getPropSettings(prop));
				case NNDataset.TARGETS % __NNDataset.TARGETS__
					check = Format.checkFormat(Format.CELL, value, NNDataset.getPropSettings(prop));
				case NNDataset.TEMPLATE % __NNDataset.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDataset.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataset:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataset.getPropTag(prop) ' (' NNDataset.getFormatTag(NNDataset.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(d, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case NNDataset.INPUTS % __NNDataset.INPUTS__
					rng_settings_ = rng(); rng(d.getPropSeed(NNDataset.INPUTS), 'twister')
					
					value = cellfun(@(dp) dp.get('INPUT'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case NNDataset.TARGETS % __NNDataset.TARGETS__
					rng_settings_ = rng(); rng(d.getPropSeed(NNDataset.TARGETS), 'twister')
					
					value = cellfun(@(dp) dp.get('TARGET'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(d, prop, varargin{:});
					else
						value = calculateValue@Element(d, prop, varargin{:});
					end
			end
			
		end
	end
end
