classdef VOI < ConcreteElement
	%VOI is the base element for the variables of interest.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Variable Of Interest (VOI) is the base element for a variable of interest.
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	%
	% VOI methods (constructor):
	%  VOI - constructor
	%
	% VOI methods:
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
	% VOI methods (display):
	%  tostring - string with information about the variable of interest
	%  disp - displays information about the variable of interest
	%  tree - displays the tree of the variable of interest
	%
	% VOI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two variable of interest are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the variable of interest
	%
	% VOI methods (save/load, Static):
	%  save - saves BRAPH2 variable of interest as b2 file
	%  load - loads a BRAPH2 variable of interest from a b2 file
	%
	% VOI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the variable of interest
	%
	% VOI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the variable of interest
	%
	% VOI methods (inspection, Static):
	%  getClass - returns the class of the variable of interest
	%  getSubclasses - returns all subclasses of VOI
	%  getProps - returns the property list of the variable of interest
	%  getPropNumber - returns the property number of the variable of interest
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
	% VOI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% VOI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% VOI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% VOI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?VOI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">VOI constants</a>.
	%
	%
	% See also VOINumeric, VOICategoric.
	
	properties (Constant) % properties
		V = ConcreteElement.getPropNumber() + 1;
		V_TAG = 'V';
		V_CATEGORY = Category.DATA;
		V_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function voi = VOI(varargin)
			%VOI() creates a variable of interest.
			%
			% VOI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% VOI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			voi = voi@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function voi_class = getClass()
			%GETCLASS returns the class of the variable of interest.
			%
			% CLASS = VOI.GETCLASS() returns the class 'VOI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = VOI.GETCLASS() returns the class of the variable of interest VOI.
			%  CLASS = Element.GETCLASS(VOI) returns the class of 'VOI'.
			%  CLASS = Element.GETCLASS('VOI') returns 'VOI'.
			%
			% Note that the Element.GETCLASS(VOI) and Element.GETCLASS('VOI')
			%  are less computationally efficient.
			
			voi_class = 'VOI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the variable of interest.
			%
			% LIST = VOI.GETSUBCLASSES() returns all subclasses of 'VOI'.
			%
			% Alternative forms to call this method are:
			%  LIST = VOI.GETSUBCLASSES() returns all subclasses of the variable of interest VOI.
			%  LIST = Element.GETSUBCLASSES(VOI) returns all subclasses of 'VOI'.
			%  LIST = Element.GETSUBCLASSES('VOI') returns all subclasses of 'VOI'.
			%
			% Note that the Element.GETSUBCLASSES(VOI) and Element.GETSUBCLASSES('VOI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('VOI', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of variable of interest.
			%
			% PROPS = VOI.GETPROPS() returns the property list of variable of interest
			%  as a row vector.
			%
			% PROPS = VOI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = VOI.GETPROPS([CATEGORY]) returns the property list of the variable of interest VOI.
			%  PROPS = Element.GETPROPS(VOI[, CATEGORY]) returns the property list of 'VOI'.
			%  PROPS = Element.GETPROPS('VOI'[, CATEGORY]) returns the property list of 'VOI'.
			%
			% Note that the Element.GETPROPS(VOI) and Element.GETPROPS('VOI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						VOI.V ...
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
						VOI.V ...
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
			%GETPROPNUMBER returns the property number of variable of interest.
			%
			% N = VOI.GETPROPNUMBER() returns the property number of variable of interest.
			%
			% N = VOI.GETPROPNUMBER(CATEGORY) returns the property number of variable of interest
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = VOI.GETPROPNUMBER([CATEGORY]) returns the property number of the variable of interest VOI.
			%  N = Element.GETPROPNUMBER(VOI) returns the property number of 'VOI'.
			%  N = Element.GETPROPNUMBER('VOI') returns the property number of 'VOI'.
			%
			% Note that the Element.GETPROPNUMBER(VOI) and Element.GETPROPNUMBER('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(VOI.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in variable of interest/error.
			%
			% CHECK = VOI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSPROP(PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:VOI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSPROP(PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(VOI) and Element.EXISTSPROP('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == VOI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for VOI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in variable of interest/error.
			%
			% CHECK = VOI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSTAG(TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:VOI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSTAG(TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(VOI) and Element.EXISTSTAG('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			voi_tag_list = cellfun(@(x) VOI.getPropTag(x), num2cell(VOI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, voi_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for VOI.'] ...
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
			%  PROPERTY = VOI.GETPROPPROP(POINTER) returns property number of POINTER of VOI.
			%  PROPERTY = Element.GETPROPPROP(VOI, POINTER) returns property number of POINTER of VOI.
			%  PROPERTY = VOI.GETPROPPROP(VOI, POINTER) returns property number of POINTER of VOI.
			%
			% Note that the Element.GETPROPPROP(VOI) and Element.GETPROPPROP('VOI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				voi_tag_list = cellfun(@(x) VOI.getPropTag(x), num2cell(VOI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, voi_tag_list)); % tag = pointer
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
			%  TAG = VOI.GETPROPTAG(POINTER) returns tag of POINTER of VOI.
			%  TAG = Element.GETPROPTAG(VOI, POINTER) returns tag of POINTER of VOI.
			%  TAG = VOI.GETPROPTAG(VOI, POINTER) returns tag of POINTER of VOI.
			%
			% Note that the Element.GETPROPTAG(VOI) and Element.GETPROPTAG('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case VOI.V
						tag = VOI.V_TAG;
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
			%  CATEGORY = VOI.GETPROPCATEGORY(POINTER) returns category of POINTER of VOI.
			%  CATEGORY = Element.GETPROPCATEGORY(VOI, POINTER) returns category of POINTER of VOI.
			%  CATEGORY = VOI.GETPROPCATEGORY(VOI, POINTER) returns category of POINTER of VOI.
			%
			% Note that the Element.GETPROPCATEGORY(VOI) and Element.GETPROPCATEGORY('VOI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V
					prop_category = VOI.V_CATEGORY;
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
			%  FORMAT = VOI.GETPROPFORMAT(POINTER) returns format of POINTER of VOI.
			%  FORMAT = Element.GETPROPFORMAT(VOI, POINTER) returns format of POINTER of VOI.
			%  FORMAT = VOI.GETPROPFORMAT(VOI, POINTER) returns format of POINTER of VOI.
			%
			% Note that the Element.GETPROPFORMAT(VOI) and Element.GETPROPFORMAT('VOI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V
					prop_format = VOI.V_FORMAT;
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
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of VOI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(VOI, POINTER) returns description of POINTER of VOI.
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(VOI, POINTER) returns description of POINTER of VOI.
			%
			% Note that the Element.GETPROPDESCRIPTION(VOI) and Element.GETPROPDESCRIPTION('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V
					prop_description = 'V (data, scalar) is the value of the variable of interest.';
				case VOI.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the variable of interest.';
				case VOI.NAME
					prop_description = 'NAME (constant, string) is the name of the variable of interest.';
				case VOI.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the variable of interest.';
				case VOI.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the variable of interest.';
				case VOI.ID
					prop_description = 'ID (data, string) is a few-letter code for the variable of interest.';
				case VOI.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the variable of interest.';
				case VOI.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the variable of interest.';
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
			%  SETTINGS = VOI.GETPROPSETTINGS(POINTER) returns settings of POINTER of VOI.
			%  SETTINGS = Element.GETPROPSETTINGS(VOI, POINTER) returns settings of POINTER of VOI.
			%  SETTINGS = VOI.GETPROPSETTINGS(VOI, POINTER) returns settings of POINTER of VOI.
			%
			% Note that the Element.GETPROPSETTINGS(VOI) and Element.GETPROPSETTINGS('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case VOI.TEMPLATE
					prop_settings = 'VOI';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = VOI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = VOI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULT(VOI, POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = VOI.GETPROPDEFAULT(VOI, POINTER) returns the default value of POINTER of VOI.
			%
			% Note that the Element.GETPROPDEFAULT(VOI) and Element.GETPROPDEFAULT('VOI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V
					prop_default = Format.getFormatDefault(Format.SCALAR, VOI.getPropSettings(prop));
				case VOI.ELCLASS
					prop_default = 'VOI';
				case VOI.NAME
					prop_default = 'Variable Of Interest';
				case VOI.DESCRIPTION
					prop_default = 'A Variable Of Interest (VOI) is the base element for a variable of interest. Instances of this class should not be created. Use one of its subclasses instead.';
				case VOI.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, VOI.getPropSettings(prop));
				case VOI.ID
					prop_default = 'VOI ID';
				case VOI.LABEL
					prop_default = 'VOI label';
				case VOI.NOTES
					prop_default = 'VOI notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(VOI, POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(VOI, POINTER) returns the conditioned default value of POINTER of VOI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(VOI) and Element.GETPROPDEFAULTCONDITIONED('VOI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			prop_default = VOI.conditioning(prop, VOI.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = VOI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = VOI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of VOI.
			%  CHECK = Element.CHECKPROP(VOI, PROP, VALUE) checks VALUE format for PROP of VOI.
			%  CHECK = VOI.CHECKPROP(VOI, PROP, VALUE) checks VALUE format for PROP of VOI.
			% 
			% VOI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:VOI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  VOI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: €BRAPH2.STR€:VOI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(VOI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: €BRAPH2.STR€:VOI:€BRAPH2.WRONG_INPUT€
			%  VOI.CHECKPROP(VOI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: €BRAPH2.STR€:VOI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(VOI) and Element.CHECKPROP('VOI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case VOI.V % __VOI.V__
					check = Format.checkFormat(Format.SCALAR, value, VOI.getPropSettings(prop));
				case VOI.TEMPLATE % __VOI.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, VOI.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' VOI.getPropTag(prop) ' (' VOI.getFormatTag(VOI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
