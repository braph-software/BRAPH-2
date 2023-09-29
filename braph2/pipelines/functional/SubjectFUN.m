classdef SubjectFUN < Subject
	%SubjectFUN is a subject with functional matrix (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with a functional matrix (e.g. obtained from fMRI).
	%
	% SubjectFUN methods (constructor):
	%  SubjectFUN - constructor
	%
	% SubjectFUN methods:
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
	% SubjectFUN methods (display):
	%  tostring - string with information about the subject with functional matrix
	%  disp - displays information about the subject with functional matrix
	%  tree - displays the tree of the subject with functional matrix
	%
	% SubjectFUN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with functional matrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with functional matrix
	%
	% SubjectFUN methods (save/load, Static):
	%  save - saves BRAPH2 subject with functional matrix as b2 file
	%  load - loads a BRAPH2 subject with functional matrix from a b2 file
	%
	% SubjectFUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with functional matrix
	%
	% SubjectFUN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with functional matrix
	%
	% SubjectFUN methods (inspection, Static):
	%  getClass - returns the class of the subject with functional matrix
	%  getSubclasses - returns all subclasses of SubjectFUN
	%  getProps - returns the property list of the subject with functional matrix
	%  getPropNumber - returns the property number of the subject with functional matrix
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
	% SubjectFUN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectFUN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectFUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectFUN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectFUN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectFUN constants</a>.
	%
	%
	% See also ImporterGroupSubjectFUN_TXT, ExporterGroupSubjectFUN_TXT, ImporterGroupSubjectFUN_XLS, ExporterGroupSubjectFUN_XLS.
	
	properties (Constant) % properties
		BA = Subject.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		FUN = Subject.getPropNumber() + 2;
		FUN_TAG = 'FUN';
		FUN_CATEGORY = Category.DATA;
		FUN_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function sub = SubjectFUN(varargin)
			%SubjectFUN() creates a subject with functional matrix.
			%
			% SubjectFUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectFUN(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the subject with functional matrix.
			%
			% CLASS = SubjectFUN.GETCLASS() returns the class 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with functional matrix SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectFUN') returns 'SubjectFUN'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectFUN')
			%  are less computationally efficient.
			
			sub_class = 'SubjectFUN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with functional matrix.
			%
			% LIST = SubjectFUN.GETSUBCLASSES() returns all subclasses of 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with functional matrix SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectFUN') returns all subclasses of 'SubjectFUN'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectFUN', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with functional matrix.
			%
			% PROPS = SubjectFUN.GETPROPS() returns the property list of subject with functional matrix
			%  as a row vector.
			%
			% PROPS = SubjectFUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with functional matrix SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectFUN'[, CATEGORY]) returns the property list of 'SubjectFUN'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Subject.getProps() ...
						SubjectFUN.BA ...
						SubjectFUN.FUN ...
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
						SubjectFUN.BA ...
						SubjectFUN.FUN ...
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
			%GETPROPNUMBER returns the property number of subject with functional matrix.
			%
			% N = SubjectFUN.GETPROPNUMBER() returns the property number of subject with functional matrix.
			%
			% N = SubjectFUN.GETPROPNUMBER(CATEGORY) returns the property number of subject with functional matrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with functional matrix SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectFUN') returns the property number of 'SubjectFUN'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectFUN.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectFUN, PROP) checks whether PROP exists for SubjectFUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SubjectFUN, PROP) throws error if PROP does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectFUN.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectFUN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectFUN, TAG) checks whether TAG exists for SubjectFUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SubjectFUN, TAG) throws error if TAG does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectfun_tag_list = cellfun(@(x) SubjectFUN.getPropTag(x), num2cell(SubjectFUN.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectfun_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectFUN.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%  PROPERTY = SUB.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectfun_tag_list = cellfun(@(x) SubjectFUN.getPropTag(x), num2cell(SubjectFUN.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectfun_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%  TAG = SUB.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectFUN.BA
						tag = SubjectFUN.BA_TAG;
					case SubjectFUN.FUN
						tag = SubjectFUN.FUN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_category = SubjectFUN.BA_CATEGORY;
				case SubjectFUN.FUN
					prop_category = SubjectFUN.FUN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_format = SubjectFUN.BA_FORMAT;
				case SubjectFUN.FUN
					prop_format = SubjectFUN.FUN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case SubjectFUN.FUN
					prop_description = 'FUN (data, matrix) is an adjacency matrix.';
				case SubjectFUN.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case SubjectFUN.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case SubjectFUN.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case SubjectFUN.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case SubjectFUN.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case SubjectFUN.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case SubjectFUN.NOTES
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
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_settings = 'BrainAtlas';
				case SubjectFUN.FUN
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.FUN
					prop_default = Format.getFormatDefault(Format.MATRIX, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.ELCLASS
					prop_default = 'SubjectFUN';
				case SubjectFUN.NAME
					prop_default = 'SubjectFUN';
				case SubjectFUN.DESCRIPTION
					prop_default = 'Subject with a functional matrix (e.g. obtained from fMRI).';
				case SubjectFUN.ID
					prop_default = 'SubjectFUN ID';
				case SubjectFUN.LABEL
					prop_default = 'SubjectFUN label';
				case SubjectFUN.NOTES
					prop_default = 'SubjectFUN notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			prop_default = SubjectFUN.conditioning(prop, SubjectFUN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			%  CHECK = SUB.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectFUN:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:SubjectFUN:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: €BRAPH2.STR€:SubjectFUN:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: €BRAPH2.STR€:SubjectFUN:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA % __SubjectFUN.BA__
					check = Format.checkFormat(Format.ITEM, value, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.FUN % __SubjectFUN.FUN__
					check = Format.checkFormat(Format.MATRIX, value, SubjectFUN.getPropSettings(prop));
				otherwise
					if prop <= Subject.getPropNumber()
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectFUN.getPropTag(prop) ' (' SubjectFUN.getFormatTag(SubjectFUN.getPropFormat(prop)) ').'] ...
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
				case SubjectFUN.FUN % __SubjectFUN.FUN__
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
				case SubjectFUN.FUN % __SubjectFUN.FUN__
					pr = PanelPropMatrix('EL', sub, 'PROP', SubjectFUN.FUN, ...
					    'ROWNAME', {'numbered'}, ...
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
			        im = ImporterGroupSubjectFUN_TXT( ...
			            'ID', 'Import Group of SubjectCons from TXT', ...
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
			        warndlg(['Please, select a valid input Group of SubjectCons in TXT format. ' newline() ...
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
			        im = ImporterGroupSubjectFUN_XLS( ...
			            'ID', 'Import Group of SubjectCons from XLS', ...
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
			        warndlg(['Please, select a valid input Group of SubjectCons in XLS format. ' newline() ...
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
			    ex = ExporterGroupSubjectFUN_TXT( ...
			        'ID', 'Export Brain Group of SubjectCons to TXT', ...
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
			    ex = ExporterGroupSubjectFUN_XLS( ...
			        'ID', 'Export Brain Group of SubjectCons to XLS', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');;
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
