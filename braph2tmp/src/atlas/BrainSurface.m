classdef BrainSurface < Element
	% BrainSurface is a brain surface.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% BrainSurface contains the information of a brain surface.
	% It provides the methods necessary to handle the brain surface data.
	% BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and 
	% triangles of a brain surface.
	%
	% The list of BrainSurface properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain surface.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain surface.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain surface.
	%  <strong>4</strong> <strong>vertex_number</strong> 	VERTEX_NUMBER (data, scalar) is the number of triangles vertices.
	%  <strong>5</strong> <strong>coordinates</strong> 	COORDINATES (data, matrix) is the coordinates of the triangles vertices.
	%  <strong>6</strong> <strong>triangles_number</strong> 	TRIANGLES_NUMBER (data, scalar) is the number of triangles.
	%  <strong>7</strong> <strong>triangles</strong> 	TRIANGLES (data, matrix) is the triad of coordinates identifiers to create a triangle.
	%
	% BrainSurface methods (constructor):
	% BrainSurface - constructor
	%
	% BrainSurface methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in brain surface/error.
	%  existsProp - checks whether property exists in brain surface/error.
	%  getPropNumber - returns the property number of brain surface.
	%  getProps - returns the property list of brain surface.
	%  getDescription - returns the description of the brain surface.
	%  getName - returns the name of the brain surface.
	%  getClass - returns the class of the brain surface.
	%
	% BrainSurface methods:
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
	% BrainSurface methods (operators):
	%  isequal - determines whether two BrainSurface are equal (values, locked)
	%
	% BrainSurface methods (display):
	%  tostring - string with information about the BrainSurface
	%  disp - displays information about the BrainSurface
	%  tree - displays the element of BrainSurface
	%
	% BrainSurface method (element list):
	%  getElementList - returns a list with all subelements of BrainSurface
	%
	% BrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the BrainSurface
	%
	% BrainSurface method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the BrainSurface
	%
	% BrainSurface methods (copy):
	%  copy - copies the BrainSurface
	%  deepclone - deep-clones the BrainSurface
	%  clone - clones the BrainSurface
	%
	% BrainSurface methods (inspection, Static):
	%  getClass - returns BrainSurface
	%  getName - returns the name of BrainSurface
	%  getDescription - returns the description of BrainSurface
	%  getProps - returns the property list of BrainSurface
	%  getPropNumber - returns the property number of BrainSurface
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
	% BrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainSurface methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% BrainSurface methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% BrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% BrainSurface properties (Constant).
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
	%  VERTEX_NUMBER - 4
	%  VERTEX_NUMBER_TAG - 'vertex_number'
	%  VERTEX_NUMBER_CATEGORY - 'd'
	%  VERTEX_NUMBER_FORMAT - 'nn'
	%  COORDINATES - 5
	%  COORDINATES_TAG - 'coordinates'
	%  COORDINATES_CATEGORY - 'd'
	%  COORDINATES_FORMAT - 'nm'
	%  TRIANGLES_NUMBER - 6
	%  TRIANGLES_NUMBER_TAG - 'triangles_number'
	%  TRIANGLES_NUMBER_CATEGORY - 'd'
	%  TRIANGLES_NUMBER_FORMAT - 'nn'
	%  TRIANGLES - 7
	%  TRIANGLES_TAG - 'triangles'
	%  TRIANGLES_CATEGORY - 'd'
	%  TRIANGLES_FORMAT - 'nm'
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
	% See also Element, BrainAtlas, BrainRegion.
	
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = 2;
		LABEL_TAG = 'label';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = 3;
		NOTES_TAG = 'notes';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		VERTEX_NUMBER = 4;
		VERTEX_NUMBER_TAG = 'vertex_number';
		VERTEX_NUMBER_CATEGORY = Category.DATA;
		VERTEX_NUMBER_FORMAT = Format.SCALAR;
		
		COORDINATES = 5;
		COORDINATES_TAG = 'coordinates';
		COORDINATES_CATEGORY = Category.DATA;
		COORDINATES_FORMAT = Format.MATRIX;
		
		TRIANGLES_NUMBER = 6;
		TRIANGLES_NUMBER_TAG = 'triangles_number';
		TRIANGLES_NUMBER_CATEGORY = Category.DATA;
		TRIANGLES_NUMBER_FORMAT = Format.SCALAR;
		
		TRIANGLES = 7;
		TRIANGLES_TAG = 'triangles';
		TRIANGLES_CATEGORY = Category.DATA;
		TRIANGLES_FORMAT = Format.MATRIX;
	end
	methods (Static) % inspection methods
		function bs_class = getClass()
			%GETCLASS returns the class of the brain surface.
			%
			% CLASS = BrainSurface.GETCLASS() returns the class 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BS.GETCLASS() returns the class of the brain surface BS.
			%  CLASS = Element.GETCLASS(BS) returns the class of 'BS'.
			%  CLASS = Element.GETCLASS('BrainSurface') returns 'BrainSurface'.
			%
			% See also getName, getDescription.
			
			bs_class = 'BrainSurface';
		end
		function bs_name = getName()
			%GETNAME returns the name of the brain surface.
			%
			% NAME = BrainSurface.GETNAME() returns the name of the 'brain surface'.
			%  Brain Surface.
			%
			% Alternative forms to call this method are:
			%  NAME = BS.GETNAME() returns the name of the brain surface BS.
			%  NAME = Element.GETNAME(BS) returns the name of 'BS'.
			%  NAME = Element.GETNAME('BrainSurface') returns the name of 'BrainSurface'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			bs_name = 'Brain Surface';
		end
		function bs_description = getDescription()
			%GETDESCRIPTION returns the description of the brain surface.
			%
			% STR = BrainSurface.GETDESCRIPTION() returns the description of the 'brain surface'.
			%  which is:
			%
			%  BrainSurface contains the information of a brain surface.
			%  It provides the methods necessary to handle the brain surface data.
			%  BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and 
			%  triangles of a brain surface.
			%
			% Alternative forms to call this method are:
			%  STR = BS.GETDESCRIPTION() returns the description of the brain surface BS.
			%  STR = Element.GETDESCRIPTION(BS) returns the description of 'BS'.
			%  STR = Element.GETDESCRIPTION('BrainSurface') returns the description of 'BrainSurface'.
			%
			% See also getClass, getName.
			
			bs_description = [
				'BrainSurface contains the information of a brain surface.' ...
				'It provides the methods necessary to handle the brain surface data.' ...
				'BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and ' ...
				'triangles of a brain surface.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain surface.
			%
			% PROPS = BrainSurface.GETPROPS() returns the property list of brain surface.
			%
			% PROPS = BrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BS.GETPROPS([CATEGORY]) returns the property list of the brain surface BS.
			%  PROPS = Element.GETPROPS(BS[, CATEGORY]) returns the property list of 'BS'.
			%  PROPS = Element.GETPROPS('BrainSurface'[, CATEGORY]) returns the property list of 'BrainSurface'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						BrainSurface.LABEL
						BrainSurface.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						BrainSurface.ID
						BrainSurface.VERTEX_NUMBER
						BrainSurface.COORDINATES
						BrainSurface.TRIANGLES_NUMBER
						BrainSurface.TRIANGLES
						];
				case Category.RESULT
					prop_list = [
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						BrainSurface.ID
						BrainSurface.LABEL
						BrainSurface.NOTES
						BrainSurface.VERTEX_NUMBER
						BrainSurface.COORDINATES
						BrainSurface.TRIANGLES_NUMBER
						BrainSurface.TRIANGLES
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of brain surface.
			%
			% N = BrainSurface.GETPROPNUMBER() returns the property number of brain surface.
			%
			% Alternative forms to call this method are:
			%  N = BS.GETPROPNUMBER() returns the property number of the brain surface BS.
			%  N = Element.GETPROPNUMBER(BS) returns the property number of 'BS'.
			%  N = Element.GETPROPNUMBER('BrainSurface') returns the property number of 'BrainSurface'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSPROP(PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BS, PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BrainSurface, PROP) checks whether PROP exists for BrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSPROP(PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BS, PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BrainSurface, PROP) throws error if PROP does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					BrainSurface.existsProp(prop), ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainSurface.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSTAG(TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BS, TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BrainSurface, TAG) checks whether TAG exists for BrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSTAG(TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BS, TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BrainSurface, TAG) throws error if TAG does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				brainsurface_tag_list = { 'id'  'label'  'notes'  'vertex_number'  'coordinates'  'triangles_number'  'triangles' };
				
				check = any(strcmpi(tag, brainsurface_tag_list));
			else
				assert( ...
					BrainSurface.existsTag(tag), ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for BrainSurface'] ...
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
			%  PROPERTY = BS.GETPROPPROP(POINTER) returns property number of POINTER of BS.
			%  PROPERTY = Element.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%  PROPERTY = BS.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				brainsurface_tag_list = { 'id'  'label'  'notes'  'vertex_number'  'coordinates'  'triangles_number'  'triangles' };
				
				tag = pointer;
				BrainSurface.existsTag(tag);
				
				prop = find(strcmpi(tag, brainsurface_tag_list));
			else % numeric
				prop = pointer;
				BrainSurface.existsProp(prop);
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
			%  TAG = BS.GETPROPTAG(POINTER) returns tag of POINTER of BS.
			%  TAG = Element.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%  TAG = BS.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				BrainSurface.existsTag(tag);
			else % numeric
				prop = pointer;
				BrainSurface.existsProp(prop);
				
				switch prop
					case BrainSurface.ID
						tag = BrainSurface.ID_TAG;
					case BrainSurface.LABEL
						tag = BrainSurface.LABEL_TAG;
					case BrainSurface.NOTES
						tag = BrainSurface.NOTES_TAG;
					case BrainSurface.VERTEX_NUMBER
						tag = BrainSurface.VERTEX_NUMBER_TAG;
					case BrainSurface.COORDINATES
						tag = BrainSurface.COORDINATES_TAG;
					case BrainSurface.TRIANGLES_NUMBER
						tag = BrainSurface.TRIANGLES_NUMBER_TAG;
					case BrainSurface.TRIANGLES
						tag = BrainSurface.TRIANGLES_TAG;
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
			%  CATEGORY = BS.GETPROPCATEGORY(POINTER) returns category of POINTER of BS.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%  CATEGORY = BS.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					prop_category = BrainSurface.ID_CATEGORY;
				case BrainSurface.LABEL
					prop_category = BrainSurface.LABEL_CATEGORY;
				case BrainSurface.NOTES
					prop_category = BrainSurface.NOTES_CATEGORY;
				case BrainSurface.VERTEX_NUMBER
					prop_category = BrainSurface.VERTEX_NUMBER_CATEGORY;
				case BrainSurface.COORDINATES
					prop_category = BrainSurface.COORDINATES_CATEGORY;
				case BrainSurface.TRIANGLES_NUMBER
					prop_category = BrainSurface.TRIANGLES_NUMBER_CATEGORY;
				case BrainSurface.TRIANGLES
					prop_category = BrainSurface.TRIANGLES_CATEGORY;
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
			%  FORMAT = BS.GETPROPFORMAT(POINTER) returns format of POINTER of BS.
			%  FORMAT = Element.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%  FORMAT = BS.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					prop_format = BrainSurface.ID_FORMAT;
				case BrainSurface.LABEL
					prop_format = BrainSurface.LABEL_FORMAT;
				case BrainSurface.NOTES
					prop_format = BrainSurface.NOTES_FORMAT;
				case BrainSurface.VERTEX_NUMBER
					prop_format = BrainSurface.VERTEX_NUMBER_FORMAT;
				case BrainSurface.COORDINATES
					prop_format = BrainSurface.COORDINATES_FORMAT;
				case BrainSurface.TRIANGLES_NUMBER
					prop_format = BrainSurface.TRIANGLES_NUMBER_FORMAT;
				case BrainSurface.TRIANGLES
					prop_format = BrainSurface.TRIANGLES_FORMAT;
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
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain surface.';
				case BrainSurface.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain surface.';
				case BrainSurface.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain surface.';
				case BrainSurface.VERTEX_NUMBER
					prop_description = 'VERTEX_NUMBER (data, scalar) is the number of triangles vertices.';
				case BrainSurface.COORDINATES
					prop_description = 'COORDINATES (data, matrix) is the coordinates of the triangles vertices.';
				case BrainSurface.TRIANGLES_NUMBER
					prop_description = 'TRIANGLES_NUMBER (data, scalar) is the number of triangles.';
				case BrainSurface.TRIANGLES
					prop_description = 'TRIANGLES (data, matrix) is the triad of coordinates identifiers to create a triangle.';
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
			%  SETTINGS = BS.GETPROPSETTINGS(POINTER) returns settings of POINTER of BS.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%  SETTINGS = BS.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainSurface.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainSurface.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainSurface.VERTEX_NUMBER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainSurface.COORDINATES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case BrainSurface.TRIANGLES_NUMBER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainSurface.TRIANGLES
					prop_settings = Format.getFormatSettings(Format.MATRIX);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					prop_default = Format.getFormatDefault(Format.STRING, BrainSurface.getPropSettings(prop));
				case BrainSurface.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, BrainSurface.getPropSettings(prop));
				case BrainSurface.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, BrainSurface.getPropSettings(prop));
				case BrainSurface.VERTEX_NUMBER
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainSurface.getPropSettings(prop));
				case BrainSurface.COORDINATES
					prop_default = Format.getFormatDefault(Format.MATRIX, BrainSurface.getPropSettings(prop));
				case BrainSurface.TRIANGLES_NUMBER
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainSurface.getPropSettings(prop));
				case BrainSurface.TRIANGLES
					prop_default = Format.getFormatDefault(Format.MATRIX, BrainSurface.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			prop_default = BrainSurface.conditioning(prop, BrainSurface.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BS.
			%  CHECK = Element.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			%  CHECK = BS.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			% 
			% BS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  BS.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case BrainSurface.ID
					check = Format.checkFormat(Format.STRING, value, BrainSurface.getPropSettings(prop));
				case BrainSurface.LABEL
					check = Format.checkFormat(Format.STRING, value, BrainSurface.getPropSettings(prop));
				case BrainSurface.NOTES
					check = Format.checkFormat(Format.STRING, value, BrainSurface.getPropSettings(prop));
				case BrainSurface.VERTEX_NUMBER
					check = Format.checkFormat(Format.SCALAR, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case BrainSurface.COORDINATES
					check = Format.checkFormat(Format.MATRIX, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
				case BrainSurface.TRIANGLES_NUMBER
					check = Format.checkFormat(Format.SCALAR, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case BrainSurface.TRIANGLES
					check = Format.checkFormat(Format.MATRIX, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainSurface.getPropTag(prop) ' (' BrainSurface.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function bs = BrainSurface(varargin)
			% BrainSurface() creates a brain surface.
			%
			% BrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainSurface(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainSurface properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain surface.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain surface.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain surface.
			%  <strong>4</strong> <strong>vertex_number</strong> 	VERTEX_NUMBER (data, scalar) is the number of triangles vertices.
			%  <strong>5</strong> <strong>coordinates</strong> 	COORDINATES (data, matrix) is the coordinates of the triangles vertices.
			%  <strong>6</strong> <strong>triangles_number</strong> 	TRIANGLES_NUMBER (data, scalar) is the number of triangles.
			%  <strong>7</strong> <strong>triangles</strong> 	TRIANGLES (data, matrix) is the triad of coordinates identifiers to create a triangle.
			%
			% See also Category, Format, set, check.
			
			bs = bs@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(bs, prop, value)
			check = true;
			msg = ['Error while checking' tostring(bs) ' ' bs.getPropTag(prop) '.'];
			
			switch prop
				case BrainSurface.COORDINATES
					check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1));
					if check 
					    msg = 'All ok!';
					else
					    msg = ['COORDINATES must have VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') columns while it has ' num2str(size(value, 2)) '.'];
					end
					
				case BrainSurface.TRIANGLES
					check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && all(all(value > 0)) && all(all(value <= bs.get('VERTEX_NUMBER')));
					if check 
					    msg = 'All ok!';
					else
					    msg = [ ...
					        'TRIANGLES must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' columns while it has ' num2str(size(value, 1)) '.' ...
					        'The identifiers in TRIANGLES must be greater than 0 and smaller or equal to the VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
					        'while they are ' num2str(value) '.' ...
					        ];
					end
					
				otherwise
					[check, msg] = checkValue@Element(bs, prop, value);
					
			end
		end
	end
end
