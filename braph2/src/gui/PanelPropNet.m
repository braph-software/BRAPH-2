classdef PanelPropNet < PanelProp
	%PanelPropNet plots the panel of a property neural network.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Neural Network Prop Panel (PanelPropNet) plots the panel for a NET property with a button.
	% It works for all categories.
	%
	% PanelPropNet methods (constructor):
	%  PanelPropNet - constructor
	%
	% PanelPropNet methods:
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
	% PanelPropNet methods (display):
	%  tostring - string with information about the neural network prop panel
	%  disp - displays information about the neural network prop panel
	%  tree - displays the tree of the neural network prop panel
	%
	% PanelPropNet methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network prop panel
	%
	% PanelPropNet methods (save/load, Static):
	%  save - saves BRAPH2 neural network prop panel as b2 file
	%  load - loads a BRAPH2 neural network prop panel from a b2 file
	%
	% PanelPropNet method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network prop panel
	%
	% PanelPropNet method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network prop panel
	%
	% PanelPropNet methods (inspection, Static):
	%  getClass - returns the class of the neural network prop panel
	%  getSubclasses - returns all subclasses of PanelPropNet
	%  getProps - returns the property list of the neural network prop panel
	%  getPropNumber - returns the property number of the neural network prop panel
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
	% PanelPropNet methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropNet methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropNet methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropNet methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropNet; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropNet constants</a>.
	%
	%
	% See also uibutton, GUI, PanelElement, PanelProp.
	
	properties (Constant) % properties
		BUTTON_TEXT = PanelProp.getPropNumber() + 1;
		BUTTON_TEXT_TAG = 'BUTTON_TEXT';
		BUTTON_TEXT_CATEGORY = Category.GUI;
		BUTTON_TEXT_FORMAT = Format.STRING;
		
		BUTTON = PanelProp.getPropNumber() + 2;
		BUTTON_TAG = 'BUTTON';
		BUTTON_CATEGORY = Category.EVANESCENT;
		BUTTON_FORMAT = Format.HANDLE;
		
		MSG_FLAG = PanelProp.getPropNumber() + 3;
		MSG_FLAG_TAG = 'MSG_FLAG';
		MSG_FLAG_CATEGORY = Category.GUI;
		MSG_FLAG_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function pr = PanelPropNet(varargin)
			%PanelPropNet() creates a neural network prop panel.
			%
			% PanelPropNet(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropNet(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the neural network prop panel.
			%
			% CLASS = PanelPropNet.GETCLASS() returns the class 'PanelPropNet'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the neural network prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropNet') returns 'PanelPropNet'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropNet')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropNet';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network prop panel.
			%
			% LIST = PanelPropNet.GETSUBCLASSES() returns all subclasses of 'PanelPropNet'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the neural network prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropNet') returns all subclasses of 'PanelPropNet'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropNet', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network prop panel.
			%
			% PROPS = PanelPropNet.GETPROPS() returns the property list of neural network prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropNet.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the neural network prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropNet'[, CATEGORY]) returns the property list of 'PanelPropNet'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropNet.BUTTON_TEXT ...
						PanelPropNet.BUTTON ...
						PanelPropNet.MSG_FLAG ...
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
						PanelPropNet.BUTTON ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropNet.BUTTON_TEXT ...
						PanelPropNet.MSG_FLAG ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network prop panel.
			%
			% N = PanelPropNet.GETPROPNUMBER() returns the property number of neural network prop panel.
			%
			% N = PanelPropNet.GETPROPNUMBER(CATEGORY) returns the property number of neural network prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropNet') returns the property number of 'PanelPropNet'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropNet.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network prop panel/error.
			%
			% CHECK = PanelPropNet.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropNet, PROP) checks whether PROP exists for PanelPropNet.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropNet:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%  Element.EXISTSPROP(PanelPropNet, PROP) throws error if PROP does NOT exist for PanelPropNet.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropNet.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropNet.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network prop panel/error.
			%
			% CHECK = PanelPropNet.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropNet, TAG) checks whether TAG exists for PanelPropNet.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropNet:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%  Element.EXISTSTAG(PanelPropNet, TAG) throws error if TAG does NOT exist for PanelPropNet.
			%   Error id: [BRAPH2:PanelPropNet:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropnet_tag_list = cellfun(@(x) PanelPropNet.getPropTag(x), num2cell(PanelPropNet.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropnet_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropNet.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropNet, POINTER) returns property number of POINTER of PanelPropNet.
			%  PROPERTY = PR.GETPROPPROP(PanelPropNet, POINTER) returns property number of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropnet_tag_list = cellfun(@(x) PanelPropNet.getPropTag(x), num2cell(PanelPropNet.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropnet_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropNet, POINTER) returns tag of POINTER of PanelPropNet.
			%  TAG = PR.GETPROPTAG(PanelPropNet, POINTER) returns tag of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropNet.BUTTON_TEXT
						tag = PanelPropNet.BUTTON_TEXT_TAG;
					case PanelPropNet.BUTTON
						tag = PanelPropNet.BUTTON_TAG;
					case PanelPropNet.MSG_FLAG
						tag = PanelPropNet.MSG_FLAG_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropNet, POINTER) returns category of POINTER of PanelPropNet.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropNet, POINTER) returns category of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT
					prop_category = PanelPropNet.BUTTON_TEXT_CATEGORY;
				case PanelPropNet.BUTTON
					prop_category = PanelPropNet.BUTTON_CATEGORY;
				case PanelPropNet.MSG_FLAG
					prop_category = PanelPropNet.MSG_FLAG_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropNet, POINTER) returns format of POINTER of PanelPropNet.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropNet, POINTER) returns format of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT
					prop_format = PanelPropNet.BUTTON_TEXT_FORMAT;
				case PanelPropNet.BUTTON
					prop_format = PanelPropNet.BUTTON_FORMAT;
				case PanelPropNet.MSG_FLAG
					prop_format = PanelPropNet.MSG_FLAG_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropNet, POINTER) returns description of POINTER of PanelPropNet.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropNet, POINTER) returns description of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT
					prop_description = 'BUTTON_TEXT (gui, string) is the button text.';
				case PanelPropNet.BUTTON
					prop_description = 'BUTTON (evanescent, handle) is the logical value dropdown.';
				case PanelPropNet.MSG_FLAG
					prop_description = 'MSG_FLAG (gui, logical) determines whether to show the message box about the neural network visualization window.';
				case PanelPropNet.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the neural network property panel.';
				case PanelPropNet.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network property panel.';
				case PanelPropNet.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network property panel.';
				case PanelPropNet.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network property panel.';
				case PanelPropNet.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network property panel.';
				case PanelPropNet.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network property panel.';
				case PanelPropNet.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network property panel.';
				case PanelPropNet.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropNet.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropNet.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropNet.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropNet.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the button.';
				case PanelPropNet.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropNet.DELETE
					prop_description = 'DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropNet, POINTER) returns settings of POINTER of PanelPropNet.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropNet, POINTER) returns settings of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PanelPropNet.BUTTON
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropNet.MSG_FLAG
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropNet.TEMPLATE
					prop_settings = 'PanelPropNet';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropNet.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropNet.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropNet, POINTER) returns the default value of POINTER of PanelPropNet.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropNet, POINTER) returns the default value of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT
					prop_default = Format.getFormatDefault(Format.STRING, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.BUTTON
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.MSG_FLAG
					prop_default = true;
				case PanelPropNet.ELCLASS
					prop_default = 'PanelPropNet';
				case PanelPropNet.NAME
					prop_default = 'Neural Network Prop Panel';
				case PanelPropNet.DESCRIPTION
					prop_default = 'A Neural Network Prop Panel (PanelPropNet) plots the panel for a NET property with a button. It works for all categories.';
				case PanelPropNet.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.ID
					prop_default = 'PanelPropNet ID';
				case PanelPropNet.LABEL
					prop_default = 'PanelPropNet label';
				case PanelPropNet.NOTES
					prop_default = 'PanelPropNet notes';
				case PanelPropNet.EL
					prop_default = PanelProp();
				case PanelPropNet.PROP
					prop_default = PanelProp.EL;
				case PanelPropNet.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropNet.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropNet.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropNet, POINTER) returns the conditioned default value of POINTER of PanelPropNet.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropNet, POINTER) returns the conditioned default value of POINTER of PanelPropNet.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			prop_default = PanelPropNet.conditioning(prop, PanelPropNet.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropNet, PROP, VALUE) checks VALUE format for PROP of PanelPropNet.
			%  CHECK = PR.CHECKPROP(PanelPropNet, PROP, VALUE) checks VALUE format for PROP of PanelPropNet.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropNet:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropNet:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropNet, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropNet.
			%   Error id: €BRAPH2.STR€:PanelPropNet:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropNet, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropNet.
			%   Error id: €BRAPH2.STR€:PanelPropNet:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropNet')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropNet.getPropProp(pointer);
			
			switch prop
				case PanelPropNet.BUTTON_TEXT % __PanelPropNet.BUTTON_TEXT__
					check = Format.checkFormat(Format.STRING, value, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.BUTTON % __PanelPropNet.BUTTON__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.MSG_FLAG % __PanelPropNet.MSG_FLAG__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropNet.getPropSettings(prop));
				case PanelPropNet.TEMPLATE % __PanelPropNet.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropNet.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropNet:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropNet.getPropTag(prop) ' (' PanelPropNet.getFormatTag(PanelPropNet.getPropFormat(prop)) ').'] ...
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
				case PanelPropNet.BUTTON % __PanelPropNet.BUTTON__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					button = uibutton( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'BUTTON', ...
					    'Text', '', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ButtonPushedFcn', {@cb_button}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					
					value = button;
					
				case PanelPropNet.X_DRAW % __PanelPropNet.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON')
					end
					
				case PanelPropNet.UPDATE % __PanelPropNet.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if ~isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        button_text = pr.get('BUTTON_TEXT');
					    else % isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        if isa(el.getr(prop), 'NoValue')
					            button_text = el.getPropDefault(prop).Name;
					        else
					            button_text = 'Trained neural network';;
					        end
					    end
					    
					    switch el.getPropCategory(prop)
					        case {Category.CONSTANT, Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('BUTTON'), ...
					                'Text', button_text ...
					                )
					        
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            if isa(el.getr(prop), 'NoValue')
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Enable', 'off' ...
					                    )
					            else
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Enable', 'on' ...
					                    )
					            end
					    end
					end
					
				case PanelPropNet.REDRAW % __PanelPropNet.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropNet.DELETE % __PanelPropNet.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('BUTTON', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    net = el.memorize(prop);
			    
			    analyzeNetwork(net);
			
			    if pr.get('MSG_FLAG')
			        pr.set('MSG_FLAG', false);
			        title = ['About Network Visualization Windows'];
			        
			        message = {''
			            ['{\bf\color{orange}' BRAPH2.STR '}'] % note to use doubl slashes to avoid genesis problem
			            ['{\color{gray}version ' BRAPH2.VERSION '}']
			            ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
			            ''
			            'The network visualization window'
			            'cannot be closed automatically.'
			            'It requires manual closure by the user.'
			            ''
			            ''};
			
			        braph2msgbox(title, message)
			    end
			end
		end
	end
end
