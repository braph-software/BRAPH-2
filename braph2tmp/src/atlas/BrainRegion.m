classdef BrainRegion < Element
	% BrainRegion is a brain region.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% BrainRegion contains the information of a brain region.
	% It provides the methods necessary to handle the brain regions data.
	% BrainRegion contains and manages the id, label, x coordinate, y 
	% coordinate, and z coordinate of a brain region.
	%
	% The list of BrainRegion properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain region.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain region.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain region.
	%  <strong>4</strong> <strong>x</strong> 	X (data, scalar) is the x-coordinate of the brain region.
	%  <strong>5</strong> <strong>y</strong> 	Y (data, scalar) is the y-coordinate of the brain region.
	%  <strong>6</strong> <strong>z</strong> 	Z (data, scalar) is the z-coordinate of the brain region.
	%
	% BrainRegion methods (constructor):
	% BrainRegion - constructor
	%
	% BrainRegion methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in brain region/error.
	%  existsProp - checks whether property exists in brain region/error.
	%  getPropNumber - returns the property number of brain region.
	%  getProps - returns the property list of brain region.
	%  getDescription - returns the description of the brain region.
	%  getName - returns the name of the brain region.
	%  getClass - returns the class of the brain region.
	%
	% BrainRegion methods:
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
	% BrainRegion methods (operators):
	%  isequal - determines whether two BrainRegion are equal (values, locked)
	%
	% BrainRegion methods (display):
	%  tostring - string with information about the BrainRegion
	%  disp - displays information about the BrainRegion
	%  tree - displays the element of BrainRegion
	%
	% BrainRegion method (element list):
	%  getElementList - returns a list with all subelements of BrainRegion
	%
	% BrainRegion method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the BrainRegion
	%
	% BrainRegion method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the BrainRegion
	%
	% BrainRegion methods (copy):
	%  copy - copies the BrainRegion
	%  deepclone - deep-clones the BrainRegion
	%  clone - clones the BrainRegion
	%
	% BrainRegion methods (inspection, Static):
	%  getClass - returns BrainRegion
	%  getName - returns the name of BrainRegion
	%  getDescription - returns the description of BrainRegion
	%  getProps - returns the property list of BrainRegion
	%  getPropNumber - returns the property number of BrainRegion
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
	% BrainRegion methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainRegion methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% BrainRegion methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% BrainRegion methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% BrainRegion properties (Constant).
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
	%  X - 4
	%  X_TAG - 'x'
	%  X_CATEGORY - 'd'
	%  X_FORMAT - 'nn'
	%  Y - 5
	%  Y_TAG - 'y'
	%  Y_CATEGORY - 'd'
	%  Y_FORMAT - 'nn'
	%  Z - 6
	%  Z_TAG - 'z'
	%  Z_CATEGORY - 'd'
	%  Z_FORMAT - 'nn'
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
	% See also Element, BrainAtlas, BrainSurface.
	
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
		
		X = 4;
		X_TAG = 'x';
		X_CATEGORY = Category.DATA;
		X_FORMAT = Format.SCALAR;
		
		Y = 5;
		Y_TAG = 'y';
		Y_CATEGORY = Category.DATA;
		Y_FORMAT = Format.SCALAR;
		
		Z = 6;
		Z_TAG = 'z';
		Z_CATEGORY = Category.DATA;
		Z_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function br_class = getClass()
			%GETCLASS returns the class of the brain region.
			%
			% CLASS = BrainRegion.GETCLASS() returns the class 'BrainRegion'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BR.GETCLASS() returns the class of the brain region BR.
			%  CLASS = Element.GETCLASS(BR) returns the class of 'BR'.
			%  CLASS = Element.GETCLASS('BrainRegion') returns 'BrainRegion'.
			%
			% See also getName, getDescription.
			
			br_class = 'BrainRegion';
		end
		function br_name = getName()
			%GETNAME returns the name of the brain region.
			%
			% NAME = BrainRegion.GETNAME() returns the name of the 'brain region'.
			%  Brain Region.
			%
			% Alternative forms to call this method are:
			%  NAME = BR.GETNAME() returns the name of the brain region BR.
			%  NAME = Element.GETNAME(BR) returns the name of 'BR'.
			%  NAME = Element.GETNAME('BrainRegion') returns the name of 'BrainRegion'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			br_name = 'Brain Region';
		end
		function br_description = getDescription()
			%GETDESCRIPTION returns the description of the brain region.
			%
			% STR = BrainRegion.GETDESCRIPTION() returns the description of the 'brain region'.
			%  which is:
			%
			%  BrainRegion contains the information of a brain region.
			%  It provides the methods necessary to handle the brain regions data.
			%  BrainRegion contains and manages the id, label, x coordinate, y 
			%  coordinate, and z coordinate of a brain region.
			%
			% Alternative forms to call this method are:
			%  STR = BR.GETDESCRIPTION() returns the description of the brain region BR.
			%  STR = Element.GETDESCRIPTION(BR) returns the description of 'BR'.
			%  STR = Element.GETDESCRIPTION('BrainRegion') returns the description of 'BrainRegion'.
			%
			% See also getClass, getName.
			
			br_description = [
				'BrainRegion contains the information of a brain region.' ...
				'It provides the methods necessary to handle the brain regions data.' ...
				'BrainRegion contains and manages the id, label, x coordinate, y ' ...
				'coordinate, and z coordinate of a brain region.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain region.
			%
			% PROPS = BrainRegion.GETPROPS() returns the property list of brain region.
			%
			% PROPS = BrainRegion.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BR.GETPROPS([CATEGORY]) returns the property list of the brain region BR.
			%  PROPS = Element.GETPROPS(BR[, CATEGORY]) returns the property list of 'BR'.
			%  PROPS = Element.GETPROPS('BrainRegion'[, CATEGORY]) returns the property list of 'BrainRegion'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						BrainRegion.LABEL
						BrainRegion.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						BrainRegion.ID
						BrainRegion.X
						BrainRegion.Y
						BrainRegion.Z
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
						BrainRegion.ID
						BrainRegion.LABEL
						BrainRegion.NOTES
						BrainRegion.X
						BrainRegion.Y
						BrainRegion.Z
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of brain region.
			%
			% N = BrainRegion.GETPROPNUMBER() returns the property number of brain region.
			%
			% Alternative forms to call this method are:
			%  N = BR.GETPROPNUMBER() returns the property number of the brain region BR.
			%  N = Element.GETPROPNUMBER(BR) returns the property number of 'BR'.
			%  N = Element.GETPROPNUMBER('BrainRegion') returns the property number of 'BrainRegion'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain region/error.
			%
			% CHECK = BrainRegion.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSPROP(PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BR, PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BrainRegion, PROP) checks whether PROP exists for BrainRegion.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSPROP(PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSPROP(BR, PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSPROP(BrainRegion, PROP) throws error if PROP does NOT exist for BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					BrainRegion.existsProp(prop), ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainRegion.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain region/error.
			%
			% CHECK = BrainRegion.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSTAG(TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BR, TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BrainRegion, TAG) checks whether TAG exists for BrainRegion.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSTAG(TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSTAG(BR, TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSTAG(BrainRegion, TAG) throws error if TAG does NOT exist for BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				brainregion_tag_list = { 'id'  'label'  'notes'  'x'  'y'  'z' };
				
				check = any(strcmpi(tag, brainregion_tag_list));
			else
				assert( ...
					BrainRegion.existsTag(tag), ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for BrainRegion'] ...
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
			%  PROPERTY = BR.GETPROPPROP(POINTER) returns property number of POINTER of BR.
			%  PROPERTY = Element.GETPROPPROP(BrainRegion, POINTER) returns property number of POINTER of BrainRegion.
			%  PROPERTY = BR.GETPROPPROP(BrainRegion, POINTER) returns property number of POINTER of BrainRegion.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				brainregion_tag_list = { 'id'  'label'  'notes'  'x'  'y'  'z' };
				
				tag = pointer;
				BrainRegion.existsTag(tag);
				
				prop = find(strcmpi(tag, brainregion_tag_list));
			else % numeric
				prop = pointer;
				BrainRegion.existsProp(prop);
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
			%  TAG = BR.GETPROPTAG(POINTER) returns tag of POINTER of BR.
			%  TAG = Element.GETPROPTAG(BrainRegion, POINTER) returns tag of POINTER of BrainRegion.
			%  TAG = BR.GETPROPTAG(BrainRegion, POINTER) returns tag of POINTER of BrainRegion.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				BrainRegion.existsTag(tag);
			else % numeric
				prop = pointer;
				BrainRegion.existsProp(prop);
				
				switch prop
					case BrainRegion.ID
						tag = BrainRegion.ID_TAG;
					case BrainRegion.LABEL
						tag = BrainRegion.LABEL_TAG;
					case BrainRegion.NOTES
						tag = BrainRegion.NOTES_TAG;
					case BrainRegion.X
						tag = BrainRegion.X_TAG;
					case BrainRegion.Y
						tag = BrainRegion.Y_TAG;
					case BrainRegion.Z
						tag = BrainRegion.Z_TAG;
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
			%  CATEGORY = BR.GETPROPCATEGORY(POINTER) returns category of POINTER of BR.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainRegion, POINTER) returns category of POINTER of BrainRegion.
			%  CATEGORY = BR.GETPROPCATEGORY(BrainRegion, POINTER) returns category of POINTER of BrainRegion.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					prop_category = BrainRegion.ID_CATEGORY;
				case BrainRegion.LABEL
					prop_category = BrainRegion.LABEL_CATEGORY;
				case BrainRegion.NOTES
					prop_category = BrainRegion.NOTES_CATEGORY;
				case BrainRegion.X
					prop_category = BrainRegion.X_CATEGORY;
				case BrainRegion.Y
					prop_category = BrainRegion.Y_CATEGORY;
				case BrainRegion.Z
					prop_category = BrainRegion.Z_CATEGORY;
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
			%  FORMAT = BR.GETPROPFORMAT(POINTER) returns format of POINTER of BR.
			%  FORMAT = Element.GETPROPFORMAT(BrainRegion, POINTER) returns format of POINTER of BrainRegion.
			%  FORMAT = BR.GETPROPFORMAT(BrainRegion, POINTER) returns format of POINTER of BrainRegion.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					prop_format = BrainRegion.ID_FORMAT;
				case BrainRegion.LABEL
					prop_format = BrainRegion.LABEL_FORMAT;
				case BrainRegion.NOTES
					prop_format = BrainRegion.NOTES_FORMAT;
				case BrainRegion.X
					prop_format = BrainRegion.X_FORMAT;
				case BrainRegion.Y
					prop_format = BrainRegion.Y_FORMAT;
				case BrainRegion.Z
					prop_format = BrainRegion.Z_FORMAT;
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
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainRegion, POINTER) returns description of POINTER of BrainRegion.
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(BrainRegion, POINTER) returns description of POINTER of BrainRegion.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain region.';
				case BrainRegion.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain region.';
				case BrainRegion.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain region.';
				case BrainRegion.X
					prop_description = 'X (data, scalar) is the x-coordinate of the brain region.';
				case BrainRegion.Y
					prop_description = 'Y (data, scalar) is the y-coordinate of the brain region.';
				case BrainRegion.Z
					prop_description = 'Z (data, scalar) is the z-coordinate of the brain region.';
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
			%  SETTINGS = BR.GETPROPSETTINGS(POINTER) returns settings of POINTER of BR.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainRegion, POINTER) returns settings of POINTER of BrainRegion.
			%  SETTINGS = BR.GETPROPSETTINGS(BrainRegion, POINTER) returns settings of POINTER of BrainRegion.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainRegion.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainRegion.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainRegion.X
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainRegion.Y
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case BrainRegion.Z
					prop_settings = Format.getFormatSettings(Format.SCALAR);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainRegion, POINTER) returns the default value of POINTER of BrainRegion.
			%  DEFAULT = BR.GETPROPDEFAULT(BrainRegion, POINTER) returns the default value of POINTER of BrainRegion.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					prop_default = Format.getFormatDefault(Format.STRING, BrainRegion.getPropSettings(prop));
				case BrainRegion.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, BrainRegion.getPropSettings(prop));
				case BrainRegion.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, BrainRegion.getPropSettings(prop));
				case BrainRegion.X
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainRegion.getPropSettings(prop));
				case BrainRegion.Y
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainRegion.getPropSettings(prop));
				case BrainRegion.Z
					prop_default = Format.getFormatDefault(Format.SCALAR, BrainRegion.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainRegion, POINTER) returns the conditioned default value of POINTER of BrainRegion.
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(BrainRegion, POINTER) returns the conditioned default value of POINTER of BrainRegion.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			prop_default = BrainRegion.conditioning(prop, BrainRegion.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BR.
			%  CHECK = Element.CHECKPROP(BrainRegion, PROP, VALUE) checks VALUE format for PROP of BrainRegion.
			%  CHECK = BR.CHECKPROP(BrainRegion, PROP, VALUE) checks VALUE format for PROP of BrainRegion.
			% 
			% BR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:BrainRegion:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.CHECKPROP(BrainRegion, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  BR.CHECKPROP(BrainRegion, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case BrainRegion.ID
					check = Format.checkFormat(Format.STRING, value, BrainRegion.getPropSettings(prop));
				case BrainRegion.LABEL
					check = Format.checkFormat(Format.STRING, value, BrainRegion.getPropSettings(prop));
				case BrainRegion.NOTES
					check = Format.checkFormat(Format.STRING, value, BrainRegion.getPropSettings(prop));
				case BrainRegion.X
					check = Format.checkFormat(Format.SCALAR, value, BrainRegion.getPropSettings(prop));
				case BrainRegion.Y
					check = Format.checkFormat(Format.SCALAR, value, BrainRegion.getPropSettings(prop));
				case BrainRegion.Z
					check = Format.checkFormat(Format.SCALAR, value, BrainRegion.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainRegion.getPropTag(prop) ' (' BrainRegion.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function br = BrainRegion(varargin)
			% BrainRegion() creates a brain region.
			%
			% BrainRegion(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainRegion(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainRegion properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain region.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain region.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain region.
			%  <strong>4</strong> <strong>x</strong> 	X (data, scalar) is the x-coordinate of the brain region.
			%  <strong>5</strong> <strong>y</strong> 	Y (data, scalar) is the y-coordinate of the brain region.
			%  <strong>6</strong> <strong>z</strong> 	Z (data, scalar) is the z-coordinate of the brain region.
			%
			% See also Category, Format, set, check.
			
			br = br@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
