classdef MeasureGroupBrainPF_BU < MeasureGroupBrainPF
	%MeasureGroupBrainPF_BU is a plot of a binodal unilayer measure group brain.
	% It is a subclass of <a href="matlab:help MeasureGroupBrainPF">MeasureGroupBrainPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_BU) manages the plot of the binodal unilayer measure
	%  ploted over the brain.  
	% MeasureGroupBrainPF_BU  utilizes the surface created from BrainAtlasPF to integrate 
	%  the binodal unilayer meaure into the brain regions.
	%
	% MeasureGroupBrainPF_BU methods (constructor):
	%  MeasureGroupBrainPF_BU - constructor
	%
	% MeasureGroupBrainPF_BU methods:
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
	% MeasureGroupBrainPF_BU methods (display):
	%  tostring - string with information about the panel figure for binodal unilayer measure group brain
	%  disp - displays information about the panel figure for binodal unilayer measure group brain
	%  tree - displays the tree of the panel figure for binodal unilayer measure group brain
	%
	% MeasureGroupBrainPF_BU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for binodal unilayer measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for binodal unilayer measure group brain
	%
	% MeasureGroupBrainPF_BU methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for binodal unilayer measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for binodal unilayer measure group brain from a b2 file
	%
	% MeasureGroupBrainPF_BU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for binodal unilayer measure group brain
	%
	% MeasureGroupBrainPF_BU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for binodal unilayer measure group brain
	%
	% MeasureGroupBrainPF_BU methods (inspection, Static):
	%  getClass - returns the class of the panel figure for binodal unilayer measure group brain
	%  getSubclasses - returns all subclasses of MeasureGroupBrainPF_BU
	%  getProps - returns the property list of the panel figure for binodal unilayer measure group brain
	%  getPropNumber - returns the property number of the panel figure for binodal unilayer measure group brain
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
	% MeasureGroupBrainPF_BU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureGroupBrainPF_BU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureGroupBrainPF_BU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureGroupBrainPF_BU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureGroupBrainPF_BU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureGroupBrainPF_BU constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	methods % constructor
		function pf = MeasureGroupBrainPF_BU(varargin)
			%MeasureGroupBrainPF_BU() creates a panel figure for binodal unilayer measure group brain.
			%
			% MeasureGroupBrainPF_BU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureGroupBrainPF_BU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasureGroupBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for binodal unilayer measure group brain.
			%
			% CLASS = MeasureGroupBrainPF_BU.GETCLASS() returns the class 'MeasureGroupBrainPF_BU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for binodal unilayer measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureGroupBrainPF_BU') returns 'MeasureGroupBrainPF_BU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			
			pf_class = 'MeasureGroupBrainPF_BU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for binodal unilayer measure group brain.
			%
			% LIST = MeasureGroupBrainPF_BU.GETSUBCLASSES() returns all subclasses of 'MeasureGroupBrainPF_BU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for binodal unilayer measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureGroupBrainPF_BU') returns all subclasses of 'MeasureGroupBrainPF_BU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureGroupBrainPF_BU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for binodal unilayer measure group brain.
			%
			% PROPS = MeasureGroupBrainPF_BU.GETPROPS() returns the property list of panel figure for binodal unilayer measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureGroupBrainPF_BU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for binodal unilayer measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureGroupBrainPF_BU'[, CATEGORY]) returns the property list of 'MeasureGroupBrainPF_BU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasureGroupBrainPF.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasureGroupBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for binodal unilayer measure group brain.
			%
			% N = MeasureGroupBrainPF_BU.GETPROPNUMBER() returns the property number of panel figure for binodal unilayer measure group brain.
			%
			% N = MeasureGroupBrainPF_BU.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for binodal unilayer measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for binodal unilayer measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureGroupBrainPF_BU') returns the property number of 'MeasureGroupBrainPF_BU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureGroupBrainPF_BU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for binodal unilayer measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_BU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureGroupBrainPF_BU, PROP) checks whether PROP exists for MeasureGroupBrainPF_BU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%  Element.EXISTSPROP(MeasureGroupBrainPF_BU, PROP) throws error if PROP does NOT exist for MeasureGroupBrainPF_BU.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureGroupBrainPF_BU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureGroupBrainPF_BU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for binodal unilayer measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_BU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureGroupBrainPF_BU, TAG) checks whether TAG exists for MeasureGroupBrainPF_BU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%  Element.EXISTSTAG(MeasureGroupBrainPF_BU, TAG) throws error if TAG does NOT exist for MeasureGroupBrainPF_BU.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measuregroupbrainpf_bu_tag_list = cellfun(@(x) MeasureGroupBrainPF_BU.getPropTag(x), num2cell(MeasureGroupBrainPF_BU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measuregroupbrainpf_bu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureGroupBrainPF_BU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureGroupBrainPF_BU, POINTER) returns property number of POINTER of MeasureGroupBrainPF_BU.
			%  PROPERTY = PF.GETPROPPROP(MeasureGroupBrainPF_BU, POINTER) returns property number of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measuregroupbrainpf_bu_tag_list = cellfun(@(x) MeasureGroupBrainPF_BU.getPropTag(x), num2cell(MeasureGroupBrainPF_BU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measuregroupbrainpf_bu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureGroupBrainPF_BU, POINTER) returns tag of POINTER of MeasureGroupBrainPF_BU.
			%  TAG = PF.GETPROPTAG(MeasureGroupBrainPF_BU, POINTER) returns tag of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureGroupBrainPF_BU')
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
						tag = getPropTag@MeasureGroupBrainPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureGroupBrainPF_BU, POINTER) returns category of POINTER of MeasureGroupBrainPF_BU.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureGroupBrainPF_BU, POINTER) returns category of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MeasureGroupBrainPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureGroupBrainPF_BU, POINTER) returns format of POINTER of MeasureGroupBrainPF_BU.
			%  FORMAT = PF.GETPROPFORMAT(MeasureGroupBrainPF_BU, POINTER) returns format of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MeasureGroupBrainPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureGroupBrainPF_BU, POINTER) returns description of POINTER of MeasureGroupBrainPF_BU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureGroupBrainPF_BU, POINTER) returns description of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_BU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureGroupBrainPF_BU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureGroupBrainPF_BU.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.';
				otherwise
					prop_description = getPropDescription@MeasureGroupBrainPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureGroupBrainPF_BU, POINTER) returns settings of POINTER of MeasureGroupBrainPF_BU.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureGroupBrainPF_BU, POINTER) returns settings of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_BU.TEMPLATE
					prop_settings = 'MeasureGroupBrainPF_BU';
				otherwise
					prop_settings = getPropSettings@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_BU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_BU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureGroupBrainPF_BU, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureGroupBrainPF_BU, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_BU.ELCLASS
					prop_default = 'MeasureGroupBrainPF_BU';
				case MeasureGroupBrainPF_BU.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureGroupBrainPF_BU.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_BU) manages the plot of the binodal unilayer measure ploted over the brain. MeasureGroupBrainPF_BU  utilizes the surface created from BrainAtlasPF to integrate the binodal unilayer meaure into the brain regions.';
				case MeasureGroupBrainPF_BU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureGroupBrainPF_BU.getPropSettings(prop));
				case MeasureGroupBrainPF_BU.ID
					prop_default = 'MeasureGroupBrainPF_BU ID';
				case MeasureGroupBrainPF_BU.LABEL
					prop_default = 'MeasureGroupBrainPF_BU label';
				case MeasureGroupBrainPF_BU.NOTES
					prop_default = 'MeasureGroupBrainPF_BU notes';
				otherwise
					prop_default = getPropDefault@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_BU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_BU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_BU, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_BU, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_BU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			prop_default = MeasureGroupBrainPF_BU.conditioning(prop, MeasureGroupBrainPF_BU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureGroupBrainPF_BU, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_BU.
			%  CHECK = PF.CHECKPROP(MeasureGroupBrainPF_BU, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_BU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureGroupBrainPF_BU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_BU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureGroupBrainPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_BU.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_BU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureGroupBrainPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_BU.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_BU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureGroupBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureGroupBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_BU.TEMPLATE % __MeasureGroupBrainPF_BU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureGroupBrainPF_BU.getPropSettings(prop));
				otherwise
					if prop <= MeasureGroupBrainPF.getPropNumber()
						check = checkProp@MeasureGroupBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureGroupBrainPF_BU.getPropTag(prop) ' (' MeasureGroupBrainPF_BU.getFormatTag(MeasureGroupBrainPF_BU.getPropFormat(prop)) ').'] ...
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
				case MeasureGroupBrainPF_BU.SETUP % __MeasureGroupBrainPF_BU.SETUP__
					%%%__WARN_TBI__
					value = [];
					
				otherwise
					if prop <= MeasureGroupBrainPF.getPropNumber()
						value = calculateValue@MeasureGroupBrainPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
