classdef ImporterGroupSubjectCON_XLS < Importer
	%ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity data from a series of XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity 
	%  data from a series of XLS/XLSX files contained in a folder named "GROUP_ID". 
	%  All these files must be in the same folder; also, no other files should be 
	%  in the folder. Each file contains a table of values corresponding to the 
	%  adjacency matrix.
	% The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ImporterGroupSubjectCON_XLS methods (constructor):
	%  ImporterGroupSubjectCON_XLS - constructor
	%
	% ImporterGroupSubjectCON_XLS methods:
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
	% ImporterGroupSubjectCON_XLS methods (display):
	%  tostring - string with information about the importer of CON subject group from XLS/XLSX
	%  disp - displays information about the importer of CON subject group from XLS/XLSX
	%  tree - displays the tree of the importer of CON subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_XLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of CON subject group from XLS/XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of CON subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_XLS methods (save/load, Static):
	%  save - saves BRAPH2 importer of CON subject group from XLS/XLSX as b2 file
	%  load - loads a BRAPH2 importer of CON subject group from XLS/XLSX from a b2 file
	%
	% ImporterGroupSubjectCON_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of CON subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_XLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of CON subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_XLS methods (inspection, Static):
	%  getClass - returns the class of the importer of CON subject group from XLS/XLSX
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectCON_XLS
	%  getProps - returns the property list of the importer of CON subject group from XLS/XLSX
	%  getPropNumber - returns the property number of the importer of CON subject group from XLS/XLSX
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
	% ImporterGroupSubjectCON_XLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectCON_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectCON_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectCON_XLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectCON_XLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectCON_XLS constants</a>.
	%
	%
	% See also Group, SubjectCON, ExporterGroupSubjectCON_XLS.
	
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
		function im = ImporterGroupSubjectCON_XLS(varargin)
			%ImporterGroupSubjectCON_XLS() creates a importer of CON subject group from XLS/XLSX.
			%
			% ImporterGroupSubjectCON_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectCON_XLS(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the importer of CON subject group from XLS/XLSX.
			%
			% CLASS = ImporterGroupSubjectCON_XLS.GETCLASS() returns the class 'ImporterGroupSubjectCON_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of CON subject group from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectCON_XLS') returns 'ImporterGroupSubjectCON_XLS'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectCON_XLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of CON subject group from XLS/XLSX.
			%
			% LIST = ImporterGroupSubjectCON_XLS.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectCON_XLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of CON subject group from XLS/XLSX IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectCON_XLS') returns all subclasses of 'ImporterGroupSubjectCON_XLS'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterGroupSubjectCON_XLS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of CON subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectCON_XLS.GETPROPS() returns the property list of importer of CON subject group from XLS/XLSX
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectCON_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of CON subject group from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectCON_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectCON_XLS'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjectCON_XLS.DIRECTORY ...
						ImporterGroupSubjectCON_XLS.GET_DIR ...
						ImporterGroupSubjectCON_XLS.BA ...
						ImporterGroupSubjectCON_XLS.GR ...
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
						ImporterGroupSubjectCON_XLS.DIRECTORY ...
						ImporterGroupSubjectCON_XLS.BA ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjectCON_XLS.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjectCON_XLS.GET_DIR ...
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
			%GETPROPNUMBER returns the property number of importer of CON subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectCON_XLS.GETPROPNUMBER() returns the property number of importer of CON subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectCON_XLS.GETPROPNUMBER(CATEGORY) returns the property number of importer of CON subject group from XLS/XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of CON subject group from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectCON_XLS') returns the property number of 'ImporterGroupSubjectCON_XLS'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterGroupSubjectCON_XLS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of CON subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectCON_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectCON_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectCON_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectCON_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectCON_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterGroupSubjectCON_XLS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectCON_XLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of CON subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectCON_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectCON_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectCON_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectCON_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectCON_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_XLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importergroupsubjectcon_xls_tag_list = cellfun(@(x) ImporterGroupSubjectCON_XLS.getPropTag(x), num2cell(ImporterGroupSubjectCON_XLS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjectcon_xls_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectCON_XLS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectCON_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectCON_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importergroupsubjectcon_xls_tag_list = cellfun(@(x) ImporterGroupSubjectCON_XLS.getPropTag(x), num2cell(ImporterGroupSubjectCON_XLS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjectcon_xls_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectCON_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectCON_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjectCON_XLS.DIRECTORY
						tag = ImporterGroupSubjectCON_XLS.DIRECTORY_TAG;
					case ImporterGroupSubjectCON_XLS.GET_DIR
						tag = ImporterGroupSubjectCON_XLS.GET_DIR_TAG;
					case ImporterGroupSubjectCON_XLS.BA
						tag = ImporterGroupSubjectCON_XLS.BA_TAG;
					case ImporterGroupSubjectCON_XLS.GR
						tag = ImporterGroupSubjectCON_XLS.GR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectCON_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectCON_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY
					prop_category = ImporterGroupSubjectCON_XLS.DIRECTORY_CATEGORY;
				case ImporterGroupSubjectCON_XLS.GET_DIR
					prop_category = ImporterGroupSubjectCON_XLS.GET_DIR_CATEGORY;
				case ImporterGroupSubjectCON_XLS.BA
					prop_category = ImporterGroupSubjectCON_XLS.BA_CATEGORY;
				case ImporterGroupSubjectCON_XLS.GR
					prop_category = ImporterGroupSubjectCON_XLS.GR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectCON_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectCON_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY
					prop_format = ImporterGroupSubjectCON_XLS.DIRECTORY_FORMAT;
				case ImporterGroupSubjectCON_XLS.GET_DIR
					prop_format = ImporterGroupSubjectCON_XLS.GET_DIR_FORMAT;
				case ImporterGroupSubjectCON_XLS.BA
					prop_format = ImporterGroupSubjectCON_XLS.BA_FORMAT;
				case ImporterGroupSubjectCON_XLS.GR
					prop_format = ImporterGroupSubjectCON_XLS.GR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectCON_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectCON_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory containing the CON subject group files from which to load the subject group.';
				case ImporterGroupSubjectCON_XLS.GET_DIR
					prop_description = 'GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the CON subject group.';
				case ImporterGroupSubjectCON_XLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectCON_XLS.GR
					prop_description = 'GR (result, item) is a group of subjects with connectivity data.';
				case ImporterGroupSubjectCON_XLS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ImporterGroupSubjectCON_XLS.NAME
					prop_description = 'NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectCON_XLS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the CON subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectCON_XLS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the CON subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectCON_XLS.ID
					prop_description = 'ID (data, string) is a few-letter code for the CON subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectCON_XLS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the CON subject group importer from XLS/XLSX.';
				case ImporterGroupSubjectCON_XLS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the CON subject group importer from XLS/XLSX.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectCON_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectCON_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectCON_XLS.GET_DIR
					prop_settings = 'ImporterGroupSubjectCON_XLS';
				case ImporterGroupSubjectCON_XLS.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectCON_XLS.GR
					prop_settings = 'Group';
				case ImporterGroupSubjectCON_XLS.TEMPLATE
					prop_settings = 'ImporterGroupSubjectCON_XLS';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectCON_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectCON_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ImporterGroupSubjectCON_XLS.GET_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case ImporterGroupSubjectCON_XLS.ELCLASS
					prop_default = 'ImporterGroupSubjectCON_XLS';
				case ImporterGroupSubjectCON_XLS.NAME
					prop_default = 'ImporterGroupSubjectCON_XLS';
				case ImporterGroupSubjectCON_XLS.DESCRIPTION
					prop_default = 'ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity data from a series of XLS/XLSX file. The variables of interest can be loaded from another XLS/XLSX file.';
				case ImporterGroupSubjectCON_XLS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.ID
					prop_default = 'ImporterGroupSubjectCON_XLS ID';
				case ImporterGroupSubjectCON_XLS.LABEL
					prop_default = 'ImporterGroupSubjectCON_XLS label';
				case ImporterGroupSubjectCON_XLS.NOTES
					prop_default = 'ImporterGroupSubjectCON_XLS notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_XLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectCON_XLS.conditioning(prop, ImporterGroupSubjectCON_XLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectCON_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectCON_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjectCON_XLS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectCON_XLS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjectCON_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_XLS.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectCON_XLS:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjectCON_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_XLS.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectCON_XLS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectCON_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectCON_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_XLS.DIRECTORY % __ImporterGroupSubjectCON_XLS.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.GET_DIR % __ImporterGroupSubjectCON_XLS.GET_DIR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.BA % __ImporterGroupSubjectCON_XLS.BA__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.GR % __ImporterGroupSubjectCON_XLS.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_XLS.TEMPLATE % __ImporterGroupSubjectCON_XLS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_XLS.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectCON_XLS.getPropTag(prop) ' (' ImporterGroupSubjectCON_XLS.getFormatTag(ImporterGroupSubjectCON_XLS.getPropFormat(prop)) ').'] ...
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
				case ImporterGroupSubjectCON_XLS.GET_DIR % __ImporterGroupSubjectCON_XLS.GET_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case ImporterGroupSubjectCON_XLS.GR % __ImporterGroupSubjectCON_XLS.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjectCON_XLS.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					directory = im.get('DIRECTORY');
					if isfolder(directory)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					    
					    [~, gr_name] = fileparts(directory);
					    gr.set( ...
					        'ID', gr_name, ...
					        'LABEL', gr_name, ...
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
					                br_number = size(xlsread(fullfile(directory, files(1).name)), 1);
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
					                
					                CON = xlsread(fullfile(directory, files(i).name));
					                if size(CON, 1) ~= ba.get('BR_DICT').get('LENGTH') || size(CON, 2) ~= ba.get('BR_DICT').get('LENGTH')
					                    error( ...
					                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
					                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\n' ...
					                        'The file ' sub_id ' should contain a matrix ' int2str(ba.get('BR_DICT').get('LENGTH')) 'x' int2str(ba.get('BR_DICT').get('LENGTH')) ', ' ...
					                        'while it is ' int2str(size(CON, 1)) 'x' int2str(size(CON, 2)) '.'] ...
					                        )
					                end
					                
					                sub = SubjectCON( ...
					                    'ID', sub_id, ...
					                    'BA', ba, ...
					                    'CON', CON ...
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
					    error([BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO], ...
					        [BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.ERR_IO '\n' ...
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
				case ImporterGroupSubjectCON_XLS.GR % __ImporterGroupSubjectCON_XLS.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
