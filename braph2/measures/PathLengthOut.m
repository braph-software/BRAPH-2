classdef PathLengthOut < Measure
	%PathLengthOut is the graph Out-Path Length.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Out-Path Length (PathLengthOut) is the average shortest out-path lengths of one node to all other nodes without a layer.
	%
	% PathLengthOut methods (constructor):
	%  PathLengthOut - constructor
	%
	% PathLengthOut methods:
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
	% PathLengthOut methods (display):
	%  tostring - string with information about the out-path length
	%  disp - displays information about the out-path length
	%  tree - displays the tree of the out-path length
	%
	% PathLengthOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two out-path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the out-path length
	%
	% PathLengthOut methods (save/load, Static):
	%  save - saves BRAPH2 out-path length as b2 file
	%  load - loads a BRAPH2 out-path length from a b2 file
	%
	% PathLengthOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the out-path length
	%
	% PathLengthOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the out-path length
	%
	% PathLengthOut methods (inspection, Static):
	%  getClass - returns the class of the out-path length
	%  getSubclasses - returns all subclasses of PathLengthOut
	%  getProps - returns the property list of the out-path length
	%  getPropNumber - returns the property number of the out-path length
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
	% PathLengthOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthOut methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthOut constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = PathLengthOut(varargin)
			%PathLengthOut() creates a out-path length.
			%
			% PathLengthOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthOut(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the out-path length.
			%
			% CLASS = PathLengthOut.GETCLASS() returns the class 'PathLengthOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the out-path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthOut') returns 'PathLengthOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthOut')
			%  are less computationally efficient.
			
			m_class = 'PathLengthOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the out-path length.
			%
			% LIST = PathLengthOut.GETSUBCLASSES() returns all subclasses of 'PathLengthOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the out-path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthOut') returns all subclasses of 'PathLengthOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PathLengthOut', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of out-path length.
			%
			% PROPS = PathLengthOut.GETPROPS() returns the property list of out-path length
			%  as a row vector.
			%
			% PROPS = PathLengthOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the out-path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthOut'[, CATEGORY]) returns the property list of 'PathLengthOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						PathLengthOut.RULE ...
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
						PathLengthOut.RULE ...
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
			%GETPROPNUMBER returns the property number of out-path length.
			%
			% N = PathLengthOut.GETPROPNUMBER() returns the property number of out-path length.
			%
			% N = PathLengthOut.GETPROPNUMBER(CATEGORY) returns the property number of out-path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the out-path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthOut') returns the property number of 'PathLengthOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PathLengthOut.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in out-path length/error.
			%
			% CHECK = PathLengthOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthOut, PROP) checks whether PROP exists for PathLengthOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%  Element.EXISTSPROP(PathLengthOut, PROP) throws error if PROP does NOT exist for PathLengthOut.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PathLengthOut.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in out-path length/error.
			%
			% CHECK = PathLengthOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthOut, TAG) checks whether TAG exists for PathLengthOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%  Element.EXISTSTAG(PathLengthOut, TAG) throws error if TAG does NOT exist for PathLengthOut.
			%   Error id: [BRAPH2:PathLengthOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pathlengthout_tag_list = cellfun(@(x) PathLengthOut.getPropTag(x), num2cell(PathLengthOut.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pathlengthout_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthOut.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthOut, POINTER) returns property number of POINTER of PathLengthOut.
			%  PROPERTY = M.GETPROPPROP(PathLengthOut, POINTER) returns property number of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pathlengthout_tag_list = cellfun(@(x) PathLengthOut.getPropTag(x), num2cell(PathLengthOut.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pathlengthout_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PathLengthOut, POINTER) returns tag of POINTER of PathLengthOut.
			%  TAG = M.GETPROPTAG(PathLengthOut, POINTER) returns tag of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PathLengthOut.RULE
						tag = PathLengthOut.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthOut, POINTER) returns category of POINTER of PathLengthOut.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthOut, POINTER) returns category of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE
					prop_category = PathLengthOut.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthOut, POINTER) returns format of POINTER of PathLengthOut.
			%  FORMAT = M.GETPROPFORMAT(PathLengthOut, POINTER) returns format of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE
					prop_format = PathLengthOut.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthOut, POINTER) returns description of POINTER of PathLengthOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthOut, POINTER) returns description of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE
					prop_description = 'RULE (parameter, option) is the PathLengthOut algorithm';
				case PathLengthOut.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Out-Path Length.';
				case PathLengthOut.NAME
					prop_description = 'NAME (constant, string) is the name of the Out-Path Length.';
				case PathLengthOut.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Out-Path Length.';
				case PathLengthOut.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Out-Path Length.';
				case PathLengthOut.ID
					prop_description = 'ID (data, string) is a few-letter code of the Out-Path Length.';
				case PathLengthOut.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Out-Path Length.';
				case PathLengthOut.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Out-Path Length.';
				case PathLengthOut.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case PathLengthOut.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case PathLengthOut.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case PathLengthOut.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case PathLengthOut.M
					prop_description = 'M (result, cell) is the cell containing the Out-Path Length.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthOut, POINTER) returns settings of POINTER of PathLengthOut.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthOut, POINTER) returns settings of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE
					prop_settings = {'subgraphs' 'harmonic' 'mean'};
				case PathLengthOut.TEMPLATE
					prop_settings = 'PathLengthOut';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthOut, POINTER) returns the default value of POINTER of PathLengthOut.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthOut, POINTER) returns the default value of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE
					prop_default = 'harmonic';
				case PathLengthOut.ELCLASS
					prop_default = 'PathLengthOut';
				case PathLengthOut.NAME
					prop_default = 'Out-Path Length';
				case PathLengthOut.DESCRIPTION
					prop_default = 'The Out-Path Length (PathLengthOut) is the average shortest out-path length of one node to all other nodes within a layer.';
				case PathLengthOut.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PathLengthOut.getPropSettings(prop));
				case PathLengthOut.ID
					prop_default = 'PathLengthOut ID';
				case PathLengthOut.LABEL
					prop_default = 'Out-Path Length label';
				case PathLengthOut.NOTES
					prop_default = 'Out-Path Length notes';
				case PathLengthOut.SHAPE
					prop_default = Measure.NODAL;
				case PathLengthOut.SCOPE
					prop_default = Measure.UNILAYER;
				case PathLengthOut.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case PathLengthOut.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMxBD'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthOut, POINTER) returns the conditioned default value of POINTER of PathLengthOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthOut, POINTER) returns the conditioned default value of POINTER of PathLengthOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			prop_default = PathLengthOut.conditioning(prop, PathLengthOut.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthOut, PROP, VALUE) checks VALUE format for PROP of PathLengthOut.
			%  CHECK = M.CHECKPROP(PathLengthOut, PROP, VALUE) checks VALUE format for PROP of PathLengthOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PathLengthOut:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:PathLengthOut:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PathLengthOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOut.
			%   Error id: €BRAPH2.STR€:PathLengthOut:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(PathLengthOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOut.
			%   Error id: €BRAPH2.STR€:PathLengthOut:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthOut.getPropProp(pointer);
			
			switch prop
				case PathLengthOut.RULE % __PathLengthOut.RULE__
					check = Format.checkFormat(Format.OPTION, value, PathLengthOut.getPropSettings(prop));
				case PathLengthOut.TEMPLATE % __PathLengthOut.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PathLengthOut.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PathLengthOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthOut.getPropTag(prop) ' (' PathLengthOut.getFormatTag(PathLengthOut.getPropFormat(prop)) ').'] ...
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
				case PathLengthOut.M % __PathLengthOut.M__
					rng_settings_ = rng(); rng(m.getPropSeed(PathLengthOut.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					N = g.get('NODENUMBER');
					L = g.get('LAYERNUMBER');
					
					out_path_length = cell(L, 1);                    
					path_length_rule = m.get('RULE');
					
					distance = Distance('G', g).get('M');
					
					parfor li = 1:1:L
					    out_path_length_layer = zeros(N(1), 1);
					    distance_layer = distance{li};
					
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            for u = 1:1:N
					                Du = distance_layer(u, :);
					                out_path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
					            end
					            out_path_length_layer(isnan(out_path_length_layer)) = 0;  % node Nan corresponds to isolated nodes, pathlength is 0
					        case {'mean'}
					            for u = 1:1:N
					                Du = distance_layer(u, :);
					                out_path_length_layer(u) = mean(Du(Du~=0));
					            end
					        otherwise  % 'harmonic' 'default'
					            for u = 1:1:N
					                Du = distance_layer(u, :);
					                out_path_length_layer(u) = harmmean(Du(Du~=0));
					            end
					    end
					    out_path_length(li) = {out_path_length_layer};
					end
					value = out_path_length;
					
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
