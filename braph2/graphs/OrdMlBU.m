classdef OrdMlBU < Graph
	%OrdMlBU is an ordinal multilayer binary undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multilayer binary undirected (BU) graph, layers could have different number 
	%  of nodes with within-layer undirected edges either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% The connectivity matrices are symmetric (within layer).
	% All node connections are allowed between layers.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% OrdMlBU methods (constructor):
	%  OrdMlBU - constructor
	%
	% OrdMlBU methods:
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
	% OrdMlBU methods (display):
	%  tostring - string with information about the ordinal multilayer binary undirected graph
	%  disp - displays information about the ordinal multilayer binary undirected graph
	%  tree - displays the tree of the ordinal multilayer binary undirected graph
	%
	% OrdMlBU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multilayer binary undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multilayer binary undirected graph
	%
	% OrdMlBU methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multilayer binary undirected graph as b2 file
	%  load - loads a BRAPH2 ordinal multilayer binary undirected graph from a b2 file
	%
	% OrdMlBU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multilayer binary undirected graph
	%
	% OrdMlBU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multilayer binary undirected graph
	%
	% OrdMlBU methods (inspection, Static):
	%  getClass - returns the class of the ordinal multilayer binary undirected graph
	%  getSubclasses - returns all subclasses of OrdMlBU
	%  getProps - returns the property list of the ordinal multilayer binary undirected graph
	%  getPropNumber - returns the property number of the ordinal multilayer binary undirected graph
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
	% OrdMlBU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlBU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlBU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlBU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlBU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlBU constants</a>.
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
		function g = OrdMlBU(varargin)
			%OrdMlBU() creates a ordinal multilayer binary undirected graph.
			%
			% OrdMlBU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlBU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multilayer binary undirected graph.
			%
			% CLASS = OrdMlBU.GETCLASS() returns the class 'OrdMlBU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multilayer binary undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlBU') returns 'OrdMlBU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlBU')
			%  are less computationally efficient.
			
			g_class = 'OrdMlBU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multilayer binary undirected graph.
			%
			% LIST = OrdMlBU.GETSUBCLASSES() returns all subclasses of 'OrdMlBU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multilayer binary undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlBU') returns all subclasses of 'OrdMlBU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlBU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multilayer binary undirected graph.
			%
			% PROPS = OrdMlBU.GETPROPS() returns the property list of ordinal multilayer binary undirected graph
			%  as a row vector.
			%
			% PROPS = OrdMlBU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multilayer binary undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlBU'[, CATEGORY]) returns the property list of 'OrdMlBU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMlBU.B ...
						OrdMlBU.SYMMETRIZE_RULE ...
						OrdMlBU.SEMIPOSITIVIZE_RULE ...
						OrdMlBU.ATTEMPTSPEREDGE ...
						OrdMlBU.RANDOMIZATION ...
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
						OrdMlBU.SYMMETRIZE_RULE ...
						OrdMlBU.SEMIPOSITIVIZE_RULE ...
						OrdMlBU.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMlBU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMlBU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multilayer binary undirected graph.
			%
			% N = OrdMlBU.GETPROPNUMBER() returns the property number of ordinal multilayer binary undirected graph.
			%
			% N = OrdMlBU.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multilayer binary undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multilayer binary undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlBU') returns the property number of 'OrdMlBU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlBU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multilayer binary undirected graph/error.
			%
			% CHECK = OrdMlBU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlBU, PROP) checks whether PROP exists for OrdMlBU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%  Element.EXISTSPROP(OrdMlBU, PROP) throws error if PROP does NOT exist for OrdMlBU.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlBU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlBU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multilayer binary undirected graph/error.
			%
			% CHECK = OrdMlBU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlBU, TAG) checks whether TAG exists for OrdMlBU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlBU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%  Element.EXISTSTAG(OrdMlBU, TAG) throws error if TAG does NOT exist for OrdMlBU.
			%   Error id: [BRAPH2:OrdMlBU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlbu_tag_list = cellfun(@(x) OrdMlBU.getPropTag(x), num2cell(OrdMlBU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlbu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlBU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlBU, POINTER) returns property number of POINTER of OrdMlBU.
			%  PROPERTY = G.GETPROPPROP(OrdMlBU, POINTER) returns property number of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlbu_tag_list = cellfun(@(x) OrdMlBU.getPropTag(x), num2cell(OrdMlBU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlbu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlBU, POINTER) returns tag of POINTER of OrdMlBU.
			%  TAG = G.GETPROPTAG(OrdMlBU, POINTER) returns tag of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlBU.B
						tag = OrdMlBU.B_TAG;
					case OrdMlBU.SYMMETRIZE_RULE
						tag = OrdMlBU.SYMMETRIZE_RULE_TAG;
					case OrdMlBU.SEMIPOSITIVIZE_RULE
						tag = OrdMlBU.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMlBU.ATTEMPTSPEREDGE
						tag = OrdMlBU.ATTEMPTSPEREDGE_TAG;
					case OrdMlBU.RANDOMIZATION
						tag = OrdMlBU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlBU, POINTER) returns category of POINTER of OrdMlBU.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlBU, POINTER) returns category of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B
					prop_category = OrdMlBU.B_CATEGORY;
				case OrdMlBU.SYMMETRIZE_RULE
					prop_category = OrdMlBU.SYMMETRIZE_RULE_CATEGORY;
				case OrdMlBU.SEMIPOSITIVIZE_RULE
					prop_category = OrdMlBU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMlBU.ATTEMPTSPEREDGE
					prop_category = OrdMlBU.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMlBU.RANDOMIZATION
					prop_category = OrdMlBU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlBU, POINTER) returns format of POINTER of OrdMlBU.
			%  FORMAT = G.GETPROPFORMAT(OrdMlBU, POINTER) returns format of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B
					prop_format = OrdMlBU.B_FORMAT;
				case OrdMlBU.SYMMETRIZE_RULE
					prop_format = OrdMlBU.SYMMETRIZE_RULE_FORMAT;
				case OrdMlBU.SEMIPOSITIVIZE_RULE
					prop_format = OrdMlBU.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMlBU.ATTEMPTSPEREDGE
					prop_format = OrdMlBU.ATTEMPTSPEREDGE_FORMAT;
				case OrdMlBU.RANDOMIZATION
					prop_format = OrdMlBU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlBU, POINTER) returns description of POINTER of OrdMlBU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlBU, POINTER) returns description of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.';
				case OrdMlBU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case OrdMlBU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMlBU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlBU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMlBU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case OrdMlBU.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multilayer binary undirected graph.';
				case OrdMlBU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multilayer binary undirected graph.';
				case OrdMlBU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multilayer binary undirected graph.';
				case OrdMlBU.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multilayer binary undirected graph.';
				case OrdMlBU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multilayer binary undirected graph.';
				case OrdMlBU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multilayer binary undirected graph.';
				case OrdMlBU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.';
				case OrdMlBU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMlBU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMlBU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlBU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlBU.A
					prop_description = 'A (result, cell) is the cell containing the within-layer binary adjacency matrices of the multilayer binary undirected graph and the ordinal connections between layers.';
				case OrdMlBU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMlBU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlBU, POINTER) returns settings of POINTER of OrdMlBU.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlBU, POINTER) returns settings of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlBU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case OrdMlBU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMlBU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlBU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlBU.TEMPLATE
					prop_settings = 'OrdMlBU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlBU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlBU, POINTER) returns the default value of POINTER of OrdMlBU.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlBU, POINTER) returns the default value of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B
					prop_default = {[] []; [] []};
				case OrdMlBU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMlBU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.ELCLASS
					prop_default = 'OrdMlBU';
				case OrdMlBU.NAME
					prop_default = 'OrdMlBU';
				case OrdMlBU.DESCRIPTION
					prop_default = 'In an ordinal multilayer binary undirected (BU) graph, layers could have different number of nodes with within-layer undirected edges either 0 (absence of connection) or 1 (existence of connection). The connectivity matrices are symmetric (within layer). All node connections are allowed between layers. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case OrdMlBU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.ID
					prop_default = 'OrdMlBU ID';
				case OrdMlBU.LABEL
					prop_default = 'OrdMlBU label';
				case OrdMlBU.NOTES
					prop_default = 'OrdMlBU notes';
				case OrdMlBU.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlBU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlBU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlBU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlBU, POINTER) returns the conditioned default value of POINTER of OrdMlBU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlBU, POINTER) returns the conditioned default value of POINTER of OrdMlBU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			prop_default = OrdMlBU.conditioning(prop, OrdMlBU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlBU, PROP, VALUE) checks VALUE format for PROP of OrdMlBU.
			%  CHECK = G.CHECKPROP(OrdMlBU, PROP, VALUE) checks VALUE format for PROP of OrdMlBU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlBU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlBU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBU.
			%   Error id: €BRAPH2.STR€:OrdMlBU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlBU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBU.
			%   Error id: €BRAPH2.STR€:OrdMlBU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlBU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlBU.getPropProp(pointer);
			
			switch prop
				case OrdMlBU.B % __OrdMlBU.B__
					check = Format.checkFormat(Format.CELL, value, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.SYMMETRIZE_RULE % __OrdMlBU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.SEMIPOSITIVIZE_RULE % __OrdMlBU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.ATTEMPTSPEREDGE % __OrdMlBU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.RANDOMIZATION % __OrdMlBU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMlBU.getPropSettings(prop));
				case OrdMlBU.TEMPLATE % __OrdMlBU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlBU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlBU.getPropTag(prop) ' (' OrdMlBU.getFormatTag(OrdMlBU.getPropFormat(prop)) ').'] ...
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
				case OrdMlBU.RANDOMIZATION % __OrdMlBU.RANDOMIZATION__
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
					
				case OrdMlBU.CONNECTIVITY_TYPE % __OrdMlBU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMlBU.DIRECTIONALITY_TYPE % __OrdMlBU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMlBU.SELFCONNECTIVITY_TYPE % __OrdMlBU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlBU.NEGATIVITY_TYPE % __OrdMlBU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlBU.A % __OrdMlBU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBU.A), 'twister')
					
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
					            if j == i + 1
					                M = semipositivize(B{i, j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, varargin{:}, 'diagonal', 'include'); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(i, j) = {M};
					                M = semipositivize(B{j, i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, varargin{:}, 'diagonal', 'include'); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(j, i) = {M};
					            else
					                A(i, j) = {zeros(size(B{i, j}))};
					                A(j, i) = {zeros(size(B{j, i}))};
					            end
					        end
					    end
					end
					
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMlBU.ALAYERLABELS % __OrdMlBU.ALAYERLABELS__
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
				case OrdMlBU.B % __OrdMlBU.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMlBU.A % __OrdMlBU.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBU.A, ...
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
