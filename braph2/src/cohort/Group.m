classdef Group < ConcreteElement
	%Group is a group of subjects.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Group represents a group of subjects whose class is defined in the property SUB_CLASS.
	%  Group provides the methods necessary to handle groups of subjects. 
	%  It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
	%  whose methods can be used to inspect, add or remove subjects.
	%
	% Group methods (constructor):
	%  Group - constructor
	%
	% Group methods:
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
	% Group methods (display):
	%  tostring - string with information about the group of subjects
	%  disp - displays information about the group of subjects
	%  tree - displays the tree of the group of subjects
	%
	% Group methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two group of subjects are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the group of subjects
	%
	% Group methods (save/load, Static):
	%  save - saves BRAPH2 group of subjects as b2 file
	%  load - loads a BRAPH2 group of subjects from a b2 file
	%
	% Group method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the group of subjects
	%
	% Group method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the group of subjects
	%
	% Group methods (inspection, Static):
	%  getClass - returns the class of the group of subjects
	%  getSubclasses - returns all subclasses of Group
	%  getProps - returns the property list of the group of subjects
	%  getPropNumber - returns the property number of the group of subjects
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
	% Group methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Group methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Group methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Group methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Group; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Group constants</a>.
	%
	%
	% See also Subject, IndexedDictionary.
	
	properties (Constant) % properties
		SUB_CLASS = ConcreteElement.getPropNumber() + 1;
		SUB_CLASS_TAG = 'SUB_CLASS';
		SUB_CLASS_CATEGORY = Category.PARAMETER;
		SUB_CLASS_FORMAT = Format.CLASS;
		
		SUB_DICT = ConcreteElement.getPropNumber() + 2;
		SUB_DICT_TAG = 'SUB_DICT';
		SUB_DICT_CATEGORY = Category.DATA;
		SUB_DICT_FORMAT = Format.IDICT;
		
		VOIS = ConcreteElement.getPropNumber() + 3;
		VOIS_TAG = 'VOIS';
		VOIS_CATEGORY = Category.RESULT;
		VOIS_FORMAT = Format.CELL;
		
		COVARIATES = ConcreteElement.getPropNumber() + 4;
		COVARIATES_TAG = 'COVARIATES';
		COVARIATES_CATEGORY = Category.RESULT;
		COVARIATES_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function gr = Group(varargin)
			%Group() creates a group of subjects.
			%
			% Group(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Group(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			gr = gr@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function gr_class = getClass()
			%GETCLASS returns the class of the group of subjects.
			%
			% CLASS = Group.GETCLASS() returns the class 'Group'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GR.GETCLASS() returns the class of the group of subjects GR.
			%  CLASS = Element.GETCLASS(GR) returns the class of 'GR'.
			%  CLASS = Element.GETCLASS('Group') returns 'Group'.
			%
			% Note that the Element.GETCLASS(GR) and Element.GETCLASS('Group')
			%  are less computationally efficient.
			
			gr_class = 'Group';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the group of subjects.
			%
			% LIST = Group.GETSUBCLASSES() returns all subclasses of 'Group'.
			%
			% Alternative forms to call this method are:
			%  LIST = GR.GETSUBCLASSES() returns all subclasses of the group of subjects GR.
			%  LIST = Element.GETSUBCLASSES(GR) returns all subclasses of 'GR'.
			%  LIST = Element.GETSUBCLASSES('Group') returns all subclasses of 'Group'.
			%
			% Note that the Element.GETSUBCLASSES(GR) and Element.GETSUBCLASSES('Group')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Group', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group of subjects.
			%
			% PROPS = Group.GETPROPS() returns the property list of group of subjects
			%  as a row vector.
			%
			% PROPS = Group.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GR.GETPROPS([CATEGORY]) returns the property list of the group of subjects GR.
			%  PROPS = Element.GETPROPS(GR[, CATEGORY]) returns the property list of 'GR'.
			%  PROPS = Element.GETPROPS('Group'[, CATEGORY]) returns the property list of 'Group'.
			%
			% Note that the Element.GETPROPS(GR) and Element.GETPROPS('Group')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Group.SUB_CLASS ...
						Group.SUB_DICT ...
						Group.VOIS ...
						Group.COVARIATES ...
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
						Group.SUB_CLASS ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						Group.SUB_DICT ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						Group.VOIS ...
						Group.COVARIATES ...
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
			%GETPROPNUMBER returns the property number of group of subjects.
			%
			% N = Group.GETPROPNUMBER() returns the property number of group of subjects.
			%
			% N = Group.GETPROPNUMBER(CATEGORY) returns the property number of group of subjects
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GR.GETPROPNUMBER([CATEGORY]) returns the property number of the group of subjects GR.
			%  N = Element.GETPROPNUMBER(GR) returns the property number of 'GR'.
			%  N = Element.GETPROPNUMBER('Group') returns the property number of 'Group'.
			%
			% Note that the Element.GETPROPNUMBER(GR) and Element.GETPROPNUMBER('Group')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Group.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in group of subjects/error.
			%
			% CHECK = Group.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSPROP(PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(GR, PROP) checks whether PROP exists for GR.
			%  CHECK = Element.EXISTSPROP(Group, PROP) checks whether PROP exists for Group.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Group:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSPROP(PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSPROP(GR, PROP) throws error if PROP does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSPROP(Group, PROP) throws error if PROP does NOT exist for Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GR) and Element.EXISTSPROP('Group')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Group.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Group.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group of subjects/error.
			%
			% CHECK = Group.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GR.EXISTSTAG(TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(GR, TAG) checks whether TAG exists for GR.
			%  CHECK = Element.EXISTSTAG(Group, TAG) checks whether TAG exists for Group.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Group:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GR.EXISTSTAG(TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSTAG(GR, TAG) throws error if TAG does NOT exist for GR.
			%   Error id: [BRAPH2:Group:WrongInput]
			%  Element.EXISTSTAG(Group, TAG) throws error if TAG does NOT exist for Group.
			%   Error id: [BRAPH2:Group:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GR) and Element.EXISTSTAG('Group')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			group_tag_list = cellfun(@(x) Group.getPropTag(x), num2cell(Group.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, group_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Group.'] ...
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
			%  PROPERTY = GR.GETPROPPROP(POINTER) returns property number of POINTER of GR.
			%  PROPERTY = Element.GETPROPPROP(Group, POINTER) returns property number of POINTER of Group.
			%  PROPERTY = GR.GETPROPPROP(Group, POINTER) returns property number of POINTER of Group.
			%
			% Note that the Element.GETPROPPROP(GR) and Element.GETPROPPROP('Group')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				group_tag_list = cellfun(@(x) Group.getPropTag(x), num2cell(Group.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, group_tag_list)); % tag = pointer
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
			%  TAG = GR.GETPROPTAG(POINTER) returns tag of POINTER of GR.
			%  TAG = Element.GETPROPTAG(Group, POINTER) returns tag of POINTER of Group.
			%  TAG = GR.GETPROPTAG(Group, POINTER) returns tag of POINTER of Group.
			%
			% Note that the Element.GETPROPTAG(GR) and Element.GETPROPTAG('Group')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Group.SUB_CLASS
						tag = Group.SUB_CLASS_TAG;
					case Group.SUB_DICT
						tag = Group.SUB_DICT_TAG;
					case Group.VOIS
						tag = Group.VOIS_TAG;
					case Group.COVARIATES
						tag = Group.COVARIATES_TAG;
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
			%  CATEGORY = GR.GETPROPCATEGORY(POINTER) returns category of POINTER of GR.
			%  CATEGORY = Element.GETPROPCATEGORY(Group, POINTER) returns category of POINTER of Group.
			%  CATEGORY = GR.GETPROPCATEGORY(Group, POINTER) returns category of POINTER of Group.
			%
			% Note that the Element.GETPROPCATEGORY(GR) and Element.GETPROPCATEGORY('Group')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS
					prop_category = Group.SUB_CLASS_CATEGORY;
				case Group.SUB_DICT
					prop_category = Group.SUB_DICT_CATEGORY;
				case Group.VOIS
					prop_category = Group.VOIS_CATEGORY;
				case Group.COVARIATES
					prop_category = Group.COVARIATES_CATEGORY;
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
			%  FORMAT = GR.GETPROPFORMAT(POINTER) returns format of POINTER of GR.
			%  FORMAT = Element.GETPROPFORMAT(Group, POINTER) returns format of POINTER of Group.
			%  FORMAT = GR.GETPROPFORMAT(Group, POINTER) returns format of POINTER of Group.
			%
			% Note that the Element.GETPROPFORMAT(GR) and Element.GETPROPFORMAT('Group')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS
					prop_format = Group.SUB_CLASS_FORMAT;
				case Group.SUB_DICT
					prop_format = Group.SUB_DICT_FORMAT;
				case Group.VOIS
					prop_format = Group.VOIS_FORMAT;
				case Group.COVARIATES
					prop_format = Group.COVARIATES_FORMAT;
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
			%  DESCRIPTION = GR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Group, POINTER) returns description of POINTER of Group.
			%  DESCRIPTION = GR.GETPROPDESCRIPTION(Group, POINTER) returns description of POINTER of Group.
			%
			% Note that the Element.GETPROPDESCRIPTION(GR) and Element.GETPROPDESCRIPTION('Group')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS
					prop_description = 'SUB_CLASS (parameter, class) is the class of the subjects of the group.';
				case Group.SUB_DICT
					prop_description = 'SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.';
				case Group.VOIS
					prop_description = 'VOIS (result, cell) contains the variables of interest, including {kind, categories, values}.';
				case Group.COVARIATES
					prop_description = 'COVARIATES (result, matrix) contains the values of the covariates with the categorical ones one-hot encoded.';
				case Group.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the group of subjects.';
				case Group.NAME
					prop_description = 'NAME (constant, string) is the name of the group of subjects.';
				case Group.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the group of subjects.';
				case Group.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the group of subjects.';
				case Group.ID
					prop_description = 'ID (data, string) is a few-letter code for the group of subjects.';
				case Group.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group of subjects.';
				case Group.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group of subjects.';
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
			%  SETTINGS = GR.GETPROPSETTINGS(POINTER) returns settings of POINTER of GR.
			%  SETTINGS = Element.GETPROPSETTINGS(Group, POINTER) returns settings of POINTER of Group.
			%  SETTINGS = GR.GETPROPSETTINGS(Group, POINTER) returns settings of POINTER of Group.
			%
			% Note that the Element.GETPROPSETTINGS(GR) and Element.GETPROPSETTINGS('Group')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS
					prop_settings = 'Subject';
				case Group.SUB_DICT
					prop_settings = 'Subject';
				case Group.VOIS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case Group.COVARIATES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Group.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Group.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULT(Group, POINTER) returns the default value of POINTER of Group.
			%  DEFAULT = GR.GETPROPDEFAULT(Group, POINTER) returns the default value of POINTER of Group.
			%
			% Note that the Element.GETPROPDEFAULT(GR) and Element.GETPROPDEFAULT('Group')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS
					prop_default = Format.getFormatDefault(Format.CLASS, Group.getPropSettings(prop));
				case Group.SUB_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Group.getPropSettings(prop));
				case Group.VOIS
					prop_default = Format.getFormatDefault(Format.CELL, Group.getPropSettings(prop));
				case Group.COVARIATES
					prop_default = Format.getFormatDefault(Format.MATRIX, Group.getPropSettings(prop));
				case Group.ELCLASS
					prop_default = 'Group';
				case Group.NAME
					prop_default = 'Group';
				case Group.DESCRIPTION
					prop_default = 'A Group represents a group of subjects whose class is defined in the property SUB_CLASS. Group provides the methods necessary to handle groups of subjects. It manages the subjects as an indexed dictionary of subjects SUB_DICT, whose methods can be used to inspect, add or remove subjects.';
				case Group.ID
					prop_default = 'Group ID';
				case Group.LABEL
					prop_default = 'Group label';
				case Group.NOTES
					prop_default = 'Group notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Group.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Group.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Group, POINTER) returns the conditioned default value of POINTER of Group.
			%  DEFAULT = GR.GETPROPDEFAULTCONDITIONED(Group, POINTER) returns the conditioned default value of POINTER of Group.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GR) and Element.GETPROPDEFAULTCONDITIONED('Group')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Group.getPropProp(pointer);
			
			prop_default = Group.conditioning(prop, Group.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GR.
			%  CHECK = Element.CHECKPROP(Group, PROP, VALUE) checks VALUE format for PROP of Group.
			%  CHECK = GR.CHECKPROP(Group, PROP, VALUE) checks VALUE format for PROP of Group.
			% 
			% GR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Group:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GR.
			%   Error id: €BRAPH2.STR€:Group:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Group, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Group.
			%   Error id: €BRAPH2.STR€:Group:€BRAPH2.WRONG_INPUT€
			%  GR.CHECKPROP(Group, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Group.
			%   Error id: €BRAPH2.STR€:Group:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GR) and Element.CHECKPROP('Group')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Group.getPropProp(pointer);
			
			switch prop
				case Group.SUB_CLASS % __Group.SUB_CLASS__
					check = Format.checkFormat(Format.CLASS, value, Group.getPropSettings(prop));
				case Group.SUB_DICT % __Group.SUB_DICT__
					check = Format.checkFormat(Format.IDICT, value, Group.getPropSettings(prop));
				case Group.VOIS % __Group.VOIS__
					check = Format.checkFormat(Format.CELL, value, Group.getPropSettings(prop));
				case Group.COVARIATES % __Group.COVARIATES__
					check = Format.checkFormat(Format.MATRIX, value, Group.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Group.getPropTag(prop) ' (' Group.getFormatTag(Group.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gr, prop, varargin)
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
				case Group.VOIS % __Group.VOIS__
					rng_settings_ = rng(); rng(gr.getPropSeed(Group.VOIS), 'twister')
					
					sub_dict = gr.get('SUB_DICT');
					
					if sub_dict.get('LENGTH') ~= 0
					    sub = sub_dict.get('IT', 1);
					    voi_dict = sub.get('VOI_DICT');
					    
					    value = cell(voi_dict.get('LENGTH'), 3);
					    for v = 1:1:voi_dict.get('LENGTH')
					        voi = voi_dict.get('IT', v);
					        
					        value{v, 1} = voi.getClass();
					        
					        if isa(voi, 'VOICategoric')
					            value{v, 2} = voi.get('CATEGORIES');
					        end
					        
					        value{v, 3} = voi.get('V');
					    end
					    
					    for s = 2:1:sub_dict.get('LENGTH')
					        sub = sub_dict.get('IT', s);
					        voi_dict = sub.get('VOI_DICT');
					        
					        for v = 1:1:voi_dict.get('LENGTH')
					            voi = voi_dict.get('IT', v);
					            
					            % % % Add error/warning if voi kind or categories are different from first subject
					            
					            value{v, 3} = [value{v, 3}; voi.get('V')];
					        end
					    end
					else
					    value = {};
					end
					
					rng(rng_settings_)
					
				case Group.COVARIATES % __Group.COVARIATES__
					rng_settings_ = rng(); rng(gr.getPropSeed(Group.COVARIATES), 'twister')
					
					vois = gr.get('VOIS');
					
					value = zeros(gr.get('SUB_DICT').get('LENGTH'), 0);
					for v = 1:1:size(vois, 1)
					    if strcmp(vois{v, 1}, 'VOICategoric')
					        one_hot_encoding = dummyvar(vois{v, 3});
					        value = [value, one_hot_encoding(:, 2:end)];
					    else % 'VOINumeric'
					        value = [value, vois{v, 3}];
					    end
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(gr, prop, varargin{:});
					else
						value = calculateValue@Element(gr, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(gr, prop, varargin)
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
				case Group.SUB_DICT % __Group.SUB_DICT__
					[order, title] = load_layout(gr.get(Group.SUB_DICT).get(IndexedDictionary.IT_CLASS));
					cols(1) = PanelPropIDictTable.SELECTOR;
					columnname = {''};
					for i = 1:1:length(order)
					    if isfinite(order(i))
					        cols(order(i) + 1) = i;
					        columnname{order(i) + 1} = title{i};
					    end
					end
					pr = PanelPropIDictTable('EL', gr, 'PROP', Group.SUB_DICT, ... 
					    'ROWNAME', 'numbered', ...
					    'COLS', cols, ...
					    'COLUMNNAME', columnname, ...
					    'MENU_OPEN_ITEMS', true, ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(gr, prop, varargin{:});
					
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
			
			eval([el.get('SUB_CLASS') '.getGUIMenuImport(el, menu_import, pe)']);
			im_sub_menus = get(menu_import, 'Children');
			delete(im_sub_menus(end)); % delete one sub menu to import JSON
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			eval([el.get('SUB_CLASS') '.getGUIMenuExport(el, menu_export, pe)']);
			ex_sub_menus = get(menu_export, 'Children');
			delete(ex_sub_menus(end)); % delete one sub menu to export JSON
			
		end
	end
end
