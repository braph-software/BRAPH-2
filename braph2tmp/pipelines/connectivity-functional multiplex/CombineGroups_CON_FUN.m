classdef CombineGroups_CON_FUN < Element
	% CombineGroups_CON_FUN combines a group of subjects with connectivity data with a group of subjects with functional data.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% CombineGroups_CON_FUN combines a group of subjects with connectivity data with a group of subjects with functional data.
	% Combines the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
	% copied from the first group, in this case connectivity.
	%
	% The list of CombineGroups_CON_FUN properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group combiner.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group combiner.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group combiner.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>5</strong> <strong>gr1</strong> 	GR1 (data, item) is a group of subjects with connectivity data.
	%  <strong>6</strong> <strong>gr2</strong> 	GR2 (data, item) is a group of subjects with functional data.
	%  <strong>7</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with connectivity and functional data.
	%
	% CombineGroups_CON_FUN methods (constructor):
	% CombineGroups_CON_FUN - constructor
	%
	% CombineGroups_CON_FUN methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in combines the CON subject group with the FUN subject group/error.
	%  existsProp - checks whether property exists in combines the CON subject group with the FUN subject group/error.
	%  getPropNumber - returns the property number of combines the CON subject group with the FUN subject group.
	%  getProps - returns the property list of combines the CON subject group with the FUN subject group.
	%  getDescription - returns the description of the combines the CON subject group with the FUN subject group.
	%  getName - returns the name of the combines the CON subject group with the FUN subject group.
	%  getClass - returns the class of the combines the CON subject group with the FUN subject group.
	%
	% CombineGroups_CON_FUN methods:
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
	% CombineGroups_CON_FUN methods (operators):
	%  isequal - determines whether two CombineGroups_CON_FUN are equal (values, locked)
	%
	% CombineGroups_CON_FUN methods (display):
	%  tostring - string with information about the CombineGroups_CON_FUN
	%  disp - displays information about the CombineGroups_CON_FUN
	%  tree - displays the element of CombineGroups_CON_FUN
	%
	% CombineGroups_CON_FUN method (element list):
	%  getElementList - returns a list with all subelements of CombineGroups_CON_FUN
	%
	% CombineGroups_CON_FUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the CombineGroups_CON_FUN
	%
	% CombineGroups_CON_FUN method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the CombineGroups_CON_FUN
	%
	% CombineGroups_CON_FUN methods (copy):
	%  copy - copies the CombineGroups_CON_FUN
	%  deepclone - deep-clones the CombineGroups_CON_FUN
	%  clone - clones the CombineGroups_CON_FUN
	%
	% CombineGroups_CON_FUN methods (inspection, Static):
	%  getClass - returns CombineGroups_CON_FUN
	%  getName - returns the name of CombineGroups_CON_FUN
	%  getDescription - returns the description of CombineGroups_CON_FUN
	%  getProps - returns the property list of CombineGroups_CON_FUN
	%  getPropNumber - returns the property number of CombineGroups_CON_FUN
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
	% CombineGroups_CON_FUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CombineGroups_CON_FUN methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% CombineGroups_CON_FUN methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% CombineGroups_CON_FUN methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% CombineGroups_CON_FUN properties (Constant).
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
	%  GR1 - 5
	%  GR1_TAG - 'gr1'
	%  GR1_CATEGORY - 'd'
	%  GR1_FORMAT - 'it'
	%  GR2 - 6
	%  GR2_TAG - 'gr2'
	%  GR2_CATEGORY - 'd'
	%  GR2_FORMAT - 'it'
	%  GR - 7
	%  GR_TAG - 'gr'
	%  GR_CATEGORY - 'r'
	%  GR_FORMAT - 'it'
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
	% See also Element.
	
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
		
		GR1 = 5;
		GR1_TAG = 'gr1';
		GR1_CATEGORY = Category.DATA;
		GR1_FORMAT = Format.ITEM;
		
		GR2 = 6;
		GR2_TAG = 'gr2';
		GR2_CATEGORY = Category.DATA;
		GR2_FORMAT = Format.ITEM;
		
		GR = 7;
		GR_TAG = 'gr';
		GR_CATEGORY = Category.RESULT;
		GR_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function co_class = getClass()
			%GETCLASS returns the class of the combines the CON subject group with the FUN subject group.
			%
			% CLASS = CombineGroups_CON_FUN.GETCLASS() returns the class 'CombineGroups_CON_FUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CO.GETCLASS() returns the class of the combines the CON subject group with the FUN subject group CO.
			%  CLASS = Element.GETCLASS(CO) returns the class of 'CO'.
			%  CLASS = Element.GETCLASS('CombineGroups_CON_FUN') returns 'CombineGroups_CON_FUN'.
			%
			% See also getName, getDescription.
			
			co_class = 'CombineGroups_CON_FUN';
		end
		function co_name = getName()
			%GETNAME returns the name of the combines the CON subject group with the FUN subject group.
			%
			% NAME = CombineGroups_CON_FUN.GETNAME() returns the name of the 'combines the CON subject group with the FUN subject group'.
			%  Combines The CON Subject Group With The FUN Subject Group.
			%
			% Alternative forms to call this method are:
			%  NAME = CO.GETNAME() returns the name of the combines the CON subject group with the FUN subject group CO.
			%  NAME = Element.GETNAME(CO) returns the name of 'CO'.
			%  NAME = Element.GETNAME('CombineGroups_CON_FUN') returns the name of 'CombineGroups_CON_FUN'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			co_name = 'Combines The CON Subject Group With The FUN Subject Group';
		end
		function co_description = getDescription()
			%GETDESCRIPTION returns the description of the combines the CON subject group with the FUN subject group.
			%
			% STR = CombineGroups_CON_FUN.GETDESCRIPTION() returns the description of the 'combines the CON subject group with the FUN subject group'.
			%  which is:
			%
			%  CombineGroups_CON_FUN combines a group of subjects with connectivity data with a group of subjects with functional data.
			%  Combines the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
			%  copied from the first group, in this case connectivity.
			%
			% Alternative forms to call this method are:
			%  STR = CO.GETDESCRIPTION() returns the description of the combines the CON subject group with the FUN subject group CO.
			%  STR = Element.GETDESCRIPTION(CO) returns the description of 'CO'.
			%  STR = Element.GETDESCRIPTION('CombineGroups_CON_FUN') returns the description of 'CombineGroups_CON_FUN'.
			%
			% See also getClass, getName.
			
			co_description = [
				'CombineGroups_CON_FUN combines a group of subjects with connectivity data with a group of subjects with functional data.' ...
				'Combines the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are' ...
				'copied from the first group, in this case connectivity.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of combines the CON subject group with the FUN subject group.
			%
			% PROPS = CombineGroups_CON_FUN.GETPROPS() returns the property list of combines the CON subject group with the FUN subject group.
			%
			% PROPS = CombineGroups_CON_FUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CO.GETPROPS([CATEGORY]) returns the property list of the combines the CON subject group with the FUN subject group CO.
			%  PROPS = Element.GETPROPS(CO[, CATEGORY]) returns the property list of 'CO'.
			%  PROPS = Element.GETPROPS('CombineGroups_CON_FUN'[, CATEGORY]) returns the property list of 'CombineGroups_CON_FUN'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						CombineGroups_CON_FUN.LABEL
						CombineGroups_CON_FUN.NOTES
						CombineGroups_CON_FUN.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						CombineGroups_CON_FUN.ID
						CombineGroups_CON_FUN.GR1
						CombineGroups_CON_FUN.GR2
						];
				case Category.RESULT
					prop_list = [
						CombineGroups_CON_FUN.GR
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						CombineGroups_CON_FUN.ID
						CombineGroups_CON_FUN.LABEL
						CombineGroups_CON_FUN.NOTES
						CombineGroups_CON_FUN.WAITBAR
						CombineGroups_CON_FUN.GR1
						CombineGroups_CON_FUN.GR2
						CombineGroups_CON_FUN.GR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of combines the CON subject group with the FUN subject group.
			%
			% N = CombineGroups_CON_FUN.GETPROPNUMBER() returns the property number of combines the CON subject group with the FUN subject group.
			%
			% Alternative forms to call this method are:
			%  N = CO.GETPROPNUMBER() returns the property number of the combines the CON subject group with the FUN subject group CO.
			%  N = Element.GETPROPNUMBER(CO) returns the property number of 'CO'.
			%  N = Element.GETPROPNUMBER('CombineGroups_CON_FUN') returns the property number of 'CombineGroups_CON_FUN'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in combines the CON subject group with the FUN subject group/error.
			%
			% CHECK = CombineGroups_CON_FUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CO.EXISTSPROP(PROP) checks whether PROP exists for CO.
			%  CHECK = Element.EXISTSPROP(CO, PROP) checks whether PROP exists for CO.
			%  CHECK = Element.EXISTSPROP(CombineGroups_CON_FUN, PROP) checks whether PROP exists for CombineGroups_CON_FUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CO.EXISTSPROP(PROP) throws error if PROP does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  Element.EXISTSPROP(CO, PROP) throws error if PROP does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  Element.EXISTSPROP(CombineGroups_CON_FUN, PROP) throws error if PROP does NOT exist for CombineGroups_CON_FUN.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					CombineGroups_CON_FUN.existsProp(prop), ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CombineGroups_CON_FUN.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in combines the CON subject group with the FUN subject group/error.
			%
			% CHECK = CombineGroups_CON_FUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CO.EXISTSTAG(TAG) checks whether TAG exists for CO.
			%  CHECK = Element.EXISTSTAG(CO, TAG) checks whether TAG exists for CO.
			%  CHECK = Element.EXISTSTAG(CombineGroups_CON_FUN, TAG) checks whether TAG exists for CombineGroups_CON_FUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CO.EXISTSTAG(TAG) throws error if TAG does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  Element.EXISTSTAG(CO, TAG) throws error if TAG does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  Element.EXISTSTAG(CombineGroups_CON_FUN, TAG) throws error if TAG does NOT exist for CombineGroups_CON_FUN.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				combinegroups_con_fun_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr1'  'gr2'  'gr' };
				
				check = any(strcmpi(tag, combinegroups_con_fun_tag_list));
			else
				assert( ...
					CombineGroups_CON_FUN.existsTag(tag), ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for CombineGroups_CON_FUN'] ...
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
			%  PROPERTY = CO.GETPROPPROP(POINTER) returns property number of POINTER of CO.
			%  PROPERTY = Element.GETPROPPROP(CombineGroups_CON_FUN, POINTER) returns property number of POINTER of CombineGroups_CON_FUN.
			%  PROPERTY = CO.GETPROPPROP(CombineGroups_CON_FUN, POINTER) returns property number of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				combinegroups_con_fun_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr1'  'gr2'  'gr' };
				
				tag = pointer;
				CombineGroups_CON_FUN.existsTag(tag);
				
				prop = find(strcmpi(tag, combinegroups_con_fun_tag_list));
			else % numeric
				prop = pointer;
				CombineGroups_CON_FUN.existsProp(prop);
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
			%  TAG = CO.GETPROPTAG(POINTER) returns tag of POINTER of CO.
			%  TAG = Element.GETPROPTAG(CombineGroups_CON_FUN, POINTER) returns tag of POINTER of CombineGroups_CON_FUN.
			%  TAG = CO.GETPROPTAG(CombineGroups_CON_FUN, POINTER) returns tag of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				CombineGroups_CON_FUN.existsTag(tag);
			else % numeric
				prop = pointer;
				CombineGroups_CON_FUN.existsProp(prop);
				
				switch prop
					case CombineGroups_CON_FUN.ID
						tag = CombineGroups_CON_FUN.ID_TAG;
					case CombineGroups_CON_FUN.LABEL
						tag = CombineGroups_CON_FUN.LABEL_TAG;
					case CombineGroups_CON_FUN.NOTES
						tag = CombineGroups_CON_FUN.NOTES_TAG;
					case CombineGroups_CON_FUN.WAITBAR
						tag = CombineGroups_CON_FUN.WAITBAR_TAG;
					case CombineGroups_CON_FUN.GR1
						tag = CombineGroups_CON_FUN.GR1_TAG;
					case CombineGroups_CON_FUN.GR2
						tag = CombineGroups_CON_FUN.GR2_TAG;
					case CombineGroups_CON_FUN.GR
						tag = CombineGroups_CON_FUN.GR_TAG;
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
			%  CATEGORY = CO.GETPROPCATEGORY(POINTER) returns category of POINTER of CO.
			%  CATEGORY = Element.GETPROPCATEGORY(CombineGroups_CON_FUN, POINTER) returns category of POINTER of CombineGroups_CON_FUN.
			%  CATEGORY = CO.GETPROPCATEGORY(CombineGroups_CON_FUN, POINTER) returns category of POINTER of CombineGroups_CON_FUN.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					prop_category = CombineGroups_CON_FUN.ID_CATEGORY;
				case CombineGroups_CON_FUN.LABEL
					prop_category = CombineGroups_CON_FUN.LABEL_CATEGORY;
				case CombineGroups_CON_FUN.NOTES
					prop_category = CombineGroups_CON_FUN.NOTES_CATEGORY;
				case CombineGroups_CON_FUN.WAITBAR
					prop_category = CombineGroups_CON_FUN.WAITBAR_CATEGORY;
				case CombineGroups_CON_FUN.GR1
					prop_category = CombineGroups_CON_FUN.GR1_CATEGORY;
				case CombineGroups_CON_FUN.GR2
					prop_category = CombineGroups_CON_FUN.GR2_CATEGORY;
				case CombineGroups_CON_FUN.GR
					prop_category = CombineGroups_CON_FUN.GR_CATEGORY;
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
			%  FORMAT = CO.GETPROPFORMAT(POINTER) returns format of POINTER of CO.
			%  FORMAT = Element.GETPROPFORMAT(CombineGroups_CON_FUN, POINTER) returns format of POINTER of CombineGroups_CON_FUN.
			%  FORMAT = CO.GETPROPFORMAT(CombineGroups_CON_FUN, POINTER) returns format of POINTER of CombineGroups_CON_FUN.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					prop_format = CombineGroups_CON_FUN.ID_FORMAT;
				case CombineGroups_CON_FUN.LABEL
					prop_format = CombineGroups_CON_FUN.LABEL_FORMAT;
				case CombineGroups_CON_FUN.NOTES
					prop_format = CombineGroups_CON_FUN.NOTES_FORMAT;
				case CombineGroups_CON_FUN.WAITBAR
					prop_format = CombineGroups_CON_FUN.WAITBAR_FORMAT;
				case CombineGroups_CON_FUN.GR1
					prop_format = CombineGroups_CON_FUN.GR1_FORMAT;
				case CombineGroups_CON_FUN.GR2
					prop_format = CombineGroups_CON_FUN.GR2_FORMAT;
				case CombineGroups_CON_FUN.GR
					prop_format = CombineGroups_CON_FUN.GR_FORMAT;
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
			%  DESCRIPTION = CO.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CO.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CombineGroups_CON_FUN, POINTER) returns description of POINTER of CombineGroups_CON_FUN.
			%  DESCRIPTION = CO.GETPROPDESCRIPTION(CombineGroups_CON_FUN, POINTER) returns description of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					prop_description = 'ID (data, string) is a few-letter code for the group combiner.';
				case CombineGroups_CON_FUN.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group combiner.';
				case CombineGroups_CON_FUN.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group combiner.';
				case CombineGroups_CON_FUN.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) detemines whether to show the waitbar.';
				case CombineGroups_CON_FUN.GR1
					prop_description = 'GR1 (data, item) is a group of subjects with connectivity data.';
				case CombineGroups_CON_FUN.GR2
					prop_description = 'GR2 (data, item) is a group of subjects with functional data.';
				case CombineGroups_CON_FUN.GR
					prop_description = 'GR (result, item) is a group of subjects with connectivity and functional data.';
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
			%  SETTINGS = CO.GETPROPSETTINGS(POINTER) returns settings of POINTER of CO.
			%  SETTINGS = Element.GETPROPSETTINGS(CombineGroups_CON_FUN, POINTER) returns settings of POINTER of CombineGroups_CON_FUN.
			%  SETTINGS = CO.GETPROPSETTINGS(CombineGroups_CON_FUN, POINTER) returns settings of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CombineGroups_CON_FUN.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CombineGroups_CON_FUN.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case CombineGroups_CON_FUN.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CombineGroups_CON_FUN.GR1
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case CombineGroups_CON_FUN.GR2
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case CombineGroups_CON_FUN.GR
					prop_settings = 'Group';
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CombineGroups_CON_FUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CombineGroups_CON_FUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CO.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CO.
			%  DEFAULT = Element.GETPROPDEFAULT(CombineGroups_CON_FUN, POINTER) returns the default value of POINTER of CombineGroups_CON_FUN.
			%  DEFAULT = CO.GETPROPDEFAULT(CombineGroups_CON_FUN, POINTER) returns the default value of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					prop_default = Format.getFormatDefault(Format.STRING, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.GR1
					prop_default = Group('SUB_CLASS', 'SubjectCON');
				case CombineGroups_CON_FUN.GR2
					prop_default = Group('SUB_CLASS', 'SubjectFUN');
				case CombineGroups_CON_FUN.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CombineGroups_CON_FUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CombineGroups_CON_FUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CO.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CO.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CombineGroups_CON_FUN, POINTER) returns the conditioned default value of POINTER of CombineGroups_CON_FUN.
			%  DEFAULT = CO.GETPROPDEFAULTCONDITIONED(CombineGroups_CON_FUN, POINTER) returns the conditioned default value of POINTER of CombineGroups_CON_FUN.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			prop_default = CombineGroups_CON_FUN.conditioning(prop, CombineGroups_CON_FUN.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CO.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CO.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CO.
			%  CHECK = Element.CHECKPROP(CombineGroups_CON_FUN, PROP, VALUE) checks VALUE format for PROP of CombineGroups_CON_FUN.
			%  CHECK = CO.CHECKPROP(CombineGroups_CON_FUN, PROP, VALUE) checks VALUE format for PROP of CombineGroups_CON_FUN.
			% 
			% CO.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CO.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  Element.CHECKPROP(CombineGroups_CON_FUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CombineGroups_CON_FUN.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			%  CO.CHECKPROP(CombineGroups_CON_FUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CombineGroups_CON_FUN.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				case CombineGroups_CON_FUN.ID
					check = Format.checkFormat(Format.STRING, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.LABEL
					check = Format.checkFormat(Format.STRING, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.NOTES
					check = Format.checkFormat(Format.STRING, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.GR1
					check = Format.checkFormat(Format.ITEM, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.GR2
					check = Format.checkFormat(Format.ITEM, value, CombineGroups_CON_FUN.getPropSettings(prop));
				case CombineGroups_CON_FUN.GR
					check = Format.checkFormat(Format.ITEM, value, CombineGroups_CON_FUN.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CombineGroups_CON_FUN.getPropTag(prop) ' (' CombineGroups_CON_FUN.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function co = CombineGroups_CON_FUN(varargin)
			% CombineGroups_CON_FUN() creates a combines the CON subject group with the FUN subject group.
			%
			% CombineGroups_CON_FUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CombineGroups_CON_FUN(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CombineGroups_CON_FUN properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group combiner.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group combiner.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group combiner.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>5</strong> <strong>gr1</strong> 	GR1 (data, item) is a group of subjects with connectivity data.
			%  <strong>6</strong> <strong>gr2</strong> 	GR2 (data, item) is a group of subjects with functional data.
			%  <strong>7</strong> <strong>gr</strong> 	GR (result, item) is a group of subjects with connectivity and functional data.
			%
			% See also Category, Format, set, check.
			
			co = co@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = CombineGroups_CON_FUN.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(co, prop, value)
			check = true;
			msg = ['Error while checking' tostring(co) ' ' co.getPropTag(prop) '.'];
			
			switch prop
				case CombineGroups_CON_FUN.GR
					check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_FUN_MP', [], [], true)));
					
				otherwise
					[check, msg] = checkValue@Element(co, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(co, prop)
		
			switch prop
				case CombineGroups_CON_FUN.GR
					rng(co.getPropSeed(CombineGroups_CON_FUN.GR), 'twister')
					
					if co.get('WAITBAR')
					    wb = waitbar(0, 'Combining subject groups ...', 'Name', BRAPH2.NAME);
					    set_braph2icon(wb)
					end
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP') ...
					    );
					
					% get connectivity and functional groups
					group1 = co.get('GR1');
					group2 = co.get('GR2');
					
					% assert that the 2 groups have the same number of subjects
					assert(isequal(group1.get('SUB_DICT').length(), group2.get('SUB_DICT').length()), ...
					    [BRAPH2.STR ':CombineGroups_CON_FUN:' BRAPH2.BUG_ERR], ...
					    ['The 2 groups to be combined need to have the same number of subjects while ', ...
					    'group 1 has ' tostring(group1.get('SUB_DICT').length()) ' subjects and group 2 has ' tostring(group2.get('SUB_DICT').length()) ' subjects.'])
					
					% sets group props
					gr.set( ...
					    'ID', group1.get('ID'), ...
					    'LABEL', group1.get('LABEL'), ...
					    'NOTES', 'Combined group with CON and FUN data'...
					    );
					
					subdict = gr.get('SUB_DICT');
					subdict_gr1 = group1.get('SUB_DICT');
					subdict_gr2 = group2.get('SUB_DICT');
					
					for i = 1:1:group1.get('SUB_DICT').length()
					    if co.get('WAITBAR')
					        waitbar(.30 + .70 * i / group1.get('SUB_DICT').length(), wb, ['Combining subject ' num2str(i) ' of ' num2str(group1.get('SUB_DICT').length()) ' ...'])
					    end
					
					    sub1 = subdict_gr1.getItem(i);
					    sub2 = subdict_gr2.getItem(i);
					    CON_FUN_MP = cell(2, 1);
					    CON_FUN_MP(1) = {sub1.get('CON')};
					    CON_FUN_MP(2) = {sub2.get('FUN')};
					    
					    % add CON_FUN_MP subject
					    sub = SubjectCON_FUN_MP( ...
					        'ID', sub1.get('ID'), ...
					        'BA', sub1.get('BA'), ...
					        'L', 2, ...
					        'CON_FUN_MP', CON_FUN_MP, ...
					        'age', sub1.get('age'), ...
					        'sex', sub1.get('sex') ...
					        );
					    subdict.add(sub);
					end
					gr.set('sub_dict', subdict);
					
					value = gr;
					
					if co.get('WAITBAR')
					    close(wb)
					end
					
				otherwise
					value = calculateValue@Element(co, prop);
					
			end
		end
	end
end
