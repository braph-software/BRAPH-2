classdef ImporterGroupSubjectST_MP_TXT < Importer
	%ImporterGroupSubjectST_MP_TXT imports a group of subjects with structural multiplex data from an TXT file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectST_MP_TXT imports a group of subjects with structural 
	%  multiplex data from a series of TXT files contained in a folder named 
	%  "GROUP_ID". All these files must be in the same folder; also, no other 
	%  files should be in the folder. Each file corresponds to a layer of the 
	%  multiplex and should be labeled with the layer number indicated as, e.g., 
	%  "GROUP_ID.1.txt" and "GROUP_ID.2.txt". 
	%  Each file contains the following columns: Subject ID (column 1), Subject 
	%  LABEL (column 2), Subject NOTES (column 3) and BrainRegions 
	%  (columns 4-end; one brain region value per column). The first row contains 
	%  the headers and each subsequent row the values for each subject.
	% The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ImporterGroupSubjectST_MP_TXT methods (constructor):
	%  ImporterGroupSubjectST_MP_TXT - constructor
	%
	% ImporterGroupSubjectST_MP_TXT methods:
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
	% ImporterGroupSubjectST_MP_TXT methods (display):
	%  tostring - string with information about the importer of ST MP subject group from TXT
	%  disp - displays information about the importer of ST MP subject group from TXT
	%  tree - displays the tree of the importer of ST MP subject group from TXT
	%
	% ImporterGroupSubjectST_MP_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of ST MP subject group from TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of ST MP subject group from TXT
	%
	% ImporterGroupSubjectST_MP_TXT methods (save/load, Static):
	%  save - saves BRAPH2 importer of ST MP subject group from TXT as b2 file
	%  load - loads a BRAPH2 importer of ST MP subject group from TXT from a b2 file
	%
	% ImporterGroupSubjectST_MP_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of ST MP subject group from TXT
	%
	% ImporterGroupSubjectST_MP_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of ST MP subject group from TXT
	%
	% ImporterGroupSubjectST_MP_TXT methods (inspection, Static):
	%  getClass - returns the class of the importer of ST MP subject group from TXT
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectST_MP_TXT
	%  getProps - returns the property list of the importer of ST MP subject group from TXT
	%  getPropNumber - returns the property number of the importer of ST MP subject group from TXT
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
	% ImporterGroupSubjectST_MP_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectST_MP_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectST_MP_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectST_MP_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectST_MP_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectST_MP_TXT constants</a>.
	%
	%
	% See also Group, SubjectST_MP, ExporterGroupSubjectST_MP_TXT.
	
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
		function im = ImporterGroupSubjectST_MP_TXT(varargin)
			%ImporterGroupSubjectST_MP_TXT() creates a importer of ST MP subject group from TXT.
			%
			% ImporterGroupSubjectST_MP_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectST_MP_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the importer of ST MP subject group from TXT.
			%
			% CLASS = ImporterGroupSubjectST_MP_TXT.GETCLASS() returns the class 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of ST MP subject group from TXT IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectST_MP_TXT') returns 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectST_MP_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of ST MP subject group from TXT.
			%
			% LIST = ImporterGroupSubjectST_MP_TXT.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of ST MP subject group from TXT IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectST_MP_TXT') returns all subclasses of 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterGroupSubjectST_MP_TXT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of ST MP subject group from TXT.
			%
			% PROPS = ImporterGroupSubjectST_MP_TXT.GETPROPS() returns the property list of importer of ST MP subject group from TXT
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectST_MP_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of ST MP subject group from TXT IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectST_MP_TXT'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterGroupSubjectST_MP_TXT.DIRECTORY ...
						ImporterGroupSubjectST_MP_TXT.GET_DIR ...
						ImporterGroupSubjectST_MP_TXT.BA ...
						ImporterGroupSubjectST_MP_TXT.GR ...
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
						ImporterGroupSubjectST_MP_TXT.DIRECTORY ...
						ImporterGroupSubjectST_MP_TXT.BA ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterGroupSubjectST_MP_TXT.GR ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterGroupSubjectST_MP_TXT.GET_DIR ...
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
			%GETPROPNUMBER returns the property number of importer of ST MP subject group from TXT.
			%
			% N = ImporterGroupSubjectST_MP_TXT.GETPROPNUMBER() returns the property number of importer of ST MP subject group from TXT.
			%
			% N = ImporterGroupSubjectST_MP_TXT.GETPROPNUMBER(CATEGORY) returns the property number of importer of ST MP subject group from TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of ST MP subject group from TXT IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectST_MP_TXT') returns the property number of 'ImporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterGroupSubjectST_MP_TXT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of ST MP subject group from TXT/error.
			%
			% CHECK = ImporterGroupSubjectST_MP_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectST_MP_TXT, PROP) checks whether PROP exists for ImporterGroupSubjectST_MP_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectST_MP_TXT, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectST_MP_TXT.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterGroupSubjectST_MP_TXT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectST_MP_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of ST MP subject group from TXT/error.
			%
			% CHECK = ImporterGroupSubjectST_MP_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectST_MP_TXT, TAG) checks whether TAG exists for ImporterGroupSubjectST_MP_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectST_MP_TXT, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectST_MP_TXT.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importergroupsubjectst_mp_txt_tag_list = cellfun(@(x) ImporterGroupSubjectST_MP_TXT.getPropTag(x), num2cell(ImporterGroupSubjectST_MP_TXT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importergroupsubjectst_mp_txt_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectST_MP_TXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectST_MP_TXT, POINTER) returns property number of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectST_MP_TXT, POINTER) returns property number of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importergroupsubjectst_mp_txt_tag_list = cellfun(@(x) ImporterGroupSubjectST_MP_TXT.getPropTag(x), num2cell(ImporterGroupSubjectST_MP_TXT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importergroupsubjectst_mp_txt_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectST_MP_TXT, POINTER) returns tag of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectST_MP_TXT, POINTER) returns tag of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterGroupSubjectST_MP_TXT.DIRECTORY
						tag = ImporterGroupSubjectST_MP_TXT.DIRECTORY_TAG;
					case ImporterGroupSubjectST_MP_TXT.GET_DIR
						tag = ImporterGroupSubjectST_MP_TXT.GET_DIR_TAG;
					case ImporterGroupSubjectST_MP_TXT.BA
						tag = ImporterGroupSubjectST_MP_TXT.BA_TAG;
					case ImporterGroupSubjectST_MP_TXT.GR
						tag = ImporterGroupSubjectST_MP_TXT.GR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectST_MP_TXT, POINTER) returns category of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectST_MP_TXT, POINTER) returns category of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_category = ImporterGroupSubjectST_MP_TXT.DIRECTORY_CATEGORY;
				case ImporterGroupSubjectST_MP_TXT.GET_DIR
					prop_category = ImporterGroupSubjectST_MP_TXT.GET_DIR_CATEGORY;
				case ImporterGroupSubjectST_MP_TXT.BA
					prop_category = ImporterGroupSubjectST_MP_TXT.BA_CATEGORY;
				case ImporterGroupSubjectST_MP_TXT.GR
					prop_category = ImporterGroupSubjectST_MP_TXT.GR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectST_MP_TXT, POINTER) returns format of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectST_MP_TXT, POINTER) returns format of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_format = ImporterGroupSubjectST_MP_TXT.DIRECTORY_FORMAT;
				case ImporterGroupSubjectST_MP_TXT.GET_DIR
					prop_format = ImporterGroupSubjectST_MP_TXT.GET_DIR_FORMAT;
				case ImporterGroupSubjectST_MP_TXT.BA
					prop_format = ImporterGroupSubjectST_MP_TXT.BA_FORMAT;
				case ImporterGroupSubjectST_MP_TXT.GR
					prop_format = ImporterGroupSubjectST_MP_TXT.GR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectST_MP_TXT, POINTER) returns description of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectST_MP_TXT, POINTER) returns description of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.';
				case ImporterGroupSubjectST_MP_TXT.GET_DIR
					prop_description = 'GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the ST MP subject group with L layers.';
				case ImporterGroupSubjectST_MP_TXT.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectST_MP_TXT.GR
					prop_description = 'GR (result, item) is a group of subjects with structural multiplex data.';
				case ImporterGroupSubjectST_MP_TXT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.NAME
					prop_description = 'NAME (constant, string) is the name of the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.ID
					prop_description = 'ID (data, string) is a few-letter code for the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ST MP subject group importer from TXT.';
				case ImporterGroupSubjectST_MP_TXT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ST MP subject group importer from TXT.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectST_MP_TXT, POINTER) returns settings of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectST_MP_TXT, POINTER) returns settings of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectST_MP_TXT.GET_DIR
					prop_settings = 'ImporterGroupSubjectST_MP_TXT';
				case ImporterGroupSubjectST_MP_TXT.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectST_MP_TXT.GR
					prop_settings = 'Group';
				case ImporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_settings = 'ImporterGroupSubjectST_MP_TXT';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_MP_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_MP_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectST_MP_TXT, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectST_MP_TXT, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ImporterGroupSubjectST_MP_TXT.GET_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.GR
					prop_default = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
				case ImporterGroupSubjectST_MP_TXT.ELCLASS
					prop_default = 'ImporterGroupSubjectST_MP_TXT';
				case ImporterGroupSubjectST_MP_TXT.NAME
					prop_default = 'Multiplex Structural Subject Group TXT Importer';
				case ImporterGroupSubjectST_MP_TXT.DESCRIPTION
					prop_default = 'ImporterGroupSubjectST_MP_TXT imports a group of subjects with structural multiplex data from an TXT file and their covariates from another TXT file.';
				case ImporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.ID
					prop_default = 'ImporterGroupSubjectST_MP_TXT ID';
				case ImporterGroupSubjectST_MP_TXT.LABEL
					prop_default = 'ImporterGroupSubjectST_MP_TXT label';
				case ImporterGroupSubjectST_MP_TXT.NOTES
					prop_default = 'ImporterGroupSubjectST_MP_TXT notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_MP_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_MP_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_MP_TXT, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_MP_TXT.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_MP_TXT, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectST_MP_TXT.conditioning(prop, ImporterGroupSubjectST_MP_TXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectST_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_MP_TXT.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectST_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_MP_TXT.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterGroupSubjectST_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_MP_TXT.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterGroupSubjectST_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_MP_TXT.
			%   Error id: €BRAPH2.STR€:ImporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_MP_TXT.DIRECTORY % __ImporterGroupSubjectST_MP_TXT.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.GET_DIR % __ImporterGroupSubjectST_MP_TXT.GET_DIR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.BA % __ImporterGroupSubjectST_MP_TXT.BA__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.GR % __ImporterGroupSubjectST_MP_TXT.GR__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ImporterGroupSubjectST_MP_TXT.TEMPLATE % __ImporterGroupSubjectST_MP_TXT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectST_MP_TXT.getPropTag(prop) ' (' ImporterGroupSubjectST_MP_TXT.getFormatTag(ImporterGroupSubjectST_MP_TXT.getPropFormat(prop)) ').'] ...
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
				case ImporterGroupSubjectST_MP_TXT.GET_DIR % __ImporterGroupSubjectST_MP_TXT.GET_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case ImporterGroupSubjectST_MP_TXT.GR % __ImporterGroupSubjectST_MP_TXT.GR__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterGroupSubjectST_MP_TXT.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectST_MP', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					directory = im.get('DIRECTORY');
					if isfolder(directory)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					
					    % sets group props
					    [~, name] = fileparts(directory);
					    gr.set( ...
					        'ID', name, ...
					        'LABEL', name, ...
					        'NOTES', ['Group loaded from ' directory] ...
					        );
					
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...')
					        
					        % analyzes files
					        files = dir(fullfile(directory, '*.txt'));
					
					        if ~isempty(files)
					            % brain atlas
					            braph2waitbar(wb, .25, 'Loading brain atlas ...')
					            ba = im.get('BA');
					            raw = readtable(fullfile(directory, files(1).name), 'Delimiter', '	');
					            br_number = size(raw, 2) - 3;
					            if ba.get('BR_DICT').get('LENGTH') == 0
					                ba = BrainAtlas();
					                br_dict = ba.memorize('BR_DICT');
					                for j = 1:1:br_number
					                    br_id = raw.Properties.VariableNames{j};
					                    br = BrainRegion('ID', br_id);
					                    br_dict.get('ADD', br)
					                end
					            end
					            if br_number ~= ba.get('BR_DICT').get('LENGTH')
					                error( ...
					                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
					                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\n' ...
					                    'The file ' files(1).name ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
					                    'while it contains ' int2str(br_number) ' columns.'] ...
					                    )
					            end
					            
					            % determines the number of layers
					            L = 0;
					            for i = 1:1:length(files)
					                [~, gr_id_layer_no] = fileparts(files(i).name);
					                splits = regexp(gr_id_layer_no, '(.+)\.(\d+)', 'tokens');
					                gr_id = splits{1}{1};
					                L = max(L, str2double(splits{1}{2}));
					            end
					            
					            % adds subjects
					            sub_dict = gr.memorize('SUB_DICT');
					            for i = 1:1:size(raw, 1)
					                braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
					                
					                % read files
					                ST_MP = {};
					                for l = 1:1:L
					                    raw = readtable(fullfile(directory, [gr_id '.' int2str(l) '.txt']), 'Delimiter', '	');
					                    ST = zeros(br_number, 1);
					                    for j = 1:1:length(ST)
					                        ST(j) = raw{i, 3 + j};
					                    end
					                    ST_MP = [ST_MP, ST];
					                end
					                
					                sub = SubjectST_MP( ...
					                    'ID', char(raw{i, 1}), ...
					                    'LABEL', char(raw{i, 2}), ...
					                    'NOTES', char(raw{i, 3}), ...
					                    'BA', ba, ...
					                    'L', L, ...
					                    'ST_MP', ST_MP ...
					                );
					                sub_dict.get('ADD', sub);
					            end
					            
					            % variables of interest
					            if isfile([directory '.vois.txt'])
					                vois = textread([directory '.vois.txt'], '%s', 'delimiter', '	', 'whitespace', '');
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
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					        
					        rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					else
					    error([BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.ERR_IO], ...
					        [BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.ERR_IO '\n' ...
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
				case ImporterGroupSubjectST_MP_TXT.GR % __ImporterGroupSubjectST_MP_TXT.GR__
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true)));
					
				otherwise
					if prop <= Importer.getPropNumber()
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
