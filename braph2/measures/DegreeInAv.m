classdef DegreeInAv < DegreeIn
	%DegreeInAv is the graph Average In-Degree.
	% It is a subclass of <a href="matlab:help DegreeIn">DegreeIn</a>.
	%
	% The Average In-Degree (DegreeInAv) of a graph is the average of all number of inward edges connected to a node within a layer.
	%
	% DegreeInAv methods (constructor):
	%  DegreeInAv - constructor
	%
	% DegreeInAv methods:
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
	% DegreeInAv methods (display):
	%  tostring - string with information about the average in-degree
	%  disp - displays information about the average in-degree
	%  tree - displays the tree of the average in-degree
	%
	% DegreeInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average in-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average in-degree
	%
	% DegreeInAv methods (save/load, Static):
	%  save - saves BRAPH2 average in-degree as b2 file
	%  load - loads a BRAPH2 average in-degree from a b2 file
	%
	% DegreeInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average in-degree
	%
	% DegreeInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average in-degree
	%
	% DegreeInAv methods (inspection, Static):
	%  getClass - returns the class of the average in-degree
	%  getSubclasses - returns all subclasses of DegreeInAv
	%  getProps - returns the property list of the average in-degree
	%  getPropNumber - returns the property number of the average in-degree
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
	% DegreeInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeInAv constants</a>.
	%
	
	methods % constructor
		function m = DegreeInAv(varargin)
			%DegreeInAv() creates a average in-degree.
			%
			% DegreeInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeInAv(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the average in-degree.
			%
			% CLASS = DegreeInAv.GETCLASS() returns the class 'DegreeInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeInAv') returns 'DegreeInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeInAv')
			%  are less computationally efficient.
			
			m_class = 'DegreeInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average in-degree.
			%
			% LIST = DegreeInAv.GETSUBCLASSES() returns all subclasses of 'DegreeInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average in-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeInAv') returns all subclasses of 'DegreeInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('DegreeInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-degree.
			%
			% PROPS = DegreeInAv.GETPROPS() returns the property list of average in-degree
			%  as a row vector.
			%
			% PROPS = DegreeInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeInAv'[, CATEGORY]) returns the property list of 'DegreeInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeInAv')
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
			%GETPROPNUMBER returns the property number of average in-degree.
			%
			% N = DegreeInAv.GETPROPNUMBER() returns the property number of average in-degree.
			%
			% N = DegreeInAv.GETPROPNUMBER(CATEGORY) returns the property number of average in-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average in-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeInAv') returns the property number of 'DegreeInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(DegreeInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average in-degree/error.
			%
			% CHECK = DegreeInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeInAv, PROP) checks whether PROP exists for DegreeInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%  Element.EXISTSPROP(DegreeInAv, PROP) throws error if PROP does NOT exist for DegreeInAv.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == DegreeInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-degree/error.
			%
			% CHECK = DegreeInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeInAv, TAG) checks whether TAG exists for DegreeInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%  Element.EXISTSTAG(DegreeInAv, TAG) throws error if TAG does NOT exist for DegreeInAv.
			%   Error id: [BRAPH2:DegreeInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			degreeinav_tag_list = cellfun(@(x) DegreeInAv.getPropTag(x), num2cell(DegreeInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, degreeinav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for DegreeInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeInAv, POINTER) returns property number of POINTER of DegreeInAv.
			%  PROPERTY = M.GETPROPPROP(DegreeInAv, POINTER) returns property number of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				degreeinav_tag_list = cellfun(@(x) DegreeInAv.getPropTag(x), num2cell(DegreeInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, degreeinav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(DegreeInAv, POINTER) returns tag of POINTER of DegreeInAv.
			%  TAG = M.GETPROPTAG(DegreeInAv, POINTER) returns tag of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeInAv')
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeInAv, POINTER) returns category of POINTER of DegreeInAv.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeInAv, POINTER) returns category of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeInAv, POINTER) returns format of POINTER of DegreeInAv.
			%  FORMAT = M.GETPROPFORMAT(DegreeInAv, POINTER) returns format of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeInAv, POINTER) returns description of POINTER of DegreeInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeInAv, POINTER) returns description of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
			switch prop
				case DegreeInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average In-Degree.';
				case DegreeInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average In-Degree.';
				case DegreeInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average In-Degree.';
				case DegreeInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average In-Degree.';
				case DegreeInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average In-Degree.';
				case DegreeInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average In-Degree.';
				case DegreeInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average In-Degree.';
				case DegreeInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case DegreeInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case DegreeInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case DegreeInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case DegreeInAv.M
					prop_description = 'M (result, cell) is the cell containing the Average In-Degree value.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeInAv, POINTER) returns settings of POINTER of DegreeInAv.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeInAv, POINTER) returns settings of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
			switch prop
				case DegreeInAv.TEMPLATE
					prop_settings = 'DegreeInAv';
				otherwise
					prop_settings = getPropSettings@DegreeIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeInAv, POINTER) returns the default value of POINTER of DegreeInAv.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeInAv, POINTER) returns the default value of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
			switch prop
				case DegreeInAv.ELCLASS
					prop_default = 'DegreeInAv';
				case DegreeInAv.NAME
					prop_default = 'Average In-Degree';
				case DegreeInAv.DESCRIPTION
					prop_default = 'The Average In-Degree (DegreeInAv) of a graph is the average of all number of inward edges connected to a node within a layer.';
				case DegreeInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, DegreeInAv.getPropSettings(prop));
				case DegreeInAv.ID
					prop_default = 'DegreeInAv ID';
				case DegreeInAv.LABEL
					prop_default = 'Average In-Degree label';
				case DegreeInAv.NOTES
					prop_default = 'Average In-Degree notes';
				case DegreeInAv.SHAPE
					prop_default = Measure.GLOBAL;
				case DegreeInAv.SCOPE
					prop_default = Measure.UNILAYER;
				case DegreeInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case DegreeInAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@DegreeIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeInAv, POINTER) returns the conditioned default value of POINTER of DegreeInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeInAv, POINTER) returns the conditioned default value of POINTER of DegreeInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeInAv.getPropProp(pointer);
			
			prop_default = DegreeInAv.conditioning(prop, DegreeInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeInAv, PROP, VALUE) checks VALUE format for PROP of DegreeInAv.
			%  CHECK = M.CHECKPROP(DegreeInAv, PROP, VALUE) checks VALUE format for PROP of DegreeInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:DegreeInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:DegreeInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(DegreeInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeInAv.
			%   Error id: €BRAPH2.STR€:DegreeInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(DegreeInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeInAv.
			%   Error id: €BRAPH2.STR€:DegreeInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeInAv.getPropProp(pointer);
			
			switch prop
				case DegreeInAv.TEMPLATE % __DegreeInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, DegreeInAv.getPropSettings(prop));
				otherwise
					if prop <= DegreeIn.getPropNumber()
						check = checkProp@DegreeIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeInAv.getPropTag(prop) ' (' DegreeInAv.getFormatTag(DegreeInAv.getPropFormat(prop)) ').'] ...
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
				case DegreeInAv.M % __DegreeInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(DegreeInAv.M), 'twister')
					
					in_degree = calculateValue@DegreeIn(m, prop);	
					g = m.get('G'); % graph from measure class
					L = g.get('LAYERNUMBER');
					in_degree_av = cell(L, 1);
					
					parfor li = 1:1:L
					    in_degree_av(li) = {mean(in_degree{li})};
					end
					
					value = in_degree_av;
					
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
