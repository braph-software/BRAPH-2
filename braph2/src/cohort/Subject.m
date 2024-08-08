classdef Subject < ConcreteElement
	%Subject is a subject.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Subject provides the methods necessary for all subjects. 
	%  Instances of this element should not be created. 
	%  Use one of its subelements instead.
	%
	% Subject methods (constructor):
	%  Subject - constructor
	%
	% Subject methods:
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
	% Subject methods (display):
	%  tostring - string with information about the subject
	%  disp - displays information about the subject
	%  tree - displays the tree of the subject
	%
	% Subject methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject
	%
	% Subject methods (save/load, Static):
	%  save - saves BRAPH2 subject as b2 file
	%  load - loads a BRAPH2 subject from a b2 file
	%
	% Subject method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject
	%
	% Subject method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject
	%
	% Subject methods (inspection, Static):
	%  getClass - returns the class of the subject
	%  getSubclasses - returns all subclasses of Subject
	%  getProps - returns the property list of the subject
	%  getPropNumber - returns the property number of the subject
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
	% Subject methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Subject methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Subject methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Subject methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Subject; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Subject constants</a>.
	%
	%
	% See also Group.
	
	properties (Constant) % properties
		VOI_DICT = ConcreteElement.getPropNumber() + 1;
		VOI_DICT_TAG = 'VOI_DICT';
		VOI_DICT_CATEGORY = Category.DATA;
		VOI_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function sub = Subject(varargin)
			%Subject() creates a subject.
			%
			% Subject(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Subject(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			sub = sub@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function sub_class = getClass()
			%GETCLASS returns the class of the subject.
			%
			% CLASS = Subject.GETCLASS() returns the class 'Subject'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('Subject') returns 'Subject'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('Subject')
			%  are less computationally efficient.
			
			sub_class = 'Subject';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject.
			%
			% LIST = Subject.GETSUBCLASSES() returns all subclasses of 'Subject'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('Subject') returns all subclasses of 'Subject'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('Subject')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Subject', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject.
			%
			% PROPS = Subject.GETPROPS() returns the property list of subject
			%  as a row vector.
			%
			% PROPS = Subject.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('Subject'[, CATEGORY]) returns the property list of 'Subject'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('Subject')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Subject.VOI_DICT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						Subject.VOI_DICT ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject.
			%
			% N = Subject.GETPROPNUMBER() returns the property number of subject.
			%
			% N = Subject.GETPROPNUMBER(CATEGORY) returns the property number of subject
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('Subject') returns the property number of 'Subject'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('Subject')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Subject.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject/error.
			%
			% CHECK = Subject.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(Subject, PROP) checks whether PROP exists for Subject.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Subject:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSPROP(Subject, PROP) throws error if PROP does NOT exist for Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('Subject')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Subject.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Subject.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject/error.
			%
			% CHECK = Subject.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(Subject, TAG) checks whether TAG exists for Subject.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Subject:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSTAG(Subject, TAG) throws error if TAG does NOT exist for Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('Subject')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subject_tag_list = cellfun(@(x) Subject.getPropTag(x), num2cell(Subject.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subject_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Subject.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Subject, POINTER) returns property number of POINTER of Subject.
			%  PROPERTY = SUB.GETPROPPROP(Subject, POINTER) returns property number of POINTER of Subject.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('Subject')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subject_tag_list = cellfun(@(x) Subject.getPropTag(x), num2cell(Subject.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subject_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Subject, POINTER) returns tag of POINTER of Subject.
			%  TAG = SUB.GETPROPTAG(Subject, POINTER) returns tag of POINTER of Subject.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('Subject')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Subject.VOI_DICT
						tag = Subject.VOI_DICT_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(Subject, POINTER) returns category of POINTER of Subject.
			%  CATEGORY = SUB.GETPROPCATEGORY(Subject, POINTER) returns category of POINTER of Subject.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('Subject')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT
					prop_category = Subject.VOI_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(Subject, POINTER) returns format of POINTER of Subject.
			%  FORMAT = SUB.GETPROPFORMAT(Subject, POINTER) returns format of POINTER of Subject.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('Subject')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT
					prop_format = Subject.VOI_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Subject, POINTER) returns description of POINTER of Subject.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(Subject, POINTER) returns description of POINTER of Subject.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('Subject')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT
					prop_description = 'VOI_DICT (data, idict) contains the variables of interest of the subject.';
				case Subject.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the subject.';
				case Subject.NAME
					prop_description = 'NAME (constant, string) is the name of the subject.';
				case Subject.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the subject.';
				case Subject.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the subject.';
				case Subject.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case Subject.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case Subject.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the subject.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(Subject, POINTER) returns settings of POINTER of Subject.
			%  SETTINGS = SUB.GETPROPSETTINGS(Subject, POINTER) returns settings of POINTER of Subject.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('Subject')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT
					prop_settings = 'VOI';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Subject.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Subject.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(Subject, POINTER) returns the default value of POINTER of Subject.
			%  DEFAULT = SUB.GETPROPDEFAULT(Subject, POINTER) returns the default value of POINTER of Subject.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('Subject')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Subject.getPropSettings(prop));
				case Subject.ELCLASS
					prop_default = 'Subject';
				case Subject.NAME
					prop_default = 'Subject';
				case Subject.DESCRIPTION
					prop_default = 'A Subject provides the methods necessary for all subjects. Instances of this element should not be created. Use one of its subelements instead.';
				case Subject.ID
					prop_default = 'Subject ID';
				case Subject.LABEL
					prop_default = 'Subject label';
				case Subject.NOTES
					prop_default = 'Subject notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Subject.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Subject.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Subject, POINTER) returns the conditioned default value of POINTER of Subject.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(Subject, POINTER) returns the conditioned default value of POINTER of Subject.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('Subject')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			prop_default = Subject.conditioning(prop, Subject.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Subject, PROP, VALUE) checks VALUE format for PROP of Subject.
			%  CHECK = SUB.CHECKPROP(Subject, PROP, VALUE) checks VALUE format for PROP of Subject.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Subject:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: €BRAPH2.STR€:Subject:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Subject, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Subject.
			%   Error id: €BRAPH2.STR€:Subject:€BRAPH2.WRONG_INPUT€
			%  SUB.CHECKPROP(Subject, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Subject.
			%   Error id: €BRAPH2.STR€:Subject:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('Subject')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.VOI_DICT % __Subject.VOI_DICT__
					check = Format.checkFormat(Format.IDICT, value, Subject.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Subject.getPropTag(prop) ' (' Subject.getFormatTag(Subject.getPropFormat(prop)) ').'] ...
					)
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
				case Subject.VOI_DICT % __Subject.VOI_DICT__
					pr = SubjectPP_VOIDict('EL', sub, 'PROP', Subject.VOI_DICT, varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(sub, prop, varargin{:});
					
			end
		end
	end
end
