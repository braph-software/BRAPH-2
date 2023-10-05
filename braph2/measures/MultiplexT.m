classdef MultiplexT < Measure
	%MultiplexT is the graph Multiplex Triangles.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multiplex Triangles (MultiplexT) are calculated as the number of neighbors of a node 
	%  that are also neighbors of each other between each pair of layers. 
	% In weighted graphs, the multiplex triangles are calculated as geometric mean 
	%  of the weights of the edges forming the multiplex triangle.
	%
	% MultiplexT methods (constructor):
	%  MultiplexT - constructor
	%
	% MultiplexT methods:
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
	% MultiplexT methods (display):
	%  tostring - string with information about the multiplex triangles
	%  disp - displays information about the multiplex triangles
	%  tree - displays the tree of the multiplex triangles
	%
	% MultiplexT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex triangles are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex triangles
	%
	% MultiplexT methods (save/load, Static):
	%  save - saves BRAPH2 multiplex triangles as b2 file
	%  load - loads a BRAPH2 multiplex triangles from a b2 file
	%
	% MultiplexT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex triangles
	%
	% MultiplexT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex triangles
	%
	% MultiplexT methods (inspection, Static):
	%  getClass - returns the class of the multiplex triangles
	%  getSubclasses - returns all subclasses of MultiplexT
	%  getProps - returns the property list of the multiplex triangles
	%  getPropNumber - returns the property number of the multiplex triangles
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
	% MultiplexT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexT constants</a>.
	%
	
	methods % constructor
		function m = MultiplexT(varargin)
			%MultiplexT() creates a multiplex triangles.
			%
			% MultiplexT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex triangles.
			%
			% CLASS = MultiplexT.GETCLASS() returns the class 'MultiplexT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex triangles M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexT') returns 'MultiplexT'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexT')
			%  are less computationally efficient.
			
			m_class = 'MultiplexT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex triangles.
			%
			% LIST = MultiplexT.GETSUBCLASSES() returns all subclasses of 'MultiplexT'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex triangles M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexT') returns all subclasses of 'MultiplexT'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex triangles.
			%
			% PROPS = MultiplexT.GETPROPS() returns the property list of multiplex triangles
			%  as a row vector.
			%
			% PROPS = MultiplexT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex triangles M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexT'[, CATEGORY]) returns the property list of 'MultiplexT'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexT')
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
			%GETPROPNUMBER returns the property number of multiplex triangles.
			%
			% N = MultiplexT.GETPROPNUMBER() returns the property number of multiplex triangles.
			%
			% N = MultiplexT.GETPROPNUMBER(CATEGORY) returns the property number of multiplex triangles
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex triangles M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexT') returns the property number of 'MultiplexT'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex triangles/error.
			%
			% CHECK = MultiplexT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexT, PROP) checks whether PROP exists for MultiplexT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%  Element.EXISTSPROP(MultiplexT, PROP) throws error if PROP does NOT exist for MultiplexT.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex triangles/error.
			%
			% CHECK = MultiplexT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexT, TAG) checks whether TAG exists for MultiplexT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%  Element.EXISTSTAG(MultiplexT, TAG) throws error if TAG does NOT exist for MultiplexT.
			%   Error id: [BRAPH2:MultiplexT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplext_tag_list = cellfun(@(x) MultiplexT.getPropTag(x), num2cell(MultiplexT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplext_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexT, POINTER) returns property number of POINTER of MultiplexT.
			%  PROPERTY = M.GETPROPPROP(MultiplexT, POINTER) returns property number of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplext_tag_list = cellfun(@(x) MultiplexT.getPropTag(x), num2cell(MultiplexT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplext_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexT, POINTER) returns tag of POINTER of MultiplexT.
			%  TAG = M.GETPROPTAG(MultiplexT, POINTER) returns tag of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexT')
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexT, POINTER) returns category of POINTER of MultiplexT.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexT, POINTER) returns category of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexT, POINTER) returns format of POINTER of MultiplexT.
			%  FORMAT = M.GETPROPFORMAT(MultiplexT, POINTER) returns format of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexT, POINTER) returns description of POINTER of MultiplexT.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexT, POINTER) returns description of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
			switch prop
				case MultiplexT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex Triangles.';
				case MultiplexT.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex Triangles.';
				case MultiplexT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex Triangles.';
				case MultiplexT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex Triangles.';
				case MultiplexT.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex Triangles.';
				case MultiplexT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex Triangles.';
				case MultiplexT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex Triangles.';
				case MultiplexT.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexT.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexT.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexT.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexT.M
					prop_description = 'M (result, cell) is the Multiplex Triangles.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexT, POINTER) returns settings of POINTER of MultiplexT.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexT, POINTER) returns settings of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
			switch prop
				case MultiplexT.TEMPLATE
					prop_settings = 'MultiplexT';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexT, POINTER) returns the default value of POINTER of MultiplexT.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexT, POINTER) returns the default value of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
			switch prop
				case MultiplexT.ELCLASS
					prop_default = 'MultiplexT';
				case MultiplexT.NAME
					prop_default = 'Multiplex Triangles';
				case MultiplexT.DESCRIPTION
					prop_default = 'The Multiplex Triangles (MultiplexT) are calculated as the number of neighbors of a node that are also neighbors of each other between each pair of layers. In weighted graphs, the multiplex triangles are calculated as geometric mean of the weights of the edges forming the multiplex triangle.';
				case MultiplexT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexT.getPropSettings(prop));
				case MultiplexT.ID
					prop_default = 'MultiplexT ID';
				case MultiplexT.LABEL
					prop_default = 'Multiplex Triangles label';
				case MultiplexT.NOTES
					prop_default = 'Multiplex Triangles notes';
				case MultiplexT.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexT.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexT.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexT.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD' 'OrdMxBUT'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexT, POINTER) returns the conditioned default value of POINTER of MultiplexT.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexT, POINTER) returns the conditioned default value of POINTER of MultiplexT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexT.getPropProp(pointer);
			
			prop_default = MultiplexT.conditioning(prop, MultiplexT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexT, PROP, VALUE) checks VALUE format for PROP of MultiplexT.
			%  CHECK = M.CHECKPROP(MultiplexT, PROP, VALUE) checks VALUE format for PROP of MultiplexT.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexT.
			%   Error id: €BRAPH2.STR€:MultiplexT:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexT.
			%   Error id: €BRAPH2.STR€:MultiplexT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexT.getPropProp(pointer);
			
			switch prop
				case MultiplexT.TEMPLATE % __MultiplexT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexT.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexT.getPropTag(prop) ' (' MultiplexT.getFormatTag(MultiplexT.getPropFormat(prop)) ').'] ...
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
				case MultiplexT.M % __MultiplexT.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexT.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					N = g.get('NODENUMBER');
					
					if l == 0
					    value = {};
					else
					    multiplex_triangles = cell(length(ls), 1);
					    count = 1;
					    for p = 1:1:length(ls) % for each density
					        multiplex_triangles_partition = zeros(N(1), 1);
					         % loop thorugh pairs of layers
					        for i = count:1:ls(p) + count - 2
					            B11 = A{i, i};
					            for j = i+1:1:ls(p) + count - 1
					                B22 = A{j, j};
					                multiplex_triangles_partition = multiplex_triangles_partition + diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3));
					            end
					        end
					        count = count + ls(p);
					        multiplex_triangles(p) = {multiplex_triangles_partition};
					    end
					    value = multiplex_triangles;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
