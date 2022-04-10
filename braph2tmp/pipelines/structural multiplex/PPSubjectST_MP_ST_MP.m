classdef PPSubjectST_MP_ST_MP < PPSubjectST_ST
	% PPSubjectST_MP_ST_MP represents the structural multiplex data of a subject.
	% It is a subclass of <a href="matlab:help PPSubjectST_ST">PPSubjectST_ST</a>.
	%
	% PPSubjectST_MP_ST_MP represents the structural multiplex data of a subject.
	% It visualized a table showing the content of a layer, which can be selected by a slider.
	%
	% The list of PPSubjectST_MP_ST_MP properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPSubjectST_MP_ST_MP methods (constructor):
	% PPSubjectST_MP_ST_MP - constructor
	%
	% PPSubjectST_MP_ST_MP methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot subject structural multiplex data/error.
	%  existsProp - checks whether property exists in plot subject structural multiplex data/error.
	%  getPropNumber - returns the property number of plot subject structural multiplex data.
	%  getProps - returns the property list of plot subject structural multiplex data.
	%  getDescription - returns the description of the plot subject structural multiplex data.
	%  getName - returns the name of the plot subject structural multiplex data.
	%  getClass - returns the class of the plot subject structural multiplex data.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPSubjectST_MP_ST_MP methods:
	%  cb_matrix_value - executes callback for the matrix table.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws a table with the structural multiplex data of a subject.
	%  cb_button_del - _ST_MP/cb_button_del is a function.
	%  cb_button_calc - ST_MP/cb_button_calc is a function.
	%  cb_button_cb - P_ST_MP/cb_button_cb is a function.
	%  set_settings - P_ST_MP/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - MP_ST_MP/cb_close_fs is a function.
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
	% PPSubjectST_MP_ST_MP methods (operators):
	%  isequal - determines whether two PPSubjectST_MP_ST_MP are equal (values, locked)
	%
	% PPSubjectST_MP_ST_MP methods (display):
	%  tostring - string with information about the PPSubjectST_MP_ST_MP
	%  disp - displays information about the PPSubjectST_MP_ST_MP
	%  tree - displays the element of PPSubjectST_MP_ST_MP
	%
	% PPSubjectST_MP_ST_MP method (element list):
	%  getElementList - returns a list with all subelements of PPSubjectST_MP_ST_MP
	%
	% PPSubjectST_MP_ST_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPSubjectST_MP_ST_MP
	%
	% PPSubjectST_MP_ST_MP method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPSubjectST_MP_ST_MP
	%
	% PPSubjectST_MP_ST_MP methods (copy):
	%  copy - copies the PPSubjectST_MP_ST_MP
	%  deepclone - deep-clones the PPSubjectST_MP_ST_MP
	%  clone - clones the PPSubjectST_MP_ST_MP
	%
	% PPSubjectST_MP_ST_MP methods (inspection, Static):
	%  getClass - returns PPSubjectST_MP_ST_MP
	%  getName - returns the name of PPSubjectST_MP_ST_MP
	%  getDescription - returns the description of PPSubjectST_MP_ST_MP
	%  getProps - returns the property list of PPSubjectST_MP_ST_MP
	%  getPropNumber - returns the property number of PPSubjectST_MP_ST_MP
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
	% PPSubjectST_MP_ST_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPSubjectST_MP_ST_MP methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPSubjectST_MP_ST_MP methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPSubjectST_MP_ST_MP methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPSubjectST_MP_ST_MP properties (Constant).
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
	% See also GUI, PlotElement, PlotPropMatrix, Subject, SubjectSTMP..
	
	properties (Access = private) % element properties
		p
		table_value
		table_text
		slider
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot subject structural multiplex data.
			%
			% CLASS = PPSubjectST_MP_ST_MP.GETCLASS() returns the class 'PPSubjectST_MP_ST_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot subject structural multiplex data PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPSubjectST_MP_ST_MP') returns 'PPSubjectST_MP_ST_MP'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPSubjectST_MP_ST_MP';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot subject structural multiplex data.
			%
			% NAME = PPSubjectST_MP_ST_MP.GETNAME() returns the name of the 'plot subject structural multiplex data'.
			%  Plot Subject Structural Multiplex Data.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot subject structural multiplex data PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPSubjectST_MP_ST_MP') returns the name of 'PPSubjectST_MP_ST_MP'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Subject Structural Multiplex Data';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot subject structural multiplex data.
			%
			% STR = PPSubjectST_MP_ST_MP.GETDESCRIPTION() returns the description of the 'plot subject structural multiplex data'.
			%  which is:
			%
			%  PPSubjectST_MP_ST_MP represents the structural multiplex data of a subject.
			%  It visualized a table showing the content of a layer, which can be selected by a slider.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot subject structural multiplex data PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPSubjectST_MP_ST_MP') returns the description of 'PPSubjectST_MP_ST_MP'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPSubjectST_MP_ST_MP represents the structural multiplex data of a subject.' ...
				'It visualized a table showing the content of a layer, which can be selected by a slider.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot subject structural multiplex data.
			%
			% PROPS = PPSubjectST_MP_ST_MP.GETPROPS() returns the property list of plot subject structural multiplex data.
			%
			% PROPS = PPSubjectST_MP_ST_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot subject structural multiplex data PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPSubjectST_MP_ST_MP'[, CATEGORY]) returns the property list of 'PPSubjectST_MP_ST_MP'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PPSubjectST_ST.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PPSubjectST_ST.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PPSubjectST_ST.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PPSubjectST_ST.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PPSubjectST_ST.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PPSubjectST_ST.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PPSubjectST_ST.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot subject structural multiplex data.
			%
			% N = PPSubjectST_MP_ST_MP.GETPROPNUMBER() returns the property number of plot subject structural multiplex data.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot subject structural multiplex data PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPSubjectST_MP_ST_MP') returns the property number of 'PPSubjectST_MP_ST_MP'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot subject structural multiplex data/error.
			%
			% CHECK = PPSubjectST_MP_ST_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPSubjectST_MP_ST_MP, PROP) checks whether PROP exists for PPSubjectST_MP_ST_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  Element.EXISTSPROP(PPSubjectST_MP_ST_MP, PROP) throws error if PROP does NOT exist for PPSubjectST_MP_ST_MP.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPSubjectST_MP_ST_MP.existsProp(prop), ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPSubjectST_MP_ST_MP.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot subject structural multiplex data/error.
			%
			% CHECK = PPSubjectST_MP_ST_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPSubjectST_MP_ST_MP, TAG) checks whether TAG exists for PPSubjectST_MP_ST_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  Element.EXISTSTAG(PPSubjectST_MP_ST_MP, TAG) throws error if TAG does NOT exist for PPSubjectST_MP_ST_MP.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectst_mp_st_mp_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppsubjectst_mp_st_mp_tag_list));
			else
				assert( ...
					PPSubjectST_MP_ST_MP.existsTag(tag), ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPSubjectST_MP_ST_MP'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPSubjectST_MP_ST_MP, POINTER) returns property number of POINTER of PPSubjectST_MP_ST_MP.
			%  PROPERTY = PR.GETPROPPROP(PPSubjectST_MP_ST_MP, POINTER) returns property number of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectst_mp_st_mp_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPSubjectST_MP_ST_MP.existsTag(tag);
				
				prop = find(strcmpi(tag, ppsubjectst_mp_st_mp_tag_list));
			else % numeric
				prop = pointer;
				PPSubjectST_MP_ST_MP.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPSubjectST_MP_ST_MP, POINTER) returns tag of POINTER of PPSubjectST_MP_ST_MP.
			%  TAG = PR.GETPROPTAG(PPSubjectST_MP_ST_MP, POINTER) returns tag of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPSubjectST_MP_ST_MP.existsTag(tag);
			else % numeric
				prop = pointer;
				PPSubjectST_MP_ST_MP.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PPSubjectST_ST(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPSubjectST_MP_ST_MP, POINTER) returns category of POINTER of PPSubjectST_MP_ST_MP.
			%  CATEGORY = PR.GETPROPCATEGORY(PPSubjectST_MP_ST_MP, POINTER) returns category of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PPSubjectST_ST(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPSubjectST_MP_ST_MP, POINTER) returns format of POINTER of PPSubjectST_MP_ST_MP.
			%  FORMAT = PR.GETPROPFORMAT(PPSubjectST_MP_ST_MP, POINTER) returns format of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PPSubjectST_ST(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPSubjectST_MP_ST_MP, POINTER) returns description of POINTER of PPSubjectST_MP_ST_MP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPSubjectST_MP_ST_MP, POINTER) returns description of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PPSubjectST_ST(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPSubjectST_MP_ST_MP, POINTER) returns settings of POINTER of PPSubjectST_MP_ST_MP.
			%  SETTINGS = PR.GETPROPSETTINGS(PPSubjectST_MP_ST_MP, POINTER) returns settings of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PPSubjectST_ST(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPSubjectST_MP_ST_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectST_MP_ST_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPSubjectST_MP_ST_MP, POINTER) returns the default value of POINTER of PPSubjectST_MP_ST_MP.
			%  DEFAULT = PR.GETPROPDEFAULT(PPSubjectST_MP_ST_MP, POINTER) returns the default value of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PPSubjectST_ST(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPSubjectST_MP_ST_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectST_MP_ST_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPSubjectST_MP_ST_MP, POINTER) returns the conditioned default value of POINTER of PPSubjectST_MP_ST_MP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPSubjectST_MP_ST_MP, POINTER) returns the conditioned default value of POINTER of PPSubjectST_MP_ST_MP.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			prop_default = PPSubjectST_MP_ST_MP.conditioning(prop, PPSubjectST_MP_ST_MP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPSubjectST_MP_ST_MP, PROP, VALUE) checks VALUE format for PROP of PPSubjectST_MP_ST_MP.
			%  CHECK = PR.CHECKPROP(PPSubjectST_MP_ST_MP, PROP, VALUE) checks VALUE format for PROP of PPSubjectST_MP_ST_MP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  Element.CHECKPROP(PPSubjectST_MP_ST_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectST_MP_ST_MP.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			%  PR.CHECKPROP(PPSubjectST_MP_ST_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectST_MP_ST_MP.
			%   Error id: [BRAPH2:PPSubjectST_MP_ST_MP:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PPSubjectST_ST(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectST_MP_ST_MP:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPSubjectST_MP_ST_MP.getPropTag(prop) ' (' PPSubjectST_MP_ST_MP.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPSubjectST_MP_ST_MP(varargin)
			% PPSubjectST_MP_ST_MP() creates a plot subject structural multiplex data.
			%
			% PPSubjectST_MP_ST_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPSubjectST_MP_ST_MP(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPSubjectST_MP_ST_MP properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PPSubjectST_ST(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPSubjectST_MP_ST_MP.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PPSubjectST_ST.getPropNumber()
						value = conditioning@PPSubjectST_ST(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws a table with the structural multiplex data of a subject.
		    %
		    % DRAW(PR) draws the property panel, a slider to navigate the values
		    %  a table with the structural multiplex data of a subject.
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
		
		    pr.p = draw@PPSubjectST_ST(pr, varargin{:});
		
		    % retrieves the handle of the table
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uitable')
		            pr.table_value = children(i);
		        end
		    end
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.get(prop);
		    L = length(value); % number of layers
		
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
		    
		    pr.table_text = uicontrol( ...
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
		        'Data', value{round(get(pr.slider, 'Value'))}, ...
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
		    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT, 'DHeight', DHEIGHT)
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
