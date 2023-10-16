classdef MultiplexBUD < MultiplexWU
	%MultiplexBUD is a binary undirected multiplex with fixed densities.
	% It is a subclass of <a href="matlab:help MultiplexWU">MultiplexWU</a>.
	%
	% In a binary undirected multiplex with fixed densities (BUD), the layers are 
	%  those of binary undirected (BU) multiplex graphs derived from the same 
	%  weighted supra-connectivity matrices binarized at different densities.
	% The supra-connectivity matrix has a number of partitions equal to the number of densities.
	%
	% MultiplexBUD methods (constructor):
	%  MultiplexBUD - constructor
	%
	% MultiplexBUD methods:
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
	% MultiplexBUD methods (display):
	%  tostring - string with information about the binary undirected multiplex with fixed densities
	%  disp - displays information about the binary undirected multiplex with fixed densities
	%  tree - displays the tree of the binary undirected multiplex with fixed densities
	%
	% MultiplexBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multiplex with fixed densities are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multiplex with fixed densities
	%
	% MultiplexBUD methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multiplex with fixed densities as b2 file
	%  load - loads a BRAPH2 binary undirected multiplex with fixed densities from a b2 file
	%
	% MultiplexBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed densities
	%
	% MultiplexBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed densities
	%
	% MultiplexBUD methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multiplex with fixed densities
	%  getSubclasses - returns all subclasses of MultiplexBUD
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
	% MultiplexBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = MultiplexWU.getPropNumber() + 1;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultiplexBUD(varargin)
			%MultiplexBUD() creates a binary undirected multiplex with fixed densities.
			%
			% MultiplexBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@MultiplexWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the binary undirected multiplex with fixed densities.
			%
			% CLASS = MultiplexBUD.GETCLASS() returns the class 'MultiplexBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multiplex with fixed densities G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultiplexBUD') returns 'MultiplexBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultiplexBUD')
			%  are less computationally efficient.
			
			g_class = 'MultiplexBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multiplex with fixed densities.
			%
			% LIST = MultiplexBUD.GETSUBCLASSES() returns all subclasses of 'MultiplexBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multiplex with fixed densities G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultiplexBUD') returns all subclasses of 'MultiplexBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexBUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multiplex with fixed densities.
			%
			% PROPS = MultiplexBUD.GETPROPS() returns the property list of binary undirected multiplex with fixed densities
			%  as a row vector.
			%
			% PROPS = MultiplexBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multiplex with fixed densities G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultiplexBUD'[, CATEGORY]) returns the property list of 'MultiplexBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultiplexWU.getProps() ...
						MultiplexBUD.DENSITIES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultiplexWU.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultiplexWU.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultiplexWU.getProps(Category.PARAMETER) ...
						MultiplexBUD.DENSITIES ...
						];
				case Category.DATA
					prop_list = [ ...
						MultiplexWU.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultiplexWU.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultiplexWU.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultiplexWU.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultiplexWU.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultiplexWU.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of binary undirected multiplex with fixed densities.
			%
			% N = MultiplexBUD.GETPROPNUMBER() returns the property number of binary undirected multiplex with fixed densities.
			%
			% N = MultiplexBUD.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multiplex with fixed densities
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multiplex with fixed densities G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultiplexBUD') returns the property number of 'MultiplexBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexBUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multiplex with fixed densities/error.
			%
			% CHECK = MultiplexBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultiplexBUD, PROP) checks whether PROP exists for MultiplexBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%  Element.EXISTSPROP(MultiplexBUD, PROP) throws error if PROP does NOT exist for MultiplexBUD.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexBUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multiplex with fixed densities/error.
			%
			% CHECK = MultiplexBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultiplexBUD, TAG) checks whether TAG exists for MultiplexBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%  Element.EXISTSTAG(MultiplexBUD, TAG) throws error if TAG does NOT exist for MultiplexBUD.
			%   Error id: [BRAPH2:MultiplexBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexbud_tag_list = cellfun(@(x) MultiplexBUD.getPropTag(x), num2cell(MultiplexBUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexbud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexBUD, POINTER) returns property number of POINTER of MultiplexBUD.
			%  PROPERTY = G.GETPROPPROP(MultiplexBUD, POINTER) returns property number of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexbud_tag_list = cellfun(@(x) MultiplexBUD.getPropTag(x), num2cell(MultiplexBUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexbud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexBUD, POINTER) returns tag of POINTER of MultiplexBUD.
			%  TAG = G.GETPROPTAG(MultiplexBUD, POINTER) returns tag of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexBUD.DENSITIES
						tag = MultiplexBUD.DENSITIES_TAG;
					otherwise
						tag = getPropTag@MultiplexWU(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexBUD, POINTER) returns category of POINTER of MultiplexBUD.
			%  CATEGORY = G.GETPROPCATEGORY(MultiplexBUD, POINTER) returns category of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES
					prop_category = MultiplexBUD.DENSITIES_CATEGORY;
				otherwise
					prop_category = getPropCategory@MultiplexWU(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexBUD, POINTER) returns format of POINTER of MultiplexBUD.
			%  FORMAT = G.GETPROPFORMAT(MultiplexBUD, POINTER) returns format of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES
					prop_format = MultiplexBUD.DENSITIES_FORMAT;
				otherwise
					prop_format = getPropFormat@MultiplexWU(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexBUD, POINTER) returns description of POINTER of MultiplexBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultiplexBUD, POINTER) returns description of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case MultiplexBUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected multiplex with fixed densities.';
				case MultiplexBUD.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.';
				case MultiplexBUD.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultiplexBUD.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultiplexBUD.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultiplexBUD.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultiplexBUD.A
					prop_description = 'A (result, cell) is the cell array containing the multiplex binary adjacency matrices of the binary undirected multiplex. ';
				case MultiplexBUD.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of multiplex layers for each partition (density) of the graph.';
				case MultiplexBUD.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case MultiplexBUD.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition (density) labels for A.';
				case MultiplexBUD.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case MultiplexBUD.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition (density) ticks for A.';
				case MultiplexBUD.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultiplexBUD.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultiplexBUD.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				otherwise
					prop_description = getPropDescription@MultiplexWU(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexBUD, POINTER) returns settings of POINTER of MultiplexBUD.
			%  SETTINGS = G.GETPROPSETTINGS(MultiplexBUD, POINTER) returns settings of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultiplexBUD.TEMPLATE
					prop_settings = 'MultiplexBUD';
				otherwise
					prop_settings = getPropSettings@MultiplexWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexBUD, POINTER) returns the default value of POINTER of MultiplexBUD.
			%  DEFAULT = G.GETPROPDEFAULT(MultiplexBUD, POINTER) returns the default value of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES
					prop_default = Format.getFormatDefault(Format.RVECTOR, MultiplexBUD.getPropSettings(prop));
				case MultiplexBUD.ELCLASS
					prop_default = 'MultiplexBUD';
				case MultiplexBUD.NAME
					prop_default = 'MultiplexBUD';
				case MultiplexBUD.DESCRIPTION
					prop_default = 'In a binary undirected multiplex with fixed densities (BUD), the layers are those of binary undirected (BU) multiplex graphs derived from the same weighted supra-connectivity matrices binarized at different densities. The supra-connectivity matrix has a number of partitions equal to the number of densities.';
				case MultiplexBUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexBUD.getPropSettings(prop));
				case MultiplexBUD.ID
					prop_default = 'MultiplexBUD ID';
				case MultiplexBUD.LABEL
					prop_default = 'MultiplexBUD label';
				case MultiplexBUD.NOTES
					prop_default = 'MultiplexBUD notes';
				case MultiplexBUD.GRAPH_TYPE
					prop_default = Graph.MULTIPLEX;
				case MultiplexBUD.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultiplexBUD');
				case MultiplexBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@MultiplexWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexBUD, POINTER) returns the conditioned default value of POINTER of MultiplexBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultiplexBUD, POINTER) returns the conditioned default value of POINTER of MultiplexBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			prop_default = MultiplexBUD.conditioning(prop, MultiplexBUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexBUD, PROP, VALUE) checks VALUE format for PROP of MultiplexBUD.
			%  CHECK = G.CHECKPROP(MultiplexBUD, PROP, VALUE) checks VALUE format for PROP of MultiplexBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexBUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultiplexBUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBUD.
			%   Error id: €BRAPH2.STR€:MultiplexBUD:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultiplexBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBUD.
			%   Error id: €BRAPH2.STR€:MultiplexBUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultiplexBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexBUD.getPropProp(pointer);
			
			switch prop
				case MultiplexBUD.DENSITIES % __MultiplexBUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, MultiplexBUD.getPropSettings(prop));
				case MultiplexBUD.TEMPLATE % __MultiplexBUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexBUD.getPropSettings(prop));
				otherwise
					if prop <= MultiplexWU.getPropNumber()
						check = checkProp@MultiplexWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexBUD.getPropTag(prop) ' (' MultiplexBUD.getFormatTag(MultiplexBUD.getPropFormat(prop)) ').'] ...
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
				case MultiplexBUD.CONNECTIVITY_TYPE % __MultiplexBUD.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultiplexBUD.DIRECTIONALITY_TYPE % __MultiplexBUD.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultiplexBUD.SELFCONNECTIVITY_TYPE % __MultiplexBUD.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultiplexBUD.NEGATIVITY_TYPE % __MultiplexBUD.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultiplexBUD.A % __MultiplexBUD.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexBUD.A), 'twister')
					
					A_WU = calculateValue@MultiplexWU(g, prop);
					
					densities = g.get('DENSITIES');
					L = length(A_WU); % number of layers of MultiplexWU
					A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    A(:, :) = {eye(length(A_WU{1, 1}))};
					    for i = 1:1:length(densities)
					        density = densities(i);
					        layer = 1;
					        for j = (i - 1) * L + 1:1:i * L
					            tmp_A = dediagonalize(binarize(A_WU{layer, layer}, 'density', density));
					            layer = layer + 1;
					            A{j, j} = tmp_A;           
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultiplexBUD.PARTITIONS % __MultiplexBUD.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexBUD.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					rng(rng_settings_)
					
				case MultiplexBUD.ALAYERLABELS % __MultiplexBUD.ALAYERLABELS__
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
					
				case MultiplexBUD.APARTITIONLABELS % __MultiplexBUD.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultiplexBUD.ALAYERTICKS % __MultiplexBUD.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('DENSITIES'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    densities = g.get('DENSITIES');
					    alayerticks = [1:1:(l / length(densities))];
					end
					value = alayerticks;
					
				case MultiplexBUD.APARTITIONTICKS % __MultiplexBUD.APARTITIONTICKS__
					value = g.get('DENSITIES');
					
				case MultiplexBUD.RANDOMIZATION % __MultiplexBUD.RANDOMIZATION__
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
					if prop <= MultiplexWU.getPropNumber()
						value = calculateValue@MultiplexWU(g, prop, varargin{:});
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
				case MultiplexBUD.DENSITIES % __MultiplexBUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultiplexBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case MultiplexBUD.A % __MultiplexBUD.A__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexBUD.A, ...
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
					pr = getPanelProp@MultiplexWU(g, prop, varargin{:});
					
			end
		end
	end
end
