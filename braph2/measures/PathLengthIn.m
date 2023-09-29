classdef PathLengthIn < Measure
	%PathLengthIn is the graph In-Path Length.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The In-Path Length (PathLengthIn) is the average shortest in-path length of one node to all other nodes within a layer.
	%
	% PathLengthIn methods (constructor):
	%  PathLengthIn - constructor
	%
	% PathLengthIn methods:
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
	% PathLengthIn methods (display):
	%  tostring - string with information about the in-path length
	%  disp - displays information about the in-path length
	%  tree - displays the tree of the in-path length
	%
	% PathLengthIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two in-path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the in-path length
	%
	% PathLengthIn methods (save/load, Static):
	%  save - saves BRAPH2 in-path length as b2 file
	%  load - loads a BRAPH2 in-path length from a b2 file
	%
	% PathLengthIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the in-path length
	%
	% PathLengthIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the in-path length
	%
	% PathLengthIn methods (inspection, Static):
	%  getClass - returns the class of the in-path length
	%  getSubclasses - returns all subclasses of PathLengthIn
	%  getProps - returns the property list of the in-path length
	%  getPropNumber - returns the property number of the in-path length
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
	% PathLengthIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthIn constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = PathLengthIn(varargin)
			%PathLengthIn() creates a in-path length.
			%
			% PathLengthIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthIn(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the in-path length.
			%
			% CLASS = PathLengthIn.GETCLASS() returns the class 'PathLengthIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the in-path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthIn') returns 'PathLengthIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthIn')
			%  are less computationally efficient.
			
			m_class = 'PathLengthIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the in-path length.
			%
			% LIST = PathLengthIn.GETSUBCLASSES() returns all subclasses of 'PathLengthIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the in-path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthIn') returns all subclasses of 'PathLengthIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLengthIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of in-path length.
			%
			% PROPS = PathLengthIn.GETPROPS() returns the property list of in-path length
			%  as a row vector.
			%
			% PROPS = PathLengthIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the in-path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthIn'[, CATEGORY]) returns the property list of 'PathLengthIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						PathLengthIn.RULE ...
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
						PathLengthIn.RULE ...
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
			%GETPROPNUMBER returns the property number of in-path length.
			%
			% N = PathLengthIn.GETPROPNUMBER() returns the property number of in-path length.
			%
			% N = PathLengthIn.GETPROPNUMBER(CATEGORY) returns the property number of in-path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the in-path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthIn') returns the property number of 'PathLengthIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLengthIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in in-path length/error.
			%
			% CHECK = PathLengthIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthIn, PROP) checks whether PROP exists for PathLengthIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%  Element.EXISTSPROP(PathLengthIn, PROP) throws error if PROP does NOT exist for PathLengthIn.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLengthIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in in-path length/error.
			%
			% CHECK = PathLengthIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthIn, TAG) checks whether TAG exists for PathLengthIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%  Element.EXISTSTAG(PathLengthIn, TAG) throws error if TAG does NOT exist for PathLengthIn.
			%   Error id: [BRAPH2:PathLengthIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlengthin_tag_list = cellfun(@(x) PathLengthIn.getPropTag(x), num2cell(PathLengthIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlengthin_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthIn.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthIn, POINTER) returns property number of POINTER of PathLengthIn.
			%  PROPERTY = M.GETPROPPROP(PathLengthIn, POINTER) returns property number of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlengthin_tag_list = cellfun(@(x) PathLengthIn.getPropTag(x), num2cell(PathLengthIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlengthin_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLengthIn, POINTER) returns tag of POINTER of PathLengthIn.
			%  TAG = M.GETPROPTAG(PathLengthIn, POINTER) returns tag of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PathLengthIn.RULE
						tag = PathLengthIn.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthIn, POINTER) returns category of POINTER of PathLengthIn.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthIn, POINTER) returns category of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE
					prop_category = PathLengthIn.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthIn, POINTER) returns format of POINTER of PathLengthIn.
			%  FORMAT = M.GETPROPFORMAT(PathLengthIn, POINTER) returns format of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE
					prop_format = PathLengthIn.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthIn, POINTER) returns description of POINTER of PathLengthIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthIn, POINTER) returns description of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE
					prop_description = 'RULE (parameter, option) is the PathLengthIn algorithm';
				case PathLengthIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the In-Path Length .';
				case PathLengthIn.NAME
					prop_description = 'NAME (constant, string) is the name of the in-path length.';
				case PathLengthIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the In-Path Length.';
				case PathLengthIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the In-Path Length.';
				case PathLengthIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the In-Path Length.';
				case PathLengthIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the In-Path Length.';
				case PathLengthIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the In-Path Length.';
				case PathLengthIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case PathLengthIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLengthIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLengthIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLengthIn.M
					prop_description = 'M (result, cell) is the cell containing the In-Path Length.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthIn, POINTER) returns settings of POINTER of PathLengthIn.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthIn, POINTER) returns settings of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE
					prop_settings = {'subgraphs' 'harmonic' 'mean'};
				case PathLengthIn.TEMPLATE
					prop_settings = 'PathLengthIn';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthIn, POINTER) returns the default value of POINTER of PathLengthIn.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthIn, POINTER) returns the default value of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE
					prop_default = 'harmonic';
				case PathLengthIn.ELCLASS
					prop_default = 'PathLengthIn';
				case PathLengthIn.NAME
					prop_default = 'In-Path Length';
				case PathLengthIn.DESCRIPTION
					prop_default = 'The In-Path Length (PathLengthIn) is the average shortest in-path length of one node to all other nodes within a layer.';
				case PathLengthIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLengthIn.getPropSettings(prop));
				case PathLengthIn.ID
					prop_default = 'PathLengthIn ID';
				case PathLengthIn.LABEL
					prop_default = 'In-Path Length label';
				case PathLengthIn.NOTES
					prop_default = 'In-Path Length notes';
				case PathLengthIn.SHAPE
					prop_default = Measure.NODAL;
				case PathLengthIn.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLengthIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLengthIn.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthIn, POINTER) returns the conditioned default value of POINTER of PathLengthIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthIn, POINTER) returns the conditioned default value of POINTER of PathLengthIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			prop_default = PathLengthIn.conditioning(prop, PathLengthIn.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthIn, PROP, VALUE) checks VALUE format for PROP of PathLengthIn.
			%  CHECK = M.CHECKPROP(PathLengthIn, PROP, VALUE) checks VALUE format for PROP of PathLengthIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLengthIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLengthIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLengthIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthIn.
			%   Error id: €BRAPH2.STR€:PathLengthIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLengthIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthIn.
			%   Error id: €BRAPH2.STR€:PathLengthIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthIn.getPropProp(pointer);
			
			switch prop
				case PathLengthIn.RULE % __PathLengthIn.RULE__
					check = Format.checkFormat(Format.OPTION, value, PathLengthIn.getPropSettings(prop));
				case PathLengthIn.TEMPLATE % __PathLengthIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLengthIn.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthIn.getPropTag(prop) ' (' PathLengthIn.getFormatTag(PathLengthIn.getPropFormat(prop)) ').'] ...
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
				case PathLengthIn.M % __PathLengthIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLengthIn.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					N = g.get('NODENUMBER');
					L = g.get('LAYERNUMBER');
					
					in_path_length = cell(L, 1);                    
					path_length_rule = m.get('RULE');
					
					distance = Distance('G', g).get('M');
					
					parfor li = 1:1:L
					    in_path_length_layer = zeros(N(1), 1);
					    distance_layer = distance{li};
					
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                in_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
					            end
					            in_path_length_layer(isnan(in_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
					        case {'mean'}
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                in_path_length_layer(u) = mean(Du(Du~=0));
					            end
					        otherwise  % 'harmonic' 'default'
					            for u = 1:1:N
					                Du = distance_layer(:, u);
					                in_path_length_layer(u) = harmmean(Du(Du~=0));
					            end
					    end
					    in_path_length(li) = {in_path_length_layer};
					end
					value = in_path_length;
					
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
