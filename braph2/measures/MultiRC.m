classdef MultiRC < Richness
	%MultiRC is the graph Multirichness.
	% It is a subclass of <a href="matlab:help Richness">Richness</a>.
	%
	% The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes 
	%  of degree k or higher in all layers. The relevance of each layer is 
	%  controlled by the coefficients c that are between 0 and 1; 
	%  the default coefficients are (1/layernumber).
	%
	% MultiRC methods (constructor):
	%  MultiRC - constructor
	%
	% MultiRC methods:
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
	% MultiRC methods (display):
	%  tostring - string with information about the multirichness
	%  disp - displays information about the multirichness
	%  tree - displays the tree of the multirichness
	%
	% MultiRC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multirichness are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multirichness
	%
	% MultiRC methods (save/load, Static):
	%  save - saves BRAPH2 multirichness as b2 file
	%  load - loads a BRAPH2 multirichness from a b2 file
	%
	% MultiRC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multirichness
	%
	% MultiRC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multirichness
	%
	% MultiRC methods (inspection, Static):
	%  getClass - returns the class of the multirichness
	%  getSubclasses - returns all subclasses of MultiRC
	%  getProps - returns the property list of the multirichness
	%  getPropNumber - returns the property number of the multirichness
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
	% MultiRC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiRC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiRC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiRC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiRC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiRC constants</a>.
	%
	
	properties (Constant) % properties
		MULTIRICHNESS_COEFFICIENTS = Richness.getPropNumber() + 1;
		MULTIRICHNESS_COEFFICIENTS_TAG = 'MULTIRICHNESS_COEFFICIENTS';
		MULTIRICHNESS_COEFFICIENTS_CATEGORY = Category.PARAMETER;
		MULTIRICHNESS_COEFFICIENTS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function m = MultiRC(varargin)
			%MultiRC() creates a multirichness.
			%
			% MultiRC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiRC(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Richness(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multirichness.
			%
			% CLASS = MultiRC.GETCLASS() returns the class 'MultiRC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multirichness M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiRC') returns 'MultiRC'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiRC')
			%  are less computationally efficient.
			
			m_class = 'MultiRC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multirichness.
			%
			% LIST = MultiRC.GETSUBCLASSES() returns all subclasses of 'MultiRC'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multirichness M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiRC') returns all subclasses of 'MultiRC'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiRC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiRC', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multirichness.
			%
			% PROPS = MultiRC.GETPROPS() returns the property list of multirichness
			%  as a row vector.
			%
			% PROPS = MultiRC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multirichness M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiRC'[, CATEGORY]) returns the property list of 'MultiRC'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Richness.getProps() ...
						MultiRC.MULTIRICHNESS_COEFFICIENTS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Richness.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Richness.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Richness.getProps(Category.PARAMETER) ...
						MultiRC.MULTIRICHNESS_COEFFICIENTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Richness.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Richness.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Richness.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Richness.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Richness.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Richness.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multirichness.
			%
			% N = MultiRC.GETPROPNUMBER() returns the property number of multirichness.
			%
			% N = MultiRC.GETPROPNUMBER(CATEGORY) returns the property number of multirichness
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multirichness M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiRC') returns the property number of 'MultiRC'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiRC')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiRC.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multirichness/error.
			%
			% CHECK = MultiRC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiRC, PROP) checks whether PROP exists for MultiRC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSPROP(MultiRC, PROP) throws error if PROP does NOT exist for MultiRC.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiRC.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiRC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multirichness/error.
			%
			% CHECK = MultiRC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiRC, TAG) checks whether TAG exists for MultiRC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSTAG(MultiRC, TAG) throws error if TAG does NOT exist for MultiRC.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multirc_tag_list = cellfun(@(x) MultiRC.getPropTag(x), num2cell(MultiRC.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multirc_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiRC.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiRC, POINTER) returns property number of POINTER of MultiRC.
			%  PROPERTY = M.GETPROPPROP(MultiRC, POINTER) returns property number of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multirc_tag_list = cellfun(@(x) MultiRC.getPropTag(x), num2cell(MultiRC.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multirc_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiRC, POINTER) returns tag of POINTER of MultiRC.
			%  TAG = M.GETPROPTAG(MultiRC, POINTER) returns tag of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiRC.MULTIRICHNESS_COEFFICIENTS
						tag = MultiRC.MULTIRICHNESS_COEFFICIENTS_TAG;
					otherwise
						tag = getPropTag@Richness(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiRC, POINTER) returns category of POINTER of MultiRC.
			%  CATEGORY = M.GETPROPCATEGORY(MultiRC, POINTER) returns category of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiRC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_category = MultiRC.MULTIRICHNESS_COEFFICIENTS_CATEGORY;
				otherwise
					prop_category = getPropCategory@Richness(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiRC, POINTER) returns format of POINTER of MultiRC.
			%  FORMAT = M.GETPROPFORMAT(MultiRC, POINTER) returns format of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_format = MultiRC.MULTIRICHNESS_COEFFICIENTS_FORMAT;
				otherwise
					prop_format = getPropFormat@Richness(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiRC, POINTER) returns description of POINTER of MultiRC.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiRC, POINTER) returns description of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_description = 'MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR)';
				case MultiRC.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multirichness.';
				case MultiRC.NAME
					prop_description = 'NAME (constant, string) is the name of the Multirichness.';
				case MultiRC.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multirichness.';
				case MultiRC.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the multirichness.';
				case MultiRC.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multirichness.';
				case MultiRC.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multirichness.';
				case MultiRC.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multirichness.';
				case MultiRC.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiRC.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiRC.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiRC.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiRC.M
					prop_description = 'M (result, cell) is the Multirichness.';
				otherwise
					prop_description = getPropDescription@Richness(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiRC, POINTER) returns settings of POINTER of MultiRC.
			%  SETTINGS = M.GETPROPSETTINGS(MultiRC, POINTER) returns settings of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultiRC.TEMPLATE
					prop_settings = 'MultiRC';
				otherwise
					prop_settings = getPropSettings@Richness(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiRC, POINTER) returns the default value of POINTER of MultiRC.
			%  DEFAULT = M.GETPROPDEFAULT(MultiRC, POINTER) returns the default value of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_default = [0];
				case MultiRC.ELCLASS
					prop_default = 'MultiRC';
				case MultiRC.NAME
					prop_default = 'Multirichness';
				case MultiRC.DESCRIPTION
					prop_default = 'The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes of degree k or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).';
				case MultiRC.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiRC.getPropSettings(prop));
				case MultiRC.ID
					prop_default = 'MultiRC ID';
				case MultiRC.LABEL
					prop_default = 'Multirichness label';
				case MultiRC.NOTES
					prop_default = 'Multirichness notes';
				case MultiRC.SHAPE
					prop_default = Measure.NODAL;
				case MultiRC.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiRC.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiRC.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Richness(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiRC, POINTER) returns the conditioned default value of POINTER of MultiRC.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiRC, POINTER) returns the conditioned default value of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiRC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			prop_default = MultiRC.conditioning(prop, MultiRC.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiRC, PROP, VALUE) checks VALUE format for PROP of MultiRC.
			%  CHECK = M.CHECKPROP(MultiRC, PROP, VALUE) checks VALUE format for PROP of MultiRC.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiRC:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiRC:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRC.
			%   Error id: €BRAPH2.STR€:MultiRC:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRC.
			%   Error id: €BRAPH2.STR€:MultiRC:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case MultiRC.MULTIRICHNESS_COEFFICIENTS % __MultiRC.MULTIRICHNESS_COEFFICIENTS__
					check = Format.checkFormat(Format.RVECTOR, value, MultiRC.getPropSettings(prop));
				case MultiRC.TEMPLATE % __MultiRC.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiRC.getPropSettings(prop));
				otherwise
					if prop <= Richness.getPropNumber()
						check = checkProp@Richness(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRC:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiRC.getPropTag(prop) ' (' MultiRC.getFormatTag(MultiRC.getPropFormat(prop)) ').'] ...
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
				case MultiRC.M % __MultiRC.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiRC.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					richness = calculateValue@Richness(m, prop);
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
					    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
					        [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
					        ['Multirichness coefficients must have the same length than the ' ...
					        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])
					
					    if length(multirichness_coefficients) == ls(1)
					        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
					            [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
					            ['Multirichness coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichness_coefficients)])
					        c = multirichness_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					    multirichness = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        multirichness_partition = zeros(N(1), 1);
					        for li = count:1:ls(i) + count - 1
					            multirichness_partition = multirichness_partition + c(li)*richness{li};
					        end
					        count = count + ls(i);
					        multirichness(i) = {multirichness_partition};
					    end
					    value = multirichness;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Richness.getPropNumber()
						value = calculateValue@Richness(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
