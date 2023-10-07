classdef MultigraphBUD < GraphWU
	%MultigraphBUD is a binary undirected multigraph with fixed densities.
	% It is a subclass of <a href="matlab:help GraphWU">GraphWU</a>.
	%
	% In a binary undirected multigraph with fixed densities, all the layers 
	%  consist of binary undirected (BU) graphs derived from the same weighted 
	%  connectivity matrix binarized at different densities.
	% There are no connections between layers.
	%
	% MultigraphBUD methods (constructor):
	%  MultigraphBUD - constructor
	%
	% MultigraphBUD methods:
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
	% MultigraphBUD methods (display):
	%  tostring - string with information about the binary undirected multigraph with fixed densities
	%  disp - displays information about the binary undirected multigraph with fixed densities
	%  tree - displays the tree of the binary undirected multigraph with fixed densities
	%
	% MultigraphBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multigraph with fixed densities are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multigraph with fixed densities
	%
	% MultigraphBUD methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multigraph with fixed densities as b2 file
	%  load - loads a BRAPH2 binary undirected multigraph with fixed densities from a b2 file
	%
	% MultigraphBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multigraph with fixed densities
	%
	% MultigraphBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multigraph with fixed densities
	%
	% MultigraphBUD methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multigraph with fixed densities
	%  getSubclasses - returns all subclasses of MultigraphBUD
	%  getProps - returns the property list of the binary undirected multigraph with fixed densities
	%  getPropNumber - returns the property number of the binary undirected multigraph with fixed densities
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
	% MultigraphBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultigraphBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultigraphBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultigraphBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultigraphBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultigraphBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = GraphWU.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultigraphBUD(varargin)
			%MultigraphBUD() creates a binary undirected multigraph with fixed densities.
			%
			% MultigraphBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultigraphBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@GraphWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the binary undirected multigraph with fixed densities.
			%
			% CLASS = MultigraphBUD.GETCLASS() returns the class 'MultigraphBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multigraph with fixed densities G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultigraphBUD') returns 'MultigraphBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultigraphBUD')
			%  are less computationally efficient.
			
			g_class = 'MultigraphBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multigraph with fixed densities.
			%
			% LIST = MultigraphBUD.GETSUBCLASSES() returns all subclasses of 'MultigraphBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multigraph with fixed densities G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultigraphBUD') returns all subclasses of 'MultigraphBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultigraphBUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multigraph with fixed densities.
			%
			% PROPS = MultigraphBUD.GETPROPS() returns the property list of binary undirected multigraph with fixed densities
			%  as a row vector.
			%
			% PROPS = MultigraphBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multigraph with fixed densities G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultigraphBUD'[, CATEGORY]) returns the property list of 'MultigraphBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GraphWU.getProps() ...
						MultigraphBUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						GraphWU.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						GraphWU.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GraphWU.getProps(Category.PARAMETER) ...
						MultigraphBUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						GraphWU.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						GraphWU.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						GraphWU.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						GraphWU.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GraphWU.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GraphWU.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of binary undirected multigraph with fixed densities.
			%
			% N = MultigraphBUD.GETPROPNUMBER() returns the property number of binary undirected multigraph with fixed densities.
			%
			% N = MultigraphBUD.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multigraph with fixed densities
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multigraph with fixed densities G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultigraphBUD') returns the property number of 'MultigraphBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultigraphBUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multigraph with fixed densities/error.
			%
			% CHECK = MultigraphBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultigraphBUD, PROP) checks whether PROP exists for MultigraphBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%  Element.EXISTSPROP(MultigraphBUD, PROP) throws error if PROP does NOT exist for MultigraphBUD.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultigraphBUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultigraphBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multigraph with fixed densities/error.
			%
			% CHECK = MultigraphBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultigraphBUD, TAG) checks whether TAG exists for MultigraphBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%  Element.EXISTSTAG(MultigraphBUD, TAG) throws error if TAG does NOT exist for MultigraphBUD.
			%   Error id: [BRAPH2:MultigraphBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multigraphbud_tag_list = cellfun(@(x) MultigraphBUD.getPropTag(x), num2cell(MultigraphBUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multigraphbud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultigraphBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultigraphBUD, POINTER) returns property number of POINTER of MultigraphBUD.
			%  PROPERTY = G.GETPROPPROP(MultigraphBUD, POINTER) returns property number of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multigraphbud_tag_list = cellfun(@(x) MultigraphBUD.getPropTag(x), num2cell(MultigraphBUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multigraphbud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultigraphBUD, POINTER) returns tag of POINTER of MultigraphBUD.
			%  TAG = G.GETPROPTAG(MultigraphBUD, POINTER) returns tag of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultigraphBUD.DENSITIES
						tag = MultigraphBUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@GraphWU(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultigraphBUD, POINTER) returns category of POINTER of MultigraphBUD.
			%  CATEGORY = G.GETPROPCATEGORY(MultigraphBUD, POINTER) returns category of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES
					prop_category = MultigraphBUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@GraphWU(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultigraphBUD, POINTER) returns format of POINTER of MultigraphBUD.
			%  FORMAT = G.GETPROPFORMAT(MultigraphBUD, POINTER) returns format of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES
					prop_format = MultigraphBUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@GraphWU(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultigraphBUD, POINTER) returns description of POINTER of MultigraphBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultigraphBUD, POINTER) returns description of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case MultigraphBUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected multigraph with fixed densities.';
				case MultigraphBUD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, matrix) returns the graph type __Graph.MULTIGRAPH__.';
				case MultigraphBUD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultigraphBUD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultigraphBUD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ * ones(layernumber).';
				case MultigraphBUD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultigraphBUD.A
					prop_description = 'A (result, cell) is the cell array with the symmetric binary adjacency matrices of the binary undirected multigraph.';
				case MultigraphBUD.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers (1) for each partition (density) of the graph.';
				case MultigraphBUD.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case MultigraphBUD.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultigraphBUD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultigraphBUD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				otherwise
					prop_description = getPropDescription@GraphWU(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultigraphBUD, POINTER) returns settings of POINTER of MultigraphBUD.
			%  SETTINGS = G.GETPROPSETTINGS(MultigraphBUD, POINTER) returns settings of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultigraphBUD.TEMPLATE
					prop_settings = 'MultigraphBUD';
				otherwise
					prop_settings = getPropSettings@GraphWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultigraphBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultigraphBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultigraphBUD, POINTER) returns the default value of POINTER of MultigraphBUD.
			%  DEFAULT = G.GETPROPDEFAULT(MultigraphBUD, POINTER) returns the default value of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES
					prop_default = Format.getFormatDefault(Format.RVECTOR, MultigraphBUD.getPropSettings(prop));
				case MultigraphBUD.ELCLASS
					prop_default = 'MultigraphBUD';
				case MultigraphBUD.NAME
					prop_default = 'MultigraphBUD';
				case MultigraphBUD.DESCRIPTION
					prop_default = 'In a binary undirected multigraph with fixed densities, all the layers consist of binary undirected (BU) graphs derived from the same weighted connectivity matrix binarized at different densities. There are no connections between layers.';
				case MultigraphBUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultigraphBUD.getPropSettings(prop));
				case MultigraphBUD.ID
					prop_default = 'MultigraphBUD ID';
				case MultigraphBUD.LABEL
					prop_default = 'MultigraphBUD label';
				case MultigraphBUD.NOTES
					prop_default = 'MultigraphBUD notes';
				case MultigraphBUD.GRAPH_TYPE
					prop_default = Graph.MULTIGRAPH;
				case MultigraphBUD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultigraphBUD');
				case MultigraphBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@GraphWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultigraphBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultigraphBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultigraphBUD, POINTER) returns the conditioned default value of POINTER of MultigraphBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultigraphBUD, POINTER) returns the conditioned default value of POINTER of MultigraphBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			prop_default = MultigraphBUD.conditioning(prop, MultigraphBUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultigraphBUD, PROP, VALUE) checks VALUE format for PROP of MultigraphBUD.
			%  CHECK = G.CHECKPROP(MultigraphBUD, PROP, VALUE) checks VALUE format for PROP of MultigraphBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultigraphBUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultigraphBUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultigraphBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultigraphBUD.
			%   Error id: €BRAPH2.STR€:MultigraphBUD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultigraphBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultigraphBUD.
			%   Error id: €BRAPH2.STR€:MultigraphBUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultigraphBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultigraphBUD.getPropProp(pointer);
			
			switch prop
				case MultigraphBUD.DENSITIES % __MultigraphBUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, MultigraphBUD.getPropSettings(prop));
				case MultigraphBUD.TEMPLATE % __MultigraphBUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultigraphBUD.getPropSettings(prop));
				otherwise
					if prop <= GraphWU.getPropNumber()
						check = checkProp@GraphWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultigraphBUD.getPropTag(prop) ' (' MultigraphBUD.getFormatTag(MultigraphBUD.getPropFormat(prop)) ').'] ...
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
				case MultigraphBUD.CONNECTIVITY_TYPE % __MultigraphBUD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultigraphBUD.DIRECTIONALITY_TYPE % __MultigraphBUD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultigraphBUD.SELFCONNECTIVITY_TYPE % __MultigraphBUD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONSELFCONNECTED * ones(layernumber);
					
				case MultigraphBUD.NEGATIVITY_TYPE % __MultigraphBUD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultigraphBUD.A % __MultigraphBUD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultigraphBUD.A), 'twister')
					
					A_WU = calculateValue@GraphWU(g, prop);
					
					densities = g.get('DENSITIES');
					A = cell(length(densities));
					
					if ~isempty(cell2mat(A_WU))
					    for i = 1:1:length(densities)
					        density = densities(i);
					        A{i, i} = dediagonalize(binarize(cell2mat(A_WU), 'density', density));
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultigraphBUD.PARTITIONS % __MultigraphBUD.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultigraphBUD.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					% %% ¡prop!
					% ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
					% %% ¡calculate!
					% alayerlabels = g.get('LAYERLABELS');
					% if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					%     alayerlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					% end
					% value = alayerlabels;
					
					rng(rng_settings_)
					
				case MultigraphBUD.APARTITIONLABELS % __MultigraphBUD.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultigraphBUD.RANDOMIZATION % __MultigraphBUD.RANDOMIZATION__
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
					if prop <= GraphWU.getPropNumber()
						value = calculateValue@GraphWU(g, prop, varargin{:});
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
				case MultigraphBUD.DENSITIES % __MultigraphBUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultigraphBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case MultigraphBUD.A % __MultigraphBUD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultigraphBUD.A, ...
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
					pr = getPanelProp@GraphWU(g, prop, varargin{:});
					
			end
		end
	end
end
