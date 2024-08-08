classdef OverlappingDegOutAv < OverlappingDegOut
	%OverlappingDegOutAv is the graph Average Overlapping Out-Degree.
	% It is a subclass of <a href="matlab:help OverlappingDegOut">OverlappingDegOut</a>.
	%
	% The Average Overlapping Out-Degree (OverlappingDegOutAv) of a graph is the average of the sum of the 
	% out-degrees of a node in all layers.
	%
	% OverlappingDegOutAv methods (constructor):
	%  OverlappingDegOutAv - constructor
	%
	% OverlappingDegOutAv methods:
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
	% OverlappingDegOutAv methods (display):
	%  tostring - string with information about the average overlapping out-degree
	%  disp - displays information about the average overlapping out-degree
	%  tree - displays the tree of the average overlapping out-degree
	%
	% OverlappingDegOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average overlapping out-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average overlapping out-degree
	%
	% OverlappingDegOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average overlapping out-degree as b2 file
	%  load - loads a BRAPH2 average overlapping out-degree from a b2 file
	%
	% OverlappingDegOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average overlapping out-degree
	%
	% OverlappingDegOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average overlapping out-degree
	%
	% OverlappingDegOutAv methods (inspection, Static):
	%  getClass - returns the class of the average overlapping out-degree
	%  getSubclasses - returns all subclasses of OverlappingDegOutAv
	%  getProps - returns the property list of the average overlapping out-degree
	%  getPropNumber - returns the property number of the average overlapping out-degree
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
	% OverlappingDegOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingDegOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingDegOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingDegOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingDegOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingDegOutAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingDegOutAv(varargin)
			%OverlappingDegOutAv() creates a average overlapping out-degree.
			%
			% OverlappingDegOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingDegOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingDegOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average overlapping out-degree.
			%
			% CLASS = OverlappingDegOutAv.GETCLASS() returns the class 'OverlappingDegOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping out-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingDegOutAv') returns 'OverlappingDegOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingDegOutAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingDegOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average overlapping out-degree.
			%
			% LIST = OverlappingDegOutAv.GETSUBCLASSES() returns all subclasses of 'OverlappingDegOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average overlapping out-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingDegOutAv') returns all subclasses of 'OverlappingDegOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingDegOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping out-degree.
			%
			% PROPS = OverlappingDegOutAv.GETPROPS() returns the property list of average overlapping out-degree
			%  as a row vector.
			%
			% PROPS = OverlappingDegOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping out-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingDegOutAv'[, CATEGORY]) returns the property list of 'OverlappingDegOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingDegOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingDegOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingDegOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average overlapping out-degree.
			%
			% N = OverlappingDegOutAv.GETPROPNUMBER() returns the property number of average overlapping out-degree.
			%
			% N = OverlappingDegOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average overlapping out-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average overlapping out-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingDegOutAv') returns the property number of 'OverlappingDegOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingDegOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping out-degree/error.
			%
			% CHECK = OverlappingDegOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingDegOutAv, PROP) checks whether PROP exists for OverlappingDegOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingDegOutAv, PROP) throws error if PROP does NOT exist for OverlappingDegOutAv.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingDegOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingDegOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping out-degree/error.
			%
			% CHECK = OverlappingDegOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingDegOutAv, TAG) checks whether TAG exists for OverlappingDegOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingDegOutAv, TAG) throws error if TAG does NOT exist for OverlappingDegOutAv.
			%   Error id: [BRAPH2:OverlappingDegOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingdegoutav_tag_list = cellfun(@(x) OverlappingDegOutAv.getPropTag(x), num2cell(OverlappingDegOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingdegoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingDegOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingDegOutAv, POINTER) returns property number of POINTER of OverlappingDegOutAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingDegOutAv, POINTER) returns property number of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingdegoutav_tag_list = cellfun(@(x) OverlappingDegOutAv.getPropTag(x), num2cell(OverlappingDegOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingdegoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(OverlappingDegOutAv, POINTER) returns tag of POINTER of OverlappingDegOutAv.
			%  TAG = M.GETPROPTAG(OverlappingDegOutAv, POINTER) returns tag of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingDegOutAv')
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
						tag = getPropTag@OverlappingDegOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingDegOutAv, POINTER) returns category of POINTER of OverlappingDegOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingDegOutAv, POINTER) returns category of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingDegOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingDegOutAv, POINTER) returns format of POINTER of OverlappingDegOutAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingDegOutAv, POINTER) returns format of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingDegOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingDegOutAv, POINTER) returns description of POINTER of OverlappingDegOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingDegOutAv, POINTER) returns description of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping Out-Degree.';
				case OverlappingDegOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingDegOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingDegOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingDegOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingDegOutAv.M
					prop_description = 'M (result, cell) is the Average Overlapping Out-Degree.';
				otherwise
					prop_description = getPropDescription@OverlappingDegOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingDegOutAv, POINTER) returns settings of POINTER of OverlappingDegOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingDegOutAv, POINTER) returns settings of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegOutAv.TEMPLATE
					prop_settings = 'OverlappingDegOutAv';
				otherwise
					prop_settings = getPropSettings@OverlappingDegOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingDegOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingDegOutAv, POINTER) returns the default value of POINTER of OverlappingDegOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingDegOutAv, POINTER) returns the default value of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegOutAv.ELCLASS
					prop_default = 'OverlappingDegOutAv';
				case OverlappingDegOutAv.NAME
					prop_default = 'Average Overlapping Out-Degree';
				case OverlappingDegOutAv.DESCRIPTION
					prop_default = 'The Average Overlapping Out-Degree (OverlappingDegOutAv) of a graph is the average of the sum of the out-degrees of a node in all layers.';
				case OverlappingDegOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingDegOutAv.getPropSettings(prop));
				case OverlappingDegOutAv.ID
					prop_default = 'OverlappingDegOutAv ID';
				case OverlappingDegOutAv.LABEL
					prop_default = 'Average Overlapping Out-Degree label';
				case OverlappingDegOutAv.NOTES
					prop_default = 'Average Overlapping Out-Degree notes';
				case OverlappingDegOutAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingDegOutAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingDegOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingDegOutAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@OverlappingDegOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingDegOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingDegOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingDegOutAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingDegOutAv, POINTER) returns the conditioned default value of POINTER of OverlappingDegOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			prop_default = OverlappingDegOutAv.conditioning(prop, OverlappingDegOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingDegOutAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegOutAv.
			%  CHECK = M.CHECKPROP(OverlappingDegOutAv, PROP, VALUE) checks VALUE format for PROP of OverlappingDegOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingDegOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingDegOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingDegOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegOutAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingDegOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingDegOutAv.
			%   Error id: €BRAPH2.STR€:OverlappingDegOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingDegOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingDegOutAv.getPropProp(pointer);
			
			switch prop
				case OverlappingDegOutAv.TEMPLATE % __OverlappingDegOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingDegOutAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingDegOut.getPropNumber()
						check = checkProp@OverlappingDegOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingDegOutAv.getPropTag(prop) ' (' OverlappingDegOutAv.getFormatTag(OverlappingDegOutAv.getPropFormat(prop)) ').'] ...
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
				case OverlappingDegOutAv.M % __OverlappingDegOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingDegOutAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					overlapping_out_degree_av = calculateValue@OverlappingDegOut(m, prop);
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					    return;
					end
					
					value = {mean(cell2mat(overlapping_out_degree_av))};
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingDegOut.getPropNumber()
						value = calculateValue@OverlappingDegOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
