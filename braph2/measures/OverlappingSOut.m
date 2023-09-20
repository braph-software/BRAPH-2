classdef OverlappingSOut < StrengthOut
	%OverlappingSOut is the graph overlapping strength.
	% It is a subclass of <a href="matlab:help StrengthOut">StrengthOut</a>.
	%
	% The overlapping out-strength of a graph is the sum of the out-strengths of a 
	% node in all layers.
	%
	% The list of OverlappingSOut properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the overlapping strength.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the overlapping strength.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the overlapping strength.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the overlapping strength.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the overlapping strength.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the overlapping strength.
	%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the overlapping strength.
	%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% OverlappingSOut methods (constructor):
	%  OverlappingSOut - constructor
	%
	% OverlappingSOut methods:
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
	% OverlappingSOut methods (display):
	%  tostring - string with information about the ovrlapstrout
	%  disp - displays information about the ovrlapstrout
	%  tree - displays the tree of the ovrlapstrout
	%
	% OverlappingSOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ovrlapstrout are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ovrlapstrout
	%
	% OverlappingSOut methods (save/load, Static):
	%  save - saves BRAPH2 ovrlapstrout as b2 file
	%  load - loads a BRAPH2 ovrlapstrout from a b2 file
	%
	% OverlappingSOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ovrlapstrout
	%
	% OverlappingSOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ovrlapstrout
	%
	% OverlappingSOut methods (inspection, Static):
	%  getClass - returns the class of the ovrlapstrout
	%  getSubclasses - returns all subclasses of OverlappingSOut
	%  getProps - returns the property list of the ovrlapstrout
	%  getPropNumber - returns the property number of the ovrlapstrout
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
	% OverlappingSOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingSOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingSOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingSOut methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingSOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingSOut constants</a>.
	%
	
	methods % constructor
		function m = OverlappingSOut(varargin)
			%OverlappingSOut() creates a ovrlapstrout.
			%
			% OverlappingSOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingSOut(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OverlappingSOut properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the overlapping strength.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the overlapping strength.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the overlapping strength.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the overlapping strength.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the overlapping strength.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the overlapping strength.
			%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the overlapping strength.
			%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@StrengthOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the ovrlapstrout.
			%
			% CLASS = OverlappingSOut.GETCLASS() returns the class 'OverlappingSOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the ovrlapstrout M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingSOut') returns 'OverlappingSOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingSOut')
			%  are less computationally efficient.
			
			m_class = 'OverlappingSOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ovrlapstrout.
			%
			% LIST = OverlappingSOut.GETSUBCLASSES() returns all subclasses of 'OverlappingSOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the ovrlapstrout M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingSOut') returns all subclasses of 'OverlappingSOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'OverlappingSOut'  'OverlappingSOutAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ovrlapstrout.
			%
			% PROPS = OverlappingSOut.GETPROPS() returns the property list of ovrlapstrout
			%  as a row vector.
			%
			% PROPS = OverlappingSOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the ovrlapstrout M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingSOut'[, CATEGORY]) returns the property list of 'OverlappingSOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingSOut')
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
			%GETPROPNUMBER returns the property number of ovrlapstrout.
			%
			% N = OverlappingSOut.GETPROPNUMBER() returns the property number of ovrlapstrout.
			%
			% N = OverlappingSOut.GETPROPNUMBER(CATEGORY) returns the property number of ovrlapstrout
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the ovrlapstrout M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingSOut') returns the property number of 'OverlappingSOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingSOut')
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
			%EXISTSPROP checks whether property exists in ovrlapstrout/error.
			%
			% CHECK = OverlappingSOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingSOut, PROP) checks whether PROP exists for OverlappingSOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%  Element.EXISTSPROP(OverlappingSOut, PROP) throws error if PROP does NOT exist for OverlappingSOut.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput'], ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingSOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ovrlapstrout/error.
			%
			% CHECK = OverlappingSOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingSOut, TAG) checks whether TAG exists for OverlappingSOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%  Element.EXISTSTAG(OverlappingSOut, TAG) throws error if TAG does NOT exist for OverlappingSOut.
			%   Error id: [BRAPH2:OverlappingSOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput'], ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingSOut.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingSOut, POINTER) returns property number of POINTER of OverlappingSOut.
			%  PROPERTY = M.GETPROPPROP(OverlappingSOut, POINTER) returns property number of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingSOut')
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
			%  TAG = Element.GETPROPTAG(OverlappingSOut, POINTER) returns tag of POINTER of OverlappingSOut.
			%  TAG = M.GETPROPTAG(OverlappingSOut, POINTER) returns tag of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				overlappingsout_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = overlappingsout_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingSOut, POINTER) returns category of POINTER of OverlappingSOut.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingSOut, POINTER) returns category of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			overlappingsout_category_list = { 1  1  3  4  2  2  1  1  1  1  4  5  9 };
			prop_category = overlappingsout_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingSOut, POINTER) returns format of POINTER of OverlappingSOut.
			%  FORMAT = M.GETPROPFORMAT(OverlappingSOut, POINTER) returns format of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			overlappingsout_format_list = { 2  2  8  2  2  2  11  11  11  7  8  16  8 };
			prop_format = overlappingsout_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingSOut, POINTER) returns description of POINTER of OverlappingSOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingSOut, POINTER) returns description of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			overlappingsout_description_list = { 'NAME (constant, string) is the name of the overlapping strength.'  'DESCRIPTION (constant, string) is the description of the overlapping strength.'  'TEMPLATE (parameter, item) is the template of the overlapping strength.'  'ID (data, string) is a few-letter code of the overlapping strength.'  'LABEL (metadata, string) is an extended label of the overlapping strength.'  'NOTES (metadata, string) are some specific notes about the overlapping strength.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the overlapping strength.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = overlappingsout_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingSOut, POINTER) returns settings of POINTER of OverlappingSOut.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingSOut, POINTER) returns settings of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 3 % OverlappingSOut.TEMPLATE
					prop_settings = 'OverlappingSOut';
				otherwise
					prop_settings = getPropSettings@StrengthOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingSOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingSOut, POINTER) returns the default value of POINTER of OverlappingSOut.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingSOut, POINTER) returns the default value of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % OverlappingSOut.NAME
					prop_default = 'OverlappingSOut';
				case 2 % OverlappingSOut.DESCRIPTION
					prop_default = 'The overlapping out-strength of a graph is the sum of the out-strengths of a node in all layers.';
				case 3 % OverlappingSOut.TEMPLATE
					prop_default = Format.getFormatDefault(8, OverlappingSOut.getPropSettings(prop));
				case 4 % OverlappingSOut.ID
					prop_default = 'OverlappingSOut ID';
				case 5 % OverlappingSOut.LABEL
					prop_default = 'OverlappingSOut label';
				case 6 % OverlappingSOut.NOTES
					prop_default = 'OverlappingSOut notes';
				case 7 % OverlappingSOut.SHAPE
					prop_default = 2;
				case 8 % OverlappingSOut.SCOPE
					prop_default = 1;
				case 9 % OverlappingSOut.PARAMETRICITY
					prop_default = 2;
				case 10 % OverlappingSOut.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultilayerWD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@StrengthOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingSOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingSOut, POINTER) returns the conditioned default value of POINTER of OverlappingSOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingSOut, POINTER) returns the conditioned default value of POINTER of OverlappingSOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			prop_default = OverlappingSOut.conditioning(prop, OverlappingSOut.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingSOut, PROP, VALUE) checks VALUE format for PROP of OverlappingSOut.
			%  CHECK = M.CHECKPROP(OverlappingSOut, PROP, VALUE) checks VALUE format for PROP of OverlappingSOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:OverlappingSOut:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:OverlappingSOut:WrongInput
			%  Element.CHECKPROP(OverlappingSOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSOut.
			%   Error id: BRAPH2:OverlappingSOut:WrongInput
			%  M.CHECKPROP(OverlappingSOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSOut.
			%   Error id: BRAPH2:OverlappingSOut:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingSOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingSOut.getPropProp(pointer);
			
			switch prop
				case 3 % OverlappingSOut.TEMPLATE
					check = Format.checkFormat(8, value, OverlappingSOut.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@StrengthOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput'], ...
					['BRAPH2' ':OverlappingSOut:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingSOut.getPropTag(prop) ' (' OverlappingSOut.getFormatTag(OverlappingSOut.getPropFormat(prop)) ').'] ...
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
				case 12 % OverlappingSOut.M
					rng_settings_ = rng(); rng(m.getPropSeed(12), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    strength = calculateValue@StrengthOut(m, prop);	
					    overlapping_strength = zeros(N(1), 1);
					    for li = 1:l  
					        overlapping_strength = overlapping_strength + strength{li};
					    end
					    value = {overlapping_strength};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@StrengthOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
