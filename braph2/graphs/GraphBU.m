classdef GraphBU < Graph
	%GraphBU is a binary undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a binary undirected graph (GraphBU) , the edges are undirected and can be 
	%  either 0 (absence of connection) or 1 (existence of connection).
	% The connectivity matrix is symmetric.
	%
	% GraphBU methods (constructor):
	%  GraphBU - constructor
	%
	% GraphBU methods:
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
	% GraphBU methods (display):
	%  tostring - string with information about the binary undirected graph
	%  disp - displays information about the binary undirected graph
	%  tree - displays the tree of the binary undirected graph
	%
	% GraphBU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected graph
	%
	% GraphBU methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected graph as b2 file
	%  load - loads a BRAPH2 binary undirected graph from a b2 file
	%
	% GraphBU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected graph
	%
	% GraphBU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected graph
	%
	% GraphBU methods (inspection, Static):
	%  getClass - returns the class of the binary undirected graph
	%  getSubclasses - returns all subclasses of GraphBU
	%  getProps - returns the property list of the binary undirected graph
	%  getPropNumber - returns the property number of the binary undirected graph
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
	% GraphBU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphBU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphBU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphBU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphBU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphBU constants</a>.
	%
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'B';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.SMATRIX;
		
		SYMMETRIZE_RULE = Graph.getPropNumber() + 2;
		SYMMETRIZE_RULE_TAG = 'SYMMETRIZE_RULE';
		SYMMETRIZE_RULE_CATEGORY = Category.PARAMETER;
		SYMMETRIZE_RULE_FORMAT = Format.OPTION;
		
		SEMIPOSITIVIZE_RULE = Graph.getPropNumber() + 3;
		SEMIPOSITIVIZE_RULE_TAG = 'SEMIPOSITIVIZE_RULE';
		SEMIPOSITIVIZE_RULE_CATEGORY = Category.PARAMETER;
		SEMIPOSITIVIZE_RULE_FORMAT = Format.OPTION;
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 4;
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		RANDOMIZATION = Graph.getPropNumber() + 5;
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = Category.QUERY;
		RANDOMIZATION_FORMAT = Format.CELL;
	end
	methods % constructor
		function g = GraphBU(varargin)
			%GraphBU() creates a binary undirected graph.
			%
			% GraphBU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphBU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the binary undirected graph.
			%
			% CLASS = GraphBU.GETCLASS() returns the class 'GraphBU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('GraphBU') returns 'GraphBU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('GraphBU')
			%  are less computationally efficient.
			
			g_class = 'GraphBU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected graph.
			%
			% LIST = GraphBU.GETSUBCLASSES() returns all subclasses of 'GraphBU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('GraphBU') returns all subclasses of 'GraphBU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('GraphBU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphBU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected graph.
			%
			% PROPS = GraphBU.GETPROPS() returns the property list of binary undirected graph
			%  as a row vector.
			%
			% PROPS = GraphBU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('GraphBU'[, CATEGORY]) returns the property list of 'GraphBU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						GraphBU.B ...
						GraphBU.SYMMETRIZE_RULE ...
						GraphBU.SEMIPOSITIVIZE_RULE ...
						GraphBU.ATTEMPTSPEREDGE ...
						GraphBU.RANDOMIZATION ...
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
						GraphBU.SYMMETRIZE_RULE ...
						GraphBU.SEMIPOSITIVIZE_RULE ...
						GraphBU.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						GraphBU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						GraphBU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of binary undirected graph.
			%
			% N = GraphBU.GETPROPNUMBER() returns the property number of binary undirected graph.
			%
			% N = GraphBU.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('GraphBU') returns the property number of 'GraphBU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('GraphBU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphBU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected graph/error.
			%
			% CHECK = GraphBU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(GraphBU, PROP) checks whether PROP exists for GraphBU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%  Element.EXISTSPROP(GraphBU, PROP) throws error if PROP does NOT exist for GraphBU.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('GraphBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphBU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphBU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected graph/error.
			%
			% CHECK = GraphBU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(GraphBU, TAG) checks whether TAG exists for GraphBU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%  Element.EXISTSTAG(GraphBU, TAG) throws error if TAG does NOT exist for GraphBU.
			%   Error id: [BRAPH2:GraphBU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('GraphBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphbu_tag_list = cellfun(@(x) GraphBU.getPropTag(x), num2cell(GraphBU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphbu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphBU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphBU, POINTER) returns property number of POINTER of GraphBU.
			%  PROPERTY = G.GETPROPPROP(GraphBU, POINTER) returns property number of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphbu_tag_list = cellfun(@(x) GraphBU.getPropTag(x), num2cell(GraphBU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphbu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GraphBU, POINTER) returns tag of POINTER of GraphBU.
			%  TAG = G.GETPROPTAG(GraphBU, POINTER) returns tag of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphBU.B
						tag = GraphBU.B_TAG;
					case GraphBU.SYMMETRIZE_RULE
						tag = GraphBU.SYMMETRIZE_RULE_TAG;
					case GraphBU.SEMIPOSITIVIZE_RULE
						tag = GraphBU.SEMIPOSITIVIZE_RULE_TAG;
					case GraphBU.ATTEMPTSPEREDGE
						tag = GraphBU.ATTEMPTSPEREDGE_TAG;
					case GraphBU.RANDOMIZATION
						tag = GraphBU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphBU, POINTER) returns category of POINTER of GraphBU.
			%  CATEGORY = G.GETPROPCATEGORY(GraphBU, POINTER) returns category of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('GraphBU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B
					prop_category = GraphBU.B_CATEGORY;
				case GraphBU.SYMMETRIZE_RULE
					prop_category = GraphBU.SYMMETRIZE_RULE_CATEGORY;
				case GraphBU.SEMIPOSITIVIZE_RULE
					prop_category = GraphBU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case GraphBU.ATTEMPTSPEREDGE
					prop_category = GraphBU.ATTEMPTSPEREDGE_CATEGORY;
				case GraphBU.RANDOMIZATION
					prop_category = GraphBU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GraphBU, POINTER) returns format of POINTER of GraphBU.
			%  FORMAT = G.GETPROPFORMAT(GraphBU, POINTER) returns format of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('GraphBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B
					prop_format = GraphBU.B_FORMAT;
				case GraphBU.SYMMETRIZE_RULE
					prop_format = GraphBU.SYMMETRIZE_RULE_FORMAT;
				case GraphBU.SEMIPOSITIVIZE_RULE
					prop_format = GraphBU.SEMIPOSITIVIZE_RULE_FORMAT;
				case GraphBU.ATTEMPTSPEREDGE
					prop_format = GraphBU.ATTEMPTSPEREDGE_FORMAT;
				case GraphBU.RANDOMIZATION
					prop_format = GraphBU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphBU, POINTER) returns description of POINTER of GraphBU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(GraphBU, POINTER) returns description of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B
					prop_description = 'B (data, smatrix) is the input graph adjacency matrix.';
				case GraphBU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case GraphBU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case GraphBU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case GraphBU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case GraphBU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected graph.';
				case GraphBU.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected graph.';
				case GraphBU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected graph.';
				case GraphBU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected graph.';
				case GraphBU.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected graph.';
				case GraphBU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected graph.';
				case GraphBU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected graph.';
				case GraphBU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.';
				case GraphBU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__.';
				case GraphBU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__.';
				case GraphBU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.';
				case GraphBU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.';
				case GraphBU.A
					prop_description = 'A (result, cell) is the symmetric binary adjacency matrix of the binary undirected graph.';
				case GraphBU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphBU, POINTER) returns settings of POINTER of GraphBU.
			%  SETTINGS = G.GETPROPSETTINGS(GraphBU, POINTER) returns settings of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case GraphBU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case GraphBU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case GraphBU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GraphBU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GraphBU.TEMPLATE
					prop_settings = 'GraphBU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphBU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphBU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphBU, POINTER) returns the default value of POINTER of GraphBU.
			%  DEFAULT = G.GETPROPDEFAULT(GraphBU, POINTER) returns the default value of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('GraphBU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B
					prop_default = Format.getFormatDefault(Format.SMATRIX, GraphBU.getPropSettings(prop));
				case GraphBU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphBU.getPropSettings(prop));
				case GraphBU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphBU.getPropSettings(prop));
				case GraphBU.ATTEMPTSPEREDGE
					prop_default = 5;
				case GraphBU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, GraphBU.getPropSettings(prop));
				case GraphBU.ELCLASS
					prop_default = 'GraphBU';
				case GraphBU.NAME
					prop_default = 'Graph Binary Undirected';
				case GraphBU.DESCRIPTION
					prop_default = 'In a binary undirected graph (GraphBU), the edges are undirected and can be either 0 (absence of connection) or 1 (existence of connection). The connectivity matrix is symmetric.';
				case GraphBU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphBU.getPropSettings(prop));
				case GraphBU.ID
					prop_default = 'GraphBU ID';
				case GraphBU.LABEL
					prop_default = 'GraphBU label';
				case GraphBU.NOTES
					prop_default = 'GraphBU notes';
				case GraphBU.GRAPH_TYPE
					prop_default = Graph.GRAPH;
				case GraphBU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('GraphBU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphBU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphBU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphBU, POINTER) returns the conditioned default value of POINTER of GraphBU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(GraphBU, POINTER) returns the conditioned default value of POINTER of GraphBU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('GraphBU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphBU.getPropProp(pointer);
			
			prop_default = GraphBU.conditioning(prop, GraphBU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GraphBU, PROP, VALUE) checks VALUE format for PROP of GraphBU.
			%  CHECK = G.CHECKPROP(GraphBU, PROP, VALUE) checks VALUE format for PROP of GraphBU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphBU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:GraphBU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphBU.
			%   Error id: €BRAPH2.STR€:GraphBU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(GraphBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphBU.
			%   Error id: €BRAPH2.STR€:GraphBU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('GraphBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphBU.getPropProp(pointer);
			
			switch prop
				case GraphBU.B % __GraphBU.B__
					check = Format.checkFormat(Format.SMATRIX, value, GraphBU.getPropSettings(prop));
				case GraphBU.SYMMETRIZE_RULE % __GraphBU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphBU.getPropSettings(prop));
				case GraphBU.SEMIPOSITIVIZE_RULE % __GraphBU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphBU.getPropSettings(prop));
				case GraphBU.ATTEMPTSPEREDGE % __GraphBU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, GraphBU.getPropSettings(prop));
				case GraphBU.RANDOMIZATION % __GraphBU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, GraphBU.getPropSettings(prop));
				case GraphBU.TEMPLATE % __GraphBU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphBU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphBU.getPropTag(prop) ' (' GraphBU.getFormatTag(GraphBU.getPropFormat(prop)) ').'] ...
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
				case GraphBU.RANDOMIZATION % __GraphBU.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = cell2mat(varargin{1});
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					% remove self connections
					A(1:length(A) + 1:numel(A)) = 0;
					[I_edges, J_edges] = find(triu(A)); % find the edges
					E = length(I_edges); % number of edges
					
					if E == 0
					    value = A;
					    swaps = 0;
					    return
					end
					
					if E == 1
					    r_ab_1 = A(I_edges(1), J_edges(1));
					    r_ab_2 = A(J_edges(1), I_edges(1));
					    A(I_edges(1), J_edges(1)) = 0;
					    A(J_edges(1), I_edges(1)) = 0;
					    selected_nodes = randperm(size(A, 1), 2);
					    A(selected_nodes(1), selected_nodes(2)) = r_ab_1;
					    A(selected_nodes(2), selected_nodes(1)) = r_ab_2;
					    value = A;
					    swaps = 1;
					    return
					end
					
					random_A = A;
					swaps = 0; % number of successful edge swaps
					for attempt = 1:1:attempts_per_edge * E
					
					    % select two edges
					    selected_edges = randperm(E, 2);
					    node_start_1 = I_edges(selected_edges(1));
					    node_end_1 = J_edges(selected_edges(1));
					    node_start_2 = I_edges(selected_edges(2));
					    node_end_2 = J_edges(selected_edges(2));
					
					    if rand(1) > .5
					        I_edges(selected_edges(2)) = node_end_2;
					        J_edges(selected_edges(2)) = node_start_2;
					
					        node_start_2 = I_edges(selected_edges(2));
					        node_end_2 = J_edges(selected_edges(2));
					    end
					
					    r_1 = random_A(node_start_1, node_end_1);
					    r_3 = random_A(node_end_1, node_start_1);
					    r_2 = random_A(node_start_2, node_end_2);
					    r_4 = random_A(node_end_2, node_start_2);
					
					    % Swap edges if:
					    % 1) no edge between node_start_1 and node_end_2
					    % 2) no edge between node_start_2 and node_end_1
					    % 3) node_start_1 ~= node_start_2
					    % 4) node_end_1 ~= node_end_2
					    % 5) node_start_1 ~= node_end_2
					    % 6) node_start_2 ~= node_end_1
					
					    if ~random_A(node_start_1, node_end_2) && ...
					            ~random_A(node_start_2, node_end_1) && ...
					            node_start_1 ~= node_start_2 && ...
					            node_end_1 ~= node_end_2 && ...
					            node_start_1 ~= node_end_2 && ...
					            node_start_2 ~= node_end_1
					
					        % erase old edges
					        random_A(node_start_1, node_end_1) = 0;
					        random_A(node_end_1, node_start_1) = 0;
					
					        random_A(node_start_2, node_end_2) = 0;
					        random_A(node_end_2, node_start_2) = 0;
					
					        % write new edges
					
					        random_A(node_start_1, node_end_2) = r_1;
					        random_A(node_end_2, node_start_1) = r_3;
					
					        random_A(node_start_2, node_end_1) = r_2;
					        random_A(node_end_1, node_start_2) = r_4;
					
					        % update edge list
					        J_edges(selected_edges(1)) = node_end_2;
					        J_edges(selected_edges(2)) = node_end_1;
					
					        swaps = swaps + 1;
					    end
					end
					value = random_A;
					
				case GraphBU.CONNECTIVITY_TYPE % __GraphBU.CONNECTIVITY_TYPE__
					value = Graph.BINARY;
					
				case GraphBU.DIRECTIONALITY_TYPE % __GraphBU.DIRECTIONALITY_TYPE__
					value = Graph.UNDIRECTED;
					
				case GraphBU.SELFCONNECTIVITY_TYPE % __GraphBU.SELFCONNECTIVITY_TYPE__
					value = Graph.NONSELFCONNECTED;
					
				case GraphBU.NEGATIVITY_TYPE % __GraphBU.NEGATIVITY_TYPE__
					value = Graph.NONNEGATIVE;
					
				case GraphBU.A % __GraphBU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(GraphBU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					
					B = symmetrize(B, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
					B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
					B = binarize(B); %#ok<PROPLC> % enforces binary adjacency matrix, equivalent to binarize(B, 'threshold', 0, 'bins', [-1:.001:1])
					
					A = {B}; %#ok<PROPLC>
					if g.get('RANDOMIZE')
					    random_A = g.get('RANDOMIZATION', A);
					    A = {random_A};
					end
					value = A;
					
					rng(rng_settings_)
					
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
				case GraphBU.B % __GraphBU.B__
					pr = PanelPropMatrix('EL', g, 'PROP', GraphBU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case GraphBU.A % __GraphBU.A__
					pr = PanelPropCell('EL', g, 'PROP', GraphBU.A, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Graph(g, prop, varargin{:});
					
			end
		end
	end
end
