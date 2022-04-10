classdef PipelineCode < Element
	% PipelineCode is an executable code line of a pipeline.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% PipelineCode represents a line of executable code in a pipeline.
	%
	% The list of PipelineCode properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a numeric code for the pipeline code line.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline code line.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code line.
	%  <strong>4</strong> <strong>text_before_exec</strong> 	TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.
	%  <strong>5</strong> <strong>text_after_exec</strong> 	TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.
	%  <strong>6</strong> <strong>moniker</strong> 	MONIKER (data, string) is the moniker of the calculated element.
	%  <strong>7</strong> <strong>code</strong> 	CODE (data, string) is the code line to calculate the element.
	%  <strong>8</strong> <strong>el</strong> 	EL (data, item) is the calculated element.
	%
	% PipelineCode methods (constructor):
	% PipelineCode - constructor
	%
	% PipelineCode methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in pipeline code line/error.
	%  existsProp - checks whether property exists in pipeline code line/error.
	%  getPropNumber - returns the property number of pipeline code line.
	%  getProps - returns the property list of pipeline code line.
	%  getDescription - returns the description of the pipeline code line.
	%  getName - returns the name of the pipeline code line.
	%  getClass - returns the class of the pipeline code line.
	%
	% PipelineCode methods:
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
	% PipelineCode methods (operators):
	%  isequal - determines whether two PipelineCode are equal (values, locked)
	%
	% PipelineCode methods (display):
	%  tostring - string with information about the PipelineCode
	%  disp - displays information about the PipelineCode
	%  tree - displays the element of PipelineCode
	%
	% PipelineCode method (element list):
	%  getElementList - returns a list with all subelements of PipelineCode
	%
	% PipelineCode method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PipelineCode
	%
	% PipelineCode method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PipelineCode
	%
	% PipelineCode methods (copy):
	%  copy - copies the PipelineCode
	%  deepclone - deep-clones the PipelineCode
	%  clone - clones the PipelineCode
	%
	% PipelineCode methods (inspection, Static):
	%  getClass - returns PipelineCode
	%  getName - returns the name of PipelineCode
	%  getDescription - returns the description of PipelineCode
	%  getProps - returns the property list of PipelineCode
	%  getPropNumber - returns the property number of PipelineCode
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
	% PipelineCode methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineCode methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PipelineCode methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PipelineCode methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PipelineCode properties (Constant).
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
	%  TEXT_BEFORE_EXEC - 4
	%  TEXT_BEFORE_EXEC_TAG - 'text_before_exec'
	%  TEXT_BEFORE_EXEC_CATEGORY - 'm'
	%  TEXT_BEFORE_EXEC_FORMAT - 'st'
	%  TEXT_AFTER_EXEC - 5
	%  TEXT_AFTER_EXEC_TAG - 'text_after_exec'
	%  TEXT_AFTER_EXEC_CATEGORY - 'm'
	%  TEXT_AFTER_EXEC_FORMAT - 'st'
	%  MONIKER - 6
	%  MONIKER_TAG - 'moniker'
	%  MONIKER_CATEGORY - 'd'
	%  MONIKER_FORMAT - 'st'
	%  CODE - 7
	%  CODE_TAG - 'code'
	%  CODE_CATEGORY - 'd'
	%  CODE_FORMAT - 'st'
	%  EL - 8
	%  EL_TAG - 'el'
	%  EL_CATEGORY - 'd'
	%  EL_FORMAT - 'it'
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
	% See also PipelineGUI, Pipeline, PipelineSection.
	
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
		
		TEXT_BEFORE_EXEC = 4;
		TEXT_BEFORE_EXEC_TAG = 'text_before_exec';
		TEXT_BEFORE_EXEC_CATEGORY = Category.METADATA;
		TEXT_BEFORE_EXEC_FORMAT = Format.STRING;
		
		TEXT_AFTER_EXEC = 5;
		TEXT_AFTER_EXEC_TAG = 'text_after_exec';
		TEXT_AFTER_EXEC_CATEGORY = Category.METADATA;
		TEXT_AFTER_EXEC_FORMAT = Format.STRING;
		
		MONIKER = 6;
		MONIKER_TAG = 'moniker';
		MONIKER_CATEGORY = Category.DATA;
		MONIKER_FORMAT = Format.STRING;
		
		CODE = 7;
		CODE_TAG = 'code';
		CODE_CATEGORY = Category.DATA;
		CODE_FORMAT = Format.STRING;
		
		EL = 8;
		EL_TAG = 'el';
		EL_CATEGORY = Category.DATA;
		EL_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function pc_class = getClass()
			%GETCLASS returns the class of the pipeline code line.
			%
			% CLASS = PipelineCode.GETCLASS() returns the class 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PC.GETCLASS() returns the class of the pipeline code line PC.
			%  CLASS = Element.GETCLASS(PC) returns the class of 'PC'.
			%  CLASS = Element.GETCLASS('PipelineCode') returns 'PipelineCode'.
			%
			% See also getName, getDescription.
			
			pc_class = 'PipelineCode';
		end
		function pc_name = getName()
			%GETNAME returns the name of the pipeline code line.
			%
			% NAME = PipelineCode.GETNAME() returns the name of the 'pipeline code line'.
			%  Pipeline Code Line.
			%
			% Alternative forms to call this method are:
			%  NAME = PC.GETNAME() returns the name of the pipeline code line PC.
			%  NAME = Element.GETNAME(PC) returns the name of 'PC'.
			%  NAME = Element.GETNAME('PipelineCode') returns the name of 'PipelineCode'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pc_name = 'Pipeline Code Line';
		end
		function pc_description = getDescription()
			%GETDESCRIPTION returns the description of the pipeline code line.
			%
			% STR = PipelineCode.GETDESCRIPTION() returns the description of the 'pipeline code line'.
			%  which is:
			%
			%  PipelineCode represents a line of executable code in a pipeline.
			%
			% Alternative forms to call this method are:
			%  STR = PC.GETDESCRIPTION() returns the description of the pipeline code line PC.
			%  STR = Element.GETDESCRIPTION(PC) returns the description of 'PC'.
			%  STR = Element.GETDESCRIPTION('PipelineCode') returns the description of 'PipelineCode'.
			%
			% See also getClass, getName.
			
			pc_description = [
				'PipelineCode represents a line of executable code in a pipeline.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline code line.
			%
			% PROPS = PipelineCode.GETPROPS() returns the property list of pipeline code line.
			%
			% PROPS = PipelineCode.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PC.GETPROPS([CATEGORY]) returns the property list of the pipeline code line PC.
			%  PROPS = Element.GETPROPS(PC[, CATEGORY]) returns the property list of 'PC'.
			%  PROPS = Element.GETPROPS('PipelineCode'[, CATEGORY]) returns the property list of 'PipelineCode'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PipelineCode.LABEL
						PipelineCode.NOTES
						PipelineCode.TEXT_BEFORE_EXEC
						PipelineCode.TEXT_AFTER_EXEC
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						PipelineCode.ID
						PipelineCode.MONIKER
						PipelineCode.CODE
						PipelineCode.EL
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
						PipelineCode.ID
						PipelineCode.LABEL
						PipelineCode.NOTES
						PipelineCode.TEXT_BEFORE_EXEC
						PipelineCode.TEXT_AFTER_EXEC
						PipelineCode.MONIKER
						PipelineCode.CODE
						PipelineCode.EL
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of pipeline code line.
			%
			% N = PipelineCode.GETPROPNUMBER() returns the property number of pipeline code line.
			%
			% Alternative forms to call this method are:
			%  N = PC.GETPROPNUMBER() returns the property number of the pipeline code line PC.
			%  N = Element.GETPROPNUMBER(PC) returns the property number of 'PC'.
			%  N = Element.GETPROPNUMBER('PipelineCode') returns the property number of 'PipelineCode'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSPROP(PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PC, PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PipelineCode, PROP) checks whether PROP exists for PipelineCode.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSPROP(PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PC, PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PipelineCode, PROP) throws error if PROP does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					PipelineCode.existsProp(prop), ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineCode.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSTAG(TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PC, TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PipelineCode, TAG) checks whether TAG exists for PipelineCode.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSTAG(TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PC, TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PipelineCode, TAG) throws error if TAG does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				pipelinecode_tag_list = { 'id'  'label'  'notes'  'text_before_exec'  'text_after_exec'  'moniker'  'code'  'el' };
				
				check = any(strcmpi(tag, pipelinecode_tag_list));
			else
				assert( ...
					PipelineCode.existsTag(tag), ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PipelineCode'] ...
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
			%  PROPERTY = PC.GETPROPPROP(POINTER) returns property number of POINTER of PC.
			%  PROPERTY = Element.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%  PROPERTY = PC.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				pipelinecode_tag_list = { 'id'  'label'  'notes'  'text_before_exec'  'text_after_exec'  'moniker'  'code'  'el' };
				
				tag = pointer;
				PipelineCode.existsTag(tag);
				
				prop = find(strcmpi(tag, pipelinecode_tag_list));
			else % numeric
				prop = pointer;
				PipelineCode.existsProp(prop);
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
			%  TAG = PC.GETPROPTAG(POINTER) returns tag of POINTER of PC.
			%  TAG = Element.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%  TAG = PC.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PipelineCode.existsTag(tag);
			else % numeric
				prop = pointer;
				PipelineCode.existsProp(prop);
				
				switch prop
					case PipelineCode.ID
						tag = PipelineCode.ID_TAG;
					case PipelineCode.LABEL
						tag = PipelineCode.LABEL_TAG;
					case PipelineCode.NOTES
						tag = PipelineCode.NOTES_TAG;
					case PipelineCode.TEXT_BEFORE_EXEC
						tag = PipelineCode.TEXT_BEFORE_EXEC_TAG;
					case PipelineCode.TEXT_AFTER_EXEC
						tag = PipelineCode.TEXT_AFTER_EXEC_TAG;
					case PipelineCode.MONIKER
						tag = PipelineCode.MONIKER_TAG;
					case PipelineCode.CODE
						tag = PipelineCode.CODE_TAG;
					case PipelineCode.EL
						tag = PipelineCode.EL_TAG;
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
			%  CATEGORY = PC.GETPROPCATEGORY(POINTER) returns category of POINTER of PC.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%  CATEGORY = PC.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					prop_category = PipelineCode.ID_CATEGORY;
				case PipelineCode.LABEL
					prop_category = PipelineCode.LABEL_CATEGORY;
				case PipelineCode.NOTES
					prop_category = PipelineCode.NOTES_CATEGORY;
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_category = PipelineCode.TEXT_BEFORE_EXEC_CATEGORY;
				case PipelineCode.TEXT_AFTER_EXEC
					prop_category = PipelineCode.TEXT_AFTER_EXEC_CATEGORY;
				case PipelineCode.MONIKER
					prop_category = PipelineCode.MONIKER_CATEGORY;
				case PipelineCode.CODE
					prop_category = PipelineCode.CODE_CATEGORY;
				case PipelineCode.EL
					prop_category = PipelineCode.EL_CATEGORY;
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
			%  FORMAT = PC.GETPROPFORMAT(POINTER) returns format of POINTER of PC.
			%  FORMAT = Element.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%  FORMAT = PC.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					prop_format = PipelineCode.ID_FORMAT;
				case PipelineCode.LABEL
					prop_format = PipelineCode.LABEL_FORMAT;
				case PipelineCode.NOTES
					prop_format = PipelineCode.NOTES_FORMAT;
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_format = PipelineCode.TEXT_BEFORE_EXEC_FORMAT;
				case PipelineCode.TEXT_AFTER_EXEC
					prop_format = PipelineCode.TEXT_AFTER_EXEC_FORMAT;
				case PipelineCode.MONIKER
					prop_format = PipelineCode.MONIKER_FORMAT;
				case PipelineCode.CODE
					prop_format = PipelineCode.CODE_FORMAT;
				case PipelineCode.EL
					prop_format = PipelineCode.EL_FORMAT;
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
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					prop_description = 'ID (data, string) is a numeric code for the pipeline code line.';
				case PipelineCode.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline code line.';
				case PipelineCode.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline code line.';
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_description = 'TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.';
				case PipelineCode.TEXT_AFTER_EXEC
					prop_description = 'TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.';
				case PipelineCode.MONIKER
					prop_description = 'MONIKER (data, string) is the moniker of the calculated element.';
				case PipelineCode.CODE
					prop_description = 'CODE (data, string) is the code line to calculate the element.';
				case PipelineCode.EL
					prop_description = 'EL (data, item) is the calculated element.';
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
			%  SETTINGS = PC.GETPROPSETTINGS(POINTER) returns settings of POINTER of PC.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%  SETTINGS = PC.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.TEXT_AFTER_EXEC
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.MONIKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.CODE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_AFTER_EXEC
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.MONIKER
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.CODE
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PipelineCode.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			prop_default = PipelineCode.conditioning(prop, PipelineCode.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PC.
			%  CHECK = Element.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			%  CHECK = PC.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			% 
			% PC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  PC.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.ID
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.LABEL
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.NOTES
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_BEFORE_EXEC
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_AFTER_EXEC
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.MONIKER
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.CODE
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.EL
					check = Format.checkFormat(Format.ITEM, value, PipelineCode.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineCode.getPropTag(prop) ' (' PipelineCode.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pc = PipelineCode(varargin)
			% PipelineCode() creates a pipeline code line.
			%
			% PipelineCode(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineCode(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelineCode properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a numeric code for the pipeline code line.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline code line.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code line.
			%  <strong>4</strong> <strong>text_before_exec</strong> 	TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.
			%  <strong>5</strong> <strong>text_after_exec</strong> 	TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.
			%  <strong>6</strong> <strong>moniker</strong> 	MONIKER (data, string) is the moniker of the calculated element.
			%  <strong>7</strong> <strong>code</strong> 	CODE (data, string) is the code line to calculate the element.
			%  <strong>8</strong> <strong>el</strong> 	EL (data, item) is the calculated element.
			%
			% See also Category, Format, set, check.
			
			pc = pc@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(pc, prop, value)
			check = true;
			msg = ['Error while checking' tostring(pc) ' ' pc.getPropTag(prop) '.'];
			
			switch prop
				case PipelineCode.MONIKER
					check = ~iskeyword(value) && ~strcmp(value, 'varargin');
					if check 
					    msg = 'All ok!';
					else
					    msg = ['The MONIKER (' value ') cannot be a MatLab keyword ' ...
					        '(' char(join(cellfun(@(x) ['''' x ''''], iskeyword, 'UniformOutput', false))) ') ' ...
					        'or ''varargin''.'];
					end
					
				otherwise
					[check, msg] = checkValue@Element(pc, prop, value);
					
			end
		end
	end
end
