classdef MultilayerWD < Graph
	%MultilayerWD is a multilayer weighted directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multilayer weighted directed graph (MultilayerWD) , layers could have different number 
	% of nodes with within-layer weighted directed edges, associated with a real
	% number between 0 and 1 and indicating the strength of the connection.
	% The connectivity matrices are symmetric (within layer).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and standardized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.
	%
	% MultilayerWD methods (constructor):
	%  MultilayerWD - constructor
	%
	% MultilayerWD methods:
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
	% MultilayerWD methods (display):
	%  tostring - string with information about the multilayer weighted directed graph
	%  disp - displays information about the multilayer weighted directed graph
	%  tree - displays the tree of the multilayer weighted directed graph
	%
	% MultilayerWD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer weighted directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer weighted directed graph
	%
	% MultilayerWD methods (save/load, Static):
	%  save - saves BRAPH2 multilayer weighted directed graph as b2 file
	%  load - loads a BRAPH2 multilayer weighted directed graph from a b2 file
	%
	% MultilayerWD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer weighted directed graph
	%
	% MultilayerWD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer weighted directed graph
	%
	% MultilayerWD methods (inspection, Static):
	%  getClass - returns the class of the multilayer weighted directed graph
	%  getSubclasses - returns all subclasses of MultilayerWD
	%  getProps - returns the property list of the multilayer weighted directed graph
	%  getPropNumber - returns the property number of the multilayer weighted directed graph
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
	% MultilayerWD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerWD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerWD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerWD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerWD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerWD constants</a>.
	%
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'B';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.CELL;
		
		SEMIPOSITIVIZE_RULE = Graph.getPropNumber() + 2;
		SEMIPOSITIVIZE_RULE_TAG = 'SEMIPOSITIVIZE_RULE';
		SEMIPOSITIVIZE_RULE_CATEGORY = Category.PARAMETER;
		SEMIPOSITIVIZE_RULE_FORMAT = Format.OPTION;
		
		STANDARDIZE_RULE = Graph.getPropNumber() + 3;
		STANDARDIZE_RULE_TAG = 'STANDARDIZE_RULE';
		STANDARDIZE_RULE_CATEGORY = Category.PARAMETER;
		STANDARDIZE_RULE_FORMAT = Format.OPTION;
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 4;
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		NUMBEROFWEIGHTS = Graph.getPropNumber() + 5;
		NUMBEROFWEIGHTS_TAG = 'NUMBEROFWEIGHTS';
		NUMBEROFWEIGHTS_CATEGORY = Category.PARAMETER;
		NUMBEROFWEIGHTS_FORMAT = Format.SCALAR;
		
		RANDOMIZATION = Graph.getPropNumber() + 6;
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = Category.QUERY;
		RANDOMIZATION_FORMAT = Format.CELL;
	end
	methods % constructor
		function g = MultilayerWD(varargin)
			%MultilayerWD() creates a multilayer weighted directed graph.
			%
			% MultilayerWD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerWD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multilayer weighted directed graph.
			%
			% CLASS = MultilayerWD.GETCLASS() returns the class 'MultilayerWD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer weighted directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerWD') returns 'MultilayerWD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerWD')
			%  are less computationally efficient.
			
			g_class = 'MultilayerWD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer weighted directed graph.
			%
			% LIST = MultilayerWD.GETSUBCLASSES() returns all subclasses of 'MultilayerWD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer weighted directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerWD') returns all subclasses of 'MultilayerWD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerWD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer weighted directed graph.
			%
			% PROPS = MultilayerWD.GETPROPS() returns the property list of multilayer weighted directed graph
			%  as a row vector.
			%
			% PROPS = MultilayerWD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer weighted directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerWD'[, CATEGORY]) returns the property list of 'MultilayerWD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultilayerWD.B ...
						MultilayerWD.SEMIPOSITIVIZE_RULE ...
						MultilayerWD.STANDARDIZE_RULE ...
						MultilayerWD.ATTEMPTSPEREDGE ...
						MultilayerWD.NUMBEROFWEIGHTS ...
						MultilayerWD.RANDOMIZATION ...
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
						MultilayerWD.SEMIPOSITIVIZE_RULE ...
						MultilayerWD.STANDARDIZE_RULE ...
						MultilayerWD.ATTEMPTSPEREDGE ...
						MultilayerWD.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultilayerWD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultilayerWD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of multilayer weighted directed graph.
			%
			% N = MultilayerWD.GETPROPNUMBER() returns the property number of multilayer weighted directed graph.
			%
			% N = MultilayerWD.GETPROPNUMBER(CATEGORY) returns the property number of multilayer weighted directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer weighted directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerWD') returns the property number of 'MultilayerWD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerWD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer weighted directed graph/error.
			%
			% CHECK = MultilayerWD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerWD, PROP) checks whether PROP exists for MultilayerWD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%  Element.EXISTSPROP(MultilayerWD, PROP) throws error if PROP does NOT exist for MultilayerWD.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerWD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerWD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer weighted directed graph/error.
			%
			% CHECK = MultilayerWD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerWD, TAG) checks whether TAG exists for MultilayerWD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%  Element.EXISTSTAG(MultilayerWD, TAG) throws error if TAG does NOT exist for MultilayerWD.
			%   Error id: [BRAPH2:MultilayerWD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerwd_tag_list = cellfun(@(x) MultilayerWD.getPropTag(x), num2cell(MultilayerWD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerwd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerWD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerWD, POINTER) returns property number of POINTER of MultilayerWD.
			%  PROPERTY = G.GETPROPPROP(MultilayerWD, POINTER) returns property number of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerwd_tag_list = cellfun(@(x) MultilayerWD.getPropTag(x), num2cell(MultilayerWD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerwd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerWD, POINTER) returns tag of POINTER of MultilayerWD.
			%  TAG = G.GETPROPTAG(MultilayerWD, POINTER) returns tag of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerWD.B
						tag = MultilayerWD.B_TAG;
					case MultilayerWD.SEMIPOSITIVIZE_RULE
						tag = MultilayerWD.SEMIPOSITIVIZE_RULE_TAG;
					case MultilayerWD.STANDARDIZE_RULE
						tag = MultilayerWD.STANDARDIZE_RULE_TAG;
					case MultilayerWD.ATTEMPTSPEREDGE
						tag = MultilayerWD.ATTEMPTSPEREDGE_TAG;
					case MultilayerWD.NUMBEROFWEIGHTS
						tag = MultilayerWD.NUMBEROFWEIGHTS_TAG;
					case MultilayerWD.RANDOMIZATION
						tag = MultilayerWD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerWD, POINTER) returns category of POINTER of MultilayerWD.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerWD, POINTER) returns category of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B
					prop_category = MultilayerWD.B_CATEGORY;
				case MultilayerWD.SEMIPOSITIVIZE_RULE
					prop_category = MultilayerWD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultilayerWD.STANDARDIZE_RULE
					prop_category = MultilayerWD.STANDARDIZE_RULE_CATEGORY;
				case MultilayerWD.ATTEMPTSPEREDGE
					prop_category = MultilayerWD.ATTEMPTSPEREDGE_CATEGORY;
				case MultilayerWD.NUMBEROFWEIGHTS
					prop_category = MultilayerWD.NUMBEROFWEIGHTS_CATEGORY;
				case MultilayerWD.RANDOMIZATION
					prop_category = MultilayerWD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerWD, POINTER) returns format of POINTER of MultilayerWD.
			%  FORMAT = G.GETPROPFORMAT(MultilayerWD, POINTER) returns format of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B
					prop_format = MultilayerWD.B_FORMAT;
				case MultilayerWD.SEMIPOSITIVIZE_RULE
					prop_format = MultilayerWD.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultilayerWD.STANDARDIZE_RULE
					prop_format = MultilayerWD.STANDARDIZE_RULE_FORMAT;
				case MultilayerWD.ATTEMPTSPEREDGE
					prop_format = MultilayerWD.ATTEMPTSPEREDGE_FORMAT;
				case MultilayerWD.NUMBEROFWEIGHTS
					prop_format = MultilayerWD.NUMBEROFWEIGHTS_FORMAT;
				case MultilayerWD.RANDOMIZATION
					prop_format = MultilayerWD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerWD, POINTER) returns description of POINTER of MultilayerWD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerWD, POINTER) returns description of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices.';
				case MultilayerWD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultilayerWD.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case MultilayerWD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultilayerWD.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case MultilayerWD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultilayerWD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the multilayer weighted directed graph.';
				case MultilayerWD.NAME
					prop_description = 'NAME (constant, string) is the name of the multilayer weighted directed graph.';
				case MultilayerWD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multilayer weighted directed graph.';
				case MultilayerWD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multilayer weighted directed graph.';
				case MultilayerWD.ID
					prop_description = 'ID (data, string) is a few-letter code for the multilayer weighted directed graph.';
				case MultilayerWD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multilayer weighted directed graph.';
				case MultilayerWD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multilayer weighted directed graph.';
				case MultilayerWD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.';
				case MultilayerWD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case MultilayerWD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case MultilayerWD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultilayerWD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultilayerWD.A
					prop_description = 'A (result, cell) is the cell containing the within-layer weighted adjacency matrices of the multilayer weighted directed graph and the connections between layers.';
				case MultilayerWD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultilayerWD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerWD, POINTER) returns settings of POINTER of MultilayerWD.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerWD, POINTER) returns settings of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerWD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultilayerWD.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case MultilayerWD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerWD.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerWD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerWD.TEMPLATE
					prop_settings = 'MultilayerWD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerWD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerWD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerWD, POINTER) returns the default value of POINTER of MultilayerWD.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerWD, POINTER) returns the default value of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B
					prop_default = {[] []; [] []};
				case MultilayerWD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultilayerWD.NUMBEROFWEIGHTS
					prop_default = 10;
				case MultilayerWD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.ELCLASS
					prop_default = 'MultilayerWD';
				case MultilayerWD.NAME
					prop_default = 'Multilayer Weighted Directed';
				case MultilayerWD.DESCRIPTION
					prop_default = 'In a multilayer weighted directed graph (MultilayerWD), layers could have different number  of nodes with within-layer weighted directed edges, associated with a real  number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric (within layer). All node connections are allowed between layers.On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and standardized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.';
				case MultilayerWD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.ID
					prop_default = 'MultilayerWD ID';
				case MultilayerWD.LABEL
					prop_default = 'MultilayerWD label';
				case MultilayerWD.NOTES
					prop_default = 'MultilayerWD notes';
				case MultilayerWD.GRAPH_TYPE
					prop_default = Graph.MULTILAYER;
				case MultilayerWD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultilayerWD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerWD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerWD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerWD, POINTER) returns the conditioned default value of POINTER of MultilayerWD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerWD, POINTER) returns the conditioned default value of POINTER of MultilayerWD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			prop_default = MultilayerWD.conditioning(prop, MultilayerWD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerWD, PROP, VALUE) checks VALUE format for PROP of MultilayerWD.
			%  CHECK = G.CHECKPROP(MultilayerWD, PROP, VALUE) checks VALUE format for PROP of MultilayerWD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerWD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultilayerWD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerWD.
			%   Error id: €BRAPH2.STR€:MultilayerWD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultilayerWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerWD.
			%   Error id: €BRAPH2.STR€:MultilayerWD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerWD.getPropProp(pointer);
			
			switch prop
				case MultilayerWD.B % __MultilayerWD.B__
					check = Format.checkFormat(Format.CELL, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.SEMIPOSITIVIZE_RULE % __MultilayerWD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.STANDARDIZE_RULE % __MultilayerWD.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.ATTEMPTSPEREDGE % __MultilayerWD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.NUMBEROFWEIGHTS % __MultilayerWD.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.RANDOMIZATION % __MultilayerWD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultilayerWD.getPropSettings(prop));
				case MultilayerWD.TEMPLATE % __MultilayerWD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerWD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerWD.getPropTag(prop) ' (' MultilayerWD.getFormatTag(MultilayerWD.getPropFormat(prop)) ').'] ...
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
				case MultilayerWD.RANDOMIZATION % __MultilayerWD.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    tmp_g = GraphWD();
					    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    tmp_g.set('NUMBEROFWEIGHTS', g.get('NUMBEROFWEIGHTS'));
					    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case MultilayerWD.CONNECTIVITY_TYPE % __MultilayerWD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case MultilayerWD.DIRECTIONALITY_TYPE % __MultilayerWD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case MultilayerWD.SELFCONNECTIVITY_TYPE % __MultilayerWD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultilayerWD.NEGATIVITY_TYPE % __MultilayerWD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultilayerWD.A % __MultilayerWD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerWD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					for i = 1:1:L
					    M = dediagonalize(B{i,i}); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE'));  % rescales adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{i, i})
					        for j = i+1:1:L
					            M = semipositivize(B{i,j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE'));  % rescales adjacency matrix
					            A(i, j) = {M};
					            M = semipositivize(B{j,i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE'));  % rescales adjacency matrix
					            A(j, i) = {M};
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultilayerWD.ALAYERLABELS % __MultilayerWD.ALAYERLABELS__
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
				case MultilayerWD.B % __MultilayerWD.B__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerWD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultilayerWD.A % __MultilayerWD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerWD.A, ...
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
