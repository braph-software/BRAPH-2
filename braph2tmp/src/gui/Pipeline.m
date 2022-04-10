classdef Pipeline < Element
	% Pipeline is an analysis pipeline.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Pipeline is an analysis pipeline.
	%
	% The list of Pipeline properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a code for the pipeline (typically its file name).
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline.
	%  <strong>4</strong> <strong>ps_dict</strong> 	PS_DICT (data, idict) is an indexed dictionary with the code sections.
	%
	% Pipeline methods (constructor):
	% Pipeline - constructor
	%
	% Pipeline methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in analysis pipeline/error.
	%  existsProp - checks whether property exists in analysis pipeline/error.
	%  getPropNumber - returns the property number of analysis pipeline.
	%  getProps - returns the property list of analysis pipeline.
	%  getDescription - returns the description of the analysis pipeline.
	%  getName - returns the name of the analysis pipeline.
	%  getClass - returns the class of the analysis pipeline.
	%  getGUIMenuExport - sets a figure menu.
	%  getGUIMenuImport - sets a figure menu.
	%
	% Pipeline methods:
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
	% Pipeline methods (operators):
	%  isequal - determines whether two Pipeline are equal (values, locked)
	%
	% Pipeline methods (display):
	%  tostring - string with information about the Pipeline
	%  disp - displays information about the Pipeline
	%  tree - displays the element of Pipeline
	%
	% Pipeline method (element list):
	%  getElementList - returns a list with all subelements of Pipeline
	%
	% Pipeline method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Pipeline
	%
	% Pipeline method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Pipeline
	%
	% Pipeline methods (copy):
	%  copy - copies the Pipeline
	%  deepclone - deep-clones the Pipeline
	%  clone - clones the Pipeline
	%
	% Pipeline methods (inspection, Static):
	%  getClass - returns Pipeline
	%  getName - returns the name of Pipeline
	%  getDescription - returns the description of Pipeline
	%  getProps - returns the property list of Pipeline
	%  getPropNumber - returns the property number of Pipeline
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
	% Pipeline methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Pipeline methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Pipeline methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Pipeline methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Pipeline properties (Constant).
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
	%  PS_DICT - 4
	%  PS_DICT_TAG - 'ps_dict'
	%  PS_DICT_CATEGORY - 'd'
	%  PS_DICT_FORMAT - 'di'
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
	% See also PipelineGUI, PipelineSection, PipelineCode.
	
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
		
		PS_DICT = 4;
		PS_DICT_TAG = 'ps_dict';
		PS_DICT_CATEGORY = Category.DATA;
		PS_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function pip_class = getClass()
			%GETCLASS returns the class of the analysis pipeline.
			%
			% CLASS = Pipeline.GETCLASS() returns the class 'Pipeline'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PIP.GETCLASS() returns the class of the analysis pipeline PIP.
			%  CLASS = Element.GETCLASS(PIP) returns the class of 'PIP'.
			%  CLASS = Element.GETCLASS('Pipeline') returns 'Pipeline'.
			%
			% See also getName, getDescription.
			
			pip_class = 'Pipeline';
		end
		function pip_name = getName()
			%GETNAME returns the name of the analysis pipeline.
			%
			% NAME = Pipeline.GETNAME() returns the name of the 'analysis pipeline'.
			%  Analysis Pipeline.
			%
			% Alternative forms to call this method are:
			%  NAME = PIP.GETNAME() returns the name of the analysis pipeline PIP.
			%  NAME = Element.GETNAME(PIP) returns the name of 'PIP'.
			%  NAME = Element.GETNAME('Pipeline') returns the name of 'Pipeline'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pip_name = 'Analysis Pipeline';
		end
		function pip_description = getDescription()
			%GETDESCRIPTION returns the description of the analysis pipeline.
			%
			% STR = Pipeline.GETDESCRIPTION() returns the description of the 'analysis pipeline'.
			%  which is:
			%
			%  Pipeline is an analysis pipeline.
			%
			% Alternative forms to call this method are:
			%  STR = PIP.GETDESCRIPTION() returns the description of the analysis pipeline PIP.
			%  STR = Element.GETDESCRIPTION(PIP) returns the description of 'PIP'.
			%  STR = Element.GETDESCRIPTION('Pipeline') returns the description of 'Pipeline'.
			%
			% See also getClass, getName.
			
			pip_description = [
				'Pipeline is an analysis pipeline.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of analysis pipeline.
			%
			% PROPS = Pipeline.GETPROPS() returns the property list of analysis pipeline.
			%
			% PROPS = Pipeline.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PIP.GETPROPS([CATEGORY]) returns the property list of the analysis pipeline PIP.
			%  PROPS = Element.GETPROPS(PIP[, CATEGORY]) returns the property list of 'PIP'.
			%  PROPS = Element.GETPROPS('Pipeline'[, CATEGORY]) returns the property list of 'Pipeline'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Pipeline.LABEL
						Pipeline.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Pipeline.ID
						Pipeline.PS_DICT
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
						Pipeline.ID
						Pipeline.LABEL
						Pipeline.NOTES
						Pipeline.PS_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of analysis pipeline.
			%
			% N = Pipeline.GETPROPNUMBER() returns the property number of analysis pipeline.
			%
			% Alternative forms to call this method are:
			%  N = PIP.GETPROPNUMBER() returns the property number of the analysis pipeline PIP.
			%  N = Element.GETPROPNUMBER(PIP) returns the property number of 'PIP'.
			%  N = Element.GETPROPNUMBER('Pipeline') returns the property number of 'Pipeline'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 4;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in analysis pipeline/error.
			%
			% CHECK = Pipeline.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PIP.EXISTSPROP(PROP) checks whether PROP exists for PIP.
			%  CHECK = Element.EXISTSPROP(PIP, PROP) checks whether PROP exists for PIP.
			%  CHECK = Element.EXISTSPROP(Pipeline, PROP) checks whether PROP exists for Pipeline.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PIP.EXISTSPROP(PROP) throws error if PROP does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSPROP(PIP, PROP) throws error if PROP does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSPROP(Pipeline, PROP) throws error if PROP does NOT exist for Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4 ]);
			else
				assert( ...
					Pipeline.existsProp(prop), ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Pipeline.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in analysis pipeline/error.
			%
			% CHECK = Pipeline.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PIP.EXISTSTAG(TAG) checks whether TAG exists for PIP.
			%  CHECK = Element.EXISTSTAG(PIP, TAG) checks whether TAG exists for PIP.
			%  CHECK = Element.EXISTSTAG(Pipeline, TAG) checks whether TAG exists for Pipeline.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PIP.EXISTSTAG(TAG) throws error if TAG does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSTAG(PIP, TAG) throws error if TAG does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSTAG(Pipeline, TAG) throws error if TAG does NOT exist for Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				pipeline_tag_list = { 'id'  'label'  'notes'  'ps_dict' };
				
				check = any(strcmpi(tag, pipeline_tag_list));
			else
				assert( ...
					Pipeline.existsTag(tag), ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Pipeline'] ...
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
			%  PROPERTY = PIP.GETPROPPROP(POINTER) returns property number of POINTER of PIP.
			%  PROPERTY = Element.GETPROPPROP(Pipeline, POINTER) returns property number of POINTER of Pipeline.
			%  PROPERTY = PIP.GETPROPPROP(Pipeline, POINTER) returns property number of POINTER of Pipeline.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				pipeline_tag_list = { 'id'  'label'  'notes'  'ps_dict' };
				
				tag = pointer;
				Pipeline.existsTag(tag);
				
				prop = find(strcmpi(tag, pipeline_tag_list));
			else % numeric
				prop = pointer;
				Pipeline.existsProp(prop);
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
			%  TAG = PIP.GETPROPTAG(POINTER) returns tag of POINTER of PIP.
			%  TAG = Element.GETPROPTAG(Pipeline, POINTER) returns tag of POINTER of Pipeline.
			%  TAG = PIP.GETPROPTAG(Pipeline, POINTER) returns tag of POINTER of Pipeline.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Pipeline.existsTag(tag);
			else % numeric
				prop = pointer;
				Pipeline.existsProp(prop);
				
				switch prop
					case Pipeline.ID
						tag = Pipeline.ID_TAG;
					case Pipeline.LABEL
						tag = Pipeline.LABEL_TAG;
					case Pipeline.NOTES
						tag = Pipeline.NOTES_TAG;
					case Pipeline.PS_DICT
						tag = Pipeline.PS_DICT_TAG;
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
			%  CATEGORY = PIP.GETPROPCATEGORY(POINTER) returns category of POINTER of PIP.
			%  CATEGORY = Element.GETPROPCATEGORY(Pipeline, POINTER) returns category of POINTER of Pipeline.
			%  CATEGORY = PIP.GETPROPCATEGORY(Pipeline, POINTER) returns category of POINTER of Pipeline.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					prop_category = Pipeline.ID_CATEGORY;
				case Pipeline.LABEL
					prop_category = Pipeline.LABEL_CATEGORY;
				case Pipeline.NOTES
					prop_category = Pipeline.NOTES_CATEGORY;
				case Pipeline.PS_DICT
					prop_category = Pipeline.PS_DICT_CATEGORY;
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
			%  FORMAT = PIP.GETPROPFORMAT(POINTER) returns format of POINTER of PIP.
			%  FORMAT = Element.GETPROPFORMAT(Pipeline, POINTER) returns format of POINTER of Pipeline.
			%  FORMAT = PIP.GETPROPFORMAT(Pipeline, POINTER) returns format of POINTER of Pipeline.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					prop_format = Pipeline.ID_FORMAT;
				case Pipeline.LABEL
					prop_format = Pipeline.LABEL_FORMAT;
				case Pipeline.NOTES
					prop_format = Pipeline.NOTES_FORMAT;
				case Pipeline.PS_DICT
					prop_format = Pipeline.PS_DICT_FORMAT;
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
			%  DESCRIPTION = PIP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PIP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Pipeline, POINTER) returns description of POINTER of Pipeline.
			%  DESCRIPTION = PIP.GETPROPDESCRIPTION(Pipeline, POINTER) returns description of POINTER of Pipeline.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					prop_description = 'ID (data, string) is a code for the pipeline (typically its file name).';
				case Pipeline.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline.';
				case Pipeline.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline.';
				case Pipeline.PS_DICT
					prop_description = 'PS_DICT (data, idict) is an indexed dictionary with the code sections.';
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
			%  SETTINGS = PIP.GETPROPSETTINGS(POINTER) returns settings of POINTER of PIP.
			%  SETTINGS = Element.GETPROPSETTINGS(Pipeline, POINTER) returns settings of POINTER of Pipeline.
			%  SETTINGS = PIP.GETPROPSETTINGS(Pipeline, POINTER) returns settings of POINTER of Pipeline.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Pipeline.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Pipeline.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Pipeline.PS_DICT
					prop_settings = 'PipelineSection';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PIP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PIP.
			%  DEFAULT = Element.GETPROPDEFAULT(Pipeline, POINTER) returns the default value of POINTER of Pipeline.
			%  DEFAULT = PIP.GETPROPDEFAULT(Pipeline, POINTER) returns the default value of POINTER of Pipeline.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					prop_default = Format.getFormatDefault(Format.STRING, Pipeline.getPropSettings(prop));
				case Pipeline.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Pipeline.getPropSettings(prop));
				case Pipeline.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Pipeline.getPropSettings(prop));
				case Pipeline.PS_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Pipeline.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PIP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PIP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Pipeline, POINTER) returns the conditioned default value of POINTER of Pipeline.
			%  DEFAULT = PIP.GETPROPDEFAULTCONDITIONED(Pipeline, POINTER) returns the conditioned default value of POINTER of Pipeline.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			prop_default = Pipeline.conditioning(prop, Pipeline.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PIP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PIP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PIP.
			%  CHECK = Element.CHECKPROP(Pipeline, PROP, VALUE) checks VALUE format for PROP of Pipeline.
			%  CHECK = PIP.CHECKPROP(Pipeline, PROP, VALUE) checks VALUE format for PROP of Pipeline.
			% 
			% PIP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Pipeline:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PIP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.CHECKPROP(Pipeline, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  PIP.CHECKPROP(Pipeline, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case Pipeline.ID
					check = Format.checkFormat(Format.STRING, value, Pipeline.getPropSettings(prop));
				case Pipeline.LABEL
					check = Format.checkFormat(Format.STRING, value, Pipeline.getPropSettings(prop));
				case Pipeline.NOTES
					check = Format.checkFormat(Format.STRING, value, Pipeline.getPropSettings(prop));
				case Pipeline.PS_DICT
					check = Format.checkFormat(Format.IDICT, value, Pipeline.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Pipeline:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Pipeline.getPropTag(prop) ' (' Pipeline.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pip = Pipeline(varargin)
			% Pipeline() creates a analysis pipeline.
			%
			% Pipeline(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Pipeline(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Pipeline properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a code for the pipeline (typically its file name).
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the pipeline.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the pipeline.
			%  <strong>4</strong> <strong>ps_dict</strong> 	PS_DICT (data, idict) is an indexed dictionary with the code sections.
			%
			% See also Category, Format, set, check.
			
			pip = pip@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(pip, prop, varargin)
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
				case Pipeline.NOTES
					pr = PlotPropString('EL', pip, 'PROP', Pipeline.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 8.5, varargin{:});
					
				case Pipeline.PS_DICT
					pr = PPPipeline_PSDict('EL', pip, 'PROP', Pipeline.PS_DICT, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(pip, prop, varargin{:});
					
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
			    'Label', 'Import BRAPH2 ...', ...
			    'Callback', {@cb_importer_BRAPH2});
			function cb_importer_BRAPH2(~, ~)
			    im = ImporterPipelineBRAPH2( ...
			        'ID', 'Import BRAPH2 Pipeline', ...
			        'WAITBAR', true ...
			        );
			    im.uigetfile();
			    try
			        if isfile(im.get('FILE'))
			            pip = pe.get('EL');
			            
			            assert( ...
			                all(cellfun(@(prop) ~pip.isLocked(prop), num2cell(pip.getProps()))), ...
			                [BRAPH2.STR ':Pipeline:' BRAPH2.BUG_FUNC], ...
			                'To import an element, all its properties must be unlocked.' ...
			                )
			            
			            pip_new = im.get('PIP');
			            for prop = 1:1:pip.getPropNumber()
			                if pip.getPropCategory(prop) ~= Category.RESULT
			                    pip.set(prop, pip_new.get(prop))
			                end
			            end
			            
			            pe.reinit(pip_new)
			        end
			    catch e
			        warndlg(['Please, select a valid input Pipeline in BRAPH2 format. ' newline() ...
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
			    'Label', 'Export BRAPH2 ...', ...
			    'Callback', {@cb_exporter_BRAPH2});
			function cb_exporter_BRAPH2(~, ~)
			    ex = ExporterPipelineBRAPH2( ...
			        'ID', 'Export BRAPH2 Pipeline', ...
			        'PIP', el.copy(), ...
			        'WAITBAR', true ...
			        );
			    ex.uiputfile()
			    if ~strcmp(ex.get('FILE'), ExporterPipelineBRAPH2.getPropDefault('FILE'))
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
