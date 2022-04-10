classdef ImporterBrainSurfaceNV < Importer
	% ImporterBrainSurfaceNV imports a brain surface from a NV file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterBrainSurfaceNV imports a brain surface from a NV file.
	%
	% The list of ImporterBrainSurfaceNV properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the NV file from where to load the brain atlas.
	%  <strong>6</strong> <strong>surf</strong> 	SURF (result, item) is a brain surface.
	%
	% ImporterBrainSurfaceNV methods (constructor):
	% ImporterBrainSurfaceNV - constructor
	%
	% ImporterBrainSurfaceNV methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer of brain surface from NV/error.
	%  existsProp - checks whether property exists in importer of brain surface from NV/error.
	%  getPropNumber - returns the property number of importer of brain surface from NV.
	%  getProps - returns the property list of importer of brain surface from NV.
	%  getDescription - returns the description of the importer of brain surface from NV.
	%  getName - returns the name of the importer of brain surface from NV.
	%  getClass - returns the class of the importer of brain surface from NV.
	%
	% ImporterBrainSurfaceNV methods:
	%  uigetfile - E opens a dialog box to set the NV file where to save the brain atlas.
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
	% ImporterBrainSurfaceNV methods (operators):
	%  isequal - determines whether two ImporterBrainSurfaceNV are equal (values, locked)
	%
	% ImporterBrainSurfaceNV methods (display):
	%  tostring - string with information about the ImporterBrainSurfaceNV
	%  disp - displays information about the ImporterBrainSurfaceNV
	%  tree - displays the element of ImporterBrainSurfaceNV
	%
	% ImporterBrainSurfaceNV method (element list):
	%  getElementList - returns a list with all subelements of ImporterBrainSurfaceNV
	%
	% ImporterBrainSurfaceNV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ImporterBrainSurfaceNV
	%
	% ImporterBrainSurfaceNV method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ImporterBrainSurfaceNV
	%
	% ImporterBrainSurfaceNV methods (copy):
	%  copy - copies the ImporterBrainSurfaceNV
	%  deepclone - deep-clones the ImporterBrainSurfaceNV
	%  clone - clones the ImporterBrainSurfaceNV
	%
	% ImporterBrainSurfaceNV methods (inspection, Static):
	%  getClass - returns ImporterBrainSurfaceNV
	%  getName - returns the name of ImporterBrainSurfaceNV
	%  getDescription - returns the description of ImporterBrainSurfaceNV
	%  getProps - returns the property list of ImporterBrainSurfaceNV
	%  getPropNumber - returns the property number of ImporterBrainSurfaceNV
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
	% ImporterBrainSurfaceNV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainSurfaceNV methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ImporterBrainSurfaceNV methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ImporterBrainSurfaceNV methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ImporterBrainSurfaceNV properties (Constant).
	%  FILE - 5
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
	%  SURF - 6
	%  SURF_TAG - 'surf'
	%  SURF_CATEGORY - 'r'
	%  SURF_FORMAT - 'it'
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
	% See also Element, Importer, BrainSurface..
	
	properties (Constant) % properties
		FILE = Importer.getPropNumber() + 1;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		SURF = Importer.getPropNumber() + 2;
		SURF_TAG = 'surf';
		SURF_CATEGORY = Category.RESULT;
		SURF_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function im_class = getClass()
			%GETCLASS returns the class of the importer of brain surface from NV.
			%
			% CLASS = ImporterBrainSurfaceNV.GETCLASS() returns the class 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of brain surface from NV IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainSurfaceNV') returns 'ImporterBrainSurfaceNV'.
			%
			% See also getName, getDescription.
			
			im_class = 'ImporterBrainSurfaceNV';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer of brain surface from NV.
			%
			% NAME = ImporterBrainSurfaceNV.GETNAME() returns the name of the 'importer of brain surface from NV'.
			%  Importer Of Brain Surface From NV.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer of brain surface from NV IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('ImporterBrainSurfaceNV') returns the name of 'ImporterBrainSurfaceNV'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer Of Brain Surface From NV';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer of brain surface from NV.
			%
			% STR = ImporterBrainSurfaceNV.GETDESCRIPTION() returns the description of the 'importer of brain surface from NV'.
			%  which is:
			%
			%  ImporterBrainSurfaceNV imports a brain surface from a NV file.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer of brain surface from NV IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('ImporterBrainSurfaceNV') returns the description of 'ImporterBrainSurfaceNV'.
			%
			% See also getClass, getName.
			
			im_description = [
				'ImporterBrainSurfaceNV imports a brain surface from a NV file.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of brain surface from NV.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS() returns the property list of importer of brain surface from NV.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of brain surface from NV IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainSurfaceNV'[, CATEGORY]) returns the property list of 'ImporterBrainSurfaceNV'.
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
						ImporterBrainSurfaceNV.FILE
						];
				case Category.RESULT
					prop_list = [
						Importer.getProps(Category.RESULT)
						ImporterBrainSurfaceNV.SURF
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
						ImporterBrainSurfaceNV.FILE
						ImporterBrainSurfaceNV.SURF
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer of brain surface from NV.
			%
			% N = ImporterBrainSurfaceNV.GETPROPNUMBER() returns the property number of importer of brain surface from NV.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer of brain surface from NV IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainSurfaceNV') returns the property number of 'ImporterBrainSurfaceNV'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of brain surface from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) checks whether PROP exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) throws error if PROP does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					ImporterBrainSurfaceNV.existsProp(prop), ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainSurfaceNV.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of brain surface from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) checks whether TAG exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) throws error if TAG does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importerbrainsurfacenv_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'surf' };
				
				check = any(strcmpi(tag, importerbrainsurfacenv_tag_list));
			else
				assert( ...
					ImporterBrainSurfaceNV.existsTag(tag), ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ImporterBrainSurfaceNV'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importerbrainsurfacenv_tag_list = { 'id'  'label'  'notes'  'waitbar'  'file'  'surf' };
				
				tag = pointer;
				ImporterBrainSurfaceNV.existsTag(tag);
				
				prop = find(strcmpi(tag, importerbrainsurfacenv_tag_list));
			else % numeric
				prop = pointer;
				ImporterBrainSurfaceNV.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%  TAG = IM.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ImporterBrainSurfaceNV.existsTag(tag);
			else % numeric
				prop = pointer;
				ImporterBrainSurfaceNV.existsProp(prop);
				
				switch prop
					case ImporterBrainSurfaceNV.FILE
						tag = ImporterBrainSurfaceNV.FILE_TAG;
					case ImporterBrainSurfaceNV.SURF
						tag = ImporterBrainSurfaceNV.SURF_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_category = ImporterBrainSurfaceNV.FILE_CATEGORY;
				case ImporterBrainSurfaceNV.SURF
					prop_category = ImporterBrainSurfaceNV.SURF_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_format = ImporterBrainSurfaceNV.FILE_FORMAT;
				case ImporterBrainSurfaceNV.SURF
					prop_format = ImporterBrainSurfaceNV.SURF_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_description = 'FILE (data, string) is the NV file from where to load the brain atlas.';
				case ImporterBrainSurfaceNV.SURF
					prop_description = 'SURF (result, item) is a brain surface.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ImporterBrainSurfaceNV.SURF
					prop_settings = 'BrainSurface';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					prop_default = 'human_ICBM152.nv';
				case ImporterBrainSurfaceNV.SURF
					prop_default = Format.getFormatDefault(Format.ITEM, ImporterBrainSurfaceNV.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			prop_default = ImporterBrainSurfaceNV.conditioning(prop, ImporterBrainSurfaceNV.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			%  CHECK = IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case ImporterBrainSurfaceNV.FILE
					check = Format.checkFormat(Format.STRING, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case ImporterBrainSurfaceNV.SURF
					check = Format.checkFormat(Format.ITEM, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				otherwise
					check = checkProp@Importer(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainSurfaceNV.getPropTag(prop) ' (' ImporterBrainSurfaceNV.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = ImporterBrainSurfaceNV(varargin)
			% ImporterBrainSurfaceNV() creates a importer of brain surface from NV.
			%
			% ImporterBrainSurfaceNV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainSurfaceNV(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterBrainSurfaceNV properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>file</strong> 	FILE (data, string) is the NV file from where to load the brain atlas.
			%  <strong>6</strong> <strong>surf</strong> 	SURF (result, item) is a brain surface.
			%
			% See also Category, Format, set, check.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
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
				case ImporterBrainSurfaceNV.SURF
					rng(im.getPropSeed(ImporterBrainSurfaceNV.SURF), 'twister')
					
					% creates empty BrainSurface
					bs = BrainSurface();
					
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file)
					    file = [fileparts(which('braph2')) filesep 'brainsurfs' filesep file];
					end
					
					if isfile(file)
					    if im.get('WAITBAR')
					        wb = waitbar(.15, 'Reading brain surface file ...', 'Name', BRAPH2.NAME);
					        set_braph2icon(wb)
					    end
					    
					    fid = fopen(file);
					    vertex_number = fscanf(fid, '%f', 1);
					    coord = fscanf(fid, '%f', [3, vertex_number])';
					    tri_number = fscanf(fid, '%f', 1);
					    tri = fscanf(fid, '%d', [3, tri_number])';
					    fclose(fid);
					    
					    splits = split(file, filesep);
					    name = splits{end};
					    
					    bs.set('ID', name)
					    bs.set('vertex_number', vertex_number);
					    bs.set('coordinates', coord);
					    bs.set('triangles_number', tri_number);
					    bs.set('triangles', tri);
					    
					    if im.get('WAITBAR')
					        close(wb)
					    end    
					end
					
					value = bs;
					
				otherwise
					value = calculateValue@Importer(im, prop);
					
			end
		end
	end
	methods % methods
		function uigetfile(im)
		    % UIGETFILE opens a dialog box to set the NV file where to save the brain atlas.
		
		    [filename, filepath, filterindex] = uigetfile('*.nv', 'Select NV file');
		    if filterindex
		        file = [filepath filename];
		        im.set('FILE', file);
		    end
		end
	end
end
