classdef MultiplexKCorC < Measure
	%MultiplexKCorC is the graph Multiplex K-Coreness Centrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multiplex K-Coreness Centrality (MultiplexKCorC) of a node is k if the node belongs to the k-core 
	% but not to the (k+1)-core.
	%
	% MultiplexKCorC methods (constructor):
	%  MultiplexKCorC - constructor
	%
	% MultiplexKCorC methods:
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
	% MultiplexKCorC methods (display):
	%  tostring - string with information about the multiplex k-coreness centrality
	%  disp - displays information about the multiplex k-coreness centrality
	%  tree - displays the tree of the multiplex k-coreness centrality
	%
	% MultiplexKCorC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex k-coreness centrality are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex k-coreness centrality
	%
	% MultiplexKCorC methods (save/load, Static):
	%  save - saves BRAPH2 multiplex k-coreness centrality as b2 file
	%  load - loads a BRAPH2 multiplex k-coreness centrality from a b2 file
	%
	% MultiplexKCorC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex k-coreness centrality
	%
	% MultiplexKCorC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex k-coreness centrality
	%
	% MultiplexKCorC methods (inspection, Static):
	%  getClass - returns the class of the multiplex k-coreness centrality
	%  getSubclasses - returns all subclasses of MultiplexKCorC
	%  getProps - returns the property list of the multiplex k-coreness centrality
	%  getPropNumber - returns the property number of the multiplex k-coreness centrality
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
	% MultiplexKCorC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexKCorC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexKCorC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexKCorC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexKCorC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexKCorC constants</a>.
	%
	
	methods % constructor
		function m = MultiplexKCorC(varargin)
			%MultiplexKCorC() creates a multiplex k-coreness centrality.
			%
			% MultiplexKCorC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexKCorC(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex k-coreness centrality.
			%
			% CLASS = MultiplexKCorC.GETCLASS() returns the class 'MultiplexKCorC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex k-coreness centrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexKCorC') returns 'MultiplexKCorC'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexKCorC')
			%  are less computationally efficient.
			
			m_class = 'MultiplexKCorC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex k-coreness centrality.
			%
			% LIST = MultiplexKCorC.GETSUBCLASSES() returns all subclasses of 'MultiplexKCorC'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex k-coreness centrality M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexKCorC') returns all subclasses of 'MultiplexKCorC'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexKCorC', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex k-coreness centrality.
			%
			% PROPS = MultiplexKCorC.GETPROPS() returns the property list of multiplex k-coreness centrality
			%  as a row vector.
			%
			% PROPS = MultiplexKCorC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex k-coreness centrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexKCorC'[, CATEGORY]) returns the property list of 'MultiplexKCorC'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexKCorC')
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
			%GETPROPNUMBER returns the property number of multiplex k-coreness centrality.
			%
			% N = MultiplexKCorC.GETPROPNUMBER() returns the property number of multiplex k-coreness centrality.
			%
			% N = MultiplexKCorC.GETPROPNUMBER(CATEGORY) returns the property number of multiplex k-coreness centrality
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex k-coreness centrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexKCorC') returns the property number of 'MultiplexKCorC'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexKCorC.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex k-coreness centrality/error.
			%
			% CHECK = MultiplexKCorC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexKCorC, PROP) checks whether PROP exists for MultiplexKCorC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%  Element.EXISTSPROP(MultiplexKCorC, PROP) throws error if PROP does NOT exist for MultiplexKCorC.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexKCorC.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexKCorC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex k-coreness centrality/error.
			%
			% CHECK = MultiplexKCorC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexKCorC, TAG) checks whether TAG exists for MultiplexKCorC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%  Element.EXISTSTAG(MultiplexKCorC, TAG) throws error if TAG does NOT exist for MultiplexKCorC.
			%   Error id: [BRAPH2:MultiplexKCorC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexkcorc_tag_list = cellfun(@(x) MultiplexKCorC.getPropTag(x), num2cell(MultiplexKCorC.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexkcorc_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexKCorC.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexKCorC, POINTER) returns property number of POINTER of MultiplexKCorC.
			%  PROPERTY = M.GETPROPPROP(MultiplexKCorC, POINTER) returns property number of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexkcorc_tag_list = cellfun(@(x) MultiplexKCorC.getPropTag(x), num2cell(MultiplexKCorC.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexkcorc_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexKCorC, POINTER) returns tag of POINTER of MultiplexKCorC.
			%  TAG = M.GETPROPTAG(MultiplexKCorC, POINTER) returns tag of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexKCorC')
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexKCorC, POINTER) returns category of POINTER of MultiplexKCorC.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexKCorC, POINTER) returns category of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexKCorC, POINTER) returns format of POINTER of MultiplexKCorC.
			%  FORMAT = M.GETPROPFORMAT(MultiplexKCorC, POINTER) returns format of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexKCorC, POINTER) returns description of POINTER of MultiplexKCorC.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexKCorC, POINTER) returns description of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
			switch prop
				case MultiplexKCorC.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex K-Coreness Centrality.';
				case MultiplexKCorC.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexKCorC.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexKCorC.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexKCorC.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexKCorC.M
					prop_description = 'M (result, cell) is the Multiplex K-Coreness Centrality.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexKCorC, POINTER) returns settings of POINTER of MultiplexKCorC.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexKCorC, POINTER) returns settings of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
			switch prop
				case MultiplexKCorC.TEMPLATE
					prop_settings = 'MultiplexKCorC';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexKCorC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexKCorC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexKCorC, POINTER) returns the default value of POINTER of MultiplexKCorC.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexKCorC, POINTER) returns the default value of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
			switch prop
				case MultiplexKCorC.ELCLASS
					prop_default = 'MultiplexKCorC';
				case MultiplexKCorC.NAME
					prop_default = 'Multiplex K-Coreness Centrality';
				case MultiplexKCorC.DESCRIPTION
					prop_default = 'The Multiplex K-Coreness Centrality (MultiplexKCorC) of a node is k if the node belongs to the k-core but not to the (k+1)-core.';
				case MultiplexKCorC.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexKCorC.getPropSettings(prop));
				case MultiplexKCorC.ID
					prop_default = 'MultiplexKCorC ID';
				case MultiplexKCorC.LABEL
					prop_default = 'Multiplex K-Coreness Centrality label';
				case MultiplexKCorC.NOTES
					prop_default = 'Multiplex K-Coreness Centrality notes';
				case MultiplexKCorC.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexKCorC.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexKCorC.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexKCorC.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexKCorC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexKCorC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexKCorC, POINTER) returns the conditioned default value of POINTER of MultiplexKCorC.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexKCorC, POINTER) returns the conditioned default value of POINTER of MultiplexKCorC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
			prop_default = MultiplexKCorC.conditioning(prop, MultiplexKCorC.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexKCorC, PROP, VALUE) checks VALUE format for PROP of MultiplexKCorC.
			%  CHECK = M.CHECKPROP(MultiplexKCorC, PROP, VALUE) checks VALUE format for PROP of MultiplexKCorC.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexKCorC:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexKCorC:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexKCorC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexKCorC.
			%   Error id: €BRAPH2.STR€:MultiplexKCorC:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexKCorC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexKCorC.
			%   Error id: €BRAPH2.STR€:MultiplexKCorC:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexKCorC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexKCorC.getPropProp(pointer);
			
			switch prop
				case MultiplexKCorC.TEMPLATE % __MultiplexKCorC.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexKCorC.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexKCorC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexKCorC.getPropTag(prop) ' (' MultiplexKCorC.getFormatTag(MultiplexKCorC.getPropFormat(prop)) ').'] ...
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
				case MultiplexKCorC.M % __MultiplexKCorC.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexKCorC.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');  
					
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multiplex_k_coreness_centrality = cell(length(ls), 1);
					    directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
					    for i = 1:1:length(ls)
					        A_sum = zeros(N(1), N(1));
					        for j = 1:1:length(l)
					            A_sum = A_sum + A{j, j};
					        end
					        multiplex_coreness = zeros(1, N(1));
					        for k = 1:N(1)
					            m_k_core = calculate_multiplexkcore(A_sum, k, directionality_layer);
					            ss = sum(m_k_core) > 0;
					            multiplex_coreness(ss) = k;
					        end
					        multiplex_k_coreness_centrality(i) = {multiplex_coreness'};
					    end
					    value = multiplex_k_coreness_centrality;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function m_k_core = calculate_multiplexkcore(A, k, directionality_layer)
			    % CALCULATE MKCORE calculates the multiplex k-core value of a supra-adjacency matrix
			    %
			    % MKCORE = CALCULATEMULTIPLEXKCORE(M, A, k, directionality_layer) returns
			    % the value of the multiplex k-core of a supra-adjacency matrix
			    
			    iter = 0;
			    subAii = binarize(A);
			    while 1
			        % get degrees of matrix
			        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
			            ovdeg = sum(subAii, 1)';  % degree undirected graphs
			        else
			            ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
			        end
			    
			        % find nodes with degree < k
			        low_k_nodes = find((ovdeg < k) & (ovdeg > 0));
			    
			        % if none found -> stop
			        if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
			    
			        % peel away found nodes
			        iter = iter + 1;
			        subAii(low_k_nodes, :) = 0;
			        subAii(:, low_k_nodes) = 0;
			    end
			    m_k_core = subAii;  % add k-core of layer li
			end
		end
	end
end
