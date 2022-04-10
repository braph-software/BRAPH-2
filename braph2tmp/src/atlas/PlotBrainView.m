classdef PlotBrainView < Plot
	% PlotBrainView is a plot of a brain view.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% Plot is the plot of a graph of a function.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
	%
	% The list of PlotBrainView properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>me</strong> 	ME (metadata, item) is the measure.
	%  <strong>4</strong> <strong>comp</strong> 	COMP (metadata, item) is the comparison.
	%  <strong>5</strong> <strong>atlas</strong> 	ATLAS(metadata, item) is a brain atlas.
	%  <strong>6</strong> <strong>proptag</strong> 	PROPTAG(metadata, string) is a prop tag.
	%  <strong>7</strong> <strong>type</strong> 	TYPE(metadata, string) is the type of measure.
	%
	% PlotBrainView methods (constructor):
	% PlotBrainView - constructor
	%
	% PlotBrainView methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot brain view/error.
	%  existsProp - checks whether property exists in plot brain view/error.
	%  getPropNumber - returns the property number of plot brain view.
	%  getProps - returns the property list of plot brain view.
	%  getDescription - returns the description of the plot brain view.
	%  getName - returns the name of the plot brain view.
	%  getClass - returns the class of the plot brain view.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotBrainView methods:
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  settings - opens the brain surface property editor GUI.
	%  getBrainView - W creates a brain view panel for GUIAnalysis
	%  draw - draws the graphical panel.
	%  set_settings - /set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_close_fs - w/cb_close_fs is a function.
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
	% PlotBrainView methods (operators):
	%  isequal - determines whether two PlotBrainView are equal (values, locked)
	%
	% PlotBrainView methods (display):
	%  tostring - string with information about the PlotBrainView
	%  disp - displays information about the PlotBrainView
	%  tree - displays the element of PlotBrainView
	%
	% PlotBrainView method (element list):
	%  getElementList - returns a list with all subelements of PlotBrainView
	%
	% PlotBrainView method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotBrainView
	%
	% PlotBrainView method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotBrainView
	%
	% PlotBrainView methods (copy):
	%  copy - copies the PlotBrainView
	%  deepclone - deep-clones the PlotBrainView
	%  clone - clones the PlotBrainView
	%
	% PlotBrainView methods (inspection, Static):
	%  getClass - returns PlotBrainView
	%  getName - returns the name of PlotBrainView
	%  getDescription - returns the description of PlotBrainView
	%  getProps - returns the property list of PlotBrainView
	%  getPropNumber - returns the property number of PlotBrainView
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
	% PlotBrainView methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotBrainView methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotBrainView methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotBrainView methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotBrainView properties (Constant).
	%  ME - 3
	%  ME_TAG - 'me'
	%  ME_CATEGORY - 'm'
	%  ME_FORMAT - 'it'
	%  COMP - 4
	%  COMP_TAG - 'comp'
	%  COMP_CATEGORY - 'm'
	%  COMP_FORMAT - 'it'
	%  ATLAS - 5
	%  ATLAS_TAG - 'atlas'
	%  ATLAS_CATEGORY - 'm'
	%  ATLAS_FORMAT - 'it'
	%  PROPTAG - 6
	%  PROPTAG_TAG - 'proptag'
	%  PROPTAG_CATEGORY - 'm'
	%  PROPTAG_FORMAT - 'st'
	%  TYPE - 7
	%  TYPE_TAG - 'type'
	%  TYPE_CATEGORY - 'm'
	%  TYPE_FORMAT - 'st'
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
	% See also uipanel, ishandle, isgraphics, figure, PlotGraph.
	
	properties (Access = private) % element properties
		h_figure % panel graphical handle
		h_axes % axes handle
		bg % plot brain graph
		p
		f_settings
		m
	end
	properties (Constant) % properties
		ME = Plot.getPropNumber() + 1;
		ME_TAG = 'me';
		ME_CATEGORY = Category.METADATA;
		ME_FORMAT = Format.ITEM;
		
		COMP = Plot.getPropNumber() + 2;
		COMP_TAG = 'comp';
		COMP_CATEGORY = Category.METADATA;
		COMP_FORMAT = Format.ITEM;
		
		ATLAS = Plot.getPropNumber() + 3;
		ATLAS_TAG = 'atlas';
		ATLAS_CATEGORY = Category.METADATA;
		ATLAS_FORMAT = Format.ITEM;
		
		PROPTAG = Plot.getPropNumber() + 4;
		PROPTAG_TAG = 'proptag';
		PROPTAG_CATEGORY = Category.METADATA;
		PROPTAG_FORMAT = Format.STRING;
		
		TYPE = Plot.getPropNumber() + 5;
		TYPE_TAG = 'type';
		TYPE_CATEGORY = Category.METADATA;
		TYPE_FORMAT = Format.STRING;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot brain view.
			%
			% CLASS = PlotBrainView.GETCLASS() returns the class 'PlotBrainView'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot brain view PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotBrainView') returns 'PlotBrainView'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotBrainView';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot brain view.
			%
			% NAME = PlotBrainView.GETNAME() returns the name of the 'plot brain view'.
			%  Plot Brain View.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot brain view PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotBrainView') returns the name of 'PlotBrainView'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Brain View';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot brain view.
			%
			% STR = PlotBrainView.GETDESCRIPTION() returns the description of the 'plot brain view'.
			%  which is:
			%
			%  Plot is the plot of a graph of a function.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot brain view PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotBrainView') returns the description of 'PlotBrainView'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'Plot is the plot of a graph of a function.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot brain view.
			%
			% PROPS = PlotBrainView.GETPROPS() returns the property list of plot brain view.
			%
			% PROPS = PlotBrainView.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot brain view PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotBrainView'[, CATEGORY]) returns the property list of 'PlotBrainView'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotBrainView.ME
						PlotBrainView.COMP
						PlotBrainView.ATLAS
						PlotBrainView.PROPTAG
						PlotBrainView.TYPE
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
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
						PlotBrainView.ME
						PlotBrainView.COMP
						PlotBrainView.ATLAS
						PlotBrainView.PROPTAG
						PlotBrainView.TYPE
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot brain view.
			%
			% N = PlotBrainView.GETPROPNUMBER() returns the property number of plot brain view.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot brain view PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotBrainView') returns the property number of 'PlotBrainView'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot brain view/error.
			%
			% CHECK = PlotBrainView.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotBrainView, PROP) checks whether PROP exists for PlotBrainView.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotBrainView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  Element.EXISTSPROP(PlotBrainView, PROP) throws error if PROP does NOT exist for PlotBrainView.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PlotBrainView.existsProp(prop), ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotBrainView.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot brain view/error.
			%
			% CHECK = PlotBrainView.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotBrainView, TAG) checks whether TAG exists for PlotBrainView.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotBrainView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  Element.EXISTSTAG(PlotBrainView, TAG) throws error if TAG does NOT exist for PlotBrainView.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainview_tag_list = { 'id'  'bkgcolor'  'me'  'comp'  'atlas'  'proptag'  'type' };
				
				check = any(strcmpi(tag, plotbrainview_tag_list));
			else
				assert( ...
					PlotBrainView.existsTag(tag), ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotBrainView'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotBrainView, POINTER) returns property number of POINTER of PlotBrainView.
			%  PROPERTY = PR.GETPROPPROP(PlotBrainView, POINTER) returns property number of POINTER of PlotBrainView.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainview_tag_list = { 'id'  'bkgcolor'  'me'  'comp'  'atlas'  'proptag'  'type' };
				
				tag = pointer;
				PlotBrainView.existsTag(tag);
				
				prop = find(strcmpi(tag, plotbrainview_tag_list));
			else % numeric
				prop = pointer;
				PlotBrainView.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotBrainView, POINTER) returns tag of POINTER of PlotBrainView.
			%  TAG = PR.GETPROPTAG(PlotBrainView, POINTER) returns tag of POINTER of PlotBrainView.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotBrainView.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotBrainView.existsProp(prop);
				
				switch prop
					case PlotBrainView.ME
						tag = PlotBrainView.ME_TAG;
					case PlotBrainView.COMP
						tag = PlotBrainView.COMP_TAG;
					case PlotBrainView.ATLAS
						tag = PlotBrainView.ATLAS_TAG;
					case PlotBrainView.PROPTAG
						tag = PlotBrainView.PROPTAG_TAG;
					case PlotBrainView.TYPE
						tag = PlotBrainView.TYPE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotBrainView, POINTER) returns category of POINTER of PlotBrainView.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotBrainView, POINTER) returns category of POINTER of PlotBrainView.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					prop_category = PlotBrainView.ME_CATEGORY;
				case PlotBrainView.COMP
					prop_category = PlotBrainView.COMP_CATEGORY;
				case PlotBrainView.ATLAS
					prop_category = PlotBrainView.ATLAS_CATEGORY;
				case PlotBrainView.PROPTAG
					prop_category = PlotBrainView.PROPTAG_CATEGORY;
				case PlotBrainView.TYPE
					prop_category = PlotBrainView.TYPE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotBrainView, POINTER) returns format of POINTER of PlotBrainView.
			%  FORMAT = PR.GETPROPFORMAT(PlotBrainView, POINTER) returns format of POINTER of PlotBrainView.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					prop_format = PlotBrainView.ME_FORMAT;
				case PlotBrainView.COMP
					prop_format = PlotBrainView.COMP_FORMAT;
				case PlotBrainView.ATLAS
					prop_format = PlotBrainView.ATLAS_FORMAT;
				case PlotBrainView.PROPTAG
					prop_format = PlotBrainView.PROPTAG_FORMAT;
				case PlotBrainView.TYPE
					prop_format = PlotBrainView.TYPE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotBrainView, POINTER) returns description of POINTER of PlotBrainView.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotBrainView, POINTER) returns description of POINTER of PlotBrainView.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					prop_description = 'ME (metadata, item) is the measure.';
				case PlotBrainView.COMP
					prop_description = 'COMP (metadata, item) is the comparison.';
				case PlotBrainView.ATLAS
					prop_description = 'ATLAS(metadata, item) is a brain atlas.';
				case PlotBrainView.PROPTAG
					prop_description = 'PROPTAG(metadata, string) is a prop tag.';
				case PlotBrainView.TYPE
					prop_description = 'TYPE(metadata, string) is the type of measure.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotBrainView, POINTER) returns settings of POINTER of PlotBrainView.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotBrainView, POINTER) returns settings of POINTER of PlotBrainView.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotBrainView.COMP
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotBrainView.ATLAS
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotBrainView.PROPTAG
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotBrainView.TYPE
					prop_settings = Format.getFormatSettings(Format.STRING);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotBrainView.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainView.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotBrainView, POINTER) returns the default value of POINTER of PlotBrainView.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotBrainView, POINTER) returns the default value of POINTER of PlotBrainView.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					prop_default = Format.getFormatDefault(Format.ITEM, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.COMP
					prop_default = Format.getFormatDefault(Format.ITEM, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.ATLAS
					prop_default = Format.getFormatDefault(Format.ITEM, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.PROPTAG
					prop_default = Format.getFormatDefault(Format.STRING, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.TYPE
					prop_default = Format.getFormatDefault(Format.STRING, PlotBrainView.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotBrainView.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainView.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotBrainView, POINTER) returns the conditioned default value of POINTER of PlotBrainView.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotBrainView, POINTER) returns the conditioned default value of POINTER of PlotBrainView.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			prop_default = PlotBrainView.conditioning(prop, PlotBrainView.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotBrainView, PROP, VALUE) checks VALUE format for PROP of PlotBrainView.
			%  CHECK = PR.CHECKPROP(PlotBrainView, PROP, VALUE) checks VALUE format for PROP of PlotBrainView.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotBrainView:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  Element.CHECKPROP(PlotBrainView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainView.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			%  PR.CHECKPROP(PlotBrainView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainView.
			%   Error id: [BRAPH2:PlotBrainView:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotBrainView.getPropProp(pointer);
			
			switch prop
				case PlotBrainView.ME
					check = Format.checkFormat(Format.ITEM, value, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.COMP
					check = Format.checkFormat(Format.ITEM, value, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.ATLAS
					check = Format.checkFormat(Format.ITEM, value, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.PROPTAG
					check = Format.checkFormat(Format.STRING, value, PlotBrainView.getPropSettings(prop));
				case PlotBrainView.TYPE
					check = Format.checkFormat(Format.STRING, value, PlotBrainView.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainView:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotBrainView.getPropTag(prop) ' (' PlotBrainView.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotBrainView(varargin)
			% PlotBrainView() creates a plot brain view.
			%
			% PlotBrainView(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotBrainView(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotBrainView properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>me</strong> 	ME (metadata, item) is the measure.
			%  <strong>4</strong> <strong>comp</strong> 	COMP (metadata, item) is the comparison.
			%  <strong>5</strong> <strong>atlas</strong> 	ATLAS(metadata, item) is a brain atlas.
			%  <strong>6</strong> <strong>proptag</strong> 	PROPTAG(metadata, string) is a prop tag.
			%  <strong>7</strong> <strong>type</strong> 	TYPE(metadata, string) is the type of measure.
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotBrainView.getPropProp(pointer);
			
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
		    pr.p = draw@Plot(pr, ...
		        varargin{:});
		    pr.h_figure = get(pr.p, 'Parent');
		    subpanel = uipanel(pr.h_figure, ...
		        'BackGroundColor', 'w', ...
		        'Units', 'normalized', ...
		        'Position', [.0 .0 1 1] ...
		        );
		    
		    pr.h_axes = axes(subpanel);
		
		    pr.getBrainView();
		
		    % output
		    if nargout > 0
		        h_panel = pr.pp;
		    end
		end
		function p = getBrainView(pr)
		    % GETBRAINVIEW creates a brain view panel for GUIAnalysis
		    %
		    % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
		    % brain view panel for GUIAnalysis.
		    %
		    % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
		    uiparent = pr.h_figure;
		    atlas = pr.get('ATLAS');
		    
		    % get surf or set default
		    if isempty(atlas.get('SURF').get('Triangles'))
		        selected_surface = 'human_ICBM152';
		        atlas.set('SURF', ImporterBrainSurfaceNV('FILE', [selected_surface '.nv']).get('SURF'));
		        surf =  atlas.get('SURF');
		    else
		        surf = atlas.get('SURF');
		    end
		    
		    prop_tag = pr.get('PROPTAG');
		    
		    if isequal(pr.get('ME'), Element()) && ~isempty(pr.get('COMP'))
		        tmp_comp = pr.get('COMP');
		        if isa(tmp_comp, 'ComparisonGroup')
		            pr.bg =  PlotBrainGraphComparison('ATLAS', atlas, ...
		                'COMP', pr.get('COMP'), ...
		                'PROPTAG', prop_tag, ...
		                'Surf', surf, ...
		                'TYPE', pr.get('TYPE'));
		        else % ensemble
		            pr.bg =  PlotBrainGraphComparisonEnsemble('ATLAS', atlas, ...
		                'COMP', pr.get('COMP'), ...
		                'PROPTAG', prop_tag, ...
		                'Surf', surf, ...
		                'TYPE', pr.get('TYPE'));
		        end       
		    else
		        tmp_me = pr.get('ME');
		        if isa(tmp_me, 'Measure') % group
		            pr.bg =  PlotBrainGraph('ATLAS', atlas, ...
		                'ME',  pr.get('ME'), ...
		                'Surf', surf, ...
		                'TYPE', pr.get('TYPE'));
		        else % ensemble
		            pr.bg =  PlotBrainGraphEnsemble('ATLAS', atlas, ...
		                'ME',  pr.get('ME'), ...
		                'Surf', surf, ...
		                'TYPE', pr.get('TYPE'));
		        end       
		    end
		    
		    function create_figure()
		        pr.bg.draw('Parent', uiparent);
		    end
		
		    create_figure()
		
		    if nargout > 0
		        p = ui_brainview_panel;
		    end
		end
		function f_settings = settings(pr, varargin)
		    %SETTINGS opens the brain surface property editor GUI.
		    %
		    % SETTINGS(PL) allows the user to specify the properties of the brain
		    %  atlas plot by opening a GUI property editor.
		    %
		    % F = SETTINGS(PL) returns a handle to the brain atlas property editor GUI.
		    %
		    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the brain
		    %  atlas property editor GUI with custom property-value couples.
		    %  All standard plot properties of figure can be used.
		    %
		    % See also draw, figure, isgraphics.
		
		    f_settings = pr.bg.settings();
		    pr.set_settings(f_settings);
		    pr.f_settings = f_settings;
		end
		function cb_bring_to_front(pr)
		    pr.cb_bring_to_front@Plot();    
		    pr.bg.cb_bring_to_front()
		end
		function cb_hide(pr)
		    pr.cb_hide@Plot();
		    pr.bg.cb_hide()
		end
	end
end
