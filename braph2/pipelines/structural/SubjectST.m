classdef SubjectST < Subject
	%SubjectST is a subject with structural data (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with structural data (e.g. cortical thickness obtaibed from strcutural MRI) for each brain region.
	%
	% SubjectST methods (constructor):
	%  SubjectST - constructor
	%
	% SubjectST methods:
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
	% SubjectST methods (display):
	%  tostring - string with information about the subject with structural data
	%  disp - displays information about the subject with structural data
	%  tree - displays the tree of the subject with structural data
	%
	% SubjectST methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with structural data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with structural data
	%
	% SubjectST methods (save/load, Static):
	%  save - saves BRAPH2 subject with structural data as b2 file
	%  load - loads a BRAPH2 subject with structural data from a b2 file
	%
	% SubjectST method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with structural data
	%
	% SubjectST method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with structural data
	%
	% SubjectST methods (inspection, Static):
	%  getClass - returns the class of the subject with structural data
	%  getSubclasses - returns all subclasses of SubjectST
	%  getProps - returns the property list of the subject with structural data
	%  getPropNumber - returns the property number of the subject with structural data
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
	% SubjectST methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectST methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectST methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectST methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectST; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectST constants</a>.
	%
	%
	% See also ImporterGroupSubjectST_TXT, ExporterGroupSubjectST_TXT, ImporterGroupSubjectST_XLS, ExporterGroupSubjectST_XLS.
	
	properties (Constant) % properties
		BA = Subject.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		ST = Subject.getPropNumber() + 2;
		ST_TAG = 'ST';
		ST_CATEGORY = Category.DATA;
		ST_FORMAT = Format.CVECTOR;
	end
	methods % constructor
		function sub = SubjectST(varargin)
			%SubjectST() creates a subject with structural data.
			%
			% SubjectST(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectST(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the subject with structural data.
			%
			% CLASS = SubjectST.GETCLASS() returns the class 'SubjectST'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with structural data SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectST') returns 'SubjectST'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectST')
			%  are less computationally efficient.
			
			sub_class = 'SubjectST';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with structural data.
			%
			% LIST = SubjectST.GETSUBCLASSES() returns all subclasses of 'SubjectST'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with structural data SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectST') returns all subclasses of 'SubjectST'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectST')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectST', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with structural data.
			%
			% PROPS = SubjectST.GETPROPS() returns the property list of subject with structural data
			%  as a row vector.
			%
			% PROPS = SubjectST.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with structural data SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectST'[, CATEGORY]) returns the property list of 'SubjectST'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Subject.getProps() ...
						SubjectST.BA ...
						SubjectST.ST ...
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
						SubjectST.BA ...
						SubjectST.ST ...
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
			%GETPROPNUMBER returns the property number of subject with structural data.
			%
			% N = SubjectST.GETPROPNUMBER() returns the property number of subject with structural data.
			%
			% N = SubjectST.GETPROPNUMBER(CATEGORY) returns the property number of subject with structural data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with structural data SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectST') returns the property number of 'SubjectST'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectST')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectST.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with structural data/error.
			%
			% CHECK = SubjectST.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectST, PROP) checks whether PROP exists for SubjectST.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectST:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%  Element.EXISTSPROP(SubjectST, PROP) throws error if PROP does NOT exist for SubjectST.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectST')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectST.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectST.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with structural data/error.
			%
			% CHECK = SubjectST.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectST, TAG) checks whether TAG exists for SubjectST.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectST:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%  Element.EXISTSTAG(SubjectST, TAG) throws error if TAG does NOT exist for SubjectST.
			%   Error id: [BRAPH2:SubjectST:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectST')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectst_tag_list = cellfun(@(x) SubjectST.getPropTag(x), num2cell(SubjectST.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectst_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectST.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SubjectST, POINTER) returns property number of POINTER of SubjectST.
			%  PROPERTY = SUB.GETPROPPROP(SubjectST, POINTER) returns property number of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectst_tag_list = cellfun(@(x) SubjectST.getPropTag(x), num2cell(SubjectST.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectst_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SubjectST, POINTER) returns tag of POINTER of SubjectST.
			%  TAG = SUB.GETPROPTAG(SubjectST, POINTER) returns tag of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectST.BA
						tag = SubjectST.BA_TAG;
					case SubjectST.ST
						tag = SubjectST.ST_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectST, POINTER) returns category of POINTER of SubjectST.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectST, POINTER) returns category of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectST')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA
					prop_category = SubjectST.BA_CATEGORY;
				case SubjectST.ST
					prop_category = SubjectST.ST_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SubjectST, POINTER) returns format of POINTER of SubjectST.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectST, POINTER) returns format of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectST')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA
					prop_format = SubjectST.BA_FORMAT;
				case SubjectST.ST
					prop_format = SubjectST.ST_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectST, POINTER) returns description of POINTER of SubjectST.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectST, POINTER) returns description of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case SubjectST.ST
					prop_description = 'ST (data, cvector) is a column vector with data for each brain region.';
				case SubjectST.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case SubjectST.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case SubjectST.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case SubjectST.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case SubjectST.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case SubjectST.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case SubjectST.NOTES
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
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectST, POINTER) returns settings of POINTER of SubjectST.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectST, POINTER) returns settings of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA
					prop_settings = 'BrainAtlas';
				case SubjectST.ST
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectST.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectST.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectST, POINTER) returns the default value of POINTER of SubjectST.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectST, POINTER) returns the default value of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectST')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectST.getPropSettings(prop));
				case SubjectST.ST
					prop_default = Format.getFormatDefault(Format.CVECTOR, SubjectST.getPropSettings(prop));
				case SubjectST.ELCLASS
					prop_default = 'SubjectST';
				case SubjectST.NAME
					prop_default = 'SubjectST';
				case SubjectST.DESCRIPTION
					prop_default = 'SubjectST with structural data (e.g. cortical thickness obtaibed from strcutural MRI) for each brain region.';
				case SubjectST.ID
					prop_default = 'SubjectST ID';
				case SubjectST.LABEL
					prop_default = 'SubjectST label';
				case SubjectST.NOTES
					prop_default = 'SubjectST notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectST.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectST.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectST, POINTER) returns the conditioned default value of POINTER of SubjectST.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectST, POINTER) returns the conditioned default value of POINTER of SubjectST.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectST')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectST.getPropProp(pointer);
			
			prop_default = SubjectST.conditioning(prop, SubjectST.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SubjectST, PROP, VALUE) checks VALUE format for PROP of SubjectST.
			%  CHECK = SUB.CHECKPROP(SubjectST, PROP, VALUE) checks VALUE format for PROP of SubjectST.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectST:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:SubjectST:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectST, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectST.
			%   Error id: €BRAPH2.STR€:SubjectST:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(SubjectST, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectST.
			%   Error id: €BRAPH2.STR€:SubjectST:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectST')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectST.getPropProp(pointer);
			
			switch prop
				case SubjectST.BA % __SubjectST.BA__
					check = Format.checkFormat(Format.ITEM, value, SubjectST.getPropSettings(prop));
				case SubjectST.ST % __SubjectST.ST__
					check = Format.checkFormat(Format.CVECTOR, value, SubjectST.getPropSettings(prop));
				otherwise
					if prop <= Subject.getPropNumber()
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectST:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectST.getPropTag(prop) ' (' SubjectST.getFormatTag(SubjectST.getPropFormat(prop)) ').'] ...
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
				case SubjectST.ST % __SubjectST.ST__
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					check = (iscolumn(value) && isequal(size(value), [br_number, 1])) || (isempty(value) && br_number == 0); % Format.checkFormat(Format.CVECTOR, value) already checked
					if check
					    msg = 'All ok!';
					else   
					    msg = ['ST must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
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
				case SubjectST.ST % __SubjectST.ST__
					pr = PanelPropMatrix('EL', sub, 'PROP', SubjectST.ST, ...
					    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    'COLUMNNAME', {}, ...
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
			        im = ImporterGroupSubjectST_TXT( ...
			            'ID', 'Import Group of SubjectSts from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectSts in TXT format. ' newline() ...
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
			        im = ImporterGroupSubjectST_XLS( ...
			            'ID', 'Import Group of SubjectSts from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectSTs in XLS format. ' newline() ...
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
			    ex = ExporterGroupSubjectST_TXT( ...
			        'ID', 'Export Brain Group of SubjectSTs to TXT', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
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
			    ex = ExporterGroupSubjectST_XLS( ...
			        'ID', 'Export Brain Group of SubjectSTs to XLS', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
