classdef AnalyzeEnsemble_CON_WD < AnalyzeEnsemble
	%AnalyzeEnsemble_CON_WD is a graph analysis using connectivity data.
	% It is a subclass of <a href="matlab:help AnalyzeEnsemble">AnalyzeEnsemble</a>.
	%
	% This graph analysis uses connectivity data and analyzes them using weighted directed graphs.
	%
	% The list of AnalyzeEnsemble_CON_WD properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectCON.
	%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (GraphWD) ensemble obtained from this analysis.
	%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
	%
	% AnalyzeEnsemble_CON_WD methods (constructor):
	%  AnalyzeEnsemble_CON_WD - constructor
	%
	% AnalyzeEnsemble_CON_WD methods:
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
	% AnalyzeEnsemble_CON_WD methods (display):
	%  tostring - string with information about the graph analysis with connectivity data
	%  disp - displays information about the graph analysis with connectivity data
	%  tree - displays the tree of the graph analysis with connectivity data
	%
	% AnalyzeEnsemble_CON_WD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with connectivity data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with connectivity data
	%
	% AnalyzeEnsemble_CON_WD methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with connectivity data as b2 file
	%  load - loads a BRAPH2 graph analysis with connectivity data from a b2 file
	%
	% AnalyzeEnsemble_CON_WD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with connectivity data
	%
	% AnalyzeEnsemble_CON_WD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with connectivity data
	%
	% AnalyzeEnsemble_CON_WD methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with connectivity data
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble_CON_WD
	%  getProps - returns the property list of the graph analysis with connectivity data
	%  getPropNumber - returns the property number of the graph analysis with connectivity data
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
	% AnalyzeEnsemble_CON_WD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble_CON_WD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble_CON_WD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble_CON_WD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble_CON_WD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble_CON_WD constants</a>.
	%
	%
	% See also SubjectCON, GraphWD.
	
	methods % constructor
		function a = AnalyzeEnsemble_CON_WD(varargin)
			%AnalyzeEnsemble_CON_WD() creates a graph analysis with connectivity data.
			%
			% AnalyzeEnsemble_CON_WD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble_CON_WD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble_CON_WD properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectCON.
			%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (GraphWD) ensemble obtained from this analysis.
			%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
			%
			% See also Category, Format.
			
			a = a@AnalyzeEnsemble(varargin{:});
		end
	end
	methods (Static) % inspection
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with connectivity data.
			%
			% CLASS = AnalyzeEnsemble_CON_WD.GETCLASS() returns the class 'AnalyzeEnsemble_CON_WD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with connectivity data A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble_CON_WD') returns 'AnalyzeEnsemble_CON_WD'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble_CON_WD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with connectivity data.
			%
			% LIST = AnalyzeEnsemble_CON_WD.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble_CON_WD'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with connectivity data A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble_CON_WD') returns all subclasses of 'AnalyzeEnsemble_CON_WD'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeEnsemble_CON_WD' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with connectivity data.
			%
			% PROPS = AnalyzeEnsemble_CON_WD.GETPROPS() returns the property list of graph analysis with connectivity data
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble_CON_WD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with connectivity data A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble_CON_WD'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble_CON_WD'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble_CON_WD')
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
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 11];
				case 4 % Category.DATA
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = [12 13];
				case 6 % Category.QUERY
					prop_list = [8 14];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with connectivity data.
			%
			% N = AnalyzeEnsemble_CON_WD.GETPROPNUMBER() returns the property number of graph analysis with connectivity data.
			%
			% N = AnalyzeEnsemble_CON_WD.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with connectivity data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with connectivity data A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble_CON_WD') returns the property number of 'AnalyzeEnsemble_CON_WD'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble_CON_WD')
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
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with connectivity data/error.
			%
			% CHECK = AnalyzeEnsemble_CON_WD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble_CON_WD, PROP) checks whether PROP exists for AnalyzeEnsemble_CON_WD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble_CON_WD, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble_CON_WD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble_CON_WD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with connectivity data/error.
			%
			% CHECK = AnalyzeEnsemble_CON_WD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble_CON_WD, TAG) checks whether TAG exists for AnalyzeEnsemble_CON_WD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble_CON_WD, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble_CON_WD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble_CON_WD.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble_CON_WD, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_WD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble_CON_WD, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble_CON_WD, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_WD.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble_CON_WD, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzeensemble_con_wd_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' };
				tag = analyzeensemble_con_wd_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble_CON_WD, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_WD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble_CON_WD, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_wd_category_list = { 1  1  1  3  4  2  2  6  9  4  3  5  5  6 };
			prop_category = analyzeensemble_con_wd_category_list{prop};
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble_CON_WD, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_WD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble_CON_WD, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_wd_format_list = { 2  2  2  8  2  2  2  2  4  8  8  10  10  8 };
			prop_format = analyzeensemble_con_wd_format_list{prop};
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_WD, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_WD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_WD, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_wd_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data.'  'DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data.'  'TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data.'  'ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data.'  'LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data.'  'NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class SubjectCON.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'G_DICT (result, idict) is the graph (GraphWD) ensemble obtained from this analysis.'  'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.'  'MEASUREENSEMBLE (query, item) returns an ensemble-based measure.' };
			prop_description = analyzeensemble_con_wd_description_list{prop};
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble_CON_WD, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_WD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble_CON_WD, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % AnalyzeEnsemble_CON_WD.TEMPLATE
					prop_settings = 'AnalyzeEnsemble_CON_WD';
				case 11 % AnalyzeEnsemble_CON_WD.GRAPH_TEMPLATE
					prop_settings = 'GraphWD';
				case 12 % AnalyzeEnsemble_CON_WD.G_DICT
					prop_settings = 'GraphWD';
				otherwise
					prop_settings = getPropSettings@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_WD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_WD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble_CON_WD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_WD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble_CON_WD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % AnalyzeEnsemble_CON_WD.ELCLASS
					prop_default = 'AnalyzeEnsemble_CON_WD';
				case 2 % AnalyzeEnsemble_CON_WD.NAME
					prop_default = 'AnalyzeEnsemble_CON_WD';
				case 3 % AnalyzeEnsemble_CON_WD.DESCRIPTION
					prop_default = 'This ensemble-based graph analysis (AnalyzeEnsemble_CON_WD) analyzes connectivity data using weighted directed graphs.';
				case 4 % AnalyzeEnsemble_CON_WD.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				case 5 % AnalyzeEnsemble_CON_WD.ID
					prop_default = 'AnalyzeEnsemble_CON_WD ID';
				case 6 % AnalyzeEnsemble_CON_WD.LABEL
					prop_default = 'AnalyzeEnsemble_CON_WD label';
				case 7 % AnalyzeEnsemble_CON_WD.NOTES
					prop_default = 'AnalyzeEnsemble_CON_WD notes';
				case 10 % AnalyzeEnsemble_CON_WD.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON');
				case 11 % AnalyzeEnsemble_CON_WD.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_CON_WD.G_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_WD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_WD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_WD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_WD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_WD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_WD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble_CON_WD.conditioning(prop, AnalyzeEnsemble_CON_WD.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble_CON_WD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_WD.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble_CON_WD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_WD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput
			%  Element.CHECKPROP(AnalyzeEnsemble_CON_WD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_WD.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput
			%  A.CHECKPROP(AnalyzeEnsemble_CON_WD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_WD.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_WD:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble_CON_WD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble_CON_WD.getPropProp(pointer);
			
			switch prop
				case 4 % AnalyzeEnsemble_CON_WD.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				case 11 % AnalyzeEnsemble_CON_WD.GRAPH_TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_CON_WD.G_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemble_CON_WD.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@AnalyzeEnsemble(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_WD:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble_CON_WD.getPropTag(prop) ' (' AnalyzeEnsemble_CON_WD.getFormatTag(AnalyzeEnsemble_CON_WD.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case 12 % AnalyzeEnsemble_CON_WD.G_DICT
					rng_settings_ = rng(); rng(a.getPropSeed(12), 'twister')
					
					g_dict = IndexedDictionary('IT_CLASS', 'GraphWD');
					gr = a.get('GR');
					
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
						sub = gr.get('SUB_DICT').get('IT', i);
					    g = GraphWD( ...
					        'ID', ['g ' sub.get('ID')], ...
					        'B', Callback('EL', sub, 'TAG', 'CON'), ...
					        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
					        );
					    g_dict.get('ADD', g)
					        
					    if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
					        for i = 1:1:g_dict.get('LENGTH')
					            g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
					        end
					    end
					end
					
					value = g_dict;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 14
						value = calculateValue@AnalyzeEnsemble(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
end
