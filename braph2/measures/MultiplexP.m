classdef MultiplexP < Measure
	%MultiplexP is the graph Multiplex Participation.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multiplex Participation (MultiplexP) is the nodal homogeneity of the number of 
	%  neighbors of a node across the layers. 
	% It is calculated as: Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2] 
	%  where L is the number of layers, ki(l) is the degree in the l-th 
	%  layer and oi is the overlapping degree of the node. 
	% Pi = 1 when the degree is the same in all layers and Pi = 0 when a 
	%  node has non-zero degree in only one layer.
	%
	% MultiplexP methods (constructor):
	%  MultiplexP - constructor
	%
	% MultiplexP methods:
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
	% MultiplexP methods (display):
	%  tostring - string with information about the mxpart
	%  disp - displays information about the mxpart
	%  tree - displays the tree of the mxpart
	%
	% MultiplexP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two mxpart are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the mxpart
	%
	% MultiplexP methods (save/load, Static):
	%  save - saves BRAPH2 mxpart as b2 file
	%  load - loads a BRAPH2 mxpart from a b2 file
	%
	% MultiplexP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the mxpart
	%
	% MultiplexP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the mxpart
	%
	% MultiplexP methods (inspection, Static):
	%  getClass - returns the class of the mxpart
	%  getSubclasses - returns all subclasses of MultiplexP
	%  getProps - returns the property list of the mxpart
	%  getPropNumber - returns the property number of the mxpart
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
	% MultiplexP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexP constants</a>.
	%
	
	methods % constructor
		function m = MultiplexP(varargin)
			%MultiplexP() creates a mxpart.
			%
			% MultiplexP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the mxpart.
			%
			% CLASS = MultiplexP.GETCLASS() returns the class 'MultiplexP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the mxpart M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexP') returns 'MultiplexP'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexP')
			%  are less computationally efficient.
			
			m_class = 'MultiplexP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the mxpart.
			%
			% LIST = MultiplexP.GETSUBCLASSES() returns all subclasses of 'MultiplexP'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the mxpart M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexP') returns all subclasses of 'MultiplexP'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of mxpart.
			%
			% PROPS = MultiplexP.GETPROPS() returns the property list of mxpart
			%  as a row vector.
			%
			% PROPS = MultiplexP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the mxpart M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexP'[, CATEGORY]) returns the property list of 'MultiplexP'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexP')
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
			%GETPROPNUMBER returns the property number of mxpart.
			%
			% N = MultiplexP.GETPROPNUMBER() returns the property number of mxpart.
			%
			% N = MultiplexP.GETPROPNUMBER(CATEGORY) returns the property number of mxpart
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the mxpart M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexP') returns the property number of 'MultiplexP'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in mxpart/error.
			%
			% CHECK = MultiplexP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexP, PROP) checks whether PROP exists for MultiplexP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%  Element.EXISTSPROP(MultiplexP, PROP) throws error if PROP does NOT exist for MultiplexP.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in mxpart/error.
			%
			% CHECK = MultiplexP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexP, TAG) checks whether TAG exists for MultiplexP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%  Element.EXISTSTAG(MultiplexP, TAG) throws error if TAG does NOT exist for MultiplexP.
			%   Error id: [BRAPH2:MultiplexP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexp_tag_list = cellfun(@(x) MultiplexP.getPropTag(x), num2cell(MultiplexP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexP, POINTER) returns property number of POINTER of MultiplexP.
			%  PROPERTY = M.GETPROPPROP(MultiplexP, POINTER) returns property number of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexp_tag_list = cellfun(@(x) MultiplexP.getPropTag(x), num2cell(MultiplexP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexP, POINTER) returns tag of POINTER of MultiplexP.
			%  TAG = M.GETPROPTAG(MultiplexP, POINTER) returns tag of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexP')
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexP, POINTER) returns category of POINTER of MultiplexP.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexP, POINTER) returns category of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexP, POINTER) returns format of POINTER of MultiplexP.
			%  FORMAT = M.GETPROPFORMAT(MultiplexP, POINTER) returns format of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexP, POINTER) returns description of POINTER of MultiplexP.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexP, POINTER) returns description of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
			switch prop
				case MultiplexP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex Participation.';
				case MultiplexP.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex Participation.';
				case MultiplexP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex Participation.';
				case MultiplexP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex Participation.';
				case MultiplexP.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex Participation.';
				case MultiplexP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex Participation.';
				case MultiplexP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex Participation.';
				case MultiplexP.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexP.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexP.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexP.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexP.M
					prop_description = 'M (result, cell) is the Multiplex Participation.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexP, POINTER) returns settings of POINTER of MultiplexP.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexP, POINTER) returns settings of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
			switch prop
				case MultiplexP.TEMPLATE
					prop_settings = 'MultiplexP';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexP, POINTER) returns the default value of POINTER of MultiplexP.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexP, POINTER) returns the default value of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
			switch prop
				case MultiplexP.ELCLASS
					prop_default = 'MultiplexP';
				case MultiplexP.NAME
					prop_default = 'Multiplex Participation';
				case MultiplexP.DESCRIPTION
					prop_default = 'The Multiplex Participation (MultiplexP) is the nodal homogeneity of the number of neighbors of a node across the layers. It is calculated as: Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2] where L is the number of layers, ki(l) is the degree in the l-th layer and oi is the overlapping degree of the node. Pi = 1 when the degree is the same in all layers and Pi = 0 when a node has non-zero degree in only one layer.';
				case MultiplexP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexP.getPropSettings(prop));
				case MultiplexP.ID
					prop_default = 'MultiplexP ID';
				case MultiplexP.LABEL
					prop_default = 'Multiplex Participation label';
				case MultiplexP.NOTES
					prop_default = 'Multiplex Participation notes';
				case MultiplexP.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexP.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexP.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexP.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexP, POINTER) returns the conditioned default value of POINTER of MultiplexP.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexP, POINTER) returns the conditioned default value of POINTER of MultiplexP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexP.getPropProp(pointer);
			
			prop_default = MultiplexP.conditioning(prop, MultiplexP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexP, PROP, VALUE) checks VALUE format for PROP of MultiplexP.
			%  CHECK = M.CHECKPROP(MultiplexP, PROP, VALUE) checks VALUE format for PROP of MultiplexP.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexP.
			%   Error id: €BRAPH2.STR€:MultiplexP:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexP.
			%   Error id: €BRAPH2.STR€:MultiplexP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexP.getPropProp(pointer);
			
			switch prop
				case MultiplexP.TEMPLATE % __MultiplexP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexP.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexP.getPropTag(prop) ' (' MultiplexP.getFormatTag(MultiplexP.getPropFormat(prop)) ').'] ...
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
				case MultiplexP.M % __MultiplexP.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexP.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    degree = Degree('G', g).get('M');
					    overlapping_degree = OverlappingDeg('G', g).get('M'); 
					    multiplex_participation = cell(length(ls), 1);
					    
					    count = 1;
					    for i = 1:1:length(ls)
					       multiplex_participation_partition = zeros(N(1), 1);
					        for li = count:1:ls(i) + count - 1
					            multiplex_participation_partition = multiplex_participation_partition + (degree{li}./overlapping_degree{i}).^2;
					        end
					        multiplex_participation_partition = ls(i) / (ls(i) - 1) * (1 - multiplex_participation_partition);
					        multiplex_participation_partition(isnan(multiplex_participation_partition)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
					        count = count + ls(i);
					        multiplex_participation(i) = {multiplex_participation_partition};
					    end
					    value = multiplex_participation;
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
