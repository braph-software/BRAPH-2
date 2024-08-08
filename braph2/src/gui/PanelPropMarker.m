classdef PanelPropMarker < PanelProp
	%PanelPropMarker plots the panel of a property marker.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Marker Prop Panel (PanelPropMarker) plots the panel for a MARKER property with a drop-down list.
	% It works for all categories.
	%
	% PanelPropMarker methods (constructor):
	%  PanelPropMarker - constructor
	%
	% PanelPropMarker methods:
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
	% PanelPropMarker methods (display):
	%  tostring - string with information about the marker prop panel
	%  disp - displays information about the marker prop panel
	%  tree - displays the tree of the marker prop panel
	%
	% PanelPropMarker methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two marker prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the marker prop panel
	%
	% PanelPropMarker methods (save/load, Static):
	%  save - saves BRAPH2 marker prop panel as b2 file
	%  load - loads a BRAPH2 marker prop panel from a b2 file
	%
	% PanelPropMarker method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the marker prop panel
	%
	% PanelPropMarker method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the marker prop panel
	%
	% PanelPropMarker methods (inspection, Static):
	%  getClass - returns the class of the marker prop panel
	%  getSubclasses - returns all subclasses of PanelPropMarker
	%  getProps - returns the property list of the marker prop panel
	%  getPropNumber - returns the property number of the marker prop panel
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
	% PanelPropMarker methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropMarker methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropMarker methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropMarker methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropMarker; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropMarker constants</a>.
	%
	%
	% See also uidropdown, uiaxes, line, GUI, PanelElement.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
		
		AXES = PanelProp.getPropNumber() + 2;
		AXES_TAG = 'AXES';
		AXES_CATEGORY = Category.EVANESCENT;
		AXES_FORMAT = Format.HANDLE;
		
		LN = PanelProp.getPropNumber() + 3;
		LN_TAG = 'LN';
		LN_CATEGORY = Category.EVANESCENT;
		LN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropMarker(varargin)
			%PanelPropMarker() creates a marker prop panel.
			%
			% PanelPropMarker(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropMarker(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the marker prop panel.
			%
			% CLASS = PanelPropMarker.GETCLASS() returns the class 'PanelPropMarker'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the marker prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropMarker') returns 'PanelPropMarker'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropMarker')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropMarker';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the marker prop panel.
			%
			% LIST = PanelPropMarker.GETSUBCLASSES() returns all subclasses of 'PanelPropMarker'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the marker prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropMarker') returns all subclasses of 'PanelPropMarker'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropMarker', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of marker prop panel.
			%
			% PROPS = PanelPropMarker.GETPROPS() returns the property list of marker prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropMarker.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the marker prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropMarker'[, CATEGORY]) returns the property list of 'PanelPropMarker'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropMarker.DROPDOWN ...
						PanelPropMarker.AXES ...
						PanelPropMarker.LN ...
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
						PanelPropMarker.DROPDOWN ...
						PanelPropMarker.AXES ...
						PanelPropMarker.LN ...
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
			%GETPROPNUMBER returns the property number of marker prop panel.
			%
			% N = PanelPropMarker.GETPROPNUMBER() returns the property number of marker prop panel.
			%
			% N = PanelPropMarker.GETPROPNUMBER(CATEGORY) returns the property number of marker prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the marker prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropMarker') returns the property number of 'PanelPropMarker'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropMarker.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in marker prop panel/error.
			%
			% CHECK = PanelPropMarker.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropMarker, PROP) checks whether PROP exists for PanelPropMarker.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%  Element.EXISTSPROP(PanelPropMarker, PROP) throws error if PROP does NOT exist for PanelPropMarker.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropMarker.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropMarker.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in marker prop panel/error.
			%
			% CHECK = PanelPropMarker.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropMarker, TAG) checks whether TAG exists for PanelPropMarker.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%  Element.EXISTSTAG(PanelPropMarker, TAG) throws error if TAG does NOT exist for PanelPropMarker.
			%   Error id: [BRAPH2:PanelPropMarker:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropmarker_tag_list = cellfun(@(x) PanelPropMarker.getPropTag(x), num2cell(PanelPropMarker.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropmarker_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropMarker.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropMarker, POINTER) returns property number of POINTER of PanelPropMarker.
			%  PROPERTY = PR.GETPROPPROP(PanelPropMarker, POINTER) returns property number of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropmarker_tag_list = cellfun(@(x) PanelPropMarker.getPropTag(x), num2cell(PanelPropMarker.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropmarker_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropMarker, POINTER) returns tag of POINTER of PanelPropMarker.
			%  TAG = PR.GETPROPTAG(PanelPropMarker, POINTER) returns tag of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropMarker.DROPDOWN
						tag = PanelPropMarker.DROPDOWN_TAG;
					case PanelPropMarker.AXES
						tag = PanelPropMarker.AXES_TAG;
					case PanelPropMarker.LN
						tag = PanelPropMarker.LN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropMarker, POINTER) returns category of POINTER of PanelPropMarker.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropMarker, POINTER) returns category of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN
					prop_category = PanelPropMarker.DROPDOWN_CATEGORY;
				case PanelPropMarker.AXES
					prop_category = PanelPropMarker.AXES_CATEGORY;
				case PanelPropMarker.LN
					prop_category = PanelPropMarker.LN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropMarker, POINTER) returns format of POINTER of PanelPropMarker.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropMarker, POINTER) returns format of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN
					prop_format = PanelPropMarker.DROPDOWN_FORMAT;
				case PanelPropMarker.AXES
					prop_format = PanelPropMarker.AXES_FORMAT;
				case PanelPropMarker.LN
					prop_format = PanelPropMarker.LN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropMarker, POINTER) returns description of POINTER of PanelPropMarker.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropMarker, POINTER) returns description of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the marker value dropdown.';
				case PanelPropMarker.AXES
					prop_description = 'AXES (evanescent, handle) is the marker value axes.';
				case PanelPropMarker.LN
					prop_description = 'LN (evanescent, handle) is the marker value line.';
				case PanelPropMarker.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the marker property panel.';
				case PanelPropMarker.NAME
					prop_description = 'NAME (constant, string) is the name of the marker property panel.';
				case PanelPropMarker.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the marker property panel.';
				case PanelPropMarker.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the marker property panel.';
				case PanelPropMarker.ID
					prop_description = 'ID (data, string) is a few-letter code for the marker property panel.';
				case PanelPropMarker.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the marker property panel.';
				case PanelPropMarker.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the marker property panel.';
				case PanelPropMarker.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropMarker.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropMarker.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropMarker.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropMarker.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropMarker.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropMarker.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropMarker, POINTER) returns settings of POINTER of PanelPropMarker.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropMarker, POINTER) returns settings of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropMarker.AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropMarker.LN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropMarker.TEMPLATE
					prop_settings = 'PanelPropMarker';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropMarker.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropMarker.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropMarker, POINTER) returns the default value of POINTER of PanelPropMarker.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropMarker, POINTER) returns the default value of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.LN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.ELCLASS
					prop_default = 'PanelPropMarker';
				case PanelPropMarker.NAME
					prop_default = 'Marker Prop Panel';
				case PanelPropMarker.DESCRIPTION
					prop_default = 'A Marker Prop Panel (PanelPropMarker) plots the panel for a MARKER property with a drop-down list. It works for all categories.';
				case PanelPropMarker.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.ID
					prop_default = 'PanelPropMarker ID';
				case PanelPropMarker.LABEL
					prop_default = 'PanelPropMarker label';
				case PanelPropMarker.NOTES
					prop_default = 'PanelPropMarker notes';
				case PanelPropMarker.EL
					prop_default = SettingsSymbol();
				case PanelPropMarker.PROP
					prop_default = SettingsSymbol.SYMBOL;
				case PanelPropMarker.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropMarker.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropMarker.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropMarker, POINTER) returns the conditioned default value of POINTER of PanelPropMarker.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropMarker, POINTER) returns the conditioned default value of POINTER of PanelPropMarker.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			prop_default = PanelPropMarker.conditioning(prop, PanelPropMarker.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropMarker, PROP, VALUE) checks VALUE format for PROP of PanelPropMarker.
			%  CHECK = PR.CHECKPROP(PanelPropMarker, PROP, VALUE) checks VALUE format for PROP of PanelPropMarker.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropMarker:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropMarker:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropMarker, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropMarker.
			%   Error id: €BRAPH2.STR€:PanelPropMarker:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropMarker, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropMarker.
			%   Error id: €BRAPH2.STR€:PanelPropMarker:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropMarker')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropMarker.getPropProp(pointer);
			
			switch prop
				case PanelPropMarker.DROPDOWN % __PanelPropMarker.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.AXES % __PanelPropMarker.AXES__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.LN % __PanelPropMarker.LN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropMarker.getPropSettings(prop));
				case PanelPropMarker.TEMPLATE % __PanelPropMarker.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropMarker.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMarker:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropMarker.getPropTag(prop) ' (' PanelPropMarker.getFormatTag(PanelPropMarker.getPropFormat(prop)) ').'] ...
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
				case PanelPropMarker.DROPDOWN % __PanelPropMarker.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'Items', el.getPropSettings(prop), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case PanelPropMarker.AXES % __PanelPropMarker.AXES__
					axes = uiaxes( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'AXES' ...
					    );
					axis(axes, 'off')
					axes.Toolbar.Visible = 'off';
					axes.Interactions = [];
					value = axes;
					
				case PanelPropMarker.LN % __PanelPropMarker.LN__
					axes = pr.memorize('AXES');
					
					ln = plot(axes, ...
					    [0], ...
					    [0], ...
					    'MarkerSize', 10, ...
					    'MarkerFaceColor', 'k', ...
					    'MarkerEdgeColor', 'k');
					xlim(axes, [-1 1])        
					ylim(axes, [-1 1])
					
					value = ln;
					
				case PanelPropMarker.X_DRAW % __PanelPropMarker.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					    pr.memorize('AXES')
					    pr.memorize('LN')
					end
					
				case PanelPropMarker.UPDATE % __PanelPropMarker.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('DROPDOWN'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            set(pr.get('LN'), 'Marker', el.get(prop))
					            
					        case Category.METADATA
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            set(pr.get('LN'), 'Marker', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            set(pr.get('LN'), 'Marker', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
					                set(pr.get('LN'), 'Marker', el.getPropDefault(prop))
					            else
					                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					                set(pr.get('LN'), 'Marker', el.get(prop))
					            end
					            
					            set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case PanelPropMarker.REDRAW % __PanelPropMarker.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
					    set(pr.get('AXES'), 'InnerPosition', [s(.3)+.15*w_p+s(1.7) s(.3) .70*w_p s(1.7)])
					end
					
				case PanelPropMarker.DELETE % __PanelPropMarker.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
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
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end
