classdef PPNNData_GR_NN < PlotPropItem
	% PPNNData_GR_NN is a plot of an item property.
	% It is a subclass of <a href="matlab:help PlotPropItem">PlotPropItem</a>.
	%
	% PPNNData_GR_NN plots NN group using a pushbutton that opens the linked object at a certain location.
	% 
	% CALLBACK - This is a callback function:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the NN group figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the NN group figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the NN group figure and its settings figure
	%
	% The list of PPNNData_GR_NN properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPNNData_GR_NN methods (constructor):
	% PPNNData_GR_NN - constructor
	%
	% PPNNData_GR_NN methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property item/error.
	%  existsProp - checks whether property exists in plot property item/error.
	%  getPropNumber - returns the property number of plot property item.
	%  getProps - returns the property list of plot property item.
	%  getDescription - returns the description of the plot property item.
	%  getName - returns the name of the plot property item.
	%  getClass - returns the class of the plot property item.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPNNData_GR_NN methods:
	%  cb_close - closes the figure.
	%  cb_hide - hides the brain atlas figure and its settings figure.
	%  cb_bring_to_front - brings to front the brain atlas figure and its settings figure.
	%  cb_pushbutton_margin - hbutton_margin is a function.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the panel of the item property.
	%  cb_pushbutton_value - shbutton_value is a function.
	%  cb_button_del - /cb_button_del is a function.
	%  cb_button_calc - cb_button_calc is a function.
	%  cb_button_cb - N/cb_button_cb is a function.
	%  set_settings - N/set_settings is a function.
	%  cb_close_fs - NN/cb_close_fs is a function.
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
	% PPNNData_GR_NN methods (operators):
	%  isequal - determines whether two PPNNData_GR_NN are equal (values, locked)
	%
	% PPNNData_GR_NN methods (display):
	%  tostring - string with information about the PPNNData_GR_NN
	%  disp - displays information about the PPNNData_GR_NN
	%  tree - displays the element of PPNNData_GR_NN
	%
	% PPNNData_GR_NN method (element list):
	%  getElementList - returns a list with all subelements of PPNNData_GR_NN
	%
	% PPNNData_GR_NN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPNNData_GR_NN
	%
	% PPNNData_GR_NN method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPNNData_GR_NN
	%
	% PPNNData_GR_NN methods (copy):
	%  copy - copies the PPNNData_GR_NN
	%  deepclone - deep-clones the PPNNData_GR_NN
	%  clone - clones the PPNNData_GR_NN
	%
	% PPNNData_GR_NN methods (inspection, Static):
	%  getClass - returns PPNNData_GR_NN
	%  getName - returns the name of PPNNData_GR_NN
	%  getDescription - returns the description of PPNNData_GR_NN
	%  getProps - returns the property list of PPNNData_GR_NN
	%  getPropNumber - returns the property number of PPNNData_GR_NN
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
	% PPNNData_GR_NN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPNNData_GR_NN methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPNNData_GR_NN methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPNNData_GR_NN methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPNNData_GR_NN properties (Constant).
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
		pushbutton
		f_nn_data
		pushbutton_value
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property item.
			%
			% CLASS = PPNNData_GR_NN.GETCLASS() returns the class 'PPNNData_GR_NN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property item PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPNNData_GR_NN') returns 'PPNNData_GR_NN'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPNNData_GR_NN';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property item.
			%
			% NAME = PPNNData_GR_NN.GETNAME() returns the name of the 'plot property item'.
			%  Plot Property Item.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property item PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPNNData_GR_NN') returns the name of 'PPNNData_GR_NN'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Item';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property item.
			%
			% STR = PPNNData_GR_NN.GETDESCRIPTION() returns the description of the 'plot property item'.
			%  which is:
			%
			%  PPNNData_GR_NN plots NN group using a pushbutton that opens the linked object at a certain location.
			%  
			%  CALLBACK - This is a callback function:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the NN group figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the NN group figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the NN group figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property item PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPNNData_GR_NN') returns the description of 'PPNNData_GR_NN'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPNNData_GR_NN plots NN group using a pushbutton that opens the linked object at a certain location.' ...
				'' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the NN group figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the NN group figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the NN group figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property item.
			%
			% PROPS = PPNNData_GR_NN.GETPROPS() returns the property list of plot property item.
			%
			% PROPS = PPNNData_GR_NN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property item PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPNNData_GR_NN'[, CATEGORY]) returns the property list of 'PPNNData_GR_NN'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropItem.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropItem.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropItem.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropItem.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropItem.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropItem.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropItem.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property item.
			%
			% N = PPNNData_GR_NN.GETPROPNUMBER() returns the property number of plot property item.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property item PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPNNData_GR_NN') returns the property number of 'PPNNData_GR_NN'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property item/error.
			%
			% CHECK = PPNNData_GR_NN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPNNData_GR_NN, PROP) checks whether PROP exists for PPNNData_GR_NN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  Element.EXISTSPROP(PPNNData_GR_NN, PROP) throws error if PROP does NOT exist for PPNNData_GR_NN.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPNNData_GR_NN.existsProp(prop), ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPNNData_GR_NN.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property item/error.
			%
			% CHECK = PPNNData_GR_NN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPNNData_GR_NN, TAG) checks whether TAG exists for PPNNData_GR_NN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  Element.EXISTSTAG(PPNNData_GR_NN, TAG) throws error if TAG does NOT exist for PPNNData_GR_NN.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnndata_gr_nn_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppnndata_gr_nn_tag_list));
			else
				assert( ...
					PPNNData_GR_NN.existsTag(tag), ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPNNData_GR_NN'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPNNData_GR_NN, POINTER) returns property number of POINTER of PPNNData_GR_NN.
			%  PROPERTY = PR.GETPROPPROP(PPNNData_GR_NN, POINTER) returns property number of POINTER of PPNNData_GR_NN.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnndata_gr_nn_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPNNData_GR_NN.existsTag(tag);
				
				prop = find(strcmpi(tag, ppnndata_gr_nn_tag_list));
			else % numeric
				prop = pointer;
				PPNNData_GR_NN.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPNNData_GR_NN, POINTER) returns tag of POINTER of PPNNData_GR_NN.
			%  TAG = PR.GETPROPTAG(PPNNData_GR_NN, POINTER) returns tag of POINTER of PPNNData_GR_NN.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPNNData_GR_NN.existsTag(tag);
			else % numeric
				prop = pointer;
				PPNNData_GR_NN.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropItem(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPNNData_GR_NN, POINTER) returns category of POINTER of PPNNData_GR_NN.
			%  CATEGORY = PR.GETPROPCATEGORY(PPNNData_GR_NN, POINTER) returns category of POINTER of PPNNData_GR_NN.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropItem(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPNNData_GR_NN, POINTER) returns format of POINTER of PPNNData_GR_NN.
			%  FORMAT = PR.GETPROPFORMAT(PPNNData_GR_NN, POINTER) returns format of POINTER of PPNNData_GR_NN.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropItem(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPNNData_GR_NN, POINTER) returns description of POINTER of PPNNData_GR_NN.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPNNData_GR_NN, POINTER) returns description of POINTER of PPNNData_GR_NN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				case PPNNData_GR_NN.ENABLE
					prop_description = 'ENABLE (metadata, option) switches between off and inactive fields.';
				otherwise
					prop_description = getPropDescription@PlotPropItem(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPNNData_GR_NN, POINTER) returns settings of POINTER of PPNNData_GR_NN.
			%  SETTINGS = PR.GETPROPSETTINGS(PPNNData_GR_NN, POINTER) returns settings of POINTER of PPNNData_GR_NN.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropItem(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPNNData_GR_NN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNData_GR_NN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPNNData_GR_NN, POINTER) returns the default value of POINTER of PPNNData_GR_NN.
			%  DEFAULT = PR.GETPROPDEFAULT(PPNNData_GR_NN, POINTER) returns the default value of POINTER of PPNNData_GR_NN.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				case PPNNData_GR_NN.ENABLE
					prop_default = 'off';
				otherwise
					prop_default = getPropDefault@PlotPropItem(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPNNData_GR_NN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNData_GR_NN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPNNData_GR_NN, POINTER) returns the conditioned default value of POINTER of PPNNData_GR_NN.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPNNData_GR_NN, POINTER) returns the conditioned default value of POINTER of PPNNData_GR_NN.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			prop_default = PPNNData_GR_NN.conditioning(prop, PPNNData_GR_NN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPNNData_GR_NN, PROP, VALUE) checks VALUE format for PROP of PPNNData_GR_NN.
			%  CHECK = PR.CHECKPROP(PPNNData_GR_NN, PROP, VALUE) checks VALUE format for PROP of PPNNData_GR_NN.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  Element.CHECKPROP(PPNNData_GR_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNData_GR_NN.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			%  PR.CHECKPROP(PPNNData_GR_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNData_GR_NN.
			%   Error id: [BRAPH2:PPNNData_GR_NN:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropItem(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNData_GR_NN:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPNNData_GR_NN.getPropTag(prop) ' (' PPNNData_GR_NN.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPNNData_GR_NN(varargin)
			% PPNNData_GR_NN() creates a plot property item.
			%
			% PPNNData_GR_NN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPNNData_GR_NN(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPNNData_GR_NN properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropItem(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPNNData_GR_NN.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropItem.getPropNumber()
						value = conditioning@PlotPropItem(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the panel of the item property.
		    %
		    % DRAW(PR) draws the panel of the item property.
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
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    pr.p = draw@PlotProp(pr, varargin{:});
		    
		    if ~check_graphics(pr.pushbutton_value, 'pushbutton')
		        pr.pushbutton_value = uicontrol( ...
		            'Style', 'pushbutton', ...
		            'Tag', 'pushbutton_value', ...
		            'Parent', pr.p, ...
		            'Units', 'normalized', ...
		            'Position', [.01 .10 .98 .45], ... % position defined here because it's always the same
		            'FontUnits', BRAPH2.FONTUNITS, ...
		            'FontSize', BRAPH2.FONTSIZE, ...
		            'Callback', {@cb_pushbutton_value} ...
		            );
		    end
		
		    function cb_pushbutton_value(~, ~) % (src, event)
		        pr.cb_pushbutton_value();
		    end
		
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'pushbutton')
		            pr.pushbutton = children(i);
		            break; % to do change the condition
		        end
		    end
		
		    set(pr.pushbutton, 'Callback', {@cb_pushbutton_margin});
		
		    function cb_pushbutton_margin(~, ~)
		        pr.cb_pushbutton_margin();
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
		
		    update@PlotProp(pr);
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    value = el.getr(prop);
		
		    if isa(value, 'NoValue')
		        set(pr.pushbutton_value, ...
		            'String', 'NNGroup', ...
		            'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
		            'Enable', pr.get('ENABLE') ...
		            );
		    else
		        set(pr.pushbutton_value, ...
		            'String', 'NNGroup', ...
		            'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
		            'Enable', 'on' ...
		            );
		    end
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
		
		    pr.redraw@PlotPropItem(varargin{:});
		end
		function cb_pushbutton_margin(pr)
		    %CB_PUSHBUTTON_VALUE executes callback for the pushbutton.
		    %
		    % CB_PUSHBUTTON_VALUE(PR) executes callback for the pushbutton.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    pr.update();
		    f_ba = ancestor(pr.p, 'Figure');
		    f_ba_x = Plot.x0(f_ba, 'pixels');
		    f_ba_y = Plot.y0(f_ba, 'pixels');
		    f_ba_w = Plot.w(f_ba, 'pixels');
		    f_ba_h = Plot.h(f_ba, 'pixels');
		
		    screen_x = Plot.x0(0, 'pixels');
		    screen_y = Plot.y0(0, 'pixels');
		    screen_w = Plot.w(0, 'pixels');
		    screen_h = Plot.h(0, 'pixels');
		
		    x = (f_ba_x + f_ba_w) / screen_w;
		    y = f_ba_y / screen_h;
		    w = f_ba_w / screen_w;
		    h = f_ba_h / screen_h;
		
		    value = el.getr(prop);
		    if isa(value, 'NoValue')
		        pr.f_nn_data = GUI('PE', el.getPropDefault(prop), 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
		    else
		        pr.f_nn_data = GUI('PE', el.get(prop), 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
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
		
		    % bring to front NN group figure
		    if check_graphics(pr.f_nn_data, 'figure')
		        children = get(pr.f_nn_data, 'Children');
		        holder = get(pr.f_nn_data, 'UserData');
		        holder.cb_bring_to_front();
		    end
		end
		function cb_hide(pr)
		    %CB_HIDE hides the brain atlas figure and its settings figure.
		    %
		    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hide settings panel
		    pr.cb_hide@PlotProp();
		
		    % hide NN group figure
		    if check_graphics(pr.f_nn_data, 'figure')
		        holder = get(pr.f_nn_data, 'UserData');
		        holder.cb_hide();
		    end
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure.
		    %
		    % CB_CLOSE(PR) closes the figure and its children figures.
		    %
		    % See also cb_bring_to_front, cd_hide.
		
		    % close NN group gui
		    if check_graphics(pr.f_nn_data, 'figure')
		        close(pr.f_nn_data)
		    end
		end
	end
end
