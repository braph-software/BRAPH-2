classdef MultiplexCl < MultiplexT
	%MultiplexCl is the graph Multiplex Clustering.
	% It is a subclass of <a href="matlab:help MultiplexT">MultiplexT</a>.
	%
	% The two-Multiplex Clustering coefficient (MultiplexCl) of a node i is the fraction 
	%  of two-multiplex triangles (triangles which use edges from two different 
	%  layers) with a vertex in node i and the number of one-triads centered in i.
	%
	% MultiplexCl methods (constructor):
	%  MultiplexCl - constructor
	%
	% MultiplexCl methods:
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
	% MultiplexCl methods (display):
	%  tostring - string with information about the multiplex clustering
	%  disp - displays information about the multiplex clustering
	%  tree - displays the tree of the multiplex clustering
	%
	% MultiplexCl methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex clustering are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex clustering
	%
	% MultiplexCl methods (save/load, Static):
	%  save - saves BRAPH2 multiplex clustering as b2 file
	%  load - loads a BRAPH2 multiplex clustering from a b2 file
	%
	% MultiplexCl method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex clustering
	%
	% MultiplexCl method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex clustering
	%
	% MultiplexCl methods (inspection, Static):
	%  getClass - returns the class of the multiplex clustering
	%  getSubclasses - returns all subclasses of MultiplexCl
	%  getProps - returns the property list of the multiplex clustering
	%  getPropNumber - returns the property number of the multiplex clustering
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
	% MultiplexCl methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexCl methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexCl methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexCl methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexCl; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexCl constants</a>.
	%
	
	methods % constructor
		function m = MultiplexCl(varargin)
			%MultiplexCl() creates a multiplex clustering.
			%
			% MultiplexCl(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexCl(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@MultiplexT(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multiplex clustering.
			%
			% CLASS = MultiplexCl.GETCLASS() returns the class 'MultiplexCl'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex clustering M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexCl') returns 'MultiplexCl'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexCl')
			%  are less computationally efficient.
			
			m_class = 'MultiplexCl';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex clustering.
			%
			% LIST = MultiplexCl.GETSUBCLASSES() returns all subclasses of 'MultiplexCl'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex clustering M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexCl') returns all subclasses of 'MultiplexCl'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexCl', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex clustering.
			%
			% PROPS = MultiplexCl.GETPROPS() returns the property list of multiplex clustering
			%  as a row vector.
			%
			% PROPS = MultiplexCl.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex clustering M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexCl'[, CATEGORY]) returns the property list of 'MultiplexCl'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultiplexT.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultiplexT.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultiplexT.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultiplexT.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MultiplexT.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultiplexT.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultiplexT.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultiplexT.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultiplexT.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultiplexT.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multiplex clustering.
			%
			% N = MultiplexCl.GETPROPNUMBER() returns the property number of multiplex clustering.
			%
			% N = MultiplexCl.GETPROPNUMBER(CATEGORY) returns the property number of multiplex clustering
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex clustering M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexCl') returns the property number of 'MultiplexCl'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexCl.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex clustering/error.
			%
			% CHECK = MultiplexCl.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexCl, PROP) checks whether PROP exists for MultiplexCl.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexCl:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%  Element.EXISTSPROP(MultiplexCl, PROP) throws error if PROP does NOT exist for MultiplexCl.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexCl.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexCl.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex clustering/error.
			%
			% CHECK = MultiplexCl.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexCl, TAG) checks whether TAG exists for MultiplexCl.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexCl:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%  Element.EXISTSTAG(MultiplexCl, TAG) throws error if TAG does NOT exist for MultiplexCl.
			%   Error id: [BRAPH2:MultiplexCl:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexcl_tag_list = cellfun(@(x) MultiplexCl.getPropTag(x), num2cell(MultiplexCl.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexcl_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexCl.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexCl, POINTER) returns property number of POINTER of MultiplexCl.
			%  PROPERTY = M.GETPROPPROP(MultiplexCl, POINTER) returns property number of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexcl_tag_list = cellfun(@(x) MultiplexCl.getPropTag(x), num2cell(MultiplexCl.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexcl_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexCl, POINTER) returns tag of POINTER of MultiplexCl.
			%  TAG = M.GETPROPTAG(MultiplexCl, POINTER) returns tag of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexCl')
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
						tag = getPropTag@MultiplexT(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexCl, POINTER) returns category of POINTER of MultiplexCl.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexCl, POINTER) returns category of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MultiplexT(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexCl, POINTER) returns format of POINTER of MultiplexCl.
			%  FORMAT = M.GETPROPFORMAT(MultiplexCl, POINTER) returns format of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MultiplexT(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexCl, POINTER) returns description of POINTER of MultiplexCl.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexCl, POINTER) returns description of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				case MultiplexCl.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex Clustering.';
				case MultiplexCl.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex Clustering.';
				case MultiplexCl.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex Clustering.';
				case MultiplexCl.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex Clustering.';
				case MultiplexCl.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex Clustering.';
				case MultiplexCl.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex Clustering.';
				case MultiplexCl.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex Clustering.';
				case MultiplexCl.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexCl.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexCl.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexCl.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexCl.M
					prop_description = 'M (result, cell) is the Multiplex Clustering.';
				otherwise
					prop_description = getPropDescription@MultiplexT(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexCl, POINTER) returns settings of POINTER of MultiplexCl.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexCl, POINTER) returns settings of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				case MultiplexCl.TEMPLATE
					prop_settings = 'MultiplexCl';
				otherwise
					prop_settings = getPropSettings@MultiplexT(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexCl.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCl.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexCl, POINTER) returns the default value of POINTER of MultiplexCl.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexCl, POINTER) returns the default value of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				case MultiplexCl.ELCLASS
					prop_default = 'MultiplexCl';
				case MultiplexCl.NAME
					prop_default = 'Multiplex Clustering';
				case MultiplexCl.DESCRIPTION
					prop_default = 'The two-Multiplex Clustering coefficient (MultiplexCl) of a node i is the fraction of two-multiplex triangles (triangles which use edges from two different layers) with a vertex in node i and the number of one-triads centered in i.';
				case MultiplexCl.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexCl.getPropSettings(prop));
				case MultiplexCl.ID
					prop_default = 'MultiplexCl ID';
				case MultiplexCl.LABEL
					prop_default = 'Multiplex Clustering label';
				case MultiplexCl.NOTES
					prop_default = 'Multiplex Clustering notes';
				case MultiplexCl.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexCl.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexCl.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexCl.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@MultiplexT(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexCl.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCl.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexCl, POINTER) returns the conditioned default value of POINTER of MultiplexCl.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexCl, POINTER) returns the conditioned default value of POINTER of MultiplexCl.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			prop_default = MultiplexCl.conditioning(prop, MultiplexCl.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexCl, PROP, VALUE) checks VALUE format for PROP of MultiplexCl.
			%  CHECK = M.CHECKPROP(MultiplexCl, PROP, VALUE) checks VALUE format for PROP of MultiplexCl.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexCl:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexCl:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexCl, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCl.
			%   Error id: €BRAPH2.STR€:MultiplexCl:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexCl, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCl.
			%   Error id: €BRAPH2.STR€:MultiplexCl:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexCl')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexCl.getPropProp(pointer);
			
			switch prop
				case MultiplexCl.TEMPLATE % __MultiplexCl.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexCl.getPropSettings(prop));
				otherwise
					if prop <= MultiplexT.getPropNumber()
						check = checkProp@MultiplexT(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCl:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexCl.getPropTag(prop) ' (' MultiplexCl.getFormatTag(MultiplexCl.getPropFormat(prop)) ').'] ...
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
				case MultiplexCl.M % __MultiplexCl.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexCl.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multiplex_triangles = calculateValue@MultiplexT(m, prop);
					    degree = Degree('G', g).get('M');
					
					    multiplex_clustering = cell(length(ls), 1);
					    count = 1;
					    for p = 1:1:length(ls)
					        multiplex_clustering_degree = zeros(N(1), 1);
					        for i = count:1:ls(p) + count - 1
					            k = degree{i};
					            multiplex_clustering_degree = multiplex_clustering_degree + (k .* (k - 1));
					        end
					        multiplex_clustering_partition = multiplex_triangles{p}./ ((ls(p)-1)*multiplex_clustering_degree);
					        multiplex_clustering_partition(isnan(multiplex_clustering_partition)) = 0;  % Should return zeros, not NaN
					        count = count + ls(p);
					        multiplex_clustering(p) = {multiplex_clustering_partition};
					    end
					    value = multiplex_clustering;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= MultiplexT.getPropNumber()
						value = calculateValue@MultiplexT(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
