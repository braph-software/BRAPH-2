classdef KCorenessCentrality < Measure
	%KCorenessCentrality is the graph kcorenesscentrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The k-coreness centrality of a node is k if the node belongs to the k-core 
	% but not to the (k+1)-core.
	%
	% The list of KCorenessCentrality properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the kcorenesscentrality.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the kcorenesscentrality.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the kcorenesscentrality.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the kcorenesscentrality.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the kcorenesscentrality.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the kcorenesscentrality.
	%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the kcorenesscentrality.
	%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% KCorenessCentrality methods (constructor):
	%  KCorenessCentrality - constructor
	%
	% KCorenessCentrality methods:
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
	% KCorenessCentrality methods (display):
	%  tostring - string with information about the kcorenesscentrality
	%  disp - displays information about the kcorenesscentrality
	%  tree - displays the tree of the kcorenesscentrality
	%
	% KCorenessCentrality methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two kcorenesscentrality are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the kcorenesscentrality
	%
	% KCorenessCentrality methods (save/load, Static):
	%  save - saves BRAPH2 kcorenesscentrality as b2 file
	%  load - loads a BRAPH2 kcorenesscentrality from a b2 file
	%
	% KCorenessCentrality method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the kcorenesscentrality
	%
	% KCorenessCentrality method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the kcorenesscentrality
	%
	% KCorenessCentrality methods (inspection, Static):
	%  getClass - returns the class of the kcorenesscentrality
	%  getSubclasses - returns all subclasses of KCorenessCentrality
	%  getProps - returns the property list of the kcorenesscentrality
	%  getPropNumber - returns the property number of the kcorenesscentrality
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
	% KCorenessCentrality methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% KCorenessCentrality methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% KCorenessCentrality methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% KCorenessCentrality methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?KCorenessCentrality; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">KCorenessCentrality constants</a>.
	%
	
	methods % constructor
		function m = KCorenessCentrality(varargin)
			%KCorenessCentrality() creates a kcorenesscentrality.
			%
			% KCorenessCentrality(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% KCorenessCentrality(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of KCorenessCentrality properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the kcorenesscentrality.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the kcorenesscentrality.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the kcorenesscentrality.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the kcorenesscentrality.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the kcorenesscentrality.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the kcorenesscentrality.
			%  <strong>7</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>8</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>9</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>10</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>11</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>12</strong> <strong>M</strong> 	M (result, cell) is the kcorenesscentrality.
			%  <strong>13</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the kcorenesscentrality.
			%
			% CLASS = KCorenessCentrality.GETCLASS() returns the class 'KCorenessCentrality'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the kcorenesscentrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('KCorenessCentrality') returns 'KCorenessCentrality'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('KCorenessCentrality')
			%  are less computationally efficient.
			
			m_class = 'KCorenessCentrality';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the kcorenesscentrality.
			%
			% LIST = KCorenessCentrality.GETSUBCLASSES() returns all subclasses of 'KCorenessCentrality'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the kcorenesscentrality M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('KCorenessCentrality') returns all subclasses of 'KCorenessCentrality'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'KCorenessCentrality' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of kcorenesscentrality.
			%
			% PROPS = KCorenessCentrality.GETPROPS() returns the property list of kcorenesscentrality
			%  as a row vector.
			%
			% PROPS = KCorenessCentrality.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the kcorenesscentrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('KCorenessCentrality'[, CATEGORY]) returns the property list of 'KCorenessCentrality'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('KCorenessCentrality')
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
			%GETPROPNUMBER returns the property number of kcorenesscentrality.
			%
			% N = KCorenessCentrality.GETPROPNUMBER() returns the property number of kcorenesscentrality.
			%
			% N = KCorenessCentrality.GETPROPNUMBER(CATEGORY) returns the property number of kcorenesscentrality
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the kcorenesscentrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('KCorenessCentrality') returns the property number of 'KCorenessCentrality'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('KCorenessCentrality')
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
			%EXISTSPROP checks whether property exists in kcorenesscentrality/error.
			%
			% CHECK = KCorenessCentrality.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(KCorenessCentrality, PROP) checks whether PROP exists for KCorenessCentrality.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%  Element.EXISTSPROP(KCorenessCentrality, PROP) throws error if PROP does NOT exist for KCorenessCentrality.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput'], ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for KCorenessCentrality.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in kcorenesscentrality/error.
			%
			% CHECK = KCorenessCentrality.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(KCorenessCentrality, TAG) checks whether TAG exists for KCorenessCentrality.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%  Element.EXISTSTAG(KCorenessCentrality, TAG) throws error if TAG does NOT exist for KCorenessCentrality.
			%   Error id: [BRAPH2:KCorenessCentrality:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput'], ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for KCorenessCentrality.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(KCorenessCentrality, POINTER) returns property number of POINTER of KCorenessCentrality.
			%  PROPERTY = M.GETPROPPROP(KCorenessCentrality, POINTER) returns property number of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('KCorenessCentrality')
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
			%  TAG = Element.GETPROPTAG(KCorenessCentrality, POINTER) returns tag of POINTER of KCorenessCentrality.
			%  TAG = M.GETPROPTAG(KCorenessCentrality, POINTER) returns tag of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				kcorenesscentrality_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = kcorenesscentrality_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(KCorenessCentrality, POINTER) returns category of POINTER of KCorenessCentrality.
			%  CATEGORY = M.GETPROPCATEGORY(KCorenessCentrality, POINTER) returns category of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			kcorenesscentrality_category_list = { 1  1  3  4  2  2  1  1  1  1  4  5  9 };
			prop_category = kcorenesscentrality_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(KCorenessCentrality, POINTER) returns format of POINTER of KCorenessCentrality.
			%  FORMAT = M.GETPROPFORMAT(KCorenessCentrality, POINTER) returns format of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			kcorenesscentrality_format_list = { 2  2  8  2  2  2  11  11  11  7  8  16  8 };
			prop_format = kcorenesscentrality_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(KCorenessCentrality, POINTER) returns description of POINTER of KCorenessCentrality.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(KCorenessCentrality, POINTER) returns description of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			kcorenesscentrality_description_list = { 'NAME (constant, string) is the name of the kcorenesscentrality.'  'DESCRIPTION (constant, string) is the description of the kcorenesscentrality.'  'TEMPLATE (parameter, item) is the template of the kcorenesscentrality.'  'ID (data, string) is a few-letter code of the kcorenesscentrality.'  'LABEL (metadata, string) is an extended label of the kcorenesscentrality.'  'NOTES (metadata, string) are some specific notes about the kcorenesscentrality.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the kcorenesscentrality.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = kcorenesscentrality_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(KCorenessCentrality, POINTER) returns settings of POINTER of KCorenessCentrality.
			%  SETTINGS = M.GETPROPSETTINGS(KCorenessCentrality, POINTER) returns settings of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = KCorenessCentrality.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = KCorenessCentrality.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(KCorenessCentrality, POINTER) returns the default value of POINTER of KCorenessCentrality.
			%  DEFAULT = M.GETPROPDEFAULT(KCorenessCentrality, POINTER) returns the default value of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % KCorenessCentrality.NAME
					prop_default = 'KCorenessCentrality';
				case 2 % KCorenessCentrality.DESCRIPTION
					prop_default = 'The k-coreness centrality of a node is k if the node belongs to the k-core but not to the (k+1)-core.';
				case 4 % KCorenessCentrality.ID
					prop_default = 'KCorenessCentrality ID';
				case 5 % KCorenessCentrality.LABEL
					prop_default = 'KCorenessCentrality label';
				case 6 % KCorenessCentrality.NOTES
					prop_default = 'KCorenessCentrality notes';
				case 7 % KCorenessCentrality.SHAPE
					prop_default = 2;
				case 8 % KCorenessCentrality.SCOPE
					prop_default = 2;
				case 9 % KCorenessCentrality.PARAMETRICITY
					prop_default = 2;
				case 10 % KCorenessCentrality.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'GraphWD' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexWD' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = KCorenessCentrality.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = KCorenessCentrality.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(KCorenessCentrality, POINTER) returns the conditioned default value of POINTER of KCorenessCentrality.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(KCorenessCentrality, POINTER) returns the conditioned default value of POINTER of KCorenessCentrality.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			prop_default = KCorenessCentrality.conditioning(prop, KCorenessCentrality.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(KCorenessCentrality, PROP, VALUE) checks VALUE format for PROP of KCorenessCentrality.
			%  CHECK = M.CHECKPROP(KCorenessCentrality, PROP, VALUE) checks VALUE format for PROP of KCorenessCentrality.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:KCorenessCentrality:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:KCorenessCentrality:WrongInput
			%  Element.CHECKPROP(KCorenessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of KCorenessCentrality.
			%   Error id: BRAPH2:KCorenessCentrality:WrongInput
			%  M.CHECKPROP(KCorenessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of KCorenessCentrality.
			%   Error id: BRAPH2:KCorenessCentrality:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('KCorenessCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = KCorenessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= 13
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput'], ...
					['BRAPH2' ':KCorenessCentrality:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' KCorenessCentrality.getPropTag(prop) ' (' KCorenessCentrality.getFormatTag(KCorenessCentrality.getPropFormat(prop)) ').'] ...
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
				case 12 % KCorenessCentrality.M
					rng_settings_ = rng(); rng(m.getPropSeed(12), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					k_coreness_centrality = cell(L, 1);
					directionality_type =  g.get('DIRECTIONALITY_TYPE', L);
					
					for li = 1:1:L
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    coreness = zeros(1, N(1));
					    for k = 1:N(1)
					        k_core = calculate_kcore(Aii, k, directionality_layer);
					        ss = sum(k_core) > 0;
					        coreness(ss) = k;
					    end
					    k_coreness_centrality(li) = {coreness'};
					end
					value = k_coreness_centrality;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function k_core = calculate_kcore(A, k, directionality_layer)
			% CALCULATEKCORE calculates the k-core value of an adjacency matrix
			%
			% KCORE = CALCULATEKCORE(M, A, k, directionality_layer) returns
			% the value of the k-core of an adjacency matrix
			
			iter = 0;
			subAii = binarize(A);
			while 1
			    % get degrees of matrix
			    if directionality_layer == 2  % undirected graphs
			        deg = sum(subAii, 1)';  % degree undirected graphs
			    else
			        deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
			    end
			    
			    % find nodes with degree < k
			    low_k_nodes = find((deg < k) & (deg > 0));
			    
			    % if none found -> stop
			    if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
			    
			    % peel away found nodes
			    iter = iter + 1;
			    subAii(low_k_nodes, :) = 0;
			    subAii(:, low_k_nodes) = 0;
			end
			k_core = subAii;  % add k-core of layer li
			end
		end
	end
end
