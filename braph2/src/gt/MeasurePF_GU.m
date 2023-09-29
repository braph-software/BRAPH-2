classdef MeasurePF_GU < MeasurePF
	%MeasurePF_GU is the base element to plot a global unilayer measure.
	% It is a subclass of <a href="matlab:help MeasurePF">MeasurePF</a>.
	%
	% A Panel Figure for Global Unilayer Measure (MeasurePF_GU) manages the basic functionalities to plot of a global unilayer measure.
	%
	% MeasurePF_GU methods (constructor):
	%  MeasurePF_GU - constructor
	%
	% MeasurePF_GU methods:
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
	% MeasurePF_GU methods (display):
	%  tostring - string with information about the panel figure for global unilayer measure
	%  disp - displays information about the panel figure for global unilayer measure
	%  tree - displays the tree of the panel figure for global unilayer measure
	%
	% MeasurePF_GU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for global unilayer measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for global unilayer measure
	%
	% MeasurePF_GU methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for global unilayer measure as b2 file
	%  load - loads a BRAPH2 panel figure for global unilayer measure from a b2 file
	%
	% MeasurePF_GU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for global unilayer measure
	%
	% MeasurePF_GU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for global unilayer measure
	%
	% MeasurePF_GU methods (inspection, Static):
	%  getClass - returns the class of the panel figure for global unilayer measure
	%  getSubclasses - returns all subclasses of MeasurePF_GU
	%  getProps - returns the property list of the panel figure for global unilayer measure
	%  getPropNumber - returns the property number of the panel figure for global unilayer measure
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
	% MeasurePF_GU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasurePF_GU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasurePF_GU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasurePF_GU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasurePF_GU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasurePF_GU constants</a>.
	%
	%
	% See also Measure.
	
	methods % constructor
		function pf = MeasurePF_GU(varargin)
			%MeasurePF_GU() creates a panel figure for global unilayer measure.
			%
			% MeasurePF_GU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasurePF_GU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasurePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for global unilayer measure.
			%
			% CLASS = MeasurePF_GU.GETCLASS() returns the class 'MeasurePF_GU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for global unilayer measure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasurePF_GU') returns 'MeasurePF_GU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasurePF_GU')
			%  are less computationally efficient.
			
			pf_class = 'MeasurePF_GU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for global unilayer measure.
			%
			% LIST = MeasurePF_GU.GETSUBCLASSES() returns all subclasses of 'MeasurePF_GU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for global unilayer measure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasurePF_GU') returns all subclasses of 'MeasurePF_GU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasurePF_GU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for global unilayer measure.
			%
			% PROPS = MeasurePF_GU.GETPROPS() returns the property list of panel figure for global unilayer measure
			%  as a row vector.
			%
			% PROPS = MeasurePF_GU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for global unilayer measure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasurePF_GU'[, CATEGORY]) returns the property list of 'MeasurePF_GU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasurePF.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasurePF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasurePF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasurePF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasurePF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasurePF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasurePF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasurePF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasurePF.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasurePF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for global unilayer measure.
			%
			% N = MeasurePF_GU.GETPROPNUMBER() returns the property number of panel figure for global unilayer measure.
			%
			% N = MeasurePF_GU.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for global unilayer measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for global unilayer measure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasurePF_GU') returns the property number of 'MeasurePF_GU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasurePF_GU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for global unilayer measure/error.
			%
			% CHECK = MeasurePF_GU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasurePF_GU, PROP) checks whether PROP exists for MeasurePF_GU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%  Element.EXISTSPROP(MeasurePF_GU, PROP) throws error if PROP does NOT exist for MeasurePF_GU.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasurePF_GU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasurePF_GU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for global unilayer measure/error.
			%
			% CHECK = MeasurePF_GU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasurePF_GU, TAG) checks whether TAG exists for MeasurePF_GU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%  Element.EXISTSTAG(MeasurePF_GU, TAG) throws error if TAG does NOT exist for MeasurePF_GU.
			%   Error id: [BRAPH2:MeasurePF_GU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measurepf_gu_tag_list = cellfun(@(x) MeasurePF_GU.getPropTag(x), num2cell(MeasurePF_GU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measurepf_gu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasurePF_GU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasurePF_GU, POINTER) returns property number of POINTER of MeasurePF_GU.
			%  PROPERTY = PF.GETPROPPROP(MeasurePF_GU, POINTER) returns property number of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measurepf_gu_tag_list = cellfun(@(x) MeasurePF_GU.getPropTag(x), num2cell(MeasurePF_GU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measurepf_gu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasurePF_GU, POINTER) returns tag of POINTER of MeasurePF_GU.
			%  TAG = PF.GETPROPTAG(MeasurePF_GU, POINTER) returns tag of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@MeasurePF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasurePF_GU, POINTER) returns category of POINTER of MeasurePF_GU.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasurePF_GU, POINTER) returns category of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MeasurePF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasurePF_GU, POINTER) returns format of POINTER of MeasurePF_GU.
			%  FORMAT = PF.GETPROPFORMAT(MeasurePF_GU, POINTER) returns format of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MeasurePF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasurePF_GU, POINTER) returns description of POINTER of MeasurePF_GU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasurePF_GU, POINTER) returns description of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for global unilayer measure.';
				case MeasurePF_GU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for global unilayer measure.';
				case MeasurePF_GU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for global unilayer measure.';
				case MeasurePF_GU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for global unilayer measure.';
				case MeasurePF_GU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for global unilayer measure.';
				case MeasurePF_GU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for global unilayer measure.';
				case MeasurePF_GU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for global unilayer measure.';
				case MeasurePF_GU.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it.';
				otherwise
					prop_description = getPropDescription@MeasurePF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasurePF_GU, POINTER) returns settings of POINTER of MeasurePF_GU.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasurePF_GU, POINTER) returns settings of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GU.TEMPLATE
					prop_settings = 'MeasurePF_GU';
				otherwise
					prop_settings = getPropSettings@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasurePF_GU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_GU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasurePF_GU, POINTER) returns the default value of POINTER of MeasurePF_GU.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasurePF_GU, POINTER) returns the default value of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GU.ELCLASS
					prop_default = 'MeasurePF_GU';
				case MeasurePF_GU.NAME
					prop_default = 'Panel Figure for Global Unilayer Measure';
				case MeasurePF_GU.DESCRIPTION
					prop_default = 'A Panel Figure for Global Unilayer Measure (MeasurePF_GU) manages the basic functionalities to plot of a global unilayer measure.';
				case MeasurePF_GU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF_GU.getPropSettings(prop));
				case MeasurePF_GU.ID
					prop_default = 'MeasurePF_GU ID';
				case MeasurePF_GU.LABEL
					prop_default = 'MeasurePF_GU label';
				case MeasurePF_GU.NOTES
					prop_default = 'MeasurePF_GU notes';
				otherwise
					prop_default = getPropDefault@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasurePF_GU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_GU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasurePF_GU, POINTER) returns the conditioned default value of POINTER of MeasurePF_GU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasurePF_GU, POINTER) returns the conditioned default value of POINTER of MeasurePF_GU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			prop_default = MeasurePF_GU.conditioning(prop, MeasurePF_GU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasurePF_GU, PROP, VALUE) checks VALUE format for PROP of MeasurePF_GU.
			%  CHECK = PF.CHECKPROP(MeasurePF_GU, PROP, VALUE) checks VALUE format for PROP of MeasurePF_GU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasurePF_GU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasurePF_GU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasurePF_GU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_GU.
			%   Error id: €BRAPH2.STR€:MeasurePF_GU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasurePF_GU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_GU.
			%   Error id: €BRAPH2.STR€:MeasurePF_GU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasurePF_GU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasurePF_GU.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GU.TEMPLATE % __MeasurePF_GU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF_GU.getPropSettings(prop));
				otherwise
					if prop <= MeasurePF.getPropNumber()
						check = checkProp@MeasurePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasurePF_GU.getPropTag(prop) ' (' MeasurePF_GU.getFormatTag(MeasurePF_GU.getPropFormat(prop)) ').'] ...
					)
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
				case MeasurePF_GU.SETUP % __MeasurePF_GU.SETUP__
					x = pf.get('M').get('G').get('ALAYERTICKS');
					
					y = cell2mat(pf.get('M').get('M'))';
					
					pf.memorize('ST_LINE').set('X', x, 'Y', y)
					
					if ~isempty(y)
					    if isempty(x) 
					        pf.memorize('ST_AREA').set('X', [1 1:1:length(y) length(y)], 'Y', [0 y 0])
					    else
					        pf.memorize('ST_AREA').set('X', [x(1) x x(end)], 'Y', [0 y 0])
					    end
					end
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					pf.get('ST_TITLE').set( ...
					    'TXT', pf.get('M').get('LABEL'), ...
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
					if prop <= MeasurePF.getPropNumber()
						value = calculateValue@MeasurePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
