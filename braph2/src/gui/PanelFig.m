classdef PanelFig < Panel
	%PanelFig plots the panel of a figure.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% A Figure Panel (PanelFig) plots a figure.
	% 
	% CONSTRUCTOR - To construct a PanelFig use, e.g.:
	% 
	%     pf = PanelFig('<strong>PARENT</strong>', <parent element>)
	%   
	%  where the <parent element> can be a GUI or a Panel, 
	%   but most often a GUIFig.
	%   
	% DRAW - To draw the panel, call:
	% 
	%     pf.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pf.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pf.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	%   
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pf.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pf.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pf.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pf.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%     pf.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
	%     pf.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.
	%
	% PanelFig methods (constructor):
	%  PanelFig - constructor
	%
	% PanelFig methods:
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
	% PanelFig methods (display):
	%  tostring - string with information about the figure panel
	%  disp - displays information about the figure panel
	%  tree - displays the tree of the figure panel
	%
	% PanelFig methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two figure panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the figure panel
	%
	% PanelFig methods (save/load, Static):
	%  save - saves BRAPH2 figure panel as b2 file
	%  load - loads a BRAPH2 figure panel from a b2 file
	%
	% PanelFig method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the figure panel
	%
	% PanelFig method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the figure panel
	%
	% PanelFig methods (inspection, Static):
	%  getClass - returns the class of the figure panel
	%  getSubclasses - returns all subclasses of PanelFig
	%  getProps - returns the property list of the figure panel
	%  getPropNumber - returns the property number of the figure panel
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
	% PanelFig methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelFig methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelFig methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelFig methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelFig; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelFig constants</a>.
	%
	%
	% See also uipanel, GUIFig, Settings.
	
	properties (Constant) % properties
		ST_POSITION = Panel.getPropNumber() + 1;
		ST_POSITION_TAG = 'ST_POSITION';
		ST_POSITION_CATEGORY = Category.FIGURE;
		ST_POSITION_FORMAT = Format.ITEM;
		
		H_TOOLBAR = Panel.getPropNumber() + 2;
		H_TOOLBAR_TAG = 'H_TOOLBAR';
		H_TOOLBAR_CATEGORY = Category.EVANESCENT;
		H_TOOLBAR_FORMAT = Format.HANDLE;
		
		H_TOOLS = Panel.getPropNumber() + 3;
		H_TOOLS_TAG = 'H_TOOLS';
		H_TOOLS_CATEGORY = Category.EVANESCENT;
		H_TOOLS_FORMAT = Format.HANDLELIST;
	end
	methods % constructor
		function pf = PanelFig(varargin)
			%PanelFig() creates a figure panel.
			%
			% PanelFig(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelFig(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the figure panel.
			%
			% CLASS = PanelFig.GETCLASS() returns the class 'PanelFig'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the figure panel PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('PanelFig') returns 'PanelFig'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('PanelFig')
			%  are less computationally efficient.
			
			pf_class = 'PanelFig';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the figure panel.
			%
			% LIST = PanelFig.GETSUBCLASSES() returns all subclasses of 'PanelFig'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the figure panel PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('PanelFig') returns all subclasses of 'PanelFig'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('PanelFig')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelFig', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of figure panel.
			%
			% PROPS = PanelFig.GETPROPS() returns the property list of figure panel
			%  as a row vector.
			%
			% PROPS = PanelFig.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the figure panel PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('PanelFig'[, CATEGORY]) returns the property list of 'PanelFig'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Panel.getProps() ...
						PanelFig.ST_POSITION ...
						PanelFig.H_TOOLBAR ...
						PanelFig.H_TOOLS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Panel.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Panel.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Panel.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Panel.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Panel.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Panel.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Panel.getProps(Category.EVANESCENT) ...
						PanelFig.H_TOOLBAR ...
						PanelFig.H_TOOLS ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Panel.getProps(Category.FIGURE) ...
						PanelFig.ST_POSITION ...
						];
				case Category.GUI
					prop_list = [ ...
						Panel.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of figure panel.
			%
			% N = PanelFig.GETPROPNUMBER() returns the property number of figure panel.
			%
			% N = PanelFig.GETPROPNUMBER(CATEGORY) returns the property number of figure panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the figure panel PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('PanelFig') returns the property number of 'PanelFig'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelFig.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in figure panel/error.
			%
			% CHECK = PanelFig.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PanelFig, PROP) checks whether PROP exists for PanelFig.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSPROP(PanelFig, PROP) throws error if PROP does NOT exist for PanelFig.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelFig.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelFig.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in figure panel/error.
			%
			% CHECK = PanelFig.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PanelFig, TAG) checks whether TAG exists for PanelFig.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSTAG(PanelFig, TAG) throws error if TAG does NOT exist for PanelFig.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelfig_tag_list = cellfun(@(x) PanelFig.getPropTag(x), num2cell(PanelFig.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelfig_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelFig.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(PanelFig, POINTER) returns property number of POINTER of PanelFig.
			%  PROPERTY = PF.GETPROPPROP(PanelFig, POINTER) returns property number of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelfig_tag_list = cellfun(@(x) PanelFig.getPropTag(x), num2cell(PanelFig.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelfig_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(PanelFig, POINTER) returns tag of POINTER of PanelFig.
			%  TAG = PF.GETPROPTAG(PanelFig, POINTER) returns tag of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelFig.ST_POSITION
						tag = PanelFig.ST_POSITION_TAG;
					case PanelFig.H_TOOLBAR
						tag = PanelFig.H_TOOLBAR_TAG;
					case PanelFig.H_TOOLS
						tag = PanelFig.H_TOOLS_TAG;
					otherwise
						tag = getPropTag@Panel(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(PanelFig, POINTER) returns category of POINTER of PanelFig.
			%  CATEGORY = PF.GETPROPCATEGORY(PanelFig, POINTER) returns category of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('PanelFig')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION
					prop_category = PanelFig.ST_POSITION_CATEGORY;
				case PanelFig.H_TOOLBAR
					prop_category = PanelFig.H_TOOLBAR_CATEGORY;
				case PanelFig.H_TOOLS
					prop_category = PanelFig.H_TOOLS_CATEGORY;
				otherwise
					prop_category = getPropCategory@Panel(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(PanelFig, POINTER) returns format of POINTER of PanelFig.
			%  FORMAT = PF.GETPROPFORMAT(PanelFig, POINTER) returns format of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('PanelFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION
					prop_format = PanelFig.ST_POSITION_FORMAT;
				case PanelFig.H_TOOLBAR
					prop_format = PanelFig.H_TOOLBAR_FORMAT;
				case PanelFig.H_TOOLS
					prop_format = PanelFig.H_TOOLS_FORMAT;
				otherwise
					prop_format = getPropFormat@Panel(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelFig, POINTER) returns description of POINTER of PanelFig.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(PanelFig, POINTER) returns description of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION
					prop_description = 'ST_POSITION (figure, item) determines the panel position.';
				case PanelFig.H_TOOLBAR
					prop_description = 'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.';
				case PanelFig.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.';
				case PanelFig.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the figure panel.';
				case PanelFig.NAME
					prop_description = 'NAME (constant, string) is the name of the figure panel.';
				case PanelFig.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the figure panel.';
				case PanelFig.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the figure panel.';
				case PanelFig.ID
					prop_description = 'ID (data, string) is a few-letter code for the figure panel.';
				case PanelFig.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the figure panel.';
				case PanelFig.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the figure panel.';
				case PanelFig.BKGCOLOR
					prop_description = 'BKGCOLOR (figure, color) is the panel background color.';
				case PanelFig.DRAW
					prop_description = 'DRAW (query, logical) draws the figure panel.';
				case PanelFig.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the figure panel is deleted.';
				otherwise
					prop_description = getPropDescription@Panel(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(PanelFig, POINTER) returns settings of POINTER of PanelFig.
			%  SETTINGS = PF.GETPROPSETTINGS(PanelFig, POINTER) returns settings of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION
					prop_settings = 'SettingsPosition';
				case PanelFig.H_TOOLBAR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelFig.H_TOOLS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PanelFig.TEMPLATE
					prop_settings = 'PanelFig';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelFig, POINTER) returns the default value of POINTER of PanelFig.
			%  DEFAULT = PF.GETPROPDEFAULT(PanelFig, POINTER) returns the default value of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION
					prop_default = Format.getFormatDefault(Format.ITEM, PanelFig.getPropSettings(prop));
				case PanelFig.H_TOOLBAR
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelFig.getPropSettings(prop));
				case PanelFig.H_TOOLS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PanelFig.getPropSettings(prop));
				case PanelFig.ELCLASS
					prop_default = 'PanelFig';
				case PanelFig.NAME
					prop_default = 'Figure Panel';
				case PanelFig.DESCRIPTION
					prop_default = 'A Figure Panel (PanelFig) plots a figure.';
				case PanelFig.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelFig.getPropSettings(prop));
				case PanelFig.ID
					prop_default = 'PanelFig ID';
				case PanelFig.LABEL
					prop_default = 'PanelFig label';
				case PanelFig.NOTES
					prop_default = 'PanelFig notes';
				case PanelFig.BKGCOLOR
					prop_default = [1 1 1];
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelFig, POINTER) returns the conditioned default value of POINTER of PanelFig.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(PanelFig, POINTER) returns the conditioned default value of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('PanelFig')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			prop_default = PanelFig.conditioning(prop, PanelFig.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(PanelFig, PROP, VALUE) checks VALUE format for PROP of PanelFig.
			%  CHECK = PF.CHECKPROP(PanelFig, PROP, VALUE) checks VALUE format for PROP of PanelFig.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelFig:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:PanelFig:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelFig.
			%   Error id: €BRAPH2.STR€:PanelFig:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(PanelFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelFig.
			%   Error id: €BRAPH2.STR€:PanelFig:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case PanelFig.ST_POSITION % __PanelFig.ST_POSITION__
					check = Format.checkFormat(Format.ITEM, value, PanelFig.getPropSettings(prop));
				case PanelFig.H_TOOLBAR % __PanelFig.H_TOOLBAR__
					check = Format.checkFormat(Format.HANDLE, value, PanelFig.getPropSettings(prop));
				case PanelFig.H_TOOLS % __PanelFig.H_TOOLS__
					check = Format.checkFormat(Format.HANDLELIST, value, PanelFig.getPropSettings(prop));
				case PanelFig.TEMPLATE % __PanelFig.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelFig.getPropSettings(prop));
				otherwise
					if prop <= Panel.getPropNumber()
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelFig.getPropTag(prop) ' (' PanelFig.getFormatTag(PanelFig.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case PanelFig.H_TOOLBAR % __PanelFig.H_TOOLBAR__
					value = findobj(ancestor(pf.memorize('PARENT').memorize('H'), 'Figure'), 'Tag', 'TOOLBAR');
					
				case PanelFig.H_TOOLS % __PanelFig.H_TOOLS__
					value = {};
					
				case PanelFig.DRAW % __PanelFig.DRAW__
					if check_graphics(pf.memorize('H'), 'uipanel') % H = p for panel
					    
					    pf.memorize('ST_POSITION').set('PANEL', pf, 'PROP', pf.H).get('SETUP')
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pf)], ...
					        [BRAPH2.STR ':' class(pf) '\n' ...
					        'The call pf.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelFig.DELETE % __PanelFig.DELETE__
					value = calculateValue@Panel(pf, Panel.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_TOOLBAR', Element.getNoValue())
					    pf.set('H_TOOLS', Element.getNoValue())
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						value = calculateValue@Panel(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case PanelFig.ST_POSITION % __PanelFig.ST_POSITION__
					pr = SettingsPositionPP('EL', pf, 'PROP', PanelFig.ST_POSITION, varargin{:});
					
				otherwise
					pr = getPanelProp@Panel(pf, prop, varargin{:});
					
			end
		end
	end
end
