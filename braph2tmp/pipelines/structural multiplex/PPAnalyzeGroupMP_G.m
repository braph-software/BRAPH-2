classdef PPAnalyzeGroupMP_G < PlotProp
	% PPAnalyzeGroupMP_G is a plot of a multiplex graph property.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPAnalyzeGroupMP_G plots the measure table associated with a multiplex graph of the analysis.
	% It also provides the buttons to navigate the graphical interface of both
	% the measures and the graph.
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
	%
	% The list of PPAnalyzeGroupMP_G properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPAnalyzeGroupMP_G methods (constructor):
	% PPAnalyzeGroupMP_G - constructor
	%
	% PPAnalyzeGroupMP_G methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property graph mp/error.
	%  existsProp - checks whether property exists in plot property graph mp/error.
	%  getPropNumber - returns the property number of plot property graph mp.
	%  getProps - returns the property list of plot property graph mp.
	%  getDescription - returns the description of the plot property graph mp.
	%  getName - returns the name of the plot property graph mp.
	%  getClass - returns the class of the plot property graph mp.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPAnalyzeGroupMP_G methods:
	%  cb_close - closes the figure.
	%  cb_hide - hides the figure and its settings figure.
	%  cb_bring_to_front - brings to front the figure and its settings figure.
	%  get_button_condition - N returns the calculate button state.
	%  is_measure_calculated - D checks if a measure has been calculated for the graph.
	%  cb_graph_adj_figure - b_graph_adj_figure is a function.
	%  cb_graph_ui_figure - E draws a new figure to manage a plot graph.
	%  cb_measure_calc - _G/cb_measure_calc is a function.
	%  cb_measure_gui - executes callback for the pushbutton.
	%  cb_graph_value - executes callback for the pushbutton.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the panel of the graph property and the measure table.
	%  cb_button_del - MP_G/cb_button_del is a function.
	%  cb_button_calc - P_G/cb_button_calc is a function.
	%  cb_button_cb - pMP_G/cb_button_cb is a function.
	%  set_settings - pMP_G/set_settings is a function.
	%  cb_close_fs - upMP_G/cb_close_fs is a function.
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
	% PPAnalyzeGroupMP_G methods (operators):
	%  isequal - determines whether two PPAnalyzeGroupMP_G are equal (values, locked)
	%
	% PPAnalyzeGroupMP_G methods (display):
	%  tostring - string with information about the PPAnalyzeGroupMP_G
	%  disp - displays information about the PPAnalyzeGroupMP_G
	%  tree - displays the element of PPAnalyzeGroupMP_G
	%
	% PPAnalyzeGroupMP_G method (element list):
	%  getElementList - returns a list with all subelements of PPAnalyzeGroupMP_G
	%
	% PPAnalyzeGroupMP_G method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPAnalyzeGroupMP_G
	%
	% PPAnalyzeGroupMP_G method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPAnalyzeGroupMP_G
	%
	% PPAnalyzeGroupMP_G methods (copy):
	%  copy - copies the PPAnalyzeGroupMP_G
	%  deepclone - deep-clones the PPAnalyzeGroupMP_G
	%  clone - clones the PPAnalyzeGroupMP_G
	%
	% PPAnalyzeGroupMP_G methods (inspection, Static):
	%  getClass - returns PPAnalyzeGroupMP_G
	%  getName - returns the name of PPAnalyzeGroupMP_G
	%  getDescription - returns the description of PPAnalyzeGroupMP_G
	%  getProps - returns the property list of PPAnalyzeGroupMP_G
	%  getPropNumber - returns the property number of PPAnalyzeGroupMP_G
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
	% PPAnalyzeGroupMP_G methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPAnalyzeGroupMP_G methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPAnalyzeGroupMP_G methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPAnalyzeGroupMP_G methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPAnalyzeGroupMP_G properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, AnalyzeGroup.
	
	properties (Access = private) % element properties
		p
		measure_tbl
		measure_btn
		graph_btn
		plot_graph_btn
		plot_type_adj
		line_plot_tglbtn % line plot toggle button
		measure_plot_btn
		mlist
		selected
		already_calculated
		graph % internal graph type
		f_m % array of measure class figures
		f_pg % figure for plot graph
		f_adj % figure for plot adj
		f_g % figure for class graph
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property graph mp.
			%
			% CLASS = PPAnalyzeGroupMP_G.GETCLASS() returns the class 'PPAnalyzeGroupMP_G'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property graph mp PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPAnalyzeGroupMP_G') returns 'PPAnalyzeGroupMP_G'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPAnalyzeGroupMP_G';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property graph mp.
			%
			% NAME = PPAnalyzeGroupMP_G.GETNAME() returns the name of the 'plot property graph mp'.
			%  Plot Property Graph Mp.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property graph mp PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPAnalyzeGroupMP_G') returns the name of 'PPAnalyzeGroupMP_G'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Graph Mp';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property graph mp.
			%
			% STR = PPAnalyzeGroupMP_G.GETDESCRIPTION() returns the description of the 'plot property graph mp'.
			%  which is:
			%
			%  PPAnalyzeGroupMP_G plots the measure table associated with a multiplex graph of the analysis.
			%  It also provides the buttons to navigate the graphical interface of both
			%  the measures and the graph.
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property graph mp PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPAnalyzeGroupMP_G') returns the description of 'PPAnalyzeGroupMP_G'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPAnalyzeGroupMP_G plots the measure table associated with a multiplex graph of the analysis.' ...
				'It also provides the buttons to navigate the graphical interface of both' ...
				'the measures and the graph.' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property graph mp.
			%
			% PROPS = PPAnalyzeGroupMP_G.GETPROPS() returns the property list of plot property graph mp.
			%
			% PROPS = PPAnalyzeGroupMP_G.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property graph mp PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPAnalyzeGroupMP_G'[, CATEGORY]) returns the property list of 'PPAnalyzeGroupMP_G'.
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
			%GETPROPNUMBER returns the property number of plot property graph mp.
			%
			% N = PPAnalyzeGroupMP_G.GETPROPNUMBER() returns the property number of plot property graph mp.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property graph mp PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPAnalyzeGroupMP_G') returns the property number of 'PPAnalyzeGroupMP_G'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property graph mp/error.
			%
			% CHECK = PPAnalyzeGroupMP_G.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPAnalyzeGroupMP_G, PROP) checks whether PROP exists for PPAnalyzeGroupMP_G.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  Element.EXISTSPROP(PPAnalyzeGroupMP_G, PROP) throws error if PROP does NOT exist for PPAnalyzeGroupMP_G.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPAnalyzeGroupMP_G.existsProp(prop), ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPAnalyzeGroupMP_G.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property graph mp/error.
			%
			% CHECK = PPAnalyzeGroupMP_G.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPAnalyzeGroupMP_G, TAG) checks whether TAG exists for PPAnalyzeGroupMP_G.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  Element.EXISTSTAG(PPAnalyzeGroupMP_G, TAG) throws error if TAG does NOT exist for PPAnalyzeGroupMP_G.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppanalyzegroupmp_g_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppanalyzegroupmp_g_tag_list));
			else
				assert( ...
					PPAnalyzeGroupMP_G.existsTag(tag), ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPAnalyzeGroupMP_G'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPAnalyzeGroupMP_G, POINTER) returns property number of POINTER of PPAnalyzeGroupMP_G.
			%  PROPERTY = PR.GETPROPPROP(PPAnalyzeGroupMP_G, POINTER) returns property number of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppanalyzegroupmp_g_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPAnalyzeGroupMP_G.existsTag(tag);
				
				prop = find(strcmpi(tag, ppanalyzegroupmp_g_tag_list));
			else % numeric
				prop = pointer;
				PPAnalyzeGroupMP_G.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPAnalyzeGroupMP_G, POINTER) returns tag of POINTER of PPAnalyzeGroupMP_G.
			%  TAG = PR.GETPROPTAG(PPAnalyzeGroupMP_G, POINTER) returns tag of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPAnalyzeGroupMP_G.existsTag(tag);
			else % numeric
				prop = pointer;
				PPAnalyzeGroupMP_G.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPAnalyzeGroupMP_G, POINTER) returns category of POINTER of PPAnalyzeGroupMP_G.
			%  CATEGORY = PR.GETPROPCATEGORY(PPAnalyzeGroupMP_G, POINTER) returns category of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PPAnalyzeGroupMP_G, POINTER) returns format of POINTER of PPAnalyzeGroupMP_G.
			%  FORMAT = PR.GETPROPFORMAT(PPAnalyzeGroupMP_G, POINTER) returns format of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPAnalyzeGroupMP_G, POINTER) returns description of POINTER of PPAnalyzeGroupMP_G.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPAnalyzeGroupMP_G, POINTER) returns description of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPAnalyzeGroupMP_G, POINTER) returns settings of POINTER of PPAnalyzeGroupMP_G.
			%  SETTINGS = PR.GETPROPSETTINGS(PPAnalyzeGroupMP_G, POINTER) returns settings of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPAnalyzeGroupMP_G.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPAnalyzeGroupMP_G.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPAnalyzeGroupMP_G, POINTER) returns the default value of POINTER of PPAnalyzeGroupMP_G.
			%  DEFAULT = PR.GETPROPDEFAULT(PPAnalyzeGroupMP_G, POINTER) returns the default value of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPAnalyzeGroupMP_G.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPAnalyzeGroupMP_G.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPAnalyzeGroupMP_G, POINTER) returns the conditioned default value of POINTER of PPAnalyzeGroupMP_G.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPAnalyzeGroupMP_G, POINTER) returns the conditioned default value of POINTER of PPAnalyzeGroupMP_G.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
			prop_default = PPAnalyzeGroupMP_G.conditioning(prop, PPAnalyzeGroupMP_G.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPAnalyzeGroupMP_G, PROP, VALUE) checks VALUE format for PROP of PPAnalyzeGroupMP_G.
			%  CHECK = PR.CHECKPROP(PPAnalyzeGroupMP_G, PROP, VALUE) checks VALUE format for PROP of PPAnalyzeGroupMP_G.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  Element.CHECKPROP(PPAnalyzeGroupMP_G, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPAnalyzeGroupMP_G.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			%  PR.CHECKPROP(PPAnalyzeGroupMP_G, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPAnalyzeGroupMP_G.
			%   Error id: [BRAPH2:PPAnalyzeGroupMP_G:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPAnalyzeGroupMP_G:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPAnalyzeGroupMP_G.getPropTag(prop) ' (' PPAnalyzeGroupMP_G.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPAnalyzeGroupMP_G(varargin)
			% PPAnalyzeGroupMP_G() creates a plot property graph mp.
			%
			% PPAnalyzeGroupMP_G(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPAnalyzeGroupMP_G(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPAnalyzeGroupMP_G properties is:
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
			prop = PPAnalyzeGroupMP_G.getPropProp(pointer);
			
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
		    if ~check_graphics(pr.graph_btn, 'pushbutton') && ...
		            (isempty(pr.measure_tbl) || ~isgraphics(pr.measure_tbl, 'uitable'))
		        % graph button
		        pr.graph_btn = uicontrol( ...
		            'Style', 'pushbutton', ...
		            'Tag', 'pushbutton_value', ...
		            'Parent', pr.p, ...
		            'Units', 'normalized', ...
		            'String', 'Graph Data', ...
		            'TooltipString', 'Open a GUI for the graph data.', ...
		            'Position', [.79 .76 .2 .15], ...
		            'Visible', 'off', ...
		            'Callback', {@cb_graph_btn} ...
		            );
		        
		        pr.plot_type_adj = uicontrol(...
		            'Style', 'pushbutton', ...
		            'Parent', pr.p, ...
		            'Units', 'normalized', ...
		            'CData', imresize(imread('icon_plot_adj.png'), [40 40]), ...
		            'TooltipString', 'Open a plot for the adjacency matrix.', ...
		            'Position', [.01 .76 .2 .15], ...
		            'Visible', 'off', ...
		            'Callback', {@cb_plot_type_adj} ...
		            );
		        
		        pr.line_plot_tglbtn = uicontrol(...
		            'Style', 'pushbutton', ...
		            'Parent', pr.p, ...
		            'Units', 'normalized', ...
		            'CData', imresize(imread('icon_plot_lines.png'), [40 40]), ...
		            'TooltipString', 'Open a line plot for the measure.', ...
		            'Position', [.23 .76 .2 .15], ...
		            'Visible', 'off', ...
		            'Callback', {@cb_plot_type_line} ...
		            );
		        pr.mlist = [];
		        
		        pr.measure_tbl = uitable( ...
		            'Parent', pr.p, ...
		            'Visible', 'on', ...
		            'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
		            'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
		            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		            'ColumnEditable', [true false false false false], ...
		            'Visible', 'off', ...
		            'CellEditCallback', {@cb_measure_edit} ...
		            );
		        
		        % measure button
		        pr.measure_btn = uicontrol( ...
		            'Parent', pr.p, ...
		            'Style', 'pushbutton', ...
		            'Tag', 'measure_button', ...
		            'Units', 'normalized', ...
		            'String', 'Calculate Measures', ...
		            'TooltipString', 'Calculate Selected Measures', ...
		            'Position', [.01 .02 .48 .09], ...
		            'Visible', 'off', ...
		            'Callback', {@cb_measure_btn} ...
		            );
		        
		        pr.measure_plot_btn = uicontrol(...
		            'Parent', pr.p, ...
		            'Style', 'pushbutton', ...
		            'Tag', 'measure_plot_button', ...
		            'Units', 'normalized', ...
		            'String', 'Show Measures', ...
		            'TooltipString', 'Show Selected Measures', ...
		            'Position', [.51 .02 .48 .09], ...
		            'Visible', 'off', ...
		            'Callback', {@cb_measure_plot_btn} ...
		            );
		    end
		        
		        function cb_graph_btn(~, ~) % (src, event)
		        pr.cb_graph_value()
		        end
		        function cb_plot_type_adj(~, ~)
		        pr.cb_graph_adj_figure();
		        end
		        function cb_plot_type_line(~, ~)
		        pr.cb_graph_ui_figure();
		        end
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
		        % visible gui
		        set(pr.line_plot_tglbtn, 'Visible', 'off')
		        set(pr.graph_btn, 'Visible', 'off')
		        set(pr.plot_type_adj, 'Visible', 'off')
		        set(pr.measure_tbl, 'Visible', 'off')
		        set(pr.measure_btn, 'Visible', 'off')
		        set(pr.measure_plot_btn, 'Visible', 'off')
		        pr.graph = [];
		        pr.already_calculated = [];
		
		    else
		        graph = el.get(prop);
		        pr.graph = graph;
		        
		        % visible gui
		        set(pr.graph_btn, 'Visible', 'on')
		        set(pr.plot_type_adj, 'Visible', 'on')
		        set(pr.measure_tbl, 'Visible', 'on')
		        set(pr.measure_btn, 'Visible', 'on')
		        set(pr.measure_plot_btn, 'Visible', 'on')
		
		        if  ~isa(graph, 'NoValue') && isa(graph, 'Graph')
		            if isempty(pr.mlist)
		                pr.mlist = Graph.getCompatibleMeasureList(graph);
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
		
		        if ~check_graphics(pr.f_pg, 'figure')
		            set(pr.plot_type_adj, 'Enable', 'on');
		            set(pr.line_plot_tglbtn, 'Enable', 'on');
		        end        
		    end
		
		    function plot_type_rules()
		        if ~isempty(pr.graph) && ~contains(el.getClass(), 'WU') && ~isempty(pr.already_calculated) && any([pr.already_calculated{:}])
		            set(pr.line_plot_tglbtn, ...
		                    'Enable', 'on', ...
		                    'Visible', 'on');
		        else
		            set(pr.line_plot_tglbtn, ...
		                    'Enable', 'off', ...
		                    'Visible', 'off');
		        end
		    end
		   
		    plot_type_rules()
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
		        if ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
		            set(pr.measure_tbl, ...
		                'Units', 'normalized', ...
		                'Position', [.01 .13 .98 (Dh/(h+Dh)-.27)] ...
		                )
		        end
		        
		        pr.redraw@PlotProp('Height', (h + Dh)*1.5, varargin{:})
		    else
		        if ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
		            set(pr.measure_tbl, ...
		                'Units', 'normalized', ...
		                'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)], ...
		                'Visible', 'off' ...
		                )
		        end
		        pr.redraw@PlotProp(varargin{:})
		    end   
		end
		function cb_graph_value(pr)
		    %CB_GRAPH_VALUE executes callback for the pushbutton.
		    %
		    % CB_GRAPH_VALUE(PR) executes callback for the pushbutton.
		    %  It opens Graph GUI.
		    %
		    % See also cb_measure_value.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    pr.update()
		
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
		
		    N = ceil(sqrt(1));
		
		    x = (f_gr_x + f_gr_w) / screen_w + mod(1 - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
		    y = f_gr_y / screen_h;
		    w = f_gr_w / screen_w;
		    h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((1 - .5) / N)) / N / screen_h;
		
		
		    % TODO: check this part of the code once GUI is finalized
		    value = el.getr(prop);
		    if ~check_graphics(pr.f_g, 'figure')
		        if isa(value, 'NoValue')
		            pr.f_g = GUI( ...
		                'PE', el.getPropDefault(prop), ...
		                'POSITION', [x y w h], ...
		                'CLOSEREQ', false).draw();
		        else
		            pr.f_g = GUI( ...
		                'PE', el.get(prop), ...
		                'POSITION', [x y w h], ...
		                'CLOSEREQ', false).draw();
		        end
		    elseif  isequal(get(pr.f_g, 'Visible'), 'on')
		        gui = get(pr.f_g, 'UserData');
		        gui.cb_hide()
		    else
		        gui = get(pr.f_g, 'UserData');
		        gui.cb_bring_to_front()
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
		    graph = el.memorize(prop);
		    pr.mlist = Graph.getCompatibleMeasureList(graph);
		
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
		
		        measure = pr.mlist{i};
		
		        x = (f_gr_x + f_gr_w) / screen_w + mod(i - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
		        y = f_gr_y / screen_h;
		        w = f_gr_w / screen_w;
		        h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((i - .5) / N)) / N / screen_h;
		
		        result_measure = graph.getMeasure(measure);
		        plot_permission = true;
		        tmp_gui = [];
		        for j = 1:length(pr.f_m)
		            tmp_f = pr.f_m{j};
		            if check_graphics(tmp_f,'figure')
		                tmp_gui = get(tmp_f, 'UserData');
		                if isequal(tmp_gui.get('pe').get('el').get('id'), result_measure.get('ID'))
		                    plot_permission = false;
		                    if isequal(get(tmp_f, 'Visible'), 'on')
		                        % hide
		                        set(tmp_f, 'Visible', 'off')
		                    else
		                        % show
		                        figure(tmp_f)
		                        set(tmp_f, ...
		                            'Visible', 'on', ...
		                            'WindowState', 'normal' ...
		                            )
		                    end
		                end
		            end            
		        end
		        if plot_permission
		            pr.f_m{f_count} = GUI('pe', result_measure, 'POSITION', [x y w h], 'CLOSEREQ', false).draw();
		            f_count = f_count + 1;
		        end
		    end
		end
		function cb_measure_calc(pr)
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    graph = el.memorize(prop);
		    pr.mlist = Graph.getCompatibleMeasureList(graph);
		
		    measure_short_list = pr.mlist(pr.selected);
		
		    % calculate
		    if pr.get('WAITBAR')
		        wb = waitbar(0, ['Calculating ' num2str(length(pr.selected))  ' measures ...'], 'Name', BRAPH2.NAME);
		        set_braph2icon(wb)
		    end
		
		    for i = 1:length(pr.mlist)
		        if ~ismember(pr.mlist(i), measure_short_list)
		            continue;
		        end
		
		        measure = pr.mlist{i};
		        if pr.get('WAITBAR')
		            waitbar(.1 + .20 * i / length(pr.selected), wb, ['Calculating measure ' measure ]);
		        end
		        result_measure = graph.getMeasure(measure);
		        result_measure.memorize('M');
		        pr.already_calculated{i} = 1;
		    end
		
		    % close progress bar
		    if pr.get('WAITBAR')
		        close(wb)
		    end
		    pr.update();
		end
		function cb_graph_ui_figure(pr)
		    % CB_GRAPH_UI_FIGURE draws a new figure to manage a plot graph.
		    %
		    % CB_GRAPH_UI_FIGURE(PR) draws a new figure to manage a plot graph and
		    % sets the figure to F_PG property of PPGRAPH
		    %
		    % see also cb_graph_value, cb_measure_value.
		
		    f_pg = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
		    f_ba_x = Plot.x0(f_pg, 'pixels');
		    f_ba_y = Plot.y0(f_pg, 'pixels');
		    f_ba_w = Plot.w(f_pg, 'pixels');
		    f_ba_h = Plot.h(f_pg, 'pixels');
		
		    screen_x = Plot.x0(0, 'pixels');
		    screen_y = Plot.y0(0, 'pixels');
		    screen_w = Plot.w(0, 'pixels');
		    screen_h = Plot.h(0, 'pixels');
		
		    x = f_ba_x + f_ba_w;
		    h = f_ba_h / 1.5;
		    y = f_ba_y + f_ba_h - h;
		    w = screen_w - x;
		    
		    if isempty(pr.f_pg) || ~check_graphics(pr.f_pg, 'figure')
		        pr.f_pg = figure( ...
		            'NumberTitle', 'off', ...
		            'Units', 'normalized', ...
		            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		            'CloseRequestFcn', {@cb_f_pg_close} ...
		            );
		        set_braph2icon(pr.f_pg)
		        menu_about = BRAPH2.add_menu_about(pr.f_pg);
		        set(pr.f_pg, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
		
		        el = pr.get('EL');
		        prop = pr.get('PROP');        
		        group = el.get('GR').get('ID');
		
		        if isa(el, 'AnalyzeGroup_ST_MP_BUD')
		            x_range = el.get('DENSITIES');
		            x_title = 'DENSITIES';
		        elseif isa(el, 'AnalyzeGroup_ST_MP_BUT')
		            x_range = el.get('THRESHOLDS');
		            x_title = 'THRESHOLDS';
		        end
		        
		         pg = PlotAnalysisMPLine( ... 
		                'Graph', pr.graph, ...
		                'X', x_range, ...
		                'PLOTTITLE', ['Analysis of group ' group], ...
		                'XLABEL', x_title ...
		                );
		            
		            pg.draw('Parent', pr.f_pg)
		            set(pr.f_pg, 'UserData', pg);
		            
		            f_settings = pg.settings();
		            set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
		            f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
		            f_settings.OuterPosition(2) = f_ba_y/screen_h;     
		    elseif isequal(get(pr.f_pg, 'Visible'), 'on')
		        gui = get(pr.f_pg, 'UserData');
		        gui.cb_hide()
		    else
		        gui = get(pr.f_pg, 'UserData');
		        gui.cb_bring_to_front()
		    end
		
		        function cb_f_pg_close(~, ~)
		            delete(pr.f_pg);
		            pr.update()
		        end
		
		    pr.update()
		end
		function cb_graph_adj_figure(pr)
		    f_pg = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
		    f_ba_x = Plot.x0(f_pg, 'pixels');
		    f_ba_y = Plot.y0(f_pg, 'pixels');
		    f_ba_w = Plot.w(f_pg, 'pixels');
		    f_ba_h = Plot.h(f_pg, 'pixels');
		
		    screen_x = Plot.x0(0, 'pixels');
		    screen_y = Plot.y0(0, 'pixels');
		    screen_w = Plot.w(0, 'pixels');
		    screen_h = Plot.h(0, 'pixels');
		
		    x = f_ba_x + f_ba_w;
		    h = f_ba_h / 1.5;
		    y = f_ba_y + f_ba_h - h;
		    w = screen_w - x;
		
		    if isempty(pr.f_adj) || ~check_graphics(pr.f_adj, 'figure')
		        pr.f_adj = figure( ...
		            'NumberTitle', 'off', ...
		            'Units', 'normalized', ...
		            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		            'CloseRequestFcn', {@cb_f_adj_close} ...
		            );
		        set_braph2icon(pr.f_adj)
		        menu_about = BRAPH2.add_menu_about(pr.f_adj);
		        set(pr.f_adj, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
		        el = pr.get('EL');
		        prop = pr.get('PROP');
		        g = el.get(prop);
		        
		        g_dict = IndexedDictionary( ...
		            'it_class', g.getClass() ...
		            );
		        g_dict.add(g);
		        pg = PlotAdjacencyMatrix('G_DICT', g_dict);
		        
		        pg.draw('Parent', pr.f_adj)
		        set(pr.f_adj, 'UserData', pg);
		
		        f_settings = pg.settings();
		        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
		        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
		        f_settings.OuterPosition(2) = f_ba_y/screen_h;
		    elseif isequal(get(pr.f_adj, 'Visible'), 'on')
		        gui = get(pr.f_adj, 'UserData');
		        gui.cb_hide()
		    else
		        gui = get(pr.f_adj, 'UserData');
		        gui.cb_bring_to_front()
		    end
		
		        function cb_f_adj_close(~, ~)
		            delete(pr.f_adj);
		            pr.update()
		        end
		
		    pr.update()
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
		    graph = el.memorize(prop);
		    measure_dict = graph.get('M_DICT');
		    measure_list = pr.mlist;
		    calculated_list = cell(size(measure_list, 2), 1);
		    if measure_dict.length() > 0
		        for i = 1:length(measure_list)
		            measure = measure_list{i};
		            if any(cellfun(@(x) isequal(measure, x.get('ID')), measure_dict.getItems()))
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
		    state = 0; % calculated
		    for i = 1:length(plot_prop_children)
		        pp_c = plot_prop_children(i);
		        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
		            if isequal(pp_c.Enable, 'off')
		                state = 1;  % not calculated
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
		    
		    % bring to front graph class
		    if check_graphics(pr.f_g, 'figure')
		        gui = get(pr.f_g, 'UserData');
		        pe = gui.get('PE');
		        pe.cb_bring_to_front()
		    end
		    
		    % bring to front measure class guis
		    for i = 1:length(pr.f_m)
		        f_m = pr.f_m{i};
		        if check_graphics(f_m, 'figure')
		            gui = get(f_m, 'UserData');
		            pe = gui.get('PE');
		            pe.cb_bring_to_front()
		        end
		    end
		    
		    % bring to front plot graph
		    if check_graphics(pr.f_pg, 'figure')
		        gui = get(pr.f_pg, 'UserData');
		        gui.cb_bring_to_front()
		    end  
		    if check_graphics(pr.f_adj, 'figure')
		        gui = get(pr.f_adj, 'UserData');
		        gui.cb_bring_to_front()
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
		    
		    % bring to front graph class
		    if check_graphics(pr.f_g, 'figure')
		        gui = get(pr.f_g, 'UserData');
		        pe = gui.get('PE');
		        pe.cb_hide()
		    end
		    
		    % bring to front measure class guis
		    for i = 1:length(pr.f_m)
		        f_m = pr.f_m{i};
		        if check_graphics(f_m, 'figure')
		            gui = get(f_m, 'UserData');
		            pe = gui.get('PE');
		            pe.cb_hide()
		        end
		    end
		    
		    % bring to front plot graph
		    if check_graphics(pr.f_pg, 'figure')
		        gui = get(pr.f_pg, 'UserData');
		        gui.cb_hide();
		    end 
		    if check_graphics(pr.f_adj, 'figure')
		        gui = get(pr.f_adj, 'UserData');
		        gui.cb_hide();
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
		    
		    % close plot graph figure
		    if ~isempty(pr.f_pg) && check_graphics(pr.f_pg, 'figure')
		        delete(pr.f_pg);
		    end
		    
		    
		    % close adj graph figure
		    if ~isempty(pr.f_adj) && check_graphics(pr.f_adj, 'figure')
		        delete(pr.f_adj);
		    end 
		    
		    % close graph class
		    if check_graphics(pr.f_g, 'figure')
		        gui = get(pr.f_g, 'UserData');
		        pe = gui.get('PE');
		        pe.cb_close()
		    end
		end
	end
end
