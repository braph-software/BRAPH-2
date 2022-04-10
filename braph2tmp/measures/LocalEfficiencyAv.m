classdef LocalEfficiencyAv < LocalEfficiency
	% LocalEfficiencyAv is the graph average local efficiency.
	% It is a subclass of <a href="matlab:help LocalEfficiency">LocalEfficiency</a>.
	%
	% The average local efficiency is the average of all the local efficiencies
	% within each layer.
	%
	% The list of LocalEfficiencyAv properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average local efficiency.
	%
	% LocalEfficiencyAv methods (constructor):
	% LocalEfficiencyAv - constructor
	%
	% LocalEfficiencyAv methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in average local efficiency/error.
	%  existsProp - checks whether property exists in average local efficiency/error.
	%  getPropNumber - returns the property number of average local efficiency.
	%  getProps - returns the property list of average local efficiency.
	%  getDescription - returns the description of the average local efficiency.
	%  getName - returns the name of the average local efficiency.
	%  getClass - returns the class of the average local efficiency.
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
	% LocalEfficiencyAv methods:
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
	% LocalEfficiencyAv methods (operators):
	%  isequal - determines whether two LocalEfficiencyAv are equal (values, locked)
	%
	% LocalEfficiencyAv methods (display):
	%  tostring - string with information about the LocalEfficiencyAv
	%  disp - displays information about the LocalEfficiencyAv
	%  tree - displays the element of LocalEfficiencyAv
	%
	% LocalEfficiencyAv method (element list):
	%  getElementList - returns a list with all subelements of LocalEfficiencyAv
	%
	% LocalEfficiencyAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the LocalEfficiencyAv
	%
	% LocalEfficiencyAv method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the LocalEfficiencyAv
	%
	% LocalEfficiencyAv methods (copy):
	%  copy - copies the LocalEfficiencyAv
	%  deepclone - deep-clones the LocalEfficiencyAv
	%  clone - clones the LocalEfficiencyAv
	%
	% LocalEfficiencyAv methods (inspection, Static):
	%  getClass - returns LocalEfficiencyAv
	%  getName - returns the name of LocalEfficiencyAv
	%  getDescription - returns the description of LocalEfficiencyAv
	%  getProps - returns the property list of LocalEfficiencyAv
	%  getPropNumber - returns the property number of LocalEfficiencyAv
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
	% LocalEfficiencyAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% LocalEfficiencyAv methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% LocalEfficiencyAv methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% LocalEfficiencyAv methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% LocalEfficiencyAv properties (Constant).
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
			%GETCLASS returns the class of the average local efficiency.
			%
			% CLASS = LocalEfficiencyAv.GETCLASS() returns the class 'LocalEfficiencyAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average local efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('LocalEfficiencyAv') returns 'LocalEfficiencyAv'.
			%
			% See also getName, getDescription.
			
			m_class = 'LocalEfficiencyAv';
		end
		function m_name = getName()
			%GETNAME returns the name of the average local efficiency.
			%
			% NAME = LocalEfficiencyAv.GETNAME() returns the name of the 'average local efficiency'.
			%  Average Local Efficiency.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the average local efficiency M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('LocalEfficiencyAv') returns the name of 'LocalEfficiencyAv'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Average Local Efficiency';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the average local efficiency.
			%
			% STR = LocalEfficiencyAv.GETDESCRIPTION() returns the description of the 'average local efficiency'.
			%  which is:
			%
			%  The average local efficiency is the average of all the local efficiencies
			%  within each layer.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the average local efficiency M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('LocalEfficiencyAv') returns the description of 'LocalEfficiencyAv'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The average local efficiency is the average of all the local efficiencies' ...
				'within each layer.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average local efficiency.
			%
			% PROPS = LocalEfficiencyAv.GETPROPS() returns the property list of average local efficiency.
			%
			% PROPS = LocalEfficiencyAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average local efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('LocalEfficiencyAv'[, CATEGORY]) returns the property list of 'LocalEfficiencyAv'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						LocalEfficiency.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						LocalEfficiency.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						LocalEfficiency.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						LocalEfficiency.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						LocalEfficiency.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						LocalEfficiency.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						LocalEfficiency.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of average local efficiency.
			%
			% N = LocalEfficiencyAv.GETPROPNUMBER() returns the property number of average local efficiency.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the average local efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('LocalEfficiencyAv') returns the property number of 'LocalEfficiencyAv'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in average local efficiency/error.
			%
			% CHECK = LocalEfficiencyAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(LocalEfficiencyAv, PROP) checks whether PROP exists for LocalEfficiencyAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(LocalEfficiencyAv, PROP) throws error if PROP does NOT exist for LocalEfficiencyAv.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					LocalEfficiencyAv.existsProp(prop), ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for LocalEfficiencyAv.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average local efficiency/error.
			%
			% CHECK = LocalEfficiencyAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(LocalEfficiencyAv, TAG) checks whether TAG exists for LocalEfficiencyAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(LocalEfficiencyAv, TAG) throws error if TAG does NOT exist for LocalEfficiencyAv.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				localefficiencyav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, localefficiencyav_tag_list));
			else
				assert( ...
					LocalEfficiencyAv.existsTag(tag), ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for LocalEfficiencyAv'] ...
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
			%  PROPERTY = Element.GETPROPPROP(LocalEfficiencyAv, POINTER) returns property number of POINTER of LocalEfficiencyAv.
			%  PROPERTY = M.GETPROPPROP(LocalEfficiencyAv, POINTER) returns property number of POINTER of LocalEfficiencyAv.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				localefficiencyav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				LocalEfficiencyAv.existsTag(tag);
				
				prop = find(strcmpi(tag, localefficiencyav_tag_list));
			else % numeric
				prop = pointer;
				LocalEfficiencyAv.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(LocalEfficiencyAv, POINTER) returns tag of POINTER of LocalEfficiencyAv.
			%  TAG = M.GETPROPTAG(LocalEfficiencyAv, POINTER) returns tag of POINTER of LocalEfficiencyAv.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				LocalEfficiencyAv.existsTag(tag);
			else % numeric
				prop = pointer;
				LocalEfficiencyAv.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@LocalEfficiency(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(LocalEfficiencyAv, POINTER) returns category of POINTER of LocalEfficiencyAv.
			%  CATEGORY = M.GETPROPCATEGORY(LocalEfficiencyAv, POINTER) returns category of POINTER of LocalEfficiencyAv.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@LocalEfficiency(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(LocalEfficiencyAv, POINTER) returns format of POINTER of LocalEfficiencyAv.
			%  FORMAT = M.GETPROPFORMAT(LocalEfficiencyAv, POINTER) returns format of POINTER of LocalEfficiencyAv.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@LocalEfficiency(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(LocalEfficiencyAv, POINTER) returns description of POINTER of LocalEfficiencyAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(LocalEfficiencyAv, POINTER) returns description of POINTER of LocalEfficiencyAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case LocalEfficiencyAv.M
					prop_description = 'M (result, cell) is the average local efficiency.';
				otherwise
					prop_description = getPropDescription@LocalEfficiency(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(LocalEfficiencyAv, POINTER) returns settings of POINTER of LocalEfficiencyAv.
			%  SETTINGS = M.GETPROPSETTINGS(LocalEfficiencyAv, POINTER) returns settings of POINTER of LocalEfficiencyAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@LocalEfficiency(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = LocalEfficiencyAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = LocalEfficiencyAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(LocalEfficiencyAv, POINTER) returns the default value of POINTER of LocalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULT(LocalEfficiencyAv, POINTER) returns the default value of POINTER of LocalEfficiencyAv.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@LocalEfficiency(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = LocalEfficiencyAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = LocalEfficiencyAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(LocalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of LocalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(LocalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of LocalEfficiencyAv.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			prop_default = LocalEfficiencyAv.conditioning(prop, LocalEfficiencyAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(LocalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of LocalEfficiencyAv.
			%  CHECK = M.CHECKPROP(LocalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of LocalEfficiencyAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  Element.CHECKPROP(LocalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of LocalEfficiencyAv.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			%  M.CHECKPROP(LocalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of LocalEfficiencyAv.
			%   Error id: [BRAPH2:LocalEfficiencyAv:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@LocalEfficiency(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':LocalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' LocalEfficiencyAv.getPropTag(prop) ' (' LocalEfficiencyAv.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 1 (Global).
			%
			% 1 = LocalEfficiencyAv.GETMEASURESHAPE() returns the measures graph shape (Global).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.GLOBAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = LocalEfficiencyAv.GETMEASURESCOPE() returns the measures layer scope (Global).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = LocalEfficiencyAv.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of LocalEfficiencyAv compatible graphs.
			%
			% LIST = LocalEfficiencyAv.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help GraphBU">GraphBU</a>
			%  <a href="matlab:help MultigraphBUD">MultigraphBUD</a>
			%  <a href="matlab:help MultigraphBUT">MultigraphBUT</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%  <a href="matlab:help MultiplexBU">MultiplexBU</a>
			%  <a href="matlab:help MultiplexBUD">MultiplexBUD</a>
			%  <a href="matlab:help MultiplexBUT">MultiplexBUT</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWU', ...
				'GraphBU', ...
				'MultigraphBUD', ...
				'MultigraphBUT', ...
				'MultiplexWU', ...
				'MultiplexBU', ...
				'MultiplexBUD', ...
				'MultiplexBUT', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (8) of LocalEfficiencyAv compatible graphs.
			%
			% 8 = LocalEfficiencyAv.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('LocalEfficiencyAv');
		end
	end
	methods % constructor
		function m = LocalEfficiencyAv(varargin)
			% LocalEfficiencyAv() creates a average local efficiency.
			%
			% LocalEfficiencyAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% LocalEfficiencyAv(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of LocalEfficiencyAv properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the average local efficiency.
			%
			% See also Category, Format, set, check.
			
			m = m@LocalEfficiency(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = LocalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= LocalEfficiency.getPropNumber()
						value = conditioning@LocalEfficiency(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case LocalEfficiencyAv.M
					g = m.get('G'); % graph from measure class
					local_efficiency = calculateValue@LocalEfficiency(m, prop);
					
					local_efficiency_av = cell(g.layernumber(), 1);
					for li = 1:1:length(local_efficiency_av)
					    local_efficiency_av(li) = {mean(local_efficiency{li})};
					end
					
					value = local_efficiency_av;
					
				otherwise
					value = calculateValue@LocalEfficiency(m, prop);
					
			end
		end
	end
end
