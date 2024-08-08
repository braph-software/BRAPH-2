classdef PanelPropClass < PanelProp
	%PanelPropClass plots the panel of a property class.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Class Prop Panel (PanelPropClass) plots the panel for a CLASS property with a drop-down list.
	% It works for all categories.
	%
	% PanelPropClass methods (constructor):
	%  PanelPropClass - constructor
	%
	% PanelPropClass methods:
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
	% PanelPropClass methods (display):
	%  tostring - string with information about the class prop panel
	%  disp - displays information about the class prop panel
	%  tree - displays the tree of the class prop panel
	%
	% PanelPropClass methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two class prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the class prop panel
	%
	% PanelPropClass methods (save/load, Static):
	%  save - saves BRAPH2 class prop panel as b2 file
	%  load - loads a BRAPH2 class prop panel from a b2 file
	%
	% PanelPropClass method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the class prop panel
	%
	% PanelPropClass method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the class prop panel
	%
	% PanelPropClass methods (inspection, Static):
	%  getClass - returns the class of the class prop panel
	%  getSubclasses - returns all subclasses of PanelPropClass
	%  getProps - returns the property list of the class prop panel
	%  getPropNumber - returns the property number of the class prop panel
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
	% PanelPropClass methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropClass methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropClass methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropClass methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropClass; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropClass constants</a>.
	%
	%
	% See also uidropdown, GUI, PanelElement.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropClass(varargin)
			%PanelPropClass() creates a class prop panel.
			%
			% PanelPropClass(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropClass(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the class prop panel.
			%
			% CLASS = PanelPropClass.GETCLASS() returns the class 'PanelPropClass'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the class prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropClass') returns 'PanelPropClass'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropClass')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropClass';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the class prop panel.
			%
			% LIST = PanelPropClass.GETSUBCLASSES() returns all subclasses of 'PanelPropClass'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the class prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropClass') returns all subclasses of 'PanelPropClass'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropClass', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of class prop panel.
			%
			% PROPS = PanelPropClass.GETPROPS() returns the property list of class prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropClass.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the class prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropClass'[, CATEGORY]) returns the property list of 'PanelPropClass'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropClass.DROPDOWN ...
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
						PanelPropClass.DROPDOWN ...
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
			%GETPROPNUMBER returns the property number of class prop panel.
			%
			% N = PanelPropClass.GETPROPNUMBER() returns the property number of class prop panel.
			%
			% N = PanelPropClass.GETPROPNUMBER(CATEGORY) returns the property number of class prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the class prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropClass') returns the property number of 'PanelPropClass'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropClass.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in class prop panel/error.
			%
			% CHECK = PanelPropClass.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropClass, PROP) checks whether PROP exists for PanelPropClass.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropClass:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%  Element.EXISTSPROP(PanelPropClass, PROP) throws error if PROP does NOT exist for PanelPropClass.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropClass.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropClass.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in class prop panel/error.
			%
			% CHECK = PanelPropClass.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropClass, TAG) checks whether TAG exists for PanelPropClass.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropClass:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%  Element.EXISTSTAG(PanelPropClass, TAG) throws error if TAG does NOT exist for PanelPropClass.
			%   Error id: [BRAPH2:PanelPropClass:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropclass_tag_list = cellfun(@(x) PanelPropClass.getPropTag(x), num2cell(PanelPropClass.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropclass_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropClass.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropClass, POINTER) returns property number of POINTER of PanelPropClass.
			%  PROPERTY = PR.GETPROPPROP(PanelPropClass, POINTER) returns property number of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropclass_tag_list = cellfun(@(x) PanelPropClass.getPropTag(x), num2cell(PanelPropClass.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropclass_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropClass, POINTER) returns tag of POINTER of PanelPropClass.
			%  TAG = PR.GETPROPTAG(PanelPropClass, POINTER) returns tag of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropClass.DROPDOWN
						tag = PanelPropClass.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropClass, POINTER) returns category of POINTER of PanelPropClass.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropClass, POINTER) returns category of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN
					prop_category = PanelPropClass.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropClass, POINTER) returns format of POINTER of PanelPropClass.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropClass, POINTER) returns format of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN
					prop_format = PanelPropClass.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropClass, POINTER) returns description of POINTER of PanelPropClass.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropClass, POINTER) returns description of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the logical value dropdown.';
				case PanelPropClass.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the class property panel.';
				case PanelPropClass.NAME
					prop_description = 'NAME (constant, string) is the name of the class property panel.';
				case PanelPropClass.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the class property panel.';
				case PanelPropClass.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the class property panel.';
				case PanelPropClass.ID
					prop_description = 'ID (data, string) is a few-letter code for the class property panel.';
				case PanelPropClass.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the class property panel.';
				case PanelPropClass.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the class property panel.';
				case PanelPropClass.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropClass.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropClass.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropClass.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropClass.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropClass.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropClass.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropClass, POINTER) returns settings of POINTER of PanelPropClass.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropClass, POINTER) returns settings of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropClass.TEMPLATE
					prop_settings = 'PanelPropClass';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropClass.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropClass.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropClass, POINTER) returns the default value of POINTER of PanelPropClass.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropClass, POINTER) returns the default value of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropClass.getPropSettings(prop));
				case PanelPropClass.ELCLASS
					prop_default = 'PanelPropClass';
				case PanelPropClass.NAME
					prop_default = 'Class Prop Panel';
				case PanelPropClass.DESCRIPTION
					prop_default = 'A Class Prop Panel (PanelPropClass) plots the panel for a CLASS property with a drop-down list. It works for all categories.';
				case PanelPropClass.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropClass.getPropSettings(prop));
				case PanelPropClass.ID
					prop_default = 'PanelPropClass ID';
				case PanelPropClass.LABEL
					prop_default = 'PanelPropClass label';
				case PanelPropClass.NOTES
					prop_default = 'PanelPropClass notes';
				case PanelPropClass.EL
					prop_default = IndexedDictionary();
				case PanelPropClass.PROP
					prop_default = IndexedDictionary.IT_CLASS;
				case PanelPropClass.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropClass.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropClass.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropClass, POINTER) returns the conditioned default value of POINTER of PanelPropClass.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropClass, POINTER) returns the conditioned default value of POINTER of PanelPropClass.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			prop_default = PanelPropClass.conditioning(prop, PanelPropClass.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropClass, PROP, VALUE) checks VALUE format for PROP of PanelPropClass.
			%  CHECK = PR.CHECKPROP(PanelPropClass, PROP, VALUE) checks VALUE format for PROP of PanelPropClass.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropClass:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropClass:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropClass, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropClass.
			%   Error id: €BRAPH2.STR€:PanelPropClass:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropClass, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropClass.
			%   Error id: €BRAPH2.STR€:PanelPropClass:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropClass')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropClass.getPropProp(pointer);
			
			switch prop
				case PanelPropClass.DROPDOWN % __PanelPropClass.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropClass.getPropSettings(prop));
				case PanelPropClass.TEMPLATE % __PanelPropClass.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropClass.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClass:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropClass.getPropTag(prop) ' (' PanelPropClass.getFormatTag(PanelPropClass.getPropFormat(prop)) ').'] ...
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
				case PanelPropClass.DROPDOWN % __PanelPropClass.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'Items', Element.getSubclasses(el.getPropSettings(prop)), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case PanelPropClass.X_DRAW % __PanelPropClass.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case PanelPropClass.UPDATE % __PanelPropClass.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT % __Category.CONSTANT__
					            set(pr.get('DROPDOWN'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            
					        case Category.METADATA % __Category.METADATA__
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
					            else
					                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case PanelPropClass.REDRAW % __PanelPropClass.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropClass.DELETE % __PanelPropClass.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end
