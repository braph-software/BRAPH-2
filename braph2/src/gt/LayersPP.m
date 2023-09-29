classdef LayersPP < PanelProp
	%LayersPP plots the panel to select the layers of an adjacency matrix.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Layers Prop Panel (LayersPP) plots the panel to select the layers of an adjacency matrix.
	% It works for all categories.
	%
	% LayersPP methods (constructor):
	%  LayersPP - constructor
	%
	% LayersPP methods:
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
	% LayersPP methods (display):
	%  tostring - string with information about the layers prop panel
	%  disp - displays information about the layers prop panel
	%  tree - displays the tree of the layers prop panel
	%
	% LayersPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two layers prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the layers prop panel
	%
	% LayersPP methods (save/load, Static):
	%  save - saves BRAPH2 layers prop panel as b2 file
	%  load - loads a BRAPH2 layers prop panel from a b2 file
	%
	% LayersPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the layers prop panel
	%
	% LayersPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the layers prop panel
	%
	% LayersPP methods (inspection, Static):
	%  getClass - returns the class of the layers prop panel
	%  getSubclasses - returns all subclasses of LayersPP
	%  getProps - returns the property list of the layers prop panel
	%  getPropNumber - returns the property number of the layers prop panel
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
	% LayersPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% LayersPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% LayersPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% LayersPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?LayersPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">LayersPP constants</a>.
	%
	%
	% See also uitable, GraphHistPF, GraphAdjPF..
	
	properties (Constant) % properties
		G_PROP = PanelProp.getPropNumber() + 1;
		G_PROP_TAG = 'G_PROP';
		G_PROP_CATEGORY = Category.DATA;
		G_PROP_FORMAT = Format.SCALAR;
		
		ENABLE = PanelProp.getPropNumber() + 2;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 3;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 4;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 5;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		TABLE = PanelProp.getPropNumber() + 6;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = LayersPP(varargin)
			%LayersPP() creates a layers prop panel.
			%
			% LayersPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% LayersPP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the layers prop panel.
			%
			% CLASS = LayersPP.GETCLASS() returns the class 'LayersPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the layers prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('LayersPP') returns 'LayersPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('LayersPP')
			%  are less computationally efficient.
			
			pr_class = 'LayersPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the layers prop panel.
			%
			% LIST = LayersPP.GETSUBCLASSES() returns all subclasses of 'LayersPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the layers prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('LayersPP') returns all subclasses of 'LayersPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('LayersPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('LayersPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of layers prop panel.
			%
			% PROPS = LayersPP.GETPROPS() returns the property list of layers prop panel
			%  as a row vector.
			%
			% PROPS = LayersPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the layers prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('LayersPP'[, CATEGORY]) returns the property list of 'LayersPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						LayersPP.G_PROP ...
						LayersPP.ENABLE ...
						LayersPP.ROWNAME ...
						LayersPP.COLUMNNAME ...
						LayersPP.TABLE_HEIGHT ...
						LayersPP.TABLE ...
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
						LayersPP.G_PROP ...
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
						LayersPP.TABLE ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						LayersPP.ENABLE ...
						LayersPP.ROWNAME ...
						LayersPP.COLUMNNAME ...
						LayersPP.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of layers prop panel.
			%
			% N = LayersPP.GETPROPNUMBER() returns the property number of layers prop panel.
			%
			% N = LayersPP.GETPROPNUMBER(CATEGORY) returns the property number of layers prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the layers prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('LayersPP') returns the property number of 'LayersPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('LayersPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(LayersPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in layers prop panel/error.
			%
			% CHECK = LayersPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(LayersPP, PROP) checks whether PROP exists for LayersPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:LayersPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%  Element.EXISTSPROP(LayersPP, PROP) throws error if PROP does NOT exist for LayersPP.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('LayersPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == LayersPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for LayersPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in layers prop panel/error.
			%
			% CHECK = LayersPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(LayersPP, TAG) checks whether TAG exists for LayersPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:LayersPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%  Element.EXISTSTAG(LayersPP, TAG) throws error if TAG does NOT exist for LayersPP.
			%   Error id: [BRAPH2:LayersPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('LayersPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			layerspp_tag_list = cellfun(@(x) LayersPP.getPropTag(x), num2cell(LayersPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, layerspp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for LayersPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(LayersPP, POINTER) returns property number of POINTER of LayersPP.
			%  PROPERTY = PR.GETPROPPROP(LayersPP, POINTER) returns property number of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				layerspp_tag_list = cellfun(@(x) LayersPP.getPropTag(x), num2cell(LayersPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, layerspp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(LayersPP, POINTER) returns tag of POINTER of LayersPP.
			%  TAG = PR.GETPROPTAG(LayersPP, POINTER) returns tag of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case LayersPP.G_PROP
						tag = LayersPP.G_PROP_TAG;
					case LayersPP.ENABLE
						tag = LayersPP.ENABLE_TAG;
					case LayersPP.ROWNAME
						tag = LayersPP.ROWNAME_TAG;
					case LayersPP.COLUMNNAME
						tag = LayersPP.COLUMNNAME_TAG;
					case LayersPP.TABLE_HEIGHT
						tag = LayersPP.TABLE_HEIGHT_TAG;
					case LayersPP.TABLE
						tag = LayersPP.TABLE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(LayersPP, POINTER) returns category of POINTER of LayersPP.
			%  CATEGORY = PR.GETPROPCATEGORY(LayersPP, POINTER) returns category of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('LayersPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP
					prop_category = LayersPP.G_PROP_CATEGORY;
				case LayersPP.ENABLE
					prop_category = LayersPP.ENABLE_CATEGORY;
				case LayersPP.ROWNAME
					prop_category = LayersPP.ROWNAME_CATEGORY;
				case LayersPP.COLUMNNAME
					prop_category = LayersPP.COLUMNNAME_CATEGORY;
				case LayersPP.TABLE_HEIGHT
					prop_category = LayersPP.TABLE_HEIGHT_CATEGORY;
				case LayersPP.TABLE
					prop_category = LayersPP.TABLE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(LayersPP, POINTER) returns format of POINTER of LayersPP.
			%  FORMAT = PR.GETPROPFORMAT(LayersPP, POINTER) returns format of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('LayersPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP
					prop_format = LayersPP.G_PROP_FORMAT;
				case LayersPP.ENABLE
					prop_format = LayersPP.ENABLE_FORMAT;
				case LayersPP.ROWNAME
					prop_format = LayersPP.ROWNAME_FORMAT;
				case LayersPP.COLUMNNAME
					prop_format = LayersPP.COLUMNNAME_FORMAT;
				case LayersPP.TABLE_HEIGHT
					prop_format = LayersPP.TABLE_HEIGHT_FORMAT;
				case LayersPP.TABLE
					prop_format = LayersPP.TABLE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(LayersPP, POINTER) returns description of POINTER of LayersPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(LayersPP, POINTER) returns description of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP
					prop_description = 'G_PROP (data, scalar) is the graph property number.';
				case LayersPP.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case LayersPP.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case LayersPP.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case LayersPP.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case LayersPP.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case LayersPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel to select the layers of an adjacency matrix.';
				case LayersPP.NAME
					prop_description = 'NAME (constant, string) is the name of the panel to select the layers of an adjacency matrix.';
				case LayersPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel to select the layers of an adjacency matrix.';
				case LayersPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel to select the layers of an adjacency matrix.';
				case LayersPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel to select the layers of an adjacency matrix.';
				case LayersPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel to select the layers of an adjacency matrix.';
				case LayersPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel to select the layers of an adjacency matrix.';
				case LayersPP.EL
					prop_description = 'EL (data, item) is the element.';
				case LayersPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case LayersPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case LayersPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case LayersPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case LayersPP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(LayersPP, POINTER) returns settings of POINTER of LayersPP.
			%  SETTINGS = PR.GETPROPSETTINGS(LayersPP, POINTER) returns settings of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case LayersPP.ENABLE
					prop_settings = {'on', 'off'};
				case LayersPP.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case LayersPP.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case LayersPP.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case LayersPP.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case LayersPP.TEMPLATE
					prop_settings = 'LayersPP';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = LayersPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = LayersPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(LayersPP, POINTER) returns the default value of POINTER of LayersPP.
			%  DEFAULT = PR.GETPROPDEFAULT(LayersPP, POINTER) returns the default value of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('LayersPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP
					prop_default = GraphHistPF.G;
				case LayersPP.ENABLE
					prop_default = 'on';
				case LayersPP.ROWNAME
					prop_default = {'numbered'};
				case LayersPP.COLUMNNAME
					prop_default = {'numbered'};
				case LayersPP.TABLE_HEIGHT
					prop_default = s(20);
				case LayersPP.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, LayersPP.getPropSettings(prop));
				case LayersPP.ELCLASS
					prop_default = 'LayersPP';
				case LayersPP.NAME
					prop_default = 'Layers Prop Panel';
				case LayersPP.DESCRIPTION
					prop_default = 'A Layers Prop Panel (LayersPP) plots the panel to select the layers of an adjacency matrix.';
				case LayersPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, LayersPP.getPropSettings(prop));
				case LayersPP.ID
					prop_default = 'LayersPP ID';
				case LayersPP.LABEL
					prop_default = 'LayersPP label';
				case LayersPP.NOTES
					prop_default = 'LayersPP notes';
				case LayersPP.EL
					prop_default = GraphHistPF();
				case LayersPP.PROP
					prop_default = GraphHistPF.LAYERS;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = LayersPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = LayersPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(LayersPP, POINTER) returns the conditioned default value of POINTER of LayersPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(LayersPP, POINTER) returns the conditioned default value of POINTER of LayersPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('LayersPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = LayersPP.getPropProp(pointer);
			
			prop_default = LayersPP.conditioning(prop, LayersPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(LayersPP, PROP, VALUE) checks VALUE format for PROP of LayersPP.
			%  CHECK = PR.CHECKPROP(LayersPP, PROP, VALUE) checks VALUE format for PROP of LayersPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:LayersPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:LayersPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(LayersPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of LayersPP.
			%   Error id: €BRAPH2.STR€:LayersPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(LayersPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of LayersPP.
			%   Error id: €BRAPH2.STR€:LayersPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('LayersPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = LayersPP.getPropProp(pointer);
			
			switch prop
				case LayersPP.G_PROP % __LayersPP.G_PROP__
					check = Format.checkFormat(Format.SCALAR, value, LayersPP.getPropSettings(prop));
				case LayersPP.ENABLE % __LayersPP.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, LayersPP.getPropSettings(prop));
				case LayersPP.ROWNAME % __LayersPP.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, LayersPP.getPropSettings(prop));
				case LayersPP.COLUMNNAME % __LayersPP.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, LayersPP.getPropSettings(prop));
				case LayersPP.TABLE_HEIGHT % __LayersPP.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, LayersPP.getPropSettings(prop));
				case LayersPP.TABLE % __LayersPP.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, LayersPP.getPropSettings(prop));
				case LayersPP.TEMPLATE % __LayersPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, LayersPP.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LayersPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' LayersPP.getPropTag(prop) ' (' LayersPP.getFormatTag(LayersPP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
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
				case LayersPP.G_PROP % __LayersPP.G_PROP__
					pr.lock('G_PROP', 'Iterative', false)
					
				case LayersPP.ROWNAME % __LayersPP.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case LayersPP.COLUMNNAME % __LayersPP.COLUMNNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						postset@PanelProp(pr, prop);
					end
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
				case LayersPP.TABLE % __LayersPP.TABLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TABLE', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					value = table;
					
				case LayersPP.X_DRAW % __LayersPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					end
					
				case LayersPP.UPDATE % __LayersPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    g = el.get(pr.get('G_PROP'));
					    
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        pr.set('HEIGHT', min(s(4.5) + s(2) * g.get('LAYERNUMBER'), pr.get('TABLE_HEIGHT')))
					    end
					
					    if isa(pr.getr('ROWNAME'), 'NoValue')
					        rowname = g.get('ALAYERLABELS');
					    else
					        rowname = pr.get('ROWNAME');
					    end
					    if isequal(rowname, {'numbered'})
					        rowname = 'numbered';
					    end
					    if isa(pr.getr('COLUMNNAME'), 'NoValue')
					        columnname = g.get('ALAYERLABELS');
					    else
					        columnname = pr.get('COLUMNNAME');
					    end
					    if isequal(columnname, {'numbered'})
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('TABLE'), ...
					                'Data', cb_table_data(el.get(prop)), ...
					                'ColumnEditable', false ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('TABLE'), ...
					                'Data', cb_table_data(el.get(prop)), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('TABLE'), ...
					                'Data', cb_table_data(el.get(prop)), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('TABLE'), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                % don't plot anything for a result not yet calculated
					                set(pr.get('TABLE'), 'Visible', 'off')
					            else
					                set(pr.get('TABLE'), ...
					                    'Data', cb_table_data(el.get(prop)), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false, ...
					                    'Visible', 'on' ...
					                    )
					            end
					    end
					end
					
				case LayersPP.REDRAW % __LayersPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case LayersPP.DELETE % __LayersPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    el.set(prop, event.Indices)
			end
			function data = cb_table_data(indices)
			    g = pr.get('EL').get(pr.get('G_PROP'));
			    data = false(g.get('LAYERNUMBER'));
			    
			    data(indices(1), indices(2)) = true;
			end
		end
	end
end
