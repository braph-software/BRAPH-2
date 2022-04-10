classdef PlotPropCell < PlotProp
	% PlotPropCell is a plot of a cell property.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PlotPropCell plots a CELL property of an element in a table.
	% It works for all categories.
	%
	% The list of PlotPropCell properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PlotPropCell methods (constructor):
	% PlotPropCell - constructor
	%
	% PlotPropCell methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property cell/error.
	%  existsProp - checks whether property exists in plot property cell/error.
	%  getPropNumber - returns the property number of plot property cell.
	%  getProps - returns the property list of plot property cell.
	%  getDescription - returns the description of the plot property cell.
	%  getName - returns the name of the plot property cell.
	%  getClass - returns the class of the plot property cell.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotPropCell methods:
	%  cb_table_value_cell - e_value_cell is a function.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content and permission of the table.
	%  draw - draws the panel of the cell property.
	%  cb_button_del - b_button_del is a function.
	%  cb_button_calc - _button_calc is a function.
	%  cb_button_cb - cb_button_cb is a function.
	%  set_settings - set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - /cb_close_fs is a function.
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
	% PlotPropCell methods (operators):
	%  isequal - determines whether two PlotPropCell are equal (values, locked)
	%
	% PlotPropCell methods (display):
	%  tostring - string with information about the PlotPropCell
	%  disp - displays information about the PlotPropCell
	%  tree - displays the element of PlotPropCell
	%
	% PlotPropCell method (element list):
	%  getElementList - returns a list with all subelements of PlotPropCell
	%
	% PlotPropCell method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotPropCell
	%
	% PlotPropCell method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotPropCell
	%
	% PlotPropCell methods (copy):
	%  copy - copies the PlotPropCell
	%  deepclone - deep-clones the PlotPropCell
	%  clone - clones the PlotPropCell
	%
	% PlotPropCell methods (inspection, Static):
	%  getClass - returns PlotPropCell
	%  getName - returns the name of PlotPropCell
	%  getDescription - returns the description of PlotPropCell
	%  getProps - returns the property list of PlotPropCell
	%  getPropNumber - returns the property number of PlotPropCell
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
	% PlotPropCell methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotPropCell methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotPropCell methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotPropCell methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotPropCell properties (Constant).
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
	% See also GUI, PlotElement, PlotProp.
	
	properties (Access = private) % element properties
		p
		table_value_cell
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property cell.
			%
			% CLASS = PlotPropCell.GETCLASS() returns the class 'PlotPropCell'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property cell PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotPropCell') returns 'PlotPropCell'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotPropCell';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property cell.
			%
			% NAME = PlotPropCell.GETNAME() returns the name of the 'plot property cell'.
			%  Plot Property Cell.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property cell PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotPropCell') returns the name of 'PlotPropCell'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Cell';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property cell.
			%
			% STR = PlotPropCell.GETDESCRIPTION() returns the description of the 'plot property cell'.
			%  which is:
			%
			%  PlotPropCell plots a CELL property of an element in a table.
			%  It works for all categories.
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property cell PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotPropCell') returns the description of 'PlotPropCell'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotPropCell plots a CELL property of an element in a table.' ...
				'It works for all categories.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property cell.
			%
			% PROPS = PlotPropCell.GETPROPS() returns the property list of plot property cell.
			%
			% PROPS = PlotPropCell.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property cell PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotPropCell'[, CATEGORY]) returns the property list of 'PlotPropCell'.
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
			%GETPROPNUMBER returns the property number of plot property cell.
			%
			% N = PlotPropCell.GETPROPNUMBER() returns the property number of plot property cell.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property cell PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotPropCell') returns the property number of 'PlotPropCell'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property cell/error.
			%
			% CHECK = PlotPropCell.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotPropCell, PROP) checks whether PROP exists for PlotPropCell.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotPropCell:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  Element.EXISTSPROP(PlotPropCell, PROP) throws error if PROP does NOT exist for PlotPropCell.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PlotPropCell.existsProp(prop), ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotPropCell.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property cell/error.
			%
			% CHECK = PlotPropCell.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotPropCell, TAG) checks whether TAG exists for PlotPropCell.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotPropCell:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  Element.EXISTSTAG(PlotPropCell, TAG) throws error if TAG does NOT exist for PlotPropCell.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropcell_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, plotpropcell_tag_list));
			else
				assert( ...
					PlotPropCell.existsTag(tag), ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotPropCell'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotPropCell, POINTER) returns property number of POINTER of PlotPropCell.
			%  PROPERTY = PR.GETPROPPROP(PlotPropCell, POINTER) returns property number of POINTER of PlotPropCell.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotpropcell_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PlotPropCell.existsTag(tag);
				
				prop = find(strcmpi(tag, plotpropcell_tag_list));
			else % numeric
				prop = pointer;
				PlotPropCell.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotPropCell, POINTER) returns tag of POINTER of PlotPropCell.
			%  TAG = PR.GETPROPTAG(PlotPropCell, POINTER) returns tag of POINTER of PlotPropCell.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotPropCell.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotPropCell.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotPropCell, POINTER) returns category of POINTER of PlotPropCell.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotPropCell, POINTER) returns category of POINTER of PlotPropCell.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PlotPropCell, POINTER) returns format of POINTER of PlotPropCell.
			%  FORMAT = PR.GETPROPFORMAT(PlotPropCell, POINTER) returns format of POINTER of PlotPropCell.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotPropCell, POINTER) returns description of POINTER of PlotPropCell.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotPropCell, POINTER) returns description of POINTER of PlotPropCell.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotPropCell, POINTER) returns settings of POINTER of PlotPropCell.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotPropCell, POINTER) returns settings of POINTER of PlotPropCell.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotPropCell.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropCell.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotPropCell, POINTER) returns the default value of POINTER of PlotPropCell.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotPropCell, POINTER) returns the default value of POINTER of PlotPropCell.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotPropCell.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotPropCell.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotPropCell, POINTER) returns the conditioned default value of POINTER of PlotPropCell.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotPropCell, POINTER) returns the conditioned default value of POINTER of PlotPropCell.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotPropCell.getPropProp(pointer);
			
			prop_default = PlotPropCell.conditioning(prop, PlotPropCell.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotPropCell, PROP, VALUE) checks VALUE format for PROP of PlotPropCell.
			%  CHECK = PR.CHECKPROP(PlotPropCell, PROP, VALUE) checks VALUE format for PROP of PlotPropCell.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotPropCell:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  Element.CHECKPROP(PlotPropCell, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropCell.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			%  PR.CHECKPROP(PlotPropCell, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotPropCell.
			%   Error id: [BRAPH2:PlotPropCell:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotPropCell.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotPropCell:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotPropCell.getPropTag(prop) ' (' PlotPropCell.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotPropCell(varargin)
			% PlotPropCell() creates a plot property cell.
			%
			% PlotPropCell(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotPropCell(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotPropCell properties is:
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
			prop = PlotPropCell.getPropProp(pointer);
			
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
		    
		    pr.p = draw@PlotProp(pr, varargin{:});
		    
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
		    
		    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
		    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
		    
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		
		    value = el.getr(prop);
		    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
		        pr.redraw@PlotProp('Height', h, varargin{:})
		    else
		        value_cell = el.get(prop);
		
		        if isempty(value_cell)
		            pr.redraw@PlotProp('Height', h, varargin{:})
		        else
		            pr.redraw@PlotProp('Height', h + Dh, varargin{:})
		        end
		        
		        for r = 1:1:size(value_cell, 1)
		            for c = 1:1:size(value_cell, 2)
		                table_w = (.98 - .01) / size(value_cell, 2);
		                table_h = (Dh / (h + Dh) - .02) / size(value_cell, 1);
		                set(pr.table_value_cell{r, c}, ...
		                    'Units', 'normalized', ...
		                    'Position', ...
		                        [ ...
		                            .01 + (c - 1) * table_w ...
		                            .02 + (size(value_cell, 1) - r) * table_h ...
		                            table_w ...
		                            table_h ...
		                        ] ...
		                    )
		            end
		        end
		    end    
		end
		function cb_table_value_cell(pr, r, c, i, j, newdata)
		    %CB_TABLE_VALUE_CELL executes callback for the cell tables.
		    %
		    % CB_TABLE_VALUE_CELL(PR, R, C, I, J, NEWDATA) executes callback for the cell tables.
		    %  It updates the value at position (I,J) of the matrix (R,C) with NEWDATA. 
		
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    value = el.get(prop);
		    value_rc = value{r, c};
		    value_rc(i, j) = newdata;
		    value{r, c} = value_rc;
		    el.set(prop, value)
		
		    pr.update()
		end
	end
end
