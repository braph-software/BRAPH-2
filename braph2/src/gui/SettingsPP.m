classdef SettingsPP < PanelProp
	%SettingsPP is the panel for settings.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Prop Panel for Settings (SettingsPP) is the base element for the panels 
	%  of the Settings. In particular, it provides the updated PanelProp listeners.
	% It works for all categories.
	%
	% SettingsPP methods (constructor):
	%  SettingsPP - constructor
	%
	% SettingsPP methods:
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
	% SettingsPP methods (display):
	%  tostring - string with information about the prop panel for settings
	%  disp - displays information about the prop panel for settings
	%  tree - displays the tree of the prop panel for settings
	%
	% SettingsPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for settings
	%
	% SettingsPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for settings as b2 file
	%  load - loads a BRAPH2 prop panel for settings from a b2 file
	%
	% SettingsPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for settings
	%
	% SettingsPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for settings
	%
	% SettingsPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for settings
	%  getSubclasses - returns all subclasses of SettingsPP
	%  getProps - returns the property list of the prop panel for settings
	%  getPropNumber - returns the property number of the prop panel for settings
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
	% SettingsPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsPP constants</a>.
	%
	%
	% See also Settings.
	
	methods % constructor
		function pr = SettingsPP(varargin)
			%SettingsPP() creates a prop panel for settings.
			%
			% SettingsPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for settings.
			%
			% CLASS = SettingsPP.GETCLASS() returns the class 'SettingsPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsPP') returns 'SettingsPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for settings.
			%
			% LIST = SettingsPP.GETSUBCLASSES() returns all subclasses of 'SettingsPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsPP') returns all subclasses of 'SettingsPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for settings.
			%
			% PROPS = SettingsPP.GETPROPS() returns the property list of prop panel for settings
			%  as a row vector.
			%
			% PROPS = SettingsPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsPP'[, CATEGORY]) returns the property list of 'SettingsPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for settings.
			%
			% N = SettingsPP.GETPROPNUMBER() returns the property number of prop panel for settings.
			%
			% N = SettingsPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsPP') returns the property number of 'SettingsPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for settings/error.
			%
			% CHECK = SettingsPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsPP, PROP) checks whether PROP exists for SettingsPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%  Element.EXISTSPROP(SettingsPP, PROP) throws error if PROP does NOT exist for SettingsPP.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for settings/error.
			%
			% CHECK = SettingsPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsPP, TAG) checks whether TAG exists for SettingsPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%  Element.EXISTSTAG(SettingsPP, TAG) throws error if TAG does NOT exist for SettingsPP.
			%   Error id: [BRAPH2:SettingsPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingspp_tag_list = cellfun(@(x) SettingsPP.getPropTag(x), num2cell(SettingsPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingspp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsPP.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(SettingsPP, POINTER) returns property number of POINTER of SettingsPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsPP, POINTER) returns property number of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingspp_tag_list = cellfun(@(x) SettingsPP.getPropTag(x), num2cell(SettingsPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingspp_tag_list)); % tag = pointer
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(SettingsPP, POINTER) returns tag of POINTER of SettingsPP.
			%  TAG = PR.GETPROPTAG(SettingsPP, POINTER) returns tag of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsPP')
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
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsPP, POINTER) returns category of POINTER of SettingsPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsPP, POINTER) returns category of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(SettingsPP, POINTER) returns format of POINTER of SettingsPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsPP, POINTER) returns format of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsPP, POINTER) returns description of POINTER of SettingsPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsPP, POINTER) returns description of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				case SettingsPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for settings.';
				case SettingsPP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for settings.';
				case SettingsPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for settings.';
				case SettingsPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for settings.';
				case SettingsPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for settings.';
				case SettingsPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for settings.';
				case SettingsPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for settings.';
				case SettingsPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsPP.LISTENER_SET
					prop_description = 'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.';
				case SettingsPP.LISTENER_MEMORIZED
					prop_description = 'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.';
				case SettingsPP.LISTENER_LOCKED
					prop_description = 'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsPP, POINTER) returns settings of POINTER of SettingsPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsPP, POINTER) returns settings of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				case SettingsPP.TEMPLATE
					prop_settings = 'SettingsPP';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsPP, POINTER) returns the default value of POINTER of SettingsPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsPP, POINTER) returns the default value of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				case SettingsPP.ELCLASS
					prop_default = 'SettingsPP';
				case SettingsPP.NAME
					prop_default = 'Prop Panel for Settings';
				case SettingsPP.DESCRIPTION
					prop_default = 'A Prop Panel for Settings (SettingsPP) is the base element for the panels of the Settings. In particular, it provides the updated PanelProp listeners. It works for all categories.';
				case SettingsPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsPP.getPropSettings(prop));
				case SettingsPP.ID
					prop_default = 'SettingsPP ID';
				case SettingsPP.LABEL
					prop_default = 'SettingsPP label';
				case SettingsPP.NOTES
					prop_default = 'SettingsPP notes';
				case SettingsPP.EL
					prop_default = BrainSurfacePF();
				case SettingsPP.PROP
					prop_default = BrainSurfacePF.ST_AXIS;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsPP, POINTER) returns the conditioned default value of POINTER of SettingsPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsPP, POINTER) returns the conditioned default value of POINTER of SettingsPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsPP.getPropProp(pointer);
			
			prop_default = SettingsPP.conditioning(prop, SettingsPP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(SettingsPP, PROP, VALUE) checks VALUE format for PROP of SettingsPP.
			%  CHECK = PR.CHECKPROP(SettingsPP, PROP, VALUE) checks VALUE format for PROP of SettingsPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPP.
			%   Error id: €BRAPH2.STR€:SettingsPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPP.
			%   Error id: €BRAPH2.STR€:SettingsPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsPP.getPropProp(pointer);
			
			switch prop
				case SettingsPP.TEMPLATE % __SettingsPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsPP.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsPP.getPropTag(prop) ' (' SettingsPP.getFormatTag(SettingsPP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case SettingsPP.LISTENER_SET % __SettingsPP.LISTENER_SET__
					value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropSet', @cb_listener_set)};
					
				case SettingsPP.LISTENER_MEMORIZED % __SettingsPP.LISTENER_MEMORIZED__
					value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropMemorized', @cb_listener_memorized)};
					
				case SettingsPP.LISTENER_LOCKED % __SettingsPP.LISTENER_LOCKED__
					value = {listener(pr.get('EL').get(pr.get('PROP')), 'PropLocked', @cb_listener_locked)};
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_listener_set(~, event)
			    if pr.get('DRAWN')
			    % % % if ismember(pr.get('PROP'), cell2mat(event.props)) && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_memorized(~, event)
			    if pr.get('DRAWN')
			    % % % if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_locked(~, event)
			    if pr.get('DRAWN')
			    % % % if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')
			    end
			end
		end
	end
end
