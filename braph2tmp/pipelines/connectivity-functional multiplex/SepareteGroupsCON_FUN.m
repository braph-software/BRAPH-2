classdef SepareteGroupsCON_FUN < Element
	% SepareteGroupsCON_FUN separetes a group of subjects with connectivity data with a group of subjects with functional data.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% SepareteGroups_CON_FUN separetes a group of subjects with connectivity data with a group of subjects with functional data.
	% Separetes the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
	% copied from the first group, in this case connectivity.
	%
	% The list of SepareteGroupsCON_FUN properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group combiner.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group combiner.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group combiner.
	%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar.
	%  <strong>5</strong> <strong>gr_con_fun_mp</strong> 	GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data
	%  <strong>6</strong> <strong>grs</strong> 	GRS (result, cell) is a idict containing two group of subjects with connectivity data and functional data.
	%
	% SepareteGroupsCON_FUN methods (constructor):
	% SepareteGroupsCON_FUN - constructor
	%
	% SepareteGroupsCON_FUN methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in separetes the CON subject group and the FUN subject group from a CON_FUN group/error.
	%  existsProp - checks whether property exists in separetes the CON subject group and the FUN subject group from a CON_FUN group/error.
	%  getPropNumber - returns the property number of separetes the CON subject group and the FUN subject group from a CON_FUN group.
	%  getProps - returns the property list of separetes the CON subject group and the FUN subject group from a CON_FUN group.
	%  getDescription - returns the description of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
	%  getName - returns the name of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
	%  getClass - returns the class of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
	%
	% SepareteGroupsCON_FUN methods:
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
	% SepareteGroupsCON_FUN methods (operators):
	%  isequal - determines whether two SepareteGroupsCON_FUN are equal (values, locked)
	%
	% SepareteGroupsCON_FUN methods (display):
	%  tostring - string with information about the SepareteGroupsCON_FUN
	%  disp - displays information about the SepareteGroupsCON_FUN
	%  tree - displays the element of SepareteGroupsCON_FUN
	%
	% SepareteGroupsCON_FUN method (element list):
	%  getElementList - returns a list with all subelements of SepareteGroupsCON_FUN
	%
	% SepareteGroupsCON_FUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the SepareteGroupsCON_FUN
	%
	% SepareteGroupsCON_FUN method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the SepareteGroupsCON_FUN
	%
	% SepareteGroupsCON_FUN methods (copy):
	%  copy - copies the SepareteGroupsCON_FUN
	%  deepclone - deep-clones the SepareteGroupsCON_FUN
	%  clone - clones the SepareteGroupsCON_FUN
	%
	% SepareteGroupsCON_FUN methods (inspection, Static):
	%  getClass - returns SepareteGroupsCON_FUN
	%  getName - returns the name of SepareteGroupsCON_FUN
	%  getDescription - returns the description of SepareteGroupsCON_FUN
	%  getProps - returns the property list of SepareteGroupsCON_FUN
	%  getPropNumber - returns the property number of SepareteGroupsCON_FUN
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
	% SepareteGroupsCON_FUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SepareteGroupsCON_FUN methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% SepareteGroupsCON_FUN methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% SepareteGroupsCON_FUN methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% SepareteGroupsCON_FUN properties (Constant).
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
	%  GR_CON_FUN_MP - 5
	%  GR_CON_FUN_MP_TAG - 'gr_con_fun_mp'
	%  GR_CON_FUN_MP_CATEGORY - 'd'
	%  GR_CON_FUN_MP_FORMAT - 'it'
	%  GRS - 6
	%  GRS_TAG - 'grs'
	%  GRS_CATEGORY - 'r'
	%  GRS_FORMAT - 'll'
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
		
		GR_CON_FUN_MP = 5;
		GR_CON_FUN_MP_TAG = 'gr_con_fun_mp';
		GR_CON_FUN_MP_CATEGORY = Category.DATA;
		GR_CON_FUN_MP_FORMAT = Format.ITEM;
		
		GRS = 6;
		GRS_TAG = 'grs';
		GRS_CATEGORY = Category.RESULT;
		GRS_FORMAT = Format.CELL;
	end
	methods (Static) % inspection methods
		function se_class = getClass()
			%GETCLASS returns the class of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% CLASS = SepareteGroupsCON_FUN.GETCLASS() returns the class 'SepareteGroupsCON_FUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SE.GETCLASS() returns the class of the separetes the CON subject group and the FUN subject group from a CON_FUN group SE.
			%  CLASS = Element.GETCLASS(SE) returns the class of 'SE'.
			%  CLASS = Element.GETCLASS('SepareteGroupsCON_FUN') returns 'SepareteGroupsCON_FUN'.
			%
			% See also getName, getDescription.
			
			se_class = 'SepareteGroupsCON_FUN';
		end
		function se_name = getName()
			%GETNAME returns the name of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% NAME = SepareteGroupsCON_FUN.GETNAME() returns the name of the 'separetes the CON subject group and the FUN subject group from a CON_FUN group'.
			%  Separetes The CON Subject Group And The FUN Subject Group From A CON_FUN Group.
			%
			% Alternative forms to call this method are:
			%  NAME = SE.GETNAME() returns the name of the separetes the CON subject group and the FUN subject group from a CON_FUN group SE.
			%  NAME = Element.GETNAME(SE) returns the name of 'SE'.
			%  NAME = Element.GETNAME('SepareteGroupsCON_FUN') returns the name of 'SepareteGroupsCON_FUN'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			se_name = 'Separetes The CON Subject Group And The FUN Subject Group From A CON_FUN Group';
		end
		function se_description = getDescription()
			%GETDESCRIPTION returns the description of the separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% STR = SepareteGroupsCON_FUN.GETDESCRIPTION() returns the description of the 'separetes the CON subject group and the FUN subject group from a CON_FUN group'.
			%  which is:
			%
			%  SepareteGroups_CON_FUN separetes a group of subjects with connectivity data with a group of subjects with functional data.
			%  Separetes the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are
			%  copied from the first group, in this case connectivity.
			%
			% Alternative forms to call this method are:
			%  STR = SE.GETDESCRIPTION() returns the description of the separetes the CON subject group and the FUN subject group from a CON_FUN group SE.
			%  STR = Element.GETDESCRIPTION(SE) returns the description of 'SE'.
			%  STR = Element.GETDESCRIPTION('SepareteGroupsCON_FUN') returns the description of 'SepareteGroupsCON_FUN'.
			%
			% See also getClass, getName.
			
			se_description = [
				'SepareteGroups_CON_FUN separetes a group of subjects with connectivity data with a group of subjects with functional data.' ...
				'Separetes the data uploaded through the connectivity and functional workflows. The ID and covariates of subjects are' ...
				'copied from the first group, in this case connectivity.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% PROPS = SepareteGroupsCON_FUN.GETPROPS() returns the property list of separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% PROPS = SepareteGroupsCON_FUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SE.GETPROPS([CATEGORY]) returns the property list of the separetes the CON subject group and the FUN subject group from a CON_FUN group SE.
			%  PROPS = Element.GETPROPS(SE[, CATEGORY]) returns the property list of 'SE'.
			%  PROPS = Element.GETPROPS('SepareteGroupsCON_FUN'[, CATEGORY]) returns the property list of 'SepareteGroupsCON_FUN'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						SepareteGroupsCON_FUN.LABEL
						SepareteGroupsCON_FUN.NOTES
						SepareteGroupsCON_FUN.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						SepareteGroupsCON_FUN.ID
						SepareteGroupsCON_FUN.GR_CON_FUN_MP
						];
				case Category.RESULT
					prop_list = [
						SepareteGroupsCON_FUN.GRS
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						SepareteGroupsCON_FUN.ID
						SepareteGroupsCON_FUN.LABEL
						SepareteGroupsCON_FUN.NOTES
						SepareteGroupsCON_FUN.WAITBAR
						SepareteGroupsCON_FUN.GR_CON_FUN_MP
						SepareteGroupsCON_FUN.GRS
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% N = SepareteGroupsCON_FUN.GETPROPNUMBER() returns the property number of separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% Alternative forms to call this method are:
			%  N = SE.GETPROPNUMBER() returns the property number of the separetes the CON subject group and the FUN subject group from a CON_FUN group SE.
			%  N = Element.GETPROPNUMBER(SE) returns the property number of 'SE'.
			%  N = Element.GETPROPNUMBER('SepareteGroupsCON_FUN') returns the property number of 'SepareteGroupsCON_FUN'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in separetes the CON subject group and the FUN subject group from a CON_FUN group/error.
			%
			% CHECK = SepareteGroupsCON_FUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSPROP(PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SE, PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SepareteGroupsCON_FUN, PROP) checks whether PROP exists for SepareteGroupsCON_FUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSPROP(PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  Element.EXISTSPROP(SE, PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  Element.EXISTSPROP(SepareteGroupsCON_FUN, PROP) throws error if PROP does NOT exist for SepareteGroupsCON_FUN.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					SepareteGroupsCON_FUN.existsProp(prop), ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SepareteGroupsCON_FUN.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in separetes the CON subject group and the FUN subject group from a CON_FUN group/error.
			%
			% CHECK = SepareteGroupsCON_FUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSTAG(TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SE, TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SepareteGroupsCON_FUN, TAG) checks whether TAG exists for SepareteGroupsCON_FUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSTAG(TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  Element.EXISTSTAG(SE, TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  Element.EXISTSTAG(SepareteGroupsCON_FUN, TAG) throws error if TAG does NOT exist for SepareteGroupsCON_FUN.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				separetegroupscon_fun_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_con_fun_mp'  'grs' };
				
				check = any(strcmpi(tag, separetegroupscon_fun_tag_list));
			else
				assert( ...
					SepareteGroupsCON_FUN.existsTag(tag), ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for SepareteGroupsCON_FUN'] ...
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
			%  PROPERTY = SE.GETPROPPROP(POINTER) returns property number of POINTER of SE.
			%  PROPERTY = Element.GETPROPPROP(SepareteGroupsCON_FUN, POINTER) returns property number of POINTER of SepareteGroupsCON_FUN.
			%  PROPERTY = SE.GETPROPPROP(SepareteGroupsCON_FUN, POINTER) returns property number of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				separetegroupscon_fun_tag_list = { 'id'  'label'  'notes'  'waitbar'  'gr_con_fun_mp'  'grs' };
				
				tag = pointer;
				SepareteGroupsCON_FUN.existsTag(tag);
				
				prop = find(strcmpi(tag, separetegroupscon_fun_tag_list));
			else % numeric
				prop = pointer;
				SepareteGroupsCON_FUN.existsProp(prop);
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
			%  TAG = SE.GETPROPTAG(POINTER) returns tag of POINTER of SE.
			%  TAG = Element.GETPROPTAG(SepareteGroupsCON_FUN, POINTER) returns tag of POINTER of SepareteGroupsCON_FUN.
			%  TAG = SE.GETPROPTAG(SepareteGroupsCON_FUN, POINTER) returns tag of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				SepareteGroupsCON_FUN.existsTag(tag);
			else % numeric
				prop = pointer;
				SepareteGroupsCON_FUN.existsProp(prop);
				
				switch prop
					case SepareteGroupsCON_FUN.ID
						tag = SepareteGroupsCON_FUN.ID_TAG;
					case SepareteGroupsCON_FUN.LABEL
						tag = SepareteGroupsCON_FUN.LABEL_TAG;
					case SepareteGroupsCON_FUN.NOTES
						tag = SepareteGroupsCON_FUN.NOTES_TAG;
					case SepareteGroupsCON_FUN.WAITBAR
						tag = SepareteGroupsCON_FUN.WAITBAR_TAG;
					case SepareteGroupsCON_FUN.GR_CON_FUN_MP
						tag = SepareteGroupsCON_FUN.GR_CON_FUN_MP_TAG;
					case SepareteGroupsCON_FUN.GRS
						tag = SepareteGroupsCON_FUN.GRS_TAG;
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
			%  CATEGORY = SE.GETPROPCATEGORY(POINTER) returns category of POINTER of SE.
			%  CATEGORY = Element.GETPROPCATEGORY(SepareteGroupsCON_FUN, POINTER) returns category of POINTER of SepareteGroupsCON_FUN.
			%  CATEGORY = SE.GETPROPCATEGORY(SepareteGroupsCON_FUN, POINTER) returns category of POINTER of SepareteGroupsCON_FUN.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					prop_category = SepareteGroupsCON_FUN.ID_CATEGORY;
				case SepareteGroupsCON_FUN.LABEL
					prop_category = SepareteGroupsCON_FUN.LABEL_CATEGORY;
				case SepareteGroupsCON_FUN.NOTES
					prop_category = SepareteGroupsCON_FUN.NOTES_CATEGORY;
				case SepareteGroupsCON_FUN.WAITBAR
					prop_category = SepareteGroupsCON_FUN.WAITBAR_CATEGORY;
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					prop_category = SepareteGroupsCON_FUN.GR_CON_FUN_MP_CATEGORY;
				case SepareteGroupsCON_FUN.GRS
					prop_category = SepareteGroupsCON_FUN.GRS_CATEGORY;
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
			%  FORMAT = SE.GETPROPFORMAT(POINTER) returns format of POINTER of SE.
			%  FORMAT = Element.GETPROPFORMAT(SepareteGroupsCON_FUN, POINTER) returns format of POINTER of SepareteGroupsCON_FUN.
			%  FORMAT = SE.GETPROPFORMAT(SepareteGroupsCON_FUN, POINTER) returns format of POINTER of SepareteGroupsCON_FUN.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					prop_format = SepareteGroupsCON_FUN.ID_FORMAT;
				case SepareteGroupsCON_FUN.LABEL
					prop_format = SepareteGroupsCON_FUN.LABEL_FORMAT;
				case SepareteGroupsCON_FUN.NOTES
					prop_format = SepareteGroupsCON_FUN.NOTES_FORMAT;
				case SepareteGroupsCON_FUN.WAITBAR
					prop_format = SepareteGroupsCON_FUN.WAITBAR_FORMAT;
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					prop_format = SepareteGroupsCON_FUN.GR_CON_FUN_MP_FORMAT;
				case SepareteGroupsCON_FUN.GRS
					prop_format = SepareteGroupsCON_FUN.GRS_FORMAT;
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
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SepareteGroupsCON_FUN, POINTER) returns description of POINTER of SepareteGroupsCON_FUN.
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(SepareteGroupsCON_FUN, POINTER) returns description of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					prop_description = 'ID (data, string) is a few-letter code for the group combiner.';
				case SepareteGroupsCON_FUN.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group combiner.';
				case SepareteGroupsCON_FUN.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group combiner.';
				case SepareteGroupsCON_FUN.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) determines whether to show the waitbar.';
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					prop_description = 'GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data';
				case SepareteGroupsCON_FUN.GRS
					prop_description = 'GRS (result, cell) is a idict containing two group of subjects with connectivity data and functional data.';
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
			%  SETTINGS = SE.GETPROPSETTINGS(POINTER) returns settings of POINTER of SE.
			%  SETTINGS = Element.GETPROPSETTINGS(SepareteGroupsCON_FUN, POINTER) returns settings of POINTER of SepareteGroupsCON_FUN.
			%  SETTINGS = SE.GETPROPSETTINGS(SepareteGroupsCON_FUN, POINTER) returns settings of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case SepareteGroupsCON_FUN.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case SepareteGroupsCON_FUN.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case SepareteGroupsCON_FUN.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case SepareteGroupsCON_FUN.GRS
					prop_settings = Format.getFormatSettings(Format.CELL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SepareteGroupsCON_FUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SepareteGroupsCON_FUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULT(SepareteGroupsCON_FUN, POINTER) returns the default value of POINTER of SepareteGroupsCON_FUN.
			%  DEFAULT = SE.GETPROPDEFAULT(SepareteGroupsCON_FUN, POINTER) returns the default value of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					prop_default = Format.getFormatDefault(Format.STRING, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP');
				case SepareteGroupsCON_FUN.GRS
					prop_default = Format.getFormatDefault(Format.CELL, SepareteGroupsCON_FUN.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SepareteGroupsCON_FUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SepareteGroupsCON_FUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SepareteGroupsCON_FUN, POINTER) returns the conditioned default value of POINTER of SepareteGroupsCON_FUN.
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(SepareteGroupsCON_FUN, POINTER) returns the conditioned default value of POINTER of SepareteGroupsCON_FUN.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			prop_default = SepareteGroupsCON_FUN.conditioning(prop, SepareteGroupsCON_FUN.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SE.
			%  CHECK = Element.CHECKPROP(SepareteGroupsCON_FUN, PROP, VALUE) checks VALUE format for PROP of SepareteGroupsCON_FUN.
			%  CHECK = SE.CHECKPROP(SepareteGroupsCON_FUN, PROP, VALUE) checks VALUE format for PROP of SepareteGroupsCON_FUN.
			% 
			% SE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SE.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  Element.CHECKPROP(SepareteGroupsCON_FUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SepareteGroupsCON_FUN.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			%  SE.CHECKPROP(SepareteGroupsCON_FUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SepareteGroupsCON_FUN.
			%   Error id: [BRAPH2:SepareteGroupsCON_FUN:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				case SepareteGroupsCON_FUN.ID
					check = Format.checkFormat(Format.STRING, value, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.LABEL
					check = Format.checkFormat(Format.STRING, value, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.NOTES
					check = Format.checkFormat(Format.STRING, value, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.GR_CON_FUN_MP
					check = Format.checkFormat(Format.ITEM, value, SepareteGroupsCON_FUN.getPropSettings(prop));
				case SepareteGroupsCON_FUN.GRS
					check = Format.checkFormat(Format.CELL, value, SepareteGroupsCON_FUN.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SepareteGroupsCON_FUN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SepareteGroupsCON_FUN.getPropTag(prop) ' (' SepareteGroupsCON_FUN.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function se = SepareteGroupsCON_FUN(varargin)
			% SepareteGroupsCON_FUN() creates a separetes the CON subject group and the FUN subject group from a CON_FUN group.
			%
			% SepareteGroupsCON_FUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SepareteGroupsCON_FUN(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SepareteGroupsCON_FUN properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the group combiner.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the group combiner.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the group combiner.
			%  <strong>4</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar.
			%  <strong>5</strong> <strong>gr_con_fun_mp</strong> 	GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data
			%  <strong>6</strong> <strong>grs</strong> 	GRS (result, cell) is a idict containing two group of subjects with connectivity data and functional data.
			%
			% See also Category, Format, set, check.
			
			se = se@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = SepareteGroupsCON_FUN.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(se, prop)
		
			switch prop
				case SepareteGroupsCON_FUN.GRS
					rng(se.getPropSeed(SepareteGroupsCON_FUN.GRS), 'twister')
					
					if se.get('WAITBAR')
					    wb = waitbar(0, 'Separating subject groups ...', 'Name', BRAPH2.NAME);
					    set_braph2icon(wb)
					end
					
					gr = se.get('GR_CON_FUN_MP');
					gr_subdict = gr.get('SUB_DICT');
					if ~isa(gr_subdict, 'NoValue') && gr_subdict.length() > 0
					    ba = gr.get('SUB_DICT').getItem(1).get('BA');
					    
					    % declare variables
					    gr_con = Group( ...
					        'SUB_CLASS', 'SubjectCON', ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
					        );
					    subdict_con = gr_con.get('SUB_DICT');
					    gr_fun = Group( ...
					        'SUB_CLASS', 'SubjectFUN', ...
					        'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
					        );
					    subdict_fun = gr_fun.get('SUB_DICT');
					    
					    % cycle for data and creation of different groups
					    for i = 1:1:gr_subdict.length()
					        if se.get('WAITBAR')
					            waitbar(.30 + .70 * i / gr_subdict.length(), wb, ['Separating subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length()) ' ...'])
					        end
					        sub = gr_subdict.getItem(i);
					        sub_data = sub.get('CON_FUN_MP'); 
					        sub_con = SubjectCON( ...
					            'ID', sub.get('ID'), ...
					            'BA', ba, ...
					            'age', sub.get('AGE'), ...
					            'sex', sub.get('SEX'), ...
					            'CON', sub_data{1} ...
					            );
					        sub_fun = SubjectFUN( ...
					            'ID', sub.get('ID'), ...
					            'BA', ba, ...
					            'age', sub.get('AGE'), ...
					            'sex', sub.get('SEX'), ...
					            'FUN', sub_data{2} ...
					            );
					        subdict_con.add(sub_con);
					        subdict_fun.add(sub_fun);
					    end
					    
					    gr_con.set('sub_dict', subdict_con);
					    gr_fun.set('sub_dict', subdict_fun);
					    
					    % declare result variable and set it with result
					    grs = cell(2, 1);
					    grs{1} = gr_con;
					    grs{2} = gr_fun;
					else
					    grs = {};
					end
					
					
					if se.get('WAITBAR')
					    close(wb)
					end
					
					value = grs;
					
				otherwise
					value = calculateValue@Element(se, prop);
					
			end
		end
	end
end
