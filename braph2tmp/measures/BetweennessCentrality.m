classdef BetweennessCentrality < Measure
	% BetweennessCentrality is the graph betweenness centrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The betweenness centrality of a graph is the fraction of all shortest paths in the 
	% graph that pass through a given node. Nodes with high values of betweenness
	% centrality participate in a large number of shortest paths.
	%
	% The list of BetweennessCentrality properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the betweenness centrality.
	%
	% BetweennessCentrality methods (constructor):
	% BetweennessCentrality - constructor
	%
	% BetweennessCentrality methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in betweenness centrality/error.
	%  existsProp - checks whether property exists in betweenness centrality/error.
	%  getPropNumber - returns the property number of betweenness centrality.
	%  getProps - returns the property list of betweenness centrality.
	%  getDescription - returns the description of the betweenness centrality.
	%  getName - returns the name of the betweenness centrality.
	%  getClass - returns the class of the betweenness centrality.
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
	% BetweennessCentrality methods:
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
	% BetweennessCentrality methods (operators):
	%  isequal - determines whether two BetweennessCentrality are equal (values, locked)
	%
	% BetweennessCentrality methods (display):
	%  tostring - string with information about the BetweennessCentrality
	%  disp - displays information about the BetweennessCentrality
	%  tree - displays the element of BetweennessCentrality
	%
	% BetweennessCentrality method (element list):
	%  getElementList - returns a list with all subelements of BetweennessCentrality
	%
	% BetweennessCentrality method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the BetweennessCentrality
	%
	% BetweennessCentrality method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the BetweennessCentrality
	%
	% BetweennessCentrality methods (copy):
	%  copy - copies the BetweennessCentrality
	%  deepclone - deep-clones the BetweennessCentrality
	%  clone - clones the BetweennessCentrality
	%
	% BetweennessCentrality methods (inspection, Static):
	%  getClass - returns BetweennessCentrality
	%  getName - returns the name of BetweennessCentrality
	%  getDescription - returns the description of BetweennessCentrality
	%  getProps - returns the property list of BetweennessCentrality
	%  getPropNumber - returns the property number of BetweennessCentrality
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
	% BetweennessCentrality methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BetweennessCentrality methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% BetweennessCentrality methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% BetweennessCentrality methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% BetweennessCentrality properties (Constant).
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
			%GETCLASS returns the class of the betweenness centrality.
			%
			% CLASS = BetweennessCentrality.GETCLASS() returns the class 'BetweennessCentrality'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the betweenness centrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('BetweennessCentrality') returns 'BetweennessCentrality'.
			%
			% See also getName, getDescription.
			
			m_class = 'BetweennessCentrality';
		end
		function m_name = getName()
			%GETNAME returns the name of the betweenness centrality.
			%
			% NAME = BetweennessCentrality.GETNAME() returns the name of the 'betweenness centrality'.
			%  Betweenness Centrality.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the betweenness centrality M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('BetweennessCentrality') returns the name of 'BetweennessCentrality'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Betweenness Centrality';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the betweenness centrality.
			%
			% STR = BetweennessCentrality.GETDESCRIPTION() returns the description of the 'betweenness centrality'.
			%  which is:
			%
			%  The betweenness centrality of a graph is the fraction of all shortest paths in the 
			%  graph that pass through a given node. Nodes with high values of betweenness
			%  centrality participate in a large number of shortest paths.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the betweenness centrality M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('BetweennessCentrality') returns the description of 'BetweennessCentrality'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The betweenness centrality of a graph is the fraction of all shortest paths in the ' ...
				'graph that pass through a given node. Nodes with high values of betweenness' ...
				'centrality participate in a large number of shortest paths.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of betweenness centrality.
			%
			% PROPS = BetweennessCentrality.GETPROPS() returns the property list of betweenness centrality.
			%
			% PROPS = BetweennessCentrality.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the betweenness centrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('BetweennessCentrality'[, CATEGORY]) returns the property list of 'BetweennessCentrality'.
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
						];
				case Category.DATA
					prop_list = [
						Measure.getProps(Category.DATA)
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
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of betweenness centrality.
			%
			% N = BetweennessCentrality.GETPROPNUMBER() returns the property number of betweenness centrality.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the betweenness centrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('BetweennessCentrality') returns the property number of 'BetweennessCentrality'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in betweenness centrality/error.
			%
			% CHECK = BetweennessCentrality.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(BetweennessCentrality, PROP) checks whether PROP exists for BetweennessCentrality.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSPROP(BetweennessCentrality, PROP) throws error if PROP does NOT exist for BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					BetweennessCentrality.existsProp(prop), ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BetweennessCentrality.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in betweenness centrality/error.
			%
			% CHECK = BetweennessCentrality.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(BetweennessCentrality, TAG) checks whether TAG exists for BetweennessCentrality.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.EXISTSTAG(BetweennessCentrality, TAG) throws error if TAG does NOT exist for BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				betweennesscentrality_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, betweennesscentrality_tag_list));
			else
				assert( ...
					BetweennessCentrality.existsTag(tag), ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for BetweennessCentrality'] ...
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
			%  PROPERTY = Element.GETPROPPROP(BetweennessCentrality, POINTER) returns property number of POINTER of BetweennessCentrality.
			%  PROPERTY = M.GETPROPPROP(BetweennessCentrality, POINTER) returns property number of POINTER of BetweennessCentrality.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				betweennesscentrality_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				BetweennessCentrality.existsTag(tag);
				
				prop = find(strcmpi(tag, betweennesscentrality_tag_list));
			else % numeric
				prop = pointer;
				BetweennessCentrality.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(BetweennessCentrality, POINTER) returns tag of POINTER of BetweennessCentrality.
			%  TAG = M.GETPROPTAG(BetweennessCentrality, POINTER) returns tag of POINTER of BetweennessCentrality.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				BetweennessCentrality.existsTag(tag);
			else % numeric
				prop = pointer;
				BetweennessCentrality.existsProp(prop);
				
				switch prop
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
			%  CATEGORY = Element.GETPROPCATEGORY(BetweennessCentrality, POINTER) returns category of POINTER of BetweennessCentrality.
			%  CATEGORY = M.GETPROPCATEGORY(BetweennessCentrality, POINTER) returns category of POINTER of BetweennessCentrality.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(BetweennessCentrality, POINTER) returns format of POINTER of BetweennessCentrality.
			%  FORMAT = M.GETPROPFORMAT(BetweennessCentrality, POINTER) returns format of POINTER of BetweennessCentrality.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BetweennessCentrality, POINTER) returns description of POINTER of BetweennessCentrality.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(BetweennessCentrality, POINTER) returns description of POINTER of BetweennessCentrality.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				case BetweennessCentrality.M
					prop_description = 'M (result, cell) is the betweenness centrality.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(BetweennessCentrality, POINTER) returns settings of POINTER of BetweennessCentrality.
			%  SETTINGS = M.GETPROPSETTINGS(BetweennessCentrality, POINTER) returns settings of POINTER of BetweennessCentrality.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(BetweennessCentrality, POINTER) returns the default value of POINTER of BetweennessCentrality.
			%  DEFAULT = M.GETPROPDEFAULT(BetweennessCentrality, POINTER) returns the default value of POINTER of BetweennessCentrality.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BetweennessCentrality.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BetweennessCentrality, POINTER) returns the conditioned default value of POINTER of BetweennessCentrality.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(BetweennessCentrality, POINTER) returns the conditioned default value of POINTER of BetweennessCentrality.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			prop_default = BetweennessCentrality.conditioning(prop, BetweennessCentrality.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(BetweennessCentrality, PROP, VALUE) checks VALUE format for PROP of BetweennessCentrality.
			%  CHECK = M.CHECKPROP(BetweennessCentrality, PROP, VALUE) checks VALUE format for PROP of BetweennessCentrality.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  Element.CHECKPROP(BetweennessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			%  M.CHECKPROP(BetweennessCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BetweennessCentrality.
			%   Error id: [BRAPH2:BetweennessCentrality:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = BetweennessCentrality.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@Measure(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BetweennessCentrality:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BetweennessCentrality.getPropTag(prop) ' (' BetweennessCentrality.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = BetweennessCentrality.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = BetweennessCentrality.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = BetweennessCentrality.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of BetweennessCentrality compatible graphs.
			%
			% LIST = BetweennessCentrality.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help GraphWD">GraphWD</a>
			%  <a href="matlab:help GraphBU">GraphBU</a>
			%  <a href="matlab:help MultigraphBUD">MultigraphBUD</a>
			%  <a href="matlab:help MultigraphBUT">MultigraphBUT</a>
			%  <a href="matlab:help GraphBD">GraphBD</a>
			%  <a href="matlab:help MultiplexBD">MultiplexBD</a>
			%  <a href="matlab:help MultiplexBU">MultiplexBU</a>
			%  <a href="matlab:help MultiplexBUD">MultiplexBUD</a>
			%  <a href="matlab:help MultiplexBUT">MultiplexBUT</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWU', ...
				'GraphWD', ...
				'GraphBU', ...
				'MultigraphBUD', ...
				'MultigraphBUT', ...
				'GraphBD', ...
				'MultiplexBD', ...
				'MultiplexBU', ...
				'MultiplexBUD', ...
				'MultiplexBUT', ...
				'MultiplexWD', ...
				'MultiplexWU', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (12) of BetweennessCentrality compatible graphs.
			%
			% 12 = BetweennessCentrality.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('BetweennessCentrality');
		end
	end
	methods % constructor
		function m = BetweennessCentrality(varargin)
			% BetweennessCentrality() creates a betweenness centrality.
			%
			% BetweennessCentrality(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BetweennessCentrality(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BetweennessCentrality properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the betweenness centrality.
			%
			% See also Category, Format, set, check.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = BetweennessCentrality.getPropProp(pointer);
			
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
				case BetweennessCentrality.M
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					N = g.nodenumber(); 
					
					betweenness_centrality = cell(g.layernumber(), 1);
					connectivity_layer =  g.getConnectivityType(g.layernumber());
					
					for li = 1:1:g.layernumber()
					    Aii = A{li, li};
					
					    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					        betweenness_centrality_layer = m.getWeightedCalculation(Aii)/((N(li)-1)*(N(li)-2));  % Normalized betweenness centrality
					        betweenness_centrality(li) = {betweenness_centrality_layer};
					    else  % binary graphs
					        betweenness_centrality_layer = m.getBinaryCalculation(Aii)/((N(li)-1)*(N(li)-2));  % Normalized betweenness centrality
					        betweenness_centrality(li) = {betweenness_centrality_layer};
					    end
					end
					
					value = betweenness_centrality;
					
				otherwise
					value = calculateValue@Measure(m, prop);
					
			end
		end
	end
	methods % methods
		function weighted_betweenness_centrality = getWeightedCalculation(m, A)
		    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
		    %
		    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the
		    %  distance of a weighted adjacency matrix A.
		
		    N = size(A, 2);  % number of nodes
		    E = find(A);
		    A(E) = 1./A(E);  % invert weights
		    weighted_betweenness_centrality = zeros(N, 1);  % init vertex betweenness
		    
		    % Compute the distances and number of
		    % shortest paths between all pairs of vertices
		    for u = 1:N  % One search for each source vertex u
		        D = inf(1, N);
		        D(u) = 0;  % distance from u
		        NP = zeros(1, N);
		        NP(u) = 1;  % number of paths from u
		        S = true(1, N);  % distance permanence S (true is temporary)
		        P = false(N);  % predecessors P
		        Q = zeros(1, N);  % order of non-increasing distance
		        q = N;
		        G = A;  % graph G
		        V = u;  % set of nodes (V) of graph G
		        
		        % Forward pass:
		        % Compute the shortest paths
		        % from the source u to all the other nodes in V
		        while 1
		            S(V) = 0;  % distance u->V is now permanent
		            G(:,V) = 0;  % no in-edges as already shortest
		            for v = V
		                Q(q) = v;
		                q = q-1;
		                neighbours = find(G(v,:));  % neighbours of v
		                for neighbour = neighbours
		                    Duw = D(v) + G(v, neighbour);  % Duw path length to be tested
		                    if Duw<D(neighbour)  % if new u->w shorter than old
		                        D(neighbour) = Duw;
		                        NP(neighbour) = NP(v);  % NP(u->w) = NP of new path
		                        P(neighbour,:) = 0;
		                        P(neighbour, v) = 1;  % v is the only predecessor
		                    elseif Duw==D(neighbour)  % if new u->w equal to old
		                        NP(neighbour) = NP(neighbour)+NP(v);  % NP(u->w) sum of old and new
		                        P(neighbour, v) = 1;  % v is also a predecessor
		                    end
		                end
		            end
		            minD = min(D(S));  % shortest distance
		            if isempty(minD), break  % all nodes reached, or
		            elseif isinf(minD)  % some cannot be reached:
		                Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
		            end
		            V = find(D==minD);
		        end
		        
		        % Compute dependencies (DP)
		        DP = zeros(N, 1);
		        for n = Q(1:N-1)
		            weighted_betweenness_centrality(n) = weighted_betweenness_centrality(n)+DP(n);  % update betweenness
		            for v = find(P(n,:))
		                DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);  % dependency
		            end
		        end
		    end
		end
		function binary_betweenness_centrality = getBinaryCalculation(m, A)
		    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
		    %
		    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
		    %  distance of a binary adjacency matrix A.
		    
		    N = size(A, 1);  % number of nodes
		    I = eye(N)~=0;  % logical identity matrix
		    d = 1;  % start path length d
		    NPd = A;  % number of paths of length |d|
		    NSPd = NPd;  % number of shortest paths of length |d|
		    NSP = NSPd;  % number of shortest paths of any length
		    NSP(I) = 1;
		    L = NSPd;  % length of shortest paths
		    L(I) = 1;
		    
		    % Forward pass: Compute the distance (L) and the number of
		    % shortest paths (NSP) between all pairs
		    % Compute Path Count:
		    while find(NSPd, 1)
		        d = d + 1;
		        NPd = NPd*A;  % Index value corresponds to number of paths found of length d+1
		        NSPd = NPd.*(L==0);
		        NSP = NSP + NSPd;  % Add new found shortest paths
		        L = L+d.*(NSPd~=0);  % Add new found shortest paths' distance
		    end
		    L(~L) = inf; L(I) = 0;  % Lenght for disconnected vertices is inf
		    NSP(~NSP) = 1;  % NSP for disconnected vertices is 1
		    
		    % Backward pass: compute the dependencies (DP)
		    DP = zeros(N);  % vertex on vertex dependency
		    diam = d-1;  % graph diameter
		    for d = diam:-1:2  % L == path_length_d is zero for path_length_d = diam
		        DPd1 = (((L==d).*(1+DP)./NSP)*(A.')).*((L==(d-1)).*NSP);
		        DP = DP + DPd1;  %DPd1: dependencies on vertices |d-1| from source
		    end
		    binary_betweenness_centrality = sum(DP, 1);  % compute betweenness
		    binary_betweenness_centrality = binary_betweenness_centrality';
		end
	end
end
