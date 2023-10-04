classdef MultiplexWD < Graph
	%MultiplexWD is a multiplex weighted directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multiplex weighted directed (WD) graph, all layers have the same number 
	%  of nodes with within-layer weighted directed edges, associated with a real 
	%  number between 0 and 1 and indicating the strength of the connection.
	% There are connections between layers connecting the corresponding nodes.
	%
	% MultiplexWD methods (constructor):
	%  MultiplexWD - constructor
	%
	% MultiplexWD methods:
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
	% MultiplexWD methods (display):
	%  tostring - string with information about the multiplex weighted directed graph
	%  disp - displays information about the multiplex weighted directed graph
	%  tree - displays the tree of the multiplex weighted directed graph
	%
	% MultiplexWD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex weighted directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex weighted directed graph
	%
	% MultiplexWD methods (save/load, Static):
	%  save - saves BRAPH2 multiplex weighted directed graph as b2 file
	%  load - loads a BRAPH2 multiplex weighted directed graph from a b2 file
	%
	% MultiplexWD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex weighted directed graph
	%
	% MultiplexWD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex weighted directed graph
	%
	% MultiplexWD methods (inspection, Static):
	%  getClass - returns the class of the multiplex weighted directed graph
	%  getSubclasses - returns all subclasses of MultiplexWD
	%  getProps - returns the property list of the multiplex weighted directed graph
	%  getPropNumber - returns the property number of the multiplex weighted directed graph
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
	% MultiplexWD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexWD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexWD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexWD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexWD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexWD constants</a>.
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
		function g = MultiplexWD(varargin)
			%MultiplexWD() creates a multiplex weighted directed graph.
			%
			% MultiplexWD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexWD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex weighted directed graph.
			%
			% CLASS = MultiplexWD.GETCLASS() returns the class 'MultiplexWD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multiplex weighted directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultiplexWD') returns 'MultiplexWD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultiplexWD')
			%  are less computationally efficient.
			
			g_class = 'MultiplexWD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex weighted directed graph.
			%
			% LIST = MultiplexWD.GETSUBCLASSES() returns all subclasses of 'MultiplexWD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multiplex weighted directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultiplexWD') returns all subclasses of 'MultiplexWD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexWD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex weighted directed graph.
			%
			% PROPS = MultiplexWD.GETPROPS() returns the property list of multiplex weighted directed graph
			%  as a row vector.
			%
			% PROPS = MultiplexWD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multiplex weighted directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultiplexWD'[, CATEGORY]) returns the property list of 'MultiplexWD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultiplexWD.B ...
						MultiplexWD.SEMIPOSITIVIZE_RULE ...
						MultiplexWD.STANDARDIZE_RULE ...
						MultiplexWD.ATTEMPTSPEREDGE ...
						MultiplexWD.NUMBEROFWEIGHTS ...
						MultiplexWD.RANDOMIZATION ...
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
						MultiplexWD.SEMIPOSITIVIZE_RULE ...
						MultiplexWD.STANDARDIZE_RULE ...
						MultiplexWD.ATTEMPTSPEREDGE ...
						MultiplexWD.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultiplexWD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultiplexWD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of multiplex weighted directed graph.
			%
			% N = MultiplexWD.GETPROPNUMBER() returns the property number of multiplex weighted directed graph.
			%
			% N = MultiplexWD.GETPROPNUMBER(CATEGORY) returns the property number of multiplex weighted directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex weighted directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultiplexWD') returns the property number of 'MultiplexWD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexWD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex weighted directed graph/error.
			%
			% CHECK = MultiplexWD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultiplexWD, PROP) checks whether PROP exists for MultiplexWD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%  Element.EXISTSPROP(MultiplexWD, PROP) throws error if PROP does NOT exist for MultiplexWD.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexWD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexWD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex weighted directed graph/error.
			%
			% CHECK = MultiplexWD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultiplexWD, TAG) checks whether TAG exists for MultiplexWD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%  Element.EXISTSTAG(MultiplexWD, TAG) throws error if TAG does NOT exist for MultiplexWD.
			%   Error id: [BRAPH2:MultiplexWD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexwd_tag_list = cellfun(@(x) MultiplexWD.getPropTag(x), num2cell(MultiplexWD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexwd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexWD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexWD, POINTER) returns property number of POINTER of MultiplexWD.
			%  PROPERTY = G.GETPROPPROP(MultiplexWD, POINTER) returns property number of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexwd_tag_list = cellfun(@(x) MultiplexWD.getPropTag(x), num2cell(MultiplexWD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexwd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexWD, POINTER) returns tag of POINTER of MultiplexWD.
			%  TAG = G.GETPROPTAG(MultiplexWD, POINTER) returns tag of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexWD.B
						tag = MultiplexWD.B_TAG;
					case MultiplexWD.SEMIPOSITIVIZE_RULE
						tag = MultiplexWD.SEMIPOSITIVIZE_RULE_TAG;
					case MultiplexWD.STANDARDIZE_RULE
						tag = MultiplexWD.STANDARDIZE_RULE_TAG;
					case MultiplexWD.ATTEMPTSPEREDGE
						tag = MultiplexWD.ATTEMPTSPEREDGE_TAG;
					case MultiplexWD.NUMBEROFWEIGHTS
						tag = MultiplexWD.NUMBEROFWEIGHTS_TAG;
					case MultiplexWD.RANDOMIZATION
						tag = MultiplexWD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexWD, POINTER) returns category of POINTER of MultiplexWD.
			%  CATEGORY = G.GETPROPCATEGORY(MultiplexWD, POINTER) returns category of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B
					prop_category = MultiplexWD.B_CATEGORY;
				case MultiplexWD.SEMIPOSITIVIZE_RULE
					prop_category = MultiplexWD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultiplexWD.STANDARDIZE_RULE
					prop_category = MultiplexWD.STANDARDIZE_RULE_CATEGORY;
				case MultiplexWD.ATTEMPTSPEREDGE
					prop_category = MultiplexWD.ATTEMPTSPEREDGE_CATEGORY;
				case MultiplexWD.NUMBEROFWEIGHTS
					prop_category = MultiplexWD.NUMBEROFWEIGHTS_CATEGORY;
				case MultiplexWD.RANDOMIZATION
					prop_category = MultiplexWD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexWD, POINTER) returns format of POINTER of MultiplexWD.
			%  FORMAT = G.GETPROPFORMAT(MultiplexWD, POINTER) returns format of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B
					prop_format = MultiplexWD.B_FORMAT;
				case MultiplexWD.SEMIPOSITIVIZE_RULE
					prop_format = MultiplexWD.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultiplexWD.STANDARDIZE_RULE
					prop_format = MultiplexWD.STANDARDIZE_RULE_FORMAT;
				case MultiplexWD.ATTEMPTSPEREDGE
					prop_format = MultiplexWD.ATTEMPTSPEREDGE_FORMAT;
				case MultiplexWD.NUMBEROFWEIGHTS
					prop_format = MultiplexWD.NUMBEROFWEIGHTS_FORMAT;
				case MultiplexWD.RANDOMIZATION
					prop_format = MultiplexWD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexWD, POINTER) returns description of POINTER of MultiplexWD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultiplexWD, POINTER) returns description of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.';
				case MultiplexWD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultiplexWD.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case MultiplexWD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultiplexWD.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case MultiplexWD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultiplexWD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MultiplexWD.NAME
					prop_description = 'NAME (constant, string) is the name of the multiplex weighted directed graph.';
				case MultiplexWD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multiplex weighted directed graph.';
				case MultiplexWD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multiplex weighted directed graph.';
				case MultiplexWD.ID
					prop_description = 'ID (data, string) is a few-letter code for the multiplex weighted directed graph.';
				case MultiplexWD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multiplex weighted directed graph.';
				case MultiplexWD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multiplex weighted directed graph.';
				case MultiplexWD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.';
				case MultiplexWD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case MultiplexWD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case MultiplexWD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultiplexWD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultiplexWD.A
					prop_description = 'A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted directed graph.';
				case MultiplexWD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case MultiplexWD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexWD, POINTER) returns settings of POINTER of MultiplexWD.
			%  SETTINGS = G.GETPROPSETTINGS(MultiplexWD, POINTER) returns settings of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexWD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultiplexWD.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case MultiplexWD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultiplexWD.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultiplexWD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexWD.TEMPLATE
					prop_settings = 'MultiplexWD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexWD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexWD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexWD, POINTER) returns the default value of POINTER of MultiplexWD.
			%  DEFAULT = G.GETPROPDEFAULT(MultiplexWD, POINTER) returns the default value of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B
					prop_default = {[] []};
				case MultiplexWD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultiplexWD.NUMBEROFWEIGHTS
					prop_default = 10;
				case MultiplexWD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.ELCLASS
					prop_default = 'MultiplexWD';
				case MultiplexWD.NAME
					prop_default = 'MultiplexWD';
				case MultiplexWD.DESCRIPTION
					prop_default = 'In a multiplex weighted directed (WD) graph, all layers have the same number of nodes with within-layer weighted directed edges, associated with a real number between 0 and 1 and indicating the strength of the connection. There are connections between layers connecting the corresponding nodes.';
				case MultiplexWD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.ID
					prop_default = 'MultiplexWD ID';
				case MultiplexWD.LABEL
					prop_default = 'MultiplexWD label';
				case MultiplexWD.NOTES
					prop_default = 'MultiplexWD notes';
				case MultiplexWD.GRAPH_TYPE
					prop_default = Graph.MULTIPLEX;
				case MultiplexWD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultiplexWD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexWD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexWD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexWD, POINTER) returns the conditioned default value of POINTER of MultiplexWD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultiplexWD, POINTER) returns the conditioned default value of POINTER of MultiplexWD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			prop_default = MultiplexWD.conditioning(prop, MultiplexWD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexWD, PROP, VALUE) checks VALUE format for PROP of MultiplexWD.
			%  CHECK = G.CHECKPROP(MultiplexWD, PROP, VALUE) checks VALUE format for PROP of MultiplexWD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexWD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultiplexWD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexWD.
			%   Error id: €BRAPH2.STR€:MultiplexWD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultiplexWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexWD.
			%   Error id: €BRAPH2.STR€:MultiplexWD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultiplexWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexWD.getPropProp(pointer);
			
			switch prop
				case MultiplexWD.B % __MultiplexWD.B__
					check = Format.checkFormat(Format.CELL, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.SEMIPOSITIVIZE_RULE % __MultiplexWD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.STANDARDIZE_RULE % __MultiplexWD.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.ATTEMPTSPEREDGE % __MultiplexWD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.NUMBEROFWEIGHTS % __MultiplexWD.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.RANDOMIZATION % __MultiplexWD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultiplexWD.getPropSettings(prop));
				case MultiplexWD.TEMPLATE % __MultiplexWD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexWD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexWD.getPropTag(prop) ' (' MultiplexWD.getFormatTag(MultiplexWD.getPropFormat(prop)) ').'] ...
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
				case MultiplexWD.RANDOMIZATION % __MultiplexWD.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    tmp_g = GraphWD();
					    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    tmp_g.set('NUMBEROFWEIGHTS', g.get('NUMBEROFWEIGHTS'));
					    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case MultiplexWD.CONNECTIVITY_TYPE % __MultiplexWD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case MultiplexWD.DIRECTIONALITY_TYPE % __MultiplexWD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case MultiplexWD.SELFCONNECTIVITY_TYPE % __MultiplexWD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultiplexWD.NEGATIVITY_TYPE % __MultiplexWD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultiplexWD.A % __MultiplexWD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexWD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = dediagonalize(B{i}); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B{i}, 'DediagonalizeRule', 0)
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
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultiplexWD.ALAYERLABELS % __MultiplexWD.ALAYERLABELS__
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
				case MultiplexWD.B % __MultiplexWD.B__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexWD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('ALAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultiplexWD.A % __MultiplexWD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexWD.A, ...
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
