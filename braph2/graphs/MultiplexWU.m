classdef MultiplexWU < Graph
	%MultiplexWU is a multiplex weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multiplex weighted undirected graph (MultiplexWU), all layers have the same number 
	%  of nodes with within-layer weighted undirected edges, associated with a real 
	%  number between 0 and 1 and indicating the strength of the connection.
	% The connectivity matrices are symmetric.
	% There are connections between layers connecting the corresponding nodes.
	%
	% MultiplexWU methods (constructor):
	%  MultiplexWU - constructor
	%
	% MultiplexWU methods:
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
	% MultiplexWU methods (display):
	%  tostring - string with information about the multiplex weighted undirected graph
	%  disp - displays information about the multiplex weighted undirected graph
	%  tree - displays the tree of the multiplex weighted undirected graph
	%
	% MultiplexWU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex weighted undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex weighted undirected graph
	%
	% MultiplexWU methods (save/load, Static):
	%  save - saves BRAPH2 multiplex weighted undirected graph as b2 file
	%  load - loads a BRAPH2 multiplex weighted undirected graph from a b2 file
	%
	% MultiplexWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex weighted undirected graph
	%
	% MultiplexWU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex weighted undirected graph
	%
	% MultiplexWU methods (inspection, Static):
	%  getClass - returns the class of the multiplex weighted undirected graph
	%  getSubclasses - returns all subclasses of MultiplexWU
	%  getProps - returns the property list of the multiplex weighted undirected graph
	%  getPropNumber - returns the property number of the multiplex weighted undirected graph
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
	% MultiplexWU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexWU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexWU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexWU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexWU constants</a>.
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
		function g = MultiplexWU(varargin)
			%MultiplexWU() creates a multiplex weighted undirected graph.
			%
			% MultiplexWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexWU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex weighted undirected graph.
			%
			% CLASS = MultiplexWU.GETCLASS() returns the class 'MultiplexWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multiplex weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultiplexWU') returns 'MultiplexWU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultiplexWU')
			%  are less computationally efficient.
			
			g_class = 'MultiplexWU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex weighted undirected graph.
			%
			% LIST = MultiplexWU.GETSUBCLASSES() returns all subclasses of 'MultiplexWU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multiplex weighted undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultiplexWU') returns all subclasses of 'MultiplexWU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexWU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex weighted undirected graph.
			%
			% PROPS = MultiplexWU.GETPROPS() returns the property list of multiplex weighted undirected graph
			%  as a row vector.
			%
			% PROPS = MultiplexWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multiplex weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultiplexWU'[, CATEGORY]) returns the property list of 'MultiplexWU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultiplexWU.B ...
						MultiplexWU.SYMMETRIZE_RULE ...
						MultiplexWU.SEMIPOSITIVIZE_RULE ...
						MultiplexWU.STANDARDIZE_RULE ...
						MultiplexWU.ATTEMPTSPEREDGE ...
						MultiplexWU.NUMBEROFWEIGHTS ...
						MultiplexWU.RANDOMIZATION ...
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
						MultiplexWU.SYMMETRIZE_RULE ...
						MultiplexWU.SEMIPOSITIVIZE_RULE ...
						MultiplexWU.STANDARDIZE_RULE ...
						MultiplexWU.ATTEMPTSPEREDGE ...
						MultiplexWU.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultiplexWU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultiplexWU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of multiplex weighted undirected graph.
			%
			% N = MultiplexWU.GETPROPNUMBER() returns the property number of multiplex weighted undirected graph.
			%
			% N = MultiplexWU.GETPROPNUMBER(CATEGORY) returns the property number of multiplex weighted undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultiplexWU') returns the property number of 'MultiplexWU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexWU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex weighted undirected graph/error.
			%
			% CHECK = MultiplexWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultiplexWU, PROP) checks whether PROP exists for MultiplexWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%  Element.EXISTSPROP(MultiplexWU, PROP) throws error if PROP does NOT exist for MultiplexWU.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexWU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexWU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex weighted undirected graph/error.
			%
			% CHECK = MultiplexWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultiplexWU, TAG) checks whether TAG exists for MultiplexWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%  Element.EXISTSTAG(MultiplexWU, TAG) throws error if TAG does NOT exist for MultiplexWU.
			%   Error id: [BRAPH2:MultiplexWU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexwu_tag_list = cellfun(@(x) MultiplexWU.getPropTag(x), num2cell(MultiplexWU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexwu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexWU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexWU, POINTER) returns property number of POINTER of MultiplexWU.
			%  PROPERTY = G.GETPROPPROP(MultiplexWU, POINTER) returns property number of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexwu_tag_list = cellfun(@(x) MultiplexWU.getPropTag(x), num2cell(MultiplexWU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexwu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexWU, POINTER) returns tag of POINTER of MultiplexWU.
			%  TAG = G.GETPROPTAG(MultiplexWU, POINTER) returns tag of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexWU.B
						tag = MultiplexWU.B_TAG;
					case MultiplexWU.SYMMETRIZE_RULE
						tag = MultiplexWU.SYMMETRIZE_RULE_TAG;
					case MultiplexWU.SEMIPOSITIVIZE_RULE
						tag = MultiplexWU.SEMIPOSITIVIZE_RULE_TAG;
					case MultiplexWU.STANDARDIZE_RULE
						tag = MultiplexWU.STANDARDIZE_RULE_TAG;
					case MultiplexWU.ATTEMPTSPEREDGE
						tag = MultiplexWU.ATTEMPTSPEREDGE_TAG;
					case MultiplexWU.NUMBEROFWEIGHTS
						tag = MultiplexWU.NUMBEROFWEIGHTS_TAG;
					case MultiplexWU.RANDOMIZATION
						tag = MultiplexWU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexWU, POINTER) returns category of POINTER of MultiplexWU.
			%  CATEGORY = G.GETPROPCATEGORY(MultiplexWU, POINTER) returns category of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B
					prop_category = MultiplexWU.B_CATEGORY;
				case MultiplexWU.SYMMETRIZE_RULE
					prop_category = MultiplexWU.SYMMETRIZE_RULE_CATEGORY;
				case MultiplexWU.SEMIPOSITIVIZE_RULE
					prop_category = MultiplexWU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultiplexWU.STANDARDIZE_RULE
					prop_category = MultiplexWU.STANDARDIZE_RULE_CATEGORY;
				case MultiplexWU.ATTEMPTSPEREDGE
					prop_category = MultiplexWU.ATTEMPTSPEREDGE_CATEGORY;
				case MultiplexWU.NUMBEROFWEIGHTS
					prop_category = MultiplexWU.NUMBEROFWEIGHTS_CATEGORY;
				case MultiplexWU.RANDOMIZATION
					prop_category = MultiplexWU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexWU, POINTER) returns format of POINTER of MultiplexWU.
			%  FORMAT = G.GETPROPFORMAT(MultiplexWU, POINTER) returns format of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B
					prop_format = MultiplexWU.B_FORMAT;
				case MultiplexWU.SYMMETRIZE_RULE
					prop_format = MultiplexWU.SYMMETRIZE_RULE_FORMAT;
				case MultiplexWU.SEMIPOSITIVIZE_RULE
					prop_format = MultiplexWU.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultiplexWU.STANDARDIZE_RULE
					prop_format = MultiplexWU.STANDARDIZE_RULE_FORMAT;
				case MultiplexWU.ATTEMPTSPEREDGE
					prop_format = MultiplexWU.ATTEMPTSPEREDGE_FORMAT;
				case MultiplexWU.NUMBEROFWEIGHTS
					prop_format = MultiplexWU.NUMBEROFWEIGHTS_FORMAT;
				case MultiplexWU.RANDOMIZATION
					prop_format = MultiplexWU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexWU, POINTER) returns description of POINTER of MultiplexWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultiplexWU, POINTER) returns description of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.';
				case MultiplexWU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case MultiplexWU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultiplexWU.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case MultiplexWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultiplexWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case MultiplexWU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultiplexWU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the multiplex weighted undirected graph.';
				case MultiplexWU.NAME
					prop_description = 'NAME (constant, string) is the name of the multiplex weighted undirected graph.';
				case MultiplexWU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multiplex weighted undirected graph.';
				case MultiplexWU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multiplex weighted undirected graph.';
				case MultiplexWU.ID
					prop_description = 'ID (data, string) is a few-letter code for the multiplex weighted undirected graph.';
				case MultiplexWU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multiplex weighted undirected graph.';
				case MultiplexWU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multiplex weighted undirected graphh.';
				case MultiplexWU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.';
				case MultiplexWU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case MultiplexWU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultiplexWU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultiplexWU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultiplexWU.A
					prop_description = 'A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.';
				case MultiplexWU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultiplexWU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexWU, POINTER) returns settings of POINTER of MultiplexWU.
			%  SETTINGS = G.GETPROPSETTINGS(MultiplexWU, POINTER) returns settings of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexWU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case MultiplexWU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultiplexWU.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case MultiplexWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultiplexWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultiplexWU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexWU.TEMPLATE
					prop_settings = 'MultiplexWU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexWU, POINTER) returns the default value of POINTER of MultiplexWU.
			%  DEFAULT = G.GETPROPDEFAULT(MultiplexWU, POINTER) returns the default value of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B
					prop_default = {[] []};
				case MultiplexWU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultiplexWU.NUMBEROFWEIGHTS
					prop_default = 10;
				case MultiplexWU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.ELCLASS
					prop_default = 'MultiplexWU';
				case MultiplexWU.NAME
					prop_default = 'Multiplex Weighted Undirected';
				case MultiplexWU.DESCRIPTION
					prop_default = 'In a multiplex weighted undirected graph (MultiplexWU), all layers have the same number of nodes with within-layer weighted undirected edges, associated with a real number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric. There are connections between layers connecting the corresponding nodes.';
				case MultiplexWU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.ID
					prop_default = 'MultiplexWU ID';
				case MultiplexWU.LABEL
					prop_default = 'MultiplexWU label';
				case MultiplexWU.NOTES
					prop_default = 'MultiplexWU notes';
				case MultiplexWU.GRAPH_TYPE
					prop_default = Graph.MULTIPLEX;
				case MultiplexWU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultiplexWU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexWU, POINTER) returns the conditioned default value of POINTER of MultiplexWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultiplexWU, POINTER) returns the conditioned default value of POINTER of MultiplexWU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			prop_default = MultiplexWU.conditioning(prop, MultiplexWU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexWU, PROP, VALUE) checks VALUE format for PROP of MultiplexWU.
			%  CHECK = G.CHECKPROP(MultiplexWU, PROP, VALUE) checks VALUE format for PROP of MultiplexWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexWU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultiplexWU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexWU.
			%   Error id: €BRAPH2.STR€:MultiplexWU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultiplexWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexWU.
			%   Error id: €BRAPH2.STR€:MultiplexWU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultiplexWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexWU.getPropProp(pointer);
			
			switch prop
				case MultiplexWU.B % __MultiplexWU.B__
					check = Format.checkFormat(Format.CELL, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.SYMMETRIZE_RULE % __MultiplexWU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.SEMIPOSITIVIZE_RULE % __MultiplexWU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.STANDARDIZE_RULE % __MultiplexWU.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.ATTEMPTSPEREDGE % __MultiplexWU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.NUMBEROFWEIGHTS % __MultiplexWU.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.RANDOMIZATION % __MultiplexWU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultiplexWU.getPropSettings(prop));
				case MultiplexWU.TEMPLATE % __MultiplexWU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexWU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexWU.getPropTag(prop) ' (' MultiplexWU.getFormatTag(MultiplexWU.getPropFormat(prop)) ').'] ...
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
				case MultiplexWU.RANDOMIZATION % __MultiplexWU.RANDOMIZATION__
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
					
				case MultiplexWU.CONNECTIVITY_TYPE % __MultiplexWU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case MultiplexWU.DIRECTIONALITY_TYPE % __MultiplexWU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultiplexWU.SELFCONNECTIVITY_TYPE % __MultiplexWU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultiplexWU.NEGATIVITY_TYPE % __MultiplexWU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultiplexWU.A % __MultiplexWU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexWU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = symmetrize(B{i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % enforces binary adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{1, 1})
					        for j = i+1:1:L
					            A(i, j) = {eye(length(A{1, 1}))};
					            A(j, i) = {eye(length(A{1, 1}))};
					        end
					    end
					end
					
					if g.get('GRAPH_TYPE') ~= 4
					
					else
					    if g.get('RANDOMIZE')
					        A = g.get('RANDOMIZATION', A);
					    end
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultiplexWU.ALAYERLABELS % __MultiplexWU.ALAYERLABELS__
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
				case MultiplexWU.B % __MultiplexWU.B__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexWU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultiplexWU.A % __MultiplexWU.A__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexWU.A, ...
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
