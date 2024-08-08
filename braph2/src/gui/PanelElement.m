classdef PanelElement < Panel
	%PanelElement plots the panel of an element.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% An Element Panel (PanelElement) plots all properties of an element in a panel, 
	%  which contains a series of stacked property panels,
	%  one for each property of the element EL being plotted.
	% 
	% CONSTRUCTOR - To construct a PanelElement use, e.g.:
	% 
	%     pe = PanelElement('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
	%   
	%  where the <parent element> can be a GUI or a Panel, 
	%   but most often a GUIElement.
	%   
	% DRAW - To draw the panel, call:
	% 
	%     pe.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pe.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	%   
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pe.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pe.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pe.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pe.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%     pe.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
	%     pe.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.
	%
	% PanelElement methods (constructor):
	%  PanelElement - constructor
	%
	% PanelElement methods:
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
	% PanelElement methods (display):
	%  tostring - string with information about the element panel
	%  disp - displays information about the element panel
	%  tree - displays the tree of the element panel
	%
	% PanelElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two element panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the element panel
	%
	% PanelElement methods (save/load, Static):
	%  save - saves BRAPH2 element panel as b2 file
	%  load - loads a BRAPH2 element panel from a b2 file
	%
	% PanelElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the element panel
	%
	% PanelElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the element panel
	%
	% PanelElement methods (inspection, Static):
	%  getClass - returns the class of the element panel
	%  getSubclasses - returns all subclasses of PanelElement
	%  getProps - returns the property list of the element panel
	%  getPropNumber - returns the property number of the element panel
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
	% PanelElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelElement constants</a>.
	%
	%
	% See also uigridlayout, GUI, GUIElement, PanelProp.
	
	properties (Constant) % properties
		EL = Panel.getPropNumber() + 1;
		EL_TAG = 'EL';
		EL_CATEGORY = Category.DATA;
		EL_FORMAT = Format.ITEM;
		
		PR_ORDER = Panel.getPropNumber() + 2;
		PR_ORDER_TAG = 'PR_ORDER';
		PR_ORDER_CATEGORY = Category.GUI;
		PR_ORDER_FORMAT = Format.RVECTOR;
		
		PR_TITLE = Panel.getPropNumber() + 3;
		PR_TITLE_TAG = 'PR_TITLE';
		PR_TITLE_CATEGORY = Category.GUI;
		PR_TITLE_FORMAT = Format.STRINGLIST;
		
		PR_VISIBLE = Panel.getPropNumber() + 4;
		PR_VISIBLE_TAG = 'PR_VISIBLE';
		PR_VISIBLE_CATEGORY = Category.GUI;
		PR_VISIBLE_FORMAT = Format.RVECTOR;
		
		PR_DICT = Panel.getPropNumber() + 5;
		PR_DICT_TAG = 'PR_DICT';
		PR_DICT_CATEGORY = Category.RESULT;
		PR_DICT_FORMAT = Format.IDICT;
		
		MIN_WIDTH = Panel.getPropNumber() + 6;
		MIN_WIDTH_TAG = 'MIN_WIDTH';
		MIN_WIDTH_CATEGORY = Category.GUI;
		MIN_WIDTH_FORMAT = Format.SIZE;
		
		RESIZEX = Panel.getPropNumber() + 7;
		RESIZEX_TAG = 'RESIZEX';
		RESIZEX_CATEGORY = Category.QUERY;
		RESIZEX_FORMAT = Format.LOGICAL;
		
		RESIZEY = Panel.getPropNumber() + 8;
		RESIZEY_TAG = 'RESIZEY';
		RESIZEY_CATEGORY = Category.QUERY;
		RESIZEY_FORMAT = Format.LOGICAL;
		
		LISTENER_PPHEIGHT = Panel.getPropNumber() + 9;
		LISTENER_PPHEIGHT_TAG = 'LISTENER_PPHEIGHT';
		LISTENER_PPHEIGHT_CATEGORY = Category.EVANESCENT;
		LISTENER_PPHEIGHT_FORMAT = Format.HANDLELIST;
	end
	methods % constructor
		function pe = PanelElement(varargin)
			%PanelElement() creates a element panel.
			%
			% PanelElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelElement(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pe = pe@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function pe_class = getClass()
			%GETCLASS returns the class of the element panel.
			%
			% CLASS = PanelElement.GETCLASS() returns the class 'PanelElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PE.GETCLASS() returns the class of the element panel PE.
			%  CLASS = Element.GETCLASS(PE) returns the class of 'PE'.
			%  CLASS = Element.GETCLASS('PanelElement') returns 'PanelElement'.
			%
			% Note that the Element.GETCLASS(PE) and Element.GETCLASS('PanelElement')
			%  are less computationally efficient.
			
			pe_class = 'PanelElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the element panel.
			%
			% LIST = PanelElement.GETSUBCLASSES() returns all subclasses of 'PanelElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = PE.GETSUBCLASSES() returns all subclasses of the element panel PE.
			%  LIST = Element.GETSUBCLASSES(PE) returns all subclasses of 'PE'.
			%  LIST = Element.GETSUBCLASSES('PanelElement') returns all subclasses of 'PanelElement'.
			%
			% Note that the Element.GETSUBCLASSES(PE) and Element.GETSUBCLASSES('PanelElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelElement', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of element panel.
			%
			% PROPS = PanelElement.GETPROPS() returns the property list of element panel
			%  as a row vector.
			%
			% PROPS = PanelElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PE.GETPROPS([CATEGORY]) returns the property list of the element panel PE.
			%  PROPS = Element.GETPROPS(PE[, CATEGORY]) returns the property list of 'PE'.
			%  PROPS = Element.GETPROPS('PanelElement'[, CATEGORY]) returns the property list of 'PanelElement'.
			%
			% Note that the Element.GETPROPS(PE) and Element.GETPROPS('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Panel.getProps() ...
						PanelElement.EL ...
						PanelElement.PR_ORDER ...
						PanelElement.PR_TITLE ...
						PanelElement.PR_VISIBLE ...
						PanelElement.PR_DICT ...
						PanelElement.MIN_WIDTH ...
						PanelElement.RESIZEX ...
						PanelElement.RESIZEY ...
						PanelElement.LISTENER_PPHEIGHT ...
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
						PanelElement.EL ...
						];
				case Category.RESULT
					prop_list = [
						Panel.getProps(Category.RESULT) ...
						PanelElement.PR_DICT ...
						];
				case Category.QUERY
					prop_list = [ ...
						Panel.getProps(Category.QUERY) ...
						PanelElement.RESIZEX ...
						PanelElement.RESIZEY ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Panel.getProps(Category.EVANESCENT) ...
						PanelElement.LISTENER_PPHEIGHT ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Panel.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Panel.getProps(Category.GUI) ...
						PanelElement.PR_ORDER ...
						PanelElement.PR_TITLE ...
						PanelElement.PR_VISIBLE ...
						PanelElement.MIN_WIDTH ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of element panel.
			%
			% N = PanelElement.GETPROPNUMBER() returns the property number of element panel.
			%
			% N = PanelElement.GETPROPNUMBER(CATEGORY) returns the property number of element panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PE.GETPROPNUMBER([CATEGORY]) returns the property number of the element panel PE.
			%  N = Element.GETPROPNUMBER(PE) returns the property number of 'PE'.
			%  N = Element.GETPROPNUMBER('PanelElement') returns the property number of 'PanelElement'.
			%
			% Note that the Element.GETPROPNUMBER(PE) and Element.GETPROPNUMBER('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelElement.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in element panel/error.
			%
			% CHECK = PanelElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSPROP(PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PE, PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PanelElement, PROP) checks whether PROP exists for PanelElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSPROP(PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSPROP(PE, PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSPROP(PanelElement, PROP) throws error if PROP does NOT exist for PanelElement.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PE) and Element.EXISTSPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelElement.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in element panel/error.
			%
			% CHECK = PanelElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSTAG(TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PE, TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PanelElement, TAG) checks whether TAG exists for PanelElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSTAG(TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSTAG(PE, TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSTAG(PanelElement, TAG) throws error if TAG does NOT exist for PanelElement.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PE) and Element.EXISTSTAG('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelelement_tag_list = cellfun(@(x) PanelElement.getPropTag(x), num2cell(PanelElement.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelelement_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelElement.'] ...
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
			%  PROPERTY = PE.GETPROPPROP(POINTER) returns property number of POINTER of PE.
			%  PROPERTY = Element.GETPROPPROP(PanelElement, POINTER) returns property number of POINTER of PanelElement.
			%  PROPERTY = PE.GETPROPPROP(PanelElement, POINTER) returns property number of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPPROP(PE) and Element.GETPROPPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelelement_tag_list = cellfun(@(x) PanelElement.getPropTag(x), num2cell(PanelElement.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelelement_tag_list)); % tag = pointer
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
			%  TAG = PE.GETPROPTAG(POINTER) returns tag of POINTER of PE.
			%  TAG = Element.GETPROPTAG(PanelElement, POINTER) returns tag of POINTER of PanelElement.
			%  TAG = PE.GETPROPTAG(PanelElement, POINTER) returns tag of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPTAG(PE) and Element.GETPROPTAG('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelElement.EL
						tag = PanelElement.EL_TAG;
					case PanelElement.PR_ORDER
						tag = PanelElement.PR_ORDER_TAG;
					case PanelElement.PR_TITLE
						tag = PanelElement.PR_TITLE_TAG;
					case PanelElement.PR_VISIBLE
						tag = PanelElement.PR_VISIBLE_TAG;
					case PanelElement.PR_DICT
						tag = PanelElement.PR_DICT_TAG;
					case PanelElement.MIN_WIDTH
						tag = PanelElement.MIN_WIDTH_TAG;
					case PanelElement.RESIZEX
						tag = PanelElement.RESIZEX_TAG;
					case PanelElement.RESIZEY
						tag = PanelElement.RESIZEY_TAG;
					case PanelElement.LISTENER_PPHEIGHT
						tag = PanelElement.LISTENER_PPHEIGHT_TAG;
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
			%  CATEGORY = PE.GETPROPCATEGORY(POINTER) returns category of POINTER of PE.
			%  CATEGORY = Element.GETPROPCATEGORY(PanelElement, POINTER) returns category of POINTER of PanelElement.
			%  CATEGORY = PE.GETPROPCATEGORY(PanelElement, POINTER) returns category of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPCATEGORY(PE) and Element.GETPROPCATEGORY('PanelElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL
					prop_category = PanelElement.EL_CATEGORY;
				case PanelElement.PR_ORDER
					prop_category = PanelElement.PR_ORDER_CATEGORY;
				case PanelElement.PR_TITLE
					prop_category = PanelElement.PR_TITLE_CATEGORY;
				case PanelElement.PR_VISIBLE
					prop_category = PanelElement.PR_VISIBLE_CATEGORY;
				case PanelElement.PR_DICT
					prop_category = PanelElement.PR_DICT_CATEGORY;
				case PanelElement.MIN_WIDTH
					prop_category = PanelElement.MIN_WIDTH_CATEGORY;
				case PanelElement.RESIZEX
					prop_category = PanelElement.RESIZEX_CATEGORY;
				case PanelElement.RESIZEY
					prop_category = PanelElement.RESIZEY_CATEGORY;
				case PanelElement.LISTENER_PPHEIGHT
					prop_category = PanelElement.LISTENER_PPHEIGHT_CATEGORY;
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
			%  FORMAT = PE.GETPROPFORMAT(POINTER) returns format of POINTER of PE.
			%  FORMAT = Element.GETPROPFORMAT(PanelElement, POINTER) returns format of POINTER of PanelElement.
			%  FORMAT = PE.GETPROPFORMAT(PanelElement, POINTER) returns format of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPFORMAT(PE) and Element.GETPROPFORMAT('PanelElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL
					prop_format = PanelElement.EL_FORMAT;
				case PanelElement.PR_ORDER
					prop_format = PanelElement.PR_ORDER_FORMAT;
				case PanelElement.PR_TITLE
					prop_format = PanelElement.PR_TITLE_FORMAT;
				case PanelElement.PR_VISIBLE
					prop_format = PanelElement.PR_VISIBLE_FORMAT;
				case PanelElement.PR_DICT
					prop_format = PanelElement.PR_DICT_FORMAT;
				case PanelElement.MIN_WIDTH
					prop_format = PanelElement.MIN_WIDTH_FORMAT;
				case PanelElement.RESIZEX
					prop_format = PanelElement.RESIZEX_FORMAT;
				case PanelElement.RESIZEY
					prop_format = PanelElement.RESIZEY_FORMAT;
				case PanelElement.LISTENER_PPHEIGHT
					prop_format = PanelElement.LISTENER_PPHEIGHT_FORMAT;
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
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelElement, POINTER) returns description of POINTER of PanelElement.
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(PanelElement, POINTER) returns description of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(PE) and Element.GETPROPDESCRIPTION('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL
					prop_description = 'EL (data, item) is the element to be plotted.';
				case PanelElement.PR_ORDER
					prop_description = 'PR_ORDER (gui, rvector) is the order of the property plots.';
				case PanelElement.PR_TITLE
					prop_description = 'PR_TITLE (gui, stringlist) is the list of property plot titles.';
				case PanelElement.PR_VISIBLE
					prop_description = 'PR_VISIBLE (gui, rvector) is the list of visible property plots.';
				case PanelElement.PR_DICT
					prop_description = 'PR_DICT (result, idict) is a dictionary of the property plots.';
				case PanelElement.MIN_WIDTH
					prop_description = 'MIN_WIDTH (gui, size) is the minimal panel width in pixels.';
				case PanelElement.RESIZEX
					prop_description = 'RESIZEX (query, logical) resizes the x-extension of the element panel and its prop panels.';
				case PanelElement.RESIZEY
					prop_description = 'RESIZEY (query, logical) resizes the y-extension of the element panel and its prop panels.';
				case PanelElement.LISTENER_PPHEIGHT
					prop_description = 'LISTENER_PPHEIGHT (evanescent, handlelist) contains the listeners to the PropSet events.';
				case PanelElement.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the element panel.';
				case PanelElement.NAME
					prop_description = 'NAME (constant, string) is the name of the element panel.';
				case PanelElement.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the element panel.';
				case PanelElement.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the element panel.';
				case PanelElement.ID
					prop_description = 'ID (data, string) is a few-letter code for the element panel.';
				case PanelElement.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the element panel.';
				case PanelElement.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the element panel.';
				case PanelElement.PARENT
					prop_description = 'PARENT (gui, item) is the panel parent.';
				case PanelElement.H
					prop_description = 'H (evanescent, handle) is the grid layout handle.';
				case PanelElement.H_WAITBAR
					prop_description = 'H_WAITBAR (evanescent, handle) is the waitbar handle.';
				case PanelElement.DRAW
					prop_description = 'DRAW (query, logical) draws the element panel.';
				case PanelElement.DRAWN
					prop_description = 'DRAWN (query, logical) returns whether the panel has been drawn.';
				case PanelElement.SHOW
					prop_description = 'SHOW (query, logical) brings to the front the figures dependent on the element panel.';
				case PanelElement.HIDE
					prop_description = 'HIDE (query, logical) hides the figures dependent on the element panel.';
				case PanelElement.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the element panel is deleted.';
				case PanelElement.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figures dependent on the element panel.';
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
			%  SETTINGS = PE.GETPROPSETTINGS(POINTER) returns settings of POINTER of PE.
			%  SETTINGS = Element.GETPROPSETTINGS(PanelElement, POINTER) returns settings of POINTER of PanelElement.
			%  SETTINGS = PE.GETPROPSETTINGS(PanelElement, POINTER) returns settings of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPSETTINGS(PE) and Element.GETPROPSETTINGS('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PanelElement.PR_ORDER
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PanelElement.PR_TITLE
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelElement.PR_VISIBLE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PanelElement.PR_DICT
					prop_settings = 'PanelProp';
				case PanelElement.MIN_WIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelElement.RESIZEX
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelElement.RESIZEY
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelElement.LISTENER_PPHEIGHT
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PanelElement.TEMPLATE
					prop_settings = 'PanelElement';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelElement, POINTER) returns the default value of POINTER of PanelElement.
			%  DEFAULT = PE.GETPROPDEFAULT(PanelElement, POINTER) returns the default value of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDEFAULT(PE) and Element.GETPROPDEFAULT('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PanelElement.getPropSettings(prop));
				case PanelElement.PR_ORDER
					prop_default = Format.getFormatDefault(Format.RVECTOR, PanelElement.getPropSettings(prop));
				case PanelElement.PR_TITLE
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelElement.getPropSettings(prop));
				case PanelElement.PR_VISIBLE
					prop_default = Format.getFormatDefault(Format.RVECTOR, PanelElement.getPropSettings(prop));
				case PanelElement.PR_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PanelElement.getPropSettings(prop));
				case PanelElement.MIN_WIDTH
					prop_default = 300;
				case PanelElement.RESIZEX
					prop_default = Format.getFormatDefault(Format.LOGICAL, PanelElement.getPropSettings(prop));
				case PanelElement.RESIZEY
					prop_default = Format.getFormatDefault(Format.LOGICAL, PanelElement.getPropSettings(prop));
				case PanelElement.LISTENER_PPHEIGHT
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PanelElement.getPropSettings(prop));
				case PanelElement.ELCLASS
					prop_default = 'PanelElement';
				case PanelElement.NAME
					prop_default = 'Element Panel';
				case PanelElement.DESCRIPTION
					prop_default = 'An Element Panel (PanelElement) plots all properties of an element in a panel, which contains a series of stacked property panels, one for each property of the element being plotted.';
				case PanelElement.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelElement.getPropSettings(prop));
				case PanelElement.ID
					prop_default = 'PanelElement ID';
				case PanelElement.LABEL
					prop_default = 'PanelElement label';
				case PanelElement.NOTES
					prop_default = 'PanelElement notes';
				case PanelElement.PARENT
					prop_default = GUI();
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelElement, POINTER) returns the conditioned default value of POINTER of PanelElement.
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(PanelElement, POINTER) returns the conditioned default value of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PE) and Element.GETPROPDEFAULTCONDITIONED('PanelElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			prop_default = PanelElement.conditioning(prop, PanelElement.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pe, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case PanelElement.PR_ORDER % __PanelElement.PR_ORDER__
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [value, ~, ~] = load_layout(pe.get('EL'));
					end
					
				case PanelElement.PR_TITLE % __PanelElement.PR_TITLE__
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [~, value, ~] = load_layout(pe.get('EL'));
					end
					
				case PanelElement.PR_VISIBLE % __PanelElement.PR_VISIBLE__
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [~, ~, value] = load_layout(pe.get('EL'));
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						value = preset@Panel(pe, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PE.
			%  CHECK = Element.CHECKPROP(PanelElement, PROP, VALUE) checks VALUE format for PROP of PanelElement.
			%  CHECK = PE.CHECKPROP(PanelElement, PROP, VALUE) checks VALUE format for PROP of PanelElement.
			% 
			% PE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelElement:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PE.
			%   Error id: €BRAPH2.STR€:PanelElement:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelElement.
			%   Error id: €BRAPH2.STR€:PanelElement:€BRAPH2.WRONG_INPUT€
			%  PE.CHECKPROP(PanelElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelElement.
			%   Error id: €BRAPH2.STR€:PanelElement:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PE) and Element.CHECKPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case PanelElement.EL % __PanelElement.EL__
					check = Format.checkFormat(Format.ITEM, value, PanelElement.getPropSettings(prop));
				case PanelElement.PR_ORDER % __PanelElement.PR_ORDER__
					check = Format.checkFormat(Format.RVECTOR, value, PanelElement.getPropSettings(prop));
				case PanelElement.PR_TITLE % __PanelElement.PR_TITLE__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelElement.getPropSettings(prop));
				case PanelElement.PR_VISIBLE % __PanelElement.PR_VISIBLE__
					check = Format.checkFormat(Format.RVECTOR, value, PanelElement.getPropSettings(prop));
				case PanelElement.PR_DICT % __PanelElement.PR_DICT__
					check = Format.checkFormat(Format.IDICT, value, PanelElement.getPropSettings(prop));
				case PanelElement.MIN_WIDTH % __PanelElement.MIN_WIDTH__
					check = Format.checkFormat(Format.SIZE, value, PanelElement.getPropSettings(prop));
				case PanelElement.RESIZEX % __PanelElement.RESIZEX__
					check = Format.checkFormat(Format.LOGICAL, value, PanelElement.getPropSettings(prop));
				case PanelElement.RESIZEY % __PanelElement.RESIZEY__
					check = Format.checkFormat(Format.LOGICAL, value, PanelElement.getPropSettings(prop));
				case PanelElement.LISTENER_PPHEIGHT % __PanelElement.LISTENER_PPHEIGHT__
					check = Format.checkFormat(Format.HANDLELIST, value, PanelElement.getPropSettings(prop));
				case PanelElement.TEMPLATE % __PanelElement.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelElement.getPropSettings(prop));
				case PanelElement.PARENT % __PanelElement.PARENT__
					check = Format.checkFormat(Format.ITEM, value, PanelElement.getPropSettings(prop));
					if check
						check = isa(value, 'GUI') || isa(value, 'Panel');
					end
				otherwise
					if prop <= Panel.getPropNumber()
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelElement.getPropTag(prop) ' (' PanelElement.getFormatTag(PanelElement.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pe, prop)
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
				case PanelElement.EL % __PanelElement.EL__
					pe.lock('EL', 'Iterative', false)
					
					[order, title, visible] = load_layout(pe.get('EL'));
					pe.set( ...
					    'PR_ORDER', order, ...
					    'PR_TITLE', title, ...
					    'PR_VISIBLE', visible ...
					    )
					
				case PanelElement.PARENT % __PanelElement.PARENT__
					if check_graphics(pe.getr('H'), 'uigridlayout') % H = gl for grid layout
					    set(pe.get('H'), 'Parent', pe.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						postset@Panel(pe, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pe, prop, varargin)
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
				case PanelElement.PR_DICT % __PanelElement.PR_DICT__
					rng_settings_ = rng(); rng(pe.getPropSeed(PanelElement.PR_DICT), 'twister')
					
					el = pe.get('EL');
					
					wb = pe.memorize('H_WAITBAR');
					
					order = pe.get('PR_ORDER');
					title = pe.get('PR_TITLE');
					visible = pe.get('PR_VISIBLE');
					
					pr_list = cell(1, sum(visible)); % sum(visible) = sum of visible prop
					for prop = 1:1:el.getPropNumber()
					    
					    braph2waitbar(wb, 0 + .5 * (prop - 1) / el.getPropNumber(), ['Analyzing prop ' int2str(prop) ' of ' int2str(el.getPropNumber())])
					
					    if visible(prop)
					        pr = el.getPanelProp(prop);
					        
					        if isa(pr.getr('PARENT'), 'NoValue')
					            pr.set('PARENT', pe)
					        end
					        
					        if strcmp(pr.get('TITLE'), pr.get('ID'))
					            pr.set('TITLE', title{prop})
					        end
					        
					        if isa(pr.getr('WAITBAR'), 'NoValue')
					            pr.set('WAITBAR', pe.getCallback(PanelElement.WAITBAR))
					        end
					        
					        pr_list{order(prop)} = pr;
					    end
					end
					
					value = IndexedDictionary( ...
					    'ID', el.get('TOSTRING'), ...
					    'IT_CLASS', 'PanelProp', ...
					    'IT_LIST', pr_list ...
					    );
					
					rng(rng_settings_)
					
				case PanelElement.RESIZEX % __PanelElement.RESIZEX__
					if pe.get('DRAWN')
					    pr_dict = pe.get('PR_DICT');
					    
					    column_width = max(pe.get('MIN_WIDTH'), w(pe.get('PARENT').get('H'), 'pixels') - 20);
					    set(pe.get('H'), 'ColumnWidth', {column_width})
					
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr_dict.get('IT', pri).get('REDRAW', 'Width', column_width)
					    end
					   
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''RESIZEX'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelElement.RESIZEY % __PanelElement.RESIZEY__
					if pe.get('DRAWN')
					    set(pe.get('H'), 'RowHeight', cellfun(@(pr) {pr.get('HEIGHT')}, pe.get('PR_DICT').get('IT_LIST')))
					
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''RESIZEY'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelElement.LISTENER_PPHEIGHT % __PanelElement.LISTENER_PPHEIGHT__
					value = cellfun(@(pr) listener(pr, 'PropSet', @cb_listener_ppheight), pe.get('PR_DICT').get('IT_LIST'), 'UniformOutput', false);
					
				case PanelElement.H % __PanelElement.H__
					gl = uigridlayout([pe.memorize('PR_DICT').get('LENGTH') 1], ... % set grid layout
					    'Parent', pe.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
					    'Tag', 'H', ...
					    'UserData', pe, ... % handle to retrieve the panel
					    'Scrollable', 'on', ...
					    'RowSpacing', 5, ...
					    'Padding', [5 s(1.5) 15 5], ...    
					    'BackgroundColor', pe.get('BKGCOLOR'), ...
					    'DeleteFcn', {@cb_get, 'DELETE'} ...
					    );
					value = gl;
					
				case PanelElement.H_WAITBAR % __PanelElement.H_WAITBAR__
					if pe.get('WAITBAR')
					    value = braph2waitbar(pe.get('WAITBAR'), 0, 'Drawing the element panel ...'); % wb
					else
					    value = gobjects(1);
					end
					
				case PanelElement.DRAW % __PanelElement.DRAW__
					if check_graphics(pe.memorize('H'), 'uigridlayout') % H = gl for grid layout
					    gl = pe.get('H');
					    
					    if ~isempty(varargin)
					        set(g, varargin{:})
					    end
					
						wb = pe.memorize('H_WAITBAR');
					    
					    pr_dict = pe.memorize('PR_DICT');
					    
					    for pri = 1:1:pr_dict.get('LENGTH')
					        braph2waitbar(wb, .5 + .5 * (pri - 1) / pr_dict.get('LENGTH'), ['Drawing prop panel ' int2str(pri) ' of ' int2str(pr_dict.get('LENGTH'))])
					        
					        pr = pr_dict.get('IT', pri);
					        pr.get('DRAW')
					    end
					    
					    pe.memorize('LISTENER_PPHEIGHT')
					    
					    braph2waitbar(wb, 'close')
					    pe.set('H_WAITBAR', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelElement.DRAWN % __PanelElement.DRAWN__
					value = check_graphics(pe.getr('H'), 'uigridlayout'); % H = gl for grid layout
					
				case PanelElement.SHOW % __PanelElement.SHOW__
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('SHOW', 'ShowParentFigure', false)
					    end
					
					    calculateValue@Panel(pe, Panel.SHOW, varargin{:});
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelElement.HIDE % __PanelElement.HIDE__
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('HIDE', 'HideParentFigure', false)
					    end
					
					    calculateValue@Panel(pe, Panel.HIDE, varargin{:});
					
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelElement.DELETE % __PanelElement.DELETE__
					value = calculateValue@Panel(pe, Panel.DELETE, varargin{:}); % also warning
					if value
					    pe.set('LISTENER_PPHEIGHT', Element.getNoValue())
					end
					
				case PanelElement.CLOSE % __PanelElement.CLOSE__
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('CLOSE', 'CloseParentFigure', false)
					    end
					    
					    calculateValue@Panel(pe, Panel.CLOSE, varargin{:});
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pe)], ...
					        [BRAPH2.STR ':' class(pe) '\n' ...
					        'The call pe.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						value = calculateValue@Panel(pe, prop, varargin{:});
					else
						value = calculateValue@Element(pe, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				pe.get(varargin{:})
			end
			function cb_listener_ppheight(~, event)
			    if ismember(PanelProp.HEIGHT, cell2mat(event.props)) && pe.get('DRAWN')
			        pe.get('RESIZEY')
			    end
			end
		end
	end
end
