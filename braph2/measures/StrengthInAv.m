classdef StrengthInAv < StrengthIn
	%StrengthInAv is the graph average in-strength.
	% It is a subclass of <a href="matlab:help StrengthIn">StrengthIn</a>.
	%
	% The average in-strength of a graph is the mean of the sum of all weights of the inward edges 
	% connected to a node within a layer, i.e., it is the sum of the columns of 
	% the adjacency matrix.
	%
	% The list of StrengthInAv properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the in-strength.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the in-strength.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the in-strength.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the in-strength.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the in-strength.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the in-strength.
	%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the in-strength.
	%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
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
			% The list of StrengthInAv properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the in-strength.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the in-strength.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the in-strength.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the in-strength.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the in-strength.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the in-strength.
			%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the in-strength.
			%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
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
			
			subclass_list = { 'StrengthInAv' }; %CET: Computational Efficiency Trick
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
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 7 8 9 10];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = 3;
				case 4 % Category.DATA
					prop_list = [4 11];
				case 5 % Category.RESULT
					prop_list = 12;
				case 9 % Category.GUI
					prop_list = 13;
				otherwise
					prop_list = [];
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
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 6;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
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
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput' '\n' ...
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
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput' '\n' ...
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
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); % tag = pointer %CET: Computational Efficiency Trick
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
				%CET: Computational Efficiency Trick
				strengthinav_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = strengthinav_tag_list{pointer}; % prop = pointer
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
			
			%CET: Computational Efficiency Trick
			strengthinav_category_list = { 1  1  3  4  2  2  1  1  1  1  4  5  9 };
			prop_category = strengthinav_category_list{prop};
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
			
			%CET: Computational Efficiency Trick
			strengthinav_format_list = { 2  2  8  2  2  2  11  11  11  7  8  16  8 };
			prop_format = strengthinav_format_list{prop};
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
			
			%CET: Computational Efficiency Trick
			strengthinav_description_list = { 'NAME (constant, string) is the name of the in-strength.'  'DESCRIPTION (constant, string) is the description of the in-strength.'  'TEMPLATE (parameter, item) is the template of the in-strength.'  'ID (data, string) is a few-letter code of the in-strength.'  'LABEL (metadata, string) is an extended label of the in-strength.'  'NOTES (metadata, string) are some specific notes about the in-strength.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the in-strength.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = strengthinav_description_list{prop};
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
			
			switch prop %CET: Computational Efficiency Trick
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
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % StrengthInAv.NAME
					prop_default = 'StrengthInAv';
				case 2 % StrengthInAv.DESCRIPTION
					prop_default = 'The average in-strength of a graph is the mean of the sum of all weights of the inward edges connected to a node within a layer, i.e., it is the sum of the columns of the adjacency matrix.';
				case 4 % StrengthInAv.ID
					prop_default = 'StrengthInAv ID';
				case 5 % StrengthInAv.LABEL
					prop_default = 'StrengthInAv label';
				case 6 % StrengthInAv.NOTES
					prop_default = 'StrengthInAv notes';
				case 7 % StrengthInAv.SHAPE
					prop_default = 1;
				case 8 % StrengthInAv.SCOPE
					prop_default = 2;
				case 9 % StrengthInAv.PARAMETRICITY
					prop_default = 2;
				case 10 % StrengthInAv.COMPATIBLE_GRAPHS
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
			%  Error id: BRAPH2:StrengthInAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:StrengthInAv:WrongInput
			%  Element.CHECKPROP(StrengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthInAv.
			%   Error id: BRAPH2:StrengthInAv:WrongInput
			%  M.CHECKPROP(StrengthInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthInAv.
			%   Error id: BRAPH2:StrengthInAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('StrengthInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = StrengthInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= 13
						check = checkProp@StrengthIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthInAv:' 'WrongInput' '\n' ...
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
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 12 % StrengthInAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(12), 'twister')
					
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
					if prop <= 13
						value = calculateValue@StrengthIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
