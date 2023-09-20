classdef RCDeg < Degree
	%RCDeg is the graph richclubdegree.
	% It is a subclass of <a href="matlab:help Degree">Degree</a>.
	%
	% The rich-club degree of a node at level k is the sum of 
	%  the edges that connect nodes of degree k or higher within a layer. 
	%  k is set by the user; the default value is equal to 1.
	%
	% The list of RCDeg properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the richclubdegree.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the richclubdegree.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the richclubdegree.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the richclubdegree.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the richclubdegree.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the richclubdegree.
	%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the richclubdegree.
	%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>14</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, SCALAR) 
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
	%  tostring - string with information about the richclubdegree
	%  disp - displays information about the richclubdegree
	%  tree - displays the tree of the richclubdegree
	%
	% RCDeg methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two richclubdegree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the richclubdegree
	%
	% RCDeg methods (save/load, Static):
	%  save - saves BRAPH2 richclubdegree as b2 file
	%  load - loads a BRAPH2 richclubdegree from a b2 file
	%
	% RCDeg method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the richclubdegree
	%
	% RCDeg method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the richclubdegree
	%
	% RCDeg methods (inspection, Static):
	%  getClass - returns the class of the richclubdegree
	%  getSubclasses - returns all subclasses of RCDeg
	%  getProps - returns the property list of the richclubdegree
	%  getPropNumber - returns the property number of the richclubdegree
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
		PARAMETRIC_VALUE = 14; %CET: Computational Efficiency Trick
		PARAMETRIC_VALUE_TAG = 'PARAMETRIC_VALUE';
		PARAMETRIC_VALUE_CATEGORY = 3;
		PARAMETRIC_VALUE_FORMAT = 11;
	end
	methods % constructor
		function m = RCDeg(varargin)
			%RCDeg() creates a richclubdegree.
			%
			% RCDeg(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RCDeg(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of RCDeg properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the richclubdegree.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the richclubdegree.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the richclubdegree.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the richclubdegree.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the richclubdegree.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the richclubdegree.
			%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the richclubdegree.
			%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>14</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, SCALAR) 
			%
			% See also Category, Format.
			
			m = m@Degree(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the richclubdegree.
			%
			% CLASS = RCDeg.GETCLASS() returns the class 'RCDeg'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the richclubdegree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('RCDeg') returns 'RCDeg'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('RCDeg')
			%  are less computationally efficient.
			
			m_class = 'RCDeg';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the richclubdegree.
			%
			% LIST = RCDeg.GETSUBCLASSES() returns all subclasses of 'RCDeg'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the richclubdegree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('RCDeg') returns all subclasses of 'RCDeg'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('RCDeg')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'RCDeg'  'MultiplexRCDeg' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of richclubdegree.
			%
			% PROPS = RCDeg.GETPROPS() returns the property list of richclubdegree
			%  as a row vector.
			%
			% PROPS = RCDeg.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the richclubdegree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('RCDeg'[, CATEGORY]) returns the property list of 'RCDeg'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('RCDeg')
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
					prop_list = [1 2 7 8 9 10];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = [3 14];
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
			%GETPROPNUMBER returns the property number of richclubdegree.
			%
			% N = RCDeg.GETPROPNUMBER() returns the property number of richclubdegree.
			%
			% N = RCDeg.GETPROPNUMBER(CATEGORY) returns the property number of richclubdegree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the richclubdegree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('RCDeg') returns the property number of 'RCDeg'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('RCDeg')
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
					prop_number = 2;
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
			%EXISTSPROP checks whether property exists in richclubdegree/error.
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
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCDeg:' 'WrongInput'], ...
					['BRAPH2' ':RCDeg:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RCDeg.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in richclubdegree/error.
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
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCDeg:' 'WrongInput'], ...
					['BRAPH2' ':RCDeg:' 'WrongInput' '\n' ...
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
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); % tag = pointer %CET: Computational Efficiency Trick
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
				%CET: Computational Efficiency Trick
				rcdeg_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' };
				tag = rcdeg_tag_list{pointer}; % prop = pointer
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
			
			%CET: Computational Efficiency Trick
			rcdeg_category_list = { 1  1  3  4  2  2  1  1  1  1  4  5  9  3 };
			prop_category = rcdeg_category_list{prop};
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
			
			%CET: Computational Efficiency Trick
			rcdeg_format_list = { 2  2  8  2  2  2  11  11  11  7  8  16  8  11 };
			prop_format = rcdeg_format_list{prop};
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
			
			%CET: Computational Efficiency Trick
			rcdeg_description_list = { 'NAME (constant, string) is the name of the richclubdegree.'  'DESCRIPTION (constant, string) is the description of the richclubdegree.'  'TEMPLATE (parameter, item) is the template of the richclubdegree.'  'ID (data, string) is a few-letter code of the richclubdegree.'  'LABEL (metadata, string) is an extended label of the richclubdegree.'  'NOTES (metadata, string) are some specific notes about the richclubdegree.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the richclubdegree.'  'PFM (gui, item) contains the panel figure of the measure.'  'PARAMETRIC_VALUE (parameter, SCALAR) ' };
			prop_description = rcdeg_description_list{prop};
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
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % RCDeg.PARAMETRIC_VALUE
					prop_settings = Format.getFormatSettings(11);
				case 3 % RCDeg.TEMPLATE
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
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % RCDeg.PARAMETRIC_VALUE
					prop_default = 1;
				case 1 % RCDeg.NAME
					prop_default = 'RCDeg';
				case 2 % RCDeg.DESCRIPTION
					prop_default = 'The rich-club degree of a node at level k is the sum of the edges that connect nodes of degree k or higher within a layer. k is set by the user; the default value is equal to 1.';
				case 3 % RCDeg.TEMPLATE
					prop_default = Format.getFormatDefault(8, RCDeg.getPropSettings(prop));
				case 4 % RCDeg.ID
					prop_default = 'RCDeg ID';
				case 5 % RCDeg.LABEL
					prop_default = 'RCDeg label';
				case 6 % RCDeg.NOTES
					prop_default = 'RCDeg notes';
				case 7 % RCDeg.SHAPE
					prop_default = 2;
				case 8 % RCDeg.SCOPE
					prop_default = 2;
				case 9 % RCDeg.PARAMETRICITY
					prop_default = 1;
				case 10 % RCDeg.COMPATIBLE_GRAPHS
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
			%  Error id: BRAPH2:RCDeg:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:RCDeg:WrongInput
			%  Element.CHECKPROP(RCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCDeg.
			%   Error id: BRAPH2:RCDeg:WrongInput
			%  M.CHECKPROP(RCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCDeg.
			%   Error id: BRAPH2:RCDeg:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('RCDeg')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RCDeg.getPropProp(pointer);
			
			switch prop
				case 14 % RCDeg.PARAMETRIC_VALUE
					check = Format.checkFormat(11, value, RCDeg.getPropSettings(prop));
				case 3 % RCDeg.TEMPLATE
					check = Format.checkFormat(8, value, RCDeg.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@Degree(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCDeg:' 'WrongInput'], ...
					['BRAPH2' ':RCDeg:' 'WrongInput' '\n' ...
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
				case 12 % RCDeg.M
					rng_settings_ = rng(); rng(m.getPropSeed(12), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					rich_club_degree = cell(L, 1); 
					directionality_type = g.get('DIRECTIONALITY_TYPE', L);
					richclub_threshold = m.get('PARAMETRIC_VALUE');
					assert(mod(richclub_threshold, 1) == 0, ...
					    ['BRAPH2' ':RCDeg:' 'WrongInput'], ...
					    ['RCDeg threshold must be an integer value ' ...
					    'while it is ' tostring(richclub_threshold)])
					
					k_level = abs(richclub_threshold);
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    if directionality_layer == 2  % undirected graphs
					       
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
					
					        if directionality_layer == 2  % undirected graphs
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
					if prop <= 13
						value = calculateValue@Degree(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
