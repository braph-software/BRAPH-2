classdef PanelPropLine < PanelProp
	%PanelPropLine plots the panel of a property line.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Line Prop Panel (PanelPropLine) plots the panel for an LINE property with a drop-down list.
	% It works for all categories.
	%
	% PanelPropLine methods (constructor):
	%  PanelPropLine - constructor
	%
	% PanelPropLine methods:
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
	% PanelPropLine methods (display):
	%  tostring - string with information about the line prop panel
	%  disp - displays information about the line prop panel
	%  tree - displays the tree of the line prop panel
	%
	% PanelPropLine methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two line prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the line prop panel
	%
	% PanelPropLine methods (save/load, Static):
	%  save - saves BRAPH2 line prop panel as b2 file
	%  load - loads a BRAPH2 line prop panel from a b2 file
	%
	% PanelPropLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the line prop panel
	%
	% PanelPropLine method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the line prop panel
	%
	% PanelPropLine methods (inspection, Static):
	%  getClass - returns the class of the line prop panel
	%  getSubclasses - returns all subclasses of PanelPropLine
	%  getProps - returns the property list of the line prop panel
	%  getPropNumber - returns the property number of the line prop panel
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
	% PanelPropLine methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropLine methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropLine methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropLine; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropLine constants</a>.
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
		function pr = PanelPropLine(varargin)
			%PanelPropLine() creates a line prop panel.
			%
			% PanelPropLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropLine(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the line prop panel.
			%
			% CLASS = PanelPropLine.GETCLASS() returns the class 'PanelPropLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the line prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropLine') returns 'PanelPropLine'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropLine')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropLine';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the line prop panel.
			%
			% LIST = PanelPropLine.GETSUBCLASSES() returns all subclasses of 'PanelPropLine'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the line prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropLine') returns all subclasses of 'PanelPropLine'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropLine', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of line prop panel.
			%
			% PROPS = PanelPropLine.GETPROPS() returns the property list of line prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the line prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropLine'[, CATEGORY]) returns the property list of 'PanelPropLine'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropLine.DROPDOWN ...
						PanelPropLine.AXES ...
						PanelPropLine.LN ...
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
						PanelPropLine.DROPDOWN ...
						PanelPropLine.AXES ...
						PanelPropLine.LN ...
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
			%GETPROPNUMBER returns the property number of line prop panel.
			%
			% N = PanelPropLine.GETPROPNUMBER() returns the property number of line prop panel.
			%
			% N = PanelPropLine.GETPROPNUMBER(CATEGORY) returns the property number of line prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the line prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropLine') returns the property number of 'PanelPropLine'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropLine.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in line prop panel/error.
			%
			% CHECK = PanelPropLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropLine, PROP) checks whether PROP exists for PanelPropLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%  Element.EXISTSPROP(PanelPropLine, PROP) throws error if PROP does NOT exist for PanelPropLine.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropLine.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropLine.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in line prop panel/error.
			%
			% CHECK = PanelPropLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropLine, TAG) checks whether TAG exists for PanelPropLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%  Element.EXISTSTAG(PanelPropLine, TAG) throws error if TAG does NOT exist for PanelPropLine.
			%   Error id: [BRAPH2:PanelPropLine:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropline_tag_list = cellfun(@(x) PanelPropLine.getPropTag(x), num2cell(PanelPropLine.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropline_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropLine.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropLine, POINTER) returns property number of POINTER of PanelPropLine.
			%  PROPERTY = PR.GETPROPPROP(PanelPropLine, POINTER) returns property number of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropline_tag_list = cellfun(@(x) PanelPropLine.getPropTag(x), num2cell(PanelPropLine.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropline_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropLine, POINTER) returns tag of POINTER of PanelPropLine.
			%  TAG = PR.GETPROPTAG(PanelPropLine, POINTER) returns tag of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropLine.DROPDOWN
						tag = PanelPropLine.DROPDOWN_TAG;
					case PanelPropLine.AXES
						tag = PanelPropLine.AXES_TAG;
					case PanelPropLine.LN
						tag = PanelPropLine.LN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropLine, POINTER) returns category of POINTER of PanelPropLine.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropLine, POINTER) returns category of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN
					prop_category = PanelPropLine.DROPDOWN_CATEGORY;
				case PanelPropLine.AXES
					prop_category = PanelPropLine.AXES_CATEGORY;
				case PanelPropLine.LN
					prop_category = PanelPropLine.LN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropLine, POINTER) returns format of POINTER of PanelPropLine.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropLine, POINTER) returns format of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN
					prop_format = PanelPropLine.DROPDOWN_FORMAT;
				case PanelPropLine.AXES
					prop_format = PanelPropLine.AXES_FORMAT;
				case PanelPropLine.LN
					prop_format = PanelPropLine.LN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropLine, POINTER) returns description of POINTER of PanelPropLine.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropLine, POINTER) returns description of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the marker value dropdown.';
				case PanelPropLine.AXES
					prop_description = 'AXES (evanescent, handle) is the marker value axes.';
				case PanelPropLine.LN
					prop_description = 'LN (evanescent, handle) is the marker value line.';
				case PanelPropLine.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the line property panel.';
				case PanelPropLine.NAME
					prop_description = 'NAME (constant, string) is the name of the line property panel.';
				case PanelPropLine.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the line property panel.';
				case PanelPropLine.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the line property panel.';
				case PanelPropLine.ID
					prop_description = 'ID (data, string) is a few-letter code for the line property panel.';
				case PanelPropLine.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the line property panel.';
				case PanelPropLine.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the line property panel.';
				case PanelPropLine.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropLine.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropLine.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropLine.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropLine.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropLine.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropLine.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropLine, POINTER) returns settings of POINTER of PanelPropLine.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropLine, POINTER) returns settings of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropLine.AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropLine.LN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropLine.TEMPLATE
					prop_settings = 'PanelPropLine';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropLine, POINTER) returns the default value of POINTER of PanelPropLine.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropLine, POINTER) returns the default value of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.LN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.ELCLASS
					prop_default = 'PanelPropLine';
				case PanelPropLine.NAME
					prop_default = 'Line Prop Panel';
				case PanelPropLine.DESCRIPTION
					prop_default = 'A Line Prop Panel (PanelPropLine) plots the panel for an LINE property with a drop-down list. It works for all categories.';
				case PanelPropLine.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.ID
					prop_default = 'PanelPropLine ID';
				case PanelPropLine.LABEL
					prop_default = 'PanelPropLine label';
				case PanelPropLine.NOTES
					prop_default = 'PanelPropLine notes';
				case PanelPropLine.EL
					prop_default = SettingsLine();
				case PanelPropLine.PROP
					prop_default = SettingsLine.LINESTYLE;
				case PanelPropLine.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropLine, POINTER) returns the conditioned default value of POINTER of PanelPropLine.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropLine, POINTER) returns the conditioned default value of POINTER of PanelPropLine.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			prop_default = PanelPropLine.conditioning(prop, PanelPropLine.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropLine, PROP, VALUE) checks VALUE format for PROP of PanelPropLine.
			%  CHECK = PR.CHECKPROP(PanelPropLine, PROP, VALUE) checks VALUE format for PROP of PanelPropLine.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropLine:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropLine:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropLine.
			%   Error id: €BRAPH2.STR€:PanelPropLine:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropLine.
			%   Error id: €BRAPH2.STR€:PanelPropLine:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropLine.getPropProp(pointer);
			
			switch prop
				case PanelPropLine.DROPDOWN % __PanelPropLine.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.AXES % __PanelPropLine.AXES__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.LN % __PanelPropLine.LN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropLine.getPropSettings(prop));
				case PanelPropLine.TEMPLATE % __PanelPropLine.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropLine.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropLine.getPropTag(prop) ' (' PanelPropLine.getFormatTag(PanelPropLine.getPropFormat(prop)) ').'] ...
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
				case PanelPropLine.DROPDOWN % __PanelPropLine.DROPDOWN__
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
					
				case PanelPropLine.AXES % __PanelPropLine.AXES__
					axes = uiaxes( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'AXES' ...
					    );
					axis(axes, 'off')
					axes.Toolbar.Visible = 'off';
					axes.Interactions = [];
					
					value = axes;
					
				case PanelPropLine.LN % __PanelPropLine.LN__
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
					
				case PanelPropLine.X_DRAW % __PanelPropLine.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					    pr.memorize('AXES')
					    pr.memorize('LN')
					end
					
				case PanelPropLine.UPDATE % __PanelPropLine.UPDATE__
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
					            set(pr.get('LN'), 'LineStyle', el.get(prop))
					            
					        case Category.METADATA
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            set(pr.get('LN'), 'LineStyle', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            set(pr.get('LN'), 'LineStyle', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
					                set(pr.get('LN'), 'LineStyle', el.getPropDefault(prop))
					            else
					                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					                set(pr.get('LN'), 'LineStyle', el.get(prop))
					            end
					            
					            set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case PanelPropLine.REDRAW % __PanelPropLine.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value 
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
					    set(pr.get('AXES'), 'InnerPosition', [s(.3)+.15*w_p+s(1.7) s(.3) .70*w_p s(1.7)])
					end
					
				case PanelPropLine.DELETE % __PanelPropLine.DELETE__
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
