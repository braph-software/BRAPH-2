classdef DegreeIn < Measure
	%DegreeIn is the graph In-Degree.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The In-Degree (DegreeIn) of a node is the number of inward edges connected to a node within a layer. 
	% Connection weights are ignored in calculations.
	%
	% DegreeIn methods (constructor):
	%  DegreeIn - constructor
	%
	% DegreeIn methods:
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
	% DegreeIn methods (display):
	%  tostring - string with information about the in-degree
	%  disp - displays information about the in-degree
	%  tree - displays the tree of the in-degree
	%
	% DegreeIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two in-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the in-degree
	%
	% DegreeIn methods (save/load, Static):
	%  save - saves BRAPH2 in-degree as b2 file
	%  load - loads a BRAPH2 in-degree from a b2 file
	%
	% DegreeIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the in-degree
	%
	% DegreeIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the in-degree
	%
	% DegreeIn methods (inspection, Static):
	%  getClass - returns the class of the in-degree
	%  getSubclasses - returns all subclasses of DegreeIn
	%  getProps - returns the property list of the in-degree
	%  getPropNumber - returns the property number of the in-degree
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
	% DegreeIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeIn constants</a>.
	%
	
	methods % constructor
		function m = DegreeIn(varargin)
			%DegreeIn() creates a in-degree.
			%
			% DegreeIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeIn(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the in-degree.
			%
			% CLASS = DegreeIn.GETCLASS() returns the class 'DegreeIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the in-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeIn') returns 'DegreeIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeIn')
			%  are less computationally efficient.
			
			m_class = 'DegreeIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the in-degree.
			%
			% LIST = DegreeIn.GETSUBCLASSES() returns all subclasses of 'DegreeIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the in-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeIn') returns all subclasses of 'DegreeIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('DegreeIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of in-degree.
			%
			% PROPS = DegreeIn.GETPROPS() returns the property list of in-degree
			%  as a row vector.
			%
			% PROPS = DegreeIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the in-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeIn'[, CATEGORY]) returns the property list of 'DegreeIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of in-degree.
			%
			% N = DegreeIn.GETPROPNUMBER() returns the property number of in-degree.
			%
			% N = DegreeIn.GETPROPNUMBER(CATEGORY) returns the property number of in-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the in-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeIn') returns the property number of 'DegreeIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(DegreeIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in in-degree/error.
			%
			% CHECK = DegreeIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeIn, PROP) checks whether PROP exists for DegreeIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%  Element.EXISTSPROP(DegreeIn, PROP) throws error if PROP does NOT exist for DegreeIn.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == DegreeIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in in-degree/error.
			%
			% CHECK = DegreeIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeIn, TAG) checks whether TAG exists for DegreeIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%  Element.EXISTSTAG(DegreeIn, TAG) throws error if TAG does NOT exist for DegreeIn.
			%   Error id: [BRAPH2:DegreeIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			degreein_tag_list = cellfun(@(x) DegreeIn.getPropTag(x), num2cell(DegreeIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, degreein_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for DegreeIn.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeIn, POINTER) returns property number of POINTER of DegreeIn.
			%  PROPERTY = M.GETPROPPROP(DegreeIn, POINTER) returns property number of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				degreein_tag_list = cellfun(@(x) DegreeIn.getPropTag(x), num2cell(DegreeIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, degreein_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(DegreeIn, POINTER) returns tag of POINTER of DegreeIn.
			%  TAG = M.GETPROPTAG(DegreeIn, POINTER) returns tag of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeIn')
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
						tag = getPropTag@Measure(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeIn, POINTER) returns category of POINTER of DegreeIn.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeIn, POINTER) returns category of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Measure(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeIn, POINTER) returns format of POINTER of DegreeIn.
			%  FORMAT = M.GETPROPFORMAT(DegreeIn, POINTER) returns format of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Measure(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeIn, POINTER) returns description of POINTER of DegreeIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeIn, POINTER) returns description of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				case DegreeIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the In-Degree.';
				case DegreeIn.NAME
					prop_description = 'NAME (constant, string) is the name of the In-Degree.';
				case DegreeIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the In-Degree.';
				case DegreeIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the In-Degree.';
				case DegreeIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the In-Degree.';
				case DegreeIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the In-Degree.';
				case DegreeIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the In-Degree.';
				case DegreeIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case DegreeIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case DegreeIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case DegreeIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case DegreeIn.M
					prop_description = 'M (result, cell) is the cell containing the In-Degree value.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeIn, POINTER) returns settings of POINTER of DegreeIn.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeIn, POINTER) returns settings of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				case DegreeIn.TEMPLATE
					prop_settings = 'DegreeIn';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeIn, POINTER) returns the default value of POINTER of DegreeIn.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeIn, POINTER) returns the default value of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				case DegreeIn.ELCLASS
					prop_default = 'DegreeIn';
				case DegreeIn.NAME
					prop_default = 'In-Degree';
				case DegreeIn.DESCRIPTION
					prop_default = 'The In-Degree (DegreeIn) of a node is the number of inward edges connected to a node within a layer. Connection weights are ignored in calculations.';
				case DegreeIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, DegreeIn.getPropSettings(prop));
				case DegreeIn.ID
					prop_default = 'DegreeIn ID';
				case DegreeIn.LABEL
					prop_default = 'In-Degree label';
				case DegreeIn.NOTES
					prop_default = 'In-Degree notes';
				case DegreeIn.SHAPE
					prop_default = Measure.NODAL;
				case DegreeIn.SCOPE
					prop_default = Measure.UNILAYER;
				case DegreeIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case DegreeIn.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeIn, POINTER) returns the conditioned default value of POINTER of DegreeIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeIn, POINTER) returns the conditioned default value of POINTER of DegreeIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeIn.getPropProp(pointer);
			
			prop_default = DegreeIn.conditioning(prop, DegreeIn.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeIn, PROP, VALUE) checks VALUE format for PROP of DegreeIn.
			%  CHECK = M.CHECKPROP(DegreeIn, PROP, VALUE) checks VALUE format for PROP of DegreeIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:DegreeIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:DegreeIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(DegreeIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeIn.
			%   Error id: €BRAPH2.STR€:DegreeIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(DegreeIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeIn.
			%   Error id: €BRAPH2.STR€:DegreeIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeIn.getPropProp(pointer);
			
			switch prop
				case DegreeIn.TEMPLATE % __DegreeIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, DegreeIn.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeIn.getPropTag(prop) ' (' DegreeIn.getFormatTag(DegreeIn.getPropFormat(prop)) ').'] ...
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
				case DegreeIn.M % __DegreeIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(DegreeIn.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					in_degree = cell(L, 1);
					
					parfor li = 1:1:L
					    Aii = A{li, li};
					    Aii = binarize(Aii);  % binarizes the adjacency matrix
					    in_degree(li) = {sum(Aii, 1)'};  % calculates the in-degree of a node for layer li
					end
					
					value = in_degree;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
