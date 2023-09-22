classdef MultiplexPOut < Measure
	%MultiplexPOut is the graph multiplex out-participation.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The multiplex out-participation is the homogeneity of the number of outward 
	%  neighbours of a node across the layers.
	%
	% The list of MultiplexPOut properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the multiplex out-participation.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the multiplex out-participation.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the multiplex out-participation.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the multiplex out-participation.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the multiplex out-participation.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the multiplex out-participation.
	%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>8</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>9</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>10</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>11</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>12</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>13</strong> <strong>M</strong> 	M (result, cell) is the multiplex out-participation.
	%  <strong>14</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% MultiplexPOut methods (constructor):
	%  MultiplexPOut - constructor
	%
	% MultiplexPOut methods:
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
	% MultiplexPOut methods (display):
	%  tostring - string with information about the multiplex out-participation
	%  disp - displays information about the multiplex out-participation
	%  tree - displays the tree of the multiplex out-participation
	%
	% MultiplexPOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex out-participation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex out-participation
	%
	% MultiplexPOut methods (save/load, Static):
	%  save - saves BRAPH2 multiplex out-participation as b2 file
	%  load - loads a BRAPH2 multiplex out-participation from a b2 file
	%
	% MultiplexPOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex out-participation
	%
	% MultiplexPOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex out-participation
	%
	% MultiplexPOut methods (inspection, Static):
	%  getClass - returns the class of the multiplex out-participation
	%  getSubclasses - returns all subclasses of MultiplexPOut
	%  getProps - returns the property list of the multiplex out-participation
	%  getPropNumber - returns the property number of the multiplex out-participation
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
	% MultiplexPOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexPOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexPOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexPOut methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexPOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexPOut constants</a>.
	%
	
	methods % constructor
		function m = MultiplexPOut(varargin)
			%MultiplexPOut() creates a multiplex out-participation.
			%
			% MultiplexPOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexPOut(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiplexPOut properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the multiplex out-participation.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the multiplex out-participation.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the multiplex out-participation.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the multiplex out-participation.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the multiplex out-participation.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the multiplex out-participation.
			%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>8</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>9</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>10</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>11</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>12</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>13</strong> <strong>M</strong> 	M (result, cell) is the multiplex out-participation.
			%  <strong>14</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multiplex out-participation.
			%
			% CLASS = MultiplexPOut.GETCLASS() returns the class 'MultiplexPOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex out-participation M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexPOut') returns 'MultiplexPOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexPOut')
			%  are less computationally efficient.
			
			m_class = 'MultiplexPOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex out-participation.
			%
			% LIST = MultiplexPOut.GETSUBCLASSES() returns all subclasses of 'MultiplexPOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex out-participation M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexPOut') returns all subclasses of 'MultiplexPOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultiplexPOut' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex out-participation.
			%
			% PROPS = MultiplexPOut.GETPROPS() returns the property list of multiplex out-participation
			%  as a row vector.
			%
			% PROPS = MultiplexPOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex out-participation M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexPOut'[, CATEGORY]) returns the property list of 'MultiplexPOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 8 9 10 11];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = 3;
				case 4 % Category.DATA
					prop_list = [4 12];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = 7;
				case 9 % Category.GUI
					prop_list = 14;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multiplex out-participation.
			%
			% N = MultiplexPOut.GETPROPNUMBER() returns the property number of multiplex out-participation.
			%
			% N = MultiplexPOut.GETPROPNUMBER(CATEGORY) returns the property number of multiplex out-participation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex out-participation M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexPOut') returns the property number of 'MultiplexPOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
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
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex out-participation/error.
			%
			% CHECK = MultiplexPOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexPOut, PROP) checks whether PROP exists for MultiplexPOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%  Element.EXISTSPROP(MultiplexPOut, PROP) throws error if PROP does NOT exist for MultiplexPOut.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexPOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex out-participation/error.
			%
			% CHECK = MultiplexPOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexPOut, TAG) checks whether TAG exists for MultiplexPOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%  Element.EXISTSTAG(MultiplexPOut, TAG) throws error if TAG does NOT exist for MultiplexPOut.
			%   Error id: [BRAPH2:MultiplexPOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexPOut.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexPOut, POINTER) returns property number of POINTER of MultiplexPOut.
			%  PROPERTY = M.GETPROPPROP(MultiplexPOut, POINTER) returns property number of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MultiplexPOut, POINTER) returns tag of POINTER of MultiplexPOut.
			%  TAG = M.GETPROPTAG(MultiplexPOut, POINTER) returns tag of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multiplexpout_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = multiplexpout_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexPOut, POINTER) returns category of POINTER of MultiplexPOut.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexPOut, POINTER) returns category of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexpout_category_list = { 1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = multiplexpout_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexPOut, POINTER) returns format of POINTER of MultiplexPOut.
			%  FORMAT = M.GETPROPFORMAT(MultiplexPOut, POINTER) returns format of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexpout_format_list = { 2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = multiplexpout_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexPOut, POINTER) returns description of POINTER of MultiplexPOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexPOut, POINTER) returns description of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexpout_description_list = { 'NAME (constant, string) is the name of the multiplex out-participation.'  'DESCRIPTION (constant, string) is the description of the multiplex out-participation.'  'TEMPLATE (parameter, item) is the template of the multiplex out-participation.'  'ID (data, string) is a few-letter code of the multiplex out-participation.'  'LABEL (metadata, string) is an extended label of the multiplex out-participation.'  'NOTES (metadata, string) are some specific notes about the multiplex out-participation.'  'TOSTRING (query, string) returns a string that represents the object.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the multiplex out-participation.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = multiplexpout_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexPOut, POINTER) returns settings of POINTER of MultiplexPOut.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexPOut, POINTER) returns settings of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 3 % MultiplexPOut.TEMPLATE
					prop_settings = 'MultiplexPOut';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexPOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexPOut, POINTER) returns the default value of POINTER of MultiplexPOut.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexPOut, POINTER) returns the default value of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % MultiplexPOut.NAME
					prop_default = 'MultiplexOutParticipation';
				case 2 % MultiplexPOut.DESCRIPTION
					prop_default = 'The multiplex out-participation is the homogeneity of the number of outward neighbours of a node across the layers.';
				case 3 % MultiplexPOut.TEMPLATE
					prop_default = Format.getFormatDefault(8, MultiplexPOut.getPropSettings(prop));
				case 4 % MultiplexPOut.ID
					prop_default = 'MultiplexPOut ID';
				case 5 % MultiplexPOut.LABEL
					prop_default = 'MultiplexOutParticipation label';
				case 6 % MultiplexPOut.NOTES
					prop_default = 'MultiplexOutParticipation notes';
				case 8 % MultiplexPOut.SHAPE
					prop_default = 2;
				case 9 % MultiplexPOut.SCOPE
					prop_default = 1;
				case 10 % MultiplexPOut.PARAMETRICITY
					prop_default = 2;
				case 11 % MultiplexPOut.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultiplexBD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexPOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexPOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexPOut, POINTER) returns the conditioned default value of POINTER of MultiplexPOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexPOut, POINTER) returns the conditioned default value of POINTER of MultiplexPOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			prop_default = MultiplexPOut.conditioning(prop, MultiplexPOut.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexPOut, PROP, VALUE) checks VALUE format for PROP of MultiplexPOut.
			%  CHECK = M.CHECKPROP(MultiplexPOut, PROP, VALUE) checks VALUE format for PROP of MultiplexPOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultiplexPOut:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:MultiplexPOut:WrongInput
			%  Element.CHECKPROP(MultiplexPOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPOut.
			%   Error id: BRAPH2:MultiplexPOut:WrongInput
			%  M.CHECKPROP(MultiplexPOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexPOut.
			%   Error id: BRAPH2:MultiplexPOut:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexPOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexPOut.getPropProp(pointer);
			
			switch prop
				case 3 % MultiplexPOut.TEMPLATE
					check = Format.checkFormat(8, value, MultiplexPOut.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexPOut:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexPOut.getPropTag(prop) ' (' MultiplexPOut.getFormatTag(MultiplexPOut.getPropFormat(prop)) ').'] ...
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
				case 13 % MultiplexPOut.M
					rng_settings_ = rng(); rng(m.getPropSeed(13), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    out_degree = DegreeOut('G', g).get('M');
					    overlapping_out_degree = OverlappingDegOut('G', g).get('M');
					    multiplex_out_participation =  zeros(N(1), 1);
					
					    for li = 1:1:l
					        multiplex_out_participation = multiplex_out_participation + (out_degree{li}./overlapping_out_degree{1}).^2;
					    end
					    multiplex_out_participation = l / (l - 1) * (1 - multiplex_out_participation);
					    multiplex_out_participation(isnan(multiplex_out_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
					    value = {multiplex_out_participation};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 14
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
