classdef ExporterPipelineBRAPH2 < Exporter
	%ExporterPipelineBRAPH2 exports a pipeline in a BRAPH2 file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.
	%
	% ExporterPipelineBRAPH2 methods (constructor):
	%  ExporterPipelineBRAPH2 - constructor
	%
	% ExporterPipelineBRAPH2 methods:
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
	% ExporterPipelineBRAPH2 methods (display):
	%  tostring - string with information about the pipeline exporter in BRAPH2
	%  disp - displays information about the pipeline exporter in BRAPH2
	%  tree - displays the tree of the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline exporter in BRAPH2 are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (save/load, Static):
	%  save - saves BRAPH2 pipeline exporter in BRAPH2 as b2 file
	%  load - loads a BRAPH2 pipeline exporter in BRAPH2 from a b2 file
	%
	% ExporterPipelineBRAPH2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (inspection, Static):
	%  getClass - returns the class of the pipeline exporter in BRAPH2
	%  getSubclasses - returns all subclasses of ExporterPipelineBRAPH2
	%  getProps - returns the property list of the pipeline exporter in BRAPH2
	%  getPropNumber - returns the property number of the pipeline exporter in BRAPH2
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
	% ExporterPipelineBRAPH2 methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterPipelineBRAPH2 methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterPipelineBRAPH2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterPipelineBRAPH2 methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterPipelineBRAPH2; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterPipelineBRAPH2 constants</a>.
	%
	%
	% See also Exporter, Pipeline, ImporterPipelineBRAPH2.
	
	properties (Constant) % properties
		PIP = Exporter.getPropNumber() + 1;
		PIP_TAG = 'PIP';
		PIP_CATEGORY = Category.DATA;
		PIP_FORMAT = Format.ITEM;
		
		FILE = Exporter.getPropNumber() + 2;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		PUT_FILE = Exporter.getPropNumber() + 3;
		PUT_FILE_TAG = 'PUT_FILE';
		PUT_FILE_CATEGORY = Category.QUERY;
		PUT_FILE_FORMAT = Format.EMPTY;
		
		SAVE = Exporter.getPropNumber() + 4;
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function ex = ExporterPipelineBRAPH2(varargin)
			%ExporterPipelineBRAPH2() creates a pipeline exporter in BRAPH2.
			%
			% ExporterPipelineBRAPH2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterPipelineBRAPH2(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the pipeline exporter in BRAPH2.
			%
			% CLASS = ExporterPipelineBRAPH2.GETCLASS() returns the class 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the pipeline exporter in BRAPH2 EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterPipelineBRAPH2') returns 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			
			ex_class = 'ExporterPipelineBRAPH2';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline exporter in BRAPH2.
			%
			% LIST = ExporterPipelineBRAPH2.GETSUBCLASSES() returns all subclasses of 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the pipeline exporter in BRAPH2 EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterPipelineBRAPH2') returns all subclasses of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ExporterPipelineBRAPH2', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline exporter in BRAPH2.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS() returns the property list of pipeline exporter in BRAPH2
			%  as a row vector.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the pipeline exporter in BRAPH2 EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterPipelineBRAPH2'[, CATEGORY]) returns the property list of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Exporter.getProps() ...
						ExporterPipelineBRAPH2.PIP ...
						ExporterPipelineBRAPH2.FILE ...
						ExporterPipelineBRAPH2.PUT_FILE ...
						ExporterPipelineBRAPH2.SAVE ...
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
						ExporterPipelineBRAPH2.PIP ...
						ExporterPipelineBRAPH2.FILE ...
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT) ...
						ExporterPipelineBRAPH2.SAVE ...
						];
				case Category.QUERY
					prop_list = [ ...
						Exporter.getProps(Category.QUERY) ...
						ExporterPipelineBRAPH2.PUT_FILE ...
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
			%GETPROPNUMBER returns the property number of pipeline exporter in BRAPH2.
			%
			% N = ExporterPipelineBRAPH2.GETPROPNUMBER() returns the property number of pipeline exporter in BRAPH2.
			%
			% N = ExporterPipelineBRAPH2.GETPROPNUMBER(CATEGORY) returns the property number of pipeline exporter in BRAPH2
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline exporter in BRAPH2 EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterPipelineBRAPH2') returns the property number of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ExporterPipelineBRAPH2.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline exporter in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) checks whether PROP exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) throws error if PROP does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ExporterPipelineBRAPH2.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterPipelineBRAPH2.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline exporter in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) checks whether TAG exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) throws error if TAG does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			exporterpipelinebraph2_tag_list = cellfun(@(x) ExporterPipelineBRAPH2.getPropTag(x), num2cell(ExporterPipelineBRAPH2.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, exporterpipelinebraph2_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ExporterPipelineBRAPH2.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%  PROPERTY = EX.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				exporterpipelinebraph2_tag_list = cellfun(@(x) ExporterPipelineBRAPH2.getPropTag(x), num2cell(ExporterPipelineBRAPH2.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, exporterpipelinebraph2_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%  TAG = EX.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ExporterPipelineBRAPH2.PIP
						tag = ExporterPipelineBRAPH2.PIP_TAG;
					case ExporterPipelineBRAPH2.FILE
						tag = ExporterPipelineBRAPH2.FILE_TAG;
					case ExporterPipelineBRAPH2.PUT_FILE
						tag = ExporterPipelineBRAPH2.PUT_FILE_TAG;
					case ExporterPipelineBRAPH2.SAVE
						tag = ExporterPipelineBRAPH2.SAVE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_category = ExporterPipelineBRAPH2.PIP_CATEGORY;
				case ExporterPipelineBRAPH2.FILE
					prop_category = ExporterPipelineBRAPH2.FILE_CATEGORY;
				case ExporterPipelineBRAPH2.PUT_FILE
					prop_category = ExporterPipelineBRAPH2.PUT_FILE_CATEGORY;
				case ExporterPipelineBRAPH2.SAVE
					prop_category = ExporterPipelineBRAPH2.SAVE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%  FORMAT = EX.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_format = ExporterPipelineBRAPH2.PIP_FORMAT;
				case ExporterPipelineBRAPH2.FILE
					prop_format = ExporterPipelineBRAPH2.FILE_FORMAT;
				case ExporterPipelineBRAPH2.PUT_FILE
					prop_format = ExporterPipelineBRAPH2.PUT_FILE_FORMAT;
				case ExporterPipelineBRAPH2.SAVE
					prop_format = ExporterPipelineBRAPH2.SAVE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_description = 'PIP (data, item) is a pipeline.';
				case ExporterPipelineBRAPH2.FILE
					prop_description = 'FILE (data, string) is the BRAPH2 file where to save the pipeline.';
				case ExporterPipelineBRAPH2.PUT_FILE
					prop_description = 'PUT_FILE (query, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.';
				case ExporterPipelineBRAPH2.SAVE
					prop_description = 'SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.';
				case ExporterPipelineBRAPH2.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the exporter of a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.NAME
					prop_description = 'NAME (constant, string) is the name of the exporter of a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the exporter of a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the exporter of a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.ID
					prop_description = 'ID (data, string) is a few-letter code for the exporter of a pipeline v a BRAPH2 file.';
				case ExporterPipelineBRAPH2.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the exporter of a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the exporter of a pipeline to a BRAPH2 file.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_settings = 'Pipeline';
				case ExporterPipelineBRAPH2.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterPipelineBRAPH2.PUT_FILE
					prop_settings = 'ExporterPipelineBRAPH2';
				case ExporterPipelineBRAPH2.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ExporterPipelineBRAPH2.TEMPLATE
					prop_settings = 'ExporterPipelineBRAPH2';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2'];
				case ExporterPipelineBRAPH2.PUT_FILE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.ELCLASS
					prop_default = 'ExporterPipelineBRAPH2';
				case ExporterPipelineBRAPH2.NAME
					prop_default = 'Pipeline Exporter in BRAPH2 File';
				case ExporterPipelineBRAPH2.DESCRIPTION
					prop_default = 'A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.';
				case ExporterPipelineBRAPH2.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.ID
					prop_default = 'ExporterPipelineBRAPH2 ID';
				case ExporterPipelineBRAPH2.LABEL
					prop_default = 'ExporterPipelineBRAPH2 label';
				case ExporterPipelineBRAPH2.NOTES
					prop_default = 'ExporterPipelineBRAPH2 notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			prop_default = ExporterPipelineBRAPH2.conditioning(prop, ExporterPipelineBRAPH2.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			%  CHECK = EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ExporterPipelineBRAPH2:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: €BRAPH2.STR€:ExporterPipelineBRAPH2:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: €BRAPH2.STR€:ExporterPipelineBRAPH2:€BRAPH2.WRONG_INPUT€
			%  EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: €BRAPH2.STR€:ExporterPipelineBRAPH2:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP % __ExporterPipelineBRAPH2.PIP__
					check = Format.checkFormat(Format.ITEM, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.FILE % __ExporterPipelineBRAPH2.FILE__
					check = Format.checkFormat(Format.STRING, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.PUT_FILE % __ExporterPipelineBRAPH2.PUT_FILE__
					check = Format.checkFormat(Format.EMPTY, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.SAVE % __ExporterPipelineBRAPH2.SAVE__
					check = Format.checkFormat(Format.EMPTY, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.TEMPLATE % __ExporterPipelineBRAPH2.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				otherwise
					if prop <= Exporter.getPropNumber()
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterPipelineBRAPH2.getPropTag(prop) ' (' ExporterPipelineBRAPH2.getFormatTag(ExporterPipelineBRAPH2.getPropFormat(prop)) ').'] ...
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
				case ExporterPipelineBRAPH2.PUT_FILE % __ExporterPipelineBRAPH2.PUT_FILE__
					[filename, filepath, filterindex] = uiputfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 Pipeline file');
					if filterindex
					    file = [filepath filename];
					    ex.set('FILE', file);
					end
					value = ex;
					
				case ExporterPipelineBRAPH2.SAVE % __ExporterPipelineBRAPH2.SAVE__
					rng_settings_ = rng(); rng(ex.getPropSeed(ExporterPipelineBRAPH2.SAVE), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
						wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					    
					    pip = ex.get('PIP');
					   
					    txt = [ ...
					        '%% ' pip.get('LABEL') newline()  ...
					        newline() ...
					        ];
					
					    notes = cellfun(@(x) ['% ' strtrim(x) newline()], str2cell(pip.get('NOTES')), 'UniformOutput', false);
					    for i = 1:1:length(notes)
					        txt = [txt notes{i}];
					    end
					
					    txt = [ txt ...
					        newline() ...
					        '% PDF: ' pip.get('PDF') newline() ...
					        '% README: ' pip.get('README') newline() ...
					        ];
					
					    ps_dict = pip.get('PS_DICT');
					    for s = 1:1:ps_dict.get('LENGTH')
					        ps = ps_dict.get('IT', s);
					        
					        txt = [ txt ...
					            newline() ...
					            '%% ' ps.get('LABEL') newline() ...
					            ];
					        
					        pc_dict = ps.get('PC_DICT');
					        for c = 1:1:pc_dict.get('LENGTH')
					            braph2waitbar(wb, 0 + 1.00 * (s - 1 + c / pc_dict.get('LENGTH')) / ps_dict.get('LENGTH'), ...
					                ['Saving pipeline section ' num2str(s) ' of ' num2str(ps_dict.get('LENGTH')) ...
					                ', code line ' num2str(c) ' of ' num2str(pc_dict.get('LENGTH')) ' ...'])
					                
					            pc = pc_dict.get('IT', c);
					            
					            txt = [ txt ...
					                pc.get('MONIKER') ' = ' pc.get('CODE') ' % ' pc.get('TEXT_BEFORE_EXEC') ' % ' pc.get('TEXT_AFTER_EXEC') newline() ...
					                ];
					        end
					    end
					    
					    txt = regexprep(txt, '%', '%%');
					    
					    object_file = fopen(ex.get('FILE'), 'w');
					    fprintf(object_file, txt);
					    fclose(object_file);
					    
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
