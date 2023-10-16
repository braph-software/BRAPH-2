classdef OrdMxBUD < OrdMxWU
	%OrdMxBUD is a ordinal multiplex binary undirected with fixed densities.
	% It is a subclass of <a href="matlab:help OrdMxWU">OrdMxWU</a>.
	%
	% In an ordinal binary undirected multiplex with fixed densities (BUD), the layers are 
	%  those of binary undirected (BU) multiplex graphs derived from the same 
	%  weighted supra-adjacency matrices binarized at different densities.
	% The supra-adjacency matrix has a number of partitions equal to the number of densities.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	%
	% OrdMxBUD methods (constructor):
	%  OrdMxBUD - constructor
	%
	% OrdMxBUD methods:
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
	% OrdMxBUD methods (display):
	%  tostring - string with information about the binary undirected multiplex with fixed densities
	%  disp - displays information about the binary undirected multiplex with fixed densities
	%  tree - displays the tree of the binary undirected multiplex with fixed densities
	%
	% OrdMxBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multiplex with fixed densities are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multiplex with fixed densities
	%
	% OrdMxBUD methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multiplex with fixed densities as b2 file
	%  load - loads a BRAPH2 binary undirected multiplex with fixed densities from a b2 file
	%
	% OrdMxBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed densities
	%
	% OrdMxBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed densities
	%
	% OrdMxBUD methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multiplex with fixed densities
	%  getSubclasses - returns all subclasses of OrdMxBUD
	%  getProps - returns the property list of the binary undirected multiplex with fixed densities
	%  getPropNumber - returns the property number of the binary undirected multiplex with fixed densities
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
	% OrdMxBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = OrdMxWU.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = OrdMxBUD(varargin)
			%OrdMxBUD() creates a binary undirected multiplex with fixed densities.
			%
			% OrdMxBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@OrdMxWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the binary undirected multiplex with fixed densities.
			%
			% CLASS = OrdMxBUD.GETCLASS() returns the class 'OrdMxBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multiplex with fixed densities G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxBUD') returns 'OrdMxBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxBUD')
			%  are less computationally efficient.
			
			g_class = 'OrdMxBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multiplex with fixed densities.
			%
			% LIST = OrdMxBUD.GETSUBCLASSES() returns all subclasses of 'OrdMxBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multiplex with fixed densities G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxBUD') returns all subclasses of 'OrdMxBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMxBUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multiplex with fixed densities.
			%
			% PROPS = OrdMxBUD.GETPROPS() returns the property list of binary undirected multiplex with fixed densities
			%  as a row vector.
			%
			% PROPS = OrdMxBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multiplex with fixed densities G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxBUD'[, CATEGORY]) returns the property list of 'OrdMxBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OrdMxWU.getProps() ...
						OrdMxBUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OrdMxWU.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OrdMxWU.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OrdMxWU.getProps(Category.PARAMETER) ...
						OrdMxBUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						OrdMxWU.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OrdMxWU.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OrdMxWU.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OrdMxWU.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OrdMxWU.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OrdMxWU.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of binary undirected multiplex with fixed densities.
			%
			% N = OrdMxBUD.GETPROPNUMBER() returns the property number of binary undirected multiplex with fixed densities.
			%
			% N = OrdMxBUD.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multiplex with fixed densities
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multiplex with fixed densities G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxBUD') returns the property number of 'OrdMxBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMxBUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multiplex with fixed densities/error.
			%
			% CHECK = OrdMxBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxBUD, PROP) checks whether PROP exists for OrdMxBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%  Element.EXISTSPROP(OrdMxBUD, PROP) throws error if PROP does NOT exist for OrdMxBUD.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMxBUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multiplex with fixed densities/error.
			%
			% CHECK = OrdMxBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxBUD, TAG) checks whether TAG exists for OrdMxBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%  Element.EXISTSTAG(OrdMxBUD, TAG) throws error if TAG does NOT exist for OrdMxBUD.
			%   Error id: [BRAPH2:OrdMxBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmxbud_tag_list = cellfun(@(x) OrdMxBUD.getPropTag(x), num2cell(OrdMxBUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmxbud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMxBUD, POINTER) returns property number of POINTER of OrdMxBUD.
			%  PROPERTY = G.GETPROPPROP(OrdMxBUD, POINTER) returns property number of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmxbud_tag_list = cellfun(@(x) OrdMxBUD.getPropTag(x), num2cell(OrdMxBUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmxbud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMxBUD, POINTER) returns tag of POINTER of OrdMxBUD.
			%  TAG = G.GETPROPTAG(OrdMxBUD, POINTER) returns tag of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMxBUD.DENSITIES
						tag = OrdMxBUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@OrdMxWU(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxBUD, POINTER) returns category of POINTER of OrdMxBUD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxBUD, POINTER) returns category of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES
					prop_category = OrdMxBUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@OrdMxWU(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMxBUD, POINTER) returns format of POINTER of OrdMxBUD.
			%  FORMAT = G.GETPROPFORMAT(OrdMxBUD, POINTER) returns format of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES
					prop_format = OrdMxBUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@OrdMxWU(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxBUD, POINTER) returns description of POINTER of OrdMxBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxBUD, POINTER) returns description of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case OrdMxBUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.NAME
					prop_description = 'NAME (constant, string) is the name of the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ordinal binary undirected multiplex with fixed densities.';
				case OrdMxBUD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTIPLEX__.';
				case OrdMxBUD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMxBUD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMxBUD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMxBUD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMxBUD.A
					prop_description = 'A (result, cell) is the cell array containing the multiplex binary supra-adjacency matrices of the binary undirected multiplex. ';
				case OrdMxBUD.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of multiplex layers for each partition (density) of the graph.';
				case OrdMxBUD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case OrdMxBUD.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition (density) labels for A.';
				case OrdMxBUD.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case OrdMxBUD.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition (density) ticks for A.';
				case OrdMxBUD.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case OrdMxBUD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMxBUD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				otherwise
					prop_description = getPropDescription@OrdMxWU(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxBUD, POINTER) returns settings of POINTER of OrdMxBUD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxBUD, POINTER) returns settings of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case OrdMxBUD.TEMPLATE
					prop_settings = 'OrdMxBUD';
				otherwise
					prop_settings = getPropSettings@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxBUD, POINTER) returns the default value of POINTER of OrdMxBUD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxBUD, POINTER) returns the default value of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES
					prop_default = Format.getFormatDefault(Format.RVECTOR, OrdMxBUD.getPropSettings(prop));
				case OrdMxBUD.ELCLASS
					prop_default = 'OrdMxBUD';
				case OrdMxBUD.NAME
					prop_default = 'OrdMxBUD';
				case OrdMxBUD.DESCRIPTION
					prop_default = 'In an ordinal binary undirected multiplex with fixed densities (BUD), the layers are those of binary undirected (BU) multiplex graphs derived from the same weighted supra-adjacency matrix binarized at different densities. The supra-adjacency matrix has a number of partitions equal to the number of densities.The layers are connected in an ordinal fashion, where just consecutive layers are connected';
				case OrdMxBUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMxBUD.getPropSettings(prop));
				case OrdMxBUD.ID
					prop_default = 'OrdMxBUD ID';
				case OrdMxBUD.LABEL
					prop_default = 'OrdMxBUD label';
				case OrdMxBUD.NOTES
					prop_default = 'OrdMxBUD notes';
				case OrdMxBUD.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTIPLEX;
				case OrdMxBUD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMxBUD');
				case OrdMxBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxBUD, POINTER) returns the conditioned default value of POINTER of OrdMxBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxBUD, POINTER) returns the conditioned default value of POINTER of OrdMxBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			prop_default = OrdMxBUD.conditioning(prop, OrdMxBUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMxBUD, PROP, VALUE) checks VALUE format for PROP of OrdMxBUD.
			%  CHECK = G.CHECKPROP(OrdMxBUD, PROP, VALUE) checks VALUE format for PROP of OrdMxBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMxBUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMxBUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMxBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUD.
			%   Error id: €BRAPH2.STR€:OrdMxBUD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMxBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUD.
			%   Error id: €BRAPH2.STR€:OrdMxBUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxBUD.getPropProp(pointer);
			
			switch prop
				case OrdMxBUD.DENSITIES % __OrdMxBUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, OrdMxBUD.getPropSettings(prop));
				case OrdMxBUD.TEMPLATE % __OrdMxBUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMxBUD.getPropSettings(prop));
				otherwise
					if prop <= OrdMxWU.getPropNumber()
						check = checkProp@OrdMxWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxBUD.getPropTag(prop) ' (' OrdMxBUD.getFormatTag(OrdMxBUD.getPropFormat(prop)) ').'] ...
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
				case OrdMxBUD.CONNECTIVITY_TYPE % __OrdMxBUD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMxBUD.DIRECTIONALITY_TYPE % __OrdMxBUD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMxBUD.SELFCONNECTIVITY_TYPE % __OrdMxBUD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMxBUD.NEGATIVITY_TYPE % __OrdMxBUD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMxBUD.A % __OrdMxBUD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxBUD.A), 'twister')
					
					A_WU = calculateValue@OrdMxWU(g, prop);
					
					densities = g.get('DENSITIES');
					L = length(A_WU); % number of layers of MultiplexWU
					A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    A(:, :) = {eye(length(A_WU{1, 1}))};
					    for i = 1:1:length(densities)
					        density = densities(i);
					        layer = 1;
					        for j = (i - 1) * L + 1:1:i * L
					            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'density', density));
					            layer = layer + 1;
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMxBUD.PARTITIONS % __OrdMxBUD.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxBUD.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					rng(rng_settings_)
					
				case OrdMxBUD.ALAYERLABELS % __OrdMxBUD.ALAYERLABELS__
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
					
				case OrdMxBUD.APARTITIONLABELS % __OrdMxBUD.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case OrdMxBUD.ALAYERTICKS % __OrdMxBUD.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('DENSITIES'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    densities = g.get('DENSITIES');
					    alayerticks = [1:1:(l / length(densities))];
					end
					value = alayerticks;
					
				case OrdMxBUD.APARTITIONTICKS % __OrdMxBUD.APARTITIONTICKS__
					value = g.get('DENSITIES');
					
				case OrdMxBUD.RANDOMIZATION % __OrdMxBUD.RANDOMIZATION__
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
					if prop <= OrdMxWU.getPropNumber()
						value = calculateValue@OrdMxWU(g, prop, varargin{:});
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
				case OrdMxBUD.DENSITIES % __OrdMxBUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultiplexBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case OrdMxBUD.A % __OrdMxBUD.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxBUD.A, ...
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
					pr = getPanelProp@OrdMxWU(g, prop, varargin{:});
					
			end
		end
	end
end
