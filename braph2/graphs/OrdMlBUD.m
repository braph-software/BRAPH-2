classdef OrdMlBUD < OrdMlWU
	%OrdMlBUD is an ordinal multilayer binary undirected with fixed densities.
	% It is a subclass of <a href="matlab:help OrdMlWU">OrdMlWU</a>.
	%
	% In an ordinal multilayer binary undirected graph with fixed densities (OrdMlBUD), layers 
	%  consist of binary undirected multilayer graphs derived from the same 
	%  weighted supra-connectivity matrices binarized at different densities. Layers 
	%  within the binary undirected multilayer graphs could have different number of nodes 
	%  with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% The supra-connectivity matrix has a number of partitions equal to the number of densities.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% OrdMlBUD methods (constructor):
	%  OrdMlBUD - constructor
	%
	% OrdMlBUD methods:
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
	% OrdMlBUD methods (display):
	%  tostring - string with information about the ordinal multilayer binary undirected with fixed densities
	%  disp - displays information about the ordinal multilayer binary undirected with fixed densities
	%  tree - displays the tree of the ordinal multilayer binary undirected with fixed densities
	%
	% OrdMlBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multilayer binary undirected with fixed densities are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multilayer binary undirected with fixed densities
	%
	% OrdMlBUD methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multilayer binary undirected with fixed densities as b2 file
	%  load - loads a BRAPH2 ordinal multilayer binary undirected with fixed densities from a b2 file
	%
	% OrdMlBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multilayer binary undirected with fixed densities
	%
	% OrdMlBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multilayer binary undirected with fixed densities
	%
	% OrdMlBUD methods (inspection, Static):
	%  getClass - returns the class of the ordinal multilayer binary undirected with fixed densities
	%  getSubclasses - returns all subclasses of OrdMlBUD
	%  getProps - returns the property list of the ordinal multilayer binary undirected with fixed densities
	%  getPropNumber - returns the property number of the ordinal multilayer binary undirected with fixed densities
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
	% OrdMlBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = OrdMlWU.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = OrdMlBUD(varargin)
			%OrdMlBUD() creates a ordinal multilayer binary undirected with fixed densities.
			%
			% OrdMlBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@OrdMlWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the ordinal multilayer binary undirected with fixed densities.
			%
			% CLASS = OrdMlBUD.GETCLASS() returns the class 'OrdMlBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multilayer binary undirected with fixed densities G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlBUD') returns 'OrdMlBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlBUD')
			%  are less computationally efficient.
			
			g_class = 'OrdMlBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multilayer binary undirected with fixed densities.
			%
			% LIST = OrdMlBUD.GETSUBCLASSES() returns all subclasses of 'OrdMlBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multilayer binary undirected with fixed densities G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlBUD') returns all subclasses of 'OrdMlBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlBUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multilayer binary undirected with fixed densities.
			%
			% PROPS = OrdMlBUD.GETPROPS() returns the property list of ordinal multilayer binary undirected with fixed densities
			%  as a row vector.
			%
			% PROPS = OrdMlBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multilayer binary undirected with fixed densities G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlBUD'[, CATEGORY]) returns the property list of 'OrdMlBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OrdMlWU.getProps() ...
						OrdMlBUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OrdMlWU.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OrdMlWU.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OrdMlWU.getProps(Category.PARAMETER) ...
						OrdMlBUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						OrdMlWU.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OrdMlWU.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OrdMlWU.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OrdMlWU.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OrdMlWU.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OrdMlWU.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ordinal multilayer binary undirected with fixed densities.
			%
			% N = OrdMlBUD.GETPROPNUMBER() returns the property number of ordinal multilayer binary undirected with fixed densities.
			%
			% N = OrdMlBUD.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multilayer binary undirected with fixed densities
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multilayer binary undirected with fixed densities G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlBUD') returns the property number of 'OrdMlBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlBUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multilayer binary undirected with fixed densities/error.
			%
			% CHECK = OrdMlBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlBUD, PROP) checks whether PROP exists for OrdMlBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%  Element.EXISTSPROP(OrdMlBUD, PROP) throws error if PROP does NOT exist for OrdMlBUD.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlBUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multilayer binary undirected with fixed densities/error.
			%
			% CHECK = OrdMlBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlBUD, TAG) checks whether TAG exists for OrdMlBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%  Element.EXISTSTAG(OrdMlBUD, TAG) throws error if TAG does NOT exist for OrdMlBUD.
			%   Error id: [BRAPH2:OrdMlBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlbud_tag_list = cellfun(@(x) OrdMlBUD.getPropTag(x), num2cell(OrdMlBUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlbud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlBUD, POINTER) returns property number of POINTER of OrdMlBUD.
			%  PROPERTY = G.GETPROPPROP(OrdMlBUD, POINTER) returns property number of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlbud_tag_list = cellfun(@(x) OrdMlBUD.getPropTag(x), num2cell(OrdMlBUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlbud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlBUD, POINTER) returns tag of POINTER of OrdMlBUD.
			%  TAG = G.GETPROPTAG(OrdMlBUD, POINTER) returns tag of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlBUD.DENSITIES
						tag = OrdMlBUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@OrdMlWU(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlBUD, POINTER) returns category of POINTER of OrdMlBUD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlBUD, POINTER) returns category of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES
					prop_category = OrdMlBUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@OrdMlWU(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlBUD, POINTER) returns format of POINTER of OrdMlBUD.
			%  FORMAT = G.GETPROPFORMAT(OrdMlBUD, POINTER) returns format of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES
					prop_format = OrdMlBUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@OrdMlWU(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlBUD, POINTER) returns description of POINTER of OrdMlBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlBUD, POINTER) returns description of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case OrdMlBUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal multilayer binary undirected with fixed densities.';
				case OrdMlBUD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.';
				case OrdMlBUD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMlBUD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMlBUD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlBUD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlBUD.A
					prop_description = 'A (result, cell) is the cell array containing the multilayer binary supra-adjacency matrices of the binary undirected multilayer. ';
				case OrdMlBUD.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers for each partition (density) of the graph.';
				case OrdMlBUD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case OrdMlBUD.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition (density) labels for A.';
				case OrdMlBUD.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case OrdMlBUD.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition (density) ticks for A.';
				case OrdMlBUD.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case OrdMlBUD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlBUD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				otherwise
					prop_description = getPropDescription@OrdMlWU(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlBUD, POINTER) returns settings of POINTER of OrdMlBUD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlBUD, POINTER) returns settings of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case OrdMlBUD.TEMPLATE
					prop_settings = 'OrdMlBUD';
				otherwise
					prop_settings = getPropSettings@OrdMlWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlBUD, POINTER) returns the default value of POINTER of OrdMlBUD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlBUD, POINTER) returns the default value of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES
					prop_default = Format.getFormatDefault(Format.RVECTOR, OrdMlBUD.getPropSettings(prop));
				case OrdMlBUD.ELCLASS
					prop_default = 'OrdMlBUD';
				case OrdMlBUD.NAME
					prop_default = 'Ordinal Multilayer Binary Undirected at fixed Densities';
				case OrdMlBUD.DESCRIPTION
					prop_default = 'In an ordinal multilayer binary undirected graph with fixed densities (OrdMlBUD), layers consist of binary undirected multilayer graphs derived from the same weighted supra-connectivity matrices binarized at different densities. Layers within the binary undirected multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). The supra-connectivity matrix has a number of partitions equal to the number of densities. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case OrdMlBUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlBUD.getPropSettings(prop));
				case OrdMlBUD.ID
					prop_default = 'OrdMlBUD ID';
				case OrdMlBUD.LABEL
					prop_default = 'OrdMlBUD label';
				case OrdMlBUD.NOTES
					prop_default = 'OrdMlBUD notes';
				case OrdMlBUD.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlBUD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlBUD');
				case OrdMlBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@OrdMlWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlBUD, POINTER) returns the conditioned default value of POINTER of OrdMlBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlBUD, POINTER) returns the conditioned default value of POINTER of OrdMlBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			prop_default = OrdMlBUD.conditioning(prop, OrdMlBUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlBUD, PROP, VALUE) checks VALUE format for PROP of OrdMlBUD.
			%  CHECK = G.CHECKPROP(OrdMlBUD, PROP, VALUE) checks VALUE format for PROP of OrdMlBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlBUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlBUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBUD.
			%   Error id: €BRAPH2.STR€:OrdMlBUD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBUD.
			%   Error id: €BRAPH2.STR€:OrdMlBUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlBUD.getPropProp(pointer);
			
			switch prop
				case OrdMlBUD.DENSITIES % __OrdMlBUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, OrdMlBUD.getPropSettings(prop));
				case OrdMlBUD.TEMPLATE % __OrdMlBUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlBUD.getPropSettings(prop));
				otherwise
					if prop <= OrdMlWU.getPropNumber()
						check = checkProp@OrdMlWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlBUD.getPropTag(prop) ' (' OrdMlBUD.getFormatTag(OrdMlBUD.getPropFormat(prop)) ').'] ...
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
				case OrdMlBUD.CONNECTIVITY_TYPE % __OrdMlBUD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMlBUD.DIRECTIONALITY_TYPE % __OrdMlBUD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMlBUD.SELFCONNECTIVITY_TYPE % __OrdMlBUD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlBUD.NEGATIVITY_TYPE % __OrdMlBUD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlBUD.A % __OrdMlBUD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBUD.A), 'twister')
					
					A_WU = calculateValue@OrdMlWU(g, prop);
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
					            if i_density == j_density && j == i + 1
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
					
				case OrdMlBUD.PARTITIONS % __OrdMlBUD.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBUD.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					rng(rng_settings_)
					
				case OrdMlBUD.ALAYERLABELS % __OrdMlBUD.ALAYERLABELS__
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
					            alayerlabels = [alayerlabels, [blayerlabels{j} '|' densities{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case OrdMlBUD.APARTITIONLABELS % __OrdMlBUD.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case OrdMlBUD.ALAYERTICKS % __OrdMlBUD.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('DENSITIES'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    densities = g.get('DENSITIES');
					    alayerticks = [1:1:(l / length(densities))];
					end
					value = alayerticks;
					
				case OrdMlBUD.APARTITIONTICKS % __OrdMlBUD.APARTITIONTICKS__
					value = g.get('DENSITIES');
					
				case OrdMlBUD.RANDOMIZATION % __OrdMlBUD.RANDOMIZATION__
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
					if prop <= OrdMlWU.getPropNumber()
						value = calculateValue@OrdMlWU(g, prop, varargin{:});
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
				case OrdMlBUD.DENSITIES % __OrdMlBUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case OrdMlBUD.A % __OrdMlBUD.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBUD.A, ...
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
					pr = getPanelProp@OrdMlWU(g, prop, varargin{:});
					
			end
		end
	end
end
