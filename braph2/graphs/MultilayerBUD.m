classdef MultilayerBUD < MultilayerWU
	%MultilayerBUD is a binary undirected multilayer graph with fixed densities.
	% It is a subclass of <a href="matlab:help MultilayerWU">MultilayerWU</a>.
	%
	% In a multilayer binary undirected with fixed densities (BUD) graph, the layers 
	%  are those of binary undirected (BU) multilayer graphs derived from the same 
	%  weighted supra-adjacency matrix binarized at different densities. The supra-adjacency 
	%  matrix has a number of partitions equal to the number of densities. Layers
	%  within the binary undirected (BU) multilayer graphs could have different number of nodes 
	%  with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% All node connections are allowed between layers.
	% On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
	% On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.
	%
	% The list of MultilayerBUD properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the binary undirected multilayer graph with fixed densities.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the binary undirected multilayer graph with fixed densities.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary undirected multilayer graph with fixed densities.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the binary undirected multilayer graph with fixed densities.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the binary undirected multilayer graph with fixed densities.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the binary undirected multilayer with fixed densities.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the binary undirected multilayer graph with fixed densities.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type 6.
	%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type 2 * ones(layernumber).
	%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type 2 * ones(layernumber).
	%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type 1 on the diagonal and 2 off diagonal.
	%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type  ones(layernumber).
	%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
	%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
	%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
	%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels for A.
	%  <strong>18</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
	%  <strong>19</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
	%  <strong>20</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
	%  <strong>21</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the nodel labels for each layer.
	%  <strong>22</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
	%  <strong>23</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
	%  <strong>24</strong> <strong>A</strong> 	A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed densities (BUD) graph.
	%  <strong>25</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
	%  <strong>26</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
	%  <strong>27</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
	%  <strong>28</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers for each partition (density) of the graph.
	%  <strong>29</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>30</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
	%  <strong>31</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
	%  <strong>32</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
	%  <strong>33</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
	%  <strong>34</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.
	%  <strong>35</strong> <strong>SYMMETRIZE_RULE</strong> 	SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
	%  <strong>36</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
	%  <strong>37</strong> <strong>STANDARDIZE_RULE</strong> 	STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
	%  <strong>38</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
	%  <strong>39</strong> <strong>NUMBEROFWEIGHTS</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
	%  <strong>40</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
	%  <strong>41</strong> <strong>DENSITIES</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
	%
	% MultilayerBUD methods (constructor):
	%  MultilayerBUD - constructor
	%
	% MultilayerBUD methods:
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
	% MultilayerBUD methods (display):
	%  tostring - string with information about the multilayer binary undirected with fixed densities graph
	%  disp - displays information about the multilayer binary undirected with fixed densities graph
	%  tree - displays the tree of the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer binary undirected with fixed densities graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (save/load, Static):
	%  save - saves BRAPH2 multilayer binary undirected with fixed densities graph as b2 file
	%  load - loads a BRAPH2 multilayer binary undirected with fixed densities graph from a b2 file
	%
	% MultilayerBUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer binary undirected with fixed densities graph
	%
	% MultilayerBUD methods (inspection, Static):
	%  getClass - returns the class of the multilayer binary undirected with fixed densities graph
	%  getSubclasses - returns all subclasses of MultilayerBUD
	%  getProps - returns the property list of the multilayer binary undirected with fixed densities graph
	%  getPropNumber - returns the property number of the multilayer binary undirected with fixed densities graph
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
	% MultilayerBUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerBUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerBUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerBUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerBUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerBUD constants</a>.
	%
	
	properties (Constant) % properties
		DENSITIES = 41; %CET: Computational Efficiency Trick
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = 3;
		DENSITIES_FORMAT = 12;
	end
	methods % constructor
		function g = MultilayerBUD(varargin)
			%MultilayerBUD() creates a multilayer binary undirected with fixed densities graph.
			%
			% MultilayerBUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerBUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultilayerBUD properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the binary undirected multilayer graph with fixed densities.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the binary undirected multilayer graph with fixed densities.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary undirected multilayer graph with fixed densities.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the binary undirected multilayer graph with fixed densities.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the binary undirected multilayer graph with fixed densities.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the binary undirected multilayer with fixed densities.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the binary undirected multilayer graph with fixed densities.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type 6.
			%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type 2 * ones(layernumber).
			%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type 2 * ones(layernumber).
			%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type 1 on the diagonal and 2 off diagonal.
			%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type  ones(layernumber).
			%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
			%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
			%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
			%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels for A.
			%  <strong>18</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
			%  <strong>19</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
			%  <strong>20</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
			%  <strong>21</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the nodel labels for each layer.
			%  <strong>22</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
			%  <strong>23</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
			%  <strong>24</strong> <strong>A</strong> 	A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed densities (BUD) graph.
			%  <strong>25</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
			%  <strong>26</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
			%  <strong>27</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
			%  <strong>28</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers for each partition (density) of the graph.
			%  <strong>29</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>30</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
			%  <strong>31</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
			%  <strong>32</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
			%  <strong>33</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
			%  <strong>34</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.
			%  <strong>35</strong> <strong>SYMMETRIZE_RULE</strong> 	SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
			%  <strong>36</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
			%  <strong>37</strong> <strong>STANDARDIZE_RULE</strong> 	STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
			%  <strong>38</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
			%  <strong>39</strong> <strong>NUMBEROFWEIGHTS</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
			%  <strong>40</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
			%  <strong>41</strong> <strong>DENSITIES</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
			%
			% See also Category, Format.
			
			g = g@MultilayerWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the multilayer binary undirected with fixed densities graph.
			%
			% CLASS = MultilayerBUD.GETCLASS() returns the class 'MultilayerBUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the multilayer binary undirected with fixed densities graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('MultilayerBUD') returns 'MultilayerBUD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('MultilayerBUD')
			%  are less computationally efficient.
			
			g_class = 'MultilayerBUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer binary undirected with fixed densities graph.
			%
			% LIST = MultilayerBUD.GETSUBCLASSES() returns all subclasses of 'MultilayerBUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the multilayer binary undirected with fixed densities graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('MultilayerBUD') returns all subclasses of 'MultilayerBUD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultilayerBUD' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer binary undirected with fixed densities graph.
			%
			% PROPS = MultilayerBUD.GETPROPS() returns the property list of multilayer binary undirected with fixed densities graph
			%  as a row vector.
			%
			% PROPS = MultilayerBUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the multilayer binary undirected with fixed densities graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('MultilayerBUD'[, CATEGORY]) returns the property list of 'MultilayerBUD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 30];
				case 2 % Category.METADATA
					prop_list = [6 7 14 16 18 20];
				case 3 % Category.PARAMETER
					prop_list = [4 22 23 35 36 37 38 39 41];
				case 4 % Category.DATA
					prop_list = [5 34];
				case 5 % Category.RESULT
					prop_list = [24 26 27 28 29];
				case 6 % Category.QUERY
					prop_list = [8 10 11 12 13 15 17 19 21 25 31 40];
				case 9 % Category.GUI
					prop_list = [32 33];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multilayer binary undirected with fixed densities graph.
			%
			% N = MultilayerBUD.GETPROPNUMBER() returns the property number of multilayer binary undirected with fixed densities graph.
			%
			% N = MultilayerBUD.GETPROPNUMBER(CATEGORY) returns the property number of multilayer binary undirected with fixed densities graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer binary undirected with fixed densities graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('MultilayerBUD') returns the property number of 'MultilayerBUD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 41;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 5;
				case 2 % Category.METADATA
					prop_number = 6;
				case 3 % Category.PARAMETER
					prop_number = 9;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 12;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer binary undirected with fixed densities graph/error.
			%
			% CHECK = MultilayerBUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(MultilayerBUD, PROP) checks whether PROP exists for MultilayerBUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSPROP(MultilayerBUD, PROP) throws error if PROP does NOT exist for MultilayerBUD.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 41 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerBUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer binary undirected with fixed densities graph/error.
			%
			% CHECK = MultilayerBUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(MultilayerBUD, TAG) checks whether TAG exists for MultilayerBUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%  Element.EXISTSTAG(MultilayerBUD, TAG) throws error if TAG does NOT exist for MultilayerBUD.
			%   Error id: [BRAPH2:MultilayerBUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'DENSITIES' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerBUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerBUD, POINTER) returns property number of POINTER of MultilayerBUD.
			%  PROPERTY = G.GETPROPPROP(MultilayerBUD, POINTER) returns property number of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'DENSITIES' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = G.GETPROPTAG(POINTER) returns tag of POINTER of G.
			%  TAG = Element.GETPROPTAG(MultilayerBUD, POINTER) returns tag of POINTER of MultilayerBUD.
			%  TAG = G.GETPROPTAG(MultilayerBUD, POINTER) returns tag of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multilayerbud_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'DENSITIES' };
				tag = multilayerbud_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerBUD, POINTER) returns category of POINTER of MultilayerBUD.
			%  CATEGORY = G.GETPROPCATEGORY(MultilayerBUD, POINTER) returns category of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayerbud_category_list = { 1  1  1  3  4  2  2  6  1  6  6  6  6  2  6  2  6  2  6  2  6  3  3  5  6  5  5  5  5  1  6  9  9  4  3  3  3  3  3  6  3 };
			prop_category = multilayerbud_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerBUD, POINTER) returns format of POINTER of MultilayerBUD.
			%  FORMAT = G.GETPROPFORMAT(MultilayerBUD, POINTER) returns format of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayerbud_format_list = { 2  2  2  8  2  2  2  2  11  15  15  15  11  12  12  3  3  3  3  3  3  4  11  16  4  12  11  12  10  7  8  8  8  16  5  5  5  11  11  16  12 };
			prop_format = multilayerbud_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerBUD, POINTER) returns description of POINTER of MultilayerBUD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(MultilayerBUD, POINTER) returns description of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayerbud_description_list = { 'ELCLASS (constant, string) is the class of the binary undirected multilayer graph with fixed densities.'  'NAME (constant, string) is the name of the binary undirected multilayer graph with fixed densities.'  'DESCRIPTION (constant, string) is the description of the binary undirected multilayer graph with fixed densities.'  'TEMPLATE (parameter, item) is the template of the binary undirected multilayer graph with fixed densities.'  'ID (data, string) is a few-letter code for the binary undirected multilayer graph with fixed densities.'  'LABEL (metadata, string) is an extended label of the binary undirected multilayer with fixed densities.'  'NOTES (metadata, string) are some specific notes about the binary undirected multilayer graph with fixed densities.'  'TOSTRING (query, string) returns a string that represents the object.'  'GRAPH_TYPE (constant, scalar) returns the graph type 6.'  'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type 2 * ones(layernumber).'  'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type 2 * ones(layernumber).'  'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type 1 on the diagonal and 2 off diagonal.'  'NEGATIVITY_TYPE (query, smatrix) returns the negativity type  ones(layernumber).'  'LAYERTICKS (metadata, rvector) are the layer tick values.'  'ALAYERTICKS (query, rvector) returns the layer tick values.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the layer labels for A.'  'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.'  'APARTITIONLABELS (query, stringlist) returns the partition labels for A.'  'NODELABELS (metadata, stringlist) are the node labels provided by the user.'  'ANODELABELS (query, stringlist) returns the nodel labels for each layer.'  'RANDOMIZE (parameter, logical) determines whether to randomize the graph.'  'RANDOM_SEED (parameter, scalar) is the randomization seed.'  'A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed densities (BUD) graph.'  'A_CHECK (query, logical) checks the format of the adjacency matrix.'  'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.'  'LAYERNUMBER (result, scalar) returns the number of layers in the graph.'  'PARTITIONS (result, rvector) returns the number of layers for each partition (density) of the graph.'  'M_DICT (result, idict) contains the calculated measures of the graph.'  'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.'  'MEASURE (query, item) returns a measure.'  'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.'  'PFGH (gui, item) contains the panel figure of the graph histogram.'  'B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.'  'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.'  'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.'  'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.'  'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.'  'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.'  'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.'  'DENSITIES (parameter, rvector) is the vector of densities.' };
			prop_description = multilayerbud_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerBUD, POINTER) returns settings of POINTER of MultilayerBUD.
			%  SETTINGS = G.GETPROPSETTINGS(MultilayerBUD, POINTER) returns settings of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 41 % MultilayerBUD.DENSITIES
					prop_settings = Format.getFormatSettings(12);
				case 4 % MultilayerBUD.TEMPLATE
					prop_settings = 'MultilayerBUD';
				otherwise
					prop_settings = getPropSettings@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerBUD, POINTER) returns the default value of POINTER of MultilayerBUD.
			%  DEFAULT = G.GETPROPDEFAULT(MultilayerBUD, POINTER) returns the default value of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 41 % MultilayerBUD.DENSITIES
					prop_default = [0 0 0 0];
				case 1 % MultilayerBUD.ELCLASS
					prop_default = 'MultilayerBUD';
				case 2 % MultilayerBUD.NAME
					prop_default = 'MultilayerBUD';
				case 3 % MultilayerBUD.DESCRIPTION
					prop_default = 'In a multilayer binary undirected with fixed densities (BUD) graph, the layers are those of binary undirected (BU) multilayer graphs derived from the same weighted supra-adjacency matrix binarized at different densities. The supra-adjacency matrix has a number of partitions equal to the number of densities. Layerswithin the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.';
				case 4 % MultilayerBUD.TEMPLATE
					prop_default = Format.getFormatDefault(8, MultilayerBUD.getPropSettings(prop));
				case 5 % MultilayerBUD.ID
					prop_default = 'MultilayerBUD ID';
				case 6 % MultilayerBUD.LABEL
					prop_default = 'MultilayerBUD label';
				case 7 % MultilayerBUD.NOTES
					prop_default = 'MultilayerBUD notes';
				case 9 % MultilayerBUD.GRAPH_TYPE
					prop_default = 6;
				case 30 % MultilayerBUD.COMPATIBLE_MEASURES
					prop_default = { 'Degree'  'DegreeAv'  'DegreeOverlap'  'DegreeOverlapAv'  'Distance'  'EdgeOverlap'  'GlobalEfficiency'  'GlobalEfficiencyAv' };
				case 38 % MultilayerBUD.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@MultilayerWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerBUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerBUD, POINTER) returns the conditioned default value of POINTER of MultilayerBUD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(MultilayerBUD, POINTER) returns the conditioned default value of POINTER of MultilayerBUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			prop_default = MultilayerBUD.conditioning(prop, MultilayerBUD.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = G.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = G.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of G.
			%  CHECK = Element.CHECKPROP(MultilayerBUD, PROP, VALUE) checks VALUE format for PROP of MultilayerBUD.
			%  CHECK = G.CHECKPROP(MultilayerBUD, PROP, VALUE) checks VALUE format for PROP of MultilayerBUD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultilayerBUD:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: BRAPH2:MultilayerBUD:WrongInput
			%  Element.CHECKPROP(MultilayerBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUD.
			%   Error id: BRAPH2:MultilayerBUD:WrongInput
			%  G.CHECKPROP(MultilayerBUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerBUD.
			%   Error id: BRAPH2:MultilayerBUD:WrongInput]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('MultilayerBUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerBUD.getPropProp(pointer);
			
			switch prop
				case 41 % MultilayerBUD.DENSITIES
					check = Format.checkFormat(12, value, MultilayerBUD.getPropSettings(prop));
				case 4 % MultilayerBUD.TEMPLATE
					check = Format.checkFormat(8, value, MultilayerBUD.getPropSettings(prop));
				otherwise
					if prop <= 40
						check = checkProp@MultilayerWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerBUD:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerBUD.getPropTag(prop) ' (' MultilayerBUD.getFormatTag(MultilayerBUD.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 10 % MultilayerBUD.CONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					
				case 11 % MultilayerBUD.DIRECTIONALITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					
				case 12 % MultilayerBUD.SELFCONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					value(1:layernumber+1:end) = 1;
					
				case 13 % MultilayerBUD.NEGATIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value =  ones(layernumber);
					
				case 24 % MultilayerBUD.A
					rng_settings_ = rng(); rng(g.getPropSeed(24), 'twister')
					
					A_WU = calculateValue@MultilayerWU(g, prop);
					densities = g.get('DENSITIES');
					L = length(A_WU); % number of layers of MultilayerWU
					A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)
					if L > 0 && ~isempty(cell2mat(A_WU))
					    for i = 1:1:length(A)
					        if mod(i, L) == 0
					            i_layer = L;
					            i_density = densities(fix(i/L));
					        else
					            i_layer = mod(i, L);
					            i_density = densities(fix(i/L)+1);
					        end
					        M = symmetrize(A_WU{i_layer, i_layer}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					        M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
					        M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					        M = binarize(M, 'density', i_density); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					        A(i, i) = {M};
					        for j = i+1:1:length(A)
					            if mod(j, L) == 0
					                j_layer = L;
					                j_density = densities(fix(j/L));
					            else
					                j_layer = mod(j, L);
					                j_density = densities(fix(j/L)+1);
					            end
					            if i_density == j_density
					                M = semipositivize(A_WU{i_layer, j_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(i, j) = {M};
					                M = semipositivize(A_WU{j_layer, i_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					                M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					                A(j, i) = {M};
					            else
					                A(i, j) = {zeros(size(A_WU{i_layer, i_layer}, 1), size(A_WU{j_layer, j_layer}, 2))};
					                A(j, i) = {zeros(size(A_WU{j_layer, j_layer}, 2), size(A_WU{i_layer, i_layer}, 1))};
					            end
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case 28 % MultilayerBUD.PARTITIONS
					rng_settings_ = rng(); rng(g.getPropSeed(28), 'twister')
					
					l = g.get('LAYERNUMBER');
					densities = g.get('DENSITIES');
					value = ones(1, length(densities)) * l / length(densities);
					
					rng(rng_settings_)
					
				case 17 % MultilayerBUD.ALAYERLABELS
					alayerlabels = g.get('LAYERLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
					    densities = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					
					    if length(alayerlabels) == length(g.get('B'))
					        blayerlabels = alayerlabels;
					    else % includes isempty(layerlabels)
					        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
					    end
					    
					    alayerlabels = {};
					    for i = 1:1:length(densities)
					        for j = 1:1:length(blayerlabels)
					            alayerlabels = [alayerlabels, ['L' blayerlabels{j} '|' densities{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case 19 % MultilayerBUD.APARTITIONLABELS
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('DENSITIES')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case 40 % MultilayerBUD.RANDOMIZATION
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    random_g = GraphBU();
					    random_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    random_A = random_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				otherwise
					if prop <= 40
						value = calculateValue@MultilayerWU(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(g, prop, varargin)
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
				case 41 % MultilayerBUD.DENSITIES
					pr = PanelPropRVectorSmart('EL', g, 'PROP', 41, 'MAX', 100, 'MIN', 0, varargin{:});
					
				case 24 % MultilayerBUD.A
					pr = PanelPropCell('EL', g, 'PROP', 24, ...
					    'TABLE_HEIGHT', 480, ...
					    'XYSLIDERLOCK', true, ... 
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', true, ...
					    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					    'YSLIDERWIDTH', 60, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@MultilayerWU(g, prop, varargin{:});
					
			end
		end
	end
end
