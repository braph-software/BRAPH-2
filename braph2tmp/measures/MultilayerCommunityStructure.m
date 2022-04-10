classdef MultilayerCommunityStructure < Measure
	% MultilayerCommunityStructure is the graph multilayer community structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The multilayer community structure of a multilayer graph is a subdivision of 
	% the network into non-overlapping groups of nodes which maximizes the number 
	% of whitin group edges, and minimizes the number of between group edges.
	%
	% The list of MultilayerCommunityStructure properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multilayer community structure.
	%  <strong>6</strong> <strong>limit</strong> 	LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
	%  <strong>7</strong> <strong>randord</strong> 	RANDORD (parameter, LOGICAL) is used to set randperm.
	%  <strong>8</strong> <strong>randmove</strong> 	RANDMOVE (parameter, LOGICAL) is the move function.
	%  <strong>9</strong> <strong>gamma</strong> 	gamma (parameter, SCALAR) is the resolution parameter.
	%  <strong>10</strong> <strong>omega</strong> 	omega (parameter, SCALAR) is the inter-layer coupling parameter.
	%  <strong>11</strong> <strong>s0</strong> 	S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
	%  <strong>12</strong> <strong>om</strong> 	OM (data, MATRIX) is the multilayer modularity matrix
	%  <strong>13</strong> <strong>quality_function</strong> 	QUALITY_FUNCTION(data, MATRIX) is the multilayer modularity matrix
	%
	% MultilayerCommunityStructure methods (constructor):
	% MultilayerCommunityStructure - constructor
	%
	% MultilayerCommunityStructure methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in multilayer community structure/error.
	%  existsProp - checks whether property exists in multilayer community structure/error.
	%  getPropNumber - returns the property number of multilayer community structure.
	%  getProps - returns the property list of multilayer community structure.
	%  getDescription - returns the description of the multilayer community structure.
	%  getName - returns the name of the multilayer community structure.
	%  getClass - returns the class of the multilayer community structure.
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
	% MultilayerCommunityStructure methods:
	%  metanetwork_i - returns the ith column of the metanetwork
	%  metanetwork - K returns the new aggregated network (communities --> nodes)
	%  multicat_directed - returns the multilayer modularity matrix for unordered directed networks
	%  multicat_undirected - returns the multilayer modularity matrix for unordered undirected networks
	%  multiord_directed - returns the multilayer modularity matrix for ordered directed networks
	%  multiord_undirected - returns the multilayer modularity matrix for ordered undirected networks
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
	% MultilayerCommunityStructure methods (operators):
	%  isequal - determines whether two MultilayerCommunityStructure are equal (values, locked)
	%
	% MultilayerCommunityStructure methods (display):
	%  tostring - string with information about the MultilayerCommunityStructure
	%  disp - displays information about the MultilayerCommunityStructure
	%  tree - displays the element of MultilayerCommunityStructure
	%
	% MultilayerCommunityStructure method (element list):
	%  getElementList - returns a list with all subelements of MultilayerCommunityStructure
	%
	% MultilayerCommunityStructure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the MultilayerCommunityStructure
	%
	% MultilayerCommunityStructure method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the MultilayerCommunityStructure
	%
	% MultilayerCommunityStructure methods (copy):
	%  copy - copies the MultilayerCommunityStructure
	%  deepclone - deep-clones the MultilayerCommunityStructure
	%  clone - clones the MultilayerCommunityStructure
	%
	% MultilayerCommunityStructure methods (inspection, Static):
	%  getClass - returns MultilayerCommunityStructure
	%  getName - returns the name of MultilayerCommunityStructure
	%  getDescription - returns the description of MultilayerCommunityStructure
	%  getProps - returns the property list of MultilayerCommunityStructure
	%  getPropNumber - returns the property number of MultilayerCommunityStructure
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
	% MultilayerCommunityStructure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerCommunityStructure methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% MultilayerCommunityStructure methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% MultilayerCommunityStructure methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% MultilayerCommunityStructure properties (Constant).
	%  LIMIT - 6
	%  LIMIT_TAG - 'limit'
	%  LIMIT_CATEGORY - 'p'
	%  LIMIT_FORMAT - 'nn'
	%  RANDORD - 7
	%  RANDORD_TAG - 'randord'
	%  RANDORD_CATEGORY - 'p'
	%  RANDORD_FORMAT - 'lo'
	%  RANDMOVE - 8
	%  RANDMOVE_TAG - 'randmove'
	%  RANDMOVE_CATEGORY - 'p'
	%  RANDMOVE_FORMAT - 'lo'
	%  GAMMA - 9
	%  GAMMA_TAG - 'gamma'
	%  GAMMA_CATEGORY - 'p'
	%  GAMMA_FORMAT - 'nn'
	%  OMEGA - 10
	%  OMEGA_TAG - 'omega'
	%  OMEGA_CATEGORY - 'p'
	%  OMEGA_FORMAT - 'nn'
	%  S0 - 11
	%  S0_TAG - 's0'
	%  S0_CATEGORY - 'd'
	%  S0_FORMAT - 'nc'
	%  OM - 12
	%  OM_TAG - 'om'
	%  OM_CATEGORY - 'd'
	%  OM_FORMAT - 'nm'
	%  QUALITY_FUNCTION - 13
	%  QUALITY_FUNCTION_TAG - 'quality_function'
	%  QUALITY_FUNCTION_CATEGORY - 'd'
	%  QUALITY_FUNCTION_FORMAT - 'nm'
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
		LIMIT = Measure.getPropNumber() + 1;
		LIMIT_TAG = 'limit';
		LIMIT_CATEGORY = Category.PARAMETER;
		LIMIT_FORMAT = Format.SCALAR;
		
		RANDORD = Measure.getPropNumber() + 2;
		RANDORD_TAG = 'randord';
		RANDORD_CATEGORY = Category.PARAMETER;
		RANDORD_FORMAT = Format.LOGICAL;
		
		RANDMOVE = Measure.getPropNumber() + 3;
		RANDMOVE_TAG = 'randmove';
		RANDMOVE_CATEGORY = Category.PARAMETER;
		RANDMOVE_FORMAT = Format.LOGICAL;
		
		GAMMA = Measure.getPropNumber() + 4;
		GAMMA_TAG = 'gamma';
		GAMMA_CATEGORY = Category.PARAMETER;
		GAMMA_FORMAT = Format.SCALAR;
		
		OMEGA = Measure.getPropNumber() + 5;
		OMEGA_TAG = 'omega';
		OMEGA_CATEGORY = Category.PARAMETER;
		OMEGA_FORMAT = Format.SCALAR;
		
		S0 = Measure.getPropNumber() + 6;
		S0_TAG = 's0';
		S0_CATEGORY = Category.DATA;
		S0_FORMAT = Format.CVECTOR;
		
		OM = Measure.getPropNumber() + 7;
		OM_TAG = 'om';
		OM_CATEGORY = Category.DATA;
		OM_FORMAT = Format.MATRIX;
		
		QUALITY_FUNCTION = Measure.getPropNumber() + 8;
		QUALITY_FUNCTION_TAG = 'quality_function';
		QUALITY_FUNCTION_CATEGORY = Category.DATA;
		QUALITY_FUNCTION_FORMAT = Format.MATRIX;
	end
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the multilayer community structure.
			%
			% CLASS = MultilayerCommunityStructure.GETCLASS() returns the class 'MultilayerCommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multilayer community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultilayerCommunityStructure') returns 'MultilayerCommunityStructure'.
			%
			% See also getName, getDescription.
			
			m_class = 'MultilayerCommunityStructure';
		end
		function m_name = getName()
			%GETNAME returns the name of the multilayer community structure.
			%
			% NAME = MultilayerCommunityStructure.GETNAME() returns the name of the 'multilayer community structure'.
			%  Multilayer Community Structure.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the multilayer community structure M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('MultilayerCommunityStructure') returns the name of 'MultilayerCommunityStructure'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Multilayer Community Structure';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the multilayer community structure.
			%
			% STR = MultilayerCommunityStructure.GETDESCRIPTION() returns the description of the 'multilayer community structure'.
			%  which is:
			%
			%  The multilayer community structure of a multilayer graph is a subdivision of 
			%  the network into non-overlapping groups of nodes which maximizes the number 
			%  of whitin group edges, and minimizes the number of between group edges.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the multilayer community structure M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('MultilayerCommunityStructure') returns the description of 'MultilayerCommunityStructure'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The multilayer community structure of a multilayer graph is a subdivision of ' ...
				'the network into non-overlapping groups of nodes which maximizes the number ' ...
				'of whitin group edges, and minimizes the number of between group edges.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer community structure.
			%
			% PROPS = MultilayerCommunityStructure.GETPROPS() returns the property list of multilayer community structure.
			%
			% PROPS = MultilayerCommunityStructure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multilayer community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultilayerCommunityStructure'[, CATEGORY]) returns the property list of 'MultilayerCommunityStructure'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Measure.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Measure.getProps(Category.PARAMETER)
						MultilayerCommunityStructure.LIMIT
						MultilayerCommunityStructure.RANDORD
						MultilayerCommunityStructure.RANDMOVE
						MultilayerCommunityStructure.GAMMA
						MultilayerCommunityStructure.OMEGA
						];
				case Category.DATA
					prop_list = [
						Measure.getProps(Category.DATA)
						MultilayerCommunityStructure.S0
						MultilayerCommunityStructure.OM
						MultilayerCommunityStructure.QUALITY_FUNCTION
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
						MultilayerCommunityStructure.LIMIT
						MultilayerCommunityStructure.RANDORD
						MultilayerCommunityStructure.RANDMOVE
						MultilayerCommunityStructure.GAMMA
						MultilayerCommunityStructure.OMEGA
						MultilayerCommunityStructure.S0
						MultilayerCommunityStructure.OM
						MultilayerCommunityStructure.QUALITY_FUNCTION
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of multilayer community structure.
			%
			% N = MultilayerCommunityStructure.GETPROPNUMBER() returns the property number of multilayer community structure.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the multilayer community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultilayerCommunityStructure') returns the property number of 'MultilayerCommunityStructure'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 13;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunityStructure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultilayerCommunityStructure, PROP) checks whether PROP exists for MultilayerCommunityStructure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  Element.EXISTSPROP(MultilayerCommunityStructure, PROP) throws error if PROP does NOT exist for MultilayerCommunityStructure.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13 ]);
			else
				assert( ...
					MultilayerCommunityStructure.existsProp(prop), ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerCommunityStructure.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunityStructure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultilayerCommunityStructure, TAG) checks whether TAG exists for MultilayerCommunityStructure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  Element.EXISTSTAG(MultilayerCommunityStructure, TAG) throws error if TAG does NOT exist for MultilayerCommunityStructure.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				multilayercommunitystructure_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'limit'  'randord'  'randmove'  'gamma'  'omega'  's0'  'om'  'quality_function' };
				
				check = any(strcmpi(tag, multilayercommunitystructure_tag_list));
			else
				assert( ...
					MultilayerCommunityStructure.existsTag(tag), ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for MultilayerCommunityStructure'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerCommunityStructure, POINTER) returns property number of POINTER of MultilayerCommunityStructure.
			%  PROPERTY = M.GETPROPPROP(MultilayerCommunityStructure, POINTER) returns property number of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				multilayercommunitystructure_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'limit'  'randord'  'randmove'  'gamma'  'omega'  's0'  'om'  'quality_function' };
				
				tag = pointer;
				MultilayerCommunityStructure.existsTag(tag);
				
				prop = find(strcmpi(tag, multilayercommunitystructure_tag_list));
			else % numeric
				prop = pointer;
				MultilayerCommunityStructure.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(MultilayerCommunityStructure, POINTER) returns tag of POINTER of MultilayerCommunityStructure.
			%  TAG = M.GETPROPTAG(MultilayerCommunityStructure, POINTER) returns tag of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				MultilayerCommunityStructure.existsTag(tag);
			else % numeric
				prop = pointer;
				MultilayerCommunityStructure.existsProp(prop);
				
				switch prop
					case MultilayerCommunityStructure.LIMIT
						tag = MultilayerCommunityStructure.LIMIT_TAG;
					case MultilayerCommunityStructure.RANDORD
						tag = MultilayerCommunityStructure.RANDORD_TAG;
					case MultilayerCommunityStructure.RANDMOVE
						tag = MultilayerCommunityStructure.RANDMOVE_TAG;
					case MultilayerCommunityStructure.GAMMA
						tag = MultilayerCommunityStructure.GAMMA_TAG;
					case MultilayerCommunityStructure.OMEGA
						tag = MultilayerCommunityStructure.OMEGA_TAG;
					case MultilayerCommunityStructure.S0
						tag = MultilayerCommunityStructure.S0_TAG;
					case MultilayerCommunityStructure.OM
						tag = MultilayerCommunityStructure.OM_TAG;
					case MultilayerCommunityStructure.QUALITY_FUNCTION
						tag = MultilayerCommunityStructure.QUALITY_FUNCTION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerCommunityStructure, POINTER) returns category of POINTER of MultilayerCommunityStructure.
			%  CATEGORY = M.GETPROPCATEGORY(MultilayerCommunityStructure, POINTER) returns category of POINTER of MultilayerCommunityStructure.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					prop_category = MultilayerCommunityStructure.LIMIT_CATEGORY;
				case MultilayerCommunityStructure.RANDORD
					prop_category = MultilayerCommunityStructure.RANDORD_CATEGORY;
				case MultilayerCommunityStructure.RANDMOVE
					prop_category = MultilayerCommunityStructure.RANDMOVE_CATEGORY;
				case MultilayerCommunityStructure.GAMMA
					prop_category = MultilayerCommunityStructure.GAMMA_CATEGORY;
				case MultilayerCommunityStructure.OMEGA
					prop_category = MultilayerCommunityStructure.OMEGA_CATEGORY;
				case MultilayerCommunityStructure.S0
					prop_category = MultilayerCommunityStructure.S0_CATEGORY;
				case MultilayerCommunityStructure.OM
					prop_category = MultilayerCommunityStructure.OM_CATEGORY;
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					prop_category = MultilayerCommunityStructure.QUALITY_FUNCTION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerCommunityStructure, POINTER) returns format of POINTER of MultilayerCommunityStructure.
			%  FORMAT = M.GETPROPFORMAT(MultilayerCommunityStructure, POINTER) returns format of POINTER of MultilayerCommunityStructure.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					prop_format = MultilayerCommunityStructure.LIMIT_FORMAT;
				case MultilayerCommunityStructure.RANDORD
					prop_format = MultilayerCommunityStructure.RANDORD_FORMAT;
				case MultilayerCommunityStructure.RANDMOVE
					prop_format = MultilayerCommunityStructure.RANDMOVE_FORMAT;
				case MultilayerCommunityStructure.GAMMA
					prop_format = MultilayerCommunityStructure.GAMMA_FORMAT;
				case MultilayerCommunityStructure.OMEGA
					prop_format = MultilayerCommunityStructure.OMEGA_FORMAT;
				case MultilayerCommunityStructure.S0
					prop_format = MultilayerCommunityStructure.S0_FORMAT;
				case MultilayerCommunityStructure.OM
					prop_format = MultilayerCommunityStructure.OM_FORMAT;
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					prop_format = MultilayerCommunityStructure.QUALITY_FUNCTION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerCommunityStructure, POINTER) returns description of POINTER of MultilayerCommunityStructure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultilayerCommunityStructure, POINTER) returns description of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					prop_description = 'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.';
				case MultilayerCommunityStructure.RANDORD
					prop_description = 'RANDORD (parameter, LOGICAL) is used to set randperm.';
				case MultilayerCommunityStructure.RANDMOVE
					prop_description = 'RANDMOVE (parameter, LOGICAL) is the move function.';
				case MultilayerCommunityStructure.GAMMA
					prop_description = 'gamma (parameter, SCALAR) is the resolution parameter.';
				case MultilayerCommunityStructure.OMEGA
					prop_description = 'omega (parameter, SCALAR) is the inter-layer coupling parameter.';
				case MultilayerCommunityStructure.S0
					prop_description = 'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.';
				case MultilayerCommunityStructure.OM
					prop_description = 'OM (data, MATRIX) is the multilayer modularity matrix';
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					prop_description = 'QUALITY_FUNCTION(data, MATRIX) is the multilayer modularity matrix';
				case MultilayerCommunityStructure.M
					prop_description = 'M (result, cell) is the multilayer community structure.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerCommunityStructure, POINTER) returns settings of POINTER of MultilayerCommunityStructure.
			%  SETTINGS = M.GETPROPSETTINGS(MultilayerCommunityStructure, POINTER) returns settings of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunityStructure.RANDORD
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case MultilayerCommunityStructure.RANDMOVE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case MultilayerCommunityStructure.GAMMA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunityStructure.OMEGA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunityStructure.S0
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case MultilayerCommunityStructure.OM
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerCommunityStructure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunityStructure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerCommunityStructure, POINTER) returns the default value of POINTER of MultilayerCommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULT(MultilayerCommunityStructure, POINTER) returns the default value of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					prop_default = 10000;
				case MultilayerCommunityStructure.RANDORD
					prop_default = true;
				case MultilayerCommunityStructure.RANDMOVE
					prop_default = true;
				case MultilayerCommunityStructure.GAMMA
					prop_default = 1;
				case MultilayerCommunityStructure.OMEGA
					prop_default = 1;
				case MultilayerCommunityStructure.S0
					prop_default = [];
				case MultilayerCommunityStructure.OM
					prop_default = [];
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					prop_default = [];
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerCommunityStructure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunityStructure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerCommunityStructure, POINTER) returns the conditioned default value of POINTER of MultilayerCommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultilayerCommunityStructure, POINTER) returns the conditioned default value of POINTER of MultilayerCommunityStructure.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			prop_default = MultilayerCommunityStructure.conditioning(prop, MultilayerCommunityStructure.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerCommunityStructure, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunityStructure.
			%  CHECK = M.CHECKPROP(MultilayerCommunityStructure, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunityStructure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  Element.CHECKPROP(MultilayerCommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunityStructure.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			%  M.CHECKPROP(MultilayerCommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunityStructure.
			%   Error id: [BRAPH2:MultilayerCommunityStructure:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunityStructure.LIMIT
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.RANDORD
					check = Format.checkFormat(Format.LOGICAL, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.RANDMOVE
					check = Format.checkFormat(Format.LOGICAL, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.GAMMA
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.OMEGA
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.S0
					check = Format.checkFormat(Format.CVECTOR, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.OM
					check = Format.checkFormat(Format.MATRIX, value, MultilayerCommunityStructure.getPropSettings(prop));
				case MultilayerCommunityStructure.QUALITY_FUNCTION
					check = Format.checkFormat(Format.MATRIX, value, MultilayerCommunityStructure.getPropSettings(prop));
				otherwise
					check = checkProp@Measure(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerCommunityStructure.getPropTag(prop) ' (' MultilayerCommunityStructure.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = MultilayerCommunityStructure.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = MultilayerCommunityStructure.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = MultilayerCommunityStructure.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of MultilayerCommunityStructure compatible graphs.
			%
			% LIST = MultilayerCommunityStructure.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help MultiplexBU">MultiplexBU</a>
			%  <a href="matlab:help MultiplexBUD">MultiplexBUD</a>
			%  <a href="matlab:help MultiplexBUT">MultiplexBUT</a>
			%  <a href="matlab:help MultiplexBD">MultiplexBD</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%  <a href="matlab:help OrderedMultiplexWU">OrderedMultiplexWU</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'MultiplexBU', ...
				'MultiplexBUD', ...
				'MultiplexBUT', ...
				'MultiplexBD', ...
				'MultiplexWU', ...
				'MultiplexWD', ...
				'OrderedMultiplexWU', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (7) of MultilayerCommunityStructure compatible graphs.
			%
			% 7 = MultilayerCommunityStructure.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('MultilayerCommunityStructure');
		end
	end
	methods % constructor
		function m = MultilayerCommunityStructure(varargin)
			% MultilayerCommunityStructure() creates a multilayer community structure.
			%
			% MultilayerCommunityStructure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerCommunityStructure(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultilayerCommunityStructure properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multilayer community structure.
			%  <strong>6</strong> <strong>limit</strong> 	LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
			%  <strong>7</strong> <strong>randord</strong> 	RANDORD (parameter, LOGICAL) is used to set randperm.
			%  <strong>8</strong> <strong>randmove</strong> 	RANDMOVE (parameter, LOGICAL) is the move function.
			%  <strong>9</strong> <strong>gamma</strong> 	gamma (parameter, SCALAR) is the resolution parameter.
			%  <strong>10</strong> <strong>omega</strong> 	omega (parameter, SCALAR) is the inter-layer coupling parameter.
			%  <strong>11</strong> <strong>s0</strong> 	S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
			%  <strong>12</strong> <strong>om</strong> 	OM (data, MATRIX) is the multilayer modularity matrix
			%  <strong>13</strong> <strong>quality_function</strong> 	QUALITY_FUNCTION(data, MATRIX) is the multilayer modularity matrix
			%
			% See also Category, Format, set, check.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = MultilayerCommunityStructure.getPropProp(pointer);
			
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
				case MultilayerCommunityStructure.M
					g = m.get('G');  % graph from measure class
					N = g.nodenumber();
					L = g.layernumber();  % number of layers
					limit = m.get('LIMIT');  % set default for maximum size of multilayer modularity matrix
					randord = m.get('randord');  % set randperm
					randmove = m.get('randmove');  % set move function
					gamma = m.get('gamma');
					omega = m.get('omega');
					S0 = m.get('S0');
					OM = m.get('OM');
					
					if L == 0  % no value case
					    value = {};
					    return;
					end
					% set randperm- v. index-ordered
					if randord
					    myord = @(n) randperm(n);
					else
					    myord = @(n) 1:n;
					end
					
					% set move function (maximal (original Louvain) or random improvement)
					if randmove
					    if ischar(randmove)
					        if any(strcmp(randmove,{'move','moverand','moverandw'}))
					            movefunction = randmove;
					        else
					            error('unknown value for ''randmove''');
					        end
					    else
					        % backwards compatibility: randmove=true
					        movefunction = 'moverand';
					    end
					else
					    movefunction = 'move';
					end
					
					if isempty(OM)
					    directionality_type =  g.getDirectionalityType(g.layernumber());
					    directionality_firstlayer = directionality_type(1, 1);
					    A = cell(L, 1);
					    for i=1:L
					        A_hold = g.get('A');
					        A(i) = {A_hold{i, i}};
					    end
					    if g.is_multiplex(g) || g.is_multilayer(g)
					        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
					            [OM, twom] = m.multicat_undirected(A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = m.multicat_directed(A, gamma, omega, N(1), L);
					        end
					    elseif g.is_ordered_multiplex(g) || g.is_ordered_multilayer(g)
					        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
					            [OM, twom] = m.multiord_undirected(A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = m.multiord_directed(A, gamma, omega, N(1), L);
					        end
					    end
					end
					
					% initialise variables and do symmetry check
					if isa(OM,'function_handle')
					    n = length(OM(1));
					    S = (1:n)';
					    
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0) == n
					            group_handler('assign', S0);
					            S0 = group_handler('return'); % tidy config
					        else
					            error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    
					    % symmetry check (only checks symmetry of a small part of the matrix)
					    M = OM;
					    it(:,1) = M(1);
					    ii = find(it(2:end)>0,3) + 1;
					    ii = [1,ii'];
					    for i=2:length(ii)
					        it(:,i)=M(ii(i));
					    end
					    it = it(ii,:);
					    if norm(full(it-it')) > 2*eps
					        error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					            'Function handle does not correspond to a symmetric matrix. Deviation: %i', norm(full(it-it')))
					    end
					else
					    n = length(OM);
					    S = (1:n)';
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0)==n
					            % clean input partition
					            group_handler('assign', S0);
					            S0 = group_handler('return');
					        else
					            error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    %symmetry check and fix if not symmetric
					    if nnz(OM-OM')
					        OM = (OM+OM')/2;
					        %                     disp('WARNING: Forced symmetric OM matrix')
					    end
					    M = OM;
					end
					
					dtot = eps;  % keeps track of total change in modularity
					y = S0;
					% Run using function handle, if provided
					while (isa(M,'function_handle'))  % loop around each "pass" (in language of Blondel et al) with OM function handle
					    Sb = S;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;  % keeps track of change in modularity in pass
					        yb = [];
					        while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M(1)))
					                di = group_handler(movefunction, i, M(i));
					                dstep = dstep + di;
					            end
					            
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);  % group_handler implements tidyconfig
					    y = unique(y);  % unique also puts elements in ascending order
					    
					    % calculate modularity and return if converged
					    if isequal(Sb,S)
					        Q = 0;
					        P = sparse(y,1:length(y),1);
					        for i=1:length(M(1))
					            Q = Q + (P*M(i))'*P(:,i);
					        end
					        Q = full(Q);
					        clear('group_handler');
					        clear('metanetwork_reduce');
					        m.set('QUALITY_FUNCTION', Q/twom)  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        return
					    end
					    
					    % check wether #groups < limit
					    t = length(unique(S));
					    if (t > limit)
					        metanetwork_reduce('assign', S);  % inputs group information to metanetwork_reduce
					        M = @(i) m.metanetwork_i(OM,i);  % use function handle if #groups > limit
					    else
					        metanetwork_reduce('assign', S);
					        J = zeros(t);  % convert to matrix if #groups small enough
					        for c=1:t
					            J(:,c) = m.metanetwork_i(OM,c);
					        end
					        OM = J;
					        M = OM;
					    end
					end
					
					% Run using matrix OM (old B)
					S2 = (1:length(OM))';
					Sb = [];
					while ~isequal(Sb, S2)  % loop around each "pass" (in language of Blondel et al) with B matrix
					    Sb = S2;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;
					        while (~isequal(yb,y)) && (dstep/dtot > 2*eps) && (dstep > 10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M))
					                di = group_handler(movefunction,i,M(:,i));
					                dstep = dstep+di;
					            end
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);
					    S2 = y(S2);
					    
					    if isequal(Sb,S2)
					        P = sparse(y,1:length(y),1);
					        Q = full(sum(sum((P*M).*P)));
					        m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        value = multilayer_community_structure;
					        return
					    end
					    
					    M = m.metanetwork(OM, S2);
					    y = unique(S2);  % unique also puts elements in ascending order
					end
					m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					S = reshape(S, N(1), L);
					multilayer_community_structure = cell(L, 1);
					for li = 1:1:L
					    multilayer_community_structure(li) = {S(:, li)};
					end
					
					value = multilayer_community_structure;
					
				otherwise
					value = calculateValue@Measure(m, prop);
					
			end
		end
	end
	methods % methods
		function [OM, twom] = multiord_undirected(m, A, gamma, omega, N, T)
		% MULTIORDUNDIRECTED returns the multilayer modularity matrix for ordered undirected networks
		%
		% [B, twom] = MULTIORDUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
		% Newman-Girvan modularity matrix for ordered undirected networks.
		%
		%   Input: A: Cell array of NxN adjacency matrices for each layer of an
		%          ordered undirected multilayer network
		%          gamma: intralayer resolution parameter
		%          omega: interlayer coupling strength
		%
		%   Output: B: function handle where B(i) returns the ith column of
		%          [NxT]x[NxT] flattened modularity tensor for the
		%           multilayer network with uniform ordinal coupling (T is
		%           the number of layers of the network)
		%           twom: normalisation constant
		%
		%   Example of usage: [B,twom]=multiord_f(A,gamma,omega);
		%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
		%          postprocess_ordinal_multilayer.m for how to improve output
		%          multilayer partition
		%          Q=Q/twom;
		%          S=reshape(S,N,T);
		%
		%   [B,twom] = MULTIORD_F(A,GAMMA, OMEGA) with A a cell array of square
		%   symmetric matrices of equal size each representing an undirected network
		%   "layer" computes the multilayer Newman-Girvan modularity matrix using
		%   the quality function described in Mucha et al. 2010, with intralayer
		%   resolution parameter GAMMA, and with interlayer coupling OMEGA connecting
		%   nearest-neighbor ordered layers.  The null model used for the quality
		%   function is the Newman-Girvan null model (see e.g. Bazzi et al. for other
		%   possible null models). Once the mulilayer modularity matrix is computed,
		%   optimization can be performed by the generalized Louvain code GENLOUVAIN
		%   or ITERATED_GENLOUVAIN. The output B can be used with other heuristics,
		%   provided the same mapping is used to go from the multilayer tensor to
		%   the multilayer flattened matrix. That is, the node-layer tuple (i,s)
		%   is mapped to i + (s-1)*N. [Note that we can define a mapping between a
		%   multilayer partition S_m stored as an N by T matrix and the corresponding
		%   flattened partition S stored as an NT by 1 vector. In particular
		%   S_m = reshape(S,N,T) and S = S_m(:).]
		%
		%
		%   See also
		%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
		%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
		%       other heuristics:           SPECTRAL23
		%       Kernighan-Lin improvement:  KLNB
		%
		%   Notes:
		%     The matrices in the cell array A are assumed to be square,
		%     symmetric, and of equal size.  These assumptions are not checked here.
		%
		%     For smaller systems, it is potentially more efficient (and easier) to
		%     directly use the sparse quality/modularity matrix B in MULTIORD. For
		%     large systems with directed layer networks, use MULTIORDDIR_F.
		%
		%     This code serves as a template and can be modified for situations
		%     with other wrinkles (e.g., different intralayer null models,
		%     different numbers of nodes from layer-to-layer, or systems which are
		%     both multiplex and longitudinal).  That is, this code is only a
		%     starting point; it is by no means exhaustive.
		%
		%     By using this code, the user implicitly acknowledges that the authors
		%     accept no liability associated with that use.  (What are you doing
		%     with it anyway that might cause there to be a potential liability?!?)
		
		if nargin < 2 || isempty(gamma)
		    gamma = 1;
		end
		
		if nargin < 3
		    omega = 1;
		end
		
		if length(gamma) == 1
		    gamma = repmat(gamma, T, 1);
		end
		
		ii=[]; jj=[]; vv=[];
		ki=[]; kj=[]; kv=[];
		twom = 0;
		for s=1:T
		    indx = (1:N)' + (s-1)*N;
		    [i, j, v] = find(A{s});
		    ii = [ii; indx(i)];
		    jj = [jj; indx(j)];
		    vv = [vv; v];
		    k = sum(A{s});
		    mm = sum(k);
		    twom = twom + mm;
		    ki = [ki; indx];
		    kj = [kj; ones(N,1)*s];
		    kv = [kv; k(:)./mm];
		end
		AA = sparse(ii, jj, vv, N*T, N*T);
		K = sparse(ki, kj, kv, N*T, T);
		clear ii jj vv ki kj kv
		kvec = full(sum(AA));
		AA = AA + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
		OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:,ceil(i/(N+eps)))*kvec(i);
		twom = twom + 2*N*(T-1)*omega;
		end
		function [OM, twom] = multiord_directed(m, A, gamma, omega, N, T)
		% MULTIORDDIRECTED returns the multilayer modularity matrix for ordered directed networks
		%
		% [B, twom] = MULTIORDDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
		% Leicht-Newman modularity matrix for ordered directed networks.
		%
		%   Input: A: Cell array of NxN adjacency matrices for each layer of an
		%          ordered directed multilayer network
		%          gamma: intralayer resolution parameter
		%          omega: interlayer coupling strength
		%
		%   Output: B: function handle where B(i) returns the ith column of
		%          [NxT]x[NxT] flattened modularity tensor for the
		%           multilayer network with uniform ordinal coupling (T is
		%           the number of layers of the network)
		%           twom: normalisation constant
		%
		%   Example of usage: [B,twom]=multiorddir_f(A,gamma,omega);
		%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
		%          postprocess_ordinal_multilayer.m for how to improve output
		%          multilayer partition
		%          Q=Q/twom;
		%          S=reshape(S,N,T);
		%
		%   [B,twom] = MULTIORDDIR_F(A,GAMMA, OMEGA) with A a cell array of square
		%   matrices of equal size each representing an directed network "layer"
		%   computes the Leicht-Newman multilayer modularity matrix Susing the
		%   quality function described in Mucha et al. 2010, with intralayer
		%   resolution parameter GAMMA, and with interlayer coupling OMEGA
		%   connecting nearest-neighbor ordered layers. Once the mulilayer modularity
		%   matrix is computed, optimization can be performed by the generalized
		%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
		%   with other heuristics, provided the same mapping is used to go from the
		%   multilayer tensor to the multilayer flattened matrix. That is, the
		%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
		%   define a mapping between a multilayer partition S_m stored as an N by T
		%   matrix and the corresponding flattened partition S stored as an NT by 1
		%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
		%
		%   See also
		%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
		%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
		%       other heuristics:           SPECTRAL23
		%       Kernighan-Lin improvement:  KLNB
		%
		%   Notes:
		%     The matrices in the cell array A are assumed to be square,
		%     and of equal size.  These assumptions are not checked here.
		%
		%     For smaller systems, it is potentially more efficient (and easier) to
		%     directly use the sparse quality/modularity matrix B in MULTIORD. For
		%     large systems with undirected layer networks, use MULTIORD_F.
		%
		%     This code serves as a template and can be modified for situations
		%     with other wrinkles (e.g., different intralayer null models,
		%     different numbers of nodes from layer-to-layer, or systems which are
		%     both multiplex and longitudinal).  That is, this code is only a
		%     starting point; it is by no means exhaustive.
		%
		%     By using this code, the user implicitly acknowledges that the authors
		%     accept no liability associated with that use.  (What are you doing
		%     with it anyway that might cause there to be a potential liability?!?)
		
		if nargin < 2 || isempty(gamma)
		    gamma = 1;
		end
		
		if nargin < 3 || isempty(omega)
		    omega = 1;
		end
		
		if length(gamma) == 1
		    gamma = repmat(gamma,T,1);
		end
		m = zeros(T,1);
		for i=1:T
		    m(i) = sum(A{i}(:));
		end
		A = blkdiag(A{:});
		kout = sum(A,1);
		koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
		kin = sum(A,2);
		kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
		A = (A+A')./2;
		A = A + omega*spdiags(ones(N*T,2), [-N,N], N*T, N*T);
		
		OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps)))+kin(i).*koutmat(:,ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
		twom = sum(m) + omega*2*N*(T-1);
		end
		function [OM, twom] = multicat_undirected(m, A, gamma, omega, N, T)
		% MULTICATUNDIRECTED returns the multilayer modularity matrix for unordered undirected networks
		%
		% [B, twom] = MULTICATUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
		% Newman-Girvan modularity matrix for unordered undirected networks.
		%
		%   Input: A: Cell array of NxN adjacency matrices for each layer of an
		%          unordered multilayer undirected network
		%          gamma: intralayer resolution parameter
		%          omega: interlayer coupling strength
		%
		%   Output: B: [NxT]x[NxT] function handle where B(i) returns the ith column
		%           of the flattened modularity tensor for the
		%           multilayer network with uniform categorical coupling (T is
		%           the number of layers of the network)
		%           twom: normalisation constant
		%
		%   Example of usage: [B,twom]=multicat_f(A,gamma,omega);
		%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
		%          postprocess_categorical_multilayer.m for how to improve output
		%          multilayer partition
		%          Q=Q/twom;
		%          S=reshape(S,N,T);
		%
		%   [B,twom] = MULTICAT(A,GAMMA, OMEGA) with A a cell array of square
		%   symmetric matrices of equal size each representing an undirected network
		%   "layer" computes the multilayer modularity matrix using the quality
		%   function described in Mucha et al. 2010, with intralayer resolution
		%   parameter GAMMA, and with interlayer coupling OMEGA connecting
		%   all-to-all categorical layers. Once the mulilayer modularity matrix is
		%   computed, optimization can be performed by the generalized Louvain code
		%   GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used with other
		%   heuristics, provided the same mapping is used to go from the multilayer
		%   tensor to the multilayer flattened matrix. That is, the node-layer tuple
		%   (i,s) is mapped to i + (s-1)*N. [Note that we can define a mapping between
		%   a multilayer partition S_m stored as an N by T matrix and the corresponding
		%   flattened partition S stored as an NT by 1 vector. In particular
		%   S_m = reshape(S,N,T) and S = S_m(:).]
		%
		%   Notes:
		%     The matrices in the cell array A are assumed to be symmetric, square,
		%     and of equal size.  These assumptions are not checked here.
		%
		%     For smaller systems, it is potentially more efficient (and easier) to
		%     directly use the sparse quality/modularity matrix B, as in MULTICAT.
		%
		%     This code serves as a template and can be modified for situations
		%     with other wrinkles (e.g., different intralayer null models,
		%     different numbers of nodes from layer-to-layer, or systems which are
		%     both multiplex and longitudinal).  That is, this code is only a
		%     starting point; it is by no means exhaustive.
		%
		%     By using this code, the user implicitly acknowledges that the authors
		%     accept no liability associated with that use.  (What are you doing
		%     with it anyway that might cause there to be a potential liability?!?)
		
		if nargin < 2 || isempty(gamma)
		    gamma = 1;
		end
		
		if nargin < 3 || isempty(omega)
		    omega = 1;
		end
		
		if length(gamma) == 1
		    gamma = repmat(gamma, T, 1);
		end
		
		ii = []; jj = []; vv = [];
		ki = []; kj = []; kv = [];
		twom = 0;
		for s=1:T
		    indx = [1:N]' + (s-1)*N;
		    [i, j, v] = find(A{s});
		    ii = [ii; indx(i)];
		    jj = [jj; indx(j)];
		    vv = [vv; v];
		    k = sum(A{s});
		    mm = sum(k);
		    ki = [ki; indx];
		    kj = [kj; ones(N,1)*s];
		    kv = [kv; k(:)./mm];
		    twom = twom + sum(k);
		end
		AA = sparse(ii,jj,vv,N*T,N*T);
		K=sparse(ki,kj,kv,N*T,T);
		clear ii jj vv ki kj kv
		kvec = full(sum(AA));
		all2all = N*[(-T+1):-1,1:(T-1)];
		AA = AA + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
		OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:, ceil(i/(N+eps)))*kvec(i);
		twom = twom + 2*N*(T-1)*T*omega;
		end
		function [OM, twom] = multicat_directed(m, A, gamma, omega, N, T)
		% MULTICATDIRECTED returns the multilayer modularity matrix for unordered directed networks
		%
		% [B, twom] = MULTICATDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
		% Leicht-Newman modularity matrix for unordered directed networks.
		%
		%   Input: A: Cell array of NxN adjacency matrices for each layer of a
		%          categorical directed multilayer network
		%          gamma: intralayer resolution parameter
		%          omega: interlayer coupling strength
		%
		%   Output: B: function handle where B(i) returns the ith column of
		%          [NxT]x[NxT] flattened modularity tensor for the
		%           multilayer network with uniform ordinal coupling (T is
		%           the number of layers of the network)
		%           twom: normalisation constant
		%
		%   Example of usage: [B,twom]=multicatdir_f(A,gamma,omega);
		%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
		%          postprocess_categorical_multilayer.m for how to improve output
		%          multilayer partition
		%          Q=Q/twom;
		%          S=reshape(S,N,T);
		%
		%   [B,twom] = MULTICATDIR_F(A,GAMMA, OMEGA) with A a cell array of square
		%   matrices of equal size each representing an directed network "layer"
		%   computes the Leicht-Newman multilayer modularity matrix B using the
		%   quality function described in Mucha et al. 2010, with intralayer
		%   resolution parameter GAMMA, and with interlayer coupling OMEGA
		%   connecting all-to-all categorical layers. Once the mulilayer modularity
		%   matrix is computed, optimization can be performed by the generalized
		%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
		%   with other heuristics, provided the same mapping is used to go from the
		%   multilayer tensor to the multilayer flattened matrix. That is, the
		%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
		%   define a mapping between a multilayer partition S_m stored as an N by T
		%   matrix and the corresponding flattened partition S stored as an NT by 1
		%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
		%
		%   Notes:
		%     The matrices in the cell array A are assumed to be square,
		%     and of equal size.  These assumptions are not checked here.
		%
		%     For smaller systems, it is potentially more efficient (and easier) to
		%     directly use the sparse quality/modularity matrix B in MULTICAT. For
		%     large systems with undirected layer networks, use MULTICAT_F.
		%
		%     This code serves as a template and can be modified for situations
		%     with other wrinkles (e.g., different intralayer null models,
		%     different numbers of nodes from layer-to-layer, or systems which are
		%     both multiplex and longitudinal).  That is, this code is only a
		%     starting point; it is by no means exhaustive.
		%
		%     By using this code, the user implicitly acknowledges that the authors
		%     accept no liability associated with that use.  (What are you doing
		%     with it anyway that might cause there to be a potential liability?!?)
		
		if nargin < 2 || isempty(gamma)
		    gamma = 1;
		end
		
		if nargin < 3 || isempty(omega)
		    omega = 1;
		end
		
		if length(gamma) == 1
		    gamma = repmat(gamma, T, 1);
		end
		
		m = zeros(T, 1);
		for i=1:T
		    m(i) = sum(A{i}(:));
		end
		A = blkdiag(A{:});
		kout = sum(A,1);
		koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
		kin = sum(A,2);
		kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
		A = (A+A')./2;
		all2all = N*[(-T+1):-1,1:(T-1)];
		A = A + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
		
		OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps))) + kin(i).*koutmat(:, ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
		twom = sum(m) + omega*2*N*(T-1);
		end
		function M = metanetwork(m, J, S)
		% METANETWORK returns the new aggregated network (communities --> nodes)
		%
		% [B, twom] = METANETWORK(J, S) returns the new aggregated
		% network (communities --> nodes)
		
		PP = sparse(1:length(S), S, 1);
		M = PP'*J*PP;
		end
		function Mi = metanetwork_i(m, J, i)
		% METANETWORKI returns the ith column of the metanetwork
		%
		% [B, twom] = METANETWORKI(J, S) returns the ith column of
		% the metanetwork. J is a function handle
		
		ind = metanetwork_reduce('nodes',i);
		for j=ind(:)'
		    metanetwork_reduce('reduce',J(j));
		end
		Mi = metanetwork_reduce('return');
		end
	end
end
