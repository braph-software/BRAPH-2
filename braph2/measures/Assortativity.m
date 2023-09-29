classdef Assortativity < Measure
	%Assortativity is the graph Assortativity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Assortativity coefficient (Assortativity) of a graph is the correlation coefficient 
	%  between the degrees/strengths of all nodes on two opposite ends of an edge 
	%  within a layer.
	% The corresponding coefficient for directed and weighted networks is 
	%  calculated by using the weighted and directed variants of degree/strength.
	%
	% Assortativity methods (constructor):
	%  Assortativity - constructor
	%
	% Assortativity methods:
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
	% Assortativity methods (display):
	%  tostring - string with information about the assortativity
	%  disp - displays information about the assortativity
	%  tree - displays the tree of the assortativity
	%
	% Assortativity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two assortativity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the assortativity
	%
	% Assortativity methods (save/load, Static):
	%  save - saves BRAPH2 assortativity as b2 file
	%  load - loads a BRAPH2 assortativity from a b2 file
	%
	% Assortativity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the assortativity
	%
	% Assortativity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the assortativity
	%
	% Assortativity methods (inspection, Static):
	%  getClass - returns the class of the assortativity
	%  getSubclasses - returns all subclasses of Assortativity
	%  getProps - returns the property list of the assortativity
	%  getPropNumber - returns the property number of the assortativity
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
	% Assortativity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Assortativity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Assortativity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Assortativity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Assortativity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Assortativity constants</a>.
	%
	
	methods % constructor
		function m = Assortativity(varargin)
			%Assortativity() creates a assortativity.
			%
			% Assortativity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Assortativity(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the assortativity.
			%
			% CLASS = Assortativity.GETCLASS() returns the class 'Assortativity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the assortativity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Assortativity') returns 'Assortativity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Assortativity')
			%  are less computationally efficient.
			
			m_class = 'Assortativity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the assortativity.
			%
			% LIST = Assortativity.GETSUBCLASSES() returns all subclasses of 'Assortativity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the assortativity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Assortativity') returns all subclasses of 'Assortativity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Assortativity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Assortativity', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of assortativity.
			%
			% PROPS = Assortativity.GETPROPS() returns the property list of assortativity
			%  as a row vector.
			%
			% PROPS = Assortativity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the assortativity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Assortativity'[, CATEGORY]) returns the property list of 'Assortativity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Assortativity')
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
			%GETPROPNUMBER returns the property number of assortativity.
			%
			% N = Assortativity.GETPROPNUMBER() returns the property number of assortativity.
			%
			% N = Assortativity.GETPROPNUMBER(CATEGORY) returns the property number of assortativity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the assortativity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Assortativity') returns the property number of 'Assortativity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Assortativity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Assortativity.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in assortativity/error.
			%
			% CHECK = Assortativity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Assortativity, PROP) checks whether PROP exists for Assortativity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Assortativity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%  Element.EXISTSPROP(Assortativity, PROP) throws error if PROP does NOT exist for Assortativity.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Assortativity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Assortativity.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Assortativity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in assortativity/error.
			%
			% CHECK = Assortativity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Assortativity, TAG) checks whether TAG exists for Assortativity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Assortativity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%  Element.EXISTSTAG(Assortativity, TAG) throws error if TAG does NOT exist for Assortativity.
			%   Error id: [BRAPH2:Assortativity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Assortativity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			assortativity_tag_list = cellfun(@(x) Assortativity.getPropTag(x), num2cell(Assortativity.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, assortativity_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Assortativity.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Assortativity, POINTER) returns property number of POINTER of Assortativity.
			%  PROPERTY = M.GETPROPPROP(Assortativity, POINTER) returns property number of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Assortativity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				assortativity_tag_list = cellfun(@(x) Assortativity.getPropTag(x), num2cell(Assortativity.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, assortativity_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Assortativity, POINTER) returns tag of POINTER of Assortativity.
			%  TAG = M.GETPROPTAG(Assortativity, POINTER) returns tag of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Assortativity')
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
			%  CATEGORY = Element.GETPROPCATEGORY(Assortativity, POINTER) returns category of POINTER of Assortativity.
			%  CATEGORY = M.GETPROPCATEGORY(Assortativity, POINTER) returns category of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Assortativity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(Assortativity, POINTER) returns format of POINTER of Assortativity.
			%  FORMAT = M.GETPROPFORMAT(Assortativity, POINTER) returns format of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Assortativity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Assortativity, POINTER) returns description of POINTER of Assortativity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Assortativity, POINTER) returns description of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Assortativity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
			switch prop
				case Assortativity.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Assortativity.';
				case Assortativity.NAME
					prop_description = 'NAME (constant, string) is the name of the Assortativity.';
				case Assortativity.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Assortativity.';
				case Assortativity.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Assortativity.';
				case Assortativity.ID
					prop_description = 'ID (data, string) is a few-letter code of the Assortativity.';
				case Assortativity.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Assortativity.';
				case Assortativity.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Assortativity.';
				case Assortativity.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case Assortativity.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Assortativity.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Assortativity.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Assortativity.M
					prop_description = 'M (result, cell) is the cell containing the assortativity value.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Assortativity, POINTER) returns settings of POINTER of Assortativity.
			%  SETTINGS = M.GETPROPSETTINGS(Assortativity, POINTER) returns settings of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Assortativity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
			switch prop
				case Assortativity.TEMPLATE
					prop_settings = 'Assortativity';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Assortativity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Assortativity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Assortativity, POINTER) returns the default value of POINTER of Assortativity.
			%  DEFAULT = M.GETPROPDEFAULT(Assortativity, POINTER) returns the default value of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Assortativity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
			switch prop
				case Assortativity.ELCLASS
					prop_default = 'Assortativity';
				case Assortativity.NAME
					prop_default = 'Assortativity';
				case Assortativity.DESCRIPTION
					prop_default = 'The Assortativity coefficient (Assortativity) of a graph is the shortest path between all pairs of nodes within a layer of the graph. For weighted graphs, the assortativity is calculated with the Dijkstra algorithm using the inverse weight as the assortativity associated to the edge.';
				case Assortativity.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Assortativity.getPropSettings(prop));
				case Assortativity.ID
					prop_default = 'Assortativity ID';
				case Assortativity.LABEL
					prop_default = 'Assortativity label';
				case Assortativity.NOTES
					prop_default = 'Assortativity notes';
				case Assortativity.SHAPE
					prop_default = Measure.GLOBAL;
				case Assortativity.SCOPE
					prop_default = Measure.UNILAYER;
				case Assortativity.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Assortativity.COMPATIBLE_GRAPHS
					prop_default = {'GraphBU' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBU' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Assortativity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Assortativity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Assortativity, POINTER) returns the conditioned default value of POINTER of Assortativity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Assortativity, POINTER) returns the conditioned default value of POINTER of Assortativity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Assortativity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Assortativity.getPropProp(pointer);
			
			prop_default = Assortativity.conditioning(prop, Assortativity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Assortativity, PROP, VALUE) checks VALUE format for PROP of Assortativity.
			%  CHECK = M.CHECKPROP(Assortativity, PROP, VALUE) checks VALUE format for PROP of Assortativity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Assortativity:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Assortativity:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Assortativity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Assortativity.
			%   Error id: €BRAPH2.STR€:Assortativity:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Assortativity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Assortativity.
			%   Error id: €BRAPH2.STR€:Assortativity:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Assortativity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Assortativity.getPropProp(pointer);
			
			switch prop
				case Assortativity.TEMPLATE % __Assortativity.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Assortativity.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Assortativity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Assortativity.getPropTag(prop) ' (' Assortativity.getFormatTag(Assortativity.getPropFormat(prop)) ').'] ...
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
				case Assortativity.M % __Assortativity.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Assortativity.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					assortativity = cell(L, 1);
					connectivity_layer =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
					for li = 1:1:L
					    Aii = A{li, li};
					    [i, j] = find(triu(Aii) ~= 0);  % nodes [i, j]
					    M = length(i);  % Number of edges
					    k_i = zeros(M, L);
					    k_j = zeros(length(j), L);
					    
					    if connectivity_layer == Graph.BINARY 
					        
					        degree = Degree('G', g).get('M');        
					        d = degree{li};
					        
					    elseif connectivity_layer == Graph.WEIGHTED 
					        
					        strength = Strength('G', g).get('M');        
					        d = strength{li};
					    end
					    k_i(:, li) = d(i);  % degree/strength node i
					    k_j(:, li) = d(j);  % degree/strength node j
					    % compute assortativity
					    assortativity_layer = (sum(k_i(:, li) .* k_j(:, li)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2)...
					        / (sum(0.5 * (k_i(:, li).^2 + k_j(:, li).^2)) / M - (sum(0.5 * (k_i(:, li) + k_j(:, li))) / M)^2);
					    assortativity_layer(isnan(assortativity_layer)) = 0;  % Should return zeros, not NaN
					    assortativity(li) = {assortativity_layer};
					end
					
					value = assortativity;
					
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
