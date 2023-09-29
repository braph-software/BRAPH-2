classdef PathLengthInAv < PathLengthIn
	%PathLengthInAv is the graph Average In-Path Length.
	% It is a subclass of <a href="matlab:help PathLengthIn">PathLengthIn</a>.
	%
	% The Average In-Path Length (PathLengthInAv) of a graph is the average of the sum of the in-path lengths within each layer.
	%
	% PathLengthInAv methods (constructor):
	%  PathLengthInAv - constructor
	%
	% PathLengthInAv methods:
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
	% PathLengthInAv methods (display):
	%  tostring - string with information about the average in-path length
	%  disp - displays information about the average in-path length
	%  tree - displays the tree of the average in-path length
	%
	% PathLengthInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average in-path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average in-path length
	%
	% PathLengthInAv methods (save/load, Static):
	%  save - saves BRAPH2 average in-path length as b2 file
	%  load - loads a BRAPH2 average in-path length from a b2 file
	%
	% PathLengthInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average in-path length
	%
	% PathLengthInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average in-path length
	%
	% PathLengthInAv methods (inspection, Static):
	%  getClass - returns the class of the average in-path length
	%  getSubclasses - returns all subclasses of PathLengthInAv
	%  getProps - returns the property list of the average in-path length
	%  getPropNumber - returns the property number of the average in-path length
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
	% PathLengthInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthInAv constants</a>.
	%
	
	methods % constructor
		function m = PathLengthInAv(varargin)
			%PathLengthInAv() creates a average in-path length.
			%
			% PathLengthInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@PathLengthIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average in-path length.
			%
			% CLASS = PathLengthInAv.GETCLASS() returns the class 'PathLengthInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthInAv') returns 'PathLengthInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthInAv')
			%  are less computationally efficient.
			
			m_class = 'PathLengthInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average in-path length.
			%
			% LIST = PathLengthInAv.GETSUBCLASSES() returns all subclasses of 'PathLengthInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average in-path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthInAv') returns all subclasses of 'PathLengthInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLengthInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-path length.
			%
			% PROPS = PathLengthInAv.GETPROPS() returns the property list of average in-path length
			%  as a row vector.
			%
			% PROPS = PathLengthInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthInAv'[, CATEGORY]) returns the property list of 'PathLengthInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PathLengthIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PathLengthIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PathLengthIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PathLengthIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PathLengthIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PathLengthIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PathLengthIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PathLengthIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PathLengthIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PathLengthIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average in-path length.
			%
			% N = PathLengthInAv.GETPROPNUMBER() returns the property number of average in-path length.
			%
			% N = PathLengthInAv.GETPROPNUMBER(CATEGORY) returns the property number of average in-path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average in-path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthInAv') returns the property number of 'PathLengthInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLengthInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average in-path length/error.
			%
			% CHECK = PathLengthInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthInAv, PROP) checks whether PROP exists for PathLengthInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%  Element.EXISTSPROP(PathLengthInAv, PROP) throws error if PROP does NOT exist for PathLengthInAv.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLengthInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-path length/error.
			%
			% CHECK = PathLengthInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthInAv, TAG) checks whether TAG exists for PathLengthInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%  Element.EXISTSTAG(PathLengthInAv, TAG) throws error if TAG does NOT exist for PathLengthInAv.
			%   Error id: [BRAPH2:PathLengthInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlengthinav_tag_list = cellfun(@(x) PathLengthInAv.getPropTag(x), num2cell(PathLengthInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlengthinav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthInAv, POINTER) returns property number of POINTER of PathLengthInAv.
			%  PROPERTY = M.GETPROPPROP(PathLengthInAv, POINTER) returns property number of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlengthinav_tag_list = cellfun(@(x) PathLengthInAv.getPropTag(x), num2cell(PathLengthInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlengthinav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLengthInAv, POINTER) returns tag of POINTER of PathLengthInAv.
			%  TAG = M.GETPROPTAG(PathLengthInAv, POINTER) returns tag of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthInAv')
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
						tag = getPropTag@PathLengthIn(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthInAv, POINTER) returns category of POINTER of PathLengthInAv.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthInAv, POINTER) returns category of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PathLengthIn(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthInAv, POINTER) returns format of POINTER of PathLengthInAv.
			%  FORMAT = M.GETPROPFORMAT(PathLengthInAv, POINTER) returns format of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PathLengthIn(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthInAv, POINTER) returns description of POINTER of PathLengthInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthInAv, POINTER) returns description of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				case PathLengthInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average In-Path Length.';
				case PathLengthInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average In-Path Length.';
				case PathLengthInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average In-Path Length.';
				case PathLengthInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average In-Path Length.';
				case PathLengthInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average In-Path Length.';
				case PathLengthInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average In-Path Length.';
				case PathLengthInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average In-Path Length.';
				case PathLengthInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case PathLengthInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLengthInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLengthInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLengthInAv.M
					prop_description = 'M (result, cell) is the cell containing the Average In-Path Length.';
				otherwise
					prop_description = getPropDescription@PathLengthIn(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthInAv, POINTER) returns settings of POINTER of PathLengthInAv.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthInAv, POINTER) returns settings of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				case PathLengthInAv.TEMPLATE
					prop_settings = 'PathLengthInAv';
				otherwise
					prop_settings = getPropSettings@PathLengthIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthInAv, POINTER) returns the default value of POINTER of PathLengthInAv.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthInAv, POINTER) returns the default value of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				case PathLengthInAv.ELCLASS
					prop_default = 'PathLengthInAv';
				case PathLengthInAv.NAME
					prop_default = 'Average In-Path Length';
				case PathLengthInAv.DESCRIPTION
					prop_default = 'The Average In-Path Length (PathLengthInAv) is the average shortest in-path length of one node to all other nodes within a layer.';
				case PathLengthInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLengthInAv.getPropSettings(prop));
				case PathLengthInAv.ID
					prop_default = 'PathLengthInAv ID';
				case PathLengthInAv.LABEL
					prop_default = 'Average In-Path Length label';
				case PathLengthInAv.NOTES
					prop_default = 'Average In-Path Length notes';
				case PathLengthInAv.SHAPE
					prop_default = Measure.NODAL;
				case PathLengthInAv.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLengthInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLengthInAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'};
				otherwise
					prop_default = getPropDefault@PathLengthIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthInAv, POINTER) returns the conditioned default value of POINTER of PathLengthInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthInAv, POINTER) returns the conditioned default value of POINTER of PathLengthInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			prop_default = PathLengthInAv.conditioning(prop, PathLengthInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthInAv, PROP, VALUE) checks VALUE format for PROP of PathLengthInAv.
			%  CHECK = M.CHECKPROP(PathLengthInAv, PROP, VALUE) checks VALUE format for PROP of PathLengthInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLengthInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLengthInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthInAv.
			%   Error id: €BRAPH2.STR€:PathLengthInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthInAv.
			%   Error id: €BRAPH2.STR€:PathLengthInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthInAv.getPropProp(pointer);
			
			switch prop
				case PathLengthInAv.TEMPLATE % __PathLengthInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLengthInAv.getPropSettings(prop));
				otherwise
					if prop <= PathLengthIn.getPropNumber()
						check = checkProp@PathLengthIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthInAv.getPropTag(prop) ' (' PathLengthInAv.getFormatTag(PathLengthInAv.getPropFormat(prop)) ').'] ...
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
				case PathLengthInAv.M % __PathLengthInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLengthInAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					
					in_path_length = calculateValue@PathLengthIn(m, prop);
					in_path_length_av = cell(L, 1);
					path_length_rule = m.get('RULE');
					parfor li = 1:1:length(in_path_length_av)
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            player = in_path_length{li};
					            in_path_length_av(li) = {mean(player(player~=Inf))};
					        case {'mean'}
					            in_path_length_av(li) = {mean(in_path_length{li})};
					        otherwise  % 'harmonic' 'default'
					            in_path_length_av(li) = {harmmean(in_path_length{li})};
					    end
					end
					value = in_path_length_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= PathLengthIn.getPropNumber()
						value = calculateValue@PathLengthIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
