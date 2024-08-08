classdef PanelPropStringList < PanelProp
	%PanelPropStringList plots the panel of a property string-list.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% PanelPropStringList plots the panel for a STRINGLIST property with a text area.
	% It works for all categories.
	% 
	% It can be personalized with the following property:
	%  TA_HEIGHT - Text area height in pixels when the table is shown.
	%
	% PanelPropStringList methods (constructor):
	%  PanelPropStringList - constructor
	%
	% PanelPropStringList methods:
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
	% PanelPropStringList methods (display):
	%  tostring - string with information about the string-list prop panel
	%  disp - displays information about the string-list prop panel
	%  tree - displays the tree of the string-list prop panel
	%
	% PanelPropStringList methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two string-list prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the string-list prop panel
	%
	% PanelPropStringList methods (save/load, Static):
	%  save - saves BRAPH2 string-list prop panel as b2 file
	%  load - loads a BRAPH2 string-list prop panel from a b2 file
	%
	% PanelPropStringList method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the string-list prop panel
	%
	% PanelPropStringList method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the string-list prop panel
	%
	% PanelPropStringList methods (inspection, Static):
	%  getClass - returns the class of the string-list prop panel
	%  getSubclasses - returns all subclasses of PanelPropStringList
	%  getProps - returns the property list of the string-list prop panel
	%  getPropNumber - returns the property number of the string-list prop panel
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
	% PanelPropStringList methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropStringList methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropStringList methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropStringList methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropStringList; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropStringList constants</a>.
	%
	%
	% See also uitextarea, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		TA_HEIGHT = PanelProp.getPropNumber() + 2;
		TA_HEIGHT_TAG = 'TA_HEIGHT';
		TA_HEIGHT_CATEGORY = Category.GUI;
		TA_HEIGHT_FORMAT = Format.SIZE;
		
		TEXTAREA = PanelProp.getPropNumber() + 3;
		TEXTAREA_TAG = 'TEXTAREA';
		TEXTAREA_CATEGORY = Category.EVANESCENT;
		TEXTAREA_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropStringList(varargin)
			%PanelPropStringList() creates a string-list prop panel.
			%
			% PanelPropStringList(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropStringList(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the string-list prop panel.
			%
			% CLASS = PanelPropStringList.GETCLASS() returns the class 'PanelPropStringList'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the string-list prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropStringList') returns 'PanelPropStringList'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropStringList')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropStringList';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the string-list prop panel.
			%
			% LIST = PanelPropStringList.GETSUBCLASSES() returns all subclasses of 'PanelPropStringList'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the string-list prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropStringList') returns all subclasses of 'PanelPropStringList'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropStringList', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of string-list prop panel.
			%
			% PROPS = PanelPropStringList.GETPROPS() returns the property list of string-list prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropStringList.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the string-list prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropStringList'[, CATEGORY]) returns the property list of 'PanelPropStringList'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropStringList.ENABLE ...
						PanelPropStringList.TA_HEIGHT ...
						PanelPropStringList.TEXTAREA ...
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
						PanelPropStringList.TEXTAREA ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropStringList.ENABLE ...
						PanelPropStringList.TA_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of string-list prop panel.
			%
			% N = PanelPropStringList.GETPROPNUMBER() returns the property number of string-list prop panel.
			%
			% N = PanelPropStringList.GETPROPNUMBER(CATEGORY) returns the property number of string-list prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the string-list prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropStringList') returns the property number of 'PanelPropStringList'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropStringList.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in string-list prop panel/error.
			%
			% CHECK = PanelPropStringList.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropStringList, PROP) checks whether PROP exists for PanelPropStringList.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSPROP(PanelPropStringList, PROP) throws error if PROP does NOT exist for PanelPropStringList.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropStringList.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropStringList.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in string-list prop panel/error.
			%
			% CHECK = PanelPropStringList.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropStringList, TAG) checks whether TAG exists for PanelPropStringList.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSTAG(PanelPropStringList, TAG) throws error if TAG does NOT exist for PanelPropStringList.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropstringlist_tag_list = cellfun(@(x) PanelPropStringList.getPropTag(x), num2cell(PanelPropStringList.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropstringlist_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropStringList.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropStringList, POINTER) returns property number of POINTER of PanelPropStringList.
			%  PROPERTY = PR.GETPROPPROP(PanelPropStringList, POINTER) returns property number of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropstringlist_tag_list = cellfun(@(x) PanelPropStringList.getPropTag(x), num2cell(PanelPropStringList.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropstringlist_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropStringList, POINTER) returns tag of POINTER of PanelPropStringList.
			%  TAG = PR.GETPROPTAG(PanelPropStringList, POINTER) returns tag of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropStringList.ENABLE
						tag = PanelPropStringList.ENABLE_TAG;
					case PanelPropStringList.TA_HEIGHT
						tag = PanelPropStringList.TA_HEIGHT_TAG;
					case PanelPropStringList.TEXTAREA
						tag = PanelPropStringList.TEXTAREA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropStringList, POINTER) returns category of POINTER of PanelPropStringList.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropStringList, POINTER) returns category of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE
					prop_category = PanelPropStringList.ENABLE_CATEGORY;
				case PanelPropStringList.TA_HEIGHT
					prop_category = PanelPropStringList.TA_HEIGHT_CATEGORY;
				case PanelPropStringList.TEXTAREA
					prop_category = PanelPropStringList.TEXTAREA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropStringList, POINTER) returns format of POINTER of PanelPropStringList.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropStringList, POINTER) returns format of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE
					prop_format = PanelPropStringList.ENABLE_FORMAT;
				case PanelPropStringList.TA_HEIGHT
					prop_format = PanelPropStringList.TA_HEIGHT_FORMAT;
				case PanelPropStringList.TEXTAREA
					prop_format = PanelPropStringList.TEXTAREA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropStringList, POINTER) returns description of POINTER of PanelPropStringList.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropStringList, POINTER) returns description of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.';
				case PanelPropStringList.TA_HEIGHT
					prop_description = 'TA_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case PanelPropStringList.TEXTAREA
					prop_description = 'TEXTAREA (evanescent, handle) is the string value text area.';
				case PanelPropStringList.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the string-list property panel.';
				case PanelPropStringList.NAME
					prop_description = 'NAME (constant, string) is the name of the string-list property panel.';
				case PanelPropStringList.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the string-list property panel.';
				case PanelPropStringList.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the string-list property panel.';
				case PanelPropStringList.ID
					prop_description = 'ID (data, string) is a few-letter code for the string-list property panel.';
				case PanelPropStringList.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the string-list property panel.';
				case PanelPropStringList.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the string-list property panel.';
				case PanelPropStringList.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropStringList.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropStringList.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropStringList.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropStringList.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropStringList.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropStringList, POINTER) returns settings of POINTER of PanelPropStringList.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropStringList, POINTER) returns settings of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropStringList.TA_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropStringList.TEXTAREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropStringList.TEMPLATE
					prop_settings = 'PanelPropStringList';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropStringList, POINTER) returns the default value of POINTER of PanelPropStringList.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropStringList, POINTER) returns the default value of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE
					prop_default = true;
				case PanelPropStringList.TA_HEIGHT
					prop_default = s(20);
				case PanelPropStringList.TEXTAREA
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropStringList.getPropSettings(prop));
				case PanelPropStringList.ELCLASS
					prop_default = 'PanelPropStringList';
				case PanelPropStringList.NAME
					prop_default = 'String-List Prop Panel';
				case PanelPropStringList.DESCRIPTION
					prop_default = 'PanelPropStringList plots the panel for a STRINGLIST property with a text area. It works for all categories. It can be personalized with the following props: TA_HEIGHT.';
				case PanelPropStringList.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropStringList.getPropSettings(prop));
				case PanelPropStringList.ID
					prop_default = 'PanelPropStringList ID';
				case PanelPropStringList.LABEL
					prop_default = 'PanelPropStringList label';
				case PanelPropStringList.NOTES
					prop_default = 'PanelPropStringList notes';
				case PanelPropStringList.EL
					prop_default = Graph();
				case PanelPropStringList.PROP
					prop_default = Graph.LAYERLABELS;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropStringList, POINTER) returns the conditioned default value of POINTER of PanelPropStringList.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropStringList, POINTER) returns the conditioned default value of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			prop_default = PanelPropStringList.conditioning(prop, PanelPropStringList.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropStringList, PROP, VALUE) checks VALUE format for PROP of PanelPropStringList.
			%  CHECK = PR.CHECKPROP(PanelPropStringList, PROP, VALUE) checks VALUE format for PROP of PanelPropStringList.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropStringList:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropStringList:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropStringList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringList.
			%   Error id: €BRAPH2.STR€:PanelPropStringList:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropStringList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringList.
			%   Error id: €BRAPH2.STR€:PanelPropStringList:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case PanelPropStringList.ENABLE % __PanelPropStringList.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropStringList.getPropSettings(prop));
				case PanelPropStringList.TA_HEIGHT % __PanelPropStringList.TA_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropStringList.getPropSettings(prop));
				case PanelPropStringList.TEXTAREA % __PanelPropStringList.TEXTAREA__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropStringList.getPropSettings(prop));
				case PanelPropStringList.TEMPLATE % __PanelPropStringList.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropStringList.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropStringList.getPropTag(prop) ' (' PanelPropStringList.getFormatTag(PanelPropStringList.getPropFormat(prop)) ').'] ...
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
				case PanelPropStringList.TEXTAREA % __PanelPropStringList.TEXTAREA__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					textarea = uitextarea( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXTAREA', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_textarea} ...
					    );
					
					value = textarea;
					
				case PanelPropStringList.X_DRAW % __PanelPropStringList.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TEXTAREA')
					end
					
				case PanelPropStringList.UPDATE % __PanelPropStringList.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        pr.set('HEIGHT', min(s(2) + s(2) * (length(el.get(prop)) + 1), pr.get('TA_HEIGHT')))
					    end
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('TEXTAREA'), ...
					                'Value', cell2str(el.get(prop)), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))
					
					            if el.isLocked(prop)
					                set(pr.get('TEXTAREA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('TEXTAREA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                if isempty(el.getPropDefault(prop))
					                    set(pr.get('TEXTAREA'), 'Visible', false)
					                else
					                    set(pr.get('TEXTAREA'), ...
					                        'Value', cell2str(el.getPropDefault(prop)), ...
					                        'Visible', true ...
					                        )
					                end
					            else
					                set(pr.get('TEXTAREA'), ...
					                    'Value', cell2str(el.get(prop)), ...
					                    'Visible', true ...
					                    )
					            end
					            
					            set(pr.get('TEXTAREA'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					    end
					end
					
				case PanelPropStringList.REDRAW % __PanelPropStringList.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TEXTAREA'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case PanelPropStringList.DELETE % __PanelPropStringList.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TEXTAREA', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_textarea(~, ~)
			    value = get(pr.get('TEXTAREA'), 'Value');
			    pr.get('EL').set(pr.get('PROP'), str2cell(value))
			end
		end
	end
end
