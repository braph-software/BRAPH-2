classdef PanelPropStringTextArea < PanelProp
	%PanelPropStringTextArea plots the panel of a property string with a text-area.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A String Prop Panel with Text-Area (PanelPropStringTextArea) plots the panel for a STRING property with a text-area.
	% It works for all categories.
	%
	% PanelPropStringTextArea methods (constructor):
	%  PanelPropStringTextArea - constructor
	%
	% PanelPropStringTextArea methods:
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
	% PanelPropStringTextArea methods (display):
	%  tostring - string with information about the string prop panel with text-area 
	%  disp - displays information about the string prop panel with text-area 
	%  tree - displays the tree of the string prop panel with text-area 
	%
	% PanelPropStringTextArea methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two string prop panel with text-area  are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the string prop panel with text-area 
	%
	% PanelPropStringTextArea methods (save/load, Static):
	%  save - saves BRAPH2 string prop panel with text-area  as b2 file
	%  load - loads a BRAPH2 string prop panel with text-area  from a b2 file
	%
	% PanelPropStringTextArea method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the string prop panel with text-area 
	%
	% PanelPropStringTextArea method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the string prop panel with text-area 
	%
	% PanelPropStringTextArea methods (inspection, Static):
	%  getClass - returns the class of the string prop panel with text-area 
	%  getSubclasses - returns all subclasses of PanelPropStringTextArea
	%  getProps - returns the property list of the string prop panel with text-area 
	%  getPropNumber - returns the property number of the string prop panel with text-area 
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
	% PanelPropStringTextArea methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropStringTextArea methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropStringTextArea methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropStringTextArea methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropStringTextArea; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropStringTextArea constants</a>.
	%
	%
	% See also uitextarea, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		TEXTAREA = PanelProp.getPropNumber() + 2;
		TEXTAREA_TAG = 'TEXTAREA';
		TEXTAREA_CATEGORY = Category.EVANESCENT;
		TEXTAREA_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropStringTextArea(varargin)
			%PanelPropStringTextArea() creates a string prop panel with text-area .
			%
			% PanelPropStringTextArea(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropStringTextArea(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the string prop panel with text-area .
			%
			% CLASS = PanelPropStringTextArea.GETCLASS() returns the class 'PanelPropStringTextArea'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the string prop panel with text-area  PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropStringTextArea') returns 'PanelPropStringTextArea'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropStringTextArea')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropStringTextArea';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the string prop panel with text-area .
			%
			% LIST = PanelPropStringTextArea.GETSUBCLASSES() returns all subclasses of 'PanelPropStringTextArea'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the string prop panel with text-area  PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropStringTextArea') returns all subclasses of 'PanelPropStringTextArea'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropStringTextArea', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of string prop panel with text-area .
			%
			% PROPS = PanelPropStringTextArea.GETPROPS() returns the property list of string prop panel with text-area 
			%  as a row vector.
			%
			% PROPS = PanelPropStringTextArea.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the string prop panel with text-area  PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropStringTextArea'[, CATEGORY]) returns the property list of 'PanelPropStringTextArea'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropStringTextArea.ENABLE ...
						PanelPropStringTextArea.TEXTAREA ...
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
						PanelPropStringTextArea.TEXTAREA ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropStringTextArea.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of string prop panel with text-area .
			%
			% N = PanelPropStringTextArea.GETPROPNUMBER() returns the property number of string prop panel with text-area .
			%
			% N = PanelPropStringTextArea.GETPROPNUMBER(CATEGORY) returns the property number of string prop panel with text-area 
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the string prop panel with text-area  PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropStringTextArea') returns the property number of 'PanelPropStringTextArea'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropStringTextArea.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in string prop panel with text-area /error.
			%
			% CHECK = PanelPropStringTextArea.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropStringTextArea, PROP) checks whether PROP exists for PanelPropStringTextArea.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%  Element.EXISTSPROP(PanelPropStringTextArea, PROP) throws error if PROP does NOT exist for PanelPropStringTextArea.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropStringTextArea.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropStringTextArea.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in string prop panel with text-area /error.
			%
			% CHECK = PanelPropStringTextArea.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropStringTextArea, TAG) checks whether TAG exists for PanelPropStringTextArea.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%  Element.EXISTSTAG(PanelPropStringTextArea, TAG) throws error if TAG does NOT exist for PanelPropStringTextArea.
			%   Error id: [BRAPH2:PanelPropStringTextArea:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropstringtextarea_tag_list = cellfun(@(x) PanelPropStringTextArea.getPropTag(x), num2cell(PanelPropStringTextArea.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropstringtextarea_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropStringTextArea.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropStringTextArea, POINTER) returns property number of POINTER of PanelPropStringTextArea.
			%  PROPERTY = PR.GETPROPPROP(PanelPropStringTextArea, POINTER) returns property number of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropstringtextarea_tag_list = cellfun(@(x) PanelPropStringTextArea.getPropTag(x), num2cell(PanelPropStringTextArea.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropstringtextarea_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropStringTextArea, POINTER) returns tag of POINTER of PanelPropStringTextArea.
			%  TAG = PR.GETPROPTAG(PanelPropStringTextArea, POINTER) returns tag of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropStringTextArea.ENABLE
						tag = PanelPropStringTextArea.ENABLE_TAG;
					case PanelPropStringTextArea.TEXTAREA
						tag = PanelPropStringTextArea.TEXTAREA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropStringTextArea, POINTER) returns category of POINTER of PanelPropStringTextArea.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropStringTextArea, POINTER) returns category of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE
					prop_category = PanelPropStringTextArea.ENABLE_CATEGORY;
				case PanelPropStringTextArea.TEXTAREA
					prop_category = PanelPropStringTextArea.TEXTAREA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropStringTextArea, POINTER) returns format of POINTER of PanelPropStringTextArea.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropStringTextArea, POINTER) returns format of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE
					prop_format = PanelPropStringTextArea.ENABLE_FORMAT;
				case PanelPropStringTextArea.TEXTAREA
					prop_format = PanelPropStringTextArea.TEXTAREA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropStringTextArea, POINTER) returns description of POINTER of PanelPropStringTextArea.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropStringTextArea, POINTER) returns description of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the text-area between active and inactive appearance when not editable.';
				case PanelPropStringTextArea.TEXTAREA
					prop_description = 'TEXTAREA (evanescent, handle) is the string value text-area.';
				case PanelPropStringTextArea.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the string property panel with a text-area.';
				case PanelPropStringTextArea.NAME
					prop_description = 'NAME (constant, string) is the name of the string property panel with a text-area.';
				case PanelPropStringTextArea.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the string property panel with a text-area.';
				case PanelPropStringTextArea.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the string property panel with a text-area.';
				case PanelPropStringTextArea.ID
					prop_description = 'ID (data, string) is a few-letter code for the string property panel with a text-area.';
				case PanelPropStringTextArea.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the string property panel with a text-area.';
				case PanelPropStringTextArea.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the string property panel with a text-area.';
				case PanelPropStringTextArea.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropStringTextArea.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropStringTextArea.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropStringTextArea.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropStringTextArea.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the text-area.';
				case PanelPropStringTextArea.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropStringTextArea.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropStringTextArea, POINTER) returns settings of POINTER of PanelPropStringTextArea.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropStringTextArea, POINTER) returns settings of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropStringTextArea.TEXTAREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropStringTextArea.TEMPLATE
					prop_settings = 'PanelPropStringTextArea';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropStringTextArea.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringTextArea.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropStringTextArea, POINTER) returns the default value of POINTER of PanelPropStringTextArea.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropStringTextArea, POINTER) returns the default value of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE
					prop_default = true;
				case PanelPropStringTextArea.TEXTAREA
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropStringTextArea.getPropSettings(prop));
				case PanelPropStringTextArea.ELCLASS
					prop_default = 'PanelPropStringTextArea';
				case PanelPropStringTextArea.NAME
					prop_default = 'String Prop Panel with Text-Area';
				case PanelPropStringTextArea.DESCRIPTION
					prop_default = 'A String Prop Panel with Text-Area (PanelPropStringTextArea) plots the panel for a STRING property with a text-area. It works for all categories.';
				case PanelPropStringTextArea.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropStringTextArea.getPropSettings(prop));
				case PanelPropStringTextArea.ID
					prop_default = 'PanelPropStringTextArea ID';
				case PanelPropStringTextArea.LABEL
					prop_default = 'PanelPropStringTextArea label';
				case PanelPropStringTextArea.NOTES
					prop_default = 'PanelPropStringTextArea notes';
				case PanelPropStringTextArea.EL
					prop_default = ConcreteElement();
				case PanelPropStringTextArea.PROP
					prop_default = ConcreteElement.NOTES;
				case PanelPropStringTextArea.HEIGHT
					prop_default = s(7);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropStringTextArea.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringTextArea.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropStringTextArea, POINTER) returns the conditioned default value of POINTER of PanelPropStringTextArea.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropStringTextArea, POINTER) returns the conditioned default value of POINTER of PanelPropStringTextArea.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			prop_default = PanelPropStringTextArea.conditioning(prop, PanelPropStringTextArea.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropStringTextArea, PROP, VALUE) checks VALUE format for PROP of PanelPropStringTextArea.
			%  CHECK = PR.CHECKPROP(PanelPropStringTextArea, PROP, VALUE) checks VALUE format for PROP of PanelPropStringTextArea.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropStringTextArea:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropStringTextArea:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropStringTextArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringTextArea.
			%   Error id: €BRAPH2.STR€:PanelPropStringTextArea:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropStringTextArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringTextArea.
			%   Error id: €BRAPH2.STR€:PanelPropStringTextArea:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropStringTextArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropStringTextArea.getPropProp(pointer);
			
			switch prop
				case PanelPropStringTextArea.ENABLE % __PanelPropStringTextArea.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropStringTextArea.getPropSettings(prop));
				case PanelPropStringTextArea.TEXTAREA % __PanelPropStringTextArea.TEXTAREA__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropStringTextArea.getPropSettings(prop));
				case PanelPropStringTextArea.TEMPLATE % __PanelPropStringTextArea.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropStringTextArea.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropStringTextArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropStringTextArea.getPropTag(prop) ' (' PanelPropStringTextArea.getFormatTag(PanelPropStringTextArea.getPropFormat(prop)) ').'] ...
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
				case PanelPropStringTextArea.TEXTAREA % __PanelPropStringTextArea.TEXTAREA__
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
					
				case PanelPropStringTextArea.X_DRAW % __PanelPropStringTextArea.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TEXTAREA')
					end
					
				case PanelPropStringTextArea.UPDATE % __PanelPropStringTextArea.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('TEXTAREA'), ...
					                'Value', el.get(prop), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\n', char(10)))
					
					            if el.isLocked(prop)
					                set(pr.get('TEXTAREA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\n', char(10)))
					
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
					                set(pr.get('TEXTAREA'), 'Value', strrep(el.getPropDefault(prop), '\n', char(10)))
					            else
					                set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\n', char(10)))
					            end
					            
					            set(pr.get('TEXTAREA'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					    end
					end
					
				case PanelPropStringTextArea.REDRAW % __PanelPropStringTextArea.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TEXTAREA'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case PanelPropStringTextArea.DELETE % __PanelPropStringTextArea.DELETE__
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
			    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\n', value{:})) % double \ to be converted to single \ in compilation
			end
		end
	end
end
