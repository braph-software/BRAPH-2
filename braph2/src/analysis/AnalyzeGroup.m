classdef AnalyzeGroup < ConcreteElement
	%AnalyzeGroup is a group-based graph analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.
	% Instances of this class should not be created; Use one of its subclasses instead.
	%
	% AnalyzeGroup methods (constructor):
	%  AnalyzeGroup - constructor
	%
	% AnalyzeGroup methods:
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
	% AnalyzeGroup methods (display):
	%  tostring - string with information about the group-based graph analysis
	%  disp - displays information about the group-based graph analysis
	%  tree - displays the tree of the group-based graph analysis
	%
	% AnalyzeGroup methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two group-based graph analysis are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the group-based graph analysis
	%
	% AnalyzeGroup methods (save/load, Static):
	%  save - saves BRAPH2 group-based graph analysis as b2 file
	%  load - loads a BRAPH2 group-based graph analysis from a b2 file
	%
	% AnalyzeGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the group-based graph analysis
	%
	% AnalyzeGroup method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the group-based graph analysis
	%
	% AnalyzeGroup methods (inspection, Static):
	%  getClass - returns the class of the group-based graph analysis
	%  getSubclasses - returns all subclasses of AnalyzeGroup
	%  getProps - returns the property list of the group-based graph analysis
	%  getPropNumber - returns the property number of the group-based graph analysis
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
	% AnalyzeGroup methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroup methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroup; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroup constants</a>.
	%
	%
	% See also CompareGroup.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		GR = ConcreteElement.getPropNumber() + 2;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		G = ConcreteElement.getPropNumber() + 3;
		G_TAG = 'G';
		G_CATEGORY = Category.RESULT;
		G_FORMAT = Format.ITEM;
	end
	methods % constructor
		function a = AnalyzeGroup(varargin)
			%AnalyzeGroup() creates a group-based graph analysis.
			%
			% AnalyzeGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			a = a@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function a_class = getClass()
			%GETCLASS returns the class of the group-based graph analysis.
			%
			% CLASS = AnalyzeGroup.GETCLASS() returns the class 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the group-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup') returns 'AnalyzeGroup'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeGroup')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeGroup';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the group-based graph analysis.
			%
			% LIST = AnalyzeGroup.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the group-based graph analysis A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroup') returns all subclasses of 'AnalyzeGroup'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeGroup', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based graph analysis.
			%
			% PROPS = AnalyzeGroup.GETPROPS() returns the property list of group-based graph analysis
			%  as a row vector.
			%
			% PROPS = AnalyzeGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the group-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup'[, CATEGORY]) returns the property list of 'AnalyzeGroup'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						AnalyzeGroup.WAITBAR ...
						AnalyzeGroup.GR ...
						AnalyzeGroup.G ...
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
						AnalyzeGroup.GR ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						AnalyzeGroup.G ...
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
						AnalyzeGroup.WAITBAR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of group-based graph analysis.
			%
			% N = AnalyzeGroup.GETPROPNUMBER() returns the property number of group-based graph analysis.
			%
			% N = AnalyzeGroup.GETPROPNUMBER(CATEGORY) returns the property number of group-based graph analysis
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the group-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup') returns the property number of 'AnalyzeGroup'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeGroup.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup, PROP) checks whether PROP exists for AnalyzeGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup, PROP) throws error if PROP does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeGroup.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup, TAG) checks whether TAG exists for AnalyzeGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup, TAG) throws error if TAG does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzegroup_tag_list = cellfun(@(x) AnalyzeGroup.getPropTag(x), num2cell(AnalyzeGroup.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzegroup_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzegroup_tag_list = cellfun(@(x) AnalyzeGroup.getPropTag(x), num2cell(AnalyzeGroup.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzegroup_tag_list)); % tag = pointer
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%  TAG = A.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeGroup.WAITBAR
						tag = AnalyzeGroup.WAITBAR_TAG;
					case AnalyzeGroup.GR
						tag = AnalyzeGroup.GR_TAG;
					case AnalyzeGroup.G
						tag = AnalyzeGroup.G_TAG;
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR
					prop_category = AnalyzeGroup.WAITBAR_CATEGORY;
				case AnalyzeGroup.GR
					prop_category = AnalyzeGroup.GR_CATEGORY;
				case AnalyzeGroup.G
					prop_category = AnalyzeGroup.G_CATEGORY;
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR
					prop_format = AnalyzeGroup.WAITBAR_FORMAT;
				case AnalyzeGroup.GR
					prop_format = AnalyzeGroup.GR_FORMAT;
				case AnalyzeGroup.G
					prop_format = AnalyzeGroup.G_FORMAT;
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case AnalyzeGroup.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class.';
				case AnalyzeGroup.G
					prop_description = 'G (result, item) is the graph obtained from this analysis.';
				case AnalyzeGroup.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeGroup.NAME
					prop_description = 'NAME (constant, string) is the name of the group-based graph analysis.';
				case AnalyzeGroup.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the group-based graph analysis.';
				case AnalyzeGroup.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the group-based graph analysis.';
				case AnalyzeGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the group-based graph analysis.';
				case AnalyzeGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group-based graph analysis.';
				case AnalyzeGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group-based graph analysis.';
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case AnalyzeGroup.GR
					prop_settings = 'Group';
				case AnalyzeGroup.G
					prop_settings = 'Graph';
				case AnalyzeGroup.TEMPLATE
					prop_settings = 'AnalyzeGroup';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR
					prop_default = true;
				case AnalyzeGroup.GR
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.G
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.ELCLASS
					prop_default = 'AnalyzeGroup';
				case AnalyzeGroup.NAME
					prop_default = 'AnalyzeGroup';
				case AnalyzeGroup.DESCRIPTION
					prop_default = 'AnalyzeGroup provides the methods necessary for all group-based analysis subclasses. Instances of this class should not be created; Use one of its subclasses instead.';
				case AnalyzeGroup.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.ID
					prop_default = 'AnalyzeGroup ID';
				case AnalyzeGroup.LABEL
					prop_default = 'AnalyzeGroup label';
				case AnalyzeGroup.NOTES
					prop_default = 'AnalyzeGroup notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			prop_default = AnalyzeGroup.conditioning(prop, AnalyzeGroup.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			%  CHECK = A.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeGroup:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup:€BRAPH2.WRONG_INPUT€
			%  A.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup.WAITBAR % __AnalyzeGroup.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.GR % __AnalyzeGroup.GR__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.G % __AnalyzeGroup.G__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup.getPropSettings(prop));
				case AnalyzeGroup.TEMPLATE % __AnalyzeGroup.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup.getPropTag(prop) ' (' AnalyzeGroup.getFormatTag(AnalyzeGroup.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case AnalyzeGroup.G % __AnalyzeGroup.G__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeGroup.G), 'twister')
					
					value = Graph();
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
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
				case AnalyzeGroup.GR % __AnalyzeGroup.GR__
					pr = PanelPropItem('EL', a, 'PROP', AnalyzeGroup.GR, ...
					    'BUTTON_TEXT', a.get('GR').get('ID'), ...
					    varargin{:});
					
				case AnalyzeGroup.G % __AnalyzeGroup.G__
					% pr = PanelPropItem('EL', a, 'PROP', AnalyzeGroup.G, ...
					%     'GUICLASS', 'GUIElement', ...
					%     'BUTTON_TEXT', 'Graph & Measures', ...
					%     varargin{:});
					pr = AnalyzeGroupPP_G('EL', a, 'PROP', AnalyzeGroup.G, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(a, prop, varargin{:});
					
			end
		end
	end
end
