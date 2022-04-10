classdef PPSubjectFUN_MP_FUN_MP < PPSubjectFUN_FUN
	% PPSubjectFUN_MP_FUN_MP represents the functional multiplex data of a subject.
	% It is a subclass of <a href="matlab:help PPSubjectFUN_FUN">PPSubjectFUN_FUN</a>.
	%
	% PPSubjectFUN_MP_FUN_MP represents the functional multiplex data of a subject.
	%
	% The list of PPSubjectFUN_MP_FUN_MP properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPSubjectFUN_MP_FUN_MP methods (constructor):
	% PPSubjectFUN_MP_FUN_MP - constructor
	%
	% PPSubjectFUN_MP_FUN_MP methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot subject functional multiplex data/error.
	%  existsProp - checks whether property exists in plot subject functional multiplex data/error.
	%  getPropNumber - returns the property number of plot subject functional multiplex data.
	%  getProps - returns the property list of plot subject functional multiplex data.
	%  getDescription - returns the description of the plot subject functional multiplex data.
	%  getName - returns the name of the plot subject functional multiplex data.
	%  getClass - returns the class of the plot subject functional multiplex data.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPSubjectFUN_MP_FUN_MP methods:
	%  cb_matrix_value - executes callback for the matrix table.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws a table with the functional multiplex data of a subject.
	%  cb_button_del - P_FUN_MP/cb_button_del is a function.
	%  cb_button_calc - _FUN_MP/cb_button_calc is a function.
	%  cb_button_cb - MP_FUN_MP/cb_button_cb is a function.
	%  set_settings - MP_FUN_MP/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - _MP_FUN_MP/cb_close_fs is a function.
	%  settings - opens the settings figure.
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
	% PPSubjectFUN_MP_FUN_MP methods (operators):
	%  isequal - determines whether two PPSubjectFUN_MP_FUN_MP are equal (values, locked)
	%
	% PPSubjectFUN_MP_FUN_MP methods (display):
	%  tostring - string with information about the PPSubjectFUN_MP_FUN_MP
	%  disp - displays information about the PPSubjectFUN_MP_FUN_MP
	%  tree - displays the element of PPSubjectFUN_MP_FUN_MP
	%
	% PPSubjectFUN_MP_FUN_MP method (element list):
	%  getElementList - returns a list with all subelements of PPSubjectFUN_MP_FUN_MP
	%
	% PPSubjectFUN_MP_FUN_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPSubjectFUN_MP_FUN_MP
	%
	% PPSubjectFUN_MP_FUN_MP method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPSubjectFUN_MP_FUN_MP
	%
	% PPSubjectFUN_MP_FUN_MP methods (copy):
	%  copy - copies the PPSubjectFUN_MP_FUN_MP
	%  deepclone - deep-clones the PPSubjectFUN_MP_FUN_MP
	%  clone - clones the PPSubjectFUN_MP_FUN_MP
	%
	% PPSubjectFUN_MP_FUN_MP methods (inspection, Static):
	%  getClass - returns PPSubjectFUN_MP_FUN_MP
	%  getName - returns the name of PPSubjectFUN_MP_FUN_MP
	%  getDescription - returns the description of PPSubjectFUN_MP_FUN_MP
	%  getProps - returns the property list of PPSubjectFUN_MP_FUN_MP
	%  getPropNumber - returns the property number of PPSubjectFUN_MP_FUN_MP
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
	% PPSubjectFUN_MP_FUN_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPSubjectFUN_MP_FUN_MP methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPSubjectFUN_MP_FUN_MP methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPSubjectFUN_MP_FUN_MP methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPSubjectFUN_MP_FUN_MP properties (Constant).
	%  EL - 3
	%  EL_TAG - 'el'
	%  EL_CATEGORY - 'm'
	%  EL_FORMAT - 'it'
	%  PROP - 4
	%  PROP_TAG - 'prop'
	%  PROP_CATEGORY - 'd'
	%  PROP_FORMAT - 'nn'
	%  TITLE - 5
	%  TITLE_TAG - 'title'
	%  TITLE_CATEGORY - 'm'
	%  TITLE_FORMAT - 'st'
	%  ENABLE - 6
	%  ENABLE_TAG - 'enable'
	%  ENABLE_CATEGORY - 'm'
	%  ENABLE_FORMAT - 'op'
	%  WAITBAR - 7
	%  WAITBAR_TAG - 'waitbar'
	%  WAITBAR_CATEGORY - 'm'
	%  WAITBAR_FORMAT - 'lo'
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  BKGCOLOR - 2
	%  BKGCOLOR_TAG - 'bkgcolor'
	%  BKGCOLOR_CATEGORY - 'm'
	%  BKGCOLOR_FORMAT - 'nr'
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
	% See also GUI, PlotElement, PlotPropMatrix, Subject, SubjectFUNMP..
	
	properties (Access = private) % element properties
		p
		table_value
		table_text
		slider
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot subject functional multiplex data.
			%
			% CLASS = PPSubjectFUN_MP_FUN_MP.GETCLASS() returns the class 'PPSubjectFUN_MP_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot subject functional multiplex data PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPSubjectFUN_MP_FUN_MP') returns 'PPSubjectFUN_MP_FUN_MP'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPSubjectFUN_MP_FUN_MP';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot subject functional multiplex data.
			%
			% NAME = PPSubjectFUN_MP_FUN_MP.GETNAME() returns the name of the 'plot subject functional multiplex data'.
			%  Plot Subject Functional Multiplex Data.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot subject functional multiplex data PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPSubjectFUN_MP_FUN_MP') returns the name of 'PPSubjectFUN_MP_FUN_MP'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Subject Functional Multiplex Data';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot subject functional multiplex data.
			%
			% STR = PPSubjectFUN_MP_FUN_MP.GETDESCRIPTION() returns the description of the 'plot subject functional multiplex data'.
			%  which is:
			%
			%  PPSubjectFUN_MP_FUN_MP represents the functional multiplex data of a subject.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot subject functional multiplex data PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPSubjectFUN_MP_FUN_MP') returns the description of 'PPSubjectFUN_MP_FUN_MP'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPSubjectFUN_MP_FUN_MP represents the functional multiplex data of a subject.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot subject functional multiplex data.
			%
			% PROPS = PPSubjectFUN_MP_FUN_MP.GETPROPS() returns the property list of plot subject functional multiplex data.
			%
			% PROPS = PPSubjectFUN_MP_FUN_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot subject functional multiplex data PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPSubjectFUN_MP_FUN_MP'[, CATEGORY]) returns the property list of 'PPSubjectFUN_MP_FUN_MP'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PPSubjectFUN_FUN.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PPSubjectFUN_FUN.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot subject functional multiplex data.
			%
			% N = PPSubjectFUN_MP_FUN_MP.GETPROPNUMBER() returns the property number of plot subject functional multiplex data.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot subject functional multiplex data PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPSubjectFUN_MP_FUN_MP') returns the property number of 'PPSubjectFUN_MP_FUN_MP'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot subject functional multiplex data/error.
			%
			% CHECK = PPSubjectFUN_MP_FUN_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPSubjectFUN_MP_FUN_MP, PROP) checks whether PROP exists for PPSubjectFUN_MP_FUN_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(PPSubjectFUN_MP_FUN_MP, PROP) throws error if PROP does NOT exist for PPSubjectFUN_MP_FUN_MP.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPSubjectFUN_MP_FUN_MP.existsProp(prop), ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPSubjectFUN_MP_FUN_MP.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot subject functional multiplex data/error.
			%
			% CHECK = PPSubjectFUN_MP_FUN_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPSubjectFUN_MP_FUN_MP, TAG) checks whether TAG exists for PPSubjectFUN_MP_FUN_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(PPSubjectFUN_MP_FUN_MP, TAG) throws error if TAG does NOT exist for PPSubjectFUN_MP_FUN_MP.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectfun_mp_fun_mp_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppsubjectfun_mp_fun_mp_tag_list));
			else
				assert( ...
					PPSubjectFUN_MP_FUN_MP.existsTag(tag), ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPSubjectFUN_MP_FUN_MP'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(PPSubjectFUN_MP_FUN_MP, POINTER) returns property number of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  PROPERTY = PR.GETPROPPROP(PPSubjectFUN_MP_FUN_MP, POINTER) returns property number of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectfun_mp_fun_mp_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPSubjectFUN_MP_FUN_MP.existsTag(tag);
				
				prop = find(strcmpi(tag, ppsubjectfun_mp_fun_mp_tag_list));
			else % numeric
				prop = pointer;
				PPSubjectFUN_MP_FUN_MP.existsProp(prop);
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(PPSubjectFUN_MP_FUN_MP, POINTER) returns tag of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  TAG = PR.GETPROPTAG(PPSubjectFUN_MP_FUN_MP, POINTER) returns tag of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPSubjectFUN_MP_FUN_MP.existsTag(tag);
			else % numeric
				prop = pointer;
				PPSubjectFUN_MP_FUN_MP.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PPSubjectFUN_FUN(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(PPSubjectFUN_MP_FUN_MP, POINTER) returns category of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  CATEGORY = PR.GETPROPCATEGORY(PPSubjectFUN_MP_FUN_MP, POINTER) returns category of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PPSubjectFUN_FUN(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(PPSubjectFUN_MP_FUN_MP, POINTER) returns format of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  FORMAT = PR.GETPROPFORMAT(PPSubjectFUN_MP_FUN_MP, POINTER) returns format of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PPSubjectFUN_FUN(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPSubjectFUN_MP_FUN_MP, POINTER) returns description of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPSubjectFUN_MP_FUN_MP, POINTER) returns description of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PPSubjectFUN_FUN(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(PPSubjectFUN_MP_FUN_MP, POINTER) returns settings of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  SETTINGS = PR.GETPROPSETTINGS(PPSubjectFUN_MP_FUN_MP, POINTER) returns settings of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PPSubjectFUN_FUN(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPSubjectFUN_MP_FUN_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectFUN_MP_FUN_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPSubjectFUN_MP_FUN_MP, POINTER) returns the default value of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  DEFAULT = PR.GETPROPDEFAULT(PPSubjectFUN_MP_FUN_MP, POINTER) returns the default value of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PPSubjectFUN_FUN(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPSubjectFUN_MP_FUN_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectFUN_MP_FUN_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPSubjectFUN_MP_FUN_MP, POINTER) returns the conditioned default value of POINTER of PPSubjectFUN_MP_FUN_MP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPSubjectFUN_MP_FUN_MP, POINTER) returns the conditioned default value of POINTER of PPSubjectFUN_MP_FUN_MP.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			prop_default = PPSubjectFUN_MP_FUN_MP.conditioning(prop, PPSubjectFUN_MP_FUN_MP.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(PPSubjectFUN_MP_FUN_MP, PROP, VALUE) checks VALUE format for PROP of PPSubjectFUN_MP_FUN_MP.
			%  CHECK = PR.CHECKPROP(PPSubjectFUN_MP_FUN_MP, PROP, VALUE) checks VALUE format for PROP of PPSubjectFUN_MP_FUN_MP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  Element.CHECKPROP(PPSubjectFUN_MP_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectFUN_MP_FUN_MP.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			%  PR.CHECKPROP(PPSubjectFUN_MP_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectFUN_MP_FUN_MP.
			%   Error id: [BRAPH2:PPSubjectFUN_MP_FUN_MP:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PPSubjectFUN_FUN(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectFUN_MP_FUN_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPSubjectFUN_MP_FUN_MP.getPropTag(prop) ' (' PPSubjectFUN_MP_FUN_MP.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPSubjectFUN_MP_FUN_MP(varargin)
			% PPSubjectFUN_MP_FUN_MP() creates a plot subject functional multiplex data.
			%
			% PPSubjectFUN_MP_FUN_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPSubjectFUN_MP_FUN_MP(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPSubjectFUN_MP_FUN_MP properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PPSubjectFUN_FUN(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPSubjectFUN_MP_FUN_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PPSubjectFUN_FUN.getPropNumber()
						value = conditioning@PPSubjectFUN_FUN(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws a table with the functional multiplex data of a subject.
		    %
		    % DRAW(PR) draws the property panel, a slider to navigate the values
		    %  a table with the functional multiplex data of a subject.
		    %
		    % H = DRAW(PR) returns a handle to the property panel.
		    %
		    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel
		    %  with custom Name-Value pairs.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle H of the panel.
		    %
		    % See also update, redraw, settings, uipanel.
		
		    pr.p = draw@PPSubjectFUN_FUN(pr, varargin{:});
		
		    % retrieves the handle of the table
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uitable')
		            pr.table_value = children(i);
		        end
		    end
		
		    % create panel with slider
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.get(prop);
		    L = length(value);
		
		    % set on first layer
		    pr.slider = uicontrol( ...
		        'Parent', pr.p, ...
		        'Style', 'slider', ...
		        'Units', 'characters', ...
		        'Value', 1, ...
		        'Min', 1, ...
		        'Max', L, ...
		        'SliderStep', [1 1], ...
		        'Callback', {@cb_slider} ...
		        );
		    
		    function cb_slider(~, ~)
		        pr.update()
		    end
		
		    pr.table_text = uicontrol(...
		        'Parent', pr.p, ...
		        'Style', 'text', ...
		        'Units', 'characters', ...
		        'HorizontalAlignment', 'left', ...
		        'FontUnits', BRAPH2.FONTUNITS, ...
		        'FontSize', BRAPH2.FONTSIZE, ...
		        'String', '1', ...
		        'BackgroundColor', pr.get('BKGCOLOR') ...
		        );
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content of the property panel and its graphical objects.
		    %
		    % UPDATE(PR) updates the content of the property panel and its graphical objects.
		    %
		    % See also draw, redraw, PlotElement.
		
		    update@PlotProp(pr)
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.get(prop);
		    
		    if el.isLocked(prop)
		        set(pr.table_value, ...
		            'Enable', pr.get('ENABLE'), ...
		            'ColumnEditable', false ...
		            )
		    end
		    
		    set(pr.table_text, ...
		        'String', num2str(round(get(pr.slider, 'Value'))));
		
		    set(pr.table_value, ...
		        'Data', value{round(get(pr.slider, 'Value'))}', ...
		        'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
		        'ColumnEditable', true)
		
		    value = el.getr(prop);
		    if isa(value, 'Callback')
		        set(pr.table_value, ...
		            'Enable', pr.get('ENABLE'), ...
		            'ColumnEditable', false ...
		            )
		    end
		
		end
		function redraw(pr, varargin)
		    %REDRAW resizes the property panel and repositions its graphical objects.
		    %
		    % REDRAW(PR) resizes the property panel and repositions its
		    %   graphical objects (slider, slider value tag and table).
		    %
		    % Important notes:
		    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects.
		    % 2. REDRAW() is typically called internally by PlotElement and does not need
		    %  to be expricitly called in children of PlotProp.
		    %
		    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
		    %  repositions the property panel. It is possible to use a
		    %  subset of the Name-Value pairs.
		    %  By default:
		    %  - X0 does not change
		    %  - Y0 does not change
		    %  - WIDTH does not change    
		    %  - HEIGHT=1.8 characters.
		    %  - SHEIGHT=2.0 characters (slider height).
		    %  - THEIGHT=2.0 characters (tag height).
		    %  - DHEIGHT=20 characters (table height).
		    %
		    % See also draw, update, PlotElement.
		
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
		    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
		    
		    pr.redraw@PlotProp('Height', h + Sh + Th + Dh, varargin{:})
		    
		    set(pr.slider, ...
		        'Units', 'normalized', ...
		        'Position', [.01 (Th+Dh)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		        );
		    
		    set(pr.table_text, ...
		        'Units', 'normalized', ...
		        'Position', [.01 Dh/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		        );
		    
		    set(pr.table_value, ...
		        'Units', 'normalized', ...
		        'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.02)] ...
		        )
		end
		function cb_matrix_value(pr, i, j, newdata)
		    %CB_MATRIX_VALUE executes callback for the matrix table.
		    %
		    % CB_MATRIX_VALUE(PR, I, J, NEWDATA) executes callback for the matrix table.
		    %  It updates the matrix at position (I,J) with NEWDATA 
		    %  for the layer that is currently selected by the slider. 
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    value = el.get(prop);
		    value{get(pr.slider, 'Value')}(i, j) = newdata;
		    el.set(prop, value)
		
		    pr.update()
		end
	end
end
