classdef RCDeg < Degree
	%RCDeg is the graph Rich-Club Degree.
	% It is a subclass of <a href="matlab:help Degree">Degree</a>.
	%
	% The Rich-Club Degree (RCDeg) of a node at level k is the sum of 
	%  the edges that connect nodes of degree k or higher within a layer. 
	%  k is set by the user; the default value is equal to 1.
	%
	% RCDeg methods (constructor):
	%  RCDeg - constructor
	%
	% RCDeg methods:
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
	% RCDeg methods (display):
	%  tostring - string with information about the rich-club degree
	%  disp - displays information about the rich-club degree
	%  tree - displays the tree of the rich-club degree
	%
	% RCDeg methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two rich-club degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the rich-club degree
	%
	% RCDeg methods (save/load, Static):
	%  save - saves BRAPH2 rich-club degree as b2 file
	%  load - loads a BRAPH2 rich-club degree from a b2 file
	%
	% RCDeg method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the rich-club degree
	%
	% RCDeg method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the rich-club degree
	%
	% RCDeg methods (inspection, Static):
	%  getClass - returns the class of the rich-club degree
	%  getSubclasses - returns all subclasses of RCDeg
	%  getProps - returns the property list of the rich-club degree
	%  getPropNumber - returns the property number of the rich-club degree
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
	% RCDeg methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% RCDeg methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% RCDeg methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% RCDeg methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?RCDeg; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">RCDeg constants</a>.
	%
	
	properties (Constant) % properties
		PARAMETRIC_VALUE = Degree.getPropNumber() + 1;
		PARAMETRIC_VALUE_TAG = 'PARAMETRIC_VALUE';
		PARAMETRIC_VALUE_CATEGORY = Category.PARAMETER;
		PARAMETRIC_VALUE_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function m = RCDeg(varargin)
			%RCDeg() creates a rich-club degree.
			%
			% RCDeg(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RCDeg(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Degree(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the rich-club degree.
			%
			% CLASS = RCDeg.GETCLASS() returns the class 'RCDeg'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the rich-club degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('RCDeg') returns 'RCDeg'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('RCDeg')
			%  are less computationally efficient.
			
			m_class = 'RCDeg';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the rich-club degree.
			%
			% LIST = RCDeg.GETSUBCLASSES() returns all subclasses of 'RCDeg'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the rich-club degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('RCDeg') returns all subclasses of 'RCDeg'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('RCDeg')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('RCDeg', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of rich-club degree.
			%
			% PROPS = RCDeg.GETPROPS() returns the property list of rich-club degree
			%  as a row vector.
			%
			% PROPS = RCDeg.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the rich-club degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('RCDeg'[, CATEGORY]) returns the property list of 'RCDeg'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Degree.getProps() ...
						RCDeg.PARAMETRIC_VALUE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Degree.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Degree.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Degree.getProps(Category.PARAMETER) ...
						RCDeg.PARAMETRIC_VALUE ...
						];
				case Category.DATA
					prop_list = [ ...
						Degree.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Degree.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Degree.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Degree.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Degree.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Degree.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of rich-club degree.
			%
			% N = RCDeg.GETPROPNUMBER() returns the property number of rich-club degree.
			%
			% N = RCDeg.GETPROPNUMBER(CATEGORY) returns the property number of rich-club degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the rich-club degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('RCDeg') returns the property number of 'RCDeg'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('RCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(RCDeg.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in rich-club degree/error.
			%
			% CHECK = RCDeg.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(RCDeg, PROP) checks whether PROP exists for RCDeg.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:RCDeg:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%  Element.EXISTSPROP(RCDeg, PROP) throws error if PROP does NOT exist for RCDeg.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('RCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == RCDeg.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RCDeg.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in rich-club degree/error.
			%
			% CHECK = RCDeg.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(RCDeg, TAG) checks whether TAG exists for RCDeg.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:RCDeg:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%  Element.EXISTSTAG(RCDeg, TAG) throws error if TAG does NOT exist for RCDeg.
			%   Error id: [BRAPH2:RCDeg:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('RCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			rcdeg_tag_list = cellfun(@(x) RCDeg.getPropTag(x), num2cell(RCDeg.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, rcdeg_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for RCDeg.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(RCDeg, POINTER) returns property number of POINTER of RCDeg.
			%  PROPERTY = M.GETPROPPROP(RCDeg, POINTER) returns property number of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				rcdeg_tag_list = cellfun(@(x) RCDeg.getPropTag(x), num2cell(RCDeg.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, rcdeg_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(RCDeg, POINTER) returns tag of POINTER of RCDeg.
			%  TAG = M.GETPROPTAG(RCDeg, POINTER) returns tag of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case RCDeg.PARAMETRIC_VALUE
						tag = RCDeg.PARAMETRIC_VALUE_TAG;
					otherwise
						tag = getPropTag@Degree(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(RCDeg, POINTER) returns category of POINTER of RCDeg.
			%  CATEGORY = M.GETPROPCATEGORY(RCDeg, POINTER) returns category of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('RCDeg')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE
					prop_category = RCDeg.PARAMETRIC_VALUE_CATEGORY;
				otherwise
					prop_category = getPropCategory@Degree(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(RCDeg, POINTER) returns format of POINTER of RCDeg.
			%  FORMAT = M.GETPROPFORMAT(RCDeg, POINTER) returns format of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('RCDeg')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE
					prop_format = RCDeg.PARAMETRIC_VALUE_FORMAT;
				otherwise
					prop_format = getPropFormat@Degree(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(RCDeg, POINTER) returns description of POINTER of RCDeg.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(RCDeg, POINTER) returns description of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE
					prop_description = 'PARAMETRIC_VALUE (parameter, SCALAR) ';
				case RCDeg.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Rich-Club Degree.';
				case RCDeg.NAME
					prop_description = 'NAME (constant, string) is the name of the Rich-Club Degree.';
				case RCDeg.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Rich-Club Degree.';
				case RCDeg.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Rich-Club Degree.';
				case RCDeg.ID
					prop_description = 'ID (data, string) is a few-letter code of the Rich-Club Degree.';
				case RCDeg.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Rich-Club Degree.';
				case RCDeg.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Rich-Club Degree.';
				case RCDeg.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case RCDeg.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case RCDeg.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.PARAMETRIC__.';
				case RCDeg.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case RCDeg.M
					prop_description = 'M (result, cell) is the Rich-Club Degree.';
				otherwise
					prop_description = getPropDescription@Degree(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(RCDeg, POINTER) returns settings of POINTER of RCDeg.
			%  SETTINGS = M.GETPROPSETTINGS(RCDeg, POINTER) returns settings of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case RCDeg.TEMPLATE
					prop_settings = 'RCDeg';
				otherwise
					prop_settings = getPropSettings@Degree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = RCDeg.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = RCDeg.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(RCDeg, POINTER) returns the default value of POINTER of RCDeg.
			%  DEFAULT = M.GETPROPDEFAULT(RCDeg, POINTER) returns the default value of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('RCDeg')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE
					prop_default = 1;
				case RCDeg.ELCLASS
					prop_default = 'RCDeg';
				case RCDeg.NAME
					prop_default = 'Rich-Club Degree';
				case RCDeg.DESCRIPTION
					prop_default = 'The Rich-Club Degree (RCDeg) of a node at level k is the sum of the edges that connect nodes of degree k or higher within a layer. k is set by the user; the default value is equal to 1.';
				case RCDeg.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, RCDeg.getPropSettings(prop));
				case RCDeg.ID
					prop_default = 'RCDeg ID';
				case RCDeg.LABEL
					prop_default = 'Rich-Club Degree label';
				case RCDeg.NOTES
					prop_default = 'Rich-Club Degree notes';
				case RCDeg.SHAPE
					prop_default = Measure.NODAL;
				case RCDeg.SCOPE
					prop_default = Measure.UNILAYER;
				case RCDeg.PARAMETRICITY
					prop_default = Measure.PARAMETRIC;
				case RCDeg.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Degree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = RCDeg.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = RCDeg.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(RCDeg, POINTER) returns the conditioned default value of POINTER of RCDeg.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(RCDeg, POINTER) returns the conditioned default value of POINTER of RCDeg.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('RCDeg')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = RCDeg.getPropProp(pointer);
			
			prop_default = RCDeg.conditioning(prop, RCDeg.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(RCDeg, PROP, VALUE) checks VALUE format for PROP of RCDeg.
			%  CHECK = M.CHECKPROP(RCDeg, PROP, VALUE) checks VALUE format for PROP of RCDeg.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:RCDeg:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:RCDeg:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(RCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCDeg.
			%   Error id: €BRAPH2.STR€:RCDeg:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(RCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCDeg.
			%   Error id: €BRAPH2.STR€:RCDeg:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('RCDeg')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case RCDeg.PARAMETRIC_VALUE % __RCDeg.PARAMETRIC_VALUE__
					check = Format.checkFormat(Format.SCALAR, value, RCDeg.getPropSettings(prop));
				case RCDeg.TEMPLATE % __RCDeg.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, RCDeg.getPropSettings(prop));
				otherwise
					if prop <= Degree.getPropNumber()
						check = checkProp@Degree(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' RCDeg.getPropTag(prop) ' (' RCDeg.getFormatTag(RCDeg.getPropFormat(prop)) ').'] ...
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
				case RCDeg.M % __RCDeg.M__
					rng_settings_ = rng(); rng(m.getPropSeed(RCDeg.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					rich_club_degree = cell(L, 1); 
					directionality_type = g.get('DIRECTIONALITY_TYPE', L);
					richclub_threshold = m.get('PARAMETRIC_VALUE');
					assert(mod(richclub_threshold, 1) == 0, ...
					    [BRAPH2.STR ':RCDeg:' BRAPH2.WRONG_INPUT], ...
					    ['RCDeg threshold must be an integer value ' ...
					    'while it is ' tostring(richclub_threshold)])
					
					k_level = abs(richclub_threshold);
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					       
					        degree = calculateValue@Degree(m, prop); 
					        deg = degree{li};
					
					    else  % directed graphs
					      
					        in_degree = DegreeIn('G', g).get('M');        
					        out_degree = DegreeOut('G', g).get('M');       
					
					        deg = (in_degree{li} + out_degree{li})/2;
					    end
					
					    richclub_layer = zeros(N(1), 1, k_level);
					    for k = 1:1:k_level
					        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
					        Aii = binarize(Aii);  % binarizes the adjacency matrix
					        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
					        subAii(low_rich_nodes, :) = 0;  % remove rows
					        subAii(:, low_rich_nodes) = 0;  % remove columns
					
					        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					            richclub_layer(:, :, k) = sum(subAii, 1)';  % degree of high rich nodes
					        else
					            richclub_layer(:, :, k) = (sum(subAii, 1)' + sum(subAii, 2))/2;  % degree of high rich nodes
					        end
					
					    end
					    rich_club_degree(li) = {richclub_layer};  % add rich club degree of layer li          
					end
					
					value = rich_club_degree;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Degree.getPropNumber()
						value = calculateValue@Degree(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
