classdef SubjectCON_MP < Subject
	%SubjectCON_MP is a subject with connectivity multiplex data.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with L connectivity matrices (e.g. obtained from DTI).
	%
	% SubjectCON_MP methods (constructor):
	%  SubjectCON_MP - constructor
	%
	% SubjectCON_MP methods:
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
	% SubjectCON_MP methods (display):
	%  tostring - string with information about the subject with connectivity multiplex data
	%  disp - displays information about the subject with connectivity multiplex data
	%  tree - displays the tree of the subject with connectivity multiplex data
	%
	% SubjectCON_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with connectivity multiplex data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with connectivity multiplex data
	%
	% SubjectCON_MP methods (save/load, Static):
	%  save - saves BRAPH2 subject with connectivity multiplex data as b2 file
	%  load - loads a BRAPH2 subject with connectivity multiplex data from a b2 file
	%
	% SubjectCON_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with connectivity multiplex data
	%
	% SubjectCON_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with connectivity multiplex data
	%
	% SubjectCON_MP methods (inspection, Static):
	%  getClass - returns the class of the subject with connectivity multiplex data
	%  getSubclasses - returns all subclasses of SubjectCON_MP
	%  getProps - returns the property list of the subject with connectivity multiplex data
	%  getPropNumber - returns the property number of the subject with connectivity multiplex data
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
	% SubjectCON_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectCON_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectCON_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectCON_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectCON_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectCON_MP constants</a>.
	%
	%
	% See also ImporterGroupSubjectCON_MP_TXT, ExporterGroupSubjectCON_MP_TXT, ImporterGroupSubjectCON_MP_XLS, ExporterGroupSubjectCON_MP_XLS.
	
	properties (Constant) % properties
		BA = Subject.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		L = Subject.getPropNumber() + 2;
		L_TAG = 'L';
		L_CATEGORY = Category.DATA;
		L_FORMAT = Format.SCALAR;
		
		LAYERLABELS = Subject.getPropNumber() + 3;
		LAYERLABELS_TAG = 'LAYERLABELS';
		LAYERLABELS_CATEGORY = Category.METADATA;
		LAYERLABELS_FORMAT = Format.STRINGLIST;
		
		ALAYERLABELS = Subject.getPropNumber() + 4;
		ALAYERLABELS_TAG = 'ALAYERLABELS';
		ALAYERLABELS_CATEGORY = Category.QUERY;
		ALAYERLABELS_FORMAT = Format.STRINGLIST;
		
		CON_MP = Subject.getPropNumber() + 5;
		CON_MP_TAG = 'CON_MP';
		CON_MP_CATEGORY = Category.DATA;
		CON_MP_FORMAT = Format.CELL;
	end
	methods % constructor
		function sub = SubjectCON_MP(varargin)
			%SubjectCON_MP() creates a subject with connectivity multiplex data.
			%
			% SubjectCON_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectCON_MP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the subject with connectivity multiplex data.
			%
			% CLASS = SubjectCON_MP.GETCLASS() returns the class 'SubjectCON_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with connectivity multiplex data SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectCON_MP') returns 'SubjectCON_MP'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectCON_MP')
			%  are less computationally efficient.
			
			sub_class = 'SubjectCON_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with connectivity multiplex data.
			%
			% LIST = SubjectCON_MP.GETSUBCLASSES() returns all subclasses of 'SubjectCON_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with connectivity multiplex data SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectCON_MP') returns all subclasses of 'SubjectCON_MP'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectCON_MP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with connectivity multiplex data.
			%
			% PROPS = SubjectCON_MP.GETPROPS() returns the property list of subject with connectivity multiplex data
			%  as a row vector.
			%
			% PROPS = SubjectCON_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with connectivity multiplex data SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectCON_MP'[, CATEGORY]) returns the property list of 'SubjectCON_MP'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Subject.getProps() ...
						SubjectCON_MP.BA ...
						SubjectCON_MP.L ...
						SubjectCON_MP.LAYERLABELS ...
						SubjectCON_MP.ALAYERLABELS ...
						SubjectCON_MP.CON_MP ...
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
						SubjectCON_MP.LAYERLABELS ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Subject.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Subject.getProps(Category.DATA) ...
						SubjectCON_MP.BA ...
						SubjectCON_MP.L ...
						SubjectCON_MP.CON_MP ...
						];
				case Category.RESULT
					prop_list = [
						Subject.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Subject.getProps(Category.QUERY) ...
						SubjectCON_MP.ALAYERLABELS ...
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
			%GETPROPNUMBER returns the property number of subject with connectivity multiplex data.
			%
			% N = SubjectCON_MP.GETPROPNUMBER() returns the property number of subject with connectivity multiplex data.
			%
			% N = SubjectCON_MP.GETPROPNUMBER(CATEGORY) returns the property number of subject with connectivity multiplex data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with connectivity multiplex data SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectCON_MP') returns the property number of 'SubjectCON_MP'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectCON_MP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with connectivity multiplex data/error.
			%
			% CHECK = SubjectCON_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectCON_MP, PROP) checks whether PROP exists for SubjectCON_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%  Element.EXISTSPROP(SubjectCON_MP, PROP) throws error if PROP does NOT exist for SubjectCON_MP.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectCON_MP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectCON_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with connectivity multiplex data/error.
			%
			% CHECK = SubjectCON_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectCON_MP, TAG) checks whether TAG exists for SubjectCON_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%  Element.EXISTSTAG(SubjectCON_MP, TAG) throws error if TAG does NOT exist for SubjectCON_MP.
			%   Error id: [BRAPH2:SubjectCON_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectcon_mp_tag_list = cellfun(@(x) SubjectCON_MP.getPropTag(x), num2cell(SubjectCON_MP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectcon_mp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectCON_MP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SubjectCON_MP, POINTER) returns property number of POINTER of SubjectCON_MP.
			%  PROPERTY = SUB.GETPROPPROP(SubjectCON_MP, POINTER) returns property number of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectcon_mp_tag_list = cellfun(@(x) SubjectCON_MP.getPropTag(x), num2cell(SubjectCON_MP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectcon_mp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SubjectCON_MP, POINTER) returns tag of POINTER of SubjectCON_MP.
			%  TAG = SUB.GETPROPTAG(SubjectCON_MP, POINTER) returns tag of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectCON_MP.BA
						tag = SubjectCON_MP.BA_TAG;
					case SubjectCON_MP.L
						tag = SubjectCON_MP.L_TAG;
					case SubjectCON_MP.LAYERLABELS
						tag = SubjectCON_MP.LAYERLABELS_TAG;
					case SubjectCON_MP.ALAYERLABELS
						tag = SubjectCON_MP.ALAYERLABELS_TAG;
					case SubjectCON_MP.CON_MP
						tag = SubjectCON_MP.CON_MP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectCON_MP, POINTER) returns category of POINTER of SubjectCON_MP.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectCON_MP, POINTER) returns category of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA
					prop_category = SubjectCON_MP.BA_CATEGORY;
				case SubjectCON_MP.L
					prop_category = SubjectCON_MP.L_CATEGORY;
				case SubjectCON_MP.LAYERLABELS
					prop_category = SubjectCON_MP.LAYERLABELS_CATEGORY;
				case SubjectCON_MP.ALAYERLABELS
					prop_category = SubjectCON_MP.ALAYERLABELS_CATEGORY;
				case SubjectCON_MP.CON_MP
					prop_category = SubjectCON_MP.CON_MP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SubjectCON_MP, POINTER) returns format of POINTER of SubjectCON_MP.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectCON_MP, POINTER) returns format of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA
					prop_format = SubjectCON_MP.BA_FORMAT;
				case SubjectCON_MP.L
					prop_format = SubjectCON_MP.L_FORMAT;
				case SubjectCON_MP.LAYERLABELS
					prop_format = SubjectCON_MP.LAYERLABELS_FORMAT;
				case SubjectCON_MP.ALAYERLABELS
					prop_format = SubjectCON_MP.ALAYERLABELS_FORMAT;
				case SubjectCON_MP.CON_MP
					prop_format = SubjectCON_MP.CON_MP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectCON_MP, POINTER) returns description of POINTER of SubjectCON_MP.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectCON_MP, POINTER) returns description of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case SubjectCON_MP.L
					prop_description = 'L (data, scalar) is the number of layers of subject data.';
				case SubjectCON_MP.LAYERLABELS
					prop_description = 'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.';
				case SubjectCON_MP.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the processed layer labels.';
				case SubjectCON_MP.CON_MP
					prop_description = 'CON_MP (data, cell) is a cell containing L matrices corresponding connectivity matrices of each layer.';
				case SubjectCON_MP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject.';
				case SubjectCON_MP.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case SubjectCON_MP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case SubjectCON_MP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case SubjectCON_MP.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case SubjectCON_MP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case SubjectCON_MP.NOTES
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
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectCON_MP, POINTER) returns settings of POINTER of SubjectCON_MP.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectCON_MP, POINTER) returns settings of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA
					prop_settings = 'BrainAtlas';
				case SubjectCON_MP.L
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SubjectCON_MP.LAYERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case SubjectCON_MP.ALAYERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case SubjectCON_MP.CON_MP
					prop_settings = Format.getFormatSettings(Format.CELL);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectCON_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectCON_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectCON_MP, POINTER) returns the default value of POINTER of SubjectCON_MP.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectCON_MP, POINTER) returns the default value of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.L
					prop_default = Format.getFormatDefault(Format.SCALAR, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.LAYERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.ALAYERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.CON_MP
					prop_default = Format.getFormatDefault(Format.CELL, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.ELCLASS
					prop_default = 'SubjectCON_MP';
				case SubjectCON_MP.NAME
					prop_default = 'Multiplex Connectivity Subject';
				case SubjectCON_MP.DESCRIPTION
					prop_default = 'Subject with L connectivity matrices (e.g. obtained from DTI).';
				case SubjectCON_MP.ID
					prop_default = 'SubjectCON_MP ID';
				case SubjectCON_MP.LABEL
					prop_default = 'SubjectCON_MP label';
				case SubjectCON_MP.NOTES
					prop_default = 'SubjectCON_MP notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectCON_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectCON_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectCON_MP, POINTER) returns the conditioned default value of POINTER of SubjectCON_MP.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectCON_MP, POINTER) returns the conditioned default value of POINTER of SubjectCON_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			prop_default = SubjectCON_MP.conditioning(prop, SubjectCON_MP.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(sub, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case SubjectCON_MP.L % __SubjectCON_MP.L__
					value = abs(round(value));
					
				otherwise
					if prop <= Subject.getPropNumber()
						value = preset@Subject(sub, prop, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(SubjectCON_MP, PROP, VALUE) checks VALUE format for PROP of SubjectCON_MP.
			%  CHECK = SUB.CHECKPROP(SubjectCON_MP, PROP, VALUE) checks VALUE format for PROP of SubjectCON_MP.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectCON_MP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:SubjectCON_MP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectCON_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectCON_MP.
			%   Error id: €BRAPH2.STR€:SubjectCON_MP:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(SubjectCON_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectCON_MP.
			%   Error id: €BRAPH2.STR€:SubjectCON_MP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectCON_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectCON_MP.getPropProp(pointer);
			
			switch prop
				case SubjectCON_MP.BA % __SubjectCON_MP.BA__
					check = Format.checkFormat(Format.ITEM, value, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.L % __SubjectCON_MP.L__
					check = Format.checkFormat(Format.SCALAR, value, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.LAYERLABELS % __SubjectCON_MP.LAYERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.ALAYERLABELS % __SubjectCON_MP.ALAYERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, SubjectCON_MP.getPropSettings(prop));
				case SubjectCON_MP.CON_MP % __SubjectCON_MP.CON_MP__
					check = Format.checkFormat(Format.CELL, value, SubjectCON_MP.getPropSettings(prop));
				otherwise
					if prop <= Subject.getPropNumber()
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectCON_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectCON_MP.getPropTag(prop) ' (' SubjectCON_MP.getFormatTag(SubjectCON_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(sub, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case SubjectCON_MP.L % __SubjectCON_MP.L__
					if ~isa(sub.getr('CON_MP'), 'NoValue') && sub.get('L') ~= length(sub.get('CON_MP'))
					    sub.set('L', length(sub.get('CON_MP')))
					end
					
				case SubjectCON_MP.LAYERLABELS % __SubjectCON_MP.LAYERLABELS__
					if ~isa(sub.getr('L'), 'NoValue') && length(sub.get('LAYERLABELS')) ~= sub.get('L')
					    title = ['About Layer Labels'];
					    message = {''
					        ['{\bf\color{orange}' BRAPH2.STR '}'] % note to use doubl slashes to avoid genesis problem
					        ['{\color{gray}version ' BRAPH2.VERSION '}']
					        ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
					        ''
					        'Please, select a valid number of Layer Labels.'
					        ''
					        ''};
					    braph2msgbox(title, message)
					    
					    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('CON_MP'))))))
					end
					
				case SubjectCON_MP.CON_MP % __SubjectCON_MP.CON_MP__
					if length(sub.get('LAYERLABELS')) ~= sub.get('L')
					    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('CON_MP'))))))
					end
					
				otherwise
					if prop <= Subject.getPropNumber()
						postset@Subject(sub, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(sub, prop, varargin)
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
				case SubjectCON_MP.ALAYERLABELS % __SubjectCON_MP.ALAYERLABELS__
					value = sub.get('LAYERLABELS');
					
				otherwise
					if prop <= Subject.getPropNumber()
						value = calculateValue@Subject(sub, prop, varargin{:});
					else
						value = calculateValue@Element(sub, prop, varargin{:});
					end
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
				case SubjectCON_MP.CON_MP % __SubjectCON_MP.CON_MP__
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					num_layers = sub.get('L');
					check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 1), value), ones(1, num_layers) * br_number)  && isequal( cellfun(@(v) size(v, 2), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0);
					if check
					    msg = 'All ok!';
					else   
					    msg = ['CON_MP must be a cell with L square matrices with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
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
				case SubjectCON_MP.CON_MP % __SubjectCON_MP.CON_MP__
					pr = PanelPropCell('EL', sub, 'PROP', SubjectCON_MP.CON_MP, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Subject(sub, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.TXT', ...
			        'Label', 'Import TXT ...', ...
			        'Callback', {@cb_importer_TXT});
			end
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterGroupSubjectCON_MP_TXT( ...
			            'ID', 'Import Group of SubjectCON_MPs from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCON_MPs in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.XLS', ...
			        'Label', 'Import XLS ...', ...
			        'Callback', {@cb_importer_XLS});
			end
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterGroupSubjectCON_MP_XLS( ...
			            'ID', 'Import Group of SubjectCON_MPs from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCON_MPs in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.TXT', ...
			        'Label', 'Export TXT ...', ...
			        'Callback', {@cb_exporter_TXT});
			end
			function cb_exporter_TXT(~, ~)
			    ex = ExporterGroupSubjectCON_MP_TXT( ...
			        'ID', 'Export Brain Group of SubjectCON_MPs to TXT', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.XLS', ...
			        'Label', 'Export XLS ...', ...
			        'Callback', {@cb_exporter_XLS});
			end
			function cb_exporter_XLS(~, ~)
			    ex = ExporterGroupSubjectCON_MP_XLS( ...
			        'ID', 'Export Brain Group of SubjectCON_MPs to XLS', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
