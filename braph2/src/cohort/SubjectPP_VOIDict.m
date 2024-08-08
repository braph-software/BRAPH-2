classdef SubjectPP_VOIDict < PanelProp
	%SubjectPP_VOIDict plots the panel for a VOI dictionary.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using 
	%  numeric editfields and drop-down lists.
	% It is intended to be used with the property VOI_DICT of Subject.
	%
	% SubjectPP_VOIDict methods (constructor):
	%  SubjectPP_VOIDict - constructor
	%
	% SubjectPP_VOIDict methods:
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
	% SubjectPP_VOIDict methods (display):
	%  tostring - string with information about the VOI prop panel
	%  disp - displays information about the VOI prop panel
	%  tree - displays the tree of the VOI prop panel
	%
	% SubjectPP_VOIDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two VOI prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the VOI prop panel
	%
	% SubjectPP_VOIDict methods (save/load, Static):
	%  save - saves BRAPH2 VOI prop panel as b2 file
	%  load - loads a BRAPH2 VOI prop panel from a b2 file
	%
	% SubjectPP_VOIDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the VOI prop panel
	%
	% SubjectPP_VOIDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the VOI prop panel
	%
	% SubjectPP_VOIDict methods (inspection, Static):
	%  getClass - returns the class of the VOI prop panel
	%  getSubclasses - returns all subclasses of SubjectPP_VOIDict
	%  getProps - returns the property list of the VOI prop panel
	%  getPropNumber - returns the property number of the VOI prop panel
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
	% SubjectPP_VOIDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectPP_VOIDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectPP_VOIDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectPP_VOIDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectPP_VOIDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectPP_VOIDict constants</a>.
	%
	%
	% See also Subject, uieditfield, uidropdown.
	
	properties (Constant) % properties
		HEIGHT_MIN = PanelProp.getPropNumber() + 1;
		HEIGHT_MIN_TAG = 'HEIGHT_MIN';
		HEIGHT_MIN_CATEGORY = Category.GUI;
		HEIGHT_MIN_FORMAT = Format.SCALAR;
		
		HEIGHT_VOI_EDITFIELD = PanelProp.getPropNumber() + 2;
		HEIGHT_VOI_EDITFIELD_TAG = 'HEIGHT_VOI_EDITFIELD';
		HEIGHT_VOI_EDITFIELD_CATEGORY = Category.GUI;
		HEIGHT_VOI_EDITFIELD_FORMAT = Format.SCALAR;
		
		HEIGHT_VOI_DROPDOWN = PanelProp.getPropNumber() + 3;
		HEIGHT_VOI_DROPDOWN_TAG = 'HEIGHT_VOI_DROPDOWN';
		HEIGHT_VOI_DROPDOWN_CATEGORY = Category.GUI;
		HEIGHT_VOI_DROPDOWN_FORMAT = Format.SCALAR;
		
		ENABLE = PanelProp.getPropNumber() + 4;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		HANDLES_VOI = PanelProp.getPropNumber() + 5;
		HANDLES_VOI_TAG = 'HANDLES_VOI';
		HANDLES_VOI_CATEGORY = Category.EVANESCENT;
		HANDLES_VOI_FORMAT = Format.HANDLELIST;
		
		LABELS_VOI = PanelProp.getPropNumber() + 6;
		LABELS_VOI_TAG = 'LABELS_VOI';
		LABELS_VOI_CATEGORY = Category.EVANESCENT;
		LABELS_VOI_FORMAT = Format.HANDLELIST;
	end
	methods % constructor
		function pr = SubjectPP_VOIDict(varargin)
			%SubjectPP_VOIDict() creates a VOI prop panel.
			%
			% SubjectPP_VOIDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectPP_VOIDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the VOI prop panel.
			%
			% CLASS = SubjectPP_VOIDict.GETCLASS() returns the class 'SubjectPP_VOIDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the VOI prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SubjectPP_VOIDict') returns 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			
			pr_class = 'SubjectPP_VOIDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the VOI prop panel.
			%
			% LIST = SubjectPP_VOIDict.GETSUBCLASSES() returns all subclasses of 'SubjectPP_VOIDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the VOI prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SubjectPP_VOIDict') returns all subclasses of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SubjectPP_VOIDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of VOI prop panel.
			%
			% PROPS = SubjectPP_VOIDict.GETPROPS() returns the property list of VOI prop panel
			%  as a row vector.
			%
			% PROPS = SubjectPP_VOIDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the VOI prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SubjectPP_VOIDict'[, CATEGORY]) returns the property list of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						SubjectPP_VOIDict.HEIGHT_MIN ...
						SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD ...
						SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN ...
						SubjectPP_VOIDict.ENABLE ...
						SubjectPP_VOIDict.HANDLES_VOI ...
						SubjectPP_VOIDict.LABELS_VOI ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						SubjectPP_VOIDict.HANDLES_VOI ...
						SubjectPP_VOIDict.LABELS_VOI ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						SubjectPP_VOIDict.HEIGHT_MIN ...
						SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD ...
						SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN ...
						SubjectPP_VOIDict.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of VOI prop panel.
			%
			% N = SubjectPP_VOIDict.GETPROPNUMBER() returns the property number of VOI prop panel.
			%
			% N = SubjectPP_VOIDict.GETPROPNUMBER(CATEGORY) returns the property number of VOI prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the VOI prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SubjectPP_VOIDict') returns the property number of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SubjectPP_VOIDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in VOI prop panel/error.
			%
			% CHECK = SubjectPP_VOIDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SubjectPP_VOIDict, PROP) checks whether PROP exists for SubjectPP_VOIDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSPROP(SubjectPP_VOIDict, PROP) throws error if PROP does NOT exist for SubjectPP_VOIDict.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SubjectPP_VOIDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectPP_VOIDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in VOI prop panel/error.
			%
			% CHECK = SubjectPP_VOIDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SubjectPP_VOIDict, TAG) checks whether TAG exists for SubjectPP_VOIDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSTAG(SubjectPP_VOIDict, TAG) throws error if TAG does NOT exist for SubjectPP_VOIDict.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			subjectpp_voidict_tag_list = cellfun(@(x) SubjectPP_VOIDict.getPropTag(x), num2cell(SubjectPP_VOIDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, subjectpp_voidict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SubjectPP_VOIDict.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(SubjectPP_VOIDict, POINTER) returns property number of POINTER of SubjectPP_VOIDict.
			%  PROPERTY = PR.GETPROPPROP(SubjectPP_VOIDict, POINTER) returns property number of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				subjectpp_voidict_tag_list = cellfun(@(x) SubjectPP_VOIDict.getPropTag(x), num2cell(SubjectPP_VOIDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, subjectpp_voidict_tag_list)); % tag = pointer
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(SubjectPP_VOIDict, POINTER) returns tag of POINTER of SubjectPP_VOIDict.
			%  TAG = PR.GETPROPTAG(SubjectPP_VOIDict, POINTER) returns tag of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SubjectPP_VOIDict.HEIGHT_MIN
						tag = SubjectPP_VOIDict.HEIGHT_MIN_TAG;
					case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
						tag = SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD_TAG;
					case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
						tag = SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN_TAG;
					case SubjectPP_VOIDict.ENABLE
						tag = SubjectPP_VOIDict.ENABLE_TAG;
					case SubjectPP_VOIDict.HANDLES_VOI
						tag = SubjectPP_VOIDict.HANDLES_VOI_TAG;
					case SubjectPP_VOIDict.LABELS_VOI
						tag = SubjectPP_VOIDict.LABELS_VOI_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectPP_VOIDict, POINTER) returns category of POINTER of SubjectPP_VOIDict.
			%  CATEGORY = PR.GETPROPCATEGORY(SubjectPP_VOIDict, POINTER) returns category of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN
					prop_category = SubjectPP_VOIDict.HEIGHT_MIN_CATEGORY;
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_category = SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD_CATEGORY;
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_category = SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN_CATEGORY;
				case SubjectPP_VOIDict.ENABLE
					prop_category = SubjectPP_VOIDict.ENABLE_CATEGORY;
				case SubjectPP_VOIDict.HANDLES_VOI
					prop_category = SubjectPP_VOIDict.HANDLES_VOI_CATEGORY;
				case SubjectPP_VOIDict.LABELS_VOI
					prop_category = SubjectPP_VOIDict.LABELS_VOI_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(SubjectPP_VOIDict, POINTER) returns format of POINTER of SubjectPP_VOIDict.
			%  FORMAT = PR.GETPROPFORMAT(SubjectPP_VOIDict, POINTER) returns format of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN
					prop_format = SubjectPP_VOIDict.HEIGHT_MIN_FORMAT;
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_format = SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD_FORMAT;
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_format = SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN_FORMAT;
				case SubjectPP_VOIDict.ENABLE
					prop_format = SubjectPP_VOIDict.ENABLE_FORMAT;
				case SubjectPP_VOIDict.HANDLES_VOI
					prop_format = SubjectPP_VOIDict.HANDLES_VOI_FORMAT;
				case SubjectPP_VOIDict.LABELS_VOI
					prop_format = SubjectPP_VOIDict.LABELS_VOI_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectPP_VOIDict, POINTER) returns description of POINTER of SubjectPP_VOIDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SubjectPP_VOIDict, POINTER) returns description of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN
					prop_description = 'HEIGHT_MIN (gui, scalar) is the default (minumum) height.';
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_description = 'HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.';
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_description = 'HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.';
				case SubjectPP_VOIDict.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.';
				case SubjectPP_VOIDict.HANDLES_VOI
					prop_description = 'HANDLES_VOI (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.';
				case SubjectPP_VOIDict.LABELS_VOI
					prop_description = 'LABELS_VOI (evanescent, handlelist) is the list of VOI labels.';
				case SubjectPP_VOIDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the VOI prop panel.';
				case SubjectPP_VOIDict.NAME
					prop_description = 'NAME (constant, string) is the name of the VOI prop panel.';
				case SubjectPP_VOIDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the VOI prop panel.';
				case SubjectPP_VOIDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the VOI prop panel.';
				case SubjectPP_VOIDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the VOI prop panel.';
				case SubjectPP_VOIDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the VOI prop panel.';
				case SubjectPP_VOIDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the VOI prop panel.';
				case SubjectPP_VOIDict.EL
					prop_description = 'EL (data, item) is the element.';
				case SubjectPP_VOIDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SubjectPP_VOIDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SubjectPP_VOIDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case SubjectPP_VOIDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SubjectPP_VOIDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectPP_VOIDict, POINTER) returns settings of POINTER of SubjectPP_VOIDict.
			%  SETTINGS = PR.GETPROPSETTINGS(SubjectPP_VOIDict, POINTER) returns settings of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SubjectPP_VOIDict.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SubjectPP_VOIDict.HANDLES_VOI
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case SubjectPP_VOIDict.LABELS_VOI
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case SubjectPP_VOIDict.TEMPLATE
					prop_settings = 'SubjectPP_VOIDict';
				case SubjectPP_VOIDict.EL
					prop_settings = 'Subject';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectPP_VOIDict, POINTER) returns the default value of POINTER of SubjectPP_VOIDict.
			%  DEFAULT = PR.GETPROPDEFAULT(SubjectPP_VOIDict, POINTER) returns the default value of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN
					prop_default = s(2);
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_default = s(2);
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_default = s(2);
				case SubjectPP_VOIDict.ENABLE
					prop_default = true;
				case SubjectPP_VOIDict.HANDLES_VOI
					prop_default = Format.getFormatDefault(Format.HANDLELIST, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.LABELS_VOI
					prop_default = Format.getFormatDefault(Format.HANDLELIST, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.ELCLASS
					prop_default = 'SubjectPP_VOIDict';
				case SubjectPP_VOIDict.NAME
					prop_default = 'VOI Prop Panel';
				case SubjectPP_VOIDict.DESCRIPTION
					prop_default = 'A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using numeric editfields and drop-down lists. It is intended to be used with the property VOI_DICT of Subject.';
				case SubjectPP_VOIDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.ID
					prop_default = 'SubjectPP_VOIDict ID';
				case SubjectPP_VOIDict.LABEL
					prop_default = 'SubjectPP_VOIDict label';
				case SubjectPP_VOIDict.NOTES
					prop_default = 'SubjectPP_VOIDict notes';
				case SubjectPP_VOIDict.EL
					prop_default = Format.getFormatDefault(Format.ITEM, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.PROP
					prop_default = Subject.VOI_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectPP_VOIDict, POINTER) returns the conditioned default value of POINTER of SubjectPP_VOIDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SubjectPP_VOIDict, POINTER) returns the conditioned default value of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			prop_default = SubjectPP_VOIDict.conditioning(prop, SubjectPP_VOIDict.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) checks VALUE format for PROP of SubjectPP_VOIDict.
			%  CHECK = PR.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) checks VALUE format for PROP of SubjectPP_VOIDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SubjectPP_VOIDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SubjectPP_VOIDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectPP_VOIDict.
			%   Error id: €BRAPH2.STR€:SubjectPP_VOIDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectPP_VOIDict.
			%   Error id: €BRAPH2.STR€:SubjectPP_VOIDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case SubjectPP_VOIDict.HEIGHT_MIN % __SubjectPP_VOIDict.HEIGHT_MIN__
					check = Format.checkFormat(Format.SCALAR, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD % __SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD__
					check = Format.checkFormat(Format.SCALAR, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN % __SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN__
					check = Format.checkFormat(Format.SCALAR, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.ENABLE % __SubjectPP_VOIDict.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.HANDLES_VOI % __SubjectPP_VOIDict.HANDLES_VOI__
					check = Format.checkFormat(Format.HANDLELIST, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.LABELS_VOI % __SubjectPP_VOIDict.LABELS_VOI__
					check = Format.checkFormat(Format.HANDLELIST, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.TEMPLATE % __SubjectPP_VOIDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SubjectPP_VOIDict.getPropSettings(prop));
				case SubjectPP_VOIDict.EL % __SubjectPP_VOIDict.EL__
					check = Format.checkFormat(Format.ITEM, value, SubjectPP_VOIDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectPP_VOIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectPP_VOIDict.getPropTag(prop) ' (' SubjectPP_VOIDict.getFormatTag(SubjectPP_VOIDict.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case SubjectPP_VOIDict.HANDLES_VOI % __SubjectPP_VOIDict.HANDLES_VOI__
					sub = pr.get('EL');
					prop = pr.get('PROP');
					
					voi_dict = sub.get('VOI_DICT');
					handles_voi = cell(1, voi_dict.get('LENGTH'));
					for i = 1:1:voi_dict.get('LENGTH')
					    voi = voi_dict.get('IT', i);
					    
					    if isa(voi, 'VOICategoric')
					        dropdown = uidropdown( ...
					            'Parent', pr.memorize('H'), ... % H = p for Panel
					            'Tag', ['DROPDOWN ' int2str(i)], ... 
					            'Items', voi.get('CATEGORIES'), ...
					            'FontSize', BRAPH2.FONTSIZE, ...
					            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					            'ValueChangedFcn', {@cb_voi_dropdown}, ...
					            'UserData', i ...
					            );
					
					        handles_voi{i} = dropdown;
					    else % isa(voi, 'VOINumeric')
					        editfield = uieditfield('numeric', ...
					            'Parent', pr.memorize('H'), ... % H = p for Panel
					            'Tag', ['EDITFIELD ' int2str(i)], ...
					            'FontSize', BRAPH2.FONTSIZE, ... 
					            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					            'ValueChangedFcn', {@cb_voi_editfield}, ...
					            'UserData', i ...
					            );
					
					        handles_voi{i} = editfield;
					    end
					end
					
					value = handles_voi;
					
				case SubjectPP_VOIDict.LABELS_VOI % __SubjectPP_VOIDict.LABELS_VOI__
					sub = pr.get('EL');
					prop = pr.get('PROP');
					
					voi_dict = sub.get('VOI_DICT');
					labels_voi = cell(1, voi_dict.get('LENGTH'));
					for i = 1:1:voi_dict.get('LENGTH')
					    voi = voi_dict.get('IT', i);
					    
					    labels_voi{i} = uilabel( ...
					        'Parent', pr.memorize('H'), ...
					        'Tag', ['LABEL ' int2str(i)], ...
					        'Interpreter', 'html', ...
					        'FontSize', BRAPH2.FONTSIZE, ...
					        'HorizontalAlignment', 'right', ... 
					        'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					        'BackgroundColor', pr.get('BKGCOLOR') ...
					        );
					end
					
					value = labels_voi;
					
				case SubjectPP_VOIDict.X_DRAW % __SubjectPP_VOIDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('HANDLES_VOI')
					    pr.memorize('LABELS_VOI')
					end
					
				case SubjectPP_VOIDict.UPDATE % __SubjectPP_VOIDict.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    sub = pr.get('EL');
					
					    height = pr.get('HEIGHT_MIN');
					
					    voi_dict = sub.get('VOI_DICT');
						labels_voi = pr.get('LABELS_VOI');
					    handles_voi = pr.get('HANDLES_VOI');
					    for i = 1:1:voi_dict.get('LENGTH')
					        voi = voi_dict.get('IT', i);
					        
					        label = labels_voi{i};
					        set(label, 'Text', voi.get('ID'))
					        
					        if isa(voi, 'VOICategoric')
					            height = height + pr.get('HEIGHT_VOI_DROPDOWN');
					
					            dropdown = handles_voi{i};
					            
					            voi_categories = voi.get('CATEGORIES');
					            set(dropdown, 'Value', voi_categories{voi.get('V')})
					
					            prop_value = voi.getr('V');
					            if voi.isLocked('V') || isa(prop_value, 'Callback')
					                set(dropdown, 'Enable', 'off')
					            end
					        else % isa(voi, 'VOINumeric')
					            height = height + pr.get('HEIGHT_VOI_EDITFIELD');
					            
					            editfield = handles_voi{i};
					            
					            set(editfield, 'Value', voi.get('V'))
					
					            prop_value = voi.getr('V');
					            if voi.isLocked('V') || isa(prop_value, 'Callback')
					                set(editfield, ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					        end
					    end
					    
					    pr.set('HEIGHT', height)
					end
					
				case SubjectPP_VOIDict.REDRAW % __SubjectPP_VOIDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
						w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    sub = pr.get('EL');
					
					    h = 0;
					    
					    voi_dict = sub.get('VOI_DICT');
					    labels_voi = pr.get('LABELS_VOI');
					    handles_voi = pr.get('HANDLES_VOI');
					    for i = voi_dict.get('LENGTH'):-1:1
					        voi = voi_dict.get('IT', i);
					        
					        label = labels_voi{i};
					        set(label, 'Position', [s(.3) h+s(.3) .30*w_p-s(.6) s(1.75)])
					        
					        if isa(voi, 'VOICategoric')
					            dropdown = handles_voi{i};
					            
					            set(dropdown, 'Position', [.30*w_p h+s(.3) .65*w_p s(1.75)])
					
					            h = h + pr.get('HEIGHT_VOI_DROPDOWN');
					        else % isa(voi, 'VOINumeric')
					            editfield = handles_voi{i};
					            
					            set(editfield, 'Position', [.30*w_p h+s(.3) .45*w_p s(1.75)])
					            
					            h = h + pr.get('HEIGHT_VOI_EDITFIELD');
					        end
					    end
					end
					
				case SubjectPP_VOIDict.DELETE % __SubjectPP_VOIDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('HANDLES_VOI', Element.getNoValue())
					    pr.set('LABELS_VOI', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_voi_editfield(src, ~)
			    i = get(src, 'UserData');
			
			    handles_voi = pr.get('HANDLES_VOI');
			    editfield = handles_voi{i};
			    
			    voi_dict = pr.get('EL').get(pr.get('PROP'));
			    voi = voi_dict.get('IT', i);
			    
			    voi.set('V', get(editfield, 'Value'))
			end
			function cb_voi_dropdown(src, ~)
			    i = get(src, 'UserData');
			
			    handles_voi = pr.get('HANDLES_VOI');
			    dropdown = handles_voi{i};
			    
			    voi_dict = pr.get('EL').get(pr.get('PROP'));
			    voi = voi_dict.get('IT', i);
			    
			    voi.set('V', find(strcmp(get(dropdown, 'Value'), voi.get('CATEGORIES'))))
			end
		end
	end
end
