classdef ImporterBrainAtlasXLS < Importer
	% ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
	% The TXT file consists of 6 columns. It reads as follows: 
	% BrainAtlas ID (column 1), BrainAtlas LABEL (column 2),
	% BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
	% BrainAtlas NOTES (column 6).
	% It will throw an error is problems occur during the import.
	% It throws an error is problems occur during the import.
	%
	% The list of ImporterBrainAtlasXLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.
	%  <strong>6</strong> <strong>ba</strong> 	BA (result, item) is a brain atlas.
	%
	% ImporterBrainAtlasXLS methods (constructor):
	% ImporterBrainAtlasXLS - constructor
	%
	% ImporterBrainAtlasXLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer of brain atlas from XLS/XLSX/error.
	%  existsProp - checks whether property exists in importer of brain atlas from XLS/XLSX/error.
	%  getPropNumber - returns the property number of importer of brain atlas from XLS/XLSX.
	%  getProps - returns the property list of importer of brain atlas from XLS/XLSX.
	%  getDescription - returns the description of the importer of brain atlas from XLS/XLSX.
	%  getName - returns the name of the importer of brain atlas from XLS/XLSX.
	%  getClass - returns the class of the importer of brain atlas from XLS/XLSX.
	%
	% ImporterBrainAtlasXLS methods:
	%  uigetfile - E opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
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
	% ImporterBrainAtlasXLS methods (operators):
	%  isequal - determines whether two ImporterBrainAtlasXLS are equal (values, locked)
	%
	% ImporterBrainAtlasXLS methods (display):
	%  tostring - string with information about the ImporterBrainAtlasXLS
	%  disp - displays information about the ImporterBrainAtlasXLS
	%  tree - displays the element of ImporterBrainAtlasXLS
	%
	% ImporterBrainAtlasXLS method (element list):
	%  getElementList - returns a list with all subelements of ImporterBrainAtlasXLS
	%
	% ImporterBrainAtlasXLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ImporterBrainAtlasXLS
	%
	% ImporterBrainAtlasXLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ImporterBrainAtlasXLS
	%
	% ImporterBrainAtlasXLS methods (copy):
	%  copy - copies the ImporterBrainAtlasXLS
	%  deepclone - deep-clones the ImporterBrainAtlasXLS
	%  clone - clones the ImporterBrainAtlasXLS
	%
	% ImporterBrainAtlasXLS methods (inspection, Static):
	%  getClass - returns ImporterBrainAtlasXLS
	%  getName - returns the name of ImporterBrainAtlasXLS
	%  getDescription - returns the description of ImporterBrainAtlasXLS
	%  getProps - returns the property list of ImporterBrainAtlasXLS
	%  getPropNumber - returns the property number of ImporterBrainAtlasXLS
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
	% ImporterBrainAtlasXLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainAtlasXLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ImporterBrainAtlasXLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ImporterBrainAtlasXLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ImporterBrainAtlasXLS properties (Constant).
	%  FILE - 5
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
	%  BA - 6
	%  BA_TAG - 'ba'
	%  BA_CATEGORY - 'r'
	%  BA_FORMAT - 'it'
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
	% See also Element, Importer, ExporterBrainAtlasXLS..
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		BA = Importer.getPropNumber() + 2;
		BA_TAG = 'ba';
		BA_CATEGORY = Category.RESULT;
		BA_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function im_class = getClass()
			%GETCLASS returns the class of the importer of brain atlas from XLS/XLSX.
			%
			% CLASS = ImporterBrainAtlasXLS.GETCLASS() returns the class 'ImporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of brain atlas from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainAtlasXLS') returns 'ImporterBrainAtlasXLS'.
			%
			% See also getName, getDescription.
			
			im_class = 'ImporterBrainAtlasXLS';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer of brain atlas from XLS/XLSX.
			%
			% NAME = ImporterBrainAtlasXLS.GETNAME() returns the name of the 'importer of brain atlas from XLS/XLSX'.
			%  Importer Of Brain Atlas From XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer of brain atlas from XLS/XLSX IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('ImporterBrainAtlasXLS') returns the name of 'ImporterBrainAtlasXLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer Of Brain Atlas From XLS/XLSX';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer of brain atlas from XLS/XLSX.
			%
			% STR = ImporterBrainAtlasXLS.GETDESCRIPTION() returns the description of the 'importer of brain atlas from XLS/XLSX'.
			%  which is:
			%
			%  ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
			%  The TXT file consists of 6 columns. It reads as follows: 
			%  BrainAtlas ID (column 1), BrainAtlas LABEL (column 2),
			%  BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
			%  BrainAtlas NOTES (column 6).
			%  It will throw an error is problems occur during the import.
			%  It throws an error is problems occur during the import.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer of brain atlas from XLS/XLSX IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('ImporterBrainAtlasXLS') returns the description of 'ImporterBrainAtlasXLS'.
			%
			% See also getClass, getName.
			
			im_description = [
				'ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.' ...
				'The TXT file consists of 6 columns. It reads as follows: ' ...
				'BrainAtlas ID (column 1), BrainAtlas LABEL (column 2),' ...
				'BrainRegions (column 3-5; coordinates x, y, z, one per column) and ' ...
				'BrainAtlas NOTES (column 6).' ...
				'It will throw an error is problems occur during the import.' ...
				'It throws an error is problems occur during the import.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of brain atlas from XLS/XLSX.
			%
			% PROPS = ImporterBrainAtlasXLS.GETPROPS() returns the property list of importer of brain atlas from XLS/XLSX.
			%
			% PROPS = ImporterBrainAtlasXLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of brain atlas from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainAtlasXLS'[, CATEGORY]) returns the property list of 'ImporterBrainAtlasXLS'.
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
						ImporterBrainAtlasXLS.FILE
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT)
						ImporterBrainAtlasXLS.BA
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
						ImporterBrainAtlasXLS.FILE
						ImporterBrainAtlasXLS.BA
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer of brain atlas from XLS/XLSX.
			%
			% N = ImporterBrainAtlasXLS.GETPROPNUMBER() returns the property number of importer of brain atlas from XLS/XLSX.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer of brain atlas from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainAtlasXLS') returns the property number of 'ImporterBrainAtlasXLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of brain atlas from XLS/XLSX/error.
			%
			% CHECK = ImporterBrainAtlasXLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainAtlasXLS, PROP) checks whether PROP exists for ImporterBrainAtlasXLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainAtlasXLS, PROP) throws error if PROP does NOT exist for ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					ImporterBrainAtlasXLS.existsProp(prop), ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainAtlasXLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of brain atlas from XLS/XLSX/error.
			%
			% CHECK = ImporterBrainAtlasXLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainAtlasXLS, TAG) checks whether TAG exists for ImporterBrainAtlasXLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainAtlasXLS, TAG) throws error if TAG does NOT exist for ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importerbrainatlasxls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'ba' };
				
				check = any(strcmpi(tag, importerbrainatlasxls_tag_list));
			else
				assert( ...
					ImporterBrainAtlasXLS.existsTag(tag), ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ImporterBrainAtlasXLS'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainAtlasXLS, POINTER) returns property number of POINTER of ImporterBrainAtlasXLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainAtlasXLS, POINTER) returns property number of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importerbrainatlasxls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'ba' };
				
				tag = pointer;
				ImporterBrainAtlasXLS.existsTag(tag);
				
				prop = find(strcmpi(tag, importerbrainatlasxls_tag_list));
			else % numeric
				prop = pointer;
				ImporterBrainAtlasXLS.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ImporterBrainAtlasXLS, POINTER) returns tag of POINTER of ImporterBrainAtlasXLS.
			%  TAG = IM.GETPROPTAG(ImporterBrainAtlasXLS, POINTER) returns tag of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ImporterBrainAtlasXLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ImporterBrainAtlasXLS.existsProp(prop);
				
				switch prop
					case ImporterBrainAtlasXLS.FILE
						tag = ImporterBrainAtlasXLS.FILE_TAG;
					case ImporterBrainAtlasXLS.BA
						tag = ImporterBrainAtlasXLS.BA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainAtlasXLS, POINTER) returns category of POINTER of ImporterBrainAtlasXLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainAtlasXLS, POINTER) returns category of POINTER of ImporterBrainAtlasXLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					prop_category = ImporterBrainAtlasXLS.FILE_CATEGORY;
				case ImporterBrainAtlasXLS.BA
					prop_category = ImporterBrainAtlasXLS.BA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainAtlasXLS, POINTER) returns format of POINTER of ImporterBrainAtlasXLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainAtlasXLS, POINTER) returns format of POINTER of ImporterBrainAtlasXLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					prop_format = ImporterBrainAtlasXLS.FILE_FORMAT;
				case ImporterBrainAtlasXLS.BA
					prop_format = ImporterBrainAtlasXLS.BA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainAtlasXLS, POINTER) returns description of POINTER of ImporterBrainAtlasXLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainAtlasXLS, POINTER) returns description of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					prop_description = 'FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.';
				case ImporterBrainAtlasXLS.BA
					prop_description = 'BA (result, item) is a brain atlas.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainAtlasXLS, POINTER) returns settings of POINTER of ImporterBrainAtlasXLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainAtlasXLS, POINTER) returns settings of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterBrainAtlasXLS.BA
					prop_settings = 'BrainAtlas';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ImporterBrainAtlasXLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					prop_default = Format.getFormatDefault(Format.STRING, ImporterBrainAtlasXLS.getPropSettings(prop));
				case ImporterBrainAtlasXLS.BA
					prop_default = BrainAtlas();
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasXLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasXLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			prop_default = ImporterBrainAtlasXLS.conditioning(prop, ImporterBrainAtlasXLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasXLS.
			%  CHECK = IM.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasXLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  IM.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ImporterBrainAtlasXLS.FILE
					check = Format.checkFormat(Format.STRING, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				case ImporterBrainAtlasXLS.BA
					check = Format.checkFormat(Format.ITEM, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				otherwise
					check = checkProp@Importer(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainAtlasXLS.getPropTag(prop) ' (' ImporterBrainAtlasXLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = ImporterBrainAtlasXLS(varargin)
			% ImporterBrainAtlasXLS() creates a importer of brain atlas from XLS/XLSX.
			%
			% ImporterBrainAtlasXLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainAtlasXLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterBrainAtlasXLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.
			%  <strong>6</strong> <strong>ba</strong> 	BA (result, item) is a brain atlas.
			%
			% See also Category, Format, set, check.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Importer.getPropNumber()
						value = conditioning@Importer(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop)
		
			switch prop
				case ImporterBrainAtlasXLS.BA
					rng(im.getPropSeed(ImporterBrainAtlasXLS.BA), 'twister')
					
					% creates empty BrainAtlas
					ba = BrainAtlas();
					% analyzes file
					file = im.memorize('FILE');
					if ~isfile(file) && ~braph2_testing()
					    im.uigetfile()
					    file = im.memorize('FILE');
					end
					if isfile(file)
					    if im.get('WAITBAR')
					        wb = waitbar(0, 'Reading File ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					
					    try
					        [~, ~, raw] = xlsread(file);
					        
					        % adds props
					        if im.get('WAITBAR')
					            waitbar(.15, wb, 'Loading brain atlas file ...');
					        end
					        
					        ba.set( ...
					            'ID', raw{1, 1}, ...
					            'LABEL', raw{2, 1}, ...
					            'NOTES', raw{3, 1} ...
					            );
					        
					        idict = ba.get('BR_DICT');
					        
					        % adds brain regions
					        if im.get('WAITBAR')
					            waitbar(.30, wb, 'Extracting brain regions ...')
					        end
					        
					        for i = 5:1:size(raw, 1)
					            if im.get('WAITBAR')
					                waitbar(.30 + .70 * (i - 4) / (size(raw, 1) - 4), wb, ['Loading brain region ' num2str(i - 4) ' of ' num2str(size(raw, 1) - 4) ' ...'])
					            end
					            
					            br = BrainRegion( ...
					                'ID', raw{i, 1}, ...
					                'LABEL', raw{i, 2}, ...
					                'X', raw{i, 3}, ...
					                'Y', raw{i, 4}, ...
					                'Z', raw{i, 5}, ...
					                'NOTES', raw{i, 6} ...
					                );
					            idict.add(br);
					        end
					        ba.set('br_dict', idict);
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
					
					value = ba;
					
				otherwise
					value = calculateValue@Importer(im, prop);
					
			end
		end
	end
	methods % methods
		function uigetfile(im)
		    % UIGETFILE opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
		    
		    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
		    if filterindex
		        file = [filepath filename];
		        im.set('FILE', file);
		    end
		end
	end
end
