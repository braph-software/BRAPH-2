classdef ExporterBrainAtlasXLS < Exporter
	% ExporterBrainAtlasXLS exports a brain atlas to an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterBrainAtlasXLS exports a brain atlas to an XLS/XLSX file.
	%
	% The list of ExporterBrainAtlasXLS properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
	%  <strong>5</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
	%  <strong>6</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file where to save the brain atlas.
	%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the brain atlas in the selected XLS/XLSX file.
	%
	% ExporterBrainAtlasXLS methods (constructor):
	% ExporterBrainAtlasXLS - constructor
	%
	% ExporterBrainAtlasXLS methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in exporter of brain atlas in XLS/error.
	%  existsProp - checks whether property exists in exporter of brain atlas in XLS/error.
	%  getPropNumber - returns the property number of exporter of brain atlas in XLS.
	%  getProps - returns the property list of exporter of brain atlas in XLS.
	%  getDescription - returns the description of the exporter of brain atlas in XLS.
	%  getName - returns the name of the exporter of brain atlas in XLS.
	%  getClass - returns the class of the exporter of brain atlas in XLS.
	%
	% ExporterBrainAtlasXLS methods:
	%  uiputfile - E (result, empty) opens a dialog box to set the XLS/XLSX file where to save the brain atlas.
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
	% ExporterBrainAtlasXLS methods (operators):
	%  isequal - determines whether two ExporterBrainAtlasXLS are equal (values, locked)
	%
	% ExporterBrainAtlasXLS methods (display):
	%  tostring - string with information about the ExporterBrainAtlasXLS
	%  disp - displays information about the ExporterBrainAtlasXLS
	%  tree - displays the element of ExporterBrainAtlasXLS
	%
	% ExporterBrainAtlasXLS method (element list):
	%  getElementList - returns a list with all subelements of ExporterBrainAtlasXLS
	%
	% ExporterBrainAtlasXLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ExporterBrainAtlasXLS
	%
	% ExporterBrainAtlasXLS method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ExporterBrainAtlasXLS
	%
	% ExporterBrainAtlasXLS methods (copy):
	%  copy - copies the ExporterBrainAtlasXLS
	%  deepclone - deep-clones the ExporterBrainAtlasXLS
	%  clone - clones the ExporterBrainAtlasXLS
	%
	% ExporterBrainAtlasXLS methods (inspection, Static):
	%  getClass - returns ExporterBrainAtlasXLS
	%  getName - returns the name of ExporterBrainAtlasXLS
	%  getDescription - returns the description of ExporterBrainAtlasXLS
	%  getProps - returns the property list of ExporterBrainAtlasXLS
	%  getPropNumber - returns the property number of ExporterBrainAtlasXLS
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
	% ExporterBrainAtlasXLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterBrainAtlasXLS methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ExporterBrainAtlasXLS methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ExporterBrainAtlasXLS methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ExporterBrainAtlasXLS properties (Constant).
	%  BA - 5
	%  BA_TAG - 'ba'
	%  BA_CATEGORY - 'd'
	%  BA_FORMAT - 'it'
	%  FILE - 6
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
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
	% See also Element, Exporter, ImporterBrainAtlasXLS..
	
	properties (Constant) % properties
		BA = Exporter.getPropNumber() + 1;
		BA_TAG = 'ba';
		BA_CATEGORY = Category.DATA;
		BA_FORMAT = Format.ITEM;
		
		FILE = Exporter.getPropNumber() + 2;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		SAVE = Exporter.getPropNumber() + 3;
		SAVE_TAG = 'save';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods (Static) % inspection methods
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of brain atlas in XLS.
			%
			% CLASS = ExporterBrainAtlasXLS.GETCLASS() returns the class 'ExporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of brain atlas in XLS EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterBrainAtlasXLS') returns 'ExporterBrainAtlasXLS'.
			%
			% See also getName, getDescription.
			
			ex_class = 'ExporterBrainAtlasXLS';
		end
		function ex_name = getName()
			%GETNAME returns the name of the exporter of brain atlas in XLS.
			%
			% NAME = ExporterBrainAtlasXLS.GETNAME() returns the name of the 'exporter of brain atlas in XLS'.
			%  Exporter Of Brain Atlas In XLS.
			%
			% Alternative forms to call this method are:
			%  NAME = EX.GETNAME() returns the name of the exporter of brain atlas in XLS EX.
			%  NAME = Element.GETNAME(EX) returns the name of 'EX'.
			%  NAME = Element.GETNAME('ExporterBrainAtlasXLS') returns the name of 'ExporterBrainAtlasXLS'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ex_name = 'Exporter Of Brain Atlas In XLS';
		end
		function ex_description = getDescription()
			%GETDESCRIPTION returns the description of the exporter of brain atlas in XLS.
			%
			% STR = ExporterBrainAtlasXLS.GETDESCRIPTION() returns the description of the 'exporter of brain atlas in XLS'.
			%  which is:
			%
			%  ExporterBrainAtlasXLS exports a brain atlas to an XLS/XLSX file.
			%
			% Alternative forms to call this method are:
			%  STR = EX.GETDESCRIPTION() returns the description of the exporter of brain atlas in XLS EX.
			%  STR = Element.GETDESCRIPTION(EX) returns the description of 'EX'.
			%  STR = Element.GETDESCRIPTION('ExporterBrainAtlasXLS') returns the description of 'ExporterBrainAtlasXLS'.
			%
			% See also getClass, getName.
			
			ex_description = [
				'ExporterBrainAtlasXLS exports a brain atlas to an XLS/XLSX file.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of brain atlas in XLS.
			%
			% PROPS = ExporterBrainAtlasXLS.GETPROPS() returns the property list of exporter of brain atlas in XLS.
			%
			% PROPS = ExporterBrainAtlasXLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of brain atlas in XLS EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterBrainAtlasXLS'[, CATEGORY]) returns the property list of 'ExporterBrainAtlasXLS'.
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
						ExporterBrainAtlasXLS.BA
						ExporterBrainAtlasXLS.FILE
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT)
						ExporterBrainAtlasXLS.SAVE
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
						ExporterBrainAtlasXLS.BA
						ExporterBrainAtlasXLS.FILE
						ExporterBrainAtlasXLS.SAVE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of exporter of brain atlas in XLS.
			%
			% N = ExporterBrainAtlasXLS.GETPROPNUMBER() returns the property number of exporter of brain atlas in XLS.
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER() returns the property number of the exporter of brain atlas in XLS EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterBrainAtlasXLS') returns the property number of 'ExporterBrainAtlasXLS'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of brain atlas in XLS/error.
			%
			% CHECK = ExporterBrainAtlasXLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterBrainAtlasXLS, PROP) checks whether PROP exists for ExporterBrainAtlasXLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(ExporterBrainAtlasXLS, PROP) throws error if PROP does NOT exist for ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					ExporterBrainAtlasXLS.existsProp(prop), ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterBrainAtlasXLS.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of brain atlas in XLS/error.
			%
			% CHECK = ExporterBrainAtlasXLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterBrainAtlasXLS, TAG) checks whether TAG exists for ExporterBrainAtlasXLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(ExporterBrainAtlasXLS, TAG) throws error if TAG does NOT exist for ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				exporterbrainatlasxls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'ba'  'file'  'save' };
				
				check = any(strcmpi(tag, exporterbrainatlasxls_tag_list));
			else
				assert( ...
					ExporterBrainAtlasXLS.existsTag(tag), ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ExporterBrainAtlasXLS'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterBrainAtlasXLS, POINTER) returns property number of POINTER of ExporterBrainAtlasXLS.
			%  PROPERTY = EX.GETPROPPROP(ExporterBrainAtlasXLS, POINTER) returns property number of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				exporterbrainatlasxls_tag_list = { 'id'  'label'  'notes'  'waitbar'  'ba'  'file'  'save' };
				
				tag = pointer;
				ExporterBrainAtlasXLS.existsTag(tag);
				
				prop = find(strcmpi(tag, exporterbrainatlasxls_tag_list));
			else % numeric
				prop = pointer;
				ExporterBrainAtlasXLS.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ExporterBrainAtlasXLS, POINTER) returns tag of POINTER of ExporterBrainAtlasXLS.
			%  TAG = EX.GETPROPTAG(ExporterBrainAtlasXLS, POINTER) returns tag of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ExporterBrainAtlasXLS.existsTag(tag);
			else % numeric
				prop = pointer;
				ExporterBrainAtlasXLS.existsProp(prop);
				
				switch prop
					case ExporterBrainAtlasXLS.BA
						tag = ExporterBrainAtlasXLS.BA_TAG;
					case ExporterBrainAtlasXLS.FILE
						tag = ExporterBrainAtlasXLS.FILE_TAG;
					case ExporterBrainAtlasXLS.SAVE
						tag = ExporterBrainAtlasXLS.SAVE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterBrainAtlasXLS, POINTER) returns category of POINTER of ExporterBrainAtlasXLS.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterBrainAtlasXLS, POINTER) returns category of POINTER of ExporterBrainAtlasXLS.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_category = ExporterBrainAtlasXLS.BA_CATEGORY;
				case ExporterBrainAtlasXLS.FILE
					prop_category = ExporterBrainAtlasXLS.FILE_CATEGORY;
				case ExporterBrainAtlasXLS.SAVE
					prop_category = ExporterBrainAtlasXLS.SAVE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterBrainAtlasXLS, POINTER) returns format of POINTER of ExporterBrainAtlasXLS.
			%  FORMAT = EX.GETPROPFORMAT(ExporterBrainAtlasXLS, POINTER) returns format of POINTER of ExporterBrainAtlasXLS.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_format = ExporterBrainAtlasXLS.BA_FORMAT;
				case ExporterBrainAtlasXLS.FILE
					prop_format = ExporterBrainAtlasXLS.FILE_FORMAT;
				case ExporterBrainAtlasXLS.SAVE
					prop_format = ExporterBrainAtlasXLS.SAVE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterBrainAtlasXLS, POINTER) returns description of POINTER of ExporterBrainAtlasXLS.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterBrainAtlasXLS, POINTER) returns description of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_description = 'BA (data, item) is a brain atlas.';
				case ExporterBrainAtlasXLS.FILE
					prop_description = 'FILE (data, string) is the XLS/XLSX file where to save the brain atlas.';
				case ExporterBrainAtlasXLS.SAVE
					prop_description = 'SAVE (result, empty) saves the brain atlas in the selected XLS/XLSX file.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterBrainAtlasXLS, POINTER) returns settings of POINTER of ExporterBrainAtlasXLS.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterBrainAtlasXLS, POINTER) returns settings of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_settings = 'BrainAtlas';
				case ExporterBrainAtlasXLS.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterBrainAtlasXLS.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ExporterBrainAtlasXLS.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_xls_file_to_save_brain_atlas_most_likely_to_be_erased.xlsx'];
				case ExporterBrainAtlasXLS.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterBrainAtlasXLS.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasXLS.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasXLS.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			prop_default = ExporterBrainAtlasXLS.conditioning(prop, ExporterBrainAtlasXLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasXLS.
			%  CHECK = EX.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasXLS.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  Element.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			%  EX.CHECKPROP(ExporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ExporterBrainAtlasXLS:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case ExporterBrainAtlasXLS.BA
					check = Format.checkFormat(Format.ITEM, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.FILE
					check = Format.checkFormat(Format.STRING, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				case ExporterBrainAtlasXLS.SAVE
					check = Format.checkFormat(Format.EMPTY, value, ExporterBrainAtlasXLS.getPropSettings(prop));
				otherwise
					check = checkProp@Exporter(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterBrainAtlasXLS:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterBrainAtlasXLS.getPropTag(prop) ' (' ExporterBrainAtlasXLS.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ex = ExporterBrainAtlasXLS(varargin)
			% ExporterBrainAtlasXLS() creates a exporter of brain atlas in XLS.
			%
			% ExporterBrainAtlasXLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterBrainAtlasXLS(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterBrainAtlasXLS properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
			%  <strong>5</strong> <strong>ba</strong> 	BA (data, item) is a brain atlas.
			%  <strong>6</strong> <strong>file</strong> 	FILE (data, string) is the XLS/XLSX file where to save the brain atlas.
			%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the brain atlas in the selected XLS/XLSX file.
			%
			% See also Category, Format, set, check.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ExporterBrainAtlasXLS.getPropProp(pointer);
			
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
				case ExporterBrainAtlasXLS.SAVE
					rng(ex.getPropSeed(ExporterBrainAtlasXLS.SAVE), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
					    if ex.get('WAITBAR')
					        wb = waitbar(0, 'Retrieving path ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    
					    ba = ex.get('BA');
					    ba_id = ba.get('ID');
					    if ~isempty(ba.get('LABEL'))
					        ba_label = ba.get('LABEL');
					    else
					        ba_label = ' ';
					    end
					    if ~isempty(ba.get('NOTES'))
					        ba_notes = ba.get('NOTES');
					    else
					        ba_notes = ' ';
					    end
					
					    % gets brain region data
					    if ex.get('WAITBAR')
					        waitbar(.15, wb, 'Organizing info ...');
					    end
					    
					    br_dict = ba.get('BR_DICT');
					    br_ids = cell(br_dict.length(), 1);
					    br_labels = cell(br_dict.length(), 1);
					    br_notes = cell(br_dict.length(), 1);
					    br_x = cell(br_dict.length(), 1);
					    br_y = cell(br_dict.length(), 1);
					    br_z = cell(br_dict.length(), 1);
					    for i = 1:1:br_dict.length()
					        if ex.get('WAITBAR')
					            waitbar(.30 + .70 * i / br_dict.length(), wb, ['Saving brain region ' num2str(i) ' of ' num2str(br_dict.length())]);
					        end
					        
					        br = br_dict.getItem(i);
					        br_ids{i} = br.get('ID');
					        if ~isempty(br.get('LABEL'))
					            br_labels{i} = br.get('LABEL');
					        else
					            br_labels{i} = ' ';
					        end
					        if ~isempty(br.get('NOTES'))
					            br_notes{i} = br.get('NOTES');
					        else
					            br_notes{i} = ' ';
					        end
					        br_x{i} = br.get('X');
					        br_y{i} = br.get('Y');
					        br_z{i} = br.get('Z');
					    end
					
					    % creates table
					    tab = [
					        {ba_id, {}, {}, {}, {}, {}};
					        {ba_label, {}, {}, {}, {}, {}};
					        {ba_notes, {}, {}, {}, {}, {}};
					        {{}, {}, {}, {}, {}, {}};
					        table(br_ids, br_labels, br_x, br_y, br_z, br_notes)
					        ];
					
					    % save
					    if ex.get('WAITBAR')
					        waitbar(1, wb, 'Finalizing ...');
					    end
					
					    writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0);
					
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
		function uiputfile(ex)
		    % UIPUTFILE (result, empty) opens a dialog box to set the XLS/XLSX file where to save the brain atlas.
		
		    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
		    if filterindex
		        file = [filepath filename];
		        ex.set('FILE', file);
		    end
		end
	end
end
