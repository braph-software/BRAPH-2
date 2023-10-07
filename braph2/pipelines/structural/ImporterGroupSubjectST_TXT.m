classdef ImporterGroupSubjectST_TXT < Importer
	%ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectST_XLS imports a group of subjects with structural data 
	%  from a TXT file named "GROUP_ID.txt". This file contains the 
	%  following columns: Subject ID (column 1), Subject LABEL (column 2), 
	%  Subject NOTES (column 3) and BrainRegions (columns 4-end; one brainregion 
	%  value per column). The first row contains the headers and each subsequent 
	%  row the values for each subject.
	% The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
	%  (if existing) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ImporterGroupSubjectST_TXT methods (constructor):
	%  ImporterGroupSubjectST_TXT - constructor
	%
	% ImporterGroupSubjectST_TXT methods:
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
	% ImporterGroupSubjectST_TXT methods (display):
	%  tostring - string with information about the importer of ST subject group from TXT
	%  disp - displays information about the importer of ST subject group from TXT
	%  tree - displays the tree of the importer of ST subject group from TXT
	%
	% ImporterGroupSubjectST_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of ST subject group from TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of ST subject group from TXT
	%
	% ImporterGroupSubjectST_TXT methods (save/load, Static):
	%  save - saves BRAPH2 importer of ST subject group from TXT as b2 file
	%  load - loads a BRAPH2 importer of ST subject group from TXT from a b2 file
	%
	% ImporterGroupSubjectST_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of ST subject group from TXT
	%
	% ImporterGroupSubjectST_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of ST subject group from TXT
	%
	% ImporterGroupSubjectST_TXT methods (inspection, Static):
	%  getClass - returns the class of the importer of ST subject group from TXT
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectST_TXT
	%  getProps - returns the property list of the importer of ST subject group from TXT
	%  getPropNumber - returns the property number of the importer of ST subject group from TXT
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
	% ImporterGroupSubjectST_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectST_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectST_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectST_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectST_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectST_TXT constants</a>.
	%
	%
	% See also Group, SubjectST, ExporterGroupSubjectST_TXT.
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		GET_FILE = Importer.getPropNumber() + 2;
		GET_FILE_TAG = 'GET_FILE';
		GET_FILE_CATEGORY = Category.QUERY;
		GET_FILE_FORMAT = Format.ITEM;
		
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
		function im = ImporterGroupSubjectST_TXT(varargin)
			%ImporterGroupSubjectST_TXT() creates a importer of ST subject group from TXT.
			%
			% ImporterGroupSubjectST_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectST_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the importer of ST subject group from TXT.
			%
			% CLASS = ImporterGroupSubjectST_TXT.GETCLASS() returns the class 'ImporterGroupSubjectST_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of ST subject group from TXT IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectST_TXT') returns 'ImporterGroupSubjectST_TXT'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectST_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of ST subject group from TXT.
			%
			% LIST = ImporterGroupSubjectST_TXT.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectST_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of ST subject group from TXT IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectST_TXT') returns all subclasses of 'ImporterGroupSubjectST_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterGroupSubjectST_TXT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of ST subject group from TXT.
			%
			% PROPS = ImporterGroupSubjectST_TXT.GETPROPS() returns the property list of importer of ST subject group from TXT
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectST_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of ST subject group from TXT IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectST_TXT'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectST_TXT'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjectST_TXT.FILE ...
						ImporterGroupSubjectST_TXT.GET_FILE ...
						ImporterGroupSubjectST_TXT.BA ...
						ImporterGroupSubjectST_TXT.GR ...
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
						ImporterGroupSubjectST_TXT.FILE ...
						ImporterGroupSubjectST_TXT.BA ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjectST_TXT.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjectST_TXT.GET_FILE ...
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
			%GETPROPNUMBER returns the property number of importer of ST subject group from TXT.
			%
			% N = ImporterGroupSubjectST_TXT.GETPROPNUMBER() returns the property number of importer of ST subject group from TXT.
			%
			% N = ImporterGroupSubjectST_TXT.GETPROPNUMBER(CATEGORY) returns the property number of importer of ST subject group from TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of ST subject group from TXT IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectST_TXT') returns the property number of 'ImporterGroupSubjectST_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterGroupSubjectST_TXT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of ST subject group from TXT/error.
			%
			% CHECK = ImporterGroupSubjectST_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectST_TXT, PROP) checks whether PROP exists for ImporterGroupSubjectST_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectST_TXT, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectST_TXT.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterGroupSubjectST_TXT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectST_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of ST subject group from TXT/error.
			%
			% CHECK = ImporterGroupSubjectST_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectST_TXT, TAG) checks whether TAG exists for ImporterGroupSubjectST_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectST_TXT, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectST_TXT.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importergroupsubjectst_txt_tag_list = cellfun(@(x) ImporterGroupSubjectST_TXT.getPropTag(x), num2cell(ImporterGroupSubjectST_TXT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjectst_txt_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectST_TXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectST_TXT, POINTER) returns property number of POINTER of ImporterGroupSubjectST_TXT.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectST_TXT, POINTER) returns property number of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importergroupsubjectst_txt_tag_list = cellfun(@(x) ImporterGroupSubjectST_TXT.getPropTag(x), num2cell(ImporterGroupSubjectST_TXT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjectst_txt_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectST_TXT, POINTER) returns tag of POINTER of ImporterGroupSubjectST_TXT.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectST_TXT, POINTER) returns tag of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjectST_TXT.FILE
						tag = ImporterGroupSubjectST_TXT.FILE_TAG;
					case ImporterGroupSubjectST_TXT.GET_FILE
						tag = ImporterGroupSubjectST_TXT.GET_FILE_TAG;
					case ImporterGroupSubjectST_TXT.BA
						tag = ImporterGroupSubjectST_TXT.BA_TAG;
					case ImporterGroupSubjectST_TXT.GR
						tag = ImporterGroupSubjectST_TXT.GR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectST_TXT, POINTER) returns category of POINTER of ImporterGroupSubjectST_TXT.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectST_TXT, POINTER) returns category of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE
					prop_category = ImporterGroupSubjectST_TXT.FILE_CATEGORY;
				case ImporterGroupSubjectST_TXT.GET_FILE
					prop_category = ImporterGroupSubjectST_TXT.GET_FILE_CATEGORY;
				case ImporterGroupSubjectST_TXT.BA
					prop_category = ImporterGroupSubjectST_TXT.BA_CATEGORY;
				case ImporterGroupSubjectST_TXT.GR
					prop_category = ImporterGroupSubjectST_TXT.GR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectST_TXT, POINTER) returns format of POINTER of ImporterGroupSubjectST_TXT.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectST_TXT, POINTER) returns format of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE
					prop_format = ImporterGroupSubjectST_TXT.FILE_FORMAT;
				case ImporterGroupSubjectST_TXT.GET_FILE
					prop_format = ImporterGroupSubjectST_TXT.GET_FILE_FORMAT;
				case ImporterGroupSubjectST_TXT.BA
					prop_format = ImporterGroupSubjectST_TXT.BA_FORMAT;
				case ImporterGroupSubjectST_TXT.GR
					prop_format = ImporterGroupSubjectST_TXT.GR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectST_TXT, POINTER) returns description of POINTER of ImporterGroupSubjectST_TXT.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectST_TXT, POINTER) returns description of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE
					prop_description = 'FILE (data, string) is the TXT file from where to load the ST subject group.';
				case ImporterGroupSubjectST_TXT.GET_FILE
					prop_description = 'GET_FILE (query, item) opens a dialog box to set the TXT file from where to load the ST subject group.';
				case ImporterGroupSubjectST_TXT.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectST_TXT.GR
					prop_description = 'GR (result, item) is a group of subjects with structural data.';
				case ImporterGroupSubjectST_TXT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ImporterGroupSubjectST_TXT.NAME
					prop_description = 'NAME (constant, string) is the name of the ST subject group importer from TXT.';
				case ImporterGroupSubjectST_TXT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ST subject group importer from TXT.';
				case ImporterGroupSubjectST_TXT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ST subject group importer from TXT.';
				case ImporterGroupSubjectST_TXT.ID
					prop_description = 'ID (data, string) is a few-letter code for the ST subject group importer from TXT.';
				case ImporterGroupSubjectST_TXT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ST subject group importer from TXT.';
				case ImporterGroupSubjectST_TXT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ST subject group importer from TXT.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectST_TXT, POINTER) returns settings of POINTER of ImporterGroupSubjectST_TXT.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectST_TXT, POINTER) returns settings of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectST_TXT.GET_FILE
					prop_settings = 'ImporterGroupSubjectST_TXT';
				case ImporterGroupSubjectST_TXT.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectST_TXT.GR
					prop_settings = 'Group';
				case ImporterGroupSubjectST_TXT.TEMPLATE
					prop_settings = 'ImporterGroupSubjectST_TXT';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectST_TXT, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_TXT.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectST_TXT, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE
					prop_default = '';
				case ImporterGroupSubjectST_TXT.GET_FILE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case ImporterGroupSubjectST_TXT.ELCLASS
					prop_default = 'ImporterGroupSubjectST_TXT';
				case ImporterGroupSubjectST_TXT.NAME
					prop_default = 'ImporterGroupSubjectST_TXT';
				case ImporterGroupSubjectST_TXT.DESCRIPTION
					prop_default = 'ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.';
				case ImporterGroupSubjectST_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.ID
					prop_default = 'ImporterGroupSubjectST_TXT ID';
				case ImporterGroupSubjectST_TXT.LABEL
					prop_default = 'ImporterGroupSubjectST_TXT label';
				case ImporterGroupSubjectST_TXT.NOTES
					prop_default = 'ImporterGroupSubjectST_TXT notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_TXT, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_TXT.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_TXT, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectST_TXT.conditioning(prop, ImporterGroupSubjectST_TXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectST_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_TXT.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectST_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_TXT.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjectST_TXT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_TXT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjectST_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_TXT.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_TXT:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjectST_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_TXT.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_TXT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectST_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectST_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_TXT.FILE % __ImporterGroupSubjectST_TXT.FILE__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.GET_FILE % __ImporterGroupSubjectST_TXT.GET_FILE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.BA % __ImporterGroupSubjectST_TXT.BA__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.GR % __ImporterGroupSubjectST_TXT.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_TXT.TEMPLATE % __ImporterGroupSubjectST_TXT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_TXT.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectST_TXT.getPropTag(prop) ' (' ImporterGroupSubjectST_TXT.getFormatTag(ImporterGroupSubjectST_TXT.getPropFormat(prop)) ').'] ...
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
				case ImporterGroupSubjectST_TXT.GET_FILE % __ImporterGroupSubjectST_TXT.GET_FILE__
					[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
					if filterindex
					    file = [filepath filename];
						im.set('FILE', file);
					end
					value = im;
					
				case ImporterGroupSubjectST_TXT.GR % __ImporterGroupSubjectST_TXT.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjectST_TXT.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					% analyzes file
					file = im.get('FILE');
					if isfile(file)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
					    
					    [~, name, ext] = fileparts(file);
					    gr.set( ...
					        'ID', name, ...
					        'LABEL', [name ext], ...
					        'NOTES', ['Group loaded from ' file] ...
					        );
					    
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...')
					
					        raw = readtable(file, 'Delimiter', '	');
					        
					        % brain atlas
					        braph2waitbar(wb, .25, 'Loading brain atlas ...')
					        ba = im.get('BA');
					        br_number = size(raw, 2) - 3;
					        if ba.get('BR_DICT').get('LENGTH') == 0
					            ba = BrainAtlas();
					            br_dict = ba.memorize('BR_DICT');
					            for j = 4:1:size(raw, 2)
					                br_id = raw.Properties.VariableNames{j};
					                br = BrainRegion('ID', br_id);
					                br_dict.get('ADD', br)
					            end
					        end
					        if br_number ~= ba.get('BR_DICT').get('LENGTH')
					            error( ...
					                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
					                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\n' ...
					                'The file ' name '.' ext ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
					                'while it contains ' int2str(br_number) ' columns.'] ...
					                )
					        end
					                
					        % adds subjects
					        sub_dict = gr.memorize('SUB_DICT');
					        for i = 1:1:size(raw, 1)
					            braph2waitbar(wb, .25 + .75 * i / size(raw, 1), ['Loading subject ' num2str(i) ' of ' num2str(size(raw, 1)) ' ...'])
					            
					            ST = zeros(br_number, 1);
					            for j = 1:1:length(ST)
					                ST(j) = raw{i, 3 + j};
					            end
					            sub = SubjectST( ...
					                'ID', char(raw{i, 1}), ...
					                'LABEL', char(raw{i, 2}), ...
					                'NOTES', char(raw{i, 3}), ...
					                'BA', ba, ...
					                'ST', ST ...
					                );
					            sub_dict.get('ADD', sub);
					        end
					        
					        % variables of interest
					        if isfile([fileparts(file) filesep() name  '.vois.txt'])
					            vois = textread([fileparts(file) filesep() name  '.vois.txt'], '%s', 'delimiter', '	', 'whitespace', '');
					            vois = reshape(vois, find(strcmp('', vois), 1) - 1, [])';
					            for i = 3:1:size(vois, 1)
					                sub_id = vois{i, 1};
					                sub = sub_dict.get('IT', sub_id);
					                for v = 2:1:size(vois, 2)
					                    voi_id = vois{1, v};
					                    if isempty(vois{2, v}) % VOINumeric
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOINumeric( ...
					                                'ID', voi_id, ...
					                                'V', str2num(vois{i, v}) ...
					                                ) ...
					                            );
					                    elseif ~isempty(vois{2, v}) % VOICategoric
					                        categories = eval(vois{2, v});
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOICategoric( ...
					                                'ID', voi_id, ...
					                                'CATEGORIES', str2cell(categories), ...
					                                'V', find(strcmp(vois{i, v}, categories)) ...
					                                ) ...
					                            );
					                    end                        
					                end
					            end
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					        
					        rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					elseif ~isempty(file)
					    error([BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO], ...
					        [BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO '\n' ...
					        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
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
				case ImporterGroupSubjectST_TXT.GR % __ImporterGroupSubjectST_TXT.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
