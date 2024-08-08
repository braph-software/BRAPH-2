classdef ExporterGroupSubjectCON_MP_TXT < Exporter
	%ExporterGroupSubjectCON_MP_TXT exports a group of subjects with connectivity multiplex data to a series of TXT file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectCON_MP_TXT exports a group of subjects with connectivity 
	%  multiplex data to a series of tab-separated TXT files contained in a folder 
	%  named "GROUP_ID". All these files are saved in the same folder. Each file 
	%  contains a table of values corresponding to the adjacency matrix. Files 
	%  should be labeled with the layer number indicated as, e.g., 
	%  "SUBJECT_ID.1.txt" and "SUBJECT_ID.2.txt".
	% The variables of interest (if existing) are saved in another tab-separated 
	%  TXT file named "GROUP_ID.vois.txt" consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ExporterGroupSubjectCON_MP_TXT methods (constructor):
	%  ExporterGroupSubjectCON_MP_TXT - constructor
	%
	% ExporterGroupSubjectCON_MP_TXT methods:
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
	% ExporterGroupSubjectCON_MP_TXT methods (display):
	%  tostring - string with information about the exporter of CON MP subject group in TXT
	%  disp - displays information about the exporter of CON MP subject group in TXT
	%  tree - displays the tree of the exporter of CON MP subject group in TXT
	%
	% ExporterGroupSubjectCON_MP_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two exporter of CON MP subject group in TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the exporter of CON MP subject group in TXT
	%
	% ExporterGroupSubjectCON_MP_TXT methods (save/load, Static):
	%  save - saves BRAPH2 exporter of CON MP subject group in TXT as b2 file
	%  load - loads a BRAPH2 exporter of CON MP subject group in TXT from a b2 file
	%
	% ExporterGroupSubjectCON_MP_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the exporter of CON MP subject group in TXT
	%
	% ExporterGroupSubjectCON_MP_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the exporter of CON MP subject group in TXT
	%
	% ExporterGroupSubjectCON_MP_TXT methods (inspection, Static):
	%  getClass - returns the class of the exporter of CON MP subject group in TXT
	%  getSubclasses - returns all subclasses of ExporterGroupSubjectCON_MP_TXT
	%  getProps - returns the property list of the exporter of CON MP subject group in TXT
	%  getPropNumber - returns the property number of the exporter of CON MP subject group in TXT
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
	% ExporterGroupSubjectCON_MP_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterGroupSubjectCON_MP_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterGroupSubjectCON_MP_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectCON_MP_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterGroupSubjectCON_MP_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterGroupSubjectCON_MP_TXT constants</a>.
	%
	%
	% See also Group, SunbjectCON_MP, ImporterGroupSubjectCON_MP_TXT.
	
	properties (Constant) % properties
		GR = Exporter.getPropNumber() + 1;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		DIRECTORY = Exporter.getPropNumber() + 2;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		PUT_DIR = Exporter.getPropNumber() + 3;
		PUT_DIR_TAG = 'PUT_DIR';
		PUT_DIR_CATEGORY = Category.QUERY;
		PUT_DIR_FORMAT = Format.ITEM;
		
		SAVE = Exporter.getPropNumber() + 4;
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function ex = ExporterGroupSubjectCON_MP_TXT(varargin)
			%ExporterGroupSubjectCON_MP_TXT() creates a exporter of CON MP subject group in TXT.
			%
			% ExporterGroupSubjectCON_MP_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectCON_MP_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of CON MP subject group in TXT.
			%
			% CLASS = ExporterGroupSubjectCON_MP_TXT.GETCLASS() returns the class 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of CON MP subject group in TXT EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectCON_MP_TXT') returns 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			
			ex_class = 'ExporterGroupSubjectCON_MP_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the exporter of CON MP subject group in TXT.
			%
			% LIST = ExporterGroupSubjectCON_MP_TXT.GETSUBCLASSES() returns all subclasses of 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the exporter of CON MP subject group in TXT EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterGroupSubjectCON_MP_TXT') returns all subclasses of 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ExporterGroupSubjectCON_MP_TXT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of CON MP subject group in TXT.
			%
			% PROPS = ExporterGroupSubjectCON_MP_TXT.GETPROPS() returns the property list of exporter of CON MP subject group in TXT
			%  as a row vector.
			%
			% PROPS = ExporterGroupSubjectCON_MP_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of CON MP subject group in TXT EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectCON_MP_TXT'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Exporter.getProps() ...
						ExporterGroupSubjectCON_MP_TXT.GR ...
						ExporterGroupSubjectCON_MP_TXT.DIRECTORY ...
						ExporterGroupSubjectCON_MP_TXT.PUT_DIR ...
						ExporterGroupSubjectCON_MP_TXT.SAVE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Exporter.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Exporter.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Exporter.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Exporter.getProps(Category.DATA) ...
						ExporterGroupSubjectCON_MP_TXT.GR ...
						ExporterGroupSubjectCON_MP_TXT.DIRECTORY ...
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT) ...
						ExporterGroupSubjectCON_MP_TXT.SAVE ...
						];
				case Category.QUERY
					prop_list = [ ...
						Exporter.getProps(Category.QUERY) ...
						ExporterGroupSubjectCON_MP_TXT.PUT_DIR ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Exporter.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Exporter.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Exporter.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of exporter of CON MP subject group in TXT.
			%
			% N = ExporterGroupSubjectCON_MP_TXT.GETPROPNUMBER() returns the property number of exporter of CON MP subject group in TXT.
			%
			% N = ExporterGroupSubjectCON_MP_TXT.GETPROPNUMBER(CATEGORY) returns the property number of exporter of CON MP subject group in TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the exporter of CON MP subject group in TXT EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectCON_MP_TXT') returns the property number of 'ExporterGroupSubjectCON_MP_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ExporterGroupSubjectCON_MP_TXT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of CON MP subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectCON_MP_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectCON_MP_TXT, PROP) checks whether PROP exists for ExporterGroupSubjectCON_MP_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectCON_MP_TXT, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectCON_MP_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ExporterGroupSubjectCON_MP_TXT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectCON_MP_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of CON MP subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectCON_MP_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectCON_MP_TXT, TAG) checks whether TAG exists for ExporterGroupSubjectCON_MP_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectCON_MP_TXT, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectCON_MP_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			exportergroupsubjectcon_mp_txt_tag_list = cellfun(@(x) ExporterGroupSubjectCON_MP_TXT.getPropTag(x), num2cell(ExporterGroupSubjectCON_MP_TXT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, exportergroupsubjectcon_mp_txt_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectCON_MP_TXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectCON_MP_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectCON_MP_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				exportergroupsubjectcon_mp_txt_tag_list = cellfun(@(x) ExporterGroupSubjectCON_MP_TXT.getPropTag(x), num2cell(ExporterGroupSubjectCON_MP_TXT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, exportergroupsubjectcon_mp_txt_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectCON_MP_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectCON_MP_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ExporterGroupSubjectCON_MP_TXT.GR
						tag = ExporterGroupSubjectCON_MP_TXT.GR_TAG;
					case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
						tag = ExporterGroupSubjectCON_MP_TXT.DIRECTORY_TAG;
					case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
						tag = ExporterGroupSubjectCON_MP_TXT.PUT_DIR_TAG;
					case ExporterGroupSubjectCON_MP_TXT.SAVE
						tag = ExporterGroupSubjectCON_MP_TXT.SAVE_TAG;
					otherwise
						tag = getPropTag@Exporter(prop);
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectCON_MP_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectCON_MP_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR
					prop_category = ExporterGroupSubjectCON_MP_TXT.GR_CATEGORY;
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
					prop_category = ExporterGroupSubjectCON_MP_TXT.DIRECTORY_CATEGORY;
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
					prop_category = ExporterGroupSubjectCON_MP_TXT.PUT_DIR_CATEGORY;
				case ExporterGroupSubjectCON_MP_TXT.SAVE
					prop_category = ExporterGroupSubjectCON_MP_TXT.SAVE_CATEGORY;
				otherwise
					prop_category = getPropCategory@Exporter(prop);
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectCON_MP_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectCON_MP_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR
					prop_format = ExporterGroupSubjectCON_MP_TXT.GR_FORMAT;
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
					prop_format = ExporterGroupSubjectCON_MP_TXT.DIRECTORY_FORMAT;
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
					prop_format = ExporterGroupSubjectCON_MP_TXT.PUT_DIR_FORMAT;
				case ExporterGroupSubjectCON_MP_TXT.SAVE
					prop_format = ExporterGroupSubjectCON_MP_TXT.SAVE_FORMAT;
				otherwise
					prop_format = getPropFormat@Exporter(prop);
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectCON_MP_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectCON_MP_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR
					prop_description = 'GR (data, item) is a group of subjects with connectivity multiplex data.';
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity multiplex data.';
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
					prop_description = 'PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity multiplex data.';
				case ExporterGroupSubjectCON_MP_TXT.SAVE
					prop_description = 'SAVE (result, empty) saves the group of subjects with connectivity multiplex data in TXT files in the selected directory.';
				case ExporterGroupSubjectCON_MP_TXT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.NAME
					prop_description = 'NAME (constant, string) is the name of the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.ID
					prop_description = 'ID (data, string) is a few-letter code for the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the CON MP subject group exporter in TXT.';
				case ExporterGroupSubjectCON_MP_TXT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the CON MP subject group exporter in TXT.';
				otherwise
					prop_description = getPropDescription@Exporter(prop);
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectCON_MP_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectCON_MP_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR
					prop_settings = 'Group';
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
					prop_settings = 'ExporterGroupSubjectCON_MP_TXT';
				case ExporterGroupSubjectCON_MP_TXT.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ExporterGroupSubjectCON_MP_TXT.TEMPLATE
					prop_settings = 'ExporterGroupSubjectCON_MP_TXT';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectCON_MP_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectCON_MP_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectCON_MP_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectCON_MP_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY
					prop_default = [fileparts(which('test_braph2')) filesep 'default_group_subjects_CON_MP_most_likely_to_be_erased'];
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.ELCLASS
					prop_default = 'ExporterGroupSubjectCON_MP_TXT';
				case ExporterGroupSubjectCON_MP_TXT.NAME
					prop_default = 'Multiplex Connectivity Subject Group TXT Exporter';
				case ExporterGroupSubjectCON_MP_TXT.DESCRIPTION
					prop_default = 'ExporterGroupSubjectCON_MP_TXT exports a group of subjects with connectivity multiplex data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.';
				case ExporterGroupSubjectCON_MP_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.ID
					prop_default = 'ExporterGroupSubjectCON_MP_TXT ID';
				case ExporterGroupSubjectCON_MP_TXT.LABEL
					prop_default = 'ExporterGroupSubjectCON_MP_TXT label';
				case ExporterGroupSubjectCON_MP_TXT.NOTES
					prop_default = 'ExporterGroupSubjectCON_MP_TXT notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectCON_MP_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectCON_MP_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectCON_MP_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectCON_MP_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectCON_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectCON_MP_TXT.conditioning(prop, ExporterGroupSubjectCON_MP_TXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectCON_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectCON_MP_TXT.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectCON_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectCON_MP_TXT.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ExporterGroupSubjectCON_MP_TXT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectCON_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ExporterGroupSubjectCON_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectCON_MP_TXT.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectCON_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  EX.CHECKPROP(ExporterGroupSubjectCON_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectCON_MP_TXT.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectCON_MP_TXT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterGroupSubjectCON_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterGroupSubjectCON_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectCON_MP_TXT.GR % __ExporterGroupSubjectCON_MP_TXT.GR__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
					if check
						check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_MP', [], [], true)));
					end
				case ExporterGroupSubjectCON_MP_TXT.DIRECTORY % __ExporterGroupSubjectCON_MP_TXT.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR % __ExporterGroupSubjectCON_MP_TXT.PUT_DIR__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.SAVE % __ExporterGroupSubjectCON_MP_TXT.SAVE__
					check = Format.checkFormat(Format.EMPTY, value, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectCON_MP_TXT.TEMPLATE % __ExporterGroupSubjectCON_MP_TXT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectCON_MP_TXT.getPropSettings(prop));
				otherwise
					if prop <= Exporter.getPropNumber()
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectCON_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectCON_MP_TXT.getPropTag(prop) ' (' ExporterGroupSubjectCON_MP_TXT.getFormatTag(ExporterGroupSubjectCON_MP_TXT.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ex, prop, varargin)
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
				case ExporterGroupSubjectCON_MP_TXT.PUT_DIR % __ExporterGroupSubjectCON_MP_TXT.PUT_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    ex.set('DIRECTORY', directory);
					end
					value = ex;
					
				case ExporterGroupSubjectCON_MP_TXT.SAVE % __ExporterGroupSubjectCON_MP_TXT.SAVE__
					rng_settings_ = rng(); rng(ex.getPropSeed(ExporterGroupSubjectCON_MP_TXT.SAVE), 'twister')
					
					directory = ex.get('DIRECTORY');
					
					if isfolder(directory)
					    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					
					    gr = ex.get('GR');
					
					    gr_directory = [directory filesep() gr.get('ID')];
					    if ~exist(gr_directory, 'dir')
					        mkdir(gr_directory)
					    end
					    
					    braph2waitbar(wb, .15, 'Organizing info ...')
					
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.get('LENGTH');
					    
					    for i = 1:1:sub_number
					        braph2waitbar(wb, .15 + .85 * i / sub_number, ['Saving subject ' num2str(i) ' of ' num2str(sub_number) ' ...'])
					
					        L = sub_dict.get('IT', 1).get('L');
					        
					        sub = sub_dict.get('IT', i);
					        sub_id = sub.get('ID');
					        sub_CON_MP = sub.get('CON_MP');
					        
					        for l = 1:1:L
					            tab = table(sub_CON_MP{l});
					            
					            sub_file = [gr_directory filesep() sub_id '.' int2str(l) '.txt'];
					            
					            % save file
					            writetable(tab, sub_file, 'Delimiter', '	', 'WriteVariableNames', false);
					        end
					    end
					    
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
					                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = {['{' sprintf(' ''%s'' ', categories{:}) '}']};
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
					                end
					            end
					        end
					        writetable(table(vois), [gr_directory '.vois.txt'], 'Delimiter', '	', 'WriteVariableNames', false)
					    end
					    
					    braph2waitbar(wb, 'close')
					end
					
					% sets value to empty
					value = [];
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Exporter.getPropNumber()
						value = calculateValue@Exporter(ex, prop, varargin{:});
					else
						value = calculateValue@Element(ex, prop, varargin{:});
					end
			end
			
		end
	end
end
