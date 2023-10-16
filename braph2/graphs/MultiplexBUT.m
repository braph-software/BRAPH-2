classdef MultiplexBUT < MultiplexWU
	%MultiplexBUT is a binary undirected multiplex with fixed thresholds.
	% It is a subclass of <a href="matlab:help MultiplexWU">MultiplexWU</a>.
	%
	% In a binary undirected multiplex with fixed thresholds (BUT), the layers are 
	%  those of binary undirected (BU) multiplex graphs derived from the same 
	%  weighted supra-connectivity matrices binarized at different thresholds.
	% The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
	%
	% MultiplexBUT methods (constructor):
	%  MultiplexBUT - constructor
	%
	% MultiplexBUT methods:
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
	% MultiplexBUT methods (display):
	%  tostring - string with information about the binary undirected multiplex with fixed thresholds
	%  disp - displays information about the binary undirected multiplex with fixed thresholds
	%  tree - displays the tree of the binary undirected multiplex with fixed thresholds
	%
	% MultiplexBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary undirected multiplex with fixed thresholds are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary undirected multiplex with fixed thresholds
	%
	% MultiplexBUT methods (save/load, Static):
	%  save - saves BRAPH2 binary undirected multiplex with fixed thresholds as b2 file
	%  load - loads a BRAPH2 binary undirected multiplex with fixed thresholds from a b2 file
	%
	% MultiplexBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed thresholds
	%
	% MultiplexBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary undirected multiplex with fixed thresholds
	%
	% MultiplexBUT methods (inspection, Static):
	%  getClass - returns the class of the binary undirected multiplex with fixed thresholds
	%  getSubclasses - returns all subclasses of MultiplexBUT
	%  getProps - returns the property list of the binary undirected multiplex with fixed thresholds
	%  getPropNumber - returns the property number of the binary undirected multiplex with fixed thresholds
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
	% MultiplexBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = MultiplexWU.getPropNumber() + 1;
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = MultiplexBUT(varargin)
			%MultiplexBUT() creates a binary undirected multiplex with fixed thresholds.
			%
			% MultiplexBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexBUT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the binary undirected multiplex with fixed thresholds.
			%
			% CLASS = MultiplexBUT.GETCLASS() returns the class 'MultiplexBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary undirected multiplex with fixed thresholds G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultiplexBUT') returns 'MultiplexBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultiplexBUT')
			%  are less computationally efficient.
			
			g_class = 'MultiplexBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary undirected multiplex with fixed thresholds.
			%
			% LIST = MultiplexBUT.GETSUBCLASSES() returns all subclasses of 'MultiplexBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary undirected multiplex with fixed thresholds G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultiplexBUT') returns all subclasses of 'MultiplexBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexBUT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary undirected multiplex with fixed thresholds.
			%
			% PROPS = MultiplexBUT.GETPROPS() returns the property list of binary undirected multiplex with fixed thresholds
			%  as a row vector.
			%
			% PROPS = MultiplexBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary undirected multiplex with fixed thresholds G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultiplexBUT'[, CATEGORY]) returns the property list of 'MultiplexBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultiplexWU.getProps() ...
						MultiplexBUT.THRESHOLDS ...
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
						MultiplexBUT.THRESHOLDS ...
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
			%GETPROPNUMBER returns the property number of binary undirected multiplex with fixed thresholds.
			%
			% N = MultiplexBUT.GETPROPNUMBER() returns the property number of binary undirected multiplex with fixed thresholds.
			%
			% N = MultiplexBUT.GETPROPNUMBER(CATEGORY) returns the property number of binary undirected multiplex with fixed thresholds
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary undirected multiplex with fixed thresholds G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultiplexBUT') returns the property number of 'MultiplexBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexBUT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in binary undirected multiplex with fixed thresholds/error.
			%
			% CHECK = MultiplexBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultiplexBUT, PROP) checks whether PROP exists for MultiplexBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%  Element.EXISTSPROP(MultiplexBUT, PROP) throws error if PROP does NOT exist for MultiplexBUT.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexBUT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary undirected multiplex with fixed thresholds/error.
			%
			% CHECK = MultiplexBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultiplexBUT, TAG) checks whether TAG exists for MultiplexBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%  Element.EXISTSTAG(MultiplexBUT, TAG) throws error if TAG does NOT exist for MultiplexBUT.
			%   Error id: [BRAPH2:MultiplexBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexbut_tag_list = cellfun(@(x) MultiplexBUT.getPropTag(x), num2cell(MultiplexBUT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexbut_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexBUT, POINTER) returns property number of POINTER of MultiplexBUT.
			%  PROPERTY = G.GETPROPPROP(MultiplexBUT, POINTER) returns property number of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexbut_tag_list = cellfun(@(x) MultiplexBUT.getPropTag(x), num2cell(MultiplexBUT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexbut_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexBUT, POINTER) returns tag of POINTER of MultiplexBUT.
			%  TAG = G.GETPROPTAG(MultiplexBUT, POINTER) returns tag of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexBUT.THRESHOLDS
						tag = MultiplexBUT.THRESHOLDS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexBUT, POINTER) returns category of POINTER of MultiplexBUT.
			%  CATEGORY = G.GETPROPCATEGORY(MultiplexBUT, POINTER) returns category of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS
					prop_category = MultiplexBUT.THRESHOLDS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexBUT, POINTER) returns format of POINTER of MultiplexBUT.
			%  FORMAT = G.GETPROPFORMAT(MultiplexBUT, POINTER) returns format of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS
					prop_format = MultiplexBUT.THRESHOLDS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexBUT, POINTER) returns description of POINTER of MultiplexBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultiplexBUT, POINTER) returns description of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case MultiplexBUT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected multiplex with fixed thresholds.';
				case MultiplexBUT.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.';
				case MultiplexBUT.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case MultiplexBUT.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case MultiplexBUT.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case MultiplexBUT.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case MultiplexBUT.A
					prop_description = 'A (result, cell) is the cell array containing the multiplex binary adjacency matrices of the binary undirected multiplex. ';
				case MultiplexBUT.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of multiplex layers for each partition (threshold) of the graph.';
				case MultiplexBUT.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case MultiplexBUT.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.';
				case MultiplexBUT.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case MultiplexBUT.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.';
				case MultiplexBUT.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case MultiplexBUT.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case MultiplexBUT.RANDOMIZATION
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexBUT, POINTER) returns settings of POINTER of MultiplexBUT.
			%  SETTINGS = G.GETPROPSETTINGS(MultiplexBUT, POINTER) returns settings of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultiplexBUT.TEMPLATE
					prop_settings = 'MultiplexBUT';
				otherwise
					prop_settings = getPropSettings@MultiplexWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexBUT, POINTER) returns the default value of POINTER of MultiplexBUT.
			%  DEFAULT = G.GETPROPDEFAULT(MultiplexBUT, POINTER) returns the default value of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, MultiplexBUT.getPropSettings(prop));
				case MultiplexBUT.ELCLASS
					prop_default = 'MultiplexBUT';
				case MultiplexBUT.NAME
					prop_default = 'MultiplexBUT';
				case MultiplexBUT.DESCRIPTION
					prop_default = 'In a binary undirected multiplex with fixed thresholds (BUT), the layers are those of binary undirected (BU) multiplex graphs derived from the same weighted supra-connectivity matrices binarized at different thresholds. The supra-connectivity matrix has a number of partitions equal to the number of thresholds.';
				case MultiplexBUT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexBUT.getPropSettings(prop));
				case MultiplexBUT.ID
					prop_default = 'MultiplexBUT ID';
				case MultiplexBUT.LABEL
					prop_default = 'MultiplexBUT label';
				case MultiplexBUT.NOTES
					prop_default = 'MultiplexBUT notes';
				case MultiplexBUT.GRAPH_TYPE
					prop_default = Graph.MULTIPLEX;
				case MultiplexBUT.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('MultiplexBUT');
				case MultiplexBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@MultiplexWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexBUT, POINTER) returns the conditioned default value of POINTER of MultiplexBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultiplexBUT, POINTER) returns the conditioned default value of POINTER of MultiplexBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			prop_default = MultiplexBUT.conditioning(prop, MultiplexBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexBUT, PROP, VALUE) checks VALUE format for PROP of MultiplexBUT.
			%  CHECK = G.CHECKPROP(MultiplexBUT, PROP, VALUE) checks VALUE format for PROP of MultiplexBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexBUT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:MultiplexBUT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBUT.
			%   Error id: €BRAPH2.STR€:MultiplexBUT:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(MultiplexBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexBUT.
			%   Error id: €BRAPH2.STR€:MultiplexBUT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultiplexBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexBUT.getPropProp(pointer);
			
			switch prop
				case MultiplexBUT.THRESHOLDS % __MultiplexBUT.THRESHOLDS__
					check = Format.checkFormat(Format.RVECTOR, value, MultiplexBUT.getPropSettings(prop));
				case MultiplexBUT.TEMPLATE % __MultiplexBUT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexBUT.getPropSettings(prop));
				otherwise
					if prop <= MultiplexWU.getPropNumber()
						check = checkProp@MultiplexWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexBUT.getPropTag(prop) ' (' MultiplexBUT.getFormatTag(MultiplexBUT.getPropFormat(prop)) ').'] ...
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
				case MultiplexBUT.CONNECTIVITY_TYPE % __MultiplexBUT.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case MultiplexBUT.DIRECTIONALITY_TYPE % __MultiplexBUT.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case MultiplexBUT.SELFCONNECTIVITY_TYPE % __MultiplexBUT.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case MultiplexBUT.NEGATIVITY_TYPE % __MultiplexBUT.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case MultiplexBUT.A % __MultiplexBUT.A__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexBUT.A), 'twister')
					
					A_WU = calculateValue@MultiplexWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					L = length(A_WU); % number of layers
					A = cell(length(thresholds)*L);
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    A(:, :) = {eye(length(A_WU{1, 1}))};
					    for i = 1:1:length(thresholds)
					        threshold = thresholds(i);
					        layer = 1;
					        for j = (i - 1) * L + 1:1:i * L
					            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'threshold', threshold));
					            layer = layer + 1;
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case MultiplexBUT.PARTITIONS % __MultiplexBUT.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(MultiplexBUT.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case MultiplexBUT.ALAYERLABELS % __MultiplexBUT.ALAYERLABELS__
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
					            alayerlabels = [alayerlabels, [blayerlabels{j} '|' thresholds{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case MultiplexBUT.APARTITIONLABELS % __MultiplexBUT.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case MultiplexBUT.ALAYERTICKS % __MultiplexBUT.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('THRESHOLDS'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    thresholds = g.get('THRESHOLDS');
					    alayerticks = [1:1:(l / length(thresholds))];
					end
					value = alayerticks;
					
				case MultiplexBUT.APARTITIONTICKS % __MultiplexBUT.APARTITIONTICKS__
					value = g.get('THRESHOLDS');
					
				case MultiplexBUT.RANDOMIZATION % __MultiplexBUT.RANDOMIZATION__
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
				case MultiplexBUT.THRESHOLDS % __MultiplexBUT.THRESHOLDS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', MultiplexBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case MultiplexBUT.A % __MultiplexBUT.A__
					pr = PanelPropCell('EL', g, 'PROP', MultiplexBUT.A, ...
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
