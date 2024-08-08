classdef OrdMxBD < Graph
	%OrdMxBD is a ordinal multiplex binary directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multiplex binary directed graph (OrdMxBD), all layers have the same number 
	%  of nodes with within-layer directed edges either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% There are connections between layers connecting the corresponding nodes.
	%
	% OrdMxBD methods (constructor):
	%  OrdMxBD - constructor
	%
	% OrdMxBD methods:
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
	% OrdMxBD methods (display):
	%  tostring - string with information about the ordinal multiplex binary directed graph
	%  disp - displays information about the ordinal multiplex binary directed graph
	%  tree - displays the tree of the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multiplex binary directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multiplex binary directed graph as b2 file
	%  load - loads a BRAPH2 ordinal multiplex binary directed graph from a b2 file
	%
	% OrdMxBD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multiplex binary directed graph
	%
	% OrdMxBD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (inspection, Static):
	%  getClass - returns the class of the ordinal multiplex binary directed graph
	%  getSubclasses - returns all subclasses of OrdMxBD
	%  getProps - returns the property list of the ordinal multiplex binary directed graph
	%  getPropNumber - returns the property number of the ordinal multiplex binary directed graph
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
	% OrdMxBD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxBD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxBD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxBD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxBD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxBD constants</a>.
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
		function g = OrdMxBD(varargin)
			%OrdMxBD() creates a ordinal multiplex binary directed graph.
			%
			% OrdMxBD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxBD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multiplex binary directed graph.
			%
			% CLASS = OrdMxBD.GETCLASS() returns the class 'OrdMxBD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex binary directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxBD') returns 'OrdMxBD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxBD')
			%  are less computationally efficient.
			
			g_class = 'OrdMxBD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multiplex binary directed graph.
			%
			% LIST = OrdMxBD.GETSUBCLASSES() returns all subclasses of 'OrdMxBD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multiplex binary directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxBD') returns all subclasses of 'OrdMxBD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMxBD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex binary directed graph.
			%
			% PROPS = OrdMxBD.GETPROPS() returns the property list of ordinal multiplex binary directed graph
			%  as a row vector.
			%
			% PROPS = OrdMxBD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex binary directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxBD'[, CATEGORY]) returns the property list of 'OrdMxBD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						OrdMxBD.B ...
						OrdMxBD.SEMIPOSITIVIZE_RULE ...
						OrdMxBD.ATTEMPTSPEREDGE ...
						OrdMxBD.RANDOMIZATION ...
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
						OrdMxBD.SEMIPOSITIVIZE_RULE ...
						OrdMxBD.ATTEMPTSPEREDGE ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						OrdMxBD.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						OrdMxBD.RANDOMIZATION ...
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
			%GETPROPNUMBER returns the property number of ordinal multiplex binary directed graph.
			%
			% N = OrdMxBD.GETPROPNUMBER() returns the property number of ordinal multiplex binary directed graph.
			%
			% N = OrdMxBD.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multiplex binary directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multiplex binary directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxBD') returns the property number of 'OrdMxBD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMxBD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multiplex binary directed graph/error.
			%
			% CHECK = OrdMxBD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxBD, PROP) checks whether PROP exists for OrdMxBD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSPROP(OrdMxBD, PROP) throws error if PROP does NOT exist for OrdMxBD.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMxBD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxBD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex binary directed graph/error.
			%
			% CHECK = OrdMxBD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxBD, TAG) checks whether TAG exists for OrdMxBD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSTAG(OrdMxBD, TAG) throws error if TAG does NOT exist for OrdMxBD.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmxbd_tag_list = cellfun(@(x) OrdMxBD.getPropTag(x), num2cell(OrdMxBD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmxbd_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxBD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMxBD, POINTER) returns property number of POINTER of OrdMxBD.
			%  PROPERTY = G.GETPROPPROP(OrdMxBD, POINTER) returns property number of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmxbd_tag_list = cellfun(@(x) OrdMxBD.getPropTag(x), num2cell(OrdMxBD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmxbd_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMxBD, POINTER) returns tag of POINTER of OrdMxBD.
			%  TAG = G.GETPROPTAG(OrdMxBD, POINTER) returns tag of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMxBD.B
						tag = OrdMxBD.B_TAG;
					case OrdMxBD.SEMIPOSITIVIZE_RULE
						tag = OrdMxBD.SEMIPOSITIVIZE_RULE_TAG;
					case OrdMxBD.ATTEMPTSPEREDGE
						tag = OrdMxBD.ATTEMPTSPEREDGE_TAG;
					case OrdMxBD.RANDOMIZATION
						tag = OrdMxBD.RANDOMIZATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxBD, POINTER) returns category of POINTER of OrdMxBD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxBD, POINTER) returns category of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B
					prop_category = OrdMxBD.B_CATEGORY;
				case OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_category = OrdMxBD.SEMIPOSITIVIZE_RULE_CATEGORY;
				case OrdMxBD.ATTEMPTSPEREDGE
					prop_category = OrdMxBD.ATTEMPTSPEREDGE_CATEGORY;
				case OrdMxBD.RANDOMIZATION
					prop_category = OrdMxBD.RANDOMIZATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMxBD, POINTER) returns format of POINTER of OrdMxBD.
			%  FORMAT = G.GETPROPFORMAT(OrdMxBD, POINTER) returns format of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B
					prop_format = OrdMxBD.B_FORMAT;
				case OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_format = OrdMxBD.SEMIPOSITIVIZE_RULE_FORMAT;
				case OrdMxBD.ATTEMPTSPEREDGE
					prop_format = OrdMxBD.ATTEMPTSPEREDGE_FORMAT;
				case OrdMxBD.RANDOMIZATION
					prop_format = OrdMxBD.RANDOMIZATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxBD, POINTER) returns description of POINTER of OrdMxBD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxBD, POINTER) returns description of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices.';
				case OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case OrdMxBD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMxBD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case OrdMxBD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ordinal multiplex binary directed graph.';
				case OrdMxBD.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multiplex binary directed graph.';
				case OrdMxBD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multiplex binary directed graph.';
				case OrdMxBD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multiplex binary directed graph.';
				case OrdMxBD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multiplex binary directed graph.';
				case OrdMxBD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multiplex binary directed graph.';
				case OrdMxBD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multiplex binary directed graph.';
				case OrdMxBD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX__.';
				case OrdMxBD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMxBD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).';
				case OrdMxBD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMxBD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMxBD.A
					prop_description = 'A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.';
				case OrdMxBD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMxBD.COMPATIBLE_MEASURES
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxBD, POINTER) returns settings of POINTER of OrdMxBD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxBD, POINTER) returns settings of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case OrdMxBD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrdMxBD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrdMxBD.TEMPLATE
					prop_settings = 'OrdMxBD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxBD, POINTER) returns the default value of POINTER of OrdMxBD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxBD, POINTER) returns the default value of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B
					prop_default = {[] []};
				case OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrdMxBD.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.ELCLASS
					prop_default = 'OrdMxBD';
				case OrdMxBD.NAME
					prop_default = 'Ordinal Multiplex Binary Directed Graph';
				case OrdMxBD.DESCRIPTION
					prop_default = 'In an ordinal multiplex binary directed graph (OrdMxBD), all layers have the same number of nodes with within-layer directed edges either 0 (absence of connection) or 1 (existence of connection). There are connections between layers connecting the corresponding nodes.';
				case OrdMxBD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.ID
					prop_default = 'OrdMxBD ID';
				case OrdMxBD.LABEL
					prop_default = 'OrdMxBD label';
				case OrdMxBD.NOTES
					prop_default = 'OrdMxBD notes';
				case OrdMxBD.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTIPLEX;
				case OrdMxBD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMxBD');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxBD, POINTER) returns the conditioned default value of POINTER of OrdMxBD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxBD, POINTER) returns the conditioned default value of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			prop_default = OrdMxBD.conditioning(prop, OrdMxBD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMxBD, PROP, VALUE) checks VALUE format for PROP of OrdMxBD.
			%  CHECK = G.CHECKPROP(OrdMxBD, PROP, VALUE) checks VALUE format for PROP of OrdMxBD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMxBD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMxBD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMxBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBD.
			%   Error id: €BRAPH2.STR€:OrdMxBD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMxBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBD.
			%   Error id: €BRAPH2.STR€:OrdMxBD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case OrdMxBD.B % __OrdMxBD.B__
					check = Format.checkFormat(Format.CELL, value, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.SEMIPOSITIVIZE_RULE % __OrdMxBD.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.ATTEMPTSPEREDGE % __OrdMxBD.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.RANDOMIZATION % __OrdMxBD.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, OrdMxBD.getPropSettings(prop));
				case OrdMxBD.TEMPLATE % __OrdMxBD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMxBD.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxBD.getPropTag(prop) ' (' OrdMxBD.getFormatTag(OrdMxBD.getPropFormat(prop)) ').'] ...
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
				case OrdMxBD.RANDOMIZATION % __OrdMxBD.RANDOMIZATION__
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
					
				case OrdMxBD.CONNECTIVITY_TYPE % __OrdMxBD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMxBD.DIRECTIONALITY_TYPE % __OrdMxBD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.DIRECTED * ones(layernumber);
					
				case OrdMxBD.SELFCONNECTIVITY_TYPE % __OrdMxBD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMxBD.NEGATIVITY_TYPE % __OrdMxBD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMxBD.A % __OrdMxBD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxBD.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = dediagonalize(B{i}); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B{i}, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = binarize(M, varargin{:}); % rescales adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
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
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMxBD.ALAYERLABELS % __OrdMxBD.ALAYERLABELS__
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
				case OrdMxBD.B % __OrdMxBD.B__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxBD.B, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', s(3.5), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case OrdMxBD.A % __OrdMxBD.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxBD.A, ...
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
