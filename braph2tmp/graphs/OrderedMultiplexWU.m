classdef OrderedMultiplexWU < Graph
	% OrderedMultiplexWU is an ordinal multiplex weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multiplex weighted undirected (WU) graph, 
	% the edges are associated with a real number between 0 and 1 
	% indicating the strength of the connection, and they are undirected.
	% The connectivity matrix of each layer is symmetric.
	% The layers are connected in an ordinal fashion, where just 
	% consecutive layers are connected.
	%
	% The list of OrderedMultiplexWU properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph.
	%  <strong>4</strong> <strong>brainatlas</strong> 	BRAINATLAS (data, item) is a atlas associated with the graph.
	%  <strong>5</strong> <strong>a</strong> 	A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.
	%  <strong>6</strong> <strong>m_dict</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>7</strong> <strong>b</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
	%  <strong>8</strong> <strong>attemptsperedge</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
	%  <strong>9</strong> <strong>numberofweights</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
	%
	% OrderedMultiplexWU methods (constructor):
	% OrderedMultiplexWU - constructor
	%
	% OrderedMultiplexWU methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in ordinal multiplex weighted undirected graph/error.
	%  existsProp - checks whether property exists in ordinal multiplex weighted undirected graph/error.
	%  getPropNumber - returns the property number of ordinal multiplex weighted undirected graph.
	%  getProps - returns the property list of ordinal multiplex weighted undirected graph.
	%  getDescription - returns the description of the ordinal multiplex weighted undirected graph.
	%  getName - returns the name of the ordinal multiplex weighted undirected graph.
	%  getClass - returns the class of the ordinal multiplex weighted undirected graph.
	%  getNegativityType - returns the negativity type of the graph.
	%  getSelfConnectivityType - returns the self-connectivity type of the graph.
	%  getDirectionalityType - returns the directionality type of the graph.
	%  getConnectivityType - returns the connectivity type of the graph.
	%  getGraphType - returns the graph type.
	%  edgeattack - removes given edges from a graph
	%  nodeattack - removes given nodes from a graph
	%  subgraph - Extract a subgraph
	%  getCompatibleMeasureList - T returns the list of measures
	%  checkNegativity - checks if adjacency matrix A is correct for the negativity type.
	%  checkSelfConnectivity - checks if adjacency matrix A is correct for the self-connectivity type.
	%  checkDirectionality - checks if adjacency matrix A is correct for the directionality type.
	%  checkConnectivity - checks if adjacency matrix A is correct for the connectivity type.
	%  checkA - checks whether adjacency matrix A is correct for the type of graph.
	%  is_negative - checks whether graph allows negative values.
	%  is_nonnegative - checks whether graph allows non-negative values.
	%  is_not_selfconnected - checks if graph is not self-connected.
	%  is_selfconnected - checks if graph is self-connected.
	%  is_undirected - checks if graph is undirected.
	%  is_directed - checks if graph is directed
	%  is_binary - checks if graph is binary
	%  is_weighted - checks if graph is weighted.
	%  is_multilayer - checks if graph is multilayer
	%  is_ordered_multilayer - checks if graph is ordered multilayer.
	%  is_multiplex - checks if graph is multiplex.
	%  is_ordered_multiplex - checks if graph is ordered multiplex.
	%  is_multigraph - checks if graph is multigraph.
	%  is_graph - checks if graph is graph (single layer).
	%
	% OrderedMultiplexWU methods:
	%  randomize - E returns a randomized graph
	%  getMeasure - returns measure.
	%  layernumber - returns the number of layers in the graph.
	%  nodenumber - returns the number of nodes in the graph.
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
	% OrderedMultiplexWU methods (operators):
	%  isequal - determines whether two OrderedMultiplexWU are equal (values, locked)
	%
	% OrderedMultiplexWU methods (display):
	%  tostring - string with information about the OrderedMultiplexWU
	%  disp - displays information about the OrderedMultiplexWU
	%  tree - displays the element of OrderedMultiplexWU
	%
	% OrderedMultiplexWU method (element list):
	%  getElementList - returns a list with all subelements of OrderedMultiplexWU
	%
	% OrderedMultiplexWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the OrderedMultiplexWU
	%
	% OrderedMultiplexWU method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the OrderedMultiplexWU
	%
	% OrderedMultiplexWU methods (copy):
	%  copy - copies the OrderedMultiplexWU
	%  deepclone - deep-clones the OrderedMultiplexWU
	%  clone - clones the OrderedMultiplexWU
	%
	% OrderedMultiplexWU methods (inspection, Static):
	%  getClass - returns OrderedMultiplexWU
	%  getName - returns the name of OrderedMultiplexWU
	%  getDescription - returns the description of OrderedMultiplexWU
	%  getProps - returns the property list of OrderedMultiplexWU
	%  getPropNumber - returns the property number of OrderedMultiplexWU
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
	% OrderedMultiplexWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrderedMultiplexWU methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% OrderedMultiplexWU methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% OrderedMultiplexWU methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% OrderedMultiplexWU properties (Constant).
	%  B - 7
	%  B_TAG - 'b'
	%  B_CATEGORY - 'd'
	%  B_FORMAT - 'll'
	%  ATTEMPTSPEREDGE - 8
	%  ATTEMPTSPEREDGE_TAG - 'attemptsperedge'
	%  ATTEMPTSPEREDGE_CATEGORY - 'p'
	%  ATTEMPTSPEREDGE_FORMAT - 'nn'
	%  NUMBEROFWEIGHTS - 9
	%  NUMBEROFWEIGHTS_TAG - 'numberofweights'
	%  NUMBEROFWEIGHTS_CATEGORY - 'p'
	%  NUMBEROFWEIGHTS_FORMAT - 'nn'
	%  GRAPH - 1
	%  GRAPH_NAME - 'Graph'
	%  GRAPH_DESCRIPTION - 'A graph consists of a single layer.'
	%  MULTIGRAPH - 2
	%  MULTIGRAPH_NAME - 'Multigraph'
	%  MULTIGRAPH_DESCRIPTION - 'A multigraph consists of multiple unconnected layers.'
	%  ORDERED_MULTIPLEX - 3
	%  ORDERED_MULTIPLEX_NAME - 'Ordered Multipex'
	%  ORDERED_MULTIPLEX_DESCRIPTION - 'An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.'
	%  MULTIPLEX - 4
	%  MULTIPLEX_NAME - 'Multiplex'
	%  MULTIPLEX_DESCRIPTION - 'A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.'
	%  ORDERED_MULTILAYER - 5
	%  ORDERED_MULTILAYER_NAME - 'Ordered Multilayer'
	%  ORDERED_MULTILAYER_DESCRIPTION - 'An ordered multilayer consists of multiple layers with ordinal connections between any nodes.'
	%  MULTILAYER - 6
	%  MULTILAYER_NAME - 'Multilayer'
	%  MULTILAYER_DESCRIPTION - 'A multilayer consists of multiple layers with categorical between any nodes.'
	%  TYPE_NUMBER - 6
	%  TYPE_NAME - cell[6 1] { 'Graph' 'Multigraph' 'Ordered Multipex' 'Multiplex' 'Ordered Multilayer' 'Multilayer' }
	%  TYPE_DESCRIPTION - cell[6 1] { 'A graph consists of a single layer.' 'A multigraph consists of multiple unconnected layers.' 'An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.' 'A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.' 'An ordered multilayer consists of multiple layers with ordinal connections between any nodes.' 'A multilayer consists of multiple layers with categorical between any nodes.' }
	%  WEIGHTED - 1
	%  WEIGHTED_NAME - 'Weighted'
	%  WEIGHTED_DESCRIPTION - 'Graph with weighted connections.'
	%  BINARY - 2
	%  BINARY_NAME - 'Binary'
	%  BINARY_DESCRIPTION - 'Graph with binary (0 or 1) connections.'
	%  CONNECTIVITY_TYPE_NUMBER - 2
	%  CONNECTIVITY_TYPE_NAME - cell[2 1] { 'Weighted' 'Binary' }
	%  CONNECTIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph with weighted connections.' 'Graph with binary (0 or 1) connections.' }
	%  DIRECTED - 1
	%  DIRECTED_NAME - 'Directed'
	%  DIRECTED_DESCRIPTION - 'Graph with directed edges.'
	%  UNDIRECTED - 2
	%  UNDIRECTED_NAME - 'Undirected'
	%  UNDIRECTED_DESCRIPTION - 'Graph with undirected edges.'
	%  DIRECTIONALITY_TYPE_NUMBER - 2
	%  DIRECTIONALITY_TYPE_NAME - cell[2 1] { 'Directed' 'Undirected' }
	%  DIRECTIONALITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph with directed edges.' 'Graph with undirected edges.' }
	%  NONSELFCONNECTED - 1
	%  NONSELFCONNECTED_NAME - 'Non-self-connected'
	%  NONSELFCONNECTED_DESCRIPTION - 'Graph without self-connections.'
	%  SELFCONNECTED - 2
	%  SELFCONNECTED_NAME - 'Self-connected'
	%  SELFCONNECTED_DESCRIPTION - 'Graph with self-connections.'
	%  SELFCONNECTIVITY_TYPE_NUMBER - 2
	%  SELFCONNECTIVITY_TYPE_NAME - cell[2 1] { 'Non-self-connected' 'Self-connected' }
	%  SELFCONNECTIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph without self-connections.' 'Graph with self-connections.' }
	%  NONNEGATIVE - 1
	%  NONNEGATIVE_NAME - 'Non-negative'
	%  NONNEGATIVE_DESCRIPTION - 'Graph without negative edges.'
	%  NEGATIVE - 2
	%  NEGATIVE_NAME - 'Negative'
	%  NEGATIVE_DESCRIPTION - 'Graph allowing negative edges.'
	%  NEGATIVITY_TYPE_NUMBER - 2
	%  NEGATIVITY_TYPE_NAME - cell[2 1] { 'Non-negative' 'Negative' }
	%  NEGATIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph without negative edges.' 'Graph allowing negative edges.' }
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
	%  BRAINATLAS - 4
	%  BRAINATLAS_TAG - 'brainatlas'
	%  BRAINATLAS_CATEGORY - 'd'
	%  BRAINATLAS_FORMAT - 'it'
	%  A - 5
	%  A_TAG - 'a'
	%  A_CATEGORY - 'r'
	%  A_FORMAT - 'll'
	%  M_DICT - 6
	%  M_DICT_TAG - 'm_dict'
	%  M_DICT_CATEGORY - 'r'
	%  M_DICT_FORMAT - 'di'
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
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'b';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.CELL;
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 2;
		ATTEMPTSPEREDGE_TAG = 'attemptsperedge';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		NUMBEROFWEIGHTS = Graph.getPropNumber() + 3;
		NUMBEROFWEIGHTS_TAG = 'numberofweights';
		NUMBEROFWEIGHTS_CATEGORY = Category.PARAMETER;
		NUMBEROFWEIGHTS_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function g_class = getClass()
			%GETCLASS returns the class of the ordinal multiplex weighted undirected graph.
			%
			% CLASS = OrderedMultiplexWU.GETCLASS() returns the class 'OrderedMultiplexWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrderedMultiplexWU') returns 'OrderedMultiplexWU'.
			%
			% See also getName, getDescription.
			
			g_class = 'OrderedMultiplexWU';
		end
		function g_name = getName()
			%GETNAME returns the name of the ordinal multiplex weighted undirected graph.
			%
			% NAME = OrderedMultiplexWU.GETNAME() returns the name of the 'ordinal multiplex weighted undirected graph'.
			%  Ordinal Multiplex Weighted Undirected Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = G.GETNAME() returns the name of the ordinal multiplex weighted undirected graph G.
			%  NAME = Element.GETNAME(G) returns the name of 'G'.
			%  NAME = Element.GETNAME('OrderedMultiplexWU') returns the name of 'OrderedMultiplexWU'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			g_name = 'Ordinal Multiplex Weighted Undirected Graph';
		end
		function g_description = getDescription()
			%GETDESCRIPTION returns the description of the ordinal multiplex weighted undirected graph.
			%
			% STR = OrderedMultiplexWU.GETDESCRIPTION() returns the description of the 'ordinal multiplex weighted undirected graph'.
			%  which is:
			%
			%  In an ordinal multiplex weighted undirected (WU) graph, 
			%  the edges are associated with a real number between 0 and 1 
			%  indicating the strength of the connection, and they are undirected.
			%  The connectivity matrix of each layer is symmetric.
			%  The layers are connected in an ordinal fashion, where just 
			%  consecutive layers are connected.
			%
			% Alternative forms to call this method are:
			%  STR = G.GETDESCRIPTION() returns the description of the ordinal multiplex weighted undirected graph G.
			%  STR = Element.GETDESCRIPTION(G) returns the description of 'G'.
			%  STR = Element.GETDESCRIPTION('OrderedMultiplexWU') returns the description of 'OrderedMultiplexWU'.
			%
			% See also getClass, getName.
			
			g_description = [
				'In an ordinal multiplex weighted undirected (WU) graph, ' ...
				'the edges are associated with a real number between 0 and 1 ' ...
				'indicating the strength of the connection, and they are undirected.' ...
				'The connectivity matrix of each layer is symmetric.' ...
				'The layers are connected in an ordinal fashion, where just ' ...
				'consecutive layers are connected.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex weighted undirected graph.
			%
			% PROPS = OrderedMultiplexWU.GETPROPS() returns the property list of ordinal multiplex weighted undirected graph.
			%
			% PROPS = OrderedMultiplexWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrderedMultiplexWU'[, CATEGORY]) returns the property list of 'OrderedMultiplexWU'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Graph.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Graph.getProps(Category.PARAMETER)
						OrderedMultiplexWU.ATTEMPTSPEREDGE
						OrderedMultiplexWU.NUMBEROFWEIGHTS
						];
				case Category.DATA
					prop_list = [
						Graph.getProps(Category.DATA)
						OrderedMultiplexWU.B
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Graph.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Graph.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Graph.getProps()
						OrderedMultiplexWU.B
						OrderedMultiplexWU.ATTEMPTSPEREDGE
						OrderedMultiplexWU.NUMBEROFWEIGHTS
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of ordinal multiplex weighted undirected graph.
			%
			% N = OrderedMultiplexWU.GETPROPNUMBER() returns the property number of ordinal multiplex weighted undirected graph.
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER() returns the property number of the ordinal multiplex weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrderedMultiplexWU') returns the property number of 'OrderedMultiplexWU'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 9;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multiplex weighted undirected graph/error.
			%
			% CHECK = OrderedMultiplexWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrderedMultiplexWU, PROP) checks whether PROP exists for OrderedMultiplexWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  Element.EXISTSPROP(OrderedMultiplexWU, PROP) throws error if PROP does NOT exist for OrderedMultiplexWU.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9 ]);
			else
				assert( ...
					OrderedMultiplexWU.existsProp(prop), ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrderedMultiplexWU.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex weighted undirected graph/error.
			%
			% CHECK = OrderedMultiplexWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrderedMultiplexWU, TAG) checks whether TAG exists for OrderedMultiplexWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  Element.EXISTSTAG(OrderedMultiplexWU, TAG) throws error if TAG does NOT exist for OrderedMultiplexWU.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				orderedmultiplexwu_tag_list = { 'id'  'label'  'notes'  'brainatlas'  'a'  'm_dict'  'b'  'attemptsperedge'  'numberofweights' };
				
				check = any(strcmpi(tag, orderedmultiplexwu_tag_list));
			else
				assert( ...
					OrderedMultiplexWU.existsTag(tag), ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for OrderedMultiplexWU'] ...
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
			%  PROPERTY = G.GETPROPPROP(POINTER) returns property number of POINTER of G.
			%  PROPERTY = Element.GETPROPPROP(OrderedMultiplexWU, POINTER) returns property number of POINTER of OrderedMultiplexWU.
			%  PROPERTY = G.GETPROPPROP(OrderedMultiplexWU, POINTER) returns property number of POINTER of OrderedMultiplexWU.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				orderedmultiplexwu_tag_list = { 'id'  'label'  'notes'  'brainatlas'  'a'  'm_dict'  'b'  'attemptsperedge'  'numberofweights' };
				
				tag = pointer;
				OrderedMultiplexWU.existsTag(tag);
				
				prop = find(strcmpi(tag, orderedmultiplexwu_tag_list));
			else % numeric
				prop = pointer;
				OrderedMultiplexWU.existsProp(prop);
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
			%  TAG = G.GETPROPTAG(POINTER) returns tag of POINTER of G.
			%  TAG = Element.GETPROPTAG(OrderedMultiplexWU, POINTER) returns tag of POINTER of OrderedMultiplexWU.
			%  TAG = G.GETPROPTAG(OrderedMultiplexWU, POINTER) returns tag of POINTER of OrderedMultiplexWU.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				OrderedMultiplexWU.existsTag(tag);
			else % numeric
				prop = pointer;
				OrderedMultiplexWU.existsProp(prop);
				
				switch prop
					case OrderedMultiplexWU.B
						tag = OrderedMultiplexWU.B_TAG;
					case OrderedMultiplexWU.ATTEMPTSPEREDGE
						tag = OrderedMultiplexWU.ATTEMPTSPEREDGE_TAG;
					case OrderedMultiplexWU.NUMBEROFWEIGHTS
						tag = OrderedMultiplexWU.NUMBEROFWEIGHTS_TAG;
					otherwise
						tag = getPropTag@Graph(prop);
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
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(OrderedMultiplexWU, POINTER) returns category of POINTER of OrderedMultiplexWU.
			%  CATEGORY = G.GETPROPCATEGORY(OrderedMultiplexWU, POINTER) returns category of POINTER of OrderedMultiplexWU.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					prop_category = OrderedMultiplexWU.B_CATEGORY;
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					prop_category = OrderedMultiplexWU.ATTEMPTSPEREDGE_CATEGORY;
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					prop_category = OrderedMultiplexWU.NUMBEROFWEIGHTS_CATEGORY;
				otherwise
					prop_category = getPropCategory@Graph(prop);
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
			%  FORMAT = G.GETPROPFORMAT(POINTER) returns format of POINTER of G.
			%  FORMAT = Element.GETPROPFORMAT(OrderedMultiplexWU, POINTER) returns format of POINTER of OrderedMultiplexWU.
			%  FORMAT = G.GETPROPFORMAT(OrderedMultiplexWU, POINTER) returns format of POINTER of OrderedMultiplexWU.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					prop_format = OrderedMultiplexWU.B_FORMAT;
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					prop_format = OrderedMultiplexWU.ATTEMPTSPEREDGE_FORMAT;
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					prop_format = OrderedMultiplexWU.NUMBEROFWEIGHTS_FORMAT;
				otherwise
					prop_format = getPropFormat@Graph(prop);
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
			%  DESCRIPTION = G.GETPROPDESCRIPTION(POINTER) returns description of POINTER of G.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrderedMultiplexWU, POINTER) returns description of POINTER of OrderedMultiplexWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrderedMultiplexWU, POINTER) returns description of POINTER of OrderedMultiplexWU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					prop_description = 'B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.';
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case OrderedMultiplexWU.A
					prop_description = 'A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.';
				otherwise
					prop_description = getPropDescription@Graph(prop);
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
			%  SETTINGS = G.GETPROPSETTINGS(POINTER) returns settings of POINTER of G.
			%  SETTINGS = Element.GETPROPSETTINGS(OrderedMultiplexWU, POINTER) returns settings of POINTER of OrderedMultiplexWU.
			%  SETTINGS = G.GETPROPSETTINGS(OrderedMultiplexWU, POINTER) returns settings of POINTER of OrderedMultiplexWU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					prop_settings = Format.getFormatSettings(Format.CELL);
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrderedMultiplexWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrderedMultiplexWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrderedMultiplexWU, POINTER) returns the default value of POINTER of OrderedMultiplexWU.
			%  DEFAULT = G.GETPROPDEFAULT(OrderedMultiplexWU, POINTER) returns the default value of POINTER of OrderedMultiplexWU.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					prop_default = {[] []};;
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					prop_default = 10;
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrderedMultiplexWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrderedMultiplexWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrderedMultiplexWU, POINTER) returns the conditioned default value of POINTER of OrderedMultiplexWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrderedMultiplexWU, POINTER) returns the conditioned default value of POINTER of OrderedMultiplexWU.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			prop_default = OrderedMultiplexWU.conditioning(prop, OrderedMultiplexWU.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = G.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = G.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of G.
			%  CHECK = Element.CHECKPROP(OrderedMultiplexWU, PROP, VALUE) checks VALUE format for PROP of OrderedMultiplexWU.
			%  CHECK = G.CHECKPROP(OrderedMultiplexWU, PROP, VALUE) checks VALUE format for PROP of OrderedMultiplexWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  Element.CHECKPROP(OrderedMultiplexWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrderedMultiplexWU.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			%  G.CHECKPROP(OrderedMultiplexWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrderedMultiplexWU.
			%   Error id: [BRAPH2:OrderedMultiplexWU:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				case OrderedMultiplexWU.B
					check = Format.checkFormat(Format.CELL, value, OrderedMultiplexWU.getPropSettings(prop));
				case OrderedMultiplexWU.ATTEMPTSPEREDGE
					check = Format.checkFormat(Format.SCALAR, value, OrderedMultiplexWU.getPropSettings(prop));
				case OrderedMultiplexWU.NUMBEROFWEIGHTS
					check = Format.checkFormat(Format.SCALAR, value, OrderedMultiplexWU.getPropSettings(prop));
				otherwise
					check = checkProp@Graph(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OrderedMultiplexWU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrderedMultiplexWU.getPropTag(prop) ' (' OrderedMultiplexWU.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function graph = getGraphType()
			%GETGRAPHTYPE returns 3 (Ordered Multipex).
			%
			% 3 = OrderedMultiplexWU.GETGRAPHTYPE() returns the type of graph (Ordered Multipex).
			%
			% See also getConnectivityType, getDirectionalityType, getSelfConnectivityType, getNegativityType.
			
			graph = Graph.ORDERED_MULTIPLEX;
		end
		function connectivity = getConnectivityType(varargin)
			%GETCONNECTIVITYTYPE returns 1 (Weighted).
			%
			% 1 = OrderedMultiplexWU.GETCONNECTIVITYTYPE() returns the type of graph connectivity (Weighted).
			%
			% 1 = OrderedMultiplexWU.GETCONNECTIVITYTYPE(LAYERNUMBER) returns a matrix with the 
			%  connectivity type of each layer in a multiple layer graph.
			%
			% See also getGraphType, getDirectionalityType, getSelfConnectivityType, getNegativityType.
			
			
			if isempty(varargin)
				layernumber = 1;
			else
				layernumber = varargin{1};
			end
			
			connectivity = Graph.WEIGHTED * ones(layernumber);
		end
		function directionality = getDirectionalityType(varargin)
			%GETDIRECTIONALITYTYPE returns 1 (Directed).
			%
			% 1 = OrderedMultiplexWU.GETDIRECTIONALITYTYPE() returns the type of graph directionality (Directed).
			% the directionality type of each layer.
			%
			% 1 = OrderedMultiplexWU.GETDIRECTIONALITYTYPE(LAYERNUMBER) returns a matrix with 
			%  the directionality type of each layer.
			%
			% See also getGraphType, getConnectivityType, getSelfConnectivityType, getNegativityType.
			
			
			if isempty(varargin)
				layernumber = 1;
			else
				layernumber = varargin{1};
			end
			
			directionality = Graph.UNDIRECTED * ones(layernumber);
		end
		function selfconnectivity = getSelfConnectivityType(varargin)
			%GETSELFCONNECTIVITYTYPE returns 1 (Non-self-connected).
			%
			% 1 = OrderedMultiplexWU.GETSELFCONNECTIVITYTYPE() returns the type of graph self connnectivity (Non-self-connected).
			%
			% 1 = OrderedMultiplexWU.GETSELFCONNECTIVITYTYPE(LAYERNUMBER) returns a matrix 
			%  with the self-connectivity type of each layer.
			%
			% See also getGraphType, getConnectivityType, getDirectionalityType, getNegativityType.
			
			
			if isempty(varargin)
				layernumber = 1;
			else
				layernumber = varargin{1};
			end
			
			selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
			selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;
		end
		function negativity = getNegativityType(varargin)
			%GETNEGATIVITYTYPE returns 1 (Non-negative).
			%
			% 1 = OrderedMultiplexWU.GETNEGATIVITYTYPE() returns the type of graph negativity (Non-negative).
			%
			% 1 = OrderedMultiplexWU.GETNEGATIVITYTYPE(LAYERNUMBER) returns a matrix 
			%  with the negativity type of each layer.
			%
			% See also getGraphType, getConnectivityType, getDirectionalityType, getSelfConnectivityType.
			
			
			if isempty(varargin)
				layernumber = 1;
			else
				layernumber = varargin{1};
			end
			
			negativity = Graph.NONNEGATIVE * ones(layernumber);
		end
	end
	methods % constructor
		function g = OrderedMultiplexWU(varargin)
			% OrderedMultiplexWU() creates a ordinal multiplex weighted undirected graph.
			%
			% OrderedMultiplexWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrderedMultiplexWU(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OrderedMultiplexWU properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph.
			%  <strong>4</strong> <strong>brainatlas</strong> 	BRAINATLAS (data, item) is a atlas associated with the graph.
			%  <strong>5</strong> <strong>a</strong> 	A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.
			%  <strong>6</strong> <strong>m_dict</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>7</strong> <strong>b</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
			%  <strong>8</strong> <strong>attemptsperedge</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
			%  <strong>9</strong> <strong>numberofweights</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
			%
			% See also Category, Format, set, check.
			
			g = g@Graph(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = OrderedMultiplexWU.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Graph.getPropNumber()
						value = conditioning@Graph(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop)
		
			switch prop
				case OrderedMultiplexWU.A
					B = g.get('B');
					L = length(B); %% number of layers
					A = cell(L, L);
					
					varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
					for i = 1:1:L
					    M = symmetrize(B{i}, varargin{:}); %% enforces symmetry of adjacency matrix
					    M = dediagonalize(M, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
					    M = semipositivize(M, varargin{:}); %% removes negative weights
					    M = standardize(M, varargin{:}); %% enforces binary adjacency matrix
					    A(i, i) = {M};
					    if ~isempty(A{1, 1})
					        for j = i+1:1:L
					            if j == i+1
					                A(i, j) = {eye(length(A{1, 1}))};
					                A(j, i) = {eye(length(A{1, 1}))};
					            else
					                A(i, j) = {zeros(length(A{1, 1}))};
					                A(j, i) = {zeros(length(A{1, 1}))};
					            end
					        end
					    end
					end
					
					value = A;
					
				otherwise
					value = calculateValue@Graph(g, prop);
					
			end
		end
	end
	methods % methods
		function random_g = randomize(g)
		    % RANDOMIZE returns a randomized graph
		    %
		    % RANDOMIZED_G = RANDOMIZE(G) returns the randomized
		    % graph RANDOM_G obtained with a randomized correlation
		    % matrix via the static function randomize_A while preserving
		    % degree distributions. The randomization it is done layer by
		    % layer and then integrated in the 2-D supra-adjacency matrix
		    % cell array.
		    %
		    % RANDOMIZED_G = RANDOMIZE(G, 'AttemptsPerEdge', VALUE)
		    % returns the randomized graph RANDOM_G obtained with a
		    % randomized correlation matrix via the static function
		    % randomize_A while preserving  degree distributions.
		    % The multiplex is randomized layer by layer where randomized
		    % adjacency matrix of each layer are then integrated in the
		    % 2-D supra-adjacency matrix cell array.
		    %
		    % See also GraphBD
		
		    % get rules
		    number_of_weights = g.get('NUMBEROFWEIGHTS');
		    attempts_per_edge = g.get('ATTEMPTSPEREDGE');
		
		    if nargin<2
		        attempts_per_edge = 5;
		    end
		
		    % get A
		    A = g.get('A');
		    L = g.layernumber();
		    random_multi_A = cell(1, L);
		
		    for li = 1:1:L
		        Aii = A{li, li};
		        random_A = GraphWU.randomize_A(Aii, attempts_per_edge, number_of_weights);
		        random_multi_A(li) = {random_A};
		    end
		    random_g = OrderedMultiplexWU('B', random_multi_A);
		end
	end
end
