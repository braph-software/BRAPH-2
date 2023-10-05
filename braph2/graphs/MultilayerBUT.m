classdef MultilayerBUT < MultilayerWU
	%MultilayerBUT is a multilayer binary undirected graph with fixed thresholds.
	% It is a subclass of <a href="matlab:help MultilayerWU">MultilayerWU</a>.
	%
	% In a multilayer binary undirected with fixed thresholds (BUT) graph, the layers 
	%  are those of binary undirected (BU) multilayer graphs derived from the same 
	%  weighted supra-adjacency matrix binarized at different thresholds. The supra-adjacency 
	%  matrix has a number of partitions equal to the number of thresholds. Layers
	%  within the binary undirected (BU) multilayer graphs could have different number of nodes 
	%  with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% MultilayerBUT methods (constructor):
	%  MultilayerBUT - constructor
	%
	% MultilayerBUT methods:
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
	% MultilayerBUT methods (display):
	%  tostring - string with information about the multilayer binary undirected with fixed thresholds graph
	%  disp - displays information about the multilayer binary undirected with fixed thresholds graph
	%  tree - displays the tree of the multilayer binary undirected with fixed thresholds graph
	%
	% MultilayerBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer binary undirected with fixed thresholds graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer binary undirected with fixed thresholds graph
	%
	% MultilayerBUT methods (save/load, Static):
	%  save - saves BRAPH2 multilayer binary undirected with fixed thresholds graph as b2 file
	%  load - loads a BRAPH2 multilayer binary undirected with fixed thresholds graph from a b2 file
	%
	% MultilayerBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed thresholds graph
	%
	% MultilayerBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed thresholds graph
	%
	% MultilayerBUT methods (inspection, Static):
	%  getClass - returns the class of the multilayer binary undirected with fixed thresholds graph
	%  getSubclasses - returns all subclasses of MultilayerBUT
	%  getProps - returns the property list of the multilayer binary undirected with fixed thresholds graph
	%  getPropNumber - returns the property number of the multilayer binary undirected with fixed thresholds graph
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
	% MultilayerBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = MultilayerWU.getPropNumber() + 1;
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultilayerBUT(varargin)
			%MultilayerBUT() creates a multilayer binary undirected with fixed thresholds graph.
			%
			% MultilayerBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerBUT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multilayer binary undirected with fixed thresholds graph.
			%
			% CLASS = MultilayerBUT.GETCLASS() returns the class 'MultilayerBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer binary undirected with fixed thresholds graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerBUT') returns 'MultilayerBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerBUT')
			%  are less computationally efficient.
			
			g_class = 'MultilayerBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer binary undirected with fixed thresholds graph.
			%
			% LIST = MultilayerBUT.GETSUBCLASSES() returns all subclasses of 'MultilayerBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer binary undirected with fixed thresholds graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerBUT') returns all subclasses of 'MultilayerBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerBUT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer binary undirected with fixed thresholds graph.
			%
			% PROPS = MultilayerBUT.GETPROPS() returns the property list of multilayer binary undirected with fixed thresholds graph
			%  as a row vector.
			%
			% PROPS = MultilayerBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer binary undirected with fixed thresholds graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerBUT'[, CATEGORY]) returns the property list of 'MultilayerBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultilayerWU.getProps() ...
						MultilayerBUT.THRESHOLDS ...
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
						MultilayerBUT.THRESHOLDS ...
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
			%GETPROPNUMBER returns the property number of multilayer binary undirected with fixed thresholds graph.
			%
			% N = MultilayerBUT.GETPROPNUMBER() returns the property number of multilayer binary undirected with fixed thresholds graph.
			%
			% N = MultilayerBUT.GETPROPNUMBER(CATEGORY) returns the property number of multilayer binary undirected with fixed thresholds graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer binary undirected with fixed thresholds graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerBUT') returns the property number of 'MultilayerBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerBUT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer binary undirected with fixed thresholds graph/error.
			%
			% CHECK = MultilayerBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerBUT, PROP) checks whether PROP exists for MultilayerBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%  Element.EXISTSPROP(MultilayerBUT, PROP) throws error if PROP does NOT exist for MultilayerBUT.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerBUT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer binary undirected with fixed thresholds graph/error.
			%
			% CHECK = MultilayerBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerBUT, TAG) checks whether TAG exists for MultilayerBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%  Element.EXISTSTAG(MultilayerBUT, TAG) throws error if TAG does NOT exist for MultilayerBUT.
			%   Error id: [BRAPH2:MultilayerBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerbut_tag_list = cellfun(@(x) MultilayerBUT.getPropTag(x), num2cell(MultilayerBUT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerbut_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerBUT, POINTER) returns property number of POINTER of MultilayerBUT.
			%  PROPERTY = G.GETPROPPROP(MultilayerBUT, POINTER) returns property number of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerbut_tag_list = cellfun(@(x) MultilayerBUT.getPropTag(x), num2cell(MultilayerBUT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerbut_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerBUT, POINTER) returns tag of POINTER of MultilayerBUT.
			%  TAG = G.GETPROPTAG(MultilayerBUT, POINTER) returns tag of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerBUT.THRESHOLDS
						tag = MultilayerBUT.THRESHOLDS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerBUT, POINTER) returns category of POINTER of MultilayerBUT.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerBUT, POINTER) returns category of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS
					prop_category = MultilayerBUT.THRESHOLDS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerBUT, POINTER) returns format of POINTER of MultilayerBUT.
			%  FORMAT = G.GETPROPFORMAT(MultilayerBUT, POINTER) returns format of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS
					prop_format = MultilayerBUT.THRESHOLDS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerBUT, POINTER) returns description of POINTER of MultilayerBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerBUT, POINTER) returns description of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case MultilayerBUT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.NAME
					prop_description = 'NAME (constant, string) is the name of the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.ID
					prop_description = 'ID (data, string) is a few-letter code for the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multilayer binary undirected graph with fixed thresholds.';
				case MultilayerBUT.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.';
				case MultilayerBUT.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultilayerBUT.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultilayerBUT.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultilayerBUT.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultilayerBUT.A
					prop_description = 'A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed thresholds (BUT) graph.';
				case MultilayerBUT.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.';
				case MultilayerBUT.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultilayerBUT.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case MultilayerBUT.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultilayerBUT.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultilayerBUT.RANDOMIZATION
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerBUT, POINTER) returns settings of POINTER of MultilayerBUT.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerBUT, POINTER) returns settings of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultilayerBUT.TEMPLATE
					prop_settings = 'MultilayerBUT';
				otherwise
					prop_settings = getPropSettings@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerBUT, POINTER) returns the default value of POINTER of MultilayerBUT.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerBUT, POINTER) returns the default value of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS
					prop_default = [0 0 0 0];
				case MultilayerBUT.ELCLASS
					prop_default = 'MultilayerBUT';
				case MultilayerBUT.NAME
					prop_default = 'MultilayerBUT';
				case MultilayerBUT.DESCRIPTION
					prop_default = 'In a multilayer binary undirected with fixed thresholds (BUT) graph, the layers are those of binary undirected (BU) multilayer graphs derived from the same weighted supra-adjacency matrix binarized at different thresholds. The supra-adjacency  matrix has a number of partitions equal to the number of thresholds. Layers within the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case MultilayerBUT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerBUT.getPropSettings(prop));
				case MultilayerBUT.ID
					prop_default = 'MultilayerBUT ID';
				case MultilayerBUT.LABEL
					prop_default = 'MultilayerBUT label';
				case MultilayerBUT.NOTES
					prop_default = 'MultilayerBUT notes';
				case MultilayerBUT.GRAPH_TYPE
					prop_default = Graph.MULTILAYER;
				case MultilayerBUT.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultilayerBUT');
				case MultilayerBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerBUT, POINTER) returns the conditioned default value of POINTER of MultilayerBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerBUT, POINTER) returns the conditioned default value of POINTER of MultilayerBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			prop_default = MultilayerBUT.conditioning(prop, MultilayerBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerBUT, PROP, VALUE) checks VALUE format for PROP of MultilayerBUT.
			%  CHECK = G.CHECKPROP(MultilayerBUT, PROP, VALUE) checks VALUE format for PROP of MultilayerBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerBUT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultilayerBUT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUT.
			%   Error id: €BRAPH2.STR€:MultilayerBUT:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultilayerBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUT.
			%   Error id: €BRAPH2.STR€:MultilayerBUT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerBUT.getPropProp(pointer);
			
			switch prop
				case MultilayerBUT.THRESHOLDS % __MultilayerBUT.THRESHOLDS__
					check = Format.checkFormat(Format.RVECTOR, value, MultilayerBUT.getPropSettings(prop));
				case MultilayerBUT.TEMPLATE % __MultilayerBUT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerBUT.getPropSettings(prop));
				otherwise
					if prop <= MultilayerWU.getPropNumber()
						check = checkProp@MultilayerWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerBUT.getPropTag(prop) ' (' MultilayerBUT.getFormatTag(MultilayerBUT.getPropFormat(prop)) ').'] ...
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
				case MultilayerBUT.CONNECTIVITY_TYPE % __MultilayerBUT.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultilayerBUT.DIRECTIONALITY_TYPE % __MultilayerBUT.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultilayerBUT.SELFCONNECTIVITY_TYPE % __MultilayerBUT.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultilayerBUT.NEGATIVITY_TYPE % __MultilayerBUT.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultilayerBUT.A % __MultilayerBUT.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerBUT.A), 'twister')
					
					A_WU = calculateValue@MultilayerWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					L = length(A_WU); % number of layers
					A = cell(length(thresholds)*L);
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    for i = 1:1:length(thresholds)
					        threshold = thresholds(i);
					        layer_x = 1;
					        for j = (i - 1) * L + 1:1:i * L
					            layer_y = 1;
						        for k = (i - 1) * L + 1:1:i * L
					                if j==k
					                    M = symmetrize(A_WU{layer_x, layer_x}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					                    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					                    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                    M = binarize(M,  'threshold', threshold); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                    A(j, j) = {M};
					                else
					                    M = semipositivize(A_WU{layer_x, layer_y}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                    M = binarize(M, 'threshold', threshold, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                    A(j, k) = {M};
					                end
					                layer_y = layer_y + 1;
					            end
					            layer_y = 1;
					            for n = k + 1:1:length(thresholds)*L
					                if layer_y == L+1
					                    layer_y = 1;
					                end
					                A(j, n) = {zeros(size(A_WU{layer_x, layer_y}, 1), size(A_WU{layer_x, layer_y}, 2))};
					                A(n, j) = {zeros(size(A_WU{layer_y, layer_x}, 1), size(A_WU{layer_y, layer_x}, 2))};
					                layer_y = layer_y + 1;
					            end
					            layer_x = layer_x + 1;
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultilayerBUT.PARTITIONS % __MultilayerBUT.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultilayerBUT.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case MultilayerBUT.ALAYERLABELS % __MultilayerBUT.ALAYERLABELS__
					alayerlabels = g.get('LAYERLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
					    thresholds = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					
					    if length(alayerlabels) == length(g.get('B'))
					        blayerlabels = alayerlabels;
					    else % includes isempty(layerlabels)
					        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
					    end
					    
					    alayerlabels = {};
					    for i = 1:1:length(thresholds)
					        for j = 1:1:length(blayerlabels)
					            alayerlabels = [alayerlabels, ['L' blayerlabels{j} '|' thresholds{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case MultilayerBUT.APARTITIONLABELS % __MultilayerBUT.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= g.get('THRESHOLDS') % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultilayerBUT.RANDOMIZATION % __MultilayerBUT.RANDOMIZATION__
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
				case MultilayerBUT.THRESHOLDS % __MultilayerBUT.THRESHOLDS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case MultilayerBUT.A % __MultilayerBUT.A__
					pr = PanelPropCell('EL', g, 'PROP', MultilayerBUT.A, ...
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
