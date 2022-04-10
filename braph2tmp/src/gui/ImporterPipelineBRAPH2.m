classdef ImporterPipelineBRAPH2 < Importer
	% ImporterPipelineBRAPH2 imports a brain atlas from a braph2 file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterPipelineBRAPH2 imports a pipeline from a BRAPH2 file.
	% The format of the BRAPH2 file should include the label, description and at least one code section.
	%
	% The list of ImporterPipelineBRAPH2 properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the BRAPH2 file from where to load the pipeline.
	%  <strong>6</strong> <strong>pip</strong> 	PIP (result, item) is a pipeline.
	%
	% ImporterPipelineBRAPH2 methods (constructor):
	% ImporterPipelineBRAPH2 - constructor
	%
	% ImporterPipelineBRAPH2 methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer of pipeline from BRAPH2/error.
	%  existsProp - checks whether property exists in importer of pipeline from BRAPH2/error.
	%  getPropNumber - returns the property number of importer of pipeline from BRAPH2.
	%  getProps - returns the property list of importer of pipeline from BRAPH2.
	%  getDescription - returns the description of the importer of pipeline from BRAPH2.
	%  getName - returns the name of the importer of pipeline from BRAPH2.
	%  getClass - returns the class of the importer of pipeline from BRAPH2.
	%
	% ImporterPipelineBRAPH2 methods:
	%  uigetfile - E opens a dialog box to get the BRAPH2 file from where to load the pipeline.
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
	% ImporterPipelineBRAPH2 methods (operators):
	%  isequal - determines whether two ImporterPipelineBRAPH2 are equal (values, locked)
	%
	% ImporterPipelineBRAPH2 methods (display):
	%  tostring - string with information about the ImporterPipelineBRAPH2
	%  disp - displays information about the ImporterPipelineBRAPH2
	%  tree - displays the element of ImporterPipelineBRAPH2
	%
	% ImporterPipelineBRAPH2 method (element list):
	%  getElementList - returns a list with all subelements of ImporterPipelineBRAPH2
	%
	% ImporterPipelineBRAPH2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ImporterPipelineBRAPH2
	%
	% ImporterPipelineBRAPH2 method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ImporterPipelineBRAPH2
	%
	% ImporterPipelineBRAPH2 methods (copy):
	%  copy - copies the ImporterPipelineBRAPH2
	%  deepclone - deep-clones the ImporterPipelineBRAPH2
	%  clone - clones the ImporterPipelineBRAPH2
	%
	% ImporterPipelineBRAPH2 methods (inspection, Static):
	%  getClass - returns ImporterPipelineBRAPH2
	%  getName - returns the name of ImporterPipelineBRAPH2
	%  getDescription - returns the description of ImporterPipelineBRAPH2
	%  getProps - returns the property list of ImporterPipelineBRAPH2
	%  getPropNumber - returns the property number of ImporterPipelineBRAPH2
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
	% ImporterPipelineBRAPH2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterPipelineBRAPH2 methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ImporterPipelineBRAPH2 methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ImporterPipelineBRAPH2 methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ImporterPipelineBRAPH2 properties (Constant).
	%  FILE - 5
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
	%  PIP - 6
	%  PIP_TAG - 'pip'
	%  PIP_CATEGORY - 'r'
	%  PIP_FORMAT - 'it'
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
	% See also Importer, Pipeline, ExporterPipelineBRAPH2..
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		PIP = Importer.getPropNumber() + 2;
		PIP_TAG = 'pip';
		PIP_CATEGORY = Category.RESULT;
		PIP_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function im_class = getClass()
			%GETCLASS returns the class of the importer of pipeline from BRAPH2.
			%
			% CLASS = ImporterPipelineBRAPH2.GETCLASS() returns the class 'ImporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of pipeline from BRAPH2 IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterPipelineBRAPH2') returns 'ImporterPipelineBRAPH2'.
			%
			% See also getName, getDescription.
			
			im_class = 'ImporterPipelineBRAPH2';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer of pipeline from BRAPH2.
			%
			% NAME = ImporterPipelineBRAPH2.GETNAME() returns the name of the 'importer of pipeline from BRAPH2'.
			%  Importer Of Pipeline From BRAPH2.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer of pipeline from BRAPH2 IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('ImporterPipelineBRAPH2') returns the name of 'ImporterPipelineBRAPH2'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer Of Pipeline From BRAPH2';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer of pipeline from BRAPH2.
			%
			% STR = ImporterPipelineBRAPH2.GETDESCRIPTION() returns the description of the 'importer of pipeline from BRAPH2'.
			%  which is:
			%
			%  ImporterPipelineBRAPH2 imports a pipeline from a BRAPH2 file.
			%  The format of the BRAPH2 file should include the label, description and at least one code section.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer of pipeline from BRAPH2 IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('ImporterPipelineBRAPH2') returns the description of 'ImporterPipelineBRAPH2'.
			%
			% See also getClass, getName.
			
			im_description = [
				'ImporterPipelineBRAPH2 imports a pipeline from a BRAPH2 file.' ...
				'The format of the BRAPH2 file should include the label, description and at least one code section.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of pipeline from BRAPH2.
			%
			% PROPS = ImporterPipelineBRAPH2.GETPROPS() returns the property list of importer of pipeline from BRAPH2.
			%
			% PROPS = ImporterPipelineBRAPH2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of pipeline from BRAPH2 IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterPipelineBRAPH2'[, CATEGORY]) returns the property list of 'ImporterPipelineBRAPH2'.
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
						ImporterPipelineBRAPH2.FILE
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT)
						ImporterPipelineBRAPH2.PIP
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
						ImporterPipelineBRAPH2.FILE
						ImporterPipelineBRAPH2.PIP
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer of pipeline from BRAPH2.
			%
			% N = ImporterPipelineBRAPH2.GETPROPNUMBER() returns the property number of importer of pipeline from BRAPH2.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer of pipeline from BRAPH2 IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterPipelineBRAPH2') returns the property number of 'ImporterPipelineBRAPH2'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of pipeline from BRAPH2/error.
			%
			% CHECK = ImporterPipelineBRAPH2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterPipelineBRAPH2, PROP) checks whether PROP exists for ImporterPipelineBRAPH2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(ImporterPipelineBRAPH2, PROP) throws error if PROP does NOT exist for ImporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					ImporterPipelineBRAPH2.existsProp(prop), ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterPipelineBRAPH2.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of pipeline from BRAPH2/error.
			%
			% CHECK = ImporterPipelineBRAPH2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterPipelineBRAPH2, TAG) checks whether TAG exists for ImporterPipelineBRAPH2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(ImporterPipelineBRAPH2, TAG) throws error if TAG does NOT exist for ImporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importerpipelinebraph2_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'pip' };
				
				check = any(strcmpi(tag, importerpipelinebraph2_tag_list));
			else
				assert( ...
					ImporterPipelineBRAPH2.existsTag(tag), ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ImporterPipelineBRAPH2'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterPipelineBRAPH2, POINTER) returns property number of POINTER of ImporterPipelineBRAPH2.
			%  PROPERTY = IM.GETPROPPROP(ImporterPipelineBRAPH2, POINTER) returns property number of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importerpipelinebraph2_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'pip' };
				
				tag = pointer;
				ImporterPipelineBRAPH2.existsTag(tag);
				
				prop = find(strcmpi(tag, importerpipelinebraph2_tag_list));
			else % numeric
				prop = pointer;
				ImporterPipelineBRAPH2.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ImporterPipelineBRAPH2, POINTER) returns tag of POINTER of ImporterPipelineBRAPH2.
			%  TAG = IM.GETPROPTAG(ImporterPipelineBRAPH2, POINTER) returns tag of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ImporterPipelineBRAPH2.existsTag(tag);
			else % numeric
				prop = pointer;
				ImporterPipelineBRAPH2.existsProp(prop);
				
				switch prop
					case ImporterPipelineBRAPH2.FILE
						tag = ImporterPipelineBRAPH2.FILE_TAG;
					case ImporterPipelineBRAPH2.PIP
						tag = ImporterPipelineBRAPH2.PIP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterPipelineBRAPH2, POINTER) returns category of POINTER of ImporterPipelineBRAPH2.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterPipelineBRAPH2, POINTER) returns category of POINTER of ImporterPipelineBRAPH2.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					prop_category = ImporterPipelineBRAPH2.FILE_CATEGORY;
				case ImporterPipelineBRAPH2.PIP
					prop_category = ImporterPipelineBRAPH2.PIP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterPipelineBRAPH2, POINTER) returns format of POINTER of ImporterPipelineBRAPH2.
			%  FORMAT = IM.GETPROPFORMAT(ImporterPipelineBRAPH2, POINTER) returns format of POINTER of ImporterPipelineBRAPH2.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					prop_format = ImporterPipelineBRAPH2.FILE_FORMAT;
				case ImporterPipelineBRAPH2.PIP
					prop_format = ImporterPipelineBRAPH2.PIP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterPipelineBRAPH2, POINTER) returns description of POINTER of ImporterPipelineBRAPH2.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterPipelineBRAPH2, POINTER) returns description of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					prop_description = 'FILE (data, string) is the BRAPH2 file from where to load the pipeline.';
				case ImporterPipelineBRAPH2.PIP
					prop_description = 'PIP (result, item) is a pipeline.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterPipelineBRAPH2, POINTER) returns settings of POINTER of ImporterPipelineBRAPH2.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterPipelineBRAPH2, POINTER) returns settings of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterPipelineBRAPH2.PIP
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterPipelineBRAPH2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterPipelineBRAPH2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ImporterPipelineBRAPH2.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					prop_default = Format.getFormatDefault(Format.STRING, ImporterPipelineBRAPH2.getPropSettings(prop));
				case ImporterPipelineBRAPH2.PIP
					prop_default = Pipeline();
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ImporterPipelineBRAPH2.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ImporterPipelineBRAPH2.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			prop_default = ImporterPipelineBRAPH2.conditioning(prop, ImporterPipelineBRAPH2.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ImporterPipelineBRAPH2.
			%  CHECK = IM.CHECKPROP(ImporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ImporterPipelineBRAPH2.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  Element.CHECKPROP(ImporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			%  IM.CHECKPROP(ImporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ImporterPipelineBRAPH2:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case ImporterPipelineBRAPH2.FILE
					check = Format.checkFormat(Format.STRING, value, ImporterPipelineBRAPH2.getPropSettings(prop));
				case ImporterPipelineBRAPH2.PIP
					check = Format.checkFormat(Format.ITEM, value, ImporterPipelineBRAPH2.getPropSettings(prop));
				otherwise
					check = checkProp@Importer(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterPipelineBRAPH2.getPropTag(prop) ' (' ImporterPipelineBRAPH2.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = ImporterPipelineBRAPH2(varargin)
			% ImporterPipelineBRAPH2() creates a importer of pipeline from BRAPH2.
			%
			% ImporterPipelineBRAPH2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterPipelineBRAPH2(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterPipelineBRAPH2 properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the BRAPH2 file from where to load the pipeline.
			%  <strong>6</strong> <strong>pip</strong> 	PIP (result, item) is a pipeline.
			%
			% See also Category, Format, set, check.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ImporterPipelineBRAPH2.getPropProp(pointer);
			
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
				case ImporterPipelineBRAPH2.PIP
					rng(im.getPropSeed(ImporterPipelineBRAPH2.PIP), 'twister')
					
					% creates empty Pipeline
					pip = Pipeline();
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file) && ~braph2_testing()
					    im.uigetfile()
					    file = im.memorize('FILE');
					end
					if isfile(file)
					    if im.get('WAITBAR')
					        wb = waitbar(0, 'Reading pipeline file ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					
					    try
					        txt = fileread(file);
					
					        % Pipeline
					        header_marks = regexp(txt, '%%', 'all');
					        header_txt = txt(header_marks(1):header_marks(2));
					        header_newlines = regexp(header_txt, newline(), 'all');
					
					        [~, id] = fileparts(file);
					        pip.set('ID', id)
					
					        label = strtrim(header_txt(3:header_newlines(1))); % eliminates %%
					        pip.set('LABEL', label)
					        
					        notes = strtrim(header_txt(header_newlines(1) + 4:end - 1));
					        notes_newlines = regexp(notes, newline(), 'all');
					        for i = length(notes_newlines):-1:1
					            notes = [notes(1:notes_newlines(i)) strtrim(notes(notes_newlines(i) + 2:end))]; % eliminates % but not newline
					        end
					        pip.set('NOTES', notes)
					        
					        % PipelineSection Dictionary
					        pip.set('PS_DICT', Pipeline.getPropDefault('PS_DICT'))
					        
					        txt = txt(header_marks(2):end);
					        section_marks = [regexp(txt, '%%', 'all') length(txt) + 1];
					        for s = 1:1:length(section_marks) - 1
					            section_txt = strtrim(txt(section_marks(s) + 2:section_marks(s + 1) - 1));
					            section_newlines = regexp(section_txt, newline(), 'all');
					
					            ps = PipelineSection( ...
					                'ID', int2str(s), ...
					                'Label', strtrim(section_txt(1:section_newlines(1))) ...
					                );
					            pip.get('PS_DICT').add(ps)
					            
					            % PipelineCode Dictionary
					            ps.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'))
					            
					            section_txt = section_txt(section_newlines(1):end);
					            code_marks = [regexp(section_txt, newline(), 'all') length(section_txt) + 1];
					            for c = 1:1:length(code_marks) - 1
					                if im.get('WAITBAR')
					                    waitbar(.00 + 1.00 * (s - 1 + c / (length(code_marks) - 1)) / (length(section_marks) - 1), wb, ...
					                        ['Loading pipeline section ' num2str(s) ' of ' num2str(length(section_marks) - 1) ...
					                        ', code line ' num2str(c) ' of ' num2str(length(code_marks) - 1) ' ...'])
					                end
					                
					                code_txt = strtrim(section_txt(code_marks(c):code_marks(c + 1) - 1));
					
					                text = strtrim(code_txt(regexp(code_txt, ';', 'once') + 1:end));
					                text = text(2:end); % removes initial %
					                text_before_exec = strtrim(text(1:regexp(text, '%', 'once') - 1));
					                text_after_exec = strtrim(text(regexp(text, '%', 'once') + 1:end));
					                
					                pc = PipelineCode( ...
					                    'ID', int2str(c), ...
					                    'MONIKER', strtrim(code_txt(1:regexp(code_txt, '=', 'once') - 1)), ...
					                    'TEXT_BEFORE_EXEC', text_before_exec, ...
					                    'TEXT_AFTER_EXEC', text_after_exec, ...
					                    'CODE', strtrim(code_txt(regexp(code_txt, '=', 'once') + 1:regexp(code_txt, ';', 'once'))) ...
					                    );
					                ps.get('PC_DICT').add(pc)
					            end
					        end
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
					
					value = pip;
					
				otherwise
					value = calculateValue@Importer(im, prop);
					
			end
		end
	end
	methods % methods
		function uigetfile(im)
		    % UIGETFILE opens a dialog box to get the BRAPH2 file from where to load the pipeline.
		    
		    [filename, filepath, filterindex] = uigetfile(BRAPH2.EXT_PIPELINE, 'Select TXT file');
		    if filterindex
		        file = [filepath filename];
		        im.set('FILE', file);
		    end
		end
	end
end
