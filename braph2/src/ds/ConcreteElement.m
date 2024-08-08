classdef ConcreteElement < Element
	%ConcreteElement is the base class for all concrete elements.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% A Concrete Element (ConcreteElement) provides the infrastructure necessary 
	%  for all concrete elements. In particular, it has the constant properties 
	%  ELCLASS (string), NAME (string) and DESCRIPTION (string), the property 
	%  TEMPLATE (item), the indexing properties ID (string), LABEL (string), 
	%  and NOTES (string), and the query prop TOSTRING (string).
	% Even though it is possible to create instances of ConcreteElement, 
	%  typically one uses its subclasses.
	%
	% ConcreteElement methods (constructor):
	%  ConcreteElement - constructor
	%
	% ConcreteElement methods:
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
	% ConcreteElement methods (display):
	%  tostring - string with information about the concrete element
	%  disp - displays information about the concrete element
	%  tree - displays the tree of the concrete element
	%
	% ConcreteElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two concrete element are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the concrete element
	%
	% ConcreteElement methods (save/load, Static):
	%  save - saves BRAPH2 concrete element as b2 file
	%  load - loads a BRAPH2 concrete element from a b2 file
	%
	% ConcreteElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the concrete element
	%
	% ConcreteElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the concrete element
	%
	% ConcreteElement methods (inspection, Static):
	%  getClass - returns the class of the concrete element
	%  getSubclasses - returns all subclasses of ConcreteElement
	%  getProps - returns the property list of the concrete element
	%  getPropNumber - returns the property number of the concrete element
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
	% ConcreteElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConcreteElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConcreteElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConcreteElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConcreteElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConcreteElement constants</a>.
	%
	%
	% See also NoValue, Callback.
	
	properties (Constant) % properties
		ELCLASS = Element.getPropNumber() + 1;
		ELCLASS_TAG = 'ELCLASS';
		ELCLASS_CATEGORY = Category.CONSTANT;
		ELCLASS_FORMAT = Format.STRING;
		
		NAME = Element.getPropNumber() + 2;
		NAME_TAG = 'NAME';
		NAME_CATEGORY = Category.CONSTANT;
		NAME_FORMAT = Format.STRING;
		
		DESCRIPTION = Element.getPropNumber() + 3;
		DESCRIPTION_TAG = 'DESCRIPTION';
		DESCRIPTION_CATEGORY = Category.CONSTANT;
		DESCRIPTION_FORMAT = Format.STRING;
		
		TEMPLATE = Element.getPropNumber() + 4;
		TEMPLATE_TAG = 'TEMPLATE';
		TEMPLATE_CATEGORY = Category.PARAMETER;
		TEMPLATE_FORMAT = Format.ITEM;
		
		ID = Element.getPropNumber() + 5;
		ID_TAG = 'ID';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = Element.getPropNumber() + 6;
		LABEL_TAG = 'LABEL';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = Element.getPropNumber() + 7;
		NOTES_TAG = 'NOTES';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		TOSTRING = Element.getPropNumber() + 8;
		TOSTRING_TAG = 'TOSTRING';
		TOSTRING_CATEGORY = Category.QUERY;
		TOSTRING_FORMAT = Format.STRING;
	end
	methods % constructor
		function el = ConcreteElement(varargin)
			%ConcreteElement() creates a concrete element.
			%
			% ConcreteElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConcreteElement(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			el = el@Element(varargin{:});
		end
	end
	methods (Static) % inspection
		function el_class = getClass()
			%GETCLASS returns the class of the concrete element.
			%
			% CLASS = ConcreteElement.GETCLASS() returns the class 'ConcreteElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EL.GETCLASS() returns the class of the concrete element EL.
			%  CLASS = Element.GETCLASS(EL) returns the class of 'EL'.
			%  CLASS = Element.GETCLASS('ConcreteElement') returns 'ConcreteElement'.
			%
			% Note that the Element.GETCLASS(EL) and Element.GETCLASS('ConcreteElement')
			%  are less computationally efficient.
			
			el_class = 'ConcreteElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the concrete element.
			%
			% LIST = ConcreteElement.GETSUBCLASSES() returns all subclasses of 'ConcreteElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = EL.GETSUBCLASSES() returns all subclasses of the concrete element EL.
			%  LIST = Element.GETSUBCLASSES(EL) returns all subclasses of 'EL'.
			%  LIST = Element.GETSUBCLASSES('ConcreteElement') returns all subclasses of 'ConcreteElement'.
			%
			% Note that the Element.GETSUBCLASSES(EL) and Element.GETSUBCLASSES('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ConcreteElement', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of concrete element.
			%
			% PROPS = ConcreteElement.GETPROPS() returns the property list of concrete element
			%  as a row vector.
			%
			% PROPS = ConcreteElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EL.GETPROPS([CATEGORY]) returns the property list of the concrete element EL.
			%  PROPS = Element.GETPROPS(EL[, CATEGORY]) returns the property list of 'EL'.
			%  PROPS = Element.GETPROPS('ConcreteElement'[, CATEGORY]) returns the property list of 'ConcreteElement'.
			%
			% Note that the Element.GETPROPS(EL) and Element.GETPROPS('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Element.getProps() ...
						ConcreteElement.ELCLASS ...
						ConcreteElement.NAME ...
						ConcreteElement.DESCRIPTION ...
						ConcreteElement.TEMPLATE ...
						ConcreteElement.ID ...
						ConcreteElement.LABEL ...
						ConcreteElement.NOTES ...
						ConcreteElement.TOSTRING ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Element.getProps(Category.CONSTANT) ...
						ConcreteElement.ELCLASS ...
						ConcreteElement.NAME ...
						ConcreteElement.DESCRIPTION ...
						];
				case Category.METADATA
					prop_list = [ ...
						Element.getProps(Category.METADATA) ...
						ConcreteElement.LABEL ...
						ConcreteElement.NOTES ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Element.getProps(Category.PARAMETER) ...
						ConcreteElement.TEMPLATE ...
						];
				case Category.DATA
					prop_list = [ ...
						Element.getProps(Category.DATA) ...
						ConcreteElement.ID ...
						];
				case Category.RESULT
					prop_list = [
						Element.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Element.getProps(Category.QUERY) ...
						ConcreteElement.TOSTRING ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Element.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Element.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Element.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of concrete element.
			%
			% N = ConcreteElement.GETPROPNUMBER() returns the property number of concrete element.
			%
			% N = ConcreteElement.GETPROPNUMBER(CATEGORY) returns the property number of concrete element
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EL.GETPROPNUMBER([CATEGORY]) returns the property number of the concrete element EL.
			%  N = Element.GETPROPNUMBER(EL) returns the property number of 'EL'.
			%  N = Element.GETPROPNUMBER('ConcreteElement') returns the property number of 'ConcreteElement'.
			%
			% Note that the Element.GETPROPNUMBER(EL) and Element.GETPROPNUMBER('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ConcreteElement.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in concrete element/error.
			%
			% CHECK = ConcreteElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EL.EXISTSPROP(PROP) checks whether PROP exists for EL.
			%  CHECK = Element.EXISTSPROP(EL, PROP) checks whether PROP exists for EL.
			%  CHECK = Element.EXISTSPROP(ConcreteElement, PROP) checks whether PROP exists for ConcreteElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EL.EXISTSPROP(PROP) throws error if PROP does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSPROP(EL, PROP) throws error if PROP does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSPROP(ConcreteElement, PROP) throws error if PROP does NOT exist for ConcreteElement.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EL) and Element.EXISTSPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ConcreteElement.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConcreteElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in concrete element/error.
			%
			% CHECK = ConcreteElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EL.EXISTSTAG(TAG) checks whether TAG exists for EL.
			%  CHECK = Element.EXISTSTAG(EL, TAG) checks whether TAG exists for EL.
			%  CHECK = Element.EXISTSTAG(ConcreteElement, TAG) checks whether TAG exists for ConcreteElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EL.EXISTSTAG(TAG) throws error if TAG does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSTAG(EL, TAG) throws error if TAG does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSTAG(ConcreteElement, TAG) throws error if TAG does NOT exist for ConcreteElement.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EL) and Element.EXISTSTAG('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			concreteelement_tag_list = cellfun(@(x) ConcreteElement.getPropTag(x), num2cell(ConcreteElement.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, concreteelement_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ConcreteElement.'] ...
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
			%  PROPERTY = EL.GETPROPPROP(POINTER) returns property number of POINTER of EL.
			%  PROPERTY = Element.GETPROPPROP(ConcreteElement, POINTER) returns property number of POINTER of ConcreteElement.
			%  PROPERTY = EL.GETPROPPROP(ConcreteElement, POINTER) returns property number of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPPROP(EL) and Element.GETPROPPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				concreteelement_tag_list = cellfun(@(x) ConcreteElement.getPropTag(x), num2cell(ConcreteElement.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, concreteelement_tag_list)); % tag = pointer
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
			%  TAG = EL.GETPROPTAG(POINTER) returns tag of POINTER of EL.
			%  TAG = Element.GETPROPTAG(ConcreteElement, POINTER) returns tag of POINTER of ConcreteElement.
			%  TAG = EL.GETPROPTAG(ConcreteElement, POINTER) returns tag of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPTAG(EL) and Element.GETPROPTAG('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ConcreteElement.ELCLASS
						tag = ConcreteElement.ELCLASS_TAG;
					case ConcreteElement.NAME
						tag = ConcreteElement.NAME_TAG;
					case ConcreteElement.DESCRIPTION
						tag = ConcreteElement.DESCRIPTION_TAG;
					case ConcreteElement.TEMPLATE
						tag = ConcreteElement.TEMPLATE_TAG;
					case ConcreteElement.ID
						tag = ConcreteElement.ID_TAG;
					case ConcreteElement.LABEL
						tag = ConcreteElement.LABEL_TAG;
					case ConcreteElement.NOTES
						tag = ConcreteElement.NOTES_TAG;
					case ConcreteElement.TOSTRING
						tag = ConcreteElement.TOSTRING_TAG;
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
			%  CATEGORY = EL.GETPROPCATEGORY(POINTER) returns category of POINTER of EL.
			%  CATEGORY = Element.GETPROPCATEGORY(ConcreteElement, POINTER) returns category of POINTER of ConcreteElement.
			%  CATEGORY = EL.GETPROPCATEGORY(ConcreteElement, POINTER) returns category of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPCATEGORY(EL) and Element.GETPROPCATEGORY('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS
					prop_category = ConcreteElement.ELCLASS_CATEGORY;
				case ConcreteElement.NAME
					prop_category = ConcreteElement.NAME_CATEGORY;
				case ConcreteElement.DESCRIPTION
					prop_category = ConcreteElement.DESCRIPTION_CATEGORY;
				case ConcreteElement.TEMPLATE
					prop_category = ConcreteElement.TEMPLATE_CATEGORY;
				case ConcreteElement.ID
					prop_category = ConcreteElement.ID_CATEGORY;
				case ConcreteElement.LABEL
					prop_category = ConcreteElement.LABEL_CATEGORY;
				case ConcreteElement.NOTES
					prop_category = ConcreteElement.NOTES_CATEGORY;
				case ConcreteElement.TOSTRING
					prop_category = ConcreteElement.TOSTRING_CATEGORY;
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
			%  FORMAT = EL.GETPROPFORMAT(POINTER) returns format of POINTER of EL.
			%  FORMAT = Element.GETPROPFORMAT(ConcreteElement, POINTER) returns format of POINTER of ConcreteElement.
			%  FORMAT = EL.GETPROPFORMAT(ConcreteElement, POINTER) returns format of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPFORMAT(EL) and Element.GETPROPFORMAT('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS
					prop_format = ConcreteElement.ELCLASS_FORMAT;
				case ConcreteElement.NAME
					prop_format = ConcreteElement.NAME_FORMAT;
				case ConcreteElement.DESCRIPTION
					prop_format = ConcreteElement.DESCRIPTION_FORMAT;
				case ConcreteElement.TEMPLATE
					prop_format = ConcreteElement.TEMPLATE_FORMAT;
				case ConcreteElement.ID
					prop_format = ConcreteElement.ID_FORMAT;
				case ConcreteElement.LABEL
					prop_format = ConcreteElement.LABEL_FORMAT;
				case ConcreteElement.NOTES
					prop_format = ConcreteElement.NOTES_FORMAT;
				case ConcreteElement.TOSTRING
					prop_format = ConcreteElement.TOSTRING_FORMAT;
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
			%  DESCRIPTION = EL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConcreteElement, POINTER) returns description of POINTER of ConcreteElement.
			%  DESCRIPTION = EL.GETPROPDESCRIPTION(ConcreteElement, POINTER) returns description of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(EL) and Element.GETPROPDESCRIPTION('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).';
				case ConcreteElement.NAME
					prop_description = 'NAME (constant, string) is the name of the concrete element.';
				case ConcreteElement.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the concrete element.';
				case ConcreteElement.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the concrete element.';
				case ConcreteElement.ID
					prop_description = 'ID (data, string) is a few-letter code for the concrete element.';
				case ConcreteElement.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the concrete element.';
				case ConcreteElement.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the concrete element.';
				case ConcreteElement.TOSTRING
					prop_description = 'TOSTRING (query, string) returns a string that represents the concrete element.';
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
			%  SETTINGS = EL.GETPROPSETTINGS(POINTER) returns settings of POINTER of EL.
			%  SETTINGS = Element.GETPROPSETTINGS(ConcreteElement, POINTER) returns settings of POINTER of ConcreteElement.
			%  SETTINGS = EL.GETPROPSETTINGS(ConcreteElement, POINTER) returns settings of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPSETTINGS(EL) and Element.GETPROPSETTINGS('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.NAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.DESCRIPTION
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.TEMPLATE
					prop_settings = 'ConcreteElement';
				case ConcreteElement.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ConcreteElement.TOSTRING
					prop_settings = Format.getFormatSettings(Format.STRING);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EL.
			%  DEFAULT = Element.GETPROPDEFAULT(ConcreteElement, POINTER) returns the default value of POINTER of ConcreteElement.
			%  DEFAULT = EL.GETPROPDEFAULT(ConcreteElement, POINTER) returns the default value of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDEFAULT(EL) and Element.GETPROPDEFAULT('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS
					prop_default = 'ConcreteElement';
				case ConcreteElement.NAME
					prop_default = 'Concrete Element';
				case ConcreteElement.DESCRIPTION
					prop_default = 'A Concrete Element (ConcreteElement) provides the infrastructure necessary for all concrete elements. In particular, it has the constant properties NAME (string) and DESCRIPTION (string), the property TEMPLATE (item), and the indexing properties ID (string), LABEL (string), and NOTES (string). Even though it is possible to create instances of ConcreteElement, typically one uses its subclasses.';
				case ConcreteElement.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.ID
					prop_default = 'ConcreteElement ID';
				case ConcreteElement.LABEL
					prop_default = 'ConcreteElement label';
				case ConcreteElement.NOTES
					prop_default = 'ConcreteElement notes';
				case ConcreteElement.TOSTRING
					prop_default = Format.getFormatDefault(Format.STRING, ConcreteElement.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConcreteElement, POINTER) returns the conditioned default value of POINTER of ConcreteElement.
			%  DEFAULT = EL.GETPROPDEFAULTCONDITIONED(ConcreteElement, POINTER) returns the conditioned default value of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EL) and Element.GETPROPDEFAULTCONDITIONED('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			prop_default = ConcreteElement.conditioning(prop, ConcreteElement.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(~, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
		end
	end
	methods (Access=protected) % preset
		function value = preset(el, prop, value)
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
				case ConcreteElement.TEMPLATE % __ConcreteElement.TEMPLATE__
					if ~isa(el, class(value))
					    error( ...
					        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT '\n' ...
					        'The element (' class(el) ') must be a template (' class(value) ').'] ...
					        )
					end
					
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EL.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EL.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EL.
			%  CHECK = Element.CHECKPROP(ConcreteElement, PROP, VALUE) checks VALUE format for PROP of ConcreteElement.
			%  CHECK = EL.CHECKPROP(ConcreteElement, PROP, VALUE) checks VALUE format for PROP of ConcreteElement.
			% 
			% EL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ConcreteElement:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EL.
			%   Error id: €BRAPH2.STR€:ConcreteElement:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ConcreteElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConcreteElement.
			%   Error id: €BRAPH2.STR€:ConcreteElement:€BRAPH2.WRONG_INPUT€
			%  EL.CHECKPROP(ConcreteElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConcreteElement.
			%   Error id: €BRAPH2.STR€:ConcreteElement:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EL) and Element.CHECKPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case ConcreteElement.ELCLASS % __ConcreteElement.ELCLASS__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.NAME % __ConcreteElement.NAME__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.DESCRIPTION % __ConcreteElement.DESCRIPTION__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.TEMPLATE % __ConcreteElement.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.ID % __ConcreteElement.ID__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.LABEL % __ConcreteElement.LABEL__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.NOTES % __ConcreteElement.NOTES__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
				case ConcreteElement.TOSTRING % __ConcreteElement.TOSTRING__
					check = Format.checkFormat(Format.STRING, value, ConcreteElement.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ConcreteElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConcreteElement.getPropTag(prop) ' (' ConcreteElement.getFormatTag(ConcreteElement.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(el, prop)
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
				case ConcreteElement.TEMPLATE % __ConcreteElement.TEMPLATE__
					template = el.get('TEMPLATE');
					
					parameter_props = template.getProps(Category.PARAMETER);
					parameter_props = parameter_props(parameter_props ~= template.TEMPLATE);
					
					varargin = cell(1, 2 * length(parameter_props));
					for i = 1:1:length(parameter_props)
					    parameter_prop = parameter_props(i);
					    varargin{2 * i - 1} = parameter_prop;
					    varargin{2 * i} = template.getCallback(parameter_prop);    
					end
					
					warning_backup = warning('off', [BRAPH2.STR ':' class(el)]);
					el.set(varargin{:});
					warning(warning_backup)
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(el, prop, varargin)
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
				case ConcreteElement.TOSTRING % __ConcreteElement.TOSTRING__
					value = el.tostring();
					
				otherwise
					if prop <= Element.getPropNumber()
						value = calculateValue@Element(el, prop, varargin{:});
					else
						value = calculateValue@Element(el, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(el, prop, varargin)
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
				case ConcreteElement.NOTES % __ConcreteElement.NOTES__
					pr = PanelPropStringTextArea('EL', el, 'PROP', ConcreteElement.NOTES, varargin{:});
					
				otherwise
					pr = getPanelProp@Element(el, prop, varargin{:});
					
			end
		end
	end
end
