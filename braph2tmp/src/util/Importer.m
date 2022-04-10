classdef Importer < Element
	% Importer imports an element from a file.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Importer imports an element from generic file. 
	% Importer contains and manages the properties of the element.
	%
	% The list of Importer properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%
	% Importer methods (constructor):
	% Importer - constructor
	%
	% Importer methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in importer from a file/error.
	%  existsProp - checks whether property exists in importer from a file/error.
	%  getPropNumber - returns the property number of importer from a file.
	%  getProps - returns the property list of importer from a file.
	%  getDescription - returns the description of the importer from a file.
	%  getName - returns the name of the importer from a file.
	%  getClass - returns the class of the importer from a file.
	%
	% Importer methods:
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
	% Importer methods (operators):
	%  isequal - determines whether two Importer are equal (values, locked)
	%
	% Importer methods (display):
	%  tostring - string with information about the Importer
	%  disp - displays information about the Importer
	%  tree - displays the element of Importer
	%
	% Importer method (element list):
	%  getElementList - returns a list with all subelements of Importer
	%
	% Importer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Importer
	%
	% Importer method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Importer
	%
	% Importer methods (copy):
	%  copy - copies the Importer
	%  deepclone - deep-clones the Importer
	%  clone - clones the Importer
	%
	% Importer methods (inspection, Static):
	%  getClass - returns Importer
	%  getName - returns the name of Importer
	%  getDescription - returns the description of Importer
	%  getProps - returns the property list of Importer
	%  getPropNumber - returns the property number of Importer
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
	% Importer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Importer methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Importer methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Importer methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Importer properties (Constant).
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
	% See also Element, Exporter..
	
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
		function im_class = getClass()
			%GETCLASS returns the class of the importer from a file.
			%
			% CLASS = Importer.GETCLASS() returns the class 'Importer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer from a file IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('Importer') returns 'Importer'.
			%
			% See also getName, getDescription.
			
			im_class = 'Importer';
		end
		function im_name = getName()
			%GETNAME returns the name of the importer from a file.
			%
			% NAME = Importer.GETNAME() returns the name of the 'importer from a file'.
			%  Importer From A File.
			%
			% Alternative forms to call this method are:
			%  NAME = IM.GETNAME() returns the name of the importer from a file IM.
			%  NAME = Element.GETNAME(IM) returns the name of 'IM'.
			%  NAME = Element.GETNAME('Importer') returns the name of 'Importer'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			im_name = 'Importer From A File';
		end
		function im_description = getDescription()
			%GETDESCRIPTION returns the description of the importer from a file.
			%
			% STR = Importer.GETDESCRIPTION() returns the description of the 'importer from a file'.
			%  which is:
			%
			%  Importer imports an element from generic file. 
			%  Importer contains and manages the properties of the element.
			%
			% Alternative forms to call this method are:
			%  STR = IM.GETDESCRIPTION() returns the description of the importer from a file IM.
			%  STR = Element.GETDESCRIPTION(IM) returns the description of 'IM'.
			%  STR = Element.GETDESCRIPTION('Importer') returns the description of 'Importer'.
			%
			% See also getClass, getName.
			
			im_description = [
				'Importer imports an element from generic file. ' ...
				'Importer contains and manages the properties of the element.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer from a file.
			%
			% PROPS = Importer.GETPROPS() returns the property list of importer from a file.
			%
			% PROPS = Importer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer from a file IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('Importer'[, CATEGORY]) returns the property list of 'Importer'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Importer.LABEL
						Importer.NOTES
						Importer.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Importer.ID
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
						Importer.ID
						Importer.LABEL
						Importer.NOTES
						Importer.WAITBAR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of importer from a file.
			%
			% N = Importer.GETPROPNUMBER() returns the property number of importer from a file.
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER() returns the property number of the importer from a file IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('Importer') returns the property number of 'Importer'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 4;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(Importer, PROP) checks whether PROP exists for Importer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(Importer, PROP) throws error if PROP does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4 ]);
			else
				assert( ...
					Importer.existsProp(prop), ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Importer.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(Importer, TAG) checks whether TAG exists for Importer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(Importer, TAG) throws error if TAG does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				importer_tag_list = { 'id'  'label'  'notes'  'waitbar' };
				
				check = any(strcmpi(tag, importer_tag_list));
			else
				assert( ...
					Importer.existsTag(tag), ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Importer'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%  PROPERTY = IM.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				importer_tag_list = { 'id'  'label'  'notes'  'waitbar' };
				
				tag = pointer;
				Importer.existsTag(tag);
				
				prop = find(strcmpi(tag, importer_tag_list));
			else % numeric
				prop = pointer;
				Importer.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%  TAG = IM.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Importer.existsTag(tag);
			else % numeric
				prop = pointer;
				Importer.existsProp(prop);
				
				switch prop
					case Importer.ID
						tag = Importer.ID_TAG;
					case Importer.LABEL
						tag = Importer.LABEL_TAG;
					case Importer.NOTES
						tag = Importer.NOTES_TAG;
					case Importer.WAITBAR
						tag = Importer.WAITBAR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%  CATEGORY = IM.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					prop_category = Importer.ID_CATEGORY;
				case Importer.LABEL
					prop_category = Importer.LABEL_CATEGORY;
				case Importer.NOTES
					prop_category = Importer.NOTES_CATEGORY;
				case Importer.WAITBAR
					prop_category = Importer.WAITBAR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%  FORMAT = IM.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					prop_format = Importer.ID_FORMAT;
				case Importer.LABEL
					prop_format = Importer.LABEL_FORMAT;
				case Importer.NOTES
					prop_format = Importer.NOTES_FORMAT;
				case Importer.WAITBAR
					prop_format = Importer.WAITBAR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					prop_description = 'ID (data, string) is a few-letter code for the importer.';
				case Importer.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the importer.';
				case Importer.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the importer.';
				case Importer.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%  SETTINGS = IM.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Importer.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Importer.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Importer.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					prop_default = Format.getFormatDefault(Format.STRING, Importer.getPropSettings(prop));
				case Importer.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Importer.getPropSettings(prop));
				case Importer.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Importer.getPropSettings(prop));
				case Importer.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, Importer.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			prop_default = Importer.conditioning(prop, Importer.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			%  CHECK = IM.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Importer:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  IM.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.ID
					check = Format.checkFormat(Format.STRING, value, Importer.getPropSettings(prop));
				case Importer.LABEL
					check = Format.checkFormat(Format.STRING, value, Importer.getPropSettings(prop));
				case Importer.NOTES
					check = Format.checkFormat(Format.STRING, value, Importer.getPropSettings(prop));
				case Importer.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, Importer.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Importer.getPropTag(prop) ' (' Importer.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function im = Importer(varargin)
			% Importer() creates a importer from a file.
			%
			% Importer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Importer(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Importer properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%
			% See also Category, Format, set, check.
			
			im = im@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Importer.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
