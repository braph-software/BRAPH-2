classdef StrengthOutAv < StrengthOut
	%StrengthOutAv is the graph Average Out-Strength.
	% It is a subclass of <a href="matlab:help StrengthOut">StrengthOut</a>.
	%
	% The Average Out-Strength (StrengthOutAv) of a graph is the mean of the sum of all weights of the outward edges 
	% connected to a node within a layer, i.e., it is the sum of the rows of 
	% the adjacency matrix.
	%
	% StrengthOutAv methods (constructor):
	%  StrengthOutAv - constructor
	%
	% StrengthOutAv methods:
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
	% StrengthOutAv methods (display):
	%  tostring - string with information about the average out-strength
	%  disp - displays information about the average out-strength
	%  tree - displays the tree of the average out-strength
	%
	% StrengthOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average out-strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average out-strength
	%
	% StrengthOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average out-strength as b2 file
	%  load - loads a BRAPH2 average out-strength from a b2 file
	%
	% StrengthOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average out-strength
	%
	% StrengthOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average out-strength
	%
	% StrengthOutAv methods (inspection, Static):
	%  getClass - returns the class of the average out-strength
	%  getSubclasses - returns all subclasses of StrengthOutAv
	%  getProps - returns the property list of the average out-strength
	%  getPropNumber - returns the property number of the average out-strength
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
	% StrengthOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% StrengthOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% StrengthOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% StrengthOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?StrengthOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">StrengthOutAv constants</a>.
	%
	
	methods % constructor
		function m = StrengthOutAv(varargin)
			%StrengthOutAv() creates a average out-strength.
			%
			% StrengthOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% StrengthOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@StrengthOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average out-strength.
			%
			% CLASS = StrengthOutAv.GETCLASS() returns the class 'StrengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('StrengthOutAv') returns 'StrengthOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('StrengthOutAv')
			%  are less computationally efficient.
			
			m_class = 'StrengthOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average out-strength.
			%
			% LIST = StrengthOutAv.GETSUBCLASSES() returns all subclasses of 'StrengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average out-strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('StrengthOutAv') returns all subclasses of 'StrengthOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('StrengthOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-strength.
			%
			% PROPS = StrengthOutAv.GETPROPS() returns the property list of average out-strength
			%  as a row vector.
			%
			% PROPS = StrengthOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('StrengthOutAv'[, CATEGORY]) returns the property list of 'StrengthOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					StrengthOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						StrengthOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						StrengthOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						StrengthOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						StrengthOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						StrengthOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						StrengthOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						StrengthOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						StrengthOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						StrengthOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average out-strength.
			%
			% N = StrengthOutAv.GETPROPNUMBER() returns the property number of average out-strength.
			%
			% N = StrengthOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average out-strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average out-strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('StrengthOutAv') returns the property number of 'StrengthOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(StrengthOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average out-strength/error.
			%
			% CHECK = StrengthOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(StrengthOutAv, PROP) checks whether PROP exists for StrengthOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%  Element.EXISTSPROP(StrengthOutAv, PROP) throws error if PROP does NOT exist for StrengthOutAv.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == StrengthOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for StrengthOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-strength/error.
			%
			% CHECK = StrengthOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(StrengthOutAv, TAG) checks whether TAG exists for StrengthOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%  Element.EXISTSTAG(StrengthOutAv, TAG) throws error if TAG does NOT exist for StrengthOutAv.
			%   Error id: [BRAPH2:StrengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			strengthoutav_tag_list = cellfun(@(x) StrengthOutAv.getPropTag(x), num2cell(StrengthOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, strengthoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for StrengthOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(StrengthOutAv, POINTER) returns property number of POINTER of StrengthOutAv.
			%  PROPERTY = M.GETPROPPROP(StrengthOutAv, POINTER) returns property number of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				strengthoutav_tag_list = cellfun(@(x) StrengthOutAv.getPropTag(x), num2cell(StrengthOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, strengthoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(StrengthOutAv, POINTER) returns tag of POINTER of StrengthOutAv.
			%  TAG = M.GETPROPTAG(StrengthOutAv, POINTER) returns tag of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('StrengthOutAv')
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
						tag = getPropTag@StrengthOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(StrengthOutAv, POINTER) returns category of POINTER of StrengthOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(StrengthOutAv, POINTER) returns category of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@StrengthOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(StrengthOutAv, POINTER) returns format of POINTER of StrengthOutAv.
			%  FORMAT = M.GETPROPFORMAT(StrengthOutAv, POINTER) returns format of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@StrengthOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(StrengthOutAv, POINTER) returns description of POINTER of StrengthOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(StrengthOutAv, POINTER) returns description of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				case StrengthOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Out-Strength.';
				case StrengthOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Out-Strength.';
				case StrengthOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Out-Strength.';
				case StrengthOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Out-Strength.';
				case StrengthOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Out-Strength.';
				case StrengthOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Out-Strength.';
				case StrengthOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Out-Strength.';
				case StrengthOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case StrengthOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case StrengthOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case StrengthOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case StrengthOutAv.M
					prop_description = 'M (result, cell) is the Average Out-Strength.';
				otherwise
					prop_description = getPropDescription@StrengthOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(StrengthOutAv, POINTER) returns settings of POINTER of StrengthOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(StrengthOutAv, POINTER) returns settings of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				case StrengthOutAv.TEMPLATE
					prop_settings = 'StrengthOutAv';
				otherwise
					prop_settings = getPropSettings@StrengthOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = StrengthOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(StrengthOutAv, POINTER) returns the default value of POINTER of StrengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(StrengthOutAv, POINTER) returns the default value of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				case StrengthOutAv.ELCLASS
					prop_default = 'StrengthOutAv';
				case StrengthOutAv.NAME
					prop_default = 'Average Out-Strength';
				case StrengthOutAv.DESCRIPTION
					prop_default = 'The Average Out-Strength (StrengthOutAv) of a graph is the mean of the sum of all weights of the outward edges connected to a node within a layer, i.e., it is the sum of the rows of the adjacency matrix.';
				case StrengthOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, StrengthOutAv.getPropSettings(prop));
				case StrengthOutAv.ID
					prop_default = 'StrengthOutAv ID';
				case StrengthOutAv.LABEL
					prop_default = 'Average Out-Strength label';
				case StrengthOutAv.NOTES
					prop_default = 'Average Out-Strength notes';
				case StrengthOutAv.SHAPE
					prop_default = Measure.GLOBAL;
				case StrengthOutAv.SCOPE
					prop_default = Measure.UNILAYER;
				case StrengthOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case StrengthOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'MultiplexWD' 'OrdMxWD' 'MultilayerWD' 'OrdMlWD'};
				otherwise
					prop_default = getPropDefault@StrengthOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = StrengthOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(StrengthOutAv, POINTER) returns the conditioned default value of POINTER of StrengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(StrengthOutAv, POINTER) returns the conditioned default value of POINTER of StrengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			prop_default = StrengthOutAv.conditioning(prop, StrengthOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(StrengthOutAv, PROP, VALUE) checks VALUE format for PROP of StrengthOutAv.
			%  CHECK = M.CHECKPROP(StrengthOutAv, PROP, VALUE) checks VALUE format for PROP of StrengthOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:StrengthOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:StrengthOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(StrengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthOutAv.
			%   Error id: €BRAPH2.STR€:StrengthOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(StrengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthOutAv.
			%   Error id: €BRAPH2.STR€:StrengthOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('StrengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = StrengthOutAv.getPropProp(pointer);
			
			switch prop
				case StrengthOutAv.TEMPLATE % __StrengthOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, StrengthOutAv.getPropSettings(prop));
				otherwise
					if prop <= StrengthOut.getPropNumber()
						check = checkProp@StrengthOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':StrengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' StrengthOutAv.getPropTag(prop) ' (' StrengthOutAv.getFormatTag(StrengthOutAv.getPropFormat(prop)) ').'] ...
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
				case StrengthOutAv.M % __StrengthOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(StrengthOutAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					out_strength = calculateValue@StrengthOut(m, prop);
					L = g.get('LAYERNUMBER');
					
					out_strength_av = cell(L, 1);
					
					parfor li = 1:1:L
					    out_strength_av(li) = {mean(out_strength{li})};
					end
					
					value = out_strength_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= StrengthOut.getPropNumber()
						value = calculateValue@StrengthOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
