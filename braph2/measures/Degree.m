classdef Degree < Measure
	%Degree is the graph Degree.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Degree of a node is the number of edges connected to the node within a layer. 
	%  Connection weights are ignored in calculations.
	%
	% Degree methods (constructor):
	%  Degree - constructor
	%
	% Degree methods:
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
	% Degree methods (display):
	%  tostring - string with information about the degree
	%  disp - displays information about the degree
	%  tree - displays the tree of the degree
	%
	% Degree methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the degree
	%
	% Degree methods (save/load, Static):
	%  save - saves BRAPH2 degree as b2 file
	%  load - loads a BRAPH2 degree from a b2 file
	%
	% Degree method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the degree
	%
	% Degree method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the degree
	%
	% Degree methods (inspection, Static):
	%  getClass - returns the class of the degree
	%  getSubclasses - returns all subclasses of Degree
	%  getProps - returns the property list of the degree
	%  getPropNumber - returns the property number of the degree
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
	% Degree methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Degree methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Degree methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Degree methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Degree; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Degree constants</a>.
	%
	
	methods % constructor
		function m = Degree(varargin)
			%Degree() creates a degree.
			%
			% Degree(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Degree(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the degree.
			%
			% CLASS = Degree.GETCLASS() returns the class 'Degree'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Degree') returns 'Degree'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Degree')
			%  are less computationally efficient.
			
			m_class = 'Degree';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the degree.
			%
			% LIST = Degree.GETSUBCLASSES() returns all subclasses of 'Degree'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Degree') returns all subclasses of 'Degree'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Degree')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Degree', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of degree.
			%
			% PROPS = Degree.GETPROPS() returns the property list of degree
			%  as a row vector.
			%
			% PROPS = Degree.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Degree'[, CATEGORY]) returns the property list of 'Degree'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Degree')
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
			%GETPROPNUMBER returns the property number of degree.
			%
			% N = Degree.GETPROPNUMBER() returns the property number of degree.
			%
			% N = Degree.GETPROPNUMBER(CATEGORY) returns the property number of degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Degree') returns the property number of 'Degree'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Degree')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Degree.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in degree/error.
			%
			% CHECK = Degree.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Degree, PROP) checks whether PROP exists for Degree.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Degree:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%  Element.EXISTSPROP(Degree, PROP) throws error if PROP does NOT exist for Degree.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Degree')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Degree.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Degree.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in degree/error.
			%
			% CHECK = Degree.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Degree, TAG) checks whether TAG exists for Degree.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Degree:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%  Element.EXISTSTAG(Degree, TAG) throws error if TAG does NOT exist for Degree.
			%   Error id: [BRAPH2:Degree:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Degree')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			degree_tag_list = cellfun(@(x) Degree.getPropTag(x), num2cell(Degree.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, degree_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Degree.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Degree, POINTER) returns property number of POINTER of Degree.
			%  PROPERTY = M.GETPROPPROP(Degree, POINTER) returns property number of POINTER of Degree.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Degree')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				degree_tag_list = cellfun(@(x) Degree.getPropTag(x), num2cell(Degree.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, degree_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Degree, POINTER) returns tag of POINTER of Degree.
			%  TAG = M.GETPROPTAG(Degree, POINTER) returns tag of POINTER of Degree.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Degree')
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
			%  CATEGORY = Element.GETPROPCATEGORY(Degree, POINTER) returns category of POINTER of Degree.
			%  CATEGORY = M.GETPROPCATEGORY(Degree, POINTER) returns category of POINTER of Degree.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Degree')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Degree.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(Degree, POINTER) returns format of POINTER of Degree.
			%  FORMAT = M.GETPROPFORMAT(Degree, POINTER) returns format of POINTER of Degree.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Degree')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Degree.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Degree, POINTER) returns description of POINTER of Degree.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Degree, POINTER) returns description of POINTER of Degree.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Degree')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Degree.getPropProp(pointer);
			
			switch prop
				case Degree.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Degree.';
				case Degree.NAME
					prop_description = 'NAME (constant, string) is the name of the Degree.';
				case Degree.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Degree.';
				case Degree.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Degree.';
				case Degree.ID
					prop_description = 'ID (data, string) is a few-letter code of the Degree.';
				case Degree.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Degree.';
				case Degree.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Degree.';
				case Degree.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Degree.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Degree.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Degree.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Degree.M
					prop_description = 'M (result, cell) is the Degree.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Degree, POINTER) returns settings of POINTER of Degree.
			%  SETTINGS = M.GETPROPSETTINGS(Degree, POINTER) returns settings of POINTER of Degree.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Degree')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Degree.getPropProp(pointer);
			
			switch prop
				case Degree.TEMPLATE
					prop_settings = 'Degree';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Degree.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Degree.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Degree, POINTER) returns the default value of POINTER of Degree.
			%  DEFAULT = M.GETPROPDEFAULT(Degree, POINTER) returns the default value of POINTER of Degree.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Degree')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Degree.getPropProp(pointer);
			
			switch prop
				case Degree.ELCLASS
					prop_default = 'Degree';
				case Degree.NAME
					prop_default = 'Degree';
				case Degree.DESCRIPTION
					prop_default = 'The Degree of a node is the number of edges connected to the node within a layer. Connection weights are ignored in calculations.';
				case Degree.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Degree.getPropSettings(prop));
				case Degree.ID
					prop_default = 'Degree ID';
				case Degree.LABEL
					prop_default = 'Degree label';
				case Degree.NOTES
					prop_default = 'Degree notes';
				case Degree.SHAPE
					prop_default = Measure.NODAL;
				case Degree.SCOPE
					prop_default = Measure.UNILAYER;
				case Degree.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Degree.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Degree.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Degree.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Degree, POINTER) returns the conditioned default value of POINTER of Degree.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Degree, POINTER) returns the conditioned default value of POINTER of Degree.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Degree')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Degree.getPropProp(pointer);
			
			prop_default = Degree.conditioning(prop, Degree.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Degree, PROP, VALUE) checks VALUE format for PROP of Degree.
			%  CHECK = M.CHECKPROP(Degree, PROP, VALUE) checks VALUE format for PROP of Degree.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Degree:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Degree:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Degree, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Degree.
			%   Error id: €BRAPH2.STR€:Degree:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Degree, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Degree.
			%   Error id: €BRAPH2.STR€:Degree:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Degree')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Degree.getPropProp(pointer);
			
			switch prop
				case Degree.TEMPLATE % __Degree.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Degree.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Degree:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Degree.getPropTag(prop) ' (' Degree.getFormatTag(Degree.getPropFormat(prop)) ').'] ...
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
				case Degree.M % __Degree.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Degree.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					
					degree = cell(g.get('LAYERNUMBER'), 1);
					
					parfor li = 1:1:g.get('LAYERNUMBER')
					    Aii = A{li, li};
					    Aii = binarize(Aii);  % binarizes the adjacency matrix (removing diagonal)
					    degree(li) = {sum(Aii, 2)};  % calculates the degree of a node for layer li
					end
					
					value = degree;
					
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
