classdef PanelPropRVectorSmart < PanelPropString
	%PanelPropRVectorSmart plots the panel of a smart row vector.
	% It is a subclass of <a href="matlab:help PanelPropString">PanelPropString</a>.
	%
	% A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel 
	%  for a row vector with an edit field. Smart means that (almost) any MatLab 
	%  expression leading to a correct row vector can be introduced in the edit field.
	%  Also, the value of the vector can be limited between some MIN and MAX.
	% It works for all categories, exept for __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.
	%
	% PanelPropRVectorSmart methods (constructor):
	%  PanelPropRVectorSmart - constructor
	%
	% PanelPropRVectorSmart methods:
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
	% PanelPropRVectorSmart methods (display):
	%  tostring - string with information about the smart row-vector prop panel
	%  disp - displays information about the smart row-vector prop panel
	%  tree - displays the tree of the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two smart row-vector prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (save/load, Static):
	%  save - saves BRAPH2 smart row-vector prop panel as b2 file
	%  load - loads a BRAPH2 smart row-vector prop panel from a b2 file
	%
	% PanelPropRVectorSmart method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the smart row-vector prop panel
	%
	% PanelPropRVectorSmart method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (inspection, Static):
	%  getClass - returns the class of the smart row-vector prop panel
	%  getSubclasses - returns all subclasses of PanelPropRVectorSmart
	%  getProps - returns the property list of the smart row-vector prop panel
	%  getPropNumber - returns the property number of the smart row-vector prop panel
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
	% PanelPropRVectorSmart methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropRVectorSmart methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropRVectorSmart methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropRVectorSmart methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropRVectorSmart; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropRVectorSmart constants</a>.
	%
	%
	% See also uieditfield, GUI, PanelElement.
	
	properties (Constant) % properties
		MAX = PanelPropString.getPropNumber() + 1;
		MAX_TAG = 'MAX';
		MAX_CATEGORY = Category.PARAMETER;
		MAX_FORMAT = Format.SCALAR;
		
		MIN = PanelPropString.getPropNumber() + 2;
		MIN_TAG = 'MIN';
		MIN_CATEGORY = Category.PARAMETER;
		MIN_FORMAT = Format.SCALAR;
		
		UNIQUE_VALUE = PanelPropString.getPropNumber() + 3;
		UNIQUE_VALUE_TAG = 'UNIQUE_VALUE';
		UNIQUE_VALUE_CATEGORY = Category.PARAMETER;
		UNIQUE_VALUE_FORMAT = Format.LOGICAL;
		
		DEFAULT = PanelPropString.getPropNumber() + 4;
		DEFAULT_TAG = 'DEFAULT';
		DEFAULT_CATEGORY = Category.PARAMETER;
		DEFAULT_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function pr = PanelPropRVectorSmart(varargin)
			%PanelPropRVectorSmart() creates a smart row-vector prop panel.
			%
			% PanelPropRVectorSmart(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropRVectorSmart(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelPropString(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the smart row-vector prop panel.
			%
			% CLASS = PanelPropRVectorSmart.GETCLASS() returns the class 'PanelPropRVectorSmart'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the smart row-vector prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropRVectorSmart') returns 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropRVectorSmart';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the smart row-vector prop panel.
			%
			% LIST = PanelPropRVectorSmart.GETSUBCLASSES() returns all subclasses of 'PanelPropRVectorSmart'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the smart row-vector prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropRVectorSmart') returns all subclasses of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropRVectorSmart', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of smart row-vector prop panel.
			%
			% PROPS = PanelPropRVectorSmart.GETPROPS() returns the property list of smart row-vector prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropRVectorSmart.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the smart row-vector prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropRVectorSmart'[, CATEGORY]) returns the property list of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelPropString.getProps() ...
						PanelPropRVectorSmart.MAX ...
						PanelPropRVectorSmart.MIN ...
						PanelPropRVectorSmart.UNIQUE_VALUE ...
						PanelPropRVectorSmart.DEFAULT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelPropString.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelPropString.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelPropString.getProps(Category.PARAMETER) ...
						PanelPropRVectorSmart.MAX ...
						PanelPropRVectorSmart.MIN ...
						PanelPropRVectorSmart.UNIQUE_VALUE ...
						PanelPropRVectorSmart.DEFAULT ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelPropString.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelPropString.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelPropString.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelPropString.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelPropString.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelPropString.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of smart row-vector prop panel.
			%
			% N = PanelPropRVectorSmart.GETPROPNUMBER() returns the property number of smart row-vector prop panel.
			%
			% N = PanelPropRVectorSmart.GETPROPNUMBER(CATEGORY) returns the property number of smart row-vector prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the smart row-vector prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropRVectorSmart') returns the property number of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropRVectorSmart.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in smart row-vector prop panel/error.
			%
			% CHECK = PanelPropRVectorSmart.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropRVectorSmart, PROP) checks whether PROP exists for PanelPropRVectorSmart.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSPROP(PanelPropRVectorSmart, PROP) throws error if PROP does NOT exist for PanelPropRVectorSmart.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropRVectorSmart.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropRVectorSmart.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in smart row-vector prop panel/error.
			%
			% CHECK = PanelPropRVectorSmart.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropRVectorSmart, TAG) checks whether TAG exists for PanelPropRVectorSmart.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSTAG(PanelPropRVectorSmart, TAG) throws error if TAG does NOT exist for PanelPropRVectorSmart.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelproprvectorsmart_tag_list = cellfun(@(x) PanelPropRVectorSmart.getPropTag(x), num2cell(PanelPropRVectorSmart.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelproprvectorsmart_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropRVectorSmart.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropRVectorSmart, POINTER) returns property number of POINTER of PanelPropRVectorSmart.
			%  PROPERTY = PR.GETPROPPROP(PanelPropRVectorSmart, POINTER) returns property number of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelproprvectorsmart_tag_list = cellfun(@(x) PanelPropRVectorSmart.getPropTag(x), num2cell(PanelPropRVectorSmart.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelproprvectorsmart_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropRVectorSmart, POINTER) returns tag of POINTER of PanelPropRVectorSmart.
			%  TAG = PR.GETPROPTAG(PanelPropRVectorSmart, POINTER) returns tag of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropRVectorSmart.MAX
						tag = PanelPropRVectorSmart.MAX_TAG;
					case PanelPropRVectorSmart.MIN
						tag = PanelPropRVectorSmart.MIN_TAG;
					case PanelPropRVectorSmart.UNIQUE_VALUE
						tag = PanelPropRVectorSmart.UNIQUE_VALUE_TAG;
					case PanelPropRVectorSmart.DEFAULT
						tag = PanelPropRVectorSmart.DEFAULT_TAG;
					otherwise
						tag = getPropTag@PanelPropString(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropRVectorSmart, POINTER) returns category of POINTER of PanelPropRVectorSmart.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropRVectorSmart, POINTER) returns category of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX
					prop_category = PanelPropRVectorSmart.MAX_CATEGORY;
				case PanelPropRVectorSmart.MIN
					prop_category = PanelPropRVectorSmart.MIN_CATEGORY;
				case PanelPropRVectorSmart.UNIQUE_VALUE
					prop_category = PanelPropRVectorSmart.UNIQUE_VALUE_CATEGORY;
				case PanelPropRVectorSmart.DEFAULT
					prop_category = PanelPropRVectorSmart.DEFAULT_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelPropString(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropRVectorSmart, POINTER) returns format of POINTER of PanelPropRVectorSmart.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropRVectorSmart, POINTER) returns format of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX
					prop_format = PanelPropRVectorSmart.MAX_FORMAT;
				case PanelPropRVectorSmart.MIN
					prop_format = PanelPropRVectorSmart.MIN_FORMAT;
				case PanelPropRVectorSmart.UNIQUE_VALUE
					prop_format = PanelPropRVectorSmart.UNIQUE_VALUE_FORMAT;
				case PanelPropRVectorSmart.DEFAULT
					prop_format = PanelPropRVectorSmart.DEFAULT_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelPropString(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropRVectorSmart, POINTER) returns description of POINTER of PanelPropRVectorSmart.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropRVectorSmart, POINTER) returns description of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX
					prop_description = 'MAX (parameter, scalar) is the max value acceptable as input.';
				case PanelPropRVectorSmart.MIN
					prop_description = 'MIN (parameter, scalar) is the min value acceptable as input.';
				case PanelPropRVectorSmart.UNIQUE_VALUE
					prop_description = 'UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.';
				case PanelPropRVectorSmart.DEFAULT
					prop_description = 'DEFAULT (parameter, rvector) is the default value.';
				case PanelPropRVectorSmart.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the smart row-vector property panel.';
				case PanelPropRVectorSmart.NAME
					prop_description = 'NAME (constant, string) is the name of the smart row-vector property panel.';
				case PanelPropRVectorSmart.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the smart row-vector property panel.';
				case PanelPropRVectorSmart.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the smart row-vector property panel.';
				case PanelPropRVectorSmart.ID
					prop_description = 'ID (data, string) is a few-letter code for the smart row-vector property panel.';
				case PanelPropRVectorSmart.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the smart row-vector property panel.';
				case PanelPropRVectorSmart.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the smart row-vector property panel.';
				case PanelPropRVectorSmart.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropRVectorSmart.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropRVectorSmart.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropRVectorSmart.EDITFIELD
					prop_description = 'EDITFIELD (evanescent, handle) is the string value edit field with a smart row vector.';
				otherwise
					prop_description = getPropDescription@PanelPropString(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropRVectorSmart, POINTER) returns settings of POINTER of PanelPropRVectorSmart.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropRVectorSmart, POINTER) returns settings of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PanelPropRVectorSmart.MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PanelPropRVectorSmart.UNIQUE_VALUE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropRVectorSmart.DEFAULT
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PanelPropRVectorSmart.TEMPLATE
					prop_settings = 'PanelPropRVectorSmart';
				otherwise
					prop_settings = getPropSettings@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropRVectorSmart, POINTER) returns the default value of POINTER of PanelPropRVectorSmart.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropRVectorSmart, POINTER) returns the default value of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX
					prop_default = +Inf;
				case PanelPropRVectorSmart.MIN
					prop_default = -Inf;
				case PanelPropRVectorSmart.UNIQUE_VALUE
					prop_default = true;
				case PanelPropRVectorSmart.DEFAULT
					prop_default = Format.getFormatDefault(Format.RVECTOR, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.ELCLASS
					prop_default = 'PanelPropRVectorSmart';
				case PanelPropRVectorSmart.NAME
					prop_default = 'Smart Row-Vector Prop Panel';
				case PanelPropRVectorSmart.DESCRIPTION
					prop_default = 'A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel for a row vector with an edit field. Smart means that (almost) any MatLab expression leading to a correct row vector can be introduced in the edit field. Also, the value of the vector can be limited between some MIN and MAX. It works for all categories, exept for __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.';
				case PanelPropRVectorSmart.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.ID
					prop_default = 'PanelPropRVectorSmart ID';
				case PanelPropRVectorSmart.LABEL
					prop_default = 'PanelPropRVectorSmart label';
				case PanelPropRVectorSmart.NOTES
					prop_default = 'PanelPropRVectorSmart notes';
				case PanelPropRVectorSmart.EL
					prop_default = Graph();
				case PanelPropRVectorSmart.PROP
					prop_default = Graph.LAYERTICKS;
				otherwise
					prop_default = getPropDefault@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropRVectorSmart, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorSmart.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropRVectorSmart, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			prop_default = PanelPropRVectorSmart.conditioning(prop, PanelPropRVectorSmart.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorSmart.
			%  CHECK = PR.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorSmart.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropRVectorSmart:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorSmart:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorSmart.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorSmart:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorSmart.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorSmart:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorSmart.MAX % __PanelPropRVectorSmart.MAX__
					check = Format.checkFormat(Format.SCALAR, value, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.MIN % __PanelPropRVectorSmart.MIN__
					check = Format.checkFormat(Format.SCALAR, value, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.UNIQUE_VALUE % __PanelPropRVectorSmart.UNIQUE_VALUE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.DEFAULT % __PanelPropRVectorSmart.DEFAULT__
					check = Format.checkFormat(Format.RVECTOR, value, PanelPropRVectorSmart.getPropSettings(prop));
				case PanelPropRVectorSmart.TEMPLATE % __PanelPropRVectorSmart.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropRVectorSmart.getPropSettings(prop));
				otherwise
					if prop <= PanelPropString.getPropNumber()
						check = checkProp@PanelPropString(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropRVectorSmart.getPropTag(prop) ' (' PanelPropRVectorSmart.getFormatTag(PanelPropRVectorSmart.getPropFormat(prop)) ').'] ...
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
				case PanelPropRVectorSmart.UPDATE % __PanelPropRVectorSmart.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % skips __PanelPropString.UPDATE__ % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('EDITFIELD'), ...
					                'Value', mat2str(el.get(prop)), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))
					
					            if el.isLocked(prop)
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            error([BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.ERR_FUNC], ...
					                'PanelPropRVectorSmart should not be used with __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.')
					    end
					end
					
				case PanelPropRVectorSmart.EDITFIELD % __PanelPropRVectorSmart.EDITFIELD__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield} ...
					    );
					
					value = editfield;
					
				otherwise
					if prop <= PanelPropString.getPropNumber()
						value = calculateValue@PanelPropString(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    try 
			        value = eval(['[' get(pr.get('EDITFIELD'), 'Value') ']']);
			        if pr.get('UNIQUE_VALUE')
			            value = unique(value(:)'); % sort done by unique
			        end
			        value(value < pr.get('MIN')) = pr.get('MIN');
			        value(value > pr.get('MAX')) = pr.get('MAX');
			        
			        if isempty(value)
			            value = pr.get('DEFAULT');
			        end
			    catch
			        value = el.get(prop);
			    end
			    
			    el.set(prop, value)
			end
		end
	end
end
