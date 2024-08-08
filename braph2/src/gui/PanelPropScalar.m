classdef PanelPropScalar < PanelProp
	%PanelPropScalar plots the panel of a property scalar.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Scalar Prop Panel (PanelPropScalar) plots the panel for a SCALAR property with a numeric edit field.
	% It works for all categories.
	%
	% PanelPropScalar methods (constructor):
	%  PanelPropScalar - constructor
	%
	% PanelPropScalar methods:
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
	% PanelPropScalar methods (display):
	%  tostring - string with information about the scalar prop panel
	%  disp - displays information about the scalar prop panel
	%  tree - displays the tree of the scalar prop panel
	%
	% PanelPropScalar methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two scalar prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the scalar prop panel
	%
	% PanelPropScalar methods (save/load, Static):
	%  save - saves BRAPH2 scalar prop panel as b2 file
	%  load - loads a BRAPH2 scalar prop panel from a b2 file
	%
	% PanelPropScalar method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the scalar prop panel
	%
	% PanelPropScalar method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the scalar prop panel
	%
	% PanelPropScalar methods (inspection, Static):
	%  getClass - returns the class of the scalar prop panel
	%  getSubclasses - returns all subclasses of PanelPropScalar
	%  getProps - returns the property list of the scalar prop panel
	%  getPropNumber - returns the property number of the scalar prop panel
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
	% PanelPropScalar methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropScalar methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropScalar methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropScalar methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropScalar; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropScalar constants</a>.
	%
	%
	% See also uieditfield, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		EDITFIELD = PanelProp.getPropNumber() + 2;
		EDITFIELD_TAG = 'EDITFIELD';
		EDITFIELD_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropScalar(varargin)
			%PanelPropScalar() creates a scalar prop panel.
			%
			% PanelPropScalar(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropScalar(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the scalar prop panel.
			%
			% CLASS = PanelPropScalar.GETCLASS() returns the class 'PanelPropScalar'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the scalar prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropScalar') returns 'PanelPropScalar'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropScalar')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropScalar';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the scalar prop panel.
			%
			% LIST = PanelPropScalar.GETSUBCLASSES() returns all subclasses of 'PanelPropScalar'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the scalar prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropScalar') returns all subclasses of 'PanelPropScalar'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropScalar', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of scalar prop panel.
			%
			% PROPS = PanelPropScalar.GETPROPS() returns the property list of scalar prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropScalar.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the scalar prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropScalar'[, CATEGORY]) returns the property list of 'PanelPropScalar'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropScalar.ENABLE ...
						PanelPropScalar.EDITFIELD ...
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
						PanelPropScalar.EDITFIELD ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropScalar.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of scalar prop panel.
			%
			% N = PanelPropScalar.GETPROPNUMBER() returns the property number of scalar prop panel.
			%
			% N = PanelPropScalar.GETPROPNUMBER(CATEGORY) returns the property number of scalar prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the scalar prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropScalar') returns the property number of 'PanelPropScalar'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropScalar.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in scalar prop panel/error.
			%
			% CHECK = PanelPropScalar.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropScalar, PROP) checks whether PROP exists for PanelPropScalar.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%  Element.EXISTSPROP(PanelPropScalar, PROP) throws error if PROP does NOT exist for PanelPropScalar.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropScalar.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropScalar.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in scalar prop panel/error.
			%
			% CHECK = PanelPropScalar.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropScalar, TAG) checks whether TAG exists for PanelPropScalar.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%  Element.EXISTSTAG(PanelPropScalar, TAG) throws error if TAG does NOT exist for PanelPropScalar.
			%   Error id: [BRAPH2:PanelPropScalar:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropscalar_tag_list = cellfun(@(x) PanelPropScalar.getPropTag(x), num2cell(PanelPropScalar.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropscalar_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropScalar.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropScalar, POINTER) returns property number of POINTER of PanelPropScalar.
			%  PROPERTY = PR.GETPROPPROP(PanelPropScalar, POINTER) returns property number of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropscalar_tag_list = cellfun(@(x) PanelPropScalar.getPropTag(x), num2cell(PanelPropScalar.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropscalar_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropScalar, POINTER) returns tag of POINTER of PanelPropScalar.
			%  TAG = PR.GETPROPTAG(PanelPropScalar, POINTER) returns tag of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropScalar.ENABLE
						tag = PanelPropScalar.ENABLE_TAG;
					case PanelPropScalar.EDITFIELD
						tag = PanelPropScalar.EDITFIELD_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropScalar, POINTER) returns category of POINTER of PanelPropScalar.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropScalar, POINTER) returns category of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE
					prop_category = PanelPropScalar.ENABLE_CATEGORY;
				case PanelPropScalar.EDITFIELD
					prop_category = PanelPropScalar.EDITFIELD_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropScalar, POINTER) returns format of POINTER of PanelPropScalar.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropScalar, POINTER) returns format of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE
					prop_format = PanelPropScalar.ENABLE_FORMAT;
				case PanelPropScalar.EDITFIELD
					prop_format = PanelPropScalar.EDITFIELD_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropScalar, POINTER) returns description of POINTER of PanelPropScalar.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropScalar, POINTER) returns description of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.';
				case PanelPropScalar.EDITFIELD
					prop_description = 'EDITFIELD (evanescent, handle) is the alpha value edit field.';
				case PanelPropScalar.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the scalar property panel.';
				case PanelPropScalar.NAME
					prop_description = 'NAME (constant, string) is the name of the scalar property panel.';
				case PanelPropScalar.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the scalar property panel.';
				case PanelPropScalar.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the scalar property panel.';
				case PanelPropScalar.ID
					prop_description = 'ID (data, string) is a few-letter code for the scalar property panel.';
				case PanelPropScalar.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the scalar property panel.';
				case PanelPropScalar.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the scalar property panel.';
				case PanelPropScalar.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropScalar.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropScalar.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropScalar.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropScalar.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropScalar.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropScalar.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropScalar, POINTER) returns settings of POINTER of PanelPropScalar.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropScalar, POINTER) returns settings of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropScalar.EDITFIELD
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropScalar.TEMPLATE
					prop_settings = 'PanelPropScalar';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropScalar.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropScalar.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropScalar, POINTER) returns the default value of POINTER of PanelPropScalar.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropScalar, POINTER) returns the default value of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE
					prop_default = true;
				case PanelPropScalar.EDITFIELD
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropScalar.getPropSettings(prop));
				case PanelPropScalar.ELCLASS
					prop_default = 'PanelPropScalar';
				case PanelPropScalar.NAME
					prop_default = 'Scalar Prop Panel';
				case PanelPropScalar.DESCRIPTION
					prop_default = 'A Scalar Prop Panel (PanelPropScalar) plots the panel for a SCALAR property with a numeric edit field. It works for all categories.';
				case PanelPropScalar.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropScalar.getPropSettings(prop));
				case PanelPropScalar.ID
					prop_default = 'PanelPropScalar ID';
				case PanelPropScalar.LABEL
					prop_default = 'PanelPropScalar label';
				case PanelPropScalar.NOTES
					prop_default = 'PanelPropScalar notes';
				case PanelPropScalar.EL
					prop_default = PanelProp();
				case PanelPropScalar.PROP
					prop_default = PanelProp.PROP;
				case PanelPropScalar.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropScalar.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropScalar.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropScalar, POINTER) returns the conditioned default value of POINTER of PanelPropScalar.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropScalar, POINTER) returns the conditioned default value of POINTER of PanelPropScalar.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			prop_default = PanelPropScalar.conditioning(prop, PanelPropScalar.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropScalar, PROP, VALUE) checks VALUE format for PROP of PanelPropScalar.
			%  CHECK = PR.CHECKPROP(PanelPropScalar, PROP, VALUE) checks VALUE format for PROP of PanelPropScalar.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropScalar:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropScalar:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropScalar, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropScalar.
			%   Error id: €BRAPH2.STR€:PanelPropScalar:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropScalar, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropScalar.
			%   Error id: €BRAPH2.STR€:PanelPropScalar:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropScalar')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropScalar.getPropProp(pointer);
			
			switch prop
				case PanelPropScalar.ENABLE % __PanelPropScalar.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropScalar.getPropSettings(prop));
				case PanelPropScalar.EDITFIELD % __PanelPropScalar.EDITFIELD__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropScalar.getPropSettings(prop));
				case PanelPropScalar.TEMPLATE % __PanelPropScalar.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropScalar.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropScalar:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropScalar.getPropTag(prop) ' (' PanelPropScalar.getFormatTag(PanelPropScalar.getPropFormat(prop)) ').'] ...
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
				case PanelPropScalar.EDITFIELD % __PanelPropScalar.EDITFIELD__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield} ...
					    );
					
					value = editfield;
					
				case PanelPropScalar.X_DRAW % __PanelPropScalar.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('EDITFIELD')
					end
					
				case PanelPropScalar.UPDATE % __PanelPropScalar.UPDATE__
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
					            
					        case Category.METADATA
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					
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
					            else
					                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('EDITFIELD'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					    end
					end
					
				case PanelPropScalar.REDRAW % __PanelPropScalar.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .25*w_p s(1.75)])
					end
					
				case PanelPropScalar.DELETE % __PanelPropScalar.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('EDITFIELD', Element.getNoValue())
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
