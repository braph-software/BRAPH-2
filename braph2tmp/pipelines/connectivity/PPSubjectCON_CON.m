classdef PPSubjectCON_CON < PlotPropMatrix
	% PPSubjectCON_CON represents the connnectivity data of a subject.
	% It is a subclass of <a href="matlab:help PlotPropMatrix">PlotPropMatrix</a>.
	%
	% PPSubjectCON_CON represents the connnectivity data of a subject.
	%
	% The list of PPSubjectCON_CON properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPSubjectCON_CON methods (constructor):
	% PPSubjectCON_CON - constructor
	%
	% PPSubjectCON_CON methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot subject connnectivity data/error.
	%  existsProp - checks whether property exists in plot subject connnectivity data/error.
	%  getPropNumber - returns the property number of plot subject connnectivity data.
	%  getProps - returns the property list of plot subject connnectivity data.
	%  getDescription - returns the description of the plot subject connnectivity data.
	%  getName - returns the name of the plot subject connnectivity data.
	%  getClass - returns the class of the plot subject connnectivity data.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPSubjectCON_CON methods:
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the panel and its graphical objects.
	%  draw - draws a table with the connectivity data of a subject.
	%  cb_matrix_value - /cb_matrix_value is a function.
	%  cb_button_del - ON/cb_button_del is a function.
	%  cb_button_calc - N/cb_button_calc is a function.
	%  cb_button_cb - CON/cb_button_cb is a function.
	%  set_settings - CON/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - _CON/cb_close_fs is a function.
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
	% PPSubjectCON_CON methods (operators):
	%  isequal - determines whether two PPSubjectCON_CON are equal (values, locked)
	%
	% PPSubjectCON_CON methods (display):
	%  tostring - string with information about the PPSubjectCON_CON
	%  disp - displays information about the PPSubjectCON_CON
	%  tree - displays the element of PPSubjectCON_CON
	%
	% PPSubjectCON_CON method (element list):
	%  getElementList - returns a list with all subelements of PPSubjectCON_CON
	%
	% PPSubjectCON_CON method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPSubjectCON_CON
	%
	% PPSubjectCON_CON method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPSubjectCON_CON
	%
	% PPSubjectCON_CON methods (copy):
	%  copy - copies the PPSubjectCON_CON
	%  deepclone - deep-clones the PPSubjectCON_CON
	%  clone - clones the PPSubjectCON_CON
	%
	% PPSubjectCON_CON methods (inspection, Static):
	%  getClass - returns PPSubjectCON_CON
	%  getName - returns the name of PPSubjectCON_CON
	%  getDescription - returns the description of PPSubjectCON_CON
	%  getProps - returns the property list of PPSubjectCON_CON
	%  getPropNumber - returns the property number of PPSubjectCON_CON
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
	% PPSubjectCON_CON methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPSubjectCON_CON methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPSubjectCON_CON methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPSubjectCON_CON methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPSubjectCON_CON properties (Constant).
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
	% See also GUI, PlotElement, PlotPropMatrix, Subject, SubjectCON..
	
	properties (Access = private) % element properties
		p
		table_value
	end
	methods (Static) % inspection methods
		function pl_class = getClass()
			%GETCLASS returns the class of the plot subject connnectivity data.
			%
			% CLASS = PPSubjectCON_CON.GETCLASS() returns the class 'PPSubjectCON_CON'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PL.GETCLASS() returns the class of the plot subject connnectivity data PL.
			%  CLASS = Element.GETCLASS(PL) returns the class of 'PL'.
			%  CLASS = Element.GETCLASS('PPSubjectCON_CON') returns 'PPSubjectCON_CON'.
			%
			% See also getName, getDescription.
			
			pl_class = 'PPSubjectCON_CON';
		end
		function pl_name = getName()
			%GETNAME returns the name of the plot subject connnectivity data.
			%
			% NAME = PPSubjectCON_CON.GETNAME() returns the name of the 'plot subject connnectivity data'.
			%  Plot Subject Connnectivity Data.
			%
			% Alternative forms to call this method are:
			%  NAME = PL.GETNAME() returns the name of the plot subject connnectivity data PL.
			%  NAME = Element.GETNAME(PL) returns the name of 'PL'.
			%  NAME = Element.GETNAME('PPSubjectCON_CON') returns the name of 'PPSubjectCON_CON'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pl_name = 'Plot Subject Connnectivity Data';
		end
		function pl_description = getDescription()
			%GETDESCRIPTION returns the description of the plot subject connnectivity data.
			%
			% STR = PPSubjectCON_CON.GETDESCRIPTION() returns the description of the 'plot subject connnectivity data'.
			%  which is:
			%
			%  PPSubjectCON_CON represents the connnectivity data of a subject.
			%
			% Alternative forms to call this method are:
			%  STR = PL.GETDESCRIPTION() returns the description of the plot subject connnectivity data PL.
			%  STR = Element.GETDESCRIPTION(PL) returns the description of 'PL'.
			%  STR = Element.GETDESCRIPTION('PPSubjectCON_CON') returns the description of 'PPSubjectCON_CON'.
			%
			% See also getClass, getName.
			
			pl_description = [
				'PPSubjectCON_CON represents the connnectivity data of a subject.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot subject connnectivity data.
			%
			% PROPS = PPSubjectCON_CON.GETPROPS() returns the property list of plot subject connnectivity data.
			%
			% PROPS = PPSubjectCON_CON.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PL.GETPROPS([CATEGORY]) returns the property list of the plot subject connnectivity data PL.
			%  PROPS = Element.GETPROPS(PL[, CATEGORY]) returns the property list of 'PL'.
			%  PROPS = Element.GETPROPS('PPSubjectCON_CON'[, CATEGORY]) returns the property list of 'PPSubjectCON_CON'.
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
			%GETPROPNUMBER returns the property number of plot subject connnectivity data.
			%
			% N = PPSubjectCON_CON.GETPROPNUMBER() returns the property number of plot subject connnectivity data.
			%
			% Alternative forms to call this method are:
			%  N = PL.GETPROPNUMBER() returns the property number of the plot subject connnectivity data PL.
			%  N = Element.GETPROPNUMBER(PL) returns the property number of 'PL'.
			%  N = Element.GETPROPNUMBER('PPSubjectCON_CON') returns the property number of 'PPSubjectCON_CON'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot subject connnectivity data/error.
			%
			% CHECK = PPSubjectCON_CON.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSPROP(PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PL, PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PPSubjectCON_CON, PROP) checks whether PROP exists for PPSubjectCON_CON.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSPROP(PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  Element.EXISTSPROP(PL, PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  Element.EXISTSPROP(PPSubjectCON_CON, PROP) throws error if PROP does NOT exist for PPSubjectCON_CON.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPSubjectCON_CON.existsProp(prop), ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPSubjectCON_CON.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot subject connnectivity data/error.
			%
			% CHECK = PPSubjectCON_CON.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSTAG(TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PL, TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PPSubjectCON_CON, TAG) checks whether TAG exists for PPSubjectCON_CON.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSTAG(TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  Element.EXISTSTAG(PL, TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  Element.EXISTSTAG(PPSubjectCON_CON, TAG) throws error if TAG does NOT exist for PPSubjectCON_CON.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectcon_con_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppsubjectcon_con_tag_list));
			else
				assert( ...
					PPSubjectCON_CON.existsTag(tag), ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPSubjectCON_CON'] ...
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
			%  PROPERTY = PL.GETPROPPROP(POINTER) returns property number of POINTER of PL.
			%  PROPERTY = Element.GETPROPPROP(PPSubjectCON_CON, POINTER) returns property number of POINTER of PPSubjectCON_CON.
			%  PROPERTY = PL.GETPROPPROP(PPSubjectCON_CON, POINTER) returns property number of POINTER of PPSubjectCON_CON.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppsubjectcon_con_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPSubjectCON_CON.existsTag(tag);
				
				prop = find(strcmpi(tag, ppsubjectcon_con_tag_list));
			else % numeric
				prop = pointer;
				PPSubjectCON_CON.existsProp(prop);
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
			%  TAG = PL.GETPROPTAG(POINTER) returns tag of POINTER of PL.
			%  TAG = Element.GETPROPTAG(PPSubjectCON_CON, POINTER) returns tag of POINTER of PPSubjectCON_CON.
			%  TAG = PL.GETPROPTAG(PPSubjectCON_CON, POINTER) returns tag of POINTER of PPSubjectCON_CON.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPSubjectCON_CON.existsTag(tag);
			else % numeric
				prop = pointer;
				PPSubjectCON_CON.existsProp(prop);
				
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
			%  CATEGORY = PL.GETPROPCATEGORY(POINTER) returns category of POINTER of PL.
			%  CATEGORY = Element.GETPROPCATEGORY(PPSubjectCON_CON, POINTER) returns category of POINTER of PPSubjectCON_CON.
			%  CATEGORY = PL.GETPROPCATEGORY(PPSubjectCON_CON, POINTER) returns category of POINTER of PPSubjectCON_CON.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
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
			%  FORMAT = PL.GETPROPFORMAT(POINTER) returns format of POINTER of PL.
			%  FORMAT = Element.GETPROPFORMAT(PPSubjectCON_CON, POINTER) returns format of POINTER of PPSubjectCON_CON.
			%  FORMAT = PL.GETPROPFORMAT(PPSubjectCON_CON, POINTER) returns format of POINTER of PPSubjectCON_CON.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
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
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPSubjectCON_CON, POINTER) returns description of POINTER of PPSubjectCON_CON.
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(PPSubjectCON_CON, POINTER) returns description of POINTER of PPSubjectCON_CON.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
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
			%  SETTINGS = PL.GETPROPSETTINGS(POINTER) returns settings of POINTER of PL.
			%  SETTINGS = Element.GETPROPSETTINGS(PPSubjectCON_CON, POINTER) returns settings of POINTER of PPSubjectCON_CON.
			%  SETTINGS = PL.GETPROPSETTINGS(PPSubjectCON_CON, POINTER) returns settings of POINTER of PPSubjectCON_CON.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPSubjectCON_CON.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectCON_CON.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULT(PPSubjectCON_CON, POINTER) returns the default value of POINTER of PPSubjectCON_CON.
			%  DEFAULT = PL.GETPROPDEFAULT(PPSubjectCON_CON, POINTER) returns the default value of POINTER of PPSubjectCON_CON.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotPropMatrix(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPSubjectCON_CON.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPSubjectCON_CON.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPSubjectCON_CON, POINTER) returns the conditioned default value of POINTER of PPSubjectCON_CON.
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(PPSubjectCON_CON, POINTER) returns the conditioned default value of POINTER of PPSubjectCON_CON.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
			prop_default = PPSubjectCON_CON.conditioning(prop, PPSubjectCON_CON.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PL.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PL.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PL.
			%  CHECK = Element.CHECKPROP(PPSubjectCON_CON, PROP, VALUE) checks VALUE format for PROP of PPSubjectCON_CON.
			%  CHECK = PL.CHECKPROP(PPSubjectCON_CON, PROP, VALUE) checks VALUE format for PROP of PPSubjectCON_CON.
			% 
			% PL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PL.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  Element.CHECKPROP(PPSubjectCON_CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectCON_CON.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			%  PL.CHECKPROP(PPSubjectCON_CON, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPSubjectCON_CON.
			%   Error id: [BRAPH2:PPSubjectCON_CON:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotPropMatrix(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPSubjectCON_CON:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPSubjectCON_CON.getPropTag(prop) ' (' PPSubjectCON_CON.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pl = PPSubjectCON_CON(varargin)
			% PPSubjectCON_CON() creates a plot subject connnectivity data.
			%
			% PPSubjectCON_CON(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPSubjectCON_CON(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPSubjectCON_CON properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pl = pl@PlotPropMatrix(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPSubjectCON_CON.getPropProp(pointer);
			
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
		    %DRAW draws a table with the connectivity data of a subject.
		    %
		    % DRAW(PR) draws the property panel a table with the connectivity data of 
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
		
		    % output
		    if nargout > 0
		        h_panel = pr.p;
		    end
		end
		function update(pr)
		    %UPDATE updates the content of the panel and its graphical objects.
		    %
		    % UPDATE(PR) updates the content of the panel and its graphical objects.
		    %
		    % Important note:
		    % 1. UPDATE() is typically called internally by PlotElement and does not need 
		    %  to be explicitly called in children of PlotProp.
		    %
		    % See also draw, redraw, refresh, PlotElement.
		
		    update@PlotPropMatrix(pr)
		    
		    pp_el = pr.get('EL');
		    br_dict = pp_el.get('BA').get('br_dict');
		    
		    br_ids = cell(br_dict.length(), 1);
		    for i = 1:1:br_dict.length()
		        br = br_dict.getItem(i);
		        br_id = br.get(BrainRegion.ID);
		        if length(br_id) > 10
		            br_id = [br_id(1:8) '..'];
		        end
		        br_ids{i} = br_id;
		    end
		    
		    set(pr.table_value, ...
		        'ColumnName', br_ids, ...
		        'RowName', br_ids ...
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
		    %  - HEIGHT=3.33 characters.
		    %
		    % See also draw, update, refresh, PlotElement.
		    
		    pr.redraw@PlotPropMatrix(varargin{:});
		end
	end
end
