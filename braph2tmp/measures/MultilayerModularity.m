classdef MultilayerModularity < MultilayerCommunityStructure
	% MultilayerModularity is the graph multilayer modularity.
	% It is a subclass of <a href="matlab:help MultilayerCommunityStructure">MultilayerCommunityStructure</a>.
	%
	% The multilayer modularity of a multilayer graph is the quality of the 
	% resulting partition of the multilayer network.
	%
	% The list of MultilayerModularity properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multilayer modularity.
	%  <strong>6</strong> <strong>limit</strong> 	LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
	%  <strong>7</strong> <strong>randord</strong> 	RANDORD (parameter, LOGICAL) is used to set randperm.
	%  <strong>8</strong> <strong>randmove</strong> 	RANDMOVE (parameter, LOGICAL) is the move function.
	%  <strong>9</strong> <strong>gamma</strong> 	gamma (parameter, SCALAR) is the resolution parameter.
	%  <strong>10</strong> <strong>omega</strong> 	omega (parameter, SCALAR) is the inter-layer coupling parameter.
	%  <strong>11</strong> <strong>s0</strong> 	S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
	%  <strong>12</strong> <strong>om</strong> 	OM (data, MATRIX) is the multilayer modularity matrix
	%  <strong>13</strong> <strong>quality_function</strong> 	QUALITY_FUNCTION(data, MATRIX) is the multilayer modularity matrix
	%
	% MultilayerModularity methods (constructor):
	% MultilayerModularity - constructor
	%
	% MultilayerModularity methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in multilayer modularity/error.
	%  existsProp - checks whether property exists in multilayer modularity/error.
	%  getPropNumber - returns the property number of multilayer modularity.
	%  getProps - returns the property list of multilayer modularity.
	%  getDescription - returns the description of the multilayer modularity.
	%  getName - returns the name of the multilayer modularity.
	%  getClass - returns the class of the multilayer modularity.
	%  getCompatibleGraphNumber - returns the number (7) of MultilayerCommunityStructure compatible graphs.
	%  getCompatibleGraphList - returns the list of MultilayerCommunityStructure compatible graphs.
	%  getMeasureParametricity - returns 2 (Non-parametric).
	%  getMeasureScope - returns 2 (Unilayer).
	%  getMeasureShape - returns 2 (Nodal).
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
	% MultilayerModularity methods:
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
	% MultilayerModularity methods (operators):
	%  isequal - determines whether two MultilayerModularity are equal (values, locked)
	%
	% MultilayerModularity methods (display):
	%  tostring - string with information about the MultilayerModularity
	%  disp - displays information about the MultilayerModularity
	%  tree - displays the element of MultilayerModularity
	%
	% MultilayerModularity method (element list):
	%  getElementList - returns a list with all subelements of MultilayerModularity
	%
	% MultilayerModularity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the MultilayerModularity
	%
	% MultilayerModularity method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the MultilayerModularity
	%
	% MultilayerModularity methods (copy):
	%  copy - copies the MultilayerModularity
	%  deepclone - deep-clones the MultilayerModularity
	%  clone - clones the MultilayerModularity
	%
	% MultilayerModularity methods (inspection, Static):
	%  getClass - returns MultilayerModularity
	%  getName - returns the name of MultilayerModularity
	%  getDescription - returns the description of MultilayerModularity
	%  getProps - returns the property list of MultilayerModularity
	%  getPropNumber - returns the property number of MultilayerModularity
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
	% MultilayerModularity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerModularity methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% MultilayerModularity methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% MultilayerModularity methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% MultilayerModularity properties (Constant).
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
	
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the multilayer modularity.
			%
			% CLASS = MultilayerModularity.GETCLASS() returns the class 'MultilayerModularity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multilayer modularity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultilayerModularity') returns 'MultilayerModularity'.
			%
			% See also getName, getDescription.
			
			m_class = 'MultilayerModularity';
		end
		function m_name = getName()
			%GETNAME returns the name of the multilayer modularity.
			%
			% NAME = MultilayerModularity.GETNAME() returns the name of the 'multilayer modularity'.
			%  Multilayer Modularity.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the multilayer modularity M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('MultilayerModularity') returns the name of 'MultilayerModularity'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Multilayer Modularity';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the multilayer modularity.
			%
			% STR = MultilayerModularity.GETDESCRIPTION() returns the description of the 'multilayer modularity'.
			%  which is:
			%
			%  The multilayer modularity of a multilayer graph is the quality of the 
			%  resulting partition of the multilayer network.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the multilayer modularity M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('MultilayerModularity') returns the description of 'MultilayerModularity'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The multilayer modularity of a multilayer graph is the quality of the ' ...
				'resulting partition of the multilayer network.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer modularity.
			%
			% PROPS = MultilayerModularity.GETPROPS() returns the property list of multilayer modularity.
			%
			% PROPS = MultilayerModularity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multilayer modularity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultilayerModularity'[, CATEGORY]) returns the property list of 'MultilayerModularity'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						MultilayerCommunityStructure.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						MultilayerCommunityStructure.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of multilayer modularity.
			%
			% N = MultilayerModularity.GETPROPNUMBER() returns the property number of multilayer modularity.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the multilayer modularity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultilayerModularity') returns the property number of 'MultilayerModularity'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 13;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer modularity/error.
			%
			% CHECK = MultilayerModularity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultilayerModularity, PROP) checks whether PROP exists for MultilayerModularity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  Element.EXISTSPROP(MultilayerModularity, PROP) throws error if PROP does NOT exist for MultilayerModularity.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13 ]);
			else
				assert( ...
					MultilayerModularity.existsProp(prop), ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerModularity.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer modularity/error.
			%
			% CHECK = MultilayerModularity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultilayerModularity, TAG) checks whether TAG exists for MultilayerModularity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  Element.EXISTSTAG(MultilayerModularity, TAG) throws error if TAG does NOT exist for MultilayerModularity.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				multilayermodularity_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'limit'  'randord'  'randmove'  'gamma'  'omega'  's0'  'om'  'quality_function' };
				
				check = any(strcmpi(tag, multilayermodularity_tag_list));
			else
				assert( ...
					MultilayerModularity.existsTag(tag), ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for MultilayerModularity'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerModularity, POINTER) returns property number of POINTER of MultilayerModularity.
			%  PROPERTY = M.GETPROPPROP(MultilayerModularity, POINTER) returns property number of POINTER of MultilayerModularity.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				multilayermodularity_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'limit'  'randord'  'randmove'  'gamma'  'omega'  's0'  'om'  'quality_function' };
				
				tag = pointer;
				MultilayerModularity.existsTag(tag);
				
				prop = find(strcmpi(tag, multilayermodularity_tag_list));
			else % numeric
				prop = pointer;
				MultilayerModularity.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(MultilayerModularity, POINTER) returns tag of POINTER of MultilayerModularity.
			%  TAG = M.GETPROPTAG(MultilayerModularity, POINTER) returns tag of POINTER of MultilayerModularity.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				MultilayerModularity.existsTag(tag);
			else % numeric
				prop = pointer;
				MultilayerModularity.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@MultilayerCommunityStructure(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerModularity, POINTER) returns category of POINTER of MultilayerModularity.
			%  CATEGORY = M.GETPROPCATEGORY(MultilayerModularity, POINTER) returns category of POINTER of MultilayerModularity.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MultilayerCommunityStructure(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerModularity, POINTER) returns format of POINTER of MultilayerModularity.
			%  FORMAT = M.GETPROPFORMAT(MultilayerModularity, POINTER) returns format of POINTER of MultilayerModularity.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MultilayerCommunityStructure(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerModularity, POINTER) returns description of POINTER of MultilayerModularity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultilayerModularity, POINTER) returns description of POINTER of MultilayerModularity.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				case MultilayerModularity.M
					prop_description = 'M (result, cell) is the multilayer modularity.';
				otherwise
					prop_description = getPropDescription@MultilayerCommunityStructure(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerModularity, POINTER) returns settings of POINTER of MultilayerModularity.
			%  SETTINGS = M.GETPROPSETTINGS(MultilayerModularity, POINTER) returns settings of POINTER of MultilayerModularity.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@MultilayerCommunityStructure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerModularity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerModularity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerModularity, POINTER) returns the default value of POINTER of MultilayerModularity.
			%  DEFAULT = M.GETPROPDEFAULT(MultilayerModularity, POINTER) returns the default value of POINTER of MultilayerModularity.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@MultilayerCommunityStructure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerModularity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerModularity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerModularity, POINTER) returns the conditioned default value of POINTER of MultilayerModularity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultilayerModularity, POINTER) returns the conditioned default value of POINTER of MultilayerModularity.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			prop_default = MultilayerModularity.conditioning(prop, MultilayerModularity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerModularity, PROP, VALUE) checks VALUE format for PROP of MultilayerModularity.
			%  CHECK = M.CHECKPROP(MultilayerModularity, PROP, VALUE) checks VALUE format for PROP of MultilayerModularity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:MultilayerModularity:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  Element.CHECKPROP(MultilayerModularity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerModularity.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			%  M.CHECKPROP(MultilayerModularity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerModularity.
			%   Error id: [BRAPH2:MultilayerModularity:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@MultilayerCommunityStructure(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerModularity:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerModularity.getPropTag(prop) ' (' MultilayerModularity.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 1 (Global).
			%
			% 1 = MultilayerModularity.GETMEASURESHAPE() returns the measures graph shape (Global).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.GLOBAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 1 (Superglobal).
			%
			% 1 = MultilayerModularity.GETMEASURESCOPE() returns the measures layer scope (Global).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.SUPERGLOBAL;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = MultilayerModularity.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of MultilayerModularity compatible graphs.
			%
			% LIST = MultilayerModularity.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
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
			%GETCOMPATIBLEGRAPHNUMBER returns the number (7) of MultilayerModularity compatible graphs.
			%
			% 7 = MultilayerModularity.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('MultilayerModularity');
		end
	end
	methods % constructor
		function m = MultilayerModularity(varargin)
			% MultilayerModularity() creates a multilayer modularity.
			%
			% MultilayerModularity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerModularity(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultilayerModularity properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multilayer modularity.
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
			
			m = m@MultilayerCommunityStructure(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = MultilayerModularity.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= MultilayerCommunityStructure.getPropNumber()
						value = conditioning@MultilayerCommunityStructure(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case MultilayerModularity.M
					multilayer_community_structure = calculateValue@MultilayerCommunityStructure(m, prop);
					Q = 0;
					if ~isempty(cell2mat(multilayer_community_structure))
					    Q = m.get('quality_function');
					end
					multilayer_modularity = {Q};  % assign normalized quality function
					value = multilayer_modularity;
					
				otherwise
					value = calculateValue@MultilayerCommunityStructure(m, prop);
					
			end
		end
	end
end
