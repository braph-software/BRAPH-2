classdef OverlappingSOutAv < OverlappingSOut
	%OverlappingSOutAv is the graph Average Overlapping Out-Strength.
	% It is a subclass of <a href="matlab:help OverlappingSOut">OverlappingSOut</a>.
	%
	% The Average Overlapping Out-Strength of a graph is the average of the sum of the out-strengths of a 
	%  node in all layers.
	%
	% OverlappingSOutAv methods (constructor):
	%  OverlappingSOutAv - constructor
	%
	% OverlappingSOutAv methods:
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
	% OverlappingSOutAv methods (display):
	%  tostring - string with information about the average overlapping out-strength
	%  disp - displays information about the average overlapping out-strength
	%  tree - displays the tree of the average overlapping out-strength
	%
	% OverlappingSOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average overlapping out-strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average overlapping out-strength
	%
	% OverlappingSOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average overlapping out-strength as b2 file
	%  load - loads a BRAPH2 average overlapping out-strength from a b2 file
	%
	% OverlappingSOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average overlapping out-strength
	%
	% OverlappingSOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average overlapping out-strength
	%
	% OverlappingSOutAv methods (inspection, Static):
	%  getClass - returns the class of the average overlapping out-strength
	%  getSubclasses - returns all subclasses of OverlappingSOutAv
	%  getProps - returns the property list of the average overlapping out-strength
	%  getPropNumber - returns the property number of the average overlapping out-strength
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
	% OverlappingSOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingSOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingSOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingSOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingSOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingSOutAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingSOutAv(varargin)
			%OverlappingSOutAv() creates a average overlapping out-strength.
			%
			% OverlappingSOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingSOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingSOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average overlapping out-strength.
			%
			% CLASS = OverlappingSOutAv.GETCLASS() returns the class 'OverlappingSOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping out-strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingSOutAv') returns 'OverlappingSOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingSOutAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingSOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average overlapping out-strength.
			%
			% LIST = OverlappingSOutAv.GETSUBCLASSES() returns all subclasses of 'OverlappingSOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average overlapping out-strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingSOutAv') returns all subclasses of 'OverlappingSOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingSOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping out-strength.
			%
			% PROPS = OverlappingSOutAv.GETPROPS() returns the property list of average overlapping out-strength
			%  as a row vector.
			%
			% PROPS = OverlappingSOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping out-strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingSOutAv'[, CATEGORY]) returns the property list of 'OverlappingSOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingSOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingSOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingSOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingSOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingSOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingSOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingSOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingSOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingSOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingSOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average overlapping out-strength.
			%
			% N = OverlappingSOutAv.GETPROPNUMBER() returns the property number of average overlapping out-strength.
			%
			% N = OverlappingSOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average overlapping out-strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average overlapping out-strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingSOutAv') returns the property number of 'OverlappingSOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingSOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping out-strength/error.
			%
			% CHECK = OverlappingSOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingSOutAv, PROP) checks whether PROP exists for OverlappingSOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingSOutAv, PROP) throws error if PROP does NOT exist for OverlappingSOutAv.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingSOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingSOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping out-strength/error.
			%
			% CHECK = OverlappingSOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingSOutAv, TAG) checks whether TAG exists for OverlappingSOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingSOutAv, TAG) throws error if TAG does NOT exist for OverlappingSOutAv.
			%   Error id: [BRAPH2:OverlappingSOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingsoutav_tag_list = cellfun(@(x) OverlappingSOutAv.getPropTag(x), num2cell(OverlappingSOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingsoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingSOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingSOutAv, POINTER) returns property number of POINTER of OverlappingSOutAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingSOutAv, POINTER) returns property number of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingsoutav_tag_list = cellfun(@(x) OverlappingSOutAv.getPropTag(x), num2cell(OverlappingSOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingsoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OverlappingSOutAv, POINTER) returns tag of POINTER of OverlappingSOutAv.
			%  TAG = M.GETPROPTAG(OverlappingSOutAv, POINTER) returns tag of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingSOutAv')
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
						tag = getPropTag@OverlappingSOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingSOutAv, POINTER) returns category of POINTER of OverlappingSOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingSOutAv, POINTER) returns category of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingSOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingSOutAv, POINTER) returns format of POINTER of OverlappingSOutAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingSOutAv, POINTER) returns format of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingSOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingSOutAv, POINTER) returns description of POINTER of OverlappingSOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingSOutAv, POINTER) returns description of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping Out-Strength.';
				case OverlappingSOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingSOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingSOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingSOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingSOutAv.M
					prop_description = 'M (result, cell) is the Average Overlapping Out-Strength.';
				otherwise
					prop_description = getPropDescription@OverlappingSOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingSOutAv, POINTER) returns settings of POINTER of OverlappingSOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingSOutAv, POINTER) returns settings of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSOutAv.TEMPLATE
					prop_settings = 'OverlappingSOutAv';
				otherwise
					prop_settings = getPropSettings@OverlappingSOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingSOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingSOutAv, POINTER) returns the default value of POINTER of OverlappingSOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingSOutAv, POINTER) returns the default value of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSOutAv.ELCLASS
					prop_default = 'OverlappingSOutAv';
				case OverlappingSOutAv.NAME
					prop_default = 'Average Overlapping Out-Strength';
				case OverlappingSOutAv.DESCRIPTION
					prop_default = 'The Average Overlapping Out-Strength (OverlappingSOutAv) of a graph is the average of the sum of the out-strengths of a node in all layers.';
				case OverlappingSOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingSOutAv.getPropSettings(prop));
				case OverlappingSOutAv.ID
					prop_default = 'OverlappingSOutAv ID';
				case OverlappingSOutAv.LABEL
					prop_default = 'Average Overlapping Out-Strength label';
				case OverlappingSOutAv.NOTES
					prop_default = 'Average Overlapping Out-Strength notes';
				case OverlappingSOutAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingSOutAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingSOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingSOutAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultilayerWD' 'OrdMxWD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@OverlappingSOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingSOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingSOutAv, POINTER) returns the conditioned default value of POINTER of OverlappingSOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingSOutAv, POINTER) returns the conditioned default value of POINTER of OverlappingSOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			prop_default = OverlappingSOutAv.conditioning(prop, OverlappingSOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingSOutAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSOutAv.
			%  CHECK = M.CHECKPROP(OverlappingSOutAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingSOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingSOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingSOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSOutAv.
			%   Error id: €BRAPH2.STR€:OverlappingSOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingSOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSOutAv.
			%   Error id: €BRAPH2.STR€:OverlappingSOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingSOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingSOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSOutAv.TEMPLATE % __OverlappingSOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingSOutAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingSOut.getPropNumber()
						check = checkProp@OverlappingSOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingSOutAv.getPropTag(prop) ' (' OverlappingSOutAv.getFormatTag(OverlappingSOutAv.getPropFormat(prop)) ').'] ...
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
				case OverlappingSOutAv.M % __OverlappingSOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingSOutAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					overlapping_out_strength = calculateValue@OverlappingSOut(m, prop);
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					    value = {mean(cell2mat(overlapping_out_strength))};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingSOut.getPropNumber()
						value = calculateValue@OverlappingSOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
