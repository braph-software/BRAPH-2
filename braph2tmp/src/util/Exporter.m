classdef Exporter < Element
	% Exporter exports an element to a file.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Exporter exports an element to generic file. 
	% Exporter contains and manages the properties of the element.
	%
	% The list of Exporter properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
	%
	% Exporter methods (constructor):
	% Exporter - constructor
	%
	% Exporter methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in exporter to a file/error.
	%  existsProp - checks whether property exists in exporter to a file/error.
	%  getPropNumber - returns the property number of exporter to a file.
	%  getProps - returns the property list of exporter to a file.
	%  getDescription - returns the description of the exporter to a file.
	%  getName - returns the name of the exporter to a file.
	%  getClass - returns the class of the exporter to a file.
	%
	% Exporter methods:
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
	% Exporter methods (operators):
	%  isequal - determines whether two Exporter are equal (values, locked)
	%
	% Exporter methods (display):
	%  tostring - string with information about the Exporter
	%  disp - displays information about the Exporter
	%  tree - displays the element of Exporter
	%
	% Exporter method (element list):
	%  getElementList - returns a list with all subelements of Exporter
	%
	% Exporter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Exporter
	%
	% Exporter method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Exporter
	%
	% Exporter methods (copy):
	%  copy - copies the Exporter
	%  deepclone - deep-clones the Exporter
	%  clone - clones the Exporter
	%
	% Exporter methods (inspection, Static):
	%  getClass - returns Exporter
	%  getName - returns the name of Exporter
	%  getDescription - returns the description of Exporter
	%  getProps - returns the property list of Exporter
	%  getPropNumber - returns the property number of Exporter
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
	% Exporter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Exporter methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Exporter methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Exporter methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Exporter properties (Constant).
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
	% See also Element, Importer..
	
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
		
		WAITBAR = 4;
		WAITBAR_TAG = 'waitbar';
		WAITBAR_CATEGORY = Category.METADATA;
		WAITBAR_FORMAT = Format.LOGICAL;
	end
	methods (Static) % inspection methods
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter to a file.
			%
			% CLASS = Exporter.GETCLASS() returns the class 'Exporter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter to a file EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('Exporter') returns 'Exporter'.
			%
			% See also getName, getDescription.
			
			ex_class = 'Exporter';
		end
		function ex_name = getName()
			%GETNAME returns the name of the exporter to a file.
			%
			% NAME = Exporter.GETNAME() returns the name of the 'exporter to a file'.
			%  Exporter To A File.
			%
			% Alternative forms to call this method are:
			%  NAME = EX.GETNAME() returns the name of the exporter to a file EX.
			%  NAME = Element.GETNAME(EX) returns the name of 'EX'.
			%  NAME = Element.GETNAME('Exporter') returns the name of 'Exporter'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ex_name = 'Exporter To A File';
		end
		function ex_description = getDescription()
			%GETDESCRIPTION returns the description of the exporter to a file.
			%
			% STR = Exporter.GETDESCRIPTION() returns the description of the 'exporter to a file'.
			%  which is:
			%
			%  Exporter exports an element to generic file. 
			%  Exporter contains and manages the properties of the element.
			%
			% Alternative forms to call this method are:
			%  STR = EX.GETDESCRIPTION() returns the description of the exporter to a file EX.
			%  STR = Element.GETDESCRIPTION(EX) returns the description of 'EX'.
			%  STR = Element.GETDESCRIPTION('Exporter') returns the description of 'Exporter'.
			%
			% See also getClass, getName.
			
			ex_description = [
				'Exporter exports an element to generic file. ' ...
				'Exporter contains and manages the properties of the element.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter to a file.
			%
			% PROPS = Exporter.GETPROPS() returns the property list of exporter to a file.
			%
			% PROPS = Exporter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter to a file EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('Exporter'[, CATEGORY]) returns the property list of 'Exporter'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Exporter.LABEL
						Exporter.NOTES
						Exporter.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Exporter.ID
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
						Exporter.ID
						Exporter.LABEL
						Exporter.NOTES
						Exporter.WAITBAR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of exporter to a file.
			%
			% N = Exporter.GETPROPNUMBER() returns the property number of exporter to a file.
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER() returns the property number of the exporter to a file EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('Exporter') returns the property number of 'Exporter'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 4;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter to a file/error.
			%
			% CHECK = Exporter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(Exporter, PROP) checks whether PROP exists for Exporter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSPROP(Exporter, PROP) throws error if PROP does NOT exist for Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4 ]);
			else
				assert( ...
					Exporter.existsProp(prop), ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Exporter.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter to a file/error.
			%
			% CHECK = Exporter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(Exporter, TAG) checks whether TAG exists for Exporter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSTAG(Exporter, TAG) throws error if TAG does NOT exist for Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				exporter_tag_list = { 'id'  'label'  'notes'  'waitbar' };
				
				check = any(strcmpi(tag, exporter_tag_list));
			else
				assert( ...
					Exporter.existsTag(tag), ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Exporter'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Exporter, POINTER) returns property number of POINTER of Exporter.
			%  PROPERTY = EX.GETPROPPROP(Exporter, POINTER) returns property number of POINTER of Exporter.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				exporter_tag_list = { 'id'  'label'  'notes'  'waitbar' };
				
				tag = pointer;
				Exporter.existsTag(tag);
				
				prop = find(strcmpi(tag, exporter_tag_list));
			else % numeric
				prop = pointer;
				Exporter.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(Exporter, POINTER) returns tag of POINTER of Exporter.
			%  TAG = EX.GETPROPTAG(Exporter, POINTER) returns tag of POINTER of Exporter.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Exporter.existsTag(tag);
			else % numeric
				prop = pointer;
				Exporter.existsProp(prop);
				
				switch prop
					case Exporter.ID
						tag = Exporter.ID_TAG;
					case Exporter.LABEL
						tag = Exporter.LABEL_TAG;
					case Exporter.NOTES
						tag = Exporter.NOTES_TAG;
					case Exporter.WAITBAR
						tag = Exporter.WAITBAR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Exporter, POINTER) returns category of POINTER of Exporter.
			%  CATEGORY = EX.GETPROPCATEGORY(Exporter, POINTER) returns category of POINTER of Exporter.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					prop_category = Exporter.ID_CATEGORY;
				case Exporter.LABEL
					prop_category = Exporter.LABEL_CATEGORY;
				case Exporter.NOTES
					prop_category = Exporter.NOTES_CATEGORY;
				case Exporter.WAITBAR
					prop_category = Exporter.WAITBAR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Exporter, POINTER) returns format of POINTER of Exporter.
			%  FORMAT = EX.GETPROPFORMAT(Exporter, POINTER) returns format of POINTER of Exporter.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					prop_format = Exporter.ID_FORMAT;
				case Exporter.LABEL
					prop_format = Exporter.LABEL_FORMAT;
				case Exporter.NOTES
					prop_format = Exporter.NOTES_FORMAT;
				case Exporter.WAITBAR
					prop_format = Exporter.WAITBAR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Exporter, POINTER) returns description of POINTER of Exporter.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(Exporter, POINTER) returns description of POINTER of Exporter.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					prop_description = 'ID (data, string) is a few-letter code for the exporter.';
				case Exporter.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the exporter.';
				case Exporter.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the exporter.';
				case Exporter.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to how the waitbar.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Exporter, POINTER) returns settings of POINTER of Exporter.
			%  SETTINGS = EX.GETPROPSETTINGS(Exporter, POINTER) returns settings of POINTER of Exporter.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Exporter.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Exporter.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Exporter.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Exporter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Exporter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(Exporter, POINTER) returns the default value of POINTER of Exporter.
			%  DEFAULT = EX.GETPROPDEFAULT(Exporter, POINTER) returns the default value of POINTER of Exporter.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					prop_default = Format.getFormatDefault(Format.STRING, Exporter.getPropSettings(prop));
				case Exporter.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Exporter.getPropSettings(prop));
				case Exporter.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Exporter.getPropSettings(prop));
				case Exporter.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, Exporter.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Exporter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Exporter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Exporter, POINTER) returns the conditioned default value of POINTER of Exporter.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(Exporter, POINTER) returns the conditioned default value of POINTER of Exporter.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			prop_default = Exporter.conditioning(prop, Exporter.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Exporter, PROP, VALUE) checks VALUE format for PROP of Exporter.
			%  CHECK = EX.CHECKPROP(Exporter, PROP, VALUE) checks VALUE format for PROP of Exporter.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Exporter:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.CHECKPROP(Exporter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  EX.CHECKPROP(Exporter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.ID
					check = Format.checkFormat(Format.STRING, value, Exporter.getPropSettings(prop));
				case Exporter.LABEL
					check = Format.checkFormat(Format.STRING, value, Exporter.getPropSettings(prop));
				case Exporter.NOTES
					check = Format.checkFormat(Format.STRING, value, Exporter.getPropSettings(prop));
				case Exporter.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, Exporter.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Exporter.getPropTag(prop) ' (' Exporter.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ex = Exporter(varargin)
			% Exporter() creates a exporter to a file.
			%
			% Exporter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Exporter(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Exporter properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the exporter.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the exporter.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the exporter.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to how the waitbar.
			%
			% See also Category, Format, set, check.
			
			ex = ex@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
