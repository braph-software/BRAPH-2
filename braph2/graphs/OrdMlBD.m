classdef OrdMlBD < Graph
	%OrdMlBD is a ordinal multilayer binary directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multilayer binary directed (BD) graph, layers could have different number 
	%  of nodes with within-layer directed edges. Edges can be either 0 (absence of connection) 
	% or 1 (existence of connection).
	% All node connections are allowed between layers.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% OrdMlBD methods (constructor):
	%  OrdMlBD - constructor
	%
	% OrdMlBD methods:
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
	% OrdMlBD methods (display):
	%  tostring - string with information about the ordinal multilayer binary directed graph
	%  disp - displays information about the ordinal multilayer binary directed graph
	%  tree - displays the tree of the ordinal multilayer binary directed graph
	%
	% OrdMlBD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multilayer binary directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multilayer binary directed graph
	%
	% OrdMlBD methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multilayer binary directed graph as b2 file
	%  load - loads a BRAPH2 ordinal multilayer binary directed graph from a b2 file
	%
	% OrdMlBD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multilayer binary directed graph
	%
	% OrdMlBD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multilayer binary directed graph
	%
	% OrdMlBD methods (inspection, Static):
	%  getClass - returns the class of the ordinal multilayer binary directed graph
	%  getSubclasses - returns all subclasses of OrdMlBD
	%  getProps - returns the property list of the ordinal multilayer binary directed graph
	%  getPropNumber - returns the property number of the ordinal multilayer binary directed graph
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
	% OrdMlBD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlBD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlBD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlBD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlBD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlBD constants</a>.
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
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 3;
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		RANDOMIZATION = Graph.getPropNumber() + 4;
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = Category.QUERY;
		RANDOMIZATION_FORMAT = Format.CELL;
	end
	methods % constructor
		function g = OrdMlBD(varargin)
			%OrdMlBD() creates a ordinal multilayer binary directed graph.
			%
			% OrdMlBD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlBD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multilayer binary directed graph.
			%
			% CLASS = OrdMlBD.GETCLASS() returns the class 'OrdMlBD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multilayer binary directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlBD') returns 'OrdMlBD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlBD')
			%  are less computationally efficient.
			
			g_class = 'OrdMlBD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multilayer binary directed graph.
			%
			% LIST = OrdMlBD.GETSUBCLASSES() returns all subclasses of 'OrdMlBD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multilayer binary directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlBD') returns all subclasses of 'OrdMlBD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlBD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multilayer binary directed graph.
			%
			% PROPS = OrdMlBD.GETPROPS() returns the property list of ordinal multilayer binary directed graph
			%  as a row vector.
			%
			% PROPS = OrdMlBD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multilayer binary directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlBD'[, CATEGORY]) returns the property list of 'OrdMlBD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMlBD.B ...
						OrdMlBD.SEMIPOSITIVIZE_RULE ...
						OrdMlBD.ATTEMPTSPEREDGE ...
						OrdMlBD.RANDOMIZATION ...
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
						OrdMlBD.SEMIPOSITIVIZE_RULE ...
						OrdMlBD.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMlBD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMlBD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multilayer binary directed graph.
			%
			% N = OrdMlBD.GETPROPNUMBER() returns the property number of ordinal multilayer binary directed graph.
			%
			% N = OrdMlBD.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multilayer binary directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multilayer binary directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlBD') returns the property number of 'OrdMlBD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlBD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multilayer binary directed graph/error.
			%
			% CHECK = OrdMlBD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlBD, PROP) checks whether PROP exists for OrdMlBD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%  Element.EXISTSPROP(OrdMlBD, PROP) throws error if PROP does NOT exist for OrdMlBD.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlBD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlBD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multilayer binary directed graph/error.
			%
			% CHECK = OrdMlBD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlBD, TAG) checks whether TAG exists for OrdMlBD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%  Element.EXISTSTAG(OrdMlBD, TAG) throws error if TAG does NOT exist for OrdMlBD.
			%   Error id: [BRAPH2:OrdMlBD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlbd_tag_list = cellfun(@(x) OrdMlBD.getPropTag(x), num2cell(OrdMlBD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlbd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlBD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlBD, POINTER) returns property number of POINTER of OrdMlBD.
			%  PROPERTY = G.GETPROPPROP(OrdMlBD, POINTER) returns property number of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlbd_tag_list = cellfun(@(x) OrdMlBD.getPropTag(x), num2cell(OrdMlBD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlbd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlBD, POINTER) returns tag of POINTER of OrdMlBD.
			%  TAG = G.GETPROPTAG(OrdMlBD, POINTER) returns tag of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlBD.B
						tag = OrdMlBD.B_TAG;
					case OrdMlBD.SEMIPOSITIVIZE_RULE
						tag = OrdMlBD.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMlBD.ATTEMPTSPEREDGE
						tag = OrdMlBD.ATTEMPTSPEREDGE_TAG;
					case OrdMlBD.RANDOMIZATION
						tag = OrdMlBD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlBD, POINTER) returns category of POINTER of OrdMlBD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlBD, POINTER) returns category of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B
					prop_category = OrdMlBD.B_CATEGORY;
				case OrdMlBD.SEMIPOSITIVIZE_RULE
					prop_category = OrdMlBD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMlBD.ATTEMPTSPEREDGE
					prop_category = OrdMlBD.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMlBD.RANDOMIZATION
					prop_category = OrdMlBD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlBD, POINTER) returns format of POINTER of OrdMlBD.
			%  FORMAT = G.GETPROPFORMAT(OrdMlBD, POINTER) returns format of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B
					prop_format = OrdMlBD.B_FORMAT;
				case OrdMlBD.SEMIPOSITIVIZE_RULE
					prop_format = OrdMlBD.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMlBD.ATTEMPTSPEREDGE
					prop_format = OrdMlBD.ATTEMPTSPEREDGE_FORMAT;
				case OrdMlBD.RANDOMIZATION
					prop_format = OrdMlBD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlBD, POINTER) returns description of POINTER of OrdMlBD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlBD, POINTER) returns description of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B
					prop_description = 'B (data, cell) is the input cell containing the multilayer adjacency matrices.';
				case OrdMlBD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMlBD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlBD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMlBD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case OrdMlBD.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multilayer binary directed graph.';
				case OrdMlBD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multilayer binary directed graph.';
				case OrdMlBD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multilayer binary directed graph.';
				case OrdMlBD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multilayer binary directed graph.';
				case OrdMlBD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multilayer binary directed graph.';
				case OrdMlBD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multilayer binary directed graph.';
				case OrdMlBD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTILAYER__.';
				case OrdMlBD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMlBD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case OrdMlBD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlBD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlBD.A
					prop_description = 'A (result, cell) is the cell containing the within-layer binary adjacency matrices of the multilayer binary directed graph and the ordinal connections between layers.';
				case OrdMlBD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMlBD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlBD, POINTER) returns settings of POINTER of OrdMlBD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlBD, POINTER) returns settings of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlBD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMlBD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMlBD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMlBD.TEMPLATE
					prop_settings = 'OrdMlBD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlBD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlBD, POINTER) returns the default value of POINTER of OrdMlBD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlBD, POINTER) returns the default value of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B
					prop_default = {[] []; [] []};
				case OrdMlBD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMlBD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.ELCLASS
					prop_default = 'OrdMlBD';
				case OrdMlBD.NAME
					prop_default = 'OrdMlBD';
				case OrdMlBD.DESCRIPTION
					prop_default = 'In an ordinal multilayer binary directed (BD) graph, layers could have different number  of nodes with within-layer directed edges. Edges can be either 0 (absence of connection)  or 1 (existence of connection). All node connections are allowed between layers. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case OrdMlBD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.ID
					prop_default = 'OrdMlBD ID';
				case OrdMlBD.LABEL
					prop_default = 'OrdMlBD label';
				case OrdMlBD.NOTES
					prop_default = 'OrdMlBD notes';
				case OrdMlBD.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlBD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlBD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlBD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlBD, POINTER) returns the conditioned default value of POINTER of OrdMlBD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlBD, POINTER) returns the conditioned default value of POINTER of OrdMlBD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			prop_default = OrdMlBD.conditioning(prop, OrdMlBD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlBD, PROP, VALUE) checks VALUE format for PROP of OrdMlBD.
			%  CHECK = G.CHECKPROP(OrdMlBD, PROP, VALUE) checks VALUE format for PROP of OrdMlBD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlBD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlBD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBD.
			%   Error id: €BRAPH2.STR€:OrdMlBD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBD.
			%   Error id: €BRAPH2.STR€:OrdMlBD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlBD.getPropProp(pointer);
			
			switch prop
				case OrdMlBD.B % __OrdMlBD.B__
					check = Format.checkFormat(Format.CELL, value, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.SEMIPOSITIVIZE_RULE % __OrdMlBD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.ATTEMPTSPEREDGE % __OrdMlBD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.RANDOMIZATION % __OrdMlBD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMlBD.getPropSettings(prop));
				case OrdMlBD.TEMPLATE % __OrdMlBD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlBD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlBD.getPropTag(prop) ' (' OrdMlBD.getFormatTag(OrdMlBD.getPropFormat(prop)) ').'] ...
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
				case OrdMlBD.RANDOMIZATION % __OrdMlBD.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    tmp_g = GraphBD();
					    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case OrdMlBD.CONNECTIVITY_TYPE % __OrdMlBD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMlBD.DIRECTIONALITY_TYPE % __OrdMlBD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case OrdMlBD.SELFCONNECTIVITY_TYPE % __OrdMlBD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlBD.NEGATIVITY_TYPE % __OrdMlBD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlBD.A % __OrdMlBD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = dediagonalize(B{i,i}); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = binarize(M, varargin{:}); % rescales adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					    A(i, i) = {M};
					    if ~isempty(A{1, 1})
					        for j = i+1:1:L
					            M = semipositivize(B{i,j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = binarize(M);  % rescales adjacency matrix
					            A(i, j) = {M};
					            M = semipositivize(B{j,i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					            M = binarize(M);  % rescales adjacency matrix
					            A(j, i) = {M};
					        end
					    end
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMlBD.ALAYERLABELS % __OrdMlBD.ALAYERLABELS__
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
				case OrdMlBD.B % __OrdMlBD.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMlBD.A % __OrdMlBD.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBD.A, ...
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
