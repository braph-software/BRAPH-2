classdef ComparisonEnsemblePF_xUPP_Layer < PanelProp
	%ComparisonEnsemblePF_xUPP_Layer plots the panel to select a layer.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% ComparisonEnsemblePF_xUPP_Layer plots the panel to select a layer from a multilayer graph from a drop-down list.
	% It is supposed to be used with the property Layer of ComparisonEnsemblePF_NU, ComparisonEnsemblePF_BU, or ComparisonEnsemblePF_GU.
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (constructor):
	%  ComparisonEnsemblePF_xUPP_Layer - constructor
	%
	% ComparisonEnsemblePF_xUPP_Layer methods:
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
	% ComparisonEnsemblePF_xUPP_Layer methods (display):
	%  tostring - string with information about the panel property layer
	%  disp - displays information about the panel property layer
	%  tree - displays the tree of the panel property layer
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property layer are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property layer
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (save/load, Static):
	%  save - saves BRAPH2 panel property layer as b2 file
	%  load - loads a BRAPH2 panel property layer from a b2 file
	%
	% ComparisonEnsemblePF_xUPP_Layer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property layer
	%
	% ComparisonEnsemblePF_xUPP_Layer method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property layer
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (inspection, Static):
	%  getClass - returns the class of the panel property layer
	%  getSubclasses - returns all subclasses of ComparisonEnsemblePF_xUPP_Layer
	%  getProps - returns the property list of the panel property layer
	%  getPropNumber - returns the property number of the panel property layer
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
	% ComparisonEnsemblePF_xUPP_Layer methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemblePF_xUPP_Layer methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsemblePF_xUPP_Layer; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsemblePF_xUPP_Layer constants</a>.
	%
	%
	% See also uidropdown, GUI, ComparisonEnsemblePF_NU, ComparisonEnsemblePF_BU, ComparisonEnsemblePF_GU.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = ComparisonEnsemblePF_xUPP_Layer(varargin)
			%ComparisonEnsemblePF_xUPP_Layer() creates a panel property layer.
			%
			% ComparisonEnsemblePF_xUPP_Layer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemblePF_xUPP_Layer(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel property layer.
			%
			% CLASS = ComparisonEnsemblePF_xUPP_Layer.GETCLASS() returns the class 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property layer PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemblePF_xUPP_Layer') returns 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			
			pr_class = 'ComparisonEnsemblePF_xUPP_Layer';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property layer.
			%
			% LIST = ComparisonEnsemblePF_xUPP_Layer.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property layer PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsemblePF_xUPP_Layer') returns all subclasses of 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsemblePF_xUPP_Layer', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property layer.
			%
			% PROPS = ComparisonEnsemblePF_xUPP_Layer.GETPROPS() returns the property list of panel property layer
			%  as a row vector.
			%
			% PROPS = ComparisonEnsemblePF_xUPP_Layer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property layer PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemblePF_xUPP_Layer'[, CATEGORY]) returns the property list of 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						ComparisonEnsemblePF_xUPP_Layer.DROPDOWN ...
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
						ComparisonEnsemblePF_xUPP_Layer.DROPDOWN ...
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
			%GETPROPNUMBER returns the property number of panel property layer.
			%
			% N = ComparisonEnsemblePF_xUPP_Layer.GETPROPNUMBER() returns the property number of panel property layer.
			%
			% N = ComparisonEnsemblePF_xUPP_Layer.GETPROPNUMBER(CATEGORY) returns the property number of panel property layer
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property layer PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemblePF_xUPP_Layer') returns the property number of 'ComparisonEnsemblePF_xUPP_Layer'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsemblePF_xUPP_Layer.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property layer/error.
			%
			% CHECK = ComparisonEnsemblePF_xUPP_Layer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemblePF_xUPP_Layer, PROP) checks whether PROP exists for ComparisonEnsemblePF_xUPP_Layer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemblePF_xUPP_Layer, PROP) throws error if PROP does NOT exist for ComparisonEnsemblePF_xUPP_Layer.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsemblePF_xUPP_Layer.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemblePF_xUPP_Layer.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property layer/error.
			%
			% CHECK = ComparisonEnsemblePF_xUPP_Layer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemblePF_xUPP_Layer, TAG) checks whether TAG exists for ComparisonEnsemblePF_xUPP_Layer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemblePF_xUPP_Layer, TAG) throws error if TAG does NOT exist for ComparisonEnsemblePF_xUPP_Layer.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_xUPP_Layer:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblepf_xupp_layer_tag_list = cellfun(@(x) ComparisonEnsemblePF_xUPP_Layer.getPropTag(x), num2cell(ComparisonEnsemblePF_xUPP_Layer.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblepf_xupp_layer_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemblePF_xUPP_Layer.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns property number of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  PROPERTY = PR.GETPROPPROP(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns property number of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblepf_xupp_layer_tag_list = cellfun(@(x) ComparisonEnsemblePF_xUPP_Layer.getPropTag(x), num2cell(ComparisonEnsemblePF_xUPP_Layer.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblepf_xupp_layer_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns tag of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  TAG = PR.GETPROPTAG(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns tag of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
						tag = ComparisonEnsemblePF_xUPP_Layer.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns category of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  CATEGORY = PR.GETPROPCATEGORY(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns category of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
					prop_category = ComparisonEnsemblePF_xUPP_Layer.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns format of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  FORMAT = PR.GETPROPFORMAT(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns format of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
					prop_format = ComparisonEnsemblePF_xUPP_Layer.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns description of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns description of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the dropdown for the layer.';
				case ComparisonEnsemblePF_xUPP_Layer.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonEnsemblePF_xUPP_Layer.NAME
					prop_description = 'NAME (constant, string) is the name of the panel property layer.';
				case ComparisonEnsemblePF_xUPP_Layer.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel property layer.';
				case ComparisonEnsemblePF_xUPP_Layer.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel property Layer.';
				case ComparisonEnsemblePF_xUPP_Layer.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel property Layer.';
				case ComparisonEnsemblePF_xUPP_Layer.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel property layer.';
				case ComparisonEnsemblePF_xUPP_Layer.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel property layer.';
				case ComparisonEnsemblePF_xUPP_Layer.EL
					prop_description = 'EL (data, item) is the element.';
				case ComparisonEnsemblePF_xUPP_Layer.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case ComparisonEnsemblePF_xUPP_Layer.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case ComparisonEnsemblePF_xUPP_Layer.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case ComparisonEnsemblePF_xUPP_Layer.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case ComparisonEnsemblePF_xUPP_Layer.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case ComparisonEnsemblePF_xUPP_Layer.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns settings of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  SETTINGS = PR.GETPROPSETTINGS(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns settings of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF_xUPP_Layer.TEMPLATE
					prop_settings = 'ComparisonEnsemblePF_xUPP_Layer';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_xUPP_Layer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_xUPP_Layer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  DEFAULT = PR.GETPROPDEFAULT(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF_xUPP_Layer.getPropSettings(prop));
				case ComparisonEnsemblePF_xUPP_Layer.ELCLASS
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer';
				case ComparisonEnsemblePF_xUPP_Layer.NAME
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer';
				case ComparisonEnsemblePF_xUPP_Layer.DESCRIPTION
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer plots the panel to select a layer from a multilayer graph from a drop-down list. It is supposed to be used with the property LAYER of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.';
				case ComparisonEnsemblePF_xUPP_Layer.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF_xUPP_Layer.getPropSettings(prop));
				case ComparisonEnsemblePF_xUPP_Layer.ID
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer ID';
				case ComparisonEnsemblePF_xUPP_Layer.LABEL
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer label';
				case ComparisonEnsemblePF_xUPP_Layer.NOTES
					prop_default = 'ComparisonEnsemblePF_xUPP_Layer notes';
				case ComparisonEnsemblePF_xUPP_Layer.EL
					prop_default = ComparisonEnsemblePF_NU();
				case ComparisonEnsemblePF_xUPP_Layer.PROP
					prop_default = ComparisonEnsemblePF_NU.LAYER;
				case ComparisonEnsemblePF_xUPP_Layer.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_xUPP_Layer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_xUPP_Layer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_xUPP_Layer, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_xUPP_Layer.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			prop_default = ComparisonEnsemblePF_xUPP_Layer.conditioning(prop, ComparisonEnsemblePF_xUPP_Layer.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsemblePF_xUPP_Layer, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_xUPP_Layer.
			%  CHECK = PR.CHECKPROP(ComparisonEnsemblePF_xUPP_Layer, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_xUPP_Layer.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsemblePF_xUPP_Layer:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_xUPP_Layer:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsemblePF_xUPP_Layer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_xUPP_Layer.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_xUPP_Layer:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(ComparisonEnsemblePF_xUPP_Layer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_xUPP_Layer.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_xUPP_Layer:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('ComparisonEnsemblePF_xUPP_Layer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsemblePF_xUPP_Layer.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN % __ComparisonEnsemblePF_xUPP_Layer.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF_xUPP_Layer.getPropSettings(prop));
				case ComparisonEnsemblePF_xUPP_Layer.TEMPLATE % __ComparisonEnsemblePF_xUPP_Layer.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF_xUPP_Layer.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_xUPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemblePF_xUPP_Layer.getPropTag(prop) ' (' ComparisonEnsemblePF_xUPP_Layer.getFormatTag(ComparisonEnsemblePF_xUPP_Layer.getPropFormat(prop)) ').'] ...
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
				case ComparisonEnsemblePF_xUPP_Layer.DROPDOWN % __ComparisonEnsemblePF_xUPP_Layer.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case ComparisonEnsemblePF_xUPP_Layer.X_DRAW % __ComparisonEnsemblePF_xUPP_Layer.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case ComparisonEnsemblePF_xUPP_Layer.UPDATE % __ComparisonEnsemblePF_xUPP_Layer.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    LAYER = pr.get('PROP');
					
					    if pf.get('CP').get('C').get('A1').get('G_DICT').get('LENGTH')
					        g = pf.get('CP').get('C').get('A1').get('G_DICT').get('IT', 1);
					    else
					        g = pf.get('CP').get('C').get('A1').get('GRAPH_TEMPLATE');
					    end
					    
					    keys = g.get('ALAYERTICKS');
					    if (length(keys) <= 1)
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    else
					        set(pr.get('DROPDOWN'), ...
					            'Items', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:length(keys)]), 'uniformoutput', false), ...
					            'ItemsData', [1:1:length(keys)], ...
					            'Value', pf.get(LAYER) ...
					            )
					    end
					
					    prop_value = pf.getr(LAYER);
					    if pf.isLocked(LAYER) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case ComparisonEnsemblePF_xUPP_Layer.REDRAW % __ComparisonEnsemblePF_xUPP_Layer.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case ComparisonEnsemblePF_xUPP_Layer.DELETE % __ComparisonEnsemblePF_xUPP_Layer.DELETE__
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
