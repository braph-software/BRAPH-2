classdef StrengthInAv < StrengthIn
	%StrengthInAv is the graph Average In-Strength.
	% It is a subclass of <a href="matlab:help StrengthIn">StrengthIn</a>.
	%
	% The Average In-Strength (StrengthIn) of a graph is the mean of the sum of all weights of the inward edges 
	% connected to a node within a layer, i.e., it is the sum of the columns of 
	% the adjacency matrix.
	%
	% StrengthInAv methods (constructor):
	%  StrengthInAv - constructor
	%
	% StrengthInAv methods:
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
	% StrengthInAv methods (display):
	%  tostring - string with information about the average in-strength
	%  disp - displays information about the average in-strength
	%  tree - displays the tree of the average in-strength
	%
	% StrengthInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average in-strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average in-strength
	%
	% StrengthInAv methods (save/load, Static):
	%  save - saves BRAPH2 average in-strength as b2 file
	%  load - loads a BRAPH2 average in-strength from a b2 file
	%
	% StrengthInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average in-strength
	%
	% StrengthInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average in-strength
	%
	% StrengthInAv methods (inspection, Static):
	%  getClass - returns the class of the average in-strength
	%  getSubclasses - returns all subclasses of StrengthInAv
	%  getProps - returns the property list of the average in-strength
	%  getPropNumber - returns the property number of the average in-strength
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
	% StrengthInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% StrengthInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% StrengthInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% StrengthInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?StrengthInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">StrengthInAv constants</a>.
	%
	
	methods % constructor
		function m = StrengthInAv(varargin)
			%StrengthInAv() creates a average in-strength.
			%
			% StrengthInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% StrengthInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@StrengthIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average in-strength.
			%
			% CLASS = StrengthInAv.GETCLASS() returns the class 'StrengthInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('StrengthInAv') returns 'StrengthInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('StrengthInAv')
			%  are less computationally efficient.
			
			m_class = 'StrengthInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average in-strength.
			%
			% LIST = StrengthInAv.GETSUBCLASSES() returns all subclasses of 'StrengthInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average in-strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('StrengthInAv') returns all subclasses of 'StrengthInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('StrengthInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-strength.
			%
			% PROPS = StrengthInAv.GETPROPS() returns the property list of average in-strength
			%  as a row vector.
			%
			% PROPS = StrengthInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('StrengthInAv'[, CATEGORY]) returns the property list of 'StrengthInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					StrengthIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						StrengthIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						StrengthIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						StrengthIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						StrengthIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						StrengthIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						StrengthIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						StrengthIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						StrengthIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						StrengthIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average in-strength.
			%
			% N = StrengthInAv.GETPROPNUMBER() returns the property number of average in-strength.
			%
			% N = StrengthInAv.GETPROPNUMBER(CATEGORY) returns the property number of average in-strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average in-strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('StrengthInAv') returns the property number of 'StrengthInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(StrengthInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average in-strength/error.
			%
			% CHECK = StrengthInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(StrengthInAv, PROP) checks whether PROP exists for StrengthInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:StrengthInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%  Element.EXISTSPROP(StrengthInAv, PROP) throws error if PROP does NOT exist for StrengthInAv.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == StrengthInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for StrengthInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-strength/error.
			%
			% CHECK = StrengthInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(StrengthInAv, TAG) checks whether TAG exists for StrengthInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:StrengthInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%  Element.EXISTSTAG(StrengthInAv, TAG) throws error if TAG does NOT exist for StrengthInAv.
			%   Error id: [BRAPH2:StrengthInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			strengthinav_tag_list = cellfun(@(x) StrengthInAv.getPropTag(x), num2cell(StrengthInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, strengthinav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for StrengthInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(StrengthInAv, POINTER) returns property number of POINTER of StrengthInAv.
			%  PROPERTY = M.GETPROPPROP(StrengthInAv, POINTER) returns property number of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				strengthinav_tag_list = cellfun(@(x) StrengthInAv.getPropTag(x), num2cell(StrengthInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, strengthinav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(StrengthInAv, POINTER) returns tag of POINTER of StrengthInAv.
			%  TAG = M.GETPROPTAG(StrengthInAv, POINTER) returns tag of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('StrengthInAv')
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
						tag = getPropTag@StrengthIn(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(StrengthInAv, POINTER) returns category of POINTER of StrengthInAv.
			%  CATEGORY = M.GETPROPCATEGORY(StrengthInAv, POINTER) returns category of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@StrengthIn(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(StrengthInAv, POINTER) returns format of POINTER of StrengthInAv.
			%  FORMAT = M.GETPROPFORMAT(StrengthInAv, POINTER) returns format of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@StrengthIn(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(StrengthInAv, POINTER) returns description of POINTER of StrengthInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(StrengthInAv, POINTER) returns description of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				case StrengthInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average In-Strength.';
				case StrengthInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average In-Strength.';
				case StrengthInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average In-Strength.';
				case StrengthInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average In-Strength.';
				case StrengthInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average In-Strength.';
				case StrengthInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average In-Strength.';
				case StrengthInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average In-Strength.';
				case StrengthInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case StrengthInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case StrengthInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case StrengthInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case StrengthInAv.M
					prop_description = 'M (result, cell) is the Average In-Strength.';
				otherwise
					prop_description = getPropDescription@StrengthIn(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(StrengthInAv, POINTER) returns settings of POINTER of StrengthInAv.
			%  SETTINGS = M.GETPROPSETTINGS(StrengthInAv, POINTER) returns settings of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				case StrengthInAv.TEMPLATE
					prop_settings = 'StrengthInAv';
				otherwise
					prop_settings = getPropSettings@StrengthIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = StrengthInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(StrengthInAv, POINTER) returns the default value of POINTER of StrengthInAv.
			%  DEFAULT = M.GETPROPDEFAULT(StrengthInAv, POINTER) returns the default value of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				case StrengthInAv.ELCLASS
					prop_default = 'StrengthInAv';
				case StrengthInAv.NAME
					prop_default = 'Average In-Strength';
				case StrengthInAv.DESCRIPTION
					prop_default = 'The Average In-Strength (StrengthIn) of a graph is the mean of the sum of all weights of the inward edges connected to a node within a layer, i.e., it is the sum of the columns of the adjacency matrix.';
				case StrengthInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, StrengthInAv.getPropSettings(prop));
				case StrengthInAv.ID
					prop_default = 'StrengthInAv ID';
				case StrengthInAv.LABEL
					prop_default = 'Average In-Strength label';
				case StrengthInAv.NOTES
					prop_default = 'Average In-Strength notes';
				case StrengthInAv.SHAPE
					prop_default = Measure.GLOBAL;
				case StrengthInAv.SCOPE
					prop_default = Measure.UNILAYER;
				case StrengthInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case StrengthInAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'MultiplexWD' 'OrdMxWD' 'MultilayerWD' 'OrdMlWD'};
				otherwise
					prop_default = getPropDefault@StrengthIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = StrengthInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(StrengthInAv, POINTER) returns the conditioned default value of POINTER of StrengthInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(StrengthInAv, POINTER) returns the conditioned default value of POINTER of StrengthInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			prop_default = StrengthInAv.conditioning(prop, StrengthInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(StrengthInAv, PROP, VALUE) checks VALUE format for PROP of StrengthInAv.
			%  CHECK = M.CHECKPROP(StrengthInAv, PROP, VALUE) checks VALUE format for PROP of StrengthInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:StrengthInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:StrengthInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(StrengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthInAv.
			%   Error id: €BRAPH2.STR€:StrengthInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(StrengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthInAv.
			%   Error id: €BRAPH2.STR€:StrengthInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				case StrengthInAv.TEMPLATE % __StrengthInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, StrengthInAv.getPropSettings(prop));
				otherwise
					if prop <= StrengthIn.getPropNumber()
						check = checkProp@StrengthIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' StrengthInAv.getPropTag(prop) ' (' StrengthInAv.getFormatTag(StrengthInAv.getPropFormat(prop)) ').'] ...
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
				case StrengthInAv.M % __StrengthInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(StrengthInAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					in_strength = calculateValue@StrengthIn(m, prop);
					L = g.get('LAYERNUMBER');
					
					in_strength_av = cell(L, 1);
					
					parfor li = 1:1:L
					    in_strength_av(li) = {mean(in_strength{li})};
					end
					
					value = in_strength_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= StrengthIn.getPropNumber()
						value = calculateValue@StrengthIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
