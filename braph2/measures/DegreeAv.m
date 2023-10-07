classdef DegreeAv < Degree
	%DegreeAv is the graph Average Degree.
	% It is a subclass of <a href="matlab:help Degree">Degree</a>.
	%
	% The Average Degree (DegreeAv) of a graph is the average of all number of edges 
	% connected to a node within a layer. 
	% Connection weights are ignored in calculations.
	%
	% DegreeAv methods (constructor):
	%  DegreeAv - constructor
	%
	% DegreeAv methods:
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
	% DegreeAv methods (display):
	%  tostring - string with information about the average degree
	%  disp - displays information about the average degree
	%  tree - displays the tree of the average degree
	%
	% DegreeAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average degree
	%
	% DegreeAv methods (save/load, Static):
	%  save - saves BRAPH2 average degree as b2 file
	%  load - loads a BRAPH2 average degree from a b2 file
	%
	% DegreeAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average degree
	%
	% DegreeAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average degree
	%
	% DegreeAv methods (inspection, Static):
	%  getClass - returns the class of the average degree
	%  getSubclasses - returns all subclasses of DegreeAv
	%  getProps - returns the property list of the average degree
	%  getPropNumber - returns the property number of the average degree
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
	% DegreeAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeAv constants</a>.
	%
	
	methods % constructor
		function m = DegreeAv(varargin)
			%DegreeAv() creates a average degree.
			%
			% DegreeAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Degree(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average degree.
			%
			% CLASS = DegreeAv.GETCLASS() returns the class 'DegreeAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeAv') returns 'DegreeAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeAv')
			%  are less computationally efficient.
			
			m_class = 'DegreeAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average degree.
			%
			% LIST = DegreeAv.GETSUBCLASSES() returns all subclasses of 'DegreeAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeAv') returns all subclasses of 'DegreeAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('DegreeAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average degree.
			%
			% PROPS = DegreeAv.GETPROPS() returns the property list of average degree
			%  as a row vector.
			%
			% PROPS = DegreeAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeAv'[, CATEGORY]) returns the property list of 'DegreeAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Degree.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Degree.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Degree.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Degree.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Degree.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Degree.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Degree.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Degree.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Degree.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Degree.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average degree.
			%
			% N = DegreeAv.GETPROPNUMBER() returns the property number of average degree.
			%
			% N = DegreeAv.GETPROPNUMBER(CATEGORY) returns the property number of average degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeAv') returns the property number of 'DegreeAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(DegreeAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average degree/error.
			%
			% CHECK = DegreeAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeAv, PROP) checks whether PROP exists for DegreeAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%  Element.EXISTSPROP(DegreeAv, PROP) throws error if PROP does NOT exist for DegreeAv.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == DegreeAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average degree/error.
			%
			% CHECK = DegreeAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeAv, TAG) checks whether TAG exists for DegreeAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%  Element.EXISTSTAG(DegreeAv, TAG) throws error if TAG does NOT exist for DegreeAv.
			%   Error id: [BRAPH2:DegreeAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			degreeav_tag_list = cellfun(@(x) DegreeAv.getPropTag(x), num2cell(DegreeAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, degreeav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for DegreeAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeAv, POINTER) returns property number of POINTER of DegreeAv.
			%  PROPERTY = M.GETPROPPROP(DegreeAv, POINTER) returns property number of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				degreeav_tag_list = cellfun(@(x) DegreeAv.getPropTag(x), num2cell(DegreeAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, degreeav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(DegreeAv, POINTER) returns tag of POINTER of DegreeAv.
			%  TAG = M.GETPROPTAG(DegreeAv, POINTER) returns tag of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeAv')
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
						tag = getPropTag@Degree(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeAv, POINTER) returns category of POINTER of DegreeAv.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeAv, POINTER) returns category of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Degree(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeAv, POINTER) returns format of POINTER of DegreeAv.
			%  FORMAT = M.GETPROPFORMAT(DegreeAv, POINTER) returns format of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Degree(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeAv, POINTER) returns description of POINTER of DegreeAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeAv, POINTER) returns description of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				case DegreeAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Degree.';
				case DegreeAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Degree.';
				case DegreeAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Degree.';
				case DegreeAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Degree.';
				case DegreeAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Degree.';
				case DegreeAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Degree.';
				case DegreeAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Degree.';
				case DegreeAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case DegreeAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case DegreeAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case DegreeAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case DegreeAv.M
					prop_description = 'M (result, cell) is the Average Degree.';
				otherwise
					prop_description = getPropDescription@Degree(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeAv, POINTER) returns settings of POINTER of DegreeAv.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeAv, POINTER) returns settings of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				case DegreeAv.TEMPLATE
					prop_settings = 'DegreeAv';
				otherwise
					prop_settings = getPropSettings@Degree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeAv, POINTER) returns the default value of POINTER of DegreeAv.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeAv, POINTER) returns the default value of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				case DegreeAv.ELCLASS
					prop_default = 'DegreeAv';
				case DegreeAv.NAME
					prop_default = 'DegreeAv';
				case DegreeAv.DESCRIPTION
					prop_default = 'The Average Degree (DegreeAv) of a graph is the average of all number of edges connected to a node within a layer. Connection weights are ignored in calculations.';
				case DegreeAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, DegreeAv.getPropSettings(prop));
				case DegreeAv.ID
					prop_default = 'DegreeAv ID';
				case DegreeAv.LABEL
					prop_default = 'Average Degree label';
				case DegreeAv.NOTES
					prop_default = 'Average Degree notes';
				case DegreeAv.SHAPE
					prop_default = Measure.GLOBAL;
				case DegreeAv.SCOPE
					prop_default = Measure.UNILAYER;
				case DegreeAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				otherwise
					prop_default = getPropDefault@Degree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeAv, POINTER) returns the conditioned default value of POINTER of DegreeAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeAv, POINTER) returns the conditioned default value of POINTER of DegreeAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeAv.getPropProp(pointer);
			
			prop_default = DegreeAv.conditioning(prop, DegreeAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeAv, PROP, VALUE) checks VALUE format for PROP of DegreeAv.
			%  CHECK = M.CHECKPROP(DegreeAv, PROP, VALUE) checks VALUE format for PROP of DegreeAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:DegreeAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:DegreeAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(DegreeAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeAv.
			%   Error id: €BRAPH2.STR€:DegreeAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(DegreeAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeAv.
			%   Error id: €BRAPH2.STR€:DegreeAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeAv.getPropProp(pointer);
			
			switch prop
				case DegreeAv.TEMPLATE % __DegreeAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, DegreeAv.getPropSettings(prop));
				otherwise
					if prop <= Degree.getPropNumber()
						check = checkProp@Degree(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeAv.getPropTag(prop) ' (' DegreeAv.getFormatTag(DegreeAv.getPropFormat(prop)) ').'] ...
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
				case DegreeAv.M % __DegreeAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(DegreeAv.M), 'twister')
					
					degree = calculateValue@Degree(m, prop);
					
					g = m.get('G');  % graph from measure class
					
					degree_av = cell(g.get('LAYERNUMBER'), 1);
					parfor li = 1:1:g.get('LAYERNUMBER')
					    degree_av(li) = {mean(degree{li})};
					end
					
					value = degree_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Degree.getPropNumber()
						value = calculateValue@Degree(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
