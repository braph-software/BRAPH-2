classdef PlotPropMeasureEnsembleGlobalMultilayer < PlotPropScalar
	% PlotPropMeasureEnsembleGlobalMultilayer represents the nodal measure ensemble mp.
	% It is a subclass of <a href="matlab:help PlotPropScalar">PlotPropScalar</a>.
	%
	% PlotPropMeasureEnsembleGlobalMultilayer represents the global measure ensemble mp.
	%
	% The list of PlotPropMeasureEnsembleGlobalMultilayer properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (constructor):
	% PlotPropMeasureEnsembleGlobalMultilayer - constructor
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot global measure ensemble mp/error.
	%  existsProp - checks whether property exists in plot global measure ensemble mp/error.
	%  getPropNumber - returns the property number of plot global measure ensemble mp.
	%  getProps - returns the property list of plot global measure ensemble mp.
	%  getDescription - returns the description of the plot global measure ensemble mp.
	%  getName - returns the name of the plot global measure ensemble mp.
	%  getClass - returns the class of the plot global measure ensemble mp.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods:
	%  get_button_condition - N returns the calculate button state.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws a table with the global measure.
	%  cb_edit_value - eEnsembleGlobalMultilayer/cb_edit_value is a function.
	%  cb_button_del - eEnsembleGlobalMultilayer/cb_button_del is a function.
	%  cb_button_calc - EnsembleGlobalMultilayer/cb_button_calc is a function.
	%  cb_button_cb - reEnsembleGlobalMultilayer/cb_button_cb is a function.
	%  set_settings - reEnsembleGlobalMultilayer/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - ureEnsembleGlobalMultilayer/cb_close_fs is a function.
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
	% PlotPropMeasureEnsembleGlobalMultilayer methods (operators):
	%  isequal - determines whether two PlotPropMeasureEnsembleGlobalMultilayer are equal (values, locked)
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (display):
	%  tostring - string with information about the PlotPropMeasureEnsembleGlobalMultilayer
	%  disp - displays information about the PlotPropMeasureEnsembleGlobalMultilayer
	%  tree - displays the element of PlotPropMeasureEnsembleGlobalMultilayer
	%
	% PlotPropMeasureEnsembleGlobalMultilayer method (element list):
	%  getElementList - returns a list with all subelements of PlotPropMeasureEnsembleGlobalMultilayer
	%
	% PlotPropMeasureEnsembleGlobalMultilayer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotPropMeasureEnsembleGlobalMultilayer
	%
	% PlotPropMeasureEnsembleGlobalMultilayer method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotPropMeasureEnsembleGlobalMultilayer
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (copy):
	%  copy - copies the PlotPropMeasureEnsembleGlobalMultilayer
	%  deepclone - deep-clones the PlotPropMeasureEnsembleGlobalMultilayer
	%  clone - clones the PlotPropMeasureEnsembleGlobalMultilayer
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (inspection, Static):
	%  getClass - returns PlotPropMeasureEnsembleGlobalMultilayer
	%  getName - returns the name of PlotPropMeasureEnsembleGlobalMultilayer
	%  getDescription - returns the description of PlotPropMeasureEnsembleGlobalMultilayer
	%  getProps - returns the property list of PlotPropMeasureEnsembleGlobalMultilayer
	%  getPropNumber - returns the property number of PlotPropMeasureEnsembleGlobalMultilayer
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
	% PlotPropMeasureEnsembleGlobalMultilayer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotPropMeasureEnsembleGlobalMultilayer methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotPropMeasureEnsembleGlobalMultilayer properties (Constant).
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
	% See also GUI, PlotElement, PlotPropString, AnalyzeEnsemble, MeasureEnsemble..
	
	properties (Access = private) % element properties
		p
		edit_value
		slider
		slider_text
		extra_slider
		extra_text
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot global measure ensemble mp.
			%
			% CLASS = PlotPropMeasureEnsembleGlobalMultilayer.GETCLASS() returns the class 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot global measure ensemble mp PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotPropMeasureEnsembleGlobalMultilayer') returns 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotPropMeasureEnsembleGlobalMultilayer';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot global measure ensemble mp.
			%
			% NAME = PlotPropMeasureEnsembleGlobalMultilayer.GETNAME() returns the name of the 'plot global measure ensemble mp'.
			%  Plot Global Measure Ensemble Mp.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot global measure ensemble mp PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotPropMeasureEnsembleGlobalMultilayer') returns the name of 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Global Measure Ensemble Mp';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot global measure ensemble mp.
			%
			% STR = PlotPropMeasureEnsembleGlobalMultilayer.GETDESCRIPTION() returns the description of the 'plot global measure ensemble mp'.
			%  which is:
			%
			%  PlotPropMeasureEnsembleGlobalMultilayer represents the global measure ensemble mp.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot global measure ensemble mp PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotPropMeasureEnsembleGlobalMultilayer') returns the description of 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotPropMeasureEnsembleGlobalMultilayer represents the global measure ensemble mp.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot global measure ensemble mp.
			%
			% PROPS = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPS() returns the property list of plot global measure ensemble mp.
			%
			% PROPS = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot global measure ensemble mp PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotPropMeasureEnsembleGlobalMultilayer'[, CATEGORY]) returns the property list of 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropScalar.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropScalar.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropScalar.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropScalar.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropScalar.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropScalar.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropScalar.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot global measure ensemble mp.
			%
			% N = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPNUMBER() returns the property number of plot global measure ensemble mp.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot global measure ensemble mp PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotPropMeasureEnsembleGlobalMultilayer') returns the property number of 'PlotPropMeasureEnsembleGlobalMultilayer'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot global measure ensemble mp/error.
			%
			% CHECK = PlotPropMeasureEnsembleGlobalMultilayer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP) checks whether PROP exists for PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  Element.EXISTSPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP) throws error if PROP does NOT exist for PlotPropMeasureEnsembleGlobalMultilayer.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PlotPropMeasureEnsembleGlobalMultilayer.existsProp(prop), ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotPropMeasureEnsembleGlobalMultilayer.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot global measure ensemble mp/error.
			%
			% CHECK = PlotPropMeasureEnsembleGlobalMultilayer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotPropMeasureEnsembleGlobalMultilayer, TAG) checks whether TAG exists for PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  Element.EXISTSTAG(PlotPropMeasureEnsembleGlobalMultilayer, TAG) throws error if TAG does NOT exist for PlotPropMeasureEnsembleGlobalMultilayer.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropmeasureensembleglobalmultilayer_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, plotpropmeasureensembleglobalmultilayer_tag_list));
			else
				assert( ...
					PlotPropMeasureEnsembleGlobalMultilayer.existsTag(tag), ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotPropMeasureEnsembleGlobalMultilayer'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns property number of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  PROPERTY = PR.GETPROPPROP(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns property number of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropmeasureensembleglobalmultilayer_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PlotPropMeasureEnsembleGlobalMultilayer.existsTag(tag);
				
				prop = find(strcmpi(tag, plotpropmeasureensembleglobalmultilayer_tag_list));
			else % numeric
				prop = pointer;
				PlotPropMeasureEnsembleGlobalMultilayer.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns tag of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  TAG = PR.GETPROPTAG(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns tag of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotPropMeasureEnsembleGlobalMultilayer.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotPropMeasureEnsembleGlobalMultilayer.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropScalar(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns category of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns category of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropScalar(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns format of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  FORMAT = PR.GETPROPFORMAT(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns format of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropScalar(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns description of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns description of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotPropScalar(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns settings of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns settings of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropScalar(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns the default value of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns the default value of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropScalar(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropMeasureEnsembleGlobalMultilayer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns the conditioned default value of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotPropMeasureEnsembleGlobalMultilayer, POINTER) returns the conditioned default value of POINTER of PlotPropMeasureEnsembleGlobalMultilayer.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			prop_default = PlotPropMeasureEnsembleGlobalMultilayer.conditioning(prop, PlotPropMeasureEnsembleGlobalMultilayer.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP, VALUE) checks VALUE format for PROP of PlotPropMeasureEnsembleGlobalMultilayer.
			%  CHECK = PR.CHECKPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP, VALUE) checks VALUE format for PROP of PlotPropMeasureEnsembleGlobalMultilayer.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  Element.CHECKPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropMeasureEnsembleGlobalMultilayer.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			%  PR.CHECKPROP(PlotPropMeasureEnsembleGlobalMultilayer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropMeasureEnsembleGlobalMultilayer.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleGlobalMultilayer:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropScalar(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleGlobalMultilayer:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotPropMeasureEnsembleGlobalMultilayer.getPropTag(prop) ' (' PlotPropMeasureEnsembleGlobalMultilayer.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotPropMeasureEnsembleGlobalMultilayer(varargin)
			% PlotPropMeasureEnsembleGlobalMultilayer() creates a plot global measure ensemble mp.
			%
			% PlotPropMeasureEnsembleGlobalMultilayer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotPropMeasureEnsembleGlobalMultilayer(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotPropMeasureEnsembleGlobalMultilayer properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropScalar(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotPropMeasureEnsembleGlobalMultilayer.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropScalar.getPropNumber()
						value = conditioning@PlotPropScalar(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws a table with the global measure.
		    %
		    % DRAW(PR) draws the property panel a table with the structural data of 
		    %  a subject.
		    %
		    % H = DRAW(PR) returns a handle to the property panel.
		    %
		    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel 
		    %  with custom Name-Value pairs.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle H of the panel.
		    %
		    % See also update, redraw, settings, uipanel.
		    
		    pr.p = draw@PlotPropScalar(pr, varargin{:});
		
		    % retrieves the handle of the table
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'edit')
		            pr.edit_value = children(i);
		        end
		    end
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    L = size(value, 1);
		    label = 'Layer';
		    g = el.get('A').get('G_DICT').getItem(1);
		    check = g.getPropNumber() > 9;
		    map_multiplier = 100;
		    
		    if check  % bud
		        n = length(g.get(10)); % 10 is densities or thresholds
		        L = size(value, 1) / n;
		        label = g.getPropTag(10);
		    else
		        n = 1;
		    end
		    
		    if L == 1
		        Ll = 1;
		    else
		        Ll = L-1;
		    end
		    
		    if n == 1
		        nn = 1;
		    else
		        nn = n-1;
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
		    
		    function cb_slider(~, ~)
		        pr.update()
		    end
		
		    if check
		        pr.extra_slider = uicontrol( ...
		            'Parent', pr.p, ...
		            'Style', 'slider', ...
		            'Units', 'characters', ...
		            'Visible', 'off', ...
		            'Value', 1 / map_multiplier, ...
		            'Min', 1 / map_multiplier, ...
		            'Max', n / map_multiplier, ...
		            'SliderStep', [map_multiplier/(nn*map_multiplier) map_multiplier/(nn*map_multiplier)] , ...
		            'Callback', {@cb_slider_layer} ...
		            );
		        pr.extra_text = uicontrol(...
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
		
		        function cb_slider_layer(~, ~)
		            pr.update()
		        end
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content of the property panel and its graphical objects.
		    %
		    % UPDATE(PR) updates the content of the property panel and its graphical objects.
		    %
		    % Important note:
		    % 1. UPDATE() is typically called internally by PlotElement and does not need 
		    %  to be explicitly called in children of PlotProp.
		    %
		    % See also draw, redraw, PlotElement.
		
		    update@PlotProp(pr)
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    label = 'Layer';
		    g = el.get('A').get('G_DICT').getItem(1);
		    check = g.getPropNumber() > 9;
		    map_multiplier = 100;
		    
		    slider_tags = {'1'};
		    extra_label = '';
		    if check
		        n = length(g.get(10)); % 10 is densities or thresholds
		        L = size(value, 1) / n;
		        label = g.getPropTag(10);
		        if strcmp(label, 'thresholds')
		            label = 'Threshold';
		        elseif strcmp(label, 'densities')
		            label = 'Density';
		            extra_label = '%';
		        end
		        slider_tags = compose("%g", round(g.get(10), 2));
		    else
		        n = 1;
		    end
		    
		    if isa(value, 'NoValue')
		        set(pr.slider_text, ...
		            'String', [num2str(round(get(pr.slider, 'Value') * map_multiplier))]);
		        set(pr.edit_value, ...
		            'String', 'No Value', ...
		            'Enable', pr.get('ENABLE') ...
		            )
		    else
		        set(pr.slider_text, ...
		            'String', ['Layer ' num2str(round(get(pr.slider, 'Value') * map_multiplier))]);
		        
		        if check
		            
		            set(pr.extra_text, ...
		                'String', [label ' ' num2str(round(get(pr.extra_slider, 'Value') * map_multiplier))]);
		            
		            % get the correct index
		            l = round(get(pr.slider, 'Value') * map_multiplier); % layer
		            d = round(get(pr.extra_slider, 'Value') * map_multiplier); % threshold or ddensity
		            
		            correct_i =  (d * L)- L + l ;
		            
		            if isempty(l) || isempty(d) % superglobal
		                set(pr.edit_value, ...
		                    'String', value{d}, ...
		                    'Enable', pr.get('ENABLE') ...
		                    )
		            else
		                set(pr.edit_value, ...
		                    'String', value{correct_i}, ...
		                    'Enable', pr.get('ENABLE') ...
		                    )
		            end
		        else % wu
		            if ~isempty(pr.slider)
		                set(pr.edit_value, ...
		                    'String', value{round(get(pr.slider, 'Value') * map_multiplier)}, ...
		                    'Enable', pr.get('ENABLE') ...
		                    )
		            else % superglobal
		                set(pr.edit_value, ...
		                    'String', value{1}, ...
		                    'Enable', pr.get('ENABLE') ...
		                    )
		            end
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
		    %  - HEIGHT=1.4 characters.
		    %
		    % See also draw, update, PlotElement.
		    
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Sh, varargin] = get_and_remove_from_varargin(1.8, 'SHeight', varargin);
		    [Th, varargin] = get_and_remove_from_varargin(1.8, 'THeight', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(2, 'DHeight', varargin);
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.get(prop);
		    L = size(value, 1);
		    n = 0;
		    g = el.get('A').get('G_DICT').getItem(1);
		    check = g.getPropNumber() > 9;
		    if check
		        n = length(g.get(10)); % 10 is densities or thresholds
		    end
		    
		    if n > 1
		        pr.redraw@PlotPropScalar('Height', h+Sh+Th+Sh+Th+Dh, varargin{:});
		        set(pr.slider, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Sh+Th+Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.1 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.slider_text, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Sh+Th+Th+Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.1 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.extra_slider, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.1 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.extra_text, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Dh+Th+h)/(h+Sh+Sh+Th+Th+Dh)-.1 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.edit_value, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
		            )
		    else
		        pr.redraw@PlotPropScalar('Height', h+Sh+Th+Dh, varargin{:});
		        set(pr.slider, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Dh+h)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.slider_text, ...
		            'Units', 'normalized', ...
		            'Visible', 'on', ...
		            'Position', [.01 (Th+Dh+h)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
		            );
		        
		        set(pr.edit_value, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 ((Dh+h)/(h+Sh+Th+Dh)-.02)] ...
		            )
		    end
		    if ~pr.get_button_condition()
		        set(pr.slider, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.slider_text, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.edit_value, ...
		            'Visible', 'off' ...
		            )
		
		        if ~isempty(pr.layer_slider) && ~isempty(pr.layer_text)
		            set(pr.layer_slider, ...
		                'Visible', 'off' ...
		                );
		
		            set(pr.layer_text, ...
		                'Visible', 'off' ...
		                );
		
		        end
		        pr.redraw@PlotProp(varargin{:});
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
