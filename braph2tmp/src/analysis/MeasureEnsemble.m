classdef MeasureEnsemble < Element
	% MeasureEnsemble is a graph ensemble measure.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Measure provides the methods necessary for a graph ensemble measure.
	%
	% The list of MeasureEnsemble properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph ensemble measure.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph ensemble measure.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph ensemble measure.
	%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
	%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters. 
	%  <strong>6</strong> <strong>a</strong> 	A (data, item) is the ensemble-based graph analysis.
	%  <strong>7</strong> <strong>m</strong> 	M (result, cell) is the measure result.
	%
	% MeasureEnsemble methods (constructor):
	% MeasureEnsemble - constructor
	%
	% MeasureEnsemble methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph ensemble measure/error.
	%  existsProp - checks whether property exists in graph ensemble measure/error.
	%  getPropNumber - returns the property number of graph ensemble measure.
	%  getProps - returns the property list of graph ensemble measure.
	%  getDescription - returns the description of the graph ensemble measure.
	%  getName - returns the name of the graph ensemble measure.
	%  getClass - returns the class of the graph ensemble measure.
	%
	% MeasureEnsemble methods:
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
	% MeasureEnsemble methods (operators):
	%  isequal - determines whether two MeasureEnsemble are equal (values, locked)
	%
	% MeasureEnsemble methods (display):
	%  tostring - string with information about the MeasureEnsemble
	%  disp - displays information about the MeasureEnsemble
	%  tree - displays the element of MeasureEnsemble
	%
	% MeasureEnsemble method (element list):
	%  getElementList - returns a list with all subelements of MeasureEnsemble
	%
	% MeasureEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the MeasureEnsemble
	%
	% MeasureEnsemble method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the MeasureEnsemble
	%
	% MeasureEnsemble methods (copy):
	%  copy - copies the MeasureEnsemble
	%  deepclone - deep-clones the MeasureEnsemble
	%  clone - clones the MeasureEnsemble
	%
	% MeasureEnsemble methods (inspection, Static):
	%  getClass - returns MeasureEnsemble
	%  getName - returns the name of MeasureEnsemble
	%  getDescription - returns the description of MeasureEnsemble
	%  getProps - returns the property list of MeasureEnsemble
	%  getPropNumber - returns the property number of MeasureEnsemble
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
	% MeasureEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemble methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% MeasureEnsemble methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% MeasureEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% MeasureEnsemble properties (Constant).
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
	%  MEASURE - 4
	%  MEASURE_TAG - 'measure'
	%  MEASURE_CATEGORY - 'd'
	%  MEASURE_FORMAT - 'st'
	%  MEASUREPARAM - 5
	%  MEASUREPARAM_TAG - 'measureparam'
	%  MEASUREPARAM_CATEGORY - 'd'
	%  MEASUREPARAM_FORMAT - 'it'
	%  A - 6
	%  A_TAG - 'a'
	%  A_CATEGORY - 'd'
	%  A_FORMAT - 'it'
	%  M - 7
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
	%
	% See also AnalyzeEnsemble, CompareEnsemble.
	
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = 2;
		LABEL_TAG = 'label';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = 3;
		NOTES_TAG = 'notes';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		MEASURE = 4;
		MEASURE_TAG = 'measure';
		MEASURE_CATEGORY = Category.DATA;
		MEASURE_FORMAT = Format.STRING;
		
		MEASUREPARAM = 5;
		MEASUREPARAM_TAG = 'measureparam';
		MEASUREPARAM_CATEGORY = Category.DATA;
		MEASUREPARAM_FORMAT = Format.ITEM;
		
		A = 6;
		A_TAG = 'a';
		A_CATEGORY = Category.DATA;
		A_FORMAT = Format.ITEM;
		
		M = 7;
		M_TAG = 'm';
		M_CATEGORY = Category.RESULT;
		M_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function me_class = getClass()
			%GETCLASS returns the class of the graph ensemble measure.
			%
			% CLASS = MeasureEnsemble.GETCLASS() returns the class 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ME.GETCLASS() returns the class of the graph ensemble measure ME.
			%  CLASS = Element.GETCLASS(ME) returns the class of 'ME'.
			%  CLASS = Element.GETCLASS('MeasureEnsemble') returns 'MeasureEnsemble'.
			%
			% See also getName, getDescription.
			
			me_class = 'MeasureEnsemble';
		end
		function me_name = getName()
			%GETNAME returns the name of the graph ensemble measure.
			%
			% NAME = MeasureEnsemble.GETNAME() returns the name of the 'graph ensemble measure'.
			%  Graph Ensemble Measure.
			%
			% Alternative forms to call this method are:
			%  NAME = ME.GETNAME() returns the name of the graph ensemble measure ME.
			%  NAME = Element.GETNAME(ME) returns the name of 'ME'.
			%  NAME = Element.GETNAME('MeasureEnsemble') returns the name of 'MeasureEnsemble'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			me_name = 'Graph Ensemble Measure';
		end
		function me_description = getDescription()
			%GETDESCRIPTION returns the description of the graph ensemble measure.
			%
			% STR = MeasureEnsemble.GETDESCRIPTION() returns the description of the 'graph ensemble measure'.
			%  which is:
			%
			%  Measure provides the methods necessary for a graph ensemble measure.
			%
			% Alternative forms to call this method are:
			%  STR = ME.GETDESCRIPTION() returns the description of the graph ensemble measure ME.
			%  STR = Element.GETDESCRIPTION(ME) returns the description of 'ME'.
			%  STR = Element.GETDESCRIPTION('MeasureEnsemble') returns the description of 'MeasureEnsemble'.
			%
			% See also getClass, getName.
			
			me_description = [
				'Measure provides the methods necessary for a graph ensemble measure.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph ensemble measure.
			%
			% PROPS = MeasureEnsemble.GETPROPS() returns the property list of graph ensemble measure.
			%
			% PROPS = MeasureEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ME.GETPROPS([CATEGORY]) returns the property list of the graph ensemble measure ME.
			%  PROPS = Element.GETPROPS(ME[, CATEGORY]) returns the property list of 'ME'.
			%  PROPS = Element.GETPROPS('MeasureEnsemble'[, CATEGORY]) returns the property list of 'MeasureEnsemble'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						MeasureEnsemble.LABEL
						MeasureEnsemble.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						MeasureEnsemble.ID
						MeasureEnsemble.MEASURE
						MeasureEnsemble.MEASUREPARAM
						MeasureEnsemble.A
						];
				case Category.RESULT
					prop_list = [
						MeasureEnsemble.M
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						MeasureEnsemble.ID
						MeasureEnsemble.LABEL
						MeasureEnsemble.NOTES
						MeasureEnsemble.MEASURE
						MeasureEnsemble.MEASUREPARAM
						MeasureEnsemble.A
						MeasureEnsemble.M
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph ensemble measure.
			%
			% N = MeasureEnsemble.GETPROPNUMBER() returns the property number of graph ensemble measure.
			%
			% Alternative forms to call this method are:
			%  N = ME.GETPROPNUMBER() returns the property number of the graph ensemble measure ME.
			%  N = Element.GETPROPNUMBER(ME) returns the property number of 'ME'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemble') returns the property number of 'MeasureEnsemble'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSPROP(PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(ME, PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemble, PROP) checks whether PROP exists for MeasureEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSPROP(PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(ME, PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemble, PROP) throws error if PROP does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					MeasureEnsemble.existsProp(prop), ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemble.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSTAG(TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(ME, TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemble, TAG) checks whether TAG exists for MeasureEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSTAG(TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(ME, TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemble, TAG) throws error if TAG does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				measureensemble_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'a'  'm' };
				
				check = any(strcmpi(tag, measureensemble_tag_list));
			else
				assert( ...
					MeasureEnsemble.existsTag(tag), ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemble'] ...
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
			%  PROPERTY = ME.GETPROPPROP(POINTER) returns property number of POINTER of ME.
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%  PROPERTY = ME.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				measureensemble_tag_list = { 'id'  'label'  'notes'  'measure'  'measureparam'  'a'  'm' };
				
				tag = pointer;
				MeasureEnsemble.existsTag(tag);
				
				prop = find(strcmpi(tag, measureensemble_tag_list));
			else % numeric
				prop = pointer;
				MeasureEnsemble.existsProp(prop);
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
			%  TAG = ME.GETPROPTAG(POINTER) returns tag of POINTER of ME.
			%  TAG = Element.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%  TAG = ME.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				MeasureEnsemble.existsTag(tag);
			else % numeric
				prop = pointer;
				MeasureEnsemble.existsProp(prop);
				
				switch prop
					case MeasureEnsemble.ID
						tag = MeasureEnsemble.ID_TAG;
					case MeasureEnsemble.LABEL
						tag = MeasureEnsemble.LABEL_TAG;
					case MeasureEnsemble.NOTES
						tag = MeasureEnsemble.NOTES_TAG;
					case MeasureEnsemble.MEASURE
						tag = MeasureEnsemble.MEASURE_TAG;
					case MeasureEnsemble.MEASUREPARAM
						tag = MeasureEnsemble.MEASUREPARAM_TAG;
					case MeasureEnsemble.A
						tag = MeasureEnsemble.A_TAG;
					case MeasureEnsemble.M
						tag = MeasureEnsemble.M_TAG;
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
			%  CATEGORY = ME.GETPROPCATEGORY(POINTER) returns category of POINTER of ME.
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%  CATEGORY = ME.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					prop_category = MeasureEnsemble.ID_CATEGORY;
				case MeasureEnsemble.LABEL
					prop_category = MeasureEnsemble.LABEL_CATEGORY;
				case MeasureEnsemble.NOTES
					prop_category = MeasureEnsemble.NOTES_CATEGORY;
				case MeasureEnsemble.MEASURE
					prop_category = MeasureEnsemble.MEASURE_CATEGORY;
				case MeasureEnsemble.MEASUREPARAM
					prop_category = MeasureEnsemble.MEASUREPARAM_CATEGORY;
				case MeasureEnsemble.A
					prop_category = MeasureEnsemble.A_CATEGORY;
				case MeasureEnsemble.M
					prop_category = MeasureEnsemble.M_CATEGORY;
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
			%  FORMAT = ME.GETPROPFORMAT(POINTER) returns format of POINTER of ME.
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%  FORMAT = ME.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					prop_format = MeasureEnsemble.ID_FORMAT;
				case MeasureEnsemble.LABEL
					prop_format = MeasureEnsemble.LABEL_FORMAT;
				case MeasureEnsemble.NOTES
					prop_format = MeasureEnsemble.NOTES_FORMAT;
				case MeasureEnsemble.MEASURE
					prop_format = MeasureEnsemble.MEASURE_FORMAT;
				case MeasureEnsemble.MEASUREPARAM
					prop_format = MeasureEnsemble.MEASUREPARAM_FORMAT;
				case MeasureEnsemble.A
					prop_format = MeasureEnsemble.A_FORMAT;
				case MeasureEnsemble.M
					prop_format = MeasureEnsemble.M_FORMAT;
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
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ME.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph ensemble measure.';
				case MeasureEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph ensemble measure.';
				case MeasureEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph ensemble measure.';
				case MeasureEnsemble.MEASURE
					prop_description = 'MEASURE (data, string) is the measure class.';
				case MeasureEnsemble.MEASUREPARAM
					prop_description = 'MEASUREPARAM(data, item) provides the measure parameters. ';
				case MeasureEnsemble.A
					prop_description = 'A (data, item) is the ensemble-based graph analysis.';
				case MeasureEnsemble.M
					prop_description = 'M (result, cell) is the measure result.';
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
			%  SETTINGS = ME.GETPROPSETTINGS(POINTER) returns settings of POINTER of ME.
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%  SETTINGS = ME.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case MeasureEnsemble.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case MeasureEnsemble.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case MeasureEnsemble.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case MeasureEnsemble.MEASUREPARAM
					prop_settings = 'Measure';
				case MeasureEnsemble.A
					prop_settings = 'AnalyzeEnsemble';
				case MeasureEnsemble.M
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					prop_default = Format.getFormatDefault(Format.STRING, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.MEASUREPARAM
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.A
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.M
					prop_default = Format.getFormatDefault(Format.CELL, MeasureEnsemble.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			prop_default = MeasureEnsemble.conditioning(prop, MeasureEnsemble.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ME.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ME.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ME.
			%  CHECK = Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			%  CHECK = ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			% 
			% ME.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ME.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.ID
					check = Format.checkFormat(Format.STRING, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.LABEL
					check = Format.checkFormat(Format.STRING, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.NOTES
					check = Format.checkFormat(Format.STRING, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.MEASURE
					check = Format.checkFormat(Format.STRING, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.MEASUREPARAM
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.A
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.M
					check = Format.checkFormat(Format.CELL, value, MeasureEnsemble.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemble.getPropTag(prop) ' (' MeasureEnsemble.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function me = MeasureEnsemble(varargin)
			% MeasureEnsemble() creates a graph ensemble measure.
			%
			% MeasureEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemble(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasureEnsemble properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph ensemble measure.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph ensemble measure.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph ensemble measure.
			%  <strong>4</strong> <strong>measure</strong> 	MEASURE (data, string) is the measure class.
			%  <strong>5</strong> <strong>measureparam</strong> 	MEASUREPARAM(data, item) provides the measure parameters. 
			%  <strong>6</strong> <strong>a</strong> 	A (data, item) is the ensemble-based graph analysis.
			%  <strong>7</strong> <strong>m</strong> 	M (result, cell) is the measure result.
			%
			% See also Category, Format, set, check.
			
			me = me@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(me, prop)
		
			switch prop
				case MeasureEnsemble.M
					rng(me.getPropSeed(MeasureEnsemble.M), 'twister')
					
					core_measure = me.get('MEASUREPARAM');
					% get parameters from core measure
					j = 1;
					varargin = {};
					if Measure.getPropNumber() ~= core_measure.getPropNumber()
					    for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
					        if ~isa(core_measure.getr(i), 'NoValue')
					            varargin{j} = core_measure.getPropTag(i);
					            varargin{j + 1} = core_measure.getr(i);
					        end
					        j = j + 2;
					    end
					    varargin = varargin(~cellfun('isempty', varargin));
					end
					
					m_list = cellfun(@(x) x.getMeasure(me.get('MEASURE'), varargin{:}).get('M'), me.get('A').get('G_DICT').getItems, 'UniformOutput', false);
					
					if isempty(m_list)
					    m_av = {};
					else
					    m_av = cell(size(m_list{1}));
					    for i = 1:1:size(m_list{1}, 1)
					        for j = 1:1:size(m_list{1}, 2)
					            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
					            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
					        end
					    end
					end
					
					value = m_av;
					
				otherwise
					value = calculateValue@Element(me, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(me, prop, varargin)
			%GETPLOTPROP returns a prop plot.
			%
			% PR = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
			%
			% PR = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
			%
			% See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
			%  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
			%  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.
			
			switch prop
				case MeasureEnsemble.NOTES
					pr = PlotPropString('EL', me, 'PROP', MeasureEnsemble.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case MeasureEnsemble.M
					pr = PPMeasureEnsemble_M('EL', me, 'PROP', MeasureEnsemble.M, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(me, prop, varargin{:});
					
			end
		end
	end
end
