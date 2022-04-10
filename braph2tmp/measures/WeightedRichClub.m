classdef WeightedRichClub < Strength
	% WeightedRichClub is the graph weighted rich-club.
	% It is a subclass of <a href="matlab:help Strength">Strength</a>.
	%
	% The weighted rich-club of a node at level s is the fraction of the
	% edges weights that connect nodes of strength s or higher out of the 
	% maxium number of edges weights that such nodes might share within a layer.
	% s is set by the user and it can be a vector containting all the 
	% strength thresholds; the default value is equal to 1.
	%
	% The list of WeightedRichClub properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
	%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the weighted rich-club.
	%  <strong>6</strong> <strong>wrc_parameter</strong> 	WRC_PARAMETER (parameter, RVECTOR) is the threshold
	%
	% WeightedRichClub methods (constructor):
	% WeightedRichClub - constructor
	%
	% WeightedRichClub methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in weighted rich-club/error.
	%  existsProp - checks whether property exists in weighted rich-club/error.
	%  getPropNumber - returns the property number of weighted rich-club.
	%  getProps - returns the property list of weighted rich-club.
	%  getDescription - returns the description of the weighted rich-club.
	%  getName - returns the name of the weighted rich-club.
	%  getClass - returns the class of the weighted rich-club.
	%  getCompatibleGraphNumber - returns the number (2) of Strength compatible graphs.
	%  getCompatibleGraphList - returns the list of Strength compatible graphs.
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
	% WeightedRichClub methods:
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
	% WeightedRichClub methods (operators):
	%  isequal - determines whether two WeightedRichClub are equal (values, locked)
	%
	% WeightedRichClub methods (display):
	%  tostring - string with information about the WeightedRichClub
	%  disp - displays information about the WeightedRichClub
	%  tree - displays the element of WeightedRichClub
	%
	% WeightedRichClub method (element list):
	%  getElementList - returns a list with all subelements of WeightedRichClub
	%
	% WeightedRichClub method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the WeightedRichClub
	%
	% WeightedRichClub method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the WeightedRichClub
	%
	% WeightedRichClub methods (copy):
	%  copy - copies the WeightedRichClub
	%  deepclone - deep-clones the WeightedRichClub
	%  clone - clones the WeightedRichClub
	%
	% WeightedRichClub methods (inspection, Static):
	%  getClass - returns WeightedRichClub
	%  getName - returns the name of WeightedRichClub
	%  getDescription - returns the description of WeightedRichClub
	%  getProps - returns the property list of WeightedRichClub
	%  getPropNumber - returns the property number of WeightedRichClub
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
	% WeightedRichClub methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% WeightedRichClub methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% WeightedRichClub methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% WeightedRichClub methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% WeightedRichClub properties (Constant).
	%  WRC_PARAMETER - 6
	%  WRC_PARAMETER_TAG - 'wrc_parameter'
	%  WRC_PARAMETER_CATEGORY - 'p'
	%  WRC_PARAMETER_FORMAT - 'nr'
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
		WRC_PARAMETER = Strength.getPropNumber() + 1;
		WRC_PARAMETER_TAG = 'wrc_parameter';
		WRC_PARAMETER_CATEGORY = Category.PARAMETER;
		WRC_PARAMETER_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function m_class = getClass()
			%GETCLASS returns the class of the weighted rich-club.
			%
			% CLASS = WeightedRichClub.GETCLASS() returns the class 'WeightedRichClub'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the weighted rich-club M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('WeightedRichClub') returns 'WeightedRichClub'.
			%
			% See also getName, getDescription.
			
			m_class = 'WeightedRichClub';
		end
		function m_name = getName()
			%GETNAME returns the name of the weighted rich-club.
			%
			% NAME = WeightedRichClub.GETNAME() returns the name of the 'weighted rich-club'.
			%  Weighted Rich-Club.
			%
			% Alternative forms to call this method are:
			%  NAME = M.GETNAME() returns the name of the weighted rich-club M.
			%  NAME = Element.GETNAME(M) returns the name of 'M'.
			%  NAME = Element.GETNAME('WeightedRichClub') returns the name of 'WeightedRichClub'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			m_name = 'Weighted Rich-Club';
		end
		function m_description = getDescription()
			%GETDESCRIPTION returns the description of the weighted rich-club.
			%
			% STR = WeightedRichClub.GETDESCRIPTION() returns the description of the 'weighted rich-club'.
			%  which is:
			%
			%  The weighted rich-club of a node at level s is the fraction of the
			%  edges weights that connect nodes of strength s or higher out of the 
			%  maxium number of edges weights that such nodes might share within a layer.
			%  s is set by the user and it can be a vector containting all the 
			%  strength thresholds; the default value is equal to 1.
			%
			% Alternative forms to call this method are:
			%  STR = M.GETDESCRIPTION() returns the description of the weighted rich-club M.
			%  STR = Element.GETDESCRIPTION(M) returns the description of 'M'.
			%  STR = Element.GETDESCRIPTION('WeightedRichClub') returns the description of 'WeightedRichClub'.
			%
			% See also getClass, getName.
			
			m_description = [
				'The weighted rich-club of a node at level s is the fraction of the' ...
				'edges weights that connect nodes of strength s or higher out of the ' ...
				'maxium number of edges weights that such nodes might share within a layer.' ...
				's is set by the user and it can be a vector containting all the ' ...
				'strength thresholds; the default value is equal to 1.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted rich-club.
			%
			% PROPS = WeightedRichClub.GETPROPS() returns the property list of weighted rich-club.
			%
			% PROPS = WeightedRichClub.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the weighted rich-club M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('WeightedRichClub'[, CATEGORY]) returns the property list of 'WeightedRichClub'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Strength.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Strength.getProps(Category.PARAMETER)
						WeightedRichClub.WRC_PARAMETER
						];
				case Category.DATA
					prop_list = [
						Strength.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						Strength.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Strength.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Strength.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Strength.getProps()
						WeightedRichClub.WRC_PARAMETER
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of weighted rich-club.
			%
			% N = WeightedRichClub.GETPROPNUMBER() returns the property number of weighted rich-club.
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER() returns the property number of the weighted rich-club M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('WeightedRichClub') returns the property number of 'WeightedRichClub'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in weighted rich-club/error.
			%
			% CHECK = WeightedRichClub.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(WeightedRichClub, PROP) checks whether PROP exists for WeightedRichClub.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  Element.EXISTSPROP(WeightedRichClub, PROP) throws error if PROP does NOT exist for WeightedRichClub.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					WeightedRichClub.existsProp(prop), ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for WeightedRichClub.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted rich-club/error.
			%
			% CHECK = WeightedRichClub.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(WeightedRichClub, TAG) checks whether TAG exists for WeightedRichClub.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  Element.EXISTSTAG(WeightedRichClub, TAG) throws error if TAG does NOT exist for WeightedRichClub.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				weightedrichclub_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'wrc_parameter' };
				
				check = any(strcmpi(tag, weightedrichclub_tag_list));
			else
				assert( ...
					WeightedRichClub.existsTag(tag), ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for WeightedRichClub'] ...
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
			%  PROPERTY = Element.GETPROPPROP(WeightedRichClub, POINTER) returns property number of POINTER of WeightedRichClub.
			%  PROPERTY = M.GETPROPPROP(WeightedRichClub, POINTER) returns property number of POINTER of WeightedRichClub.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				weightedrichclub_tag_list = { 'id'  'label'  'notes'  'g'  'm'  'wrc_parameter' };
				
				tag = pointer;
				WeightedRichClub.existsTag(tag);
				
				prop = find(strcmpi(tag, weightedrichclub_tag_list));
			else % numeric
				prop = pointer;
				WeightedRichClub.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(WeightedRichClub, POINTER) returns tag of POINTER of WeightedRichClub.
			%  TAG = M.GETPROPTAG(WeightedRichClub, POINTER) returns tag of POINTER of WeightedRichClub.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				WeightedRichClub.existsTag(tag);
			else % numeric
				prop = pointer;
				WeightedRichClub.existsProp(prop);
				
				switch prop
					case WeightedRichClub.WRC_PARAMETER
						tag = WeightedRichClub.WRC_PARAMETER_TAG;
					otherwise
						tag = getPropTag@Strength(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(WeightedRichClub, POINTER) returns category of POINTER of WeightedRichClub.
			%  CATEGORY = M.GETPROPCATEGORY(WeightedRichClub, POINTER) returns category of POINTER of WeightedRichClub.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					prop_category = WeightedRichClub.WRC_PARAMETER_CATEGORY;
				otherwise
					prop_category = getPropCategory@Strength(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(WeightedRichClub, POINTER) returns format of POINTER of WeightedRichClub.
			%  FORMAT = M.GETPROPFORMAT(WeightedRichClub, POINTER) returns format of POINTER of WeightedRichClub.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					prop_format = WeightedRichClub.WRC_PARAMETER_FORMAT;
				otherwise
					prop_format = getPropFormat@Strength(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(WeightedRichClub, POINTER) returns description of POINTER of WeightedRichClub.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(WeightedRichClub, POINTER) returns description of POINTER of WeightedRichClub.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					prop_description = 'WRC_PARAMETER (parameter, RVECTOR) is the threshold';
				case WeightedRichClub.M
					prop_description = 'M (result, cell) is the weighted rich-club.';
				otherwise
					prop_description = getPropDescription@Strength(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(WeightedRichClub, POINTER) returns settings of POINTER of WeightedRichClub.
			%  SETTINGS = M.GETPROPSETTINGS(WeightedRichClub, POINTER) returns settings of POINTER of WeightedRichClub.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@Strength(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = WeightedRichClub.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedRichClub.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(WeightedRichClub, POINTER) returns the default value of POINTER of WeightedRichClub.
			%  DEFAULT = M.GETPROPDEFAULT(WeightedRichClub, POINTER) returns the default value of POINTER of WeightedRichClub.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					prop_default = 1;
				otherwise
					prop_default = getPropDefault@Strength(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = WeightedRichClub.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedRichClub.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(WeightedRichClub, POINTER) returns the conditioned default value of POINTER of WeightedRichClub.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(WeightedRichClub, POINTER) returns the conditioned default value of POINTER of WeightedRichClub.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			prop_default = WeightedRichClub.conditioning(prop, WeightedRichClub.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(WeightedRichClub, PROP, VALUE) checks VALUE format for PROP of WeightedRichClub.
			%  CHECK = M.CHECKPROP(WeightedRichClub, PROP, VALUE) checks VALUE format for PROP of WeightedRichClub.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:WeightedRichClub:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  Element.CHECKPROP(WeightedRichClub, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedRichClub.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			%  M.CHECKPROP(WeightedRichClub, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedRichClub.
			%   Error id: [BRAPH2:WeightedRichClub:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				case WeightedRichClub.WRC_PARAMETER
					check = Format.checkFormat(Format.RVECTOR, value, WeightedRichClub.getPropSettings(prop));
				otherwise
					check = checkProp@Strength(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' WeightedRichClub.getPropTag(prop) ' (' WeightedRichClub.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods (Static) %% graph methods
		function shape = getMeasureShape()
			%GETMEASURESHAPE returns 1 (Global).
			%
			% 1 = WeightedRichClub.GETMEASURESHAPE() returns the measures graph shape (Global).
			%
			% See also getMeasureScope, getMeasureParametricity, getCompatibleGraphList.
			
			shape = Measure.GLOBAL;
		end
		function scope = getMeasureScope()
			%GETMEASURESCOPE returns 2 (Unilayer).
			%
			% 2 = WeightedRichClub.GETMEASURESCOPE() returns the measures layer scope (Global).
			%
			% See also getMeasureShape, getMeasureParametricity, getCompatibleGraphList.
			
			scope = Measure.UNILAYER;
		end
		function parametricity = getMeasureParametricity()
			%GETMEASUREPARAMETRICITY returns 1 (Parametric).
			%
			% 1 = WeightedRichClub.GETMEASUREPARAMETRICITY() returns the measures parametricity (Parametric).
			%
			% See also getMeasureShape, getMeasureScope, getCompatibleGraphList.
			
			parametricity = Measure.PARAMETRIC;
		end
		function list = getCompatibleGraphList()
			%GETCOMPATIBLEGRAPHLIST returns the list of WeightedRichClub compatible graphs.
			%
			% LIST = WeightedRichClub.GETCOMPATIBLEGRAPHLIST() returns the list of compatible graphs.
			%
			% The compatible graphs are:
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help GraphWU">GraphWU</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%  <a href="matlab:help MultiplexWU">MultiplexWU</a>
			%
			% See also getCompatibleGraphNumber.
			
			list = { ...
				'GraphWU', ...
				'GraphWU', ...
				'MultiplexWU', ...
				'MultiplexWU', ...
				};
		end
		function n = getCompatibleGraphNumber()
			%GETCOMPATIBLEGRAPHNUMBER returns the number (4) of WeightedRichClub compatible graphs.
			%
			% 4 = WeightedRichClub.GETCOMPATIBLEGRAPHNUMBER() returns the measures number of compatible graphs.
			%
			% See also getCompatibleGraphList.
			
			n = Measure.getCompatibleGraphNumber('WeightedRichClub');
		end
	end
	methods % constructor
		function m = WeightedRichClub(varargin)
			% WeightedRichClub() creates a weighted rich-club.
			%
			% WeightedRichClub(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% WeightedRichClub(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of WeightedRichClub properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>4</strong> <strong>g</strong> 	G (data, item) is the measure graph.
			%  <strong>5</strong> <strong>m</strong> 	M (result, cell) is the weighted rich-club.
			%  <strong>6</strong> <strong>wrc_parameter</strong> 	WRC_PARAMETER (parameter, RVECTOR) is the threshold
			%
			% See also Category, Format, set, check.
			
			m = m@Strength(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = WeightedRichClub.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Strength.getPropNumber()
						value = conditioning@Strength(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop)
		
			switch prop
				case WeightedRichClub.M
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc
					L = g.layernumber();
					N = g.nodenumber();
					
					weighted_rich_club = cell(L, 1);
					directionality_type =  g.getDirectionalityType(L);
					weighted_rich_club_threshold = m.get('WRC_PARAMETER');
					assert(isnumeric(weighted_rich_club_threshold) == 1, ...
					    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
					    ['WeightedRichClub threshold must be a positive number ' ...
					    'while it is ' tostring(weighted_rich_club_threshold)])
					
					s_levels = abs(weighted_rich_club_threshold);
					    
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					   
					    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					
					        strength = calculateValue@Strength(m, prop);
					        st = strength{li};
					
					    else  % directed graphs
					
					        in_strength = InStrength('G', g).get('M');
					        out_strength = OutStrength('G', g).get('M');
					
					        st = (in_strength{li} + out_strength{li})/2;
					    end
					
					    weighted_rich_club_layer = zeros(1, 1, length(s_levels));
					    wrank = sort(Aii(:), 'descend');  % wrank contains the ranked weights of the network, with strongest connections on top
					    count = 1;
					    
					    for s = s_levels
					        low_rich_nodes = find(st < s);  % get lower rich nodes with strength < s
					        subAii = Aii;  % extract subnetwork of nodes >=s by removing nodes < s of Aii
					        subAii(low_rich_nodes, :) = [];  % remove rows
					        subAii(:, low_rich_nodes) = [];  % remove columns
					
					        Wr = sum(subAii(:));  % total weight of connections in subgraph > s
					        Er = length(find(subAii~=0));  % total number of connections in subgraph
					        wrank_r = wrank(1:1:Er);  % E>r number of connections with max weight in network
					        % Calculate weighted rich-club coefficient
					        weighted_rich_club_layer(1, 1, count) = Wr / sum(wrank_r);
					        count = count + 1;
					    end
					    weighted_rich_club_layer(isnan(weighted_rich_club_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with strength > s
					    weighted_rich_club(li) = {weighted_rich_club_layer};  % add rich club strength of layer li
					end
					value = weighted_rich_club;
					
				otherwise
					value = calculateValue@Strength(m, prop);
					
			end
		end
	end
end
