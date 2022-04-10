classdef SubjectFUN < Subject
	% SubjectFUN is a subject with functional matrix (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with a functional matrix (e.g. obtained from fMRI).
	%
	% The list of SubjectFUN properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the subject.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the subject.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the subject.
	%  <strong>4</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
	%  <strong>5</strong> <strong>fun</strong> 	FUN (data, matrix) is an adjacency matrix.
	%  <strong>6</strong> <strong>age</strong> 	age (data, scalar) is a scalar number containing the age of the subject.
	%  <strong>7</strong> <strong>sex</strong> 	sex (data, option) is an option containing the sex of the subject (female/male).
	%
	% SubjectFUN methods (constructor):
	% SubjectFUN - constructor
	%
	% SubjectFUN methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in subject with functional matrix/error.
	%  existsProp - checks whether property exists in subject with functional matrix/error.
	%  getPropNumber - returns the property number of subject with functional matrix.
	%  getProps - returns the property list of subject with functional matrix.
	%  getDescription - returns the description of the subject with functional matrix.
	%  getName - returns the name of the subject with functional matrix.
	%  getClass - returns the class of the subject with functional matrix.
	%  getGUIMenuExport - sets a figure menu.
	%  getGUIMenuImport - sets a figure menu.
	%
	% SubjectFUN methods:
	%  getPlotProp - returns a prop plot.
	%  tostring - string with information about the subject.
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
	% SubjectFUN methods (operators):
	%  isequal - determines whether two SubjectFUN are equal (values, locked)
	%
	% SubjectFUN methods (display):
	%  tostring - string with information about the SubjectFUN
	%  disp - displays information about the SubjectFUN
	%  tree - displays the element of SubjectFUN
	%
	% SubjectFUN method (element list):
	%  getElementList - returns a list with all subelements of SubjectFUN
	%
	% SubjectFUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the SubjectFUN
	%
	% SubjectFUN method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the SubjectFUN
	%
	% SubjectFUN methods (copy):
	%  copy - copies the SubjectFUN
	%  deepclone - deep-clones the SubjectFUN
	%  clone - clones the SubjectFUN
	%
	% SubjectFUN methods (inspection, Static):
	%  getClass - returns SubjectFUN
	%  getName - returns the name of SubjectFUN
	%  getDescription - returns the description of SubjectFUN
	%  getProps - returns the property list of SubjectFUN
	%  getPropNumber - returns the property number of SubjectFUN
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
	% SubjectFUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectFUN methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% SubjectFUN methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% SubjectFUN methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% SubjectFUN properties (Constant).
	%  BA - 4
	%  BA_TAG - 'ba'
	%  BA_CATEGORY - 'd'
	%  BA_FORMAT - 'it'
	%  FUN - 5
	%  FUN_TAG - 'fun'
	%  FUN_CATEGORY - 'd'
	%  FUN_FORMAT - 'nm'
	%  AGE - 6
	%  AGE_TAG - 'age'
	%  AGE_CATEGORY - 'd'
	%  AGE_FORMAT - 'nn'
	%  SEX - 7
	%  SEX_TAG - 'sex'
	%  SEX_CATEGORY - 'd'
	%  SEX_FORMAT - 'op'
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
	% See also Element, Subject.
	
	properties (Constant) % properties
		BA = Subject.getPropNumber() + 1;
		BA_TAG = 'ba';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		FUN = Subject.getPropNumber() + 2;
		FUN_TAG = 'fun';
		FUN_CATEGORY = Category.DATA;
		FUN_FORMAT = Format.MATRIX;
		
		AGE = Subject.getPropNumber() + 3;
		AGE_TAG = 'age';
		AGE_CATEGORY = Category.DATA;
		AGE_FORMAT = Format.SCALAR;
		
		SEX = Subject.getPropNumber() + 4;
		SEX_TAG = 'sex';
		SEX_CATEGORY = Category.DATA;
		SEX_FORMAT = Format.OPTION;
	end
	methods (Static) % inspection methods
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with functional matrix.
			%
			% CLASS = SubjectFUN.GETCLASS() returns the class 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with functional matrix SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectFUN') returns 'SubjectFUN'.
			%
			% See also getName, getDescription.
			
			sub_class = 'SubjectFUN';
		end
		function sub_name = getName()
			%GETNAME returns the name of the subject with functional matrix.
			%
			% NAME = SubjectFUN.GETNAME() returns the name of the 'subject with functional matrix'.
			%  Subject With Functional Matrix.
			%
			% Alternative forms to call this method are:
			%  NAME = SUB.GETNAME() returns the name of the subject with functional matrix SUB.
			%  NAME = Element.GETNAME(SUB) returns the name of 'SUB'.
			%  NAME = Element.GETNAME('SubjectFUN') returns the name of 'SubjectFUN'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			sub_name = 'Subject With Functional Matrix';
		end
		function sub_description = getDescription()
			%GETDESCRIPTION returns the description of the subject with functional matrix.
			%
			% STR = SubjectFUN.GETDESCRIPTION() returns the description of the 'subject with functional matrix'.
			%  which is:
			%
			%  Subject with a functional matrix (e.g. obtained from fMRI).
			%
			% Alternative forms to call this method are:
			%  STR = SUB.GETDESCRIPTION() returns the description of the subject with functional matrix SUB.
			%  STR = Element.GETDESCRIPTION(SUB) returns the description of 'SUB'.
			%  STR = Element.GETDESCRIPTION('SubjectFUN') returns the description of 'SubjectFUN'.
			%
			% See also getClass, getName.
			
			sub_description = [
				'Subject with a functional matrix (e.g. obtained from fMRI).' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with functional matrix.
			%
			% PROPS = SubjectFUN.GETPROPS() returns the property list of subject with functional matrix.
			%
			% PROPS = SubjectFUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with functional matrix SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectFUN'[, CATEGORY]) returns the property list of 'SubjectFUN'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Subject.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Subject.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Subject.getProps(Category.DATA)
						SubjectFUN.BA
						SubjectFUN.FUN
						SubjectFUN.AGE
						SubjectFUN.SEX
						];
				case Category.RESULT
					prop_list = [
						Subject.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Subject.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Subject.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Subject.getProps()
						SubjectFUN.BA
						SubjectFUN.FUN
						SubjectFUN.AGE
						SubjectFUN.SEX
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of subject with functional matrix.
			%
			% N = SubjectFUN.GETPROPNUMBER() returns the property number of subject with functional matrix.
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER() returns the property number of the subject with functional matrix SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectFUN') returns the property number of 'SubjectFUN'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectFUN, PROP) checks whether PROP exists for SubjectFUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SubjectFUN, PROP) throws error if PROP does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					SubjectFUN.existsProp(prop), ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectFUN.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectFUN, TAG) checks whether TAG exists for SubjectFUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SubjectFUN, TAG) throws error if TAG does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				subjectfun_tag_list = { 'id'  'label'  'notes'  'ba'  'fun'  'age'  'sex' };
				
				check = any(strcmpi(tag, subjectfun_tag_list));
			else
				assert( ...
					SubjectFUN.existsTag(tag), ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for SubjectFUN'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%  PROPERTY = SUB.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				subjectfun_tag_list = { 'id'  'label'  'notes'  'ba'  'fun'  'age'  'sex' };
				
				tag = pointer;
				SubjectFUN.existsTag(tag);
				
				prop = find(strcmpi(tag, subjectfun_tag_list));
			else % numeric
				prop = pointer;
				SubjectFUN.existsProp(prop);
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%  TAG = SUB.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				SubjectFUN.existsTag(tag);
			else % numeric
				prop = pointer;
				SubjectFUN.existsProp(prop);
				
				switch prop
					case SubjectFUN.BA
						tag = SubjectFUN.BA_TAG;
					case SubjectFUN.FUN
						tag = SubjectFUN.FUN_TAG;
					case SubjectFUN.AGE
						tag = SubjectFUN.AGE_TAG;
					case SubjectFUN.SEX
						tag = SubjectFUN.SEX_TAG;
					otherwise
						tag = getPropTag@Subject(prop);
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_category = SubjectFUN.BA_CATEGORY;
				case SubjectFUN.FUN
					prop_category = SubjectFUN.FUN_CATEGORY;
				case SubjectFUN.AGE
					prop_category = SubjectFUN.AGE_CATEGORY;
				case SubjectFUN.SEX
					prop_category = SubjectFUN.SEX_CATEGORY;
				otherwise
					prop_category = getPropCategory@Subject(prop);
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_format = SubjectFUN.BA_FORMAT;
				case SubjectFUN.FUN
					prop_format = SubjectFUN.FUN_FORMAT;
				case SubjectFUN.AGE
					prop_format = SubjectFUN.AGE_FORMAT;
				case SubjectFUN.SEX
					prop_format = SubjectFUN.SEX_FORMAT;
				otherwise
					prop_format = getPropFormat@Subject(prop);
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case SubjectFUN.FUN
					prop_description = 'FUN (data, matrix) is an adjacency matrix.';
				case SubjectFUN.AGE
					prop_description = 'age (data, scalar) is a scalar number containing the age of the subject.';
				case SubjectFUN.SEX
					prop_description = 'sex (data, option) is an option containing the sex of the subject (female/male).';
				otherwise
					prop_description = getPropDescription@Subject(prop);
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_settings = 'BrainAtlas';
				case SubjectFUN.FUN
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case SubjectFUN.AGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SubjectFUN.SEX
					prop_settings = {'Female', 'Male', 'unassigned'};
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					prop_default = BrainAtlas();
				case SubjectFUN.FUN
					prop_default = Format.getFormatDefault(Format.MATRIX, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.AGE
					prop_default = 0;
				case SubjectFUN.SEX
					prop_default = 'unassigned';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			prop_default = SubjectFUN.conditioning(prop, SubjectFUN.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			%  CHECK = SUB.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  SUB.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case SubjectFUN.BA
					check = Format.checkFormat(Format.ITEM, value, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.FUN
					check = Format.checkFormat(Format.MATRIX, value, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.AGE
					check = Format.checkFormat(Format.SCALAR, value, SubjectFUN.getPropSettings(prop));
				case SubjectFUN.SEX
					check = Format.checkFormat(Format.OPTION, value, SubjectFUN.getPropSettings(prop));
				otherwise
					check = checkProp@Subject(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SubjectFUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectFUN.getPropTag(prop) ' (' SubjectFUN.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function sub = SubjectFUN(varargin)
			% SubjectFUN() creates a subject with functional matrix.
			%
			% SubjectFUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectFUN(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SubjectFUN properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the subject.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the subject.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the subject.
			%  <strong>4</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
			%  <strong>5</strong> <strong>fun</strong> 	FUN (data, matrix) is an adjacency matrix.
			%  <strong>6</strong> <strong>age</strong> 	age (data, scalar) is a scalar number containing the age of the subject.
			%  <strong>7</strong> <strong>sex</strong> 	sex (data, option) is an option containing the sex of the subject (female/male).
			%
			% See also Category, Format, set, check.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Subject.getPropNumber()
						value = conditioning@Subject(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(sub, prop, value)
			check = true;
			msg = ['Error while checking' tostring(sub) ' ' sub.getPropTag(prop) '.'];
			
			switch prop
				case SubjectFUN.FUN
					br_number = sub.get('BA').get('BR_DICT').length();
					check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
					if check
					    msg = 'All ok!';
					else   
					    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
					end
					
				otherwise
					[check, msg] = checkValue@Subject(sub, prop, value);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(sub, prop, varargin)
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
				case SubjectFUN.FUN
					pr = PPSubjectFUN_FUN('EL', sub, 'PROP', SubjectFUN.FUN, varargin{:});
					
				otherwise
					pr = getPlotProp@Subject(sub, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			uimenu(menu_import, ...
			    'Label', 'Import TXT ...', ...
			    'Callback', {@cb_importer_TXT});
			function cb_importer_TXT(~, ~)
			    im = ImporterGroupSubjectFUN_TXT( ...
			        'ID', 'Import Group of SubjectCons from TXT', ...
			        'WAITBAR', true ...
			        );
			    im.uigetdir();
			    try
			        if isfolder(im.get('DIRECTORY'))
			            gr = pe.get('EL');
			            
			            assert( ...
			                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
			                [BRAPH2.STR ':SubjectFUN:' BRAPH2.BUG_FUNC], ...
			                'To import an element, all its properties must be unlocked.' ...
			                )
			            
			            gr_new = im.get('GR');
			            for prop = 1:1:gr.getPropNumber()
			                if gr.getPropCategory(prop) ~= Category.RESULT
			                    gr.set(prop, gr_new.get(prop))
			                end
			            end
			            
			            pe.reinit(gr_new);
			        end
			    catch e
			        warndlg(['Please, select a valid input Group of SubjectCons in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			uimenu(menu_import, ...
			    'Label', 'Import XLS ...', ...
			    'Callback', {@cb_importer_XLS});
			function cb_importer_XLS(~, ~)
			    im = ImporterGroupSubjectFUN_XLS( ...
			        'ID', 'Import Group of SubjectCons from XLS', ...
			        'WAITBAR', true ...
			        );
			    im.uigetdir();
			    try
			        if isfolder(im.get('DIRECTORY'))
			            gr = pe.get('EL');
			            
			            assert( ...
			                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
			                [BRAPH2.STR ':SubjectFUN:' BRAPH2.BUG_FUNC], ...
			                'To import an element, all its properties must be unlocked.' ...
			                )
			            
			            gr_new = im.get('GR');
			            for prop = 1:1:gr.getPropNumber()
			                if gr.getPropCategory(prop) ~= Category.RESULT
			                    gr.set(prop, gr_new.get(prop))
			                end
			            end
			            
			            pe.reinit(gr_new);
			        end
			    catch e
			        warndlg(['Please, select a valid input Group of SubjectCons in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			uimenu(menu_export, ...
			    'Label', 'Export TXT ...', ...
			    'Callback', {@cb_exporter_TXT});
			function cb_exporter_TXT(~, ~)
			    ex = ExporterGroupSubjectFUN_TXT( ...
			        'ID', 'Export Brain Group of SubjectCons to TXT', ...
			        'GR', el.copy(), ...
			        'WAITBAR', true ...
			        );
			    ex.uigetdir()
			    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_TXT.getPropDefault('DIRECTORY'))
			        ex.get('SAVE');
			    end
			end
			
			uimenu(menu_export, ...
			    'Label', 'Export XLS ...', ...
			    'Callback', {@cb_exporter_XLS});
			function cb_exporter_XLS(~, ~)
			    ex = ExporterGroupSubjectFUN_XLS( ...
			        'ID', 'Export Brain Group of SubjectCons to XLS', ...
			        'GR', el.copy(), ...
			        'WAITBAR', true ...
			        );
			    ex.uigetdir()
			    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_XLS.getPropDefault('DIRECTORY'))
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
