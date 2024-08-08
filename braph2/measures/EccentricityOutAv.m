classdef EccentricityOutAv < EccentricityOut
	%EccentricityOutAv is the graph Average Out-Eccentricity.
	% It is a subclass of <a href="matlab:help EccentricityOut">EccentricityOut</a>.
	%
	% The Average Out-Eccentricity (EccentricityOutAv) of a node is the sum of the nodal 
	% out-eccentricities divided by their number within a layer.
	%
	% EccentricityOutAv methods (constructor):
	%  EccentricityOutAv - constructor
	%
	% EccentricityOutAv methods:
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
	% EccentricityOutAv methods (display):
	%  tostring - string with information about the average eccentricity
	%  disp - displays information about the average eccentricity
	%  tree - displays the tree of the average eccentricity
	%
	% EccentricityOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average eccentricity
	%
	% EccentricityOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average eccentricity as b2 file
	%  load - loads a BRAPH2 average eccentricity from a b2 file
	%
	% EccentricityOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average eccentricity
	%
	% EccentricityOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average eccentricity
	%
	% EccentricityOutAv methods (inspection, Static):
	%  getClass - returns the class of the average eccentricity
	%  getSubclasses - returns all subclasses of EccentricityOutAv
	%  getProps - returns the property list of the average eccentricity
	%  getPropNumber - returns the property number of the average eccentricity
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
	% EccentricityOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EccentricityOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EccentricityOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EccentricityOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EccentricityOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EccentricityOutAv constants</a>.
	%
	
	methods % constructor
		function m = EccentricityOutAv(varargin)
			%EccentricityOutAv() creates a average eccentricity.
			%
			% EccentricityOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EccentricityOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@EccentricityOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average eccentricity.
			%
			% CLASS = EccentricityOutAv.GETCLASS() returns the class 'EccentricityOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EccentricityOutAv') returns 'EccentricityOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EccentricityOutAv')
			%  are less computationally efficient.
			
			m_class = 'EccentricityOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average eccentricity.
			%
			% LIST = EccentricityOutAv.GETSUBCLASSES() returns all subclasses of 'EccentricityOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EccentricityOutAv') returns all subclasses of 'EccentricityOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EccentricityOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average eccentricity.
			%
			% PROPS = EccentricityOutAv.GETPROPS() returns the property list of average eccentricity
			%  as a row vector.
			%
			% PROPS = EccentricityOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EccentricityOutAv'[, CATEGORY]) returns the property list of 'EccentricityOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					EccentricityOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						EccentricityOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						EccentricityOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						EccentricityOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						EccentricityOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						EccentricityOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						EccentricityOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						EccentricityOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						EccentricityOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						EccentricityOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average eccentricity.
			%
			% N = EccentricityOutAv.GETPROPNUMBER() returns the property number of average eccentricity.
			%
			% N = EccentricityOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EccentricityOutAv') returns the property number of 'EccentricityOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EccentricityOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average eccentricity/error.
			%
			% CHECK = EccentricityOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EccentricityOutAv, PROP) checks whether PROP exists for EccentricityOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%  Element.EXISTSPROP(EccentricityOutAv, PROP) throws error if PROP does NOT exist for EccentricityOutAv.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EccentricityOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EccentricityOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average eccentricity/error.
			%
			% CHECK = EccentricityOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EccentricityOutAv, TAG) checks whether TAG exists for EccentricityOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%  Element.EXISTSTAG(EccentricityOutAv, TAG) throws error if TAG does NOT exist for EccentricityOutAv.
			%   Error id: [BRAPH2:EccentricityOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			eccentricityoutav_tag_list = cellfun(@(x) EccentricityOutAv.getPropTag(x), num2cell(EccentricityOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, eccentricityoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EccentricityOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EccentricityOutAv, POINTER) returns property number of POINTER of EccentricityOutAv.
			%  PROPERTY = M.GETPROPPROP(EccentricityOutAv, POINTER) returns property number of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				eccentricityoutav_tag_list = cellfun(@(x) EccentricityOutAv.getPropTag(x), num2cell(EccentricityOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, eccentricityoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EccentricityOutAv, POINTER) returns tag of POINTER of EccentricityOutAv.
			%  TAG = M.GETPROPTAG(EccentricityOutAv, POINTER) returns tag of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EccentricityOutAv')
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
						tag = getPropTag@EccentricityOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(EccentricityOutAv, POINTER) returns category of POINTER of EccentricityOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(EccentricityOutAv, POINTER) returns category of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@EccentricityOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(EccentricityOutAv, POINTER) returns format of POINTER of EccentricityOutAv.
			%  FORMAT = M.GETPROPFORMAT(EccentricityOutAv, POINTER) returns format of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@EccentricityOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EccentricityOutAv, POINTER) returns description of POINTER of EccentricityOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EccentricityOutAv, POINTER) returns description of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				case EccentricityOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Out-Eccentricity.';
				case EccentricityOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Out-Eccentricity.';
				case EccentricityOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Out-Eccentricity.';
				case EccentricityOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Out-Eccentricity.';
				case EccentricityOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Out-Eccentricity.';
				case EccentricityOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Out-Eccentricity.';
				case EccentricityOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Out-Eccentricity.';
				case EccentricityOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case EccentricityOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EccentricityOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EccentricityOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EccentricityOutAv.M
					prop_description = 'M (result, cell) is the Average Out-Eccentricity.';
				otherwise
					prop_description = getPropDescription@EccentricityOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(EccentricityOutAv, POINTER) returns settings of POINTER of EccentricityOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(EccentricityOutAv, POINTER) returns settings of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				case EccentricityOutAv.TEMPLATE
					prop_settings = 'EccentricityOutAv';
				otherwise
					prop_settings = getPropSettings@EccentricityOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EccentricityOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EccentricityOutAv, POINTER) returns the default value of POINTER of EccentricityOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(EccentricityOutAv, POINTER) returns the default value of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				case EccentricityOutAv.ELCLASS
					prop_default = 'EccentricityOutAv';
				case EccentricityOutAv.NAME
					prop_default = 'Average Out-Eccentricity';
				case EccentricityOutAv.DESCRIPTION
					prop_default = 'The Average Out-Eccentricity (EccentricityOutAv) of a node is the sum of the nodal out-eccentricities divided by their number within a layer.';
				case EccentricityOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EccentricityOutAv.getPropSettings(prop));
				case EccentricityOutAv.ID
					prop_default = 'EccentricityOutAv ID';
				case EccentricityOutAv.LABEL
					prop_default = 'Average Out-Eccentricity label';
				case EccentricityOutAv.NOTES
					prop_default = 'Average Out-Eccentricity notes';
				case EccentricityOutAv.SHAPE
					prop_default = Measure.GLOBAL;
				case EccentricityOutAv.SCOPE
					prop_default = Measure.UNILAYER;
				case EccentricityOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EccentricityOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD'};;
				otherwise
					prop_default = getPropDefault@EccentricityOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EccentricityOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EccentricityOutAv, POINTER) returns the conditioned default value of POINTER of EccentricityOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EccentricityOutAv, POINTER) returns the conditioned default value of POINTER of EccentricityOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			prop_default = EccentricityOutAv.conditioning(prop, EccentricityOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EccentricityOutAv, PROP, VALUE) checks VALUE format for PROP of EccentricityOutAv.
			%  CHECK = M.CHECKPROP(EccentricityOutAv, PROP, VALUE) checks VALUE format for PROP of EccentricityOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EccentricityOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EccentricityOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EccentricityOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityOutAv.
			%   Error id: €BRAPH2.STR€:EccentricityOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EccentricityOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityOutAv.
			%   Error id: €BRAPH2.STR€:EccentricityOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EccentricityOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EccentricityOutAv.getPropProp(pointer);
			
			switch prop
				case EccentricityOutAv.TEMPLATE % __EccentricityOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EccentricityOutAv.getPropSettings(prop));
				otherwise
					if prop <= EccentricityOut.getPropNumber()
						check = checkProp@EccentricityOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EccentricityOutAv.getPropTag(prop) ' (' EccentricityOutAv.getFormatTag(EccentricityOutAv.getPropFormat(prop)) ').'] ...
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
				case EccentricityOutAv.M % __EccentricityOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EccentricityOutAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					eccentricity = calculateValue@EccentricityOut(m, prop); 
					
					eccentricity_av = cell(L, 1);
					
					ls = g.get('PARTITIONS');
					
					if L == 0
					    value = {};
					    return ;
					end
					
					parfor li = 1:L
					    eccentricity_av(li) = {mean(eccentricity{li})};
					end
					
					
					value = eccentricity_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= EccentricityOut.getPropNumber()
						value = calculateValue@EccentricityOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
