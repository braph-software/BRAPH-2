classdef OrdMlBUT < OrdMlWU
	%OrdMlBUT is an ordinal multilayer binary undirected with fixed thresholds.
	% It is a subclass of <a href="matlab:help OrdMlWU">OrdMlWU</a>.
	%
	% In an ordinal binary undirected multilayer with fixed thresholds (BUT) graph, layers 
	%  consist of binary undirected (BU) multilayer graphs derived from the same 
	%  weighted supra-connectivity matrices binarized at different thresholds. Layers 
	%  within the binary undirected (BU) multilayer graphs could have different number of nodes 
	%  with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% OrdMlBUT methods (constructor):
	%  OrdMlBUT - constructor
	%
	% OrdMlBUT methods:
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
	% OrdMlBUT methods (display):
	%  tostring - string with information about the binary undirected multilayer with fixed thresholds
	%  disp - displays information about the binary undirected multilayer with fixed thresholds
	%  tree - displays the tree of the binary undirected multilayer with fixed thresholds
	%
	% OrdMlBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multilayer with fixed thresholds are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multilayer with fixed thresholds
	%
	% OrdMlBUT methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multilayer with fixed thresholds as b2 file
	%  load - loads a BRAPH2 binary undirected multilayer with fixed thresholds from a b2 file
	%
	% OrdMlBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multilayer with fixed thresholds
	%
	% OrdMlBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multilayer with fixed thresholds
	%
	% OrdMlBUT methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multilayer with fixed thresholds
	%  getSubclasses - returns all subclasses of OrdMlBUT
	%  getProps - returns the property list of the binary undirected multilayer with fixed thresholds
	%  getPropNumber - returns the property number of the binary undirected multilayer with fixed thresholds
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
	% OrdMlBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMlBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMlBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMlBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMlBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMlBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = OrdMlWU.getPropNumber() + 1;
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = OrdMlBUT(varargin)
			%OrdMlBUT() creates a binary undirected multilayer with fixed thresholds.
			%
			% OrdMlBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMlBUT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the binary undirected multilayer with fixed thresholds.
			%
			% CLASS = OrdMlBUT.GETCLASS() returns the class 'OrdMlBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multilayer with fixed thresholds G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMlBUT') returns 'OrdMlBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMlBUT')
			%  are less computationally efficient.
			
			g_class = 'OrdMlBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multilayer with fixed thresholds.
			%
			% LIST = OrdMlBUT.GETSUBCLASSES() returns all subclasses of 'OrdMlBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multilayer with fixed thresholds G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMlBUT') returns all subclasses of 'OrdMlBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMlBUT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multilayer with fixed thresholds.
			%
			% PROPS = OrdMlBUT.GETPROPS() returns the property list of binary undirected multilayer with fixed thresholds
			%  as a row vector.
			%
			% PROPS = OrdMlBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multilayer with fixed thresholds G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMlBUT'[, CATEGORY]) returns the property list of 'OrdMlBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OrdMlWU.getProps() ...
						OrdMlBUT.THRESHOLDS ...
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
						OrdMlBUT.THRESHOLDS ...
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
			%GETPROPNUMBER returns the property number of binary undirected multilayer with fixed thresholds.
			%
			% N = OrdMlBUT.GETPROPNUMBER() returns the property number of binary undirected multilayer with fixed thresholds.
			%
			% N = OrdMlBUT.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multilayer with fixed thresholds
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multilayer with fixed thresholds G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMlBUT') returns the property number of 'OrdMlBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMlBUT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multilayer with fixed thresholds/error.
			%
			% CHECK = OrdMlBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMlBUT, PROP) checks whether PROP exists for OrdMlBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%  Element.EXISTSPROP(OrdMlBUT, PROP) throws error if PROP does NOT exist for OrdMlBUT.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMlBUT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMlBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multilayer with fixed thresholds/error.
			%
			% CHECK = OrdMlBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMlBUT, TAG) checks whether TAG exists for OrdMlBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%  Element.EXISTSTAG(OrdMlBUT, TAG) throws error if TAG does NOT exist for OrdMlBUT.
			%   Error id: [BRAPH2:OrdMlBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmlbut_tag_list = cellfun(@(x) OrdMlBUT.getPropTag(x), num2cell(OrdMlBUT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmlbut_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMlBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMlBUT, POINTER) returns property number of POINTER of OrdMlBUT.
			%  PROPERTY = G.GETPROPPROP(OrdMlBUT, POINTER) returns property number of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmlbut_tag_list = cellfun(@(x) OrdMlBUT.getPropTag(x), num2cell(OrdMlBUT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmlbut_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMlBUT, POINTER) returns tag of POINTER of OrdMlBUT.
			%  TAG = G.GETPROPTAG(OrdMlBUT, POINTER) returns tag of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMlBUT.THRESHOLDS
						tag = OrdMlBUT.THRESHOLDS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMlBUT, POINTER) returns category of POINTER of OrdMlBUT.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMlBUT, POINTER) returns category of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS
					prop_category = OrdMlBUT.THRESHOLDS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMlBUT, POINTER) returns format of POINTER of OrdMlBUT.
			%  FORMAT = G.GETPROPFORMAT(OrdMlBUT, POINTER) returns format of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS
					prop_format = OrdMlBUT.THRESHOLDS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMlBUT, POINTER) returns description of POINTER of OrdMlBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMlBUT, POINTER) returns description of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case OrdMlBUT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multilayer with fixed thresholds.';
				case OrdMlBUT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected ordinal multilayer with fixed thresholds.';
				case OrdMlBUT.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.';
				case OrdMlBUT.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMlBUT.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMlBUT.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMlBUT.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMlBUT.A
					prop_description = 'A (result, cell) is the cell array containing the multilayer binary supra-adjacency matrices of the binary undirected multilayer. ';
				case OrdMlBUT.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.';
				case OrdMlBUT.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMlBUT.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case OrdMlBUT.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case OrdMlBUT.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMlBUT.RANDOMIZATION
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMlBUT, POINTER) returns settings of POINTER of OrdMlBUT.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMlBUT, POINTER) returns settings of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case OrdMlBUT.TEMPLATE
					prop_settings = 'OrdMlBUT';
				otherwise
					prop_settings = getPropSettings@OrdMlWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMlBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMlBUT, POINTER) returns the default value of POINTER of OrdMlBUT.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMlBUT, POINTER) returns the default value of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, OrdMlBUT.getPropSettings(prop));
				case OrdMlBUT.ELCLASS
					prop_default = 'OrdMlBUT';
				case OrdMlBUT.NAME
					prop_default = 'OrdMlBUT';
				case OrdMlBUT.DESCRIPTION
					prop_default = 'In an ordinal binary undirected multilayer with fixed thresholds (BUT) graph, layers consist of binary undirected (BU) multilayer graphs derived from the same weighted supra-connectivity matrices binarized at different thresholds. Layers within the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case OrdMlBUT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMlBUT.getPropSettings(prop));
				case OrdMlBUT.ID
					prop_default = 'OrdMlBUT ID';
				case OrdMlBUT.LABEL
					prop_default = 'OrdMlBUT label';
				case OrdMlBUT.NOTES
					prop_default = 'OrdMlBUT notes';
				case OrdMlBUT.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTILAYER;
				case OrdMlBUT.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMlBUT');
				case OrdMlBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@OrdMlWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMlBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMlBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMlBUT, POINTER) returns the conditioned default value of POINTER of OrdMlBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMlBUT, POINTER) returns the conditioned default value of POINTER of OrdMlBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			prop_default = OrdMlBUT.conditioning(prop, OrdMlBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMlBUT, PROP, VALUE) checks VALUE format for PROP of OrdMlBUT.
			%  CHECK = G.CHECKPROP(OrdMlBUT, PROP, VALUE) checks VALUE format for PROP of OrdMlBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMlBUT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMlBUT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMlBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBUT.
			%   Error id: €BRAPH2.STR€:OrdMlBUT:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMlBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMlBUT.
			%   Error id: €BRAPH2.STR€:OrdMlBUT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMlBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMlBUT.getPropProp(pointer);
			
			switch prop
				case OrdMlBUT.THRESHOLDS % __OrdMlBUT.THRESHOLDS__
					check = Format.checkFormat(Format.RVECTOR, value, OrdMlBUT.getPropSettings(prop));
				case OrdMlBUT.TEMPLATE % __OrdMlBUT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMlBUT.getPropSettings(prop));
				otherwise
					if prop <= OrdMlWU.getPropNumber()
						check = checkProp@OrdMlWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMlBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMlBUT.getPropTag(prop) ' (' OrdMlBUT.getFormatTag(OrdMlBUT.getPropFormat(prop)) ').'] ...
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
				case OrdMlBUT.CONNECTIVITY_TYPE % __OrdMlBUT.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMlBUT.DIRECTIONALITY_TYPE % __OrdMlBUT.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMlBUT.SELFCONNECTIVITY_TYPE % __OrdMlBUT.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMlBUT.NEGATIVITY_TYPE % __OrdMlBUT.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMlBUT.A % __OrdMlBUT.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBUT.A), 'twister')
					
					A_WU = calculateValue@OrdMlWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					L = length(A_WU); % number of layers
					A = cell(length(thresholds)*L);
					if L > 0 && ~isempty(cell2mat(A_WU))
					    for i = 1:1:length(A)
					        if mod(i, L) == 0
					            i_layer = L;
					            i_threshold = thresholds(fix(i/L));
					        else
					            i_layer = mod(i, L);
					            i_threshold = thresholds(fix(i/L)+1);
					        end
					        M = symmetrize(A_WU{i_layer, i_layer}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					        M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					        M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					        M = binarize(M, 'threshold', i_threshold); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					        A(i, i) = {M};
					        for j = i+1:1:length(A)
					            if mod(j, L) == 0
					                j_layer = L;
					                j_threshold = thresholds(fix(j/L));
					            else
					                j_layer = mod(j, L);
					                j_threshold = thresholds(fix(j/L)+1);
					            end
					            if i_threshold == j_threshold && j == i + 1
					                    M = semipositivize(A_WU{i_layer, j_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                    M = binarize(M, 'threshold', i_threshold, 'diagonal', 'include');
					                    A(i, j) = {M};
					                    M = semipositivize(A_WU{j_layer, i_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                    M = binarize(M, 'threshold', i_threshold, 'diagonal', 'include');
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
					
				case OrdMlBUT.PARTITIONS % __OrdMlBUT.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMlBUT.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case OrdMlBUT.ALAYERLABELS % __OrdMlBUT.ALAYERLABELS__
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
					
				case OrdMlBUT.APARTITIONLABELS % __OrdMlBUT.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case OrdMlBUT.RANDOMIZATION % __OrdMlBUT.RANDOMIZATION__
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
				case OrdMlBUT.THRESHOLDS % __OrdMlBUT.THRESHOLDS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', OrdMlBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case OrdMlBUT.A % __OrdMlBUT.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMlBUT.A, ...
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
