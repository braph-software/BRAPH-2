classdef ExporterPipelineBRAPH2 < Exporter
	% ExporterPipelineBRAPH2 exports a pipeline in a BRAPH2 file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterPipelineBRAPH2 exports a pipeline to a BRAPH2 file.
	%
	% The list of ExporterPipelineBRAPH2 properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
	%  <strong>5</strong> <strong>pip</strong> 	PIP (data, item) is a pipeline.
	%  <strong>6</strong> <strong>file</strong> 	FILE (data, string) is the BRAPH2 file where to save the pipeline.
	%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
	%
	% ExporterPipelineBRAPH2 methods (constructor):
	% ExporterPipelineBRAPH2 - constructor
	%
	% ExporterPipelineBRAPH2 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in exporter of pipeline in BRAPH2/error.
	%  existsProp - checks whether property exists in exporter of pipeline in BRAPH2/error.
	%  getPropNumber - returns the property number of exporter of pipeline in BRAPH2.
	%  getProps - returns the property list of exporter of pipeline in BRAPH2.
	%  getDescription - returns the description of the exporter of pipeline in BRAPH2.
	%  getName - returns the name of the exporter of pipeline in BRAPH2.
	%  getClass - returns the class of the exporter of pipeline in BRAPH2.
	%
	% ExporterPipelineBRAPH2 methods:
	%  uiputfile - E (result, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.
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
	% ExporterPipelineBRAPH2 methods (operators):
	%  isequal - determines whether two ExporterPipelineBRAPH2 are equal (values, locked)
	%
	% ExporterPipelineBRAPH2 methods (display):
	%  tostring - string with information about the ExporterPipelineBRAPH2
	%  disp - displays information about the ExporterPipelineBRAPH2
	%  tree - displays the element of ExporterPipelineBRAPH2
	%
	% ExporterPipelineBRAPH2 method (element list):
	%  getElementList - returns a list with all subelements of ExporterPipelineBRAPH2
	%
	% ExporterPipelineBRAPH2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ExporterPipelineBRAPH2
	%
	% ExporterPipelineBRAPH2 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ExporterPipelineBRAPH2
	%
	% ExporterPipelineBRAPH2 methods (copy):
	%  copy - copies the ExporterPipelineBRAPH2
	%  deepclone - deep-clones the ExporterPipelineBRAPH2
	%  clone - clones the ExporterPipelineBRAPH2
	%
	% ExporterPipelineBRAPH2 methods (inspection, Static):
	%  getClass - returns ExporterPipelineBRAPH2
	%  getName - returns the name of ExporterPipelineBRAPH2
	%  getDescription - returns the description of ExporterPipelineBRAPH2
	%  getProps - returns the property list of ExporterPipelineBRAPH2
	%  getPropNumber - returns the property number of ExporterPipelineBRAPH2
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
	% ExporterPipelineBRAPH2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterPipelineBRAPH2 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ExporterPipelineBRAPH2 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ExporterPipelineBRAPH2 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ExporterPipelineBRAPH2 properties (Constant).
	%  PIP - 5
	%  PIP_TAG - 'pip'
	%  PIP_CATEGORY - 'd'
	%  PIP_FORMAT - 'it'
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
	% See also Exporter, Pipeline, ImporterPipelineBRAPH2..
	
	properties (Constant) % properties
		PIP = Exporter.getPropNumber() + 1;
		PIP_TAG = 'pip';
		PIP_CATEGORY = Category.DATA;
		PIP_FORMAT = Format.ITEM;
		
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
			%GETCLASS returns the class of the exporter of pipeline in BRAPH2.
			%
			% CLASS = ExporterPipelineBRAPH2.GETCLASS() returns the class 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of pipeline in BRAPH2 EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterPipelineBRAPH2') returns 'ExporterPipelineBRAPH2'.
			%
			% See also getName, getDescription.
			
			ex_class = 'ExporterPipelineBRAPH2';
		end
		function ex_name = getName()
			%GETNAME returns the name of the exporter of pipeline in BRAPH2.
			%
			% NAME = ExporterPipelineBRAPH2.GETNAME() returns the name of the 'exporter of pipeline in BRAPH2'.
			%  Exporter Of Pipeline In BRAPH2.
			%
			% Alternative forms to call this method are:
			%  NAME = EX.GETNAME() returns the name of the exporter of pipeline in BRAPH2 EX.
			%  NAME = Element.GETNAME(EX) returns the name of 'EX'.
			%  NAME = Element.GETNAME('ExporterPipelineBRAPH2') returns the name of 'ExporterPipelineBRAPH2'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ex_name = 'Exporter Of Pipeline In BRAPH2';
		end
		function ex_description = getDescription()
			%GETDESCRIPTION returns the description of the exporter of pipeline in BRAPH2.
			%
			% STR = ExporterPipelineBRAPH2.GETDESCRIPTION() returns the description of the 'exporter of pipeline in BRAPH2'.
			%  which is:
			%
			%  ExporterPipelineBRAPH2 exports a pipeline to a BRAPH2 file.
			%
			% Alternative forms to call this method are:
			%  STR = EX.GETDESCRIPTION() returns the description of the exporter of pipeline in BRAPH2 EX.
			%  STR = Element.GETDESCRIPTION(EX) returns the description of 'EX'.
			%  STR = Element.GETDESCRIPTION('ExporterPipelineBRAPH2') returns the description of 'ExporterPipelineBRAPH2'.
			%
			% See also getClass, getName.
			
			ex_description = [
				'ExporterPipelineBRAPH2 exports a pipeline to a BRAPH2 file.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of pipeline in BRAPH2.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS() returns the property list of exporter of pipeline in BRAPH2.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of pipeline in BRAPH2 EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterPipelineBRAPH2'[, CATEGORY]) returns the property list of 'ExporterPipelineBRAPH2'.
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
						ExporterPipelineBRAPH2.PIP
						ExporterPipelineBRAPH2.FILE
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT)
						ExporterPipelineBRAPH2.SAVE
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
						ExporterPipelineBRAPH2.PIP
						ExporterPipelineBRAPH2.FILE
						ExporterPipelineBRAPH2.SAVE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of exporter of pipeline in BRAPH2.
			%
			% N = ExporterPipelineBRAPH2.GETPROPNUMBER() returns the property number of exporter of pipeline in BRAPH2.
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER() returns the property number of the exporter of pipeline in BRAPH2 EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterPipelineBRAPH2') returns the property number of 'ExporterPipelineBRAPH2'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of pipeline in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) checks whether PROP exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) throws error if PROP does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					ExporterPipelineBRAPH2.existsProp(prop), ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterPipelineBRAPH2.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of pipeline in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) checks whether TAG exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) throws error if TAG does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				exporterpipelinebraph2_tag_list = { 'id'  'label'  'notes'  'waitbar'  'pip'  'file'  'save' };
				
				check = any(strcmpi(tag, exporterpipelinebraph2_tag_list));
			else
				assert( ...
					ExporterPipelineBRAPH2.existsTag(tag), ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ExporterPipelineBRAPH2'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%  PROPERTY = EX.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				exporterpipelinebraph2_tag_list = { 'id'  'label'  'notes'  'waitbar'  'pip'  'file'  'save' };
				
				tag = pointer;
				ExporterPipelineBRAPH2.existsTag(tag);
				
				prop = find(strcmpi(tag, exporterpipelinebraph2_tag_list));
			else % numeric
				prop = pointer;
				ExporterPipelineBRAPH2.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%  TAG = EX.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ExporterPipelineBRAPH2.existsTag(tag);
			else % numeric
				prop = pointer;
				ExporterPipelineBRAPH2.existsProp(prop);
				
				switch prop
					case ExporterPipelineBRAPH2.PIP
						tag = ExporterPipelineBRAPH2.PIP_TAG;
					case ExporterPipelineBRAPH2.FILE
						tag = ExporterPipelineBRAPH2.FILE_TAG;
					case ExporterPipelineBRAPH2.SAVE
						tag = ExporterPipelineBRAPH2.SAVE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_category = ExporterPipelineBRAPH2.PIP_CATEGORY;
				case ExporterPipelineBRAPH2.FILE
					prop_category = ExporterPipelineBRAPH2.FILE_CATEGORY;
				case ExporterPipelineBRAPH2.SAVE
					prop_category = ExporterPipelineBRAPH2.SAVE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%  FORMAT = EX.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_format = ExporterPipelineBRAPH2.PIP_FORMAT;
				case ExporterPipelineBRAPH2.FILE
					prop_format = ExporterPipelineBRAPH2.FILE_FORMAT;
				case ExporterPipelineBRAPH2.SAVE
					prop_format = ExporterPipelineBRAPH2.SAVE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_description = 'PIP (data, item) is a pipeline.';
				case ExporterPipelineBRAPH2.FILE
					prop_description = 'FILE (data, string) is the BRAPH2 file where to save the pipeline.';
				case ExporterPipelineBRAPH2.SAVE
					prop_description = 'SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_settings = 'Pipeline';
				case ExporterPipelineBRAPH2.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterPipelineBRAPH2.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2'];
				case ExporterPipelineBRAPH2.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterPipelineBRAPH2.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			prop_default = ExporterPipelineBRAPH2.conditioning(prop, ExporterPipelineBRAPH2.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			%  CHECK = EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ExporterPipelineBRAPH2.PIP
					check = Format.checkFormat(Format.ITEM, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.FILE
					check = Format.checkFormat(Format.STRING, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case ExporterPipelineBRAPH2.SAVE
					check = Format.checkFormat(Format.EMPTY, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				otherwise
					check = checkProp@Exporter(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterPipelineBRAPH2.getPropTag(prop) ' (' ExporterPipelineBRAPH2.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ex = ExporterPipelineBRAPH2(varargin)
			% ExporterPipelineBRAPH2() creates a exporter of pipeline in BRAPH2.
			%
			% ExporterPipelineBRAPH2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterPipelineBRAPH2(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterPipelineBRAPH2 properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
			%  <strong>5</strong> <strong>pip</strong> 	PIP (data, item) is a pipeline.
			%  <strong>6</strong> <strong>file</strong> 	FILE (data, string) is the BRAPH2 file where to save the pipeline.
			%  <strong>7</strong> <strong>save</strong> 	SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
			%
			% See also Category, Format, set, check.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
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
				case ExporterPipelineBRAPH2.SAVE
					rng(ex.getPropSeed(ExporterPipelineBRAPH2.SAVE), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
					    if ex.get('WAITBAR')
					        wb = waitbar(0, 'Retrieving path ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    
					    pip = ex.get('PIP');
					   
					    txt = [ ...
					        '%% ' pip.get('LABEL') newline()  ...
					        '%' newline() ...
					        ];
					
					    notes = cellfun(@(x) ['% ' strtrim(x) newline()], cellstr(pip.get('NOTES')), 'UniformOutput', false);
					    for i = 1:1:length(notes)
					        txt = [txt notes{i}];
					    end
					
					    ps_dict = pip.get('PS_DICT');
					    for s = 1:1:ps_dict.length()
					        ps = ps_dict.getItem(s);
					        
					        txt = [ txt ...
					            newline() ...
					            '%% ' ps.get('LABEL') newline() ...
					            ];
					        
					        pc_dict = ps.get('PC_DICT');
					        for c = 1:1:pc_dict.length()
					            if ex.get('WAITBAR')
					                waitbar(.00 + 1.00 * (s - 1 + c / pc_dict.length()) / ps_dict.length(), wb, ...
					                    ['Saving pipeline section ' num2str(s) ' of ' num2str(ps_dict.length()) ...
					                    ', code line ' num2str(c) ' of ' num2str(pc_dict.length()) ' ...'])
					            end
					                
					            pc = pc_dict.getItem(c);
					            
					            txt = [ txt ...
					                pc.get('MONIKER') ' = ' pc.get('CODE') ' % ' pc.get('TEXT_BEFORE_EXEC') ' % ' pc.get('TEXT_AFTER_EXEC') newline() ...
					                ];
					        end
					    end
					    
					    txt = regexprep(txt, '%', '%%');
					    
					    object_file = fopen(ex.get('FILE'), 'w');
					    fprintf(object_file, txt);
					    fclose(object_file);
					    
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
		    % UIPUTFILE (result, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.
		
		    [filename, filepath, filterindex] = uiputfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 Pipeline file');
		    if filterindex
		        file = [filepath filename];
		        ex.set('FILE', file);
		    end
		end
	end
end
