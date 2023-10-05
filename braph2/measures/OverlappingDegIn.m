classdef OverlappingDegIn < DegreeIn
	%OverlappingDegIn is the graph Overlapping In-Degree.
	% It is a subclass of <a href="matlab:help DegreeIn">DegreeIn</a>.
	%
	% The Overlapping In-Degree (OverlappingDegIn) of a graph is the sum of the in-degrees of a node 
	% in all layers.
	%
	% OverlappingDegIn methods (constructor):
	%  OverlappingDegIn - constructor
	%
	% OverlappingDegIn methods:
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
	% OverlappingDegIn methods (display):
	%  tostring - string with information about the overlapping in-degree
	%  disp - displays information about the overlapping in-degree
	%  tree - displays the tree of the overlapping in-degree
	%
	% OverlappingDegIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two overlapping in-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the overlapping in-degree
	%
	% OverlappingDegIn methods (save/load, Static):
	%  save - saves BRAPH2 overlapping in-degree as b2 file
	%  load - loads a BRAPH2 overlapping in-degree from a b2 file
	%
	% OverlappingDegIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the overlapping in-degree
	%
	% OverlappingDegIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the overlapping in-degree
	%
	% OverlappingDegIn methods (inspection, Static):
	%  getClass - returns the class of the overlapping in-degree
	%  getSubclasses - returns all subclasses of OverlappingDegIn
	%  getProps - returns the property list of the overlapping in-degree
	%  getPropNumber - returns the property number of the overlapping in-degree
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
	% OverlappingDegIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingDegIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingDegIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingDegIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingDegIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingDegIn constants</a>.
	%
	
	methods % constructor
		function m = OverlappingDegIn(varargin)
			%OverlappingDegIn() creates a overlapping in-degree.
			%
			% OverlappingDegIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingDegIn(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@DegreeIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the overlapping in-degree.
			%
			% CLASS = OverlappingDegIn.GETCLASS() returns the class 'OverlappingDegIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the overlapping in-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingDegIn') returns 'OverlappingDegIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingDegIn')
			%  are less computationally efficient.
			
			m_class = 'OverlappingDegIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the overlapping in-degree.
			%
			% LIST = OverlappingDegIn.GETSUBCLASSES() returns all subclasses of 'OverlappingDegIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the overlapping in-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingDegIn') returns all subclasses of 'OverlappingDegIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingDegIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of overlapping in-degree.
			%
			% PROPS = OverlappingDegIn.GETPROPS() returns the property list of overlapping in-degree
			%  as a row vector.
			%
			% PROPS = OverlappingDegIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the overlapping in-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingDegIn'[, CATEGORY]) returns the property list of 'OverlappingDegIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					DegreeIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						DegreeIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						DegreeIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						DegreeIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						DegreeIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						DegreeIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						DegreeIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						DegreeIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						DegreeIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						DegreeIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of overlapping in-degree.
			%
			% N = OverlappingDegIn.GETPROPNUMBER() returns the property number of overlapping in-degree.
			%
			% N = OverlappingDegIn.GETPROPNUMBER(CATEGORY) returns the property number of overlapping in-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the overlapping in-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingDegIn') returns the property number of 'OverlappingDegIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingDegIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in overlapping in-degree/error.
			%
			% CHECK = OverlappingDegIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingDegIn, PROP) checks whether PROP exists for OverlappingDegIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%  Element.EXISTSPROP(OverlappingDegIn, PROP) throws error if PROP does NOT exist for OverlappingDegIn.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingDegIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingDegIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in overlapping in-degree/error.
			%
			% CHECK = OverlappingDegIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingDegIn, TAG) checks whether TAG exists for OverlappingDegIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%  Element.EXISTSTAG(OverlappingDegIn, TAG) throws error if TAG does NOT exist for OverlappingDegIn.
			%   Error id: [BRAPH2:OverlappingDegIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingdegin_tag_list = cellfun(@(x) OverlappingDegIn.getPropTag(x), num2cell(OverlappingDegIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingdegin_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingDegIn.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(OverlappingDegIn, POINTER) returns property number of POINTER of OverlappingDegIn.
			%  PROPERTY = M.GETPROPPROP(OverlappingDegIn, POINTER) returns property number of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingdegin_tag_list = cellfun(@(x) OverlappingDegIn.getPropTag(x), num2cell(OverlappingDegIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingdegin_tag_list)); % tag = pointer
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(OverlappingDegIn, POINTER) returns tag of POINTER of OverlappingDegIn.
			%  TAG = M.GETPROPTAG(OverlappingDegIn, POINTER) returns tag of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@DegreeIn(prop);
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingDegIn, POINTER) returns category of POINTER of OverlappingDegIn.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingDegIn, POINTER) returns category of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@DegreeIn(prop);
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(OverlappingDegIn, POINTER) returns format of POINTER of OverlappingDegIn.
			%  FORMAT = M.GETPROPFORMAT(OverlappingDegIn, POINTER) returns format of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@DegreeIn(prop);
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingDegIn, POINTER) returns description of POINTER of OverlappingDegIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingDegIn, POINTER) returns description of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				case OverlappingDegIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Overlapping In-Degree.';
				case OverlappingDegIn.NAME
					prop_description = 'NAME (constant, string) is the name of the Overlapping In-Degree.';
				case OverlappingDegIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Overlapping In-Degree.';
				case OverlappingDegIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Overlapping In-Degree.';
				case OverlappingDegIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the Overlapping In-Degree.';
				case OverlappingDegIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Overlapping In-Degree.';
				case OverlappingDegIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Overlapping In-Degree.';
				case OverlappingDegIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingDegIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingDegIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingDegIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingDegIn.M
					prop_description = 'M (result, cell) is the Overlapping In-Degree.';
				otherwise
					prop_description = getPropDescription@DegreeIn(prop);
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingDegIn, POINTER) returns settings of POINTER of OverlappingDegIn.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingDegIn, POINTER) returns settings of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				case OverlappingDegIn.TEMPLATE
					prop_settings = 'OverlappingDegIn';
				otherwise
					prop_settings = getPropSettings@DegreeIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingDegIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingDegIn, POINTER) returns the default value of POINTER of OverlappingDegIn.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingDegIn, POINTER) returns the default value of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				case OverlappingDegIn.ELCLASS
					prop_default = 'OverlappingDegIn';
				case OverlappingDegIn.NAME
					prop_default = 'Overlapping In-Degree';
				case OverlappingDegIn.DESCRIPTION
					prop_default = 'The Overlapping In-Degree (OverlappingDegIn) of a graph is the sum of the in-degrees of a node in all layers.';
				case OverlappingDegIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingDegIn.getPropSettings(prop));
				case OverlappingDegIn.ID
					prop_default = 'OverlappingDegIn ID';
				case OverlappingDegIn.LABEL
					prop_default = 'Overlapping In-Degree label';
				case OverlappingDegIn.NOTES
					prop_default = 'Overlapping In-Degree notes';
				case OverlappingDegIn.SHAPE
					prop_default = Measure.NODAL;
				case OverlappingDegIn.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingDegIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingDegIn.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@DegreeIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingDegIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingDegIn, POINTER) returns the conditioned default value of POINTER of OverlappingDegIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingDegIn, POINTER) returns the conditioned default value of POINTER of OverlappingDegIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			prop_default = OverlappingDegIn.conditioning(prop, OverlappingDegIn.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(OverlappingDegIn, PROP, VALUE) checks VALUE format for PROP of OverlappingDegIn.
			%  CHECK = M.CHECKPROP(OverlappingDegIn, PROP, VALUE) checks VALUE format for PROP of OverlappingDegIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingDegIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingDegIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingDegIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegIn.
			%   Error id: €BRAPH2.STR€:OverlappingDegIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingDegIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegIn.
			%   Error id: €BRAPH2.STR€:OverlappingDegIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingDegIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingDegIn.getPropProp(pointer);
			
			switch prop
				case OverlappingDegIn.TEMPLATE % __OverlappingDegIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingDegIn.getPropSettings(prop));
				otherwise
					if prop <= DegreeIn.getPropNumber()
						check = checkProp@DegreeIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingDegIn.getPropTag(prop) ' (' OverlappingDegIn.getFormatTag(OverlappingDegIn.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case OverlappingDegIn.M % __OverlappingDegIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingDegIn.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    in_degree = calculateValue@DegreeIn(m, prop);
					    overlapping_in_degree = zeros(N(1), 1);
					
					    for li = 1:l
					        overlapping_in_degree = overlapping_in_degree + in_degree{li};
					    end
					    value = {overlapping_in_degree};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= DegreeIn.getPropNumber()
						value = calculateValue@DegreeIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
