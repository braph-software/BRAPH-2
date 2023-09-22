classdef SCore < Measure
	%SCore is the score.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The s-core of a graph is the largest subnetwork comprising nodes of strength 
	%   s or higher. s is set by the user; the default value is equal to 1.
	%
	% The list of SCore properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the score.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the score.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the score.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the score.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the score.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the score.
	%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>8</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.BINODAL.
	%  <strong>9</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>10</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>11</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>12</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>13</strong> <strong>M</strong> 	M (result, cell) is the score.
	%  <strong>14</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>15</strong> <strong>SCORETHRESHOLD</strong> 	SCORETHRESHOLD (parameter, scalar) is the strength threshold.
	%
	% SCore methods (constructor):
	%  SCore - constructor
	%
	% SCore methods:
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
	% SCore methods (display):
	%  tostring - string with information about the score
	%  disp - displays information about the score
	%  tree - displays the tree of the score
	%
	% SCore methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two score are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the score
	%
	% SCore methods (save/load, Static):
	%  save - saves BRAPH2 score as b2 file
	%  load - loads a BRAPH2 score from a b2 file
	%
	% SCore method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the score
	%
	% SCore method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the score
	%
	% SCore methods (inspection, Static):
	%  getClass - returns the class of the score
	%  getSubclasses - returns all subclasses of SCore
	%  getProps - returns the property list of the score
	%  getPropNumber - returns the property number of the score
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
	% SCore methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SCore methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SCore methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SCore methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SCore; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SCore constants</a>.
	%
	
	properties (Constant) % properties
		SCORETHRESHOLD = 15; %CET: Computational Efficiency Trick
		SCORETHRESHOLD_TAG = 'SCORETHRESHOLD';
		SCORETHRESHOLD_CATEGORY = 3;
		SCORETHRESHOLD_FORMAT = 11;
	end
	methods % constructor
		function m = SCore(varargin)
			%SCore() creates a score.
			%
			% SCore(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SCore(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SCore properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the score.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the score.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the score.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the score.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the score.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the score.
			%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>8</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.BINODAL.
			%  <strong>9</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>10</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>11</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>12</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>13</strong> <strong>M</strong> 	M (result, cell) is the score.
			%  <strong>14</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>15</strong> <strong>SCORETHRESHOLD</strong> 	SCORETHRESHOLD (parameter, scalar) is the strength threshold.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the score.
			%
			% CLASS = SCore.GETCLASS() returns the class 'SCore'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the score M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('SCore') returns 'SCore'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('SCore')
			%  are less computationally efficient.
			
			m_class = 'SCore';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the score.
			%
			% LIST = SCore.GETSUBCLASSES() returns all subclasses of 'SCore'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the score M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('SCore') returns all subclasses of 'SCore'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('SCore')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SCore' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of score.
			%
			% PROPS = SCore.GETPROPS() returns the property list of score
			%  as a row vector.
			%
			% PROPS = SCore.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the score M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('SCore'[, CATEGORY]) returns the property list of 'SCore'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('SCore')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 8 9 10 11];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = [3 15];
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
			%GETPROPNUMBER returns the property number of score.
			%
			% N = SCore.GETPROPNUMBER() returns the property number of score.
			%
			% N = SCore.GETPROPNUMBER(CATEGORY) returns the property number of score
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the score M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('SCore') returns the property number of 'SCore'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('SCore')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
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
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in score/error.
			%
			% CHECK = SCore.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(SCore, PROP) checks whether PROP exists for SCore.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SCore:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%  Element.EXISTSPROP(SCore, PROP) throws error if PROP does NOT exist for SCore.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('SCore')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SCore:' 'WrongInput'], ...
					['BRAPH2' ':SCore:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SCore.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in score/error.
			%
			% CHECK = SCore.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(SCore, TAG) checks whether TAG exists for SCore.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SCore:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%  Element.EXISTSTAG(SCore, TAG) throws error if TAG does NOT exist for SCore.
			%   Error id: [BRAPH2:SCore:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('SCore')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'SCORETHRESHOLD' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SCore:' 'WrongInput'], ...
					['BRAPH2' ':SCore:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SCore.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SCore, POINTER) returns property number of POINTER of SCore.
			%  PROPERTY = M.GETPROPPROP(SCore, POINTER) returns property number of POINTER of SCore.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('SCore')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'SCORETHRESHOLD' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SCore, POINTER) returns tag of POINTER of SCore.
			%  TAG = M.GETPROPTAG(SCore, POINTER) returns tag of POINTER of SCore.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('SCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				score_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'SCORETHRESHOLD' };
				tag = score_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SCore, POINTER) returns category of POINTER of SCore.
			%  CATEGORY = M.GETPROPCATEGORY(SCore, POINTER) returns category of POINTER of SCore.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('SCore')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			score_category_list = { 1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = score_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SCore, POINTER) returns format of POINTER of SCore.
			%  FORMAT = M.GETPROPFORMAT(SCore, POINTER) returns format of POINTER of SCore.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('SCore')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			score_format_list = { 2  2  8  2  2  2  2  11  11  11  7  8  16  8  11 };
			prop_format = score_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SCore, POINTER) returns description of POINTER of SCore.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(SCore, POINTER) returns description of POINTER of SCore.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('SCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			score_description_list = { 'NAME (constant, string) is the name of the score.'  'DESCRIPTION (constant, string) is the description of the score.'  'TEMPLATE (parameter, item) is the template of the score.'  'ID (data, string) is a few-letter code of the score.'  'LABEL (metadata, string) is an extended label of the score.'  'NOTES (metadata, string) are some specific notes about the score.'  'TOSTRING (query, string) returns a string that represents the object.'  'SHAPE (constant, scalar) is the measure shape Measure.BINODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the score.'  'PFM (gui, item) contains the panel figure of the measure.'  'SCORETHRESHOLD (parameter, scalar) is the strength threshold.' };
			prop_description = score_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SCore, POINTER) returns settings of POINTER of SCore.
			%  SETTINGS = M.GETPROPSETTINGS(SCore, POINTER) returns settings of POINTER of SCore.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('SCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SCore.SCORETHRESHOLD
					prop_settings = Format.getFormatSettings(11);
				case 3 % SCore.TEMPLATE
					prop_settings = 'SCore';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SCore.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SCore.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(SCore, POINTER) returns the default value of POINTER of SCore.
			%  DEFAULT = M.GETPROPDEFAULT(SCore, POINTER) returns the default value of POINTER of SCore.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('SCore')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SCore.SCORETHRESHOLD
					prop_default = 1;
				case 1 % SCore.NAME
					prop_default = 'SCore';
				case 2 % SCore.DESCRIPTION
					prop_default = 'The s-core of a graph is the largest subnetwork comprising nodes of strength s or higher. s is set by the user; the default value is equal to 1.';
				case 3 % SCore.TEMPLATE
					prop_default = Format.getFormatDefault(8, SCore.getPropSettings(prop));
				case 4 % SCore.ID
					prop_default = 'SCore ID';
				case 5 % SCore.LABEL
					prop_default = 'SCore label';
				case 6 % SCore.NOTES
					prop_default = 'SCore notes';
				case 8 % SCore.SHAPE
					prop_default = 3;
				case 9 % SCore.SCOPE
					prop_default = 2;
				case 10 % SCore.PARAMETRICITY
					prop_default = 2;
				case 11 % SCore.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphWU' 'MultiplexWD' 'MultiplexWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SCore.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SCore.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SCore, POINTER) returns the conditioned default value of POINTER of SCore.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(SCore, POINTER) returns the conditioned default value of POINTER of SCore.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('SCore')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SCore.getPropProp(pointer);
			
			prop_default = SCore.conditioning(prop, SCore.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SCore, PROP, VALUE) checks VALUE format for PROP of SCore.
			%  CHECK = M.CHECKPROP(SCore, PROP, VALUE) checks VALUE format for PROP of SCore.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SCore:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:SCore:WrongInput
			%  Element.CHECKPROP(SCore, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SCore.
			%   Error id: BRAPH2:SCore:WrongInput
			%  M.CHECKPROP(SCore, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SCore.
			%   Error id: BRAPH2:SCore:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('SCore')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SCore.getPropProp(pointer);
			
			switch prop
				case 15 % SCore.SCORETHRESHOLD
					check = Format.checkFormat(11, value, SCore.getPropSettings(prop));
				case 3 % SCore.TEMPLATE
					check = Format.checkFormat(8, value, SCore.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SCore:' 'WrongInput'], ...
					['BRAPH2' ':SCore:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SCore.getPropTag(prop) ' (' SCore.getFormatTag(SCore.getPropFormat(prop)) ').'] ...
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
				case 13 % SCore.M
					rng_settings_ = rng(); rng(m.getPropSeed(13), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					score_threshold = m.get('SCORETHRESHOLD');
					assert(isnumeric(score_threshold) == 1, ...
					    ['BRAPH2' ':SCore:' 'WrongInput'], ...
					    ['SCore threshold must be a positive number ' ...
					    'while it is ' tostring(score_threshold)])
					
					s_core = cell(L, 1);
					directionality_type = g.get('DIRECTIONALITY_TYPE', L);
					parfor li = 1:1:L    
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    iter = 0;
					    subAii = Aii;
					    while 1
					        % get strengths of matrix
					        if directionality_layer == 2  % undirected graphs
					            st = sum(subAii, 1)';  % degree undirected graphs
					        else
					            st = (sum(subAii, 1)' + sum(subAii, 2));  % strength directed
					        end
					        
					        % find nodes with degree < k
					        low_s_nodes = find((st < score_threshold) & (st > 0));
					        
					        % if none found -> stop
					        if (isempty(low_s_nodes)) break; end; %#ok<SEPEX>
					        
					        % peel away found nodes
					        iter = iter + 1;
					        subAii(low_s_nodes, :) = 0;
					        subAii(:, low_s_nodes) = 0;
					    end
					    s_core(li) = {subAii};  % add s-core of layer li
					end
					value = s_core;
					
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
