classdef Subject < Element
	% Subject is a subject.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Subject provides the methods necessary for all subjects. 
	% Instances of this element should not be created. 
	% Use one of its subelements instead.
	%
	% The list of Subject properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the subject.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the subject.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the subject.
	%
	% Subject methods (constructor):
	% Subject - constructor
	%
	% Subject methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in subject/error.
	%  existsProp - checks whether property exists in subject/error.
	%  getPropNumber - returns the property number of subject.
	%  getProps - returns the property list of subject.
	%  getDescription - returns the description of the subject.
	%  getName - returns the name of the subject.
	%  getClass - returns the class of the subject.
	%
	% Subject methods:
	%  tostring - string with information about the subject.
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
	% Subject methods (operators):
	%  isequal - determines whether two Subject are equal (values, locked)
	%
	% Subject methods (display):
	%  tostring - string with information about the Subject
	%  disp - displays information about the Subject
	%  tree - displays the element of Subject
	%
	% Subject method (element list):
	%  getElementList - returns a list with all subelements of Subject
	%
	% Subject method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Subject
	%
	% Subject method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Subject
	%
	% Subject methods (copy):
	%  copy - copies the Subject
	%  deepclone - deep-clones the Subject
	%  clone - clones the Subject
	%
	% Subject methods (inspection, Static):
	%  getClass - returns Subject
	%  getName - returns the name of Subject
	%  getDescription - returns the description of Subject
	%  getProps - returns the property list of Subject
	%  getPropNumber - returns the property number of Subject
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
	% Subject methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Subject methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Subject methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Subject methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Subject properties (Constant).
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
	% See also Element, BrainAtlas, Group.
	
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
	end
	methods (Static) % inspection methods
		function sub_class = getClass()
			%GETCLASS returns the class of the subject.
			%
			% CLASS = Subject.GETCLASS() returns the class 'Subject'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('Subject') returns 'Subject'.
			%
			% See also getName, getDescription.
			
			sub_class = 'Subject';
		end
		function sub_name = getName()
			%GETNAME returns the name of the subject.
			%
			% NAME = Subject.GETNAME() returns the name of the 'subject'.
			%  Subject.
			%
			% Alternative forms to call this method are:
			%  NAME = SUB.GETNAME() returns the name of the subject SUB.
			%  NAME = Element.GETNAME(SUB) returns the name of 'SUB'.
			%  NAME = Element.GETNAME('Subject') returns the name of 'Subject'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			sub_name = 'Subject';
		end
		function sub_description = getDescription()
			%GETDESCRIPTION returns the description of the subject.
			%
			% STR = Subject.GETDESCRIPTION() returns the description of the 'subject'.
			%  which is:
			%
			%  Subject provides the methods necessary for all subjects. 
			%  Instances of this element should not be created. 
			%  Use one of its subelements instead.
			%
			% Alternative forms to call this method are:
			%  STR = SUB.GETDESCRIPTION() returns the description of the subject SUB.
			%  STR = Element.GETDESCRIPTION(SUB) returns the description of 'SUB'.
			%  STR = Element.GETDESCRIPTION('Subject') returns the description of 'Subject'.
			%
			% See also getClass, getName.
			
			sub_description = [
				'Subject provides the methods necessary for all subjects. ' ...
				'Instances of this element should not be created. ' ...
				'Use one of its subelements instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject.
			%
			% PROPS = Subject.GETPROPS() returns the property list of subject.
			%
			% PROPS = Subject.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('Subject'[, CATEGORY]) returns the property list of 'Subject'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Subject.LABEL
						Subject.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Subject.ID
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
						Subject.ID
						Subject.LABEL
						Subject.NOTES
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of subject.
			%
			% N = Subject.GETPROPNUMBER() returns the property number of subject.
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER() returns the property number of the subject SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('Subject') returns the property number of 'Subject'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 3;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject/error.
			%
			% CHECK = Subject.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(Subject, PROP) checks whether PROP exists for Subject.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Subject:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSPROP(Subject, PROP) throws error if PROP does NOT exist for Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3 ]);
			else
				assert( ...
					Subject.existsProp(prop), ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Subject.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject/error.
			%
			% CHECK = Subject.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(Subject, TAG) checks whether TAG exists for Subject.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Subject:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.EXISTSTAG(Subject, TAG) throws error if TAG does NOT exist for Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				subject_tag_list = { 'id'  'label'  'notes' };
				
				check = any(strcmpi(tag, subject_tag_list));
			else
				assert( ...
					Subject.existsTag(tag), ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Subject'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(Subject, POINTER) returns property number of POINTER of Subject.
			%  PROPERTY = SUB.GETPROPPROP(Subject, POINTER) returns property number of POINTER of Subject.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				subject_tag_list = { 'id'  'label'  'notes' };
				
				tag = pointer;
				Subject.existsTag(tag);
				
				prop = find(strcmpi(tag, subject_tag_list));
			else % numeric
				prop = pointer;
				Subject.existsProp(prop);
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(Subject, POINTER) returns tag of POINTER of Subject.
			%  TAG = SUB.GETPROPTAG(Subject, POINTER) returns tag of POINTER of Subject.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Subject.existsTag(tag);
			else % numeric
				prop = pointer;
				Subject.existsProp(prop);
				
				switch prop
					case Subject.ID
						tag = Subject.ID_TAG;
					case Subject.LABEL
						tag = Subject.LABEL_TAG;
					case Subject.NOTES
						tag = Subject.NOTES_TAG;
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(Subject, POINTER) returns category of POINTER of Subject.
			%  CATEGORY = SUB.GETPROPCATEGORY(Subject, POINTER) returns category of POINTER of Subject.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					prop_category = Subject.ID_CATEGORY;
				case Subject.LABEL
					prop_category = Subject.LABEL_CATEGORY;
				case Subject.NOTES
					prop_category = Subject.NOTES_CATEGORY;
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(Subject, POINTER) returns format of POINTER of Subject.
			%  FORMAT = SUB.GETPROPFORMAT(Subject, POINTER) returns format of POINTER of Subject.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					prop_format = Subject.ID_FORMAT;
				case Subject.LABEL
					prop_format = Subject.LABEL_FORMAT;
				case Subject.NOTES
					prop_format = Subject.NOTES_FORMAT;
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Subject, POINTER) returns description of POINTER of Subject.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(Subject, POINTER) returns description of POINTER of Subject.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					prop_description = 'ID (data, string) is a few-letter code for the subject.';
				case Subject.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the subject.';
				case Subject.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the subject.';
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(Subject, POINTER) returns settings of POINTER of Subject.
			%  SETTINGS = SUB.GETPROPSETTINGS(Subject, POINTER) returns settings of POINTER of Subject.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Subject.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Subject.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Subject.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Subject.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(Subject, POINTER) returns the default value of POINTER of Subject.
			%  DEFAULT = SUB.GETPROPDEFAULT(Subject, POINTER) returns the default value of POINTER of Subject.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					prop_default = Format.getFormatDefault(Format.STRING, Subject.getPropSettings(prop));
				case Subject.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Subject.getPropSettings(prop));
				case Subject.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Subject.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Subject.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Subject.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Subject, POINTER) returns the conditioned default value of POINTER of Subject.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(Subject, POINTER) returns the conditioned default value of POINTER of Subject.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Subject.getPropProp(pointer);
			
			prop_default = Subject.conditioning(prop, Subject.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(Subject, PROP, VALUE) checks VALUE format for PROP of Subject.
			%  CHECK = SUB.CHECKPROP(Subject, PROP, VALUE) checks VALUE format for PROP of Subject.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Subject:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  Element.CHECKPROP(Subject, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			%  SUB.CHECKPROP(Subject, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Subject.
			%   Error id: [BRAPH2:Subject:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Subject.getPropProp(pointer);
			
			switch prop
				case Subject.ID
					check = Format.checkFormat(Format.STRING, value, Subject.getPropSettings(prop));
				case Subject.LABEL
					check = Format.checkFormat(Format.STRING, value, Subject.getPropSettings(prop));
				case Subject.NOTES
					check = Format.checkFormat(Format.STRING, value, Subject.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Subject:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Subject.getPropTag(prop) ' (' Subject.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function sub = Subject(varargin)
			% Subject() creates a subject.
			%
			% Subject(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Subject(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Subject properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the subject.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the subject.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the subject.
			%
			% See also Category, Format, set, check.
			
			sub = sub@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Subject.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % methods
		function str = tostring(sub, varargin)
		    %TOSTRING string with information about the subject.
		    %
		    % STR = TOSTRING(SUB) returns a string with information about the subject.
		    %
		    % STR = TOSTRING(SUB, N) trims the string to the first N characters.
		    %
		    % STR = TOSTRING(SUB, N, ENDING) ends the string with ENDING if it has
		    %  been trimmed.
		    %
		    % See also disp, tree.
		
		    str = [class(sub) ' ' sub.getPropTag(1) ' = ' tostring(sub.get(1)) '.'];
		
		    str = tostring(str, varargin{:});
		    str = str(2:1:end-1);
		end
	end
	methods % GUI
		function pr = getPlotProp(sub, prop, varargin)
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
				case Subject.ID
					pr = PPSubject_ID('EL', sub, 'PROP', Subject.ID, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(sub, prop, varargin{:});
					
			end
		end
	end
end
