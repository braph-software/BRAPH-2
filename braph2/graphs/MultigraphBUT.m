classdef MultigraphBUT < GraphWU
	%MultigraphBUT is a binary undirected multigraph with fixed thresholds.
	% It is a subclass of <a href="matlab:help GraphWU">GraphWU</a>.
	%
	% In a binary undirected multigraph with fixed thresholds, all the layers 
	%  consist of binary undirected (BU) graphs derived from the same 
	%  weighted connectivity matrix binarized at different thresholds.
	% There are no connections between layers.
	%
	% MultigraphBUT methods (constructor):
	%  MultigraphBUT - constructor
	%
	% MultigraphBUT methods:
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
	% MultigraphBUT methods (display):
	%  tostring - string with information about the binary undirected multigraph with fixed thresholds
	%  disp - displays information about the binary undirected multigraph with fixed thresholds
	%  tree - displays the tree of the binary undirected multigraph with fixed thresholds
	%
	% MultigraphBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multigraph with fixed thresholds are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multigraph with fixed thresholds
	%
	% MultigraphBUT methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multigraph with fixed thresholds as b2 file
	%  load - loads a BRAPH2 binary undirected multigraph with fixed thresholds from a b2 file
	%
	% MultigraphBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multigraph with fixed thresholds
	%
	% MultigraphBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multigraph with fixed thresholds
	%
	% MultigraphBUT methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multigraph with fixed thresholds
	%  getSubclasses - returns all subclasses of MultigraphBUT
	%  getProps - returns the property list of the binary undirected multigraph with fixed thresholds
	%  getPropNumber - returns the property number of the binary undirected multigraph with fixed thresholds
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
	% MultigraphBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultigraphBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultigraphBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultigraphBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultigraphBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultigraphBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = GraphWU.getPropNumber() + 1;
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultigraphBUT(varargin)
			%MultigraphBUT() creates a binary undirected multigraph with fixed thresholds.
			%
			% MultigraphBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultigraphBUT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the binary undirected multigraph with fixed thresholds.
			%
			% CLASS = MultigraphBUT.GETCLASS() returns the class 'MultigraphBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multigraph with fixed thresholds G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultigraphBUT') returns 'MultigraphBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultigraphBUT')
			%  are less computationally efficient.
			
			g_class = 'MultigraphBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multigraph with fixed thresholds.
			%
			% LIST = MultigraphBUT.GETSUBCLASSES() returns all subclasses of 'MultigraphBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multigraph with fixed thresholds G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultigraphBUT') returns all subclasses of 'MultigraphBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultigraphBUT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multigraph with fixed thresholds.
			%
			% PROPS = MultigraphBUT.GETPROPS() returns the property list of binary undirected multigraph with fixed thresholds
			%  as a row vector.
			%
			% PROPS = MultigraphBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multigraph with fixed thresholds G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultigraphBUT'[, CATEGORY]) returns the property list of 'MultigraphBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GraphWU.getProps() ...
						MultigraphBUT.THRESHOLDS ...
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
						MultigraphBUT.THRESHOLDS ...
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
			%GETPROPNUMBER returns the property number of binary undirected multigraph with fixed thresholds.
			%
			% N = MultigraphBUT.GETPROPNUMBER() returns the property number of binary undirected multigraph with fixed thresholds.
			%
			% N = MultigraphBUT.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multigraph with fixed thresholds
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multigraph with fixed thresholds G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultigraphBUT') returns the property number of 'MultigraphBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultigraphBUT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multigraph with fixed thresholds/error.
			%
			% CHECK = MultigraphBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultigraphBUT, PROP) checks whether PROP exists for MultigraphBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%  Element.EXISTSPROP(MultigraphBUT, PROP) throws error if PROP does NOT exist for MultigraphBUT.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultigraphBUT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultigraphBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multigraph with fixed thresholds/error.
			%
			% CHECK = MultigraphBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultigraphBUT, TAG) checks whether TAG exists for MultigraphBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%  Element.EXISTSTAG(MultigraphBUT, TAG) throws error if TAG does NOT exist for MultigraphBUT.
			%   Error id: [BRAPH2:MultigraphBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multigraphbut_tag_list = cellfun(@(x) MultigraphBUT.getPropTag(x), num2cell(MultigraphBUT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multigraphbut_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultigraphBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultigraphBUT, POINTER) returns property number of POINTER of MultigraphBUT.
			%  PROPERTY = G.GETPROPPROP(MultigraphBUT, POINTER) returns property number of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multigraphbut_tag_list = cellfun(@(x) MultigraphBUT.getPropTag(x), num2cell(MultigraphBUT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multigraphbut_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultigraphBUT, POINTER) returns tag of POINTER of MultigraphBUT.
			%  TAG = G.GETPROPTAG(MultigraphBUT, POINTER) returns tag of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultigraphBUT.THRESHOLDS
						tag = MultigraphBUT.THRESHOLDS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultigraphBUT, POINTER) returns category of POINTER of MultigraphBUT.
			%  CATEGORY = G.GETPROPCATEGORY(MultigraphBUT, POINTER) returns category of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS
					prop_category = MultigraphBUT.THRESHOLDS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultigraphBUT, POINTER) returns format of POINTER of MultigraphBUT.
			%  FORMAT = G.GETPROPFORMAT(MultigraphBUT, POINTER) returns format of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS
					prop_format = MultigraphBUT.THRESHOLDS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultigraphBUT, POINTER) returns description of POINTER of MultigraphBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultigraphBUT, POINTER) returns description of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case MultigraphBUT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected multigraph with fixed thresholds.';
				case MultigraphBUT.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIGRAPH__.';
				case MultigraphBUT.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultigraphBUT.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultigraphBUT.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ * ones(layernumber).';
				case MultigraphBUT.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultigraphBUT.A
					prop_description = 'A (result, cell) is the cell array with the symmetric binary adjacency matrices of the binary undirected multigraph.';
				case MultigraphBUT.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers (1) for each partition (threshold) of the graph.';
				case MultigraphBUT.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultigraphBUT.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.';
				case MultigraphBUT.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case MultigraphBUT.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.';
				case MultigraphBUT.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultigraphBUT.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultigraphBUT.RANDOMIZATION
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultigraphBUT, POINTER) returns settings of POINTER of MultigraphBUT.
			%  SETTINGS = G.GETPROPSETTINGS(MultigraphBUT, POINTER) returns settings of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultigraphBUT.TEMPLATE
					prop_settings = 'MultigraphBUT';
				otherwise
					prop_settings = getPropSettings@GraphWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultigraphBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultigraphBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultigraphBUT, POINTER) returns the default value of POINTER of MultigraphBUT.
			%  DEFAULT = G.GETPROPDEFAULT(MultigraphBUT, POINTER) returns the default value of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, MultigraphBUT.getPropSettings(prop));
				case MultigraphBUT.ELCLASS
					prop_default = 'MultigraphBUT';
				case MultigraphBUT.NAME
					prop_default = 'MultigraphBUT';
				case MultigraphBUT.DESCRIPTION
					prop_default = 'In a binary undirected multigraph with fixed thresholds, all the layers consist of binary undirected (BU) graphs derived from the same weighted connectivity matrix binarized at different thresholds. There are no connections between layers.';
				case MultigraphBUT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultigraphBUT.getPropSettings(prop));
				case MultigraphBUT.ID
					prop_default = 'MultigraphBUT ID';
				case MultigraphBUT.LABEL
					prop_default = 'MultigraphBUT label';
				case MultigraphBUT.NOTES
					prop_default = 'MultigraphBUT notes';
				case MultigraphBUT.GRAPH_TYPE
					prop_default = Graph.MULTIGRAPH;
				case MultigraphBUT.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultigraphBUT');
				case MultigraphBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@GraphWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultigraphBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultigraphBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultigraphBUT, POINTER) returns the conditioned default value of POINTER of MultigraphBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultigraphBUT, POINTER) returns the conditioned default value of POINTER of MultigraphBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			prop_default = MultigraphBUT.conditioning(prop, MultigraphBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultigraphBUT, PROP, VALUE) checks VALUE format for PROP of MultigraphBUT.
			%  CHECK = G.CHECKPROP(MultigraphBUT, PROP, VALUE) checks VALUE format for PROP of MultigraphBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultigraphBUT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultigraphBUT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultigraphBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultigraphBUT.
			%   Error id: €BRAPH2.STR€:MultigraphBUT:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultigraphBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultigraphBUT.
			%   Error id: €BRAPH2.STR€:MultigraphBUT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultigraphBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultigraphBUT.getPropProp(pointer);
			
			switch prop
				case MultigraphBUT.THRESHOLDS % __MultigraphBUT.THRESHOLDS__
					check = Format.checkFormat(Format.RVECTOR, value, MultigraphBUT.getPropSettings(prop));
				case MultigraphBUT.TEMPLATE % __MultigraphBUT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultigraphBUT.getPropSettings(prop));
				otherwise
					if prop <= GraphWU.getPropNumber()
						check = checkProp@GraphWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultigraphBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultigraphBUT.getPropTag(prop) ' (' MultigraphBUT.getFormatTag(MultigraphBUT.getPropFormat(prop)) ').'] ...
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
				case MultigraphBUT.CONNECTIVITY_TYPE % __MultigraphBUT.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultigraphBUT.DIRECTIONALITY_TYPE % __MultigraphBUT.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultigraphBUT.SELFCONNECTIVITY_TYPE % __MultigraphBUT.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONSELFCONNECTED * ones(layernumber);
					
				case MultigraphBUT.NEGATIVITY_TYPE % __MultigraphBUT.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultigraphBUT.A % __MultigraphBUT.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultigraphBUT.A), 'twister')
					
					A_WU = calculateValue@GraphWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					A = cell(length(thresholds));
					
					for i = 1:1:length(thresholds)
					    threshold = thresholds(i);
					    tmp_A = dediagonalize(binarize(cell2mat(A_WU), 'threshold', threshold));
					    A{i, i} = tmp_A;
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultigraphBUT.PARTITIONS % __MultigraphBUT.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultigraphBUT.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case MultigraphBUT.ALAYERLABELS % __MultigraphBUT.ALAYERLABELS__
					alayerlabels = g.get('LAYERLABELS');
					if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					    alayerlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = alayerlabels;
					
				case MultigraphBUT.APARTITIONLABELS % __MultigraphBUT.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultigraphBUT.ALAYERTICKS % __MultigraphBUT.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('THRESHOLDS'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    thresholds = g.get('THRESHOLDS');
					    alayerticks = [1:1:(l / length(thresholds))];
					end
					value = alayerticks;
					
				case MultigraphBUT.APARTITIONTICKS % __MultigraphBUT.APARTITIONTICKS__
					value = g.get('THRESHOLDS');
					
				case MultigraphBUT.RANDOMIZATION % __MultigraphBUT.RANDOMIZATION__
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
				case MultigraphBUT.THRESHOLDS % __MultigraphBUT.THRESHOLDS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultigraphBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case MultigraphBUT.A % __MultigraphBUT.A__
					pr = PanelPropCell('EL', g, 'PROP', MultigraphBUT.A, ...
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
