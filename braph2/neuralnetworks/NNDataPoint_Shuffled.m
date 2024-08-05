classdef NNDataPoint_Shuffled < NNDataPoint
	%NNDataPoint_Shuffled is a data point with shuffled features for for multi-layer perceptron neural network.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis.
	% The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.
	%
	% NNDataPoint_Shuffled methods (constructor):
	%  NNDataPoint_Shuffled - constructor
	%
	% NNDataPoint_Shuffled methods:
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
	% NNDataPoint_Shuffled methods (display):
	%  tostring - string with information about the shuffled neural network data point for multi-layer perceptron
	%  disp - displays information about the shuffled neural network data point for multi-layer perceptron
	%  tree - displays the tree of the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPoint_Shuffled methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two shuffled neural network data point for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPoint_Shuffled methods (save/load, Static):
	%  save - saves BRAPH2 shuffled neural network data point for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 shuffled neural network data point for multi-layer perceptron from a b2 file
	%
	% NNDataPoint_Shuffled method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPoint_Shuffled method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPoint_Shuffled methods (inspection, Static):
	%  getClass - returns the class of the shuffled neural network data point for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNDataPoint_Shuffled
	%  getProps - returns the property list of the shuffled neural network data point for multi-layer perceptron
	%  getPropNumber - returns the property number of the shuffled neural network data point for multi-layer perceptron
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
	% NNDataPoint_Shuffled methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint_Shuffled methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint_Shuffled methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint_Shuffled methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint_Shuffled; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint_Shuffled constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset.
	
	properties (Constant) % properties
		SHUFFLED_INPUT = NNDataPoint.getPropNumber() + 1;
		SHUFFLED_INPUT_TAG = 'SHUFFLED_INPUT';
		SHUFFLED_INPUT_CATEGORY = Category.DATA;
		SHUFFLED_INPUT_FORMAT = Format.CELL;
	end
	methods % constructor
		function dp = NNDataPoint_Shuffled(varargin)
			%NNDataPoint_Shuffled() creates a shuffled neural network data point for multi-layer perceptron.
			%
			% NNDataPoint_Shuffled(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint_Shuffled(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function dp_class = getClass()
			%GETCLASS returns the class of the shuffled neural network data point for multi-layer perceptron.
			%
			% CLASS = NNDataPoint_Shuffled.GETCLASS() returns the class 'NNDataPoint_Shuffled'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the shuffled neural network data point for multi-layer perceptron DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint_Shuffled') returns 'NNDataPoint_Shuffled'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint_Shuffled';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the shuffled neural network data point for multi-layer perceptron.
			%
			% LIST = NNDataPoint_Shuffled.GETSUBCLASSES() returns all subclasses of 'NNDataPoint_Shuffled'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the shuffled neural network data point for multi-layer perceptron DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint_Shuffled') returns all subclasses of 'NNDataPoint_Shuffled'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDataPoint_Shuffled', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of shuffled neural network data point for multi-layer perceptron.
			%
			% PROPS = NNDataPoint_Shuffled.GETPROPS() returns the property list of shuffled neural network data point for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNDataPoint_Shuffled.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the shuffled neural network data point for multi-layer perceptron DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint_Shuffled'[, CATEGORY]) returns the property list of 'NNDataPoint_Shuffled'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNDataPoint.getProps() ...
						NNDataPoint_Shuffled.SHUFFLED_INPUT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNDataPoint.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNDataPoint.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNDataPoint.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNDataPoint.getProps(Category.DATA) ...
						NNDataPoint_Shuffled.SHUFFLED_INPUT ...
						];
				case Category.RESULT
					prop_list = [
						NNDataPoint.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNDataPoint.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNDataPoint.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNDataPoint.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNDataPoint.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of shuffled neural network data point for multi-layer perceptron.
			%
			% N = NNDataPoint_Shuffled.GETPROPNUMBER() returns the property number of shuffled neural network data point for multi-layer perceptron.
			%
			% N = NNDataPoint_Shuffled.GETPROPNUMBER(CATEGORY) returns the property number of shuffled neural network data point for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the shuffled neural network data point for multi-layer perceptron DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint_Shuffled') returns the property number of 'NNDataPoint_Shuffled'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDataPoint_Shuffled.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in shuffled neural network data point for multi-layer perceptron/error.
			%
			% CHECK = NNDataPoint_Shuffled.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint_Shuffled, PROP) checks whether PROP exists for NNDataPoint_Shuffled.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint_Shuffled, PROP) throws error if PROP does NOT exist for NNDataPoint_Shuffled.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDataPoint_Shuffled.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint_Shuffled.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in shuffled neural network data point for multi-layer perceptron/error.
			%
			% CHECK = NNDataPoint_Shuffled.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint_Shuffled, TAG) checks whether TAG exists for NNDataPoint_Shuffled.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint_Shuffled, TAG) throws error if TAG does NOT exist for NNDataPoint_Shuffled.
			%   Error id: [BRAPH2:NNDataPoint_Shuffled:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndatapoint_shuffled_tag_list = cellfun(@(x) NNDataPoint_Shuffled.getPropTag(x), num2cell(NNDataPoint_Shuffled.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndatapoint_shuffled_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint_Shuffled.'] ...
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
			%  PROPERTY = DP.GETPROPPROP(POINTER) returns property number of POINTER of DP.
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint_Shuffled, POINTER) returns property number of POINTER of NNDataPoint_Shuffled.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint_Shuffled, POINTER) returns property number of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndatapoint_shuffled_tag_list = cellfun(@(x) NNDataPoint_Shuffled.getPropTag(x), num2cell(NNDataPoint_Shuffled.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndatapoint_shuffled_tag_list)); % tag = pointer
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
			%  TAG = DP.GETPROPTAG(POINTER) returns tag of POINTER of DP.
			%  TAG = Element.GETPROPTAG(NNDataPoint_Shuffled, POINTER) returns tag of POINTER of NNDataPoint_Shuffled.
			%  TAG = DP.GETPROPTAG(NNDataPoint_Shuffled, POINTER) returns tag of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDataPoint_Shuffled.SHUFFLED_INPUT
						tag = NNDataPoint_Shuffled.SHUFFLED_INPUT_TAG;
					otherwise
						tag = getPropTag@NNDataPoint(prop);
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
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint_Shuffled, POINTER) returns category of POINTER of NNDataPoint_Shuffled.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint_Shuffled, POINTER) returns category of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT
					prop_category = NNDataPoint_Shuffled.SHUFFLED_INPUT_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNDataPoint(prop);
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
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint_Shuffled, POINTER) returns format of POINTER of NNDataPoint_Shuffled.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint_Shuffled, POINTER) returns format of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT
					prop_format = NNDataPoint_Shuffled.SHUFFLED_INPUT_FORMAT;
				otherwise
					prop_format = getPropFormat@NNDataPoint(prop);
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
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint_Shuffled, POINTER) returns description of POINTER of NNDataPoint_Shuffled.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint_Shuffled, POINTER) returns description of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT
					prop_description = 'SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.';
				case NNDataPoint_Shuffled.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the shuffled data point for neural network analysis .';
				case NNDataPoint_Shuffled.NAME
					prop_description = 'NAME (constant, string) is the name of the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.ID
					prop_description = 'ID (data, string) is a few-letter code for the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the shuffled data point for neural network analysis.';
				case NNDataPoint_Shuffled.INPUT
					prop_description = 'INPUT (result, cell) is the input value for this data point for neural network analysis.';
				otherwise
					prop_description = getPropDescription@NNDataPoint(prop);
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
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint_Shuffled, POINTER) returns settings of POINTER of NNDataPoint_Shuffled.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint_Shuffled, POINTER) returns settings of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataPoint_Shuffled.TEMPLATE
					prop_settings = 'NNDataPoint_Shuffled';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint_Shuffled.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Shuffled.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint_Shuffled, POINTER) returns the default value of POINTER of NNDataPoint_Shuffled.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint_Shuffled, POINTER) returns the default value of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT
					prop_default = Format.getFormatDefault(Format.CELL, NNDataPoint_Shuffled.getPropSettings(prop));
				case NNDataPoint_Shuffled.ELCLASS
					prop_default = 'NNDataPoint_Shuffled';
				case NNDataPoint_Shuffled.NAME
					prop_default = 'Shuffled Neural Network Data Point';
				case NNDataPoint_Shuffled.DESCRIPTION
					prop_default = 'A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis. The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.';
				case NNDataPoint_Shuffled.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataPoint_Shuffled.getPropSettings(prop));
				case NNDataPoint_Shuffled.ID
					prop_default = 'NNDataPoint_Shuffled ID';
				case NNDataPoint_Shuffled.LABEL
					prop_default = 'NNDataPoint_Shuffled label';
				case NNDataPoint_Shuffled.NOTES
					prop_default = 'NNDataPoint_Permuted notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint_Shuffled.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Shuffled.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint_Shuffled, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Shuffled.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint_Shuffled, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Shuffled.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			prop_default = NNDataPoint_Shuffled.conditioning(prop, NNDataPoint_Shuffled.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DP.
			%  CHECK = Element.CHECKPROP(NNDataPoint_Shuffled, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Shuffled.
			%  CHECK = DP.CHECKPROP(NNDataPoint_Shuffled, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Shuffled.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDataPoint_Shuffled:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: €BRAPH2.STR€:NNDataPoint_Shuffled:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDataPoint_Shuffled, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Shuffled.
			%   Error id: €BRAPH2.STR€:NNDataPoint_Shuffled:€BRAPH2.WRONG_INPUT€
			%  DP.CHECKPROP(NNDataPoint_Shuffled, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Shuffled.
			%   Error id: €BRAPH2.STR€:NNDataPoint_Shuffled:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint_Shuffled')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint_Shuffled.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_Shuffled.SHUFFLED_INPUT % __NNDataPoint_Shuffled.SHUFFLED_INPUT__
					check = Format.checkFormat(Format.CELL, value, NNDataPoint_Shuffled.getPropSettings(prop));
				case NNDataPoint_Shuffled.TEMPLATE % __NNDataPoint_Shuffled.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDataPoint_Shuffled.getPropSettings(prop));
				otherwise
					if prop <= NNDataPoint.getPropNumber()
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_Shuffled:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint_Shuffled.getPropTag(prop) ' (' NNDataPoint_Shuffled.getFormatTag(NNDataPoint_Shuffled.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dp, prop, varargin)
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
				case NNDataPoint_Shuffled.INPUT % __NNDataPoint_Shuffled.INPUT__
					rng_settings_ = rng(); rng(dp.getPropSeed(NNDataPoint_Shuffled.INPUT), 'twister')
					
					value = dp.get('SHUFFLED_INPUT');
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNDataPoint.getPropNumber()
						value = calculateValue@NNDataPoint(dp, prop, varargin{:});
					else
						value = calculateValue@Element(dp, prop, varargin{:});
					end
			end
			
		end
	end
end
