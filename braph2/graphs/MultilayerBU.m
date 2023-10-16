classdef MultilayerBU < Graph
	%MultilayerBU is a multilayer binary undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multilayer binary undirected (BU) graph, layers could have different number
	%  of nodes with within-layer undirected edges either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% The connectivity matrices are symmetric (within layer).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% MultilayerBU methods (constructor):
	%  MultilayerBU - constructor
	%
	% MultilayerBU methods:
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
	% MultilayerBU methods (display):
	%  tostring - string with information about the multilayer binary undirected graph
	%  disp - displays information about the multilayer binary undirected graph
	%  tree - displays the tree of the multilayer binary undirected graph
	%
	% MultilayerBU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer binary undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer binary undirected graph
	%
	% MultilayerBU methods (save/load, Static):
	%  save - saves BRAPH2 multilayer binary undirected graph as b2 file
	%  load - loads a BRAPH2 multilayer binary undirected graph from a b2 file
	%
	% MultilayerBU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer binary undirected graph
	%
	% MultilayerBU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer binary undirected graph
	%
	% MultilayerBU methods (inspection, Static):
	%  getClass - returns the class of the multilayer binary undirected graph
	%  getSubclasses - returns all subclasses of MultilayerBU
	%  getProps - returns the property list of the multilayer binary undirected graph
	%  getPropNumber - returns the property number of the multilayer binary undirected graph
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
	% MultilayerBU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerBU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerBU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerBU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerBU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerBU constants</a>.
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
		function g = MultilayerBU(varargin)
			%MultilayerBU() creates a multilayer binary undirected graph.
			%
			% MultilayerBU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerBU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multilayer binary undirected graph.
			%
			% CLASS = MultilayerBU.GETCLASS() returns the class 'MultilayerBU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer binary undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerBU') returns 'MultilayerBU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerBU')
			%  are less computationally efficient.
			
			g_class = 'MultilayerBU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer binary undirected graph.
			%
			% LIST = MultilayerBU.GETSUBCLASSES() returns all subclasses of 'MultilayerBU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer binary undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerBU') returns all subclasses of 'MultilayerBU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerBU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer binary undirected graph.
			%
			% PROPS = MultilayerBU.GETPROPS() returns the property list of multilayer binary undirected graph
			%  as a row vector.
			%
			% PROPS = MultilayerBU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer binary undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerBU'[, CATEGORY]) returns the property list of 'MultilayerBU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultilayerBU.B ...
						MultilayerBU.SYMMETRIZE_RULE ...
						MultilayerBU.SEMIPOSITIVIZE_RULE ...
						MultilayerBU.ATTEMPTSPEREDGE ...
						MultilayerBU.RANDOMIZATION ...
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
						MultilayerBU.SYMMETRIZE_RULE ...
						MultilayerBU.SEMIPOSITIVIZE_RULE ...
						MultilayerBU.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultilayerBU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultilayerBU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of multilayer binary undirected graph.
			%
			% N = MultilayerBU.GETPROPNUMBER() returns the property number of multilayer binary undirected graph.
			%
			% N = MultilayerBU.GETPROPNUMBER(CATEGORY) returns the property number of multilayer binary undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer binary undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerBU') returns the property number of 'MultilayerBU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerBU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer binary undirected graph/error.
			%
			% CHECK = MultilayerBU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerBU, PROP) checks whether PROP exists for MultilayerBU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%  Element.EXISTSPROP(MultilayerBU, PROP) throws error if PROP does NOT exist for MultilayerBU.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerBU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerBU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer binary undirected graph/error.
			%
			% CHECK = MultilayerBU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerBU, TAG) checks whether TAG exists for MultilayerBU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%  Element.EXISTSTAG(MultilayerBU, TAG) throws error if TAG does NOT exist for MultilayerBU.
			%   Error id: [BRAPH2:MultilayerBU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerbu_tag_list = cellfun(@(x) MultilayerBU.getPropTag(x), num2cell(MultilayerBU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerbu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerBU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerBU, POINTER) returns property number of POINTER of MultilayerBU.
			%  PROPERTY = G.GETPROPPROP(MultilayerBU, POINTER) returns property number of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerbu_tag_list = cellfun(@(x) MultilayerBU.getPropTag(x), num2cell(MultilayerBU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerbu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerBU, POINTER) returns tag of POINTER of MultilayerBU.
			%  TAG = G.GETPROPTAG(MultilayerBU, POINTER) returns tag of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerBU.B
						tag = MultilayerBU.B_TAG;
					case MultilayerBU.SYMMETRIZE_RULE
						tag = MultilayerBU.SYMMETRIZE_RULE_TAG;
					case MultilayerBU.SEMIPOSITIVIZE_RULE
						tag = MultilayerBU.SEMIPOSITIVIZE_RULE_TAG;
					case MultilayerBU.ATTEMPTSPEREDGE
						tag = MultilayerBU.ATTEMPTSPEREDGE_TAG;
					case MultilayerBU.RANDOMIZATION
						tag = MultilayerBU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerBU, POINTER) returns category of POINTER of MultilayerBU.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerBU, POINTER) returns category of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B
					prop_category = MultilayerBU.B_CATEGORY;
				case MultilayerBU.SYMMETRIZE_RULE
					prop_category = MultilayerBU.SYMMETRIZE_RULE_CATEGORY;
				case MultilayerBU.SEMIPOSITIVIZE_RULE
					prop_category = MultilayerBU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultilayerBU.ATTEMPTSPEREDGE
					prop_category = MultilayerBU.ATTEMPTSPEREDGE_CATEGORY;
				case MultilayerBU.RANDOMIZATION
					prop_category = MultilayerBU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerBU, POINTER) returns format of POINTER of MultilayerBU.
			%  FORMAT = G.GETPROPFORMAT(MultilayerBU, POINTER) returns format of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B
					prop_format = MultilayerBU.B_FORMAT;
				case MultilayerBU.SYMMETRIZE_RULE
					prop_format = MultilayerBU.SYMMETRIZE_RULE_FORMAT;
				case MultilayerBU.SEMIPOSITIVIZE_RULE
					prop_format = MultilayerBU.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultilayerBU.ATTEMPTSPEREDGE
					prop_format = MultilayerBU.ATTEMPTSPEREDGE_FORMAT;
				case MultilayerBU.RANDOMIZATION
					prop_format = MultilayerBU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerBU, POINTER) returns description of POINTER of MultilayerBU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerBU, POINTER) returns description of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.';
				case MultilayerBU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case MultilayerBU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultilayerBU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultilayerBU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultilayerBU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MultilayerBU.NAME
					prop_description = 'NAME (constant, string) is the name of the multilayer binary undirected graph.';
				case MultilayerBU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multilayer binary undirected graph.';
				case MultilayerBU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multilayer binary undirected graph.';
				case MultilayerBU.ID
					prop_description = 'ID (data, string) is a few-letter code for the multilayer binary undirected graph.';
				case MultilayerBU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multilayer binary undirected graph.';
				case MultilayerBU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multilayer binary undirected graph.';
				case MultilayerBU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.';
				case MultilayerBU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultilayerBU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultilayerBU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultilayerBU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultilayerBU.A
					prop_description = 'A (result, cell) is the cell containing the binary supra-adjacency matrix of the multilayer binary undirected graph.';
				case MultilayerBU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultilayerBU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerBU, POINTER) returns settings of POINTER of MultilayerBU.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerBU, POINTER) returns settings of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerBU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case MultilayerBU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultilayerBU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerBU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultilayerBU.TEMPLATE
					prop_settings = 'MultilayerBU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerBU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerBU, POINTER) returns the default value of POINTER of MultilayerBU.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerBU, POINTER) returns the default value of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B
					prop_default = {[] []; [] []};
				case MultilayerBU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultilayerBU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.ELCLASS
					prop_default = 'MultilayerBU';
				case MultilayerBU.NAME
					prop_default = 'MultilayerBU';
				case MultilayerBU.DESCRIPTION
					prop_default = 'In a multilayer binary undirected (BU) graph, layers could have different number of nodes with within-layer undirected edges either 0 (absence of connection) or 1 (existence of connection). The connectivity matrices are symmetric (within layer). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case MultilayerBU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.ID
					prop_default = 'MultilayerBU ID';
				case MultilayerBU.LABEL
					prop_default = 'MultilayerBU label';
				case MultilayerBU.NOTES
					prop_default = 'MultilayerBU notes';
				case MultilayerBU.GRAPH_TYPE
					prop_default = Graph.MULTILAYER;
				case MultilayerBU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultilayerBU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerBU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerBU, POINTER) returns the conditioned default value of POINTER of MultilayerBU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerBU, POINTER) returns the conditioned default value of POINTER of MultilayerBU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			prop_default = MultilayerBU.conditioning(prop, MultilayerBU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerBU, PROP, VALUE) checks VALUE format for PROP of MultilayerBU.
			%  CHECK = G.CHECKPROP(MultilayerBU, PROP, VALUE) checks VALUE format for PROP of MultilayerBU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerBU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultilayerBU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBU.
			%   Error id: €BRAPH2.STR€:MultilayerBU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultilayerBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBU.
			%   Error id: €BRAPH2.STR€:MultilayerBU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerBU.getPropProp(pointer);
			
			switch prop
				case MultilayerBU.B % __MultilayerBU.B__
					check = Format.checkFormat(Format.CELL, value, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.SYMMETRIZE_RULE % __MultilayerBU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.SEMIPOSITIVIZE_RULE % __MultilayerBU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.ATTEMPTSPEREDGE % __MultilayerBU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.RANDOMIZATION % __MultilayerBU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultilayerBU.getPropSettings(prop));
				case MultilayerBU.TEMPLATE % __MultilayerBU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerBU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerBU.getPropTag(prop) ' (' MultilayerBU.getFormatTag(MultilayerBU.getPropFormat(prop)) ').'] ...
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
				case MultilayerBU.RANDOMIZATION % __MultilayerBU.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    random_g = GraphBU();
					    random_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    random_A = random_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case MultilayerBU.CONNECTIVITY_TYPE % __MultilayerBU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultilayerBU.DIRECTIONALITY_TYPE % __MultilayerBU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultilayerBU.SELFCONNECTIVITY_TYPE % __MultilayerBU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultilayerBU.NEGATIVITY_TYPE % __MultilayerBU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultilayerBU.A % __MultilayerBU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerBU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					for i = 1:1:L
					    M = symmetrize(B{i, i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = binarize(M); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					    A(i, i) = {M};
					    if ~isempty(A{i, i})
					        for j = i+1:1:L
					            M = semipositivize(B{i, j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = binarize(M, varargin{:}, 'diagonal', 'include'); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					            A(i, j) = {M};
					            M = semipositivize(B{j, i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = binarize(M, varargin{:}, 'diagonal', 'include'); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					            A(j, i) = {M};
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultilayerBU.ALAYERLABELS % __MultilayerBU.ALAYERLABELS__
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
				case MultilayerBU.B % __MultilayerBU.B__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerBU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultilayerBU.A % __MultilayerBU.A__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerBU.A, ...
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
