classdef KCore < Measure
	%KCore is the graph K-Core.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The K-Core (KCore) of a graph is the largest subnetwork comprising nodes of degree k or higher. 
	%   k is set by the user; the default value is equal to 1.
	%
	% KCore methods (constructor):
	%  KCore - constructor
	%
	% KCore methods:
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
	% KCore methods (display):
	%  tostring - string with information about the kcore
	%  disp - displays information about the kcore
	%  tree - displays the tree of the kcore
	%
	% KCore methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two kcore are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the kcore
	%
	% KCore methods (save/load, Static):
	%  save - saves BRAPH2 kcore as b2 file
	%  load - loads a BRAPH2 kcore from a b2 file
	%
	% KCore method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the kcore
	%
	% KCore method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the kcore
	%
	% KCore methods (inspection, Static):
	%  getClass - returns the class of the kcore
	%  getSubclasses - returns all subclasses of KCore
	%  getProps - returns the property list of the kcore
	%  getPropNumber - returns the property number of the kcore
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
	% KCore methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% KCore methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% KCore methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% KCore methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?KCore; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">KCore constants</a>.
	%
	
	properties (Constant) % properties
		KCORETHRESHOLD = Measure.getPropNumber() + 1;
		KCORETHRESHOLD_TAG = 'KCORETHRESHOLD';
		KCORETHRESHOLD_CATEGORY = Category.PARAMETER;
		KCORETHRESHOLD_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function m = KCore(varargin)
			%KCore() creates a kcore.
			%
			% KCore(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% KCore(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the kcore.
			%
			% CLASS = KCore.GETCLASS() returns the class 'KCore'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the kcore M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('KCore') returns 'KCore'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('KCore')
			%  are less computationally efficient.
			
			m_class = 'KCore';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the kcore.
			%
			% LIST = KCore.GETSUBCLASSES() returns all subclasses of 'KCore'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the kcore M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('KCore') returns all subclasses of 'KCore'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('KCore')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('KCore', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of kcore.
			%
			% PROPS = KCore.GETPROPS() returns the property list of kcore
			%  as a row vector.
			%
			% PROPS = KCore.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the kcore M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('KCore'[, CATEGORY]) returns the property list of 'KCore'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('KCore')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						KCore.KCORETHRESHOLD ...
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
						KCore.KCORETHRESHOLD ...
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
			%GETPROPNUMBER returns the property number of kcore.
			%
			% N = KCore.GETPROPNUMBER() returns the property number of kcore.
			%
			% N = KCore.GETPROPNUMBER(CATEGORY) returns the property number of kcore
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the kcore M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('KCore') returns the property number of 'KCore'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('KCore')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(KCore.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in kcore/error.
			%
			% CHECK = KCore.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(KCore, PROP) checks whether PROP exists for KCore.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:KCore:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%  Element.EXISTSPROP(KCore, PROP) throws error if PROP does NOT exist for KCore.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('KCore')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == KCore.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for KCore.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in kcore/error.
			%
			% CHECK = KCore.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(KCore, TAG) checks whether TAG exists for KCore.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:KCore:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%  Element.EXISTSTAG(KCore, TAG) throws error if TAG does NOT exist for KCore.
			%   Error id: [BRAPH2:KCore:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('KCore')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			kcore_tag_list = cellfun(@(x) KCore.getPropTag(x), num2cell(KCore.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, kcore_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for KCore.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(KCore, POINTER) returns property number of POINTER of KCore.
			%  PROPERTY = M.GETPROPPROP(KCore, POINTER) returns property number of POINTER of KCore.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('KCore')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				kcore_tag_list = cellfun(@(x) KCore.getPropTag(x), num2cell(KCore.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, kcore_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(KCore, POINTER) returns tag of POINTER of KCore.
			%  TAG = M.GETPROPTAG(KCore, POINTER) returns tag of POINTER of KCore.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('KCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case KCore.KCORETHRESHOLD
						tag = KCore.KCORETHRESHOLD_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(KCore, POINTER) returns category of POINTER of KCore.
			%  CATEGORY = M.GETPROPCATEGORY(KCore, POINTER) returns category of POINTER of KCore.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('KCore')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD
					prop_category = KCore.KCORETHRESHOLD_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(KCore, POINTER) returns format of POINTER of KCore.
			%  FORMAT = M.GETPROPFORMAT(KCore, POINTER) returns format of POINTER of KCore.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('KCore')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD
					prop_format = KCore.KCORETHRESHOLD_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(KCore, POINTER) returns description of POINTER of KCore.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(KCore, POINTER) returns description of POINTER of KCore.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('KCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD
					prop_description = 'KCORETHRESHOLD (parameter, scalar) is the k-core threshold';
				case KCore.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the K-Core.';
				case KCore.NAME
					prop_description = 'NAME (constant, string) is the name of the K-Core.';
				case KCore.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the K-Core.';
				case KCore.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the K-Core.';
				case KCore.ID
					prop_description = 'ID (data, string) is a few-letter code of the K-Core.';
				case KCore.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the K-Core.';
				case KCore.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the K-Core.';
				case KCore.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.BINODAL__.';
				case KCore.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case KCore.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case KCore.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case KCore.M
					prop_description = 'M (result, cell) is the K-Core.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(KCore, POINTER) returns settings of POINTER of KCore.
			%  SETTINGS = M.GETPROPSETTINGS(KCore, POINTER) returns settings of POINTER of KCore.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('KCore')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case KCore.TEMPLATE
					prop_settings = 'KCore';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = KCore.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = KCore.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(KCore, POINTER) returns the default value of POINTER of KCore.
			%  DEFAULT = M.GETPROPDEFAULT(KCore, POINTER) returns the default value of POINTER of KCore.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('KCore')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD
					prop_default = 1;
				case KCore.ELCLASS
					prop_default = 'KCore';
				case KCore.NAME
					prop_default = 'K-Core';
				case KCore.DESCRIPTION
					prop_default = 'The K-Core (KCore) of a graph is the largest subnetwork comprising nodes of degree k or higher. k is set by the user; the default value is equal to 1.';
				case KCore.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, KCore.getPropSettings(prop));
				case KCore.ID
					prop_default = 'KCore ID';
				case KCore.LABEL
					prop_default = 'K-Core label';
				case KCore.NOTES
					prop_default = 'K-Core notes';
				case KCore.SHAPE
					prop_default = Measure.BINODAL;
				case KCore.SCOPE
					prop_default = Measure.UNILAYER;
				case KCore.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case KCore.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = KCore.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = KCore.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(KCore, POINTER) returns the conditioned default value of POINTER of KCore.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(KCore, POINTER) returns the conditioned default value of POINTER of KCore.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('KCore')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = KCore.getPropProp(pointer);
			
			prop_default = KCore.conditioning(prop, KCore.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(KCore, PROP, VALUE) checks VALUE format for PROP of KCore.
			%  CHECK = M.CHECKPROP(KCore, PROP, VALUE) checks VALUE format for PROP of KCore.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:KCore:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:KCore:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(KCore, PROP, VALUE) throws error if VALUE has not a valid format for PROP of KCore.
			%   Error id: €BRAPH2.STR€:KCore:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(KCore, PROP, VALUE) throws error if VALUE has not a valid format for PROP of KCore.
			%   Error id: €BRAPH2.STR€:KCore:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('KCore')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = KCore.getPropProp(pointer);
			
			switch prop
				case KCore.KCORETHRESHOLD % __KCore.KCORETHRESHOLD__
					check = Format.checkFormat(Format.SCALAR, value, KCore.getPropSettings(prop));
				case KCore.TEMPLATE % __KCore.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, KCore.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' KCore.getPropTag(prop) ' (' KCore.getFormatTag(KCore.getPropFormat(prop)) ').'] ...
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
				case KCore.M % __KCore.M__
					rng_settings_ = rng(); rng(m.getPropSeed(KCore.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					kcore_threshold = m.get('KCORETHRESHOLD');
					
					k_core = cell(L, 1);
					directionality_type =  g.get('DIRECTIONALITY_TYPE', L);
					parfor li = 1:1:L    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);   
					    
					    iter = 0;
					    subAii = binarize(Aii);
					    while 1
					        % get degrees of matrix
					        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					            deg = sum(subAii, 1)';  % degree undirected graphs
					        else
					            deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
					        end
					        
					        % find nodes with degree < k
					        low_k_nodes = find((deg < kcore_threshold) & (deg > 0));
					        
					        % if none found -> stop
					        if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
					        
					        % peel away found nodes
					        iter = iter + 1;
					        subAii(low_k_nodes, :) = 0;
					        subAii(:, low_k_nodes) = 0;
					    end
					    k_core(li) = {subAii};  % add k-core of layer li
					end
					
					value = k_core;
					
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
