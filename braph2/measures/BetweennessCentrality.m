classdef BetweennessCentrality < Measure
	%BetweennessCentrality is the Betweenness Centrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Betweenness Centrality (BetweennessCentrality) of a graph is the fraction of all shortest paths in the 
	% graph that pass through a given node. Nodes with high values of betweenness 
	% centrality participate in a large number of shortest paths.
	%
	% BetweennessCentrality methods (constructor):
	%  BetweennessCentrality - constructor
	%
	% BetweennessCentrality methods:
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
	% BetweennessCentrality methods (display):
	%  tostring - string with information about the betweenness centrality
	%  disp - displays information about the betweenness centrality
	%  tree - displays the tree of the betweenness centrality
	%
	% BetweennessCentrality methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two betweenness centrality are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the betweenness centrality
	%
	% BetweennessCentrality methods (save/load, Static):
	%  save - saves BRAPH2 betweenness centrality as b2 file
	%  load - loads a BRAPH2 betweenness centrality from a b2 file
	%
	% BetweennessCentrality method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the betweenness centrality
	%
	% BetweennessCentrality method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the betweenness centrality
	%
	% BetweennessCentrality methods (inspection, Static):
	%  getClass - returns the class of the betweenness centrality
	%  getSubclasses - returns all subclasses of BetweennessCentrality
	%  getProps - returns the property list of the betweenness centrality
	%  getPropNumber - returns the property number of the betweenness centrality
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
	% BetweennessCentrality methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BetweennessCentrality methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BetweennessCentrality methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BetweennessCentrality methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BetweennessCentrality; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BetweennessCentrality constants</a>.
	%
	
	methods % constructor
		function m = BetweennessCentrality(varargin)
			%BetweennessCentrality() creates a betweenness centrality.
			%
			% BetweennessCentrality(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BetweennessCentrality(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the betweenness centrality.
			%
			% CLASS = BetweennessCentrality.GETCLASS() returns the class 'BetweennessCentrality'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the betweenness centrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('BetweennessCentrality') returns 'BetweennessCentrality'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('BetweennessCentrality')
			%  are less computationally efficient.
			
			m_class = 'BetweennessCentrality';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the betweenness centrality.
			%
			% LIST = BetweennessCentrality.GETSUBCLASSES() returns all subclasses of 'BetweennessCentrality'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the betweenness centrality M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('BetweennessCentrality') returns all subclasses of 'BetweennessCentrality'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('BetweennessCentrality', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of betweenness centrality.
			%
			% PROPS = BetweennessCentrality.GETPROPS() returns the property list of betweenness centrality
			%  as a row vector.
			%
			% PROPS = BetweennessCentrality.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the betweenness centrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('BetweennessCentrality'[, CATEGORY]) returns the property list of 'BetweennessCentrality'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of betweenness centrality.
			%
			% N = BetweennessCentrality.GETPROPNUMBER() returns the property number of betweenness centrality.
			%
			% N = BetweennessCentrality.GETPROPNUMBER(CATEGORY) returns the property number of betweenness centrality
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the betweenness centrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('BetweennessCentrality') returns the property number of 'BetweennessCentrality'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(BetweennessCentrality.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in betweenness centrality/error.
			%
			% CHECK = BetweennessCentrality.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(BetweennessCentrality, PROP) checks whether PROP exists for BetweennessCentrality.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSPROP(BetweennessCentrality, PROP) throws error if PROP does NOT exist for BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == BetweennessCentrality.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BetweennessCentrality.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in betweenness centrality/error.
			%
			% CHECK = BetweennessCentrality.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(BetweennessCentrality, TAG) checks whether TAG exists for BetweennessCentrality.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSTAG(BetweennessCentrality, TAG) throws error if TAG does NOT exist for BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			betweennesscentrality_tag_list = cellfun(@(x) BetweennessCentrality.getPropTag(x), num2cell(BetweennessCentrality.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, betweennesscentrality_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for BetweennessCentrality.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(BetweennessCentrality, POINTER) returns property number of POINTER of BetweennessCentrality.
			%  PROPERTY = M.GETPROPPROP(BetweennessCentrality, POINTER) returns property number of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				betweennesscentrality_tag_list = cellfun(@(x) BetweennessCentrality.getPropTag(x), num2cell(BetweennessCentrality.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, betweennesscentrality_tag_list)); % tag = pointer
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(BetweennessCentrality, POINTER) returns tag of POINTER of BetweennessCentrality.
			%  TAG = M.GETPROPTAG(BetweennessCentrality, POINTER) returns tag of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@Measure(prop);
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(BetweennessCentrality, POINTER) returns category of POINTER of BetweennessCentrality.
			%  CATEGORY = M.GETPROPCATEGORY(BetweennessCentrality, POINTER) returns category of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Measure(prop);
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(BetweennessCentrality, POINTER) returns format of POINTER of BetweennessCentrality.
			%  FORMAT = M.GETPROPFORMAT(BetweennessCentrality, POINTER) returns format of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Measure(prop);
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BetweennessCentrality, POINTER) returns description of POINTER of BetweennessCentrality.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(BetweennessCentrality, POINTER) returns description of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				case BetweennessCentrality.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Betweenness Centrality.';
				case BetweennessCentrality.NAME
					prop_description = 'NAME (constant, string) is the name of the Betweenness Centrality.';
				case BetweennessCentrality.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Betweenness Centrality.';
				case BetweennessCentrality.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Betweenness Centrality.';
				case BetweennessCentrality.ID
					prop_description = 'ID (data, string) is a few-letter code of the Betweenness Centrality.';
				case BetweennessCentrality.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Betweenness Centrality.';
				case BetweennessCentrality.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Betweenness Centrality.';
				case BetweennessCentrality.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case BetweennessCentrality.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case BetweennessCentrality.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case BetweennessCentrality.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case BetweennessCentrality.M
					prop_description = 'M (result, cell) is the cell containing Betweenness Centrality.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(BetweennessCentrality, POINTER) returns settings of POINTER of BetweennessCentrality.
			%  SETTINGS = M.GETPROPSETTINGS(BetweennessCentrality, POINTER) returns settings of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				case BetweennessCentrality.TEMPLATE
					prop_settings = 'BetweennessCentrality';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(BetweennessCentrality, POINTER) returns the default value of POINTER of BetweennessCentrality.
			%  DEFAULT = M.GETPROPDEFAULT(BetweennessCentrality, POINTER) returns the default value of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				case BetweennessCentrality.ELCLASS
					prop_default = 'BetweennessCentrality';
				case BetweennessCentrality.NAME
					prop_default = 'Betweenness Centrality';
				case BetweennessCentrality.DESCRIPTION
					prop_default = 'The Betweenness Centrality (BetweennessCentrality) of a graph is the fraction of all shortest paths in the graph that pass through a given node. Nodes with high values of betweenness centrality participate in a large number of shortest paths.';
				case BetweennessCentrality.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, BetweennessCentrality.getPropSettings(prop));
				case BetweennessCentrality.ID
					prop_default = 'BetweennessCentrality ID';
				case BetweennessCentrality.LABEL
					prop_default = 'Betweenness Centrality label';
				case BetweennessCentrality.NOTES
					prop_default = 'Betweenness Centrality notes';
				case BetweennessCentrality.SHAPE
					prop_default = Measure.NODAL;
				case BetweennessCentrality.SCOPE
					prop_default = Measure.UNILAYER;
				case BetweennessCentrality.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case BetweennessCentrality.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BetweennessCentrality, POINTER) returns the conditioned default value of POINTER of BetweennessCentrality.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(BetweennessCentrality, POINTER) returns the conditioned default value of POINTER of BetweennessCentrality.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			prop_default = BetweennessCentrality.conditioning(prop, BetweennessCentrality.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(BetweennessCentrality, PROP, VALUE) checks VALUE format for PROP of BetweennessCentrality.
			%  CHECK = M.CHECKPROP(BetweennessCentrality, PROP, VALUE) checks VALUE format for PROP of BetweennessCentrality.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:BetweennessCentrality:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:BetweennessCentrality:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(BetweennessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BetweennessCentrality.
			%   Error id: €BRAPH2.STR€:BetweennessCentrality:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(BetweennessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BetweennessCentrality.
			%   Error id: €BRAPH2.STR€:BetweennessCentrality:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('BetweennessCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				case BetweennessCentrality.TEMPLATE % __BetweennessCentrality.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, BetweennessCentrality.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BetweennessCentrality.getPropTag(prop) ' (' BetweennessCentrality.getFormatTag(BetweennessCentrality.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case BetweennessCentrality.M % __BetweennessCentrality.M__
					rng_settings_ = rng(); rng(m.getPropSeed(BetweennessCentrality.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					NN = g.get('NODENUMBER');
					
					betweenness_centrality = cell(L, 1);
					connectivity_layer =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
					
					for li = 1:1:L
					    Aii = A{li, li};
					
					    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					        betweenness_centrality_layer = getWeightedCalculation(Aii)/((NN(li)-1)*(NN(li)-2));  % Normalized betweenness centrality
					        betweenness_centrality(li) = {betweenness_centrality_layer};
					    else  % binary graphs
					        betweenness_centrality_layer = getBinaryCalculation(Aii)/((NN(li)-1)*(NN(li)-2));  % Normalized betweenness centrality
					        betweenness_centrality(li) = {betweenness_centrality_layer};
					    end
					end
					
					value = betweenness_centrality;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function weighted_betweenness_centrality = getWeightedCalculation(A)
			    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
			    %
			    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the
			    %  distance of a weighted adjacency matrix A.
			
			    N = size(A, 2);  % number of nodes
			    E = find(A);
			    A(E) = 1./A(E);  % invert weights
			    weighted_betweenness_centrality = zeros(N, 1);  % init vertex betweenness
			    
			    % Compute the distances and number of
			    % shortest paths between all pairs of vertices
			    for u = 1:N  % One search for each source vertex u
			        D = inf(1, N);
			        D(u) = 0;  % distance from u
			        NP = zeros(1, N);
			        NP(u) = 1;  % number of paths from u
			        S = true(1, N);  % distance permanence S (true is temporary)
			        P = false(N);  % predecessors P
			        Q = zeros(1, N);  % order of non-increasing distance
			        q = N;
			        G = A;  % graph G
			        V = u;  % set of nodes (V) of graph G
			        
			        % Forward pass:
			        % Compute the shortest paths
			        % from the source u to all the other nodes in V
			        while 1
			            S(V) = 0;  % distance u->V is now permanent
			            G(:,V) = 0;  % no in-edges as already shortest
			            for v = V
			                Q(q) = v;
			                q = q-1;
			                neighbors = find(G(v,:));  % neighbors of v
			                for neighbor = neighbors
			                    Duw = D(v) + G(v, neighbor);  % Duw path length to be tested
			                    if Duw<D(neighbor)  % if new u->w shorter than old
			                        D(neighbor) = Duw;
			                        NP(neighbor) = NP(v);  % NP(u->w) = NP of new path
			                        P(neighbor,:) = 0;
			                        P(neighbor, v) = 1;  % v is the only predecessor
			                    elseif Duw==D(neighbor)  % if new u->w equal to old
			                        NP(neighbor) = NP(neighbor)+NP(v);  % NP(u->w) sum of old and new
			                        P(neighbor, v) = 1;  % v is also a predecessor
			                    end
			                end
			            end
			            minD = min(D(S));  % shortest distance
			            if isempty(minD), break  % all nodes reached, or
			            elseif isinf(minD)  % some cannot be reached:
			                Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
			            end
			            V = find(D==minD);
			        end
			        
			        % Compute dependencies (DP)
			        DP = zeros(N, 1);
			        for n = Q(1:N-1)
			            weighted_betweenness_centrality(n) = weighted_betweenness_centrality(n)+DP(n);  % update betweenness
			            for v = find(P(n,:))
			                DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);  % dependency
			            end
			        end
			    end
			end
			function binary_betweenness_centrality = getBinaryCalculation(A)
			    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
			    %
			    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
			    %  distance of a binary adjacency matrix A.
			    
			    N = size(A, 1);  % number of nodes
			    I = eye(N)~=0;  % logical identity matrix
			    d = 1;  % start path length d
			    NPd = A;  % number of paths of length |d|
			    NSPd = NPd;  % number of shortest paths of length |d|
			    NSP = NSPd;  % number of shortest paths of any length
			    NSP(I) = 1;
			    L = NSPd;  % length of shortest paths
			    L(I) = 1;
			    
			    % Forward pass: Compute the distance (L) and the number of
			    % shortest paths (NSP) between all pairs
			    % Compute Path Count:
			    while find(NSPd, 1)
			        d = d + 1;
			        NPd = NPd*A;  % Index value corresponds to number of paths found of length d+1
			        NSPd = NPd.*(L==0);
			        NSP = NSP + NSPd;  % Add new found shortest paths
			        L = L+d.*(NSPd~=0);  % Add new found shortest paths' distance
			    end
			    L(~L) = inf; L(I) = 0;  % Lenght for disconnected vertices is inf
			    NSP(~NSP) = 1;  % NSP for disconnected vertices is 1
			    
			    % Backward pass: compute the dependencies (DP)
			    DP = zeros(N);  % vertex on vertex dependency
			    diam = d-1;  % graph diameter
			    for d = diam:-1:2  % L == path_length_d is zero for path_length_d = diam
			        DPd1 = (((L==d).*(1+DP)./NSP)*(A.')).*((L==(d-1)).*NSP);
			        DP = DP + DPd1;  %DPd1: dependencies on vertices |d-1| from source
			    end
			    binary_betweenness_centrality = sum(DP, 1);  % compute betweenness
			    binary_betweenness_centrality = binary_betweenness_centrality';
			end
		end
	end
end
