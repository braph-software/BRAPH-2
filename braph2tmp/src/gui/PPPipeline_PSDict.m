classdef PPPipeline_PSDict < PlotProp
	% PPPipeline_PSDict is a plot of a pipeline.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the pipeline figure
	%     pr.<strong>cb_hide</strong>() - hides the pipeline figure and all dependent figures
	%     pr.<strong>cb_close</strong>() - closes the pipeline figure and all dependent figures
	%
	% The list of PPPipeline_PSDict properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPPipeline_PSDict methods (constructor):
	% PPPipeline_PSDict - constructor
	%
	% PPPipeline_PSDict methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in pipeline plot/error.
	%  existsProp - checks whether property exists in pipeline plot/error.
	%  getPropNumber - returns the property number of pipeline plot.
	%  getProps - returns the property list of pipeline plot.
	%  getDescription - returns the description of the pipeline plot.
	%  getName - returns the name of the pipeline plot.
	%  getClass - returns the class of the pipeline plot.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPPipeline_PSDict methods:
	%  cb_close - closes the figure containing the pipeline panel and all dependent figures.
	%  cb_hide - hides the figure containing the pipeline panel and all dependent figures.
	%  cb_bring_to_front - brings to the front the figure with the pipeline panel.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  x_update - internal function - do NOT use.
	%  update - updates the content and permissions of the pushbutton.
	%  draw - draws the pipeline panel.
	%  cb_button_del - ict/cb_button_del is a function.
	%  cb_button_calc - ct/cb_button_calc is a function.
	%  cb_button_cb - Dict/cb_button_cb is a function.
	%  set_settings - Dict/set_settings is a function.
	%  cb_close_fs - SDict/cb_close_fs is a function.
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
	% PPPipeline_PSDict methods (operators):
	%  isequal - determines whether two PPPipeline_PSDict are equal (values, locked)
	%
	% PPPipeline_PSDict methods (display):
	%  tostring - string with information about the PPPipeline_PSDict
	%  disp - displays information about the PPPipeline_PSDict
	%  tree - displays the element of PPPipeline_PSDict
	%
	% PPPipeline_PSDict method (element list):
	%  getElementList - returns a list with all subelements of PPPipeline_PSDict
	%
	% PPPipeline_PSDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPPipeline_PSDict
	%
	% PPPipeline_PSDict method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPPipeline_PSDict
	%
	% PPPipeline_PSDict methods (copy):
	%  copy - copies the PPPipeline_PSDict
	%  deepclone - deep-clones the PPPipeline_PSDict
	%  clone - clones the PPPipeline_PSDict
	%
	% PPPipeline_PSDict methods (inspection, Static):
	%  getClass - returns PPPipeline_PSDict
	%  getName - returns the name of PPPipeline_PSDict
	%  getDescription - returns the description of PPPipeline_PSDict
	%  getProps - returns the property list of PPPipeline_PSDict
	%  getPropNumber - returns the property number of PPPipeline_PSDict
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
	% PPPipeline_PSDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPPipeline_PSDict methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPPipeline_PSDict methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPPipeline_PSDict methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPPipeline_PSDict properties (Constant).
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
	% See also Pipeline, PlotProp.
	
	properties (Access = private) % element properties
		p
		ps_panels % list of section panels
		pc_btns % 2D cell array of code buttons
		pc_GUIs % 2D cell array of GUIs
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the pipeline plot.
			%
			% CLASS = PPPipeline_PSDict.GETCLASS() returns the class 'PPPipeline_PSDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the pipeline plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPPipeline_PSDict') returns 'PPPipeline_PSDict'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPPipeline_PSDict';
		end
		function pr_name = getName()
			%GETNAME returns the name of the pipeline plot.
			%
			% NAME = PPPipeline_PSDict.GETNAME() returns the name of the 'pipeline plot'.
			%  Pipeline Plot.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the pipeline plot PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPPipeline_PSDict') returns the name of 'PPPipeline_PSDict'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Pipeline Plot';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the pipeline plot.
			%
			% STR = PPPipeline_PSDict.GETDESCRIPTION() returns the description of the 'pipeline plot'.
			%  which is:
			%
			%  PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the pipeline figure
			%      pr.<strong>cb_hide</strong>() - hides the pipeline figure and all dependent figures
			%      pr.<strong>cb_close</strong>() - closes the pipeline figure and all dependent figures
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the pipeline plot PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPPipeline_PSDict') returns the description of 'PPPipeline_PSDict'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the pipeline figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the pipeline figure and all dependent figures' ...
				'    pr.<strong>cb_close</strong>() - closes the pipeline figure and all dependent figures' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline plot.
			%
			% PROPS = PPPipeline_PSDict.GETPROPS() returns the property list of pipeline plot.
			%
			% PROPS = PPPipeline_PSDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the pipeline plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPPipeline_PSDict'[, CATEGORY]) returns the property list of 'PPPipeline_PSDict'.
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
			%GETPROPNUMBER returns the property number of pipeline plot.
			%
			% N = PPPipeline_PSDict.GETPROPNUMBER() returns the property number of pipeline plot.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the pipeline plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPPipeline_PSDict') returns the property number of 'PPPipeline_PSDict'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline plot/error.
			%
			% CHECK = PPPipeline_PSDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPPipeline_PSDict, PROP) checks whether PROP exists for PPPipeline_PSDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  Element.EXISTSPROP(PPPipeline_PSDict, PROP) throws error if PROP does NOT exist for PPPipeline_PSDict.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPPipeline_PSDict.existsProp(prop), ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPPipeline_PSDict.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline plot/error.
			%
			% CHECK = PPPipeline_PSDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPPipeline_PSDict, TAG) checks whether TAG exists for PPPipeline_PSDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  Element.EXISTSTAG(PPPipeline_PSDict, TAG) throws error if TAG does NOT exist for PPPipeline_PSDict.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				pppipeline_psdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, pppipeline_psdict_tag_list));
			else
				assert( ...
					PPPipeline_PSDict.existsTag(tag), ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPPipeline_PSDict'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPPipeline_PSDict, POINTER) returns property number of POINTER of PPPipeline_PSDict.
			%  PROPERTY = PR.GETPROPPROP(PPPipeline_PSDict, POINTER) returns property number of POINTER of PPPipeline_PSDict.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				pppipeline_psdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPPipeline_PSDict.existsTag(tag);
				
				prop = find(strcmpi(tag, pppipeline_psdict_tag_list));
			else % numeric
				prop = pointer;
				PPPipeline_PSDict.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPPipeline_PSDict, POINTER) returns tag of POINTER of PPPipeline_PSDict.
			%  TAG = PR.GETPROPTAG(PPPipeline_PSDict, POINTER) returns tag of POINTER of PPPipeline_PSDict.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPPipeline_PSDict.existsTag(tag);
			else % numeric
				prop = pointer;
				PPPipeline_PSDict.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPPipeline_PSDict, POINTER) returns category of POINTER of PPPipeline_PSDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PPPipeline_PSDict, POINTER) returns category of POINTER of PPPipeline_PSDict.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PPPipeline_PSDict, POINTER) returns format of POINTER of PPPipeline_PSDict.
			%  FORMAT = PR.GETPROPFORMAT(PPPipeline_PSDict, POINTER) returns format of POINTER of PPPipeline_PSDict.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPPipeline_PSDict, POINTER) returns description of POINTER of PPPipeline_PSDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPPipeline_PSDict, POINTER) returns description of POINTER of PPPipeline_PSDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPPipeline_PSDict, POINTER) returns settings of POINTER of PPPipeline_PSDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PPPipeline_PSDict, POINTER) returns settings of POINTER of PPPipeline_PSDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPPipeline_PSDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPPipeline_PSDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPPipeline_PSDict, POINTER) returns the default value of POINTER of PPPipeline_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PPPipeline_PSDict, POINTER) returns the default value of POINTER of PPPipeline_PSDict.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPPipeline_PSDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPPipeline_PSDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPPipeline_PSDict, POINTER) returns the conditioned default value of POINTER of PPPipeline_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPPipeline_PSDict, POINTER) returns the conditioned default value of POINTER of PPPipeline_PSDict.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
			prop_default = PPPipeline_PSDict.conditioning(prop, PPPipeline_PSDict.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPPipeline_PSDict, PROP, VALUE) checks VALUE format for PROP of PPPipeline_PSDict.
			%  CHECK = PR.CHECKPROP(PPPipeline_PSDict, PROP, VALUE) checks VALUE format for PROP of PPPipeline_PSDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  Element.CHECKPROP(PPPipeline_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPPipeline_PSDict.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			%  PR.CHECKPROP(PPPipeline_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPPipeline_PSDict.
			%   Error id: [BRAPH2:PPPipeline_PSDict:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPPipeline_PSDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPPipeline_PSDict.getPropTag(prop) ' (' PPPipeline_PSDict.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPPipeline_PSDict(varargin)
			% PPPipeline_PSDict() creates a pipeline plot.
			%
			% PPPipeline_PSDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPPipeline_PSDict(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPPipeline_PSDict properties is:
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
			prop = PPPipeline_PSDict.getPropProp(pointer);
			
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
		    %DRAW draws the pipeline panel.
		    %
		    % DRAW(PR) draws the pipeline panel.
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
		
		    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_GUIs}, varargin{:});
		    function close_GUIs(~, ~)
		        for i = 1:1:length(pr.pc_GUIs)
		            for j = 1:1:length(pr.pc_GUIs{i})
		                delete(pr.pc_GUIs{i}{j})
		            end
		        end
		    end
		
		    % deletes all graphic objects
		    % panels and btns
		    if ~isempty(pr.ps_panels)
		        cellfun(@(panel) delete(panel), pr.ps_panels)
		        pr.ps_panels = {};
		        pr.pc_btns = {}; % deleted through panels
		    end
		    % GUIs
		    if ~isempty(pr.pc_GUIs)
		        close_GUIs()
		        pr.pc_GUIs = {};
		    end
		    
		    pip = pr.get('EL');
		
		    % the checks on the existence of the panels and btns are not necessary
		    % because they have been deleted at the beginning of the script
		    ps_dict = pip.get('PS_DICT');
		    for s = 1:1:ps_dict.length()
		        ps = ps_dict.getItem(s);
		
		        % if length(pl.ps_panels) < s || isempty(pl.ps_panels{s}) || ~isgraphics(pl.ps_panels{s}, 'uipanel')
		            pr.ps_panels{s} = uipanel( ...
		                'Parent', pr.p, ...
		                'Title', [ps.get('ID') '. ' ps.get('LABEL')], ...
		                'Tooltip', ps.get('NOTES'), ...
		                'FontUnits', BRAPH2.FONTUNITS, ...
		                'FontSize', BRAPH2.FONTSIZE, ...
		                'BorderType', 'none' ...
		                );
		
		            pc_dict = ps.get('PC_DICT');
		            for c = 1:1:pc_dict.length()
		                pc = pc_dict.getItem(c);
		
		                % if length(pl.pc_btns) < s || length(pl.pc_btns{s}) < c || isempty(pl.pc_btns{s}{c}) || ~isgraphics(pl.pc_btns{s}{c}, 'uicontrol') || ~strcmpi(get(pl.pc_btns{s}{c}, 'Style'), 'pushbutton')
		                    pr.pc_btns{s}{c} = uicontrol( ...
		                        'Style', 'pushbutton', ...
		                        'Parent', pr.ps_panels{s}, ...
		                        'Tooltip', pc.get('NOTES'), ...
		                        'Enable', 'off', ...
		                        'String', pc.get('TEXT_BEFORE_EXEC'), ...
		                        'FontAngle', 'italic', ...
		                        'FontUnits', BRAPH2.FONTUNITS, ...
		                        'FontSize', BRAPH2.FONTSIZE, ...
		                        'UserData', [s c], ...
		                        'Callback', {@cb_pc_btn} ...
		                        );
		                % end
		            end
		        % end
		    end
		    
		    % callback
		    function cb_pc_btn(src, ~)
		        userdata = get(src, 'UserData');
		        s = userdata(1);
		        c = userdata(2);
		        
		        pr.update('Section', s, 'Code', c)
		    end
		    
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr, varargin)
		    %UPDATE updates the content and permissions of the pushbutton.
		    %
		    % UPDATE(PR) updates the content and permissions of the pushbutton.
		    %
		    % See also draw, redraw, refresh, PlotElement.
		
		    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
		    c_selected = get_from_varargin(0, 'Code', varargin); % selected code
		    
		    update@PlotProp(pr)
		    
		    pip = pr.get('EL');
		
		% % %
		    to_be_executed = {};
		    
		    s_to_be_calculated = 1;
		    s_dict = pip.get('PS_DICT');
		    for s = 1:1:s_dict.length()
		        section = s_dict.getItem(s);
		        
		        code_dict = section.get('PC_DICT');
		        for c = 1:1:code_dict.length()
		            code = code_dict.getItem(c);
		            moniker = code.get('MONIKER'); % FIXME send error if moniker equal to varargin
		
		            % callback code
		            if s == s_selected && c == c_selected
		                if isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
		% % %                     codeline = [moniker ' = ' code.get('CODE')];
		                    try
		                        set(pr.pc_btns{s}{c}, ...
		                            'Enable', 'off' ...
		                            )
		                            
		% % %    
		                        pr.x_update(to_be_executed{:}, ...
		                            {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
		                            {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
		% % %                         eval(codeline)
		% % %                         code.set('EL', eval([moniker ';']))
		                    catch e
		                        set(pr.pc_btns{s}{c}, ...
		                            'Enable', 'on' ...
		                            )
		
		                        if ~strcmp(e.message, BRAPH2.IM_ERR)
		                            warndlg(['An error occurred while trying to execute the code:' newline() ...
		                                newline() ...
		                                moniker ' = ' code.get('CODE') ';' newline() ...
		                                newline() ...
		                                'Error message:' newline() ...
		                                newline() ...
		                                e.message newline()], 'Warning');
		                        end
		                    end
		                end
		                    
		                if ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
		                    if length(pr.pc_GUIs) < s || length(pr.pc_GUIs{s}) < c || ~check_graphics(pr.pc_GUIs{s}{c}, 'figure')
		                        f_pip = ancestor(pr.p, 'Figure'); % Pipeline GUI
		
		                        pr.pc_GUIs{s}{c} = GUI( ...
		                            'PE', code.get('EL'), ...
		                            'Position', [ ...
		                                Plot.x0(f_pip, 'normalized') + .20 ...
		                                Plot.y0(f_pip, 'normalized') ...
		                                .20 ...
		                                Plot.h(f_pip, 'normalized') ...
		                                ], ...
		                                'CLOSEREQ', false ...
		                            ).draw();
		                    else
		                        gui = get(pr.pc_GUIs{s}{c}, 'UserData');
		                        if get(pr.pc_GUIs{s}{c}, 'Visible')
		                            gui.cb_hide()
		                        else
		                            gui.cb_bring_to_front()
		                        end
		                    end
		                end
		            end
		
		            % If a code has already been executed and the relative element exists, 
		            % 1. loads the calculated element to the workspace
		            % 2. updates the ID in the btn
		            % 3. calculates whether to move to the next section
		            if ~isa(code.getr('EL'), 'NoValue')
		% % %  
		                to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code
		% % % pr.x_update(to_be_executed{:})
		% % %                 eval([moniker ' = code.get(''EL'');'])
		
		                set(pr.pc_btns{s}{c}, ...
		                    'Enable', 'on', ...
		                    'String', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
		                    'FontAngle', 'normal', ...
		                    'FontWeight', 'normal' ...
		                    )
		
		                % if all section codes calculated, updates the section to be calculated
		                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.getItems()))
		                    s_to_be_calculated = s + 1;
		                end
		            end
		            
		            % activates the next section that can be calculated
		            % (only the codes that have not been calculated yet)
		            if s == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
		                set(pr.pc_btns{s}{c}, ...
		                    'Enable', 'on', ...
		                    'FontAngle', 'normal', ...
		                    'FontWeight', 'bold' ...
		                    )
		            end            
		        end
		    end
		end
		function x_update(varargin)
		    %X_UPDATE internal function - do NOT use.
		
		    % Safe environment to evaluate the codes of the pipeline
		    % varargin consists of cell arrays with triplets:
		    %  varargin{n} = {moniker, code, codeline}
		
		    varargin = varargin(2:end); % eliminates pr from varargin
		    
		% % %     for i = 1:1:length(varargin)
		% % %         code = varargin{i}{2};
		% % %         eval(varargin{i}{3})
		% % %     end
		
		    while ~isempty(varargin)
		% % %         code = varargin{1}{2};
		        eval(varargin{1}{3})
		        varargin = varargin(2:end);
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
		    
		    pip = pr.get('EL');
		    ps_dict = pip.get('PS_DICT');
		        
		    ps_number = ps_dict.length();
		    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').length(), ps_dict.getItems());
		    
		    h_min = 2;  % default (minumum) height
		    h_ps_header = .5; % height section header
		    h_pc = 2.5; % height code button
		    h_ps_footer = .5; % height section footer
		    h_ps_margin = .5; % height section margin
		    h = h_min + (h_ps_margin + h_ps_header + h_ps_footer) * ps_number + h_pc * sum(pc_numbers);
		    pr.redraw@PlotProp('Height', h, varargin{:})
		
		    for s = 1:1:ps_number
		        ps_y = h_ps_header * (ps_number - s) ...
		            + h_pc * sum(pc_numbers(s+1:end)) ...
		            + h_ps_footer * (ps_number - s) ...
		            + h_ps_margin * (ps_number - s + 1);
		        ps_h = h_ps_header + h_pc * pc_numbers(s) + h_ps_footer;
		        
		        set(pr.ps_panels{s}, ...
		            'Units', 'normalized', ...
		            'Position', [.02 ps_y/h .96 ps_h/h] ...
		            )
		        
		        for c = 1:1:pc_numbers(s)
		            set(pr.pc_btns{s}{c}, ...
		                'Units', 'normalized', ...
		                'Position', [.02 (h_ps_footer+(pc_numbers(s) - c)*h_pc)/ps_h .96 h_pc/ps_h] ...
		                )
		        end
		    end
		end
		function cb_bring_to_front(pr)
		    %CB_BRING_TO_FRONT brings to the front the figure with the pipeline panel.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to the front the figure with the pipeline panel 
		    %  but not its dependent figures. 
		    %
		    % See also cb_hide, cb_close, cb_close_fs.
		
		    pr.cb_bring_to_front@Plot()
		    
		    % code to bring to front the dependent figures, currently not in use
		    % for i = 1:1:length(pr.pc_GUIs)
		    %     for j = 1:1:length(pr.pc_GUIs{i})
		    %         gui = get(pr.pc_GUIs{i}{j}, 'UserData');
		    %         gui.cb_bring_to_front()
		    %     end
		    % end
		end
		function cb_hide(pr)
		    %CB_HIDE hides the figure containing the pipeline panel and all dependent figures.
		    %
		    % CB_HIDE(PR) hides the figure containing the pipeline panel and all
		    %  dependent figures. 
		    %
		    % See also cb_bring_to_front, cb_close.
		    
		    pr.cb_hide@Plot()
		    
		    for i = 1:1:length(pr.pc_GUIs)
		        for j = 1:1:length(pr.pc_GUIs{i})
		            gui = get(pr.pc_GUIs{i}{j}, 'UserData');
		            gui.cb_hide()
		        end
		    end    
		end
		function cb_close(pr)
		    %CB_CLOSE closes the figure containing the pipeline panel and all dependent figures.
		    % 
		    % CB_CLOSE(PR) closes the figure containing the pipeline panel and
		    %  deletes all dependent figures. 
		    %
		    % See also cb_bring_to_front, cb_hide.
		
		    pr.cb_close@Plot() % this triggers a call for the delete function defined in draw() that deletes the dependent figures
		end
	end
end
