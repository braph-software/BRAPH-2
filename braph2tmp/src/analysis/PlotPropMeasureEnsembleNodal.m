classdef PlotPropMeasureEnsembleNodal < PlotPropMatrix
	% PlotPropMeasureEnsembleNodal represents the nodal measure ensemble.
	% It is a subclass of <a href="matlab:help PlotPropMatrix">PlotPropMatrix</a>.
	%
	% PlotPropMeasureEnsembleNodal represents the nodal measure ensemble.
	%
	% The list of PlotPropMeasureEnsembleNodal properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PlotPropMeasureEnsembleNodal methods (constructor):
	% PlotPropMeasureEnsembleNodal - constructor
	%
	% PlotPropMeasureEnsembleNodal methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot nodal measure ensemble/error.
	%  existsProp - checks whether property exists in plot nodal measure ensemble/error.
	%  getPropNumber - returns the property number of plot nodal measure ensemble.
	%  getProps - returns the property list of plot nodal measure ensemble.
	%  getDescription - returns the description of the plot nodal measure ensemble.
	%  getName - returns the name of the plot nodal measure ensemble.
	%  getClass - returns the class of the plot nodal measure ensemble.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotPropMeasureEnsembleNodal methods:
	%  get_button_condition - N returns the calculate button state.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws a table with the nodal measure.
	%  cb_matrix_value - nsembleNodal/cb_matrix_value is a function.
	%  cb_button_del - eEnsembleNodal/cb_button_del is a function.
	%  cb_button_calc - EnsembleNodal/cb_button_calc is a function.
	%  cb_button_cb - reEnsembleNodal/cb_button_cb is a function.
	%  set_settings - reEnsembleNodal/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - ureEnsembleNodal/cb_close_fs is a function.
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
	% PlotPropMeasureEnsembleNodal methods (operators):
	%  isequal - determines whether two PlotPropMeasureEnsembleNodal are equal (values, locked)
	%
	% PlotPropMeasureEnsembleNodal methods (display):
	%  tostring - string with information about the PlotPropMeasureEnsembleNodal
	%  disp - displays information about the PlotPropMeasureEnsembleNodal
	%  tree - displays the element of PlotPropMeasureEnsembleNodal
	%
	% PlotPropMeasureEnsembleNodal method (element list):
	%  getElementList - returns a list with all subelements of PlotPropMeasureEnsembleNodal
	%
	% PlotPropMeasureEnsembleNodal method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotPropMeasureEnsembleNodal
	%
	% PlotPropMeasureEnsembleNodal method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotPropMeasureEnsembleNodal
	%
	% PlotPropMeasureEnsembleNodal methods (copy):
	%  copy - copies the PlotPropMeasureEnsembleNodal
	%  deepclone - deep-clones the PlotPropMeasureEnsembleNodal
	%  clone - clones the PlotPropMeasureEnsembleNodal
	%
	% PlotPropMeasureEnsembleNodal methods (inspection, Static):
	%  getClass - returns PlotPropMeasureEnsembleNodal
	%  getName - returns the name of PlotPropMeasureEnsembleNodal
	%  getDescription - returns the description of PlotPropMeasureEnsembleNodal
	%  getProps - returns the property list of PlotPropMeasureEnsembleNodal
	%  getPropNumber - returns the property number of PlotPropMeasureEnsembleNodal
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
	% PlotPropMeasureEnsembleNodal methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotPropMeasureEnsembleNodal methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotPropMeasureEnsembleNodal methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotPropMeasureEnsembleNodal methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotPropMeasureEnsembleNodal properties (Constant).
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
	% See also GUI, PlotElement, PlotPropMatrix, AnalyzeEnsemble, MeasureEnsemble..
	
	properties (Access = private) % element properties
		p
		table_value
		slider
		slider_text
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot nodal measure ensemble.
			%
			% CLASS = PlotPropMeasureEnsembleNodal.GETCLASS() returns the class 'PlotPropMeasureEnsembleNodal'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot nodal measure ensemble PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotPropMeasureEnsembleNodal') returns 'PlotPropMeasureEnsembleNodal'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotPropMeasureEnsembleNodal';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot nodal measure ensemble.
			%
			% NAME = PlotPropMeasureEnsembleNodal.GETNAME() returns the name of the 'plot nodal measure ensemble'.
			%  Plot Nodal Measure Ensemble.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot nodal measure ensemble PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotPropMeasureEnsembleNodal') returns the name of 'PlotPropMeasureEnsembleNodal'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Nodal Measure Ensemble';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot nodal measure ensemble.
			%
			% STR = PlotPropMeasureEnsembleNodal.GETDESCRIPTION() returns the description of the 'plot nodal measure ensemble'.
			%  which is:
			%
			%  PlotPropMeasureEnsembleNodal represents the nodal measure ensemble.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot nodal measure ensemble PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotPropMeasureEnsembleNodal') returns the description of 'PlotPropMeasureEnsembleNodal'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotPropMeasureEnsembleNodal represents the nodal measure ensemble.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot nodal measure ensemble.
			%
			% PROPS = PlotPropMeasureEnsembleNodal.GETPROPS() returns the property list of plot nodal measure ensemble.
			%
			% PROPS = PlotPropMeasureEnsembleNodal.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot nodal measure ensemble PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotPropMeasureEnsembleNodal'[, CATEGORY]) returns the property list of 'PlotPropMeasureEnsembleNodal'.
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
			%GETPROPNUMBER returns the property number of plot nodal measure ensemble.
			%
			% N = PlotPropMeasureEnsembleNodal.GETPROPNUMBER() returns the property number of plot nodal measure ensemble.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot nodal measure ensemble PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotPropMeasureEnsembleNodal') returns the property number of 'PlotPropMeasureEnsembleNodal'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot nodal measure ensemble/error.
			%
			% CHECK = PlotPropMeasureEnsembleNodal.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotPropMeasureEnsembleNodal, PROP) checks whether PROP exists for PlotPropMeasureEnsembleNodal.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  Element.EXISTSPROP(PlotPropMeasureEnsembleNodal, PROP) throws error if PROP does NOT exist for PlotPropMeasureEnsembleNodal.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PlotPropMeasureEnsembleNodal.existsProp(prop), ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotPropMeasureEnsembleNodal.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot nodal measure ensemble/error.
			%
			% CHECK = PlotPropMeasureEnsembleNodal.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotPropMeasureEnsembleNodal, TAG) checks whether TAG exists for PlotPropMeasureEnsembleNodal.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  Element.EXISTSTAG(PlotPropMeasureEnsembleNodal, TAG) throws error if TAG does NOT exist for PlotPropMeasureEnsembleNodal.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropmeasureensemblenodal_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, plotpropmeasureensemblenodal_tag_list));
			else
				assert( ...
					PlotPropMeasureEnsembleNodal.existsTag(tag), ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotPropMeasureEnsembleNodal'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotPropMeasureEnsembleNodal, POINTER) returns property number of POINTER of PlotPropMeasureEnsembleNodal.
			%  PROPERTY = PR.GETPROPPROP(PlotPropMeasureEnsembleNodal, POINTER) returns property number of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropmeasureensemblenodal_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PlotPropMeasureEnsembleNodal.existsTag(tag);
				
				prop = find(strcmpi(tag, plotpropmeasureensemblenodal_tag_list));
			else % numeric
				prop = pointer;
				PlotPropMeasureEnsembleNodal.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotPropMeasureEnsembleNodal, POINTER) returns tag of POINTER of PlotPropMeasureEnsembleNodal.
			%  TAG = PR.GETPROPTAG(PlotPropMeasureEnsembleNodal, POINTER) returns tag of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotPropMeasureEnsembleNodal.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotPropMeasureEnsembleNodal.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotPropMeasureEnsembleNodal, POINTER) returns category of POINTER of PlotPropMeasureEnsembleNodal.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotPropMeasureEnsembleNodal, POINTER) returns category of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PlotPropMeasureEnsembleNodal, POINTER) returns format of POINTER of PlotPropMeasureEnsembleNodal.
			%  FORMAT = PR.GETPROPFORMAT(PlotPropMeasureEnsembleNodal, POINTER) returns format of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotPropMeasureEnsembleNodal, POINTER) returns description of POINTER of PlotPropMeasureEnsembleNodal.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotPropMeasureEnsembleNodal, POINTER) returns description of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotPropMeasureEnsembleNodal, POINTER) returns settings of POINTER of PlotPropMeasureEnsembleNodal.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotPropMeasureEnsembleNodal, POINTER) returns settings of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotPropMeasureEnsembleNodal.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropMeasureEnsembleNodal.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotPropMeasureEnsembleNodal, POINTER) returns the default value of POINTER of PlotPropMeasureEnsembleNodal.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotPropMeasureEnsembleNodal, POINTER) returns the default value of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotPropMeasureEnsembleNodal.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropMeasureEnsembleNodal.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotPropMeasureEnsembleNodal, POINTER) returns the conditioned default value of POINTER of PlotPropMeasureEnsembleNodal.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotPropMeasureEnsembleNodal, POINTER) returns the conditioned default value of POINTER of PlotPropMeasureEnsembleNodal.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
			prop_default = PlotPropMeasureEnsembleNodal.conditioning(prop, PlotPropMeasureEnsembleNodal.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotPropMeasureEnsembleNodal, PROP, VALUE) checks VALUE format for PROP of PlotPropMeasureEnsembleNodal.
			%  CHECK = PR.CHECKPROP(PlotPropMeasureEnsembleNodal, PROP, VALUE) checks VALUE format for PROP of PlotPropMeasureEnsembleNodal.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  Element.CHECKPROP(PlotPropMeasureEnsembleNodal, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropMeasureEnsembleNodal.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			%  PR.CHECKPROP(PlotPropMeasureEnsembleNodal, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropMeasureEnsembleNodal.
			%   Error id: [BRAPH2:PlotPropMeasureEnsembleNodal:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropMatrix(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropMeasureEnsembleNodal:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotPropMeasureEnsembleNodal.getPropTag(prop) ' (' PlotPropMeasureEnsembleNodal.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotPropMeasureEnsembleNodal(varargin)
			% PlotPropMeasureEnsembleNodal() creates a plot nodal measure ensemble.
			%
			% PlotPropMeasureEnsembleNodal(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotPropMeasureEnsembleNodal(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotPropMeasureEnsembleNodal properties is:
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
			prop = PlotPropMeasureEnsembleNodal.getPropProp(pointer);
			
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
		    %DRAW draws a table with the nodal measure.
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
		    
		    pr.p = draw@PlotPropMatrix(pr, varargin{:});
		
		    % retrieves the handle of the table
		    children = get(pr.p, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uitable')
		            pr.table_value = children(i);
		        end
		    end
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    L = size(value, 1);
		    map_multiplier = 100;
		    
		    if L == 1
		        Ll=1;
		    else
		        Ll = L-1;
		    end
		    
		    % set on first layer
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
		        'Visible', 'off', ...
		        'HorizontalAlignment', 'center', ...
		        'FontUnits', BRAPH2.FONTUNITS, ...
		        'FontSize', BRAPH2.FONTSIZE, ...
		        'FontWeight', 'normal', ...
		        'String', '', ...
		        'BackgroundColor', pr.get('BKGCOLOR') ...
		        );
		    
		    function cb_slider(~, ~)
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
		    
		    g_dict = el.get('A').get('G_DICT');
		    graph = g_dict.getItem(1);
		    br_dict = graph.get('BRAINATLAS').get('BR_DICT');
		    map_multiplier = 100;    
		    slider_tags = {'1'};
		    
		    if graph.getPropNumber() > 9
		        L_prop = graph.get(10);
		        label = graph.getPropTag(10);
		        if strcmp(label, 'thresholds')
		            label = 'Threshold';
		        elseif strcmp(label, 'densities')
		            label = 'Density';
		        end
		        L = size(L_prop, 2);
		        slider_tags = compose("%g", round(L_prop, 2));
		    else
		        label = 'Weighted';
		        set(pr.slider, 'Enable', 'off')
		    end
		    
		    br_ids = cell(br_dict.length(), 1);
		    for i = 1:1:br_dict.length()
		        br = br_dict.getItem(i);
		        br_id = br.get(BrainRegion.ID);
		        if length(br_id) > 10
		            br_id = [br_id(1:8) '..'];
		        end
		        br_ids{i} = br_id;
		    end
		
		    if isa(value, 'NoValue')
		        set(pr.table_value, ...
		            'ColumnName', {}, ...
		            'RowName', br_ids ...
		            )
		    else
		        if ~graph.getPropNumber() > 9
		            set(pr.slider_text, ...
		            'Visible', 'off');
		        else
		            set(pr.slider_text, ...
		                'Visible', 'on', ...
		                'String', [label ' ' num2str(round(get(pr.slider, 'Value') * map_multiplier)) ': ' slider_tags{round(get(pr.slider, 'Value') * map_multiplier)}]);
		        end
		        
		        set(pr.table_value, ...
		            'Data', value{round(get(pr.slider, 'Value') * map_multiplier)}, ...
		            'ColumnName', {}, ...
		            'RowName', br_ids ...
		            )
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
		    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
		    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    value = el.getr(prop);
		    L = size(value, 1);
		
		    if L > 1
		        pr.redraw@PlotProp('Height', h*2+Dh, varargin{:});
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
		
		        set(pr.table_value, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.2)] ...
		            )
		    else
		        set(pr.slider, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.slider_text, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.table_value, ...
		            'Visible', 'on', ...
		            'Units', 'normalized', ...
		            'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.09)] ...
		            )
		        pr.redraw@PlotProp('Height', h*2+Dh, varargin{:});
		    end
		    if ~pr.get_button_condition()
		        set(pr.slider, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.slider_text, ...
		            'Visible', 'off' ...
		            );
		
		        set(pr.table_value, ...
		            'Visible', 'off' ...
		            )
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
