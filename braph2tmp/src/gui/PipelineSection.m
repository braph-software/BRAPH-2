classdef PipelineSection < Element
	% PipelineSection is a pipeline code section.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% PipelineCode represents a section of executable code in a pipeline.
	%
	% The list of PipelineSection properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a numeric code for the pipeline code section.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline code section.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code section.
	%  <strong>4</strong> <strong>pc_dict</strong> 	PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
	%
	% PipelineSection methods (constructor):
	% PipelineSection - constructor
	%
	% PipelineSection methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in pipeline section/error.
	%  existsProp - checks whether property exists in pipeline section/error.
	%  getPropNumber - returns the property number of pipeline section.
	%  getProps - returns the property list of pipeline section.
	%  getDescription - returns the description of the pipeline section.
	%  getName - returns the name of the pipeline section.
	%  getClass - returns the class of the pipeline section.
	%
	% PipelineSection methods:
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
	% PipelineSection methods (operators):
	%  isequal - determines whether two PipelineSection are equal (values, locked)
	%
	% PipelineSection methods (display):
	%  tostring - string with information about the PipelineSection
	%  disp - displays information about the PipelineSection
	%  tree - displays the element of PipelineSection
	%
	% PipelineSection method (element list):
	%  getElementList - returns a list with all subelements of PipelineSection
	%
	% PipelineSection method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PipelineSection
	%
	% PipelineSection method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PipelineSection
	%
	% PipelineSection methods (copy):
	%  copy - copies the PipelineSection
	%  deepclone - deep-clones the PipelineSection
	%  clone - clones the PipelineSection
	%
	% PipelineSection methods (inspection, Static):
	%  getClass - returns PipelineSection
	%  getName - returns the name of PipelineSection
	%  getDescription - returns the description of PipelineSection
	%  getProps - returns the property list of PipelineSection
	%  getPropNumber - returns the property number of PipelineSection
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
	% PipelineSection methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineSection methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PipelineSection methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PipelineSection methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PipelineSection properties (Constant).
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
	%  PC_DICT - 4
	%  PC_DICT_TAG - 'pc_dict'
	%  PC_DICT_CATEGORY - 'd'
	%  PC_DICT_FORMAT - 'di'
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
		
		PC_DICT = 4;
		PC_DICT_TAG = 'pc_dict';
		PC_DICT_CATEGORY = Category.DATA;
		PC_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function ps_class = getClass()
			%GETCLASS returns the class of the pipeline section.
			%
			% CLASS = PipelineSection.GETCLASS() returns the class 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PS.GETCLASS() returns the class of the pipeline section PS.
			%  CLASS = Element.GETCLASS(PS) returns the class of 'PS'.
			%  CLASS = Element.GETCLASS('PipelineSection') returns 'PipelineSection'.
			%
			% See also getName, getDescription.
			
			ps_class = 'PipelineSection';
		end
		function ps_name = getName()
			%GETNAME returns the name of the pipeline section.
			%
			% NAME = PipelineSection.GETNAME() returns the name of the 'pipeline section'.
			%  Pipeline Section.
			%
			% Alternative forms to call this method are:
			%  NAME = PS.GETNAME() returns the name of the pipeline section PS.
			%  NAME = Element.GETNAME(PS) returns the name of 'PS'.
			%  NAME = Element.GETNAME('PipelineSection') returns the name of 'PipelineSection'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			ps_name = 'Pipeline Section';
		end
		function ps_description = getDescription()
			%GETDESCRIPTION returns the description of the pipeline section.
			%
			% STR = PipelineSection.GETDESCRIPTION() returns the description of the 'pipeline section'.
			%  which is:
			%
			%  PipelineCode represents a section of executable code in a pipeline.
			%
			% Alternative forms to call this method are:
			%  STR = PS.GETDESCRIPTION() returns the description of the pipeline section PS.
			%  STR = Element.GETDESCRIPTION(PS) returns the description of 'PS'.
			%  STR = Element.GETDESCRIPTION('PipelineSection') returns the description of 'PipelineSection'.
			%
			% See also getClass, getName.
			
			ps_description = [
				'PipelineCode represents a section of executable code in a pipeline.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline section.
			%
			% PROPS = PipelineSection.GETPROPS() returns the property list of pipeline section.
			%
			% PROPS = PipelineSection.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PS.GETPROPS([CATEGORY]) returns the property list of the pipeline section PS.
			%  PROPS = Element.GETPROPS(PS[, CATEGORY]) returns the property list of 'PS'.
			%  PROPS = Element.GETPROPS('PipelineSection'[, CATEGORY]) returns the property list of 'PipelineSection'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PipelineSection.LABEL
						PipelineSection.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						PipelineSection.ID
						PipelineSection.PC_DICT
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
						PipelineSection.ID
						PipelineSection.LABEL
						PipelineSection.NOTES
						PipelineSection.PC_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of pipeline section.
			%
			% N = PipelineSection.GETPROPNUMBER() returns the property number of pipeline section.
			%
			% Alternative forms to call this method are:
			%  N = PS.GETPROPNUMBER() returns the property number of the pipeline section PS.
			%  N = Element.GETPROPNUMBER(PS) returns the property number of 'PS'.
			%  N = Element.GETPROPNUMBER('PipelineSection') returns the property number of 'PipelineSection'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 4;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSPROP(PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PS, PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PipelineSection, PROP) checks whether PROP exists for PipelineSection.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSPROP(PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PS, PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PipelineSection, PROP) throws error if PROP does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4 ]);
			else
				assert( ...
					PipelineSection.existsProp(prop), ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineSection.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSTAG(TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PS, TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PipelineSection, TAG) checks whether TAG exists for PipelineSection.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSTAG(TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PS, TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PipelineSection, TAG) throws error if TAG does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				pipelinesection_tag_list = { 'id'  'label'  'notes'  'pc_dict' };
				
				check = any(strcmpi(tag, pipelinesection_tag_list));
			else
				assert( ...
					PipelineSection.existsTag(tag), ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PipelineSection'] ...
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
			%  PROPERTY = PS.GETPROPPROP(POINTER) returns property number of POINTER of PS.
			%  PROPERTY = Element.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%  PROPERTY = PS.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				pipelinesection_tag_list = { 'id'  'label'  'notes'  'pc_dict' };
				
				tag = pointer;
				PipelineSection.existsTag(tag);
				
				prop = find(strcmpi(tag, pipelinesection_tag_list));
			else % numeric
				prop = pointer;
				PipelineSection.existsProp(prop);
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
			%  TAG = PS.GETPROPTAG(POINTER) returns tag of POINTER of PS.
			%  TAG = Element.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%  TAG = PS.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PipelineSection.existsTag(tag);
			else % numeric
				prop = pointer;
				PipelineSection.existsProp(prop);
				
				switch prop
					case PipelineSection.ID
						tag = PipelineSection.ID_TAG;
					case PipelineSection.LABEL
						tag = PipelineSection.LABEL_TAG;
					case PipelineSection.NOTES
						tag = PipelineSection.NOTES_TAG;
					case PipelineSection.PC_DICT
						tag = PipelineSection.PC_DICT_TAG;
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
			%  CATEGORY = PS.GETPROPCATEGORY(POINTER) returns category of POINTER of PS.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%  CATEGORY = PS.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					prop_category = PipelineSection.ID_CATEGORY;
				case PipelineSection.LABEL
					prop_category = PipelineSection.LABEL_CATEGORY;
				case PipelineSection.NOTES
					prop_category = PipelineSection.NOTES_CATEGORY;
				case PipelineSection.PC_DICT
					prop_category = PipelineSection.PC_DICT_CATEGORY;
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
			%  FORMAT = PS.GETPROPFORMAT(POINTER) returns format of POINTER of PS.
			%  FORMAT = Element.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%  FORMAT = PS.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					prop_format = PipelineSection.ID_FORMAT;
				case PipelineSection.LABEL
					prop_format = PipelineSection.LABEL_FORMAT;
				case PipelineSection.NOTES
					prop_format = PipelineSection.NOTES_FORMAT;
				case PipelineSection.PC_DICT
					prop_format = PipelineSection.PC_DICT_FORMAT;
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
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					prop_description = 'ID (data, string) is a numeric code for the pipeline code section.';
				case PipelineSection.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline code section.';
				case PipelineSection.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline code section.';
				case PipelineSection.PC_DICT
					prop_description = 'PC_DICT (data, idict) is an indexed dictionary with the executable code lines.';
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
			%  SETTINGS = PS.GETPROPSETTINGS(POINTER) returns settings of POINTER of PS.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%  SETTINGS = PS.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineSection.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineSection.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineSection.PC_DICT
					prop_settings = 'PipelineCode';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					prop_default = Format.getFormatDefault(Format.STRING, PipelineSection.getPropSettings(prop));
				case PipelineSection.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, PipelineSection.getPropSettings(prop));
				case PipelineSection.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, PipelineSection.getPropSettings(prop));
				case PipelineSection.PC_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PipelineSection.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			prop_default = PipelineSection.conditioning(prop, PipelineSection.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PS.
			%  CHECK = Element.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			%  CHECK = PS.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			% 
			% PS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  PS.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case PipelineSection.ID
					check = Format.checkFormat(Format.STRING, value, PipelineSection.getPropSettings(prop));
				case PipelineSection.LABEL
					check = Format.checkFormat(Format.STRING, value, PipelineSection.getPropSettings(prop));
				case PipelineSection.NOTES
					check = Format.checkFormat(Format.STRING, value, PipelineSection.getPropSettings(prop));
				case PipelineSection.PC_DICT
					check = Format.checkFormat(Format.IDICT, value, PipelineSection.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineSection:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineSection.getPropTag(prop) ' (' PipelineSection.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function ps = PipelineSection(varargin)
			% PipelineSection() creates a pipeline section.
			%
			% PipelineSection(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineSection(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelineSection properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a numeric code for the pipeline code section.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline code section.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code section.
			%  <strong>4</strong> <strong>pc_dict</strong> 	PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
			%
			% See also Category, Format, set, check.
			
			ps = ps@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
end
