classdef MultilayerM < MultilayerCommunity
	%MultilayerM is the graph Multilayer Modularity.
	% It is a subclass of <a href="matlab:help MultilayerCommunity">MultilayerCommunity</a>.
	%
	% The Multilayer Modularity (MultilayerM) of a multilayer graph is the multilayer 
	% quality function Q of the resulting partition of the multilayer network.
	%
	% MultilayerM methods (constructor):
	%  MultilayerM - constructor
	%
	% MultilayerM methods:
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
	% MultilayerM methods (display):
	%  tostring - string with information about the multilayer modularity
	%  disp - displays information about the multilayer modularity
	%  tree - displays the tree of the multilayer modularity
	%
	% MultilayerM methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer modularity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer modularity
	%
	% MultilayerM methods (save/load, Static):
	%  save - saves BRAPH2 multilayer modularity as b2 file
	%  load - loads a BRAPH2 multilayer modularity from a b2 file
	%
	% MultilayerM method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer modularity
	%
	% MultilayerM method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer modularity
	%
	% MultilayerM methods (inspection, Static):
	%  getClass - returns the class of the multilayer modularity
	%  getSubclasses - returns all subclasses of MultilayerM
	%  getProps - returns the property list of the multilayer modularity
	%  getPropNumber - returns the property number of the multilayer modularity
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
	% MultilayerM methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerM methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerM methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerM methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerM; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerM constants</a>.
	%
	
	methods % constructor
		function m = MultilayerM(varargin)
			%MultilayerM() creates a multilayer modularity.
			%
			% MultilayerM(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerM(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@MultilayerCommunity(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multilayer modularity.
			%
			% CLASS = MultilayerM.GETCLASS() returns the class 'MultilayerM'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multilayer modularity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultilayerM') returns 'MultilayerM'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultilayerM')
			%  are less computationally efficient.
			
			m_class = 'MultilayerM';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer modularity.
			%
			% LIST = MultilayerM.GETSUBCLASSES() returns all subclasses of 'MultilayerM'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multilayer modularity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultilayerM') returns all subclasses of 'MultilayerM'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultilayerM')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerM', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer modularity.
			%
			% PROPS = MultilayerM.GETPROPS() returns the property list of multilayer modularity
			%  as a row vector.
			%
			% PROPS = MultilayerM.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multilayer modularity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultilayerM'[, CATEGORY]) returns the property list of 'MultilayerM'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultilayerCommunity.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultilayerCommunity.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultilayerCommunity.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multilayer modularity.
			%
			% N = MultilayerM.GETPROPNUMBER() returns the property number of multilayer modularity.
			%
			% N = MultilayerM.GETPROPNUMBER(CATEGORY) returns the property number of multilayer modularity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer modularity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultilayerM') returns the property number of 'MultilayerM'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerM.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer modularity/error.
			%
			% CHECK = MultilayerM.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultilayerM, PROP) checks whether PROP exists for MultilayerM.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%  Element.EXISTSPROP(MultilayerM, PROP) throws error if PROP does NOT exist for MultilayerM.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerM.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerM.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer modularity/error.
			%
			% CHECK = MultilayerM.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultilayerM, TAG) checks whether TAG exists for MultilayerM.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%  Element.EXISTSTAG(MultilayerM, TAG) throws error if TAG does NOT exist for MultilayerM.
			%   Error id: [BRAPH2:MultilayerM:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayerm_tag_list = cellfun(@(x) MultilayerM.getPropTag(x), num2cell(MultilayerM.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayerm_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerM.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerM, POINTER) returns property number of POINTER of MultilayerM.
			%  PROPERTY = M.GETPROPPROP(MultilayerM, POINTER) returns property number of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayerm_tag_list = cellfun(@(x) MultilayerM.getPropTag(x), num2cell(MultilayerM.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayerm_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerM, POINTER) returns tag of POINTER of MultilayerM.
			%  TAG = M.GETPROPTAG(MultilayerM, POINTER) returns tag of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultilayerM')
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
						tag = getPropTag@MultilayerCommunity(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerM, POINTER) returns category of POINTER of MultilayerM.
			%  CATEGORY = M.GETPROPCATEGORY(MultilayerM, POINTER) returns category of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultilayerM')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MultilayerCommunity(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerM, POINTER) returns format of POINTER of MultilayerM.
			%  FORMAT = M.GETPROPFORMAT(MultilayerM, POINTER) returns format of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultilayerM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MultilayerCommunity(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerM, POINTER) returns description of POINTER of MultilayerM.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultilayerM, POINTER) returns description of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				case MultilayerM.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multilayer Modularity.';
				case MultilayerM.NAME
					prop_description = 'NAME (constant, string) is the name of the Multilayer Modularity.';
				case MultilayerM.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multilayer Modularity.';
				case MultilayerM.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multilayer Modularity.';
				case MultilayerM.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multilayer Modularity.';
				case MultilayerM.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multilayer Modularity.';
				case MultilayerM.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multilayer Modularity.';
				case MultilayerM.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultilayerM.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultilayerM.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultilayerM.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultilayerM.M
					prop_description = 'M (result, cell) is the Multilayer Modularity.';
				otherwise
					prop_description = getPropDescription@MultilayerCommunity(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerM, POINTER) returns settings of POINTER of MultilayerM.
			%  SETTINGS = M.GETPROPSETTINGS(MultilayerM, POINTER) returns settings of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				case MultilayerM.TEMPLATE
					prop_settings = 'MultilayerM';
				otherwise
					prop_settings = getPropSettings@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerM.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerM.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerM, POINTER) returns the default value of POINTER of MultilayerM.
			%  DEFAULT = M.GETPROPDEFAULT(MultilayerM, POINTER) returns the default value of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultilayerM')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				case MultilayerM.ELCLASS
					prop_default = 'MultilayerM';
				case MultilayerM.NAME
					prop_default = 'Multilayer Modularity';
				case MultilayerM.DESCRIPTION
					prop_default = 'The Multilayer Modularity (MultilayerM) is the homogeneity of the number of inward neighbours of a node across the layers.';
				case MultilayerM.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerM.getPropSettings(prop));
				case MultilayerM.ID
					prop_default = 'MultilayerM ID';
				case MultilayerM.LABEL
					prop_default = 'Multilayer Modularity label';
				case MultilayerM.NOTES
					prop_default = 'Multilayer Modularity notes';
				case MultilayerM.SHAPE
					prop_default = Measure.GLOBAL;
				case MultilayerM.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultilayerM.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultilayerM.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'OrdMxWU' 'MultiplexBU' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerM.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerM.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerM, POINTER) returns the conditioned default value of POINTER of MultilayerM.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultilayerM, POINTER) returns the conditioned default value of POINTER of MultilayerM.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultilayerM')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerM.getPropProp(pointer);
			
			prop_default = MultilayerM.conditioning(prop, MultilayerM.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerM, PROP, VALUE) checks VALUE format for PROP of MultilayerM.
			%  CHECK = M.CHECKPROP(MultilayerM, PROP, VALUE) checks VALUE format for PROP of MultilayerM.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerM:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultilayerM:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerM.
			%   Error id: €BRAPH2.STR€:MultilayerM:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultilayerM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerM.
			%   Error id: €BRAPH2.STR€:MultilayerM:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultilayerM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerM.getPropProp(pointer);
			
			switch prop
				case MultilayerM.TEMPLATE % __MultilayerM.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerM.getPropSettings(prop));
				otherwise
					if prop <= MultilayerCommunity.getPropNumber()
						check = checkProp@MultilayerCommunity(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerM:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerM.getPropTag(prop) ' (' MultilayerM.getFormatTag(MultilayerM.getPropFormat(prop)) ').'] ...
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
				case MultilayerM.M % __MultilayerM.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultilayerM.M), 'twister')
					
					multilayer_community_structure = calculateValue@MultilayerCommunity(m, prop);
					Q = 0;
					if ~isempty(cell2mat(multilayer_community_structure))
					    Q = m.get('QUALITY_FUNCTION');
					end
					multilayer_modularity = {Q};  % assign normalized quality function
					value = multilayer_modularity;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= MultilayerCommunity.getPropNumber()
						value = calculateValue@MultilayerCommunity(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
