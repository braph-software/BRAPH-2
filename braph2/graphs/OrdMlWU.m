classdef OrdMlWU < Graph
	%OrdMlWU is an ordinal multilayer weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multilayer weighted undirected graph (OrdMlWU), layers could have different number 
	%  of nodes with within-layer weighted undirected edges, associated with a real 
	%  number between 0 and 1 and indicating the strength of the connection.
	% The connectivity matrices are symmetric (within layer).
	% All node connections are allowed between layers.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and standardized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and standardized.
	%
	% OrdMlWU methods (constructor):
	%  OrdMlWU - constructor
	%
	% OrdMlWU methods:
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
	% OrdMlWU methods (display):
	%  tostring - string with information about the ordinal multilayer weighted undirected graph
	%  disp - displays information about the ordinal multilayer weighted undirected graph
	%  tree - displays the tree of the ordinal multilayer weighted undirected graph
	%
	% OrdMlWU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multilayer weighted undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multilayer weighted undirected graph
	%
	% OrdMlWU methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multilayer weighted undirected graph as b2 file
	%  load - loads a BRAPH2 ordinal multilayer weighted undirected graph from a b2 file
	%
	% OrdMlWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multilayer weighted undirected graph
	%
	% OrdMlWU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multilayer weighted undirected graph
	%
	% OrdMlWU methods (inspection, Static):
	%  getClass - returns the class of the ordinal multilayer weighted undirected graph
	%  getSubclasses - returns all subclasses of OrdMlWU
	%  getProps - returns the property list of the ordinal multilayer weighted undirected graph
	%  getPropNumber - returns the property number of the ordinal multilayer weighted undirected graph
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
	% OrdMlWU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlWU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlWU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlWU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlWU constants</a>.
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
		function g = OrdMlWU(varargin)
			%OrdMlWU() creates a ordinal multilayer weighted undirected graph.
			%
			% OrdMlWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlWU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multilayer weighted undirected graph.
			%
			% CLASS = OrdMlWU.GETCLASS() returns the class 'OrdMlWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multilayer weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlWU') returns 'OrdMlWU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlWU')
			%  are less computationally efficient.
			
			g_class = 'OrdMlWU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multilayer weighted undirected graph.
			%
			% LIST = OrdMlWU.GETSUBCLASSES() returns all subclasses of 'OrdMlWU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multilayer weighted undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlWU') returns all subclasses of 'OrdMlWU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlWU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multilayer weighted undirected graph.
			%
			% PROPS = OrdMlWU.GETPROPS() returns the property list of ordinal multilayer weighted undirected graph
			%  as a row vector.
			%
			% PROPS = OrdMlWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multilayer weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlWU'[, CATEGORY]) returns the property list of 'OrdMlWU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMlWU.B ...
						OrdMlWU.SYMMETRIZE_RULE ...
						OrdMlWU.SEMIPOSITIVIZE_RULE ...
						OrdMlWU.STANDARDIZE_RULE ...
						OrdMlWU.ATTEMPTSPEREDGE ...
						OrdMlWU.NUMBEROFWEIGHTS ...
						OrdMlWU.RANDOMIZATION ...
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
						OrdMlWU.SYMMETRIZE_RULE ...
						OrdMlWU.SEMIPOSITIVIZE_RULE ...
						OrdMlWU.STANDARDIZE_RULE ...
						OrdMlWU.ATTEMPTSPEREDGE ...
						OrdMlWU.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMlWU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMlWU.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multilayer weighted undirected graph.
			%
			% N = OrdMlWU.GETPROPNUMBER() returns the property number of ordinal multilayer weighted undirected graph.
			%
			% N = OrdMlWU.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multilayer weighted undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multilayer weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlWU') returns the property number of 'OrdMlWU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlWU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multilayer weighted undirected graph/error.
			%
			% CHECK = OrdMlWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlWU, PROP) checks whether PROP exists for OrdMlWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%  Element.EXISTSPROP(OrdMlWU, PROP) throws error if PROP does NOT exist for OrdMlWU.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlWU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlWU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multilayer weighted undirected graph/error.
			%
			% CHECK = OrdMlWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlWU, TAG) checks whether TAG exists for OrdMlWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%  Element.EXISTSTAG(OrdMlWU, TAG) throws error if TAG does NOT exist for OrdMlWU.
			%   Error id: [BRAPH2:OrdMlWU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlwu_tag_list = cellfun(@(x) OrdMlWU.getPropTag(x), num2cell(OrdMlWU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlwu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlWU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlWU, POINTER) returns property number of POINTER of OrdMlWU.
			%  PROPERTY = G.GETPROPPROP(OrdMlWU, POINTER) returns property number of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlwu_tag_list = cellfun(@(x) OrdMlWU.getPropTag(x), num2cell(OrdMlWU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlwu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlWU, POINTER) returns tag of POINTER of OrdMlWU.
			%  TAG = G.GETPROPTAG(OrdMlWU, POINTER) returns tag of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlWU.B
						tag = OrdMlWU.B_TAG;
					case OrdMlWU.SYMMETRIZE_RULE
						tag = OrdMlWU.SYMMETRIZE_RULE_TAG;
					case OrdMlWU.SEMIPOSITIVIZE_RULE
						tag = OrdMlWU.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMlWU.STANDARDIZE_RULE
						tag = OrdMlWU.STANDARDIZE_RULE_TAG;
					case OrdMlWU.ATTEMPTSPEREDGE
						tag = OrdMlWU.ATTEMPTSPEREDGE_TAG;
					case OrdMlWU.NUMBEROFWEIGHTS
						tag = OrdMlWU.NUMBEROFWEIGHTS_TAG;
					case OrdMlWU.RANDOMIZATION
						tag = OrdMlWU.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlWU, POINTER) returns category of POINTER of OrdMlWU.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlWU, POINTER) returns category of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B
					prop_category = OrdMlWU.B_CATEGORY;
				case OrdMlWU.SYMMETRIZE_RULE
					prop_category = OrdMlWU.SYMMETRIZE_RULE_CATEGORY;
				case OrdMlWU.SEMIPOSITIVIZE_RULE
					prop_category = OrdMlWU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMlWU.STANDARDIZE_RULE
					prop_category = OrdMlWU.STANDARDIZE_RULE_CATEGORY;
				case OrdMlWU.ATTEMPTSPEREDGE
					prop_category = OrdMlWU.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMlWU.NUMBEROFWEIGHTS
					prop_category = OrdMlWU.NUMBEROFWEIGHTS_CATEGORY;
				case OrdMlWU.RANDOMIZATION
					prop_category = OrdMlWU.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlWU, POINTER) returns format of POINTER of OrdMlWU.
			%  FORMAT = G.GETPROPFORMAT(OrdMlWU, POINTER) returns format of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B
					prop_format = OrdMlWU.B_FORMAT;
				case OrdMlWU.SYMMETRIZE_RULE
					prop_format = OrdMlWU.SYMMETRIZE_RULE_FORMAT;
				case OrdMlWU.SEMIPOSITIVIZE_RULE
					prop_format = OrdMlWU.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMlWU.STANDARDIZE_RULE
					prop_format = OrdMlWU.STANDARDIZE_RULE_FORMAT;
				case OrdMlWU.ATTEMPTSPEREDGE
					prop_format = OrdMlWU.ATTEMPTSPEREDGE_FORMAT;
				case OrdMlWU.NUMBEROFWEIGHTS
					prop_format = OrdMlWU.NUMBEROFWEIGHTS_FORMAT;
				case OrdMlWU.RANDOMIZATION
					prop_format = OrdMlWU.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlWU, POINTER) returns description of POINTER of OrdMlWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlWU, POINTER) returns description of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.';
				case OrdMlWU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case OrdMlWU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMlWU.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case OrdMlWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case OrdMlWU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMlWU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multilayer weighted undirected graph.';
				case OrdMlWU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.';
				case OrdMlWU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).';
				case OrdMlWU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMlWU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlWU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlWU.A
					prop_description = 'A (result, cell) is the cell containing the within-layer weighted adjacency matrices of the multilayer weighted undirected graph and the ordinal connections between layers.';
				case OrdMlWU.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMlWU.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlWU, POINTER) returns settings of POINTER of OrdMlWU.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlWU, POINTER) returns settings of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlWU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case OrdMlWU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMlWU.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case OrdMlWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlWU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlWU.TEMPLATE
					prop_settings = 'OrdMlWU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlWU, POINTER) returns the default value of POINTER of OrdMlWU.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlWU, POINTER) returns the default value of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B
					prop_default = {[] []; [] []};
				case OrdMlWU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMlWU.NUMBEROFWEIGHTS
					prop_default = 10;
				case OrdMlWU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.ELCLASS
					prop_default = 'OrdMlWU';
				case OrdMlWU.NAME
					prop_default = 'Ordinal Multilayer Weightd Undirected Graph';
				case OrdMlWU.DESCRIPTION
					prop_default = 'In an ordinal multilayer weighted undirected graph (OrdMlWU), layers could have different number of nodes with within-layer weighted undirected edges, associated with a real number between 0 and 1 and indicating the strength of the connection. The connectivity matrices are symmetric (within layer). All node connections are allowed between layers. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case OrdMlWU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.ID
					prop_default = 'OrdMlWU ID';
				case OrdMlWU.LABEL
					prop_default = 'OrdMlWU label';
				case OrdMlWU.NOTES
					prop_default = 'OrdMlWU notes';
				case OrdMlWU.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlWU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlWU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlWU, POINTER) returns the conditioned default value of POINTER of OrdMlWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlWU, POINTER) returns the conditioned default value of POINTER of OrdMlWU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			prop_default = OrdMlWU.conditioning(prop, OrdMlWU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlWU, PROP, VALUE) checks VALUE format for PROP of OrdMlWU.
			%  CHECK = G.CHECKPROP(OrdMlWU, PROP, VALUE) checks VALUE format for PROP of OrdMlWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlWU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlWU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlWU.
			%   Error id: €BRAPH2.STR€:OrdMlWU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlWU.
			%   Error id: €BRAPH2.STR€:OrdMlWU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlWU.getPropProp(pointer);
			
			switch prop
				case OrdMlWU.B % __OrdMlWU.B__
					check = Format.checkFormat(Format.CELL, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.SYMMETRIZE_RULE % __OrdMlWU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.SEMIPOSITIVIZE_RULE % __OrdMlWU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.STANDARDIZE_RULE % __OrdMlWU.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.ATTEMPTSPEREDGE % __OrdMlWU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.NUMBEROFWEIGHTS % __OrdMlWU.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.RANDOMIZATION % __OrdMlWU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMlWU.getPropSettings(prop));
				case OrdMlWU.TEMPLATE % __OrdMlWU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlWU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlWU.getPropTag(prop) ' (' OrdMlWU.getFormatTag(OrdMlWU.getPropFormat(prop)) ').'] ...
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
				case OrdMlWU.RANDOMIZATION % __OrdMlWU.RANDOMIZATION__
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
					
				case OrdMlWU.CONNECTIVITY_TYPE % __OrdMlWU.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.WEIGHTED * ones(layernumber);
					
				case OrdMlWU.DIRECTIONALITY_TYPE % __OrdMlWU.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMlWU.SELFCONNECTIVITY_TYPE % __OrdMlWU.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlWU.NEGATIVITY_TYPE % __OrdMlWU.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlWU.A % __OrdMlWU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlWU.A), 'twister')
					
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
					
					if g.get('GRAPH_TYPE') ~= 5
					
					else
					    if g.get('RANDOMIZE')
					        A = g.get('RANDOMIZATION', A);
					    end
					
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMlWU.ALAYERLABELS % __OrdMlWU.ALAYERLABELS__
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
				case OrdMlWU.B % __OrdMlWU.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlWU.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMlWU.A % __OrdMlWU.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlWU.A, ...
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
