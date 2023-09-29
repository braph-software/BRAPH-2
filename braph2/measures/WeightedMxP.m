classdef WeightedMxP < Measure
	%WeightedMxP is the graph Weighted Multiplex Participation.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Weighted Multiplex Participation (WeightedMxP) of a graph is the nodal homogeneity 
	%  of its number of neighbours across the layers.
	%
	% WeightedMxP methods (constructor):
	%  WeightedMxP - constructor
	%
	% WeightedMxP methods:
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
	% WeightedMxP methods (display):
	%  tostring - string with information about the weighted multiplex participation
	%  disp - displays information about the weighted multiplex participation
	%  tree - displays the tree of the weighted multiplex participation
	%
	% WeightedMxP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two weighted multiplex participation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the weighted multiplex participation
	%
	% WeightedMxP methods (save/load, Static):
	%  save - saves BRAPH2 weighted multiplex participation as b2 file
	%  load - loads a BRAPH2 weighted multiplex participation from a b2 file
	%
	% WeightedMxP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the weighted multiplex participation
	%
	% WeightedMxP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the weighted multiplex participation
	%
	% WeightedMxP methods (inspection, Static):
	%  getClass - returns the class of the weighted multiplex participation
	%  getSubclasses - returns all subclasses of WeightedMxP
	%  getProps - returns the property list of the weighted multiplex participation
	%  getPropNumber - returns the property number of the weighted multiplex participation
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
	% WeightedMxP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% WeightedMxP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% WeightedMxP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% WeightedMxP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?WeightedMxP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">WeightedMxP constants</a>.
	%
	
	methods % constructor
		function m = WeightedMxP(varargin)
			%WeightedMxP() creates a weighted multiplex participation.
			%
			% WeightedMxP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% WeightedMxP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the weighted multiplex participation.
			%
			% CLASS = WeightedMxP.GETCLASS() returns the class 'WeightedMxP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the weighted multiplex participation M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('WeightedMxP') returns 'WeightedMxP'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('WeightedMxP')
			%  are less computationally efficient.
			
			m_class = 'WeightedMxP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the weighted multiplex participation.
			%
			% LIST = WeightedMxP.GETSUBCLASSES() returns all subclasses of 'WeightedMxP'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the weighted multiplex participation M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('WeightedMxP') returns all subclasses of 'WeightedMxP'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('WeightedMxP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted multiplex participation.
			%
			% PROPS = WeightedMxP.GETPROPS() returns the property list of weighted multiplex participation
			%  as a row vector.
			%
			% PROPS = WeightedMxP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the weighted multiplex participation M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('WeightedMxP'[, CATEGORY]) returns the property list of 'WeightedMxP'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('WeightedMxP')
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
			%GETPROPNUMBER returns the property number of weighted multiplex participation.
			%
			% N = WeightedMxP.GETPROPNUMBER() returns the property number of weighted multiplex participation.
			%
			% N = WeightedMxP.GETPROPNUMBER(CATEGORY) returns the property number of weighted multiplex participation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the weighted multiplex participation M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('WeightedMxP') returns the property number of 'WeightedMxP'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(WeightedMxP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in weighted multiplex participation/error.
			%
			% CHECK = WeightedMxP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(WeightedMxP, PROP) checks whether PROP exists for WeightedMxP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:WeightedMxP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%  Element.EXISTSPROP(WeightedMxP, PROP) throws error if PROP does NOT exist for WeightedMxP.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == WeightedMxP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for WeightedMxP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted multiplex participation/error.
			%
			% CHECK = WeightedMxP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(WeightedMxP, TAG) checks whether TAG exists for WeightedMxP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:WeightedMxP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%  Element.EXISTSTAG(WeightedMxP, TAG) throws error if TAG does NOT exist for WeightedMxP.
			%   Error id: [BRAPH2:WeightedMxP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			weightedmxp_tag_list = cellfun(@(x) WeightedMxP.getPropTag(x), num2cell(WeightedMxP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, weightedmxp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for WeightedMxP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(WeightedMxP, POINTER) returns property number of POINTER of WeightedMxP.
			%  PROPERTY = M.GETPROPPROP(WeightedMxP, POINTER) returns property number of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				weightedmxp_tag_list = cellfun(@(x) WeightedMxP.getPropTag(x), num2cell(WeightedMxP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, weightedmxp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(WeightedMxP, POINTER) returns tag of POINTER of WeightedMxP.
			%  TAG = M.GETPROPTAG(WeightedMxP, POINTER) returns tag of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('WeightedMxP')
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
			%  CATEGORY = Element.GETPROPCATEGORY(WeightedMxP, POINTER) returns category of POINTER of WeightedMxP.
			%  CATEGORY = M.GETPROPCATEGORY(WeightedMxP, POINTER) returns category of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(WeightedMxP, POINTER) returns format of POINTER of WeightedMxP.
			%  FORMAT = M.GETPROPFORMAT(WeightedMxP, POINTER) returns format of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(WeightedMxP, POINTER) returns description of POINTER of WeightedMxP.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(WeightedMxP, POINTER) returns description of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
			switch prop
				case WeightedMxP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Weighted Multiplex Participation.';
				case WeightedMxP.NAME
					prop_description = 'NAME (constant, string) is the name of the Weighted Multiplex Participation.';
				case WeightedMxP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Weighted Multiplex Participation.';
				case WeightedMxP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Weighted Multiplex Participation.';
				case WeightedMxP.ID
					prop_description = 'ID (data, string) is a few-letter code of the Weighted Multiplex Participation.';
				case WeightedMxP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Weighted Multiplex Participation.';
				case WeightedMxP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Weighted Multiplex Participation.';
				case WeightedMxP.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case WeightedMxP.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case WeightedMxP.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case WeightedMxP.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case WeightedMxP.M
					prop_description = 'M (result, cell) is the Weighted Multiplex Participation.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(WeightedMxP, POINTER) returns settings of POINTER of WeightedMxP.
			%  SETTINGS = M.GETPROPSETTINGS(WeightedMxP, POINTER) returns settings of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
			switch prop
				case WeightedMxP.TEMPLATE
					prop_settings = 'WeightedMxP';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = WeightedMxP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedMxP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(WeightedMxP, POINTER) returns the default value of POINTER of WeightedMxP.
			%  DEFAULT = M.GETPROPDEFAULT(WeightedMxP, POINTER) returns the default value of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
			switch prop
				case WeightedMxP.ELCLASS
					prop_default = 'WeightedMxP';
				case WeightedMxP.NAME
					prop_default = 'Weighted Multiplex Participation';
				case WeightedMxP.DESCRIPTION
					prop_default = 'The Weighted Multiplex Participation (WeightedMxP) of a graph is the nodal homogeneity of its number of inward neighbours across the layers.';
				case WeightedMxP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, WeightedMxP.getPropSettings(prop));
				case WeightedMxP.ID
					prop_default = 'WeightedMxP ID';
				case WeightedMxP.LABEL
					prop_default = 'Weighted Multiplex Participation label';
				case WeightedMxP.NOTES
					prop_default = 'Weighted Multiplex Participation notes';
				case WeightedMxP.SHAPE
					prop_default = Measure.NODAL;
				case WeightedMxP.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case WeightedMxP.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case WeightedMxP.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = WeightedMxP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedMxP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(WeightedMxP, POINTER) returns the conditioned default value of POINTER of WeightedMxP.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(WeightedMxP, POINTER) returns the conditioned default value of POINTER of WeightedMxP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = WeightedMxP.getPropProp(pointer);
			
			prop_default = WeightedMxP.conditioning(prop, WeightedMxP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(WeightedMxP, PROP, VALUE) checks VALUE format for PROP of WeightedMxP.
			%  CHECK = M.CHECKPROP(WeightedMxP, PROP, VALUE) checks VALUE format for PROP of WeightedMxP.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:WeightedMxP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:WeightedMxP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(WeightedMxP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedMxP.
			%   Error id: €BRAPH2.STR€:WeightedMxP:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(WeightedMxP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedMxP.
			%   Error id: €BRAPH2.STR€:WeightedMxP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('WeightedMxP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = WeightedMxP.getPropProp(pointer);
			
			switch prop
				case WeightedMxP.TEMPLATE % __WeightedMxP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, WeightedMxP.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedMxP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' WeightedMxP.getPropTag(prop) ' (' WeightedMxP.getFormatTag(WeightedMxP.getPropFormat(prop)) ').'] ...
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
				case WeightedMxP.M % __WeightedMxP.M__
					rng_settings_ = rng(); rng(m.getPropSeed(WeightedMxP.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    strength = Strength('G', g).get('M');
					    overlapping_strength = OverlappingS('G', g).get('M');
					
					    weighted_multiplex_participation =  zeros(N(1), 1);
					    for li = 1:l
					        weighted_multiplex_participation = weighted_multiplex_participation + (strength{li}./overlapping_strength{1}).^2;
					    end
					    weighted_multiplex_participation = l / (l - 1) * (1 - weighted_multiplex_participation);
					    weighted_multiplex_participation(isnan(weighted_multiplex_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
					    value = {weighted_multiplex_participation};
					end
					
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
