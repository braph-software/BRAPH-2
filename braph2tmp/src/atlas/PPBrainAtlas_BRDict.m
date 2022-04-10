classdef PPBrainAtlas_BRDict < PlotProp
	% PPBrainAtlas_BRDict is a plot of brain atlas idict.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPBrainAtlas_BRDict plots the IndexedDictionary containing a BrainAtlas.
	%
	% The list of PPBrainAtlas_BRDict properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%
	% PPBrainAtlas_BRDict methods (constructor):
	% PPBrainAtlas_BRDict - constructor
	%
	% PPBrainAtlas_BRDict methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property of brain atlas idict/error.
	%  existsProp - checks whether property exists in plot property of brain atlas idict/error.
	%  getPropNumber - returns the property number of plot property of brain atlas idict.
	%  getProps - returns the property list of plot property of brain atlas idict.
	%  getDescription - returns the description of the plot property of brain atlas idict.
	%  getName - returns the name of the plot property of brain atlas idict.
	%  getClass - returns the class of the plot property of brain atlas idict.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPBrainAtlas_BRDict methods:
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property graphical panel.
	%  draw - draws the BrainAtlas idict.
	%  cb_button_del - RDict/cb_button_del is a function.
	%  cb_button_calc - Dict/cb_button_calc is a function.
	%  cb_button_cb - BRDict/cb_button_cb is a function.
	%  set_settings - BRDict/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - _BRDict/cb_close_fs is a function.
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
	% PPBrainAtlas_BRDict methods (operators):
	%  isequal - determines whether two PPBrainAtlas_BRDict are equal (values, locked)
	%
	% PPBrainAtlas_BRDict methods (display):
	%  tostring - string with information about the PPBrainAtlas_BRDict
	%  disp - displays information about the PPBrainAtlas_BRDict
	%  tree - displays the element of PPBrainAtlas_BRDict
	%
	% PPBrainAtlas_BRDict method (element list):
	%  getElementList - returns a list with all subelements of PPBrainAtlas_BRDict
	%
	% PPBrainAtlas_BRDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPBrainAtlas_BRDict
	%
	% PPBrainAtlas_BRDict method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPBrainAtlas_BRDict
	%
	% PPBrainAtlas_BRDict methods (copy):
	%  copy - copies the PPBrainAtlas_BRDict
	%  deepclone - deep-clones the PPBrainAtlas_BRDict
	%  clone - clones the PPBrainAtlas_BRDict
	%
	% PPBrainAtlas_BRDict methods (inspection, Static):
	%  getClass - returns PPBrainAtlas_BRDict
	%  getName - returns the name of PPBrainAtlas_BRDict
	%  getDescription - returns the description of PPBrainAtlas_BRDict
	%  getProps - returns the property list of PPBrainAtlas_BRDict
	%  getPropNumber - returns the property number of PPBrainAtlas_BRDict
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
	% PPBrainAtlas_BRDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPBrainAtlas_BRDict methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPBrainAtlas_BRDict methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPBrainAtlas_BRDict methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPBrainAtlas_BRDict properties (Constant).
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
	% See also GUI, PlotElement, PlotProp, BrainAtlas.
	
	properties (Access = private) % element properties
		p
		table % table with the brain regions
		selected % selected brain regions
	end
	methods (Static) % inspection methods
		function pl_class = getClass()
			%GETCLASS returns the class of the plot property of brain atlas idict.
			%
			% CLASS = PPBrainAtlas_BRDict.GETCLASS() returns the class 'PPBrainAtlas_BRDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PL.GETCLASS() returns the class of the plot property of brain atlas idict PL.
			%  CLASS = Element.GETCLASS(PL) returns the class of 'PL'.
			%  CLASS = Element.GETCLASS('PPBrainAtlas_BRDict') returns 'PPBrainAtlas_BRDict'.
			%
			% See also getName, getDescription.
			
			pl_class = 'PPBrainAtlas_BRDict';
		end
		function pl_name = getName()
			%GETNAME returns the name of the plot property of brain atlas idict.
			%
			% NAME = PPBrainAtlas_BRDict.GETNAME() returns the name of the 'plot property of brain atlas idict'.
			%  Plot Property Of Brain Atlas Idict.
			%
			% Alternative forms to call this method are:
			%  NAME = PL.GETNAME() returns the name of the plot property of brain atlas idict PL.
			%  NAME = Element.GETNAME(PL) returns the name of 'PL'.
			%  NAME = Element.GETNAME('PPBrainAtlas_BRDict') returns the name of 'PPBrainAtlas_BRDict'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pl_name = 'Plot Property Of Brain Atlas Idict';
		end
		function pl_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property of brain atlas idict.
			%
			% STR = PPBrainAtlas_BRDict.GETDESCRIPTION() returns the description of the 'plot property of brain atlas idict'.
			%  which is:
			%
			%  PPBrainAtlas_BRDict plots the IndexedDictionary containing a BrainAtlas.
			%
			% Alternative forms to call this method are:
			%  STR = PL.GETDESCRIPTION() returns the description of the plot property of brain atlas idict PL.
			%  STR = Element.GETDESCRIPTION(PL) returns the description of 'PL'.
			%  STR = Element.GETDESCRIPTION('PPBrainAtlas_BRDict') returns the description of 'PPBrainAtlas_BRDict'.
			%
			% See also getClass, getName.
			
			pl_description = [
				'PPBrainAtlas_BRDict plots the IndexedDictionary containing a BrainAtlas.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property of brain atlas idict.
			%
			% PROPS = PPBrainAtlas_BRDict.GETPROPS() returns the property list of plot property of brain atlas idict.
			%
			% PROPS = PPBrainAtlas_BRDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PL.GETPROPS([CATEGORY]) returns the property list of the plot property of brain atlas idict PL.
			%  PROPS = Element.GETPROPS(PL[, CATEGORY]) returns the property list of 'PL'.
			%  PROPS = Element.GETPROPS('PPBrainAtlas_BRDict'[, CATEGORY]) returns the property list of 'PPBrainAtlas_BRDict'.
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
			%GETPROPNUMBER returns the property number of plot property of brain atlas idict.
			%
			% N = PPBrainAtlas_BRDict.GETPROPNUMBER() returns the property number of plot property of brain atlas idict.
			%
			% Alternative forms to call this method are:
			%  N = PL.GETPROPNUMBER() returns the property number of the plot property of brain atlas idict PL.
			%  N = Element.GETPROPNUMBER(PL) returns the property number of 'PL'.
			%  N = Element.GETPROPNUMBER('PPBrainAtlas_BRDict') returns the property number of 'PPBrainAtlas_BRDict'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 7;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property of brain atlas idict/error.
			%
			% CHECK = PPBrainAtlas_BRDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSPROP(PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PL, PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PPBrainAtlas_BRDict, PROP) checks whether PROP exists for PPBrainAtlas_BRDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSPROP(PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  Element.EXISTSPROP(PL, PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  Element.EXISTSPROP(PPBrainAtlas_BRDict, PROP) throws error if PROP does NOT exist for PPBrainAtlas_BRDict.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7 ]);
			else
				assert( ...
					PPBrainAtlas_BRDict.existsProp(prop), ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPBrainAtlas_BRDict.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property of brain atlas idict/error.
			%
			% CHECK = PPBrainAtlas_BRDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSTAG(TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PL, TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PPBrainAtlas_BRDict, TAG) checks whether TAG exists for PPBrainAtlas_BRDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSTAG(TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  Element.EXISTSTAG(PL, TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  Element.EXISTSTAG(PPBrainAtlas_BRDict, TAG) throws error if TAG does NOT exist for PPBrainAtlas_BRDict.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppbrainatlas_brdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				check = any(strcmpi(tag, ppbrainatlas_brdict_tag_list));
			else
				assert( ...
					PPBrainAtlas_BRDict.existsTag(tag), ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPBrainAtlas_BRDict'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPBrainAtlas_BRDict, POINTER) returns property number of POINTER of PPBrainAtlas_BRDict.
			%  PROPERTY = PL.GETPROPPROP(PPBrainAtlas_BRDict, POINTER) returns property number of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppbrainatlas_brdict_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar' };
				
				tag = pointer;
				PPBrainAtlas_BRDict.existsTag(tag);
				
				prop = find(strcmpi(tag, ppbrainatlas_brdict_tag_list));
			else % numeric
				prop = pointer;
				PPBrainAtlas_BRDict.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPBrainAtlas_BRDict, POINTER) returns tag of POINTER of PPBrainAtlas_BRDict.
			%  TAG = PL.GETPROPTAG(PPBrainAtlas_BRDict, POINTER) returns tag of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPBrainAtlas_BRDict.existsTag(tag);
			else % numeric
				prop = pointer;
				PPBrainAtlas_BRDict.existsProp(prop);
				
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
			%  CATEGORY = PL.GETPROPCATEGORY(POINTER) returns category of POINTER of PL.
			%  CATEGORY = Element.GETPROPCATEGORY(PPBrainAtlas_BRDict, POINTER) returns category of POINTER of PPBrainAtlas_BRDict.
			%  CATEGORY = PL.GETPROPCATEGORY(PPBrainAtlas_BRDict, POINTER) returns category of POINTER of PPBrainAtlas_BRDict.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
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
			%  FORMAT = PL.GETPROPFORMAT(POINTER) returns format of POINTER of PL.
			%  FORMAT = Element.GETPROPFORMAT(PPBrainAtlas_BRDict, POINTER) returns format of POINTER of PPBrainAtlas_BRDict.
			%  FORMAT = PL.GETPROPFORMAT(PPBrainAtlas_BRDict, POINTER) returns format of POINTER of PPBrainAtlas_BRDict.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
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
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPBrainAtlas_BRDict, POINTER) returns description of POINTER of PPBrainAtlas_BRDict.
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(PPBrainAtlas_BRDict, POINTER) returns description of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
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
			%  SETTINGS = PL.GETPROPSETTINGS(POINTER) returns settings of POINTER of PL.
			%  SETTINGS = Element.GETPROPSETTINGS(PPBrainAtlas_BRDict, POINTER) returns settings of POINTER of PPBrainAtlas_BRDict.
			%  SETTINGS = PL.GETPROPSETTINGS(PPBrainAtlas_BRDict, POINTER) returns settings of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPBrainAtlas_BRDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPBrainAtlas_BRDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULT(PPBrainAtlas_BRDict, POINTER) returns the default value of POINTER of PPBrainAtlas_BRDict.
			%  DEFAULT = PL.GETPROPDEFAULT(PPBrainAtlas_BRDict, POINTER) returns the default value of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPBrainAtlas_BRDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPBrainAtlas_BRDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPBrainAtlas_BRDict, POINTER) returns the conditioned default value of POINTER of PPBrainAtlas_BRDict.
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(PPBrainAtlas_BRDict, POINTER) returns the conditioned default value of POINTER of PPBrainAtlas_BRDict.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
			prop_default = PPBrainAtlas_BRDict.conditioning(prop, PPBrainAtlas_BRDict.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPBrainAtlas_BRDict, PROP, VALUE) checks VALUE format for PROP of PPBrainAtlas_BRDict.
			%  CHECK = PL.CHECKPROP(PPBrainAtlas_BRDict, PROP, VALUE) checks VALUE format for PROP of PPBrainAtlas_BRDict.
			% 
			% PL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PL.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  Element.CHECKPROP(PPBrainAtlas_BRDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPBrainAtlas_BRDict.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			%  PL.CHECKPROP(PPBrainAtlas_BRDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPBrainAtlas_BRDict.
			%   Error id: [BRAPH2:PPBrainAtlas_BRDict:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
			switch prop
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_BRDict:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPBrainAtlas_BRDict.getPropTag(prop) ' (' PPBrainAtlas_BRDict.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pl = PPBrainAtlas_BRDict(varargin)
			% PPBrainAtlas_BRDict() creates a plot property of brain atlas idict.
			%
			% PPBrainAtlas_BRDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPBrainAtlas_BRDict(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPBrainAtlas_BRDict properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element.
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number.
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%
			% See also Category, Format, set, check.
			
			pl = pl@PlotProp(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPBrainAtlas_BRDict.getPropProp(pointer);
			
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
		    %DRAW draws the BrainAtlas idict.
		    %
		    % DRAW(PR) draws a panel with a table with the BrainAtlas idict and the
		    %  relative management buttons.
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
		
		    pr.p = draw@PlotProp(pr, varargin{:});
		
		    pr.table = uitable();
		    set(pr.table, ...
		        'Parent', pr.p, ...
		        'Units', 'normalized', ...
		        'Position', [.02 .20 .96 .75], ...
		        'ColumnName', {'', 'ID', 'Label', 'x', 'y', 'z', 'Notes'}, ...
		        'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'}, ...
		        'Tooltip', [num2str(BrainAtlas.BR_DICT) ' ' BrainAtlas.getPropDescription('BR_DICT')], ...
		        'ColumnEditable', true, ...
		        'CellEditCallback', {@cb_table} ...
		        );
		        function cb_table(~, event)
		            i = event.Indices(1);
		            col = event.Indices(2);
		            newdata = event.NewData;
		
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            switch col
		                case 1
		                    if newdata == 1
		                        pr.selected = sort(unique([pr.selected(:); i]));
		                    else
		                        pr.selected = pr.selected(pr.selected~=i);
		                    end
		                case 2
		                    if ~br_dict.containsKey(newdata)
		                        % change brain region id
		                        br_dict.getItem(i).set('ID', newdata)
		                        % change brain region key in idict
		                        oldkey = br_dict.getKey(i);
		                        br_dict.replaceKey(oldkey, newdata);
		                    end
		                case 3
		                    br_dict.getItem(i).set('Label', newdata)
		                case 4
		                    br_dict.getItem(i).set('X', newdata)
		                case 5
		                    br_dict.getItem(i).set('Y', newdata)
		                case 6
		                    br_dict.getItem(i).set('Z', newdata)
		                case 7
		                    br_dict.getItem(i).set('Notes', newdata)
		            end
		
		            pr.update()            
		        end
		
		    ui_button_table_selectall = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.02 .1 .22 .07], ...
		        'String', 'Select All', ...
		        'TooltipString', 'Select all brain regions', ...
		        'Callback', {@cb_table_selectall} ...
		        );
		        function cb_table_selectall(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = [1:1:br_dict.length()]';
		
		            pr.update()
		        end
		
		    ui_button_table_clearselection = uicontrol(pr.p, 'Style', 'pushbutton', 'Units', 'normalized', ...
		        'Position', [.02 .02 .22 .07], ...
		        'String', 'Clear', ...
		        'TooltipString', 'Clear selection', ...
		        'Callback', {@cb_table_clearselection} ...
		        );
		        function cb_table_clearselection(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = [];
		
		            pr.update()
		        end
		    
		    ui_button_table_add = uicontrol(pr.p, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.27 .1 .22 .07], ...
		        'String', 'Add', ...
		        'TooltipString', 'Add brain region at the end of table', ...
		        'Callback', {@cb_table_add} ...
		        );
		        function cb_table_add(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            br_id = 1;
		            while br_dict.containsKey(num2str(br_id))
		                br_id = br_id + 1;
		            end
		
		            br = BrainRegion( ...
		                'ID', num2str(br_id), ...
		                'Label', '', ...
		                'Notes', '', ...
		                'X', 0, ...
		                'Y', 0, ...
		                'Z', 0 ...
		                );
		            br_dict.add(br);
		
		            pr.update()
		        end
		    
		    ui_button_table_remove = uicontrol(pr.p,'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.27 .02 .22 .07], ...
		        'String', 'Remove', ...
		        'TooltipString', 'Remove selected brain regions', ...
		        'Callback', {@cb_table_remove} ...
		        );
		        function cb_table_remove(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = br_dict.remove_all(pr.selected);
		
		            pr.update()
		        end
		    
		    ui_button_table_moveup = uicontrol(pr.p,'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.52 .1 .22 .07], ...
		        'String', 'Move up', ...
		        'TooltipString', 'Move selected brain regions up', ...
		        'Callback', {@cb_table_moveup} ...
		        );
		        function cb_table_moveup(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = br_dict.move_up(pr.selected);
		
		            pr.update()
		        end
		    
		    ui_button_table_movedown = uicontrol(pr.p,'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.52 .02 .22 .07], ...
		        'String', 'Move down', ...
		        'TooltipString', 'Move selected brain regions down', ...
		        'Callback', {@cb_table_movedown} ...
		        );
		        function cb_table_movedown(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = br_dict.move_down(pr.selected);
		
		            pr.update()
		        end
		    
		    ui_button_table_move2top = uicontrol(pr.p,'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.77 .1 .22 .07], ...
		        'String', 'Move top', ...
		        'TooltipString', 'Move selected brain regions to top of table', ...
		        'Callback', {@cb_table_move2top} ...
		        );
		        function cb_table_move2top(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = br_dict.move_to_top(pr.selected);
		
		            pr.update()
		        end
		    
		    ui_button_table_move2bottom = uicontrol(pr.p,'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.77 .02 .22 .07], ...
		        'String', 'Move bottom', ...
		        'TooltipString', 'Move selected brain regions to bottom of table', ...
		        'Callback', {@cb_table_move2bottom} ...
		        );
		        function cb_table_move2bottom(~, ~)  % (src, event)
		            ba = pr.get('EL');
		            br_dict = ba.get('BR_DICT');
		
		            pr.selected = br_dict.move_to_bottom(pr.selected);
		
		            pr.update()
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
		
		    update@PlotProp(pr)
		
		    ba = pr.get('EL');
			br_dict = ba.get('BR_DICT');
		
		    if isa(ba.getr('BR_DICT'), 'NoValue')
		        ba.set('BR_DICT', br_dict)
		    end
		    
		    data = cell(br_dict.length(), 7);
		    for sub = 1:1:br_dict.length()
		        if any(pr.selected == sub)
		            data{sub, 1} = true;
		        else
		            data{sub, 1} = false;
		        end
		        data{sub, 2} = br_dict.getItem(sub).get('ID');
		        data{sub, 3} = br_dict.getItem(sub).get('Label');
		        data{sub, 4} = br_dict.getItem(sub).get('X');
		        data{sub, 5} = br_dict.getItem(sub).get('Y');
		        data{sub, 6} = br_dict.getItem(sub).get('Z');
		        data{sub, 7} = br_dict.getItem(sub).get('Notes');
		    end
		    set(pr.table, 'Data', data);
		    
		    % update brain surface
		% % %     f = ancestor(pr.p, 'Figure'); % get figure BrainAtlas
		% % %     gui = get(f, 'UserData'); % get GUI PlotElement BrainAtlas
		% % %     pe = gui.get('PE'); % get PlotElement BrainAtlas
		    pe = get(get(get(pr.p, 'Parent'), 'Parent'), 'UserData'); % get PlotElement BrainAtlas
		    pp_surf = pe.get(PlotElement.PR_DICT).getItem(BrainAtlas.SURF_TAG); % get PlotProp Surf
		    pp_surf.update_brain_atlas()
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
		    
		    pr.redraw@PlotProp('Height', 35, varargin{:});
		end
	end
end
