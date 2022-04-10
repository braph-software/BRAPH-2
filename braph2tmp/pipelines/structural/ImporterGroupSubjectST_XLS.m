classdef ImporterGroupSubjectST_XLS < Importer
	% ImporterGroupSubjectST_XLS imports a group of subjects with structural data from an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from an XLS/XLSX file.
	% The XLS/XLSX file consists of the following columns (Sheet 1): 
	% Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
	% BrainRegions (column 4-end; one brainregion value per column).
	% The first row contains the headers and each subsequent row the values for each subject.
	% The covariates must be on the second Sheet of the same XLS/XLSX file. Sheet 2 consists of the following columns:
	% Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
	% The first row contains the headers and each subsequent row the values for each subject.
	% It throws an error is problems occur during the import.
	%
	% The list of ImporterGroupSubjectST_XLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
	%  <strong>6</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
	%  <strong>7</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with structural data.
	%
	% ImporterGroupSubjectST_XLS methods (constructor):
	% ImporterGroupSubjectST_XLS - constructor
	%
	% ImporterGroupSubjectST_XLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer of ST subject group from XLS/XLSX/error.
	%  existsProp - checks whether property exists in importer of ST subject group from XLS/XLSX/error.
	%  getPropNumber - returns the property number of importer of ST subject group from XLS/XLSX.
	%  getProps - returns the property list of importer of ST subject group from XLS/XLSX.
	%  getDescription - returns the description of the importer of ST subject group from XLS/XLSX.
	%  getName - returns the name of the importer of ST subject group from XLS/XLSX.
	%  getClass - returns the class of the importer of ST subject group from XLS/XLSX.
	%
	% ImporterGroupSubjectST_XLS methods:
	%  uigetfile - E opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
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
	% ImporterGroupSubjectST_XLS methods (operators):
	%  isequal - determines whether two ImporterGroupSubjectST_XLS are equal (values, locked)
	%
	% ImporterGroupSubjectST_XLS methods (display):
	%  tostring - string with information about the ImporterGroupSubjectST_XLS
	%  disp - displays information about the ImporterGroupSubjectST_XLS
	%  tree - displays the element of ImporterGroupSubjectST_XLS
	%
	% ImporterGroupSubjectST_XLS method (element list):
	%  getElementList - returns a list with all subelements of ImporterGroupSubjectST_XLS
	%
	% ImporterGroupSubjectST_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ImporterGroupSubjectST_XLS
	%
	% ImporterGroupSubjectST_XLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ImporterGroupSubjectST_XLS
	%
	% ImporterGroupSubjectST_XLS methods (copy):
	%  copy - copies the ImporterGroupSubjectST_XLS
	%  deepclone - deep-clones the ImporterGroupSubjectST_XLS
	%  clone - clones the ImporterGroupSubjectST_XLS
	%
	% ImporterGroupSubjectST_XLS methods (inspection, Static):
	%  getClass - returns ImporterGroupSubjectST_XLS
	%  getName - returns the name of ImporterGroupSubjectST_XLS
	%  getDescription - returns the description of ImporterGroupSubjectST_XLS
	%  getProps - returns the property list of ImporterGroupSubjectST_XLS
	%  getPropNumber - returns the property number of ImporterGroupSubjectST_XLS
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
	% ImporterGroupSubjectST_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectST_XLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ImporterGroupSubjectST_XLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ImporterGroupSubjectST_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ImporterGroupSubjectST_XLS properties (Constant).
	%  FILE - 5
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
	%  BA - 6
	%  BA_TAG - 'ba'
	%  BA_CATEGORY - 'd'
	%  BA_FORMAT - 'it'
	%  GR - 7
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
	% See also Element, Importer, ExporterGroupSubjectST_XLS.
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		BA = Importer.getPropNumber() + 2;
		BA_TAG = 'ba';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		GR = Importer.getPropNumber() + 3;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function im_class = getClass()
			%GETCLASS returns the class of the importer of ST subject group from XLS/XLSX.
			%
			% CLASS = ImporterGroupSubjectST_XLS.GETCLASS() returns the class 'ImporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of ST subject group from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectST_XLS') returns 'ImporterGroupSubjectST_XLS'.
			%
			% See also getName, getDescription.
			
			im_class = 'ImporterGroupSubjectST_XLS';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer of ST subject group from XLS/XLSX.
			%
			% NAME = ImporterGroupSubjectST_XLS.GETNAME() returns the name of the 'importer of ST subject group from XLS/XLSX'.
			%  Importer Of ST Subject Group From XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer of ST subject group from XLS/XLSX IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('ImporterGroupSubjectST_XLS') returns the name of 'ImporterGroupSubjectST_XLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer Of ST Subject Group From XLS/XLSX';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer of ST subject group from XLS/XLSX.
			%
			% STR = ImporterGroupSubjectST_XLS.GETDESCRIPTION() returns the description of the 'importer of ST subject group from XLS/XLSX'.
			%  which is:
			%
			%  ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from an XLS/XLSX file.
			%  The XLS/XLSX file consists of the following columns (Sheet 1): 
			%  Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
			%  BrainRegions (column 4-end; one brainregion value per column).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%  The covariates must be on the second Sheet of the same XLS/XLSX file. Sheet 2 consists of the following columns:
			%  Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%  It throws an error is problems occur during the import.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer of ST subject group from XLS/XLSX IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('ImporterGroupSubjectST_XLS') returns the description of 'ImporterGroupSubjectST_XLS'.
			%
			% See also getClass, getName.
			
			im_description = [
				'ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from an XLS/XLSX file.' ...
				'The XLS/XLSX file consists of the following columns (Sheet 1): ' ...
				'Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and' ...
				'BrainRegions (column 4-end; one brainregion value per column).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				'The covariates must be on the second Sheet of the same XLS/XLSX file. Sheet 2 consists of the following columns:' ...
				'Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				'It throws an error is problems occur during the import.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of ST subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectST_XLS.GETPROPS() returns the property list of importer of ST subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectST_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of ST subject group from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectST_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectST_XLS'.
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
						ImporterGroupSubjectST_XLS.FILE
						ImporterGroupSubjectST_XLS.BA
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT)
						ImporterGroupSubjectST_XLS.GR
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
						ImporterGroupSubjectST_XLS.FILE
						ImporterGroupSubjectST_XLS.BA
						ImporterGroupSubjectST_XLS.GR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer of ST subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectST_XLS.GETPROPNUMBER() returns the property number of importer of ST subject group from XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer of ST subject group from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectST_XLS') returns the property number of 'ImporterGroupSubjectST_XLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of ST subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectST_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectST_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectST_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectST_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					ImporterGroupSubjectST_XLS.existsProp(prop), ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectST_XLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of ST subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectST_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectST_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectST_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectST_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importergroupsubjectst_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'ba'  'gr' };
				
				check = any(strcmpi(tag, importergroupsubjectst_xls_tag_list));
			else
				assert( ...
					ImporterGroupSubjectST_XLS.existsTag(tag), ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectST_XLS'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectST_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importergroupsubjectst_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'ba'  'gr' };
				
				tag = pointer;
				ImporterGroupSubjectST_XLS.existsTag(tag);
				
				prop = find(strcmpi(tag, importergroupsubjectst_xls_tag_list));
			else % numeric
				prop = pointer;
				ImporterGroupSubjectST_XLS.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectST_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ImporterGroupSubjectST_XLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ImporterGroupSubjectST_XLS.existsProp(prop);
				
				switch prop
					case ImporterGroupSubjectST_XLS.FILE
						tag = ImporterGroupSubjectST_XLS.FILE_TAG;
					case ImporterGroupSubjectST_XLS.BA
						tag = ImporterGroupSubjectST_XLS.BA_TAG;
					case ImporterGroupSubjectST_XLS.GR
						tag = ImporterGroupSubjectST_XLS.GR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectST_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					prop_category = ImporterGroupSubjectST_XLS.FILE_CATEGORY;
				case ImporterGroupSubjectST_XLS.BA
					prop_category = ImporterGroupSubjectST_XLS.BA_CATEGORY;
				case ImporterGroupSubjectST_XLS.GR
					prop_category = ImporterGroupSubjectST_XLS.GR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectST_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					prop_format = ImporterGroupSubjectST_XLS.FILE_FORMAT;
				case ImporterGroupSubjectST_XLS.BA
					prop_format = ImporterGroupSubjectST_XLS.BA_FORMAT;
				case ImporterGroupSubjectST_XLS.GR
					prop_format = ImporterGroupSubjectST_XLS.GR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectST_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					prop_description = 'FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.';
				case ImporterGroupSubjectST_XLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ImporterGroupSubjectST_XLS.GR
					prop_description = 'GR (result, item) is a group of subjects with structural data.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectST_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterGroupSubjectST_XLS.BA
					prop_settings = 'BrainAtlas';
				case ImporterGroupSubjectST_XLS.GR
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					prop_default = '';
				case ImporterGroupSubjectST_XLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case ImporterGroupSubjectST_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_XLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectST_XLS.conditioning(prop, ImporterGroupSubjectST_XLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  IM.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case ImporterGroupSubjectST_XLS.FILE
					check = Format.checkFormat(Format.STRING, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case ImporterGroupSubjectST_XLS.BA
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case ImporterGroupSubjectST_XLS.GR
					check = Format.checkFormat(Format.ITEM, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				otherwise
					check = checkProp@Importer(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterGroupSubjectST_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectST_XLS.getPropTag(prop) ' (' ImporterGroupSubjectST_XLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = ImporterGroupSubjectST_XLS(varargin)
			% ImporterGroupSubjectST_XLS() creates a importer of ST subject group from XLS/XLSX.
			%
			% ImporterGroupSubjectST_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectST_XLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterGroupSubjectST_XLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
			%  <strong>6</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
			%  <strong>7</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with structural data.
			%
			% See also Category, Format, set, check.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
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
				case ImporterGroupSubjectST_XLS.GR
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
					
				otherwise
					[check, msg] = checkValue@Importer(im, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop)
		
			switch prop
				case ImporterGroupSubjectST_XLS.GR
					rng(im.getPropSeed(ImporterGroupSubjectST_XLS.GR), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					    );
					
					gr.lock('SUB_CLASS');
					% analyzes file
					file = im.memorize('FILE');
					if ~isfile(file) && ~braph2_testing()
					    im.uigetfile()
					    file = im.memorize('FILE');
					end
					if isfile(file)
					    if im.get('WAITBAR')
					        wb = waitbar(0, 'Reading Directory ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    
					    [~, ~, raw] = xlsread(file);
					    
					    % Check if there are covariates to add (age and sex)
					    sheets = sheetnames(file);
					    if length(sheets) > 1
					        [~, ~, raw_covariates] = xlsread(file, 2);
					        age = raw_covariates(2:end, 2);
					        sex = raw_covariates(2:end, 3);
					    else
					        age = {[0]};
					        age = age(ones(size(raw, 1)-1,1));
					        unassigned =  {'unassigned'};
					        sex = unassigned(ones(size(raw, 1)-1, 1));
					    end
					    
					    % sets group props
					    if im.get('WAITBAR')
					        waitbar(.15, wb, 'Loading subject group ...');
					    end
					    try
					        [~, name, ext] = fileparts(file);
					        gr.set( ...
					            'ID', name, ...
					            'LABEL', [name ext], ...
					            'NOTES', ['Group loaded from ' file] ...
					            );
					        
					        % brain atlas
					        if im.get('WAITBAR')
					            waitbar(.30, wb, 'Loading brain atlas ...')
					        end
					            
					        ba = im.get('BA');
					        br_number = size(raw, 2) - 3;
					        if ba.get('BR_DICT').length ~= br_number
					            ba = BrainAtlas();
					            idict = ba.get('BR_DICT');
					            for j = 4:1:length(raw)
					                br_id = raw{1, j};
					                br = BrainRegion('ID', br_id);
					                idict.add(br)
					            end
					            ba.set('br_dict', idict);
					        end
					        
					        subdict = gr.get('SUB_DICT');
					        
					        % adds subjects
					        for i = 2:1:size(raw, 1)
					            if im.get('WAITBAR')
					                waitbar(.30 + .70 * (i - 1) / size(raw, 1), wb, ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
					            end
					            
					            ST = zeros(br_number, 1);
					            for j = 1:1:length(ST)
					                ST(j) = raw{i, 3 + j};
					            end
					            sub = SubjectST( ...
					                'ID', num2str(raw{i, 1}), ...
					                'LABEL', num2str(raw{i, 2}), ...
					                'NOTES', num2str(raw{i, 3}), ...
					                'BA', ba, ...
					                'ST', ST, ...
					                'age', age{i-1}, ...
					                'sex', sex{i-1} ...
					                );
					            subdict.add(sub);
					        end
					        gr.set('sub_dict', subdict);
					    catch e
					        if im.get('WAITBAR')
					            close(wb)
					        end
					
					        rethrow(e)
					    end
					    
					    if im.get('WAITBAR')
					        close(wb)
					    end
					elseif ~braph2_testing()
					    error(BRAPH2.IM_ERR);
					end
					
					value = gr;
					
				otherwise
					value = calculateValue@Importer(im, prop);
					
			end
		end
	end
	methods % methods
		function uigetfile(im)
		    % UIGETFILE opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
		    
		    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
		    if filterindex
		        file = [filepath filename];
		        im.set('FILE', file);
		    end
		end
	end
end
