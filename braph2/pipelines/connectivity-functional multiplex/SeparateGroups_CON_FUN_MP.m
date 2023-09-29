classdef SeparateGroups_CON_FUN_MP < ConcreteElement
	%SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity and functiona data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity 
	%  and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and 
	%  SubjectCON_FUN.
	%
	% SeparateGroups_CON_FUN_MP methods (constructor):
	%  SeparateGroups_CON_FUN_MP - constructor
	%
	% SeparateGroups_CON_FUN_MP methods:
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
	% SeparateGroups_CON_FUN_MP methods (display):
	%  tostring - string with information about the separator of a CON_FUN_MP subject group
	%  disp - displays information about the separator of a CON_FUN_MP subject group
	%  tree - displays the tree of the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two separator of a CON_FUN_MP subject group are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (save/load, Static):
	%  save - saves BRAPH2 separator of a CON_FUN_MP subject group as b2 file
	%  load - loads a BRAPH2 separator of a CON_FUN_MP subject group from a b2 file
	%
	% SeparateGroups_CON_FUN_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (inspection, Static):
	%  getClass - returns the class of the separator of a CON_FUN_MP subject group
	%  getSubclasses - returns all subclasses of SeparateGroups_CON_FUN_MP
	%  getProps - returns the property list of the separator of a CON_FUN_MP subject group
	%  getPropNumber - returns the property number of the separator of a CON_FUN_MP subject group
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
	% SeparateGroups_CON_FUN_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SeparateGroups_CON_FUN_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SeparateGroups_CON_FUN_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SeparateGroups_CON_FUN_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SeparateGroups_CON_FUN_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SeparateGroups_CON_FUN_MP constants</a>.
	%
	%
	% See also SubjectCON_FUN_MP, SubjectCON, SubjectFUN, CombineGroups_CON_FUN.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.METADATA;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		GR_CON_FUN_MP = ConcreteElement.getPropNumber() + 2;
		GR_CON_FUN_MP_TAG = 'GR_CON_FUN_MP';
		GR_CON_FUN_MP_CATEGORY = Category.DATA;
		GR_CON_FUN_MP_FORMAT = Format.ITEM;
		
		GR_CON = ConcreteElement.getPropNumber() + 3;
		GR_CON_TAG = 'GR_CON';
		GR_CON_CATEGORY = Category.RESULT;
		GR_CON_FORMAT = Format.ITEM;
		
		GR_FUN = ConcreteElement.getPropNumber() + 4;
		GR_FUN_TAG = 'GR_FUN';
		GR_FUN_CATEGORY = Category.RESULT;
		GR_FUN_FORMAT = Format.ITEM;
	end
	methods % constructor
		function se = SeparateGroups_CON_FUN_MP(varargin)
			%SeparateGroups_CON_FUN_MP() creates a separator of a CON_FUN_MP subject group.
			%
			% SeparateGroups_CON_FUN_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SeparateGroups_CON_FUN_MP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			se = se@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function se_class = getClass()
			%GETCLASS returns the class of the separator of a CON_FUN_MP subject group.
			%
			% CLASS = SeparateGroups_CON_FUN_MP.GETCLASS() returns the class 'SeparateGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SE.GETCLASS() returns the class of the separator of a CON_FUN_MP subject group SE.
			%  CLASS = Element.GETCLASS(SE) returns the class of 'SE'.
			%  CLASS = Element.GETCLASS('SeparateGroups_CON_FUN_MP') returns 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETCLASS(SE) and Element.GETCLASS('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			
			se_class = 'SeparateGroups_CON_FUN_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the separator of a CON_FUN_MP subject group.
			%
			% LIST = SeparateGroups_CON_FUN_MP.GETSUBCLASSES() returns all subclasses of 'SeparateGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = SE.GETSUBCLASSES() returns all subclasses of the separator of a CON_FUN_MP subject group SE.
			%  LIST = Element.GETSUBCLASSES(SE) returns all subclasses of 'SE'.
			%  LIST = Element.GETSUBCLASSES('SeparateGroups_CON_FUN_MP') returns all subclasses of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETSUBCLASSES(SE) and Element.GETSUBCLASSES('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SeparateGroups_CON_FUN_MP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of separator of a CON_FUN_MP subject group.
			%
			% PROPS = SeparateGroups_CON_FUN_MP.GETPROPS() returns the property list of separator of a CON_FUN_MP subject group
			%  as a row vector.
			%
			% PROPS = SeparateGroups_CON_FUN_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SE.GETPROPS([CATEGORY]) returns the property list of the separator of a CON_FUN_MP subject group SE.
			%  PROPS = Element.GETPROPS(SE[, CATEGORY]) returns the property list of 'SE'.
			%  PROPS = Element.GETPROPS('SeparateGroups_CON_FUN_MP'[, CATEGORY]) returns the property list of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPS(SE) and Element.GETPROPS('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						SeparateGroups_CON_FUN_MP.WAITBAR ...
						SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP ...
						SeparateGroups_CON_FUN_MP.GR_CON ...
						SeparateGroups_CON_FUN_MP.GR_FUN ...
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
						SeparateGroups_CON_FUN_MP.WAITBAR ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						SeparateGroups_CON_FUN_MP.GR_CON ...
						SeparateGroups_CON_FUN_MP.GR_FUN ...
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
			%GETPROPNUMBER returns the property number of separator of a CON_FUN_MP subject group.
			%
			% N = SeparateGroups_CON_FUN_MP.GETPROPNUMBER() returns the property number of separator of a CON_FUN_MP subject group.
			%
			% N = SeparateGroups_CON_FUN_MP.GETPROPNUMBER(CATEGORY) returns the property number of separator of a CON_FUN_MP subject group
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SE.GETPROPNUMBER([CATEGORY]) returns the property number of the separator of a CON_FUN_MP subject group SE.
			%  N = Element.GETPROPNUMBER(SE) returns the property number of 'SE'.
			%  N = Element.GETPROPNUMBER('SeparateGroups_CON_FUN_MP') returns the property number of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPNUMBER(SE) and Element.GETPROPNUMBER('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SeparateGroups_CON_FUN_MP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in separator of a CON_FUN_MP subject group/error.
			%
			% CHECK = SeparateGroups_CON_FUN_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSPROP(PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SE, PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SeparateGroups_CON_FUN_MP, PROP) checks whether PROP exists for SeparateGroups_CON_FUN_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSPROP(PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SE, PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SeparateGroups_CON_FUN_MP, PROP) throws error if PROP does NOT exist for SeparateGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SE) and Element.EXISTSPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SeparateGroups_CON_FUN_MP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SeparateGroups_CON_FUN_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in separator of a CON_FUN_MP subject group/error.
			%
			% CHECK = SeparateGroups_CON_FUN_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSTAG(TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SE, TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SeparateGroups_CON_FUN_MP, TAG) checks whether TAG exists for SeparateGroups_CON_FUN_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSTAG(TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SE, TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SeparateGroups_CON_FUN_MP, TAG) throws error if TAG does NOT exist for SeparateGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SE) and Element.EXISTSTAG('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			separategroups_con_fun_mp_tag_list = cellfun(@(x) SeparateGroups_CON_FUN_MP.getPropTag(x), num2cell(SeparateGroups_CON_FUN_MP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, separategroups_con_fun_mp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SeparateGroups_CON_FUN_MP.'] ...
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
			%  PROPERTY = SE.GETPROPPROP(POINTER) returns property number of POINTER of SE.
			%  PROPERTY = Element.GETPROPPROP(SeparateGroups_CON_FUN_MP, POINTER) returns property number of POINTER of SeparateGroups_CON_FUN_MP.
			%  PROPERTY = SE.GETPROPPROP(SeparateGroups_CON_FUN_MP, POINTER) returns property number of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPPROP(SE) and Element.GETPROPPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				separategroups_con_fun_mp_tag_list = cellfun(@(x) SeparateGroups_CON_FUN_MP.getPropTag(x), num2cell(SeparateGroups_CON_FUN_MP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, separategroups_con_fun_mp_tag_list)); % tag = pointer
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
			%  TAG = SE.GETPROPTAG(POINTER) returns tag of POINTER of SE.
			%  TAG = Element.GETPROPTAG(SeparateGroups_CON_FUN_MP, POINTER) returns tag of POINTER of SeparateGroups_CON_FUN_MP.
			%  TAG = SE.GETPROPTAG(SeparateGroups_CON_FUN_MP, POINTER) returns tag of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPTAG(SE) and Element.GETPROPTAG('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SeparateGroups_CON_FUN_MP.WAITBAR
						tag = SeparateGroups_CON_FUN_MP.WAITBAR_TAG;
					case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
						tag = SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP_TAG;
					case SeparateGroups_CON_FUN_MP.GR_CON
						tag = SeparateGroups_CON_FUN_MP.GR_CON_TAG;
					case SeparateGroups_CON_FUN_MP.GR_FUN
						tag = SeparateGroups_CON_FUN_MP.GR_FUN_TAG;
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
			%  CATEGORY = SE.GETPROPCATEGORY(POINTER) returns category of POINTER of SE.
			%  CATEGORY = Element.GETPROPCATEGORY(SeparateGroups_CON_FUN_MP, POINTER) returns category of POINTER of SeparateGroups_CON_FUN_MP.
			%  CATEGORY = SE.GETPROPCATEGORY(SeparateGroups_CON_FUN_MP, POINTER) returns category of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPCATEGORY(SE) and Element.GETPROPCATEGORY('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR
					prop_category = SeparateGroups_CON_FUN_MP.WAITBAR_CATEGORY;
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_category = SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP_CATEGORY;
				case SeparateGroups_CON_FUN_MP.GR_CON
					prop_category = SeparateGroups_CON_FUN_MP.GR_CON_CATEGORY;
				case SeparateGroups_CON_FUN_MP.GR_FUN
					prop_category = SeparateGroups_CON_FUN_MP.GR_FUN_CATEGORY;
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
			%  FORMAT = SE.GETPROPFORMAT(POINTER) returns format of POINTER of SE.
			%  FORMAT = Element.GETPROPFORMAT(SeparateGroups_CON_FUN_MP, POINTER) returns format of POINTER of SeparateGroups_CON_FUN_MP.
			%  FORMAT = SE.GETPROPFORMAT(SeparateGroups_CON_FUN_MP, POINTER) returns format of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPFORMAT(SE) and Element.GETPROPFORMAT('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR
					prop_format = SeparateGroups_CON_FUN_MP.WAITBAR_FORMAT;
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_format = SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP_FORMAT;
				case SeparateGroups_CON_FUN_MP.GR_CON
					prop_format = SeparateGroups_CON_FUN_MP.GR_CON_FORMAT;
				case SeparateGroups_CON_FUN_MP.GR_FUN
					prop_format = SeparateGroups_CON_FUN_MP.GR_FUN_FORMAT;
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
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SeparateGroups_CON_FUN_MP, POINTER) returns description of POINTER of SeparateGroups_CON_FUN_MP.
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(SeparateGroups_CON_FUN_MP, POINTER) returns description of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(SE) and Element.GETPROPDESCRIPTION('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) determines whether to show the waitbar.';
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_description = 'GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data.';
				case SeparateGroups_CON_FUN_MP.GR_CON
					prop_description = 'GR_CON (result, item) is a group of subjects with connectivity data.';
				case SeparateGroups_CON_FUN_MP.GR_FUN
					prop_description = 'GR_FUN (result, item) is a group of subjects with functional data.';
				case SeparateGroups_CON_FUN_MP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case SeparateGroups_CON_FUN_MP.NAME
					prop_description = 'NAME (constant, string) is the name of the separator of a CON_FUN_MP subject group.';
				case SeparateGroups_CON_FUN_MP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the separator of a CON_FUN_MP subject group.';
				case SeparateGroups_CON_FUN_MP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the separator of a CON_FUN_MP subject group.';
				case SeparateGroups_CON_FUN_MP.ID
					prop_description = 'ID (data, string) is a few-letter code for the separator of a CON_FUN_MP subject group.';
				case SeparateGroups_CON_FUN_MP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the separator of a CON_FUN_MP subject group.';
				case SeparateGroups_CON_FUN_MP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the separator of a CON_FUN_MP subject group.';
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
			%  SETTINGS = SE.GETPROPSETTINGS(POINTER) returns settings of POINTER of SE.
			%  SETTINGS = Element.GETPROPSETTINGS(SeparateGroups_CON_FUN_MP, POINTER) returns settings of POINTER of SeparateGroups_CON_FUN_MP.
			%  SETTINGS = SE.GETPROPSETTINGS(SeparateGroups_CON_FUN_MP, POINTER) returns settings of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPSETTINGS(SE) and Element.GETPROPSETTINGS('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_settings = 'Group';
				case SeparateGroups_CON_FUN_MP.GR_CON
					prop_settings = 'Group';
				case SeparateGroups_CON_FUN_MP.GR_FUN
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULT(SeparateGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of SeparateGroups_CON_FUN_MP.
			%  DEFAULT = SE.GETPROPDEFAULT(SeparateGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULT(SE) and Element.GETPROPDEFAULT('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
				case SeparateGroups_CON_FUN_MP.GR_CON
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case SeparateGroups_CON_FUN_MP.GR_FUN
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case SeparateGroups_CON_FUN_MP.ELCLASS
					prop_default = 'SeparateGroups_CON_FUN_MP';
				case SeparateGroups_CON_FUN_MP.NAME
					prop_default = 'SeparateGroups_CON_FUN_MP';
				case SeparateGroups_CON_FUN_MP.DESCRIPTION
					prop_default = 'SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and SubjectCON_FUN.';
				case SeparateGroups_CON_FUN_MP.ID
					prop_default = 'SeparateGroups_CON_FUN_MP ID';
				case SeparateGroups_CON_FUN_MP.LABEL
					prop_default = 'SeparateGroups_CON_FUN_MP label';
				case SeparateGroups_CON_FUN_MP.NOTES
					prop_default = 'SeparateGroups_CON_FUN_MP notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SeparateGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SeparateGroups_CON_FUN_MP.
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(SeparateGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SE) and Element.GETPROPDEFAULTCONDITIONED('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			prop_default = SeparateGroups_CON_FUN_MP.conditioning(prop, SeparateGroups_CON_FUN_MP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SE.
			%  CHECK = Element.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SeparateGroups_CON_FUN_MP.
			%  CHECK = SE.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SeparateGroups_CON_FUN_MP.
			% 
			% SE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SeparateGroups_CON_FUN_MP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SE.
			%   Error id: €BRAPH2.STR€:SeparateGroups_CON_FUN_MP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SeparateGroups_CON_FUN_MP.
			%   Error id: €BRAPH2.STR€:SeparateGroups_CON_FUN_MP:€BRAPH2.WRONG_INPUT€
			%  SE.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SeparateGroups_CON_FUN_MP.
			%   Error id: €BRAPH2.STR€:SeparateGroups_CON_FUN_MP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(SE) and Element.CHECKPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case SeparateGroups_CON_FUN_MP.WAITBAR % __SeparateGroups_CON_FUN_MP.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP % __SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP__
					check = Format.checkFormat(Format.ITEM, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses()));
					end
				case SeparateGroups_CON_FUN_MP.GR_CON % __SeparateGroups_CON_FUN_MP.GR_CON__
					check = Format.checkFormat(Format.ITEM, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case SeparateGroups_CON_FUN_MP.GR_FUN % __SeparateGroups_CON_FUN_MP.GR_FUN__
					check = Format.checkFormat(Format.ITEM, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SeparateGroups_CON_FUN_MP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SeparateGroups_CON_FUN_MP.getPropTag(prop) ' (' SeparateGroups_CON_FUN_MP.getFormatTag(SeparateGroups_CON_FUN_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(se, prop, varargin)
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
				case SeparateGroups_CON_FUN_MP.GR_CON % __SeparateGroups_CON_FUN_MP.GR_CON__
					rng_settings_ = rng(); rng(se.getPropSeed(SeparateGroups_CON_FUN_MP.GR_CON), 'twister')
					
					wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the connectivity group ...');
					
					gr_CON = Group( ...
					    'SUB_CLASS', 'SubjectCON', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'), ...
					    'ID', 'SubjectCON' ...
					    );
					sub_dict_CON = gr_CON.get('SUB_DICT');
					
					sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
					for i = 1:1:sub_dict.get('LENGTH')
					    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])
					
						sub = sub_dict.get('IT', i);
					    
					    sub_CON = SubjectCON( ...
					        'ID', sub.get('ID'), ...
					        'BA', sub.get('BA'), ...
					        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
					        'CON', sub.get('CON') ...
					        );
					    sub_dict_CON.get('ADD', sub_CON);    
					end
					
					value = gr_CON;
					
					braph2waitbar(wb, 'close')
					
					rng(rng_settings_)
					
				case SeparateGroups_CON_FUN_MP.GR_FUN % __SeparateGroups_CON_FUN_MP.GR_FUN__
					rng_settings_ = rng(); rng(se.getPropSeed(SeparateGroups_CON_FUN_MP.GR_FUN), 'twister')
					
					wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the functional group ...');
					
					gr_FUN = Group( ...
					    'SUB_CLASS', 'SubjectFUN', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'), ...
					    'ID', 'SubjectFUN' ...
					    );
					sub_dict_FUN = gr_FUN.get('SUB_DICT');
					
					sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
					for i = 1:1:sub_dict.get('LENGTH')
					    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])
					
						sub = sub_dict.get('IT', i);
					    
					    sub_FUN = SubjectFUN( ...
					        'ID', sub.get('ID'), ...
					        'BA', sub.get('BA'), ...
					        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
					        'FUN', sub.get('FUN') ...
					        );
					    sub_dict_FUN.get('ADD', sub_FUN);
					end
					
					value = gr_FUN;
					
					braph2waitbar(wb, 'close')
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(se, prop, varargin{:});
					else
						value = calculateValue@Element(se, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(se, prop, value)
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
			msg = ['Error while checking ' tostring(se) ' ' se.getPropTag(prop) '.'];
			
			switch prop
				case SeparateGroups_CON_FUN_MP.GR_CON % __SeparateGroups_CON_FUN_MP.GR_CON__
					check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses()));
					
				case SeparateGroups_CON_FUN_MP.GR_FUN % __SeparateGroups_CON_FUN_MP.GR_FUN__
					check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses()));
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(se, prop, value);
					end
			end
		end
	end
end
