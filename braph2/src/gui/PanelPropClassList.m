classdef PanelPropClassList < PanelProp
	%PanelPropClassList plots the panel of a property class list.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Class-List Prop Panel (PanelPropClassList) plots the panel for a CLASSLIST property with a listbox.
	% It works for all categories.
	%
	% PanelPropClassList methods (constructor):
	%  PanelPropClassList - constructor
	%
	% PanelPropClassList methods:
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
	% PanelPropClassList methods (display):
	%  tostring - string with information about the class-list prop panel
	%  disp - displays information about the class-list prop panel
	%  tree - displays the tree of the class-list prop panel
	%
	% PanelPropClassList methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two class-list prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the class-list prop panel
	%
	% PanelPropClassList methods (save/load, Static):
	%  save - saves BRAPH2 class-list prop panel as b2 file
	%  load - loads a BRAPH2 class-list prop panel from a b2 file
	%
	% PanelPropClassList method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the class-list prop panel
	%
	% PanelPropClassList method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the class-list prop panel
	%
	% PanelPropClassList methods (inspection, Static):
	%  getClass - returns the class of the class-list prop panel
	%  getSubclasses - returns all subclasses of PanelPropClassList
	%  getProps - returns the property list of the class-list prop panel
	%  getPropNumber - returns the property number of the class-list prop panel
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
	% PanelPropClassList methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropClassList methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropClassList methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropClassList methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropClassList; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropClassList constants</a>.
	%
	%
	% See also uilistbox, GUI, PanelElement.
	
	properties (Constant) % properties
		LISTBOX = PanelProp.getPropNumber() + 1;
		LISTBOX_TAG = 'LISTBOX';
		LISTBOX_CATEGORY = Category.EVANESCENT;
		LISTBOX_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropClassList(varargin)
			%PanelPropClassList() creates a class-list prop panel.
			%
			% PanelPropClassList(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropClassList(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the class-list prop panel.
			%
			% CLASS = PanelPropClassList.GETCLASS() returns the class 'PanelPropClassList'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the class-list prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropClassList') returns 'PanelPropClassList'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropClassList')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropClassList';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the class-list prop panel.
			%
			% LIST = PanelPropClassList.GETSUBCLASSES() returns all subclasses of 'PanelPropClassList'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the class-list prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropClassList') returns all subclasses of 'PanelPropClassList'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropClassList', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of class-list prop panel.
			%
			% PROPS = PanelPropClassList.GETPROPS() returns the property list of class-list prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropClassList.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the class-list prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropClassList'[, CATEGORY]) returns the property list of 'PanelPropClassList'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropClassList.LISTBOX ...
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
						PanelPropClassList.LISTBOX ...
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
			%GETPROPNUMBER returns the property number of class-list prop panel.
			%
			% N = PanelPropClassList.GETPROPNUMBER() returns the property number of class-list prop panel.
			%
			% N = PanelPropClassList.GETPROPNUMBER(CATEGORY) returns the property number of class-list prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the class-list prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropClassList') returns the property number of 'PanelPropClassList'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropClassList.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in class-list prop panel/error.
			%
			% CHECK = PanelPropClassList.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropClassList, PROP) checks whether PROP exists for PanelPropClassList.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%  Element.EXISTSPROP(PanelPropClassList, PROP) throws error if PROP does NOT exist for PanelPropClassList.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropClassList.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropClassList.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in class-list prop panel/error.
			%
			% CHECK = PanelPropClassList.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropClassList, TAG) checks whether TAG exists for PanelPropClassList.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%  Element.EXISTSTAG(PanelPropClassList, TAG) throws error if TAG does NOT exist for PanelPropClassList.
			%   Error id: [BRAPH2:PanelPropClassList:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropclasslist_tag_list = cellfun(@(x) PanelPropClassList.getPropTag(x), num2cell(PanelPropClassList.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropclasslist_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropClassList.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropClassList, POINTER) returns property number of POINTER of PanelPropClassList.
			%  PROPERTY = PR.GETPROPPROP(PanelPropClassList, POINTER) returns property number of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropclasslist_tag_list = cellfun(@(x) PanelPropClassList.getPropTag(x), num2cell(PanelPropClassList.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropclasslist_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropClassList, POINTER) returns tag of POINTER of PanelPropClassList.
			%  TAG = PR.GETPROPTAG(PanelPropClassList, POINTER) returns tag of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropClassList.LISTBOX
						tag = PanelPropClassList.LISTBOX_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropClassList, POINTER) returns category of POINTER of PanelPropClassList.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropClassList, POINTER) returns category of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX
					prop_category = PanelPropClassList.LISTBOX_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropClassList, POINTER) returns format of POINTER of PanelPropClassList.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropClassList, POINTER) returns format of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX
					prop_format = PanelPropClassList.LISTBOX_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropClassList, POINTER) returns description of POINTER of PanelPropClassList.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropClassList, POINTER) returns description of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX
					prop_description = 'LISTBOX (evanescent, handle) is the logical value listbox.';
				case PanelPropClassList.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the class-list property panel.';
				case PanelPropClassList.NAME
					prop_description = 'NAME (constant, string) is the name of the class-list property panel.';
				case PanelPropClassList.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the class-list property panel.';
				case PanelPropClassList.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the class-list property panel.';
				case PanelPropClassList.ID
					prop_description = 'ID (data, string) is a few-letter code for the class-list property panel.';
				case PanelPropClassList.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the class-list property panel.';
				case PanelPropClassList.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the class-list property panel.';
				case PanelPropClassList.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropClassList.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropClassList.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropClassList.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropClassList.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropClassList.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropClassList.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropClassList, POINTER) returns settings of POINTER of PanelPropClassList.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropClassList, POINTER) returns settings of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropClassList.TEMPLATE
					prop_settings = 'PanelPropClassList';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropClassList.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropClassList.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropClassList, POINTER) returns the default value of POINTER of PanelPropClassList.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropClassList, POINTER) returns the default value of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropClassList.getPropSettings(prop));
				case PanelPropClassList.ELCLASS
					prop_default = 'PanelPropClassList';
				case PanelPropClassList.NAME
					prop_default = 'Class-List Prop Panel';
				case PanelPropClassList.DESCRIPTION
					prop_default = 'A Class-List Prop Panel (PanelPropClassList) plots the panel for a CLASSLIST property with a listbox. It works for all categories.';
				case PanelPropClassList.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropClassList.getPropSettings(prop));
				case PanelPropClassList.ID
					prop_default = 'PanelPropClassList ID';
				case PanelPropClassList.LABEL
					prop_default = 'PanelPropClassList label';
				case PanelPropClassList.NOTES
					prop_default = 'PanelPropClassList notes';
				case PanelPropClassList.EL
					prop_default = Measure();
				case PanelPropClassList.PROP
					prop_default = Measure.COMPATIBLE_GRAPHS;
				case PanelPropClassList.HEIGHT
					prop_default = s(10);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropClassList.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropClassList.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropClassList, POINTER) returns the conditioned default value of POINTER of PanelPropClassList.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropClassList, POINTER) returns the conditioned default value of POINTER of PanelPropClassList.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			prop_default = PanelPropClassList.conditioning(prop, PanelPropClassList.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropClassList, PROP, VALUE) checks VALUE format for PROP of PanelPropClassList.
			%  CHECK = PR.CHECKPROP(PanelPropClassList, PROP, VALUE) checks VALUE format for PROP of PanelPropClassList.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropClassList:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropClassList:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropClassList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropClassList.
			%   Error id: €BRAPH2.STR€:PanelPropClassList:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropClassList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropClassList.
			%   Error id: €BRAPH2.STR€:PanelPropClassList:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropClassList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropClassList.getPropProp(pointer);
			
			switch prop
				case PanelPropClassList.LISTBOX % __PanelPropClassList.LISTBOX__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropClassList.getPropSettings(prop));
				case PanelPropClassList.TEMPLATE % __PanelPropClassList.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropClassList.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropClassList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropClassList.getPropTag(prop) ' (' PanelPropClassList.getFormatTag(PanelPropClassList.getPropFormat(prop)) ').'] ...
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
				case PanelPropClassList.LISTBOX % __PanelPropClassList.LISTBOX__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					listbox = uilistbox( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'LISTBOX', ...
					    'Items', Element.getSubclasses(el.getPropSettings(prop)), ...
					    'MultiSelect', 'on', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_listbox} ...
					    );
					
					value = listbox;
					
				case PanelPropClassList.X_DRAW % __PanelPropClassList.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('LISTBOX')
					end
					
				case PanelPropClassList.UPDATE % __PanelPropClassList.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT % __Category.CONSTANT__
					            set(pr.get('LISTBOX'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            
					        case Category.METADATA % __Category.METADATA__
					            set(pr.get('LISTBOX'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('LISTBOX'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            set(pr.get('LISTBOX'), 'Value', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('LISTBOX'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('v'), 'Value', el.getPropDefault(prop))
					            else
					                set(pr.get('LISTBOX'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('LISTBOX'), 'Enable', 'off')
					    end
					end
					
				case PanelPropClassList.REDRAW % __PanelPropClassList.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
						w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					
					    set(pr.get('LISTBOX'), 'Position', [s(.3) s(.3) .70*w_p s(8)])
					end
					
				case PanelPropClassList.DELETE % __PanelPropClassList.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('LISTBOX', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_listbox(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('LISTBOX'), 'Value'))
			end
		end
	end
end
