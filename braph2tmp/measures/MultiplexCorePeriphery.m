classdef MultiplexCorePeriphery < Multirichness
	% MultiplexCorePeriphery is the graph multiplex core-periphery.
	% It is a subclass of <a href="matlab:help Multirichness">Multirichness</a>.
	%
	% The multiplex core-periphery of a node is the value of the rank corresponding 
	% to the maximum multirichness nodes. It returns 1 for a node belonging to the 
	% core and zero otherwise. The relevance of each layer is controlled by the 
	% multirichness coefficients that are between 0 and 1, and add up to one; 
	% the default coefficients are (1/layernumber).
	%
	% The list of MultiplexCorePeriphery properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multiplex core periphery.
	%  <strong>6</strong> <strong>multirichness_coefficients</strong> 	MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR)
	%
	% MultiplexCorePeriphery methods (constructor):
	% MultiplexCorePeriphery - constructor
	%
	% MultiplexCorePeriphery methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in multiplex core-periphery/error.
	%  existsProp - checks whether property exists in multiplex core-periphery/error.
	%  getPropNumber - returns the property number of multiplex core-periphery.
	%  getProps - returns the property list of multiplex core-periphery.
	%  getDescription - returns the description of the multiplex core-periphery.
	%  getName - returns the name of the multiplex core-periphery.
	%  getClass - returns the class of the multiplex core-periphery.
	%  getCompatibleGraphNumber - returns the number (6) of Multirichness compatible graphs.
	%  getCompatibleGraphList - returns the list of Multirichness compatible graphs.
	%  getMeasureParametricity - returns 2 (Non-parametric).
	%  getMeasureScope - returns 1 (Superglobal).
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
	% MultiplexCorePeriphery methods:
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
	% MultiplexCorePeriphery methods (operators):
	%  isequal - determines whether two MultiplexCorePeriphery are equal (values, locked)
	%
	% MultiplexCorePeriphery methods (display):
	%  tostring - string with information about the MultiplexCorePeriphery
	%  disp - displays information about the MultiplexCorePeriphery
	%  tree - displays the element of MultiplexCorePeriphery
	%
	% MultiplexCorePeriphery method (element list):
	%  getElementList - returns a list with all subelements of MultiplexCorePeriphery
	%
	% MultiplexCorePeriphery method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the MultiplexCorePeriphery
	%
	% MultiplexCorePeriphery method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the MultiplexCorePeriphery
	%
	% MultiplexCorePeriphery methods (copy):
	%  copy - copies the MultiplexCorePeriphery
	%  deepclone - deep-clones the MultiplexCorePeriphery
	%  clone - clones the MultiplexCorePeriphery
	%
	% MultiplexCorePeriphery methods (inspection, Static):
	%  getClass - returns MultiplexCorePeriphery
	%  getName - returns the name of MultiplexCorePeriphery
	%  getDescription - returns the description of MultiplexCorePeriphery
	%  getProps - returns the property list of MultiplexCorePeriphery
	%  getPropNumber - returns the property number of MultiplexCorePeriphery
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
	% MultiplexCorePeriphery methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexCorePeriphery methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% MultiplexCorePeriphery methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% MultiplexCorePeriphery methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% MultiplexCorePeriphery properties (Constant).
	%  MULTIRICHNESS_COEFFICIENTS - 6
	%  MULTIRICHNESS_COEFFICIENTS_TAG - 'multirichness_coefficients'
	%  MULTIRICHNESS_COEFFICIENTS_CATEGORY - 'p'
	%  MULTIRICHNESS_COEFFICIENTS_FORMAT - 'nr'
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
			%GETCLASS returns the class of the multiplex core-periphery.
			%
			% CLASS = MultiplexCorePeriphery.GETCLASS() returns the class 'MultiplexCorePeriphery'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex core-periphery M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexCorePeriphery') returns 'MultiplexCorePeriphery'.
			%
			% See also getName, getDescription.
			
			m_class = 'MultiplexCorePeriphery';
		end
		function m_name = getName()
			%GETNAME returns the name of the multiplex core-periphery.
			%
			% NAME = MultiplexCorePeriphery.GETNAME() returns the name of the 'multiplex core-periphery'.
			%  Multiplex Core-Periphery.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the multiplex core-periphery M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('MultiplexCorePeriphery') returns the name of 'MultiplexCorePeriphery'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Multiplex Core-Periphery';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the multiplex core-periphery.
			%
			% STR = MultiplexCorePeriphery.GETDESCRIPTION() returns the description of the 'multiplex core-periphery'.
			%  which is:
			%
			%  The multiplex core-periphery of a node is the value of the rank corresponding 
			%  to the maximum multirichness nodes. It returns 1 for a node belonging to the 
			%  core and zero otherwise. The relevance of each layer is controlled by the 
			%  multirichness coefficients that are between 0 and 1, and add up to one; 
			%  the default coefficients are (1/layernumber).
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the multiplex core-periphery M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('MultiplexCorePeriphery') returns the description of 'MultiplexCorePeriphery'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The multiplex core-periphery of a node is the value of the rank corresponding ' ...
				'to the maximum multirichness nodes. It returns 1 for a node belonging to the ' ...
				'core and zero otherwise. The relevance of each layer is controlled by the ' ...
				'multirichness coefficients that are between 0 and 1, and add up to one; ' ...
				'the default coefficients are (1/layernumber).' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex core-periphery.
			%
			% PROPS = MultiplexCorePeriphery.GETPROPS() returns the property list of multiplex core-periphery.
			%
			% PROPS = MultiplexCorePeriphery.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex core-periphery M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexCorePeriphery'[, CATEGORY]) returns the property list of 'MultiplexCorePeriphery'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Multirichness.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Multirichness.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Multirichness.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						Multirichness.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Multirichness.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Multirichness.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Multirichness.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of multiplex core-periphery.
			%
			% N = MultiplexCorePeriphery.GETPROPNUMBER() returns the property number of multiplex core-periphery.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the multiplex core-periphery M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexCorePeriphery') returns the property number of 'MultiplexCorePeriphery'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex core-periphery/error.
			%
			% CHECK = MultiplexCorePeriphery.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexCorePeriphery, PROP) checks whether PROP exists for MultiplexCorePeriphery.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  Element.EXISTSPROP(MultiplexCorePeriphery, PROP) throws error if PROP does NOT exist for MultiplexCorePeriphery.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					MultiplexCorePeriphery.existsProp(prop), ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexCorePeriphery.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex core-periphery/error.
			%
			% CHECK = MultiplexCorePeriphery.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexCorePeriphery, TAG) checks whether TAG exists for MultiplexCorePeriphery.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  Element.EXISTSTAG(MultiplexCorePeriphery, TAG) throws error if TAG does NOT exist for MultiplexCorePeriphery.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				multiplexcoreperiphery_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'multirichness_coefficients' };
				
				check = any(strcmpi(tag, multiplexcoreperiphery_tag_list));
			else
				assert( ...
					MultiplexCorePeriphery.existsTag(tag), ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for MultiplexCorePeriphery'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexCorePeriphery, POINTER) returns property number of POINTER of MultiplexCorePeriphery.
			%  PROPERTY = M.GETPROPPROP(MultiplexCorePeriphery, POINTER) returns property number of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				multiplexcoreperiphery_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'multirichness_coefficients' };
				
				tag = pointer;
				MultiplexCorePeriphery.existsTag(tag);
				
				prop = find(strcmpi(tag, multiplexcoreperiphery_tag_list));
			else % numeric
				prop = pointer;
				MultiplexCorePeriphery.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(MultiplexCorePeriphery, POINTER) returns tag of POINTER of MultiplexCorePeriphery.
			%  TAG = M.GETPROPTAG(MultiplexCorePeriphery, POINTER) returns tag of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				MultiplexCorePeriphery.existsTag(tag);
			else % numeric
				prop = pointer;
				MultiplexCorePeriphery.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@Multirichness(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexCorePeriphery, POINTER) returns category of POINTER of MultiplexCorePeriphery.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexCorePeriphery, POINTER) returns category of POINTER of MultiplexCorePeriphery.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Multirichness(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexCorePeriphery, POINTER) returns format of POINTER of MultiplexCorePeriphery.
			%  FORMAT = M.GETPROPFORMAT(MultiplexCorePeriphery, POINTER) returns format of POINTER of MultiplexCorePeriphery.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Multirichness(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexCorePeriphery, POINTER) returns description of POINTER of MultiplexCorePeriphery.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexCorePeriphery, POINTER) returns description of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				case MultiplexCorePeriphery.M
					prop_description = 'M (result, cell) is the multiplex core periphery.';
				otherwise
					prop_description = getPropDescription@Multirichness(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexCorePeriphery, POINTER) returns settings of POINTER of MultiplexCorePeriphery.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexCorePeriphery, POINTER) returns settings of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@Multirichness(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexCorePeriphery.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCorePeriphery.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexCorePeriphery, POINTER) returns the default value of POINTER of MultiplexCorePeriphery.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexCorePeriphery, POINTER) returns the default value of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@Multirichness(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexCorePeriphery.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCorePeriphery.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexCorePeriphery, POINTER) returns the conditioned default value of POINTER of MultiplexCorePeriphery.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexCorePeriphery, POINTER) returns the conditioned default value of POINTER of MultiplexCorePeriphery.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			prop_default = MultiplexCorePeriphery.conditioning(prop, MultiplexCorePeriphery.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexCorePeriphery, PROP, VALUE) checks VALUE format for PROP of MultiplexCorePeriphery.
			%  CHECK = M.CHECKPROP(MultiplexCorePeriphery, PROP, VALUE) checks VALUE format for PROP of MultiplexCorePeriphery.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  Element.CHECKPROP(MultiplexCorePeriphery, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCorePeriphery.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			%  M.CHECKPROP(MultiplexCorePeriphery, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCorePeriphery.
			%   Error id: [BRAPH2:MultiplexCorePeriphery:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@Multirichness(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexCorePeriphery.getPropTag(prop) ' (' MultiplexCorePeriphery.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = MultiplexCorePeriphery.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 1 (Superglobal).
			%
			% 1 = MultiplexCorePeriphery.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.SUPERGLOBAL;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = MultiplexCorePeriphery.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of MultiplexCorePeriphery compatible graphs.
			%
			% LIST = MultiplexCorePeriphery.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help MultiplexBD">MultiplexBD</a>
			%  <a href="matlab:help MultiplexBU">MultiplexBU</a>
			%  <a href="matlab:help MultiplexBUD">MultiplexBUD</a>
			%  <a href="matlab:help MultiplexBUT">MultiplexBUT</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'MultiplexBD', ...
				'MultiplexBU', ...
				'MultiplexBUD', ...
				'MultiplexBUT', ...
				'MultiplexWD', ...
				'MultiplexWU', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (6) of MultiplexCorePeriphery compatible graphs.
			%
			% 6 = MultiplexCorePeriphery.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('MultiplexCorePeriphery');
		end
	end
	methods % constructor
		function m = MultiplexCorePeriphery(varargin)
			% MultiplexCorePeriphery() creates a multiplex core-periphery.
			%
			% MultiplexCorePeriphery(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexCorePeriphery(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiplexCorePeriphery properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multiplex core periphery.
			%  <strong>6</strong> <strong>multirichness_coefficients</strong> 	MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR)
			%
			% See also Category, Format, set, check.
			
			m = m@Multirichness(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = MultiplexCorePeriphery.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Multirichness.getPropNumber()
						value = conditioning@Multirichness(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case MultiplexCorePeriphery.M
					g = m.get('G'); % graph from measure class
					multirichness = calculateValue@Multirichness(m, prop);
					[l, ls] = g.layernumber();
					
					if l == 0
					    value = {};
					else
					    N = g.nodenumber();
					
					    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
					    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
					        [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
					        ['Multirichness coefficients must have the same length than the ' ...
					        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])
					
					    if length(multirichness_coefficients) == ls(1)
					        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
					            [BRAPH2.STR ':Multirichness:' BRAPH2.WRONG_INPUT], ...
					            ['Multirichness coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichness_coefficients)])
					        c = multirichness_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					
					    directionality_layer =  g.getDirectionalityType(l);
					    connectivity_layer =  g.getConnectivityType(l);
					    multiplex_core_periphery = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        overlapping_coefficients = zeros(N(1), 1);
					        multiplex_core_periphery_partition = zeros(N(1), 1);
					        for li = count:1:ls(i) + count - 1
					            if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					
					                    strength = Strength('G', g).get('M');
					                    deg = strength{li};
					
					                else  % directed graphs
					
					                    in_strength = InStrength('G', g).get('M');
					                    out_strength = OutStrength('G', g).get('M');
					                    deg = (in_strength{li} + out_strength{li})/2;
					                end
					
					            else  % binary graphs
					                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					
					                    degree = Degree('G', g).get('M');
					                    deg = degree{li};
					
					                else  % directed graphs
					
					                    in_degree = InDegree('G', g).get('M');
					                    out_degree = OutDegree('G', g).get('M');
					                    deg = (in_degree{li} + out_degree{li})/2;
					                end
					            end
					            overlapping_coefficients = overlapping_coefficients + c(li)*deg;
					        end
					        [~, rankingInd] = sort(overlapping_coefficients, 'descend');
					        multirichness_partition = multirichness{i};
					        [~, rankOfMaxMultirichness] = max(multirichness_partition(rankingInd));  
					        multiplex_core_periphery_partition(rankingInd(1:rankOfMaxMultirichness)) = 1;
					        count = count + ls(i);
					        multiplex_core_periphery(i) = {multiplex_core_periphery_partition};
					    end
					    value = multiplex_core_periphery;
					end
					
				otherwise
					value = calculateValue@Multirichness(m, prop);
					
			end
		end
	end
end
