classdef ExporterBrainAtlasXLS < Exporter
	%ExporterBrainAtlasXLS exports a brain atlas to an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% A Brain Atlas Exporter in XLS Files (ExporterBrainAtlasXLS) exports a brain atlas to an XLS/XLSX file.
	%
	% ExporterBrainAtlasXLS methods (constructor):
	%  ExporterBrainAtlasXLS - constructor
	%
	% ExporterBrainAtlasXLS methods:
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
	% ExporterBrainAtlasXLS methods (display):
	%  tostring - string with information about the brain atlas exporter in XLS
	%  disp - displays information about the brain atlas exporter in XLS
	%  tree - displays the tree of the brain atlas exporter in XLS
	%
	% ExporterBrainAtlasXLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas exporter in XLS are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas exporter in XLS
	%
	% ExporterBrainAtlasXLS methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas exporter in XLS as b2 file
	%  load - loads a BRAPH2 brain atlas exporter in XLS from a b2 file
	%
	% ExporterBrainAtlasXLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas exporter in XLS
	%
	% ExporterBrainAtlasXLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas exporter in XLS
	%
	% ExporterBrainAtlasXLS methods (inspection, Static):
	%  getClass - returns the class of the brain atlas exporter in XLS
	%  getSubclasses - returns all subclasses of ExporterBrainAtlasXLS
	%  getProps - returns the property list of the brain atlas exporter in XLS
	%  getPropNumber - returns the property number of the brain atlas exporter in XLS
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
	% ExporterBrainAtlasXLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterBrainAtlasXLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterBrainAtlasXLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterBrainAtlasXLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterBrainAtlasXLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterBrainAtlasXLS constants</a>.
	%
	%
	% See also BrainAtlas, ImporterBrainAtlasXLS.
	
	properties (Constant) % properties
		BA = Exporter.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		FILE = Exporter.getPropNumber() + 2;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		PUT_FILE = Exporter.getPropNumber() + 3;
		PUT_FILE_TAG = 'PUT_FILE';
		PUT_FILE_CATEGORY = Category.QUERY;
		PUT_FILE_FORMAT = Format.ITEM;
		
		SAVE = Exporter.getPropNumber() + 4;
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function ex = ExporterBrainAtlasXLS(varargin)
			%ExporterBrainAtlasXLS() creates a brain atlas exporter in XLS.
			%
			% ExporterBrainAtlasXLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterBrainAtlasXLS(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the brain atlas exporter in XLS.
			%
			% CLASS = ExporterBrainAtlasXLS.GETCLASS() returns the class 'ExporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the brain atlas exporter in XLS EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterBrainAtlasXLS') returns 'ExporterBrainAtlasXLS'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			
			ex_class = 'ExporterBrainAtlasXLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas exporter in XLS.
			%
			% LIST = ExporterBrainAtlasXLS.GETSUBCLASSES() returns all subclasses of 'ExporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the brain atlas exporter in XLS EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterBrainAtlasXLS') returns all subclasses of 'ExporterBrainAtlasXLS'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ExporterBrainAtlasXLS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas exporter in XLS.
			%
			% PROPS = ExporterBrainAtlasXLS.GETPROPS() returns the property list of brain atlas exporter in XLS
			%  as a row vector.
			%
			% PROPS = ExporterBrainAtlasXLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the brain atlas exporter in XLS EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterBrainAtlasXLS'[, CATEGORY]) returns the property list of 'ExporterBrainAtlasXLS'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Exporter.getProps() ...
						ExporterBrainAtlasXLS.BA ...
						ExporterBrainAtlasXLS.FILE ...
						ExporterBrainAtlasXLS.PUT_FILE ...
						ExporterBrainAtlasXLS.SAVE ...
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
						ExporterBrainAtlasXLS.BA ...
						ExporterBrainAtlasXLS.FILE ...
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT) ...
						ExporterBrainAtlasXLS.SAVE ...
						];
				case Category.QUERY
					prop_list = [ ...
						Exporter.getProps(Category.QUERY) ...
						ExporterBrainAtlasXLS.PUT_FILE ...
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
			%GETPROPNUMBER returns the property number of brain atlas exporter in XLS.
			%
			% N = ExporterBrainAtlasXLS.GETPROPNUMBER() returns the property number of brain atlas exporter in XLS.
			%
			% N = ExporterBrainAtlasXLS.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas exporter in XLS
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas exporter in XLS EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterBrainAtlasXLS') returns the property number of 'ExporterBrainAtlasXLS'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ExporterBrainAtlasXLS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain atlas exporter in XLS/error.
			%
			% CHECK = ExporterBrainAtlasXLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterBrainAtlasXLS, PROP) checks whether PROP exists for ExporterBrainAtlasXLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(ExporterBrainAtlasXLS, PROP) throws error if PROP does NOT exist for ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ExporterBrainAtlasXLS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterBrainAtlasXLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas exporter in XLS/error.
			%
			% CHECK = ExporterBrainAtlasXLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterBrainAtlasXLS, TAG) checks whether TAG exists for ExporterBrainAtlasXLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(ExporterBrainAtlasXLS, TAG) throws error if TAG does NOT exist for ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			exporterbrainatlasxls_tag_list = cellfun(@(x) ExporterBrainAtlasXLS.getPropTag(x), num2cell(ExporterBrainAtlasXLS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, exporterbrainatlasxls_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ExporterBrainAtlasXLS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterBrainAtlasXLS, POINTER) returns property number of POINTER of ExporterBrainAtlasXLS.
			%  PROPERTY = EX.GETPROPPROP(ExporterBrainAtlasXLS, POINTER) returns property number of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				exporterbrainatlasxls_tag_list = cellfun(@(x) ExporterBrainAtlasXLS.getPropTag(x), num2cell(ExporterBrainAtlasXLS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, exporterbrainatlasxls_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ExporterBrainAtlasXLS, POINTER) returns tag of POINTER of ExporterBrainAtlasXLS.
			%  TAG = EX.GETPROPTAG(ExporterBrainAtlasXLS, POINTER) returns tag of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ExporterBrainAtlasXLS.BA
						tag = ExporterBrainAtlasXLS.BA_TAG;
					case ExporterBrainAtlasXLS.FILE
						tag = ExporterBrainAtlasXLS.FILE_TAG;
					case ExporterBrainAtlasXLS.PUT_FILE
						tag = ExporterBrainAtlasXLS.PUT_FILE_TAG;
					case ExporterBrainAtlasXLS.SAVE
						tag = ExporterBrainAtlasXLS.SAVE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterBrainAtlasXLS, POINTER) returns category of POINTER of ExporterBrainAtlasXLS.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterBrainAtlasXLS, POINTER) returns category of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_category = ExporterBrainAtlasXLS.BA_CATEGORY;
				case ExporterBrainAtlasXLS.FILE
					prop_category = ExporterBrainAtlasXLS.FILE_CATEGORY;
				case ExporterBrainAtlasXLS.PUT_FILE
					prop_category = ExporterBrainAtlasXLS.PUT_FILE_CATEGORY;
				case ExporterBrainAtlasXLS.SAVE
					prop_category = ExporterBrainAtlasXLS.SAVE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterBrainAtlasXLS, POINTER) returns format of POINTER of ExporterBrainAtlasXLS.
			%  FORMAT = EX.GETPROPFORMAT(ExporterBrainAtlasXLS, POINTER) returns format of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_format = ExporterBrainAtlasXLS.BA_FORMAT;
				case ExporterBrainAtlasXLS.FILE
					prop_format = ExporterBrainAtlasXLS.FILE_FORMAT;
				case ExporterBrainAtlasXLS.PUT_FILE
					prop_format = ExporterBrainAtlasXLS.PUT_FILE_FORMAT;
				case ExporterBrainAtlasXLS.SAVE
					prop_format = ExporterBrainAtlasXLS.SAVE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterBrainAtlasXLS, POINTER) returns description of POINTER of ExporterBrainAtlasXLS.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterBrainAtlasXLS, POINTER) returns description of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ExporterBrainAtlasXLS.FILE
					prop_description = 'FILE (data, string) is the XLS/XLSX file where to save the brain atlas.';
				case ExporterBrainAtlasXLS.PUT_FILE
					prop_description = 'PUT_FILE (query, item) opens a dialog box to set the XLS/XLSX file where to save the brain atlas.';
				case ExporterBrainAtlasXLS.SAVE
					prop_description = 'SAVE (result, empty) saves the brain atlas in the selected XLS/XLSX file.';
				case ExporterBrainAtlasXLS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.NAME
					prop_description = 'NAME (constant, string) is the name of the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain atlas exporter in XLS.';
				case ExporterBrainAtlasXLS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain atlas exporter in XLS.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterBrainAtlasXLS, POINTER) returns settings of POINTER of ExporterBrainAtlasXLS.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterBrainAtlasXLS, POINTER) returns settings of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_settings = 'BrainAtlas';
				case ExporterBrainAtlasXLS.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterBrainAtlasXLS.PUT_FILE
					prop_settings = 'ExporterBrainAtlasXLS';
				case ExporterBrainAtlasXLS.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ExporterBrainAtlasXLS.TEMPLATE
					prop_settings = 'ExporterBrainAtlasXLS';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ExporterBrainAtlasXLS.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_brain_atlas_most_likely_to_be_erased.xlsx'];
				case ExporterBrainAtlasXLS.PUT_FILE
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.ELCLASS
					prop_default = 'ExporterBrainAtlasXLS';
				case ExporterBrainAtlasXLS.NAME
					prop_default = 'Brain Atlas Exporter in XLS Files';
				case ExporterBrainAtlasXLS.DESCRIPTION
					prop_default = 'A Brain Atlas Exporter in XLS Files (ExporterBrainAtlasXLS) exports a brain atlas to an XLS/XLSX file.';
				case ExporterBrainAtlasXLS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.ID
					prop_default = 'ExporterBrainAtlasXLS ID';
				case ExporterBrainAtlasXLS.LABEL
					prop_default = 'ExporterBrainAtlasXLS label';
				case ExporterBrainAtlasXLS.NOTES
					prop_default = 'ExporterBrainAtlasXLS notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasXLS.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			prop_default = ExporterBrainAtlasXLS.conditioning(prop, ExporterBrainAtlasXLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasXLS.
			%  CHECK = EX.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasXLS.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ExporterBrainAtlasXLS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: €BRAPH2.STR€:ExporterBrainAtlasXLS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasXLS.
			%   Error id: €BRAPH2.STR€:ExporterBrainAtlasXLS:€BRAPH2.WRONG_INPUT€
			%  EX.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasXLS.
			%   Error id: €BRAPH2.STR€:ExporterBrainAtlasXLS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA % __ExporterBrainAtlasXLS.BA__
					check = Format.checkFormat(Format.ITEM, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.FILE % __ExporterBrainAtlasXLS.FILE__
					check = Format.checkFormat(Format.STRING, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.PUT_FILE % __ExporterBrainAtlasXLS.PUT_FILE__
					check = Format.checkFormat(Format.ITEM, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.SAVE % __ExporterBrainAtlasXLS.SAVE__
					check = Format.checkFormat(Format.EMPTY, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.TEMPLATE % __ExporterBrainAtlasXLS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				otherwise
					if prop <= Exporter.getPropNumber()
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterBrainAtlasXLS.getPropTag(prop) ' (' ExporterBrainAtlasXLS.getFormatTag(ExporterBrainAtlasXLS.getPropFormat(prop)) ').'] ...
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
				case ExporterBrainAtlasXLS.PUT_FILE % __ExporterBrainAtlasXLS.PUT_FILE__
					[filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
					if filterindex
					    file = [filepath filename];
					    ex.set('FILE', file);
					end
					value = ex;
					
				case ExporterBrainAtlasXLS.SAVE % __ExporterBrainAtlasXLS.SAVE__
					rng_settings_ = rng(); rng(ex.getPropSeed(ExporterBrainAtlasXLS.SAVE), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
						wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					    
					    ba = ex.get('BA');
					    ba_id = ba.get('ID');
					    if ~isempty(ba.get('LABEL'))
					        ba_label = ba.get('LABEL');
					    else
					        ba_label = ' ';
					    end
					    if ~isempty(ba.get('NOTES'))
					        ba_notes = ba.get('NOTES');
					    else
					        ba_notes = ' ';
					    end
					
					    % gets brain region data
						braph2waitbar(wb, .15, 'Organizing info ...')
					    
					    br_dict = ba.get('BR_DICT');
					    br_ids = cell(br_dict.get('LENGTH'), 1);
					    br_labels = cell(br_dict.get('LENGTH'), 1);
					    br_notes = cell(br_dict.get('LENGTH'), 1);
					    br_x = cell(br_dict.get('LENGTH'), 1);
					    br_y = cell(br_dict.get('LENGTH'), 1);
					    br_z = cell(br_dict.get('LENGTH'), 1);
					    for i = 1:1:br_dict.get('LENGTH')
					        braph2waitbar(wb, .25 + .75 * i / br_dict.get('LENGTH'), ['Saving brain region ' num2str(i) ' of ' num2str(br_dict.get('LENGTH'))])
					        
					        br = br_dict.get('IT', i);
					        br_ids{i} = br.get('ID');
					        if ~isempty(br.get('LABEL'))
					            br_labels{i} = br.get('LABEL');
					        else
					            br_labels{i} = ' ';
					        end
					        if ~isempty(br.get('NOTES'))
					            br_notes{i} = br.get('NOTES');
					        else
					            br_notes{i} = ' ';
					        end
					        br_x{i} = br.get('X');
					        br_y{i} = br.get('Y');
					        br_z{i} = br.get('Z');
					    end
					
					    % creates table
					    tab = [
					        {ba_id, {}, {}, {}, {}, {}};
					        {ba_label, {}, {}, {}, {}, {}};
					        {ba_notes, {}, {}, {}, {}, {}};
					        {{}, {}, {}, {}, {}, {}};
					        table(br_ids, br_labels, br_x, br_y, br_z, br_notes)
					        ];
					
					    % save
					    braph2waitbar(wb, 1, 'Finalizing ...')
					    
					    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', false);
					
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
