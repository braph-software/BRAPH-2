classdef MultiplexPAv < MultiplexP
	%MultiplexPAv is the graph Average Multiplex Participation.
	% It is a subclass of <a href="matlab:help MultiplexP">MultiplexP</a>.
	%
	% The Average Multiplex Participation (MultiplexPAv) of a graph is the average homogeneity 
	%    of its number of neighbors across the layers.
	%
	% MultiplexPAv methods (constructor):
	%  MultiplexPAv - constructor
	%
	% MultiplexPAv methods:
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
	% MultiplexPAv methods (display):
	%  tostring - string with information about the average multiplex participation
	%  disp - displays information about the average multiplex participation
	%  tree - displays the tree of the average multiplex participation
	%
	% MultiplexPAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average multiplex participation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average multiplex participation
	%
	% MultiplexPAv methods (save/load, Static):
	%  save - saves BRAPH2 average multiplex participation as b2 file
	%  load - loads a BRAPH2 average multiplex participation from a b2 file
	%
	% MultiplexPAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average multiplex participation
	%
	% MultiplexPAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average multiplex participation
	%
	% MultiplexPAv methods (inspection, Static):
	%  getClass - returns the class of the average multiplex participation
	%  getSubclasses - returns all subclasses of MultiplexPAv
	%  getProps - returns the property list of the average multiplex participation
	%  getPropNumber - returns the property number of the average multiplex participation
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
	% MultiplexPAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexPAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexPAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexPAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexPAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexPAv constants</a>.
	%
	
	methods % constructor
		function m = MultiplexPAv(varargin)
			%MultiplexPAv() creates a average multiplex participation.
			%
			% MultiplexPAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexPAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@MultiplexP(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average multiplex participation.
			%
			% CLASS = MultiplexPAv.GETCLASS() returns the class 'MultiplexPAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average multiplex participation M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexPAv') returns 'MultiplexPAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexPAv')
			%  are less computationally efficient.
			
			m_class = 'MultiplexPAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average multiplex participation.
			%
			% LIST = MultiplexPAv.GETSUBCLASSES() returns all subclasses of 'MultiplexPAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average multiplex participation M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexPAv') returns all subclasses of 'MultiplexPAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexPAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average multiplex participation.
			%
			% PROPS = MultiplexPAv.GETPROPS() returns the property list of average multiplex participation
			%  as a row vector.
			%
			% PROPS = MultiplexPAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average multiplex participation M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexPAv'[, CATEGORY]) returns the property list of 'MultiplexPAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultiplexP.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultiplexP.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultiplexP.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultiplexP.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MultiplexP.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultiplexP.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultiplexP.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultiplexP.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultiplexP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultiplexP.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average multiplex participation.
			%
			% N = MultiplexPAv.GETPROPNUMBER() returns the property number of average multiplex participation.
			%
			% N = MultiplexPAv.GETPROPNUMBER(CATEGORY) returns the property number of average multiplex participation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average multiplex participation M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexPAv') returns the property number of 'MultiplexPAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexPAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average multiplex participation/error.
			%
			% CHECK = MultiplexPAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexPAv, PROP) checks whether PROP exists for MultiplexPAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%  Element.EXISTSPROP(MultiplexPAv, PROP) throws error if PROP does NOT exist for MultiplexPAv.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexPAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexPAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average multiplex participation/error.
			%
			% CHECK = MultiplexPAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexPAv, TAG) checks whether TAG exists for MultiplexPAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%  Element.EXISTSTAG(MultiplexPAv, TAG) throws error if TAG does NOT exist for MultiplexPAv.
			%   Error id: [BRAPH2:MultiplexPAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexpav_tag_list = cellfun(@(x) MultiplexPAv.getPropTag(x), num2cell(MultiplexPAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexpav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexPAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexPAv, POINTER) returns property number of POINTER of MultiplexPAv.
			%  PROPERTY = M.GETPROPPROP(MultiplexPAv, POINTER) returns property number of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexpav_tag_list = cellfun(@(x) MultiplexPAv.getPropTag(x), num2cell(MultiplexPAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexpav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexPAv, POINTER) returns tag of POINTER of MultiplexPAv.
			%  TAG = M.GETPROPTAG(MultiplexPAv, POINTER) returns tag of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexPAv')
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
						tag = getPropTag@MultiplexP(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexPAv, POINTER) returns category of POINTER of MultiplexPAv.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexPAv, POINTER) returns category of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MultiplexP(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexPAv, POINTER) returns format of POINTER of MultiplexPAv.
			%  FORMAT = M.GETPROPFORMAT(MultiplexPAv, POINTER) returns format of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MultiplexP(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexPAv, POINTER) returns description of POINTER of MultiplexPAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexPAv, POINTER) returns description of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				case MultiplexPAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Multiplex Participation.';
				case MultiplexPAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Multiplex Participation.';
				case MultiplexPAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Multiplex Participation.';
				case MultiplexPAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Multiplex Participation.';
				case MultiplexPAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Multiplex Participation.';
				case MultiplexPAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Multiplex Participation.';
				case MultiplexPAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Multiplex Participation.';
				case MultiplexPAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexPAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexPAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexPAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexPAv.M
					prop_description = 'M (result, cell) is the Average Multiplex Participation.';
				otherwise
					prop_description = getPropDescription@MultiplexP(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexPAv, POINTER) returns settings of POINTER of MultiplexPAv.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexPAv, POINTER) returns settings of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				case MultiplexPAv.TEMPLATE
					prop_settings = 'MultiplexPAv';
				otherwise
					prop_settings = getPropSettings@MultiplexP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexPAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexPAv, POINTER) returns the default value of POINTER of MultiplexPAv.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexPAv, POINTER) returns the default value of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				case MultiplexPAv.ELCLASS
					prop_default = 'MultiplexPAv';
				case MultiplexPAv.NAME
					prop_default = 'Average Multiplex Participation';
				case MultiplexPAv.DESCRIPTION
					prop_default = 'The Average Multiplex Participation (MultiplexPAv) of a graph is the average homogeneity of its number of neighbors across the layers.';
				case MultiplexPAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexPAv.getPropSettings(prop));
				case MultiplexPAv.ID
					prop_default = 'MultiplexPAv ID';
				case MultiplexPAv.LABEL
					prop_default = 'Average Multiplex Participation label';
				case MultiplexPAv.NOTES
					prop_default = 'Average Multiplex Participation notes';
				case MultiplexPAv.SHAPE
					prop_default = Measure.GLOBAL;
				case MultiplexPAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexPAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexPAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@MultiplexP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexPAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexPAv, POINTER) returns the conditioned default value of POINTER of MultiplexPAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexPAv, POINTER) returns the conditioned default value of POINTER of MultiplexPAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			prop_default = MultiplexPAv.conditioning(prop, MultiplexPAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexPAv, PROP, VALUE) checks VALUE format for PROP of MultiplexPAv.
			%  CHECK = M.CHECKPROP(MultiplexPAv, PROP, VALUE) checks VALUE format for PROP of MultiplexPAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexPAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexPAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexPAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPAv.
			%   Error id: €BRAPH2.STR€:MultiplexPAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexPAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPAv.
			%   Error id: €BRAPH2.STR€:MultiplexPAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexPAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexPAv.getPropProp(pointer);
			
			switch prop
				case MultiplexPAv.TEMPLATE % __MultiplexPAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexPAv.getPropSettings(prop));
				otherwise
					if prop <= MultiplexP.getPropNumber()
						check = checkProp@MultiplexP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexPAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexPAv.getPropTag(prop) ' (' MultiplexPAv.getFormatTag(MultiplexPAv.getPropFormat(prop)) ').'] ...
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
				case MultiplexPAv.M % __MultiplexPAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexPAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    multiplex_participation = calculateValue@MultiplexP(m, prop);
					    multiplex_participation_av = cell(length(ls), 1);
					
					    for i=1:length(ls)
					        multiplex_participation_av(i) = {mean(multiplex_participation{i})};
					    end
					    value = multiplex_participation_av;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= MultiplexP.getPropNumber()
						value = calculateValue@MultiplexP(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
