classdef BrainAtlas < Element
	% BrainAtlas is a brain atlas.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% BrainAtlas represents a brain atlas,
	% constituted by a collection of brain regions.  
	% BrainAtlas contains and manages brain regions inside an IndexedDictionary;
	% thus, it has access to all IndexedDictionary methods.
	% BrainAtlas can be imported/exported to .txt, .xls and .json files.
	%
	% The list of BrainAtlas properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain atlas.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain atlas.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas.
	%  <strong>4</strong> <strong>br_dict</strong> 	BR_DICT (data, idict) contains the brain regions of the brain atlas.
	%  <strong>5</strong> <strong>surf</strong> 	SURF (metadata, item) contains the brain surface of the brain atlas.
	%
	% BrainAtlas methods (constructor):
	% BrainAtlas - constructor
	%
	% BrainAtlas methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in brain atlas/error.
	%  existsProp - checks whether property exists in brain atlas/error.
	%  getPropNumber - returns the property number of brain atlas.
	%  getProps - returns the property list of brain atlas.
	%  getDescription - returns the description of the brain atlas.
	%  getName - returns the name of the brain atlas.
	%  getClass - returns the class of the brain atlas.
	%  getGUIMenuExport - sets a figure menu.
	%  getGUIMenuImport - sets a figure menu.
	%
	% BrainAtlas methods:
	%  getPlotProp - returns a prop plot.
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
	% BrainAtlas methods (operators):
	%  isequal - determines whether two BrainAtlas are equal (values, locked)
	%
	% BrainAtlas methods (display):
	%  tostring - string with information about the BrainAtlas
	%  disp - displays information about the BrainAtlas
	%  tree - displays the element of BrainAtlas
	%
	% BrainAtlas method (element list):
	%  getElementList - returns a list with all subelements of BrainAtlas
	%
	% BrainAtlas method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the BrainAtlas
	%
	% BrainAtlas method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the BrainAtlas
	%
	% BrainAtlas methods (copy):
	%  copy - copies the BrainAtlas
	%  deepclone - deep-clones the BrainAtlas
	%  clone - clones the BrainAtlas
	%
	% BrainAtlas methods (inspection, Static):
	%  getClass - returns BrainAtlas
	%  getName - returns the name of BrainAtlas
	%  getDescription - returns the description of BrainAtlas
	%  getProps - returns the property list of BrainAtlas
	%  getPropNumber - returns the property number of BrainAtlas
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
	% BrainAtlas methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainAtlas methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% BrainAtlas methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% BrainAtlas methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% BrainAtlas properties (Constant).
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
	%  BR_DICT - 4
	%  BR_DICT_TAG - 'br_dict'
	%  BR_DICT_CATEGORY - 'd'
	%  BR_DICT_FORMAT - 'di'
	%  SURF - 5
	%  SURF_TAG - 'surf'
	%  SURF_CATEGORY - 'm'
	%  SURF_FORMAT - 'it'
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
	% See also Element, BrainRegion, BrainSurface, ImporterBrainAtlasXLS, ImporterBrainAtlasTXT, ExporterBrainAtlasXLS, ExporterBrainAtlasTXT.
	
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
		
		BR_DICT = 4;
		BR_DICT_TAG = 'br_dict';
		BR_DICT_CATEGORY = Category.DATA;
		BR_DICT_FORMAT = Format.IDICT;
		
		SURF = 5;
		SURF_TAG = 'surf';
		SURF_CATEGORY = Category.METADATA;
		SURF_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function ba_class = getClass()
			%GETCLASS returns the class of the brain atlas.
			%
			% CLASS = BrainAtlas.GETCLASS() returns the class 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BA.GETCLASS() returns the class of the brain atlas BA.
			%  CLASS = Element.GETCLASS(BA) returns the class of 'BA'.
			%  CLASS = Element.GETCLASS('BrainAtlas') returns 'BrainAtlas'.
			%
			% See also getName, getDescription.
			
			ba_class = 'BrainAtlas';
		end
		function ba_name = getName()
			%GETNAME returns the name of the brain atlas.
			%
			% NAME = BrainAtlas.GETNAME() returns the name of the 'brain atlas'.
			%  Brain Atlas.
			%
			% Alternative forms to call this method are:
			%  NAME = BA.GETNAME() returns the name of the brain atlas BA.
			%  NAME = Element.GETNAME(BA) returns the name of 'BA'.
			%  NAME = Element.GETNAME('BrainAtlas') returns the name of 'BrainAtlas'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ba_name = 'Brain Atlas';
		end
		function ba_description = getDescription()
			%GETDESCRIPTION returns the description of the brain atlas.
			%
			% STR = BrainAtlas.GETDESCRIPTION() returns the description of the 'brain atlas'.
			%  which is:
			%
			%  BrainAtlas represents a brain atlas,
			%  constituted by a collection of brain regions.  
			%  BrainAtlas contains and manages brain regions inside an IndexedDictionary;
			%  thus, it has access to all IndexedDictionary methods.
			%  BrainAtlas can be imported/exported to .txt, .xls and .json files.
			%
			% Alternative forms to call this method are:
			%  STR = BA.GETDESCRIPTION() returns the description of the brain atlas BA.
			%  STR = Element.GETDESCRIPTION(BA) returns the description of 'BA'.
			%  STR = Element.GETDESCRIPTION('BrainAtlas') returns the description of 'BrainAtlas'.
			%
			% See also getClass, getName.
			
			ba_description = [
				'BrainAtlas represents a brain atlas,' ...
				'constituted by a collection of brain regions.  ' ...
				'BrainAtlas contains and manages brain regions inside an IndexedDictionary;' ...
				'thus, it has access to all IndexedDictionary methods.' ...
				'BrainAtlas can be imported/exported to .txt, .xls and .json files.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas.
			%
			% PROPS = BrainAtlas.GETPROPS() returns the property list of brain atlas.
			%
			% PROPS = BrainAtlas.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BA.GETPROPS([CATEGORY]) returns the property list of the brain atlas BA.
			%  PROPS = Element.GETPROPS(BA[, CATEGORY]) returns the property list of 'BA'.
			%  PROPS = Element.GETPROPS('BrainAtlas'[, CATEGORY]) returns the property list of 'BrainAtlas'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						BrainAtlas.LABEL
						BrainAtlas.NOTES
						BrainAtlas.SURF
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						BrainAtlas.ID
						BrainAtlas.BR_DICT
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
						BrainAtlas.ID
						BrainAtlas.LABEL
						BrainAtlas.NOTES
						BrainAtlas.BR_DICT
						BrainAtlas.SURF
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of brain atlas.
			%
			% N = BrainAtlas.GETPROPNUMBER() returns the property number of brain atlas.
			%
			% Alternative forms to call this method are:
			%  N = BA.GETPROPNUMBER() returns the property number of the brain atlas BA.
			%  N = Element.GETPROPNUMBER(BA) returns the property number of 'BA'.
			%  N = Element.GETPROPNUMBER('BrainAtlas') returns the property number of 'BrainAtlas'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 5;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSPROP(PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BA, PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BrainAtlas, PROP) checks whether PROP exists for BrainAtlas.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSPROP(PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BA, PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BrainAtlas, PROP) throws error if PROP does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5 ]);
			else
				assert( ...
					BrainAtlas.existsProp(prop), ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainAtlas.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSTAG(TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BA, TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BrainAtlas, TAG) checks whether TAG exists for BrainAtlas.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSTAG(TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BA, TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BrainAtlas, TAG) throws error if TAG does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				brainatlas_tag_list = { 'id'  'label'  'notes'  'br_dict'  'surf' };
				
				check = any(strcmpi(tag, brainatlas_tag_list));
			else
				assert( ...
					BrainAtlas.existsTag(tag), ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for BrainAtlas'] ...
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
			%  PROPERTY = BA.GETPROPPROP(POINTER) returns property number of POINTER of BA.
			%  PROPERTY = Element.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%  PROPERTY = BA.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				brainatlas_tag_list = { 'id'  'label'  'notes'  'br_dict'  'surf' };
				
				tag = pointer;
				BrainAtlas.existsTag(tag);
				
				prop = find(strcmpi(tag, brainatlas_tag_list));
			else % numeric
				prop = pointer;
				BrainAtlas.existsProp(prop);
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
			%  TAG = BA.GETPROPTAG(POINTER) returns tag of POINTER of BA.
			%  TAG = Element.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%  TAG = BA.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				BrainAtlas.existsTag(tag);
			else % numeric
				prop = pointer;
				BrainAtlas.existsProp(prop);
				
				switch prop
					case BrainAtlas.ID
						tag = BrainAtlas.ID_TAG;
					case BrainAtlas.LABEL
						tag = BrainAtlas.LABEL_TAG;
					case BrainAtlas.NOTES
						tag = BrainAtlas.NOTES_TAG;
					case BrainAtlas.BR_DICT
						tag = BrainAtlas.BR_DICT_TAG;
					case BrainAtlas.SURF
						tag = BrainAtlas.SURF_TAG;
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
			%  CATEGORY = BA.GETPROPCATEGORY(POINTER) returns category of POINTER of BA.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%  CATEGORY = BA.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					prop_category = BrainAtlas.ID_CATEGORY;
				case BrainAtlas.LABEL
					prop_category = BrainAtlas.LABEL_CATEGORY;
				case BrainAtlas.NOTES
					prop_category = BrainAtlas.NOTES_CATEGORY;
				case BrainAtlas.BR_DICT
					prop_category = BrainAtlas.BR_DICT_CATEGORY;
				case BrainAtlas.SURF
					prop_category = BrainAtlas.SURF_CATEGORY;
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
			%  FORMAT = BA.GETPROPFORMAT(POINTER) returns format of POINTER of BA.
			%  FORMAT = Element.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%  FORMAT = BA.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					prop_format = BrainAtlas.ID_FORMAT;
				case BrainAtlas.LABEL
					prop_format = BrainAtlas.LABEL_FORMAT;
				case BrainAtlas.NOTES
					prop_format = BrainAtlas.NOTES_FORMAT;
				case BrainAtlas.BR_DICT
					prop_format = BrainAtlas.BR_DICT_FORMAT;
				case BrainAtlas.SURF
					prop_format = BrainAtlas.SURF_FORMAT;
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
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BA.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain atlas.';
				case BrainAtlas.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain atlas.';
				case BrainAtlas.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain atlas.';
				case BrainAtlas.BR_DICT
					prop_description = 'BR_DICT (data, idict) contains the brain regions of the brain atlas.';
				case BrainAtlas.SURF
					prop_description = 'SURF (metadata, item) contains the brain surface of the brain atlas.';
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
			%  SETTINGS = BA.GETPROPSETTINGS(POINTER) returns settings of POINTER of BA.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%  SETTINGS = BA.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainAtlas.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainAtlas.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case BrainAtlas.BR_DICT
					prop_settings = 'BrainRegion';
				case BrainAtlas.SURF
					prop_settings = 'BrainSurface';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					prop_default = Format.getFormatDefault(Format.STRING, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.BR_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.SURF
					prop_default = ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF');
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			prop_default = BrainAtlas.conditioning(prop, BrainAtlas.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BA.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BA.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BA.
			%  CHECK = Element.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			%  CHECK = BA.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			% 
			% BA.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BA.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  BA.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.ID
					check = Format.checkFormat(Format.STRING, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.LABEL
					check = Format.checkFormat(Format.STRING, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.NOTES
					check = Format.checkFormat(Format.STRING, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.BR_DICT
					check = Format.checkFormat(Format.IDICT, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.SURF
					check = Format.checkFormat(Format.ITEM, value, BrainAtlas.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainAtlas.getPropTag(prop) ' (' BrainAtlas.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ba = BrainAtlas(varargin)
			% BrainAtlas() creates a brain atlas.
			%
			% BrainAtlas(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainAtlas(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainAtlas properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the brain atlas.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the brain atlas.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas.
			%  <strong>4</strong> <strong>br_dict</strong> 	BR_DICT (data, idict) contains the brain regions of the brain atlas.
			%  <strong>5</strong> <strong>surf</strong> 	SURF (metadata, item) contains the brain surface of the brain atlas.
			%
			% See also Category, Format, set, check.
			
			ba = ba@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(ba, prop, varargin)
			%GETPLOTPROP returns a prop plot.
			%
			% PR = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
			%
			% PR = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
			%
			% See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
			%  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
			%  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.
			
			switch prop
				case BrainAtlas.NOTES
					pr = PlotPropString('EL', ba, 'PROP', BrainAtlas.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});
					
				case BrainAtlas.BR_DICT
					pr = PPBrainAtlas_BRDict('EL', ba, 'PROP', BrainAtlas.BR_DICT, varargin{:});
					
				case BrainAtlas.SURF
					pr = PPBrainAtlas_Surf('EL', ba, 'PROP', BrainAtlas.SURF, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(ba, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			uimenu(menu_import, ...
			    'Label', 'Import TXT ...', ...
			    'Callback', {@cb_importer_TXT});
			function cb_importer_TXT(~, ~)
			    im = ImporterBrainAtlasTXT( ...
			        'ID', 'Import Brain Atlas from TXT', ...
			        'WAITBAR', true ...
			        );
			    im.uigetfile();
			    try
			        if isfile(im.get('FILE'))
			            % pe.set('EL', im.get('PIP')); 
			            % pe.reinit();
			
			            ba = pe.get('EL');
			            
			            assert( ...
			                all(cellfun(@(prop) ~ba.isLocked(prop), num2cell(ba.getProps()))), ...
			                [BRAPH2.STR ':BrainAtlas:' BRAPH2.BUG_FUNC], ...
			                'To import an element, all its properties must be unlocked.' ...
			                )
			            
			            ba_new = im.get('BA');
			            for prop = 1:1:ba.getPropNumber()
			                if ba.getPropCategory(prop) ~= Category.RESULT
			                    ba.set(prop, ba_new.get(prop))
			                end
			            end
			            
			            pe.reinit(ba_new);
			        end
			    catch e
			        warndlg(['Please, select a valid input BrainAtlas in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			uimenu(menu_import, ...
			    'Label', 'Import XLS ...', ...
			    'Callback', {@cb_importer_XLS});
			function cb_importer_XLS(~, ~)
			    im = ImporterBrainAtlasXLS( ...
			        'ID', 'Import Brain Atlas from XLS', ...
			        'WAITBAR', true ...
			        );
			    im.uigetfile();
			    try
			        if isfile(im.get('FILE'))
			            % pe.set('EL', im.get('PIP')); 
			            % pe.reinit();
			
			            ba = pe.get('EL');
			            
			            assert( ...
			                all(cellfun(@(prop) ~ba.isLocked(prop), num2cell(ba.getProps()))), ...
			                [BRAPH2.STR ':BrainAtlas:' BRAPH2.BUG_FUNC], ...
			                'To import an element, all its properties must be unlocked.' ...
			                )
			            
			            ba_new = im.get('BA');
			            for prop = 1:1:ba.getPropNumber()
			                if ba.getPropCategory(prop) ~= Category.RESULT
			                    ba.set(prop, ba_new.get(prop))
			                end
			            end
			            
			            pe.reinit(ba_new);
			        end
			    catch e
			        warndlg(['Please, select a valid input BrainAtlas in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			uimenu(menu_export, ...
			    'Label', 'Export TXT ...', ...
			    'Callback', {@cb_exporter_TXT});
			function cb_exporter_TXT(~, ~)
			    ex = ExporterBrainAtlasTXT( ...
			        'ID', 'Export Brain Atlas to TXT', ...
			        'BA', el.copy(), ...
			        'WAITBAR', true ...
			        );
			    ex.uiputfile()
			    if ~strcmp(ex.get('FILE'), ExporterBrainAtlasTXT.getPropDefault('FILE'))
			        ex.get('SAVE');
			    end
			end
			
			uimenu(menu_export, ...
			    'Label', 'Export XLS ...', ...
			    'Callback', {@cb_exporter_XLS});
			function cb_exporter_XLS(~, ~)
			    ex = ExporterBrainAtlasXLS( ...
			        'ID', 'Export Brain Atlas to XLS', ...
			        'BA', el.copy(), ...
			        'WAITBAR', true ...
			        );
			    ex.uiputfile()
			    if ~strcmp(ex.get('FILE'), ExporterBrainAtlasXLS.getPropDefault('FILE'))
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
