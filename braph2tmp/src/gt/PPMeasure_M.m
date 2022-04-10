classdef PPMeasure_M < PlotProp
	% PPMeasure_M is a plot of property M of measure.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPMeasure_M plots a Measure result.
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
	%
	% The list of PPMeasure_M properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPMeasure_M methods (constructor):
	% PPMeasure_M - constructor
	%
	% PPMeasure_M methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property M of measure/error.
	%  existsProp - checks whether property exists in plot property M of measure/error.
	%  getPropNumber - returns the property number of plot property M of measure.
	%  getProps - returns the property list of plot property M of measure.
	%  getDescription - returns the description of the plot property M of measure.
	%  getName - returns the name of the plot property M of measure.
	%  getClass - returns the class of the plot property M of measure.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPMeasure_M methods:
	%  get_button_condition - N returns the calculate button state.
	%  cb_close - closes the figure.
	%  cb_hide - hides the figure and its settings figure.
	%  cb_bring_to_front - brings to front the figure and its settings figure.
	%  cb_brain_view_fig - in_view_fig is a function.
	%  redraw - redraws the element graphical panel.
	%  update - updates the content of the property graphical panel.
	%  draw - draws the idict for group ensemble property graphical panel.
	%  cb_button_del - _button_del is a function.
	%  cb_button_calc - button_calc is a function.
	%  cb_button_cb - b_button_cb is a function.
	%  set_settings - et_settings is a function.
	%  cb_close_fs - cb_close_fs is a function.
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
	% PPMeasure_M methods (operators):
	%  isequal - determines whether two PPMeasure_M are equal (values, locked)
	%
	% PPMeasure_M methods (display):
	%  tostring - string with information about the PPMeasure_M
	%  disp - displays information about the PPMeasure_M
	%  tree - displays the element of PPMeasure_M
	%
	% PPMeasure_M method (element list):
	%  getElementList - returns a list with all subelements of PPMeasure_M
	%
	% PPMeasure_M method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPMeasure_M
	%
	% PPMeasure_M method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPMeasure_M
	%
	% PPMeasure_M methods (copy):
	%  copy - copies the PPMeasure_M
	%  deepclone - deep-clones the PPMeasure_M
	%  clone - clones the PPMeasure_M
	%
	% PPMeasure_M methods (inspection, Static):
	%  getClass - returns PPMeasure_M
	%  getName - returns the name of PPMeasure_M
	%  getDescription - returns the description of PPMeasure_M
	%  getProps - returns the property list of PPMeasure_M
	%  getPropNumber - returns the property number of PPMeasure_M
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
	% PPMeasure_M methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPMeasure_M methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPMeasure_M methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPMeasure_M methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPMeasure_M properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT..
	
	properties (Access = private) % element properties
		p
		f_br
		br_type
		br_btn
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property M of measure.
			%
			% CLASS = PPMeasure_M.GETCLASS() returns the class 'PPMeasure_M'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property M of measure PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPMeasure_M') returns 'PPMeasure_M'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPMeasure_M';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property M of measure.
			%
			% NAME = PPMeasure_M.GETNAME() returns the name of the 'plot property M of measure'.
			%  Plot Property M Of Measure.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property M of measure PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPMeasure_M') returns the name of 'PPMeasure_M'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property M Of Measure';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property M of measure.
			%
			% STR = PPMeasure_M.GETDESCRIPTION() returns the description of the 'plot property M of measure'.
			%  which is:
			%
			%  PPMeasure_M plots a Measure result.
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property M of measure PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPMeasure_M') returns the description of 'PPMeasure_M'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPMeasure_M plots a Measure result.' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property M of measure.
			%
			% PROPS = PPMeasure_M.GETPROPS() returns the property list of plot property M of measure.
			%
			% PROPS = PPMeasure_M.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property M of measure PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPMeasure_M'[, CATEGORY]) returns the property list of 'PPMeasure_M'.
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
			%GETPROPNUMBER returns the property number of plot property M of measure.
			%
			% N = PPMeasure_M.GETPROPNUMBER() returns the property number of plot property M of measure.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property M of measure PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPMeasure_M') returns the property number of 'PPMeasure_M'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property M of measure/error.
			%
			% CHECK = PPMeasure_M.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPMeasure_M, PROP) checks whether PROP exists for PPMeasure_M.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  Element.EXISTSPROP(PPMeasure_M, PROP) throws error if PROP does NOT exist for PPMeasure_M.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPMeasure_M.existsProp(prop), ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPMeasure_M.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property M of measure/error.
			%
			% CHECK = PPMeasure_M.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPMeasure_M, TAG) checks whether TAG exists for PPMeasure_M.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  Element.EXISTSTAG(PPMeasure_M, TAG) throws error if TAG does NOT exist for PPMeasure_M.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppmeasure_m_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppmeasure_m_tag_list));
			else
				assert( ...
					PPMeasure_M.existsTag(tag), ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPMeasure_M'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPMeasure_M, POINTER) returns property number of POINTER of PPMeasure_M.
			%  PROPERTY = PR.GETPROPPROP(PPMeasure_M, POINTER) returns property number of POINTER of PPMeasure_M.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppmeasure_m_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPMeasure_M.existsTag(tag);
				
				prop = find(strcmpi(tag, ppmeasure_m_tag_list));
			else % numeric
				prop = pointer;
				PPMeasure_M.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPMeasure_M, POINTER) returns tag of POINTER of PPMeasure_M.
			%  TAG = PR.GETPROPTAG(PPMeasure_M, POINTER) returns tag of POINTER of PPMeasure_M.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPMeasure_M.existsTag(tag);
			else % numeric
				prop = pointer;
				PPMeasure_M.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPMeasure_M, POINTER) returns category of POINTER of PPMeasure_M.
			%  CATEGORY = PR.GETPROPCATEGORY(PPMeasure_M, POINTER) returns category of POINTER of PPMeasure_M.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PPMeasure_M, POINTER) returns format of POINTER of PPMeasure_M.
			%  FORMAT = PR.GETPROPFORMAT(PPMeasure_M, POINTER) returns format of POINTER of PPMeasure_M.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPMeasure_M, POINTER) returns description of POINTER of PPMeasure_M.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPMeasure_M, POINTER) returns description of POINTER of PPMeasure_M.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPMeasure_M, POINTER) returns settings of POINTER of PPMeasure_M.
			%  SETTINGS = PR.GETPROPSETTINGS(PPMeasure_M, POINTER) returns settings of POINTER of PPMeasure_M.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPMeasure_M.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPMeasure_M.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPMeasure_M, POINTER) returns the default value of POINTER of PPMeasure_M.
			%  DEFAULT = PR.GETPROPDEFAULT(PPMeasure_M, POINTER) returns the default value of POINTER of PPMeasure_M.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPMeasure_M.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPMeasure_M.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPMeasure_M, POINTER) returns the conditioned default value of POINTER of PPMeasure_M.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPMeasure_M, POINTER) returns the conditioned default value of POINTER of PPMeasure_M.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
			prop_default = PPMeasure_M.conditioning(prop, PPMeasure_M.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPMeasure_M, PROP, VALUE) checks VALUE format for PROP of PPMeasure_M.
			%  CHECK = PR.CHECKPROP(PPMeasure_M, PROP, VALUE) checks VALUE format for PROP of PPMeasure_M.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPMeasure_M:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  Element.CHECKPROP(PPMeasure_M, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPMeasure_M.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			%  PR.CHECKPROP(PPMeasure_M, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPMeasure_M.
			%   Error id: [BRAPH2:PPMeasure_M:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPMeasure_M.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPMeasure_M:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPMeasure_M.getPropTag(prop) ' (' PPMeasure_M.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPMeasure_M(varargin)
			% PPMeasure_M() creates a plot property M of measure.
			%
			% PPMeasure_M(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPMeasure_M(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPMeasure_M properties is:
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
			prop = PPMeasure_M.getPropProp(pointer);
			
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
		
		    % create panel with slider
		    el = pr.get('EL');
		    prop = pr.get('PROP');
		    
		    if isa(el.get('G'), 'NoValue') || el.get('G').getGraphType()==0
		        pr.p = PlotPropEmptyG(...
		            'EL', el, ...
		            'PROP', prop, ...
		            'ID', 'm', ...
		            'TITLE', 'M', ...
		            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		    else
		        if Measure.is_global(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2)
		            pr.p = PlotPropMeasureGlobal( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        elseif Measure.is_nodal(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2)
		            pr.p = PlotPropMeasureNodal( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        elseif Measure.is_binodal(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2) % binodal
		            pr.p = PlotPropMeasureBinodal( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        elseif Measure.is_global(el) && el.get('G').getGraphType()==4
		            pr.p = PlotPropMeasureGlobalMultilayer( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        elseif Measure.is_nodal(el) && el.get('G').getGraphType()==4
		            pr.p = PlotPropMeasureNodalMultilayer( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        else % binodal multilayer
		            pr.p = PlotPropMeasureBinodalMultilayer( ...
		                'EL', el, ...
		                'PROP', prop, ...
		                'ID', 'm', ...
		                'TITLE', 'M', ...
		                'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
		        end
		        
		        if Measure.is_nodal(el)
		            pr.br_btn = uicontrol('Parent', pr.p, ...
		                'Style', 'pushbutton', ...
		                'Units', 'normalized', ...
		                'Visible', 'on', ...
		                'TooltipString', 'Open the measure in a Brain View plot.', ...
		                'String', 'Plot Brain View', ...
		                'Position', [.02 .76 .2 .15], ...
		                'Callback', {@cb_brainview});
		        end
		    end
		        
		    function cb_brainview (~, ~)
		        pr.cb_brain_view_fig();
		    end
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content of the property graphical panel.
		    %
		    % UPDATE(PR) updates the content of the property graphical panel.
		    %
		    % See also draw, redraw, refresh.
		    
		    get(pr.p, 'UserData').update()
		end
		function redraw(pr, varargin)
		    %REDRAW redraws the element graphical panel.
		    %
		    % REDRAW(PR) redraws the plot PR.
		    %
		    % REDRAW(PR, 'Height', HEIGHT) sets the height of PR (by default HEIGHT=3.3).
		    %
		    % See also draw, update, refresh.
		
		    get(pr.p, 'UserData').redraw(varargin{:}) 
		    if ~pr.get_button_condition()
		        set(pr.br_btn, 'Visible', 'off')
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
		            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		            'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')], ...
		            'CloseRequestFcn', {@cb_f_br_close} ...
		            );
		        set_braph2icon(pr.f_br)
		        menu_about = BRAPH2.add_menu_about(pr.f_br);
		        
		        ui_toolbar = findall(pr.f_br, 'Tag', 'FigureToolBar');
		        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
		        delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
		        
		        el = pr.get('EL');
		        prop = pr.get('PROP');
		        
		        g = el.get('G');
		        
		        if isequal(g.getClass(), 'MultigraphBUD') || isequal(g.getClass(), 'MultiplexBUD')
		            type = 'Densities';
		        elseif isequal(g.getClass(), 'MultigraphBUT') || isequal(g.getClass(), 'MultiplexBUT')
		            type = 'Thresholds';
		        else
		            type = 'Weighted';
		        end
		        
		        pbv = PlotBrainView('ME', el, ...
		            'Atlas', g.get('BRAINATLAS'), ...
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
