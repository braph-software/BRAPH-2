classdef AnalyzeEnsemble < Element
	% AnalyzeEnsemble is a ensemble-based graph analysis.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.
	% Instances of this class should not be created. 
	% Use one of its subclasses instead.
	%
	% The list of AnalyzeEnsemble properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
	%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class.
	%  <strong>5</strong> <strong>g_dict</strong> 	G_DICT (result, idict) is the graph ensemble obtained from this analysis.
	%  <strong>6</strong> <strong>me_dict</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%
	% AnalyzeEnsemble methods (constructor):
	% AnalyzeEnsemble - constructor
	%
	% AnalyzeEnsemble methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in ensemble-based graph analysis/error.
	%  existsProp - checks whether property exists in ensemble-based graph analysis/error.
	%  getPropNumber - returns the property number of ensemble-based graph analysis.
	%  getProps - returns the property list of ensemble-based graph analysis.
	%  getDescription - returns the description of the ensemble-based graph analysis.
	%  getName - returns the name of the ensemble-based graph analysis.
	%  getClass - returns the class of the ensemble-based graph analysis.
	%
	% AnalyzeEnsemble methods:
	%  getPPCompareEnsemble_CPDict - returns the comparison ensemble plot panel compatible with the analysis.
	%  getMeasureEnsemble - measure.
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
	% AnalyzeEnsemble methods (operators):
	%  isequal - determines whether two AnalyzeEnsemble are equal (values, locked)
	%
	% AnalyzeEnsemble methods (display):
	%  tostring - string with information about the AnalyzeEnsemble
	%  disp - displays information about the AnalyzeEnsemble
	%  tree - displays the element of AnalyzeEnsemble
	%
	% AnalyzeEnsemble method (element list):
	%  getElementList - returns a list with all subelements of AnalyzeEnsemble
	%
	% AnalyzeEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the AnalyzeEnsemble
	%
	% AnalyzeEnsemble method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the AnalyzeEnsemble
	%
	% AnalyzeEnsemble methods (copy):
	%  copy - copies the AnalyzeEnsemble
	%  deepclone - deep-clones the AnalyzeEnsemble
	%  clone - clones the AnalyzeEnsemble
	%
	% AnalyzeEnsemble methods (inspection, Static):
	%  getClass - returns AnalyzeEnsemble
	%  getName - returns the name of AnalyzeEnsemble
	%  getDescription - returns the description of AnalyzeEnsemble
	%  getProps - returns the property list of AnalyzeEnsemble
	%  getPropNumber - returns the property number of AnalyzeEnsemble
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
	% AnalyzeEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% AnalyzeEnsemble methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% AnalyzeEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% AnalyzeEnsemble properties (Constant).
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
	%  GR - 4
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  G_DICT - 5
	%  G_DICT_TAG - 'g_dict'
	%  G_DICT_CATEGORY - 'r'
	%  G_DICT_FORMAT - 'di'
	%  ME_DICT - 6
	%  ME_DICT_TAG - 'me_dict'
	%  ME_DICT_CATEGORY - 'r'
	%  ME_DICT_FORMAT - 'di'
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
	% See also CompareEnsemble.
	
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
		
		GR = 4;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		G_DICT = 5;
		G_DICT_TAG = 'g_dict';
		G_DICT_CATEGORY = Category.RESULT;
		G_DICT_FORMAT = Format.IDICT;
		
		ME_DICT = 6;
		ME_DICT_TAG = 'me_dict';
		ME_DICT_CATEGORY = Category.RESULT;
		ME_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function a_class = getClass()
			%GETCLASS returns the class of the ensemble-based graph analysis.
			%
			% CLASS = AnalyzeEnsemble.GETCLASS() returns the class 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the ensemble-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble') returns 'AnalyzeEnsemble'.
			%
			% See also getName, getDescription.
			
			a_class = 'AnalyzeEnsemble';
		end
		function a_name = getName()
			%GETNAME returns the name of the ensemble-based graph analysis.
			%
			% NAME = AnalyzeEnsemble.GETNAME() returns the name of the 'ensemble-based graph analysis'.
			%  Ensemble-Based Graph Analysis.
			%
			% Alternative forms to call this method are:
			%  NAME = A.GETNAME() returns the name of the ensemble-based graph analysis A.
			%  NAME = Element.GETNAME(A) returns the name of 'A'.
			%  NAME = Element.GETNAME('AnalyzeEnsemble') returns the name of 'AnalyzeEnsemble'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			a_name = 'Ensemble-Based Graph Analysis';
		end
		function a_description = getDescription()
			%GETDESCRIPTION returns the description of the ensemble-based graph analysis.
			%
			% STR = AnalyzeEnsemble.GETDESCRIPTION() returns the description of the 'ensemble-based graph analysis'.
			%  which is:
			%
			%  AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.
			%  Instances of this class should not be created. 
			%  Use one of its subclasses instead.
			%
			% Alternative forms to call this method are:
			%  STR = A.GETDESCRIPTION() returns the description of the ensemble-based graph analysis A.
			%  STR = Element.GETDESCRIPTION(A) returns the description of 'A'.
			%  STR = Element.GETDESCRIPTION('AnalyzeEnsemble') returns the description of 'AnalyzeEnsemble'.
			%
			% See also getClass, getName.
			
			a_description = [
				'AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.' ...
				'Instances of this class should not be created. ' ...
				'Use one of its subclasses instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based graph analysis.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS() returns the property list of ensemble-based graph analysis.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the ensemble-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						AnalyzeEnsemble.LABEL
						AnalyzeEnsemble.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						AnalyzeEnsemble.ID
						AnalyzeEnsemble.GR
						];
				case Category.RESULT
					prop_list = [
						AnalyzeEnsemble.G_DICT
						AnalyzeEnsemble.ME_DICT
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						AnalyzeEnsemble.ID
						AnalyzeEnsemble.LABEL
						AnalyzeEnsemble.NOTES
						AnalyzeEnsemble.GR
						AnalyzeEnsemble.G_DICT
						AnalyzeEnsemble.ME_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of ensemble-based graph analysis.
			%
			% N = AnalyzeEnsemble.GETPROPNUMBER() returns the property number of ensemble-based graph analysis.
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER() returns the property number of the ensemble-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble') returns the property number of 'AnalyzeEnsemble'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble, PROP) checks whether PROP exists for AnalyzeEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					AnalyzeEnsemble.existsProp(prop), ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble, TAG) checks whether TAG exists for AnalyzeEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzeensemble_tag_list = { 'id'  'label'  'notes'  'gr'  'g_dict'  'me_dict' };
				
				check = any(strcmpi(tag, analyzeensemble_tag_list));
			else
				assert( ...
					AnalyzeEnsemble.existsTag(tag), ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				analyzeensemble_tag_list = { 'id'  'label'  'notes'  'gr'  'g_dict'  'me_dict' };
				
				tag = pointer;
				AnalyzeEnsemble.existsTag(tag);
				
				prop = find(strcmpi(tag, analyzeensemble_tag_list));
			else % numeric
				prop = pointer;
				AnalyzeEnsemble.existsProp(prop);
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				AnalyzeEnsemble.existsTag(tag);
			else % numeric
				prop = pointer;
				AnalyzeEnsemble.existsProp(prop);
				
				switch prop
					case AnalyzeEnsemble.ID
						tag = AnalyzeEnsemble.ID_TAG;
					case AnalyzeEnsemble.LABEL
						tag = AnalyzeEnsemble.LABEL_TAG;
					case AnalyzeEnsemble.NOTES
						tag = AnalyzeEnsemble.NOTES_TAG;
					case AnalyzeEnsemble.GR
						tag = AnalyzeEnsemble.GR_TAG;
					case AnalyzeEnsemble.G_DICT
						tag = AnalyzeEnsemble.G_DICT_TAG;
					case AnalyzeEnsemble.ME_DICT
						tag = AnalyzeEnsemble.ME_DICT_TAG;
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					prop_category = AnalyzeEnsemble.ID_CATEGORY;
				case AnalyzeEnsemble.LABEL
					prop_category = AnalyzeEnsemble.LABEL_CATEGORY;
				case AnalyzeEnsemble.NOTES
					prop_category = AnalyzeEnsemble.NOTES_CATEGORY;
				case AnalyzeEnsemble.GR
					prop_category = AnalyzeEnsemble.GR_CATEGORY;
				case AnalyzeEnsemble.G_DICT
					prop_category = AnalyzeEnsemble.G_DICT_CATEGORY;
				case AnalyzeEnsemble.ME_DICT
					prop_category = AnalyzeEnsemble.ME_DICT_CATEGORY;
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					prop_format = AnalyzeEnsemble.ID_FORMAT;
				case AnalyzeEnsemble.LABEL
					prop_format = AnalyzeEnsemble.LABEL_FORMAT;
				case AnalyzeEnsemble.NOTES
					prop_format = AnalyzeEnsemble.NOTES_FORMAT;
				case AnalyzeEnsemble.GR
					prop_format = AnalyzeEnsemble.GR_FORMAT;
				case AnalyzeEnsemble.G_DICT
					prop_format = AnalyzeEnsemble.G_DICT_FORMAT;
				case AnalyzeEnsemble.ME_DICT
					prop_format = AnalyzeEnsemble.ME_DICT_FORMAT;
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis.';
				case AnalyzeEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis.';
				case AnalyzeEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis.';
				case AnalyzeEnsemble.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class.';
				case AnalyzeEnsemble.G_DICT
					prop_description = 'G_DICT (result, idict) is the graph ensemble obtained from this analysis.';
				case AnalyzeEnsemble.ME_DICT
					prop_description = 'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.';
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeEnsemble.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeEnsemble.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case AnalyzeEnsemble.GR
					prop_settings = 'Group';
				case AnalyzeEnsemble.G_DICT
					prop_settings = 'Graph';
				case AnalyzeEnsemble.ME_DICT
					prop_settings = 'MeasureEnsemble';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.GR
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.G_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ME_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemble.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble.conditioning(prop, AnalyzeEnsemble.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.ID
					check = Format.checkFormat(Format.STRING, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.LABEL
					check = Format.checkFormat(Format.STRING, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.NOTES
					check = Format.checkFormat(Format.STRING, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.GR
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.G_DICT
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ME_DICT
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble.getPropTag(prop) ' (' AnalyzeEnsemble.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function a = AnalyzeEnsemble(varargin)
			% AnalyzeEnsemble() creates a ensemble-based graph analysis.
			%
			% AnalyzeEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph analysis.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph analysis.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis.
			%  <strong>4</strong> <strong>gr</strong> 	GR (data, item) is the subject group, which also defines the subject class.
			%  <strong>5</strong> <strong>g_dict</strong> 	G_DICT (result, idict) is the graph ensemble obtained from this analysis.
			%  <strong>6</strong> <strong>me_dict</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%
			% See also Category, Format, set, check.
			
			a = a@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop)
		
			switch prop
				case AnalyzeEnsemble.G_DICT
					rng(a.getPropSeed(AnalyzeEnsemble.G_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'Graph');
					
				case AnalyzeEnsemble.ME_DICT
					rng(a.getPropSeed(AnalyzeEnsemble.ME_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', 4);
					
				otherwise
					value = calculateValue@Element(a, prop);
					
			end
		end
	end
	methods % methods
		function me = getMeasureEnsemble(a, measure_class, varargin)
		    %GETMEASURE returns measure.
		    %
		    % ME = GETMEASURE(A, MEASURE_CLASS) checks if the measure ensemble exists in the
		    %  property ME_DICT. If not it creates a new measure M of class MEASURE_CLASS
		    %  with properties defined by the graph settings. The user must call
		    %  getValue() for the new measure M to retrieve the value of measure M.
		
		    g = a.get('G_DICT').getItem(1);  % works if all graphs are the same
		    m_list = Graph.getCompatibleMeasureList(g);
		    
		    assert( ...
		        contains(measure_class, m_list), ...
		        [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT], ...
		        [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT ' '], ...
		        [a.getClass() ' utilizes Graphs of type ' g.getClass() '.' measure_class ' is not a compatible Measure with ' g.getClass() '. Please use Graph function getCompatibleMeasureList for more information.']);
		    
		    me_dict = a.memorize('ME_DICT');
		    if me_dict.containsKey(measure_class)
		        me = me_dict.getItem(measure_class);
		    else
		        me = MeasureEnsemble( ...
		            'ID', measure_class, ...
		            'A', a, ...
		            'MEASURE', measure_class, ...
		            'MEASUREPARAM', eval([measure_class '()']), ...
		            varargin{:} ...
		            );
		        me_dict.add(me);
		    end
		end
		function pr = getPPCompareEnsemble_CPDict(a, varargin)
		    %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
		    %
		    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison ensemble plot panel
		    %  that is compatible with the analyze ensemble.
		    %
		    % See also CompareEnsemble.
		
		    pr = PropPlotIDict(varargin{:});
		end
	end
	methods % GUI
		function pr = getPlotProp(a, prop, varargin)
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
				case AnalyzeEnsemble.NOTES
					pr = PlotPropString('EL', a, 'PROP', AnalyzeEnsemble.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(a, prop, varargin{:});
					
			end
		end
	end
end
