classdef PanelPropSize < PanelProp
	%PanelPropSize plots the panel of a property size.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Size Prop Panel (PanelPropSize) plots the panel for a SIZE property with a numeric edit field.
	% It works for all categories.
	%
	% PanelPropSize methods (constructor):
	%  PanelPropSize - constructor
	%
	% PanelPropSize methods:
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
	% PanelPropSize methods (display):
	%  tostring - string with information about the size prop panel
	%  disp - displays information about the size prop panel
	%  tree - displays the tree of the size prop panel
	%
	% PanelPropSize methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two size prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the size prop panel
	%
	% PanelPropSize methods (save/load, Static):
	%  save - saves BRAPH2 size prop panel as b2 file
	%  load - loads a BRAPH2 size prop panel from a b2 file
	%
	% PanelPropSize method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the size prop panel
	%
	% PanelPropSize method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the size prop panel
	%
	% PanelPropSize methods (inspection, Static):
	%  getClass - returns the class of the size prop panel
	%  getSubclasses - returns all subclasses of PanelPropSize
	%  getProps - returns the property list of the size prop panel
	%  getPropNumber - returns the property number of the size prop panel
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
	% PanelPropSize methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropSize methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropSize methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropSize methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropSize; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropSize constants</a>.
	%
	%
	% See also uieditfield, uiaxes, line, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		EDITFIELD = PanelProp.getPropNumber() + 2;
		EDITFIELD_TAG = 'EDITFIELD';
		EDITFIELD_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FORMAT = Format.HANDLE;
		
		AXES = PanelProp.getPropNumber() + 3;
		AXES_TAG = 'AXES';
		AXES_CATEGORY = Category.EVANESCENT;
		AXES_FORMAT = Format.HANDLE;
		
		LN = PanelProp.getPropNumber() + 4;
		LN_TAG = 'LN';
		LN_CATEGORY = Category.EVANESCENT;
		LN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropSize(varargin)
			%PanelPropSize() creates a size prop panel.
			%
			% PanelPropSize(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropSize(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the size prop panel.
			%
			% CLASS = PanelPropSize.GETCLASS() returns the class 'PanelPropSize'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the size prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropSize') returns 'PanelPropSize'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropSize')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropSize';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the size prop panel.
			%
			% LIST = PanelPropSize.GETSUBCLASSES() returns all subclasses of 'PanelPropSize'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the size prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropSize') returns all subclasses of 'PanelPropSize'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropSize', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of size prop panel.
			%
			% PROPS = PanelPropSize.GETPROPS() returns the property list of size prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropSize.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the size prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropSize'[, CATEGORY]) returns the property list of 'PanelPropSize'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropSize.ENABLE ...
						PanelPropSize.EDITFIELD ...
						PanelPropSize.AXES ...
						PanelPropSize.LN ...
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
						PanelPropSize.EDITFIELD ...
						PanelPropSize.AXES ...
						PanelPropSize.LN ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropSize.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of size prop panel.
			%
			% N = PanelPropSize.GETPROPNUMBER() returns the property number of size prop panel.
			%
			% N = PanelPropSize.GETPROPNUMBER(CATEGORY) returns the property number of size prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the size prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropSize') returns the property number of 'PanelPropSize'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropSize.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in size prop panel/error.
			%
			% CHECK = PanelPropSize.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropSize, PROP) checks whether PROP exists for PanelPropSize.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropSize:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%  Element.EXISTSPROP(PanelPropSize, PROP) throws error if PROP does NOT exist for PanelPropSize.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropSize.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropSize.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in size prop panel/error.
			%
			% CHECK = PanelPropSize.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropSize, TAG) checks whether TAG exists for PanelPropSize.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropSize:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%  Element.EXISTSTAG(PanelPropSize, TAG) throws error if TAG does NOT exist for PanelPropSize.
			%   Error id: [BRAPH2:PanelPropSize:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropsize_tag_list = cellfun(@(x) PanelPropSize.getPropTag(x), num2cell(PanelPropSize.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropsize_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropSize.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropSize, POINTER) returns property number of POINTER of PanelPropSize.
			%  PROPERTY = PR.GETPROPPROP(PanelPropSize, POINTER) returns property number of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropsize_tag_list = cellfun(@(x) PanelPropSize.getPropTag(x), num2cell(PanelPropSize.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropsize_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropSize, POINTER) returns tag of POINTER of PanelPropSize.
			%  TAG = PR.GETPROPTAG(PanelPropSize, POINTER) returns tag of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropSize.ENABLE
						tag = PanelPropSize.ENABLE_TAG;
					case PanelPropSize.EDITFIELD
						tag = PanelPropSize.EDITFIELD_TAG;
					case PanelPropSize.AXES
						tag = PanelPropSize.AXES_TAG;
					case PanelPropSize.LN
						tag = PanelPropSize.LN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropSize, POINTER) returns category of POINTER of PanelPropSize.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropSize, POINTER) returns category of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE
					prop_category = PanelPropSize.ENABLE_CATEGORY;
				case PanelPropSize.EDITFIELD
					prop_category = PanelPropSize.EDITFIELD_CATEGORY;
				case PanelPropSize.AXES
					prop_category = PanelPropSize.AXES_CATEGORY;
				case PanelPropSize.LN
					prop_category = PanelPropSize.LN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropSize, POINTER) returns format of POINTER of PanelPropSize.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropSize, POINTER) returns format of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE
					prop_format = PanelPropSize.ENABLE_FORMAT;
				case PanelPropSize.EDITFIELD
					prop_format = PanelPropSize.EDITFIELD_FORMAT;
				case PanelPropSize.AXES
					prop_format = PanelPropSize.AXES_FORMAT;
				case PanelPropSize.LN
					prop_format = PanelPropSize.LN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropSize, POINTER) returns description of POINTER of PanelPropSize.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropSize, POINTER) returns description of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.';
				case PanelPropSize.EDITFIELD
					prop_description = 'EDITFIELD (evanescent, handle) is the size value edit field.';
				case PanelPropSize.AXES
					prop_description = 'AXES (evanescent, handle) is the marker value axes.';
				case PanelPropSize.LN
					prop_description = 'LN (evanescent, handle) is the marker value line.';
				case PanelPropSize.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the size property panel.';
				case PanelPropSize.NAME
					prop_description = 'NAME (constant, string) is the name of the size property panel.';
				case PanelPropSize.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the size property panel.';
				case PanelPropSize.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the size property panel.';
				case PanelPropSize.ID
					prop_description = 'ID (data, string) is a few-letter code for the size property panel.';
				case PanelPropSize.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the size property panel.';
				case PanelPropSize.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the size property panel.';
				case PanelPropSize.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropSize.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropSize.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropSize.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropSize.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropSize.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropSize.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropSize, POINTER) returns settings of POINTER of PanelPropSize.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropSize, POINTER) returns settings of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropSize.EDITFIELD
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropSize.AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropSize.LN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropSize.TEMPLATE
					prop_settings = 'PanelPropSize';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropSize.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropSize.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropSize, POINTER) returns the default value of POINTER of PanelPropSize.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropSize, POINTER) returns the default value of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE
					prop_default = true;
				case PanelPropSize.EDITFIELD
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.LN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.ELCLASS
					prop_default = 'PanelPropSize';
				case PanelPropSize.NAME
					prop_default = 'Size Prop Panel';
				case PanelPropSize.DESCRIPTION
					prop_default = 'A Size Prop Panel (PanelPropSize) plots the panel for a SIZE property with a numeric edit field. It works for all categories.';
				case PanelPropSize.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.ID
					prop_default = 'PanelPropSize ID';
				case PanelPropSize.LABEL
					prop_default = 'PanelPropSize label';
				case PanelPropSize.NOTES
					prop_default = 'PanelPropSize notes';
				case PanelPropSize.EL
					prop_default = PanelProp();
				case PanelPropSize.PROP
					prop_default = PanelProp.HEIGHT;
				case PanelPropSize.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropSize.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropSize.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropSize, POINTER) returns the conditioned default value of POINTER of PanelPropSize.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropSize, POINTER) returns the conditioned default value of POINTER of PanelPropSize.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			prop_default = PanelPropSize.conditioning(prop, PanelPropSize.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropSize, PROP, VALUE) checks VALUE format for PROP of PanelPropSize.
			%  CHECK = PR.CHECKPROP(PanelPropSize, PROP, VALUE) checks VALUE format for PROP of PanelPropSize.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropSize:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropSize:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropSize, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropSize.
			%   Error id: €BRAPH2.STR€:PanelPropSize:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropSize, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropSize.
			%   Error id: €BRAPH2.STR€:PanelPropSize:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropSize')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropSize.getPropProp(pointer);
			
			switch prop
				case PanelPropSize.ENABLE % __PanelPropSize.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.EDITFIELD % __PanelPropSize.EDITFIELD__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.AXES % __PanelPropSize.AXES__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.LN % __PanelPropSize.LN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropSize.getPropSettings(prop));
				case PanelPropSize.TEMPLATE % __PanelPropSize.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropSize.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropSize:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropSize.getPropTag(prop) ' (' PanelPropSize.getFormatTag(PanelPropSize.getPropFormat(prop)) ').'] ...
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
				case PanelPropSize.EDITFIELD % __PanelPropSize.EDITFIELD__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD', ...
					    'Limits', [0 +Inf], ...
					    'LowerLimitInclusive', false, ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield} ...
					    );
					
					value = editfield;
					
				case PanelPropSize.AXES % __PanelPropSize.AXES__
					axes = uiaxes( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'AXES' ...
					    );
					axis(axes, 'off')
					axes.Toolbar.Visible = 'off';
					axes.Interactions = [];
					
					value = axes;
					
				case PanelPropSize.LN % __PanelPropSize.LN__
					axes = pr.memorize('AXES');
					
					ln = plot(axes, ...
					    [-100 0 100], ...
					    [0 0 0], ...
					    'Marker', 's', ...
					    'Color', 'k');
					xlim(axes, [-1 1])        
					ylim(axes, [-1 1])
					
					value = ln;
					
				case PanelPropSize.X_DRAW % __PanelPropSize.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('EDITFIELD')
					    pr.memorize('AXES')
					    pr.memorize('LN')
					end
					
				case PanelPropSize.UPDATE % __PanelPropSize.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('EDITFIELD'), ...
					                'Value', el.get(prop), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            set(pr.get('LN'), ...
					                'LineWidth', el.get(prop), ...
					                'MarkerSize', el.get(prop) ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					            set(pr.get('LN'), ...
					                'LineWidth', el.get(prop), ...
					                'MarkerSize', el.get(prop) ...
					                )
					
					            if el.isLocked(prop)
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					            set(pr.get('LN'), ...
					                'LineWidth', el.get(prop), ...
					                'MarkerSize', el.get(prop) ...
					                )
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('EDITFIELD'), 'Value', el.getPropDefault(prop))
					                set(pr.get('LN'), ...
					                    'LineWidth', el.getPropDefault(prop), ...
					                    'MarkerSize', el.getPropDefault(prop) ...
					                    )
					            else
					                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					                set(pr.get('LN'), ...
					                    'LineWidth', el.get(prop), ...
					                    'MarkerSize', el.get(prop) ...
					                    )
					            end
					            
					            set(pr.get('EDITFIELD'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					    end
					end
					
				case PanelPropSize.REDRAW % __PanelPropSize.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
					    set(pr.get('AXES'), 'InnerPosition', [s(.3)+.15*w_p+s(.6) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropSize.DELETE % __PanelPropSize.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('EDITFIELD', Element.getNoValue())
					    pr.set('AXES', Element.getNoValue())
					    pr.set('LN', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('EDITFIELD'), 'Value'))
			end
		end
	end
end
