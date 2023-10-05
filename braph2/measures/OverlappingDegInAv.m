classdef OverlappingDegInAv < OverlappingDegIn
	%OverlappingDegInAv is the graph Average Overlapping In-Degree.
	% It is a subclass of <a href="matlab:help OverlappingDegIn">OverlappingDegIn</a>.
	%
	% The Average Overlapping In-Degree (OverlappingDegInAv) of a graph is the average of the sum of the 
	% in-degrees of a node in all layers.
	%
	% OverlappingDegInAv methods (constructor):
	%  OverlappingDegInAv - constructor
	%
	% OverlappingDegInAv methods:
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
	% OverlappingDegInAv methods (display):
	%  tostring - string with information about the average overlapping in-degree
	%  disp - displays information about the average overlapping in-degree
	%  tree - displays the tree of the average overlapping in-degree
	%
	% OverlappingDegInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average overlapping in-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average overlapping in-degree
	%
	% OverlappingDegInAv methods (save/load, Static):
	%  save - saves BRAPH2 average overlapping in-degree as b2 file
	%  load - loads a BRAPH2 average overlapping in-degree from a b2 file
	%
	% OverlappingDegInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average overlapping in-degree
	%
	% OverlappingDegInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average overlapping in-degree
	%
	% OverlappingDegInAv methods (inspection, Static):
	%  getClass - returns the class of the average overlapping in-degree
	%  getSubclasses - returns all subclasses of OverlappingDegInAv
	%  getProps - returns the property list of the average overlapping in-degree
	%  getPropNumber - returns the property number of the average overlapping in-degree
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
	% OverlappingDegInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingDegInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingDegInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingDegInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingDegInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingDegInAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingDegInAv(varargin)
			%OverlappingDegInAv() creates a average overlapping in-degree.
			%
			% OverlappingDegInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingDegInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingDegIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average overlapping in-degree.
			%
			% CLASS = OverlappingDegInAv.GETCLASS() returns the class 'OverlappingDegInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping in-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingDegInAv') returns 'OverlappingDegInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingDegInAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingDegInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average overlapping in-degree.
			%
			% LIST = OverlappingDegInAv.GETSUBCLASSES() returns all subclasses of 'OverlappingDegInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average overlapping in-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingDegInAv') returns all subclasses of 'OverlappingDegInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingDegInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping in-degree.
			%
			% PROPS = OverlappingDegInAv.GETPROPS() returns the property list of average overlapping in-degree
			%  as a row vector.
			%
			% PROPS = OverlappingDegInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping in-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingDegInAv'[, CATEGORY]) returns the property list of 'OverlappingDegInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingDegIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingDegIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingDegIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average overlapping in-degree.
			%
			% N = OverlappingDegInAv.GETPROPNUMBER() returns the property number of average overlapping in-degree.
			%
			% N = OverlappingDegInAv.GETPROPNUMBER(CATEGORY) returns the property number of average overlapping in-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average overlapping in-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingDegInAv') returns the property number of 'OverlappingDegInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingDegInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping in-degree/error.
			%
			% CHECK = OverlappingDegInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingDegInAv, PROP) checks whether PROP exists for OverlappingDegInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingDegInAv, PROP) throws error if PROP does NOT exist for OverlappingDegInAv.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingDegInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingDegInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping in-degree/error.
			%
			% CHECK = OverlappingDegInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingDegInAv, TAG) checks whether TAG exists for OverlappingDegInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingDegInAv, TAG) throws error if TAG does NOT exist for OverlappingDegInAv.
			%   Error id: [BRAPH2:OverlappingDegInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingdeginav_tag_list = cellfun(@(x) OverlappingDegInAv.getPropTag(x), num2cell(OverlappingDegInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingdeginav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingDegInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingDegInAv, POINTER) returns property number of POINTER of OverlappingDegInAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingDegInAv, POINTER) returns property number of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingdeginav_tag_list = cellfun(@(x) OverlappingDegInAv.getPropTag(x), num2cell(OverlappingDegInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingdeginav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OverlappingDegInAv, POINTER) returns tag of POINTER of OverlappingDegInAv.
			%  TAG = M.GETPROPTAG(OverlappingDegInAv, POINTER) returns tag of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingDegInAv')
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
						tag = getPropTag@OverlappingDegIn(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingDegInAv, POINTER) returns category of POINTER of OverlappingDegInAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingDegInAv, POINTER) returns category of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingDegIn(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingDegInAv, POINTER) returns format of POINTER of OverlappingDegInAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingDegInAv, POINTER) returns format of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingDegIn(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingDegInAv, POINTER) returns description of POINTER of OverlappingDegInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingDegInAv, POINTER) returns description of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping In-Degree.';
				case OverlappingDegInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping In-Degree.';
				case OverlappingDegInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingDegInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingDegInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingDegInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingDegInAv.M
					prop_description = 'M (result, cell) is the Average Overlapping In-Degree.';
				otherwise
					prop_description = getPropDescription@OverlappingDegIn(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingDegInAv, POINTER) returns settings of POINTER of OverlappingDegInAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingDegInAv, POINTER) returns settings of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegInAv.TEMPLATE
					prop_settings = 'OverlappingDegInAv';
				otherwise
					prop_settings = getPropSettings@OverlappingDegIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingDegInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingDegInAv, POINTER) returns the default value of POINTER of OverlappingDegInAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingDegInAv, POINTER) returns the default value of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegInAv.ELCLASS
					prop_default = 'OverlappingDegInAv';
				case OverlappingDegInAv.NAME
					prop_default = 'Average Overlapping In-Degree';
				case OverlappingDegInAv.DESCRIPTION
					prop_default = 'The Average Overlapping In-Degree (OverlappingDegInAv) of a graph is the average of the sum of the in-degrees of a node in all layers.';
				case OverlappingDegInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingDegInAv.getPropSettings(prop));
				case OverlappingDegInAv.ID
					prop_default = 'OverlappingDegInAv ID';
				case OverlappingDegInAv.LABEL
					prop_default = 'Average Overlapping In-Degree label';
				case OverlappingDegInAv.NOTES
					prop_default = 'Average Overlapping In-Degree notes';
				case OverlappingDegInAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingDegInAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingDegInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingDegInAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@OverlappingDegIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingDegInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingDegInAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingDegInAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			prop_default = OverlappingDegInAv.conditioning(prop, OverlappingDegInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingDegInAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegInAv.
			%  CHECK = M.CHECKPROP(OverlappingDegInAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingDegInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingDegInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingDegInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegInAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingDegInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegInAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingDegInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingDegInAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegInAv.TEMPLATE % __OverlappingDegInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingDegInAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingDegIn.getPropNumber()
						check = checkProp@OverlappingDegIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingDegInAv.getPropTag(prop) ' (' OverlappingDegInAv.getFormatTag(OverlappingDegInAv.getPropFormat(prop)) ').'] ...
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
				case OverlappingDegInAv.M % __OverlappingDegInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingDegInAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					overlapping_in_degree_av = calculateValue@OverlappingDegIn(m, prop);
					
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					    return;
					end
					
					value = {mean(cell2mat(overlapping_in_degree_av))};
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingDegIn.getPropNumber()
						value = calculateValue@OverlappingDegIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
