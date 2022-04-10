classdef PPNNEvaluator_Feature_Map < PlotPropCell
	% PPNNEvaluator_Feature_Map is a plot of the feature map.
	% It is a subclass of <a href="matlab:help PlotPropCell">PlotPropCell</a>.
	%
	% PPNNEvaluator_Feature_Map plots the feature map with in a brain atlas.
	% CALLBACK - This is a callback function:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain viewer
	%     pr.<strong>cb_hide</strong>() - hides the brain viewer
	%     pr.<strong>cb_close</strong>() - closes the brain viewer
	%
	% The list of PPNNEvaluator_Feature_Map properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPNNEvaluator_Feature_Map methods (constructor):
	% PPNNEvaluator_Feature_Map - constructor
	%
	% PPNNEvaluator_Feature_Map methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property featur map/error.
	%  existsProp - checks whether property exists in plot property featur map/error.
	%  getPropNumber - returns the property number of plot property featur map.
	%  getProps - returns the property list of plot property featur map.
	%  getDescription - returns the description of the plot property featur map.
	%  getName - returns the name of the plot property featur map.
	%  getClass - returns the class of the plot property featur map.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPNNEvaluator_Feature_Map methods:
	%  cb_close - closes the figure.
	%  cb_hide - hides the brain atlas figure and its settings figure.
	%  cb_bring_to_front - brings to front the brain atlas figure and its settings figure.
	%  plot_brain_surface - or variables
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permission of the table.
	%  draw - draws the panel of the cell property.
	%  cb_table_value_cell - e_Map/cb_table_value_cell is a function.
	%  cb_button_del - Feature_Map/cb_button_del is a function.
	%  cb_button_calc - eature_Map/cb_button_calc is a function.
	%  cb_button_cb - _Feature_Map/cb_button_cb is a function.
	%  set_settings - _Feature_Map/set_settings is a function.
	%  cb_close_fs - r_Feature_Map/cb_close_fs is a function.
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
	% PPNNEvaluator_Feature_Map methods (operators):
	%  isequal - determines whether two PPNNEvaluator_Feature_Map are equal (values, locked)
	%
	% PPNNEvaluator_Feature_Map methods (display):
	%  tostring - string with information about the PPNNEvaluator_Feature_Map
	%  disp - displays information about the PPNNEvaluator_Feature_Map
	%  tree - displays the element of PPNNEvaluator_Feature_Map
	%
	% PPNNEvaluator_Feature_Map method (element list):
	%  getElementList - returns a list with all subelements of PPNNEvaluator_Feature_Map
	%
	% PPNNEvaluator_Feature_Map method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPNNEvaluator_Feature_Map
	%
	% PPNNEvaluator_Feature_Map method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPNNEvaluator_Feature_Map
	%
	% PPNNEvaluator_Feature_Map methods (copy):
	%  copy - copies the PPNNEvaluator_Feature_Map
	%  deepclone - deep-clones the PPNNEvaluator_Feature_Map
	%  clone - clones the PPNNEvaluator_Feature_Map
	%
	% PPNNEvaluator_Feature_Map methods (inspection, Static):
	%  getClass - returns PPNNEvaluator_Feature_Map
	%  getName - returns the name of PPNNEvaluator_Feature_Map
	%  getDescription - returns the description of PPNNEvaluator_Feature_Map
	%  getProps - returns the property list of PPNNEvaluator_Feature_Map
	%  getPropNumber - returns the property number of PPNNEvaluator_Feature_Map
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
	% PPNNEvaluator_Feature_Map methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPNNEvaluator_Feature_Map methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPNNEvaluator_Feature_Map methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPNNEvaluator_Feature_Map methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPNNEvaluator_Feature_Map properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, PlotPropcell.
	
	properties (Access = private) % element properties
		p
		table_value_cell
		plot_brain_btn
		f_brain
		f_settings
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property featur map.
			%
			% CLASS = PPNNEvaluator_Feature_Map.GETCLASS() returns the class 'PPNNEvaluator_Feature_Map'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property featur map PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPNNEvaluator_Feature_Map') returns 'PPNNEvaluator_Feature_Map'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPNNEvaluator_Feature_Map';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property featur map.
			%
			% NAME = PPNNEvaluator_Feature_Map.GETNAME() returns the name of the 'plot property featur map'.
			%  Plot Property Featur Map.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property featur map PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPNNEvaluator_Feature_Map') returns the name of 'PPNNEvaluator_Feature_Map'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Featur Map';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property featur map.
			%
			% STR = PPNNEvaluator_Feature_Map.GETDESCRIPTION() returns the description of the 'plot property featur map'.
			%  which is:
			%
			%  PPNNEvaluator_Feature_Map plots the feature map with in a brain atlas.
			%  CALLBACK - This is a callback function:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain viewer
			%      pr.<strong>cb_hide</strong>() - hides the brain viewer
			%      pr.<strong>cb_close</strong>() - closes the brain viewer
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property featur map PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPNNEvaluator_Feature_Map') returns the description of 'PPNNEvaluator_Feature_Map'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPNNEvaluator_Feature_Map plots the feature map with in a brain atlas.' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain viewer' ...
				'    pr.<strong>cb_hide</strong>() - hides the brain viewer' ...
				'    pr.<strong>cb_close</strong>() - closes the brain viewer' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property featur map.
			%
			% PROPS = PPNNEvaluator_Feature_Map.GETPROPS() returns the property list of plot property featur map.
			%
			% PROPS = PPNNEvaluator_Feature_Map.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property featur map PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPNNEvaluator_Feature_Map'[, CATEGORY]) returns the property list of 'PPNNEvaluator_Feature_Map'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotPropCell.getProps(Category.METADATA)
						];
				case Category.PARAMETER
					prop_list = [
						PlotPropCell.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotPropCell.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						PlotPropCell.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotPropCell.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotPropCell.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotPropCell.getProps()
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property featur map.
			%
			% N = PPNNEvaluator_Feature_Map.GETPROPNUMBER() returns the property number of plot property featur map.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property featur map PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPNNEvaluator_Feature_Map') returns the property number of 'PPNNEvaluator_Feature_Map'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property featur map/error.
			%
			% CHECK = PPNNEvaluator_Feature_Map.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPNNEvaluator_Feature_Map, PROP) checks whether PROP exists for PPNNEvaluator_Feature_Map.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  Element.EXISTSPROP(PPNNEvaluator_Feature_Map, PROP) throws error if PROP does NOT exist for PPNNEvaluator_Feature_Map.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPNNEvaluator_Feature_Map.existsProp(prop), ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPNNEvaluator_Feature_Map.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property featur map/error.
			%
			% CHECK = PPNNEvaluator_Feature_Map.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPNNEvaluator_Feature_Map, TAG) checks whether TAG exists for PPNNEvaluator_Feature_Map.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  Element.EXISTSTAG(PPNNEvaluator_Feature_Map, TAG) throws error if TAG does NOT exist for PPNNEvaluator_Feature_Map.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnnevaluator_feature_map_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppnnevaluator_feature_map_tag_list));
			else
				assert( ...
					PPNNEvaluator_Feature_Map.existsTag(tag), ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPNNEvaluator_Feature_Map'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPNNEvaluator_Feature_Map, POINTER) returns property number of POINTER of PPNNEvaluator_Feature_Map.
			%  PROPERTY = PR.GETPROPPROP(PPNNEvaluator_Feature_Map, POINTER) returns property number of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppnnevaluator_feature_map_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPNNEvaluator_Feature_Map.existsTag(tag);
				
				prop = find(strcmpi(tag, ppnnevaluator_feature_map_tag_list));
			else % numeric
				prop = pointer;
				PPNNEvaluator_Feature_Map.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPNNEvaluator_Feature_Map, POINTER) returns tag of POINTER of PPNNEvaluator_Feature_Map.
			%  TAG = PR.GETPROPTAG(PPNNEvaluator_Feature_Map, POINTER) returns tag of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPNNEvaluator_Feature_Map.existsTag(tag);
			else % numeric
				prop = pointer;
				PPNNEvaluator_Feature_Map.existsProp(prop);
				
				switch prop
					otherwise
						tag = getPropTag@PlotPropCell(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPNNEvaluator_Feature_Map, POINTER) returns category of POINTER of PPNNEvaluator_Feature_Map.
			%  CATEGORY = PR.GETPROPCATEGORY(PPNNEvaluator_Feature_Map, POINTER) returns category of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@PlotPropCell(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PPNNEvaluator_Feature_Map, POINTER) returns format of POINTER of PPNNEvaluator_Feature_Map.
			%  FORMAT = PR.GETPROPFORMAT(PPNNEvaluator_Feature_Map, POINTER) returns format of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@PlotPropCell(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPNNEvaluator_Feature_Map, POINTER) returns description of POINTER of PPNNEvaluator_Feature_Map.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPNNEvaluator_Feature_Map, POINTER) returns description of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_description = getPropDescription@PlotPropCell(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPNNEvaluator_Feature_Map, POINTER) returns settings of POINTER of PPNNEvaluator_Feature_Map.
			%  SETTINGS = PR.GETPROPSETTINGS(PPNNEvaluator_Feature_Map, POINTER) returns settings of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropCell(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPNNEvaluator_Feature_Map.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNEvaluator_Feature_Map.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPNNEvaluator_Feature_Map, POINTER) returns the default value of POINTER of PPNNEvaluator_Feature_Map.
			%  DEFAULT = PR.GETPROPDEFAULT(PPNNEvaluator_Feature_Map, POINTER) returns the default value of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropCell(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPNNEvaluator_Feature_Map.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPNNEvaluator_Feature_Map.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPNNEvaluator_Feature_Map, POINTER) returns the conditioned default value of POINTER of PPNNEvaluator_Feature_Map.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPNNEvaluator_Feature_Map, POINTER) returns the conditioned default value of POINTER of PPNNEvaluator_Feature_Map.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			prop_default = PPNNEvaluator_Feature_Map.conditioning(prop, PPNNEvaluator_Feature_Map.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPNNEvaluator_Feature_Map, PROP, VALUE) checks VALUE format for PROP of PPNNEvaluator_Feature_Map.
			%  CHECK = PR.CHECKPROP(PPNNEvaluator_Feature_Map, PROP, VALUE) checks VALUE format for PROP of PPNNEvaluator_Feature_Map.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  Element.CHECKPROP(PPNNEvaluator_Feature_Map, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNEvaluator_Feature_Map.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			%  PR.CHECKPROP(PPNNEvaluator_Feature_Map, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPNNEvaluator_Feature_Map.
			%   Error id: [BRAPH2:PPNNEvaluator_Feature_Map:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropCell(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPNNEvaluator_Feature_Map:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPNNEvaluator_Feature_Map.getPropTag(prop) ' (' PPNNEvaluator_Feature_Map.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPNNEvaluator_Feature_Map(varargin)
			% PPNNEvaluator_Feature_Map() creates a plot property featur map.
			%
			% PPNNEvaluator_Feature_Map(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPNNEvaluator_Feature_Map(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPNNEvaluator_Feature_Map properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotPropCell(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPNNEvaluator_Feature_Map.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotPropCell.getPropNumber()
						value = conditioning@PlotPropCell(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the panel of the cell property.
		    %
		    % DRAW(PR) draws the panel of the cell property.
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
		    
		    pr.p = draw@PlotPropCell(pr, varargin{:});
		    
		    pr.plot_brain_btn = uicontrol(pr.p, ...
		        'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [0.01 0.01 0.97 0.1], ...
		        'String', 'Plot the map', ...
		        'TooltipString', 'Plot the feature map in a brain surface.' , ...
		        'Callback', {@cb_plot_brain} ...
		        );
		    
		    function cb_plot_brain(~, ~)
		        drawnow()
		        pr.plot_brain_surface();
		        pr.update()
		    end
		    
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content and permission of the table.
		    %
		    % UPDATE(PR) updates the content and permission of the table.
		    %
		    % See also draw, redraw, refresh, PlotElement.
		    
		    update@PlotProp(pr)
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    value = el.getr(prop);
		    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
		        % don't plot anything for a result not yet calculated
		    else
		        value_cell = el.get(prop);
		        if isempty(pr.table_value_cell) || ~isequal(size(pr.table_value_cell), size(value_cell))
		            pr.table_value_cell = cell(size(value_cell));
		        end
		        for r = 1:1:size(pr.table_value_cell, 1)
		            for c = 1:1:size(pr.table_value_cell, 2)
		                if ~check_graphics(pr.table_value_cell{r, c}, 'uitable')
		                    pr.table_value_cell{r, c} = uitable('Parent', pr.p);
		                end
		                set(pr.table_value_cell{r, c}, ...
		                    'Data', value_cell{r, c}, ...
		                    'Tooltip', [num2str(r) ' ' num2str(c)], ...
		                    'FontUnits', BRAPH2.FONTUNITS, ...
		                    'FontSize', BRAPH2.FONTSIZE, ...
		                    'ColumnEditable', true, ...
		                    'CellEditCallback', {@cb_table_value_cell, r, c} ...
		                    )
		            end
		        end
		    end
		
		    function cb_table_value_cell(~, event, r, c) % (src, event)
		        pr.cb_table_value_cell(r, c, event.Indices(1), event.Indices(2), event.NewData)
		    end
		
		    if check_graphics(pr.f_brain, 'figure')
		        % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
		        set(pr.plot_brain_btn, 'Enable', 'off');
		    else
		        % enables creation of a PlotBrainAtlas figure
		        set(pr.plot_brain_btn, 'Enable', 'on');
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
		    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH)
		    %  repositions the property panel. It is possible to use a
		    %  subset of the Name-Value pairs.
		    %  By default:
		    %  - X0 does not change
		    %  - Y0 does not change
		    %  - WIDTH does not change
		    %  - HEIGHT=1.8 minimum height when no cell to show
		    %  - DHEIGHT=20 additional height when data to show
		    %
		    % See also draw, update, refresh, PlotElement.
		    
		    
		    redraw@PlotProp(pr);
		    
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(18, 'DHeight', varargin);
		    child_uitable = [];
		    children = pr.p.Children;
		    for i = 1:length(children)
		        if children(i).Type == "uitable"
		            child_uitable = children(i);
		            break
		        end
		    end
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    value = el.getr(prop);
		    
		    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
		        if isgraphics(child_uitable)
		            set(child_uitable, 'Visible', 'off');
		        end
		        set(pr.plot_brain_btn, 'Visible', 'off');
		        if isgraphics(pr.f_brain)
		            delete(pr.f_brain)
		        end
		        pr.redraw@PlotProp('Height', h, varargin{:})
		    else
		        value_cell = el.get(prop);
		    
		        if isempty(value_cell)
		            set(pr.plot_brain_btn, 'Visible', 'off');
		            if isgraphics(child_uitable)
		                set(child_uitable, 'Visible', 'off');
		            end
		            pr.redraw@PlotProp('Height', h, varargin{:})
		        else
		            set(pr.plot_brain_btn, 'Visible', 'on');
		            if isgraphics(child_uitable)
		                set(child_uitable, 'Visible', 'on');
		            end
		            pr.redraw@PlotProp('Height', h + Dh + 4, varargin{:})
		        end
		    
		        for r = 1:1:size(value_cell, 1)
		            for c = 1:1:size(value_cell, 2)
		                table_w = (.98 - .01) / size(value_cell, 2);
		                table_h = (Dh / (h + Dh) - .01) / size(value_cell, 1);
		                set(pr.table_value_cell{r, c}, ...
		                    'Units', 'normalized', ...
		                    'Position', ...
		                    [ ...
		                    .01 + (c - 1) * table_w ...
		                    .02 + (size(value_cell, 1) - r) * table_h + 0.1 ...
		                    table_w ...
		                    table_h - 0.1  ...
		                    ] ...
		                    )
		            end
		        end
		    end
		end
		function plot_brain_surface(pr)
		    % define constants or variables
		    el = pr.get('el');
		    prop = pr.get('prop');
		    sub = el.get('GR').get('SUB_DICT').getItem(1);
		    surf = sub.get('BA').get('SURF');
		    
		    f_ba = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
		    f_ba_x = Plot.x0(f_ba, 'pixels');
		    f_ba_y = Plot.y0(f_ba, 'pixels');
		    f_ba_w = Plot.w(f_ba, 'pixels');
		    f_ba_h = Plot.h(f_ba, 'pixels');
		    
		    screen_x = Plot.x0(0, 'pixels');
		    screen_y = Plot.y0(0, 'pixels');
		    screen_w = Plot.w(0, 'pixels');
		    screen_h = Plot.h(0, 'pixels');
		    
		    % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
		    x = f_ba_x + f_ba_w;
		    h = f_ba_h / 1.61;
		    y = f_ba_y + f_ba_h - h;
		    w = f_ba_w * 1.61;
		    
		    pr.f_brain = figure( ...
		        'NumberTitle', 'off', ...
		        'Units', 'normalized', ...
		        'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		        'CloseRequestFcn', {@cb_f_pba_close} ...
		        );
		    
		    set_braph2icon(pr.f_brain)
		    set(pr.f_brain, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
		    menu_about = BRAPH2.add_menu_about(pr.f_brain);
		    ui_toolbar = findall(pr.f_brain, 'Tag', 'FigureToolBar');
		    delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
		    delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
		    
		    pba = PlotBrainNN('SURF', surf, 'NNEL', el, 'ATLAS', sub.get('BA'));
		    pba.draw('Parent', pr.f_brain)
		    
		    % Plot settings panel
		    pr.f_settings = pba.settings();
		    set(pr.f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h]);
		    pr.f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
		    pr.f_settings.OuterPosition(2) = f_ba_y/screen_h;
		
		    function cb_f_pba_close(~, ~)
		        delete(pr.f_brain)
		        pr.update()
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
		    
		    if isgraphics(pr.f_brain)
		        set(pr.f_brain, 'Visible', 'on');
		        set(pr.f_settings, 'Visible', 'on');
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
		
		    if isgraphics(pr.f_brain)
		        set(pr.f_brain, 'Visible', 'off');
		        set(pr.f_settings, 'Visible', 'off');
		    end
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure.
		    %
		    % CB_CLOSE(PR) closes the figure and its children figures.
		    %
		    % See also cb_bring_to_front, cd_hide.
		    
		    pr.cb_close@PlotProp();
		
		    if isgraphics(pr.f_brain)
		        delete(pr.f_brain);
		    end
		end
	end
end
