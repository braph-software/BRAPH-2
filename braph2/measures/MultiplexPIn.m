classdef MultiplexPIn < Measure
	%MultiplexPIn is the graph Multiplex In-Participation.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multiplex In-Participation (MultiplexPIn) is the homogeneity of the number of inward 
	% neighbors of a node across the layers.
	%
	% MultiplexPIn methods (constructor):
	%  MultiplexPIn - constructor
	%
	% MultiplexPIn methods:
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
	% MultiplexPIn methods (display):
	%  tostring - string with information about the multiplex in-participation
	%  disp - displays information about the multiplex in-participation
	%  tree - displays the tree of the multiplex in-participation
	%
	% MultiplexPIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex in-participation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex in-participation
	%
	% MultiplexPIn methods (save/load, Static):
	%  save - saves BRAPH2 multiplex in-participation as b2 file
	%  load - loads a BRAPH2 multiplex in-participation from a b2 file
	%
	% MultiplexPIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex in-participation
	%
	% MultiplexPIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex in-participation
	%
	% MultiplexPIn methods (inspection, Static):
	%  getClass - returns the class of the multiplex in-participation
	%  getSubclasses - returns all subclasses of MultiplexPIn
	%  getProps - returns the property list of the multiplex in-participation
	%  getPropNumber - returns the property number of the multiplex in-participation
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
	% MultiplexPIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexPIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexPIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexPIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexPIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexPIn constants</a>.
	%
	
	methods % constructor
		function m = MultiplexPIn(varargin)
			%MultiplexPIn() creates a multiplex in-participation.
			%
			% MultiplexPIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexPIn(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multiplex in-participation.
			%
			% CLASS = MultiplexPIn.GETCLASS() returns the class 'MultiplexPIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex in-participation M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexPIn') returns 'MultiplexPIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexPIn')
			%  are less computationally efficient.
			
			m_class = 'MultiplexPIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex in-participation.
			%
			% LIST = MultiplexPIn.GETSUBCLASSES() returns all subclasses of 'MultiplexPIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex in-participation M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexPIn') returns all subclasses of 'MultiplexPIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexPIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex in-participation.
			%
			% PROPS = MultiplexPIn.GETPROPS() returns the property list of multiplex in-participation
			%  as a row vector.
			%
			% PROPS = MultiplexPIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex in-participation M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexPIn'[, CATEGORY]) returns the property list of 'MultiplexPIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexPIn')
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
			%GETPROPNUMBER returns the property number of multiplex in-participation.
			%
			% N = MultiplexPIn.GETPROPNUMBER() returns the property number of multiplex in-participation.
			%
			% N = MultiplexPIn.GETPROPNUMBER(CATEGORY) returns the property number of multiplex in-participation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex in-participation M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexPIn') returns the property number of 'MultiplexPIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexPIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex in-participation/error.
			%
			% CHECK = MultiplexPIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexPIn, PROP) checks whether PROP exists for MultiplexPIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%  Element.EXISTSPROP(MultiplexPIn, PROP) throws error if PROP does NOT exist for MultiplexPIn.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexPIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexPIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex in-participation/error.
			%
			% CHECK = MultiplexPIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexPIn, TAG) checks whether TAG exists for MultiplexPIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%  Element.EXISTSTAG(MultiplexPIn, TAG) throws error if TAG does NOT exist for MultiplexPIn.
			%   Error id: [BRAPH2:MultiplexPIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexpin_tag_list = cellfun(@(x) MultiplexPIn.getPropTag(x), num2cell(MultiplexPIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexpin_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexPIn.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexPIn, POINTER) returns property number of POINTER of MultiplexPIn.
			%  PROPERTY = M.GETPROPPROP(MultiplexPIn, POINTER) returns property number of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexpin_tag_list = cellfun(@(x) MultiplexPIn.getPropTag(x), num2cell(MultiplexPIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexpin_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexPIn, POINTER) returns tag of POINTER of MultiplexPIn.
			%  TAG = M.GETPROPTAG(MultiplexPIn, POINTER) returns tag of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexPIn')
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexPIn, POINTER) returns category of POINTER of MultiplexPIn.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexPIn, POINTER) returns category of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexPIn, POINTER) returns format of POINTER of MultiplexPIn.
			%  FORMAT = M.GETPROPFORMAT(MultiplexPIn, POINTER) returns format of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexPIn, POINTER) returns description of POINTER of MultiplexPIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexPIn, POINTER) returns description of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
			switch prop
				case MultiplexPIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex In-Participation.';
				case MultiplexPIn.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex In-Participation.';
				case MultiplexPIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex In-Participation.';
				case MultiplexPIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex In-Participation.';
				case MultiplexPIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex In-Participation.';
				case MultiplexPIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex In-Participation.';
				case MultiplexPIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex In-Participation.';
				case MultiplexPIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexPIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexPIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexPIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexPIn.M
					prop_description = 'M (result, cell) is the Multiplex In-Participation.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexPIn, POINTER) returns settings of POINTER of MultiplexPIn.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexPIn, POINTER) returns settings of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
			switch prop
				case MultiplexPIn.TEMPLATE
					prop_settings = 'MultiplexPIn';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexPIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexPIn, POINTER) returns the default value of POINTER of MultiplexPIn.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexPIn, POINTER) returns the default value of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
			switch prop
				case MultiplexPIn.ELCLASS
					prop_default = 'MultiplexPIn';
				case MultiplexPIn.NAME
					prop_default = 'Multiplex In-Participation';
				case MultiplexPIn.DESCRIPTION
					prop_default = 'The Multiplex In-Participation (MultiplexPIn) is the homogeneity of the number of inward neighbors of a node across the layers.';
				case MultiplexPIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexPIn.getPropSettings(prop));
				case MultiplexPIn.ID
					prop_default = 'MultiplexPIn ID';
				case MultiplexPIn.LABEL
					prop_default = 'Multiplex In-Participation label';
				case MultiplexPIn.NOTES
					prop_default = 'Multiplex In-Participation notes';
				case MultiplexPIn.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexPIn.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexPIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexPIn.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexBD' 'MultiplexWD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexPIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexPIn, POINTER) returns the conditioned default value of POINTER of MultiplexPIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexPIn, POINTER) returns the conditioned default value of POINTER of MultiplexPIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
			prop_default = MultiplexPIn.conditioning(prop, MultiplexPIn.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexPIn, PROP, VALUE) checks VALUE format for PROP of MultiplexPIn.
			%  CHECK = M.CHECKPROP(MultiplexPIn, PROP, VALUE) checks VALUE format for PROP of MultiplexPIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexPIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexPIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexPIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPIn.
			%   Error id: €BRAPH2.STR€:MultiplexPIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexPIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPIn.
			%   Error id: €BRAPH2.STR€:MultiplexPIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexPIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexPIn.getPropProp(pointer);
			
			switch prop
				case MultiplexPIn.TEMPLATE % __MultiplexPIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexPIn.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexPIn.getPropTag(prop) ' (' MultiplexPIn.getFormatTag(MultiplexPIn.getPropFormat(prop)) ').'] ...
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
				case MultiplexPIn.M % __MultiplexPIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexPIn.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					if L == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    in_degree = DegreeIn('G', g).get('M');
					    overlapping_in_degree = OverlappingDegIn('G', g).get('M');  
					    multiplex_in_participation =  zeros(N(1), 1);
					    for li = 1:1:L
					        multiplex_in_participation = multiplex_in_participation + (in_degree{li}./overlapping_in_degree{1}).^2;
					    end
					    multiplex_in_participation = L / (L - 1) * (1 - multiplex_in_participation);
					    multiplex_in_participation(isnan(multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
					    value = {multiplex_in_participation};
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
