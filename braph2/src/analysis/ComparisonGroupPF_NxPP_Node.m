classdef ComparisonGroupPF_NxPP_Node < PanelProp
	%ComparisonGroupPF_NxPP_Node plots the panel to select a node.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% ComparisonGroupPF_NxPP_Node plots the panel to select a node from a drop-down list.
	% It is supposed to be used with the property NODE of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.
	%
	% ComparisonGroupPF_NxPP_Node methods (constructor):
	%  ComparisonGroupPF_NxPP_Node - constructor
	%
	% ComparisonGroupPF_NxPP_Node methods:
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
	% ComparisonGroupPF_NxPP_Node methods (display):
	%  tostring - string with information about the panel property node
	%  disp - displays information about the panel property node
	%  tree - displays the tree of the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property node are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (save/load, Static):
	%  save - saves BRAPH2 panel property node as b2 file
	%  load - loads a BRAPH2 panel property node from a b2 file
	%
	% ComparisonGroupPF_NxPP_Node method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonGroupPF_NxPP_Node method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (inspection, Static):
	%  getClass - returns the class of the panel property node
	%  getSubclasses - returns all subclasses of ComparisonGroupPF_NxPP_Node
	%  getProps - returns the property list of the panel property node
	%  getPropNumber - returns the property number of the panel property node
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
	% ComparisonGroupPF_NxPP_Node methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupPF_NxPP_Node methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupPF_NxPP_Node methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupPF_NxPP_Node methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupPF_NxPP_Node; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupPF_NxPP_Node constants</a>.
	%
	%
	% See also uidropdown, GUI, ComparisonGroupPF_NU, ComparisonGroupPF_NS, ComparisonGroupPF_NB.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = ComparisonGroupPF_NxPP_Node(varargin)
			%ComparisonGroupPF_NxPP_Node() creates a panel property node.
			%
			% ComparisonGroupPF_NxPP_Node(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupPF_NxPP_Node(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel property node.
			%
			% CLASS = ComparisonGroupPF_NxPP_Node.GETCLASS() returns the class 'ComparisonGroupPF_NxPP_Node'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property node PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('ComparisonGroupPF_NxPP_Node') returns 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			
			pr_class = 'ComparisonGroupPF_NxPP_Node';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property node.
			%
			% LIST = ComparisonGroupPF_NxPP_Node.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property node PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupPF_NxPP_Node') returns all subclasses of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupPF_NxPP_Node', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property node.
			%
			% PROPS = ComparisonGroupPF_NxPP_Node.GETPROPS() returns the property list of panel property node
			%  as a row vector.
			%
			% PROPS = ComparisonGroupPF_NxPP_Node.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property node PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('ComparisonGroupPF_NxPP_Node'[, CATEGORY]) returns the property list of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						ComparisonGroupPF_NxPP_Node.DROPDOWN ...
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
						ComparisonGroupPF_NxPP_Node.DROPDOWN ...
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
			%GETPROPNUMBER returns the property number of panel property node.
			%
			% N = ComparisonGroupPF_NxPP_Node.GETPROPNUMBER() returns the property number of panel property node.
			%
			% N = ComparisonGroupPF_NxPP_Node.GETPROPNUMBER(CATEGORY) returns the property number of panel property node
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property node PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupPF_NxPP_Node') returns the property number of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupPF_NxPP_Node.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property node/error.
			%
			% CHECK = ComparisonGroupPF_NxPP_Node.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupPF_NxPP_Node, PROP) checks whether PROP exists for ComparisonGroupPF_NxPP_Node.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupPF_NxPP_Node, PROP) throws error if PROP does NOT exist for ComparisonGroupPF_NxPP_Node.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupPF_NxPP_Node.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupPF_NxPP_Node.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property node/error.
			%
			% CHECK = ComparisonGroupPF_NxPP_Node.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupPF_NxPP_Node, TAG) checks whether TAG exists for ComparisonGroupPF_NxPP_Node.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupPF_NxPP_Node, TAG) throws error if TAG does NOT exist for ComparisonGroupPF_NxPP_Node.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongrouppf_nxpp_node_tag_list = cellfun(@(x) ComparisonGroupPF_NxPP_Node.getPropTag(x), num2cell(ComparisonGroupPF_NxPP_Node.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongrouppf_nxpp_node_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupPF_NxPP_Node.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupPF_NxPP_Node, POINTER) returns property number of POINTER of ComparisonGroupPF_NxPP_Node.
			%  PROPERTY = PR.GETPROPPROP(ComparisonGroupPF_NxPP_Node, POINTER) returns property number of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongrouppf_nxpp_node_tag_list = cellfun(@(x) ComparisonGroupPF_NxPP_Node.getPropTag(x), num2cell(ComparisonGroupPF_NxPP_Node.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongrouppf_nxpp_node_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonGroupPF_NxPP_Node, POINTER) returns tag of POINTER of ComparisonGroupPF_NxPP_Node.
			%  TAG = PR.GETPROPTAG(ComparisonGroupPF_NxPP_Node, POINTER) returns tag of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupPF_NxPP_Node.DROPDOWN
						tag = ComparisonGroupPF_NxPP_Node.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupPF_NxPP_Node, POINTER) returns category of POINTER of ComparisonGroupPF_NxPP_Node.
			%  CATEGORY = PR.GETPROPCATEGORY(ComparisonGroupPF_NxPP_Node, POINTER) returns category of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_category = ComparisonGroupPF_NxPP_Node.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupPF_NxPP_Node, POINTER) returns format of POINTER of ComparisonGroupPF_NxPP_Node.
			%  FORMAT = PR.GETPROPFORMAT(ComparisonGroupPF_NxPP_Node, POINTER) returns format of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_format = ComparisonGroupPF_NxPP_Node.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupPF_NxPP_Node, POINTER) returns description of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(ComparisonGroupPF_NxPP_Node, POINTER) returns description of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the dropdown for the node.';
				case ComparisonGroupPF_NxPP_Node.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroupPF_NxPP_Node.NAME
					prop_description = 'NAME (constant, string) is the name of the panel property node.';
				case ComparisonGroupPF_NxPP_Node.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel property node.';
				case ComparisonGroupPF_NxPP_Node.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel property node.';
				case ComparisonGroupPF_NxPP_Node.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel property node.';
				case ComparisonGroupPF_NxPP_Node.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel property node.';
				case ComparisonGroupPF_NxPP_Node.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel property node.';
				case ComparisonGroupPF_NxPP_Node.EL
					prop_description = 'EL (data, item) is the element.';
				case ComparisonGroupPF_NxPP_Node.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case ComparisonGroupPF_NxPP_Node.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case ComparisonGroupPF_NxPP_Node.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case ComparisonGroupPF_NxPP_Node.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case ComparisonGroupPF_NxPP_Node.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case ComparisonGroupPF_NxPP_Node.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupPF_NxPP_Node, POINTER) returns settings of POINTER of ComparisonGroupPF_NxPP_Node.
			%  SETTINGS = PR.GETPROPSETTINGS(ComparisonGroupPF_NxPP_Node, POINTER) returns settings of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF_NxPP_Node.TEMPLATE
					prop_settings = 'ComparisonGroupPF_NxPP_Node';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupPF_NxPP_Node, POINTER) returns the default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DEFAULT = PR.GETPROPDEFAULT(ComparisonGroupPF_NxPP_Node, POINTER) returns the default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case ComparisonGroupPF_NxPP_Node.ELCLASS
					prop_default = 'ComparisonGroupPF_NxPP_Node';
				case ComparisonGroupPF_NxPP_Node.NAME
					prop_default = 'ComparisonGroupPF_NxPP_Node';
				case ComparisonGroupPF_NxPP_Node.DESCRIPTION
					prop_default = 'ComparisonGroupPF_NxPP_Node plots the panel to select a node from a drop-down list. It is supposed to be used with the property NODE of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.';
				case ComparisonGroupPF_NxPP_Node.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case ComparisonGroupPF_NxPP_Node.ID
					prop_default = 'ComparisonGroupPF_NxPP_Node ID';
				case ComparisonGroupPF_NxPP_Node.LABEL
					prop_default = 'ComparisonGroupPF_NxPP_Node label';
				case ComparisonGroupPF_NxPP_Node.NOTES
					prop_default = 'ComparisonGroupPF_NxPP_Node notes';
				case ComparisonGroupPF_NxPP_Node.EL
					prop_default = ComparisonGroupPF_NU();
				case ComparisonGroupPF_NxPP_Node.PROP
					prop_default = ComparisonGroupPF_NU.NODE;
				case ComparisonGroupPF_NxPP_Node.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_NxPP_Node, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_NxPP_Node, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			prop_default = ComparisonGroupPF_NxPP_Node.conditioning(prop, ComparisonGroupPF_NxPP_Node.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_NxPP_Node.
			%  CHECK = PR.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_NxPP_Node.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupPF_NxPP_Node:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_NxPP_Node:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_NxPP_Node.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_NxPP_Node:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_NxPP_Node.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF_NxPP_Node:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF_NxPP_Node.DROPDOWN % __ComparisonGroupPF_NxPP_Node.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case ComparisonGroupPF_NxPP_Node.TEMPLATE % __ComparisonGroupPF_NxPP_Node.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF_NxPP_Node:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupPF_NxPP_Node.getPropTag(prop) ' (' ComparisonGroupPF_NxPP_Node.getFormatTag(ComparisonGroupPF_NxPP_Node.getPropFormat(prop)) ').'] ...
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
				case ComparisonGroupPF_NxPP_Node.DROPDOWN % __ComparisonGroupPF_NxPP_Node.DROPDOWN__
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
					
				case ComparisonGroupPF_NxPP_Node.X_DRAW % __ComparisonGroupPF_NxPP_Node.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case ComparisonGroupPF_NxPP_Node.UPDATE % __ComparisonGroupPF_NxPP_Node.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    NODE = pr.get('PROP');
					    
					    keys = pf.get('CP').get('C').get('A1').get('G').get('ANODELABELS');
					    
					    set(pr.get('DROPDOWN'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', pf.get(NODE) ...
					        )
					
					    prop_value = pf.getr(NODE);
					    if pf.isLocked(NODE) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case ComparisonGroupPF_NxPP_Node.REDRAW % __ComparisonGroupPF_NxPP_Node.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case ComparisonGroupPF_NxPP_Node.DELETE % __ComparisonGroupPF_NxPP_Node.DELETE__
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
