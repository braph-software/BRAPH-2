classdef InEccentricityAv < InEccentricity
	% InEccentricityAv is the graph average in-eccentricity.
	% It is a subclass of <a href="matlab:help InEccentricity">InEccentricity</a>.
	%
	% The average in-eccentricity of a node is the sum of the nodal 
	% in-eccentricities divided by their number within a layer.
	%
	% The list of InEccentricityAv properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average in-eccentricity.
	%  <strong>6</strong> <strong>rule</strong> 	rule (parameter, OPTION)  % calculation in a graph or its subgraph
	%
	% InEccentricityAv methods (constructor):
	% InEccentricityAv - constructor
	%
	% InEccentricityAv methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in average in-eccentricity/error.
	%  existsProp - checks whether property exists in average in-eccentricity/error.
	%  getPropNumber - returns the property number of average in-eccentricity.
	%  getProps - returns the property list of average in-eccentricity.
	%  getDescription - returns the description of the average in-eccentricity.
	%  getName - returns the name of the average in-eccentricity.
	%  getClass - returns the class of the average in-eccentricity.
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
	% InEccentricityAv methods:
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
	% InEccentricityAv methods (operators):
	%  isequal - determines whether two InEccentricityAv are equal (values, locked)
	%
	% InEccentricityAv methods (display):
	%  tostring - string with information about the InEccentricityAv
	%  disp - displays information about the InEccentricityAv
	%  tree - displays the element of InEccentricityAv
	%
	% InEccentricityAv method (element list):
	%  getElementList - returns a list with all subelements of InEccentricityAv
	%
	% InEccentricityAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the InEccentricityAv
	%
	% InEccentricityAv method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the InEccentricityAv
	%
	% InEccentricityAv methods (copy):
	%  copy - copies the InEccentricityAv
	%  deepclone - deep-clones the InEccentricityAv
	%  clone - clones the InEccentricityAv
	%
	% InEccentricityAv methods (inspection, Static):
	%  getClass - returns InEccentricityAv
	%  getName - returns the name of InEccentricityAv
	%  getDescription - returns the description of InEccentricityAv
	%  getProps - returns the property list of InEccentricityAv
	%  getPropNumber - returns the property number of InEccentricityAv
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
	% InEccentricityAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% InEccentricityAv methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% InEccentricityAv methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% InEccentricityAv methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% InEccentricityAv properties (Constant).
	%  RULE - 6
	%  RULE_TAG - 'rule'
	%  RULE_CATEGORY - 'p'
	%  RULE_FORMAT - 'op'
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
			%GETCLASS returns the class of the average in-eccentricity.
			%
			% CLASS = InEccentricityAv.GETCLASS() returns the class 'InEccentricityAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('InEccentricityAv') returns 'InEccentricityAv'.
			%
			% See also getName, getDescription.
			
			m_class = 'InEccentricityAv';
		end
		function m_name = getName()
			%GETNAME returns the name of the average in-eccentricity.
			%
			% NAME = InEccentricityAv.GETNAME() returns the name of the 'average in-eccentricity'.
			%  Average In-Eccentricity.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the average in-eccentricity M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('InEccentricityAv') returns the name of 'InEccentricityAv'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Average In-Eccentricity';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the average in-eccentricity.
			%
			% STR = InEccentricityAv.GETDESCRIPTION() returns the description of the 'average in-eccentricity'.
			%  which is:
			%
			%  The average in-eccentricity of a node is the sum of the nodal 
			%  in-eccentricities divided by their number within a layer.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the average in-eccentricity M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('InEccentricityAv') returns the description of 'InEccentricityAv'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The average in-eccentricity of a node is the sum of the nodal ' ...
				'in-eccentricities divided by their number within a layer.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-eccentricity.
			%
			% PROPS = InEccentricityAv.GETPROPS() returns the property list of average in-eccentricity.
			%
			% PROPS = InEccentricityAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('InEccentricityAv'[, CATEGORY]) returns the property list of 'InEccentricityAv'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						InEccentricity.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						InEccentricity.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						InEccentricity.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						InEccentricity.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						InEccentricity.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						InEccentricity.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						InEccentricity.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of average in-eccentricity.
			%
			% N = InEccentricityAv.GETPROPNUMBER() returns the property number of average in-eccentricity.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the average in-eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('InEccentricityAv') returns the property number of 'InEccentricityAv'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in average in-eccentricity/error.
			%
			% CHECK = InEccentricityAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(InEccentricityAv, PROP) checks whether PROP exists for InEccentricityAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  Element.EXISTSPROP(InEccentricityAv, PROP) throws error if PROP does NOT exist for InEccentricityAv.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					InEccentricityAv.existsProp(prop), ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for InEccentricityAv.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-eccentricity/error.
			%
			% CHECK = InEccentricityAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(InEccentricityAv, TAG) checks whether TAG exists for InEccentricityAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  Element.EXISTSTAG(InEccentricityAv, TAG) throws error if TAG does NOT exist for InEccentricityAv.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ineccentricityav_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'rule' };
				
				check = any(strcmpi(tag, ineccentricityav_tag_list));
			else
				assert( ...
					InEccentricityAv.existsTag(tag), ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for InEccentricityAv'] ...
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
			%  PROPERTY = Element.GETPROPPROP(InEccentricityAv, POINTER) returns property number of POINTER of InEccentricityAv.
			%  PROPERTY = M.GETPROPPROP(InEccentricityAv, POINTER) returns property number of POINTER of InEccentricityAv.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ineccentricityav_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'rule' };
				
				tag = pointer;
				InEccentricityAv.existsTag(tag);
				
				prop = find(strcmpi(tag, ineccentricityav_tag_list));
			else % numeric
				prop = pointer;
				InEccentricityAv.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(InEccentricityAv, POINTER) returns tag of POINTER of InEccentricityAv.
			%  TAG = M.GETPROPTAG(InEccentricityAv, POINTER) returns tag of POINTER of InEccentricityAv.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				InEccentricityAv.existsTag(tag);
			else % numeric
				prop = pointer;
				InEccentricityAv.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@InEccentricity(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(InEccentricityAv, POINTER) returns category of POINTER of InEccentricityAv.
			%  CATEGORY = M.GETPROPCATEGORY(InEccentricityAv, POINTER) returns category of POINTER of InEccentricityAv.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@InEccentricity(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(InEccentricityAv, POINTER) returns format of POINTER of InEccentricityAv.
			%  FORMAT = M.GETPROPFORMAT(InEccentricityAv, POINTER) returns format of POINTER of InEccentricityAv.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@InEccentricity(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(InEccentricityAv, POINTER) returns description of POINTER of InEccentricityAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(InEccentricityAv, POINTER) returns description of POINTER of InEccentricityAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				case InEccentricityAv.M
					prop_description = 'M (result, cell) is the average in-eccentricity.';
				otherwise
					prop_description = getPropDescription@InEccentricity(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(InEccentricityAv, POINTER) returns settings of POINTER of InEccentricityAv.
			%  SETTINGS = M.GETPROPSETTINGS(InEccentricityAv, POINTER) returns settings of POINTER of InEccentricityAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@InEccentricity(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = InEccentricityAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = InEccentricityAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(InEccentricityAv, POINTER) returns the default value of POINTER of InEccentricityAv.
			%  DEFAULT = M.GETPROPDEFAULT(InEccentricityAv, POINTER) returns the default value of POINTER of InEccentricityAv.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@InEccentricity(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = InEccentricityAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = InEccentricityAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(InEccentricityAv, POINTER) returns the conditioned default value of POINTER of InEccentricityAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(InEccentricityAv, POINTER) returns the conditioned default value of POINTER of InEccentricityAv.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			prop_default = InEccentricityAv.conditioning(prop, InEccentricityAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(InEccentricityAv, PROP, VALUE) checks VALUE format for PROP of InEccentricityAv.
			%  CHECK = M.CHECKPROP(InEccentricityAv, PROP, VALUE) checks VALUE format for PROP of InEccentricityAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:InEccentricityAv:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  Element.CHECKPROP(InEccentricityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of InEccentricityAv.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			%  M.CHECKPROP(InEccentricityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of InEccentricityAv.
			%   Error id: [BRAPH2:InEccentricityAv:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@InEccentricity(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':InEccentricityAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' InEccentricityAv.getPropTag(prop) ' (' InEccentricityAv.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 2 (Nodal).
			%
			% 2 = InEccentricityAv.GETMEASURESHAPE() returns the measures graph shape (Nodal).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.NODAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = InEccentricityAv.GETMEASURESCOPE() returns the measures layer scope (Nodal).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = InEccentricityAv.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of InEccentricityAv compatible graphs.
			%
			% LIST = InEccentricityAv.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWD">GraphWD</a>
			%  <a href="matlab:help GraphBD">GraphBD</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%  <a href="matlab:help MultiplexBD">MultiplexBD</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWD', ...
				'GraphBD', ...
				'MultiplexWD', ...
				'MultiplexBD', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (4) of InEccentricityAv compatible graphs.
			%
			% 4 = InEccentricityAv.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('InEccentricityAv');
		end
	end
	methods % constructor
		function m = InEccentricityAv(varargin)
			% InEccentricityAv() creates a average in-eccentricity.
			%
			% InEccentricityAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% InEccentricityAv(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of InEccentricityAv properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average in-eccentricity.
			%  <strong>6</strong> <strong>rule</strong> 	rule (parameter, OPTION)  % calculation in a graph or its subgraph
			%
			% See also Category, Format, set, check.
			
			m = m@InEccentricity(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = InEccentricityAv.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= InEccentricity.getPropNumber()
						value = conditioning@InEccentricity(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case InEccentricityAv.M
					g = m.get('G'); % graph from measure class
					L = g.layernumber();
					eccentricity_rule = m.get('rule');
					in_eccentricity = InEccentricity('G', g, 'rule', eccentricity_rule).get('M'); 
					
					in_eccentricity_av = cell(L, 1);
					for li = 1:1:L
					    in_eccentricity_av(li) = {mean(in_eccentricity{li})};
					end
					value = in_eccentricity_av;
					
				otherwise
					value = calculateValue@InEccentricity(m, prop);
					
			end
		end
	end
end
