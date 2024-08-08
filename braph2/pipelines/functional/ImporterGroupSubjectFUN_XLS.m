classdef ImporterGroupSubjectFUN_XLS < Importer
	%ImporterGroupSubjectFUN_XLS imports a group of subjects with functional data from a series of XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectFUN_XLS imports a group of subjects with functional 
	%  data from a series of XLS/XLSX files contained in a folder named "GROUP_ID". 
	%  All these files must be in the same folder; also, no other files should be 
	%  in the folder. Each file contains a table with each row correspoding to a 
	%  time serie and each column to a brain region.
	% The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ImporterGroupSubjectFUN_XLS methods (constructor):
	%  ImporterGroupSubjectFUN_XLS - constructor
	%
	% ImporterGroupSubjectFUN_XLS methods:
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
	% ImporterGroupSubjectFUN_XLS methods (display):
	%  tostring - string with information about the importer of FUN subject group from XLS/XLSX
	%  disp - displays information about the importer of FUN subject group from XLS/XLSX
	%  tree - displays the tree of the importer of FUN subject group from XLS/XLSX
	%
	% ImporterGroupSubjectFUN_XLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of FUN subject group from XLS/XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of FUN subject group from XLS/XLSX
	%
	% ImporterGroupSubjectFUN_XLS methods (save/load, Static):
	%  save - saves BRAPH2 importer of FUN subject group from XLS/XLSX as b2 file
	%  load - loads a BRAPH2 importer of FUN subject group from XLS/XLSX from a b2 file
	%
	% ImporterGroupSubjectFUN_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of FUN subject group from XLS/XLSX
	%
	% ImporterGroupSubjectFUN_XLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of FUN subject group from XLS/XLSX
	%
	% ImporterGroupSubjectFUN_XLS methods (inspection, Static):
	%  getClass - returns the class of the importer of FUN subject group from XLS/XLSX
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectFUN_XLS
	%  getProps - returns the property list of the importer of FUN subject group from XLS/XLSX
	%  getPropNumber - returns the property number of the importer of FUN subject group from XLS/XLSX
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
	% ImporterGroupSubjectFUN_XLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectFUN_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectFUN_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectFUN_XLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectFUN_XLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectFUN_XLS constants</a>.
	%
	%
	% See also Group, SubjectFUN, ExporterGroupSubjectFUN_XLS.
	
	properties (Constant) % properties
		DIRECTORY = Importer.getPropNumber() + 1;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		GET_DIR = Importer.getPropNumber() + 2;
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = Category.QUERY;
		GET_DIR_FORMAT = Format.ITEM;
		
		BA = Importer.getPropNumber() + 3;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		GR = Importer.getPropNumber() + 4;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
	end
	methods % constructor
		function im = ImporterGroupSubjectFUN_XLS(varargin)
			%ImporterGroupSubjectFUN_XLS() creates a importer of FUN subject group from XLS/XLSX.
			%
			% ImporterGroupSubjectFUN_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectFUN_XLS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function im_class = getClass()
			%GETCLASS returns the class of the importer of FUN subject group from XLS/XLSX.
			%
			% CLASS = ImporterGroupSubjectFUN_XLS.GETCLASS() returns the class 'ImporterGroupSubjectFUN_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of FUN subject group from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectFUN_XLS') returns 'ImporterGroupSubjectFUN_XLS'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectFUN_XLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of FUN subject group from XLS/XLSX.
			%
			% LIST = ImporterGroupSubjectFUN_XLS.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectFUN_XLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of FUN subject group from XLS/XLSX IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectFUN_XLS') returns all subclasses of 'ImporterGroupSubjectFUN_XLS'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterGroupSubjectFUN_XLS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of FUN subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectFUN_XLS.GETPROPS() returns the property list of importer of FUN subject group from XLS/XLSX
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectFUN_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of FUN subject group from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectFUN_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectFUN_XLS'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjectFUN_XLS.DIRECTORY ...
						ImporterGroupSubjectFUN_XLS.GET_DIR ...
						ImporterGroupSubjectFUN_XLS.BA ...
						ImporterGroupSubjectFUN_XLS.GR ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Importer.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Importer.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Importer.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Importer.getProps(Category.DATA) ...
						ImporterGroupSubjectFUN_XLS.DIRECTORY ...
						ImporterGroupSubjectFUN_XLS.BA ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjectFUN_XLS.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjectFUN_XLS.GET_DIR ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Importer.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Importer.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Importer.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer of FUN subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectFUN_XLS.GETPROPNUMBER() returns the property number of importer of FUN subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectFUN_XLS.GETPROPNUMBER(CATEGORY) returns the property number of importer of FUN subject group from XLS/XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of FUN subject group from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectFUN_XLS') returns the property number of 'ImporterGroupSubjectFUN_XLS'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterGroupSubjectFUN_XLS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of FUN subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectFUN_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectFUN_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectFUN_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectFUN_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterGroupSubjectFUN_XLS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectFUN_XLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of FUN subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectFUN_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectFUN_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectFUN_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectFUN_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importergroupsubjectfun_xls_tag_list = cellfun(@(x) ImporterGroupSubjectFUN_XLS.getPropTag(x), num2cell(ImporterGroupSubjectFUN_XLS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjectfun_xls_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectFUN_XLS.'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectFUN_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectFUN_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectFUN_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importergroupsubjectfun_xls_tag_list = cellfun(@(x) ImporterGroupSubjectFUN_XLS.getPropTag(x), num2cell(ImporterGroupSubjectFUN_XLS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjectfun_xls_tag_list)); % tag = pointer
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectFUN_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectFUN_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectFUN_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjectFUN_XLS.DIRECTORY
						tag = ImporterGroupSubjectFUN_XLS.DIRECTORY_TAG;
					case ImporterGroupSubjectFUN_XLS.GET_DIR
						tag = ImporterGroupSubjectFUN_XLS.GET_DIR_TAG;
					case ImporterGroupSubjectFUN_XLS.BA
						tag = ImporterGroupSubjectFUN_XLS.BA_TAG;
					case ImporterGroupSubjectFUN_XLS.GR
						tag = ImporterGroupSubjectFUN_XLS.GR_TAG;
					otherwise
						tag = getPropTag@Importer(prop);
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectFUN_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectFUN_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectFUN_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY
					prop_category = ImporterGroupSubjectFUN_XLS.DIRECTORY_CATEGORY;
				case ImporterGroupSubjectFUN_XLS.GET_DIR
					prop_category = ImporterGroupSubjectFUN_XLS.GET_DIR_CATEGORY;
				case ImporterGroupSubjectFUN_XLS.BA
					prop_category = ImporterGroupSubjectFUN_XLS.BA_CATEGORY;
				case ImporterGroupSubjectFUN_XLS.GR
					prop_category = ImporterGroupSubjectFUN_XLS.GR_CATEGORY;
				otherwise
					prop_category = getPropCategory@Importer(prop);
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectFUN_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectFUN_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectFUN_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY
					prop_format = ImporterGroupSubjectFUN_XLS.DIRECTORY_FORMAT;
				case ImporterGroupSubjectFUN_XLS.GET_DIR
					prop_format = ImporterGroupSubjectFUN_XLS.GET_DIR_FORMAT;
				case ImporterGroupSubjectFUN_XLS.BA
					prop_format = ImporterGroupSubjectFUN_XLS.BA_FORMAT;
				case ImporterGroupSubjectFUN_XLS.GR
					prop_format = ImporterGroupSubjectFUN_XLS.GR_FORMAT;
				otherwise
					prop_format = getPropFormat@Importer(prop);
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectFUN_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectFUN_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectFUN_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory containing the FUN subject group files from which to load the subject group.';
				case ImporterGroupSubjectFUN_XLS.GET_DIR
					prop_description = 'GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN subject group.';
				case ImporterGroupSubjectFUN_XLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectFUN_XLS.GR
					prop_description = 'GR (result, item) is a group of subjects with functional data.';
				case ImporterGroupSubjectFUN_XLS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.NAME
					prop_description = 'NAME (constant, string) is the name of the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.ID
					prop_description = 'ID (data, string) is a few-letter code for the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the FUN subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectFUN_XLS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the FUN subject group importer from XLS/XLSX.';
				otherwise
					prop_description = getPropDescription@Importer(prop);
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectFUN_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectFUN_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectFUN_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectFUN_XLS.GET_DIR
					prop_settings = 'ImporterGroupSubjectFUN_XLS';
				case ImporterGroupSubjectFUN_XLS.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectFUN_XLS.GR
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectFUN_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectFUN_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectFUN_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectFUN_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectFUN_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ImporterGroupSubjectFUN_XLS.GET_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ImporterGroupSubjectFUN_XLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ImporterGroupSubjectFUN_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case ImporterGroupSubjectFUN_XLS.ELCLASS
					prop_default = 'ImporterGroupSubjectFUN_XLS';
				case ImporterGroupSubjectFUN_XLS.NAME
					prop_default = 'Functional Subject Group XLS Importer';
				case ImporterGroupSubjectFUN_XLS.DESCRIPTION
					prop_default = 'ImporterGroupSubjectFUN_XLS imports a group of subjects with functional data from a series of XLS/XLSX file and their covariates (optional) from another XLS/XLSX file.';
				case ImporterGroupSubjectFUN_XLS.ID
					prop_default = 'ImporterGroupSubjectFUN_XLS ID';
				case ImporterGroupSubjectFUN_XLS.LABEL
					prop_default = 'ImporterGroupSubjectFUN_XLS label';
				case ImporterGroupSubjectFUN_XLS.NOTES
					prop_default = 'ImporterGroupSubjectFUN_XLS notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectFUN_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectFUN_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectFUN_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectFUN_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectFUN_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectFUN_XLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectFUN_XLS.conditioning(prop, ImporterGroupSubjectFUN_XLS.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectFUN_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectFUN_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectFUN_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectFUN_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjectFUN_XLS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectFUN_XLS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjectFUN_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectFUN_XLS.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectFUN_XLS:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjectFUN_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectFUN_XLS.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectFUN_XLS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectFUN_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.DIRECTORY % __ImporterGroupSubjectFUN_XLS.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ImporterGroupSubjectFUN_XLS.GET_DIR % __ImporterGroupSubjectFUN_XLS.GET_DIR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ImporterGroupSubjectFUN_XLS.BA % __ImporterGroupSubjectFUN_XLS.BA__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ImporterGroupSubjectFUN_XLS.GR % __ImporterGroupSubjectFUN_XLS.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectFUN_XLS.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectFUN_XLS.getPropTag(prop) ' (' ImporterGroupSubjectFUN_XLS.getFormatTag(ImporterGroupSubjectFUN_XLS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop, varargin)
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
				case ImporterGroupSubjectFUN_XLS.GET_DIR % __ImporterGroupSubjectFUN_XLS.GET_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
						im.set('DIRECTORY', directory);
					end
					value = im;
					
				case ImporterGroupSubjectFUN_XLS.GR % __ImporterGroupSubjectFUN_XLS.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjectFUN_XLS.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectFUN', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					directory = im.get('DIRECTORY');
					if isfolder(directory)    
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					
					    [~, name] = fileparts(directory);
					    gr.set( ...
					        'ID', name, ...
					        'LABEL', name, ...
					        'NOTES', ['Group loaded from ' directory] ...
					        );
					
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...')
					
					        % analyzes file
					        files = [dir(fullfile(directory, '*.xlsx')); dir(fullfile(directory, '*.xls'))];
					
					        if ~isempty(files)
					            % brain atlas
					            ba = im.get('BA');
					            if ba.get('BR_DICT').get('LENGTH') == 0
					                % adds the number of regions of the first file to the brain atlas
					                br_number = size(xlsread(fullfile(directory, files(1).name)), 2);
					                br_dict = ba.memorize('BR_DICT');
					                for j = 1:1:br_number
					                    br_dict.get('ADD', BrainRegion('ID', ['br' int2str(j)]))
					                end
					            end
					
					            % adds subjects
					            sub_dict = gr.memorize('SUB_DICT');
					            for i = 1:1:length(files)
					                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])
					
					                % read file
					                [~, sub_id] = fileparts(files(i).name);
					
					                FUN = xlsread(fullfile(directory, files(i).name));
					                if size(FUN, 2) ~= ba.get('BR_DICT').get('LENGTH')
					                    error( ...
					                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
					                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\n' ...
					                        'The file ' sub_id ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
					                        'while it contains ' int2str(size(FUN, 2)) ' columns.'] ...
					                        )
					                end
					
					                sub = SubjectFUN( ...
					                    'ID', sub_id, ...
					                    'BA', ba, ...
					                    'FUN', FUN ...
					                    );
					                sub_dict.get('ADD', sub);
					            end
					            
					            % variables of interest
					            vois = [];
					            if isfile([directory '.vois.xls'])
					                [~, ~, vois] = xlsread([directory '.vois.xls']);
					            elseif isfile([directory '.vois.xlsx'])
					                [~, ~, vois] = xlsread([directory '.vois.xlsx']);
					            end
					            if ~isempty(vois)
					                for i = 3:1:size(vois, 1)
					                    sub_id = vois{i, 1};
					                    sub = sub_dict.get('IT', sub_id);
					                    for v = 2:1:size(vois, 2)
					                        voi_id = vois{1, v};
					                        if isnumeric(vois{2, v}) % VOINumeric
					                            sub.memorize('VOI_DICT').get('ADD', ...
					                                VOINumeric( ...
					                                    'ID', voi_id, ...
					                                    'V', vois{i, v} ...
					                                    ) ...
					                                );
					                        elseif ischar(vois{2, v}) % VOICategoric
					                            sub.memorize('VOI_DICT').get('ADD', ...
					                                VOICategoric( ...
					                                    'ID', voi_id, ...
					                                    'CATEGORIES', str2cell(vois{2, v}), ...
					                                    'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
					                                    ) ...
					                                );
					                        end                        
					                    end
					                end
					            end
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					        
					        rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					else
					    error([BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.ERR_IO], ...
					        [BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.ERR_IO '\n' ...
					        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
					        );
					end
					
					value = gr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Importer.getPropNumber()
						value = calculateValue@Importer(im, prop, varargin{:});
					else
						value = calculateValue@Element(im, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(im, prop, value)
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
			msg = ['Error while checking ' tostring(im) ' ' im.getPropTag(prop) '.'];
			
			switch prop
				case ImporterGroupSubjectFUN_XLS.GR % __ImporterGroupSubjectFUN_XLS.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
