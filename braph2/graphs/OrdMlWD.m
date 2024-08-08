classdef OrdMlWD < Graph
	%OrdMlWD is an ordinal multilayer weighted directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multilayer weighted directed graph (OrdMlWD), layers could have different number 
	%  of nodes with within-layer weighted directed edges, associated with a real 
	%  number between 0 and 1 and indicating the strength of the connection.
	% All nodes are allowed between layers.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and standardized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.
	%
	% OrdMlWD methods (constructor):
	%  OrdMlWD - constructor
	%
	% OrdMlWD methods:
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
	% OrdMlWD methods (display):
	%  tostring - string with information about the ordinal multilayer weighted directed graph
	%  disp - displays information about the ordinal multilayer weighted directed graph
	%  tree - displays the tree of the ordinal multilayer weighted directed graph
	%
	% OrdMlWD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multilayer weighted directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multilayer weighted directed graph
	%
	% OrdMlWD methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multilayer weighted directed graph as b2 file
	%  load - loads a BRAPH2 ordinal multilayer weighted directed graph from a b2 file
	%
	% OrdMlWD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multilayer weighted directed graph
	%
	% OrdMlWD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multilayer weighted directed graph
	%
	% OrdMlWD methods (inspection, Static):
	%  getClass - returns the class of the ordinal multilayer weighted directed graph
	%  getSubclasses - returns all subclasses of OrdMlWD
	%  getProps - returns the property list of the ordinal multilayer weighted directed graph
	%  getPropNumber - returns the property number of the ordinal multilayer weighted directed graph
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
	% OrdMlWD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlWD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlWD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlWD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlWD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlWD constants</a>.
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
		function g = OrdMlWD(varargin)
			%OrdMlWD() creates a ordinal multilayer weighted directed graph.
			%
			% OrdMlWD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlWD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multilayer weighted directed graph.
			%
			% CLASS = OrdMlWD.GETCLASS() returns the class 'OrdMlWD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multilayer weighted directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlWD') returns 'OrdMlWD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlWD')
			%  are less computationally efficient.
			
			g_class = 'OrdMlWD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multilayer weighted directed graph.
			%
			% LIST = OrdMlWD.GETSUBCLASSES() returns all subclasses of 'OrdMlWD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multilayer weighted directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlWD') returns all subclasses of 'OrdMlWD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlWD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multilayer weighted directed graph.
			%
			% PROPS = OrdMlWD.GETPROPS() returns the property list of ordinal multilayer weighted directed graph
			%  as a row vector.
			%
			% PROPS = OrdMlWD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multilayer weighted directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlWD'[, CATEGORY]) returns the property list of 'OrdMlWD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMlWD.B ...
						OrdMlWD.SEMIPOSITIVIZE_RULE ...
						OrdMlWD.STANDARDIZE_RULE ...
						OrdMlWD.ATTEMPTSPEREDGE ...
						OrdMlWD.NUMBEROFWEIGHTS ...
						OrdMlWD.RANDOMIZATION ...
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
						OrdMlWD.SEMIPOSITIVIZE_RULE ...
						OrdMlWD.STANDARDIZE_RULE ...
						OrdMlWD.ATTEMPTSPEREDGE ...
						OrdMlWD.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMlWD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMlWD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multilayer weighted directed graph.
			%
			% N = OrdMlWD.GETPROPNUMBER() returns the property number of ordinal multilayer weighted directed graph.
			%
			% N = OrdMlWD.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multilayer weighted directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multilayer weighted directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlWD') returns the property number of 'OrdMlWD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlWD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multilayer weighted directed graph/error.
			%
			% CHECK = OrdMlWD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlWD, PROP) checks whether PROP exists for OrdMlWD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%  Element.EXISTSPROP(OrdMlWD, PROP) throws error if PROP does NOT exist for OrdMlWD.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlWD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlWD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multilayer weighted directed graph/error.
			%
			% CHECK = OrdMlWD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlWD, TAG) checks whether TAG exists for OrdMlWD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlWD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%  Element.EXISTSTAG(OrdMlWD, TAG) throws error if TAG does NOT exist for OrdMlWD.
			%   Error id: [BRAPH2:OrdMlWD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlwd_tag_list = cellfun(@(x) OrdMlWD.getPropTag(x), num2cell(OrdMlWD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlwd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlWD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlWD, POINTER) returns property number of POINTER of OrdMlWD.
			%  PROPERTY = G.GETPROPPROP(OrdMlWD, POINTER) returns property number of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlwd_tag_list = cellfun(@(x) OrdMlWD.getPropTag(x), num2cell(OrdMlWD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlwd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlWD, POINTER) returns tag of POINTER of OrdMlWD.
			%  TAG = G.GETPROPTAG(OrdMlWD, POINTER) returns tag of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlWD.B
						tag = OrdMlWD.B_TAG;
					case OrdMlWD.SEMIPOSITIVIZE_RULE
						tag = OrdMlWD.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMlWD.STANDARDIZE_RULE
						tag = OrdMlWD.STANDARDIZE_RULE_TAG;
					case OrdMlWD.ATTEMPTSPEREDGE
						tag = OrdMlWD.ATTEMPTSPEREDGE_TAG;
					case OrdMlWD.NUMBEROFWEIGHTS
						tag = OrdMlWD.NUMBEROFWEIGHTS_TAG;
					case OrdMlWD.RANDOMIZATION
						tag = OrdMlWD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlWD, POINTER) returns category of POINTER of OrdMlWD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlWD, POINTER) returns category of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B
					prop_category = OrdMlWD.B_CATEGORY;
				case OrdMlWD.SEMIPOSITIVIZE_RULE
					prop_category = OrdMlWD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMlWD.STANDARDIZE_RULE
					prop_category = OrdMlWD.STANDARDIZE_RULE_CATEGORY;
				case OrdMlWD.ATTEMPTSPEREDGE
					prop_category = OrdMlWD.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMlWD.NUMBEROFWEIGHTS
					prop_category = OrdMlWD.NUMBEROFWEIGHTS_CATEGORY;
				case OrdMlWD.RANDOMIZATION
					prop_category = OrdMlWD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlWD, POINTER) returns format of POINTER of OrdMlWD.
			%  FORMAT = G.GETPROPFORMAT(OrdMlWD, POINTER) returns format of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B
					prop_format = OrdMlWD.B_FORMAT;
				case OrdMlWD.SEMIPOSITIVIZE_RULE
					prop_format = OrdMlWD.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMlWD.STANDARDIZE_RULE
					prop_format = OrdMlWD.STANDARDIZE_RULE_FORMAT;
				case OrdMlWD.ATTEMPTSPEREDGE
					prop_format = OrdMlWD.ATTEMPTSPEREDGE_FORMAT;
				case OrdMlWD.NUMBEROFWEIGHTS
					prop_format = OrdMlWD.NUMBEROFWEIGHTS_FORMAT;
				case OrdMlWD.RANDOMIZATION
					prop_format = OrdMlWD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlWD, POINTER) returns description of POINTER of OrdMlWD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlWD, POINTER) returns description of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices.';
				case OrdMlWD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMlWD.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case OrdMlWD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlWD.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case OrdMlWD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMlWD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ordinal multilayer weighted directed graph.';
				case OrdMlWD.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multilayer weighted directed graph.';
				case OrdMlWD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multilayer weighted directed graph.';
				case OrdMlWD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multilayer weighted directed graph.';
				case OrdMlWD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multilayer weighted directed graph.';
				case OrdMlWD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multilayer weighted directed graph.';
				case OrdMlWD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multilayer weighted directed graph.';
				case OrdMlWD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.';
				case OrdMlWD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case OrdMlWD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case OrdMlWD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlWD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlWD.A
					prop_description = 'A (result, cell) is the cell containing the within-layer weighted adjacency matrices of the multilayer weighted directed graph and the ordinal connections between layers.';
				case OrdMlWD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMlWD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlWD, POINTER) returns settings of POINTER of OrdMlWD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlWD, POINTER) returns settings of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlWD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMlWD.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case OrdMlWD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlWD.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlWD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlWD.TEMPLATE
					prop_settings = 'OrdMlWD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlWD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlWD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlWD, POINTER) returns the default value of POINTER of OrdMlWD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlWD, POINTER) returns the default value of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B
					prop_default = {[] []; [] []};
				case OrdMlWD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMlWD.NUMBEROFWEIGHTS
					prop_default = 10;
				case OrdMlWD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.ELCLASS
					prop_default = 'OrdMlWD';
				case OrdMlWD.NAME
					prop_default = 'Ordinal Multilayer Weighted Directed';
				case OrdMlWD.DESCRIPTION
					prop_default = 'In an ordinal multilayer weighted directed graph (OrdMlWD), layers could have different number of nodes with within-layer weighted directed edges, associated with a real number between 0 and 1 and indicating the strength of the connection. All nodes are allowed between layers. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and standardized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.';
				case OrdMlWD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.ID
					prop_default = 'OrdMlWD ID';
				case OrdMlWD.LABEL
					prop_default = 'OrdMlWD label';
				case OrdMlWD.NOTES
					prop_default = 'OrdMlWD notes';
				case OrdMlWD.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlWD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlWD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlWD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlWD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlWD, POINTER) returns the conditioned default value of POINTER of OrdMlWD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlWD, POINTER) returns the conditioned default value of POINTER of OrdMlWD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			prop_default = OrdMlWD.conditioning(prop, OrdMlWD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlWD, PROP, VALUE) checks VALUE format for PROP of OrdMlWD.
			%  CHECK = G.CHECKPROP(OrdMlWD, PROP, VALUE) checks VALUE format for PROP of OrdMlWD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlWD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlWD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlWD.
			%   Error id: €BRAPH2.STR€:OrdMlWD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlWD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlWD.
			%   Error id: €BRAPH2.STR€:OrdMlWD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlWD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlWD.getPropProp(pointer);
			
			switch prop
				case OrdMlWD.B % __OrdMlWD.B__
					check = Format.checkFormat(Format.CELL, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.SEMIPOSITIVIZE_RULE % __OrdMlWD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.STANDARDIZE_RULE % __OrdMlWD.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.ATTEMPTSPEREDGE % __OrdMlWD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.NUMBEROFWEIGHTS % __OrdMlWD.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.RANDOMIZATION % __OrdMlWD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMlWD.getPropSettings(prop));
				case OrdMlWD.TEMPLATE % __OrdMlWD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlWD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlWD.getPropTag(prop) ' (' OrdMlWD.getFormatTag(OrdMlWD.getPropFormat(prop)) ').'] ...
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
				case OrdMlWD.RANDOMIZATION % __OrdMlWD.RANDOMIZATION__
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
					
				case OrdMlWD.CONNECTIVITY_TYPE % __OrdMlWD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case OrdMlWD.DIRECTIONALITY_TYPE % __OrdMlWD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case OrdMlWD.SELFCONNECTIVITY_TYPE % __OrdMlWD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlWD.NEGATIVITY_TYPE % __OrdMlWD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlWD.A % __OrdMlWD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlWD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					for i = 1:1:L
					    M = dediagonalize(B{i, i}); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE'));  % rescales adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{i, i})
					        for j = i+1:1:L
					            if j == i + 1
					                M = semipositivize(B{i, j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
					                A(i, j) = {M};
					                M = semipositivize(B{j, i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
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
					
				case OrdMlWD.ALAYERLABELS % __OrdMlWD.ALAYERLABELS__
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
				case OrdMlWD.B % __OrdMlWD.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlWD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMlWD.A % __OrdMlWD.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlWD.A, ...
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
