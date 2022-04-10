classdef ExporterGroupSubjectFUN_XLS < Exporter
	% ExporterGroupSubjectFUN_XLS exports a group of subjects with functional data to a series of XLSX file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectFUN_XLS exports a group of subjects with functional data to a series of XLSX file and their covariates (if existing).
	% All these files are saved in the same folder.
	% Each file contains a table with each row correspoding to a time serie and each column to a brain region.
	% The XLS/XLSX file containing the covariates consists of the following columns:
	% Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
	% The first row contains the headers and each subsequent row the values for each subject.
	%
	% The list of ExporterGroupSubjectFUN_XLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
	%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects with functional data.
	%  <strong>6</strong> <strong>directory</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with functional data.
	%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the group of subjects with functional data in XLS/XLSX files in the selected directory.
	%
	% ExporterGroupSubjectFUN_XLS methods (constructor):
	% ExporterGroupSubjectFUN_XLS - constructor
	%
	% ExporterGroupSubjectFUN_XLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in exporter of FUN subject group in XLS/XLSX/error.
	%  existsProp - checks whether property exists in exporter of FUN subject group in XLS/XLSX/error.
	%  getPropNumber - returns the property number of exporter of FUN subject group in XLS/XLSX.
	%  getProps - returns the property list of exporter of FUN subject group in XLS/XLSX.
	%  getDescription - returns the description of the exporter of FUN subject group in XLS/XLSX.
	%  getName - returns the name of the exporter of FUN subject group in XLS/XLSX.
	%  getClass - returns the class of the exporter of FUN subject group in XLS/XLSX.
	%
	% ExporterGroupSubjectFUN_XLS methods:
	%  uigetdir - R opens a dialog box to set the directory where to save the group of subjects with functional data.
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
	% ExporterGroupSubjectFUN_XLS methods (operators):
	%  isequal - determines whether two ExporterGroupSubjectFUN_XLS are equal (values, locked)
	%
	% ExporterGroupSubjectFUN_XLS methods (display):
	%  tostring - string with information about the ExporterGroupSubjectFUN_XLS
	%  disp - displays information about the ExporterGroupSubjectFUN_XLS
	%  tree - displays the element of ExporterGroupSubjectFUN_XLS
	%
	% ExporterGroupSubjectFUN_XLS method (element list):
	%  getElementList - returns a list with all subelements of ExporterGroupSubjectFUN_XLS
	%
	% ExporterGroupSubjectFUN_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ExporterGroupSubjectFUN_XLS
	%
	% ExporterGroupSubjectFUN_XLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ExporterGroupSubjectFUN_XLS
	%
	% ExporterGroupSubjectFUN_XLS methods (copy):
	%  copy - copies the ExporterGroupSubjectFUN_XLS
	%  deepclone - deep-clones the ExporterGroupSubjectFUN_XLS
	%  clone - clones the ExporterGroupSubjectFUN_XLS
	%
	% ExporterGroupSubjectFUN_XLS methods (inspection, Static):
	%  getClass - returns ExporterGroupSubjectFUN_XLS
	%  getName - returns the name of ExporterGroupSubjectFUN_XLS
	%  getDescription - returns the description of ExporterGroupSubjectFUN_XLS
	%  getProps - returns the property list of ExporterGroupSubjectFUN_XLS
	%  getPropNumber - returns the property number of ExporterGroupSubjectFUN_XLS
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
	% ExporterGroupSubjectFUN_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectFUN_XLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ExporterGroupSubjectFUN_XLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ExporterGroupSubjectFUN_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ExporterGroupSubjectFUN_XLS properties (Constant).
	%  GR - 5
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'd'
	%  GR_FORMAT - 'it'
	%  DIRECTORY - 6
	%  DIRECTORY_TAG - 'directory'
	%  DIRECTORY_CATEGORY - 'd'
	%  DIRECTORY_FORMAT - 'st'
	%  SAVE - 7
	%  SAVE_TAG - 'save'
	%  SAVE_CATEGORY - 'r'
	%  SAVE_FORMAT - 'em'
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
	% See also Element, Exporter, ImporterGroupSubjectFUN_XLS.
	
	properties (Constant) % properties
		GR = Exporter.getPropNumber() + 1;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		DIRECTORY = Exporter.getPropNumber() + 2;
		DIRECTORY_TAG = 'directory';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		SAVE = Exporter.getPropNumber() + 3;
		SAVE_TAG = 'save';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods (Static) % inspection methods
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of FUN subject group in XLS/XLSX.
			%
			% CLASS = ExporterGroupSubjectFUN_XLS.GETCLASS() returns the class 'ExporterGroupSubjectFUN_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of FUN subject group in XLS/XLSX EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectFUN_XLS') returns 'ExporterGroupSubjectFUN_XLS'.
			%
			% See also getName, getDescription.
			
			ex_class = 'ExporterGroupSubjectFUN_XLS';
		end
		function ex_name = getName()
			%GETNAME returns the name of the exporter of FUN subject group in XLS/XLSX.
			%
			% NAME = ExporterGroupSubjectFUN_XLS.GETNAME() returns the name of the 'exporter of FUN subject group in XLS/XLSX'.
			%  Exporter Of FUN Subject Group In XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  NAME = EX.GETNAME() returns the name of the exporter of FUN subject group in XLS/XLSX EX.
			%  NAME = Element.GETNAME(EX) returns the name of 'EX'.
			%  NAME = Element.GETNAME('ExporterGroupSubjectFUN_XLS') returns the name of 'ExporterGroupSubjectFUN_XLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ex_name = 'Exporter Of FUN Subject Group In XLS/XLSX';
		end
		function ex_description = getDescription()
			%GETDESCRIPTION returns the description of the exporter of FUN subject group in XLS/XLSX.
			%
			% STR = ExporterGroupSubjectFUN_XLS.GETDESCRIPTION() returns the description of the 'exporter of FUN subject group in XLS/XLSX'.
			%  which is:
			%
			%  ExporterGroupSubjectFUN_XLS exports a group of subjects with functional data to a series of XLSX file and their covariates (if existing).
			%  All these files are saved in the same folder.
			%  Each file contains a table with each row correspoding to a time serie and each column to a brain region.
			%  The XLS/XLSX file containing the covariates consists of the following columns:
			%  Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%
			% Alternative forms to call this method are:
			%  STR = EX.GETDESCRIPTION() returns the description of the exporter of FUN subject group in XLS/XLSX EX.
			%  STR = Element.GETDESCRIPTION(EX) returns the description of 'EX'.
			%  STR = Element.GETDESCRIPTION('ExporterGroupSubjectFUN_XLS') returns the description of 'ExporterGroupSubjectFUN_XLS'.
			%
			% See also getClass, getName.
			
			ex_description = [
				'ExporterGroupSubjectFUN_XLS exports a group of subjects with functional data to a series of XLSX file and their covariates (if existing).' ...
				'All these files are saved in the same folder.' ...
				'Each file contains a table with each row correspoding to a time serie and each column to a brain region.' ...
				'The XLS/XLSX file containing the covariates consists of the following columns:' ...
				'Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of FUN subject group in XLS/XLSX.
			%
			% PROPS = ExporterGroupSubjectFUN_XLS.GETPROPS() returns the property list of exporter of FUN subject group in XLS/XLSX.
			%
			% PROPS = ExporterGroupSubjectFUN_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of FUN subject group in XLS/XLSX EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectFUN_XLS'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectFUN_XLS'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Exporter.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						Exporter.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Exporter.getProps(Category.DATA)
						ExporterGroupSubjectFUN_XLS.GR
						ExporterGroupSubjectFUN_XLS.DIRECTORY
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT)
						ExporterGroupSubjectFUN_XLS.SAVE
						];
				case Category.FIGURE
					prop_list = [
						Exporter.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Exporter.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Exporter.getProps()
						ExporterGroupSubjectFUN_XLS.GR
						ExporterGroupSubjectFUN_XLS.DIRECTORY
						ExporterGroupSubjectFUN_XLS.SAVE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of exporter of FUN subject group in XLS/XLSX.
			%
			% N = ExporterGroupSubjectFUN_XLS.GETPROPNUMBER() returns the property number of exporter of FUN subject group in XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER() returns the property number of the exporter of FUN subject group in XLS/XLSX EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectFUN_XLS') returns the property number of 'ExporterGroupSubjectFUN_XLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of FUN subject group in XLS/XLSX/error.
			%
			% CHECK = ExporterGroupSubjectFUN_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectFUN_XLS, PROP) checks whether PROP exists for ExporterGroupSubjectFUN_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectFUN_XLS, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					ExporterGroupSubjectFUN_XLS.existsProp(prop), ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectFUN_XLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of FUN subject group in XLS/XLSX/error.
			%
			% CHECK = ExporterGroupSubjectFUN_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectFUN_XLS, TAG) checks whether TAG exists for ExporterGroupSubjectFUN_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectFUN_XLS, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				exportergroupsubjectfun_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr'  'directory'  'save' };
				
				check = any(strcmpi(tag, exportergroupsubjectfun_xls_tag_list));
			else
				assert( ...
					ExporterGroupSubjectFUN_XLS.existsTag(tag), ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectFUN_XLS'] ...
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
			%  PROPERTY = EX.GETPROPPROP(POINTER) returns property number of POINTER of EX.
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectFUN_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectFUN_XLS.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectFUN_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				exportergroupsubjectfun_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr'  'directory'  'save' };
				
				tag = pointer;
				ExporterGroupSubjectFUN_XLS.existsTag(tag);
				
				prop = find(strcmpi(tag, exportergroupsubjectfun_xls_tag_list));
			else % numeric
				prop = pointer;
				ExporterGroupSubjectFUN_XLS.existsProp(prop);
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
			%  TAG = EX.GETPROPTAG(POINTER) returns tag of POINTER of EX.
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectFUN_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectFUN_XLS.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectFUN_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ExporterGroupSubjectFUN_XLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ExporterGroupSubjectFUN_XLS.existsProp(prop);
				
				switch prop
					case ExporterGroupSubjectFUN_XLS.GR
						tag = ExporterGroupSubjectFUN_XLS.GR_TAG;
					case ExporterGroupSubjectFUN_XLS.DIRECTORY
						tag = ExporterGroupSubjectFUN_XLS.DIRECTORY_TAG;
					case ExporterGroupSubjectFUN_XLS.SAVE
						tag = ExporterGroupSubjectFUN_XLS.SAVE_TAG;
					otherwise
						tag = getPropTag@Exporter(prop);
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectFUN_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectFUN_XLS.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectFUN_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					prop_category = ExporterGroupSubjectFUN_XLS.GR_CATEGORY;
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					prop_category = ExporterGroupSubjectFUN_XLS.DIRECTORY_CATEGORY;
				case ExporterGroupSubjectFUN_XLS.SAVE
					prop_category = ExporterGroupSubjectFUN_XLS.SAVE_CATEGORY;
				otherwise
					prop_category = getPropCategory@Exporter(prop);
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectFUN_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectFUN_XLS.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectFUN_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					prop_format = ExporterGroupSubjectFUN_XLS.GR_FORMAT;
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					prop_format = ExporterGroupSubjectFUN_XLS.DIRECTORY_FORMAT;
				case ExporterGroupSubjectFUN_XLS.SAVE
					prop_format = ExporterGroupSubjectFUN_XLS.SAVE_FORMAT;
				otherwise
					prop_format = getPropFormat@Exporter(prop);
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectFUN_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectFUN_XLS.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectFUN_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					prop_description = 'GR (data, item) is a group of subjects with functional data.';
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory name where to save the group of subjects with functional data.';
				case ExporterGroupSubjectFUN_XLS.SAVE
					prop_description = 'SAVE (result, empty) saves the group of subjects with functional data in XLS/XLSX files in the selected directory.';
				otherwise
					prop_description = getPropDescription@Exporter(prop);
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectFUN_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectFUN_XLS.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectFUN_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					prop_settings = 'Group';
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterGroupSubjectFUN_XLS.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectFUN_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectFUN_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectFUN_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectFUN_XLS.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectFUN_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ExporterGroupSubjectFUN_XLS.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterGroupSubjectFUN_XLS.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectFUN_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectFUN_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectFUN_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectFUN_XLS.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectFUN_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectFUN_XLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectFUN_XLS.conditioning(prop, ExporterGroupSubjectFUN_XLS.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EX.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EX.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EX.
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectFUN_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectFUN_XLS.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectFUN_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectFUN_XLS.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  Element.CHECKPROP(ExporterGroupSubjectFUN_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			%  EX.CHECKPROP(ExporterGroupSubjectFUN_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectFUN_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectFUN_XLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectFUN_XLS.GR
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectFUN_XLS.getPropSettings(prop));
					if check
						check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN', [], [], true))); % Format.checkFormat(Format.ITEM, value) already checked
					end
				case ExporterGroupSubjectFUN_XLS.DIRECTORY
					check = Format.checkFormat(Format.STRING, value, ExporterGroupSubjectFUN_XLS.getPropSettings(prop));
				case ExporterGroupSubjectFUN_XLS.SAVE
					check = Format.checkFormat(Format.EMPTY, value, ExporterGroupSubjectFUN_XLS.getPropSettings(prop));
				otherwise
					check = checkProp@Exporter(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectFUN_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectFUN_XLS.getPropTag(prop) ' (' ExporterGroupSubjectFUN_XLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ex = ExporterGroupSubjectFUN_XLS(varargin)
			% ExporterGroupSubjectFUN_XLS() creates a exporter of FUN subject group in XLS/XLSX.
			%
			% ExporterGroupSubjectFUN_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectFUN_XLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterGroupSubjectFUN_XLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
			%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects with functional data.
			%  <strong>6</strong> <strong>directory</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with functional data.
			%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the group of subjects with functional data in XLS/XLSX files in the selected directory.
			%
			% See also Category, Format, set, check.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ExporterGroupSubjectFUN_XLS.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Exporter.getPropNumber()
						value = conditioning@Exporter(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ex, prop)
		
			switch prop
				case ExporterGroupSubjectFUN_XLS.SAVE
					rng(ex.getPropSeed(ExporterGroupSubjectFUN_XLS.SAVE), 'twister')
					
					directory = ex.get('DIRECTORY');
					
					if isfolder(directory)
					    if ex.get('WAITBAR')
					        wb = waitbar(0, 'Retrieving path ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    gr = ex.get('GR');
					
					    gr_directory = [directory filesep() gr.get('ID')];
					    if ~exist(gr_directory, 'dir')
					        mkdir(gr_directory)
					    end
					    if ex.get('WAITBAR')
					        waitbar(.15, wb, 'Organizing info ...');
					    end
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.length();
					    sub_id = cell(sub_number, 1);
					    age = cell(sub_number, 1);
					    sex = cell(sub_number, 1);
					    if ex.get('WAITBAR')
					        waitbar(.15, wb, 'Organizing info ...');
					    end
					            
					    for i = 1:1:sub_number
					        if ex.get('WAITBAR')
					            waitbar(.30 + .70 * i / sub_number, wb, ['Saving subject ' num2str(i) ' of ' num2str(sub_number) ' ...']);
					        end
					        sub = sub_dict.getItem(i);
					        sub_id(i) = {sub.get('ID')};
					        sub_FUN = sub.get('FUN');
					        age{i} =  sub.get('AGE');
					        sex{i} =  sub.get('SEX'); 
					
					        tab = table(sub_FUN);
					
					        sub_file = [gr_directory filesep() sub_id{i} '.xlsx'];
					
					        % save file
					        writetable(tab, sub_file, 'Sheet', 1, 'WriteVariableNames', 0);
					    end
					    
					    % if covariates save them in another file
					    if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
					        tab2 = cell(1 + sub_number, 3);
					        tab2{1, 1} = 'ID';
					        tab2{1, 2} = 'Age';
					        tab2{1, 3} = 'Sex';
					        tab2(2:end, 1) = sub_id;
					        tab2(2:end, 2) = age;
					        tab2(2:end, 3) = sex;
					        tab2 = table(tab2);
					        
					        % save
					        cov_directory = [gr_directory filesep() 'covariates'];
					        if ~exist(cov_directory, 'dir')
					            mkdir(cov_directory)
					        end
					        writetable(tab2, [cov_directory filesep() gr.get('ID') '_covariates.xlsx'], 'Sheet', 1, 'WriteVariableNames', 0);
					    end
					    
					    % sets value to empty
					    value = [];
					    if ex.get('WAITBAR')
					        close(wb)
					    end
					else
					    value = ex.getr('SAVE');    
					end
					
				otherwise
					value = calculateValue@Exporter(ex, prop);
					
			end
		end
	end
	methods % methods
		function uigetdir(ex)
		    % UIGETDIR opens a dialog box to set the directory where to save the group of subjects with functional data.
		
		    directory = uigetdir('Select directory');
		    if ischar(directory) && isfolder(directory)
		        ex.set('DIRECTORY', directory);
		    end
		end
	end
end
