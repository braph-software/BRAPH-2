classdef OutGlobalEfficiencyAv < OutGlobalEfficiency
	% OutGlobalEfficiencyAv is the graph average out-global efficiency.
	% It is a subclass of <a href="matlab:help OutGlobalEfficiency">OutGlobalEfficiency</a>.
	%
	% The average out-global efficiency is the average of the out-global efficiency
	% without each layer.
	%
	% The list of OutGlobalEfficiencyAv properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the out-global efficiency.
	%
	% OutGlobalEfficiencyAv methods (constructor):
	% OutGlobalEfficiencyAv - constructor
	%
	% OutGlobalEfficiencyAv methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in average out-global efficiency/error.
	%  existsProp - checks whether property exists in average out-global efficiency/error.
	%  getPropNumber - returns the property number of average out-global efficiency.
	%  getProps - returns the property list of average out-global efficiency.
	%  getDescription - returns the description of the average out-global efficiency.
	%  getName - returns the name of the average out-global efficiency.
	%  getClass - returns the class of the average out-global efficiency.
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
	% OutGlobalEfficiencyAv methods:
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
	% OutGlobalEfficiencyAv methods (operators):
	%  isequal - determines whether two OutGlobalEfficiencyAv are equal (values, locked)
	%
	% OutGlobalEfficiencyAv methods (display):
	%  tostring - string with information about the OutGlobalEfficiencyAv
	%  disp - displays information about the OutGlobalEfficiencyAv
	%  tree - displays the element of OutGlobalEfficiencyAv
	%
	% OutGlobalEfficiencyAv method (element list):
	%  getElementList - returns a list with all subelements of OutGlobalEfficiencyAv
	%
	% OutGlobalEfficiencyAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the OutGlobalEfficiencyAv
	%
	% OutGlobalEfficiencyAv method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the OutGlobalEfficiencyAv
	%
	% OutGlobalEfficiencyAv methods (copy):
	%  copy - copies the OutGlobalEfficiencyAv
	%  deepclone - deep-clones the OutGlobalEfficiencyAv
	%  clone - clones the OutGlobalEfficiencyAv
	%
	% OutGlobalEfficiencyAv methods (inspection, Static):
	%  getClass - returns OutGlobalEfficiencyAv
	%  getName - returns the name of OutGlobalEfficiencyAv
	%  getDescription - returns the description of OutGlobalEfficiencyAv
	%  getProps - returns the property list of OutGlobalEfficiencyAv
	%  getPropNumber - returns the property number of OutGlobalEfficiencyAv
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
	% OutGlobalEfficiencyAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OutGlobalEfficiencyAv methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% OutGlobalEfficiencyAv methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% OutGlobalEfficiencyAv methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% OutGlobalEfficiencyAv properties (Constant).
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
			%GETCLASS returns the class of the average out-global efficiency.
			%
			% CLASS = OutGlobalEfficiencyAv.GETCLASS() returns the class 'OutGlobalEfficiencyAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OutGlobalEfficiencyAv') returns 'OutGlobalEfficiencyAv'.
			%
			% See also getName, getDescription.
			
			m_class = 'OutGlobalEfficiencyAv';
		end
		function m_name = getName()
			%GETNAME returns the name of the average out-global efficiency.
			%
			% NAME = OutGlobalEfficiencyAv.GETNAME() returns the name of the 'average out-global efficiency'.
			%  Average Out-Global Efficiency.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the average out-global efficiency M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('OutGlobalEfficiencyAv') returns the name of 'OutGlobalEfficiencyAv'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Average Out-Global Efficiency';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the average out-global efficiency.
			%
			% STR = OutGlobalEfficiencyAv.GETDESCRIPTION() returns the description of the 'average out-global efficiency'.
			%  which is:
			%
			%  The average out-global efficiency is the average of the out-global efficiency
			%  without each layer.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the average out-global efficiency M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('OutGlobalEfficiencyAv') returns the description of 'OutGlobalEfficiencyAv'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The average out-global efficiency is the average of the out-global efficiency' ...
				'without each layer.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-global efficiency.
			%
			% PROPS = OutGlobalEfficiencyAv.GETPROPS() returns the property list of average out-global efficiency.
			%
			% PROPS = OutGlobalEfficiencyAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OutGlobalEfficiencyAv'[, CATEGORY]) returns the property list of 'OutGlobalEfficiencyAv'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						OutGlobalEfficiency.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						OutGlobalEfficiency.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						OutGlobalEfficiency.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						OutGlobalEfficiency.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						OutGlobalEfficiency.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						OutGlobalEfficiency.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						OutGlobalEfficiency.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of average out-global efficiency.
			%
			% N = OutGlobalEfficiencyAv.GETPROPNUMBER() returns the property number of average out-global efficiency.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the average out-global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OutGlobalEfficiencyAv') returns the property number of 'OutGlobalEfficiencyAv'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in average out-global efficiency/error.
			%
			% CHECK = OutGlobalEfficiencyAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OutGlobalEfficiencyAv, PROP) checks whether PROP exists for OutGlobalEfficiencyAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(OutGlobalEfficiencyAv, PROP) throws error if PROP does NOT exist for OutGlobalEfficiencyAv.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					OutGlobalEfficiencyAv.existsProp(prop), ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OutGlobalEfficiencyAv.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-global efficiency/error.
			%
			% CHECK = OutGlobalEfficiencyAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OutGlobalEfficiencyAv, TAG) checks whether TAG exists for OutGlobalEfficiencyAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(OutGlobalEfficiencyAv, TAG) throws error if TAG does NOT exist for OutGlobalEfficiencyAv.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				outglobalefficiencyav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				check = any(strcmpi(tag, outglobalefficiencyav_tag_list));
			else
				assert( ...
					OutGlobalEfficiencyAv.existsTag(tag), ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for OutGlobalEfficiencyAv'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OutGlobalEfficiencyAv, POINTER) returns property number of POINTER of OutGlobalEfficiencyAv.
			%  PROPERTY = M.GETPROPPROP(OutGlobalEfficiencyAv, POINTER) returns property number of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				outglobalefficiencyav_tag_list = { 'id'  'label'  'notes'  'g'  'm' };
				
				tag = pointer;
				OutGlobalEfficiencyAv.existsTag(tag);
				
				prop = find(strcmpi(tag, outglobalefficiencyav_tag_list));
			else % numeric
				prop = pointer;
				OutGlobalEfficiencyAv.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(OutGlobalEfficiencyAv, POINTER) returns tag of POINTER of OutGlobalEfficiencyAv.
			%  TAG = M.GETPROPTAG(OutGlobalEfficiencyAv, POINTER) returns tag of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				OutGlobalEfficiencyAv.existsTag(tag);
			else % numeric
				prop = pointer;
				OutGlobalEfficiencyAv.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@OutGlobalEfficiency(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(OutGlobalEfficiencyAv, POINTER) returns category of POINTER of OutGlobalEfficiencyAv.
			%  CATEGORY = M.GETPROPCATEGORY(OutGlobalEfficiencyAv, POINTER) returns category of POINTER of OutGlobalEfficiencyAv.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OutGlobalEfficiency(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(OutGlobalEfficiencyAv, POINTER) returns format of POINTER of OutGlobalEfficiencyAv.
			%  FORMAT = M.GETPROPFORMAT(OutGlobalEfficiencyAv, POINTER) returns format of POINTER of OutGlobalEfficiencyAv.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OutGlobalEfficiency(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OutGlobalEfficiencyAv, POINTER) returns description of POINTER of OutGlobalEfficiencyAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OutGlobalEfficiencyAv, POINTER) returns description of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case OutGlobalEfficiencyAv.M
					prop_description = 'M (result, cell) is the out-global efficiency.';
				otherwise
					prop_description = getPropDescription@OutGlobalEfficiency(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(OutGlobalEfficiencyAv, POINTER) returns settings of POINTER of OutGlobalEfficiencyAv.
			%  SETTINGS = M.GETPROPSETTINGS(OutGlobalEfficiencyAv, POINTER) returns settings of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@OutGlobalEfficiency(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OutGlobalEfficiencyAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OutGlobalEfficiencyAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OutGlobalEfficiencyAv, POINTER) returns the default value of POINTER of OutGlobalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULT(OutGlobalEfficiencyAv, POINTER) returns the default value of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@OutGlobalEfficiency(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OutGlobalEfficiencyAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OutGlobalEfficiencyAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OutGlobalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of OutGlobalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OutGlobalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of OutGlobalEfficiencyAv.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			prop_default = OutGlobalEfficiencyAv.conditioning(prop, OutGlobalEfficiencyAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OutGlobalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of OutGlobalEfficiencyAv.
			%  CHECK = M.CHECKPROP(OutGlobalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of OutGlobalEfficiencyAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  Element.CHECKPROP(OutGlobalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OutGlobalEfficiencyAv.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			%  M.CHECKPROP(OutGlobalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OutGlobalEfficiencyAv.
			%   Error id: [BRAPH2:OutGlobalEfficiencyAv:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@OutGlobalEfficiency(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OutGlobalEfficiencyAv:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OutGlobalEfficiencyAv.getPropTag(prop) ' (' OutGlobalEfficiencyAv.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 1 (Global).
			%
			% 1 = OutGlobalEfficiencyAv.GETMEASURESHAPE() returns the measures graph shape (Global).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.GLOBAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = OutGlobalEfficiencyAv.GETMEASURESCOPE() returns the measures layer scope (Global).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 2 (Non-parametric).
			%
			% 2 = OutGlobalEfficiencyAv.GETMEASUREPARAMETRICITY() returns the measures parametricity (Non-parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.NONPARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of OutGlobalEfficiencyAv compatible graphs.
			%
			% LIST = OutGlobalEfficiencyAv.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
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
			%GETCOMPATIBLEGRAPHNUMBER returns the number (4) of OutGlobalEfficiencyAv compatible graphs.
			%
			% 4 = OutGlobalEfficiencyAv.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('OutGlobalEfficiencyAv');
		end
	end
	methods % constructor
		function m = OutGlobalEfficiencyAv(varargin)
			% OutGlobalEfficiencyAv() creates a average out-global efficiency.
			%
			% OutGlobalEfficiencyAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OutGlobalEfficiencyAv(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OutGlobalEfficiencyAv properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the out-global efficiency.
			%
			% See also Category, Format, set, check.
			
			m = m@OutGlobalEfficiency(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = OutGlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= OutGlobalEfficiency.getPropNumber()
						value = conditioning@OutGlobalEfficiency(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case OutGlobalEfficiencyAv.M
					g = m.get('G');  % graph from measure class
					L = g.layernumber();
					
					out_global_efficiency = calculateValue@OutGlobalEfficiency(m, prop);
					
					out_global_efficiency_av = cell(L, 1);
					for li = 1:1:L
					    out_global_efficiency_av(li) = {mean(out_global_efficiency{li})};
					end
					value = out_global_efficiency_av;
					
				otherwise
					value = calculateValue@OutGlobalEfficiency(m, prop);
					
			end
		end
	end
end
