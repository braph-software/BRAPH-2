classdef PlotPropSmartVector < PlotProp
	% PlotPropSmartVector is a plot of a string property.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PlotPropString plots a STRING property of an element in an edit field.
	% It works for all categories.
	% It has the following additional properties:
	% - ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).
	% - ''EditHeight'' with the height of the edit field in characters.
	%
	% The list of PlotPropSmartVector properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%  <strong>8</strong> <strong>lines</strong> 	LINES (metadata, option) switches between single- and multi-line edit field.
	%  <strong>9</strong> <strong>editheight</strong> 	EDITHEIGHT (metadata, scalar) is the height of the edit field in characters.
	%  <strong>10</strong> <strong>max</strong> 	MAX (metadata, scalar) is the max value acceptable as input
	%  <strong>11</strong> <strong>min</strong> 	MIN (metadata, scalar) is the min value acceptable as input
	%  <strong>12</strong> <strong>step</strong> 	STEP (metadata, scalar) is the step value
	%
	% PlotPropSmartVector methods (constructor):
	% PlotPropSmartVector - constructor
	%
	% PlotPropSmartVector methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property string/error.
	%  existsProp - checks whether property exists in plot property string/error.
	%  getPropNumber - returns the property number of plot property string.
	%  getProps - returns the property list of plot property string.
	%  getDescription - returns the description of the plot property string.
	%  getName - returns the name of the plot property string.
	%  getClass - returns the class of the plot property string.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotPropSmartVector methods:
	%  warning_creator - tor/warning_creator is a function.
	%  cb_edit_value - ector/cb_edit_value is a function.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permissions of the edit field.
	%  draw - draws the panel of the string property.
	%  cb_button_del - ector/cb_button_del is a function.
	%  cb_button_calc - ctor/cb_button_calc is a function.
	%  cb_button_cb - Vector/cb_button_cb is a function.
	%  set_settings - Vector/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - tVector/cb_close_fs is a function.
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
	% PlotPropSmartVector methods (operators):
	%  isequal - determines whether two PlotPropSmartVector are equal (values, locked)
	%
	% PlotPropSmartVector methods (display):
	%  tostring - string with information about the PlotPropSmartVector
	%  disp - displays information about the PlotPropSmartVector
	%  tree - displays the element of PlotPropSmartVector
	%
	% PlotPropSmartVector method (element list):
	%  getElementList - returns a list with all subelements of PlotPropSmartVector
	%
	% PlotPropSmartVector method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotPropSmartVector
	%
	% PlotPropSmartVector method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotPropSmartVector
	%
	% PlotPropSmartVector methods (copy):
	%  copy - copies the PlotPropSmartVector
	%  deepclone - deep-clones the PlotPropSmartVector
	%  clone - clones the PlotPropSmartVector
	%
	% PlotPropSmartVector methods (inspection, Static):
	%  getClass - returns PlotPropSmartVector
	%  getName - returns the name of PlotPropSmartVector
	%  getDescription - returns the description of PlotPropSmartVector
	%  getProps - returns the property list of PlotPropSmartVector
	%  getPropNumber - returns the property number of PlotPropSmartVector
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
	% PlotPropSmartVector methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotPropSmartVector methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotPropSmartVector methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotPropSmartVector methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotPropSmartVector properties (Constant).
	%  LINES - 8
	%  LINES_TAG - 'lines'
	%  LINES_CATEGORY - 'm'
	%  LINES_FORMAT - 'op'
	%  EDITHEIGHT - 9
	%  EDITHEIGHT_TAG - 'editheight'
	%  EDITHEIGHT_CATEGORY - 'm'
	%  EDITHEIGHT_FORMAT - 'nn'
	%  MAX - 10
	%  MAX_TAG - 'max'
	%  MAX_CATEGORY - 'm'
	%  MAX_FORMAT - 'nn'
	%  MIN - 11
	%  MIN_TAG - 'min'
	%  MIN_CATEGORY - 'm'
	%  MIN_FORMAT - 'nn'
	%  STEP - 12
	%  STEP_TAG - 'step'
	%  STEP_CATEGORY - 'm'
	%  STEP_FORMAT - 'nn'
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
	% See also GUI, PlotElement, PlotProp, PlotPropText.
	
	properties (Access = private) % element properties
		p
		edit_value
	end
	properties (Constant) % properties
		LINES = PlotProp.getPropNumber() + 1;
		LINES_TAG = 'lines';
		LINES_CATEGORY = Category.METADATA;
		LINES_FORMAT = Format.OPTION;
		
		EDITHEIGHT = PlotProp.getPropNumber() + 2;
		EDITHEIGHT_TAG = 'editheight';
		EDITHEIGHT_CATEGORY = Category.METADATA;
		EDITHEIGHT_FORMAT = Format.SCALAR;
		
		MAX = PlotProp.getPropNumber() + 3;
		MAX_TAG = 'max';
		MAX_CATEGORY = Category.METADATA;
		MAX_FORMAT = Format.SCALAR;
		
		MIN = PlotProp.getPropNumber() + 4;
		MIN_TAG = 'min';
		MIN_CATEGORY = Category.METADATA;
		MIN_FORMAT = Format.SCALAR;
		
		STEP = PlotProp.getPropNumber() + 5;
		STEP_TAG = 'step';
		STEP_CATEGORY = Category.METADATA;
		STEP_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property string.
			%
			% CLASS = PlotPropSmartVector.GETCLASS() returns the class 'PlotPropSmartVector'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property string PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotPropSmartVector') returns 'PlotPropSmartVector'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotPropSmartVector';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property string.
			%
			% NAME = PlotPropSmartVector.GETNAME() returns the name of the 'plot property string'.
			%  Plot Property String.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property string PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotPropSmartVector') returns the name of 'PlotPropSmartVector'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property String';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property string.
			%
			% STR = PlotPropSmartVector.GETDESCRIPTION() returns the description of the 'plot property string'.
			%  which is:
			%
			%  PlotPropString plots a STRING property of an element in an edit field.
			%  It works for all categories.
			%  It has the following additional properties:
			%  - ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).
			%  - ''EditHeight'' with the height of the edit field in characters.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property string PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotPropSmartVector') returns the description of 'PlotPropSmartVector'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotPropString plots a STRING property of an element in an edit field.' ...
				'It works for all categories.' ...
				'It has the following additional properties:' ...
				'- ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).' ...
				'- ''EditHeight'' with the height of the edit field in characters.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property string.
			%
			% PROPS = PlotPropSmartVector.GETPROPS() returns the property list of plot property string.
			%
			% PROPS = PlotPropSmartVector.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property string PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotPropSmartVector'[, CATEGORY]) returns the property list of 'PlotPropSmartVector'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotProp.getProps(Category.METADATA)
						PlotPropSmartVector.LINES
						PlotPropSmartVector.EDITHEIGHT
						PlotPropSmartVector.MAX
						PlotPropSmartVector.MIN
						PlotPropSmartVector.STEP
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
						PlotPropSmartVector.LINES
						PlotPropSmartVector.EDITHEIGHT
						PlotPropSmartVector.MAX
						PlotPropSmartVector.MIN
						PlotPropSmartVector.STEP
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property string.
			%
			% N = PlotPropSmartVector.GETPROPNUMBER() returns the property number of plot property string.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property string PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotPropSmartVector') returns the property number of 'PlotPropSmartVector'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 12;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property string/error.
			%
			% CHECK = PlotPropSmartVector.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotPropSmartVector, PROP) checks whether PROP exists for PlotPropSmartVector.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  Element.EXISTSPROP(PlotPropSmartVector, PROP) throws error if PROP does NOT exist for PlotPropSmartVector.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12 ]);
			else
				assert( ...
					PlotPropSmartVector.existsProp(prop), ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotPropSmartVector.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property string/error.
			%
			% CHECK = PlotPropSmartVector.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotPropSmartVector, TAG) checks whether TAG exists for PlotPropSmartVector.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  Element.EXISTSTAG(PlotPropSmartVector, TAG) throws error if TAG does NOT exist for PlotPropSmartVector.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropsmartvector_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar'  'lines'  'editheight'  'max'  'min'  'step' };
				
				check = any(strcmpi(tag, plotpropsmartvector_tag_list));
			else
				assert( ...
					PlotPropSmartVector.existsTag(tag), ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotPropSmartVector'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotPropSmartVector, POINTER) returns property number of POINTER of PlotPropSmartVector.
			%  PROPERTY = PR.GETPROPPROP(PlotPropSmartVector, POINTER) returns property number of POINTER of PlotPropSmartVector.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropsmartvector_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar'  'lines'  'editheight'  'max'  'min'  'step' };
				
				tag = pointer;
				PlotPropSmartVector.existsTag(tag);
				
				prop = find(strcmpi(tag, plotpropsmartvector_tag_list));
			else % numeric
				prop = pointer;
				PlotPropSmartVector.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotPropSmartVector, POINTER) returns tag of POINTER of PlotPropSmartVector.
			%  TAG = PR.GETPROPTAG(PlotPropSmartVector, POINTER) returns tag of POINTER of PlotPropSmartVector.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotPropSmartVector.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotPropSmartVector.existsProp(prop);
				
				switch prop
					case PlotPropSmartVector.LINES
						tag = PlotPropSmartVector.LINES_TAG;
					case PlotPropSmartVector.EDITHEIGHT
						tag = PlotPropSmartVector.EDITHEIGHT_TAG;
					case PlotPropSmartVector.MAX
						tag = PlotPropSmartVector.MAX_TAG;
					case PlotPropSmartVector.MIN
						tag = PlotPropSmartVector.MIN_TAG;
					case PlotPropSmartVector.STEP
						tag = PlotPropSmartVector.STEP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotPropSmartVector, POINTER) returns category of POINTER of PlotPropSmartVector.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotPropSmartVector, POINTER) returns category of POINTER of PlotPropSmartVector.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					prop_category = PlotPropSmartVector.LINES_CATEGORY;
				case PlotPropSmartVector.EDITHEIGHT
					prop_category = PlotPropSmartVector.EDITHEIGHT_CATEGORY;
				case PlotPropSmartVector.MAX
					prop_category = PlotPropSmartVector.MAX_CATEGORY;
				case PlotPropSmartVector.MIN
					prop_category = PlotPropSmartVector.MIN_CATEGORY;
				case PlotPropSmartVector.STEP
					prop_category = PlotPropSmartVector.STEP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotPropSmartVector, POINTER) returns format of POINTER of PlotPropSmartVector.
			%  FORMAT = PR.GETPROPFORMAT(PlotPropSmartVector, POINTER) returns format of POINTER of PlotPropSmartVector.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					prop_format = PlotPropSmartVector.LINES_FORMAT;
				case PlotPropSmartVector.EDITHEIGHT
					prop_format = PlotPropSmartVector.EDITHEIGHT_FORMAT;
				case PlotPropSmartVector.MAX
					prop_format = PlotPropSmartVector.MAX_FORMAT;
				case PlotPropSmartVector.MIN
					prop_format = PlotPropSmartVector.MIN_FORMAT;
				case PlotPropSmartVector.STEP
					prop_format = PlotPropSmartVector.STEP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotPropSmartVector, POINTER) returns description of POINTER of PlotPropSmartVector.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotPropSmartVector, POINTER) returns description of POINTER of PlotPropSmartVector.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					prop_description = 'LINES (metadata, option) switches between single- and multi-line edit field.';
				case PlotPropSmartVector.EDITHEIGHT
					prop_description = 'EDITHEIGHT (metadata, scalar) is the height of the edit field in characters.';
				case PlotPropSmartVector.MAX
					prop_description = 'MAX (metadata, scalar) is the max value acceptable as input';
				case PlotPropSmartVector.MIN
					prop_description = 'MIN (metadata, scalar) is the min value acceptable as input';
				case PlotPropSmartVector.STEP
					prop_description = 'STEP (metadata, scalar) is the step value';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotPropSmartVector, POINTER) returns settings of POINTER of PlotPropSmartVector.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotPropSmartVector, POINTER) returns settings of POINTER of PlotPropSmartVector.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					prop_settings = {'single', 'multi'};
				case PlotPropSmartVector.EDITHEIGHT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotPropSmartVector.MAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotPropSmartVector.MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotPropSmartVector.STEP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotPropSmartVector.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropSmartVector.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotPropSmartVector, POINTER) returns the default value of POINTER of PlotPropSmartVector.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotPropSmartVector, POINTER) returns the default value of POINTER of PlotPropSmartVector.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					prop_default = Format.getFormatDefault(Format.OPTION, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.EDITHEIGHT
					prop_default = 1.5;
				case PlotPropSmartVector.MAX
					prop_default = Format.getFormatDefault(Format.SCALAR, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.MIN
					prop_default = Format.getFormatDefault(Format.SCALAR, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.STEP
					prop_default = Format.getFormatDefault(Format.SCALAR, PlotPropSmartVector.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotPropSmartVector.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropSmartVector.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotPropSmartVector, POINTER) returns the conditioned default value of POINTER of PlotPropSmartVector.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotPropSmartVector, POINTER) returns the conditioned default value of POINTER of PlotPropSmartVector.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			prop_default = PlotPropSmartVector.conditioning(prop, PlotPropSmartVector.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotPropSmartVector, PROP, VALUE) checks VALUE format for PROP of PlotPropSmartVector.
			%  CHECK = PR.CHECKPROP(PlotPropSmartVector, PROP, VALUE) checks VALUE format for PROP of PlotPropSmartVector.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  Element.CHECKPROP(PlotPropSmartVector, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropSmartVector.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			%  PR.CHECKPROP(PlotPropSmartVector, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropSmartVector.
			%   Error id: [BRAPH2:PlotPropSmartVector:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotPropSmartVector.getPropProp(pointer);
			
			switch prop
				case PlotPropSmartVector.LINES
					check = Format.checkFormat(Format.OPTION, value, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.EDITHEIGHT
					check = Format.checkFormat(Format.SCALAR, value, PlotPropSmartVector.getPropSettings(prop));
					if check
						check = value > 0;
					end
				case PlotPropSmartVector.MAX
					check = Format.checkFormat(Format.SCALAR, value, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.MIN
					check = Format.checkFormat(Format.SCALAR, value, PlotPropSmartVector.getPropSettings(prop));
				case PlotPropSmartVector.STEP
					check = Format.checkFormat(Format.SCALAR, value, PlotPropSmartVector.getPropSettings(prop));
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropSmartVector:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotPropSmartVector.getPropTag(prop) ' (' PlotPropSmartVector.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotPropSmartVector(varargin)
			% PlotPropSmartVector() creates a plot property string.
			%
			% PlotPropSmartVector(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotPropSmartVector(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotPropSmartVector properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%  <strong>8</strong> <strong>lines</strong> 	LINES (metadata, option) switches between single- and multi-line edit field.
			%  <strong>9</strong> <strong>editheight</strong> 	EDITHEIGHT (metadata, scalar) is the height of the edit field in characters.
			%  <strong>10</strong> <strong>max</strong> 	MAX (metadata, scalar) is the max value acceptable as input
			%  <strong>11</strong> <strong>min</strong> 	MIN (metadata, scalar) is the min value acceptable as input
			%  <strong>12</strong> <strong>step</strong> 	STEP (metadata, scalar) is the step value
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotProp(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotPropSmartVector.getPropProp(pointer);
			
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
		    %DRAW draws the panel of the string property.
		    %
		    % DRAW(PR) draws the panel of the string property.
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
		    
		    if ~check_graphics(pr.edit_value, 'edit')
		        pr.edit_value = uicontrol( ...
		            'Style', 'edit', ...
		            'Tag', 'edit_value', ...
		            'Parent', pr.p, ...
		            'Units', 'normalized', ...
		            'HorizontalAlignment', 'left', ...
		            'BackgroundColor', 'w', ...
		            'Min', 0, ...
		            'Max', find(strcmpi(pr.getPropSettings('LINES'), pr.get('LINES'))), ...
		            'FontUnits', BRAPH2.FONTUNITS, ...
		            'FontSize', BRAPH2.FONTSIZE, ...
		            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		            'Callback', {@cb_edit_value} ...
		            );
		    end
		
		    function cb_edit_value(~, ~) % (src, event)
		        pr.cb_edit_value()
		    end
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content and permissions of the edit field.
		    %
		    % UPDATE(PR) updates the content and permissions of the edit field.
		    %
		    % See also draw, resize, refresh, PlotElement.
		
		    update@PlotProp(pr)
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');   
		    
		    switch el.getPropCategory(prop)        
		        case Category.METADATA
		            raw_tmp = el.get(prop);
		            if iscell(raw_tmp)
		                raw_tmp = cell2mat(raw_tmp);
		            end
		            tmp_value = num2str(raw_tmp);
		            tmp_value = regexprep(tmp_value, '\s+', ' ');
		            set(pr.edit_value, 'String', tmp_value)
		
		        case {Category.PARAMETER, Category.DATA}
		            raw_tmp = el.get(prop);
		            if iscell(raw_tmp)
		                raw_tmp = cell2mat(raw_tmp);
		            end
		            tmp_value = num2str(raw_tmp);
		            tmp_value = regexprep(tmp_value, '\s+', ' ');
		            set(pr.edit_value, 'String', tmp_value)
		
		            value = el.getr(prop);
		            if isa(value, 'Callback')
		                set(pr.edit_value, 'Enable', pr.get('ENABLE'))
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
		    
		    h = pr.get('EDITHEIGHT');
		    
		    set(pr.edit_value, 'Position', [.01 .33/(1.83+h) .98 h/(1.83+h)])
		    
		    pr.redraw@PlotProp('Height', 1.83 + h, varargin{:})
		end
		function cb_edit_value(pr)
		    %CB_EDIT_VALUE executes callback for the edit value.
		    %
		    % CB_EDIT_VALUE(PR) executes callback for the edit value.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    % get string value
		    tmp_value = get(pr.edit_value, 'String');
		    max = pr.get('max');
		    min = pr.get('min');
		
		    allowedChars = "0123456789,:. ";
		    pat = characterListPattern(allowedChars); % pattern
		    result = extract(tmp_value, pat); % cell array
		    try 
		        if any(contains(result, ':'))
		             proccessed_value = eval([result{:}]);
		        else
		            tmp_r = convertCharsToStrings([result{:}]);
		            tmp_r = strsplit(tmp_r, {' ', ','});
		            holder = [];
		            for i = 1:length(tmp_r)
		                holder = [holder str2double(tmp_r{i})]; %#ok<AGROW>
		            end  
		            proccessed_value = holder;
		        end
		
		        proccessed_value = proccessed_value(proccessed_value <= max);
		        proccessed_value = proccessed_value(proccessed_value >= min);
		    catch e
		        pr.warning_creator(e.message);
		    end
		    % set rvector
		    if isnumeric(proccessed_value)
		        try            
		            el.set(prop, proccessed_value);
		            % set other analysis if needed
		            
		        catch e
		            pr.warning_creator(e.message);
		        end
		    else
		        % do nothing
		    end
		
		    pr.update()
		end
		function warning_creator(pr, text)
		    warning_figure = warndlg(text);
		    set_braph2icon(warning_figure);
		end
	end
end
