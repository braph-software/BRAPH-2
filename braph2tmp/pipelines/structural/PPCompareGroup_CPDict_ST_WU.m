classdef PPCompareGroup_CPDict_ST_WU < PlotProp
	% PPCompareGroup_CPDict_ST_WU is a plot of a comparison dictionary.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPCompareGroup_CPDict_WU plots the comparison dictionary property associated with a graph.
	% It also provides the buttons to navigate the graphical interface of the measures.
	% 
	% CALLBACK -  These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
	%
	% The list of PPCompareGroup_CPDict_ST_WU properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPCompareGroup_CPDict_ST_WU methods (constructor):
	% PPCompareGroup_CPDict_ST_WU - constructor
	%
	% PPCompareGroup_CPDict_ST_WU methods (Static):
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
	% PPCompareGroup_CPDict_ST_WU methods:
	%  cb_close - closes the figure.
	%  cb_hide - hides the figure and its settings figure.
	%  cb_bring_to_front - brings to front the figure and its settings figure.
	%  get_button_condition - N returns the calculate button state.
	%  is_measure_calculated - D checks if a measure has been calculated for the graph.
	%  cb_measure_calc - PDict_ST_WU/cb_measure_calc is a function.
	%  cb_measure_gui - executes callback for the pushbutton.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the panel of the graph property and the measure table.
	%  cb_button_del - _CPDict_ST_WU/cb_button_del is a function.
	%  cb_button_calc - CPDict_ST_WU/cb_button_calc is a function.
	%  cb_button_cb - p_CPDict_ST_WU/cb_button_cb is a function.
	%  set_settings - p_CPDict_ST_WU/set_settings is a function.
	%  cb_close_fs - up_CPDict_ST_WU/cb_close_fs is a function.
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
	% PPCompareGroup_CPDict_ST_WU methods (operators):
	%  isequal - determines whether two PPCompareGroup_CPDict_ST_WU are equal (values, locked)
	%
	% PPCompareGroup_CPDict_ST_WU methods (display):
	%  tostring - string with information about the PPCompareGroup_CPDict_ST_WU
	%  disp - displays information about the PPCompareGroup_CPDict_ST_WU
	%  tree - displays the element of PPCompareGroup_CPDict_ST_WU
	%
	% PPCompareGroup_CPDict_ST_WU method (element list):
	%  getElementList - returns a list with all subelements of PPCompareGroup_CPDict_ST_WU
	%
	% PPCompareGroup_CPDict_ST_WU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPCompareGroup_CPDict_ST_WU
	%
	% PPCompareGroup_CPDict_ST_WU method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPCompareGroup_CPDict_ST_WU
	%
	% PPCompareGroup_CPDict_ST_WU methods (copy):
	%  copy - copies the PPCompareGroup_CPDict_ST_WU
	%  deepclone - deep-clones the PPCompareGroup_CPDict_ST_WU
	%  clone - clones the PPCompareGroup_CPDict_ST_WU
	%
	% PPCompareGroup_CPDict_ST_WU methods (inspection, Static):
	%  getClass - returns PPCompareGroup_CPDict_ST_WU
	%  getName - returns the name of PPCompareGroup_CPDict_ST_WU
	%  getDescription - returns the description of PPCompareGroup_CPDict_ST_WU
	%  getProps - returns the property list of PPCompareGroup_CPDict_ST_WU
	%  getPropNumber - returns the property number of PPCompareGroup_CPDict_ST_WU
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
	% PPCompareGroup_CPDict_ST_WU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPCompareGroup_CPDict_ST_WU methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPCompareGroup_CPDict_ST_WU methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPCompareGroup_CPDict_ST_WU methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPCompareGroup_CPDict_ST_WU properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, CompareGroup, ComparisonGroup..
	
	properties (Access = private) % element properties
		p
		measure_tbl % measure table
		measure_btn % calculate measures button
		measure_plot_btn
		mlist % list of measures compatible with the graph
		selected % list of selected measures
		already_calculated % list of measures already calculated
		f_m % array of measure class figures
		graph % graph of the comparison
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property graph.
			%
			% CLASS = PPCompareGroup_CPDict_ST_WU.GETCLASS() returns the class 'PPCompareGroup_CPDict_ST_WU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPCompareGroup_CPDict_ST_WU') returns 'PPCompareGroup_CPDict_ST_WU'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPCompareGroup_CPDict_ST_WU';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property graph.
			%
			% NAME = PPCompareGroup_CPDict_ST_WU.GETNAME() returns the name of the 'plot property graph'.
			%  Plot Property Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPCompareGroup_CPDict_ST_WU') returns the name of 'PPCompareGroup_CPDict_ST_WU'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property graph.
			%
			% STR = PPCompareGroup_CPDict_ST_WU.GETDESCRIPTION() returns the description of the 'plot property graph'.
			%  which is:
			%
			%  PPCompareGroup_CPDict_WU plots the comparison dictionary property associated with a graph.
			%  It also provides the buttons to navigate the graphical interface of the measures.
			%  
			%  CALLBACK -  These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPCompareGroup_CPDict_ST_WU') returns the description of 'PPCompareGroup_CPDict_ST_WU'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPCompareGroup_CPDict_WU plots the comparison dictionary property associated with a graph.' ...
				'It also provides the buttons to navigate the graphical interface of the measures.' ...
				'' ...
				'CALLBACK -  These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property graph.
			%
			% PROPS = PPCompareGroup_CPDict_ST_WU.GETPROPS() returns the property list of plot property graph.
			%
			% PROPS = PPCompareGroup_CPDict_ST_WU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPCompareGroup_CPDict_ST_WU'[, CATEGORY]) returns the property list of 'PPCompareGroup_CPDict_ST_WU'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotProp.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotProp.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotProp.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotProp.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotProp.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotProp.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotProp.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property graph.
			%
			% N = PPCompareGroup_CPDict_ST_WU.GETPROPNUMBER() returns the property number of plot property graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPCompareGroup_CPDict_ST_WU') returns the property number of 'PPCompareGroup_CPDict_ST_WU'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property graph/error.
			%
			% CHECK = PPCompareGroup_CPDict_ST_WU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPCompareGroup_CPDict_ST_WU, PROP) checks whether PROP exists for PPCompareGroup_CPDict_ST_WU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  Element.EXISTSPROP(PPCompareGroup_CPDict_ST_WU, PROP) throws error if PROP does NOT exist for PPCompareGroup_CPDict_ST_WU.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPCompareGroup_CPDict_ST_WU.existsProp(prop), ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPCompareGroup_CPDict_ST_WU.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property graph/error.
			%
			% CHECK = PPCompareGroup_CPDict_ST_WU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPCompareGroup_CPDict_ST_WU, TAG) checks whether TAG exists for PPCompareGroup_CPDict_ST_WU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  Element.EXISTSTAG(PPCompareGroup_CPDict_ST_WU, TAG) throws error if TAG does NOT exist for PPCompareGroup_CPDict_ST_WU.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppcomparegroup_cpdict_st_wu_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppcomparegroup_cpdict_st_wu_tag_list));
			else
				assert( ...
					PPCompareGroup_CPDict_ST_WU.existsTag(tag), ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPCompareGroup_CPDict_ST_WU'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPCompareGroup_CPDict_ST_WU, POINTER) returns property number of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  PROPERTY = PR.GETPROPPROP(PPCompareGroup_CPDict_ST_WU, POINTER) returns property number of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppcomparegroup_cpdict_st_wu_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPCompareGroup_CPDict_ST_WU.existsTag(tag);
				
				prop = find(strcmpi(tag, ppcomparegroup_cpdict_st_wu_tag_list));
			else % numeric
				prop = pointer;
				PPCompareGroup_CPDict_ST_WU.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPCompareGroup_CPDict_ST_WU, POINTER) returns tag of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  TAG = PR.GETPROPTAG(PPCompareGroup_CPDict_ST_WU, POINTER) returns tag of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPCompareGroup_CPDict_ST_WU.existsTag(tag);
			else % numeric
				prop = pointer;
				PPCompareGroup_CPDict_ST_WU.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotProp(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPCompareGroup_CPDict_ST_WU, POINTER) returns category of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  CATEGORY = PR.GETPROPCATEGORY(PPCompareGroup_CPDict_ST_WU, POINTER) returns category of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotProp(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPCompareGroup_CPDict_ST_WU, POINTER) returns format of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  FORMAT = PR.GETPROPFORMAT(PPCompareGroup_CPDict_ST_WU, POINTER) returns format of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotProp(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPCompareGroup_CPDict_ST_WU, POINTER) returns description of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPCompareGroup_CPDict_ST_WU, POINTER) returns description of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotProp(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPCompareGroup_CPDict_ST_WU, POINTER) returns settings of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  SETTINGS = PR.GETPROPSETTINGS(PPCompareGroup_CPDict_ST_WU, POINTER) returns settings of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPCompareGroup_CPDict_ST_WU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPCompareGroup_CPDict_ST_WU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPCompareGroup_CPDict_ST_WU, POINTER) returns the default value of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  DEFAULT = PR.GETPROPDEFAULT(PPCompareGroup_CPDict_ST_WU, POINTER) returns the default value of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPCompareGroup_CPDict_ST_WU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPCompareGroup_CPDict_ST_WU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPCompareGroup_CPDict_ST_WU, POINTER) returns the conditioned default value of POINTER of PPCompareGroup_CPDict_ST_WU.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPCompareGroup_CPDict_ST_WU, POINTER) returns the conditioned default value of POINTER of PPCompareGroup_CPDict_ST_WU.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			prop_default = PPCompareGroup_CPDict_ST_WU.conditioning(prop, PPCompareGroup_CPDict_ST_WU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPCompareGroup_CPDict_ST_WU, PROP, VALUE) checks VALUE format for PROP of PPCompareGroup_CPDict_ST_WU.
			%  CHECK = PR.CHECKPROP(PPCompareGroup_CPDict_ST_WU, PROP, VALUE) checks VALUE format for PROP of PPCompareGroup_CPDict_ST_WU.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  Element.CHECKPROP(PPCompareGroup_CPDict_ST_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPCompareGroup_CPDict_ST_WU.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			%  PR.CHECKPROP(PPCompareGroup_CPDict_ST_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPCompareGroup_CPDict_ST_WU.
			%   Error id: [BRAPH2:PPCompareGroup_CPDict_ST_WU:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPCompareGroup_CPDict_ST_WU:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPCompareGroup_CPDict_ST_WU.getPropTag(prop) ' (' PPCompareGroup_CPDict_ST_WU.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPCompareGroup_CPDict_ST_WU(varargin)
			% PPCompareGroup_CPDict_ST_WU() creates a plot property graph.
			%
			% PPCompareGroup_CPDict_ST_WU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPCompareGroup_CPDict_ST_WU(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPCompareGroup_CPDict_ST_WU properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotProp(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPCompareGroup_CPDict_ST_WU.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotProp.getPropNumber()
						value = conditioning@PlotProp(pointer, value);
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
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    % graph button   
		    
		    pr.mlist = [];
		    
		    pr.measure_tbl = uitable( ...
		        'Parent', pr.p, ...
		        'CellEditCallback', {@cb_measure_edit}, ...
		        'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
		        'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
		        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		        'Visible', 'off', ...
		        'ColumnEditable', [true false false false false] ...
		        );
		    
		    % measure button
		    pr.measure_btn = uicontrol( ...
		        'Parent', pr.p, ...
		        'Style', 'pushbutton', ...
		        'Tag', 'measure_button', ...
		        'Units', 'normalized', ...
		        'String', 'Calculate Comparisons', ...
		        'TooltipString', 'Calculate Selected Measure Comparison', ...
		        'Position', [.01 .02 .48 .09], ...
		        'Visible', 'off', ...
		        'Callback', {@cb_measure_btn} ...
		        );
		    
		    pr.measure_plot_btn = uicontrol(...
		        'Parent', pr.p, ...
		        'Style', 'pushbutton', ...
		        'Tag', 'measure_plot_button', ...
		        'Units', 'normalized', ...
		        'String', 'Show Comparisons', ...
		        'TooltipString', 'Show Selected Measures Comparison', ...
		        'Position', [.51 .02 .48 .09], ...
		        'Visible', 'off', ...
		        'Callback', {@cb_measure_plot_btn} ...
		        );
		        
		    function cb_measure_edit(~, event)
		        i = event.Indices(1);
		        col = event.Indices(2);
		        newdata = event.NewData;
		        switch col
		            case 1
		                if newdata == 1
		                    pr.selected = sort(unique([pr.selected(:); i]));
		                else
		                    pr.selected = pr.selected(pr.selected ~= i);
		                end            
		                
		            otherwise
		                % dont do anything
		        end
		        pr.update()
		    end
		    function cb_measure_btn(~, ~)
		        pr.cb_measure_calc()
		    end
		    function cb_measure_plot_btn(~, ~)
		        pr.cb_measure_gui();
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
		
		    update@PlotProp(pr)
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');    
		
		    button_state = pr.get_button_condition();
		
		    if ~button_state        
		        set(pr.measure_tbl, 'Visible', 'off')
		        set(pr.measure_btn, 'Visible', 'off')
		        set(pr.measure_plot_btn, 'Visible', 'off')
		
		    else
		        cp_dict = el.get(prop);
		        pr.graph = el.get('A1').get('G');
		        
		         % visible gui
		        set(pr.measure_tbl, 'Visible', 'on')
		        set(pr.measure_btn, 'Visible', 'on')
		        set(pr.measure_plot_btn, 'Visible', 'on')
		
		        if  ~isa(pr.graph, 'NoValue') && isa(pr.graph, 'Graph')
		            if isempty(pr.mlist)
		                pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
		            end
		            pr.already_calculated = pr.is_measure_calculated();
		            data = cell(length(pr.mlist), 5);
		            for mi = 1:1:length(pr.mlist)
		                if any(pr.selected == mi)
		                    data{mi, 1} = true;
		                else
		                    data{mi, 1} = false;
		                end
		
		                data{mi, 2} = pr.mlist{mi};
		
		                if Measure.is_nodal(pr.mlist{mi})
		                    data{mi, 3} = 'NODAL';
		                elseif Measure.is_global(pr.mlist{mi})
		                    data{mi, 3} = 'GLOBAL';
		                else
		                    data{mi, 3} = 'BINODAL';
		                end
		
		                if Measure.is_superglobal(pr.mlist{mi})
		                    data{mi, 4} = 'SUPERGLOBAL';
		                elseif Measure.is_unilayer(pr.mlist{mi})
		                    data{mi, 4} = 'UNILAYER';
		                else
		                    data{mi, 4} = 'BILAYER';
		                end
		
		                data{mi, 5} = eval([pr.mlist{mi} '.getDescription()']);
		            end
		            set(pr.measure_tbl, 'Data', data)
		            set(pr.measure_tbl, 'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'})
		
		            row_names = cell(length(pr.already_calculated), 1);
		            for i = 1:length(pr.already_calculated)
		                if pr.already_calculated{i}
		                    row_names{i} = 'C';
		                else
		                    row_names{i} = '';
		                end
		            end
		            set(pr.measure_tbl, 'RowName', row_names)
		        end
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
		
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(15, 'DHeight', varargin);
		
		    if pr.get_button_condition()
		        if  ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
		            set(pr.measure_tbl, ...
		                'Units', 'normalized', ...
		                'Position', [.01 .13 .98 (Dh/(h+Dh)-.27)] ...
		                )
		        end
		        pr.redraw@PlotProp('Height', (h + Dh)*1.5, varargin{:})
		    else
		        if  ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
		            set(pr.measure_tbl, ...
		                'Units', 'normalized', ...
		                'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)], ...
		                'Visible', 'off' ...
		                )
		        end
		        pr.redraw@PlotProp(varargin{:})
		    end
		end
		function cb_measure_gui(pr)
		    %CB_MEASURE_GUI executes callback for the pushbutton.
		    %
		    % CB_MEASURE_GUI(PR) executes callback for the pushbutton.
		    %  It opens Measure GUI.
		    %
		    % See also cb_graph_value.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    cp_dict = el.get(prop);    
		    pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
		    measure_short_list = pr.mlist(pr.selected);
		
		    % determine figure position
		    f_gr = ancestor(pr.p, 'Figure'); % GUI Group
		    f_gr_x = Plot.x0(f_gr, 'pixels');
		    f_gr_y = Plot.y0(f_gr, 'pixels');
		    f_gr_w = Plot.w(f_gr, 'pixels');
		    f_gr_h = Plot.h(f_gr, 'pixels');
		
		    screen_x = Plot.x0(0, 'pixels');
		    screen_y = Plot.y0(0, 'pixels');
		    screen_w = Plot.w(0, 'pixels');
		    screen_h = Plot.h(0, 'pixels');
		
		    N = ceil(sqrt(length(pr.mlist))); % number of row and columns of figures
		
		    f_count = 1;
		    for i = 1:length(pr.mlist)
		        if ~ismember(pr.mlist(i), measure_short_list)
		            continue;
		        end
		        measure_name = pr.mlist{i};
		        plot_permission = true;
		        tmp_gui = [];
		        for j = 1:cp_dict.length()
		            cp = cp_dict.getItem(j);
		            if isequal(measure_name, cp.get('measure'))
		                x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
		                y = f_gr_y / screen_h;
		                w = f_gr_w / screen_w;
		                h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;
		                   
		                for k = 1:length(pr.f_m)
		                    tmp_f = pr.f_m{k};
		                    if isgraphics(tmp_f)
		                        tmp_gui = get(tmp_f, 'UserData');
		                        if isequal(tmp_gui.get('pe').get('el').get('id'), cp.get('ID'))
		                            plot_permission = false;
		                            if isequal(get(tmp_f, 'Visible'), 'on')
		                                % hide
		                                set(tmp_f, 'Visible', 'off')
		                            else
		                                % show
		                                figure(tmp_f);
		                                set(tmp_f, ...
		                                    'Visible', 'on', ...
		                                    'WindowState', 'normal' ...
		                                    );
		                            end
		                        end
		                    end                    
		                end
		                if plot_permission
		                    pr.f_m{f_count} = GUI('pe', cp, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
		                    f_count = f_count + 1;
		                end
		                break; % go to next measure
		            end            
		        end        
		    end
		end
		function cb_measure_calc(pr)
		    el = pr.get('EL');   
		    pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
		    measure_short_list = pr.mlist(pr.selected);
		
		    % calculate
		    if pr.get('WAITBAR')
		        wb = waitbar(0, ['Calculating ' num2str(length(pr.selected))  ' comparisons ...'], 'Name', BRAPH2.NAME);
		        set_braph2icon(wb)
		    end
		
		    for i = 1:length(pr.mlist)
		        if ~ismember(pr.mlist(i), measure_short_list)
		            continue;
		        end
		
		        measure = pr.mlist{i};
		        if pr.get('WAITBAR')
		            waitbar(.1 + .20 * i / length(pr.selected), wb, ['Calculating comparison ' measure ]);
		        end
		        el.getComparison(measure).memorize('DIFF');
		        el.getComparison(measure).memorize('P1');
		        el.getComparison(measure).memorize('P2');
		        el.getComparison(measure).memorize('CIL');
		        el.getComparison(measure).memorize('CIU');
		        pr.already_calculated{i} = 1;
		    end
		
		    % close progress bar
		    if pr.get('WAITBAR')
		        close(wb)
		    end
		    pr.update();
		end
		function list =  is_measure_calculated(pr)
		    % IS_MEASURE_CALCULATED checks if a measure has been calculated for the graph.
		    % 
		    % LIST = IS_MEASURE_CALCULATED(PR) returns an array with the check for
		    %  previously calculated measures. C if a measures has been calculated
		    %  and NC for nor calculated measures.
		    %
		    % See also get_button_condition.
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    cp_dict = el.get(prop);
		    measure_list = pr.mlist;
		    calculated_list = cell(cp_dict.length(), 1);
		    if cp_dict.length() > 0
		        for i = 1:length(measure_list)
		            measure = measure_list{i};
		            if any(cellfun(@(x) isequal(x.get('MEASURE'), measure), cp_dict.getItems()))
		                calculated_list{i} = 1;
		            else
		                calculated_list{i} = 0;
		            end
		        end
		    else
		        [calculated_list{:}] = deal(0);
		    end
		    list = calculated_list;
		end
		function state = get_button_condition(pr)
		    % GET_BUTTON_CONDITION returns the calculate button state.
		    %
		    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
		    %
		    % see also is_measure_calculated.
		    
		    plot_prop_children = get(pr.p, 'Children');
		    state = 0;
		    for i = 1:length(plot_prop_children)
		        pp_c = plot_prop_children(i);
		        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
		            if isequal(pp_c.Enable, 'off')
		                state = 1;            
		            end
		        end
		    end
		
		end
		function cb_bring_to_front(pr)
		    %CB_BRING_TO_FRONT brings to front the figure and its settings figure.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to front the figure and its
		    %  settings figure.
		    %
		    % See also cb_hide, cb_close.
		
		    % brings to front settings panel
		    pr.cb_bring_to_front@PlotProp();
		        
		    % bring to front measure class guis
		    for i = 1:length(pr.f_m)
		        f_m = pr.f_m{i};
		        if check_graphics(f_m, 'figure')
		            gui = get(f_m, 'UserData');
		            pe = gui.get('PE');
		            pe.cb_bring_to_front()
		        end
		    end
		       
		end
		function cb_hide(pr)
		    %CB_HIDE hides the figure and its settings figure.
		    %
		    % CB_HIDE(PR) hides the figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hides settings panel
		    pr.cb_hide@PlotProp();    
		    
		    % bring to front measure class guis
		    for i = 1:length(pr.f_m)
		        f_m = pr.f_m{i};
		        if check_graphics(f_m, 'figure')
		            gui = get(f_m, 'UserData');
		            pe = gui.get('PE');
		            pe.cb_hide()
		        end
		    end
		
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure.
		    %
		    % CB_CLOSE(PR) closes the figure and its children figures.
		    %
		    % See also cb_bring_to_front, cd_hide.
		
		    % closes measure class guis
		    for i = 1:length(pr.f_m)
		        f_m = pr.f_m{i};
		        if check_graphics(f_m, 'figure')
		            close(f_m)
		        end
		    end
		    
		end
	end
end
