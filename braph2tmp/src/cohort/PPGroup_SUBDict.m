classdef PPGroup_SUBDict < PlotProp
	% PPGroup_SUBDict is a plot of group subjects idict.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPGroup_SUBDict plots a table to visualize IndexedDictionary of the group of subjects.
	% 
	% CALLBACK - This is a callback function:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the group figure and its subject figures
	%     pr.<strong>cb_hide</strong>() - hides the group figure and its subject figures
	%     pr.<strong>cb_close</strong>() - closes the group figure and its subject figures
	%
	% The list of PPGroup_SUBDict properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPGroup_SUBDict methods (constructor):
	% PPGroup_SUBDict - constructor
	%
	% PPGroup_SUBDict methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property of group subjects idict/error.
	%  existsProp - checks whether property exists in plot property of group subjects idict/error.
	%  getPropNumber - returns the property number of plot property of group subjects idict.
	%  getProps - returns the property list of plot property of group subjects idict.
	%  getDescription - returns the description of the plot property of group subjects idict.
	%  getName - returns the name of the plot property of group subjects idict.
	%  getClass - returns the class of the plot property of group subjects idict.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPGroup_SUBDict methods:
	%  cb_close - closes the group figure and its subject figures.
	%  cb_hide - hides the group figure and its subject figures.
	%  cb_bring_to_front - brings to front the group figure and its subject figures.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws the idict for brain atlas property graphical panel.
	%  cb_button_del - t/cb_button_del is a function.
	%  cb_button_calc - /cb_button_calc is a function.
	%  cb_button_cb - ct/cb_button_cb is a function.
	%  set_settings - ct/set_settings is a function.
	%  cb_close_fs - ict/cb_close_fs is a function.
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
	% PPGroup_SUBDict methods (operators):
	%  isequal - determines whether two PPGroup_SUBDict are equal (values, locked)
	%
	% PPGroup_SUBDict methods (display):
	%  tostring - string with information about the PPGroup_SUBDict
	%  disp - displays information about the PPGroup_SUBDict
	%  tree - displays the element of PPGroup_SUBDict
	%
	% PPGroup_SUBDict method (element list):
	%  getElementList - returns a list with all subelements of PPGroup_SUBDict
	%
	% PPGroup_SUBDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPGroup_SUBDict
	%
	% PPGroup_SUBDict method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPGroup_SUBDict
	%
	% PPGroup_SUBDict methods (copy):
	%  copy - copies the PPGroup_SUBDict
	%  deepclone - deep-clones the PPGroup_SUBDict
	%  clone - clones the PPGroup_SUBDict
	%
	% PPGroup_SUBDict methods (inspection, Static):
	%  getClass - returns PPGroup_SUBDict
	%  getName - returns the name of PPGroup_SUBDict
	%  getDescription - returns the description of PPGroup_SUBDict
	%  getProps - returns the property list of PPGroup_SUBDict
	%  getPropNumber - returns the property number of PPGroup_SUBDict
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
	% PPGroup_SUBDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPGroup_SUBDict methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPGroup_SUBDict methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPGroup_SUBDict methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPGroup_SUBDict properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, Group, Subject, IndexedDictionary.
	
	properties (Access = private) % element properties
		p
		list_subs % list of subjects
		f_subs % subject figures
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property of group subjects idict.
			%
			% CLASS = PPGroup_SUBDict.GETCLASS() returns the class 'PPGroup_SUBDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property of group subjects idict PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPGroup_SUBDict') returns 'PPGroup_SUBDict'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPGroup_SUBDict';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property of group subjects idict.
			%
			% NAME = PPGroup_SUBDict.GETNAME() returns the name of the 'plot property of group subjects idict'.
			%  Plot Property Of Group Subjects Idict.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property of group subjects idict PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPGroup_SUBDict') returns the name of 'PPGroup_SUBDict'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Of Group Subjects Idict';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property of group subjects idict.
			%
			% STR = PPGroup_SUBDict.GETDESCRIPTION() returns the description of the 'plot property of group subjects idict'.
			%  which is:
			%
			%  PPGroup_SUBDict plots a table to visualize IndexedDictionary of the group of subjects.
			%  
			%  CALLBACK - This is a callback function:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the group figure and its subject figures
			%      pr.<strong>cb_hide</strong>() - hides the group figure and its subject figures
			%      pr.<strong>cb_close</strong>() - closes the group figure and its subject figures
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property of group subjects idict PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPGroup_SUBDict') returns the description of 'PPGroup_SUBDict'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPGroup_SUBDict plots a table to visualize IndexedDictionary of the group of subjects.' ...
				'' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the group figure and its subject figures' ...
				'    pr.<strong>cb_hide</strong>() - hides the group figure and its subject figures' ...
				'    pr.<strong>cb_close</strong>() - closes the group figure and its subject figures' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property of group subjects idict.
			%
			% PROPS = PPGroup_SUBDict.GETPROPS() returns the property list of plot property of group subjects idict.
			%
			% PROPS = PPGroup_SUBDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property of group subjects idict PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPGroup_SUBDict'[, CATEGORY]) returns the property list of 'PPGroup_SUBDict'.
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
			%GETPROPNUMBER returns the property number of plot property of group subjects idict.
			%
			% N = PPGroup_SUBDict.GETPROPNUMBER() returns the property number of plot property of group subjects idict.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property of group subjects idict PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPGroup_SUBDict') returns the property number of 'PPGroup_SUBDict'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property of group subjects idict/error.
			%
			% CHECK = PPGroup_SUBDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPGroup_SUBDict, PROP) checks whether PROP exists for PPGroup_SUBDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  Element.EXISTSPROP(PPGroup_SUBDict, PROP) throws error if PROP does NOT exist for PPGroup_SUBDict.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPGroup_SUBDict.existsProp(prop), ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPGroup_SUBDict.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property of group subjects idict/error.
			%
			% CHECK = PPGroup_SUBDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPGroup_SUBDict, TAG) checks whether TAG exists for PPGroup_SUBDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  Element.EXISTSTAG(PPGroup_SUBDict, TAG) throws error if TAG does NOT exist for PPGroup_SUBDict.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppgroup_subdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppgroup_subdict_tag_list));
			else
				assert( ...
					PPGroup_SUBDict.existsTag(tag), ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPGroup_SUBDict'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPGroup_SUBDict, POINTER) returns property number of POINTER of PPGroup_SUBDict.
			%  PROPERTY = PR.GETPROPPROP(PPGroup_SUBDict, POINTER) returns property number of POINTER of PPGroup_SUBDict.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppgroup_subdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPGroup_SUBDict.existsTag(tag);
				
				prop = find(strcmpi(tag, ppgroup_subdict_tag_list));
			else % numeric
				prop = pointer;
				PPGroup_SUBDict.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPGroup_SUBDict, POINTER) returns tag of POINTER of PPGroup_SUBDict.
			%  TAG = PR.GETPROPTAG(PPGroup_SUBDict, POINTER) returns tag of POINTER of PPGroup_SUBDict.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPGroup_SUBDict.existsTag(tag);
			else % numeric
				prop = pointer;
				PPGroup_SUBDict.existsProp(prop);
				
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPGroup_SUBDict, POINTER) returns category of POINTER of PPGroup_SUBDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PPGroup_SUBDict, POINTER) returns category of POINTER of PPGroup_SUBDict.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(PPGroup_SUBDict, POINTER) returns format of POINTER of PPGroup_SUBDict.
			%  FORMAT = PR.GETPROPFORMAT(PPGroup_SUBDict, POINTER) returns format of POINTER of PPGroup_SUBDict.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPGroup_SUBDict, POINTER) returns description of POINTER of PPGroup_SUBDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPGroup_SUBDict, POINTER) returns description of POINTER of PPGroup_SUBDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPGroup_SUBDict, POINTER) returns settings of POINTER of PPGroup_SUBDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PPGroup_SUBDict, POINTER) returns settings of POINTER of PPGroup_SUBDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPGroup_SUBDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPGroup_SUBDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPGroup_SUBDict, POINTER) returns the default value of POINTER of PPGroup_SUBDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PPGroup_SUBDict, POINTER) returns the default value of POINTER of PPGroup_SUBDict.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPGroup_SUBDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPGroup_SUBDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPGroup_SUBDict, POINTER) returns the conditioned default value of POINTER of PPGroup_SUBDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPGroup_SUBDict, POINTER) returns the conditioned default value of POINTER of PPGroup_SUBDict.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
			prop_default = PPGroup_SUBDict.conditioning(prop, PPGroup_SUBDict.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPGroup_SUBDict, PROP, VALUE) checks VALUE format for PROP of PPGroup_SUBDict.
			%  CHECK = PR.CHECKPROP(PPGroup_SUBDict, PROP, VALUE) checks VALUE format for PROP of PPGroup_SUBDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  Element.CHECKPROP(PPGroup_SUBDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPGroup_SUBDict.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			%  PR.CHECKPROP(PPGroup_SUBDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPGroup_SUBDict.
			%   Error id: [BRAPH2:PPGroup_SUBDict:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPGroup_SUBDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPGroup_SUBDict.getPropTag(prop) ' (' PPGroup_SUBDict.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPGroup_SUBDict(varargin)
			% PPGroup_SUBDict() creates a plot property of group subjects idict.
			%
			% PPGroup_SUBDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPGroup_SUBDict(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPGroup_SUBDict properties is:
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
			prop = PPGroup_SUBDict.getPropProp(pointer);
			
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
		    %DRAW draws the idict for brain atlas property graphical panel.
		    %
		    % DRAW(PR) draws the property panel with a table for the idict of the
		    %  brain atlas and the relative management buttons.
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
		
		    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_f_subs}, varargin{:});
		        function close_f_subs(~, ~) 
		            % Note that this will prevent the settings figure from being closed
		            % which should not be a problem because settings is not used
		            
		            if ~isempty(pr.f_subs)
		                for i = 1:1:length(pr.f_subs)
		                    if check_graphics(pr.f_subs{i}, 'figure')
		                        close(pr.f_subs{i})
		                    end
		                end
		            end
		        end
		        
		    pr.list_subs = uicontrol('Style', 'listbox', ...
		        'Parent', pr.p, ...
		        'Units', 'normalized', ...
		        'Position', [.02 .2 .96 .74], ...
		        'String', '', ...
		        'Max', -1, 'Min', 0, ...
		        'Callback', {@cb_list_subs} ...
		        );
		        % opens a subejct figure if double-clicked
		        click_time = [];
		    function cb_list_subs(~, ~)
		        if isempty(click_time)
		            click_time = tic();
		        else
		            time_between_clicks = toc(click_time);
		            click_time = tic();
		            if time_between_clicks < .3
		                selected_sub = get(pr.list_subs, 'Value');
		                plot_subject_figure(selected_sub)
		            end
		        end
		    end
		    function plot_subject_figure(selected_sub)
		        gr = pr.get('EL');
		        prop = pr.get('PROP');
		        sub_dict = gr.get(prop);
		
		        % determine figure position
		        f_gr = ancestor(pr.p, 'Figure'); % GUI Group
		        f_gr_x = Plot.x0(f_gr, 'pixels');
		        f_gr_y = Plot.y0(f_gr, 'pixels');
		        f_gr_w = Plot.w(f_gr, 'pixels');
		        f_gr_h = Plot.h(f_gr, 'pixels');
		
		        screen_x = Plot.x0(0, 'pixels');
		        screen_y = Plot.y0(0, 'pixels');
		        screen_w = Plot.w(0, 'pixels');
		        screen_h = Plot.h(0, 'pixels');
		
		        N = ceil(sqrt(sub_dict.length())); % number of row and columns of figures
		
		        x = (f_gr_x + f_gr_w) / screen_w + mod(selected_sub - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
		        y = f_gr_y / screen_h;
		        w = f_gr_w / screen_w;
		        h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_sub - .5) / N)) / N / screen_h;
		
		        % plot subject figure (or bring it to front)           
		        sub = sub_dict.getItem(selected_sub);
		        if length(pr.f_subs) < selected_sub || ~check_graphics(pr.f_subs{selected_sub}, 'figure')
		            pr.f_subs{selected_sub} = GUI( ...
		                'PE', sub, ...
		                'POSITION', [x y w h], ...
		                'MENU_FILE', false, ...
		                'MENU_IMPORT', false, ...
		                'MENU_EXPORT', false, ...
		                'TOOL_FILE', false, ...
		                'CLOSEREQ', false ...
		                ).draw();
		            tmp_gui = get(pr.f_subs{selected_sub}, 'UserData');
		            set(pr.f_subs{selected_sub}, 'UserData', {tmp_gui, pr})
		        else
		            figure(pr.f_subs{selected_sub})
		        end
		    end
		
		    ui_button_table_remove = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.02 .1 .22 .07], ...
		        'String', 'Remove', ...
		        'TooltipString', 'Remove selected subject.', ...
		        'Callback', {@cb_table_remove} ...
		        );
		    function cb_table_remove(~, ~)  % (src, event)
		        gr = pr.get('EL');
		        prop = pr.get('PROP');
		        sub_dict = gr.get(prop);
		
		        selected_sub = get(pr.list_subs, 'Value');
		
		        selected_sub = sub_dict.remove_all(selected_sub);
		
		        pr.update();           
		    end
		    
		    ui_button_table_moveup = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.26 .1 .22 .07], ...
		        'String', 'Move up', ...
		        'TooltipString', 'Move selected subject up.', ...
		        'Callback', {@cb_table_moveup} ...
		        );
		    function cb_table_moveup(~, ~)  % (src, event)
		        gr = pr.get('EL');
		        prop = pr.get('PROP');
		        sub_dict = gr.get(prop);
		
		        selected_sub = get(pr.list_subs, 'Value');
		
		        selected_sub = sub_dict.move_up(selected_sub);
		
		        pr.update();           
		    end
		    
		    ui_button_table_movedown = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.26 .02 .22 .07], ...
		        'String', 'Move down', ...
		        'TooltipString', 'Move selected subject down.', ...
		        'Callback', {@cb_table_movedown} ...
		        );
		    function cb_table_movedown(~, ~)  % (src, event)
		            gr = pr.get('EL');
		            prop = pr.get('PROP');
		            sub_dict = gr.get(prop);
		
		            selected_sub = get(pr.list_subs, 'Value');
		
		            selected_sub = sub_dict.move_down(selected_sub);
		
		            pr.update();           
		        end
		    
		    ui_button_table_move2top = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.52 .1 .22 .07], ...
		        'String', 'Move top', ...
		        'TooltipString', 'Move selected subject to top of table.', ...
		        'Callback', {@cb_table_move2top} ...
		        );
		    function cb_table_move2top(~, ~)  % (src, event)
		            gr = pr.get('EL');
		            prop = pr.get('PROP');
		            sub_dict = gr.get(prop);
		
		            selected_sub = get(pr.list_subs, 'Value');
		
		            selected_sub = sub_dict.move_to_top(selected_sub);
		
		            pr.update();           
		        end
		    
		    ui_button_table_move2bottom = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.52 .02 .22 .07], ...
		        'String', 'Move bottom', ...
		        'TooltipString', 'Move selected subject to bottom of table.', ...
		        'Callback', {@cb_table_move2bottom} ...
		        );
		    function cb_table_move2bottom(~, ~)  % (src, event)
		            gr = pr.get('EL');
		            prop = pr.get('PROP');
		            sub_dict = gr.get(prop);
		
		            selected_sub = get(pr.list_subs, 'Value');
		
		            selected_sub = sub_dict.move_to_bottom(selected_sub);
		
		            pr.update();           
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
		
		    gr = pr.get('EL');
		    prop = pr.get('PROP');
		
		    sub_dict = gr.get(prop);
		
		    subjects_ids = cell(sub_dict.length(), 1);
		    for i = 1:1:sub_dict.length()
		        sub = sub_dict.getItem(i);
		        subjects_ids{i} = sub.tostring();
		    end
		    set(pr.list_subs, ...
		        'String', subjects_ids, ...
		        'TooltipString', [num2str(gr.getPropProp(prop)) ' ' gr.getPropDescription(prop)], ...
		        'Value', 1 ...
		        )
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
		
		    pr.redraw@PlotProp('Height', 28, varargin{:});
		end
		function cb_bring_to_front(pr)
		    %CB_BRING_TO_FRONT brings to front the group figure and its subject figures.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to front the group figure and its
		    %  subject figures.
		    %
		    % See also cb_hide, cb_close.
		
		    % brings to front settings panel
		    pr.cb_bring_to_front@PlotProp();
		
		    % brings to front subject figures
		    for i = 1:1:length(pr.f_subs)
		        f_sub = pr.f_subs{i};
		        if check_graphics(f_sub, 'figure')
		            gui_tmp = get(f_sub, 'UserData');
		            gui = gui_tmp{1};
		            pe = gui.get('PE');
		            pe.cb_bring_to_front()
		        end
		    end
		end
		function cb_hide(pr)
		    %CB_HIDE hides the group figure and its subject figures.
		    %
		    % CB_HIDE(PR) hides the group figure and its subject figures.
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hides settings panel
		    pr.cb_hide@PlotProp();
		
		    % hides subject figures
		    for i = 1:1:length(pr.f_subs)
		        f_sub = pr.f_subs{i};
		        if check_graphics(f_sub, 'figure')
		            gui_tmp = get(f_sub, 'UserData');
		            gui = gui_tmp{1};
		            pe = gui.get('PE');
		            pe.cb_hide()
		        end
		    end
		end
		function cb_close(pr)
		    %CB_CLOSE closes the group figure and its subject figures.
		    %
		    % CB_CLOSE(PR) closes the group figure and its subject figures.
		    %
		    % See also cb_bring_to_front, cb_hide.
		
		    % closes settings panel
		    pr.cb_close@PlotProp();
		
		    % closes subject figures
		    for i = 1:1:length(pr.f_subs)
		        f_sub = pr.f_subs{i};
		        if check_graphics(f_sub, 'figure')
		            gui_tmp = get(f_sub, 'UserData');
		            gui = gui_tmp{1};
		            pe = gui.get('PE');
		            pe.cb_close()
		        end
		    end
		end
	end
end
