classdef MeasurePF_GS < MeasurePF
	%MeasurePF_GS is the base element to plot a global superglobal measure.
	% It is a subclass of <a href="matlab:help MeasurePF">MeasurePF</a>.
	%
	% A Panel Figure for Global Superglobal Measure (MeasurePF_GS) manages the basic functionalities to plot of a global superglobal measure.
	%
	% MeasurePF_GS methods (constructor):
	%  MeasurePF_GS - constructor
	%
	% MeasurePF_GS methods:
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
	% MeasurePF_GS methods (display):
	%  tostring - string with information about the panel figure for global superglobal measure
	%  disp - displays information about the panel figure for global superglobal measure
	%  tree - displays the tree of the panel figure for global superglobal measure
	%
	% MeasurePF_GS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for global superglobal measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for global superglobal measure
	%
	% MeasurePF_GS methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for global superglobal measure as b2 file
	%  load - loads a BRAPH2 panel figure for global superglobal measure from a b2 file
	%
	% MeasurePF_GS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for global superglobal measure
	%
	% MeasurePF_GS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for global superglobal measure
	%
	% MeasurePF_GS methods (inspection, Static):
	%  getClass - returns the class of the panel figure for global superglobal measure
	%  getSubclasses - returns all subclasses of MeasurePF_GS
	%  getProps - returns the property list of the panel figure for global superglobal measure
	%  getPropNumber - returns the property number of the panel figure for global superglobal measure
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
	% MeasurePF_GS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasurePF_GS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasurePF_GS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasurePF_GS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasurePF_GS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasurePF_GS constants</a>.
	%
	%
	% See also Measure.
	
	methods % constructor
		function pf = MeasurePF_GS(varargin)
			%MeasurePF_GS() creates a panel figure for global superglobal measure.
			%
			% MeasurePF_GS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasurePF_GS(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel figure for global superglobal measure.
			%
			% CLASS = MeasurePF_GS.GETCLASS() returns the class 'MeasurePF_GS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for global superglobal measure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasurePF_GS') returns 'MeasurePF_GS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasurePF_GS')
			%  are less computationally efficient.
			
			pf_class = 'MeasurePF_GS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for global superglobal measure.
			%
			% LIST = MeasurePF_GS.GETSUBCLASSES() returns all subclasses of 'MeasurePF_GS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for global superglobal measure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasurePF_GS') returns all subclasses of 'MeasurePF_GS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasurePF_GS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for global superglobal measure.
			%
			% PROPS = MeasurePF_GS.GETPROPS() returns the property list of panel figure for global superglobal measure
			%  as a row vector.
			%
			% PROPS = MeasurePF_GS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for global superglobal measure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasurePF_GS'[, CATEGORY]) returns the property list of 'MeasurePF_GS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasurePF_GS')
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
			%GETPROPNUMBER returns the property number of panel figure for global superglobal measure.
			%
			% N = MeasurePF_GS.GETPROPNUMBER() returns the property number of panel figure for global superglobal measure.
			%
			% N = MeasurePF_GS.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for global superglobal measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for global superglobal measure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasurePF_GS') returns the property number of 'MeasurePF_GS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasurePF_GS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for global superglobal measure/error.
			%
			% CHECK = MeasurePF_GS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasurePF_GS, PROP) checks whether PROP exists for MeasurePF_GS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%  Element.EXISTSPROP(MeasurePF_GS, PROP) throws error if PROP does NOT exist for MeasurePF_GS.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasurePF_GS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasurePF_GS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for global superglobal measure/error.
			%
			% CHECK = MeasurePF_GS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasurePF_GS, TAG) checks whether TAG exists for MeasurePF_GS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%  Element.EXISTSTAG(MeasurePF_GS, TAG) throws error if TAG does NOT exist for MeasurePF_GS.
			%   Error id: [BRAPH2:MeasurePF_GS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measurepf_gs_tag_list = cellfun(@(x) MeasurePF_GS.getPropTag(x), num2cell(MeasurePF_GS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measurepf_gs_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasurePF_GS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasurePF_GS, POINTER) returns property number of POINTER of MeasurePF_GS.
			%  PROPERTY = PF.GETPROPPROP(MeasurePF_GS, POINTER) returns property number of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measurepf_gs_tag_list = cellfun(@(x) MeasurePF_GS.getPropTag(x), num2cell(MeasurePF_GS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measurepf_gs_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasurePF_GS, POINTER) returns tag of POINTER of MeasurePF_GS.
			%  TAG = PF.GETPROPTAG(MeasurePF_GS, POINTER) returns tag of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasurePF_GS')
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasurePF_GS, POINTER) returns category of POINTER of MeasurePF_GS.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasurePF_GS, POINTER) returns category of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(MeasurePF_GS, POINTER) returns format of POINTER of MeasurePF_GS.
			%  FORMAT = PF.GETPROPFORMAT(MeasurePF_GS, POINTER) returns format of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasurePF_GS, POINTER) returns description of POINTER of MeasurePF_GS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasurePF_GS, POINTER) returns description of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for global superglobal measure.';
				case MeasurePF_GS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for global superglobal measure.';
				case MeasurePF_GS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for global superglobal measure.';
				case MeasurePF_GS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for global superglobal measure.';
				case MeasurePF_GS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for global superglobal measure.';
				case MeasurePF_GS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for global superglobal measure.';
				case MeasurePF_GS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for global superglobal measure.';
				case MeasurePF_GS.SETUP
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasurePF_GS, POINTER) returns settings of POINTER of MeasurePF_GS.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasurePF_GS, POINTER) returns settings of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GS.TEMPLATE
					prop_settings = 'MeasurePF_GS';
				otherwise
					prop_settings = getPropSettings@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasurePF_GS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_GS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasurePF_GS, POINTER) returns the default value of POINTER of MeasurePF_GS.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasurePF_GS, POINTER) returns the default value of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GS.ELCLASS
					prop_default = 'MeasurePF_GS';
				case MeasurePF_GS.NAME
					prop_default = 'Panel Figure for Global Superglobal Measure';
				case MeasurePF_GS.DESCRIPTION
					prop_default = 'A Panel Figure for Global Superglobal Measure (MeasurePF_GS) manages the basic functionalities to plot of a global superglobal measure.';
				case MeasurePF_GS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF_GS.getPropSettings(prop));
				case MeasurePF_GS.ID
					prop_default = 'MeasurePF_GS ID';
				case MeasurePF_GS.LABEL
					prop_default = 'MeasurePF_GS label';
				case MeasurePF_GS.NOTES
					prop_default = 'MeasurePF_GS notes';
				otherwise
					prop_default = getPropDefault@MeasurePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasurePF_GS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF_GS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasurePF_GS, POINTER) returns the conditioned default value of POINTER of MeasurePF_GS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasurePF_GS, POINTER) returns the conditioned default value of POINTER of MeasurePF_GS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
			prop_default = MeasurePF_GS.conditioning(prop, MeasurePF_GS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasurePF_GS, PROP, VALUE) checks VALUE format for PROP of MeasurePF_GS.
			%  CHECK = PF.CHECKPROP(MeasurePF_GS, PROP, VALUE) checks VALUE format for PROP of MeasurePF_GS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasurePF_GS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasurePF_GS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasurePF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_GS.
			%   Error id: €BRAPH2.STR€:MeasurePF_GS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasurePF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF_GS.
			%   Error id: €BRAPH2.STR€:MeasurePF_GS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasurePF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasurePF_GS.getPropProp(pointer);
			
			switch prop
				case MeasurePF_GS.TEMPLATE % __MeasurePF_GS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF_GS.getPropSettings(prop));
				otherwise
					if prop <= MeasurePF.getPropNumber()
						check = checkProp@MeasurePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasurePF_GS.getPropTag(prop) ' (' MeasurePF_GS.getFormatTag(MeasurePF_GS.getPropFormat(prop)) ').'] ...
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
				case MeasurePF_GS.SETUP % __MeasurePF_GS.SETUP__
					%%%__WARN_TBI__
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
