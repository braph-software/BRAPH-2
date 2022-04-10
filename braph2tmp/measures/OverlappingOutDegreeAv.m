classdef OverlappingOutDegreeAv < OverlappingOutDegree
	% OverlappingOutDegreeAv is the graph average overlapping out-degree.
	% It is a subclass of <a href="matlab:help OverlappingOutDegree">OverlappingOutDegree</a>.
	%
	% The average overlapping out-degree of a graph is the average of the sum of the 
	% out-degrees of a node in all layers.
	%
	% The list of OverlappingOutDegreeAv properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average overlapping out-degree.
	%
	% OverlappingOutDegreeAv methods (constructor):
	% OverlappingOutDegreeAv - constructor
	%
	% OverlappingOutDegreeAv methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in average overlapping out-degree/error.
	%  existsProp - checks whether property exists in average overlapping out-degree/error.
	%  getPropNumber - returns the property number of average overlapping out-degree.
	%  getProps - returns the property list of average overlapping out-degree.
	%  getDescription - returns the description of the average overlapping out-degree.
	%  getName - returns the name of the average overlapping out-degree.
	%  getClass - returns the class of the average overlapping out-degree.
	%  getCompatibleGraphNumber - returns the number (4) of OutDegree compatible graphs.
	%  getCompatibleGraphList - returns the list of OutDegree compatible graphs.
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
	% OverlappingOutDegreeAv methods:
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
	% OverlappingOutDegreeAv methods (operators):
	%  isequal - determines whether two OverlappingOutDegreeAv are equal (values, locked)
	%
	% OverlappingOutDegreeAv methods (display):
	%  tostring - string with information about the OverlappingOutDegreeAv
	%  disp - displays information about the OverlappingOutDegreeAv
	%  tree - displays the element of OverlappingOutDegreeAv
	%
	% OverlappingOutDegreeAv method (element list):
	%  getElementList - returns a list with all subelements of OverlappingOutDegreeAv
	%
	% OverlappingOutDegreeAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the OverlappingOutDegreeAv
	%
	% OverlappingOutDegreeAv method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the OverlappingOutDegreeAv
	%
	% OverlappingOutDegreeAv methods (copy):
	%  copy - copies the OverlappingOutDegreeAv
	%  deepclone - deep-clones the OverlappingOutDegreeAv
	%  clone - clones the OverlappingOutDegreeAv
	%
	% OverlappingOutDegreeAv methods (inspection, Static):
	%  getClass - returns OverlappingOutDegreeAv
	%  getName - returns the name of OverlappingOutDegreeAv
	%  getDescription - returns the description of OverlappingOutDegreeAv
	%  getProps - returns the property list of OverlappingOutDegreeAv
	%  getPropNumber - returns the property number of OverlappingOutDegreeAv
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
	% OverlappingOutDegreeAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingOutDegreeAv methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% OverlappingOutDegreeAv methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% OverlappingOutDegreeAv methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% OverlappingOutDegreeAv properties (Constant).
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
			%GETCLASS returns the class of the average overlapping out-degree.
			%
			% CLASS = OverlappingOutDegreeAv.GETCLASS() returns the class 'OverlappingOutDegreeAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average overlapping out-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingOutDegreeAv') returns 'OverlappingOutDegreeAv'.
			%
			% See also getName, getDescription.
			
			m_class = 'OverlappingOutDegreeAv';
		end
		function m_name = getName()
			%GETNAME returns the name of the average overlapping out-degree.
			%
			% NAME = OverlappingOutDegreeAv.GETNAME() returns the name of the 'average overlapping out-degree'.
			%  Average Overlapping Out-Degree.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the average overlapping out-degree M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('OverlappingOutDegreeAv') returns the name of 'OverlappingOutDegreeAv'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Average Overlapping Out-Degree';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the average overlapping out-degree.
			%
			% STR = OverlappingOutDegreeAv.GETDESCRIPTION() returns the description of the 'average overlapping out-degree'.
			%  which is:
			%
			%  The average overlapping out-degree of a graph is the average of the sum of the 
			%  out-degrees of a node in all layers.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the average overlapping out-degree M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('OverlappingOutDegreeAv') returns the description of 'OverlappingOutDegreeAv'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The average overlapping out-degree of a graph is the average of the sum of the ' ...
				'out-degrees of a node in all layers.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average overlapping out-degree.
			%
			% PROPS = OverlappingOutDegreeAv.GETPROPS() returns the property list of average overlapping out-degree.
			%
			% PROPS = OverlappingOutDegreeAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average overlapping out-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingOutDegreeAv'[, CATEGORY]) returns the property list of 'OverlappingOutDegreeAv'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						OverlappingOutDegree.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						OverlappingOutDegree.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						OverlappingOutDegree.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						OverlappingOutDegree.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						OverlappingOutDegree.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						OverlappingOutDegree.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						OverlappingOutDegree.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of average overlapping out-degree.
			%
			% N = OverlappingOutDegreeAv.GETPROPNUMBER() returns the property number of average overlapping out-degree.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the average overlapping out-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingOutDegreeAv') returns the property number of 'OverlappingOutDegreeAv'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in average overlapping out-degree/error.
			%
			% CHECK = OverlappingOutDegreeAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingOutDegreeAv, PROP) checks whether PROP exists for OverlappingOutDegreeAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingOutDegreeAv, PROP) throws error if PROP does NOT exist for OverlappingOutDegreeAv.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					OverlappingOutDegreeAv.existsProp(prop), ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingOutDegreeAv.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average overlapping out-degree/error.
			%
			% CHECK = OverlappingOutDegreeAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingOutDegreeAv, TAG) checks whether TAG exists for OverlappingOutDegreeAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingOutDegreeAv, TAG) throws error if TAG does NOT exist for OverlappingOutDegreeAv.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				overlappingoutdegreeav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, overlappingoutdegreeav_tag_list));
			else
				assert( ...
					OverlappingOutDegreeAv.existsTag(tag), ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for OverlappingOutDegreeAv'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OverlappingOutDegreeAv, POINTER) returns property number of POINTER of OverlappingOutDegreeAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingOutDegreeAv, POINTER) returns property number of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				overlappingoutdegreeav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				OverlappingOutDegreeAv.existsTag(tag);
				
				prop = find(strcmpi(tag, overlappingoutdegreeav_tag_list));
			else % numeric
				prop = pointer;
				OverlappingOutDegreeAv.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(OverlappingOutDegreeAv, POINTER) returns tag of POINTER of OverlappingOutDegreeAv.
			%  TAG = M.GETPROPTAG(OverlappingOutDegreeAv, POINTER) returns tag of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				OverlappingOutDegreeAv.existsTag(tag);
			else % numeric
				prop = pointer;
				OverlappingOutDegreeAv.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@OverlappingOutDegree(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingOutDegreeAv, POINTER) returns category of POINTER of OverlappingOutDegreeAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingOutDegreeAv, POINTER) returns category of POINTER of OverlappingOutDegreeAv.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingOutDegree(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OverlappingOutDegreeAv, POINTER) returns format of POINTER of OverlappingOutDegreeAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingOutDegreeAv, POINTER) returns format of POINTER of OverlappingOutDegreeAv.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingOutDegree(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingOutDegreeAv, POINTER) returns description of POINTER of OverlappingOutDegreeAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingOutDegreeAv, POINTER) returns description of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				case OverlappingOutDegreeAv.M
					prop_description = 'M (result, cell) is the average overlapping out-degree.';
				otherwise
					prop_description = getPropDescription@OverlappingOutDegree(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingOutDegreeAv, POINTER) returns settings of POINTER of OverlappingOutDegreeAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingOutDegreeAv, POINTER) returns settings of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@OverlappingOutDegree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingOutDegreeAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingOutDegreeAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingOutDegreeAv, POINTER) returns the default value of POINTER of OverlappingOutDegreeAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingOutDegreeAv, POINTER) returns the default value of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@OverlappingOutDegree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingOutDegreeAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingOutDegreeAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingOutDegreeAv, POINTER) returns the conditioned default value of POINTER of OverlappingOutDegreeAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingOutDegreeAv, POINTER) returns the conditioned default value of POINTER of OverlappingOutDegreeAv.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			prop_default = OverlappingOutDegreeAv.conditioning(prop, OverlappingOutDegreeAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OverlappingOutDegreeAv, PROP, VALUE) checks VALUE format for PROP of OverlappingOutDegreeAv.
			%  CHECK = M.CHECKPROP(OverlappingOutDegreeAv, PROP, VALUE) checks VALUE format for PROP of OverlappingOutDegreeAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  Element.CHECKPROP(OverlappingOutDegreeAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingOutDegreeAv.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			%  M.CHECKPROP(OverlappingOutDegreeAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingOutDegreeAv.
			%   Error id: [BRAPH2:OverlappingOutDegreeAv:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@OverlappingOutDegree(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingOutDegreeAv.getPropTag(prop) ' (' OverlappingOutDegreeAv.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 1 (Global).
			%
			% 1 = OverlappingOutDegreeAv.GETMEASURESHAPE() returns the measures graph shape (Global).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.GLOBAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 1 (Superglobal).
			%
			% 1 = OverlappingOutDegreeAv.GETMEASURESCOPE() returns the measures layer scope (Global).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.SUPERGLOBAL;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = OverlappingOutDegreeAv.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of OverlappingOutDegreeAv compatible graphs.
			%
			% LIST = OverlappingOutDegreeAv.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help MultiplexBD">MultiplexBD</a>
			%  <a href="matlab:help MultiplexWD">MultiplexWD</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'MultiplexBD', ...
				'MultiplexWD', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (2) of OverlappingOutDegreeAv compatible graphs.
			%
			% 2 = OverlappingOutDegreeAv.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('OverlappingOutDegreeAv');
		end
	end
	methods % constructor
		function m = OverlappingOutDegreeAv(varargin)
			% OverlappingOutDegreeAv() creates a average overlapping out-degree.
			%
			% OverlappingOutDegreeAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingOutDegreeAv(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OverlappingOutDegreeAv properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average overlapping out-degree.
			%
			% See also Category, Format, set, check.
			
			m = m@OverlappingOutDegree(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = OverlappingOutDegreeAv.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= OverlappingOutDegree.getPropNumber()
						value = conditioning@OverlappingOutDegree(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case OverlappingOutDegreeAv.M
					g = m.get('G');  % graph from measure class
					overlapping_out_degree_av = calculateValue@OverlappingOutDegree(m, prop);
					
					value = {mean(cell2mat(overlapping_out_degree_av))};
					
				otherwise
					value = calculateValue@OverlappingOutDegree(m, prop);
					
			end
		end
	end
end
