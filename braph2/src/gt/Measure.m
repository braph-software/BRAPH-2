classdef Measure < ConcreteElement
	%Measure is a measure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Measure provides the methods necessary for all graph measures. 
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	% 
	% The measures are characterized by their:
	% 
	%  SHAPE:
	%   Measure.GLOBAL. <strong>€Measure.GLOBAL_NAME€</strong>: €Measure.GLOBAL_DESCRIPTION€
	%   Measure.NODAL. <strong>€Measure.NODAL_NAME€</strong>: €Measure.NODAL_DESCRIPTION€
	%   Measure.BINODAL. <strong>€Measure.BINODAL_NAME€</strong>: €Measure.BINODAL_DESCRIPTION€
	% 
	%  SCOPE:
	%   Measure.SUPERGLOBAL. <strong>€Measure.SUPERGLOBAL_NAME€</strong>: €Measure.SUPERGLOBAL_DESCRIPTION€
	%   Measure.UNILAYER. <strong>€Measure.UNILAYER_NAME€</strong>: €Measure.UNILAYER_DESCRIPTION€
	%   Measure.BILAYER. <strong>€Measure.BILAYER_NAME€</strong>: €Measure.BILAYER_DESCRIPTION€
	%  
	%  PARAMETRICIY:
	%   Measure.PARAMETRIC. <strong>€Measure.PARAMETRIC_NAME€</strong>: €Measure.PARAMETRIC_DESCRIPTION€
	%   Measure.NONPARAMETRIC. <strong>€Measure.NONPARAMETRIC_NAME€</strong>: €Measure.NONPARAMETRIC_DESCRIPTION€
	%
	% Measure methods (constructor):
	%  Measure - constructor
	%
	% Measure methods:
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
	% Measure methods (display):
	%  tostring - string with information about the graph measure
	%  disp - displays information about the graph measure
	%  tree - displays the tree of the graph measure
	%
	% Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph measure
	%
	% Measure methods (save/load, Static):
	%  save - saves BRAPH2 graph measure as b2 file
	%  load - loads a BRAPH2 graph measure from a b2 file
	%
	% Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph measure
	%
	% Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph measure
	%
	% Measure methods (inspection, Static):
	%  getClass - returns the class of the graph measure
	%  getSubclasses - returns all subclasses of Measure
	%  getProps - returns the property list of the graph measure
	%  getPropNumber - returns the property number of the graph measure
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
	% Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Measure constants</a>.
	%
	%
	% See also Graph.
	
	properties (Constant) % constants
		% Measure shape
		GLOBAL = 1  
		GLOBAL_NAME = 'Global'
		GLOBAL_DESCRIPTION = ['Global measure refers to global properties of ' ... 
		'a single layer graph and, therefore, consists of a single number for each graph.']
		
		NODAL = 2
		NODAL_NAME = 'Nodal'
		NODAL_DESCRIPTION = ['Nodal measure refers to properties of the nodes of' ... 
		'a single layer graph and, therefore, consists of a vector of numbers, ' ...
		'one for each node of the graph.']
		
		BINODAL = 3
		BINODAL_NAME = 'Binodal'
		BINODAL_DESCRIPTION = ['Binodal measure refers to properties between nodes of' ... 
		'a single layer graph and, therefore, consists of a matrix of numbers, ' ...
		'one for each node of the graph.']
		
		SHAPE_NUMBER = 3
		
		SHAPE_NAME = {
		    Measure.GLOBAL_NAME
		    Measure.NODAL_NAME
		    Measure.BINODAL_NAME
		    }
		
		SHAPE_DESCRIPTION = {
		    Measure.GLOBAL_DESCRIPTION
		    Measure.NODAL_DESCRIPTION
		    Measure.BINODAL_DESCRIPTION
		    }
		
		% Measure scope
		SUPERGLOBAL = 1
		SUPERGLOBAL_NAME = 'Superglobal'
		SUPERGLOBAL_DESCRIPTION = ['Superglobal measure consists of a single ' ...
		    'number for each non single layer graphs.']
		
		UNILAYER = 2
		UNILAYER_NAME = 'Unilayer'
		UNILAYER_DESCRIPTION = ['Unilayer measure consists of a vector with ' ... 
		'nodal/binodal/global measures for every layer.']
		
		BILAYER = 3
		BILAYER_NAME = 'Bilayer'
		BILAYER_DESCRIPTION = ['Bilayer measure consists of a matrix with '... 
		    'nodal/binodal/global measures between layers.']
		
		SCOPE_NUMBER = 3
		
		SCOPE_NAME = {
		    Measure.SUPERGLOBAL_NAME
		    Measure.UNILAYER_NAME
		    Measure.BILAYER_NAME
		    }
		
		SCOPE_DESCRIPTION = {
		    Measure.SUPERGLOBAL_DESCRIPTION
		    Measure.UNILAYER_DESCRIPTION
		    Measure.BILAYER_DESCRIPTION
		    }
		
		% Parametricity
		PARAMETRIC = 1
		PARAMETRIC_NAME = 'Parametric'
		PARAMETRIC_DESCRIPTION = ['Parametric measure consists of a measure ' ...
		    'that outputs the results based on a parameter.']
		
		NONPARAMETRIC = 2
		NONPARAMETRIC_NAME = 'Non-parametric'
		NONPARAMETRIC_DESCRIPTION = ['Non-parametric measure consists of a measure ' ...
		    'where the results are not based on a parameter.']
		
		PARAMETRICITY_NUMBER = 2
		
		PARAMETRICITY_NAME = {
		    Measure.PARAMETRIC_NAME
		    Measure.NONPARAMETRIC_NAME
		    }
		
		PARAMETRICITY_DESCRIPTION = {
		    Measure.PARAMETRIC_DESCRIPTION
		    Measure.NONPARAMETRIC_DESCRIPTION
		    }
	end
	properties (Constant) % properties
		SHAPE = ConcreteElement.getPropNumber() + 1;
		SHAPE_TAG = 'SHAPE';
		SHAPE_CATEGORY = Category.CONSTANT;
		SHAPE_FORMAT = Format.SCALAR;
		
		SCOPE = ConcreteElement.getPropNumber() + 2;
		SCOPE_TAG = 'SCOPE';
		SCOPE_CATEGORY = Category.CONSTANT;
		SCOPE_FORMAT = Format.SCALAR;
		
		PARAMETRICITY = ConcreteElement.getPropNumber() + 3;
		PARAMETRICITY_TAG = 'PARAMETRICITY';
		PARAMETRICITY_CATEGORY = Category.CONSTANT;
		PARAMETRICITY_FORMAT = Format.SCALAR;
		
		COMPATIBLE_GRAPHS = ConcreteElement.getPropNumber() + 4;
		COMPATIBLE_GRAPHS_TAG = 'COMPATIBLE_GRAPHS';
		COMPATIBLE_GRAPHS_CATEGORY = Category.CONSTANT;
		COMPATIBLE_GRAPHS_FORMAT = Format.CLASSLIST;
		
		G = ConcreteElement.getPropNumber() + 5;
		G_TAG = 'G';
		G_CATEGORY = Category.DATA;
		G_FORMAT = Format.ITEM;
		
		M = ConcreteElement.getPropNumber() + 6;
		M_TAG = 'M';
		M_CATEGORY = Category.RESULT;
		M_FORMAT = Format.CELL;
		
		PFM = ConcreteElement.getPropNumber() + 7;
		PFM_TAG = 'PFM';
		PFM_CATEGORY = Category.GUI;
		PFM_FORMAT = Format.ITEM;
	end
	methods % constructor
		function m = Measure(varargin)
			%Measure() creates a graph measure.
			%
			% Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Measure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the graph measure.
			%
			% CLASS = Measure.GETCLASS() returns the class 'Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the graph measure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Measure') returns 'Measure'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Measure')
			%  are less computationally efficient.
			
			m_class = 'Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph measure.
			%
			% LIST = Measure.GETSUBCLASSES() returns all subclasses of 'Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the graph measure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Measure') returns all subclasses of 'Measure'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Measure', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph measure.
			%
			% PROPS = Measure.GETPROPS() returns the property list of graph measure
			%  as a row vector.
			%
			% PROPS = Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the graph measure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Measure'[, CATEGORY]) returns the property list of 'Measure'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Measure.SHAPE ...
						Measure.SCOPE ...
						Measure.PARAMETRICITY ...
						Measure.COMPATIBLE_GRAPHS ...
						Measure.G ...
						Measure.M ...
						Measure.PFM ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						Measure.SHAPE ...
						Measure.SCOPE ...
						Measure.PARAMETRICITY ...
						Measure.COMPATIBLE_GRAPHS ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						Measure.G ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						Measure.M ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						Measure.PFM ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph measure.
			%
			% N = Measure.GETPROPNUMBER() returns the property number of graph measure.
			%
			% N = Measure.GETPROPNUMBER(CATEGORY) returns the property number of graph measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the graph measure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Measure') returns the property number of 'Measure'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Measure.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Measure, PROP) checks whether PROP exists for Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(Measure, PROP) throws error if PROP does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Measure.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Measure, TAG) checks whether TAG exists for Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(Measure, TAG) throws error if TAG does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measure_tag_list = cellfun(@(x) Measure.getPropTag(x), num2cell(Measure.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measure_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Measure.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%  PROPERTY = M.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measure_tag_list = cellfun(@(x) Measure.getPropTag(x), num2cell(Measure.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measure_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%  TAG = M.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Measure.SHAPE
						tag = Measure.SHAPE_TAG;
					case Measure.SCOPE
						tag = Measure.SCOPE_TAG;
					case Measure.PARAMETRICITY
						tag = Measure.PARAMETRICITY_TAG;
					case Measure.COMPATIBLE_GRAPHS
						tag = Measure.COMPATIBLE_GRAPHS_TAG;
					case Measure.G
						tag = Measure.G_TAG;
					case Measure.M
						tag = Measure.M_TAG;
					case Measure.PFM
						tag = Measure.PFM_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%  CATEGORY = M.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE
					prop_category = Measure.SHAPE_CATEGORY;
				case Measure.SCOPE
					prop_category = Measure.SCOPE_CATEGORY;
				case Measure.PARAMETRICITY
					prop_category = Measure.PARAMETRICITY_CATEGORY;
				case Measure.COMPATIBLE_GRAPHS
					prop_category = Measure.COMPATIBLE_GRAPHS_CATEGORY;
				case Measure.G
					prop_category = Measure.G_CATEGORY;
				case Measure.M
					prop_category = Measure.M_CATEGORY;
				case Measure.PFM
					prop_category = Measure.PFM_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%  FORMAT = M.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE
					prop_format = Measure.SHAPE_FORMAT;
				case Measure.SCOPE
					prop_format = Measure.SCOPE_FORMAT;
				case Measure.PARAMETRICITY
					prop_format = Measure.PARAMETRICITY_FORMAT;
				case Measure.COMPATIBLE_GRAPHS
					prop_format = Measure.COMPATIBLE_GRAPHS_FORMAT;
				case Measure.G
					prop_format = Measure.G_FORMAT;
				case Measure.M
					prop_format = Measure.M_FORMAT;
				case Measure.PFM
					prop_format = Measure.PFM_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape.';
				case Measure.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope.';
				case Measure.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure.';
				case Measure.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Measure.G
					prop_description = 'G (data, item) is the measure graph.';
				case Measure.M
					prop_description = 'M (result, cell) is the measure result.';
				case Measure.PFM
					prop_description = 'PFM (gui, item) contains the panel figure of the measure.';
				case Measure.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graph measure.';
				case Measure.NAME
					prop_description = 'NAME (constant, string) is the name of the graph measure.';
				case Measure.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph measure.';
				case Measure.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph measure.';
				case Measure.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph measure.';
				case Measure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph measure.';
				case Measure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph measure.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%  SETTINGS = M.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Measure.SCOPE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Measure.PARAMETRICITY
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Measure.COMPATIBLE_GRAPHS
					prop_settings = 'Graph';
				case Measure.G
					prop_settings = 'Graph';
				case Measure.M
					prop_settings = Format.getFormatSettings(Format.CELL);
				case Measure.PFM
					prop_settings = 'MeasurePF';
				case Measure.TEMPLATE
					prop_settings = 'Measure';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE
					prop_default = Measure.NODAL;
				case Measure.SCOPE
					prop_default = Measure.UNILAYER;
				case Measure.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Measure.COMPATIBLE_GRAPHS
					prop_default = Format.getFormatDefault(Format.CLASSLIST, Measure.getPropSettings(prop));
				case Measure.G
					prop_default = Format.getFormatDefault(Format.ITEM, Measure.getPropSettings(prop));
				case Measure.M
					prop_default = Format.getFormatDefault(Format.CELL, Measure.getPropSettings(prop));
				case Measure.PFM
					prop_default = Format.getFormatDefault(Format.ITEM, Measure.getPropSettings(prop));
				case Measure.ELCLASS
					prop_default = 'Measure';
				case Measure.NAME
					prop_default = 'Measure';
				case Measure.DESCRIPTION
					prop_default = 'A Measure provides the methods necessary for all graph measures. Instances of this class should not be created. Use one of its subclasses instead.';
				case Measure.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Measure.getPropSettings(prop));
				case Measure.ID
					prop_default = 'Measure ID';
				case Measure.LABEL
					prop_default = 'Measure label';
				case Measure.NOTES
					prop_default = 'Measure notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			prop_default = Measure.conditioning(prop, Measure.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			%  CHECK = M.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Measure:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Measure:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: €BRAPH2.STR€:Measure:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: €BRAPH2.STR€:Measure:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case Measure.SHAPE % __Measure.SHAPE__
					check = Format.checkFormat(Format.SCALAR, value, Measure.getPropSettings(prop));
				case Measure.SCOPE % __Measure.SCOPE__
					check = Format.checkFormat(Format.SCALAR, value, Measure.getPropSettings(prop));
				case Measure.PARAMETRICITY % __Measure.PARAMETRICITY__
					check = Format.checkFormat(Format.SCALAR, value, Measure.getPropSettings(prop));
				case Measure.COMPATIBLE_GRAPHS % __Measure.COMPATIBLE_GRAPHS__
					check = Format.checkFormat(Format.CLASSLIST, value, Measure.getPropSettings(prop));
				case Measure.G % __Measure.G__
					check = Format.checkFormat(Format.ITEM, value, Measure.getPropSettings(prop));
				case Measure.M % __Measure.M__
					check = Format.checkFormat(Format.CELL, value, Measure.getPropSettings(prop));
				case Measure.PFM % __Measure.PFM__
					check = Format.checkFormat(Format.ITEM, value, Measure.getPropSettings(prop));
				case Measure.TEMPLATE % __Measure.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Measure.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Measure.getPropTag(prop) ' (' Measure.getFormatTag(Measure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(m, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case Measure.PFM % __Measure.PFM__
					if isa(m.getr('PFM'), 'NoValue')
					    switch m.get('SHAPE')
					        case Measure.GLOBAL % __Measure.GLOBAL__
					            switch m.get('SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    m.set('PFM', MeasurePF_GS('M', m))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    m.set('PFM', MeasurePF_GU('M', m))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    m.set('PFM', MeasurePF_GB('M', m))
					            end
					        case Measure.NODAL % __Measure.NODAL__
					            switch m.get('SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    m.set('PFM', MeasurePF_NS('M', m))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    m.set('PFM', MeasurePF_NU('M', m))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    m.set('PFM', MeasurePF_NB('M', m))
					            end
					        case Measure.BINODAL % __Measure.BINODAL__
					            switch m.get('SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    m.set('PFM', MeasurePF_BS('M', m))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    m.set('PFM', MeasurePF_BU('M', m))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    m.set('PFM', MeasurePF_BB('M', m))
					            end
					    end
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(m, prop);
					end
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
				case Measure.M % __Measure.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Measure.M), 'twister')
					
					value = {};
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(m, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case Measure.M % __Measure.M__
					g = m.get('G');
					
					pr = PanelPropCell('EL', m, 'PROP', Measure.M, varargin{:});
					
					if m.get('SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if m.get('SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif m.get('SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif m.get('SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(s(3) + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case Measure.PFM % __Measure.PFM__
					pr = PanelPropItem('EL', m, 'PROP', Measure.PFM, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' m.get('LABEL')], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(m, prop, varargin{:});
					
			end
		end
	end
end
