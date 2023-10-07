classdef MultilayerBUD < MultilayerWU
	%MultilayerBUD is a binary undirected multilayer graph with fixed densities.
	% It is a subclass of <a href="matlab:help MultilayerWU">MultilayerWU</a>.
	%
	% In a multilayer binary undirected with fixed densities (BUD) graph, the layers 
	%  are those of binary undirected (BU) multilayer graphs derived from the same 
	%  weighted supra-adjacency matrix binarized at different densities. The supra-adjacency 
	%  matrix has a number of partitions equal to the number of densities. Layers
	%  within the binary undirected (BU) multilayer graphs could have different number of nodes 
	%  with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% MultilayerBUD methods (constructor):
	%  MultilayerBUD - constructor
	%
	% MultilayerBUD methods:
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
	% MultilayerBUD methods (display):
	%  tostring - string with information about the multilayer binary undirected with fixed densities graph
	%  disp - displays information about the multilayer binary undirected with fixed densities graph
	%  tree - displays the tree of the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer binary undirected with fixed densities graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (save/load, Static):
	%  save - saves BRAPH2 multilayer binary undirected with fixed densities graph as b2 file
	%  load - loads a BRAPH2 multilayer binary undirected with fixed densities graph from a b2 file
	%
	% MultilayerBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (inspection, Static):
	%  getClass - returns the class of the multilayer binary undirected with fixed densities graph
	%  getSubclasses - returns all subclasses of MultilayerBUD
	%  getProps - returns the property list of the multilayer binary undirected with fixed densities graph
	%  getPropNumber - returns the property number of the multilayer binary undirected with fixed densities graph
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
	% MultilayerBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = MultilayerWU.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultilayerBUD(varargin)
			%MultilayerBUD() creates a multilayer binary undirected with fixed densities graph.
			%
			% MultilayerBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@MultilayerWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the multilayer binary undirected with fixed densities graph.
			%
			% CLASS = MultilayerBUD.GETCLASS() returns the class 'MultilayerBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer binary undirected with fixed densities graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerBUD') returns 'MultilayerBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerBUD')
			%  are less computationally efficient.
			
			g_class = 'MultilayerBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer binary undirected with fixed densities graph.
			%
			% LIST = MultilayerBUD.GETSUBCLASSES() returns all subclasses of 'MultilayerBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer binary undirected with fixed densities graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerBUD') returns all subclasses of 'MultilayerBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerBUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer binary undirected with fixed densities graph.
			%
			% PROPS = MultilayerBUD.GETPROPS() returns the property list of multilayer binary undirected with fixed densities graph
			%  as a row vector.
			%
			% PROPS = MultilayerBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer binary undirected with fixed densities graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerBUD'[, CATEGORY]) returns the property list of 'MultilayerBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultilayerWU.getProps() ...
						MultilayerBUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultilayerWU.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultilayerWU.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultilayerWU.getProps(Category.PARAMETER) ...
						MultilayerBUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						MultilayerWU.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultilayerWU.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultilayerWU.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultilayerWU.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultilayerWU.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultilayerWU.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multilayer binary undirected with fixed densities graph.
			%
			% N = MultilayerBUD.GETPROPNUMBER() returns the property number of multilayer binary undirected with fixed densities graph.
			%
			% N = MultilayerBUD.GETPROPNUMBER(CATEGORY) returns the property number of multilayer binary undirected with fixed densities graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer binary undirected with fixed densities graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerBUD') returns the property number of 'MultilayerBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerBUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer binary undirected with fixed densities graph/error.
			%
			% CHECK = MultilayerBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerBUD, PROP) checks whether PROP exists for MultilayerBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSPROP(MultilayerBUD, PROP) throws error if PROP does NOT exist for MultilayerBUD.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerBUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer binary undirected with fixed densities graph/error.
			%
			% CHECK = MultilayerBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerBUD, TAG) checks whether TAG exists for MultilayerBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSTAG(MultilayerBUD, TAG) throws error if TAG does NOT exist for MultilayerBUD.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerbud_tag_list = cellfun(@(x) MultilayerBUD.getPropTag(x), num2cell(MultilayerBUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerbud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerBUD, POINTER) returns property number of POINTER of MultilayerBUD.
			%  PROPERTY = G.GETPROPPROP(MultilayerBUD, POINTER) returns property number of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerbud_tag_list = cellfun(@(x) MultilayerBUD.getPropTag(x), num2cell(MultilayerBUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerbud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerBUD, POINTER) returns tag of POINTER of MultilayerBUD.
			%  TAG = G.GETPROPTAG(MultilayerBUD, POINTER) returns tag of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerBUD.DENSITIES
						tag = MultilayerBUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@MultilayerWU(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerBUD, POINTER) returns category of POINTER of MultilayerBUD.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerBUD, POINTER) returns category of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES
					prop_category = MultilayerBUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@MultilayerWU(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerBUD, POINTER) returns format of POINTER of MultilayerBUD.
			%  FORMAT = G.GETPROPFORMAT(MultilayerBUD, POINTER) returns format of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES
					prop_format = MultilayerBUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@MultilayerWU(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerBUD, POINTER) returns description of POINTER of MultilayerBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerBUD, POINTER) returns description of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case MultilayerBUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected multilayer with fixed densities.';
				case MultilayerBUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected multilayer graph with fixed densities.';
				case MultilayerBUD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.';
				case MultilayerBUD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultilayerBUD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultilayerBUD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultilayerBUD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultilayerBUD.A
					prop_description = 'A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed densities (BUD) graph.';
				case MultilayerBUD.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers for each partition (density) of the graph.';
				case MultilayerBUD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case MultilayerBUD.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case MultilayerBUD.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultilayerBUD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultilayerBUD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				otherwise
					prop_description = getPropDescription@MultilayerWU(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerBUD, POINTER) returns settings of POINTER of MultilayerBUD.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerBUD, POINTER) returns settings of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultilayerBUD.TEMPLATE
					prop_settings = 'MultilayerBUD';
				otherwise
					prop_settings = getPropSettings@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerBUD, POINTER) returns the default value of POINTER of MultilayerBUD.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerBUD, POINTER) returns the default value of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES
					prop_default = [0 0 0 0];
				case MultilayerBUD.ELCLASS
					prop_default = 'MultilayerBUD';
				case MultilayerBUD.NAME
					prop_default = 'MultilayerBUD';
				case MultilayerBUD.DESCRIPTION
					prop_default = 'In a multilayer binary undirected with fixed densities (BUD) graph, the layers are those of binary undirected (BU) multilayer graphs derived from the same weighted supra-adjacency matrix binarized at different densities. The supra-adjacency matrix has a number of partitions equal to the number of densities. Layerswithin the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case MultilayerBUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerBUD.getPropSettings(prop));
				case MultilayerBUD.ID
					prop_default = 'MultilayerBUD ID';
				case MultilayerBUD.LABEL
					prop_default = 'MultilayerBUD label';
				case MultilayerBUD.NOTES
					prop_default = 'MultilayerBUD notes';
				case MultilayerBUD.GRAPH_TYPE
					prop_default = Graph.MULTILAYER;
				case MultilayerBUD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultilayerBUD');
				case MultilayerBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerBUD, POINTER) returns the conditioned default value of POINTER of MultilayerBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerBUD, POINTER) returns the conditioned default value of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			prop_default = MultilayerBUD.conditioning(prop, MultilayerBUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerBUD, PROP, VALUE) checks VALUE format for PROP of MultilayerBUD.
			%  CHECK = G.CHECKPROP(MultilayerBUD, PROP, VALUE) checks VALUE format for PROP of MultilayerBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerBUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultilayerBUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUD.
			%   Error id: €BRAPH2.STR€:MultilayerBUD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultilayerBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUD.
			%   Error id: €BRAPH2.STR€:MultilayerBUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case MultilayerBUD.DENSITIES % __MultilayerBUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, MultilayerBUD.getPropSettings(prop));
				case MultilayerBUD.TEMPLATE % __MultilayerBUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerBUD.getPropSettings(prop));
				otherwise
					if prop <= MultilayerWU.getPropNumber()
						check = checkProp@MultilayerWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerBUD.getPropTag(prop) ' (' MultilayerBUD.getFormatTag(MultilayerBUD.getPropFormat(prop)) ').'] ...
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
				case MultilayerBUD.CONNECTIVITY_TYPE % __MultilayerBUD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultilayerBUD.DIRECTIONALITY_TYPE % __MultilayerBUD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultilayerBUD.SELFCONNECTIVITY_TYPE % __MultilayerBUD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultilayerBUD.NEGATIVITY_TYPE % __MultilayerBUD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultilayerBUD.A % __MultilayerBUD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerBUD.A), 'twister')
					
					A_WU = calculateValue@MultilayerWU(g, prop);
					densities = g.get('DENSITIES');
					L = length(A_WU); % number of layers of MultilayerWU
					A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)
					if L > 0 && ~isempty(cell2mat(A_WU))
					    for i = 1:1:length(A)
					        if mod(i, L) == 0
					            i_layer = L;
					            i_density = densities(fix(i/L));
					        else
					            i_layer = mod(i, L);
					            i_density = densities(fix(i/L)+1);
					        end
					        M = symmetrize(A_WU{i_layer, i_layer}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					        M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					        M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					        M = binarize(M, 'density', i_density); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					        A(i, i) = {M};
					        for j = i+1:1:length(A)
					            if mod(j, L) == 0
					                j_layer = L;
					                j_density = densities(fix(j/L));
					            else
					                j_layer = mod(j, L);
					                j_density = densities(fix(j/L)+1);
					            end
					            if i_density == j_density
					                M = semipositivize(A_WU{i_layer, j_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(i, j) = {M};
					                M = semipositivize(A_WU{j_layer, i_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(j, i) = {M};
					            else
					                A(i, j) = {zeros(size(A_WU{i_layer, i_layer}, 1), size(A_WU{j_layer, j_layer}, 2))};
					                A(j, i) = {zeros(size(A_WU{j_layer, j_layer}, 2), size(A_WU{i_layer, i_layer}, 1))};
					            end
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultilayerBUD.PARTITIONS % __MultilayerBUD.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerBUD.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					rng(rng_settings_)
					
				case MultilayerBUD.ALAYERLABELS % __MultilayerBUD.ALAYERLABELS__
					alayerlabels = g.get('LAYERLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
					    densities = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					
					    if length(alayerlabels) == length(g.get('B'))
					        blayerlabels = alayerlabels;
					    else % includes isempty(layerlabels)
					        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
					    end
					    
					    alayerlabels = {};
					    for i = 1:1:length(densities)
					        for j = 1:1:length(blayerlabels)
					            alayerlabels = [alayerlabels, ['L' blayerlabels{j} '|' densities{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case MultilayerBUD.APARTITIONLABELS % __MultilayerBUD.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultilayerBUD.RANDOMIZATION % __MultilayerBUD.RANDOMIZATION__
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
					
				otherwise
					if prop <= MultilayerWU.getPropNumber()
						value = calculateValue@MultilayerWU(g, prop, varargin{:});
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
				case MultilayerBUD.DENSITIES % __MultilayerBUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case MultilayerBUD.A % __MultilayerBUD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerBUD.A, ...
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
					pr = getPanelProp@MultilayerWU(g, prop, varargin{:});
					
			end
		end
	end
end
