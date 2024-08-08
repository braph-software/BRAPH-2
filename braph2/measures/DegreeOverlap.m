classdef DegreeOverlap < EdgeOverlap
	%DegreeOverlap is the graph Degree Overlap.
	% It is a subclass of <a href="matlab:help EdgeOverlap">EdgeOverlap</a>.
	%
	% The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. 
	% Connection weights are ignored in calculations.
	%
	% DegreeOverlap methods (constructor):
	%  DegreeOverlap - constructor
	%
	% DegreeOverlap methods:
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
	% DegreeOverlap methods (display):
	%  tostring - string with information about the degree overlap
	%  disp - displays information about the degree overlap
	%  tree - displays the tree of the degree overlap
	%
	% DegreeOverlap methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two degree overlap are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the degree overlap
	%
	% DegreeOverlap methods (save/load, Static):
	%  save - saves BRAPH2 degree overlap as b2 file
	%  load - loads a BRAPH2 degree overlap from a b2 file
	%
	% DegreeOverlap method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the degree overlap
	%
	% DegreeOverlap method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the degree overlap
	%
	% DegreeOverlap methods (inspection, Static):
	%  getClass - returns the class of the degree overlap
	%  getSubclasses - returns all subclasses of DegreeOverlap
	%  getProps - returns the property list of the degree overlap
	%  getPropNumber - returns the property number of the degree overlap
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
	% DegreeOverlap methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeOverlap methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeOverlap methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeOverlap methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeOverlap; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeOverlap constants</a>.
	%
	
	methods % constructor
		function m = DegreeOverlap(varargin)
			%DegreeOverlap() creates a degree overlap.
			%
			% DegreeOverlap(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeOverlap(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@EdgeOverlap(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the degree overlap.
			%
			% CLASS = DegreeOverlap.GETCLASS() returns the class 'DegreeOverlap'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the degree overlap M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeOverlap') returns 'DegreeOverlap'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeOverlap')
			%  are less computationally efficient.
			
			m_class = 'DegreeOverlap';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the degree overlap.
			%
			% LIST = DegreeOverlap.GETSUBCLASSES() returns all subclasses of 'DegreeOverlap'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the degree overlap M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeOverlap') returns all subclasses of 'DegreeOverlap'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('DegreeOverlap', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of degree overlap.
			%
			% PROPS = DegreeOverlap.GETPROPS() returns the property list of degree overlap
			%  as a row vector.
			%
			% PROPS = DegreeOverlap.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the degree overlap M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeOverlap'[, CATEGORY]) returns the property list of 'DegreeOverlap'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					EdgeOverlap.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						EdgeOverlap.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						EdgeOverlap.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						EdgeOverlap.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						EdgeOverlap.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						EdgeOverlap.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						EdgeOverlap.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						EdgeOverlap.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						EdgeOverlap.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						EdgeOverlap.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of degree overlap.
			%
			% N = DegreeOverlap.GETPROPNUMBER() returns the property number of degree overlap.
			%
			% N = DegreeOverlap.GETPROPNUMBER(CATEGORY) returns the property number of degree overlap
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the degree overlap M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeOverlap') returns the property number of 'DegreeOverlap'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(DegreeOverlap.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in degree overlap/error.
			%
			% CHECK = DegreeOverlap.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeOverlap, PROP) checks whether PROP exists for DegreeOverlap.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSPROP(DegreeOverlap, PROP) throws error if PROP does NOT exist for DegreeOverlap.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == DegreeOverlap.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeOverlap.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in degree overlap/error.
			%
			% CHECK = DegreeOverlap.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeOverlap, TAG) checks whether TAG exists for DegreeOverlap.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSTAG(DegreeOverlap, TAG) throws error if TAG does NOT exist for DegreeOverlap.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			degreeoverlap_tag_list = cellfun(@(x) DegreeOverlap.getPropTag(x), num2cell(DegreeOverlap.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, degreeoverlap_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for DegreeOverlap.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeOverlap, POINTER) returns property number of POINTER of DegreeOverlap.
			%  PROPERTY = M.GETPROPPROP(DegreeOverlap, POINTER) returns property number of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				degreeoverlap_tag_list = cellfun(@(x) DegreeOverlap.getPropTag(x), num2cell(DegreeOverlap.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, degreeoverlap_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(DegreeOverlap, POINTER) returns tag of POINTER of DegreeOverlap.
			%  TAG = M.GETPROPTAG(DegreeOverlap, POINTER) returns tag of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeOverlap')
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
						tag = getPropTag@EdgeOverlap(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeOverlap, POINTER) returns category of POINTER of DegreeOverlap.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeOverlap, POINTER) returns category of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@EdgeOverlap(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeOverlap, POINTER) returns format of POINTER of DegreeOverlap.
			%  FORMAT = M.GETPROPFORMAT(DegreeOverlap, POINTER) returns format of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@EdgeOverlap(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeOverlap, POINTER) returns description of POINTER of DegreeOverlap.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeOverlap, POINTER) returns description of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				case DegreeOverlap.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Degree Overlap.';
				case DegreeOverlap.NAME
					prop_description = 'NAME (constant, string) is the name of the Degree Overlap.';
				case DegreeOverlap.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Degree Overlap.';
				case DegreeOverlap.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Degree Overlap.';
				case DegreeOverlap.ID
					prop_description = 'ID (data, string) is a few-letter code of the Degree Overlap.';
				case DegreeOverlap.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Degree Overlap.';
				case DegreeOverlap.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Degree Overlap.';
				case DegreeOverlap.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case DegreeOverlap.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case DegreeOverlap.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case DegreeOverlap.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case DegreeOverlap.M
					prop_description = 'M (result, cell) is the Degree Overlap.';
				otherwise
					prop_description = getPropDescription@EdgeOverlap(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeOverlap, POINTER) returns settings of POINTER of DegreeOverlap.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeOverlap, POINTER) returns settings of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				case DegreeOverlap.TEMPLATE
					prop_settings = 'DegreeOverlap';
				otherwise
					prop_settings = getPropSettings@EdgeOverlap(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeOverlap, POINTER) returns the default value of POINTER of DegreeOverlap.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeOverlap, POINTER) returns the default value of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				case DegreeOverlap.ELCLASS
					prop_default = 'DegreeOverlap';
				case DegreeOverlap.NAME
					prop_default = 'Degree Overlap';
				case DegreeOverlap.DESCRIPTION
					prop_default = 'The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. Connection weights are ignored in calculations.';
				case DegreeOverlap.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, DegreeOverlap.getPropSettings(prop));
				case DegreeOverlap.ID
					prop_default = 'DegreeOverlap ID';
				case DegreeOverlap.LABEL
					prop_default = 'Degree Overlap label';
				case DegreeOverlap.NOTES
					prop_default = 'Degree Overlap notes';
				case DegreeOverlap.SHAPE
					prop_default = Measure.NODAL;
				case DegreeOverlap.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case DegreeOverlap.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case DegreeOverlap.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'MultilayerWU' 'MultilayerBU' 'MultilayerBUD' 'MultilayerBUT' 'OrdMlBU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@EdgeOverlap(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeOverlap, POINTER) returns the conditioned default value of POINTER of DegreeOverlap.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeOverlap, POINTER) returns the conditioned default value of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			prop_default = DegreeOverlap.conditioning(prop, DegreeOverlap.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeOverlap, PROP, VALUE) checks VALUE format for PROP of DegreeOverlap.
			%  CHECK = M.CHECKPROP(DegreeOverlap, PROP, VALUE) checks VALUE format for PROP of DegreeOverlap.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:DegreeOverlap:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:DegreeOverlap:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(DegreeOverlap, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOverlap.
			%   Error id: €BRAPH2.STR€:DegreeOverlap:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(DegreeOverlap, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOverlap.
			%   Error id: €BRAPH2.STR€:DegreeOverlap:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				case DegreeOverlap.TEMPLATE % __DegreeOverlap.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, DegreeOverlap.getPropSettings(prop));
				otherwise
					if prop <= EdgeOverlap.getPropNumber()
						check = checkProp@EdgeOverlap(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':DegreeOverlap:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeOverlap.getPropTag(prop) ' (' DegreeOverlap.getFormatTag(DegreeOverlap.getPropFormat(prop)) ').'] ...
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
				case DegreeOverlap.M % __DegreeOverlap.M__
					rng_settings_ = rng(); rng(m.getPropSeed(DegreeOverlap.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    edge_overlap = calculateValue@EdgeOverlap(m, prop);
					    degree_overlap = cell(length(ls), 1);
					    
					    for i=1:length(ls)
					        edge_overlap_partition = edge_overlap{i};
					        degree_overlap(i) = {sum(edge_overlap_partition == 1, 2)};
					    end
					    value = degree_overlap;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= EdgeOverlap.getPropNumber()
						value = calculateValue@EdgeOverlap(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
