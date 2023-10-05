classdef ComparisonGroupPF_BU < ComparisonGroupPF
	%ComparisonGroupPF_BU is the base element to plot a binodal unilayer group comparison figure.
	% It is a subclass of <a href="matlab:help ComparisonGroupPF">ComparisonGroupPF</a>.
	%
	% ComparisonGroupPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.
	%
	% ComparisonGroupPF_BU methods (constructor):
	%  ComparisonGroupPF_BU - constructor
	%
	% ComparisonGroupPF_BU methods:
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
	% ComparisonGroupPF_BU methods (display):
	%  tostring - string with information about the panel binodal unilayer group comparison figure
	%  disp - displays information about the panel binodal unilayer group comparison figure
	%  tree - displays the tree of the panel binodal unilayer group comparison figure
	%
	% ComparisonGroupPF_BU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel binodal unilayer group comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel binodal unilayer group comparison figure
	%
	% ComparisonGroupPF_BU methods (save/load, Static):
	%  save - saves BRAPH2 panel binodal unilayer group comparison figure as b2 file
	%  load - loads a BRAPH2 panel binodal unilayer group comparison figure from a b2 file
	%
	% ComparisonGroupPF_BU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel binodal unilayer group comparison figure
	%
	% ComparisonGroupPF_BU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel binodal unilayer group comparison figure
	%
	% ComparisonGroupPF_BU methods (inspection, Static):
	%  getClass - returns the class of the panel binodal unilayer group comparison figure
	%  getSubclasses - returns all subclasses of ComparisonGroupPF_BU
	%  getProps - returns the property list of the panel binodal unilayer group comparison figure
	%  getPropNumber - returns the property number of the panel binodal unilayer group comparison figure
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
	% ComparisonGroupPF_BU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupPF_BU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupPF_BU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupPF_BU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupPF_BU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupPF_BU constants</a>.
	%
	%
	% See also ComparisonGroup.
	
	properties (Constant) % properties
		NODES = ComparisonGroupPF.getPropNumber() + 1;
		NODES_TAG = 'NODES';
		NODES_CATEGORY = Category.FIGURE;
		NODES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function pf = ComparisonGroupPF_BU(varargin)
			%ComparisonGroupPF_BU() creates a panel binodal unilayer group comparison figure.
			%
			% ComparisonGroupPF_BU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupPF_BU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@ComparisonGroupPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel binodal unilayer group comparison figure.
			%
			% CLASS = ComparisonGroupPF_BU.GETCLASS() returns the class 'ComparisonGroupPF_BU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel binodal unilayer group comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonGroupPF_BU') returns 'ComparisonGroupPF_BU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonGroupPF_BU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel binodal unilayer group comparison figure.
			%
			% LIST = ComparisonGroupPF_BU.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupPF_BU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel binodal unilayer group comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupPF_BU') returns all subclasses of 'ComparisonGroupPF_BU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupPF_BU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel binodal unilayer group comparison figure.
			%
			% PROPS = ComparisonGroupPF_BU.GETPROPS() returns the property list of panel binodal unilayer group comparison figure
			%  as a row vector.
			%
			% PROPS = ComparisonGroupPF_BU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel binodal unilayer group comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonGroupPF_BU'[, CATEGORY]) returns the property list of 'ComparisonGroupPF_BU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ComparisonGroupPF.getProps() ...
						ComparisonGroupPF_BU.NODES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ComparisonGroupPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.FIGURE) ...
						ComparisonGroupPF_BU.NODES ...
						];
				case Category.GUI
					prop_list = [ ...
						ComparisonGroupPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel binodal unilayer group comparison figure.
			%
			% N = ComparisonGroupPF_BU.GETPROPNUMBER() returns the property number of panel binodal unilayer group comparison figure.
			%
			% N = ComparisonGroupPF_BU.GETPROPNUMBER(CATEGORY) returns the property number of panel binodal unilayer group comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel binodal unilayer group comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupPF_BU') returns the property number of 'ComparisonGroupPF_BU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupPF_BU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel binodal unilayer group comparison figure/error.
			%
			% CHECK = ComparisonGroupPF_BU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupPF_BU, PROP) checks whether PROP exists for ComparisonGroupPF_BU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupPF_BU, PROP) throws error if PROP does NOT exist for ComparisonGroupPF_BU.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupPF_BU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupPF_BU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel binodal unilayer group comparison figure/error.
			%
			% CHECK = ComparisonGroupPF_BU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupPF_BU, TAG) checks whether TAG exists for ComparisonGroupPF_BU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupPF_BU, TAG) throws error if TAG does NOT exist for ComparisonGroupPF_BU.
			%   Error id: [BRAPH2:ComparisonGroupPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongrouppf_bu_tag_list = cellfun(@(x) ComparisonGroupPF_BU.getPropTag(x), num2cell(ComparisonGroupPF_BU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongrouppf_bu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupPF_BU.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupPF_BU, POINTER) returns property number of POINTER of ComparisonGroupPF_BU.
			%  PROPERTY = PF.GETPROPPROP(ComparisonGroupPF_BU, POINTER) returns property number of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongrouppf_bu_tag_list = cellfun(@(x) ComparisonGroupPF_BU.getPropTag(x), num2cell(ComparisonGroupPF_BU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongrouppf_bu_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(ComparisonGroupPF_BU, POINTER) returns tag of POINTER of ComparisonGroupPF_BU.
			%  TAG = PF.GETPROPTAG(ComparisonGroupPF_BU, POINTER) returns tag of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupPF_BU.NODES
						tag = ComparisonGroupPF_BU.NODES_TAG;
					otherwise
						tag = getPropTag@ComparisonGroupPF(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupPF_BU, POINTER) returns category of POINTER of ComparisonGroupPF_BU.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonGroupPF_BU, POINTER) returns category of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES
					prop_category = ComparisonGroupPF_BU.NODES_CATEGORY;
				otherwise
					prop_category = getPropCategory@ComparisonGroupPF(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupPF_BU, POINTER) returns format of POINTER of ComparisonGroupPF_BU.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonGroupPF_BU, POINTER) returns format of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES
					prop_format = ComparisonGroupPF_BU.NODES_FORMAT;
				otherwise
					prop_format = getPropFormat@ComparisonGroupPF(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupPF_BU, POINTER) returns description of POINTER of ComparisonGroupPF_BU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonGroupPF_BU, POINTER) returns description of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES
					prop_description = 'NODES (figure, rvector) are the node numbers of the binodal group comparison figure.';
				case ComparisonGroupPF_BU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroupPF_BU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison figure value and stores it.';
				otherwise
					prop_description = getPropDescription@ComparisonGroupPF(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupPF_BU, POINTER) returns settings of POINTER of ComparisonGroupPF_BU.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonGroupPF_BU, POINTER) returns settings of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ComparisonGroupPF_BU.TEMPLATE
					prop_settings = 'ComparisonGroupPF_BU';
				otherwise
					prop_settings = getPropSettings@ComparisonGroupPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_BU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_BU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupPF_BU, POINTER) returns the default value of POINTER of ComparisonGroupPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonGroupPF_BU, POINTER) returns the default value of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES
					prop_default = [1 1];
				case ComparisonGroupPF_BU.ELCLASS
					prop_default = 'ComparisonGroupPF_BU';
				case ComparisonGroupPF_BU.NAME
					prop_default = 'ComparisonGroupPF_BU';
				case ComparisonGroupPF_BU.DESCRIPTION
					prop_default = 'ComparisonGroupPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.';
				case ComparisonGroupPF_BU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF_BU.getPropSettings(prop));
				case ComparisonGroupPF_BU.ID
					prop_default = 'ComparisonGroupPF_BU ID';
				case ComparisonGroupPF_BU.LABEL
					prop_default = 'ComparisonGroupPF_BU label';
				case ComparisonGroupPF_BU.NOTES
					prop_default = 'ComparisonGroupPF_BU notes';
				otherwise
					prop_default = getPropDefault@ComparisonGroupPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_BU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_BU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_BU, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_BU, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_BU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			prop_default = ComparisonGroupPF_BU.conditioning(prop, ComparisonGroupPF_BU.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(ComparisonGroupPF_BU, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_BU.
			%  CHECK = PF.CHECKPROP(ComparisonGroupPF_BU, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_BU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupPF_BU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_BU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_BU.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_BU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonGroupPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_BU.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_BU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonGroupPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_BU.NODES % __ComparisonGroupPF_BU.NODES__
					check = Format.checkFormat(Format.RVECTOR, value, ComparisonGroupPF_BU.getPropSettings(prop));
				case ComparisonGroupPF_BU.TEMPLATE % __ComparisonGroupPF_BU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF_BU.getPropSettings(prop));
				otherwise
					if prop <= ComparisonGroupPF.getPropNumber()
						check = checkProp@ComparisonGroupPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupPF_BU.getPropTag(prop) ' (' ComparisonGroupPF_BU.getFormatTag(ComparisonGroupPF_BU.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case ComparisonGroupPF_BU.NODES % __ComparisonGroupPF_BU.NODES__
					pf.get('SETUP')
					
				otherwise
					if prop <= ComparisonGroupPF.getPropNumber()
						postset@ComparisonGroupPF(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case ComparisonGroupPF_BU.SETUP % __ComparisonGroupPF_BU.SETUP__
					cp = pf.get('CP');
					g = cp.get('C').get('A1').get('G');
					
					x = g.get('ALAYERTICKS');
					
					nodes = pf.get('NODES');
					diff = cellfun(@(x) x(nodes(1), nodes(2)), cp.get('DIFF'))';
					cil = cellfun(@(x) x(nodes(1), nodes(2)), cp.get('CIL'))';
					ciu = cellfun(@(x) x(nodes(1), nodes(2)), cp.get('CIU'))';
					
					pf.memorize('ST_LINE_DIFF').set('X', x, 'Y', diff)
					pf.memorize('ST_LINE_CIL').set('X', x, 'Y', cil)
					pf.memorize('ST_LINE_CIU').set('X', x, 'Y', ciu)
					
					if ~isempty(cil) && ~isempty(ciu)
					    if isempty(x) 
					        pf.memorize('ST_AREA').set('X', [1:1:length(diff) length(diff):-1:1], 'Y', [cil ciu(end:-1:1)])
					    else
					        pf.memorize('ST_AREA').set('X', [x x(end:-1:1)], 'Y', [cil ciu(end:-1:1)])
					    end
					end
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					anodelabels = g.get('ANODELABELS');
					if isequal(anodelabels, {'numbered'})
					    title = [cp.get('LABEL') ' ' int2str(nodes(1)) ' ' int2str(nodes(2))];
					else
					    title = [cp.get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}];
					end
					pf.get('ST_TITLE').set( ...
					    'TXT', title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'Layer', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'Measure Value', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				otherwise
					if prop <= ComparisonGroupPF.getPropNumber()
						value = calculateValue@ComparisonGroupPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case ComparisonGroupPF_BU.NODES % __ComparisonGroupPF_BU.NODES__
					pr = ComparisonGroupPF_BxPP_Node('EL', pf, 'PROP', ComparisonGroupPF_BU.NODES);
					
				otherwise
					pr = getPanelProp@ComparisonGroupPF(pf, prop, varargin{:});
					
			end
		end
	end
end
