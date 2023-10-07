classdef OrdMxBUT < OrdMxWU
	%OrdMxBUT is a binary undirected ordinal multiplex with fixed thresholds.
	% It is a subclass of <a href="matlab:help OrdMxWU">OrdMxWU</a>.
	%
	% In a binary undirected ordinal multiplex with fixed thresholds (BUT), 
	% all the layers consist of binary undirected (BU) multiplex graphs 
	% derived from the same weighted supra-connectivity matrices 
	% binarized at different thresholds.
	% The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	%
	% OrdMxBUT methods (constructor):
	%  OrdMxBUT - constructor
	%
	% OrdMxBUT methods:
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
	% OrdMxBUT methods (display):
	%  tostring - string with information about the ordinal multiplex binary undirected with fixed thresholds
	%  disp - displays information about the ordinal multiplex binary undirected with fixed thresholds
	%  tree - displays the tree of the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multiplex binary undirected with fixed thresholds are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multiplex binary undirected with fixed thresholds as b2 file
	%  load - loads a BRAPH2 ordinal multiplex binary undirected with fixed thresholds from a b2 file
	%
	% OrdMxBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (inspection, Static):
	%  getClass - returns the class of the ordinal multiplex binary undirected with fixed thresholds
	%  getSubclasses - returns all subclasses of OrdMxBUT
	%  getProps - returns the property list of the ordinal multiplex binary undirected with fixed thresholds
	%  getPropNumber - returns the property number of the ordinal multiplex binary undirected with fixed thresholds
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
	% OrdMxBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = OrdMxWU.getPropNumber() + 1;
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = Category.PARAMETER;
		THRESHOLDS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function g = OrdMxBUT(varargin)
			%OrdMxBUT() creates a ordinal multiplex binary undirected with fixed thresholds.
			%
			% OrdMxBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxBUT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ordinal multiplex binary undirected with fixed thresholds.
			%
			% CLASS = OrdMxBUT.GETCLASS() returns the class 'OrdMxBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex binary undirected with fixed thresholds G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxBUT') returns 'OrdMxBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxBUT')
			%  are less computationally efficient.
			
			g_class = 'OrdMxBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multiplex binary undirected with fixed thresholds.
			%
			% LIST = OrdMxBUT.GETSUBCLASSES() returns all subclasses of 'OrdMxBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multiplex binary undirected with fixed thresholds G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxBUT') returns all subclasses of 'OrdMxBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OrdMxBUT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex binary undirected with fixed thresholds.
			%
			% PROPS = OrdMxBUT.GETPROPS() returns the property list of ordinal multiplex binary undirected with fixed thresholds
			%  as a row vector.
			%
			% PROPS = OrdMxBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex binary undirected with fixed thresholds G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxBUT'[, CATEGORY]) returns the property list of 'OrdMxBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OrdMxWU.getProps() ...
						OrdMxBUT.THRESHOLDS ...
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
						OrdMxBUT.THRESHOLDS ...
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
			%GETPROPNUMBER returns the property number of ordinal multiplex binary undirected with fixed thresholds.
			%
			% N = OrdMxBUT.GETPROPNUMBER() returns the property number of ordinal multiplex binary undirected with fixed thresholds.
			%
			% N = OrdMxBUT.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multiplex binary undirected with fixed thresholds
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multiplex binary undirected with fixed thresholds G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxBUT') returns the property number of 'OrdMxBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OrdMxBUT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multiplex binary undirected with fixed thresholds/error.
			%
			% CHECK = OrdMxBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxBUT, PROP) checks whether PROP exists for OrdMxBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSPROP(OrdMxBUT, PROP) throws error if PROP does NOT exist for OrdMxBUT.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OrdMxBUT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex binary undirected with fixed thresholds/error.
			%
			% CHECK = OrdMxBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxBUT, TAG) checks whether TAG exists for OrdMxBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSTAG(OrdMxBUT, TAG) throws error if TAG does NOT exist for OrdMxBUT.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			ordmxbut_tag_list = cellfun(@(x) OrdMxBUT.getPropTag(x), num2cell(OrdMxBUT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, ordmxbut_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMxBUT, POINTER) returns property number of POINTER of OrdMxBUT.
			%  PROPERTY = G.GETPROPPROP(OrdMxBUT, POINTER) returns property number of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				ordmxbut_tag_list = cellfun(@(x) OrdMxBUT.getPropTag(x), num2cell(OrdMxBUT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, ordmxbut_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OrdMxBUT, POINTER) returns tag of POINTER of OrdMxBUT.
			%  TAG = G.GETPROPTAG(OrdMxBUT, POINTER) returns tag of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case OrdMxBUT.THRESHOLDS
						tag = OrdMxBUT.THRESHOLDS_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxBUT, POINTER) returns category of POINTER of OrdMxBUT.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxBUT, POINTER) returns category of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS
					prop_category = OrdMxBUT.THRESHOLDS_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMxBUT, POINTER) returns format of POINTER of OrdMxBUT.
			%  FORMAT = G.GETPROPFORMAT(OrdMxBUT, POINTER) returns format of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS
					prop_format = OrdMxBUT.THRESHOLDS_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxBUT, POINTER) returns description of POINTER of OrdMxBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxBUT, POINTER) returns description of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS
					prop_description = 'THRESHOLDS (parameter, rvector) is the vector of thresholds.';
				case OrdMxBUT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.NAME
					prop_description = 'NAME (constant, string) is the name of the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.';
				case OrdMxBUT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.ID
					prop_description = 'ID (data, string) is a few-letter code for the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the binary undirected ordinal multiplex with fixed thresholds.';
				case OrdMxBUT.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTIPLEX__.';
				case OrdMxBUT.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).';
				case OrdMxBUT.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).';
				case OrdMxBUT.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.';
				case OrdMxBUT.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).';
				case OrdMxBUT.A
					prop_description = 'A (result, cell) is the cell array containing the binary supra-adjacency matrix of the binary undirected multiplex with fixed thresholds (BUT).';
				case OrdMxBUT.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.';
				case OrdMxBUT.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.';
				case OrdMxBUT.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case OrdMxBUT.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case OrdMxBUT.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrdMxBUT.RANDOMIZATION
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxBUT, POINTER) returns settings of POINTER of OrdMxBUT.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxBUT, POINTER) returns settings of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case OrdMxBUT.TEMPLATE
					prop_settings = 'OrdMxBUT';
				otherwise
					prop_settings = getPropSettings@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxBUT, POINTER) returns the default value of POINTER of OrdMxBUT.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxBUT, POINTER) returns the default value of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, OrdMxBUT.getPropSettings(prop));
				case OrdMxBUT.ELCLASS
					prop_default = 'OrdMxBUT';
				case OrdMxBUT.NAME
					prop_default = 'OrdMxBUT';
				case OrdMxBUT.DESCRIPTION
					prop_default = 'In a binary undirected ordinal multiplex with fixed thresholds (BUT),  all the layers consist of binary undirected (BU) multiplex graphs  derived from the same weighted supra-connectivity matrices  binarized at different thresholds. The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.';
				case OrdMxBUT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OrdMxBUT.getPropSettings(prop));
				case OrdMxBUT.ID
					prop_default = 'OrdMxBUT ID';
				case OrdMxBUT.LABEL
					prop_default = 'OrdMxBUT label';
				case OrdMxBUT.NOTES
					prop_default = 'OrdMxBUT notes';
				case OrdMxBUT.GRAPH_TYPE
					prop_default = Graph.ORDERED_MULTIPLEX;
				case OrdMxBUT.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('OrdMxBUT');
				case OrdMxBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxBUT, POINTER) returns the conditioned default value of POINTER of OrdMxBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxBUT, POINTER) returns the conditioned default value of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			prop_default = OrdMxBUT.conditioning(prop, OrdMxBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMxBUT, PROP, VALUE) checks VALUE format for PROP of OrdMxBUT.
			%  CHECK = G.CHECKPROP(OrdMxBUT, PROP, VALUE) checks VALUE format for PROP of OrdMxBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OrdMxBUT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:OrdMxBUT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OrdMxBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUT.
			%   Error id: €BRAPH2.STR€:OrdMxBUT:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(OrdMxBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUT.
			%   Error id: €BRAPH2.STR€:OrdMxBUT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case OrdMxBUT.THRESHOLDS % __OrdMxBUT.THRESHOLDS__
					check = Format.checkFormat(Format.RVECTOR, value, OrdMxBUT.getPropSettings(prop));
				case OrdMxBUT.TEMPLATE % __OrdMxBUT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OrdMxBUT.getPropSettings(prop));
				otherwise
					if prop <= OrdMxWU.getPropNumber()
						check = checkProp@OrdMxWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrdMxBUT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxBUT.getPropTag(prop) ' (' OrdMxBUT.getFormatTag(OrdMxBUT.getPropFormat(prop)) ').'] ...
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
				case OrdMxBUT.CONNECTIVITY_TYPE % __OrdMxBUT.CONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.BINARY * ones(layernumber);
					
				case OrdMxBUT.DIRECTIONALITY_TYPE % __OrdMxBUT.DIRECTIONALITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.UNDIRECTED * ones(layernumber);
					
				case OrdMxBUT.SELFCONNECTIVITY_TYPE % __OrdMxBUT.SELFCONNECTIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.SELFCONNECTED * ones(layernumber);
					value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
					
				case OrdMxBUT.NEGATIVITY_TYPE % __OrdMxBUT.NEGATIVITY_TYPE__
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = Graph.NONNEGATIVE * ones(layernumber);
					
				case OrdMxBUT.A % __OrdMxBUT.A__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxBUT.A), 'twister')
					
					A_WU = calculateValue@OrdMxWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					L = length(A_WU); % number of layers
					A = cell(length(thresholds)*L);
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    A(:, :) = {zeros(length(A_WU{1, 1}))};
					    for i = 1:1:length(thresholds)
					        threshold = thresholds(i);
					        layer = 1;
					        for j = (i - 1) * L + 1:1:i * L
						        for k = (i - 1) * L + 1:1:i * L
					                if j == k
					                    A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'threshold', threshold));
					                elseif (j-k)==1 || (k-j)==1
					                    A(j, k) = {eye(length(A{1, 1}))};
					                else
					                    A(j, k) = {zeros(length(A{1, 1}))};
					                end
					            end
					            layer = layer + 1;
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case OrdMxBUT.PARTITIONS % __OrdMxBUT.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(OrdMxBUT.PARTITIONS), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case OrdMxBUT.ALAYERLABELS % __OrdMxBUT.ALAYERLABELS__
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
					
				case OrdMxBUT.APARTITIONLABELS % __OrdMxBUT.APARTITIONLABELS__
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case OrdMxBUT.RANDOMIZATION % __OrdMxBUT.RANDOMIZATION__
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
				case OrdMxBUT.THRESHOLDS % __OrdMxBUT.THRESHOLDS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', OrdMxBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case OrdMxBUT.A % __OrdMxBUT.A__
					pr = PanelPropCell('EL', g, 'PROP', OrdMxBUT.A, ...
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
