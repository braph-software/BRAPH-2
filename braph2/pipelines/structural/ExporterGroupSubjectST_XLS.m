classdef ExporterGroupSubjectST_XLS < Exporter
	%ExporterGroupSubjectST_XLS exports a group of subjects with structural data to an XLSX file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectST_XLS exports a group of subjects with connectivity 
	%  data to an XLSX file with name "GROUP_ID.xlsx". This file contains a table 
	%  with the following columns: Subject ID (column 1), Subject LABEL (column 2), 
	%  Subject NOTES (column 3) and BrainRegions (columns 4-end; one brain region 
	%  value per column). The first row contains the headers and each subsequent 
	%  row the values for each subject.
	% The variables of interest (if existing) are saved in another XLSX file 
	%  named "GROUP_ID.vois.xlsx" consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of ExporterGroupSubjectST_XLS properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ST subject group exporter in XLSX.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ST subject group exporter in XLSX.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ST subject group exporter in XLSX.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ST subject group exporter in XLSX.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ST subject group exporter in XLSX.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ST subject group exporter in XLSX.
	%  <strong>7</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>8</strong> <strong>GR</strong> 	GR (data, item) is a group of subjects with structural data.
	%  <strong>9</strong> <strong>FILE</strong> 	FILE (data, string) is the XLSX file name where to save the group of subjects with structural data.
	%  <strong>10</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, item) opens a dialog box to set the XLSX file where to save the group of subjects with structural data.
	%  <strong>11</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the group of subjects with structural data in the selected XLSX file.
	%
	% ExporterGroupSubjectST_XLS methods (constructor):
	%  ExporterGroupSubjectST_XLS - constructor
	%
	% ExporterGroupSubjectST_XLS methods:
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
	% ExporterGroupSubjectST_XLS methods (display):
	%  tostring - string with information about the exporter of ST subject group in XLSX
	%  disp - displays information about the exporter of ST subject group in XLSX
	%  tree - displays the tree of the exporter of ST subject group in XLSX
	%
	% ExporterGroupSubjectST_XLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two exporter of ST subject group in XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the exporter of ST subject group in XLSX
	%
	% ExporterGroupSubjectST_XLS methods (save/load, Static):
	%  save - saves BRAPH2 exporter of ST subject group in XLSX as b2 file
	%  load - loads a BRAPH2 exporter of ST subject group in XLSX from a b2 file
	%
	% ExporterGroupSubjectST_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the exporter of ST subject group in XLSX
	%
	% ExporterGroupSubjectST_XLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the exporter of ST subject group in XLSX
	%
	% ExporterGroupSubjectST_XLS methods (inspection, Static):
	%  getClass - returns the class of the exporter of ST subject group in XLSX
	%  getSubclasses - returns all subclasses of ExporterGroupSubjectST_XLS
	%  getProps - returns the property list of the exporter of ST subject group in XLSX
	%  getPropNumber - returns the property number of the exporter of ST subject group in XLSX
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
	% ExporterGroupSubjectST_XLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterGroupSubjectST_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterGroupSubjectST_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectST_XLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterGroupSubjectST_XLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterGroupSubjectST_XLS constants</a>.
	%
	%
	% See also Group, SubjectST, ImporterGroupSubjectST_XLS.
	
	properties (Constant) % properties
		GR = 8; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 4;
		GR_FORMAT = 8;
		
		FILE = 9; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 4;
		FILE_FORMAT = 2;
		
		PUT_FILE = 10; %CET: Computational Efficiency Trick
		PUT_FILE_TAG = 'PUT_FILE';
		PUT_FILE_CATEGORY = 6;
		PUT_FILE_FORMAT = 8;
		
		SAVE = 11; %CET: Computational Efficiency Trick
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = 5;
		SAVE_FORMAT = 1;
	end
	methods % constructor
		function ex = ExporterGroupSubjectST_XLS(varargin)
			%ExporterGroupSubjectST_XLS() creates a exporter of ST subject group in XLSX.
			%
			% ExporterGroupSubjectST_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectST_XLS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterGroupSubjectST_XLS properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ST subject group exporter in XLSX.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ST subject group exporter in XLSX.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ST subject group exporter in XLSX.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ST subject group exporter in XLSX.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ST subject group exporter in XLSX.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ST subject group exporter in XLSX.
			%  <strong>7</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>8</strong> <strong>GR</strong> 	GR (data, item) is a group of subjects with structural data.
			%  <strong>9</strong> <strong>FILE</strong> 	FILE (data, string) is the XLSX file name where to save the group of subjects with structural data.
			%  <strong>10</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, item) opens a dialog box to set the XLSX file where to save the group of subjects with structural data.
			%  <strong>11</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the group of subjects with structural data in the selected XLSX file.
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of ST subject group in XLSX.
			%
			% CLASS = ExporterGroupSubjectST_XLS.GETCLASS() returns the class 'ExporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of ST subject group in XLSX EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectST_XLS') returns 'ExporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			
			ex_class = 'ExporterGroupSubjectST_XLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the exporter of ST subject group in XLSX.
			%
			% LIST = ExporterGroupSubjectST_XLS.GETSUBCLASSES() returns all subclasses of 'ExporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the exporter of ST subject group in XLSX EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterGroupSubjectST_XLS') returns all subclasses of 'ExporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ExporterGroupSubjectST_XLS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of ST subject group in XLSX.
			%
			% PROPS = ExporterGroupSubjectST_XLS.GETPROPS() returns the property list of exporter of ST subject group in XLSX
			%  as a row vector.
			%
			% PROPS = ExporterGroupSubjectST_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of ST subject group in XLSX EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectST_XLS'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = 3;
				case 4 % Category.DATA
					prop_list = [4 8 9];
				case 5 % Category.RESULT
					prop_list = 11;
				case 6 % Category.QUERY
					prop_list = 10;
				case 9 % Category.GUI
					prop_list = 7;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of exporter of ST subject group in XLSX.
			%
			% N = ExporterGroupSubjectST_XLS.GETPROPNUMBER() returns the property number of exporter of ST subject group in XLSX.
			%
			% N = ExporterGroupSubjectST_XLS.GETPROPNUMBER(CATEGORY) returns the property number of exporter of ST subject group in XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the exporter of ST subject group in XLSX EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectST_XLS') returns the property number of 'ExporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 11;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 2;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
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
			%EXISTSPROP checks whether property exists in exporter of ST subject group in XLSX/error.
			%
			% CHECK = ExporterGroupSubjectST_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectST_XLS, PROP) checks whether PROP exists for ExporterGroupSubjectST_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectST_XLS, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectST_XLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of ST subject group in XLSX/error.
			%
			% CHECK = ExporterGroupSubjectST_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectST_XLS, TAG) checks whether TAG exists for ExporterGroupSubjectST_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectST_XLS, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'WAITBAR'  'GR'  'FILE'  'PUT_FILE'  'SAVE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectST_XLS.'] ...
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
			%  PROPERTY = EX.GETPROPPROP(POINTER) returns property number of POINTER of EX.
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectST_XLS.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'WAITBAR'  'GR'  'FILE'  'PUT_FILE'  'SAVE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = EX.GETPROPTAG(POINTER) returns tag of POINTER of EX.
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectST_XLS.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				exportergroupsubjectst_xls_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'WAITBAR'  'GR'  'FILE'  'PUT_FILE'  'SAVE' };
				tag = exportergroupsubjectst_xls_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectST_XLS.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectst_xls_category_list = { 1  1  3  4  2  2  9  4  4  6  5 };
			prop_category = exportergroupsubjectst_xls_category_list{prop};
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectST_XLS.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectst_xls_format_list = { 2  2  8  2  2  2  4  8  2  8  1 };
			prop_format = exportergroupsubjectst_xls_format_list{prop};
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectST_XLS.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectst_xls_description_list = { 'NAME (constant, string) is the name of the ST subject group exporter in XLSX.'  'DESCRIPTION (constant, string) is the description of the ST subject group exporter in XLSX.'  'TEMPLATE (parameter, item) is the template of the ST subject group exporter in XLSX.'  'ID (data, string) is a few-letter code for the ST subject group exporter in XLSX.'  'LABEL (metadata, string) is an extended label of the ST subject group exporter in XLSX.'  'NOTES (metadata, string) are some specific notes about the ST subject group exporter in XLSX.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is a group of subjects with structural data.'  'FILE (data, string) is the XLSX file name where to save the group of subjects with structural data.'  'PUT_FILE (query, item) opens a dialog box to set the XLSX file where to save the group of subjects with structural data.'  'SAVE (result, empty) saves the group of subjects with structural data in the selected XLSX file.' };
			prop_description = exportergroupsubjectst_xls_description_list{prop};
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectST_XLS.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 8 % ExporterGroupSubjectST_XLS.GR
					prop_settings = 'Group';
				case 9 % ExporterGroupSubjectST_XLS.FILE
					prop_settings = Format.getFormatSettings(2);
				case 10 % ExporterGroupSubjectST_XLS.PUT_FILE
					prop_settings = 'ExporterGroupSubjectST_XLS';
				case 11 % ExporterGroupSubjectST_XLS.SAVE
					prop_settings = Format.getFormatSettings(1);
				case 3 % ExporterGroupSubjectST_XLS.TEMPLATE
					prop_settings = 'ExporterGroupSubjectST_XLS';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_XLS.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 8 % ExporterGroupSubjectST_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 9 % ExporterGroupSubjectST_XLS.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_group_ST_most_likely_to_be_erased.xlsx'];
				case 10 % ExporterGroupSubjectST_XLS.PUT_FILE
					prop_default = Format.getFormatDefault(8, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 11 % ExporterGroupSubjectST_XLS.SAVE
					prop_default = Format.getFormatDefault(1, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 1 % ExporterGroupSubjectST_XLS.NAME
					prop_default = 'ExporterGroupSubjectST_XLS';
				case 2 % ExporterGroupSubjectST_XLS.DESCRIPTION
					prop_default = 'ExporterGroupSubjectST_XLS exports a group of subjects with structural data and their covariates (if existing) to another XLSX file.';
				case 3 % ExporterGroupSubjectST_XLS.TEMPLATE
					prop_default = Format.getFormatDefault(8, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 4 % ExporterGroupSubjectST_XLS.ID
					prop_default = 'ExporterGroupSubjectST_XLS ID';
				case 5 % ExporterGroupSubjectST_XLS.LABEL
					prop_default = 'ExporterGroupSubjectST_XLS label';
				case 6 % ExporterGroupSubjectST_XLS.NOTES
					prop_default = 'ExporterGroupSubjectST_XLS notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_XLS.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectST_XLS.conditioning(prop, ExporterGroupSubjectST_XLS.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EX.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EX.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EX.
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_XLS.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_XLS.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ExporterGroupSubjectST_XLS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: BRAPH2:ExporterGroupSubjectST_XLS:WrongInput
			%  Element.CHECKPROP(ExporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_XLS.
			%   Error id: BRAPH2:ExporterGroupSubjectST_XLS:WrongInput
			%  EX.CHECKPROP(ExporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_XLS.
			%   Error id: BRAPH2:ExporterGroupSubjectST_XLS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case 8 % ExporterGroupSubjectST_XLS.GR
					check = Format.checkFormat(8, value, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 9 % ExporterGroupSubjectST_XLS.FILE
					check = Format.checkFormat(2, value, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 10 % ExporterGroupSubjectST_XLS.PUT_FILE
					check = Format.checkFormat(8, value, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 11 % ExporterGroupSubjectST_XLS.SAVE
					check = Format.checkFormat(1, value, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				case 3 % ExporterGroupSubjectST_XLS.TEMPLATE
					check = Format.checkFormat(8, value, ExporterGroupSubjectST_XLS.getPropSettings(prop));
				otherwise
					if prop <= 7
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectST_XLS.getPropTag(prop) ' (' ExporterGroupSubjectST_XLS.getFormatTag(ExporterGroupSubjectST_XLS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ex, prop, varargin)
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
				case 10 % ExporterGroupSubjectST_XLS.PUT_FILE
					[filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
					if filterindex
					    file = [filepath filename];
					    ex.set('FILE', file);
					end
					value = ex;
					
				case 11 % ExporterGroupSubjectST_XLS.SAVE
					rng_settings_ = rng(); rng(ex.getPropSeed(11), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
					    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					    
					    gr = ex.get('GR');
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.get('LENGTH');
					    
						braph2waitbar(wb, .15, 'Organizing info ...')
					    
					    if sub_number == 0
					        tab = {'ID', 'Label', 'Notes'};
					    else
					        sub = sub_dict.get('IT', 1);
					        ba = sub.get('BA');
					        br_list = cellfun(@(i) ba.get('BR_DICT').get('IT', i), ...
					            num2cell([1:1:ba.get('BR_DICT').get('LENGTH')]), 'UniformOutput', false);
					        br_labels = cellfun(@(br) br.get('ID'), br_list, 'UniformOutput', false);
					        
					        tab = cell(1 + sub_number, 3 + numel(br_labels));
					        tab{1, 1} = 'ID';
					        tab{1, 2} = 'Label';
					        tab{1, 3} = 'Notes';
					        for j = 1:1:length(br_labels)
					            tab{1, 3 + j} = br_labels{j};
					        end
					
					        for i = 1:1:sub_number
					            sub = sub_dict.get('IT', i);
					
					            tab{1 + i, 1} = sub.get('ID');
					            tab{1 + i, 2} = sub.get('LABEL');
					            tab{1 + i, 3} = sub.get('NOTES');
					            
					            sub_ST = sub.get('ST');
					            for j = 1:1:length(sub_ST)
					                tab{1 + i, 3 + j} = sub_ST(j);
					            end
					        end
					    end
					    
					    % save
						braph2waitbar(wb, 1, 'Finalizing ...')
					        
					    writetable(table(tab), file, 'WriteVariableNames', false);
					
					    % variables of interest
					    voi_ids = {};
					    for i = 1:1:sub_number
					        sub = sub_dict.get('IT', i);
					        voi_ids = unique([voi_ids, sub.get('VOI_DICT').get('KEYS')]);
					    end
					    if ~isempty(voi_ids)
					        vois = cell(2 + sub_number, 1 + length(voi_ids));
					        vois{1, 1} = 'Subject ID';
					        vois(1, 2:end) = voi_ids;
					        for i = 1:1:sub_number
					            sub = sub_dict.get('IT', i);
					            vois{2 + i, 1} = sub.get('ID');
					            
					            voi_dict = sub.get('VOI_DICT');
					            for v = 1:1:voi_dict.get('LENGTH')
					                voi = voi_dict.get('IT', v);
					                voi_id = voi.get('ID');
					                if isa(voi, 'VOINumeric') % Numeric
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = voi.get('V');
					                elseif isa(voi, 'VOICategoric') % Categoric
					                    categories = voi.get('CATEGORIES');
					                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = cell2str(categories);
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
					                end
					            end
					        end
					        [dir, name, ext] = fileparts(file);
					        writetable(table(vois), [dir filesep() name '.vois.xlsx'], 'WriteVariableNames', false)
					    end
					    
					    braph2waitbar(wb, 'close')
					end
					
					% sets value to empty
					value = [];
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 7
						value = calculateValue@Exporter(ex, prop, varargin{:});
					else
						value = calculateValue@Element(ex, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(ex, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(ex) ' ' ex.getPropTag(prop) '.'];
			
			switch prop
				case 8 % ExporterGroupSubjectST_XLS.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectST', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 7
						[check, msg] = checkValue@Exporter(ex, prop, value);
					end
			end
		end
	end
end