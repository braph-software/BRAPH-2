classdef EdgeNumberDistance < Distance
	% EdgeNumberDistance is the graph edge number distance.
	% It is a subclass of <a href="matlab:help Distance">Distance</a>.
	%
	% The edge distance number of a graph is the number of edges in the shortest
	% weighted path between two nodes within a layer.
	%
	% The list of EdgeNumberDistance properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the edge number distance.
	%
	% EdgeNumberDistance methods (constructor):
	% EdgeNumberDistance - constructor
	%
	% EdgeNumberDistance methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in edge number distance/error.
	%  existsProp - checks whether property exists in edge number distance/error.
	%  getPropNumber - returns the property number of edge number distance.
	%  getProps - returns the property list of edge number distance.
	%  getDescription - returns the description of the edge number distance.
	%  getName - returns the name of the edge number distance.
	%  getClass - returns the class of the edge number distance.
	%  getCompatibleGraphNumber - returns the number (12) of Distance compatible graphs.
	%  getCompatibleGraphList - returns the list of Distance compatible graphs.
	%  getMeasureParametricity - returns 2 (Non-parametric).
	%  getMeasureScope - returns 2 (Unilayer).
	%  getMeasureShape - returns 3 (Binodal).
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
	% EdgeNumberDistance methods:
	%  getEdgeNumberDistance - calculates the edge distance number of a graph.
	%  getBinaryCalculation - calculates the distance value of a binary adjacency matrix.
	%  getWeightedCalculation - calculates the distance value of a weighted adjacency matrix.
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
	% EdgeNumberDistance methods (operators):
	%  isequal - determines whether two EdgeNumberDistance are equal (values, locked)
	%
	% EdgeNumberDistance methods (display):
	%  tostring - string with information about the EdgeNumberDistance
	%  disp - displays information about the EdgeNumberDistance
	%  tree - displays the element of EdgeNumberDistance
	%
	% EdgeNumberDistance method (element list):
	%  getElementList - returns a list with all subelements of EdgeNumberDistance
	%
	% EdgeNumberDistance method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the EdgeNumberDistance
	%
	% EdgeNumberDistance method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the EdgeNumberDistance
	%
	% EdgeNumberDistance methods (copy):
	%  copy - copies the EdgeNumberDistance
	%  deepclone - deep-clones the EdgeNumberDistance
	%  clone - clones the EdgeNumberDistance
	%
	% EdgeNumberDistance methods (inspection, Static):
	%  getClass - returns EdgeNumberDistance
	%  getName - returns the name of EdgeNumberDistance
	%  getDescription - returns the description of EdgeNumberDistance
	%  getProps - returns the property list of EdgeNumberDistance
	%  getPropNumber - returns the property number of EdgeNumberDistance
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
	% EdgeNumberDistance methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EdgeNumberDistance methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% EdgeNumberDistance methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% EdgeNumberDistance methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% EdgeNumberDistance properties (Constant).
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
			%GETCLASS returns the class of the edge number distance.
			%
			% CLASS = EdgeNumberDistance.GETCLASS() returns the class 'EdgeNumberDistance'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the edge number distance M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EdgeNumberDistance') returns 'EdgeNumberDistance'.
			%
			% See also getName, getDescription.
			
			m_class = 'EdgeNumberDistance';
		end
		function m_name = getName()
			%GETNAME returns the name of the edge number distance.
			%
			% NAME = EdgeNumberDistance.GETNAME() returns the name of the 'edge number distance'.
			%  Edge Number Distance.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the edge number distance M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('EdgeNumberDistance') returns the name of 'EdgeNumberDistance'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Edge Number Distance';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the edge number distance.
			%
			% STR = EdgeNumberDistance.GETDESCRIPTION() returns the description of the 'edge number distance'.
			%  which is:
			%
			%  The edge distance number of a graph is the number of edges in the shortest
			%  weighted path between two nodes within a layer.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the edge number distance M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('EdgeNumberDistance') returns the description of 'EdgeNumberDistance'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The edge distance number of a graph is the number of edges in the shortest' ...
				'weighted path between two nodes within a layer.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of edge number distance.
			%
			% PROPS = EdgeNumberDistance.GETPROPS() returns the property list of edge number distance.
			%
			% PROPS = EdgeNumberDistance.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the edge number distance M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EdgeNumberDistance'[, CATEGORY]) returns the property list of 'EdgeNumberDistance'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Distance.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Distance.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Distance.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						Distance.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Distance.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Distance.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Distance.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of edge number distance.
			%
			% N = EdgeNumberDistance.GETPROPNUMBER() returns the property number of edge number distance.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the edge number distance M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EdgeNumberDistance') returns the property number of 'EdgeNumberDistance'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in edge number distance/error.
			%
			% CHECK = EdgeNumberDistance.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EdgeNumberDistance, PROP) checks whether PROP exists for EdgeNumberDistance.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  Element.EXISTSPROP(EdgeNumberDistance, PROP) throws error if PROP does NOT exist for EdgeNumberDistance.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					EdgeNumberDistance.existsProp(prop), ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EdgeNumberDistance.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in edge number distance/error.
			%
			% CHECK = EdgeNumberDistance.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EdgeNumberDistance, TAG) checks whether TAG exists for EdgeNumberDistance.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  Element.EXISTSTAG(EdgeNumberDistance, TAG) throws error if TAG does NOT exist for EdgeNumberDistance.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				edgenumberdistance_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, edgenumberdistance_tag_list));
			else
				assert( ...
					EdgeNumberDistance.existsTag(tag), ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for EdgeNumberDistance'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EdgeNumberDistance, POINTER) returns property number of POINTER of EdgeNumberDistance.
			%  PROPERTY = M.GETPROPPROP(EdgeNumberDistance, POINTER) returns property number of POINTER of EdgeNumberDistance.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				edgenumberdistance_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				EdgeNumberDistance.existsTag(tag);
				
				prop = find(strcmpi(tag, edgenumberdistance_tag_list));
			else % numeric
				prop = pointer;
				EdgeNumberDistance.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(EdgeNumberDistance, POINTER) returns tag of POINTER of EdgeNumberDistance.
			%  TAG = M.GETPROPTAG(EdgeNumberDistance, POINTER) returns tag of POINTER of EdgeNumberDistance.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				EdgeNumberDistance.existsTag(tag);
			else % numeric
				prop = pointer;
				EdgeNumberDistance.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@Distance(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(EdgeNumberDistance, POINTER) returns category of POINTER of EdgeNumberDistance.
			%  CATEGORY = M.GETPROPCATEGORY(EdgeNumberDistance, POINTER) returns category of POINTER of EdgeNumberDistance.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Distance(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(EdgeNumberDistance, POINTER) returns format of POINTER of EdgeNumberDistance.
			%  FORMAT = M.GETPROPFORMAT(EdgeNumberDistance, POINTER) returns format of POINTER of EdgeNumberDistance.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Distance(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EdgeNumberDistance, POINTER) returns description of POINTER of EdgeNumberDistance.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EdgeNumberDistance, POINTER) returns description of POINTER of EdgeNumberDistance.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				case EdgeNumberDistance.M
					prop_description = 'M (result, cell) is the edge number distance.';
				otherwise
					prop_description = getPropDescription@Distance(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(EdgeNumberDistance, POINTER) returns settings of POINTER of EdgeNumberDistance.
			%  SETTINGS = M.GETPROPSETTINGS(EdgeNumberDistance, POINTER) returns settings of POINTER of EdgeNumberDistance.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@Distance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EdgeNumberDistance.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeNumberDistance.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EdgeNumberDistance, POINTER) returns the default value of POINTER of EdgeNumberDistance.
			%  DEFAULT = M.GETPROPDEFAULT(EdgeNumberDistance, POINTER) returns the default value of POINTER of EdgeNumberDistance.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@Distance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EdgeNumberDistance.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeNumberDistance.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EdgeNumberDistance, POINTER) returns the conditioned default value of POINTER of EdgeNumberDistance.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EdgeNumberDistance, POINTER) returns the conditioned default value of POINTER of EdgeNumberDistance.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			prop_default = EdgeNumberDistance.conditioning(prop, EdgeNumberDistance.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EdgeNumberDistance, PROP, VALUE) checks VALUE format for PROP of EdgeNumberDistance.
			%  CHECK = M.CHECKPROP(EdgeNumberDistance, PROP, VALUE) checks VALUE format for PROP of EdgeNumberDistance.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  Element.CHECKPROP(EdgeNumberDistance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeNumberDistance.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			%  M.CHECKPROP(EdgeNumberDistance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeNumberDistance.
			%   Error id: [BRAPH2:EdgeNumberDistance:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@Distance(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EdgeNumberDistance.getPropTag(prop) ' (' EdgeNumberDistance.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 3 (Binodal).
			%
			% 3 = EdgeNumberDistance.GETMEASURESHAPE() returns the measures graph shape (Binodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.BINODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = EdgeNumberDistance.GETMEASURESCOPE() returns the measures layer scope (Binodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = EdgeNumberDistance.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of EdgeNumberDistance compatible graphs.
			%
			% LIST = EdgeNumberDistance.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWD">GraphWD</a>
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWD', ...
				'GraphWU', ...
				'MultiplexWD', ...
				'MultiplexWU', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (4) of EdgeNumberDistance compatible graphs.
			%
			% 4 = EdgeNumberDistance.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('EdgeNumberDistance');
		end
	end
	methods % constructor
		function m = EdgeNumberDistance(varargin)
			% EdgeNumberDistance() creates a edge number distance.
			%
			% EdgeNumberDistance(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EdgeNumberDistance(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of EdgeNumberDistance properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the edge number distance.
			%
			% See also Category, Format, set, check.
			
			m = m@Distance(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = EdgeNumberDistance.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Distance.getPropNumber()
						value = conditioning@Distance(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case EdgeNumberDistance.M
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					
					edge_number_distance = cell(g.layernumber(), 1);
					
					for li = 1:1:g.layernumber()
					    Aii = A{li, li};
					    edge_number_distance(li) = {m.getEdgeNumberDistance(Aii)};
					end
					
					value = edge_number_distance;
					
				otherwise
					value = calculateValue@Distance(m, prop);
					
			end
		end
	end
	methods % methods
		function edge_number_distance = getEdgeNumberDistance(m, A)
		    %GETEDGENUMBERDISTANCE calculates the edge distance number of a graph.
		
		    ind = A~=0;
		    A(ind) = A(ind).^-1;
		    n = length(A);
		    D = inf(n);
		    D(1:n+1:end) = 0; % distance matrix
		    B = zeros(n); % number of edges matrix
		
		    for u = 1:n
		        S = true(1, n); % distance permanence (true is temporary)
		        L1 = A;
		        V = u;
		
		        while 1
		            S(V) = 0; % distance u->V is now permanent
		            L1(:, V) = 0; % no in-edges as already shortest
		
		            for v = V
		                T = find(L1(v, :)); % neighbours of shortest nodes
		                [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
		                D(u, T) = d; % smallest of old/new path lengths
		                ind = T(wi==2); % indices of lengthened paths
		                B(u, ind) = B(u, v) + 1; % increment no. of edges in lengthened paths
		            end
		
		            minD = min(D(u, S));
		            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
		                break % isinf: some nodes cannot be reached
		            end
		
		            V = find(D(u,:)==minD);
		        end
		    end
		    edge_number_distance = B;
		end
	end
end
