classdef ComparisonEnsemblePF_BxPP_Nodes < PanelProp
	%ComparisonEnsemblePF_BxPP_Nodes plots the panel to select a couple of nodes.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% ComparisonEnsemblePF_BxPP_Nodes plots the panel to select the nodes from two drop-down lists.
	% It is supposed to be used with the property NODES of ComparisonEnsemblePF_BU, ComparisonEnsemblePF_BS, or ComparisonEnsemblePF_BB.
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (constructor):
	%  ComparisonEnsemblePF_BxPP_Nodes - constructor
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods:
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
	% ComparisonEnsemblePF_BxPP_Nodes methods (display):
	%  tostring - string with information about the panel property node
	%  disp - displays information about the panel property node
	%  tree - displays the tree of the panel property node
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property node are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property node
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (save/load, Static):
	%  save - saves BRAPH2 panel property node as b2 file
	%  load - loads a BRAPH2 panel property node from a b2 file
	%
	% ComparisonEnsemblePF_BxPP_Nodes method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonEnsemblePF_BxPP_Nodes method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (inspection, Static):
	%  getClass - returns the class of the panel property node
	%  getSubclasses - returns all subclasses of ComparisonEnsemblePF_BxPP_Nodes
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
	% ComparisonEnsemblePF_BxPP_Nodes methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemblePF_BxPP_Nodes methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsemblePF_BxPP_Nodes; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsemblePF_BxPP_Nodes constants</a>.
	%
	%
	% See also uidropdown, GUI, ComparisonEnsemblePF_BU, ComparisonEnsemblePF_BS, ComparisonEnsemblePF_BB.
	
	properties (Constant) % properties
		DROPDOWN_NODE1 = PanelProp.getPropNumber() + 1;
		DROPDOWN_NODE1_TAG = 'DROPDOWN_NODE1';
		DROPDOWN_NODE1_CATEGORY = Category.EVANESCENT;
		DROPDOWN_NODE1_FORMAT = Format.HANDLE;
		
		DROPDOWN_NODE2 = PanelProp.getPropNumber() + 2;
		DROPDOWN_NODE2_TAG = 'DROPDOWN_NODE2';
		DROPDOWN_NODE2_CATEGORY = Category.EVANESCENT;
		DROPDOWN_NODE2_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = ComparisonEnsemblePF_BxPP_Nodes(varargin)
			%ComparisonEnsemblePF_BxPP_Nodes() creates a panel property node.
			%
			% ComparisonEnsemblePF_BxPP_Nodes(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemblePF_BxPP_Nodes(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = ComparisonEnsemblePF_BxPP_Nodes.GETCLASS() returns the class 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property node PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemblePF_BxPP_Nodes') returns 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			
			pr_class = 'ComparisonEnsemblePF_BxPP_Nodes';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property node.
			%
			% LIST = ComparisonEnsemblePF_BxPP_Nodes.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property node PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsemblePF_BxPP_Nodes') returns all subclasses of 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsemblePF_BxPP_Nodes', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property node.
			%
			% PROPS = ComparisonEnsemblePF_BxPP_Nodes.GETPROPS() returns the property list of panel property node
			%  as a row vector.
			%
			% PROPS = ComparisonEnsemblePF_BxPP_Nodes.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property node PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemblePF_BxPP_Nodes'[, CATEGORY]) returns the property list of 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1 ...
						ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2 ...
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
						ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1 ...
						ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2 ...
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
			% N = ComparisonEnsemblePF_BxPP_Nodes.GETPROPNUMBER() returns the property number of panel property node.
			%
			% N = ComparisonEnsemblePF_BxPP_Nodes.GETPROPNUMBER(CATEGORY) returns the property number of panel property node
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property node PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemblePF_BxPP_Nodes') returns the property number of 'ComparisonEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsemblePF_BxPP_Nodes.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property node/error.
			%
			% CHECK = ComparisonEnsemblePF_BxPP_Nodes.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP) checks whether PROP exists for ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP) throws error if PROP does NOT exist for ComparisonEnsemblePF_BxPP_Nodes.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsemblePF_BxPP_Nodes.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemblePF_BxPP_Nodes.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property node/error.
			%
			% CHECK = ComparisonEnsemblePF_BxPP_Nodes.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemblePF_BxPP_Nodes, TAG) checks whether TAG exists for ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemblePF_BxPP_Nodes, TAG) throws error if TAG does NOT exist for ComparisonEnsemblePF_BxPP_Nodes.
			%   Error id: [BRAPH2:ComparisonEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblepf_bxpp_nodes_tag_list = cellfun(@(x) ComparisonEnsemblePF_BxPP_Nodes.getPropTag(x), num2cell(ComparisonEnsemblePF_BxPP_Nodes.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblepf_bxpp_nodes_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemblePF_BxPP_Nodes.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns property number of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  PROPERTY = PR.GETPROPPROP(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns property number of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblepf_bxpp_nodes_tag_list = cellfun(@(x) ComparisonEnsemblePF_BxPP_Nodes.getPropTag(x), num2cell(ComparisonEnsemblePF_BxPP_Nodes.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblepf_bxpp_nodes_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns tag of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  TAG = PR.GETPROPTAG(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns tag of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
						tag = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1_TAG;
					case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
						tag = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns category of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  CATEGORY = PR.GETPROPCATEGORY(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns category of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_category = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1_CATEGORY;
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_category = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns format of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  FORMAT = PR.GETPROPFORMAT(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns format of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_format = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1_FORMAT;
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_format = ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns description of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns description of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_description = 'DROPDOWN_NODE1 (evanescent, handle) is the dropdown for the first node.';
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_description = 'DROPDOWN_NODE2 (evanescent, handle) is the dropdown for the second node.';
				case ComparisonEnsemblePF_BxPP_Nodes.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonEnsemblePF_BxPP_Nodes.NAME
					prop_description = 'NAME (constant, string) is the name of the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel property node.';
				case ComparisonEnsemblePF_BxPP_Nodes.EL
					prop_description = 'EL (data, item) is the element.';
				case ComparisonEnsemblePF_BxPP_Nodes.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case ComparisonEnsemblePF_BxPP_Nodes.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case ComparisonEnsemblePF_BxPP_Nodes.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case ComparisonEnsemblePF_BxPP_Nodes.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case ComparisonEnsemblePF_BxPP_Nodes.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case ComparisonEnsemblePF_BxPP_Nodes.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns settings of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  SETTINGS = PR.GETPROPSETTINGS(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns settings of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonEnsemblePF_BxPP_Nodes.TEMPLATE
					prop_settings = 'ComparisonEnsemblePF_BxPP_Nodes';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_BxPP_Nodes.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_BxPP_Nodes.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  DEFAULT = PR.GETPROPDEFAULT(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns the default value of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case ComparisonEnsemblePF_BxPP_Nodes.ELCLASS
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes';
				case ComparisonEnsemblePF_BxPP_Nodes.NAME
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes';
				case ComparisonEnsemblePF_BxPP_Nodes.DESCRIPTION
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes plots the panel to select the nodes from two drop-down lists. It is supposed to be used with the property NODES of ComparisonGroupPF_BU, ComparisonGroupPF_BS, or ComparisonGroupPF_BB.';
				case ComparisonEnsemblePF_BxPP_Nodes.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case ComparisonEnsemblePF_BxPP_Nodes.ID
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes ID';
				case ComparisonEnsemblePF_BxPP_Nodes.LABEL
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes label';
				case ComparisonEnsemblePF_BxPP_Nodes.NOTES
					prop_default = 'ComparisonEnsemblePF_BxPP_Nodes notes';
				case ComparisonEnsemblePF_BxPP_Nodes.EL
					prop_default = ComparisonEnsemblePF_BU();
				case ComparisonEnsemblePF_BxPP_Nodes.PROP
					prop_default = ComparisonEnsemblePF_BU.NODES;
				case ComparisonEnsemblePF_BxPP_Nodes.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemblePF_BxPP_Nodes.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemblePF_BxPP_Nodes.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(ComparisonEnsemblePF_BxPP_Nodes, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			prop_default = ComparisonEnsemblePF_BxPP_Nodes.conditioning(prop, ComparisonEnsemblePF_BxPP_Nodes.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_BxPP_Nodes.
			%  CHECK = PR.CHECKPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemblePF_BxPP_Nodes.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsemblePF_BxPP_Nodes:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_BxPP_Nodes:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_BxPP_Nodes.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_BxPP_Nodes:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(ComparisonEnsemblePF_BxPP_Nodes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemblePF_BxPP_Nodes.
			%   Error id: €BRAPH2.STR€:ComparisonEnsemblePF_BxPP_Nodes:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('ComparisonEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1 % __ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2 % __ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case ComparisonEnsemblePF_BxPP_Nodes.TEMPLATE % __ComparisonEnsemblePF_BxPP_Nodes.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemblePF_BxPP_Nodes.getPropTag(prop) ' (' ComparisonEnsemblePF_BxPP_Nodes.getFormatTag(ComparisonEnsemblePF_BxPP_Nodes.getPropFormat(prop)) ').'] ...
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
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1 % __ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_NODE1', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown_node} ...
					    );
					
					value = dropdown;
					
				case ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2 % __ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_NODE2', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown_node} ...
					    );
					
					value = dropdown;
					
				case ComparisonEnsemblePF_BxPP_Nodes.X_DRAW % __ComparisonEnsemblePF_BxPP_Nodes.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN_NODE1')
					    pr.memorize('DROPDOWN_NODE2')
					end
					
				case ComparisonEnsemblePF_BxPP_Nodes.UPDATE % __ComparisonEnsemblePF_BxPP_Nodes.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    NODES = pr.get('PROP');
					    
					    if pf.get('CP').get('C').get('A1').get('G_DICT').get('LENGTH')
					        g = pf.get('CP').get('C').get('A1').get('G_DICT').get('IT', 1);
					    else
					        g = pf.get('CP').get('C').get('A1').get('GRAPH_TEMPLATE');
					    end
					    keys = g.get('ANODELABELS');
					    
					    nodes = pf.get(NODES);
					    set(pr.get('DROPDOWN_NODE1'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', nodes(1) ...
					        )
					    set(pr.get('DROPDOWN_NODE2'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', nodes(2) ...
					        )
					
					    prop_value = pf.getr(NODES);
					    if pf.isLocked(NODES) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN_NODE1'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_NODE2'), 'Enable', 'off')
					    end
					end
					
				case ComparisonEnsemblePF_BxPP_Nodes.REDRAW % __ComparisonEnsemblePF_BxPP_Nodes.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN_NODE1'), 'Position', [s(.3)            s(.3) .40*w_p s(1.75)])
					    set(pr.get('DROPDOWN_NODE2'), 'Position', [s(.3)+.50*w_p    s(.3) .40*w_p s(1.75)])
					end
					
				case ComparisonEnsemblePF_BxPP_Nodes.DELETE % __ComparisonEnsemblePF_BxPP_Nodes.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN_NODE1', Element.getNoValue())
					    pr.set('DROPDOWN_NODE2', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown_node(~, ~)
			    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
			end
			function cb_dropdown_node2(~, ~)
			    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
			end
		end
	end
end
