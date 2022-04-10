classdef ExporterGroupSubjectST_MP_XLS < Exporter
	% ExporterGroupSubjectST_MP_XLS exports a group of subjects with structural multiplex data to an XLSX file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectST_MP_XLS exports a group of subjects with structural multiplex data  and their covariates (if existing) to an XLSX file.
	% The files from the same group containing the data from L layers are saved in the same folder.
	% Each XLS/XLSX file consists of the following columns: 
	% Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
	% BrainRegions of that layer (column 4-end; one brainregion value per column).
	% The first row contains the headers and each subsequent row the values for each subject.
	% The XLS/XLSX file containing the covariates consists of the following columns:
	% Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
	% The first row contains the headers and each subsequent row the values for each subject.
	%
	% The list of ExporterGroupSubjectST_MP_XLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
	%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects with structural multiplex data.
	%  <strong>6</strong> <strong>directory</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.
	%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the group of subjects with structural multiplex data in XLS/XLSX files in the selected directory.
	%
	% ExporterGroupSubjectST_MP_XLS methods (constructor):
	% ExporterGroupSubjectST_MP_XLS - constructor
	%
	% ExporterGroupSubjectST_MP_XLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in exporter of ST MP subject group in XLS/XLSX/error.
	%  existsProp - checks whether property exists in exporter of ST MP subject group in XLS/XLSX/error.
	%  getPropNumber - returns the property number of exporter of ST MP subject group in XLS/XLSX.
	%  getProps - returns the property list of exporter of ST MP subject group in XLS/XLSX.
	%  getDescription - returns the description of the exporter of ST MP subject group in XLS/XLSX.
	%  getName - returns the name of the exporter of ST MP subject group in XLS/XLSX.
	%  getClass - returns the class of the exporter of ST MP subject group in XLS/XLSX.
	%
	% ExporterGroupSubjectST_MP_XLS methods:
	%  uigetdir - R opens a dialog box to set the directory where to save the group of subjects with structural multiplex data.
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
	% ExporterGroupSubjectST_MP_XLS methods (operators):
	%  isequal - determines whether two ExporterGroupSubjectST_MP_XLS are equal (values, locked)
	%
	% ExporterGroupSubjectST_MP_XLS methods (display):
	%  tostring - string with information about the ExporterGroupSubjectST_MP_XLS
	%  disp - displays information about the ExporterGroupSubjectST_MP_XLS
	%  tree - displays the element of ExporterGroupSubjectST_MP_XLS
	%
	% ExporterGroupSubjectST_MP_XLS method (element list):
	%  getElementList - returns a list with all subelements of ExporterGroupSubjectST_MP_XLS
	%
	% ExporterGroupSubjectST_MP_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ExporterGroupSubjectST_MP_XLS
	%
	% ExporterGroupSubjectST_MP_XLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ExporterGroupSubjectST_MP_XLS
	%
	% ExporterGroupSubjectST_MP_XLS methods (copy):
	%  copy - copies the ExporterGroupSubjectST_MP_XLS
	%  deepclone - deep-clones the ExporterGroupSubjectST_MP_XLS
	%  clone - clones the ExporterGroupSubjectST_MP_XLS
	%
	% ExporterGroupSubjectST_MP_XLS methods (inspection, Static):
	%  getClass - returns ExporterGroupSubjectST_MP_XLS
	%  getName - returns the name of ExporterGroupSubjectST_MP_XLS
	%  getDescription - returns the description of ExporterGroupSubjectST_MP_XLS
	%  getProps - returns the property list of ExporterGroupSubjectST_MP_XLS
	%  getPropNumber - returns the property number of ExporterGroupSubjectST_MP_XLS
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
	% ExporterGroupSubjectST_MP_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectST_MP_XLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ExporterGroupSubjectST_MP_XLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ExporterGroupSubjectST_MP_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ExporterGroupSubjectST_MP_XLS properties (Constant).
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
	% See also Element, Exporter, ImporterGroupSubjectST_MP_XLS.
	
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
			%GETCLASS returns the class of the exporter of ST MP subject group in XLS/XLSX.
			%
			% CLASS = ExporterGroupSubjectST_MP_XLS.GETCLASS() returns the class 'ExporterGroupSubjectST_MP_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of ST MP subject group in XLS/XLSX EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectST_MP_XLS') returns 'ExporterGroupSubjectST_MP_XLS'.
			%
			% See also getName, getDescription.
			
			ex_class = 'ExporterGroupSubjectST_MP_XLS';
		end
		function ex_name = getName()
			%GETNAME returns the name of the exporter of ST MP subject group in XLS/XLSX.
			%
			% NAME = ExporterGroupSubjectST_MP_XLS.GETNAME() returns the name of the 'exporter of ST MP subject group in XLS/XLSX'.
			%  Exporter Of ST MP Subject Group In XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  NAME = EX.GETNAME() returns the name of the exporter of ST MP subject group in XLS/XLSX EX.
			%  NAME = Element.GETNAME(EX) returns the name of 'EX'.
			%  NAME = Element.GETNAME('ExporterGroupSubjectST_MP_XLS') returns the name of 'ExporterGroupSubjectST_MP_XLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ex_name = 'Exporter Of ST MP Subject Group In XLS/XLSX';
		end
		function ex_description = getDescription()
			%GETDESCRIPTION returns the description of the exporter of ST MP subject group in XLS/XLSX.
			%
			% STR = ExporterGroupSubjectST_MP_XLS.GETDESCRIPTION() returns the description of the 'exporter of ST MP subject group in XLS/XLSX'.
			%  which is:
			%
			%  ExporterGroupSubjectST_MP_XLS exports a group of subjects with structural multiplex data  and their covariates (if existing) to an XLSX file.
			%  The files from the same group containing the data from L layers are saved in the same folder.
			%  Each XLS/XLSX file consists of the following columns: 
			%  Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
			%  BrainRegions of that layer (column 4-end; one brainregion value per column).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%  The XLS/XLSX file containing the covariates consists of the following columns:
			%  Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
			%  The first row contains the headers and each subsequent row the values for each subject.
			%
			% Alternative forms to call this method are:
			%  STR = EX.GETDESCRIPTION() returns the description of the exporter of ST MP subject group in XLS/XLSX EX.
			%  STR = Element.GETDESCRIPTION(EX) returns the description of 'EX'.
			%  STR = Element.GETDESCRIPTION('ExporterGroupSubjectST_MP_XLS') returns the description of 'ExporterGroupSubjectST_MP_XLS'.
			%
			% See also getClass, getName.
			
			ex_description = [
				'ExporterGroupSubjectST_MP_XLS exports a group of subjects with structural multiplex data  and their covariates (if existing) to an XLSX file.' ...
				'The files from the same group containing the data from L layers are saved in the same folder.' ...
				'Each XLS/XLSX file consists of the following columns: ' ...
				'Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and' ...
				'BrainRegions of that layer (column 4-end; one brainregion value per column).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				'The XLS/XLSX file containing the covariates consists of the following columns:' ...
				'Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).' ...
				'The first row contains the headers and each subsequent row the values for each subject.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of ST MP subject group in XLS/XLSX.
			%
			% PROPS = ExporterGroupSubjectST_MP_XLS.GETPROPS() returns the property list of exporter of ST MP subject group in XLS/XLSX.
			%
			% PROPS = ExporterGroupSubjectST_MP_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of ST MP subject group in XLS/XLSX EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectST_MP_XLS'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectST_MP_XLS'.
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
						ExporterGroupSubjectST_MP_XLS.GR
						ExporterGroupSubjectST_MP_XLS.DIRECTORY
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT)
						ExporterGroupSubjectST_MP_XLS.SAVE
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
						ExporterGroupSubjectST_MP_XLS.GR
						ExporterGroupSubjectST_MP_XLS.DIRECTORY
						ExporterGroupSubjectST_MP_XLS.SAVE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of exporter of ST MP subject group in XLS/XLSX.
			%
			% N = ExporterGroupSubjectST_MP_XLS.GETPROPNUMBER() returns the property number of exporter of ST MP subject group in XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER() returns the property number of the exporter of ST MP subject group in XLS/XLSX EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectST_MP_XLS') returns the property number of 'ExporterGroupSubjectST_MP_XLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of ST MP subject group in XLS/XLSX/error.
			%
			% CHECK = ExporterGroupSubjectST_MP_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectST_MP_XLS, PROP) checks whether PROP exists for ExporterGroupSubjectST_MP_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectST_MP_XLS, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectST_MP_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					ExporterGroupSubjectST_MP_XLS.existsProp(prop), ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectST_MP_XLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of ST MP subject group in XLS/XLSX/error.
			%
			% CHECK = ExporterGroupSubjectST_MP_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectST_MP_XLS, TAG) checks whether TAG exists for ExporterGroupSubjectST_MP_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectST_MP_XLS, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectST_MP_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				exportergroupsubjectst_mp_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr'  'directory'  'save' };
				
				check = any(strcmpi(tag, exportergroupsubjectst_mp_xls_tag_list));
			else
				assert( ...
					ExporterGroupSubjectST_MP_XLS.existsTag(tag), ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectST_MP_XLS'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectST_MP_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectST_MP_XLS, POINTER) returns property number of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				exportergroupsubjectst_mp_xls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr'  'directory'  'save' };
				
				tag = pointer;
				ExporterGroupSubjectST_MP_XLS.existsTag(tag);
				
				prop = find(strcmpi(tag, exportergroupsubjectst_mp_xls_tag_list));
			else % numeric
				prop = pointer;
				ExporterGroupSubjectST_MP_XLS.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectST_MP_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectST_MP_XLS, POINTER) returns tag of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ExporterGroupSubjectST_MP_XLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ExporterGroupSubjectST_MP_XLS.existsProp(prop);
				
				switch prop
					case ExporterGroupSubjectST_MP_XLS.GR
						tag = ExporterGroupSubjectST_MP_XLS.GR_TAG;
					case ExporterGroupSubjectST_MP_XLS.DIRECTORY
						tag = ExporterGroupSubjectST_MP_XLS.DIRECTORY_TAG;
					case ExporterGroupSubjectST_MP_XLS.SAVE
						tag = ExporterGroupSubjectST_MP_XLS.SAVE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectST_MP_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectST_MP_XLS, POINTER) returns category of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					prop_category = ExporterGroupSubjectST_MP_XLS.GR_CATEGORY;
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					prop_category = ExporterGroupSubjectST_MP_XLS.DIRECTORY_CATEGORY;
				case ExporterGroupSubjectST_MP_XLS.SAVE
					prop_category = ExporterGroupSubjectST_MP_XLS.SAVE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectST_MP_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectST_MP_XLS, POINTER) returns format of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					prop_format = ExporterGroupSubjectST_MP_XLS.GR_FORMAT;
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					prop_format = ExporterGroupSubjectST_MP_XLS.DIRECTORY_FORMAT;
				case ExporterGroupSubjectST_MP_XLS.SAVE
					prop_format = ExporterGroupSubjectST_MP_XLS.SAVE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectST_MP_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectST_MP_XLS, POINTER) returns description of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					prop_description = 'GR (data, item) is a group of subjects with structural multiplex data.';
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.';
				case ExporterGroupSubjectST_MP_XLS.SAVE
					prop_description = 'SAVE (result, empty) saves the group of subjects with structural multiplex data in XLS/XLSX files in the selected directory.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectST_MP_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectST_MP_XLS, POINTER) returns settings of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					prop_settings = 'Group';
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterGroupSubjectST_MP_XLS.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectST_MP_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectST_MP_XLS, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case ExporterGroupSubjectST_MP_XLS.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterGroupSubjectST_MP_XLS.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_MP_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_MP_XLS.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_MP_XLS, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_MP_XLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectST_MP_XLS.conditioning(prop, ExporterGroupSubjectST_MP_XLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectST_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_MP_XLS.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectST_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_MP_XLS.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  Element.CHECKPROP(ExporterGroupSubjectST_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_MP_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			%  EX.CHECKPROP(ExporterGroupSubjectST_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_MP_XLS.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_XLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_XLS.GR
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectST_MP_XLS.getPropSettings(prop));
					if check
						check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true)));
					end
				case ExporterGroupSubjectST_MP_XLS.DIRECTORY
					check = Format.checkFormat(Format.STRING, value, ExporterGroupSubjectST_MP_XLS.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_XLS.SAVE
					check = Format.checkFormat(Format.EMPTY, value, ExporterGroupSubjectST_MP_XLS.getPropSettings(prop));
				otherwise
					check = checkProp@Exporter(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_XLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectST_MP_XLS.getPropTag(prop) ' (' ExporterGroupSubjectST_MP_XLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ex = ExporterGroupSubjectST_MP_XLS(varargin)
			% ExporterGroupSubjectST_MP_XLS() creates a exporter of ST MP subject group in XLS/XLSX.
			%
			% ExporterGroupSubjectST_MP_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectST_MP_XLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterGroupSubjectST_MP_XLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
			%  <strong>5</strong> <strong>gr</strong> 	GR (data, item) is a group of subjects with structural multiplex data.
			%  <strong>6</strong> <strong>directory</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.
			%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the group of subjects with structural multiplex data in XLS/XLSX files in the selected directory.
			%
			% See also Category, Format, set, check.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ExporterGroupSubjectST_MP_XLS.getPropProp(pointer);
			
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
				case ExporterGroupSubjectST_MP_XLS.SAVE
					rng(ex.getPropSeed(ExporterGroupSubjectST_MP_XLS.SAVE), 'twister')
					
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
					
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.length();
					
					    if ex.get('WAITBAR')
					        waitbar(.15, wb, 'Organizing info ...');
					    end
					
					    if sub_number ~= 0
					        sub = sub_dict.getItem(1);
					        ba = sub.get('BA');
					        br_list = cellfun(@(i) ba.get('BR_DICT').getItem(i), ...
					            num2cell([1:1:ba.get('BR_DICT').length()]), 'UniformOutput', false);
					        br_labels = cellfun(@(br) br.get('ID'), br_list, 'UniformOutput', false);
					        layers_number = sub_dict.getItem(1).get('L');
					        br_number = length(br_labels);
					        all_data = cell(layers_number, sub_number, br_number);
					        subjects_info = cell(sub_number, 3);
					        age = cell(sub_number, 1);
					        sex = cell(sub_number, 1);
					        
					        for i = 1:1:sub_number
					            sub = sub_dict.getItem(i);
					            subjects_info{i, 1} = sub.get('ID');
					            subjects_info{i, 2} = sub.get('LABEL');
					            subjects_info{i, 3} = sub.get('NOTES');
					            age{i} =  sub.get('AGE');
					            sex{i} =  sub.get('SEX');
					            
					            for k = 1:1:layers_number
					                data_val = sub.get('ST_MP');
					                all_data(k, i, :) = num2cell(data_val{k}');
					            end             
					        end
					
					        if ex.get('WAITBAR')
					            waitbar(.55, wb, 'Saving info ...');
					        end
					
					        for j = 1:1:layers_number
					            gr_id = gr.get('ID');
					            % save id label notes
					            tab_id = cell2table(subjects_info);
					            tab_id.Properties.VariableNames = {'ID', 'Label', 'Notes'};
					            writetable(tab_id, [gr_directory filesep() gr_id  '_' num2str(j) '.xlsx'], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'A1');
					            
					            % save data
					            tab_data =  cell2table(reshape(all_data(j, :, :), [sub_number, br_number]));
					            tab_data.Properties.VariableNames = br_labels;
					            writetable(tab_data, [gr_directory filesep() gr_id  '_' num2str(j) '.xlsx'], 'Sheet', 1, 'WriteVariableNames', 1, 'Range', 'D1');
					        end
					    end
					    
					    % if covariates save them in another file
					    if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
					        tab2 = cell(1 + sub_number, 3);
					        tab2{1, 1} = 'ID';
					        tab2{1, 2} = 'Age';
					        tab2{1, 3} = 'Sex';
					        tab2(2:end, 1) = tab_id{:, 1};
					        tab2(2:end, 2) = age;
					        tab2(2:end, 3) = sex;
					        tab2 = table(tab2);
					        
					        % save
					        warning_query = warning( 'query', 'MATLAB:xlswrite:AddSheet');
					        warning('off', 'MATLAB:xlswrite:AddSheet')
					        writetable(tab2, [gr_directory filesep() gr_id  '_1.xlsx'], 'Sheet', 2, 'WriteVariableNames', 0);
					        warning(warning_query.state, 'MATLAB:xlswrite:AddSheet')
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
		    % UIGETDIR opens a dialog box to set the directory where to save the group of subjects with structural multiplex data.
		
		    directory = uigetdir('Select directory');
		    if ischar(directory) && isfolder(directory)
		        ex.set('DIRECTORY', directory);
		    end
		end
	end
end
