classdef OrdMxWU < Graph
	%OrdMxWU is an ordinal multiplex weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multiplex weighted undirected (WU) graph, all layers have the 
	%  same number of nodes with within-layer weighted undirected edges, 
	%  associated with a real number between 0 and 1 and indicating the strength 
	%  of the connection.
	% The connectivity matrices are symmetric.
	% There are connections between layers connecting the corresponding nodes.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	%
	% OrdMxWU methods (constructor):
	%  OrdMxWU - constructor
	%
	% OrdMxWU methods:
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
	% OrdMxWU methods (display):
	%  tostring - string with information about the ordinal multiplex weighted undirected graph
	%  disp - displays information about the ordinal multiplex weighted undirected graph
	%  tree - displays the tree of the ordinal multiplex weighted undirected graph
	%
	% OrdMxWU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multiplex weighted undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multiplex weighted undirected graph
	%
	% OrdMxWU methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multiplex weighted undirected graph as b2 file
	%  load - loads a BRAPH2 ordinal multiplex weighted undirected graph from a b2 file
	%
	% OrdMxWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multiplex weighted undirected graph
	%
	% OrdMxWU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multiplex weighted undirected graph
	%
	% OrdMxWU methods (inspection, Static):
	%  getClass - returns the class of the ordinal multiplex weighted undirected graph
	%  getSubclasses - returns all subclasses of OrdMxWU
	%  getProps - returns the property list of the ordinal multiplex weighted undirected graph
	%  getPropNumber - returns the property number of the ordinal multiplex weighted undirected graph
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
	% OrdMxWU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxWU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxWU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxWU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxWU constants</a>.
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
		function g = OrdMxWU(varargin)
			%OrdMxWU() creates a ordinal multiplex weighted undirected graph.
			%
			% OrdMxWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxWU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multiplex weighted undirected graph.
			%
			% CLASS = OrdMxWU.GETCLASS() returns the class 'OrdMxWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxWU') returns 'OrdMxWU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxWU')
			%  are less computationally efficient.
			
			g_class = 'OrdMxWU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multiplex weighted undirected graph.
			%
			% LIST = OrdMxWU.GETSUBCLASSES() returns all subclasses of 'OrdMxWU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multiplex weighted undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxWU') returns all subclasses of 'OrdMxWU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMxWU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex weighted undirected graph.
			%
			% PROPS = OrdMxWU.GETPROPS() returns the property list of ordinal multiplex weighted undirected graph
			%  as a row vector.
			%
			% PROPS = OrdMxWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxWU'[, CATEGORY]) returns the property list of 'OrdMxWU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMxWU.B ...
						OrdMxWU.SYMMETRIZE_RULE ...
						OrdMxWU.SEMIPOSITIVIZE_RULE ...
						OrdMxWU.STANDARDIZE_RULE ...
						OrdMxWU.ATTEMPTSPEREDGE ...
						OrdMxWU.NUMBEROFWEIGHTS ...
						OrdMxWU.RANDOMIZATION ...
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
						OrdMxWU.SYMMETRIZE_RULE ...
						OrdMxWU.SEMIPOSITIVIZE_RULE ...
						OrdMxWU.STANDARDIZE_RULE ...
						OrdMxWU.ATTEMPTSPEREDGE ...
						OrdMxWU.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMxWU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMxWU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multiplex weighted undirected graph.
			%
			% N = OrdMxWU.GETPROPNUMBER() returns the property number of ordinal multiplex weighted undirected graph.
			%
			% N = OrdMxWU.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multiplex weighted undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multiplex weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxWU') returns the property number of 'OrdMxWU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMxWU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multiplex weighted undirected graph/error.
			%
			% CHECK = OrdMxWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxWU, PROP) checks whether PROP exists for OrdMxWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%  Element.EXISTSPROP(OrdMxWU, PROP) throws error if PROP does NOT exist for OrdMxWU.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMxWU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxWU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex weighted undirected graph/error.
			%
			% CHECK = OrdMxWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxWU, TAG) checks whether TAG exists for OrdMxWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%  Element.EXISTSTAG(OrdMxWU, TAG) throws error if TAG does NOT exist for OrdMxWU.
			%   Error id: [BRAPH2:OrdMxWU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmxwu_tag_list = cellfun(@(x) OrdMxWU.getPropTag(x), num2cell(OrdMxWU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmxwu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxWU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMxWU, POINTER) returns property number of POINTER of OrdMxWU.
			%  PROPERTY = G.GETPROPPROP(OrdMxWU, POINTER) returns property number of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmxwu_tag_list = cellfun(@(x) OrdMxWU.getPropTag(x), num2cell(OrdMxWU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmxwu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMxWU, POINTER) returns tag of POINTER of OrdMxWU.
			%  TAG = G.GETPROPTAG(OrdMxWU, POINTER) returns tag of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMxWU.B
						tag = OrdMxWU.B_TAG;
					case OrdMxWU.SYMMETRIZE_RULE
						tag = OrdMxWU.SYMMETRIZE_RULE_TAG;
					case OrdMxWU.SEMIPOSITIVIZE_RULE
						tag = OrdMxWU.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMxWU.STANDARDIZE_RULE
						tag = OrdMxWU.STANDARDIZE_RULE_TAG;
					case OrdMxWU.ATTEMPTSPEREDGE
						tag = OrdMxWU.ATTEMPTSPEREDGE_TAG;
					case OrdMxWU.NUMBEROFWEIGHTS
						tag = OrdMxWU.NUMBEROFWEIGHTS_TAG;
					case OrdMxWU.RANDOMIZATION
						tag = OrdMxWU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxWU, POINTER) returns category of POINTER of OrdMxWU.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxWU, POINTER) returns category of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B
					prop_category = OrdMxWU.B_CATEGORY;
				case OrdMxWU.SYMMETRIZE_RULE
					prop_category = OrdMxWU.SYMMETRIZE_RULE_CATEGORY;
				case OrdMxWU.SEMIPOSITIVIZE_RULE
					prop_category = OrdMxWU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMxWU.STANDARDIZE_RULE
					prop_category = OrdMxWU.STANDARDIZE_RULE_CATEGORY;
				case OrdMxWU.ATTEMPTSPEREDGE
					prop_category = OrdMxWU.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMxWU.NUMBEROFWEIGHTS
					prop_category = OrdMxWU.NUMBEROFWEIGHTS_CATEGORY;
				case OrdMxWU.RANDOMIZATION
					prop_category = OrdMxWU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMxWU, POINTER) returns format of POINTER of OrdMxWU.
			%  FORMAT = G.GETPROPFORMAT(OrdMxWU, POINTER) returns format of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B
					prop_format = OrdMxWU.B_FORMAT;
				case OrdMxWU.SYMMETRIZE_RULE
					prop_format = OrdMxWU.SYMMETRIZE_RULE_FORMAT;
				case OrdMxWU.SEMIPOSITIVIZE_RULE
					prop_format = OrdMxWU.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMxWU.STANDARDIZE_RULE
					prop_format = OrdMxWU.STANDARDIZE_RULE_FORMAT;
				case OrdMxWU.ATTEMPTSPEREDGE
					prop_format = OrdMxWU.ATTEMPTSPEREDGE_FORMAT;
				case OrdMxWU.NUMBEROFWEIGHTS
					prop_format = OrdMxWU.NUMBEROFWEIGHTS_FORMAT;
				case OrdMxWU.RANDOMIZATION
					prop_format = OrdMxWU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxWU, POINTER) returns description of POINTER of OrdMxWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxWU, POINTER) returns description of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.';
				case OrdMxWU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case OrdMxWU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMxWU.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case OrdMxWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMxWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case OrdMxWU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMxWU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case OrdMxWU.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multiplex weighted undirected graph.';
				case OrdMxWU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTIPLEX__.';
				case OrdMxWU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case OrdMxWU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMxWU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMxWU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMxWU.A
					prop_description = 'A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.';
				case OrdMxWU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMxWU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxWU, POINTER) returns settings of POINTER of OrdMxWU.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxWU, POINTER) returns settings of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMxWU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case OrdMxWU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMxWU.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case OrdMxWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMxWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMxWU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMxWU.TEMPLATE
					prop_settings = 'OrdMxWU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxWU, POINTER) returns the default value of POINTER of OrdMxWU.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxWU, POINTER) returns the default value of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B
					prop_default = {[] []};
				case OrdMxWU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMxWU.NUMBEROFWEIGHTS
					prop_default = 10;
				case OrdMxWU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.ELCLASS
					prop_default = 'OrdMxWU';
				case OrdMxWU.NAME
					prop_default = 'OrdMxWU';
				case OrdMxWU.DESCRIPTION
					prop_default = 'In an ordinal multiplex weighted undirected (WU) graph, the edges are associated with a real number between 0 and 1 indicating the strength of the connection, and they are undirected. The connectivity matrix of each layer is symmetric. The layers are connected in an ordinal fashion, where just consecutive layers are connected.';
				case OrdMxWU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.ID
					prop_default = 'OrdMxWU ID';
				case OrdMxWU.LABEL
					prop_default = 'OrdMxWU label';
				case OrdMxWU.NOTES
					prop_default = 'OrdMxWU notes';
				case OrdMxWU.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTIPLEX;
				case OrdMxWU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMxWU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxWU, POINTER) returns the conditioned default value of POINTER of OrdMxWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxWU, POINTER) returns the conditioned default value of POINTER of OrdMxWU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			prop_default = OrdMxWU.conditioning(prop, OrdMxWU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMxWU, PROP, VALUE) checks VALUE format for PROP of OrdMxWU.
			%  CHECK = G.CHECKPROP(OrdMxWU, PROP, VALUE) checks VALUE format for PROP of OrdMxWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMxWU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMxWU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMxWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxWU.
			%   Error id: €BRAPH2.STR€:OrdMxWU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMxWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxWU.
			%   Error id: €BRAPH2.STR€:OrdMxWU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxWU.getPropProp(pointer);
			
			switch prop
				case OrdMxWU.B % __OrdMxWU.B__
					check = Format.checkFormat(Format.CELL, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.SYMMETRIZE_RULE % __OrdMxWU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.SEMIPOSITIVIZE_RULE % __OrdMxWU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.STANDARDIZE_RULE % __OrdMxWU.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.ATTEMPTSPEREDGE % __OrdMxWU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.NUMBEROFWEIGHTS % __OrdMxWU.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.RANDOMIZATION % __OrdMxWU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMxWU.getPropSettings(prop));
				case OrdMxWU.TEMPLATE % __OrdMxWU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMxWU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxWU.getPropTag(prop) ' (' OrdMxWU.getFormatTag(OrdMxWU.getPropFormat(prop)) ').'] ...
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
				case OrdMxWU.RANDOMIZATION % __OrdMxWU.RANDOMIZATION__
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
					
				case OrdMxWU.CONNECTIVITY_TYPE % __OrdMxWU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case OrdMxWU.DIRECTIONALITY_TYPE % __OrdMxWU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMxWU.SELFCONNECTIVITY_TYPE % __OrdMxWU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMxWU.NEGATIVITY_TYPE % __OrdMxWU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMxWU.A % __OrdMxWU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxWU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = symmetrize(B{i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % rescales adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{1, 1})
					        for j = i+1:1:L
					            if j == i+1
					                A(i, j) = {eye(length(A{1, 1}))};
					                A(j, i) = {eye(length(A{1, 1}))};
					            else
					                A(i, j) = {zeros(length(A{1, 1}))};
					                A(j, i) = {zeros(length(A{1, 1}))};
					            end
					        end
					    end
					end
					
					if g.get('GRAPH_TYPE') ~= 3
					
					else
					    if g.get('RANDOMIZE')
					        A = g.get('RANDOMIZATION', A);
					    end
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMxWU.ALAYERLABELS % __OrdMxWU.ALAYERLABELS__
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
				case OrdMxWU.B % __OrdMxWU.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxWU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMxWU.A % __OrdMxWU.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxWU.A, ...
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
