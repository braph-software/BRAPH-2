classdef PlotAdjacencyMatrix < Plot
	% PlotAdjacencyMatrix is a plot of the adjacency matrix of the graph.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% Plot is the plot of adjacency matrix of the graph.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	%
	% The list of PlotAdjacencyMatrix properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>submenu</strong> 	SUBMENU (metadata, logical) to set a submenu
	%  <strong>4</strong> <strong>g_dict</strong> 	G_DICT (data, idict) is the dictionary that contains the graphs been ploted
	%  <strong>5</strong> <strong>layer</strong> 	LAYER (metadata, scalar) is the layer to be ploted
	%  <strong>6</strong> <strong>subject</strong> 	SUBJECT (metadata, scalar) is the subject to be ploted
	%
	% PlotAdjacencyMatrix methods (constructor):
	% PlotAdjacencyMatrix - constructor
	%
	% PlotAdjacencyMatrix methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot graph/error.
	%  existsProp - checks whether property exists in plot graph/error.
	%  getPropNumber - returns the property number of plot graph.
	%  getProps - returns the property list of plot graph.
	%  getDescription - returns the description of the plot graph.
	%  getName - returns the name of the plot graph.
	%  getClass - returns the class of the plot graph.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotAdjacencyMatrix methods:
	%  hist - T plots the histogram and density of a matrix
	%  plotb - B plots a binary matrix
	%  plotw - W plots a weighted matrix
	%  settings - opens the property editor GUI.
	%  draw - draws the graphical panel.
	%  set_settings - Matrix/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - yMatrix/cb_close_fs is a function.
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
	% PlotAdjacencyMatrix methods (operators):
	%  isequal - determines whether two PlotAdjacencyMatrix are equal (values, locked)
	%
	% PlotAdjacencyMatrix methods (display):
	%  tostring - string with information about the PlotAdjacencyMatrix
	%  disp - displays information about the PlotAdjacencyMatrix
	%  tree - displays the element of PlotAdjacencyMatrix
	%
	% PlotAdjacencyMatrix method (element list):
	%  getElementList - returns a list with all subelements of PlotAdjacencyMatrix
	%
	% PlotAdjacencyMatrix method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotAdjacencyMatrix
	%
	% PlotAdjacencyMatrix method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotAdjacencyMatrix
	%
	% PlotAdjacencyMatrix methods (copy):
	%  copy - copies the PlotAdjacencyMatrix
	%  deepclone - deep-clones the PlotAdjacencyMatrix
	%  clone - clones the PlotAdjacencyMatrix
	%
	% PlotAdjacencyMatrix methods (inspection, Static):
	%  getClass - returns PlotAdjacencyMatrix
	%  getName - returns the name of PlotAdjacencyMatrix
	%  getDescription - returns the description of PlotAdjacencyMatrix
	%  getProps - returns the property list of PlotAdjacencyMatrix
	%  getPropNumber - returns the property number of PlotAdjacencyMatrix
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
	% PlotAdjacencyMatrix methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotAdjacencyMatrix methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotAdjacencyMatrix methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotAdjacencyMatrix methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotAdjacencyMatrix properties (Constant).
	%  SUBMENU - 3
	%  SUBMENU_TAG - 'submenu'
	%  SUBMENU_CATEGORY - 'm'
	%  SUBMENU_FORMAT - 'lo'
	%  G_DICT - 4
	%  G_DICT_TAG - 'g_dict'
	%  G_DICT_CATEGORY - 'd'
	%  G_DICT_FORMAT - 'di'
	%  LAYER - 5
	%  LAYER_TAG - 'layer'
	%  LAYER_CATEGORY - 'm'
	%  LAYER_FORMAT - 'nn'
	%  SUBJECT - 6
	%  SUBJECT_TAG - 'subject'
	%  SUBJECT_CATEGORY - 'm'
	%  SUBJECT_FORMAT - 'nn'
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
	% See also uipanel, ishandle, isgraphics, figure.
	
	properties (Access = private) % element properties
		h_figure % panel graphical handle
		h_axes % axes handle
		h_plot
		pp
		h_settings
	end
	properties (Constant) % properties
		SUBMENU = Plot.getPropNumber() + 1;
		SUBMENU_TAG = 'submenu';
		SUBMENU_CATEGORY = Category.METADATA;
		SUBMENU_FORMAT = Format.LOGICAL;
		
		G_DICT = Plot.getPropNumber() + 2;
		G_DICT_TAG = 'g_dict';
		G_DICT_CATEGORY = Category.DATA;
		G_DICT_FORMAT = Format.IDICT;
		
		LAYER = Plot.getPropNumber() + 3;
		LAYER_TAG = 'layer';
		LAYER_CATEGORY = Category.METADATA;
		LAYER_FORMAT = Format.SCALAR;
		
		SUBJECT = Plot.getPropNumber() + 4;
		SUBJECT_TAG = 'subject';
		SUBJECT_CATEGORY = Category.METADATA;
		SUBJECT_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot graph.
			%
			% CLASS = PlotAdjacencyMatrix.GETCLASS() returns the class 'PlotAdjacencyMatrix'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotAdjacencyMatrix') returns 'PlotAdjacencyMatrix'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotAdjacencyMatrix';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot graph.
			%
			% NAME = PlotAdjacencyMatrix.GETNAME() returns the name of the 'plot graph'.
			%  Plot Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotAdjacencyMatrix') returns the name of 'PlotAdjacencyMatrix'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot graph.
			%
			% STR = PlotAdjacencyMatrix.GETDESCRIPTION() returns the description of the 'plot graph'.
			%  which is:
			%
			%  Plot is the plot of adjacency matrix of the graph.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotAdjacencyMatrix') returns the description of 'PlotAdjacencyMatrix'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'Plot is the plot of adjacency matrix of the graph.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot graph.
			%
			% PROPS = PlotAdjacencyMatrix.GETPROPS() returns the property list of plot graph.
			%
			% PROPS = PlotAdjacencyMatrix.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotAdjacencyMatrix'[, CATEGORY]) returns the property list of 'PlotAdjacencyMatrix'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotAdjacencyMatrix.SUBMENU
						PlotAdjacencyMatrix.LAYER
						PlotAdjacencyMatrix.SUBJECT
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotAdjacencyMatrix.G_DICT
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
						PlotAdjacencyMatrix.SUBMENU
						PlotAdjacencyMatrix.G_DICT
						PlotAdjacencyMatrix.LAYER
						PlotAdjacencyMatrix.SUBJECT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot graph.
			%
			% N = PlotAdjacencyMatrix.GETPROPNUMBER() returns the property number of plot graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotAdjacencyMatrix') returns the property number of 'PlotAdjacencyMatrix'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot graph/error.
			%
			% CHECK = PlotAdjacencyMatrix.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotAdjacencyMatrix, PROP) checks whether PROP exists for PlotAdjacencyMatrix.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  Element.EXISTSPROP(PlotAdjacencyMatrix, PROP) throws error if PROP does NOT exist for PlotAdjacencyMatrix.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					PlotAdjacencyMatrix.existsProp(prop), ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotAdjacencyMatrix.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot graph/error.
			%
			% CHECK = PlotAdjacencyMatrix.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotAdjacencyMatrix, TAG) checks whether TAG exists for PlotAdjacencyMatrix.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  Element.EXISTSTAG(PlotAdjacencyMatrix, TAG) throws error if TAG does NOT exist for PlotAdjacencyMatrix.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotadjacencymatrix_tag_list = { 'id'  'bkgcolor'  'submenu'  'g_dict'  'layer'  'subject' };
				
				check = any(strcmpi(tag, plotadjacencymatrix_tag_list));
			else
				assert( ...
					PlotAdjacencyMatrix.existsTag(tag), ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotAdjacencyMatrix'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotAdjacencyMatrix, POINTER) returns property number of POINTER of PlotAdjacencyMatrix.
			%  PROPERTY = PR.GETPROPPROP(PlotAdjacencyMatrix, POINTER) returns property number of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotadjacencymatrix_tag_list = { 'id'  'bkgcolor'  'submenu'  'g_dict'  'layer'  'subject' };
				
				tag = pointer;
				PlotAdjacencyMatrix.existsTag(tag);
				
				prop = find(strcmpi(tag, plotadjacencymatrix_tag_list));
			else % numeric
				prop = pointer;
				PlotAdjacencyMatrix.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotAdjacencyMatrix, POINTER) returns tag of POINTER of PlotAdjacencyMatrix.
			%  TAG = PR.GETPROPTAG(PlotAdjacencyMatrix, POINTER) returns tag of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotAdjacencyMatrix.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotAdjacencyMatrix.existsProp(prop);
				
				switch prop
					case PlotAdjacencyMatrix.SUBMENU
						tag = PlotAdjacencyMatrix.SUBMENU_TAG;
					case PlotAdjacencyMatrix.G_DICT
						tag = PlotAdjacencyMatrix.G_DICT_TAG;
					case PlotAdjacencyMatrix.LAYER
						tag = PlotAdjacencyMatrix.LAYER_TAG;
					case PlotAdjacencyMatrix.SUBJECT
						tag = PlotAdjacencyMatrix.SUBJECT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotAdjacencyMatrix, POINTER) returns category of POINTER of PlotAdjacencyMatrix.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotAdjacencyMatrix, POINTER) returns category of POINTER of PlotAdjacencyMatrix.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					prop_category = PlotAdjacencyMatrix.SUBMENU_CATEGORY;
				case PlotAdjacencyMatrix.G_DICT
					prop_category = PlotAdjacencyMatrix.G_DICT_CATEGORY;
				case PlotAdjacencyMatrix.LAYER
					prop_category = PlotAdjacencyMatrix.LAYER_CATEGORY;
				case PlotAdjacencyMatrix.SUBJECT
					prop_category = PlotAdjacencyMatrix.SUBJECT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotAdjacencyMatrix, POINTER) returns format of POINTER of PlotAdjacencyMatrix.
			%  FORMAT = PR.GETPROPFORMAT(PlotAdjacencyMatrix, POINTER) returns format of POINTER of PlotAdjacencyMatrix.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					prop_format = PlotAdjacencyMatrix.SUBMENU_FORMAT;
				case PlotAdjacencyMatrix.G_DICT
					prop_format = PlotAdjacencyMatrix.G_DICT_FORMAT;
				case PlotAdjacencyMatrix.LAYER
					prop_format = PlotAdjacencyMatrix.LAYER_FORMAT;
				case PlotAdjacencyMatrix.SUBJECT
					prop_format = PlotAdjacencyMatrix.SUBJECT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotAdjacencyMatrix, POINTER) returns description of POINTER of PlotAdjacencyMatrix.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotAdjacencyMatrix, POINTER) returns description of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					prop_description = 'SUBMENU (metadata, logical) to set a submenu';
				case PlotAdjacencyMatrix.G_DICT
					prop_description = 'G_DICT (data, idict) is the dictionary that contains the graphs been ploted';
				case PlotAdjacencyMatrix.LAYER
					prop_description = 'LAYER (metadata, scalar) is the layer to be ploted';
				case PlotAdjacencyMatrix.SUBJECT
					prop_description = 'SUBJECT (metadata, scalar) is the subject to be ploted';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotAdjacencyMatrix, POINTER) returns settings of POINTER of PlotAdjacencyMatrix.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotAdjacencyMatrix, POINTER) returns settings of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotAdjacencyMatrix.G_DICT
					prop_settings = 'Graph';
				case PlotAdjacencyMatrix.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotAdjacencyMatrix.SUBJECT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotAdjacencyMatrix.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotAdjacencyMatrix.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotAdjacencyMatrix, POINTER) returns the default value of POINTER of PlotAdjacencyMatrix.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotAdjacencyMatrix, POINTER) returns the default value of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					prop_default = false;
				case PlotAdjacencyMatrix.G_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PlotAdjacencyMatrix.getPropSettings(prop));
				case PlotAdjacencyMatrix.LAYER
					prop_default = 1;
				case PlotAdjacencyMatrix.SUBJECT
					prop_default = 1;
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotAdjacencyMatrix.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotAdjacencyMatrix.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotAdjacencyMatrix, POINTER) returns the conditioned default value of POINTER of PlotAdjacencyMatrix.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotAdjacencyMatrix, POINTER) returns the conditioned default value of POINTER of PlotAdjacencyMatrix.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			prop_default = PlotAdjacencyMatrix.conditioning(prop, PlotAdjacencyMatrix.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotAdjacencyMatrix, PROP, VALUE) checks VALUE format for PROP of PlotAdjacencyMatrix.
			%  CHECK = PR.CHECKPROP(PlotAdjacencyMatrix, PROP, VALUE) checks VALUE format for PROP of PlotAdjacencyMatrix.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  Element.CHECKPROP(PlotAdjacencyMatrix, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotAdjacencyMatrix.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			%  PR.CHECKPROP(PlotAdjacencyMatrix, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotAdjacencyMatrix.
			%   Error id: [BRAPH2:PlotAdjacencyMatrix:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				case PlotAdjacencyMatrix.SUBMENU
					check = Format.checkFormat(Format.LOGICAL, value, PlotAdjacencyMatrix.getPropSettings(prop));
				case PlotAdjacencyMatrix.G_DICT
					check = Format.checkFormat(Format.IDICT, value, PlotAdjacencyMatrix.getPropSettings(prop));
				case PlotAdjacencyMatrix.LAYER
					check = Format.checkFormat(Format.SCALAR, value, PlotAdjacencyMatrix.getPropSettings(prop));
				case PlotAdjacencyMatrix.SUBJECT
					check = Format.checkFormat(Format.SCALAR, value, PlotAdjacencyMatrix.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAdjacencyMatrix:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotAdjacencyMatrix.getPropTag(prop) ' (' PlotAdjacencyMatrix.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotAdjacencyMatrix(varargin)
			% PlotAdjacencyMatrix() creates a plot graph.
			%
			% PlotAdjacencyMatrix(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotAdjacencyMatrix(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotAdjacencyMatrix properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>submenu</strong> 	SUBMENU (metadata, logical) to set a submenu
			%  <strong>4</strong> <strong>g_dict</strong> 	G_DICT (data, idict) is the dictionary that contains the graphs been ploted
			%  <strong>5</strong> <strong>layer</strong> 	LAYER (metadata, scalar) is the layer to be ploted
			%  <strong>6</strong> <strong>subject</strong> 	SUBJECT (metadata, scalar) is the subject to be ploted
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotAdjacencyMatrix.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Plot.getPropNumber()
						value = conditioning@Plot(pointer, value);
					end
			end
		end
	end
	methods % methods
		function [h_figure, h_axes, subpanel] = draw(pr, varargin)
		    %DRAW draws the graphical panel.
		    %
		    % DRAW(PL) draws the graphical panel.
		    %
		    % H = DRAW(PL) returns a handle to the graphical panel.
		    %
		    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
		    %  panel with custom property-value couples.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % see also settings, uipanel, isgraphics.    
		        
		    pr.pp = draw@Plot(pr, varargin{:});
		
		    pr.h_figure = get(pr.pp, 'Parent');
		    
		    % overwrite close req
		    set(pr.pp, 'DeleteFcn', {@cb_close_fs})
		    
		    function cb_close_fs(~, ~)
		        if ~isempty(pr.h_settings) && check_graphics(pr.h_settings, 'figure')
		            close(pr.h_settings)
		        end
		    end
		    
		    if pr.get('SUBMENU')
		        subpanel = uipanel(pr.h_figure, ...
		            'BackGroundColor', 'w', ...
		            'Units', 'normalized', ...
		            'Position', [.0 .15 1 .85] ...
		            );
		        
		        pr.h_axes = axes(subpanel);
		        set(pr.h_figure, 'Color', 'w')
		        set(pr.pp, 'BackGroundColor', 'w');
		        
		    else
		        pr.h_axes = axes(pr.pp);
		    end
		        
		    if nargout > 0
		        h_figure = pr.h_figure;
		    end
		    if nargout > 1
		        h_axes = pr.h_axes;
		    end
		end
		function f_settings = settings(pr, varargin)
		    %SETTINGS opens the property editor GUI.
		    %
		    % SETTINGS(PL) allows the user to specify the properties of the plot
		    %  by opening a GUI property editor.
		    %
		    % F = SETTINGS(PL) returns a handle to the property editor GUI.
		    %
		    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the
		    %  property editor GUI with custom property-value couples.
		    %  All standard plot properties of figure can be used.
		    %
		    % See also draw, figure, isgraphics.
		
		    f = settings@Plot(pr, varargin{:});
		    pr.h_settings = f;
		
		    set(f, 'Toolbar', 'none')
		
		    % panel
		    ui_parent = pr.h_settings;
		    ui_parent_axes = pr.h_axes;
		    matrix_plot = pr.h_plot;
		
		    subject_panel = uipanel(ui_parent, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .85 .98 .14] ...
		        );
		
		    g_dict = pr.get('G_DICT');
		    g_check = g_dict.length();
		    tmp_g = g_dict.getItem(1);
		    if iscell(tmp_g.get('B'))
		        layer_check = size(tmp_g.get('B'), 2);
		    else
		        layer_check = 1;
		    end
		
		    % new part layers and subjects
		    mod = 0;
		    if g_check > 1
		        mod = mod + .2; % substract from height to all uicontrols
		
		        subject_selector_id = uicontrol(subject_panel, ...
		            'Style', 'text', ...
		            'Units', 'normalized', ...
		            'String', 'Subject Selection', ...
		            'BackgroundColor', pr.h_settings.Color, ...
		            'Position', [.01 .02 .15 .8]);
		
		        subject_list = cellfun(@(x) ['Subject: ' num2str(x)], num2cell([1:g_check]), 'UniformOutput', false);
		        subject_select_popup = uicontrol('Parent', subject_panel, ...
		            'Style', 'popupmenu', ...
		            'Units', 'normalized', ...
		            'Position', [.24 .02 .15 .88], ...
		            'String', subject_list, ...
		            'TooltipString', 'Select a subject.', ...
		            'Callback', {@cb_subject_index} ...
		            );
		    end
		
		        function cb_subject_index(~, ~)
		            val = subject_select_popup.Value;
		            str = subject_select_popup.String;
		            pr.set('subject', val);
		            update_matrix();
		        end
		
		    if layer_check > 1
		        mod = mod + .2;
		        layer_selector_id = uicontrol(subject_panel, ...
		            'Style', 'text', ...
		            'Units', 'normalized', ...
		            'String', 'Layer Selection', ...
		            'BackgroundColor', pr.h_settings.Color, ...
		            'Position', [.01+mod .02 .15 .8]);
		
		        layer_list = cellfun(@(x) ['Layer: ' num2str(x)], num2cell([1:layer_check]), 'UniformOutput', false);
		        layer_select_popup = uicontrol('Parent', subject_panel, ...
		            'Style', 'popupmenu', ...
		            'Units', 'normalized', ...
		            'Position', [.24+mod .02 .15 .88], ...
		            'String', layer_list, ...
		            'TooltipString', 'Select a layer.', ...
		            'Callback', {@cb_layer_index} ...
		            );
		
		    end
		
		        function cb_layer_index(~, ~)
		            val = layer_select_popup.Value;
		            str = layer_select_popup.String;
		            pr.set('layer', val);
		            update_matrix();
		        end
		
		    options_panel = uipanel(ui_parent, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .01 .98 .84] ...
		        );
		
		    ui_matrix_weighted_checkbox = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'checkbox', 'BackgroundColor', pr.h_settings.Color);
		    set(ui_matrix_weighted_checkbox, 'Position', [.02 .82 .3 .07], ...
		        'String', 'weighted correlation matrix', ...
		        'Value', true, ...
		        'TooltipString', 'Select weighted matrix', ...
		        'FontWeight', 'bold', ...
		        'Callback', {@cb_matrix_weighted_checkbox})
		
		    % density
		    ui_matrix_density_checkbox = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'checkbox', 'BackgroundColor', pr.h_settings.Color);
		    set(ui_matrix_density_checkbox, 'Position', [.02 .7 .3 .07], ...
		        'String', 'binary correlation matrix (set density)', ...
		        'Value', false,...
		        'TooltipString', 'Select binary correlation matrix with a set density', ...
		        'Callback', {@cb_matrix_density_checkbox})
		
		    ui_matrix_density_edit = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'edit');
		    set(ui_matrix_density_edit, 'Position', [.02 .6 .3 .07], ...
		        'String', '50.00', ...
		        'TooltipString', 'Set density.', ...
		        'FontWeight', 'bold', ...
		        'Enable', 'off', ...
		        'Callback', {@cb_matrix_density_edit});
		
		    ui_matrix_density_slider = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'slider');
		    set(ui_matrix_density_slider, 'Position', [.33 .6 .3 .07], ...
		        'Min', 0, 'Max', 100, 'Value', 50, ...
		        'TooltipString', 'Set density.', ...
		        'Enable', 'off', ...
		        'Callback', {@cb_matrix_density_slider})
		
		    % threshold
		    ui_matrix_threshold_checkbox = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'checkbox', 'BackgroundColor', pr.h_settings.Color);
		    set(ui_matrix_threshold_checkbox, 'Position', [.02 .5 .3 .07],...
		        'String', 'binary correlation matrix (set threshold)', ...
		        'Value', false, ...
		        'TooltipString', 'Select binary correlation matrix with a set threshold', ...
		        'Callback', {@cb_matrix_threshold_checkbox})
		
		    ui_matrix_threshold_edit = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'edit');
		    set(ui_matrix_threshold_edit, 'Position', [.02 .4 .3 .07], ...
		        'String', '0.50', ...
		        'TooltipString', 'Set threshold.', ...
		        'FontWeight', 'bold' ,...
		        'Enable', 'off', ...
		        'Callback', {@cb_matrix_threshold_edit});
		
		    ui_matrix_threshold_slider = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'slider');
		    set(ui_matrix_threshold_slider, 'Position', [.33 .4 .3 .07], ...
		        'Min', -1, 'Max', 1, 'Value', .50, ...
		        'TooltipString', 'Set threshold.', ...
		        'Enable', 'off', ...
		        'Callback', {@cb_matrix_threshold_slider})
		
		    % histogram
		    ui_matrix_histogram_checkbox = uicontrol('Parent', options_panel, 'Units', 'normalized', 'Style', 'checkbox', 'BackgroundColor', pr.h_settings.Color);
		    set(ui_matrix_histogram_checkbox, 'Position', [.02 .3 .1 .07],...
		        'String', 'histogram', ...
		        'Value', false, ...
		        'TooltipString', 'Select histogram of correlation coefficients', ...
		        'Callback', {@cb_matrix_histogram_checkbox})
		
		        function cb_matrix_weighted_checkbox(~, ~)
		            set(ui_matrix_weighted_checkbox, 'Value', true)
		            set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
		
		            set(ui_matrix_histogram_checkbox, 'Value', false)
		            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_density_checkbox, 'Value', false)
		            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_density_edit, 'Enable', 'off')
		            set(ui_matrix_density_slider, 'Enable', 'off')
		
		            set(ui_matrix_threshold_checkbox, 'Value', false)
		            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_threshold_edit, 'Enable', 'off')
		            set(ui_matrix_threshold_slider, 'Enable', 'off')
		
		            update_matrix()
		        end
		        function cb_matrix_density_checkbox(~, ~)
		            set(ui_matrix_weighted_checkbox, 'Value', false)
		            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_histogram_checkbox, 'Value', false)
		            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_density_checkbox, 'Value', true)
		            set(ui_matrix_density_checkbox, 'FontWeight', 'bold')
		            set(ui_matrix_density_edit, 'Enable', 'on')
		            set(ui_matrix_density_slider, 'Enable', 'on')
		
		            set(ui_matrix_threshold_checkbox, 'Value', false)
		            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_threshold_edit, 'Enable', 'off')
		            set(ui_matrix_threshold_slider, 'Enable', 'off')
		
		            update_matrix()
		        end
		        function cb_matrix_threshold_checkbox(~, ~)
		            set(ui_matrix_weighted_checkbox, 'Value', false)
		            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_histogram_checkbox, 'Value', false)
		            set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_density_checkbox, 'Value', false)
		            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_density_edit, 'Enable', 'off')
		            set(ui_matrix_density_slider, 'Enable', 'off')
		
		            set(ui_matrix_threshold_checkbox, 'Value', true)
		            set(ui_matrix_threshold_checkbox, 'FontWeight', 'bold')
		            set(ui_matrix_threshold_edit, 'Enable', 'on')
		            set(ui_matrix_threshold_slider, 'Enable', 'on')
		
		            update_matrix()
		        end
		        function cb_matrix_histogram_checkbox(~, ~)
		            set(ui_matrix_weighted_checkbox, 'Value', false)
		            set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
		
		            set(ui_matrix_histogram_checkbox, 'Value', true)
		            set(ui_matrix_histogram_checkbox, 'FontWeight', 'bold')
		
		            set(ui_matrix_density_checkbox, 'Value', false)
		            set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_density_edit, 'Enable', 'off')
		            set(ui_matrix_density_slider, 'Enable', 'off')
		
		            set(ui_matrix_threshold_checkbox, 'Value', false)
		            set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
		            set(ui_matrix_threshold_edit, 'Enable', 'off')
		            set(ui_matrix_threshold_slider, 'Enable', 'off')
		
		            update_matrix()
		        end
		        function cb_matrix_density_edit(~, ~)
		            update_matrix();
		        end
		        function cb_matrix_density_slider(src, ~)
		            set(ui_matrix_density_edit, 'String', get(src, 'Value'))
		            update_matrix();
		        end
		        function cb_matrix_threshold_edit(~, ~)
		            update_matrix();
		        end
		        function cb_matrix_threshold_slider(src, ~)
		            set(ui_matrix_threshold_edit, 'String', get(src, 'Value'))
		            update_matrix();
		        end
		        function update_matrix()
		            % get A and layer
		            g_dict_item = pr.get('G_DICT').getItem(pr.get('Subject'));
		            A = g_dict_item.get('B');
		            layer_to_plot = pr.get('Layer');
		            % i need to ask graph to return the plot 'Graph.PlotType'
		            if  get(ui_matrix_histogram_checkbox, 'Value') % histogram
		                if iscell(A) && size(A, 1) > 1 && size(A, 2) > 1
		                    pr.h_plot = pr.hist(A{layer_to_plot, layer_to_plot});
		                elseif iscell(A)
		                    pr.h_plot = pr.hist(A{layer_to_plot});
		                else
		                    pr.h_plot = pr.hist(A);
		                end
		            elseif get(ui_matrix_threshold_checkbox, 'Value')  % threshold
		                if iscell(A) && size(A, 1) > 1 && size(A, 2) > 1
		                    pr.h_plot = pr.plotb(A{layer_to_plot, layer_to_plot}, ...
		                        'threshold', ...
		                        str2double(get(ui_matrix_threshold_edit, 'String')));
		                elseif iscell(A)
		                    pr.h_plot = pr.plotb(A{layer_to_plot}, ...
		                        'threshold', ...
		                        str2double(get(ui_matrix_threshold_edit, 'String')));
		                else
		                    pr.h_plot = pr.plotb(A, ...
		                        'threshold', ...
		                        str2double(get(ui_matrix_threshold_edit, 'String')));
		                end
		            elseif get(ui_matrix_density_checkbox, 'Value')  % density
		                if iscell(A) && size(A, 1) > 1 && size(A, 2) > 1
		                    pr.h_plot = pr.plotb(A{layer_to_plot, layer_to_plot}, ...
		                        'density', ...
		                        str2double(get(ui_matrix_density_edit, 'String')));
		                elseif iscell(A)
		                    pr.h_plot = pr.plotb(A{layer_to_plot}, ...
		                        'density', ...
		                        str2double(get(ui_matrix_density_edit, 'String')));
		                else
		                    pr.h_plot = pr.plotb(A, ...
		                        'density', ...
		                        str2double(get(ui_matrix_density_edit, 'String')));
		                end
		            else  % weighted correlation
		                if iscell(A) && size(A, 1) > 1 && size(A, 2) > 1
		                    pr.h_plot = pr.plotw(A{layer_to_plot, layer_to_plot});
		                elseif iscell(A)
		                    pr.h_plot = pr.plotw(A{layer_to_plot});
		                else
		                    pr.h_plot = pr.plotw(A);
		                end
		            end
		        end
		
		    update_matrix()
		
		    if nargout > 0
		        f_settings = pr.h_settings;
		    end
		end
		function h = plotw(pr, A, varargin)
		    % PLOTW plots a weighted matrix
		    %
		    % H = PLOTW(A) plots the weighted matrix A and returns the handle to
		    %   the plot H.
		    %
		    % H = PLOTW(A,'PropertyName',PropertyValue) sets the property of the
		    %   matrix plot PropertyName to PropertyValue.
		    %   All standard plot properties of surf can be used.
		    %   Additional admissive properties are:
		    %       xlabels   -   1:1:number of matrix elements (default)
		    %       ylabels   -   1:1:number of matrix elements (default)
		    %
		    % See also Graph, plotb, surf.
		
		    N = length(A);
		
		    % x labels
		    xlabels = (1:1:N);
		    for n = 1:2:length(varargin)
		        if strcmpi(varargin{n}, 'xlabels')
		            xlabels = varargin{n + 1};
		        end
		    end
		    if ~iscell(xlabels)
		        xlabels = {xlabels};
		    end
		
		    % y labels
		    ylabels = (1:1:N);
		    for n = 1:2:length(varargin)
		        if strcmpi(varargin{n}, 'ylabels')
		            ylabels = varargin{n + 1};
		        end
		    end
		    if ~iscell(ylabels)
		        ylabels = {ylabels};
		    end
		
		    ht = surf('Parent', pr.h_axes, ...
		        (0:1:N), ...
		        (0:1:N), ...
		        [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
		    view(pr.h_axes, 2)
		    colorbar(pr.h_axes)
		    shading(pr.h_axes, 'flat')
		    axis(pr.h_axes, 'equal', 'square', 'tight')
		    grid(pr.h_axes, 'off')
		    box(pr.h_axes, 'on')
		    set(pr.h_axes, ...
		        'XAxisLocation', 'top', ...
		        'XTick', (1:1:N) - .5, ...
		        'XTickLabel', {}, ...
		        'YAxisLocation', 'left', ...
		        'YDir', 'Reverse', ...
		        'YTick', (1:1:N) - .5, ...
		        'YTickLabel', ylabels)
		
		    if ~verLessThan('matlab', '8.4.0')
		        set(pr.h_axes, ...
		            'XTickLabelRotation', 90, ...
		            'XTickLabel', xlabels)
		    else
		        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1, N), xlabels);
		        set(t, ...
		            'HorizontalAlignment', 'left', ...
		            'VerticalAlignment', 'middle', ...
		            'Rotation', 90);
		    end
		
		    colormap(pr.h_axes, 'jet')
		
		    % output if needed
		    if nargout > 0
		        h = ht;
		    end
		end
		function h = plotb(pr, A, varargin)
		    % PLOTB plots a binary matrix
		    %
		    % H = PLOTB(A) plots the binarized version of weighted matrix A and
		    %   returns the handle to the plot H.
		    %   The matrix A can be binarized by fixing the threshold
		    %   (default, threshold = 0.5).
		    %
		    % H = PLOTB(A, 'PropertyName', PropertyValue) sets the property of the
		    %   matrix plot PropertyName to PropertyValue.
		    %   All standard plot properties of surf can be used.
		    %   Additional admissive properties are:
		    %       threshold   -   0.5 (default)
		    %       xlabels     -   1:1:number of matrix elements (default)
		    %       ylabels     -   1:1:number of matrix elements (default)
		    %
		    % See also Graph, binarize, plotw, surf.
		
		    N = length(A);
		
		    % threshold
		    threshold = get_from_varargin(0, 'threshold', varargin{:});
		
		    % density
		    density = get_from_varargin([], 'density', varargin{:});
		
		    % x labels
		    xlabels = (1:1:N);
		    for n = 1:2:length(varargin)
		        if strcmpi(varargin{n}, 'xlabels')
		            xlabels = varargin{n + 1};
		        end
		    end
		    if ~iscell(xlabels)
		        xlabels = {xlabels};
		    end
		
		    % y labels
		    ylabels = (1:1:N);
		    for n = 1:2:length(varargin)
		        if strcmpi(varargin{n}, 'ylabels')
		            ylabels = varargin{n + 1};
		        end
		    end
		    if ~iscell(ylabels)
		        ylabels = {ylabels};
		    end
		
		    B = binarize(A, 'threshold', threshold, 'density', density);
		
		    ht = surf('Parent', pr.h_axes, ...
		        (0:1:N), ...
		        (0:1:N), ...
		        [B, zeros(size(B, 1), 1); zeros(1, size(B, 1) + 1)]);
		    view(pr.h_axes, 2)
		    shading(pr.h_axes, 'flat')
		    axis(pr.h_axes, 'equal', 'square', 'tight')
		    grid(pr.h_axes, 'off')
		    colorbar(pr.h_axes)
		    box(pr.h_axes, 'on')
		    set(pr.h_axes, ...
		        'XAxisLocation', 'top',  ...
		        'XTick', (1:1:N) - .5, ...
		        'XTickLabel', {},  ...
		        'YAxisLocation', 'left',  ...
		        'YDir', 'Reverse',  ...
		        'YTick', (1:1:N) - .5, ...
		        'YTickLabel', ylabels)
		
		    if ~verLessThan('matlab',  '8.4.0')
		        set(pr.h_axes, ...
		            'XTickLabelRotation',90, ...
		            'XTickLabel', xlabels)
		    else
		        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1,N), xlabels);
		        set(t, ...
		            'HorizontalAlignment', 'left',  ...
		            'VerticalAlignment', 'middle',  ...
		            'Rotation',90);
		    end
		
		    colormap(pr.h_axes, 'bone')
		
		    % output if needed
		    if nargout > 0
		        h = ht;
		    end
		end
		function h = hist(pr, A, varargin)
		    % HIST plots the histogram and density of a matrix
		    %
		    % H = HIST(A) plots the histogram of a matrix A and the associated density and
		    %   returns the handle to the plot H.
		    %
		    % H = HIST(A,'PropertyName',PropertyValue) sets the property of the histogram
		    %   plot PropertyName to PropertyValue.
		    %   All standard plot properties of surf can be used.
		    %   Additional admissive properties are:
		    %       bins       -   -1:.001:1 (default)
		    %       diagonal   -   'exclude' (default) | 'include'
		    %
		    % See also Graph, histogram.
		
		    [count, bins, density] = histogram(A, varargin{:});
		
		    bins = [bins(1) bins bins(end)];
		    count = [0 count 0];
		    density = [100 density 0];
		
		    hold(pr.h_axes, 'on')
		    cla(pr.h_axes)
		    ht1 = fill(pr.h_axes, bins, count, 'k');
		    ht2 = plot(bins, density, 'b', 'linewidth', 2, 'Parent', pr.h_axes);
		    hold(pr.h_axes, 'off')
		    xlabel(pr.h_axes, 'coefficient values / threshold')
		    ylabel(pr.h_axes, 'coefficient counts / density')
		
		    grid(pr.h_axes, 'off')
		    box(pr.h_axes, 'on')
		    colorbar(pr.h_axes, 'off')
		    axis(pr.h_axes, 'square', 'tight')
		    set(pr.h_axes, ...
		        'XAxisLocation', 'bottom',  ...
		        'XTickLabelMode', 'auto',  ...
		        'XTickMode', 'auto',  ...
		        'YTickLabelMode', 'auto',  ...
		        'YAxisLocation', 'left',  ...
		        'YDir', 'Normal',  ...
		        'YTickMode', 'auto',  ...
		        'YTickLabelMode', 'auto')
		
		    % output if needed
		    if nargout > 0
		        h = [ht1 ht2];
		    end
		end
	end
end
