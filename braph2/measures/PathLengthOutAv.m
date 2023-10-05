classdef PathLengthOutAv < PathLengthOut
	%PathLengthOutAv is the graph Average Out-Path Length.
	% It is a subclass of <a href="matlab:help PathLengthOut">PathLengthOut</a>.
	%
	% The Average Out-Path Length (PathLengthOutAv) is the average shortest out-path lengths of one node to all other nodes without a layer.
	%
	% PathLengthOutAv methods (constructor):
	%  PathLengthOutAv - constructor
	%
	% PathLengthOutAv methods:
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
	% PathLengthOutAv methods (display):
	%  tostring - string with information about the average out-path length
	%  disp - displays information about the average out-path length
	%  tree - displays the tree of the average out-path length
	%
	% PathLengthOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average out-path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average out-path length
	%
	% PathLengthOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average out-path length as b2 file
	%  load - loads a BRAPH2 average out-path length from a b2 file
	%
	% PathLengthOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average out-path length
	%
	% PathLengthOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average out-path length
	%
	% PathLengthOutAv methods (inspection, Static):
	%  getClass - returns the class of the average out-path length
	%  getSubclasses - returns all subclasses of PathLengthOutAv
	%  getProps - returns the property list of the average out-path length
	%  getPropNumber - returns the property number of the average out-path length
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
	% PathLengthOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthOutAv constants</a>.
	%
	
	methods % constructor
		function m = PathLengthOutAv(varargin)
			%PathLengthOutAv() creates a average out-path length.
			%
			% PathLengthOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@PathLengthOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average out-path length.
			%
			% CLASS = PathLengthOutAv.GETCLASS() returns the class 'PathLengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthOutAv') returns 'PathLengthOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthOutAv')
			%  are less computationally efficient.
			
			m_class = 'PathLengthOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average out-path length.
			%
			% LIST = PathLengthOutAv.GETSUBCLASSES() returns all subclasses of 'PathLengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average out-path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthOutAv') returns all subclasses of 'PathLengthOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLengthOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-path length.
			%
			% PROPS = PathLengthOutAv.GETPROPS() returns the property list of average out-path length
			%  as a row vector.
			%
			% PROPS = PathLengthOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthOutAv'[, CATEGORY]) returns the property list of 'PathLengthOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PathLengthOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PathLengthOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PathLengthOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PathLengthOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PathLengthOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PathLengthOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PathLengthOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PathLengthOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PathLengthOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PathLengthOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average out-path length.
			%
			% N = PathLengthOutAv.GETPROPNUMBER() returns the property number of average out-path length.
			%
			% N = PathLengthOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average out-path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average out-path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthOutAv') returns the property number of 'PathLengthOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLengthOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average out-path length/error.
			%
			% CHECK = PathLengthOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthOutAv, PROP) checks whether PROP exists for PathLengthOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSPROP(PathLengthOutAv, PROP) throws error if PROP does NOT exist for PathLengthOutAv.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLengthOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-path length/error.
			%
			% CHECK = PathLengthOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthOutAv, TAG) checks whether TAG exists for PathLengthOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSTAG(PathLengthOutAv, TAG) throws error if TAG does NOT exist for PathLengthOutAv.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlengthoutav_tag_list = cellfun(@(x) PathLengthOutAv.getPropTag(x), num2cell(PathLengthOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlengthoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthOutAv, POINTER) returns property number of POINTER of PathLengthOutAv.
			%  PROPERTY = M.GETPROPPROP(PathLengthOutAv, POINTER) returns property number of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlengthoutav_tag_list = cellfun(@(x) PathLengthOutAv.getPropTag(x), num2cell(PathLengthOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlengthoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLengthOutAv, POINTER) returns tag of POINTER of PathLengthOutAv.
			%  TAG = M.GETPROPTAG(PathLengthOutAv, POINTER) returns tag of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthOutAv')
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
						tag = getPropTag@PathLengthOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthOutAv, POINTER) returns category of POINTER of PathLengthOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthOutAv, POINTER) returns category of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PathLengthOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthOutAv, POINTER) returns format of POINTER of PathLengthOutAv.
			%  FORMAT = M.GETPROPFORMAT(PathLengthOutAv, POINTER) returns format of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PathLengthOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthOutAv, POINTER) returns description of POINTER of PathLengthOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthOutAv, POINTER) returns description of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				case PathLengthOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Out-Path Length.';
				case PathLengthOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Out-Path Length.';
				case PathLengthOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Out-Path Length.';
				case PathLengthOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Out-Path Length.';
				case PathLengthOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Out-Path Length.';
				case PathLengthOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Out-Path Length.';
				case PathLengthOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Out-Path Length.';
				case PathLengthOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case PathLengthOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLengthOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLengthOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLengthOutAv.M
					prop_description = 'M (result, cell) is the cell containing the Average Out-Path Length.';
				otherwise
					prop_description = getPropDescription@PathLengthOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthOutAv, POINTER) returns settings of POINTER of PathLengthOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthOutAv, POINTER) returns settings of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				case PathLengthOutAv.TEMPLATE
					prop_settings = 'PathLengthOutAv';
				otherwise
					prop_settings = getPropSettings@PathLengthOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthOutAv, POINTER) returns the default value of POINTER of PathLengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthOutAv, POINTER) returns the default value of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				case PathLengthOutAv.ELCLASS
					prop_default = 'PathLengthOutAv';
				case PathLengthOutAv.NAME
					prop_default = 'Average Out-Path Length';
				case PathLengthOutAv.DESCRIPTION
					prop_default = 'The Average Out-Path Length (PathLengthOutAv) is the average shortest PathLengthOutAv of one node to all other nodes within a layer.';
				case PathLengthOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLengthOutAv.getPropSettings(prop));
				case PathLengthOutAv.ID
					prop_default = 'PathLengthOutAv ID';
				case PathLengthOutAv.LABEL
					prop_default = 'Average Out-Path Length label';
				case PathLengthOutAv.NOTES
					prop_default = 'Average Out-Path Length notes';
				case PathLengthOutAv.SHAPE
					prop_default = Measure.NODAL;
				case PathLengthOutAv.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLengthOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLengthOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'};
				otherwise
					prop_default = getPropDefault@PathLengthOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthOutAv, POINTER) returns the conditioned default value of POINTER of PathLengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthOutAv, POINTER) returns the conditioned default value of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			prop_default = PathLengthOutAv.conditioning(prop, PathLengthOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthOutAv, PROP, VALUE) checks VALUE format for PROP of PathLengthOutAv.
			%  CHECK = M.CHECKPROP(PathLengthOutAv, PROP, VALUE) checks VALUE format for PROP of PathLengthOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLengthOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLengthOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOutAv.
			%   Error id: €BRAPH2.STR€:PathLengthOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOutAv.
			%   Error id: €BRAPH2.STR€:PathLengthOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				case PathLengthOutAv.TEMPLATE % __PathLengthOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLengthOutAv.getPropSettings(prop));
				otherwise
					if prop <= PathLengthOut.getPropNumber()
						check = checkProp@PathLengthOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthOutAv.getPropTag(prop) ' (' PathLengthOutAv.getFormatTag(PathLengthOutAv.getPropFormat(prop)) ').'] ...
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
				case PathLengthOutAv.M % __PathLengthOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLengthOutAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					
					out_path_length = calculateValue@PathLengthOut(m, prop);
					out_path_length_av = cell(L, 1);
					path_length_rule = m.get('RULE');
					parfor li = 1:1:length(out_path_length_av)
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            player = out_path_length{li};
					            out_path_length_av(li) = {mean(player(player~=Inf))};
					        case {'mean'}
					            out_path_length_av(li) = {mean(out_path_length{li})};
					        otherwise  % 'harmonic' 'default'
					            out_path_length_av(li) = {harmmean(out_path_length{li})};
					    end
					end
					value = out_path_length_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= PathLengthOut.getPropNumber()
						value = calculateValue@PathLengthOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
