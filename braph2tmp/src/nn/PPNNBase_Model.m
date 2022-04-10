classdef PPNNBase_Model < PlotPropCell
	% PPNNBase_Model plots the layer of neural networks.
	% It is a subclass of <a href="matlab:help PlotPropCell">PlotPropCell</a>.
	%
	% PPNNBase_Model plots the NN layers.
	% 
	% CALLBACK - This is a callback function:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the layer figure
	%     pr.<strong>cb_hide</strong>() - hides the layer figure
	%     pr.<strong>cb_close</strong>() - closes the layer figure
	%
	% The list of PPNNBase_Model properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPNNBase_Model methods (constructor):
	% PPNNBase_Model - constructor
	%
	% PPNNBase_Model methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property model/error.
	%  existsProp - checks whether property exists in plot property model/error.
	%  getPropNumber - returns the property number of plot property model.
	%  getProps - returns the property list of plot property model.
	%  getDescription - returns the description of the plot property model.
	%  getName - returns the name of the plot property model.
	%  getClass - returns the class of the plot property model.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPNNBase_Model methods:
	%  cb_close - closes the figure.
	%  cb_hide - hides the brain atlas figure and its settings figure.
	%  cb_bring_to_front - brings to front the brain atlas figure and its settings figure.
	%  get_buttons - _CONDITION returns the calculate button state.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the panel of the graph property and the measure table.
	%  cb_table_value_cell - ble_value_cell is a function.
	%  cb_button_del - /cb_button_del is a function.
	%  cb_button_calc - cb_button_calc is a function.
	%  cb_button_cb - l/cb_button_cb is a function.
	%  set_settings - l/set_settings is a function.
	%  cb_close_fs - el/cb_close_fs is a function.
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
	% PPNNBase_Model methods (operators):
	%  isequal - determines whether two PPNNBase_Model are equal (values, locked)
	%
	% PPNNBase_Model methods (display):
	%  tostring - string with information about the PPNNBase_Model
	%  disp - displays information about the PPNNBase_Model
	%  tree - displays the element of PPNNBase_Model
	%
	% PPNNBase_Model method (element list):
	%  getElementList - returns a list with all subelements of PPNNBase_Model
	%
	% PPNNBase_Model method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPNNBase_Model
	%
	% PPNNBase_Model method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPNNBase_Model
	%
	% PPNNBase_Model methods (copy):
	%  copy - copies the PPNNBase_Model
	%  deepclone - deep-clones the PPNNBase_Model
	%  clone - clones the PPNNBase_Model
	%
	% PPNNBase_Model methods (inspection, Static):
	%  getClass - returns PPNNBase_Model
	%  getName - returns the name of PPNNBase_Model
	%  getDescription - returns the description of PPNNBase_Model
	%  getProps - returns the property list of PPNNBase_Model
	%  getPropNumber - returns the property number of PPNNBase_Model
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
	% PPNNBase_Model methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPNNBase_Model methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPNNBase_Model methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPNNBase_Model methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPNNBase_Model properties (Constant).
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
		c_btn
		d_btn
		f_c
		h
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property model.
			%
			% CLASS = PPNNBase_Model.GETCLASS() returns the class 'PPNNBase_Model'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property model PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPNNBase_Model') returns 'PPNNBase_Model'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPNNBase_Model';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property model.
			%
			% NAME = PPNNBase_Model.GETNAME() returns the name of the 'plot property model'.
			%  Plot Property Model.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property model PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPNNBase_Model') returns the name of 'PPNNBase_Model'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Model';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property model.
			%
			% STR = PPNNBase_Model.GETDESCRIPTION() returns the description of the 'plot property model'.
			%  which is:
			%
			%  PPNNBase_Model plots the NN layers.
			%  
			%  CALLBACK - This is a callback function:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the layer figure
			%      pr.<strong>cb_hide</strong>() - hides the layer figure
			%      pr.<strong>cb_close</strong>() - closes the layer figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property model PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPNNBase_Model') returns the description of 'PPNNBase_Model'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPNNBase_Model plots the NN layers.' ...
				'' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the layer figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the layer figure' ...
				'    pr.<strong>cb_close</strong>() - closes the layer figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property model.
			%
			% PROPS = PPNNBase_Model.GETPROPS() returns the property list of plot property model.
			%
			% PROPS = PPNNBase_Model.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property model PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPNNBase_Model'[, CATEGORY]) returns the property list of 'PPNNBase_Model'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropCell.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropCell.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropCell.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropCell.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropCell.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropCell.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropCell.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property model.
			%
			% N = PPNNBase_Model.GETPROPNUMBER() returns the property number of plot property model.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property model PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPNNBase_Model') returns the property number of 'PPNNBase_Model'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property model/error.
			%
			% CHECK = PPNNBase_Model.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPNNBase_Model, PROP) checks whether PROP exists for PPNNBase_Model.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  Element.EXISTSPROP(PPNNBase_Model, PROP) throws error if PROP does NOT exist for PPNNBase_Model.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPNNBase_Model.existsProp(prop), ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPNNBase_Model.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property model/error.
			%
			% CHECK = PPNNBase_Model.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPNNBase_Model, TAG) checks whether TAG exists for PPNNBase_Model.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  Element.EXISTSTAG(PPNNBase_Model, TAG) throws error if TAG does NOT exist for PPNNBase_Model.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnnbase_model_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppnnbase_model_tag_list));
			else
				assert( ...
					PPNNBase_Model.existsTag(tag), ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPNNBase_Model'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPNNBase_Model, POINTER) returns property number of POINTER of PPNNBase_Model.
			%  PROPERTY = PR.GETPROPPROP(PPNNBase_Model, POINTER) returns property number of POINTER of PPNNBase_Model.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnnbase_model_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPNNBase_Model.existsTag(tag);
				
				prop = find(strcmpi(tag, ppnnbase_model_tag_list));
			else % numeric
				prop = pointer;
				PPNNBase_Model.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPNNBase_Model, POINTER) returns tag of POINTER of PPNNBase_Model.
			%  TAG = PR.GETPROPTAG(PPNNBase_Model, POINTER) returns tag of POINTER of PPNNBase_Model.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPNNBase_Model.existsTag(tag);
			else % numeric
				prop = pointer;
				PPNNBase_Model.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropCell(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPNNBase_Model, POINTER) returns category of POINTER of PPNNBase_Model.
			%  CATEGORY = PR.GETPROPCATEGORY(PPNNBase_Model, POINTER) returns category of POINTER of PPNNBase_Model.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropCell(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPNNBase_Model, POINTER) returns format of POINTER of PPNNBase_Model.
			%  FORMAT = PR.GETPROPFORMAT(PPNNBase_Model, POINTER) returns format of POINTER of PPNNBase_Model.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropCell(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPNNBase_Model, POINTER) returns description of POINTER of PPNNBase_Model.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPNNBase_Model, POINTER) returns description of POINTER of PPNNBase_Model.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotPropCell(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPNNBase_Model, POINTER) returns settings of POINTER of PPNNBase_Model.
			%  SETTINGS = PR.GETPROPSETTINGS(PPNNBase_Model, POINTER) returns settings of POINTER of PPNNBase_Model.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropCell(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPNNBase_Model.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNBase_Model.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPNNBase_Model, POINTER) returns the default value of POINTER of PPNNBase_Model.
			%  DEFAULT = PR.GETPROPDEFAULT(PPNNBase_Model, POINTER) returns the default value of POINTER of PPNNBase_Model.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropCell(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPNNBase_Model.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNBase_Model.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPNNBase_Model, POINTER) returns the conditioned default value of POINTER of PPNNBase_Model.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPNNBase_Model, POINTER) returns the conditioned default value of POINTER of PPNNBase_Model.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			prop_default = PPNNBase_Model.conditioning(prop, PPNNBase_Model.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPNNBase_Model, PROP, VALUE) checks VALUE format for PROP of PPNNBase_Model.
			%  CHECK = PR.CHECKPROP(PPNNBase_Model, PROP, VALUE) checks VALUE format for PROP of PPNNBase_Model.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  Element.CHECKPROP(PPNNBase_Model, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNBase_Model.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			%  PR.CHECKPROP(PPNNBase_Model, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNBase_Model.
			%   Error id: [BRAPH2:PPNNBase_Model:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropCell(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNBase_Model:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPNNBase_Model.getPropTag(prop) ' (' PPNNBase_Model.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPNNBase_Model(varargin)
			% PPNNBase_Model() creates a plot property model.
			%
			% PPNNBase_Model(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPNNBase_Model(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPNNBase_Model properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropCell(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPNNBase_Model.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropCell.getPropNumber()
						value = conditioning@PlotPropCell(pointer, value);
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
		
		    pr.p = draw@PlotProp(pr, varargin{:});
		    pr.get_buttons();
		    
		    el = pr.get('el');
		    
		    set(pr.c_btn, 'Callback', {@cb_button_mod_calc})
		    
		    function cb_button_mod_calc(~, ~)              
		        % position  %%%%%%%%%%%
		
		        % supress ploting from command line usage
		        el.set('PLOT_LAYERS', false);
		
		        pr.cb_button_calc()
		
		        f_ba = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
		        f_ba_x = Plot.x0(f_ba, 'pixels');
		        f_ba_y = Plot.y0(f_ba, 'pixels');
		        f_ba_w = Plot.w(f_ba, 'pixels');
		        f_ba_h = Plot.h(f_ba, 'pixels');
		        
		        screen_x = Plot.x0(0, 'pixels');
		        screen_y = Plot.y0(0, 'pixels');
		        screen_w = Plot.w(0, 'pixels');
		        screen_h = Plot.h(0, 'pixels');
		        
		        % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
		        x = f_ba_x + f_ba_w;
		        h = f_ba_h / 1.61;
		        y = f_ba_y + f_ba_h - h;
		        w = f_ba_w * 1.61;
		        
		        pr.h = figure('UNITS', 'normalized', 'POSITION', [x/screen_w y/screen_h w/screen_w h/screen_h]);
		        net = el.to_net(el.get('MODEL'));
		        lgraph = layerGraph(net);
		        plot(lgraph)
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
		
		    update@PlotPropCell(pr)
		    pr.get_buttons();
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
		
		    pr.redraw@PlotProp(varargin{:})
		end
		function get_buttons(pr)
		    % GET_BUTTON_CONDITION returns the calculate button state.
		    %
		    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
		    %
		    % see also is_measure_calculated.
		
		    plot_prop_children = get(pr.p, 'Children');    
		    for i = 1:length(plot_prop_children)
		        pp_c = plot_prop_children(i);
		        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
		            pr.c_btn = pp_c;
		        end
		        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_del')
		            if isgraphics(pr.h)
		                close(pr.h);
		            end
		            pr.d_btn = pp_c;
		        end
		    end
		end
		function cb_bring_to_front(pr)
		    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
		    %  settings figure.
		    %
		    % See also cb_hide, cb_close.
		
		    % bring to front settings panel
		    pr.cb_bring_to_front@PlotProp();
		
		    set(pr.h, 'Visible', 'on');
		end
		function cb_hide(pr)
		    %CB_HIDE hides the brain atlas figure and its settings figure.
		    %
		    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hide settings panel
		    pr.cb_hide@PlotProp();
		
		    set(pr.h, 'Visible', 'off');
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure.
		    %
		    % CB_CLOSE(PR) closes the figure and its children figures.
		    %
		    % See also cb_bring_to_front, cd_hide.
		    
		    if isgraphics(pr.h)
		        close(pr.h);
		    end
		end
	end
end
