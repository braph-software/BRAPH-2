classdef MultilayerWU < Graph
	%MultilayerWU is a multilayer weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multilayer weighted undirected (WU) graph, layers could have different number 
	%  of nodes with within-layer weighted undirected edges, associated with a real 
	%  number between 0 and 1 and indicating the strength of the connection.
	% The connectivity matrices are symmetric (within layer).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and standardized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.
	%
	% MultilayerWU methods (constructor):
	%  MultilayerWU - constructor
	%
	% MultilayerWU methods:
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
	% MultilayerWU methods (display):
	%  tostring - string with information about the multilayer weighted undirected graph
	%  disp - displays information about the multilayer weighted undirected graph
	%  tree - displays the tree of the multilayer weighted undirected graph
	%
	% MultilayerWU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer weighted undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer weighted undirected graph
	%
	% MultilayerWU methods (save/load, Static):
	%  save - saves BRAPH2 multilayer weighted undirected graph as b2 file
	%  load - loads a BRAPH2 multilayer weighted undirected graph from a b2 file
	%
	% MultilayerWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer weighted undirected graph
	%
	% MultilayerWU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer weighted undirected graph
	%
	% MultilayerWU methods (inspection, Static):
	%  getClass - returns the class of the multilayer weighted undirected graph
	%  getSubclasses - returns all subclasses of MultilayerWU
	%  getProps - returns the property list of the multilayer weighted undirected graph
	%  getPropNumber - returns the property number of the multilayer weighted undirected graph
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
	% MultilayerWU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerWU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerWU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerWU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerWU constants</a>.
	%
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'B';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.CELL;
		
		SYMMETRIZE_RULE = Graph.getPropNumber() + 2;
		SYMMETRIZE_RULE_TAG = 'SYMMETRIZE_RULE';
		SYMMETRIZE_RULE_CATEGORY = Category.PARAMETER;
		SYMMETRIZE_RULE_FORMAT = Format.OPTION;
		
		SEMIPOSITIVIZE_RULE = Graph.getPropNumber() + 3;
		SEMIPOSITIVIZE_RULE_TAG = 'SEMIPOSITIVIZE_RULE';
		SEMIPOSITIVIZE_RULE_CATEGORY = Category.PARAMETER;
		SEMIPOSITIVIZE_RULE_FORMAT = Format.OPTION;
		
		STANDARDIZE_RULE = Graph.getPropNumber() + 4;
		STANDARDIZE_RULE_TAG = 'STANDARDIZE_RULE';
		STANDARDIZE_RULE_CATEGORY = Category.PARAMETER;
		STANDARDIZE_RULE_FORMAT = Format.OPTION;
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 5;
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		NUMBEROFWEIGHTS = Graph.getPropNumber() + 6;
		NUMBEROFWEIGHTS_TAG = 'NUMBEROFWEIGHTS';
		NUMBEROFWEIGHTS_CATEGORY = Category.PARAMETER;
		NUMBEROFWEIGHTS_FORMAT = Format.SCALAR;
		
		RANDOMIZATION = Graph.getPropNumber() + 7;
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = Category.QUERY;
		RANDOMIZATION_FORMAT = Format.CELL;
	end
	methods % constructor
		function g = MultilayerWU(varargin)
			%MultilayerWU() creates a multilayer weighted undirected graph.
			%
			% MultilayerWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerWU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@Graph(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the multilayer weighted undirected graph.
			%
			% CLASS = MultilayerWU.GETCLASS() returns the class 'MultilayerWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerWU') returns 'MultilayerWU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerWU')
			%  are less computationally efficient.
			
			g_class = 'MultilayerWU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer weighted undirected graph.
			%
			% LIST = MultilayerWU.GETSUBCLASSES() returns all subclasses of 'MultilayerWU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer weighted undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerWU') returns all subclasses of 'MultilayerWU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerWU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer weighted undirected graph.
			%
			% PROPS = MultilayerWU.GETPROPS() returns the property list of multilayer weighted undirected graph
			%  as a row vector.
			%
			% PROPS = MultilayerWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerWU'[, CATEGORY]) returns the property list of 'MultilayerWU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultilayerWU.B ...
						MultilayerWU.SYMMETRIZE_RULE ...
						MultilayerWU.SEMIPOSITIVIZE_RULE ...
						MultilayerWU.STANDARDIZE_RULE ...
						MultilayerWU.ATTEMPTSPEREDGE ...
						MultilayerWU.NUMBEROFWEIGHTS ...
						MultilayerWU.RANDOMIZATION ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Graph.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Graph.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Graph.getProps(Category.PARAMETER) ...
						MultilayerWU.SYMMETRIZE_RULE ...
						MultilayerWU.SEMIPOSITIVIZE_RULE ...
						MultilayerWU.STANDARDIZE_RULE ...
						MultilayerWU.ATTEMPTSPEREDGE ...
						MultilayerWU.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultilayerWU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultilayerWU.RANDOMIZATION ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Graph.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Graph.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Graph.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multilayer weighted undirected graph.
			%
			% N = MultilayerWU.GETPROPNUMBER() returns the property number of multilayer weighted undirected graph.
			%
			% N = MultilayerWU.GETPROPNUMBER(CATEGORY) returns the property number of multilayer weighted undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerWU') returns the property number of 'MultilayerWU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerWU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer weighted undirected graph/error.
			%
			% CHECK = MultilayerWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerWU, PROP) checks whether PROP exists for MultilayerWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%  Element.EXISTSPROP(MultilayerWU, PROP) throws error if PROP does NOT exist for MultilayerWU.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerWU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerWU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer weighted undirected graph/error.
			%
			% CHECK = MultilayerWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerWU, TAG) checks whether TAG exists for MultilayerWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%  Element.EXISTSTAG(MultilayerWU, TAG) throws error if TAG does NOT exist for MultilayerWU.
			%   Error id: [BRAPH2:MultilayerWU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerwu_tag_list = cellfun(@(x) MultilayerWU.getPropTag(x), num2cell(MultilayerWU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerwu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerWU.'] ...
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
			%  PROPERTY = G.GETPROPPROP(POINTER) returns property number of POINTER of G.
			%  PROPERTY = Element.GETPROPPROP(MultilayerWU, POINTER) returns property number of POINTER of MultilayerWU.
			%  PROPERTY = G.GETPROPPROP(MultilayerWU, POINTER) returns property number of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerwu_tag_list = cellfun(@(x) MultilayerWU.getPropTag(x), num2cell(MultilayerWU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerwu_tag_list)); % tag = pointer
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
			%  TAG = G.GETPROPTAG(POINTER) returns tag of POINTER of G.
			%  TAG = Element.GETPROPTAG(MultilayerWU, POINTER) returns tag of POINTER of MultilayerWU.
			%  TAG = G.GETPROPTAG(MultilayerWU, POINTER) returns tag of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerWU.B
						tag = MultilayerWU.B_TAG;
					case MultilayerWU.SYMMETRIZE_RULE
						tag = MultilayerWU.SYMMETRIZE_RULE_TAG;
					case MultilayerWU.SEMIPOSITIVIZE_RULE
						tag = MultilayerWU.SEMIPOSITIVIZE_RULE_TAG;
					case MultilayerWU.STANDARDIZE_RULE
						tag = MultilayerWU.STANDARDIZE_RULE_TAG;
					case MultilayerWU.ATTEMPTSPEREDGE
						tag = MultilayerWU.ATTEMPTSPEREDGE_TAG;
					case MultilayerWU.NUMBEROFWEIGHTS
						tag = MultilayerWU.NUMBEROFWEIGHTS_TAG;
					case MultilayerWU.RANDOMIZATION
						tag = MultilayerWU.RANDOMIZATION_TAG;
					otherwise
						tag = getPropTag@Graph(prop);
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
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerWU, POINTER) returns category of POINTER of MultilayerWU.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerWU, POINTER) returns category of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B
					prop_category = MultilayerWU.B_CATEGORY;
				case MultilayerWU.SYMMETRIZE_RULE
					prop_category = MultilayerWU.SYMMETRIZE_RULE_CATEGORY;
				case MultilayerWU.SEMIPOSITIVIZE_RULE
					prop_category = MultilayerWU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultilayerWU.STANDARDIZE_RULE
					prop_category = MultilayerWU.STANDARDIZE_RULE_CATEGORY;
				case MultilayerWU.ATTEMPTSPEREDGE
					prop_category = MultilayerWU.ATTEMPTSPEREDGE_CATEGORY;
				case MultilayerWU.NUMBEROFWEIGHTS
					prop_category = MultilayerWU.NUMBEROFWEIGHTS_CATEGORY;
				case MultilayerWU.RANDOMIZATION
					prop_category = MultilayerWU.RANDOMIZATION_CATEGORY;
				otherwise
					prop_category = getPropCategory@Graph(prop);
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
			%  FORMAT = G.GETPROPFORMAT(POINTER) returns format of POINTER of G.
			%  FORMAT = Element.GETPROPFORMAT(MultilayerWU, POINTER) returns format of POINTER of MultilayerWU.
			%  FORMAT = G.GETPROPFORMAT(MultilayerWU, POINTER) returns format of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B
					prop_format = MultilayerWU.B_FORMAT;
				case MultilayerWU.SYMMETRIZE_RULE
					prop_format = MultilayerWU.SYMMETRIZE_RULE_FORMAT;
				case MultilayerWU.SEMIPOSITIVIZE_RULE
					prop_format = MultilayerWU.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultilayerWU.STANDARDIZE_RULE
					prop_format = MultilayerWU.STANDARDIZE_RULE_FORMAT;
				case MultilayerWU.ATTEMPTSPEREDGE
					prop_format = MultilayerWU.ATTEMPTSPEREDGE_FORMAT;
				case MultilayerWU.NUMBEROFWEIGHTS
					prop_format = MultilayerWU.NUMBEROFWEIGHTS_FORMAT;
				case MultilayerWU.RANDOMIZATION
					prop_format = MultilayerWU.RANDOMIZATION_FORMAT;
				otherwise
					prop_format = getPropFormat@Graph(prop);
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
			%  DESCRIPTION = G.GETPROPDESCRIPTION(POINTER) returns description of POINTER of G.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerWU, POINTER) returns description of POINTER of MultilayerWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerWU, POINTER) returns description of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.';
				case MultilayerWU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case MultilayerWU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultilayerWU.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case MultilayerWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultilayerWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case MultilayerWU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultilayerWU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MultilayerWU.NAME
					prop_description = 'NAME (constant, string) is the name of the multilayer weighted undirected graph.';
				case MultilayerWU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multilayer weighted undirected graph.';
				case MultilayerWU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multilayer weighted undirected graph.';
				case MultilayerWU.ID
					prop_description = 'ID (data, string) is a few-letter code for the multilayer weighted undirected graph.';
				case MultilayerWU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multilayer weighted undirected graph.';
				case MultilayerWU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multilayer weighted undirected graph.';
				case MultilayerWU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.';
				case MultilayerWU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case MultilayerWU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultilayerWU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultilayerWU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultilayerWU.A
					prop_description = 'A (result, cell) is the cell containing the weighted supra-adjacency matrix of the multilayer weighted undirected graph.';
				case MultilayerWU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultilayerWU.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				otherwise
					prop_description = getPropDescription@Graph(prop);
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
			%  SETTINGS = G.GETPROPSETTINGS(POINTER) returns settings of POINTER of G.
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerWU, POINTER) returns settings of POINTER of MultilayerWU.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerWU, POINTER) returns settings of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerWU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case MultilayerWU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultilayerWU.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case MultilayerWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerWU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerWU.TEMPLATE
					prop_settings = 'MultilayerWU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerWU, POINTER) returns the default value of POINTER of MultilayerWU.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerWU, POINTER) returns the default value of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B
					prop_default = {[] []; [] []};
				case MultilayerWU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultilayerWU.NUMBEROFWEIGHTS
					prop_default = 10;
				case MultilayerWU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.ELCLASS
					prop_default = 'MultilayerWU';
				case MultilayerWU.NAME
					prop_default = 'MultilayerWU';
				case MultilayerWU.DESCRIPTION
					prop_default = 'In a multilayer weighted undirected (WU) graph, layers could have different number of nodes with within-layer weighted undirected edges, associated with a real number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric (within layer). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and standardized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.';
				case MultilayerWU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.ID
					prop_default = 'MultilayerWU ID';
				case MultilayerWU.LABEL
					prop_default = 'MultilayerWU label';
				case MultilayerWU.NOTES
					prop_default = 'MultilayerWU notes';
				case MultilayerWU.GRAPH_TYPE
					prop_default = Graph.MULTILAYER;
				case MultilayerWU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultilayerWU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerWU, POINTER) returns the conditioned default value of POINTER of MultilayerWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerWU, POINTER) returns the conditioned default value of POINTER of MultilayerWU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			prop_default = MultilayerWU.conditioning(prop, MultilayerWU.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = G.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = G.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of G.
			%  CHECK = Element.CHECKPROP(MultilayerWU, PROP, VALUE) checks VALUE format for PROP of MultilayerWU.
			%  CHECK = G.CHECKPROP(MultilayerWU, PROP, VALUE) checks VALUE format for PROP of MultilayerWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerWU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultilayerWU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerWU.
			%   Error id: €BRAPH2.STR€:MultilayerWU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultilayerWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerWU.
			%   Error id: €BRAPH2.STR€:MultilayerWU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerWU.getPropProp(pointer);
			
			switch prop
				case MultilayerWU.B % __MultilayerWU.B__
					check = Format.checkFormat(Format.CELL, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.SYMMETRIZE_RULE % __MultilayerWU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.SEMIPOSITIVIZE_RULE % __MultilayerWU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.STANDARDIZE_RULE % __MultilayerWU.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.ATTEMPTSPEREDGE % __MultilayerWU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.NUMBEROFWEIGHTS % __MultilayerWU.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.RANDOMIZATION % __MultilayerWU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultilayerWU.getPropSettings(prop));
				case MultilayerWU.TEMPLATE % __MultilayerWU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerWU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerWU.getPropTag(prop) ' (' MultilayerWU.getFormatTag(MultilayerWU.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop, varargin)
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
				case MultilayerWU.RANDOMIZATION % __MultilayerWU.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    tmp_g = GraphWU();
					    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    tmp_g.set('NUMBEROFWEIGHTS', g.get('NUMBEROFWEIGHTS'));
					    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case MultilayerWU.CONNECTIVITY_TYPE % __MultilayerWU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case MultilayerWU.DIRECTIONALITY_TYPE % __MultilayerWU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultilayerWU.SELFCONNECTIVITY_TYPE % __MultilayerWU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultilayerWU.NEGATIVITY_TYPE % __MultilayerWU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultilayerWU.A % __MultilayerWU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerWU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					for i = 1:1:L
					    M = symmetrize(B{i,i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{i, i})        
					        for j = i+1:1:L
					            M = semipositivize(B{i, j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
					            A(i, j) = {M};
					            M = semipositivize(B{j, i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
					            A(j, i) = {M};
					        end
					    end
					end
					
					if g.get('GRAPH_TYPE') ~= 6
					
					else
					    if g.get('RANDOMIZE')
					        A = g.get('RANDOMIZATION', A);
					    end
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultilayerWU.ALAYERLABELS % __MultilayerWU.ALAYERLABELS__
					alayerlabels = g.get('LAYERLABELS');
					if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
					end
					value = alayerlabels;
					
				otherwise
					if prop <= Graph.getPropNumber()
						value = calculateValue@Graph(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(g, prop, varargin)
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
				case MultilayerWU.B % __MultilayerWU.B__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultilayerWU.A % __MultilayerWU.A__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerWU.A, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XYSLIDERLOCK', true, ... 
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', true, ...
					    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					    'YSLIDERWIDTH', s(5), ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Graph(g, prop, varargin{:});
					
			end
		end
	end
end
