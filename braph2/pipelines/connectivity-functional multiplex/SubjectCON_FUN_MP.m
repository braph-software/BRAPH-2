classdef SubjectCON_FUN_MP < Subject
	%SubjectCON_FUN_MP is a subject with connectivity and functional multiplex data (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with connectivity and functional data (e.g. obtained from DTI and fMRI).
	% The first layer contains a connectivity matrix and the second layer contains functional data.
	%
	% SubjectCON_FUN_MP methods (constructor):
	%  SubjectCON_FUN_MP - constructor
	%
	% SubjectCON_FUN_MP methods:
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
	% SubjectCON_FUN_MP methods (display):
	%  tostring - string with information about the subject with connectivity and functional multiplex data
	%  disp - displays information about the subject with connectivity and functional multiplex data
	%  tree - displays the tree of the subject with connectivity and functional multiplex data
	%
	% SubjectCON_FUN_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with connectivity and functional multiplex data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with connectivity and functional multiplex data
	%
	% SubjectCON_FUN_MP methods (save/load, Static):
	%  save - saves BRAPH2 subject with connectivity and functional multiplex data as b2 file
	%  load - loads a BRAPH2 subject with connectivity and functional multiplex data from a b2 file
	%
	% SubjectCON_FUN_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with connectivity and functional multiplex data
	%
	% SubjectCON_FUN_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with connectivity and functional multiplex data
	%
	% SubjectCON_FUN_MP methods (inspection, Static):
	%  getClass - returns the class of the subject with connectivity and functional multiplex data
	%  getSubclasses - returns all subclasses of SubjectCON_FUN_MP
	%  getProps - returns the property list of the subject with connectivity and functional multiplex data
	%  getPropNumber - returns the property number of the subject with connectivity and functional multiplex data
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
	% SubjectCON_FUN_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectCON_FUN_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectCON_FUN_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectCON_FUN_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectCON_FUN_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectCON_FUN_MP constants</a>.
	%
	%
	% See also CombineGroups_CON_FUN_MP, SeparateGroups_CON_FUN_MP.
	
	properties (Constant) % properties
		BA = Subject.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		CON = Subject.getPropNumber() + 2;
		CON_TAG = 'CON';
		CON_CATEGORY = Category.DATA;
		CON_FORMAT = Format.SMATRIX;
		
		FUN = Subject.getPropNumber() + 3;
		FUN_TAG = 'FUN';
		FUN_CATEGORY = Category.DATA;
		FUN_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function sub = SubjectCON_FUN_MP(varargin)
			%SubjectCON_FUN_MP() creates a subject with connectivity and functional multiplex data.
			%
			% SubjectCON_FUN_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectCON_FUN_MP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static) % inspection
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with connectivity and functional multiplex data.
			%
			% CLASS = SubjectCON_FUN_MP.GETCLASS() returns the class 'SubjectCON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with connectivity and functional multiplex data SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectCON_FUN_MP') returns 'SubjectCON_FUN_MP'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			
			sub_class = 'SubjectCON_FUN_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with connectivity and functional multiplex data.
			%
			% LIST = SubjectCON_FUN_MP.GETSUBCLASSES() returns all subclasses of 'SubjectCON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with connectivity and functional multiplex data SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectCON_FUN_MP') returns all subclasses of 'SubjectCON_FUN_MP'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectCON_FUN_MP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with connectivity and functional multiplex data.
			%
			% PROPS = SubjectCON_FUN_MP.GETPROPS() returns the property list of subject with connectivity and functional multiplex data
			%  as a row vector.
			%
			% PROPS = SubjectCON_FUN_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with connectivity and functional multiplex data SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectCON_FUN_MP'[, CATEGORY]) returns the property list of 'SubjectCON_FUN_MP'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Subject.getProps() ...
						SubjectCON_FUN_MP.BA ...
						SubjectCON_FUN_MP.CON ...
						SubjectCON_FUN_MP.FUN ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Subject.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Subject.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Subject.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Subject.getProps(Category.DATA) ...
						SubjectCON_FUN_MP.BA ...
						SubjectCON_FUN_MP.CON ...
						SubjectCON_FUN_MP.FUN ...
						];
				case Category.RESULT
					prop_list = [
						Subject.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Subject.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Subject.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Subject.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Subject.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject with connectivity and functional multiplex data.
			%
			% N = SubjectCON_FUN_MP.GETPROPNUMBER() returns the property number of subject with connectivity and functional multiplex data.
			%
			% N = SubjectCON_FUN_MP.GETPROPNUMBER(CATEGORY) returns the property number of subject with connectivity and functional multiplex data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with connectivity and functional multiplex data SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectCON_FUN_MP') returns the property number of 'SubjectCON_FUN_MP'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectCON_FUN_MP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with connectivity and functional multiplex data/error.
			%
			% CHECK = SubjectCON_FUN_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectCON_FUN_MP, PROP) checks whether PROP exists for SubjectCON_FUN_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SubjectCON_FUN_MP, PROP) throws error if PROP does NOT exist for SubjectCON_FUN_MP.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectCON_FUN_MP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectCON_FUN_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with connectivity and functional multiplex data/error.
			%
			% CHECK = SubjectCON_FUN_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectCON_FUN_MP, TAG) checks whether TAG exists for SubjectCON_FUN_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SubjectCON_FUN_MP, TAG) throws error if TAG does NOT exist for SubjectCON_FUN_MP.
			%   Error id: [BRAPH2:SubjectCON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectcon_fun_mp_tag_list = cellfun(@(x) SubjectCON_FUN_MP.getPropTag(x), num2cell(SubjectCON_FUN_MP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectcon_fun_mp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectCON_FUN_MP.'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(SubjectCON_FUN_MP, POINTER) returns property number of POINTER of SubjectCON_FUN_MP.
			%  PROPERTY = SUB.GETPROPPROP(SubjectCON_FUN_MP, POINTER) returns property number of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectcon_fun_mp_tag_list = cellfun(@(x) SubjectCON_FUN_MP.getPropTag(x), num2cell(SubjectCON_FUN_MP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectcon_fun_mp_tag_list)); % tag = pointer
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(SubjectCON_FUN_MP, POINTER) returns tag of POINTER of SubjectCON_FUN_MP.
			%  TAG = SUB.GETPROPTAG(SubjectCON_FUN_MP, POINTER) returns tag of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectCON_FUN_MP.BA
						tag = SubjectCON_FUN_MP.BA_TAG;
					case SubjectCON_FUN_MP.CON
						tag = SubjectCON_FUN_MP.CON_TAG;
					case SubjectCON_FUN_MP.FUN
						tag = SubjectCON_FUN_MP.FUN_TAG;
					otherwise
						tag = getPropTag@Subject(prop);
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectCON_FUN_MP, POINTER) returns category of POINTER of SubjectCON_FUN_MP.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectCON_FUN_MP, POINTER) returns category of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA
					prop_category = SubjectCON_FUN_MP.BA_CATEGORY;
				case SubjectCON_FUN_MP.CON
					prop_category = SubjectCON_FUN_MP.CON_CATEGORY;
				case SubjectCON_FUN_MP.FUN
					prop_category = SubjectCON_FUN_MP.FUN_CATEGORY;
				otherwise
					prop_category = getPropCategory@Subject(prop);
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(SubjectCON_FUN_MP, POINTER) returns format of POINTER of SubjectCON_FUN_MP.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectCON_FUN_MP, POINTER) returns format of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA
					prop_format = SubjectCON_FUN_MP.BA_FORMAT;
				case SubjectCON_FUN_MP.CON
					prop_format = SubjectCON_FUN_MP.CON_FORMAT;
				case SubjectCON_FUN_MP.FUN
					prop_format = SubjectCON_FUN_MP.FUN_FORMAT;
				otherwise
					prop_format = getPropFormat@Subject(prop);
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectCON_FUN_MP, POINTER) returns description of POINTER of SubjectCON_FUN_MP.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectCON_FUN_MP, POINTER) returns description of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case SubjectCON_FUN_MP.CON
					prop_description = 'CON (data, smatrix) is an adjacency matrix.';
				case SubjectCON_FUN_MP.FUN
					prop_description = 'FUN (data, matrix) is an adjacency matrix.';
				case SubjectCON_FUN_MP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject.';
				case SubjectCON_FUN_MP.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case SubjectCON_FUN_MP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case SubjectCON_FUN_MP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case SubjectCON_FUN_MP.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case SubjectCON_FUN_MP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case SubjectCON_FUN_MP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the subject.';
				otherwise
					prop_description = getPropDescription@Subject(prop);
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectCON_FUN_MP, POINTER) returns settings of POINTER of SubjectCON_FUN_MP.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectCON_FUN_MP, POINTER) returns settings of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA
					prop_settings = 'BrainAtlas';
				case SubjectCON_FUN_MP.CON
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case SubjectCON_FUN_MP.FUN
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectCON_FUN_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectCON_FUN_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectCON_FUN_MP, POINTER) returns the default value of POINTER of SubjectCON_FUN_MP.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectCON_FUN_MP, POINTER) returns the default value of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectCON_FUN_MP.getPropSettings(prop));
				case SubjectCON_FUN_MP.CON
					prop_default = Format.getFormatDefault(Format.SMATRIX, SubjectCON_FUN_MP.getPropSettings(prop));
				case SubjectCON_FUN_MP.FUN
					prop_default = Format.getFormatDefault(Format.MATRIX, SubjectCON_FUN_MP.getPropSettings(prop));
				case SubjectCON_FUN_MP.ELCLASS
					prop_default = 'SubjectCON_FUN_MP';
				case SubjectCON_FUN_MP.NAME
					prop_default = 'Multiplex Connectivity-Functional Subject';
				case SubjectCON_FUN_MP.DESCRIPTION
					prop_default = 'Subject with connectivity and functional data (e.g. obtained from DTI and fMRI). The first layer contains a connectivity matrix and the second layer contains functional data.';
				case SubjectCON_FUN_MP.ID
					prop_default = 'SubjectCON_FUN_MP ID';
				case SubjectCON_FUN_MP.LABEL
					prop_default = 'SubjectCON_FUN_MP label';
				case SubjectCON_FUN_MP.NOTES
					prop_default = 'SubjectCON_FUN_MP notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectCON_FUN_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectCON_FUN_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectCON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SubjectCON_FUN_MP.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectCON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SubjectCON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			prop_default = SubjectCON_FUN_MP.conditioning(prop, SubjectCON_FUN_MP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(SubjectCON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SubjectCON_FUN_MP.
			%  CHECK = SUB.CHECKPROP(SubjectCON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SubjectCON_FUN_MP.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectCON_FUN_MP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:SubjectCON_FUN_MP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectCON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectCON_FUN_MP.
			%   Error id: €BRAPH2.STR€:SubjectCON_FUN_MP:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(SubjectCON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectCON_FUN_MP.
			%   Error id: €BRAPH2.STR€:SubjectCON_FUN_MP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectCON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectCON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_FUN_MP.BA % __SubjectCON_FUN_MP.BA__
					check = Format.checkFormat(Format.ITEM, value, SubjectCON_FUN_MP.getPropSettings(prop));
				case SubjectCON_FUN_MP.CON % __SubjectCON_FUN_MP.CON__
					check = Format.checkFormat(Format.SMATRIX, value, SubjectCON_FUN_MP.getPropSettings(prop));
				case SubjectCON_FUN_MP.FUN % __SubjectCON_FUN_MP.FUN__
					check = Format.checkFormat(Format.MATRIX, value, SubjectCON_FUN_MP.getPropSettings(prop));
				otherwise
					if prop <= Subject.getPropNumber()
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectCON_FUN_MP.getPropTag(prop) ' (' SubjectCON_FUN_MP.getFormatTag(SubjectCON_FUN_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(sub, prop, value)
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
			msg = ['Error while checking ' tostring(sub) ' ' sub.getPropTag(prop) '.'];
			
			switch prop
				case SubjectCON_FUN_MP.CON % __SubjectCON_FUN_MP.CON__
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
					if check
					    msg = 'All ok!';
					else   
					    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
					end
					
				case SubjectCON_FUN_MP.FUN % __SubjectCON_FUN_MP.FUN__
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
					if check
					    msg = 'All ok!';
					else   
					    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
					end
					
				otherwise
					if prop <= Subject.getPropNumber()
						[check, msg] = checkValue@Subject(sub, prop, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(sub, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case SubjectCON_FUN_MP.CON % __SubjectCON_FUN_MP.CON__
					pr = PanelPropMatrix('EL', sub, 'PROP', SubjectCON.CON, ...
					    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    varargin{:});
					
				case SubjectCON_FUN_MP.FUN % __SubjectCON_FUN_MP.FUN__
					pr = PanelPropMatrix('EL', sub, 'PROP', SubjectFUN.FUN, ...
					    'ROWNAME', {'numbered'}, ...
					    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Subject(sub, prop, varargin{:});
					
			end
		end
	end
end
