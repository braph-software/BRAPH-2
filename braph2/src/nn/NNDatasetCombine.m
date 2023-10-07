classdef NNDatasetCombine < ConcreteElement
	%NNDatasetCombine combines neural network datasets.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. 
	% The resulting combined dataset contains all the unique datapoints from the input datasets, 
	% and any overlapping datapoints are excluded to ensure data consistency.
	%
	% NNDatasetCombine methods (constructor):
	%  NNDatasetCombine - constructor
	%
	% NNDatasetCombine methods:
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
	% NNDatasetCombine methods (display):
	%  tostring - string with information about the splitter of a neural network data
	%  disp - displays information about the splitter of a neural network data
	%  tree - displays the tree of the splitter of a neural network data
	%
	% NNDatasetCombine methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two splitter of a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the splitter of a neural network data
	%
	% NNDatasetCombine methods (save/load, Static):
	%  save - saves BRAPH2 splitter of a neural network data as b2 file
	%  load - loads a BRAPH2 splitter of a neural network data from a b2 file
	%
	% NNDatasetCombine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the splitter of a neural network data
	%
	% NNDatasetCombine method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the splitter of a neural network data
	%
	% NNDatasetCombine methods (inspection, Static):
	%  getClass - returns the class of the splitter of a neural network data
	%  getSubclasses - returns all subclasses of NNDatasetCombine
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
	% NNDatasetCombine methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetCombine methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetCombine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetCombine methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetCombine; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetCombine constants</a>.
	%
	%
	% See also NNDataset, NNDatasetSplit.
	
	properties (Constant) % properties
		D_LIST = ConcreteElement.getPropNumber() + 1;
		D_LIST_TAG = 'D_LIST';
		D_LIST_CATEGORY = Category.DATA;
		D_LIST_FORMAT = Format.ITEMLIST;
		
		D = ConcreteElement.getPropNumber() + 2;
		D_TAG = 'D';
		D_CATEGORY = Category.RESULT;
		D_FORMAT = Format.ITEM;
	end
	methods % constructor
		function dco = NNDatasetCombine(varargin)
			%NNDatasetCombine() creates a splitter of a neural network data.
			%
			% NNDatasetCombine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetCombine(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			dco = dco@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function dco_class = getClass()
			%GETCLASS returns the class of the splitter of a neural network data.
			%
			% CLASS = NNDatasetCombine.GETCLASS() returns the class 'NNDatasetCombine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DCO.GETCLASS() returns the class of the splitter of a neural network data DCO.
			%  CLASS = Element.GETCLASS(DCO) returns the class of 'DCO'.
			%  CLASS = Element.GETCLASS('NNDatasetCombine') returns 'NNDatasetCombine'.
			%
			% Note that the Element.GETCLASS(DCO) and Element.GETCLASS('NNDatasetCombine')
			%  are less computationally efficient.
			
			dco_class = 'NNDatasetCombine';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the splitter of a neural network data.
			%
			% LIST = NNDatasetCombine.GETSUBCLASSES() returns all subclasses of 'NNDatasetCombine'.
			%
			% Alternative forms to call this method are:
			%  LIST = DCO.GETSUBCLASSES() returns all subclasses of the splitter of a neural network data DCO.
			%  LIST = Element.GETSUBCLASSES(DCO) returns all subclasses of 'DCO'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetCombine') returns all subclasses of 'NNDatasetCombine'.
			%
			% Note that the Element.GETSUBCLASSES(DCO) and Element.GETSUBCLASSES('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDatasetCombine', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of splitter of a neural network data.
			%
			% PROPS = NNDatasetCombine.GETPROPS() returns the property list of splitter of a neural network data
			%  as a row vector.
			%
			% PROPS = NNDatasetCombine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DCO.GETPROPS([CATEGORY]) returns the property list of the splitter of a neural network data DCO.
			%  PROPS = Element.GETPROPS(DCO[, CATEGORY]) returns the property list of 'DCO'.
			%  PROPS = Element.GETPROPS('NNDatasetCombine'[, CATEGORY]) returns the property list of 'NNDatasetCombine'.
			%
			% Note that the Element.GETPROPS(DCO) and Element.GETPROPS('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNDatasetCombine.D_LIST ...
						NNDatasetCombine.D ...
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
						NNDatasetCombine.D_LIST ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNDatasetCombine.D ...
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
			%GETPROPNUMBER returns the property number of splitter of a neural network data.
			%
			% N = NNDatasetCombine.GETPROPNUMBER() returns the property number of splitter of a neural network data.
			%
			% N = NNDatasetCombine.GETPROPNUMBER(CATEGORY) returns the property number of splitter of a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DCO.GETPROPNUMBER([CATEGORY]) returns the property number of the splitter of a neural network data DCO.
			%  N = Element.GETPROPNUMBER(DCO) returns the property number of 'DCO'.
			%  N = Element.GETPROPNUMBER('NNDatasetCombine') returns the property number of 'NNDatasetCombine'.
			%
			% Note that the Element.GETPROPNUMBER(DCO) and Element.GETPROPNUMBER('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDatasetCombine.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in splitter of a neural network data/error.
			%
			% CHECK = NNDatasetCombine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DCO.EXISTSPROP(PROP) checks whether PROP exists for DCO.
			%  CHECK = Element.EXISTSPROP(DCO, PROP) checks whether PROP exists for DCO.
			%  CHECK = Element.EXISTSPROP(NNDatasetCombine, PROP) checks whether PROP exists for NNDatasetCombine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DCO.EXISTSPROP(PROP) throws error if PROP does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSPROP(DCO, PROP) throws error if PROP does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSPROP(NNDatasetCombine, PROP) throws error if PROP does NOT exist for NNDatasetCombine.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DCO) and Element.EXISTSPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDatasetCombine.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetCombine.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in splitter of a neural network data/error.
			%
			% CHECK = NNDatasetCombine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DCO.EXISTSTAG(TAG) checks whether TAG exists for DCO.
			%  CHECK = Element.EXISTSTAG(DCO, TAG) checks whether TAG exists for DCO.
			%  CHECK = Element.EXISTSTAG(NNDatasetCombine, TAG) checks whether TAG exists for NNDatasetCombine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DCO.EXISTSTAG(TAG) throws error if TAG does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSTAG(DCO, TAG) throws error if TAG does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSTAG(NNDatasetCombine, TAG) throws error if TAG does NOT exist for NNDatasetCombine.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DCO) and Element.EXISTSTAG('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndatasetcombine_tag_list = cellfun(@(x) NNDatasetCombine.getPropTag(x), num2cell(NNDatasetCombine.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndatasetcombine_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetCombine.'] ...
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
			%  PROPERTY = DCO.GETPROPPROP(POINTER) returns property number of POINTER of DCO.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetCombine, POINTER) returns property number of POINTER of NNDatasetCombine.
			%  PROPERTY = DCO.GETPROPPROP(NNDatasetCombine, POINTER) returns property number of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPPROP(DCO) and Element.GETPROPPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndatasetcombine_tag_list = cellfun(@(x) NNDatasetCombine.getPropTag(x), num2cell(NNDatasetCombine.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndatasetcombine_tag_list)); % tag = pointer
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
			%  TAG = DCO.GETPROPTAG(POINTER) returns tag of POINTER of DCO.
			%  TAG = Element.GETPROPTAG(NNDatasetCombine, POINTER) returns tag of POINTER of NNDatasetCombine.
			%  TAG = DCO.GETPROPTAG(NNDatasetCombine, POINTER) returns tag of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPTAG(DCO) and Element.GETPROPTAG('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDatasetCombine.D_LIST
						tag = NNDatasetCombine.D_LIST_TAG;
					case NNDatasetCombine.D
						tag = NNDatasetCombine.D_TAG;
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
			%  CATEGORY = DCO.GETPROPCATEGORY(POINTER) returns category of POINTER of DCO.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetCombine, POINTER) returns category of POINTER of NNDatasetCombine.
			%  CATEGORY = DCO.GETPROPCATEGORY(NNDatasetCombine, POINTER) returns category of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPCATEGORY(DCO) and Element.GETPROPCATEGORY('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST
					prop_category = NNDatasetCombine.D_LIST_CATEGORY;
				case NNDatasetCombine.D
					prop_category = NNDatasetCombine.D_CATEGORY;
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
			%  FORMAT = DCO.GETPROPFORMAT(POINTER) returns format of POINTER of DCO.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetCombine, POINTER) returns format of POINTER of NNDatasetCombine.
			%  FORMAT = DCO.GETPROPFORMAT(NNDatasetCombine, POINTER) returns format of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPFORMAT(DCO) and Element.GETPROPFORMAT('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST
					prop_format = NNDatasetCombine.D_LIST_FORMAT;
				case NNDatasetCombine.D
					prop_format = NNDatasetCombine.D_FORMAT;
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
			%  DESCRIPTION = DCO.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DCO.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetCombine, POINTER) returns description of POINTER of NNDatasetCombine.
			%  DESCRIPTION = DCO.GETPROPDESCRIPTION(NNDatasetCombine, POINTER) returns description of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDESCRIPTION(DCO) and Element.GETPROPDESCRIPTION('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST
					prop_description = 'D_LIST (data, itemlist) is a items of datasets to be combined.';
				case NNDatasetCombine.D
					prop_description = 'D (result, item) is the combined neural network dataset.';
				case NNDatasetCombine.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNDatasetCombine.NAME
					prop_description = 'NAME (constant, string) is the name of the combier of a neural network data.';
				case NNDatasetCombine.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the combier of a neural network data.';
				case NNDatasetCombine.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the combier of a neural network data.';
				case NNDatasetCombine.ID
					prop_description = 'ID (data, string) is a few-letter code for the combier of a neural network data.';
				case NNDatasetCombine.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the combier of a neural network data.';
				case NNDatasetCombine.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the combier of a neural network data.';
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
			%  SETTINGS = DCO.GETPROPSETTINGS(POINTER) returns settings of POINTER of DCO.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetCombine, POINTER) returns settings of POINTER of NNDatasetCombine.
			%  SETTINGS = DCO.GETPROPSETTINGS(NNDatasetCombine, POINTER) returns settings of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPSETTINGS(DCO) and Element.GETPROPSETTINGS('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST
					prop_settings = 'NNDataset';
				case NNDatasetCombine.D
					prop_settings = 'NNDataset';
				case NNDatasetCombine.TEMPLATE
					prop_settings = 'NNDatasetCombine';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DCO.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DCO.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetCombine, POINTER) returns the default value of POINTER of NNDatasetCombine.
			%  DEFAULT = DCO.GETPROPDEFAULT(NNDatasetCombine, POINTER) returns the default value of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDEFAULT(DCO) and Element.GETPROPDEFAULT('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNDatasetCombine.getPropSettings(prop));
				case NNDatasetCombine.D
					prop_default = Format.getFormatDefault(Format.ITEM, NNDatasetCombine.getPropSettings(prop));
				case NNDatasetCombine.ELCLASS
					prop_default = 'NNDatasetCombine';
				case NNDatasetCombine.NAME
					prop_default = 'NNDatasetCombine';
				case NNDatasetCombine.DESCRIPTION
					prop_default = 'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.';
				case NNDatasetCombine.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDatasetCombine.getPropSettings(prop));
				case NNDatasetCombine.ID
					prop_default = 'NNDatasetCombine ID';
				case NNDatasetCombine.LABEL
					prop_default = 'NNDatasetCombine label';
				case NNDatasetCombine.NOTES
					prop_default = 'NNDatasetCombine notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DCO.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DCO.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetCombine, POINTER) returns the conditioned default value of POINTER of NNDatasetCombine.
			%  DEFAULT = DCO.GETPROPDEFAULTCONDITIONED(NNDatasetCombine, POINTER) returns the conditioned default value of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DCO) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			prop_default = NNDatasetCombine.conditioning(prop, NNDatasetCombine.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DCO.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DCO.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DCO.
			%  CHECK = Element.CHECKPROP(NNDatasetCombine, PROP, VALUE) checks VALUE format for PROP of NNDatasetCombine.
			%  CHECK = DCO.CHECKPROP(NNDatasetCombine, PROP, VALUE) checks VALUE format for PROP of NNDatasetCombine.
			% 
			% DCO.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDatasetCombine:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DCO.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DCO.
			%   Error id: €BRAPH2.STR€:NNDatasetCombine:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDatasetCombine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetCombine.
			%   Error id: €BRAPH2.STR€:NNDatasetCombine:€BRAPH2.WRONG_INPUT€
			%  DCO.CHECKPROP(NNDatasetCombine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetCombine.
			%   Error id: €BRAPH2.STR€:NNDatasetCombine:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DCO) and Element.CHECKPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case NNDatasetCombine.D_LIST % __NNDatasetCombine.D_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNDatasetCombine.getPropSettings(prop));
					if check
						if ~isempty(value)
						    dp_classes = cellfun(@(x) x.get('DP_CLASS'), value, 'uniformoutput', false);
						    if length(unique(dp_classes)) == 1
						        check = true;
						    else
						        check = all(isequal(dp_classes{:}));
						    end
						end
					end
				case NNDatasetCombine.D % __NNDatasetCombine.D__
					check = Format.checkFormat(Format.ITEM, value, NNDatasetCombine.getPropSettings(prop));
				case NNDatasetCombine.TEMPLATE % __NNDatasetCombine.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDatasetCombine.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDatasetCombine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetCombine.getPropTag(prop) ' (' NNDatasetCombine.getFormatTag(NNDatasetCombine.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dco, prop, varargin)
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
				case NNDatasetCombine.D % __NNDatasetCombine.D__
					rng_settings_ = rng(); rng(dco.getPropSeed(NNDatasetCombine.D), 'twister')
					
					dp_list = cellfun(@(x) x.get('DP_DICT').get('IT_LIST'), dco.get('D_LIST'), 'UniformOutput', false);
					dp_classes = cellfun(@(x) x.get('DP_CLASS'), dco.get('D_LIST'), 'UniformOutput', false);
					
					% concatenate all subjectID
					dp_list = horzcat(dp_list{:});
					
					% inspect whether there are overlapping datapoints
					if isempty(dp_list) | isempty(dp_classes)
					    unique_dp_list = {};
					    dp_class = 'NNDataPoint';
					else
					    dp_ids = cellfun(@(x) x.get('ID'), dp_list, 'UniformOutput', false);
					    [C, i_dp_ids] = unique(dp_ids);
					    unique_dp_list = dp_list(sort(i_dp_ids));
					    dp_class = dp_classes{1};
					end
					
					% create the combined NNDataset
					combined_dp_dict = IndexedDictionary(...
					    'IT_CLASS', 'NNDataPoint', ...
					    'IT_LIST',  unique_dp_list ...
					    );
					
					value = NNDataset( ...
					    'DP_CLASS', dp_class, ...
					    'DP_DICT', combined_dp_dict ...
					    );
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(dco, prop, varargin{:});
					else
						value = calculateValue@Element(dco, prop, varargin{:});
					end
			end
			
		end
	end
end
