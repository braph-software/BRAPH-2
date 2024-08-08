classdef MultiplexBD < Graph
	%MultiplexBD is a multiplex binary directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a multiplex binary directed graph (MultiplexBD), all layers have the same number 
	%  of nodes with within-layer directed edges either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% There are connections between layers connecting the corresponding nodes.
	%
	% MultiplexBD methods (constructor):
	%  MultiplexBD - constructor
	%
	% MultiplexBD methods:
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
	% MultiplexBD methods (display):
	%  tostring - string with information about the multiplex binary directed graph
	%  disp - displays information about the multiplex binary directed graph
	%  tree - displays the tree of the multiplex binary directed graph
	%
	% MultiplexBD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex binary directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex binary directed graph
	%
	% MultiplexBD methods (save/load, Static):
	%  save - saves BRAPH2 multiplex binary directed graph as b2 file
	%  load - loads a BRAPH2 multiplex binary directed graph from a b2 file
	%
	% MultiplexBD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex binary directed graph
	%
	% MultiplexBD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex binary directed graph
	%
	% MultiplexBD methods (inspection, Static):
	%  getClass - returns the class of the multiplex binary directed graph
	%  getSubclasses - returns all subclasses of MultiplexBD
	%  getProps - returns the property list of the multiplex binary directed graph
	%  getPropNumber - returns the property number of the multiplex binary directed graph
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
	% MultiplexBD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexBD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexBD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexBD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexBD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexBD constants</a>.
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
		function g = MultiplexBD(varargin)
			%MultiplexBD() creates a multiplex binary directed graph.
			%
			% MultiplexBD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexBD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex binary directed graph.
			%
			% CLASS = MultiplexBD.GETCLASS() returns the class 'MultiplexBD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multiplex binary directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultiplexBD') returns 'MultiplexBD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultiplexBD')
			%  are less computationally efficient.
			
			g_class = 'MultiplexBD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex binary directed graph.
			%
			% LIST = MultiplexBD.GETSUBCLASSES() returns all subclasses of 'MultiplexBD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multiplex binary directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultiplexBD') returns all subclasses of 'MultiplexBD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexBD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex binary directed graph.
			%
			% PROPS = MultiplexBD.GETPROPS() returns the property list of multiplex binary directed graph
			%  as a row vector.
			%
			% PROPS = MultiplexBD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multiplex binary directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultiplexBD'[, CATEGORY]) returns the property list of 'MultiplexBD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						MultiplexBD.B ...
						MultiplexBD.SEMIPOSITIVIZE_RULE ...
						MultiplexBD.ATTEMPTSPEREDGE ...
						MultiplexBD.RANDOMIZATION ...
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
						MultiplexBD.SEMIPOSITIVIZE_RULE ...
						MultiplexBD.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						MultiplexBD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						MultiplexBD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of multiplex binary directed graph.
			%
			% N = MultiplexBD.GETPROPNUMBER() returns the property number of multiplex binary directed graph.
			%
			% N = MultiplexBD.GETPROPNUMBER(CATEGORY) returns the property number of multiplex binary directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex binary directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultiplexBD') returns the property number of 'MultiplexBD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexBD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex binary directed graph/error.
			%
			% CHECK = MultiplexBD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultiplexBD, PROP) checks whether PROP exists for MultiplexBD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%  Element.EXISTSPROP(MultiplexBD, PROP) throws error if PROP does NOT exist for MultiplexBD.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexBD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexBD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex binary directed graph/error.
			%
			% CHECK = MultiplexBD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultiplexBD, TAG) checks whether TAG exists for MultiplexBD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%  Element.EXISTSTAG(MultiplexBD, TAG) throws error if TAG does NOT exist for MultiplexBD.
			%   Error id: [BRAPH2:MultiplexBD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexbd_tag_list = cellfun(@(x) MultiplexBD.getPropTag(x), num2cell(MultiplexBD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexbd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexBD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexBD, POINTER) returns property number of POINTER of MultiplexBD.
			%  PROPERTY = G.GETPROPPROP(MultiplexBD, POINTER) returns property number of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexbd_tag_list = cellfun(@(x) MultiplexBD.getPropTag(x), num2cell(MultiplexBD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexbd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexBD, POINTER) returns tag of POINTER of MultiplexBD.
			%  TAG = G.GETPROPTAG(MultiplexBD, POINTER) returns tag of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexBD.B
						tag = MultiplexBD.B_TAG;
					case MultiplexBD.SEMIPOSITIVIZE_RULE
						tag = MultiplexBD.SEMIPOSITIVIZE_RULE_TAG;
					case MultiplexBD.ATTEMPTSPEREDGE
						tag = MultiplexBD.ATTEMPTSPEREDGE_TAG;
					case MultiplexBD.RANDOMIZATION
						tag = MultiplexBD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexBD, POINTER) returns category of POINTER of MultiplexBD.
			%  CATEGORY = G.GETPROPCATEGORY(MultiplexBD, POINTER) returns category of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B
					prop_category = MultiplexBD.B_CATEGORY;
				case MultiplexBD.SEMIPOSITIVIZE_RULE
					prop_category = MultiplexBD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case MultiplexBD.ATTEMPTSPEREDGE
					prop_category = MultiplexBD.ATTEMPTSPEREDGE_CATEGORY;
				case MultiplexBD.RANDOMIZATION
					prop_category = MultiplexBD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexBD, POINTER) returns format of POINTER of MultiplexBD.
			%  FORMAT = G.GETPROPFORMAT(MultiplexBD, POINTER) returns format of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B
					prop_format = MultiplexBD.B_FORMAT;
				case MultiplexBD.SEMIPOSITIVIZE_RULE
					prop_format = MultiplexBD.SEMIPOSITIVIZE_RULE_FORMAT;
				case MultiplexBD.ATTEMPTSPEREDGE
					prop_format = MultiplexBD.ATTEMPTSPEREDGE_FORMAT;
				case MultiplexBD.RANDOMIZATION
					prop_format = MultiplexBD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexBD, POINTER) returns description of POINTER of MultiplexBD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultiplexBD, POINTER) returns description of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices.';
				case MultiplexBD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case MultiplexBD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultiplexBD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case MultiplexBD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the multiplex binary directed graph.';
				case MultiplexBD.NAME
					prop_description = 'NAME (constant, string) is the name of the multiplex binary directed graph.';
				case MultiplexBD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multiplex binary directed graph.';
				case MultiplexBD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multiplex binary directed graph.';
				case MultiplexBD.ID
					prop_description = 'ID (data, string) is a few-letter code for the multiplex binary directed graph.';
				case MultiplexBD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multiplex binary directed graph.';
				case MultiplexBD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multiplex binary directed graph.';
				case MultiplexBD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type Graph.MULTIPLEX.';
				case MultiplexBD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultiplexBD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case MultiplexBD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultiplexBD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultiplexBD.A
					prop_description = 'A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.';
				case MultiplexBD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultiplexBD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexBD, POINTER) returns settings of POINTER of MultiplexBD.
			%  SETTINGS = G.GETPROPSETTINGS(MultiplexBD, POINTER) returns settings of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexBD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case MultiplexBD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultiplexBD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MultiplexBD.TEMPLATE
					prop_settings = 'MultiplexBD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexBD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexBD, POINTER) returns the default value of POINTER of MultiplexBD.
			%  DEFAULT = G.GETPROPDEFAULT(MultiplexBD, POINTER) returns the default value of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B
					prop_default = {[] []};
				case MultiplexBD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.ATTEMPTSPEREDGE
					prop_default = 5;
				case MultiplexBD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.ELCLASS
					prop_default = 'MultiplexBD';
				case MultiplexBD.NAME
					prop_default = 'Multiplex Binary Directed';
				case MultiplexBD.DESCRIPTION
					prop_default = 'In a multiplex binary directed graph (MultiplexBD), all layers have the same number of nodes with within-layer directed edges either 0 (absence of connection) or 1 (existence of connection). There are connections between layers connecting the corresponding nodes.';
				case MultiplexBD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.ID
					prop_default = 'MultiplexBD ID';
				case MultiplexBD.LABEL
					prop_default = 'MultiplexBD label';
				case MultiplexBD.NOTES
					prop_default = 'MultiplexBD notes';
				case MultiplexBD.GRAPH_TYPE
					prop_default = Graph.MULTIPLEX;
				case MultiplexBD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultiplexBD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexBD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexBD, POINTER) returns the conditioned default value of POINTER of MultiplexBD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultiplexBD, POINTER) returns the conditioned default value of POINTER of MultiplexBD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			prop_default = MultiplexBD.conditioning(prop, MultiplexBD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexBD, PROP, VALUE) checks VALUE format for PROP of MultiplexBD.
			%  CHECK = G.CHECKPROP(MultiplexBD, PROP, VALUE) checks VALUE format for PROP of MultiplexBD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexBD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultiplexBD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBD.
			%   Error id: €BRAPH2.STR€:MultiplexBD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultiplexBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBD.
			%   Error id: €BRAPH2.STR€:MultiplexBD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultiplexBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexBD.getPropProp(pointer);
			
			switch prop
				case MultiplexBD.B % __MultiplexBD.B__
					check = Format.checkFormat(Format.CELL, value, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.SEMIPOSITIVIZE_RULE % __MultiplexBD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.ATTEMPTSPEREDGE % __MultiplexBD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.RANDOMIZATION % __MultiplexBD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, MultiplexBD.getPropSettings(prop));
				case MultiplexBD.TEMPLATE % __MultiplexBD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexBD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexBD.getPropTag(prop) ' (' MultiplexBD.getFormatTag(MultiplexBD.getPropFormat(prop)) ').'] ...
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
				case MultiplexBD.RANDOMIZATION % __MultiplexBD.RANDOMIZATION__
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
					
				case MultiplexBD.CONNECTIVITY_TYPE % __MultiplexBD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultiplexBD.DIRECTIONALITY_TYPE % __MultiplexBD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case MultiplexBD.SELFCONNECTIVITY_TYPE % __MultiplexBD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultiplexBD.NEGATIVITY_TYPE % __MultiplexBD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultiplexBD.A % __MultiplexBD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexBD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = dediagonalize(B{i}); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B{i}, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = binarize(M, varargin{:}); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
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
					
				case MultiplexBD.ALAYERLABELS % __MultiplexBD.ALAYERLABELS__
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
				case MultiplexBD.B % __MultiplexBD.B__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexBD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case MultiplexBD.A % __MultiplexBD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexBD.A, ...
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
