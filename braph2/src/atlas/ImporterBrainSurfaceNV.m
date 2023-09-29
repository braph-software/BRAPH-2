classdef ImporterBrainSurfaceNV < Importer
	%ImporterBrainSurfaceNV imports a brain surface from a NV file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.
	%
	% ImporterBrainSurfaceNV methods (constructor):
	%  ImporterBrainSurfaceNV - constructor
	%
	% ImporterBrainSurfaceNV methods:
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
	% ImporterBrainSurfaceNV methods (display):
	%  tostring - string with information about the brain surface importer from NV
	%  disp - displays information about the brain surface importer from NV
	%  tree - displays the tree of the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain surface importer from NV are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (save/load, Static):
	%  save - saves BRAPH2 brain surface importer from NV as b2 file
	%  load - loads a BRAPH2 brain surface importer from NV from a b2 file
	%
	% ImporterBrainSurfaceNV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (inspection, Static):
	%  getClass - returns the class of the brain surface importer from NV
	%  getSubclasses - returns all subclasses of ImporterBrainSurfaceNV
	%  getProps - returns the property list of the brain surface importer from NV
	%  getPropNumber - returns the property number of the brain surface importer from NV
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
	% ImporterBrainSurfaceNV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterBrainSurfaceNV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterBrainSurfaceNV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainSurfaceNV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterBrainSurfaceNV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterBrainSurfaceNV constants</a>.
	%
	%
	% See also BrainSurface.
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		GET_FILE = Importer.getPropNumber() + 2;
		GET_FILE_TAG = 'GET_FILE';
		GET_FILE_CATEGORY = Category.QUERY;
		GET_FILE_FORMAT = Format.ITEM;
		
		SURF = Importer.getPropNumber() + 3;
		SURF_TAG = 'SURF';
		SURF_CATEGORY = Category.RESULT;
		SURF_FORMAT = Format.ITEM;
	end
	methods % constructor
		function im = ImporterBrainSurfaceNV(varargin)
			%ImporterBrainSurfaceNV() creates a brain surface importer from NV.
			%
			% ImporterBrainSurfaceNV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainSurfaceNV(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the brain surface importer from NV.
			%
			% CLASS = ImporterBrainSurfaceNV.GETCLASS() returns the class 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the brain surface importer from NV IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainSurfaceNV') returns 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			
			im_class = 'ImporterBrainSurfaceNV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain surface importer from NV.
			%
			% LIST = ImporterBrainSurfaceNV.GETSUBCLASSES() returns all subclasses of 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the brain surface importer from NV IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterBrainSurfaceNV') returns all subclasses of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ImporterBrainSurfaceNV', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain surface importer from NV.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS() returns the property list of brain surface importer from NV
			%  as a row vector.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the brain surface importer from NV IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainSurfaceNV'[, CATEGORY]) returns the property list of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Importer.getProps() ...
						ImporterBrainSurfaceNV.FILE ...
						ImporterBrainSurfaceNV.GET_FILE ...
						ImporterBrainSurfaceNV.SURF ...
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
						ImporterBrainSurfaceNV.FILE ...
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT) ...
						ImporterBrainSurfaceNV.SURF ...
						];
				case Category.QUERY
					prop_list = [ ...
						Importer.getProps(Category.QUERY) ...
						ImporterBrainSurfaceNV.GET_FILE ...
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
			%GETPROPNUMBER returns the property number of brain surface importer from NV.
			%
			% N = ImporterBrainSurfaceNV.GETPROPNUMBER() returns the property number of brain surface importer from NV.
			%
			% N = ImporterBrainSurfaceNV.GETPROPNUMBER(CATEGORY) returns the property number of brain surface importer from NV
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the brain surface importer from NV IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainSurfaceNV') returns the property number of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ImporterBrainSurfaceNV.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain surface importer from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) checks whether PROP exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) throws error if PROP does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ImporterBrainSurfaceNV.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainSurfaceNV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain surface importer from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) checks whether TAG exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) throws error if TAG does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importerbrainsurfacenv_tag_list = cellfun(@(x) ImporterBrainSurfaceNV.getPropTag(x), num2cell(ImporterBrainSurfaceNV.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importerbrainsurfacenv_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ImporterBrainSurfaceNV.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importerbrainsurfacenv_tag_list = cellfun(@(x) ImporterBrainSurfaceNV.getPropTag(x), num2cell(ImporterBrainSurfaceNV.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importerbrainsurfacenv_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%  TAG = IM.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ImporterBrainSurfaceNV.FILE
						tag = ImporterBrainSurfaceNV.FILE_TAG;
					case ImporterBrainSurfaceNV.GET_FILE
						tag = ImporterBrainSurfaceNV.GET_FILE_TAG;
					case ImporterBrainSurfaceNV.SURF
						tag = ImporterBrainSurfaceNV.SURF_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_category = ImporterBrainSurfaceNV.FILE_CATEGORY;
				case ImporterBrainSurfaceNV.GET_FILE
					prop_category = ImporterBrainSurfaceNV.GET_FILE_CATEGORY;
				case ImporterBrainSurfaceNV.SURF
					prop_category = ImporterBrainSurfaceNV.SURF_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_format = ImporterBrainSurfaceNV.FILE_FORMAT;
				case ImporterBrainSurfaceNV.GET_FILE
					prop_format = ImporterBrainSurfaceNV.GET_FILE_FORMAT;
				case ImporterBrainSurfaceNV.SURF
					prop_format = ImporterBrainSurfaceNV.SURF_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_description = 'FILE (data, string) is the NV file from where to load the brain atlas.';
				case ImporterBrainSurfaceNV.GET_FILE
					prop_description = 'GET_FILE (query, item) opens a dialog box to set the NV file where to save the brain atlas.';
				case ImporterBrainSurfaceNV.SURF
					prop_description = 'SURF (result, item) is a brain surface.';
				case ImporterBrainSurfaceNV.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the brain surface importer from NV.';
				case ImporterBrainSurfaceNV.NAME
					prop_description = 'NAME (constant, string) is the name of the brain surface importer from NV.';
				case ImporterBrainSurfaceNV.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the brain surface importer from NV.';
				case ImporterBrainSurfaceNV.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the importe of the brain surface from NVr.';
				case ImporterBrainSurfaceNV.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain surface importer from NV.';
				case ImporterBrainSurfaceNV.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain surface importer from NV.';
				case ImporterBrainSurfaceNV.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain surface importer from NV.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterBrainSurfaceNV.GET_FILE
					prop_settings = 'ImporterBrainSurfaceNV';
				case ImporterBrainSurfaceNV.SURF
					prop_settings = 'BrainSurface';
				case ImporterBrainSurfaceNV.TEMPLATE
					prop_settings = 'ImporterBrainSurfaceNV';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_default = 'human_ICBM152.nv';
				case ImporterBrainSurfaceNV.GET_FILE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.SURF
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.ELCLASS
					prop_default = 'ImporterBrainSurfaceNV';
				case ImporterBrainSurfaceNV.NAME
					prop_default = 'Brain Surface Importer from NV Files';
				case ImporterBrainSurfaceNV.DESCRIPTION
					prop_default = 'A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.';
				case ImporterBrainSurfaceNV.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.ID
					prop_default = 'ImporterBrainSurfaceNV ID';
				case ImporterBrainSurfaceNV.LABEL
					prop_default = 'ImporterBrainSurfaceNV label';
				case ImporterBrainSurfaceNV.NOTES
					prop_default = 'ImporterBrainSurfaceNV notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			prop_default = ImporterBrainSurfaceNV.conditioning(prop, ImporterBrainSurfaceNV.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			%  CHECK = IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ImporterBrainSurfaceNV:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:ImporterBrainSurfaceNV:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: €BRAPH2.STR€:ImporterBrainSurfaceNV:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: €BRAPH2.STR€:ImporterBrainSurfaceNV:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE % __ImporterBrainSurfaceNV.FILE__
					check = Format.checkFormat(Format.STRING, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.GET_FILE % __ImporterBrainSurfaceNV.GET_FILE__
					check = Format.checkFormat(Format.ITEM, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.SURF % __ImporterBrainSurfaceNV.SURF__
					check = Format.checkFormat(Format.ITEM, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.TEMPLATE % __ImporterBrainSurfaceNV.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				otherwise
					if prop <= Importer.getPropNumber()
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainSurfaceNV.getPropTag(prop) ' (' ImporterBrainSurfaceNV.getFormatTag(ImporterBrainSurfaceNV.getPropFormat(prop)) ').'] ...
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
				case ImporterBrainSurfaceNV.GET_FILE % __ImporterBrainSurfaceNV.GET_FILE__
					[filename, filepath, filterindex] = uigetfile('*.nv', 'Select NV file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case ImporterBrainSurfaceNV.SURF % __ImporterBrainSurfaceNV.SURF__
					rng_settings_ = rng(); rng(im.getPropSeed(ImporterBrainSurfaceNV.SURF), 'twister')
					
					% creates empty BrainSurface
					bs = BrainSurface();
					
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file)
					    file = [fileparts(which('braph2')) filesep 'brainsurfs' filesep file];
					end
					
					if isfile(file)
						wb = braph2waitbar(im.get('WAITBAR'), .15, 'Reading brain surface file ...');
					    
					    fid = fopen(file);
					    vertex_number = fscanf(fid, '%f', 1);
					    coord = fscanf(fid, '%f', [3, vertex_number])';
					    tri_number = fscanf(fid, '%f', 1);
					    tri = fscanf(fid, '%d', [3, tri_number])';
					    fclose(fid);
					    
					    splits = split(file, filesep);
					    name = splits{end};
					    
					    bs.set('ID', name)
					    bs.set('VERTEX_NUMBER', vertex_number);
					    bs.set('COORDINATES', coord);
					    bs.set('TRIANGLES_NUMBER', tri_number);
					    bs.set('TRIANGLES', tri);
					    
						braph2waitbar(wb, 'close')
					else
					    error([BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO], ...
					        [BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO '\n' ...
					        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
					        );    
					end
					
					value = bs;
					
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
end
