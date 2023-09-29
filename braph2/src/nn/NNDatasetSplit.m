classdef NNDatasetSplit < ConcreteElement
	%NNDatasetSplit splits a dataset into several partitioned datasets based on specified indices or proportions.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. 
	% The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset.
	% For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}.
	% Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).
	%
	% NNDatasetSplit methods (constructor):
	%  NNDatasetSplit - constructor
	%
	% NNDatasetSplit methods:
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
	% NNDatasetSplit methods (display):
	%  tostring - string with information about the splitter of a neural network data
	%  disp - displays information about the splitter of a neural network data
	%  tree - displays the tree of the splitter of a neural network data
	%
	% NNDatasetSplit methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two splitter of a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the splitter of a neural network data
	%
	% NNDatasetSplit methods (save/load, Static):
	%  save - saves BRAPH2 splitter of a neural network data as b2 file
	%  load - loads a BRAPH2 splitter of a neural network data from a b2 file
	%
	% NNDatasetSplit method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the splitter of a neural network data
	%
	% NNDatasetSplit method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the splitter of a neural network data
	%
	% NNDatasetSplit methods (inspection, Static):
	%  getClass - returns the class of the splitter of a neural network data
	%  getSubclasses - returns all subclasses of NNDatasetSplit
	%  getProps - returns the property list of the splitter of a neural network data
	%  getPropNumber - returns the property number of the splitter of a neural network data
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
	% NNDatasetSplit methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetSplit methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetSplit methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetSplit methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetSplit; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetSplit constants</a>.
	%
	%
	% See also NNDataset, NNDatasetCombine.
	
	properties (Constant) % properties
		D = ConcreteElement.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEM;
		
		SPLIT = ConcreteElement.getPropNumber() + 2;
		SPLIT_TAG = 'SPLIT';
		SPLIT_CATEGORY = Category.DATA;
		SPLIT_FORMAT = Format.CELL;
		
		D_LIST = ConcreteElement.getPropNumber() + 3;
		D_LIST_TAG = 'D_LIST';
		D_LIST_CATEGORY = Category.RESULT;
		D_LIST_FORMAT = Format.ITEMLIST;
		
		D_LIST_IT = ConcreteElement.getPropNumber() + 4;
		D_LIST_IT_TAG = 'D_LIST_IT';
		D_LIST_IT_CATEGORY = Category.QUERY;
		D_LIST_IT_FORMAT = Format.ITEM;
	end
	methods % constructor
		function dsp = NNDatasetSplit(varargin)
			%NNDatasetSplit() creates a splitter of a neural network data.
			%
			% NNDatasetSplit(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetSplit(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			dsp = dsp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function dsp_class = getClass()
			%GETCLASS returns the class of the splitter of a neural network data.
			%
			% CLASS = NNDatasetSplit.GETCLASS() returns the class 'NNDatasetSplit'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DSP.GETCLASS() returns the class of the splitter of a neural network data DSP.
			%  CLASS = Element.GETCLASS(DSP) returns the class of 'DSP'.
			%  CLASS = Element.GETCLASS('NNDatasetSplit') returns 'NNDatasetSplit'.
			%
			% Note that the Element.GETCLASS(DSP) and Element.GETCLASS('NNDatasetSplit')
			%  are less computationally efficient.
			
			dsp_class = 'NNDatasetSplit';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the splitter of a neural network data.
			%
			% LIST = NNDatasetSplit.GETSUBCLASSES() returns all subclasses of 'NNDatasetSplit'.
			%
			% Alternative forms to call this method are:
			%  LIST = DSP.GETSUBCLASSES() returns all subclasses of the splitter of a neural network data DSP.
			%  LIST = Element.GETSUBCLASSES(DSP) returns all subclasses of 'DSP'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetSplit') returns all subclasses of 'NNDatasetSplit'.
			%
			% Note that the Element.GETSUBCLASSES(DSP) and Element.GETSUBCLASSES('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDatasetSplit', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of splitter of a neural network data.
			%
			% PROPS = NNDatasetSplit.GETPROPS() returns the property list of splitter of a neural network data
			%  as a row vector.
			%
			% PROPS = NNDatasetSplit.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DSP.GETPROPS([CATEGORY]) returns the property list of the splitter of a neural network data DSP.
			%  PROPS = Element.GETPROPS(DSP[, CATEGORY]) returns the property list of 'DSP'.
			%  PROPS = Element.GETPROPS('NNDatasetSplit'[, CATEGORY]) returns the property list of 'NNDatasetSplit'.
			%
			% Note that the Element.GETPROPS(DSP) and Element.GETPROPS('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNDatasetSplit.D ...
						NNDatasetSplit.SPLIT ...
						NNDatasetSplit.D_LIST ...
						NNDatasetSplit.D_LIST_IT ...
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
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNDatasetSplit.D ...
						NNDatasetSplit.SPLIT ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNDatasetSplit.D_LIST ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						NNDatasetSplit.D_LIST_IT ...
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
			%GETPROPNUMBER returns the property number of splitter of a neural network data.
			%
			% N = NNDatasetSplit.GETPROPNUMBER() returns the property number of splitter of a neural network data.
			%
			% N = NNDatasetSplit.GETPROPNUMBER(CATEGORY) returns the property number of splitter of a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DSP.GETPROPNUMBER([CATEGORY]) returns the property number of the splitter of a neural network data DSP.
			%  N = Element.GETPROPNUMBER(DSP) returns the property number of 'DSP'.
			%  N = Element.GETPROPNUMBER('NNDatasetSplit') returns the property number of 'NNDatasetSplit'.
			%
			% Note that the Element.GETPROPNUMBER(DSP) and Element.GETPROPNUMBER('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDatasetSplit.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in splitter of a neural network data/error.
			%
			% CHECK = NNDatasetSplit.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSP.EXISTSPROP(PROP) checks whether PROP exists for DSP.
			%  CHECK = Element.EXISTSPROP(DSP, PROP) checks whether PROP exists for DSP.
			%  CHECK = Element.EXISTSPROP(NNDatasetSplit, PROP) checks whether PROP exists for NNDatasetSplit.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSPROP(DSP, PROP) throws error if PROP does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSPROP(NNDatasetSplit, PROP) throws error if PROP does NOT exist for NNDatasetSplit.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DSP) and Element.EXISTSPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDatasetSplit.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetSplit.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in splitter of a neural network data/error.
			%
			% CHECK = NNDatasetSplit.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSP.EXISTSTAG(TAG) checks whether TAG exists for DSP.
			%  CHECK = Element.EXISTSTAG(DSP, TAG) checks whether TAG exists for DSP.
			%  CHECK = Element.EXISTSTAG(NNDatasetSplit, TAG) checks whether TAG exists for NNDatasetSplit.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSTAG(DSP, TAG) throws error if TAG does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSTAG(NNDatasetSplit, TAG) throws error if TAG does NOT exist for NNDatasetSplit.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DSP) and Element.EXISTSTAG('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndatasetsplit_tag_list = cellfun(@(x) NNDatasetSplit.getPropTag(x), num2cell(NNDatasetSplit.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndatasetsplit_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetSplit.'] ...
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
			%  PROPERTY = DSP.GETPROPPROP(POINTER) returns property number of POINTER of DSP.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetSplit, POINTER) returns property number of POINTER of NNDatasetSplit.
			%  PROPERTY = DSP.GETPROPPROP(NNDatasetSplit, POINTER) returns property number of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPPROP(DSP) and Element.GETPROPPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndatasetsplit_tag_list = cellfun(@(x) NNDatasetSplit.getPropTag(x), num2cell(NNDatasetSplit.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndatasetsplit_tag_list)); % tag = pointer
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
			%  TAG = DSP.GETPROPTAG(POINTER) returns tag of POINTER of DSP.
			%  TAG = Element.GETPROPTAG(NNDatasetSplit, POINTER) returns tag of POINTER of NNDatasetSplit.
			%  TAG = DSP.GETPROPTAG(NNDatasetSplit, POINTER) returns tag of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPTAG(DSP) and Element.GETPROPTAG('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDatasetSplit.D
						tag = NNDatasetSplit.D_TAG;
					case NNDatasetSplit.SPLIT
						tag = NNDatasetSplit.SPLIT_TAG;
					case NNDatasetSplit.D_LIST
						tag = NNDatasetSplit.D_LIST_TAG;
					case NNDatasetSplit.D_LIST_IT
						tag = NNDatasetSplit.D_LIST_IT_TAG;
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
			%  CATEGORY = DSP.GETPROPCATEGORY(POINTER) returns category of POINTER of DSP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetSplit, POINTER) returns category of POINTER of NNDatasetSplit.
			%  CATEGORY = DSP.GETPROPCATEGORY(NNDatasetSplit, POINTER) returns category of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPCATEGORY(DSP) and Element.GETPROPCATEGORY('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D
					prop_category = NNDatasetSplit.D_CATEGORY;
				case NNDatasetSplit.SPLIT
					prop_category = NNDatasetSplit.SPLIT_CATEGORY;
				case NNDatasetSplit.D_LIST
					prop_category = NNDatasetSplit.D_LIST_CATEGORY;
				case NNDatasetSplit.D_LIST_IT
					prop_category = NNDatasetSplit.D_LIST_IT_CATEGORY;
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
			%  FORMAT = DSP.GETPROPFORMAT(POINTER) returns format of POINTER of DSP.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetSplit, POINTER) returns format of POINTER of NNDatasetSplit.
			%  FORMAT = DSP.GETPROPFORMAT(NNDatasetSplit, POINTER) returns format of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPFORMAT(DSP) and Element.GETPROPFORMAT('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D
					prop_format = NNDatasetSplit.D_FORMAT;
				case NNDatasetSplit.SPLIT
					prop_format = NNDatasetSplit.SPLIT_FORMAT;
				case NNDatasetSplit.D_LIST
					prop_format = NNDatasetSplit.D_LIST_FORMAT;
				case NNDatasetSplit.D_LIST_IT
					prop_format = NNDatasetSplit.D_LIST_IT_FORMAT;
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
			%  DESCRIPTION = DSP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DSP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetSplit, POINTER) returns description of POINTER of NNDatasetSplit.
			%  DESCRIPTION = DSP.GETPROPDESCRIPTION(NNDatasetSplit, POINTER) returns description of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDESCRIPTION(DSP) and Element.GETPROPDESCRIPTION('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D
					prop_description = 'D (data, item) is a dataset for neural network analysis.';
				case NNDatasetSplit.SPLIT
					prop_description = 'SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.';
				case NNDatasetSplit.D_LIST
					prop_description = 'D_LIST (result, itemlist) is the itemlist of splitted neural network datasets.';
				case NNDatasetSplit.D_LIST_IT
					prop_description = 'D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.';
				case NNDatasetSplit.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNDatasetSplit.NAME
					prop_description = 'NAME (constant, string) is the name of the splitter of a neural network data.';
				case NNDatasetSplit.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the splitter of a neural network data.';
				case NNDatasetSplit.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the splitter of a neural network data.';
				case NNDatasetSplit.ID
					prop_description = 'ID (data, string) is a few-letter code for the splitter of a neural network data.';
				case NNDatasetSplit.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the splitter of a neural network data.';
				case NNDatasetSplit.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the splitter of a neural network data.';
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
			%  SETTINGS = DSP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DSP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetSplit, POINTER) returns settings of POINTER of NNDatasetSplit.
			%  SETTINGS = DSP.GETPROPSETTINGS(NNDatasetSplit, POINTER) returns settings of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPSETTINGS(DSP) and Element.GETPROPSETTINGS('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D
					prop_settings = 'NNDataset';
				case NNDatasetSplit.SPLIT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDatasetSplit.D_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case NNDatasetSplit.D_LIST_IT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNDatasetSplit.TEMPLATE
					prop_settings = 'NNDatasetSplit';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DSP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetSplit, POINTER) returns the default value of POINTER of NNDatasetSplit.
			%  DEFAULT = DSP.GETPROPDEFAULT(NNDatasetSplit, POINTER) returns the default value of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDEFAULT(DSP) and Element.GETPROPDEFAULT('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint'));
				case NNDatasetSplit.SPLIT
					prop_default = Format.getFormatDefault(Format.CELL, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.D_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.D_LIST_IT
					prop_default = Format.getFormatDefault(Format.ITEM, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.ELCLASS
					prop_default = 'NNDatasetSplit';
				case NNDatasetSplit.NAME
					prop_default = 'NNDatasetSplit';
				case NNDatasetSplit.DESCRIPTION
					prop_default = 'A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset. For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}. Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).';
				case NNDatasetSplit.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.ID
					prop_default = 'NNDatasetSplit ID';
				case NNDatasetSplit.LABEL
					prop_default = 'NNDatasetSplit label';
				case NNDatasetSplit.NOTES
					prop_default = 'NNDatasetSplit notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DSP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetSplit, POINTER) returns the conditioned default value of POINTER of NNDatasetSplit.
			%  DEFAULT = DSP.GETPROPDEFAULTCONDITIONED(NNDatasetSplit, POINTER) returns the conditioned default value of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DSP) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			prop_default = NNDatasetSplit.conditioning(prop, NNDatasetSplit.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DSP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DSP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DSP.
			%  CHECK = Element.CHECKPROP(NNDatasetSplit, PROP, VALUE) checks VALUE format for PROP of NNDatasetSplit.
			%  CHECK = DSP.CHECKPROP(NNDatasetSplit, PROP, VALUE) checks VALUE format for PROP of NNDatasetSplit.
			% 
			% DSP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDatasetSplit:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DSP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DSP.
			%   Error id: €BRAPH2.STR€:NNDatasetSplit:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDatasetSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetSplit.
			%   Error id: €BRAPH2.STR€:NNDatasetSplit:€BRAPH2.WRONG_INPUT€
			%  DSP.CHECKPROP(NNDatasetSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetSplit.
			%   Error id: €BRAPH2.STR€:NNDatasetSplit:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DSP) and Element.CHECKPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case NNDatasetSplit.D % __NNDatasetSplit.D__
					check = Format.checkFormat(Format.ITEM, value, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.SPLIT % __NNDatasetSplit.SPLIT__
					check = Format.checkFormat(Format.CELL, value, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.D_LIST % __NNDatasetSplit.D_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.D_LIST_IT % __NNDatasetSplit.D_LIST_IT__
					check = Format.checkFormat(Format.ITEM, value, NNDatasetSplit.getPropSettings(prop));
				case NNDatasetSplit.TEMPLATE % __NNDatasetSplit.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDatasetSplit.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetSplit:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetSplit.getPropTag(prop) ' (' NNDatasetSplit.getFormatTag(NNDatasetSplit.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(dsp, prop)
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
				case NNDatasetSplit.SPLIT % __NNDatasetSplit.SPLIT__
					value = dsp.get('SPLIT');
					if all(cellfun(@isscalar, value)) & sum(cell2mat(value)) <= 1 & sum(cell2mat(value)) > 0 
					    num_sub = dsp.get('D').get('DP_DICT').get('LENGTH');
					    
					    lengths = floor(cell2mat(value) * num_sub);
					    for i = 1:1:num_sub - sum(lengths)
					        lengths(i) = lengths(i) + 1;
					    end
					    
					    indices = randperm(num_sub);
					    
					    startIndex = 1;
					    value = cell(numel(lengths), 1);
					    for i = 1:numel(lengths)
					        endIndex = startIndex + lengths(i) - 1;
					        value{i} = sort(indices(startIndex:endIndex));
					        startIndex = endIndex + 1;
					    end
					    
					    dsp.set('SPLIT', value);
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(dsp, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dsp, prop, varargin)
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
				case NNDatasetSplit.D_LIST % __NNDatasetSplit.D_LIST__
					rng_settings_ = rng(); rng(dsp.getPropSeed(NNDatasetSplit.D_LIST), 'twister')
					
					d = dsp.get('D');
					dp_list = d.get('DP_DICT').get('IT_LIST');
					split = dsp.get('SPLIT');
					value = cellfun(@(x) NNDataset( ...
					    'DP_CLASS', d.get('DP_CLASS'), ...
					    'DP_DICT', IndexedDictionary(...
					    'IT_CLASS', 'NNDataPoint', ...
					    'IT_LIST',  dp_list(x) ...
					    )), split, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case NNDatasetSplit.D_LIST_IT % __NNDatasetSplit.D_LIST_IT__
					% d = dsp.get('D_LIST_IT', index) returns the NNDataset at the specified 
					%  index from the D_LIST property.
					if isempty(varargin)
					    value = NNDataset();
					    return
					end
					index = varargin{1};
					
					d_list = dsp.get('D_LIST');
					
					value = d_list{index};
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(dsp, prop, varargin{:});
					else
						value = calculateValue@Element(dsp, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(dsp, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(dsp) ' ' dsp.getPropTag(prop) '.'];
			
			switch prop
				case NNDatasetSplit.SPLIT % __NNDatasetSplit.SPLIT__
					check = all(cellfun(@(x) all(round(x) == x & all(x <= dsp.get('D').get('DP_DICT').get('LENGTH'))), dsp.get('SPLIT')));
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(dsp, prop, value);
					end
			end
		end
	end
end
