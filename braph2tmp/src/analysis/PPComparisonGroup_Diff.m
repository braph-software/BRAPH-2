classdef PPComparisonGroup_Diff < PlotPropMatrix
	% PPComparisonGroup_Diff is a plot of comparison group difference.
	% It is a subclass of <a href="matlab:help PlotPropMatrix">PlotPropMatrix</a>.
	%
	% PPComparisonGroupDiff plots a Comparison Group Difference.
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
	%
	% The list of PPComparisonGroup_Diff properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPComparisonGroup_Diff methods (constructor):
	% PPComparisonGroup_Diff - constructor
	%
	% PPComparisonGroup_Diff methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property of comparison group difference/error.
	%  existsProp - checks whether property exists in plot property of comparison group difference/error.
	%  getPropNumber - returns the property number of plot property of comparison group difference.
	%  getProps - returns the property list of plot property of comparison group difference.
	%  getDescription - returns the description of the plot property of comparison group difference.
	%  getName - returns the name of the plot property of comparison group difference.
	%  getClass - returns the class of the plot property of comparison group difference.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPComparisonGroup_Diff methods:
	%  get_button_condition - N returns the calculate button state.
	%  cb_close - closes the figure.
	%  cb_hide - hides the figure and its settings figure.
	%  cb_bring_to_front - brings to front the figure and its settings figure.
	%  cb_brain_view_fig - Diff/cb_brain_view_fig is a function.
	%  redraw - redraws the element graphical panel.
	%  update - updates the content of the property graphical panel.
	%  draw - draws the idict for group ensemble property graphical panel.
	%  cb_matrix_value - p_Diff/cb_matrix_value is a function.
	%  cb_button_del - oup_Diff/cb_button_del is a function.
	%  cb_button_calc - up_Diff/cb_button_calc is a function.
	%  cb_button_cb - roup_Diff/cb_button_cb is a function.
	%  set_settings - roup_Diff/set_settings is a function.
	%  cb_close_fs - Group_Diff/cb_close_fs is a function.
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
	% PPComparisonGroup_Diff methods (operators):
	%  isequal - determines whether two PPComparisonGroup_Diff are equal (values, locked)
	%
	% PPComparisonGroup_Diff methods (display):
	%  tostring - string with information about the PPComparisonGroup_Diff
	%  disp - displays information about the PPComparisonGroup_Diff
	%  tree - displays the element of PPComparisonGroup_Diff
	%
	% PPComparisonGroup_Diff method (element list):
	%  getElementList - returns a list with all subelements of PPComparisonGroup_Diff
	%
	% PPComparisonGroup_Diff method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPComparisonGroup_Diff
	%
	% PPComparisonGroup_Diff method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPComparisonGroup_Diff
	%
	% PPComparisonGroup_Diff methods (copy):
	%  copy - copies the PPComparisonGroup_Diff
	%  deepclone - deep-clones the PPComparisonGroup_Diff
	%  clone - clones the PPComparisonGroup_Diff
	%
	% PPComparisonGroup_Diff methods (inspection, Static):
	%  getClass - returns PPComparisonGroup_Diff
	%  getName - returns the name of PPComparisonGroup_Diff
	%  getDescription - returns the description of PPComparisonGroup_Diff
	%  getProps - returns the property list of PPComparisonGroup_Diff
	%  getPropNumber - returns the property number of PPComparisonGroup_Diff
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
	% PPComparisonGroup_Diff methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPComparisonGroup_Diff methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPComparisonGroup_Diff methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPComparisonGroup_Diff methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPComparisonGroup_Diff properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, PlotPropMatrix, ComparisonGroup..
	
	properties (Access = private) % element properties
		p
		comparison_tbl
		slider
		second_slider
		slider_text
		second_slider_text
		f_br
		br_type
		brain_view_btn
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property of comparison group difference.
			%
			% CLASS = PPComparisonGroup_Diff.GETCLASS() returns the class 'PPComparisonGroup_Diff'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property of comparison group difference PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPComparisonGroup_Diff') returns 'PPComparisonGroup_Diff'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPComparisonGroup_Diff';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property of comparison group difference.
			%
			% NAME = PPComparisonGroup_Diff.GETNAME() returns the name of the 'plot property of comparison group difference'.
			%  Plot Property Of Comparison Group Difference.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property of comparison group difference PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPComparisonGroup_Diff') returns the name of 'PPComparisonGroup_Diff'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Of Comparison Group Difference';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property of comparison group difference.
			%
			% STR = PPComparisonGroup_Diff.GETDESCRIPTION() returns the description of the 'plot property of comparison group difference'.
			%  which is:
			%
			%  PPComparisonGroupDiff plots a Comparison Group Difference.
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property of comparison group difference PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPComparisonGroup_Diff') returns the description of 'PPComparisonGroup_Diff'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPComparisonGroupDiff plots a Comparison Group Difference.' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property of comparison group difference.
			%
			% PROPS = PPComparisonGroup_Diff.GETPROPS() returns the property list of plot property of comparison group difference.
			%
			% PROPS = PPComparisonGroup_Diff.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property of comparison group difference PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPComparisonGroup_Diff'[, CATEGORY]) returns the property list of 'PPComparisonGroup_Diff'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropMatrix.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropMatrix.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropMatrix.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropMatrix.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropMatrix.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropMatrix.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropMatrix.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property of comparison group difference.
			%
			% N = PPComparisonGroup_Diff.GETPROPNUMBER() returns the property number of plot property of comparison group difference.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property of comparison group difference PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPComparisonGroup_Diff') returns the property number of 'PPComparisonGroup_Diff'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property of comparison group difference/error.
			%
			% CHECK = PPComparisonGroup_Diff.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPComparisonGroup_Diff, PROP) checks whether PROP exists for PPComparisonGroup_Diff.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  Element.EXISTSPROP(PPComparisonGroup_Diff, PROP) throws error if PROP does NOT exist for PPComparisonGroup_Diff.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPComparisonGroup_Diff.existsProp(prop), ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPComparisonGroup_Diff.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property of comparison group difference/error.
			%
			% CHECK = PPComparisonGroup_Diff.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPComparisonGroup_Diff, TAG) checks whether TAG exists for PPComparisonGroup_Diff.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  Element.EXISTSTAG(PPComparisonGroup_Diff, TAG) throws error if TAG does NOT exist for PPComparisonGroup_Diff.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppcomparisongroup_diff_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppcomparisongroup_diff_tag_list));
			else
				assert( ...
					PPComparisonGroup_Diff.existsTag(tag), ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPComparisonGroup_Diff'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPComparisonGroup_Diff, POINTER) returns property number of POINTER of PPComparisonGroup_Diff.
			%  PROPERTY = PR.GETPROPPROP(PPComparisonGroup_Diff, POINTER) returns property number of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppcomparisongroup_diff_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPComparisonGroup_Diff.existsTag(tag);
				
				prop = find(strcmpi(tag, ppcomparisongroup_diff_tag_list));
			else % numeric
				prop = pointer;
				PPComparisonGroup_Diff.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPComparisonGroup_Diff, POINTER) returns tag of POINTER of PPComparisonGroup_Diff.
			%  TAG = PR.GETPROPTAG(PPComparisonGroup_Diff, POINTER) returns tag of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPComparisonGroup_Diff.existsTag(tag);
			else % numeric
				prop = pointer;
				PPComparisonGroup_Diff.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropMatrix(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPComparisonGroup_Diff, POINTER) returns category of POINTER of PPComparisonGroup_Diff.
			%  CATEGORY = PR.GETPROPCATEGORY(PPComparisonGroup_Diff, POINTER) returns category of POINTER of PPComparisonGroup_Diff.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropMatrix(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPComparisonGroup_Diff, POINTER) returns format of POINTER of PPComparisonGroup_Diff.
			%  FORMAT = PR.GETPROPFORMAT(PPComparisonGroup_Diff, POINTER) returns format of POINTER of PPComparisonGroup_Diff.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropMatrix(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPComparisonGroup_Diff, POINTER) returns description of POINTER of PPComparisonGroup_Diff.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPComparisonGroup_Diff, POINTER) returns description of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotPropMatrix(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPComparisonGroup_Diff, POINTER) returns settings of POINTER of PPComparisonGroup_Diff.
			%  SETTINGS = PR.GETPROPSETTINGS(PPComparisonGroup_Diff, POINTER) returns settings of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPComparisonGroup_Diff.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPComparisonGroup_Diff.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPComparisonGroup_Diff, POINTER) returns the default value of POINTER of PPComparisonGroup_Diff.
			%  DEFAULT = PR.GETPROPDEFAULT(PPComparisonGroup_Diff, POINTER) returns the default value of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPComparisonGroup_Diff.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPComparisonGroup_Diff.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPComparisonGroup_Diff, POINTER) returns the conditioned default value of POINTER of PPComparisonGroup_Diff.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPComparisonGroup_Diff, POINTER) returns the conditioned default value of POINTER of PPComparisonGroup_Diff.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			prop_default = PPComparisonGroup_Diff.conditioning(prop, PPComparisonGroup_Diff.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPComparisonGroup_Diff, PROP, VALUE) checks VALUE format for PROP of PPComparisonGroup_Diff.
			%  CHECK = PR.CHECKPROP(PPComparisonGroup_Diff, PROP, VALUE) checks VALUE format for PROP of PPComparisonGroup_Diff.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  Element.CHECKPROP(PPComparisonGroup_Diff, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPComparisonGroup_Diff.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			%  PR.CHECKPROP(PPComparisonGroup_Diff, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPComparisonGroup_Diff.
			%   Error id: [BRAPH2:PPComparisonGroup_Diff:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropMatrix(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPComparisonGroup_Diff:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPComparisonGroup_Diff.getPropTag(prop) ' (' PPComparisonGroup_Diff.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPComparisonGroup_Diff(varargin)
			% PPComparisonGroup_Diff() creates a plot property of comparison group difference.
			%
			% PPComparisonGroup_Diff(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPComparisonGroup_Diff(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPComparisonGroup_Diff properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropMatrix(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPComparisonGroup_Diff.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropMatrix.getPropNumber()
						value = conditioning@PlotPropMatrix(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the idict for group ensemble property graphical panel.
		    %
		    % DRAW(PR) draws the idict property graphical panel.
		    %
		    % H = DRAW(PR) returns a handle to the idict property graphical panel.
		    %
		    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
		    %  panel with custom property-value couples.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle to the brain surface graphical panel H.
		    %
		    % see also update, redraw, refresh, settings, uipanel, isgraphics.
		
		    pr.p = draw@PlotPropMatrix(pr, varargin{:});
		
		    % retrieves the handle of the table
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uitable')
		            pr.comparison_tbl = children(i);
		        end
		    end
		
		    % create panel with slider
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    if isa(value, 'NoValue')
		        % declare slider
		        pr.second_slider = uicontrol( ...
		            'Parent', pr.p, ...
		            'Style', 'slider', ...
		            'Callback', {@cb_slider_2}, ...
		            'Visible', 'off');
		        pr.second_slider_text = uicontrol(...
		            'Parent', pr.p, ...
		            'Style', 'text', ...
		            'Units', 'characters', ...
		            'Visible', 'off');
		        pr.slider = uicontrol( ...
		            'Parent', pr.p, ...
		            'Style', 'slider', ...
		            'Callback', {@cb_slider}, ...
		            'Visible', 'off');
		        pr.slider_text = uicontrol(...
		            'Parent', pr.p, ...
		            'Style', 'text', ...
		            'Visible', 'off');
		    else
		        L = size(value, 1);
		        L2 = size(value, 2);
		        layer_dim_element = el.get('C').get('A1').get('G');
		        if layer_dim_element.getGraphType() == 4 && layer_dim_element.getPropNumber() > 9 % mp bud
		            L2 =  size(layer_dim_element.get(10), 1);
		            L = L/L2;
		        elseif layer_dim_element.getGraphType() == 4 && layer_dim_element.getPropNumber() <= 9 %mp wu
		            L2 = size(layer_dim_element.get('b'), 2);
		            L = L/L2;
		        elseif layer_dim_element.getGraphType() == 2 && layer_dim_element.getPropNumber() > 9 %mg bud
		            L2 = size(layer_dim_element.get(10), 1);
		            L = L/L2;
		        else % wu
		            L2 = 1;
		        end
		
		        map_multiplier = 100;
		
		        if L == 1
		            Ll = 1;
		        else
		            Ll = L-1;
		        end
		
		        if L2 == 1
		            nn = 1;
		        else
		            nn = L2-1;
		        end
		
		        % set on first layer
		        if L > 1
		            pr.slider = uicontrol( ...
		                'Parent', pr.p, ...
		                'Style', 'slider', ...
		                'Units', 'characters', ...
		                'Visible', 'off', ...
		                'Value', 1 / map_multiplier, ...
		                'Min', 1 / map_multiplier, ...
		                'Max', L / map_multiplier, ...
		                'SliderStep', [map_multiplier/(Ll*map_multiplier) map_multiplier/(Ll*map_multiplier)] , ...
		                'Callback', {@cb_slider} ...
		                );
		            pr.slider_text = uicontrol(...
		                'Parent', pr.p, ...
		                'Style', 'text', ...
		                'Units', 'characters', ...
		                'HorizontalAlignment', 'center', ...
		                'Visible', 'off', ...
		                'FontUnits', BRAPH2.FONTUNITS, ...
		                'FontSize', BRAPH2.FONTSIZE, ...
		                'FontWeight', 'normal', ...
		                'String', '', ...
		                'BackgroundColor', pr.get('BKGCOLOR') ...
		                );
		        end
		
		        if L2 > 1
		            pr.second_slider = uicontrol( ...
		                'Parent', pr.p, ...
		                'Style', 'slider', ...
		                'Units', 'characters', ...
		                'Value', 1 / map_multiplier, ...
		                'Min', 1 / map_multiplier, ...
		                'Max', L2 / map_multiplier, ...
		                'SliderStep', [map_multiplier/(nn*map_multiplier) map_multiplier/(nn*map_multiplier)] , ...
		                'Callback', {@cb_slider_2} ...
		                );
		            pr.second_slider_text = uicontrol(...
		                'Parent', pr.p, ...
		                'Style', 'text', ...
		                'Units', 'characters', ...
		                'HorizontalAlignment', 'center', ...
		                'FontUnits', BRAPH2.FONTUNITS, ...
		                'FontSize', BRAPH2.FONTSIZE, ...
		                'FontWeight', 'normal', ...
		                'String', '', ...
		                'BackgroundColor', pr.get('BKGCOLOR') ...
		                );
		        end
		
		    end
		
		        function cb_slider(~, ~)
		            pr.update()
		        end
		        function cb_slider_2(~, ~)
		            pr.update()
		        end
		
		    if Measure.is_nodal(el.get('Measure'))
		        pr.brain_view_btn = uicontrol('Parent', pr.p, ...
		            'Style', 'pushbutton', ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'TooltipString', 'Open the comparison in a Brain View plot.', ...
		            'String', 'Plot Brain View', ...
		            'Position', [.02 .8 .2 .1], ...
		            'Callback', {@cb_brainview});
		    end
		
		        function cb_brainview (~, ~)
		            pr.cb_brain_view_fig();
		        end
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr, init_sliders)
		    %UPDATE updates the content of the property graphical panel.
		    %
		    % UPDATE(PR) updates the content of the property graphical panel.
		    %
		    % See also draw, redraw, refresh.
		
		    update@PlotProp(pr)
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    slider_tags = {'1'};
		    init_sliders = 1; %
		    if nargin > 1
		        init_sliders = 0;
		    end
		
		    if isa(value, 'NoValue')
		        % do nothing
		    else
		        if el.get('C').get('A1').getPropNumber() > 7
		            label = el.get('C').get('A1').getPropTag(8);
		            if strcmp(label, 'thresholds')
		                label = 'Threshold';
		            elseif strcmp(label, 'densities')
		                label = 'Density';
		            end
		            slider_tags = compose("%g", round(el.get('C').get('A1').get(8), 2));
		        else
		            label = 'Weighted';
		            set(pr.slider, ...
		                'Enable', 'off');
		        end
		        fdr_q_value = 0.05;
		        fdr_style = [1 1 0];
		        L = size(value, 1);
		        L2 = size(value, 2);
		        layer_dim_element = el.get('C').get('A1').get('G');
		        if layer_dim_element.getGraphType() == 4 && layer_dim_element.getPropNumber() > 9 % mp bud
		            L2 = size(layer_dim_element.get(10), 2);
		            L = L/L2;
		        elseif layer_dim_element.getGraphType() == 4 && layer_dim_element.getPropNumber() <= 9 %mp wu
		            L2 = size(layer_dim_element.get('b'), 2);
		            L = L/L2;
		        elseif layer_dim_element.getGraphType() == 2 && layer_dim_element.getPropNumber() > 9 %mg bud
		            L2 = size(layer_dim_element.get(10), 1);
		            L = L/L2;
		        else % wu
		            L2 = 1;
		        end
		        map_multiplier = 100;
		
		        if L == 1
		            Ll=1;
		        else
		            Ll = L-1;
		        end
		
		        if L2 == 1
		            Ll2=1;
		        else
		            Ll2 = L2-1;
		        end
		
		        %get brain atlas
		        br_dict = el.get('C').get('A1').get('g').get('brainatlas').get('br_dict');
		        br_ids = cellfun(@(x) x.get('id'), br_dict.getItems(), 'UniformOutput', false);
		
		        % have to declare in case of refresh
		        if L2 > 1 && init_sliders
		            pr.second_slider = uicontrol( ...
		                'Parent', pr.p, ...
		                'Style', 'slider', ...
		                'Units', 'characters', ...
		                'Value', 1 / map_multiplier, ...
		                'Min', 1 / map_multiplier, ...
		                'Max', L2 / map_multiplier, ...
		                'SliderStep', [map_multiplier/(Ll2*map_multiplier) map_multiplier/(Ll2*map_multiplier)],  ...
		                'Callback', {@cb_slider_2} ...
		                );
		            pr.second_slider_text = uicontrol(...
		                'Parent', pr.p, ...
		                'Style', 'text', ...
		                'Units', 'characters', ...
		                'HorizontalAlignment', 'center', ...
		                'FontUnits', BRAPH2.FONTUNITS, ...
		                'FontSize', BRAPH2.FONTSIZE, ...
		                'FontWeight', 'normal', ...
		                'String', '', ...
		                'BackgroundColor', pr.get('BKGCOLOR') ...
		                );
		        end % set on first layer
		        if init_sliders && L > 1
		            pr.slider = uicontrol( ...
		                'Parent', pr.p, ...
		                'Style', 'slider', ...
		                'Units', 'characters', ...
		                'Visible', 'off', ...
		                'Value', 1 / map_multiplier, ...
		                'Min', 1 / map_multiplier, ...
		                'Max', L / map_multiplier, ...
		                'SliderStep', [map_multiplier/(Ll*map_multiplier) map_multiplier/(Ll*map_multiplier)], ...
		                'Callback', {@cb_slider} ...
		                );
		            pr.slider_text = uicontrol(...
		                'Parent', pr.p, ...
		                'Style', 'text', ...
		                'Units', 'characters', ...
		                'HorizontalAlignment', 'center', ...
		                'Visible', 'off', ...
		                'FontUnits', BRAPH2.FONTUNITS, ...
		                'FontSize', BRAPH2.FONTSIZE, ...
		                'FontWeight', 'normal', ...
		                'String', '', ...
		                'BackgroundColor', pr.get('BKGCOLOR') ...
		                );
		        end
		        if el.get('C').get('A1').get('g').getGraphType() == 4 && L == 1 && L2 > 1 % mp, wu
		            set(pr.slider_text, ...
		                'Visible', 'off', ...
		                'String', [label ' ' num2str(round(get(pr.slider, 'Value') * map_multiplier)) ': ' slider_tags{round(get(pr.slider, 'Value') * map_multiplier)}]);
		            set(pr.second_slider_text, ...
		                'String', ['Layer: ' num2str(round(get(pr.second_slider, 'Value') * map_multiplier))]);
		            tmp_value = value{round(get(pr.second_slider, 'Value') * map_multiplier), 1};
		            p1 = el.memorize('P1');
		            p2 = el.memorize('P2');
		            cil = el.memorize('cil');
		            ciu = el.memorize('ciu');
		            p1 = p1{round(get(pr.second_slider, 'Value') * map_multiplier), 1};
		            p2 = p2{round(get(pr.second_slider, 'Value') * map_multiplier), 1};
		            cil = cil{round(get(pr.second_slider, 'Value') * map_multiplier), 1};
		            ciu = ciu{round(get(pr.second_slider, 'Value') * map_multiplier), 1};
		            if Measure.is_nodal(el.get('measure'))
		                p1 = p1';
		                [~, mask] = fdr(p1, fdr_q_value);
		                mask = mask';
		            else
		                [~, mask] = fdr(p1, fdr_q_value);
		            end
		
		            tmp_value = num2cell(tmp_value);
		
		            for i = 1:size(tmp_value, 1)
		                for j = 1:size(tmp_value, 2)
		                    if mask(i, j)
		                        clr = dec2hex(round(fdr_style * 255), 2)';
		                        clr = ['#'; clr(:)]';
		
		                        tmp_value(i, j) = {strcat(...
		                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
		                            num2str(tmp_value{i, j}))};
		                    end
		                end
		            end
		
		            % rule column diff, p1, p2, cil, ciu
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_global(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'ColumnName', {'DIFF', 'P1', 'P2', 'CIU', 'CIL'}, ...
		                    'ColumnFormat', {'char',  'char', 'char', 'char', 'char'}, ...
		                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		                    'ColumnEditable', [false false false false false] ...
		                    );
		
		                full_value = cell(size(tmp_value, 1), 5);
		                for k = 1:size(tmp_value, 1)
		                    full_value{k, 1} = tmp_value{k};
		                    full_value{k, 2} = p1(k);
		                    full_value{k, 3} = p2(k);
		                    full_value{k, 4} = ciu(k);
		                    full_value{k, 5} = cil(k);
		                end
		
		                set(pr.comparison_tbl, 'Data', full_value)
		            else
		                set(pr.comparison_tbl, ...
		                    'Data', tmp_value, ...
		                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
		                    'ColumnEditable', false)
		            end
		
		            % rule atlas
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_binodal(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'RowName', br_ids)
		            end
		
		
		        elseif  el.get('C').get('A1').get('g').getGraphType() == 4 && L > 1 && L2 > 1 % mp, bud
		            set(pr.slider_text, ...
		                'String', [label ' ' num2str(round(get(pr.slider, 'Value') * map_multiplier)) ': ' slider_tags{round(get(pr.slider, 'Value') * map_multiplier)}]);
		            set(pr.second_slider_text, ...
		                'String', ['Layer: ' num2str(round(get(pr.second_slider, 'Value')) * map_multiplier)]);
		
		            % set p values mask
		            D_T = round(get(pr.slider, 'Value') * map_multiplier);
		            layer_sel = round(get(pr.second_slider, 'Value') * map_multiplier);
		            tmp_diff = L2-layer_sel;
		            tmp_value = value{D_T*L2-tmp_diff};
		            p1 = el.memorize('P1');
		            p2 = el.memorize('P2');
		            cil = el.memorize('cil');
		            ciu = el.memorize('ciu');
		            p1 = p1{D_T*L2-tmp_diff};
		            p2 = p2{D_T*L2-tmp_diff};
		            cil = cil{D_T*L2-tmp_diff};
		            ciu = ciu{D_T*L2-tmp_diff};
		
		            if Measure.is_nodal(el.get('measure'))
		                p1 = p1';
		                [~, mask] = fdr(p1, fdr_q_value);
		                mask = mask';
		            else
		                [~, mask] = fdr(p1, fdr_q_value);
		            end
		
		            tmp_value = num2cell(tmp_value);
		
		            for i = 1:size(tmp_value, 1)
		                for j = 1:size(tmp_value, 2)
		                    if mask(i, j)
		                        clr = dec2hex(round(fdr_style * 255), 2)';
		                        clr = ['#'; clr(:)]';
		
		                        tmp_value(i, j) = {strcat(...
		                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
		                            num2str(tmp_value{i, j}))};
		                    end
		                end
		            end
		
		            % rule column diff, p1, p2, cil, ciu
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_global(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'ColumnName', {'DIFF', 'P1', 'P2', 'CIU', 'CIL'}, ...
		                    'ColumnFormat', {'char',  'char', 'char', 'char', 'char'}, ...
		                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		                    'ColumnEditable', [false false false false false] ...
		                    );
		
		                full_value = cell(size(tmp_value, 1), 5);
		                for k = 1:size(tmp_value, 1)
		                    full_value{k, 1} = tmp_value{k};
		                    full_value{k, 2} = p1(k);
		                    full_value{k, 3} = p2(k);
		                    full_value{k, 4} = ciu(k);
		                    full_value{k, 5} = cil(k);
		                end
		
		                set(pr.comparison_tbl, 'Data', full_value)
		            else
		                set(pr.comparison_tbl, ...
		                    'Data', tmp_value, ...
		                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
		                    'ColumnEditable', false)
		            end
		
		            % rule atlas
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_binodal(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'RowName', br_ids)
		            end
		        else % unilayer bud, but, wu
		            set(pr.slider_text, ...
		                'String', [label ' ' num2str(round(get(pr.slider, 'Value') * map_multiplier)) ': ' slider_tags{round(get(pr.slider, 'Value') * map_multiplier)}]);
		
		            % set p values mask
		            if ~isempty(pr.slider)
		                inner_choose = round(get(pr.slider, 'Value') * map_multiplier);
		            else
		                inner_choose = 1;
		            end
		            tmp_value = value{inner_choose};
		            p1 = el.memorize('P1');
		            p2 = el.memorize('P2');
		            cil = el.memorize('cil');
		            ciu = el.memorize('ciu');
		            p1 = p1{inner_choose};
		            p2 = p2{inner_choose};
		            cil = cil{inner_choose};
		            ciu = ciu{inner_choose};
		
		            if Measure.is_nodal(el.get('measure'))
		                p1 = p1';
		                [~, mask] = fdr(p1, fdr_q_value);
		                mask = mask';
		            else
		                [~, mask] = fdr(p1, fdr_q_value);
		            end
		
		            tmp_value = num2cell(tmp_value);
		
		            for i = 1:size(tmp_value, 1)
		                for j = 1:size(tmp_value, 2)
		                    if mask(i, j)
		                        clr = dec2hex(round(fdr_style * 255), 2)';
		                        clr = ['#'; clr(:)]';
		
		                        tmp_value(i, j) = {strcat(...
		                            ['<html><body bgcolor="' clr '" text="#000000" width="100px">'], ...
		                            num2str(tmp_value{i, j}))};
		                    end
		                end
		            end
		
		            % rule column diff, p1, p2, cil, ciu
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_global(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'ColumnName', {'DIFF', 'P1', 'P2', 'CIU', 'CIL'}, ...
		                    'ColumnFormat', {'char',  'char', 'char', 'char', 'char'}, ...
		                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		                    'ColumnEditable', [false false false false false] ...
		                    );
		
		                full_value = cell(size(tmp_value, 1), 5);
		                for k = 1:size(tmp_value, 1)
		                    full_value{k, 1} = tmp_value{k};
		                    full_value{k, 2} = p1(k);
		                    full_value{k, 3} = p2(k);
		                    full_value{k, 4} = ciu(k);
		                    full_value{k, 5} = cil(k);
		                end
		
		                set(pr.comparison_tbl, 'Data', full_value)
		            else
		                set(pr.comparison_tbl, ...
		                    'Data', tmp_value, ...
		                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
		                    'ColumnEditable', false)
		            end
		
		            if Measure.is_nodal(el.get('Measure')) || Measure.is_binodal(el.get('Measure'))
		                set(pr.comparison_tbl, ...
		                    'RowName', br_ids)
		            end
		        end
		
		    end
		
		    value = el.getr(prop);
		    if isa(value, 'Callback')
		        set(pr.comparison_tbl, ...
		            'Enable', pr.get('ENABLE'), ...
		            'ColumnEditable', false ...
		            )
		    end
		        function cb_slider(~, ~)
		            pr.update(1)
		        end
		        function cb_slider_2(~, ~)
		            pr.update(1)
		        end
		end
		function redraw(pr, varargin)
		    %REDRAW redraws the element graphical panel.
		    %
		    % REDRAW(PR) redraws the plot PR.
		    %
		    % REDRAW(PR, 'Height', HEIGHT) sets the height of PR (by default HEIGHT=3.3).
		    %
		    % See also draw, update, refresh.
		
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
		    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
		
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.get(prop);
		    L = size(value, 1);
		
		    if el.get('C').get('A1').get('g').getGraphType() == 4
		        pr.redraw@PlotProp('Height', h + Sh + Sh + Th + Th + Dh, varargin{:})
		
		        if el.get('C').get('A1').get('g').getPropNumber() > 8 % bud,but
		            remove_space = 0;
		            visibility_switch = 'on';
		        else % wu
		            remove_space = .1;
		            visibility_switch = 'off';
		        end
		
		        if ~Measure.is_nodal(el.get('Measure'))
		            remove_space = remove_space +.1;
		        end
		
		        set(pr.slider, ...
		            'Units', 'normalized', ...
		            'Visible', visibility_switch, ...
		            'Position', [.01 (Sh+Th+Dh)/(h+Sh+Sh+Th+Th+Dh)-.1+remove_space .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		
		        set(pr.slider_text, ...
		            'Units', 'normalized', ...
		            'Visible', visibility_switch, ...
		            'Position', [.01 (Sh+Th+Th+Dh)/(h+Sh+Sh+Th+Th+Dh)-.1+remove_space .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		
		        set(pr.second_slider, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Dh)/(h+Sh+Sh+Th+Th+Dh)-.1+remove_space .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		
		        set(pr.second_slider_text, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Dh+Th)/(h+Sh+Sh+Th+Th+Dh)-.1+remove_space .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		
		        set(pr.comparison_tbl, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 (Dh/(h+Sh+Sh+Th+Th+Dh)-.1+remove_space)] ...
		            )
		    elseif L
		        pr.redraw@PlotProp('Height', h + Sh + Th + Dh, varargin{:})
		        if isempty(pr.slider)
		            change_up = 0.2;
		        else
		            change_up = 0;
		        end
		        set(pr.slider, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 Dh/(h+Sh+Th+Dh)-.2 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		            );
		
		        set(pr.slider_text, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Th+Dh)/(h+Sh+Th+Dh)-.2 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		            );
		
		        set(pr.comparison_tbl, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.2+change_up)] ...
		            )
		    else
		        pr.redraw@PlotProp(varargin{:})
		    end
		    if ~pr.get_button_condition
		        set(pr.slider, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.slider_text, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.comparison_tbl, ...
		            'Visible', 'off' ...
		            )
		        if Measure.is_nodal(el.get('Measure'))
		            set(pr.brain_view_btn, ...
		                'Visible', 'off' ...
		                )
		        end
		    else
		        if Measure.is_nodal(el.get('Measure'))
		            set(pr.brain_view_btn, ...
		                'Visible', 'on' ...
		                )
		        end
		
		    end
		end
		function cb_brain_view_fig(pr)
		    f_pg = ancestor(pr.p, 'Figure');
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
		    
		    if isempty(pr.f_br) || ~check_graphics(pr.f_br, 'figure')
		        pr.f_br = figure( ...
		            'NumberTitle', 'off', ...
		            'Units', 'normalized', ...
		            'Toolbar', 'figure', ...
		            'DockControls', 'off', ...
		            'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')], ...
		            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		            'CloseRequestFcn', {@cb_f_br_close} ...
		            );
		        set_braph2icon(pr.f_br)
		        menu_about = BRAPH2.add_menu_about(pr.f_br);
		        
		        ui_toolbar = findall(pr.f_br, 'Tag', 'FigureToolBar');
		        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
		        delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
		        
		        el = pr.get('EL');
		        prop = pr.get('PROP');
		        
		        g = el.get('c').get('a1').get('g');
		        
		        if isequal(g.getClass(), 'MultigraphBUD') || isequal(g.getClass(), 'MultiplexBUD')
		            type = 'Densities';
		        elseif isequal(g.getClass(), 'MultigraphBUT') || isequal(g.getClass(), 'MultiplexBUT')
		            type = 'Thresholds';
		        else
		            type = 'Weighted';
		        end
		        
		        prop_tag = el.getPropTag(prop);
		        
		        pbv = PlotBrainView('COMP', el, ...
		            'Atlas', g.get('brainatlas'), ...
		            'PROPTAG', prop_tag, ...
		            'Type', type);
		
		        
		        pbv.draw('Parent', pr.f_br );
		        f_settings = pbv.settings();
		        set(pr.f_br, 'UserData', pbv);
		        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
		        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
		        f_settings.OuterPosition(2) = f_ba_y/screen_h;
		    else
		        gui = get(pr.f_br, 'UserData');
		        gui.cb_bring_to_front()
		    end
		    
		    function cb_f_br_close(~, ~)
		        delete(pr.f_br);
		        pr.update()
		    end
		
		    pr.update()
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
		    
		    % bring to front plot graph
		    if check_graphics(pr.f_br, 'figure')
		        gui = get(pr.f_br, 'UserData');
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
		    
		    % bring to front plot graph
		    if check_graphics(pr.f_br, 'figure')
		        gui = get(pr.f_br, 'UserData');
		        gui.cb_hide();
		    end 
		
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure.
		    %
		    % CB_CLOSE(PR) closes the figure and its children figures.
		    %
		    % See also cb_bring_to_front, cd_hide.
		
		    % close adj graph figure
		    if ~isempty(pr.f_br) && check_graphics(pr.f_br, 'figure')
		        delete(pr.f_br);
		    end     
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
	end
end
