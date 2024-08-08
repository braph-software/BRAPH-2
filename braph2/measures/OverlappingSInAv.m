classdef OverlappingSInAv < OverlappingSIn
	%OverlappingSInAv is the graph Average Overlapping In-Strength.
	% It is a subclass of <a href="matlab:help OverlappingSIn">OverlappingSIn</a>.
	%
	% The Average Overlapping In-Strength (OverlappingSInAv) of a graph is the average of the sum of the 
	%  in-strengths of a node in all layers.
	%
	% OverlappingSInAv methods (constructor):
	%  OverlappingSInAv - constructor
	%
	% OverlappingSInAv methods:
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
	% OverlappingSInAv methods (display):
	%  tostring - string with information about the average overlapping in-strength
	%  disp - displays information about the average overlapping in-strength
	%  tree - displays the tree of the average overlapping in-strength
	%
	% OverlappingSInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average overlapping in-strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average overlapping in-strength
	%
	% OverlappingSInAv methods (save/load, Static):
	%  save - saves BRAPH2 average overlapping in-strength as b2 file
	%  load - loads a BRAPH2 average overlapping in-strength from a b2 file
	%
	% OverlappingSInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average overlapping in-strength
	%
	% OverlappingSInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average overlapping in-strength
	%
	% OverlappingSInAv methods (inspection, Static):
	%  getClass - returns the class of the average overlapping in-strength
	%  getSubclasses - returns all subclasses of OverlappingSInAv
	%  getProps - returns the property list of the average overlapping in-strength
	%  getPropNumber - returns the property number of the average overlapping in-strength
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
	% OverlappingSInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingSInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingSInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingSInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingSInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingSInAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingSInAv(varargin)
			%OverlappingSInAv() creates a average overlapping in-strength.
			%
			% OverlappingSInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingSInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingSIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average overlapping in-strength.
			%
			% CLASS = OverlappingSInAv.GETCLASS() returns the class 'OverlappingSInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping in-strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingSInAv') returns 'OverlappingSInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingSInAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingSInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average overlapping in-strength.
			%
			% LIST = OverlappingSInAv.GETSUBCLASSES() returns all subclasses of 'OverlappingSInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average overlapping in-strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingSInAv') returns all subclasses of 'OverlappingSInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingSInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping in-strength.
			%
			% PROPS = OverlappingSInAv.GETPROPS() returns the property list of average overlapping in-strength
			%  as a row vector.
			%
			% PROPS = OverlappingSInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping in-strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingSInAv'[, CATEGORY]) returns the property list of 'OverlappingSInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingSIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingSIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingSIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingSIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingSIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingSIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingSIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingSIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingSIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingSIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average overlapping in-strength.
			%
			% N = OverlappingSInAv.GETPROPNUMBER() returns the property number of average overlapping in-strength.
			%
			% N = OverlappingSInAv.GETPROPNUMBER(CATEGORY) returns the property number of average overlapping in-strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average overlapping in-strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingSInAv') returns the property number of 'OverlappingSInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingSInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping in-strength/error.
			%
			% CHECK = OverlappingSInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingSInAv, PROP) checks whether PROP exists for OverlappingSInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingSInAv, PROP) throws error if PROP does NOT exist for OverlappingSInAv.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingSInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingSInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping in-strength/error.
			%
			% CHECK = OverlappingSInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingSInAv, TAG) checks whether TAG exists for OverlappingSInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingSInAv, TAG) throws error if TAG does NOT exist for OverlappingSInAv.
			%   Error id: [BRAPH2:OverlappingSInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingsinav_tag_list = cellfun(@(x) OverlappingSInAv.getPropTag(x), num2cell(OverlappingSInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingsinav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingSInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingSInAv, POINTER) returns property number of POINTER of OverlappingSInAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingSInAv, POINTER) returns property number of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingsinav_tag_list = cellfun(@(x) OverlappingSInAv.getPropTag(x), num2cell(OverlappingSInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingsinav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OverlappingSInAv, POINTER) returns tag of POINTER of OverlappingSInAv.
			%  TAG = M.GETPROPTAG(OverlappingSInAv, POINTER) returns tag of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingSInAv')
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
						tag = getPropTag@OverlappingSIn(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingSInAv, POINTER) returns category of POINTER of OverlappingSInAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingSInAv, POINTER) returns category of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingSIn(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingSInAv, POINTER) returns format of POINTER of OverlappingSInAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingSInAv, POINTER) returns format of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingSIn(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingSInAv, POINTER) returns description of POINTER of OverlappingSInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingSInAv, POINTER) returns description of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping In-Strength.';
				case OverlappingSInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping In-Strength.';
				case OverlappingSInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Overlapping In-Strength.';
				case OverlappingSInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping In-Strength.';
				case OverlappingSInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping In-Strength.';
				case OverlappingSInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping In-Strength.';
				case OverlappingSInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping In-Strength.';
				case OverlappingSInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingSInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingSInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingSInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingSInAv.M
					prop_description = 'M (result, cell) is the Average Overlapping In-Strength.';
				otherwise
					prop_description = getPropDescription@OverlappingSIn(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingSInAv, POINTER) returns settings of POINTER of OverlappingSInAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingSInAv, POINTER) returns settings of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSInAv.TEMPLATE
					prop_settings = 'OverlappingSInAv';
				otherwise
					prop_settings = getPropSettings@OverlappingSIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingSInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingSInAv, POINTER) returns the default value of POINTER of OverlappingSInAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingSInAv, POINTER) returns the default value of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSInAv.ELCLASS
					prop_default = 'OverlappingSInAv';
				case OverlappingSInAv.NAME
					prop_default = 'Average Overlapping In-Strength';
				case OverlappingSInAv.DESCRIPTION
					prop_default = 'The Average Overlapping In-Strength (OverlappingSInAv) of a graph is the average of the sum of the in-strengths of a node in all layers.';
				case OverlappingSInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingSInAv.getPropSettings(prop));
				case OverlappingSInAv.ID
					prop_default = 'OverlappingSInAv ID';
				case OverlappingSInAv.LABEL
					prop_default = 'Average Overlapping In-Strength label';
				case OverlappingSInAv.NOTES
					prop_default = 'Average Overlapping In-Strength notes';
				case OverlappingSInAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingSInAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingSInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingSInAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultilayerWD' 'OrdMlWD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@OverlappingSIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingSInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingSInAv, POINTER) returns the conditioned default value of POINTER of OverlappingSInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingSInAv, POINTER) returns the conditioned default value of POINTER of OverlappingSInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			prop_default = OverlappingSInAv.conditioning(prop, OverlappingSInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingSInAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSInAv.
			%  CHECK = M.CHECKPROP(OverlappingSInAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingSInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingSInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingSInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSInAv.
			%   Error id: €BRAPH2.STR€:OverlappingSInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingSInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSInAv.
			%   Error id: €BRAPH2.STR€:OverlappingSInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingSInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingSInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSInAv.TEMPLATE % __OverlappingSInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingSInAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingSIn.getPropNumber()
						check = checkProp@OverlappingSIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingSInAv.getPropTag(prop) ' (' OverlappingSInAv.getFormatTag(OverlappingSInAv.getPropFormat(prop)) ').'] ...
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
				case OverlappingSInAv.M % __OverlappingSInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingSInAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					overlapping_in_strength = calculateValue@OverlappingSIn(m, prop);
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					    value = {mean(cell2mat(overlapping_in_strength))};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingSIn.getPropNumber()
						value = calculateValue@OverlappingSIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
