classdef ImporterGroupSubjectCON_FUN_MP_XLS < Importer
	% ImporterGroupSubjectCON_FUN_MP_XLS imports a group of subjects with connectivity data from a series of XLS file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS imports a group of subjects with connectivity data from a series of XLS file and their covariates (optional) from another XLS file.
	% All these files must be in the same folder; also, no other files should be in the folder.
	% Each file contains a table of values corresponding to the adjacency matrix.
	% The XLS file containing the covariates must be inside another folder in the same group directory 
	% and consists of the following columns:
	% Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
	% The first row contains the headers and each subsequent row the values for each subject.
	%
	% The list of ImporterGroupSubjectCON_FUN_MP_XLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>directory_con</strong> 	DIRECTORY_CON (data, string) is the directory containing the CON_FUN_MP subject group files of CON type  from which to load the subject group.
	%  <strong>6</strong> <strong>directory_fun</strong> 	DIRECTORY_FUN (data, string) is the directory containing the CON_FUN_MP subject group files of FUN type from which to load the subject group.
	%  <strong>7</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
	%  <strong>8</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with connectivity data.
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (constructor):
	% ImporterGroupSubjectCON_FUN_MP_XLS - constructor
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer of CON_FUN_MP subject group from XLS/error.
	%  existsProp - checks whether property exists in importer of CON_FUN_MP subject group from XLS/error.
	%  getPropNumber - returns the property number of importer of CON_FUN_MP subject group from XLS.
	%  getProps - returns the property list of importer of CON_FUN_MP subject group from XLS.
	%  getDescription - returns the description of the importer of CON_FUN_MP subject group from XLS.
	%  getName - returns the name of the importer of CON_FUN_MP subject group from XLS.
	%  getClass - returns the class of the importer of CON_FUN_MP subject group from XLS.
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods:
	%  uigetdir - R opens a dialog box to set the directory from where to load the XLS files of the CON_FUN_MP subject group.
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
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (operators):
	%  isequal - determines whether two ImporterGroupSubjectCON_FUN_MP_XLS are equal (values, locked)
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (display):
	%  tostring - string with information about the ImporterGroupSubjectCON_FUN_MP_XLS
	%  disp - displays information about the ImporterGroupSubjectCON_FUN_MP_XLS
	%  tree - displays the element of ImporterGroupSubjectCON_FUN_MP_XLS
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS method (element list):
	%  getElementList - returns a list with all subelements of ImporterGroupSubjectCON_FUN_MP_XLS
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ImporterGroupSubjectCON_FUN_MP_XLS
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ImporterGroupSubjectCON_FUN_MP_XLS
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (copy):
	%  copy - copies the ImporterGroupSubjectCON_FUN_MP_XLS
	%  deepclone - deep-clones the ImporterGroupSubjectCON_FUN_MP_XLS
	%  clone - clones the ImporterGroupSubjectCON_FUN_MP_XLS
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (inspection, Static):
	%  getClass - returns ImporterGroupSubjectCON_FUN_MP_XLS
	%  getName - returns the name of ImporterGroupSubjectCON_FUN_MP_XLS
	%  getDescription - returns the description of ImporterGroupSubjectCON_FUN_MP_XLS
	%  getProps - returns the property list of ImporterGroupSubjectCON_FUN_MP_XLS
	%  getPropNumber - returns the property number of ImporterGroupSubjectCON_FUN_MP_XLS
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
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ImporterGroupSubjectCON_FUN_MP_XLS properties (Constant).
	%  DIRECTORY_CON - 5
	%  DIRECTORY_CON_TAG - 'directory_con'
	%  DIRECTORY_CON_CATEGORY - 'd'
	%  DIRECTORY_CON_FORMAT - 'st'
	%  DIRECTORY_FUN - 6
	%  DIRECTORY_FUN_TAG - 'directory_fun'
	%  DIRECTORY_FUN_CATEGORY - 'd'
	%  DIRECTORY_FUN_FORMAT - 'st'
	%  BA - 7
	%  BA_TAG - 'ba'
	%  BA_CATEGORY - 'd'
	%  BA_FORMAT - 'it'
	%  GR - 8
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'r'
	%  GR_FORMAT - 'it'
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
	%  WAITBAR - 4
	%  WAITBAR_TAG - 'waitbar'
	%  WAITBAR_CATEGORY - 'm'
	%  WAITBAR_FORMAT - 'lo'
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
	% See also Element, Importer, ExporterGroupSubjectCON_XLS.
	
	properties (Constant) % properties
		DIRECTORY_CON = Importer.getPropNumber() + 1;
		DIRECTORY_CON_TAG = 'directory_con';
		DIRECTORY_CON_CATEGORY = Category.DATA;
		DIRECTORY_CON_FORMAT = Format.STRING;
		
		DIRECTORY_FUN = Importer.getPropNumber() + 2;
		DIRECTORY_FUN_TAG = 'directory_fun';
		DIRECTORY_FUN_CATEGORY = Category.DATA;
		DIRECTORY_FUN_FORMAT = Format.STRING;
		
		BA = Importer.getPropNumber() + 3;
		BA_TAG = 'ba';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		GR = Importer.getPropNumber() + 4;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function im_class = getClass()
			%GETCLASS returns the class of the importer of CON_FUN_MP subject group from XLS.
			%
			% CLASS = ImporterGroupSubjectCON_FUN_MP_XLS.GETCLASS() returns the class 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of CON_FUN_MP subject group from XLS IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectCON_FUN_MP_XLS') returns 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% See also getName, getDescription.
			
			im_class = 'ImporterGroupSubjectCON_FUN_MP_XLS';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer of CON_FUN_MP subject group from XLS.
			%
			% NAME = ImporterGroupSubjectCON_FUN_MP_XLS.GETNAME() returns the name of the 'importer of CON_FUN_MP subject group from XLS'.
			%  Importer Of CON_FUN_MP Subject Group From XLS.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer of CON_FUN_MP subject group from XLS IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('ImporterGroupSubjectCON_FUN_MP_XLS') returns the name of 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer Of CON_FUN_MP Subject Group From XLS';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer of CON_FUN_MP subject group from XLS.
			%
			% STR = ImporterGroupSubjectCON_FUN_MP_XLS.GETDESCRIPTION() returns the description of the 'importer of CON_FUN_MP subject group from XLS'.
			%  which is:
			%
			%  ImporterGroupSubjectCON_FUN_MP_XLS imports a group of subjects with connectivity data from a series of XLS file and their covariates (optional) from another XLS file.
			%  All these files must be in the same folder; also, no other files should be in the folder.
			%  Each file contains a table of values corresponding to the adjacency matrix.
			%  The XLS file containing the covariates must be inside another folder in the same group directory 
			%  and consists of the following columns:
			%  Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer of CON_FUN_MP subject group from XLS IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('ImporterGroupSubjectCON_FUN_MP_XLS') returns the description of 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% See also getClass, getName.
			
			im_description = [
				'ImporterGroupSubjectCON_FUN_MP_XLS imports a group of subjects with connectivity data from a series of XLS file and their covariates (optional) from another XLS file.' ...
				'All these files must be in the same folder; also, no other files should be in the folder.' ...
				'Each file contains a table of values corresponding to the adjacency matrix.' ...
				'The XLS file containing the covariates must be inside another folder in the same group directory ' ...
				'and consists of the following columns:' ...
				'Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of CON_FUN_MP subject group from XLS.
			%
			% PROPS = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPS() returns the property list of importer of CON_FUN_MP subject group from XLS.
			%
			% PROPS = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of CON_FUN_MP subject group from XLS IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectCON_FUN_MP_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Importer.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Importer.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Importer.getProps(Category.DATA)
						ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
						ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
						ImporterGroupSubjectCON_FUN_MP_XLS.BA
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT)
						ImporterGroupSubjectCON_FUN_MP_XLS.GR
						];
				case Category.FIGURE
					prop_list = [
						Importer.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Importer.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Importer.getProps()
						ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
						ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
						ImporterGroupSubjectCON_FUN_MP_XLS.BA
						ImporterGroupSubjectCON_FUN_MP_XLS.GR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer of CON_FUN_MP subject group from XLS.
			%
			% N = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPNUMBER() returns the property number of importer of CON_FUN_MP subject group from XLS.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer of CON_FUN_MP subject group from XLS IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectCON_FUN_MP_XLS') returns the property number of 'ImporterGroupSubjectCON_FUN_MP_XLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of CON_FUN_MP subject group from XLS/error.
			%
			% CHECK = ImporterGroupSubjectCON_FUN_MP_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectCON_FUN_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					ImporterGroupSubjectCON_FUN_MP_XLS.existsProp(prop), ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectCON_FUN_MP_XLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of CON_FUN_MP subject group from XLS/error.
			%
			% CHECK = ImporterGroupSubjectCON_FUN_MP_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectCON_FUN_MP_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectCON_FUN_MP_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectCON_FUN_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importergroupsubjectcon_fun_mp_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'directory_con'  'directory_fun'  'ba'  'gr' };
				
				check = any(strcmpi(tag, importergroupsubjectcon_fun_mp_xls_tag_list));
			else
				assert( ...
					ImporterGroupSubjectCON_FUN_MP_XLS.existsTag(tag), ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectCON_FUN_MP_XLS'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importergroupsubjectcon_fun_mp_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'directory_con'  'directory_fun'  'ba'  'gr' };
				
				tag = pointer;
				ImporterGroupSubjectCON_FUN_MP_XLS.existsTag(tag);
				
				prop = find(strcmpi(tag, importergroupsubjectcon_fun_mp_xls_tag_list));
			else % numeric
				prop = pointer;
				ImporterGroupSubjectCON_FUN_MP_XLS.existsProp(prop);
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ImporterGroupSubjectCON_FUN_MP_XLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ImporterGroupSubjectCON_FUN_MP_XLS.existsProp(prop);
				
				switch prop
					case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
						tag = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON_TAG;
					case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
						tag = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN_TAG;
					case ImporterGroupSubjectCON_FUN_MP_XLS.BA
						tag = ImporterGroupSubjectCON_FUN_MP_XLS.BA_TAG;
					case ImporterGroupSubjectCON_FUN_MP_XLS.GR
						tag = ImporterGroupSubjectCON_FUN_MP_XLS.GR_TAG;
					otherwise
						tag = getPropTag@Importer(prop);
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					prop_category = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON_CATEGORY;
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					prop_category = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN_CATEGORY;
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					prop_category = ImporterGroupSubjectCON_FUN_MP_XLS.BA_CATEGORY;
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					prop_category = ImporterGroupSubjectCON_FUN_MP_XLS.GR_CATEGORY;
				otherwise
					prop_category = getPropCategory@Importer(prop);
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					prop_format = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON_FORMAT;
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					prop_format = ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN_FORMAT;
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					prop_format = ImporterGroupSubjectCON_FUN_MP_XLS.BA_FORMAT;
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					prop_format = ImporterGroupSubjectCON_FUN_MP_XLS.GR_FORMAT;
				otherwise
					prop_format = getPropFormat@Importer(prop);
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					prop_description = 'DIRECTORY_CON (data, string) is the directory containing the CON_FUN_MP subject group files of CON type  from which to load the subject group.';
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					prop_description = 'DIRECTORY_FUN (data, string) is the directory containing the CON_FUN_MP subject group files of FUN type from which to load the subject group.';
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					prop_description = 'GR (result, item) is a group of subjects with connectivity data.';
				otherwise
					prop_description = getPropDescription@Importer(prop);
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					prop_default = Format.getFormatDefault(Format.STRING, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					prop_default = Format.getFormatDefault(Format.STRING, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_FUN_MP_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_FUN_MP_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_FUN_MP_XLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectCON_FUN_MP_XLS.conditioning(prop, ImporterGroupSubjectCON_FUN_MP_XLS.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_FUN_MP_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_FUN_MP_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  Element.CHECKPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_FUN_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			%  IM.CHECKPROP(ImporterGroupSubjectCON_FUN_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_FUN_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_FUN_MP_XLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_CON
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.DIRECTORY_FUN
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.BA
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectCON_FUN_MP_XLS.getPropSettings(prop));
				otherwise
					check = checkProp@Importer(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectCON_FUN_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectCON_FUN_MP_XLS.getPropTag(prop) ' (' ImporterGroupSubjectCON_FUN_MP_XLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = ImporterGroupSubjectCON_FUN_MP_XLS(varargin)
			% ImporterGroupSubjectCON_FUN_MP_XLS() creates a importer of CON_FUN_MP subject group from XLS.
			%
			% ImporterGroupSubjectCON_FUN_MP_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectCON_FUN_MP_XLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterGroupSubjectCON_FUN_MP_XLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>directory_con</strong> 	DIRECTORY_CON (data, string) is the directory containing the CON_FUN_MP subject group files of CON type  from which to load the subject group.
			%  <strong>6</strong> <strong>directory_fun</strong> 	DIRECTORY_FUN (data, string) is the directory containing the CON_FUN_MP subject group files of FUN type from which to load the subject group.
			%  <strong>7</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
			%  <strong>8</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with connectivity data.
			%
			% See also Category, Format, set, check.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ImporterGroupSubjectCON_FUN_MP_XLS.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Importer.getPropNumber()
						value = conditioning@Importer(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(im, prop, value)
			check = true;
			msg = ['Error while checking' tostring(im) ' ' im.getPropTag(prop) '.'];
			
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_FUN_MP', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					[check, msg] = checkValue@Importer(im, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop)
		
			switch prop
				case ImporterGroupSubjectCON_FUN_MP_XLS.GR
					rng(im.getPropSeed(ImporterGroupSubjectCON_FUN_MP_XLS.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					% first CON
					directory_CON = im.get('DIRECTORY_CON');
					if ~isfolder(directory_CON)&& ~braph2_testing()
					    im.uigetdir('DIR_TYPE', 'DIRECTORY_CON')
					    directory_CON = im.get('DIRECTORY_CON');
					end
					if isfolder(directory_CON)  
					    gr_con = ImporterGroupSubjectCON_XLS( ...
					        'DIRECTORY',  directory_CON, ...
					        'BA', im.get('ba'), ...
					        'WAITBAR', im.get('WAITBAR') ...
					        );
					elseif ~braph2_testing()
					    error(BRAPH2.IM_ERR);
					end
					
					% second FUN
					directory_FUN = im.get('DIRECTORY_FUN');
					if ~isfolder(directory_FUN)&& ~braph2_testing()
					    im.uigetdir('DIR_TYPE', 'DIRECTORY_FUN')
					    directory_FUN = im.get('DIRECTORY_FUN');
					end
					if isfolder(directory_FUN)  
					    gr_fun = ImporterGroupSubjectFUN_XLS( ...
					        'DIRECTORY',  directory_FUN, ...
					        'BA', im.get('ba'), ...
					        'WAITBAR', im.get('WAITBAR') ...
					        );
					elseif ~braph2_testing()
					    error(BRAPH2.IM_ERR);
					end
					
					if exist('gr_con') && exist('gr_fun')
					    co_gr = CombineGroups_CON_FUN( ...
					        'GR1', gr_con.get('GR'), ...
					        'GR2', gr_fun.get('GR'), ...
					        'WAITBAR', true ...
					        );
					    
					    gr = co_gr.get('GR');
					    
					end
					
					value = gr;
					
				otherwise
					value = calculateValue@Importer(im, prop);
					
			end
		end
	end
	methods % methods
		function uigetdir(im, varargin)
		    % UIGETDIR opens a dialog box to set the directory from where to load the XLS files of the CON_FUN_MP subject group.
		
		    directory = uigetdir('Select directory');
		    dir_type = get_from_varargin('', 'DIR_TYPE', varargin{:});
		    if ischar(directory) && isfolder(directory)
		        im.set(dir_type, directory);
		    end
		end
	end
end
