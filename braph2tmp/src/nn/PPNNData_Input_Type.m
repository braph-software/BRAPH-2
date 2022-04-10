classdef PPNNData_Input_Type < PlotPropOption
	% PPNNData_Input_Type is a for yuwei.
	% It is a subclass of <a href="matlab:help PlotPropOption">PlotPropOption</a>.
	%
	% PPNNData_Input_Type represents Yuwei.
	%
	% The list of PPNNData_Input_Type properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPNNData_Input_Type methods (constructor):
	% PPNNData_Input_Type - constructor
	%
	% PPNNData_Input_Type methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property graph/error.
	%  existsProp - checks whether property exists in plot property graph/error.
	%  getPropNumber - returns the property number of plot property graph.
	%  getProps - returns the property list of plot property graph.
	%  getDescription - returns the description of the plot property graph.
	%  getName - returns the name of the plot property graph.
	%  getClass - returns the class of the plot property graph.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPNNData_Input_Type methods:
	%  lock_measures_prop - /lock_measures_prop is a function.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the panel of the graph property and the measure table.
	%  cb_popupmenu_value - /cb_popupmenu_value is a function.
	%  cb_button_del - _Type/cb_button_del is a function.
	%  cb_button_calc - Type/cb_button_calc is a function.
	%  cb_button_cb - t_Type/cb_button_cb is a function.
	%  set_settings - t_Type/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - ut_Type/cb_close_fs is a function.
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
	% PPNNData_Input_Type methods (operators):
	%  isequal - determines whether two PPNNData_Input_Type are equal (values, locked)
	%
	% PPNNData_Input_Type methods (display):
	%  tostring - string with information about the PPNNData_Input_Type
	%  disp - displays information about the PPNNData_Input_Type
	%  tree - displays the element of PPNNData_Input_Type
	%
	% PPNNData_Input_Type method (element list):
	%  getElementList - returns a list with all subelements of PPNNData_Input_Type
	%
	% PPNNData_Input_Type method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPNNData_Input_Type
	%
	% PPNNData_Input_Type method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPNNData_Input_Type
	%
	% PPNNData_Input_Type methods (copy):
	%  copy - copies the PPNNData_Input_Type
	%  deepclone - deep-clones the PPNNData_Input_Type
	%  clone - clones the PPNNData_Input_Type
	%
	% PPNNData_Input_Type methods (inspection, Static):
	%  getClass - returns PPNNData_Input_Type
	%  getName - returns the name of PPNNData_Input_Type
	%  getDescription - returns the description of PPNNData_Input_Type
	%  getProps - returns the property list of PPNNData_Input_Type
	%  getPropNumber - returns the property number of PPNNData_Input_Type
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
	% PPNNData_Input_Type methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPNNData_Input_Type methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPNNData_Input_Type methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPNNData_Input_Type methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPNNData_Input_Type properties (Constant).
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
	% See also GUI, PlotElement, PlotProp.
	
	properties (Access = private) % element properties
		p
		list_tbl
		selected
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property graph.
			%
			% CLASS = PPNNData_Input_Type.GETCLASS() returns the class 'PPNNData_Input_Type'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPNNData_Input_Type') returns 'PPNNData_Input_Type'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPNNData_Input_Type';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property graph.
			%
			% NAME = PPNNData_Input_Type.GETNAME() returns the name of the 'plot property graph'.
			%  Plot Property Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPNNData_Input_Type') returns the name of 'PPNNData_Input_Type'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property graph.
			%
			% STR = PPNNData_Input_Type.GETDESCRIPTION() returns the description of the 'plot property graph'.
			%  which is:
			%
			%  PPNNData_Input_Type represents Yuwei.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPNNData_Input_Type') returns the description of 'PPNNData_Input_Type'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPNNData_Input_Type represents Yuwei.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property graph.
			%
			% PROPS = PPNNData_Input_Type.GETPROPS() returns the property list of plot property graph.
			%
			% PROPS = PPNNData_Input_Type.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPNNData_Input_Type'[, CATEGORY]) returns the property list of 'PPNNData_Input_Type'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropOption.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropOption.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropOption.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropOption.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropOption.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropOption.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropOption.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property graph.
			%
			% N = PPNNData_Input_Type.GETPROPNUMBER() returns the property number of plot property graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPNNData_Input_Type') returns the property number of 'PPNNData_Input_Type'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property graph/error.
			%
			% CHECK = PPNNData_Input_Type.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPNNData_Input_Type, PROP) checks whether PROP exists for PPNNData_Input_Type.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  Element.EXISTSPROP(PPNNData_Input_Type, PROP) throws error if PROP does NOT exist for PPNNData_Input_Type.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPNNData_Input_Type.existsProp(prop), ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPNNData_Input_Type.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property graph/error.
			%
			% CHECK = PPNNData_Input_Type.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPNNData_Input_Type, TAG) checks whether TAG exists for PPNNData_Input_Type.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  Element.EXISTSTAG(PPNNData_Input_Type, TAG) throws error if TAG does NOT exist for PPNNData_Input_Type.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnndata_input_type_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppnndata_input_type_tag_list));
			else
				assert( ...
					PPNNData_Input_Type.existsTag(tag), ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPNNData_Input_Type'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPNNData_Input_Type, POINTER) returns property number of POINTER of PPNNData_Input_Type.
			%  PROPERTY = PR.GETPROPPROP(PPNNData_Input_Type, POINTER) returns property number of POINTER of PPNNData_Input_Type.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnndata_input_type_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPNNData_Input_Type.existsTag(tag);
				
				prop = find(strcmpi(tag, ppnndata_input_type_tag_list));
			else % numeric
				prop = pointer;
				PPNNData_Input_Type.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPNNData_Input_Type, POINTER) returns tag of POINTER of PPNNData_Input_Type.
			%  TAG = PR.GETPROPTAG(PPNNData_Input_Type, POINTER) returns tag of POINTER of PPNNData_Input_Type.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPNNData_Input_Type.existsTag(tag);
			else % numeric
				prop = pointer;
				PPNNData_Input_Type.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropOption(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPNNData_Input_Type, POINTER) returns category of POINTER of PPNNData_Input_Type.
			%  CATEGORY = PR.GETPROPCATEGORY(PPNNData_Input_Type, POINTER) returns category of POINTER of PPNNData_Input_Type.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropOption(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPNNData_Input_Type, POINTER) returns format of POINTER of PPNNData_Input_Type.
			%  FORMAT = PR.GETPROPFORMAT(PPNNData_Input_Type, POINTER) returns format of POINTER of PPNNData_Input_Type.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropOption(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPNNData_Input_Type, POINTER) returns description of POINTER of PPNNData_Input_Type.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPNNData_Input_Type, POINTER) returns description of POINTER of PPNNData_Input_Type.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotPropOption(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPNNData_Input_Type, POINTER) returns settings of POINTER of PPNNData_Input_Type.
			%  SETTINGS = PR.GETPROPSETTINGS(PPNNData_Input_Type, POINTER) returns settings of POINTER of PPNNData_Input_Type.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropOption(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPNNData_Input_Type.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNData_Input_Type.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPNNData_Input_Type, POINTER) returns the default value of POINTER of PPNNData_Input_Type.
			%  DEFAULT = PR.GETPROPDEFAULT(PPNNData_Input_Type, POINTER) returns the default value of POINTER of PPNNData_Input_Type.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropOption(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPNNData_Input_Type.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNData_Input_Type.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPNNData_Input_Type, POINTER) returns the conditioned default value of POINTER of PPNNData_Input_Type.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPNNData_Input_Type, POINTER) returns the conditioned default value of POINTER of PPNNData_Input_Type.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			prop_default = PPNNData_Input_Type.conditioning(prop, PPNNData_Input_Type.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPNNData_Input_Type, PROP, VALUE) checks VALUE format for PROP of PPNNData_Input_Type.
			%  CHECK = PR.CHECKPROP(PPNNData_Input_Type, PROP, VALUE) checks VALUE format for PROP of PPNNData_Input_Type.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  Element.CHECKPROP(PPNNData_Input_Type, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNData_Input_Type.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			%  PR.CHECKPROP(PPNNData_Input_Type, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNData_Input_Type.
			%   Error id: [BRAPH2:PPNNData_Input_Type:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropOption(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_Input_Type:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPNNData_Input_Type.getPropTag(prop) ' (' PPNNData_Input_Type.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPNNData_Input_Type(varargin)
			% PPNNData_Input_Type() creates a plot property graph.
			%
			% PPNNData_Input_Type(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPNNData_Input_Type(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPNNData_Input_Type properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropOption(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPNNData_Input_Type.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropOption.getPropNumber()
						value = conditioning@PlotPropOption(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the panel of the graph property and the measure table.
		    %
		    % DRAW(PR) draws the panel of the graph property and the measure table.
		    %
		    % H = DRAW(PR) returns a handle to the property panel.
		    %
		    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
		    %  panel with custom Name-Value pairs.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle H of the panel.
		    %
		    % See also update, redraw, refresh, uipanel.
		
		    pr.p = draw@PlotPropOption(pr, varargin{:});
		
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'popupmenu')
		            pr.list_tbl = children(i);
		        end
		    end
		    
		    set(pr.list_tbl, 'Callback', {@cb_item_list});
		    
		    function cb_item_list(~, ~)
		        val = get(pr.list_tbl, 'Value');
		        str = get(pr.list_tbl, 'String');
		
		        el = pr.get('el');
		        prop = pr.get('prop');
		        str = str{val};
		        el.set(prop, str)
		        pr.update();
		        pr.lock_measures_prop();
		    end
		    
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content and permissions of the pushbutton.
		    %
		    % UPDATE(PR) updates the content and permissions of the pushbutton.
		    %
		    % See also draw, redraw, refresh, PlotElement.
		
		    update@PlotPropOption(pr)
		end
		function redraw(pr, varargin)
		    %REDRAW resizes the property panel and repositions its graphical objects.
		    %
		    % REDRAW(PR) resizes the property panel and repositions its
		    %   graphical objects.
		    %
		    % Important notes:
		    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects.
		    % 2. REDRAW() is typically called internally by PlotElement and does not need
		    %  to be explicitly called in children of PlotProp.
		    %
		    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
		    %  repositions the property panel. It is possible to use a
		    %  subset of the Name-Value pairs.
		    %  By default:
		    %  - X0 does not change
		    %  - Y0 does not change
		    %  - WIDTH does not change
		    %  - HEIGHT=3.33 characters.
		    %
		    % See also draw, update, refresh, PlotElement.
		
		    pr.redraw@PlotPropOption(varargin{:})
		end
		function lock_measures_prop(pr)
		    pe =  ancestor(pr.p, 'figure').UserData.get('PE');
		    measure_panel =  pe.get('pr_dict').getItem('measures');
		    val = get(pr.list_tbl, 'Value');
		    str = get(pr.list_tbl, 'String');
		    str = str{val};
		    if strcmp(str, 'graph_measures')
		        measure_panel.cb_show_table();
		    else
		        measure_panel.cb_hide_table();
		    end
		    pe.redraw();
		end
	end
end
