classdef CommunityStructure < Measure
	% CommunityStructure is the graph community structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The community structure of a graph is a subdivision of the network into
	% non-overlapping groups of nodes which maximizes the number of whitin group
	% edges, and minimizes the number of between group edges.
	%
	% The list of CommunityStructure properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the triangles.
	%  <strong>6</strong> <strong>rule</strong> 	rule (parameter, OPTION) is the community structure algorithm.
	%  <strong>7</strong> <strong>gamma</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
	%  <strong>8</strong> <strong>m0</strong> 	M0 (data, rvector) is the initial community affiliation vector.
	%  <strong>9</strong> <strong>louvain_om</strong> 	Louvain_OM (data, MATRIX) is the custom objective matrix (Louvain).
	%  <strong>10</strong> <strong>om_type</strong> 	OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).
	%  <strong>11</strong> <strong>quality_function</strong> 	QUALITY_FUNCTION (metadata, SCALAR)
	%
	% CommunityStructure methods (constructor):
	% CommunityStructure - constructor
	%
	% CommunityStructure methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in community structure/error.
	%  existsProp - checks whether property exists in community structure/error.
	%  getPropNumber - returns the property number of community structure.
	%  getProps - returns the property list of community structure.
	%  getDescription - returns the description of the community structure.
	%  getName - returns the name of the community structure.
	%  getClass - returns the class of the community structure.
	%  getCompatibleGraphNumber - returns the number of compatible graphs.
	%  getCompatibleGraphList - returns the list of graphs.
	%  getMeasureParametricity - returns the parametricity of the measure.
	%  getMeasureScope - returns the measure scope.
	%  getMeasureShape - returns the measure shape.
	%  getList - T returns the list of measures
	%  is_nonparametric - checks if measure is non-parametric.
	%  is_parametric - checks if measure is parametric.
	%  is_bilayer - checks if measure is bi-layer.
	%  is_unilayer - checks if measure is unilayer.
	%  is_superglobal - checks if measure is superglobal.
	%  is_binodal - checks if measure is bi-nodal.
	%  is_nodal - checks if measure is nodal.
	%  is_global - checks if measure is global.
	%
	% CommunityStructure methods:
	%  community - tructure/community is a function.
	%  getPlotProp - returns a prop plot.
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% CommunityStructure methods (operators):
	%  isequal - determines whether two CommunityStructure are equal (values, locked)
	%
	% CommunityStructure methods (display):
	%  tostring - string with information about the CommunityStructure
	%  disp - displays information about the CommunityStructure
	%  tree - displays the element of CommunityStructure
	%
	% CommunityStructure method (element list):
	%  getElementList - returns a list with all subelements of CommunityStructure
	%
	% CommunityStructure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the CommunityStructure
	%
	% CommunityStructure method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the CommunityStructure
	%
	% CommunityStructure methods (copy):
	%  copy - copies the CommunityStructure
	%  deepclone - deep-clones the CommunityStructure
	%  clone - clones the CommunityStructure
	%
	% CommunityStructure methods (inspection, Static):
	%  getClass - returns CommunityStructure
	%  getName - returns the name of CommunityStructure
	%  getDescription - returns the description of CommunityStructure
	%  getProps - returns the property list of CommunityStructure
	%  getPropNumber - returns the property number of CommunityStructure
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% CommunityStructure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CommunityStructure methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% CommunityStructure methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% CommunityStructure methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% CommunityStructure properties (Constant).
	%  RULE - 6
	%  RULE_TAG - 'rule'
	%  RULE_CATEGORY - 'p'
	%  RULE_FORMAT - 'op'
	%  GAMMA - 7
	%  GAMMA_TAG - 'gamma'
	%  GAMMA_CATEGORY - 'p'
	%  GAMMA_FORMAT - 'nn'
	%  M0 - 8
	%  M0_TAG - 'm0'
	%  M0_CATEGORY - 'd'
	%  M0_FORMAT - 'nr'
	%  LOUVAIN_OM - 9
	%  LOUVAIN_OM_TAG - 'louvain_om'
	%  LOUVAIN_OM_CATEGORY - 'd'
	%  LOUVAIN_OM_FORMAT - 'nm'
	%  OM_TYPE - 10
	%  OM_TYPE_TAG - 'om_type'
	%  OM_TYPE_CATEGORY - 'd'
	%  OM_TYPE_FORMAT - 'op'
	%  QUALITY_FUNCTION - 11
	%  QUALITY_FUNCTION_TAG - 'quality_function'
	%  QUALITY_FUNCTION_CATEGORY - 'm'
	%  QUALITY_FUNCTION_FORMAT - 'nn'
	%  GLOBAL - 1
	%  GLOBAL_NAME - 'Global'
	%  GLOBAL_DESCRIPTION - 'Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.'
	%  NODAL - 2
	%  NODAL_NAME - 'Nodal'
	%  NODAL_DESCRIPTION - 'Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.'
	%  BINODAL - 3
	%  BINODAL_NAME - 'Binodal'
	%  BINODAL_DESCRIPTION - 'Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.'
	%  SHAPE_NUMBER - 3
	%  SHAPE_NAME - cell[3 1] { 'Global' 'Nodal' 'Binodal' }
	%  SHAPE_DESCRIPTION - cell[3 1] { 'Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.' 'Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.' 'Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.' }
	%  SUPERGLOBAL - 1
	%  SUPERGLOBAL_NAME - 'Superglobal'
	%  SUPERGLOBAL_DESCRIPTION - 'Superglobal measure consists of a single number for each non single layer graphs.'
	%  UNILAYER - 2
	%  UNILAYER_NAME - 'Unilayer'
	%  UNILAYER_DESCRIPTION - 'Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.'
	%  BILAYER - 3
	%  BILAYER_NAME - 'Bilayer'
	%  BILAYER_DESCRIPTION - 'Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.'
	%  SCOPE_NUMBER - 3
	%  SCOPE_NAME - cell[3 1] { 'Superglobal' 'Unilayer' 'Bilayer' }
	%  SCOPE_DESCRIPTION - cell[3 1] { 'Superglobal measure consists of a single number for each non single layer graphs.' 'Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.' 'Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.' }
	%  PARAMETRIC - 1
	%  PARAMETRIC_NAME - 'Parametric'
	%  PARAMETRIC_DESCRIPTION - 'Parametric measure consists of a measure that outputs the results based on a parameter.'
	%  NONPARAMETRIC - 2
	%  NONPARAMETRIC_NAME - 'Non-parametric'
	%  NONPARAMETRIC_DESCRIPTION - 'Non-parametric measure consists of a measure where the results are not based on a parameter.'
	%  PARAMETRICITY_NUMBER - 2
	%  PARAMETRICITY_NAME - cell[2 1] { 'Parametric' 'Non-parametric' }
	%  PARAMETRICITY_DESCRIPTION - cell[2 1] { 'Parametric measure consists of a measure that outputs the results based on a parameter.' 'Non-parametric measure consists of a measure where the results are not based on a parameter.' }
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  LABEL - 2
	%  LABEL_TAG - 'label'
	%  LABEL_CATEGORY - 'm'
	%  LABEL_FORMAT - 'st'
	%  NOTES - 3
	%  NOTES_TAG - 'notes'
	%  NOTES_CATEGORY - 'm'
	%  NOTES_FORMAT - 'st'
	%  G - 4
	%  G_TAG - 'g'
	%  G_CATEGORY - 'd'
	%  G_FORMAT - 'it'
	%  M - 5
	%  M_TAG - 'm'
	%  M_CATEGORY - 'r'
	%  M_FORMAT - 'll'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
	%
	% See also Measure.
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'rule';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
		
		GAMMA = Measure.getPropNumber() + 2;
		GAMMA_TAG = 'gamma';
		GAMMA_CATEGORY = Category.PARAMETER;
		GAMMA_FORMAT = Format.SCALAR;
		
		M0 = Measure.getPropNumber() + 3;
		M0_TAG = 'm0';
		M0_CATEGORY = Category.DATA;
		M0_FORMAT = Format.RVECTOR;
		
		LOUVAIN_OM = Measure.getPropNumber() + 4;
		LOUVAIN_OM_TAG = 'louvain_om';
		LOUVAIN_OM_CATEGORY = Category.DATA;
		LOUVAIN_OM_FORMAT = Format.MATRIX;
		
		OM_TYPE = Measure.getPropNumber() + 5;
		OM_TYPE_TAG = 'om_type';
		OM_TYPE_CATEGORY = Category.DATA;
		OM_TYPE_FORMAT = Format.OPTION;
		
		QUALITY_FUNCTION = Measure.getPropNumber() + 6;
		QUALITY_FUNCTION_TAG = 'quality_function';
		QUALITY_FUNCTION_CATEGORY = Category.METADATA;
		QUALITY_FUNCTION_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the community structure.
			%
			% CLASS = CommunityStructure.GETCLASS() returns the class 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('CommunityStructure') returns 'CommunityStructure'.
			%
			% See also getName, getDescription.
			
			m_class = 'CommunityStructure';
		end
		function m_name = getName()
			%GETNAME returns the name of the community structure.
			%
			% NAME = CommunityStructure.GETNAME() returns the name of the 'community structure'.
			%  Community Structure.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the community structure M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('CommunityStructure') returns the name of 'CommunityStructure'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Community Structure';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the community structure.
			%
			% STR = CommunityStructure.GETDESCRIPTION() returns the description of the 'community structure'.
			%  which is:
			%
			%  The community structure of a graph is a subdivision of the network into
			%  non-overlapping groups of nodes which maximizes the number of whitin group
			%  edges, and minimizes the number of between group edges.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the community structure M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('CommunityStructure') returns the description of 'CommunityStructure'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The community structure of a graph is a subdivision of the network into' ...
				'non-overlapping groups of nodes which maximizes the number of whitin group' ...
				'edges, and minimizes the number of between group edges.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of community structure.
			%
			% PROPS = CommunityStructure.GETPROPS() returns the property list of community structure.
			%
			% PROPS = CommunityStructure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('CommunityStructure'[, CATEGORY]) returns the property list of 'CommunityStructure'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Measure.getProps(Category.METADATA)
						CommunityStructure.QUALITY_FUNCTION
						];
				case Category.PARAMETER
					prop_list = [
						Measure.getProps(Category.PARAMETER)
						CommunityStructure.RULE
						CommunityStructure.GAMMA
						];
				case Category.DATA
					prop_list = [
						Measure.getProps(Category.DATA)
						CommunityStructure.M0
						CommunityStructure.LOUVAIN_OM
						CommunityStructure.OM_TYPE
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Measure.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Measure.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Measure.getProps()
						CommunityStructure.RULE
						CommunityStructure.GAMMA
						CommunityStructure.M0
						CommunityStructure.LOUVAIN_OM
						CommunityStructure.OM_TYPE
						CommunityStructure.QUALITY_FUNCTION
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of community structure.
			%
			% N = CommunityStructure.GETPROPNUMBER() returns the property number of community structure.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('CommunityStructure') returns the property number of 'CommunityStructure'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 11;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(CommunityStructure, PROP) checks whether PROP exists for CommunityStructure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(CommunityStructure, PROP) throws error if PROP does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11 ]);
			else
				assert( ...
					CommunityStructure.existsProp(prop), ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CommunityStructure.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(CommunityStructure, TAG) checks whether TAG exists for CommunityStructure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(CommunityStructure, TAG) throws error if TAG does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				communitystructure_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'rule'  'gamma'  'm0'  'louvain_om'  'om_type'  'quality_function' };
				
				check = any(strcmpi(tag, communitystructure_tag_list));
			else
				assert( ...
					CommunityStructure.existsTag(tag), ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for CommunityStructure'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%  PROPERTY = M.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				communitystructure_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'rule'  'gamma'  'm0'  'louvain_om'  'om_type'  'quality_function' };
				
				tag = pointer;
				CommunityStructure.existsTag(tag);
				
				prop = find(strcmpi(tag, communitystructure_tag_list));
			else % numeric
				prop = pointer;
				CommunityStructure.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%  TAG = M.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				CommunityStructure.existsTag(tag);
			else % numeric
				prop = pointer;
				CommunityStructure.existsProp(prop);
				
				switch prop
					case CommunityStructure.RULE
						tag = CommunityStructure.RULE_TAG;
					case CommunityStructure.GAMMA
						tag = CommunityStructure.GAMMA_TAG;
					case CommunityStructure.M0
						tag = CommunityStructure.M0_TAG;
					case CommunityStructure.LOUVAIN_OM
						tag = CommunityStructure.LOUVAIN_OM_TAG;
					case CommunityStructure.OM_TYPE
						tag = CommunityStructure.OM_TYPE_TAG;
					case CommunityStructure.QUALITY_FUNCTION
						tag = CommunityStructure.QUALITY_FUNCTION_TAG;
					otherwise
						tag = getPropTag@Measure(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%  CATEGORY = M.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_category = CommunityStructure.RULE_CATEGORY;
				case CommunityStructure.GAMMA
					prop_category = CommunityStructure.GAMMA_CATEGORY;
				case CommunityStructure.M0
					prop_category = CommunityStructure.M0_CATEGORY;
				case CommunityStructure.LOUVAIN_OM
					prop_category = CommunityStructure.LOUVAIN_OM_CATEGORY;
				case CommunityStructure.OM_TYPE
					prop_category = CommunityStructure.OM_TYPE_CATEGORY;
				case CommunityStructure.QUALITY_FUNCTION
					prop_category = CommunityStructure.QUALITY_FUNCTION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%  FORMAT = M.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_format = CommunityStructure.RULE_FORMAT;
				case CommunityStructure.GAMMA
					prop_format = CommunityStructure.GAMMA_FORMAT;
				case CommunityStructure.M0
					prop_format = CommunityStructure.M0_FORMAT;
				case CommunityStructure.LOUVAIN_OM
					prop_format = CommunityStructure.LOUVAIN_OM_FORMAT;
				case CommunityStructure.OM_TYPE
					prop_format = CommunityStructure.OM_TYPE_FORMAT;
				case CommunityStructure.QUALITY_FUNCTION
					prop_format = CommunityStructure.QUALITY_FUNCTION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_description = 'rule (parameter, OPTION) is the community structure algorithm.';
				case CommunityStructure.GAMMA
					prop_description = 'GAMMA (parameter, SCALAR) is the resolution parameter.';
				case CommunityStructure.M0
					prop_description = 'M0 (data, rvector) is the initial community affiliation vector.';
				case CommunityStructure.LOUVAIN_OM
					prop_description = 'Louvain_OM (data, MATRIX) is the custom objective matrix (Louvain).';
				case CommunityStructure.OM_TYPE
					prop_description = 'OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).';
				case CommunityStructure.QUALITY_FUNCTION
					prop_description = 'QUALITY_FUNCTION (metadata, SCALAR)';
				case CommunityStructure.M
					prop_description = 'M (result, cell) is the triangles.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%  SETTINGS = M.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_settings = { 'louvain' 'newman' 'fixed'};
				case CommunityStructure.GAMMA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CommunityStructure.M0
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CommunityStructure.LOUVAIN_OM
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case CommunityStructure.OM_TYPE
					prop_settings = {'modularity' 'potts' 'negative_sym' 'negative_asym'};
				case CommunityStructure.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_default = 'louvain';
				case CommunityStructure.GAMMA
					prop_default = 1;
				case CommunityStructure.M0
					prop_default = [];
				case CommunityStructure.LOUVAIN_OM
					prop_default = [];
				case CommunityStructure.OM_TYPE
					prop_default = 'modularity';
				case CommunityStructure.QUALITY_FUNCTION
					prop_default = Format.getFormatDefault(Format.SCALAR, CommunityStructure.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			prop_default = CommunityStructure.conditioning(prop, CommunityStructure.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			%  CHECK = M.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  M.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					check = Format.checkFormat(Format.OPTION, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.GAMMA
					check = Format.checkFormat(Format.SCALAR, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.M0
					check = Format.checkFormat(Format.RVECTOR, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.LOUVAIN_OM
					check = Format.checkFormat(Format.MATRIX, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.OM_TYPE
					check = Format.checkFormat(Format.OPTION, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.QUALITY_FUNCTION
					check = Format.checkFormat(Format.SCALAR, value, CommunityStructure.getPropSettings(prop));
				otherwise
					check = checkProp@Measure(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CommunityStructure.getPropTag(prop) ' (' CommunityStructure.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = CommunityStructure.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = CommunityStructure.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = CommunityStructure.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of CommunityStructure compatible graphs.
			%
			% LIST = CommunityStructure.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help GraphWD">GraphWD</a>
			%  <a href="matlab:help GraphBU">GraphBU</a>
			%  <a href="matlab:help GraphBD">GraphBD</a>
			%  <a href="matlab:help MultigraphBUD">MultigraphBUD</a>
			%  <a href="matlab:help MultigraphBUT">MultigraphBUT</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWU', ...
				'GraphWD', ...
				'GraphBU', ...
				'GraphBD', ...
				'MultigraphBUD', ...
				'MultigraphBUT', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (6) of CommunityStructure compatible graphs.
			%
			% 6 = CommunityStructure.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('CommunityStructure');
		end
	end
	methods % constructor
		function m = CommunityStructure(varargin)
			% CommunityStructure() creates a community structure.
			%
			% CommunityStructure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CommunityStructure(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CommunityStructure properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the triangles.
			%  <strong>6</strong> <strong>rule</strong> 	rule (parameter, OPTION) is the community structure algorithm.
			%  <strong>7</strong> <strong>gamma</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
			%  <strong>8</strong> <strong>m0</strong> 	M0 (data, rvector) is the initial community affiliation vector.
			%  <strong>9</strong> <strong>louvain_om</strong> 	Louvain_OM (data, MATRIX) is the custom objective matrix (Louvain).
			%  <strong>10</strong> <strong>om_type</strong> 	OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).
			%  <strong>11</strong> <strong>quality_function</strong> 	QUALITY_FUNCTION (metadata, SCALAR)
			%
			% See also Category, Format, set, check.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Measure.getPropNumber()
						value = conditioning@Measure(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case CommunityStructure.M
					g = m.get('G');  % graph from measure class
					A = g.get('A');
					community_structure = cell(g.layernumber(), 1);
					N = g.nodenumber();
					gamma = m.get('gamma');
					community_structure_algorithm = m.get('rule');
					
					for li = 1:1:g.layernumber()
					    Aii = A{li, li};
					    community_structure(li) =  m.community(Aii, N(li), gamma, community_structure_algorithm);
					end
					
					value = community_structure;
					
				otherwise
					value = calculateValue@Measure(m, prop);
					
			end
		end
	end
	methods % methods
		function comm_str = community(m, A, N, gamma, community_structure_algorithm)
		A = A;
		N = N;
		gamma = gamma;
		community_structure_algorithm = community_structure_algorithm;
		    switch lower(community_structure_algorithm)
		        case {'fixed'}
		            M0 = m.get('M0');
		            assert(isequal(size(M0, 2), size(1:N, 2)), ...
		                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
		                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
		                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
		            community_structure = {M0'};
		
		        case {'newman'}  % Newman algorithm
		            if g.is_directed(g)  % directed graphs
		                n_perm = randperm(N);  % randomly permute order of nodes
		                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
		                Ki = sum(A, 1);  % in-degree
		                Ko = sum(A, 2);  % out-degree
		                mo = sum(Ki);  % number of edges
		                b = A - gamma*(Ko*Ki).'/mo;
		                B = b+b.';  % directed modularity matrix
		                Ci = ones(N,1);  % community indices
		                cn = 1;  % number of communities
		                U = [1 0];  % array of unexamined communites
		
		                ind = 1:N;
		                Bg = B;
		                Ng = N;
		
		                while U(1)  % examine community U(1)
		                    [V, D] = eig(Bg);
		                    [d1, i1] = max(real(diag(D)));  % most positive eigenvalue of Bg
		                    v1 = V(:,i1);  % corresponding eigenvector
		                    S = ones(Ng,1);
		                    S(v1 < 0) = -1;
		                    q = S.' * Bg * S;  % contribution to modularity
		
		                    if q > 1e-10  % contribution positive: U(1) is divisible
		                        qmax = q;  % maximal contribution to modularity
		                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
		                        indg = ones(Ng, 1);  % array of unmoved indices
		                        Sit = S;
		                        while any(indg)  % iterative fine-tuning
		                            Qit = qmax - 4*Sit.*(Bg*Sit);  % this line is equivalent to:
		                            qmax = max(Qit.*indg);  % for i=1:Ng
		                            imax = (Qit==qmax);  % Sit(i)=-Sit(i);
		                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
		                            indg(imax) = nan;  % Sit(i)=-Sit(i);
		                            if qmax > q  % end
		                                q = qmax;
		                                S = Sit;
		                            end
		                        end
		
		                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
		                            U(1) = [];
		                        else
		                            cn = cn + 1;
		                            Ci(ind(S == 1)) = U(1);  % split old U(1) into new U(1) and into cn
		                            Ci(ind(S == -1)) = cn;
		                            U = [cn, U];
		                        end
		                    else  % contribution nonpositive: U(1) is indivisible
		                        U(1) = [];
		                    end
		
		                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
		                    bg = B(ind, ind);
		                    Bg = bg - diag(sum(bg));  % modularity matrix for U(1)
		                    Ng = length(ind);  % number of vertices in U(1)
		                end
		
		                s = Ci(:, ones(1, N));  % compute modularity
		                Q =~ (s-s.').*B/(2*mo);
		                Q = sum(Q(:));
		                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
		                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
		                Ci = Ci_corrected;  % output corrected community assignments
		
		                m.set('QUALITY_FUNCTION', Q);   % save normalized quality function/modularity
		                community_structure = {Ci};
		
		            else  % directed graphs
		                n_perm = randperm(N);  % randomly permute order of nodes
		                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
		                K = sum(A);  % degree
		                mo = sum(K);  % number of edges (each undirected edge is counted twice)
		                B = A - gamma*(K.'*K)/mo;  % modularity matrix
		                Ci = ones(N, 1);  % community indices
		                cn = 1;  % number of communities
		                U = [1 0];  % array of unexamined communites
		
		                ind = 1:N;
		                Bg = B;
		                Ng = N;
		
		                while U(1)  % examine community U(1)
		                    [V, D] = eig(Bg);
		                    [d1, i1] = max(real(diag(D)));  % maximal positive (real part of) eigenvalue of Bg
		                    v1 = V(:,i1);  % corresponding eigenvector
		
		                    S = ones(Ng,1);
		                    S(v1<0) = -1;
		                    q = S.'*Bg*S;  % contribution to modularity
		
		                    if q > 1e-10  % contribution positive: U(1) is divisible
		                        qmax = q;  % maximal contribution to modularity
		                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
		                        indg = ones(Ng, 1);  % array of unmoved indices
		                        Sit = S;
		                        while any(indg)  % iterative fine-tuning
		                            Qit = qmax-  4*Sit.*(Bg*Sit);  % this line is equivalent to:
		                            qmax = max(Qit.*indg);  % for i=1:Ng
		                            imax = (Qit == qmax);  % Sit(i)=-Sit(i);
		                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
		                            indg(imax) = nan;  % Sit(i)=-Sit(i);
		                            if qmax > q  % end
		                                q = qmax;
		                                S = Sit;
		                            end
		                        end
		
		                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
		                            U(1) = [];
		                        else
		                            cn = cn + 1;
		                            Ci(ind(S==1)) = U(1);  % split old U(1) into new U(1) and into cn
		                            Ci(ind(S==-1)) = cn;
		                            U = [cn, U];
		                        end
		                    else  % contribution nonpositive: U(1) is indivisible
		                        U(1) = [];
		                    end
		
		                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
		                    bg = B(ind, ind);
		                    Bg = bg-diag(sum(bg));  % modularity matrix for U(1)
		                    Ng = length(ind);  % number of vertices in U(1)
		                end
		
		                s = Ci(:,ones(1, N));  % compute modularity
		                Q =~ (s-s.').*B/mo;
		                Q = sum(Q(:));
		                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
		                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
		                Ci = Ci_corrected;  % output corrected community assignments
		
		                m.set('QUALITY_FUNCTION', Q); % save normalized quality function/modularity
		                community_structure = {Ci};
		            end
		
		        otherwise  % {'Louvain'}  % Louvain algorithm
		
		            M0 = m.get('M0');  % initial community affiliation vector
		            OM = m.get('Louvain_OM');  % custom objective matrix
		            type_OM =  m.get('OM_TYPE');  % objective-function type
		            W = double(A);  % convert to double format
		            s = sum(sum(W));  % get sum of edges
		
		            if isempty(M0)
		                M0 = 1:N;
		            else
		                assert(isequal(size(M0, 2), size(1:N, 2)), ...
		                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
		                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
		                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
		            end
		            [~,~,Mb] = unique(M0);
		            M = Mb;
		
		            if isempty(OM)
		                % calculate OM according to type_B
		
		                switch lower(type_OM)
		                    case {'potts'}
		                        assert(all(all(W == logical(W))), ...
		                            [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
		                            ['Potts-model Hamiltonian requires a binary adjacency matrix' ...
		                            'while it is ' tostring(W)])
		                        OM =  W - gamma*(~W);
		                    otherwise  % {'modularity'} default
		                        OM = W - gamma*(sum(W, 2)*sum(W, 1))/s;
		                end
		            else  % OM matrix exists
		                assert(isequal(size(W), size(OM)), ...
		                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
		                    ['OM matrix must have the same size than the adjacency matrix' ...
		                    '(' tostring(size(W)) ') while its size is ' tostring(size(OM))])
		            end
		
		            OM = (OM+OM.')/2;  % symmetrize modularity matrix
		            Hnm = zeros(N, N);  % node-to-module degree
		            for mo = 1:max(Mb)  % loop over modules
		                Hnm(:, mo) = sum(OM(:, Mb== mo), 2);
		            end
		            H = sum(Hnm, 2);  % node degree
		            Hm = sum(Hnm, 1);  % module degree
		
		            Q0 = -inf;
		            Q = sum(OM(bsxfun(@eq, M0, M0.')))/s;  % compute modularity
		            first_iteration = true;
		            n = N;
		            while Q-Q0 > 1e-10
		                flag = true;  % flag for within-hierarchy search
		                while flag
		                    flag = false;
		                    for u = randperm(n)  % loop over all nodes in random order
		                        ma = Mb(u);  % current module of u
		                        dQ = Hnm(u, :)- Hnm(u,ma) + OM(u, u);
		                        dQ(ma) = 0;  % (line above) algorithm condition
		
		                        [max_dQ, mb] = max(dQ);  % maximal increase in modularity and corresponding module
		                        if max_dQ > 1e-10  % if maximal increase is positive
		                            flag = true;
		                            Mb(u) = mb;  % reassign module
		
		                            Hnm(:,mb) = Hnm(:,mb) + OM(:,u);  % change node-to-module strengths
		                            Hnm(:,ma) = Hnm(:,ma) - OM(:,u);
		                            Hm(mb) = Hm(mb) + H(u);  % change module strengths
		                            Hm(ma) = Hm(ma) - H(u);
		                        end
		                    end
		                end
		                [~,~,Mb] = unique(Mb);  % new module assignments
		
		                M0 = M;
		                if first_iteration
		                    M = Mb;
		                    first_iteration = false;
		                else
		                    for u = 1:n  % loop through initial module assignments
		                        M(M0==u) = Mb(u);  % assign new modules
		                    end
		                end
		
		                n = max(Mb);  % new number of modules
		                B1 = zeros(n);  % new weighted matrix
		                for u = 1:n
		                    for v = u:n
		                        bm = sum(sum(OM(Mb==u,Mb==v)));  % pool weights of nodes in same module
		                        B1(u,v) = bm;
		                        B1(v,u) = bm;
		                    end
		                end
		                OM = B1;
		
		                Mb = 1:n;  % initial module assignments
		                Hnm = OM;  % node-to-module strength
		                H = sum(OM);  % node strength
		                Hm = H;  % module strength
		
		                Q0 = Q;
		                Q = trace(OM)/s;  % compute modularity
		            end
		            m.set('QUALITY_FUNCTION', Q);  % save normalized quality function/modularity
		            community_structure = {M};
		    end
		    comm_str = community_structure;
		end
	end
end
