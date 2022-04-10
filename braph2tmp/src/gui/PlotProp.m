classdef PlotProp < Plot
	% PlotProp is a plot of a property.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% PlotProp plots a property of an element in a panel. 
	%  It contains a text with the prop tag and a tooltip with the prop description.
	%  For parameter and data callback, it also features a callback button.
	%  For results, it features calculate and delete buttons.
	%  It typically is employed in one of its derived forms, 
	%  where also the contents of the element property are shown.
	% 
	% Important notes:
	% 1. PlotProp is intimately connected with GUI (cb_button_cb) and 
	%  PlotElement (update, redraw).
	% 2. The method redraw() isused internally by PlotElement
	%  and typically does not need to be explicitly called in children of PlotProp, 
	%  while update() is typically called in callbacks to update the contents.
	% 3. Children of PlotProp should implement the methods:
	%   - draw() to initially create the panel and its graphical objects
	%   - update() to update the information content of the panel and of the element
	%   - redraw() to resize the panel and reposition its graphical objcts
	% 
	% CONSTRUCTOR - To construct a PlotProp use the constructor:
	% 
	%     pr = Plot(''EL'', <element>, ''PROP'', prop);
	%     pr = Plot(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');
	%     
	% DRAW - To create the initial graphical objects in the property panel 
	%  (title text and buttons), call pr.draw():
	% 
	%     p = pr.<strong>draw</strong>();
	%     p = pr.<strong>draw</strong>(''Parent'', pp);
	% 
	%  It is also possible to use pr.draw() to get the property panel handle
	%   and to set its properties (as in the case of Plot).
	% 
	% UPDATE - Updates the information content of the panel and of the element.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PlotElement when needed.
	% 
	% REDRAW - Resizes the panel and repositions its graphical objcts.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PlotElement when needed.
	% 
	% % % % REFRESH - Updates and resizes the panel and also its parent and siblings.
	% % % %   Typically, it does not need to be called explicitly.
	% % % %   It is internally called by PlotElement when needed.
	%
	% The list of PlotProp properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PlotProp methods (constructor):
	% PlotProp - constructor
	%
	% PlotProp methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property/error.
	%  existsProp - checks whether property exists in plot property/error.
	%  getPropNumber - returns the property number of plot property.
	%  getProps - returns the property list of plot property.
	%  getDescription - returns the description of the plot property.
	%  getName - returns the name of the plot property.
	%  getClass - returns the class of the plot property.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotProp methods:
	%  cb_button_del - tton_del is a function.
	%  cb_button_calc - ton_calc is a function.
	%  cb_button_cb - utton_cb is a function.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws the property panel.
	%  set_settings - settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - close_fs is a function.
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
	% PlotProp methods (operators):
	%  isequal - determines whether two PlotProp are equal (values, locked)
	%
	% PlotProp methods (display):
	%  tostring - string with information about the PlotProp
	%  disp - displays information about the PlotProp
	%  tree - displays the element of PlotProp
	%
	% PlotProp method (element list):
	%  getElementList - returns a list with all subelements of PlotProp
	%
	% PlotProp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotProp
	%
	% PlotProp method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotProp
	%
	% PlotProp methods (copy):
	%  copy - copies the PlotProp
	%  deepclone - deep-clones the PlotProp
	%  clone - clones the PlotProp
	%
	% PlotProp methods (inspection, Static):
	%  getClass - returns PlotProp
	%  getName - returns the name of PlotProp
	%  getDescription - returns the description of PlotProp
	%  getProps - returns the property list of PlotProp
	%  getPropNumber - returns the property number of PlotProp
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
	% PlotProp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotProp methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotProp methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotProp methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotProp properties (Constant).
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
	% See also GUI, PlotElement.
	
	properties (Access = private) % element properties
		p % panel (it is h_panel in Plot)
		text_tag
		button_cb % only for PARAMETER and DATA
		button_calc % only for RESULT
		button_del % only for RESULT
	end
	properties (Constant) % properties
		EL = Plot.getPropNumber() + 1;
		EL_TAG = 'el';
		EL_CATEGORY = Category.METADATA;
		EL_FORMAT = Format.ITEM;
		
		PROP = Plot.getPropNumber() + 2;
		PROP_TAG = 'prop';
		PROP_CATEGORY = Category.DATA;
		PROP_FORMAT = Format.SCALAR;
		
		TITLE = Plot.getPropNumber() + 3;
		TITLE_TAG = 'title';
		TITLE_CATEGORY = Category.METADATA;
		TITLE_FORMAT = Format.STRING;
		
		ENABLE = Plot.getPropNumber() + 4;
		ENABLE_TAG = 'enable';
		ENABLE_CATEGORY = Category.METADATA;
		ENABLE_FORMAT = Format.OPTION;
		
		WAITBAR = Plot.getPropNumber() + 5;
		WAITBAR_TAG = 'waitbar';
		WAITBAR_CATEGORY = Category.METADATA;
		WAITBAR_FORMAT = Format.LOGICAL;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property.
			%
			% CLASS = PlotProp.GETCLASS() returns the class 'PlotProp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotProp') returns 'PlotProp'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotProp';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property.
			%
			% NAME = PlotProp.GETNAME() returns the name of the 'plot property'.
			%  Plot Property.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotProp') returns the name of 'PlotProp'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property.
			%
			% STR = PlotProp.GETDESCRIPTION() returns the description of the 'plot property'.
			%  which is:
			%
			%  PlotProp plots a property of an element in a panel. 
			%   It contains a text with the prop tag and a tooltip with the prop description.
			%   For parameter and data callback, it also features a callback button.
			%   For results, it features calculate and delete buttons.
			%   It typically is employed in one of its derived forms, 
			%   where also the contents of the element property are shown.
			%  
			%  Important notes:
			%  1. PlotProp is intimately connected with GUI (cb_button_cb) and 
			%   PlotElement (update, redraw).
			%  2. The method redraw() isused internally by PlotElement
			%   and typically does not need to be explicitly called in children of PlotProp, 
			%   while update() is typically called in callbacks to update the contents.
			%  3. Children of PlotProp should implement the methods:
			%    - draw() to initially create the panel and its graphical objects
			%    - update() to update the information content of the panel and of the element
			%    - redraw() to resize the panel and reposition its graphical objcts
			%  
			%  CONSTRUCTOR - To construct a PlotProp use the constructor:
			%  
			%      pr = Plot(''EL'', <element>, ''PROP'', prop);
			%      pr = Plot(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');
			%      
			%  DRAW - To create the initial graphical objects in the property panel 
			%   (title text and buttons), call pr.draw():
			%  
			%      p = pr.<strong>draw</strong>();
			%      p = pr.<strong>draw</strong>(''Parent'', pp);
			%  
			%   It is also possible to use pr.draw() to get the property panel handle
			%    and to set its properties (as in the case of Plot).
			%  
			%  UPDATE - Updates the information content of the panel and of the element.
			%    Typically, it does not need to be called explicitly.
			%    It is internally called by PlotElement when needed.
			%  
			%  REDRAW - Resizes the panel and repositions its graphical objcts.
			%    Typically, it does not need to be called explicitly.
			%    It is internally called by PlotElement when needed.
			%  
			%  % % % REFRESH - Updates and resizes the panel and also its parent and siblings.
			%  % % %   Typically, it does not need to be called explicitly.
			%  % % %   It is internally called by PlotElement when needed.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotProp') returns the description of 'PlotProp'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotProp plots a property of an element in a panel. ' ...
				' It contains a text with the prop tag and a tooltip with the prop description.' ...
				' For parameter and data callback, it also features a callback button.' ...
				' For results, it features calculate and delete buttons.' ...
				' It typically is employed in one of its derived forms, ' ...
				' where also the contents of the element property are shown.' ...
				'' ...
				'Important notes:' ...
				'1. PlotProp is intimately connected with GUI (cb_button_cb) and ' ...
				' PlotElement (update, redraw).' ...
				'2. The method redraw() isused internally by PlotElement' ...
				' and typically does not need to be explicitly called in children of PlotProp, ' ...
				' while update() is typically called in callbacks to update the contents.' ...
				'3. Children of PlotProp should implement the methods:' ...
				'  - draw() to initially create the panel and its graphical objects' ...
				'  - update() to update the information content of the panel and of the element' ...
				'  - redraw() to resize the panel and reposition its graphical objcts' ...
				'' ...
				'CONSTRUCTOR - To construct a PlotProp use the constructor:' ...
				'' ...
				'    pr = Plot(''EL'', <element>, ''PROP'', prop);' ...
				'    pr = Plot(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');' ...
				'    ' ...
				'DRAW - To create the initial graphical objects in the property panel ' ...
				' (title text and buttons), call pr.draw():' ...
				'' ...
				'    p = pr.<strong>draw</strong>();' ...
				'    p = pr.<strong>draw</strong>(''Parent'', pp);' ...
				'' ...
				' It is also possible to use pr.draw() to get the property panel handle' ...
				'  and to set its properties (as in the case of Plot).' ...
				'' ...
				'UPDATE - Updates the information content of the panel and of the element.' ...
				'  Typically, it does not need to be called explicitly.' ...
				'  It is internally called by PlotElement when needed.' ...
				'' ...
				'REDRAW - Resizes the panel and repositions its graphical objcts.' ...
				'  Typically, it does not need to be called explicitly.' ...
				'  It is internally called by PlotElement when needed.' ...
				'' ...
				'% % % REFRESH - Updates and resizes the panel and also its parent and siblings.' ...
				'% % %   Typically, it does not need to be called explicitly.' ...
				'% % %   It is internally called by PlotElement when needed.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property.
			%
			% PROPS = PlotProp.GETPROPS() returns the property list of plot property.
			%
			% PROPS = PlotProp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotProp'[, CATEGORY]) returns the property list of 'PlotProp'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotProp.EL
						PlotProp.TITLE
						PlotProp.ENABLE
						PlotProp.WAITBAR
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotProp.PROP
						];
				case Category.RESULT
					prop_list = [
						Plot.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						Plot.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Plot.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Plot.getProps()
						PlotProp.EL
						PlotProp.PROP
						PlotProp.TITLE
						PlotProp.ENABLE
						PlotProp.WAITBAR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property.
			%
			% N = PlotProp.GETPROPNUMBER() returns the property number of plot property.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotProp') returns the property number of 'PlotProp'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property/error.
			%
			% CHECK = PlotProp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotProp, PROP) checks whether PROP exists for PlotProp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  Element.EXISTSPROP(PlotProp, PROP) throws error if PROP does NOT exist for PlotProp.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PlotProp.existsProp(prop), ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotProp.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property/error.
			%
			% CHECK = PlotProp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotProp, TAG) checks whether TAG exists for PlotProp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  Element.EXISTSTAG(PlotProp, TAG) throws error if TAG does NOT exist for PlotProp.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotprop_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, plotprop_tag_list));
			else
				assert( ...
					PlotProp.existsTag(tag), ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotProp'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotProp, POINTER) returns property number of POINTER of PlotProp.
			%  PROPERTY = PR.GETPROPPROP(PlotProp, POINTER) returns property number of POINTER of PlotProp.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotprop_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PlotProp.existsTag(tag);
				
				prop = find(strcmpi(tag, plotprop_tag_list));
			else % numeric
				prop = pointer;
				PlotProp.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotProp, POINTER) returns tag of POINTER of PlotProp.
			%  TAG = PR.GETPROPTAG(PlotProp, POINTER) returns tag of POINTER of PlotProp.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotProp.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotProp.existsProp(prop);
				
				switch prop
					case PlotProp.EL
						tag = PlotProp.EL_TAG;
					case PlotProp.PROP
						tag = PlotProp.PROP_TAG;
					case PlotProp.TITLE
						tag = PlotProp.TITLE_TAG;
					case PlotProp.ENABLE
						tag = PlotProp.ENABLE_TAG;
					case PlotProp.WAITBAR
						tag = PlotProp.WAITBAR_TAG;
					otherwise
						tag = getPropTag@Plot(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotProp, POINTER) returns category of POINTER of PlotProp.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotProp, POINTER) returns category of POINTER of PlotProp.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					prop_category = PlotProp.EL_CATEGORY;
				case PlotProp.PROP
					prop_category = PlotProp.PROP_CATEGORY;
				case PlotProp.TITLE
					prop_category = PlotProp.TITLE_CATEGORY;
				case PlotProp.ENABLE
					prop_category = PlotProp.ENABLE_CATEGORY;
				case PlotProp.WAITBAR
					prop_category = PlotProp.WAITBAR_CATEGORY;
				otherwise
					prop_category = getPropCategory@Plot(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PlotProp, POINTER) returns format of POINTER of PlotProp.
			%  FORMAT = PR.GETPROPFORMAT(PlotProp, POINTER) returns format of POINTER of PlotProp.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					prop_format = PlotProp.EL_FORMAT;
				case PlotProp.PROP
					prop_format = PlotProp.PROP_FORMAT;
				case PlotProp.TITLE
					prop_format = PlotProp.TITLE_FORMAT;
				case PlotProp.ENABLE
					prop_format = PlotProp.ENABLE_FORMAT;
				case PlotProp.WAITBAR
					prop_format = PlotProp.WAITBAR_FORMAT;
				otherwise
					prop_format = getPropFormat@Plot(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotProp, POINTER) returns description of POINTER of PlotProp.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotProp, POINTER) returns description of POINTER of PlotProp.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					prop_description = 'EL (metadata, item) is the element.';
				case PlotProp.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PlotProp.TITLE
					prop_description = 'TITLE (metadata, string) is the property title.';
				case PlotProp.ENABLE
					prop_description = 'ENABLE (metadata, option) switches between off and inactive fields.';
				case PlotProp.WAITBAR
					prop_description = 'WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.';
				otherwise
					prop_description = getPropDescription@Plot(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotProp, POINTER) returns settings of POINTER of PlotProp.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotProp, POINTER) returns settings of POINTER of PlotProp.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotProp.PROP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotProp.TITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotProp.ENABLE
					prop_settings = {'inactive' 'off'};
				case PlotProp.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotProp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotProp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotProp, POINTER) returns the default value of POINTER of PlotProp.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotProp, POINTER) returns the default value of POINTER of PlotProp.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PlotProp.getPropSettings(prop));
				case PlotProp.PROP
					prop_default = Format.getFormatDefault(Format.SCALAR, PlotProp.getPropSettings(prop));
				case PlotProp.TITLE
					prop_default = Format.getFormatDefault(Format.STRING, PlotProp.getPropSettings(prop));
				case PlotProp.ENABLE
					prop_default = Format.getFormatDefault(Format.OPTION, PlotProp.getPropSettings(prop));
				case PlotProp.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, PlotProp.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotProp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotProp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotProp, POINTER) returns the conditioned default value of POINTER of PlotProp.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotProp, POINTER) returns the conditioned default value of POINTER of PlotProp.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotProp.getPropProp(pointer);
			
			prop_default = PlotProp.conditioning(prop, PlotProp.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotProp, PROP, VALUE) checks VALUE format for PROP of PlotProp.
			%  CHECK = PR.CHECKPROP(PlotProp, PROP, VALUE) checks VALUE format for PROP of PlotProp.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotProp:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  Element.CHECKPROP(PlotProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotProp.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			%  PR.CHECKPROP(PlotProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotProp.
			%   Error id: [BRAPH2:PlotProp:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				case PlotProp.EL
					check = Format.checkFormat(Format.ITEM, value, PlotProp.getPropSettings(prop));
				case PlotProp.PROP
					check = Format.checkFormat(Format.SCALAR, value, PlotProp.getPropSettings(prop));
				case PlotProp.TITLE
					check = Format.checkFormat(Format.STRING, value, PlotProp.getPropSettings(prop));
				case PlotProp.ENABLE
					check = Format.checkFormat(Format.OPTION, value, PlotProp.getPropSettings(prop));
				case PlotProp.WAITBAR
					check = Format.checkFormat(Format.LOGICAL, value, PlotProp.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotProp:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotProp.getPropTag(prop) ' (' PlotProp.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotProp(varargin)
			% PlotProp() creates a plot property.
			%
			% PlotProp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotProp(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotProp properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotProp.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Plot.getPropNumber()
						value = conditioning@Plot(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the property panel.
		    %
		    % DRAW(PL) draws the property panel with its title and
		    %  action buttons (callback for PARAMETER and DATA; calculate and
		    %  delete for RESULT).
		    %
		    % H = DRAW(PL) returns a handle to the property panel.
		    %
		    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the panel 
		    %  with custom Name-Value pairs.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle H of the panel.
		    %
		    % See also update, redraw, settings, uipanel.
		% % % disp('d') % FIXME
		
		    pr.p = draw@Plot(pr, varargin{:});
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    if ~check_graphics(pr.text_tag, 'text')
		        if ~isempty(pr.get('TITLE'))
		            pr_string_title = pr.get('TITLE');
		        else
		            pr_string_title = upper(el.getPropTag(prop));
		        end
		        
		        pr.text_tag =  uicontrol( ...
		            'Style', 'text', ...
		            'Tag', 'text_tag', ...
		            'Parent', pr.p, ...
		            'Units', 'characters', ...
		            'String', pr_string_title, ...
		            'HorizontalAlignment', 'left', ...
		            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
		            'BackgroundColor', pr.get('BKGCOLOR') ...
		            );
		    end
		
		    switch el.getPropCategory(prop)
		        case Category.METADATA
		            %
		            
		        case {Category.PARAMETER, Category.DATA}
		            if ~check_graphics(pr.button_cb, 'pushbutton')
		                pr.button_cb = uicontrol( ...
		                    'Style', 'pushbutton', ...
		                    'Tag', 'button_cb', ...
		                    'Parent', pr.p, ...
		                    'Units', 'characters', ...
		                    'String', '@', ...
		                    'HorizontalAlignment', 'left', ...
		                    'FontWeight', 'bold', ...
		                    'Callback', {@cb_button_cb} ...
		                    );
		            end
		            
		        case Category.RESULT
		            if ~check_graphics(pr.button_calc, 'pushbutton')
		                pr.button_calc = uicontrol( ...
		                    'Style', 'pushbutton', ...
		                    'Tag', 'button_calc', ...
		                    'Parent', pr.p, ...
		                    'Units', 'characters', ...
		                    'String', 'C', ...
		                    'HorizontalAlignment', 'left', ...
		                    'FontWeight', 'bold', ...
		                    'Tooltip', 'Calculate', ...
		                    'Callback', {@cb_button_calc} ...
		                    );
		            end
		            if ~check_graphics(pr.button_del, 'pushbutton')
		                pr.button_del = uicontrol( ...
		                    'Style', 'pushbutton', ...
		                    'Tag', 'button_del', ...
		                    'Parent', pr.p, ...
		                    'Units', 'characters', ...
		                    'String', 'D', ...
		                    'HorizontalAlignment', 'left', ...
		                    'FontWeight', 'bold', ...
		                    'Tooltip', 'Delete', ...
		                    'Callback', {@cb_button_del} ...
		                    );
		            end
		    end
		    
		    function cb_button_cb(~, ~) % (src, event)
		        pr.cb_button_cb()
		    end
		    function cb_button_calc(~, ~) % (src, event)
		        pr.cb_button_calc()
		    end
		    function cb_button_del(~, ~) % (src, event)
		        pr.cb_button_del()
		    end
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content of the property panel and its graphical objects.
		    %
		    % UPDATE(PL) updates the content of the property panel and its graphical objects.
		    %
		    % Important note:
		    % 1. UPDATE() is typically called internally by PlotElement and does not need 
		    %  to be explicitly called in children of PlotProp.
		    %
		    % See also draw, redraw, PlotElement.
		% % % disp('u') % FIXME
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    switch el.getPropCategory(prop)
		        case Category.METADATA
		            %
		
		        case {Category.PARAMETER, Category.DATA}
		            value = el.getr(prop);
		            if isa(value, 'Callback')
		                set(pr.button_cb, ...
		                    'Tooltip', value.tostring(), ...
		                    'Visible', 'on' ...
		                    )
		            else
		                set(pr.button_cb, ...
		                    'Visible', 'off' ...
		                    )
		            end
		
		        case Category.RESULT
		            value = el.getr(prop);
		            if isa(value, 'NoValue')
		                set(pr.button_calc, 'Enable', 'on')
		                set(pr.button_del, 'Enable', 'off')
		            else
		                set(pr.button_calc, 'Enable', 'off')
		                set(pr.button_del, 'Enable', 'on')
		            end
		    end
		end
		function redraw(pr, varargin)
		    %REDRAW resizes the property panel and repositions its graphical objects.
		    %
		    % REDRAW(PL) resizes the property panel and repositions its
		    %   graphical objects. 
		    % 
		    % Important notes:
		    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
		    % 2. REDRAW() is typically called internally by PlotElement and does not need 
		    %  to be explicitly called in children of PlotProp.
		    %
		    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
		    %  repositions the property panel. It is possible to use a
		    %  subset of the Name-Value pairs.
		    %  By default:
		    %  - X0 does not change
		    %  - Y0 does not change
		    %  - WIDTH does not change
		    %  - HEIGHT=1.4 characters.
		    %
		    % See also draw, update, PlotElement.
		% % % disp('r') % FIXME
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    p = pr.p;
		
		    % resizes the width (w) and height (h) of the panel
		    % keeps its initial position (x0, y0) unchanged.
		    x0_p = get_from_varargin(x0(p), 'X0', varargin);
		    y0_p = get_from_varargin(y0(p), 'Y0', varargin);
		    w_p = get_from_varargin(w(p), 'Width', varargin);
		    h_p = get_from_varargin(1.4, 'Height', varargin);
		    set(p, ...
		        'Units', 'characters', ...
		        'Position', [x0_p y0_p w_p h_p] ...
		        )
		
		    % places text_tag to the top
		    set(pr.text_tag, ...
		        'Units', 'characters', ...
		        'Position', [0 h(p)-1 w(p) 1] ...
		        )
		
		    % places the relevant buttons (depening on category)
		    switch el.getPropCategory(prop)
		        case Category.METADATA
		            %
		
		        case {Category.PARAMETER, Category.DATA}
		            set(pr.button_cb, ...
		                'Units', 'characters', ...
		                'Position', [w(p)-4 h(p)-1.2 3 1] ...
		                )
		
		        case Category.RESULT
		            set(pr.button_calc, ...
		                'Units', 'characters', ...
		                'Position', [w(p)-7.5 h(p)-1.2 3 1] ...
		                )
		            set(pr.button_del, ...
		                'Units', 'characters', ...
		                'Position', [w(p)-4 h(p)-1.2 3 1] ...
		                )
		    end
		    
		    % auxiliary functions
		    function r = x0(h)
		        r = Plot.x0(h, 'characters');
		    end
		    function r = y0(h)
		        r = Plot.y0(h, 'characters');
		    end
		    function r = w(h)
		        r = Plot.w(h, 'characters');
		    end
		    function r = h(h)
		        r = Plot.h(h, 'characters');
		    end
		end
		function cb_button_cb(pr)
		    %CB_BUTTON_CB executes callback for button callback.
		    %
		    % CB_BUTTON_CB(PL) executes callback for button callback.
		    % 
		    % See also GUI.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    GUI('EL', el.getr(prop).get('EL')) 
		% FIXME: check that this is working once GUI is complete
		end
		function cb_button_calc(pr)
		    %CB_BUTTON_CALC executes callback for button calculate.
		    %
		    % CB_BUTTON_CALC(PL) executes callback for button calculate.
		    %
		    % See also cb_button_del.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    el.memorize(prop);
		
		    % updates and redraws the parent PlotElement as well as all siblings PlotProp's
		    pe = get(get(get(pr.p, 'Parent'), 'Parent'), 'UserData');
		    pe.update()
		    pe.redraw()
		end
		function cb_button_del(pr)
		    %CB_BUTTON_DEL executes callback for button delete.
		    %
		    % CB_BUTTON_DEL(PL) executes callback for button delete.
		    %
		    % See also cb_button_calc.
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    el.set(prop, NoValue.getNoValue())
		
		    % updates and redraws the parent PlotElement as well as all siblings PlotProp's
		    pe = get(get(get(pr.p, 'Parent'), 'Parent'), 'UserData');
		    pe.update()
		    pe.redraw()
		end
	end
end
