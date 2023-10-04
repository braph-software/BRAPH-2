classdef GraphWD < Graph
	%GraphWD is a weighted directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a weighted directed (WD) graph, the edges are directed and associated 
	%  with a real number between 0 and 1 indicating the strength of the connection.
	%
	% GraphWD methods (constructor):
	%  GraphWD - constructor
	%
	% GraphWD methods:
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
	% GraphWD methods (display):
	%  tostring - string with information about the weighted directed graph
	%  disp - displays information about the weighted directed graph
	%  tree - displays the tree of the weighted directed graph
	%
	% GraphWD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two weighted directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the weighted directed graph
	%
	% GraphWD methods (save/load, Static):
	%  save - saves BRAPH2 weighted directed graph as b2 file
	%  load - loads a BRAPH2 weighted directed graph from a b2 file
	%
	% GraphWD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the weighted directed graph
	%
	% GraphWD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the weighted directed graph
	%
	% GraphWD methods (inspection, Static):
	%  getClass - returns the class of the weighted directed graph
	%  getSubclasses - returns all subclasses of GraphWD
	%  getProps - returns the property list of the weighted directed graph
	%  getPropNumber - returns the property number of the weighted directed graph
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
	% GraphWD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphWD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphWD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphWD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphWD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphWD constants</a>.
	%
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'B';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.SMATRIX;
		
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
		function g = GraphWD(varargin)
			%GraphWD() creates a weighted directed graph.
			%
			% GraphWD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphWD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the weighted directed graph.
			%
			% CLASS = GraphWD.GETCLASS() returns the class 'GraphWD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the weighted directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('GraphWD') returns 'GraphWD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('GraphWD')
			%  are less computationally efficient.
			
			g_class = 'GraphWD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the weighted directed graph.
			%
			% LIST = GraphWD.GETSUBCLASSES() returns all subclasses of 'GraphWD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the weighted directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('GraphWD') returns all subclasses of 'GraphWD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('GraphWD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphWD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted directed graph.
			%
			% PROPS = GraphWD.GETPROPS() returns the property list of weighted directed graph
			%  as a row vector.
			%
			% PROPS = GraphWD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the weighted directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('GraphWD'[, CATEGORY]) returns the property list of 'GraphWD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						GraphWD.B ...
						GraphWD.SEMIPOSITIVIZE_RULE ...
						GraphWD.STANDARDIZE_RULE ...
						GraphWD.ATTEMPTSPEREDGE ...
						GraphWD.NUMBEROFWEIGHTS ...
						GraphWD.RANDOMIZATION ...
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
						GraphWD.SEMIPOSITIVIZE_RULE ...
						GraphWD.STANDARDIZE_RULE ...
						GraphWD.ATTEMPTSPEREDGE ...
						GraphWD.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						GraphWD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						GraphWD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of weighted directed graph.
			%
			% N = GraphWD.GETPROPNUMBER() returns the property number of weighted directed graph.
			%
			% N = GraphWD.GETPROPNUMBER(CATEGORY) returns the property number of weighted directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the weighted directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('GraphWD') returns the property number of 'GraphWD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('GraphWD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphWD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in weighted directed graph/error.
			%
			% CHECK = GraphWD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(GraphWD, PROP) checks whether PROP exists for GraphWD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%  Element.EXISTSPROP(GraphWD, PROP) throws error if PROP does NOT exist for GraphWD.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('GraphWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphWD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphWD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted directed graph/error.
			%
			% CHECK = GraphWD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(GraphWD, TAG) checks whether TAG exists for GraphWD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%  Element.EXISTSTAG(GraphWD, TAG) throws error if TAG does NOT exist for GraphWD.
			%   Error id: [BRAPH2:GraphWD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('GraphWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphwd_tag_list = cellfun(@(x) GraphWD.getPropTag(x), num2cell(GraphWD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphwd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphWD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphWD, POINTER) returns property number of POINTER of GraphWD.
			%  PROPERTY = G.GETPROPPROP(GraphWD, POINTER) returns property number of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphwd_tag_list = cellfun(@(x) GraphWD.getPropTag(x), num2cell(GraphWD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphwd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GraphWD, POINTER) returns tag of POINTER of GraphWD.
			%  TAG = G.GETPROPTAG(GraphWD, POINTER) returns tag of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphWD.B
						tag = GraphWD.B_TAG;
					case GraphWD.SEMIPOSITIVIZE_RULE
						tag = GraphWD.SEMIPOSITIVIZE_RULE_TAG;
					case GraphWD.STANDARDIZE_RULE
						tag = GraphWD.STANDARDIZE_RULE_TAG;
					case GraphWD.ATTEMPTSPEREDGE
						tag = GraphWD.ATTEMPTSPEREDGE_TAG;
					case GraphWD.NUMBEROFWEIGHTS
						tag = GraphWD.NUMBEROFWEIGHTS_TAG;
					case GraphWD.RANDOMIZATION
						tag = GraphWD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphWD, POINTER) returns category of POINTER of GraphWD.
			%  CATEGORY = G.GETPROPCATEGORY(GraphWD, POINTER) returns category of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('GraphWD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B
					prop_category = GraphWD.B_CATEGORY;
				case GraphWD.SEMIPOSITIVIZE_RULE
					prop_category = GraphWD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case GraphWD.STANDARDIZE_RULE
					prop_category = GraphWD.STANDARDIZE_RULE_CATEGORY;
				case GraphWD.ATTEMPTSPEREDGE
					prop_category = GraphWD.ATTEMPTSPEREDGE_CATEGORY;
				case GraphWD.NUMBEROFWEIGHTS
					prop_category = GraphWD.NUMBEROFWEIGHTS_CATEGORY;
				case GraphWD.RANDOMIZATION
					prop_category = GraphWD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GraphWD, POINTER) returns format of POINTER of GraphWD.
			%  FORMAT = G.GETPROPFORMAT(GraphWD, POINTER) returns format of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('GraphWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B
					prop_format = GraphWD.B_FORMAT;
				case GraphWD.SEMIPOSITIVIZE_RULE
					prop_format = GraphWD.SEMIPOSITIVIZE_RULE_FORMAT;
				case GraphWD.STANDARDIZE_RULE
					prop_format = GraphWD.STANDARDIZE_RULE_FORMAT;
				case GraphWD.ATTEMPTSPEREDGE
					prop_format = GraphWD.ATTEMPTSPEREDGE_FORMAT;
				case GraphWD.NUMBEROFWEIGHTS
					prop_format = GraphWD.NUMBEROFWEIGHTS_FORMAT;
				case GraphWD.RANDOMIZATION
					prop_format = GraphWD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphWD, POINTER) returns description of POINTER of GraphWD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(GraphWD, POINTER) returns description of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B
					prop_description = 'B (data, smatrix) is the input graph adjacency matrix.';
				case GraphWD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case GraphWD.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case GraphWD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case GraphWD.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case GraphWD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case GraphWD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case GraphWD.NAME
					prop_description = 'NAME (constant, string) is the name of the weighted directed graph.';
				case GraphWD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the weighted undirected graph.';
				case GraphWD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the weighted directed graph.';
				case GraphWD.ID
					prop_description = 'ID (data, string) is a few-letter code for the weighted directed graph.';
				case GraphWD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the weighted directed graph.';
				case GraphWD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the weighted directed graph.';
				case GraphWD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.';
				case GraphWD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__.';
				case GraphWD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__.';
				case GraphWD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.';
				case GraphWD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.';
				case GraphWD.A
					prop_description = 'A (result, cell) is the non-negative adjacency matrix of the weighted directed graph.';
				case GraphWD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphWD, POINTER) returns settings of POINTER of GraphWD.
			%  SETTINGS = G.GETPROPSETTINGS(GraphWD, POINTER) returns settings of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case GraphWD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case GraphWD.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case GraphWD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GraphWD.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GraphWD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GraphWD.TEMPLATE
					prop_settings = 'GraphWD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphWD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphWD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphWD, POINTER) returns the default value of POINTER of GraphWD.
			%  DEFAULT = G.GETPROPDEFAULT(GraphWD, POINTER) returns the default value of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('GraphWD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B
					prop_default = Format.getFormatDefault(Format.SMATRIX, GraphWD.getPropSettings(prop));
				case GraphWD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphWD.getPropSettings(prop));
				case GraphWD.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphWD.getPropSettings(prop));
				case GraphWD.ATTEMPTSPEREDGE
					prop_default = 5;
				case GraphWD.NUMBEROFWEIGHTS
					prop_default = 10;
				case GraphWD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, GraphWD.getPropSettings(prop));
				case GraphWD.ELCLASS
					prop_default = 'GraphWD';
				case GraphWD.NAME
					prop_default = 'GraphWD';
				case GraphWD.DESCRIPTION
					prop_default = 'In a weighted directed (WD) graph, the edges are directed and associated with a real number between 0 and 1 indicating the strength of the connection.';
				case GraphWD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphWD.getPropSettings(prop));
				case GraphWD.ID
					prop_default = 'GraphWD ID';
				case GraphWD.LABEL
					prop_default = 'GraphWD label';
				case GraphWD.NOTES
					prop_default = 'GraphWD notes';
				case GraphWD.GRAPH_TYPE
					prop_default = Graph.GRAPH;
				case GraphWD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('GraphWD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphWD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphWD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphWD, POINTER) returns the conditioned default value of POINTER of GraphWD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(GraphWD, POINTER) returns the conditioned default value of POINTER of GraphWD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('GraphWD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphWD.getPropProp(pointer);
			
			prop_default = GraphWD.conditioning(prop, GraphWD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GraphWD, PROP, VALUE) checks VALUE format for PROP of GraphWD.
			%  CHECK = G.CHECKPROP(GraphWD, PROP, VALUE) checks VALUE format for PROP of GraphWD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphWD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:GraphWD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphWD.
			%   Error id: €BRAPH2.STR€:GraphWD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(GraphWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphWD.
			%   Error id: €BRAPH2.STR€:GraphWD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('GraphWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphWD.getPropProp(pointer);
			
			switch prop
				case GraphWD.B % __GraphWD.B__
					check = Format.checkFormat(Format.SMATRIX, value, GraphWD.getPropSettings(prop));
				case GraphWD.SEMIPOSITIVIZE_RULE % __GraphWD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphWD.getPropSettings(prop));
				case GraphWD.STANDARDIZE_RULE % __GraphWD.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphWD.getPropSettings(prop));
				case GraphWD.ATTEMPTSPEREDGE % __GraphWD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, GraphWD.getPropSettings(prop));
				case GraphWD.NUMBEROFWEIGHTS % __GraphWD.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, GraphWD.getPropSettings(prop));
				case GraphWD.RANDOMIZATION % __GraphWD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, GraphWD.getPropSettings(prop));
				case GraphWD.TEMPLATE % __GraphWD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphWD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphWD.getPropTag(prop) ' (' GraphWD.getFormatTag(GraphWD.getPropFormat(prop)) ').'] ...
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
				case GraphWD.RANDOMIZATION % __GraphWD.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = cell2mat(varargin{1});
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					number_of_weights = g.get('NUMBEROFWEIGHTS');
					
					W = {A};
					tmp_g = GraphBD('ATTEMPTSPEREDGE', attempts_per_edge);
					W = tmp_g.get('RANDOMIZATION', W);
					if iscell(W)
					    W = cell2mat(W);  % swaps with A
					end
					% remove self connections
					W(1:length(W)+1:numel(W)) = 0;
					W_bin = W > 0;
					N = size(W,1); % number of nodes
					random_A = zeros(N); % initialize null model matrix
					
					S_in = sum(W,1).'; % nodal in-strength
					S_out = sum(W,2);  % nodal out-strength
					W_sorted = sort(W(W_bin)); % sorted weights vector
					% find all the edges
					[I_edges, J_edges] = find(W);
					edges = I_edges + (J_edges-1)*N;
					% expected weights matrix
					P = (S_out*S_in.');
					
					for m = numel(W_sorted):-number_of_weights:1
					
					    % sort the expected weights matrix
					    [~, ind] = sort(P(edges));
					
					    % random index of sorted expected weight
					    selected_indices = randperm(m, min(m,number_of_weights)).';
					    selected_edges = ind(selected_indices);
					
					    % assign corresponding sorted weight at this index
					    random_A(edges(selected_edges)) = W_sorted(selected_indices);
					
					    % recalculate expected weight for node I_edges(selected_edge)
					    WAi = accumarray(I_edges(selected_edges), W_sorted(selected_indices), [N,1]);
					    Iu = any(WAi,2);
					    % readjust expected weight probabilities
					    F = 1 - WAi(Iu)./S_out(Iu);
					    P(Iu,:) = P(Iu,:).*F(:,ones(1,N));
					    % readjust in-strength
					    S_out(Iu) = S_out(Iu) - WAi(Iu);
					
					    % recalculate expected weight for node J_edges(selected_edge)
					    WAj = accumarray(J_edges(selected_edges), W_sorted(selected_indices), [N,1]);
					    Ju = any(WAj,2);
					    % readjust expected weight probabilities
					    F = 1 - WAj(Ju)./S_in(Ju);
					    P(:,Ju) = P(:,Ju).*F(:,ones(1,N)).';
					    % readjust out-strength
					    S_in(Ju) = S_in(Ju) - WAj(Ju);
					
					    % remove the edge/weight from further consideration
					    selected_edges = ind(selected_indices);
					    edges(selected_edges) = [];
					    I_edges(selected_edges) = [];
					    J_edges(selected_edges) = [];
					    W_sorted(selected_indices) = [];
					end
					
					% calculate correlation of original vs reassinged in/out strength
					% rpos_in = corrcoef(sum(W,1), sum(random_A,1));
					% rpos_out = corrcoef(sum(W,2), sum(random_A,2));
					% correlation_coefficients = [rpos_in(2) rpos_out(2)];
					value = random_A;
					
				case GraphWD.CONNECTIVITY_TYPE % __GraphWD.CONNECTIVITY_TYPE__
					value = Graph.WEIGHTED;
					
				case GraphWD.DIRECTIONALITY_TYPE % __GraphWD.DIRECTIONALITY_TYPE__
					value = Graph.DIRECTED;
					
				case GraphWD.SELFCONNECTIVITY_TYPE % __GraphWD.SELFCONNECTIVITY_TYPE__
					value = Graph.NONSELFCONNECTED;
					
				case GraphWD.NEGATIVITY_TYPE % __GraphWD.NEGATIVITY_TYPE__
					value = Graph.NONNEGATIVE;
					
				case GraphWD.A % __GraphWD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(GraphWD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					
					B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
					B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
					B = standardize(B, 'StandardizeRule', g.get('STANDARDIZE_RULE')); %#ok<PROPLC> % ensures all weights are between 0 and 1
					
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
				case GraphWD.B % __GraphWD.B__
					pr = PanelPropMatrix('EL', g, 'PROP', GraphWD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case GraphWD.A % __GraphWD.A__
					pr = PanelPropCell('EL', g, 'PROP', GraphWD.A, ...
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
