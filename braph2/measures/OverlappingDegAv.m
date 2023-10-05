classdef OverlappingDegAv < OverlappingDeg
	%OverlappingDegAv is the graph Average Overlapping Degree.
	% It is a subclass of <a href="matlab:help OverlappingDeg">OverlappingDeg</a>.
	%
	% The Average Overlapping Degree (OverlappingDegAv) of a graph is the average of the sum of the 
	% degrees of a node in all layers.
	%
	% OverlappingDegAv methods (constructor):
	%  OverlappingDegAv - constructor
	%
	% OverlappingDegAv methods:
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
	% OverlappingDegAv methods (display):
	%  tostring - string with information about the average overlapping-degree
	%  disp - displays information about the average overlapping-degree
	%  tree - displays the tree of the average overlapping-degree
	%
	% OverlappingDegAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average overlapping-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average overlapping-degree
	%
	% OverlappingDegAv methods (save/load, Static):
	%  save - saves BRAPH2 average overlapping-degree as b2 file
	%  load - loads a BRAPH2 average overlapping-degree from a b2 file
	%
	% OverlappingDegAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average overlapping-degree
	%
	% OverlappingDegAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average overlapping-degree
	%
	% OverlappingDegAv methods (inspection, Static):
	%  getClass - returns the class of the average overlapping-degree
	%  getSubclasses - returns all subclasses of OverlappingDegAv
	%  getProps - returns the property list of the average overlapping-degree
	%  getPropNumber - returns the property number of the average overlapping-degree
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
	% OverlappingDegAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingDegAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingDegAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingDegAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingDegAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingDegAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingDegAv(varargin)
			%OverlappingDegAv() creates a average overlapping-degree.
			%
			% OverlappingDegAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingDegAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingDeg(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average overlapping-degree.
			%
			% CLASS = OverlappingDegAv.GETCLASS() returns the class 'OverlappingDegAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingDegAv') returns 'OverlappingDegAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingDegAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingDegAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average overlapping-degree.
			%
			% LIST = OverlappingDegAv.GETSUBCLASSES() returns all subclasses of 'OverlappingDegAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average overlapping-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingDegAv') returns all subclasses of 'OverlappingDegAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingDegAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping-degree.
			%
			% PROPS = OverlappingDegAv.GETPROPS() returns the property list of average overlapping-degree
			%  as a row vector.
			%
			% PROPS = OverlappingDegAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingDegAv'[, CATEGORY]) returns the property list of 'OverlappingDegAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingDeg.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingDeg.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingDeg.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingDeg.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingDeg.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingDeg.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingDeg.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingDeg.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingDeg.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingDeg.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average overlapping-degree.
			%
			% N = OverlappingDegAv.GETPROPNUMBER() returns the property number of average overlapping-degree.
			%
			% N = OverlappingDegAv.GETPROPNUMBER(CATEGORY) returns the property number of average overlapping-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average overlapping-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingDegAv') returns the property number of 'OverlappingDegAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingDegAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping-degree/error.
			%
			% CHECK = OverlappingDegAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingDegAv, PROP) checks whether PROP exists for OverlappingDegAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingDegAv, PROP) throws error if PROP does NOT exist for OverlappingDegAv.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingDegAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingDegAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping-degree/error.
			%
			% CHECK = OverlappingDegAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingDegAv, TAG) checks whether TAG exists for OverlappingDegAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingDegAv, TAG) throws error if TAG does NOT exist for OverlappingDegAv.
			%   Error id: [BRAPH2:OverlappingDegAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingdegav_tag_list = cellfun(@(x) OverlappingDegAv.getPropTag(x), num2cell(OverlappingDegAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingdegav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingDegAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingDegAv, POINTER) returns property number of POINTER of OverlappingDegAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingDegAv, POINTER) returns property number of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingdegav_tag_list = cellfun(@(x) OverlappingDegAv.getPropTag(x), num2cell(OverlappingDegAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingdegav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OverlappingDegAv, POINTER) returns tag of POINTER of OverlappingDegAv.
			%  TAG = M.GETPROPTAG(OverlappingDegAv, POINTER) returns tag of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingDegAv')
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
						tag = getPropTag@OverlappingDeg(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingDegAv, POINTER) returns category of POINTER of OverlappingDegAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingDegAv, POINTER) returns category of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingDeg(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingDegAv, POINTER) returns format of POINTER of OverlappingDegAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingDegAv, POINTER) returns format of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingDeg(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingDegAv, POINTER) returns description of POINTER of OverlappingDegAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingDegAv, POINTER) returns description of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping Degree.';
				case OverlappingDegAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping Degree.';
				case OverlappingDegAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the average overlapping degree.';
				case OverlappingDegAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping Degree.';
				case OverlappingDegAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping Degree.';
				case OverlappingDegAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping Degree.';
				case OverlappingDegAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping Degree.';
				case OverlappingDegAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case OverlappingDegAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.SUPERGLOBAL__.';
				case OverlappingDegAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingDegAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingDegAv.M
					prop_description = 'M (result, cell) is the Average Overlapping Degree.';
				otherwise
					prop_description = getPropDescription@OverlappingDeg(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingDegAv, POINTER) returns settings of POINTER of OverlappingDegAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingDegAv, POINTER) returns settings of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegAv.TEMPLATE
					prop_settings = 'OverlappingDegAv';
				otherwise
					prop_settings = getPropSettings@OverlappingDeg(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingDegAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingDegAv, POINTER) returns the default value of POINTER of OverlappingDegAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingDegAv, POINTER) returns the default value of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegAv.ELCLASS
					prop_default = 'OverlappingDegAv';
				case OverlappingDegAv.NAME
					prop_default = 'Average Overlapping Degree';
				case OverlappingDegAv.DESCRIPTION
					prop_default = 'The Average Overlapping Degree (OverlappingDegAv) of a graph is the sum of the degrees of a node in all layers.';
				case OverlappingDegAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingDegAv.getPropSettings(prop));
				case OverlappingDegAv.ID
					prop_default = 'OverlappingDegAv ID';
				case OverlappingDegAv.LABEL
					prop_default = 'Average Overlapping Degree label';
				case OverlappingDegAv.NOTES
					prop_default = 'Average Overlapping Degree notes';
				case OverlappingDegAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingDegAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingDegAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingDegAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU' 'MultilayerBU'};;
				otherwise
					prop_default = getPropDefault@OverlappingDeg(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingDegAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingDegAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingDegAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			prop_default = OverlappingDegAv.conditioning(prop, OverlappingDegAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingDegAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegAv.
			%  CHECK = M.CHECKPROP(OverlappingDegAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingDegAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingDegAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingDegAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingDegAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingDegAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingDegAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegAv.TEMPLATE % __OverlappingDegAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingDegAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingDeg.getPropNumber()
						check = checkProp@OverlappingDeg(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingDegAv.getPropTag(prop) ' (' OverlappingDegAv.getFormatTag(OverlappingDegAv.getPropFormat(prop)) ').'] ...
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
				case OverlappingDegAv.M % __OverlappingDegAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingDegAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    overlapping_degree = calculateValue@OverlappingDeg(m, prop);
					    overlapping_degree_av = cell(length(l), 1);
					
					    for i=1:length(ls)
					        overlapping_degree_av(i) = {mean(overlapping_degree{i})};
					    end
					    value = overlapping_degree_av;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingDeg.getPropNumber()
						value = calculateValue@OverlappingDeg(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
