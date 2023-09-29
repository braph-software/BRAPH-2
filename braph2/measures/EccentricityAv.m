classdef EccentricityAv < Eccentricity
	%EccentricityAv is the graph Average Eccentricity.
	% It is a subclass of <a href="matlab:help Eccentricity">Eccentricity</a>.
	%
	% The Average Eccentricity (EccentricityAv) of a graph is the sum of the nodal eccentricities divided by their number within a layer.
	%
	% EccentricityAv methods (constructor):
	%  EccentricityAv - constructor
	%
	% EccentricityAv methods:
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
	% EccentricityAv methods (display):
	%  tostring - string with information about the average eccentricity
	%  disp - displays information about the average eccentricity
	%  tree - displays the tree of the average eccentricity
	%
	% EccentricityAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average eccentricity
	%
	% EccentricityAv methods (save/load, Static):
	%  save - saves BRAPH2 average eccentricity as b2 file
	%  load - loads a BRAPH2 average eccentricity from a b2 file
	%
	% EccentricityAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average eccentricity
	%
	% EccentricityAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average eccentricity
	%
	% EccentricityAv methods (inspection, Static):
	%  getClass - returns the class of the average eccentricity
	%  getSubclasses - returns all subclasses of EccentricityAv
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
	% EccentricityAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EccentricityAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EccentricityAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EccentricityAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EccentricityAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EccentricityAv constants</a>.
	%
	
	methods % constructor
		function m = EccentricityAv(varargin)
			%EccentricityAv() creates a average eccentricity.
			%
			% EccentricityAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EccentricityAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Eccentricity(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average eccentricity.
			%
			% CLASS = EccentricityAv.GETCLASS() returns the class 'EccentricityAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EccentricityAv') returns 'EccentricityAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EccentricityAv')
			%  are less computationally efficient.
			
			m_class = 'EccentricityAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average eccentricity.
			%
			% LIST = EccentricityAv.GETSUBCLASSES() returns all subclasses of 'EccentricityAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EccentricityAv') returns all subclasses of 'EccentricityAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EccentricityAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average eccentricity.
			%
			% PROPS = EccentricityAv.GETPROPS() returns the property list of average eccentricity
			%  as a row vector.
			%
			% PROPS = EccentricityAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EccentricityAv'[, CATEGORY]) returns the property list of 'EccentricityAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Eccentricity.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Eccentricity.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Eccentricity.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Eccentricity.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Eccentricity.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Eccentricity.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Eccentricity.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Eccentricity.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Eccentricity.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Eccentricity.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average eccentricity.
			%
			% N = EccentricityAv.GETPROPNUMBER() returns the property number of average eccentricity.
			%
			% N = EccentricityAv.GETPROPNUMBER(CATEGORY) returns the property number of average eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EccentricityAv') returns the property number of 'EccentricityAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EccentricityAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average eccentricity/error.
			%
			% CHECK = EccentricityAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EccentricityAv, PROP) checks whether PROP exists for EccentricityAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EccentricityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%  Element.EXISTSPROP(EccentricityAv, PROP) throws error if PROP does NOT exist for EccentricityAv.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EccentricityAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EccentricityAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average eccentricity/error.
			%
			% CHECK = EccentricityAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EccentricityAv, TAG) checks whether TAG exists for EccentricityAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EccentricityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%  Element.EXISTSTAG(EccentricityAv, TAG) throws error if TAG does NOT exist for EccentricityAv.
			%   Error id: [BRAPH2:EccentricityAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			eccentricityav_tag_list = cellfun(@(x) EccentricityAv.getPropTag(x), num2cell(EccentricityAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, eccentricityav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EccentricityAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EccentricityAv, POINTER) returns property number of POINTER of EccentricityAv.
			%  PROPERTY = M.GETPROPPROP(EccentricityAv, POINTER) returns property number of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				eccentricityav_tag_list = cellfun(@(x) EccentricityAv.getPropTag(x), num2cell(EccentricityAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, eccentricityav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EccentricityAv, POINTER) returns tag of POINTER of EccentricityAv.
			%  TAG = M.GETPROPTAG(EccentricityAv, POINTER) returns tag of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EccentricityAv')
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
						tag = getPropTag@Eccentricity(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(EccentricityAv, POINTER) returns category of POINTER of EccentricityAv.
			%  CATEGORY = M.GETPROPCATEGORY(EccentricityAv, POINTER) returns category of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Eccentricity(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(EccentricityAv, POINTER) returns format of POINTER of EccentricityAv.
			%  FORMAT = M.GETPROPFORMAT(EccentricityAv, POINTER) returns format of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Eccentricity(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EccentricityAv, POINTER) returns description of POINTER of EccentricityAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EccentricityAv, POINTER) returns description of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				case EccentricityAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Eccentricity.';
				case EccentricityAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Eccentricity.';
				case EccentricityAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Eccentricity.';
				case EccentricityAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Eccentricity.';
				case EccentricityAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Eccentricity.';
				case EccentricityAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Eccentricity.';
				case EccentricityAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Eccentricity.';
				case EccentricityAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case EccentricityAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EccentricityAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EccentricityAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EccentricityAv.M
					prop_description = 'M (result, cell) is the Average Eccentricity.';
				otherwise
					prop_description = getPropDescription@Eccentricity(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(EccentricityAv, POINTER) returns settings of POINTER of EccentricityAv.
			%  SETTINGS = M.GETPROPSETTINGS(EccentricityAv, POINTER) returns settings of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				case EccentricityAv.TEMPLATE
					prop_settings = 'EccentricityAv';
				otherwise
					prop_settings = getPropSettings@Eccentricity(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EccentricityAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EccentricityAv, POINTER) returns the default value of POINTER of EccentricityAv.
			%  DEFAULT = M.GETPROPDEFAULT(EccentricityAv, POINTER) returns the default value of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				case EccentricityAv.ELCLASS
					prop_default = 'EccentricityAv';
				case EccentricityAv.NAME
					prop_default = 'Average Eccentricity';
				case EccentricityAv.DESCRIPTION
					prop_default = 'The Average Eccentricity (EccentricityAv) of a graph is the sum of the nodal eccentricities divided by their number within a layer.';
				case EccentricityAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EccentricityAv.getPropSettings(prop));
				case EccentricityAv.ID
					prop_default = 'EccentricityAv ID';
				case EccentricityAv.LABEL
					prop_default = 'Average Eccentricity label';
				case EccentricityAv.NOTES
					prop_default = 'Average Eccentricity notes';
				case EccentricityAv.SHAPE
					prop_default = Measure.GLOBAL;
				case EccentricityAv.SCOPE
					prop_default = Measure.UNILAYER;
				case EccentricityAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EccentricityAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Eccentricity(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EccentricityAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EccentricityAv, POINTER) returns the conditioned default value of POINTER of EccentricityAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EccentricityAv, POINTER) returns the conditioned default value of POINTER of EccentricityAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			prop_default = EccentricityAv.conditioning(prop, EccentricityAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EccentricityAv, PROP, VALUE) checks VALUE format for PROP of EccentricityAv.
			%  CHECK = M.CHECKPROP(EccentricityAv, PROP, VALUE) checks VALUE format for PROP of EccentricityAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EccentricityAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EccentricityAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EccentricityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityAv.
			%   Error id: €BRAPH2.STR€:EccentricityAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EccentricityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityAv.
			%   Error id: €BRAPH2.STR€:EccentricityAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EccentricityAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EccentricityAv.getPropProp(pointer);
			
			switch prop
				case EccentricityAv.TEMPLATE % __EccentricityAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EccentricityAv.getPropSettings(prop));
				otherwise
					if prop <= Eccentricity.getPropNumber()
						check = checkProp@Eccentricity(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EccentricityAv.getPropTag(prop) ' (' EccentricityAv.getFormatTag(EccentricityAv.getPropFormat(prop)) ').'] ...
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
				case EccentricityAv.M % __EccentricityAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EccentricityAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					eccentricity = calculateValue@Eccentricity(m, prop); 
					
					eccentricity_av = cell(L, 1);
					
					parfor li = 1:L
					    eccentricity_av(li) = {mean(eccentricity{li})};
					end
					
					value = eccentricity_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Eccentricity.getPropNumber()
						value = calculateValue@Eccentricity(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
