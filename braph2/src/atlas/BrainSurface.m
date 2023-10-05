classdef BrainSurface < ConcreteElement
	%BrainSurface is a brain surface.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Brain Surface (BrainSurface) contains the information of a brain surface.
	%  It provides the methods necessary to handle the brain surface data.
	% BrainSurface contains and manages the vertex_number, coordinates, 
	%  triangles_number, and triangles of a brain surface.
	%
	% BrainSurface methods (constructor):
	%  BrainSurface - constructor
	%
	% BrainSurface methods:
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
	% BrainSurface methods (display):
	%  tostring - string with information about the brain surface
	%  disp - displays information about the brain surface
	%  tree - displays the tree of the brain surface
	%
	% BrainSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain surface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain surface
	%
	% BrainSurface methods (save/load, Static):
	%  save - saves BRAPH2 brain surface as b2 file
	%  load - loads a BRAPH2 brain surface from a b2 file
	%
	% BrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain surface
	%
	% BrainSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain surface
	%
	% BrainSurface methods (inspection, Static):
	%  getClass - returns the class of the brain surface
	%  getSubclasses - returns all subclasses of BrainSurface
	%  getProps - returns the property list of the brain surface
	%  getPropNumber - returns the property number of the brain surface
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
	% BrainSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainSurface constants</a>.
	%
	%
	% See also BrainAtlas, BrainRegion, BrainSurfacePF.
	
	properties (Constant) % properties
		VERTEX_NUMBER = ConcreteElement.getPropNumber() + 1;
		VERTEX_NUMBER_TAG = 'VERTEX_NUMBER';
		VERTEX_NUMBER_CATEGORY = Category.DATA;
		VERTEX_NUMBER_FORMAT = Format.SCALAR;
		
		COORDINATES = ConcreteElement.getPropNumber() + 2;
		COORDINATES_TAG = 'COORDINATES';
		COORDINATES_CATEGORY = Category.DATA;
		COORDINATES_FORMAT = Format.MATRIX;
		
		TRIANGLES_NUMBER = ConcreteElement.getPropNumber() + 3;
		TRIANGLES_NUMBER_TAG = 'TRIANGLES_NUMBER';
		TRIANGLES_NUMBER_CATEGORY = Category.DATA;
		TRIANGLES_NUMBER_FORMAT = Format.SCALAR;
		
		TRIANGLES = ConcreteElement.getPropNumber() + 4;
		TRIANGLES_TAG = 'TRIANGLES';
		TRIANGLES_CATEGORY = Category.DATA;
		TRIANGLES_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function bs = BrainSurface(varargin)
			%BrainSurface() creates a brain surface.
			%
			% BrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainSurface(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			bs = bs@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function bs_class = getClass()
			%GETCLASS returns the class of the brain surface.
			%
			% CLASS = BrainSurface.GETCLASS() returns the class 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BS.GETCLASS() returns the class of the brain surface BS.
			%  CLASS = Element.GETCLASS(BS) returns the class of 'BS'.
			%  CLASS = Element.GETCLASS('BrainSurface') returns 'BrainSurface'.
			%
			% Note that the Element.GETCLASS(BS) and Element.GETCLASS('BrainSurface')
			%  are less computationally efficient.
			
			bs_class = 'BrainSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain surface.
			%
			% LIST = BrainSurface.GETSUBCLASSES() returns all subclasses of 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = BS.GETSUBCLASSES() returns all subclasses of the brain surface BS.
			%  LIST = Element.GETSUBCLASSES(BS) returns all subclasses of 'BS'.
			%  LIST = Element.GETSUBCLASSES('BrainSurface') returns all subclasses of 'BrainSurface'.
			%
			% Note that the Element.GETSUBCLASSES(BS) and Element.GETSUBCLASSES('BrainSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('BrainSurface', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain surface.
			%
			% PROPS = BrainSurface.GETPROPS() returns the property list of brain surface
			%  as a row vector.
			%
			% PROPS = BrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BS.GETPROPS([CATEGORY]) returns the property list of the brain surface BS.
			%  PROPS = Element.GETPROPS(BS[, CATEGORY]) returns the property list of 'BS'.
			%  PROPS = Element.GETPROPS('BrainSurface'[, CATEGORY]) returns the property list of 'BrainSurface'.
			%
			% Note that the Element.GETPROPS(BS) and Element.GETPROPS('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						BrainSurface.VERTEX_NUMBER ...
						BrainSurface.COORDINATES ...
						BrainSurface.TRIANGLES_NUMBER ...
						BrainSurface.TRIANGLES ...
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
						BrainSurface.VERTEX_NUMBER ...
						BrainSurface.COORDINATES ...
						BrainSurface.TRIANGLES_NUMBER ...
						BrainSurface.TRIANGLES ...
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
			%GETPROPNUMBER returns the property number of brain surface.
			%
			% N = BrainSurface.GETPROPNUMBER() returns the property number of brain surface.
			%
			% N = BrainSurface.GETPROPNUMBER(CATEGORY) returns the property number of brain surface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BS.GETPROPNUMBER([CATEGORY]) returns the property number of the brain surface BS.
			%  N = Element.GETPROPNUMBER(BS) returns the property number of 'BS'.
			%  N = Element.GETPROPNUMBER('BrainSurface') returns the property number of 'BrainSurface'.
			%
			% Note that the Element.GETPROPNUMBER(BS) and Element.GETPROPNUMBER('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(BrainSurface.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSPROP(PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BS, PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BrainSurface, PROP) checks whether PROP exists for BrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSPROP(PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BS, PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BrainSurface, PROP) throws error if PROP does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BS) and Element.EXISTSPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == BrainSurface.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSTAG(TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BS, TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BrainSurface, TAG) checks whether TAG exists for BrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSTAG(TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BS, TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BrainSurface, TAG) throws error if TAG does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BS) and Element.EXISTSTAG('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			brainsurface_tag_list = cellfun(@(x) BrainSurface.getPropTag(x), num2cell(BrainSurface.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, brainsurface_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for BrainSurface.'] ...
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
			%  PROPERTY = BS.GETPROPPROP(POINTER) returns property number of POINTER of BS.
			%  PROPERTY = Element.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%  PROPERTY = BS.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPPROP(BS) and Element.GETPROPPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				brainsurface_tag_list = cellfun(@(x) BrainSurface.getPropTag(x), num2cell(BrainSurface.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, brainsurface_tag_list)); % tag = pointer
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
			%  TAG = BS.GETPROPTAG(POINTER) returns tag of POINTER of BS.
			%  TAG = Element.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%  TAG = BS.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPTAG(BS) and Element.GETPROPTAG('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case BrainSurface.VERTEX_NUMBER
						tag = BrainSurface.VERTEX_NUMBER_TAG;
					case BrainSurface.COORDINATES
						tag = BrainSurface.COORDINATES_TAG;
					case BrainSurface.TRIANGLES_NUMBER
						tag = BrainSurface.TRIANGLES_NUMBER_TAG;
					case BrainSurface.TRIANGLES
						tag = BrainSurface.TRIANGLES_TAG;
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
			%  CATEGORY = BS.GETPROPCATEGORY(POINTER) returns category of POINTER of BS.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%  CATEGORY = BS.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPCATEGORY(BS) and Element.GETPROPCATEGORY('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER
					prop_category = BrainSurface.VERTEX_NUMBER_CATEGORY;
				case BrainSurface.COORDINATES
					prop_category = BrainSurface.COORDINATES_CATEGORY;
				case BrainSurface.TRIANGLES_NUMBER
					prop_category = BrainSurface.TRIANGLES_NUMBER_CATEGORY;
				case BrainSurface.TRIANGLES
					prop_category = BrainSurface.TRIANGLES_CATEGORY;
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
			%  FORMAT = BS.GETPROPFORMAT(POINTER) returns format of POINTER of BS.
			%  FORMAT = Element.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%  FORMAT = BS.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPFORMAT(BS) and Element.GETPROPFORMAT('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER
					prop_format = BrainSurface.VERTEX_NUMBER_FORMAT;
				case BrainSurface.COORDINATES
					prop_format = BrainSurface.COORDINATES_FORMAT;
				case BrainSurface.TRIANGLES_NUMBER
					prop_format = BrainSurface.TRIANGLES_NUMBER_FORMAT;
				case BrainSurface.TRIANGLES
					prop_format = BrainSurface.TRIANGLES_FORMAT;
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
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(BS) and Element.GETPROPDESCRIPTION('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER
					prop_description = 'VERTEX_NUMBER (data, scalar) is the number of triangle vertices.';
				case BrainSurface.COORDINATES
					prop_description = 'COORDINATES (data, matrix) are the coordinates of the triangle vertices.';
				case BrainSurface.TRIANGLES_NUMBER
					prop_description = 'TRIANGLES_NUMBER (data, scalar) is the number of triangles.';
				case BrainSurface.TRIANGLES
					prop_description = 'TRIANGLES (data, matrix) are the triads of coordinates of the triangles.';
				case BrainSurface.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the brain surface.';
				case BrainSurface.NAME
					prop_description = 'NAME (constant, string) is the name of the brain surface.';
				case BrainSurface.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the brain surface.';
				case BrainSurface.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the brain surface.';
				case BrainSurface.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain surface.';
				case BrainSurface.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain surface.';
				case BrainSurface.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain surface.';
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
			%  SETTINGS = BS.GETPROPSETTINGS(POINTER) returns settings of POINTER of BS.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%  SETTINGS = BS.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPSETTINGS(BS) and Element.GETPROPSETTINGS('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainSurface.COORDINATES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case BrainSurface.TRIANGLES_NUMBER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainSurface.TRIANGLES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case BrainSurface.TEMPLATE
					prop_settings = 'BrainSurface';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDEFAULT(BS) and Element.GETPROPDEFAULT('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainSurface.getPropSettings(prop));
				case BrainSurface.COORDINATES
					prop_default = Format.getFormatDefault(Format.MATRIX, BrainSurface.getPropSettings(prop));
				case BrainSurface.TRIANGLES_NUMBER
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainSurface.getPropSettings(prop));
				case BrainSurface.TRIANGLES
					prop_default = Format.getFormatDefault(Format.MATRIX, BrainSurface.getPropSettings(prop));
				case BrainSurface.ELCLASS
					prop_default = 'BrainSurface';
				case BrainSurface.NAME
					prop_default = 'Brain Surface';
				case BrainSurface.DESCRIPTION
					prop_default = 'A Brain Surface (BrainSurface) contains the information of a brain surface. It provides the methods necessary to handle the brain surface data. BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and triangles of a brain surface.';
				case BrainSurface.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, BrainSurface.getPropSettings(prop));
				case BrainSurface.ID
					prop_default = 'BrainSurface ID';
				case BrainSurface.LABEL
					prop_default = 'BrainSurface label';
				case BrainSurface.NOTES
					prop_default = 'BrainSurface notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BS) and Element.GETPROPDEFAULTCONDITIONED('BrainSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			prop_default = BrainSurface.conditioning(prop, BrainSurface.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BS.
			%  CHECK = Element.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			%  CHECK = BS.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			% 
			% BS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:BrainSurface:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BS.
			%   Error id: €BRAPH2.STR€:BrainSurface:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: €BRAPH2.STR€:BrainSurface:€BRAPH2.WRONG_INPUT€
			%  BS.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: €BRAPH2.STR€:BrainSurface:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(BS) and Element.CHECKPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.VERTEX_NUMBER % __BrainSurface.VERTEX_NUMBER__
					check = Format.checkFormat(Format.SCALAR, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case BrainSurface.COORDINATES % __BrainSurface.COORDINATES__
					check = Format.checkFormat(Format.MATRIX, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
				case BrainSurface.TRIANGLES_NUMBER % __BrainSurface.TRIANGLES_NUMBER__
					check = Format.checkFormat(Format.SCALAR, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case BrainSurface.TRIANGLES % __BrainSurface.TRIANGLES__
					check = Format.checkFormat(Format.MATRIX, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
				case BrainSurface.TEMPLATE % __BrainSurface.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, BrainSurface.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainSurface.getPropTag(prop) ' (' BrainSurface.getFormatTag(BrainSurface.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(bs, prop, value)
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
			msg = ['Error while checking ' tostring(bs) ' ' bs.getPropTag(prop) '.'];
			
			switch prop
				case BrainSurface.COORDINATES % __BrainSurface.COORDINATES__
					check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1));
					if check 
					    msg = 'All ok!';
					else
					    msg = ['COORDINATES must have VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') columns while it has ' num2str(size(value, 2)) '.'];
					end
					
				case BrainSurface.TRIANGLES % __BrainSurface.TRIANGLES__
					check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && all(all(value > 0)) && all(all(value <= bs.get('VERTEX_NUMBER')));
					if check 
					    msg = 'All ok!';
					else
					    msg = [ ...
					        'TRIANGLES must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' columns while it has ' num2str(size(value, 1)) '.' ...
					        'The identifiers in TRIANGLES must be greater than 0 and smaller or equal to the VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
					        'while they are ' num2str(value) '.' ...
					        ];
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(bs, prop, value);
					end
			end
		end
	end
end
