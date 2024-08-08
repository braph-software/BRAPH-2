classdef Settings < ConcreteElement
	%Settings contains some graphics settings.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Graphics Settings (Settings) provides the base element for all graphics settings.
	%  Typically, only its subclasses are employed.
	% 
	%  The graphics objects is identified by its handle(list), which can be retrieved as:
	%  
	%     h = st.get('<strong>H</strong>');
	%     
	%  It returns an empty object identifier if the graphical object handle has not been 
	%   set yet.
	%     
	%  The handle can be set by setting the props PANEL and PROP (or TAG) for props 
	%   of Format.HANDLE, and PANEL, PROP (or TAG) and I for props of Format.HANDLELIST.
	%  
	% The initial setup of the figure props (initial postset) can be done by calling:
	% 
	%     st.get('<strong>SETUP</strong>')
	% 
	% Typically, it is used as a prop of a subclass of Panel (pn) and it is 
	%  initialized in the prop DRAW with a code smiliar to this:
	% 
	% 	pn.set(''ST'', Settings(''PANEL'', pn, ''PROP'', prop[, ''I'', i]) % preferred
	% 	pn.set(''ST'', Settings(''PANEL'', pn, ''TAG'', tag[, ''I'', i])
	%  
	%   The option with PROP is to be preferred, because it is faster.
	% 
	%  It might be necessary to add some listeners (e.g., to update toogle buttons).
	%
	% Settings methods (constructor):
	%  Settings - constructor
	%
	% Settings methods:
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
	% Settings methods (display):
	%  tostring - string with information about the graphics settings
	%  disp - displays information about the graphics settings
	%  tree - displays the tree of the graphics settings
	%
	% Settings methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graphics settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graphics settings
	%
	% Settings methods (save/load, Static):
	%  save - saves BRAPH2 graphics settings as b2 file
	%  load - loads a BRAPH2 graphics settings from a b2 file
	%
	% Settings method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graphics settings
	%
	% Settings method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graphics settings
	%
	% Settings methods (inspection, Static):
	%  getClass - returns the class of the graphics settings
	%  getSubclasses - returns all subclasses of Settings
	%  getProps - returns the property list of the graphics settings
	%  getPropNumber - returns the property number of the graphics settings
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
	% Settings methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Settings methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Settings methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Settings methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Settings; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Settings constants</a>.
	%
	%
	% See also Panel, listener.
	
	properties (Constant) % properties
		PANEL = ConcreteElement.getPropNumber() + 1;
		PANEL_TAG = 'PANEL';
		PANEL_CATEGORY = Category.GUI;
		PANEL_FORMAT = Format.ITEM;
		
		PROP = ConcreteElement.getPropNumber() + 2;
		PROP_TAG = 'PROP';
		PROP_CATEGORY = Category.GUI;
		PROP_FORMAT = Format.SCALAR;
		
		TAG = ConcreteElement.getPropNumber() + 3;
		TAG_TAG = 'TAG';
		TAG_CATEGORY = Category.GUI;
		TAG_FORMAT = Format.STRING;
		
		I = ConcreteElement.getPropNumber() + 4;
		I_TAG = 'I';
		I_CATEGORY = Category.GUI;
		I_FORMAT = Format.SCALAR;
		
		H = ConcreteElement.getPropNumber() + 5;
		H_TAG = 'H';
		H_CATEGORY = Category.QUERY;
		H_FORMAT = Format.HANDLE;
		
		SETUP = ConcreteElement.getPropNumber() + 6;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function st = Settings(varargin)
			%Settings() creates a graphics settings.
			%
			% Settings(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Settings(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			st = st@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function st_class = getClass()
			%GETCLASS returns the class of the graphics settings.
			%
			% CLASS = Settings.GETCLASS() returns the class 'Settings'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the graphics settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('Settings') returns 'Settings'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('Settings')
			%  are less computationally efficient.
			
			st_class = 'Settings';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graphics settings.
			%
			% LIST = Settings.GETSUBCLASSES() returns all subclasses of 'Settings'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the graphics settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('Settings') returns all subclasses of 'Settings'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('Settings')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Settings', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graphics settings.
			%
			% PROPS = Settings.GETPROPS() returns the property list of graphics settings
			%  as a row vector.
			%
			% PROPS = Settings.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the graphics settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('Settings'[, CATEGORY]) returns the property list of 'Settings'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('Settings')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Settings.PANEL ...
						Settings.PROP ...
						Settings.TAG ...
						Settings.I ...
						Settings.H ...
						Settings.SETUP ...
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
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						Settings.H ...
						Settings.SETUP ...
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
						Settings.PANEL ...
						Settings.PROP ...
						Settings.TAG ...
						Settings.I ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graphics settings.
			%
			% N = Settings.GETPROPNUMBER() returns the property number of graphics settings.
			%
			% N = Settings.GETPROPNUMBER(CATEGORY) returns the property number of graphics settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the graphics settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('Settings') returns the property number of 'Settings'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Settings.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graphics settings/error.
			%
			% CHECK = Settings.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(Settings, PROP) checks whether PROP exists for Settings.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Settings:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSPROP(Settings, PROP) throws error if PROP does NOT exist for Settings.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Settings.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Settings.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graphics settings/error.
			%
			% CHECK = Settings.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(Settings, TAG) checks whether TAG exists for Settings.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Settings:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSTAG(Settings, TAG) throws error if TAG does NOT exist for Settings.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settings_tag_list = cellfun(@(x) Settings.getPropTag(x), num2cell(Settings.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settings_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Settings.'] ...
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
			%  PROPERTY = ST.GETPROPPROP(POINTER) returns property number of POINTER of ST.
			%  PROPERTY = Element.GETPROPPROP(Settings, POINTER) returns property number of POINTER of Settings.
			%  PROPERTY = ST.GETPROPPROP(Settings, POINTER) returns property number of POINTER of Settings.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('Settings')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settings_tag_list = cellfun(@(x) Settings.getPropTag(x), num2cell(Settings.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settings_tag_list)); % tag = pointer
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
			%  TAG = ST.GETPROPTAG(POINTER) returns tag of POINTER of ST.
			%  TAG = Element.GETPROPTAG(Settings, POINTER) returns tag of POINTER of Settings.
			%  TAG = ST.GETPROPTAG(Settings, POINTER) returns tag of POINTER of Settings.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Settings.PANEL
						tag = Settings.PANEL_TAG;
					case Settings.PROP
						tag = Settings.PROP_TAG;
					case Settings.TAG
						tag = Settings.TAG_TAG;
					case Settings.I
						tag = Settings.I_TAG;
					case Settings.H
						tag = Settings.H_TAG;
					case Settings.SETUP
						tag = Settings.SETUP_TAG;
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
			%  CATEGORY = ST.GETPROPCATEGORY(POINTER) returns category of POINTER of ST.
			%  CATEGORY = Element.GETPROPCATEGORY(Settings, POINTER) returns category of POINTER of Settings.
			%  CATEGORY = ST.GETPROPCATEGORY(Settings, POINTER) returns category of POINTER of Settings.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('Settings')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL
					prop_category = Settings.PANEL_CATEGORY;
				case Settings.PROP
					prop_category = Settings.PROP_CATEGORY;
				case Settings.TAG
					prop_category = Settings.TAG_CATEGORY;
				case Settings.I
					prop_category = Settings.I_CATEGORY;
				case Settings.H
					prop_category = Settings.H_CATEGORY;
				case Settings.SETUP
					prop_category = Settings.SETUP_CATEGORY;
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
			%  FORMAT = ST.GETPROPFORMAT(POINTER) returns format of POINTER of ST.
			%  FORMAT = Element.GETPROPFORMAT(Settings, POINTER) returns format of POINTER of Settings.
			%  FORMAT = ST.GETPROPFORMAT(Settings, POINTER) returns format of POINTER of Settings.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('Settings')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL
					prop_format = Settings.PANEL_FORMAT;
				case Settings.PROP
					prop_format = Settings.PROP_FORMAT;
				case Settings.TAG
					prop_format = Settings.TAG_FORMAT;
				case Settings.I
					prop_format = Settings.I_FORMAT;
				case Settings.H
					prop_format = Settings.H_FORMAT;
				case Settings.SETUP
					prop_format = Settings.SETUP_FORMAT;
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
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ST.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Settings, POINTER) returns description of POINTER of Settings.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(Settings, POINTER) returns description of POINTER of Settings.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL
					prop_description = 'PANEL (gui, item) is the panel to which the graphics object belongs.';
				case Settings.PROP
					prop_description = 'PROP (gui, scalar) is the prop of the graphics handle(list).';
				case Settings.TAG
					prop_description = 'TAG (gui, string) is the tag of the graphics handle(s).';
				case Settings.I
					prop_description = 'I (gui, scalar) is the index of the handle, used only by handlelists.';
				case Settings.H
					prop_description = 'H (query, handle) is the graphics object handle.';
				case Settings.SETUP
					prop_description = 'SETUP (query, scalar) sets all figure props.';
				case Settings.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graphics settings.';
				case Settings.NAME
					prop_description = 'NAME (constant, string) is the name of the graphics settings.';
				case Settings.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graphics settings.';
				case Settings.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the line graphics settings.';
				case Settings.ID
					prop_description = 'ID (data, string) is a few-letter code for the graphics settings.';
				case Settings.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graphics settings.';
				case Settings.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graphics settings.';
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
			%  SETTINGS = ST.GETPROPSETTINGS(POINTER) returns settings of POINTER of ST.
			%  SETTINGS = Element.GETPROPSETTINGS(Settings, POINTER) returns settings of POINTER of Settings.
			%  SETTINGS = ST.GETPROPSETTINGS(Settings, POINTER) returns settings of POINTER of Settings.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL
					prop_settings = 'Panel';
				case Settings.PROP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Settings.TAG
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Settings.I
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Settings.H
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case Settings.SETUP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Settings.TEMPLATE
					prop_settings = 'Settings';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Settings.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Settings.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(Settings, POINTER) returns the default value of POINTER of Settings.
			%  DEFAULT = ST.GETPROPDEFAULT(Settings, POINTER) returns the default value of POINTER of Settings.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('Settings')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL
					prop_default = Format.getFormatDefault(Format.ITEM, Settings.getPropSettings(prop));
				case Settings.PROP
					prop_default = Panel.H;
				case Settings.TAG
					prop_default = 'H';
				case Settings.I
					prop_default = Format.getFormatDefault(Format.SCALAR, Settings.getPropSettings(prop));
				case Settings.H
					prop_default = Format.getFormatDefault(Format.HANDLE, Settings.getPropSettings(prop));
				case Settings.SETUP
					prop_default = Format.getFormatDefault(Format.SCALAR, Settings.getPropSettings(prop));
				case Settings.ELCLASS
					prop_default = 'Settings';
				case Settings.NAME
					prop_default = 'Graphics Settings';
				case Settings.DESCRIPTION
					prop_default = 'A Graphics Settings (Settings) provides the base element for all graphics settings. Typically, only its subclasses are employed.';
				case Settings.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Settings.getPropSettings(prop));
				case Settings.ID
					prop_default = 'Settings ID';
				case Settings.LABEL
					prop_default = 'Settings label';
				case Settings.NOTES
					prop_default = 'Settings notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Settings.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Settings.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Settings, POINTER) returns the conditioned default value of POINTER of Settings.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(Settings, POINTER) returns the conditioned default value of POINTER of Settings.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('Settings')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			prop_default = Settings.conditioning(prop, Settings.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ST.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ST.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ST.
			%  CHECK = Element.CHECKPROP(Settings, PROP, VALUE) checks VALUE format for PROP of Settings.
			%  CHECK = ST.CHECKPROP(Settings, PROP, VALUE) checks VALUE format for PROP of Settings.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Settings:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:Settings:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Settings, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Settings.
			%   Error id: €BRAPH2.STR€:Settings:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(Settings, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Settings.
			%   Error id: €BRAPH2.STR€:Settings:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('Settings')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case Settings.PANEL % __Settings.PANEL__
					check = Format.checkFormat(Format.ITEM, value, Settings.getPropSettings(prop));
				case Settings.PROP % __Settings.PROP__
					check = Format.checkFormat(Format.SCALAR, value, Settings.getPropSettings(prop));
				case Settings.TAG % __Settings.TAG__
					check = Format.checkFormat(Format.STRING, value, Settings.getPropSettings(prop));
				case Settings.I % __Settings.I__
					check = Format.checkFormat(Format.SCALAR, value, Settings.getPropSettings(prop));
				case Settings.H % __Settings.H__
					check = Format.checkFormat(Format.HANDLE, value, Settings.getPropSettings(prop));
				case Settings.SETUP % __Settings.SETUP__
					check = Format.checkFormat(Format.SCALAR, value, Settings.getPropSettings(prop));
				case Settings.TEMPLATE % __Settings.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Settings.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Settings:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Settings.getPropTag(prop) ' (' Settings.getFormatTag(Settings.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(st, prop)
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
				case Settings.PROP % __Settings.PROP__
					pn = st.get('PANEL');
					prop = st.get('PROP');
					if ~strcmp(st.get('TAG'), pn.getPropTag(prop))
					    st.set('TAG', pn.getPropTag(prop));
					end
					
				case Settings.TAG % __Settings.TAG__
					pn = st.get('PANEL');
					tag = st.get('TAG');
					if st.get('PROP') ~= pn.getPropProp(tag)
					    st.set('PROP', pn.getPropProp(tag));
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(st, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(st, prop, varargin)
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
				case Settings.H % __Settings.H__
					pn = st.get('PANEL');
					prop = st.get('PROP');
					switch pn.getPropFormat(prop)
					    case Format.HANDLE
					        if ~isa(pn.getr(prop), 'NoValue')
					            value = pn.get(prop);
					        else
					            value = gobjects(1);
					        end
					        
					    case Format.HANDLELIST
					        if ~isa(pn.getr(prop), 'NoValue') && ~isa(st.getr('I'), 'NoValue')
					            i = st.get('I');
					            handlelists = pn.get(prop);
					            value = handlelists{i};
					        else
					            value = gobjects(1);
					        end
					end
					
				case Settings.SETUP % __Settings.SETUP__
					figure_props = st.getProps(Category.FIGURE);
					settings = cell(1, 2 * length(figure_props));
					for i = 1:1:length(figure_props)
					    figure_prop = figure_props(i);
					    settings{2 * i - 1} = figure_prop;
					    settings{2 * i} = st.get(figure_prop);
					end
					st.set(settings{:})
					value = length(figure_props);
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(st, prop, varargin{:});
					else
						value = calculateValue@Element(st, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(st, prop, value)
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
			msg = ['Error while checking ' tostring(st) ' ' st.getPropTag(prop) '.'];
			
			switch prop
				case Settings.PROP % __Settings.PROP__
					check = st.get('PANEL').getPropCategory(value) == Category.EVANESCENT && any(st.get('PANEL').getPropFormat(value) == [Format.HANDLE Format.HANDLELIST]);
					if check
					    msg = 'All ok';
					else
					    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
					        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
					        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
					end
					
				case Settings.TAG % __Settings.TAG__
					check = st.get('PANEL').getPropCategory(value) == Category.EVANESCENT && any(st.get('PANEL').getPropFormat(value) == [Format.HANDLE Format.HANDLELIST]);
					if check
					    msg = 'All ok';
					else
					    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
					        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
					        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(st, prop, value);
					end
			end
		end
	end
end
