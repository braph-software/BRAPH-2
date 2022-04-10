classdef MultiRichClubDegree < RichClubDegree
	% MultiRichClubDegree is the graph multi rich-club degree.
	% It is a subclass of <a href="matlab:help RichClubDegree">RichClubDegree</a>.
	%
	% The multi rich-club degree of a node at level k is the sum of 
	% the edges that connect nodes of degree k or higher in all layers. 
	% The relevance of each layer is controlled by the coefficients c that are 
	% between 0 and 1; the default coefficients are (1/layernumber).
	%
	% The list of MultiRichClubDegree properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multi rich-club degree.
	%  <strong>6</strong> <strong>parametric_value</strong> 	PARAMETRIC_VALUE (parameter, SCALAR) 
	%  <strong>7</strong> <strong>multirichclub_coefficients</strong> 	MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients
	%
	% MultiRichClubDegree methods (constructor):
	% MultiRichClubDegree - constructor
	%
	% MultiRichClubDegree methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in multi rich-club degree/error.
	%  existsProp - checks whether property exists in multi rich-club degree/error.
	%  getPropNumber - returns the property number of multi rich-club degree.
	%  getProps - returns the property list of multi rich-club degree.
	%  getDescription - returns the description of the multi rich-club degree.
	%  getName - returns the name of the multi rich-club degree.
	%  getClass - returns the class of the multi rich-club degree.
	%  getCompatibleGraphNumber - returns the number (8) of Degree compatible graphs.
	%  getCompatibleGraphList - returns the list of Degree compatible graphs.
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
	% MultiRichClubDegree methods:
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
	% MultiRichClubDegree methods (operators):
	%  isequal - determines whether two MultiRichClubDegree are equal (values, locked)
	%
	% MultiRichClubDegree methods (display):
	%  tostring - string with information about the MultiRichClubDegree
	%  disp - displays information about the MultiRichClubDegree
	%  tree - displays the element of MultiRichClubDegree
	%
	% MultiRichClubDegree method (element list):
	%  getElementList - returns a list with all subelements of MultiRichClubDegree
	%
	% MultiRichClubDegree method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the MultiRichClubDegree
	%
	% MultiRichClubDegree method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the MultiRichClubDegree
	%
	% MultiRichClubDegree methods (copy):
	%  copy - copies the MultiRichClubDegree
	%  deepclone - deep-clones the MultiRichClubDegree
	%  clone - clones the MultiRichClubDegree
	%
	% MultiRichClubDegree methods (inspection, Static):
	%  getClass - returns MultiRichClubDegree
	%  getName - returns the name of MultiRichClubDegree
	%  getDescription - returns the description of MultiRichClubDegree
	%  getProps - returns the property list of MultiRichClubDegree
	%  getPropNumber - returns the property number of MultiRichClubDegree
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
	% MultiRichClubDegree methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiRichClubDegree methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% MultiRichClubDegree methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% MultiRichClubDegree methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% MultiRichClubDegree properties (Constant).
	%  MULTIRICHCLUB_COEFFICIENTS - 7
	%  MULTIRICHCLUB_COEFFICIENTS_TAG - 'multirichclub_coefficients'
	%  MULTIRICHCLUB_COEFFICIENTS_CATEGORY - 'p'
	%  MULTIRICHCLUB_COEFFICIENTS_FORMAT - 'nr'
	%  PARAMETRIC_VALUE - 6
	%  PARAMETRIC_VALUE_TAG - 'parametric_value'
	%  PARAMETRIC_VALUE_CATEGORY - 'p'
	%  PARAMETRIC_VALUE_FORMAT - 'nn'
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
	
	properties (Constant) % properties
		MULTIRICHCLUB_COEFFICIENTS = RichClubDegree.getPropNumber() + 1;
		MULTIRICHCLUB_COEFFICIENTS_TAG = 'multirichclub_coefficients';
		MULTIRICHCLUB_COEFFICIENTS_CATEGORY = Category.PARAMETER;
		MULTIRICHCLUB_COEFFICIENTS_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the multi rich-club degree.
			%
			% CLASS = MultiRichClubDegree.GETCLASS() returns the class 'MultiRichClubDegree'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multi rich-club degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiRichClubDegree') returns 'MultiRichClubDegree'.
			%
			% See also getName, getDescription.
			
			m_class = 'MultiRichClubDegree';
		end
		function m_name = getName()
			%GETNAME returns the name of the multi rich-club degree.
			%
			% NAME = MultiRichClubDegree.GETNAME() returns the name of the 'multi rich-club degree'.
			%  Multi Rich-Club Degree.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the multi rich-club degree M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('MultiRichClubDegree') returns the name of 'MultiRichClubDegree'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Multi Rich-Club Degree';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the multi rich-club degree.
			%
			% STR = MultiRichClubDegree.GETDESCRIPTION() returns the description of the 'multi rich-club degree'.
			%  which is:
			%
			%  The multi rich-club degree of a node at level k is the sum of 
			%  the edges that connect nodes of degree k or higher in all layers. 
			%  The relevance of each layer is controlled by the coefficients c that are 
			%  between 0 and 1; the default coefficients are (1/layernumber).
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the multi rich-club degree M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('MultiRichClubDegree') returns the description of 'MultiRichClubDegree'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The multi rich-club degree of a node at level k is the sum of ' ...
				'the edges that connect nodes of degree k or higher in all layers. ' ...
				'The relevance of each layer is controlled by the coefficients c that are ' ...
				'between 0 and 1; the default coefficients are (1/layernumber).' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multi rich-club degree.
			%
			% PROPS = MultiRichClubDegree.GETPROPS() returns the property list of multi rich-club degree.
			%
			% PROPS = MultiRichClubDegree.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multi rich-club degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiRichClubDegree'[, CATEGORY]) returns the property list of 'MultiRichClubDegree'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						RichClubDegree.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						RichClubDegree.getProps(Category.PARAMETER)
						MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
						];
				case Category.DATA
					prop_list = [
						RichClubDegree.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						RichClubDegree.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						RichClubDegree.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						RichClubDegree.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						RichClubDegree.getProps()
						MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of multi rich-club degree.
			%
			% N = MultiRichClubDegree.GETPROPNUMBER() returns the property number of multi rich-club degree.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the multi rich-club degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiRichClubDegree') returns the property number of 'MultiRichClubDegree'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in multi rich-club degree/error.
			%
			% CHECK = MultiRichClubDegree.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiRichClubDegree, PROP) checks whether PROP exists for MultiRichClubDegree.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  Element.EXISTSPROP(MultiRichClubDegree, PROP) throws error if PROP does NOT exist for MultiRichClubDegree.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					MultiRichClubDegree.existsProp(prop), ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiRichClubDegree.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multi rich-club degree/error.
			%
			% CHECK = MultiRichClubDegree.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiRichClubDegree, TAG) checks whether TAG exists for MultiRichClubDegree.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  Element.EXISTSTAG(MultiRichClubDegree, TAG) throws error if TAG does NOT exist for MultiRichClubDegree.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				multirichclubdegree_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'parametric_value'  'multirichclub_coefficients' };
				
				check = any(strcmpi(tag, multirichclubdegree_tag_list));
			else
				assert( ...
					MultiRichClubDegree.existsTag(tag), ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for MultiRichClubDegree'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiRichClubDegree, POINTER) returns property number of POINTER of MultiRichClubDegree.
			%  PROPERTY = M.GETPROPPROP(MultiRichClubDegree, POINTER) returns property number of POINTER of MultiRichClubDegree.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				multirichclubdegree_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'parametric_value'  'multirichclub_coefficients' };
				
				tag = pointer;
				MultiRichClubDegree.existsTag(tag);
				
				prop = find(strcmpi(tag, multirichclubdegree_tag_list));
			else % numeric
				prop = pointer;
				MultiRichClubDegree.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(MultiRichClubDegree, POINTER) returns tag of POINTER of MultiRichClubDegree.
			%  TAG = M.GETPROPTAG(MultiRichClubDegree, POINTER) returns tag of POINTER of MultiRichClubDegree.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				MultiRichClubDegree.existsTag(tag);
			else % numeric
				prop = pointer;
				MultiRichClubDegree.existsProp(prop);
				
				switch prop
					case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
						tag = MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS_TAG;
					otherwise
						tag = getPropTag@RichClubDegree(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiRichClubDegree, POINTER) returns category of POINTER of MultiRichClubDegree.
			%  CATEGORY = M.GETPROPCATEGORY(MultiRichClubDegree, POINTER) returns category of POINTER of MultiRichClubDegree.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					prop_category = MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS_CATEGORY;
				otherwise
					prop_category = getPropCategory@RichClubDegree(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiRichClubDegree, POINTER) returns format of POINTER of MultiRichClubDegree.
			%  FORMAT = M.GETPROPFORMAT(MultiRichClubDegree, POINTER) returns format of POINTER of MultiRichClubDegree.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					prop_format = MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS_FORMAT;
				otherwise
					prop_format = getPropFormat@RichClubDegree(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiRichClubDegree, POINTER) returns description of POINTER of MultiRichClubDegree.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiRichClubDegree, POINTER) returns description of POINTER of MultiRichClubDegree.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					prop_description = 'MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients';
				case MultiRichClubDegree.M
					prop_description = 'M (result, cell) is the multi rich-club degree.';
				otherwise
					prop_description = getPropDescription@RichClubDegree(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiRichClubDegree, POINTER) returns settings of POINTER of MultiRichClubDegree.
			%  SETTINGS = M.GETPROPSETTINGS(MultiRichClubDegree, POINTER) returns settings of POINTER of MultiRichClubDegree.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@RichClubDegree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiRichClubDegree.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRichClubDegree.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiRichClubDegree, POINTER) returns the default value of POINTER of MultiRichClubDegree.
			%  DEFAULT = M.GETPROPDEFAULT(MultiRichClubDegree, POINTER) returns the default value of POINTER of MultiRichClubDegree.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					prop_default = [0];
				otherwise
					prop_default = getPropDefault@RichClubDegree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiRichClubDegree.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRichClubDegree.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiRichClubDegree, POINTER) returns the conditioned default value of POINTER of MultiRichClubDegree.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiRichClubDegree, POINTER) returns the conditioned default value of POINTER of MultiRichClubDegree.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			prop_default = MultiRichClubDegree.conditioning(prop, MultiRichClubDegree.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiRichClubDegree, PROP, VALUE) checks VALUE format for PROP of MultiRichClubDegree.
			%  CHECK = M.CHECKPROP(MultiRichClubDegree, PROP, VALUE) checks VALUE format for PROP of MultiRichClubDegree.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  Element.CHECKPROP(MultiRichClubDegree, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRichClubDegree.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			%  M.CHECKPROP(MultiRichClubDegree, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRichClubDegree.
			%   Error id: [BRAPH2:MultiRichClubDegree:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				case MultiRichClubDegree.MULTIRICHCLUB_COEFFICIENTS
					check = Format.checkFormat(Format.RVECTOR, value, MultiRichClubDegree.getPropSettings(prop));
				otherwise
					check = checkProp@RichClubDegree(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiRichClubDegree.getPropTag(prop) ' (' MultiRichClubDegree.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = MultiRichClubDegree.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 1 (Superglobal).
			%
			% 1 = MultiRichClubDegree.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.SUPERGLOBAL;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 1 (Parametric).
			%
			% 1 = MultiRichClubDegree.GETMEASUREPARAMETRICITY() returns the measures parametricity (Parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.PARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of MultiRichClubDegree compatible graphs.
			%
			% LIST = MultiRichClubDegree.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
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
			%GETCOMPATIBLEGRAPHNUMBER returns the number (6) of MultiRichClubDegree compatible graphs.
			%
			% 6 = MultiRichClubDegree.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('MultiRichClubDegree');
		end
	end
	methods % constructor
		function m = MultiRichClubDegree(varargin)
			% MultiRichClubDegree() creates a multi rich-club degree.
			%
			% MultiRichClubDegree(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiRichClubDegree(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiRichClubDegree properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the multi rich-club degree.
			%  <strong>6</strong> <strong>parametric_value</strong> 	PARAMETRIC_VALUE (parameter, SCALAR) 
			%  <strong>7</strong> <strong>multirichclub_coefficients</strong> 	MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients
			%
			% See also Category, Format, set, check.
			
			m = m@RichClubDegree(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = MultiRichClubDegree.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= RichClubDegree.getPropNumber()
						value = conditioning@RichClubDegree(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case MultiRichClubDegree.M
					g = m.get('G'); % graph from measure class
					rich_club_degree = calculateValue@RichClubDegree(m, prop);   
					[l, ls] = g.layernumber();
					
					if l == 0
					    value = {};
					else
					    
					    N = g.nodenumber();
					
					    richclub_threshold = m.get('PARAMETRIC_VALUE'); % klevel
					
					    multirichclub_coefficients = m.get('MULTIRICHCLUB_COEFFICIENTS');
					    if length(multirichclub_coefficients) == ls(1)
					        assert(all(multirichclub_coefficients <= 1) && all(multirichclub_coefficients >= 0), ...
					            [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
					            ['MultiRichClubDegree coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichclub_coefficients)])
					        c = multirichclub_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					
					    multi_rich_club_degree = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        multi_rich_club_degree_partition = zeros(N(1), 1, richclub_threshold);
					        for li = count:1:ls(i) + count - 1
					            ri = rich_club_degree{li};  % to fix when making this measure also parametric
					            % loop over the 3rd dimension of rich club degree (k_level)
					            for k = 1:1:richclub_threshold
					                multi_rich_club_degree_partition(:, :, k) = multi_rich_club_degree_partition(:, :, k) + c(li)*ri(:, :, k);
					            end
					        end
					        count = count + ls(i);
					        multi_rich_club_degree(i) = {multi_rich_club_degree_partition};
					    end
					    value = multi_rich_club_degree;
					end
					
				otherwise
					value = calculateValue@RichClubDegree(m, prop);
					
			end
		end
	end
end
