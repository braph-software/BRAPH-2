classdef PPBrainAtlas_Surf < PlotProp
	% PPBrainAtlas_Surf is a plot of brain atlas surface.
	% It is a subclass of <a href="matlab:help PlotProp">PlotProp</a>.
	%
	% PPBrainAtlas_Surf plots for a brain atlas surface.
	% 
	% CALLBACK - This is a callback function:
	% 
	%     pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain atlas figure and its settings figure
	%     pr.<strong>cb_hide</strong>() - hides the brain atlas figure and its settings figure
	%     pr.<strong>cb_close</strong>() - closes the brain atlas figure and its settings figure
	%
	% The list of PPBrainAtlas_Surf properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element (BrainAtlas).
	%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number (BrainAtlas.SURF).
	%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
	%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
	%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
	%  <strong>8</strong> <strong>pba</strong> 	PBA (result, item) is a plot brain atlas.
	%
	% PPBrainAtlas_Surf methods (constructor):
	% PPBrainAtlas_Surf - constructor
	%
	% PPBrainAtlas_Surf methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot property of brain atlas surface/error.
	%  existsProp - checks whether property exists in plot property of brain atlas surface/error.
	%  getPropNumber - returns the property number of plot property of brain atlas surface.
	%  getProps - returns the property list of plot property of brain atlas surface.
	%  getDescription - returns the description of the plot property of brain atlas surface.
	%  getName - returns the name of the plot property of brain atlas surface.
	%  getClass - returns the class of the plot property of brain atlas surface.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PPBrainAtlas_Surf methods:
	%  cb_close - closes the brain atlas figure and its settings figure.
	%  cb_hide - hides the brain atlas figure and its settings figure.
	%  cb_bring_to_front - brings to front the brain atlas figure and its settings figure.
	%  update_brain_atlas - updates the brain atlas.
	%  redraw - resizes the property panel and repositions its graphical objects.
	%  update - updates the content of the property panel and its graphical objects.
	%  draw - draws the panel to manage a brain atlas surface.
	%  cb_button_del - urf/cb_button_del is a function.
	%  cb_button_calc - rf/cb_button_calc is a function.
	%  cb_button_cb - Surf/cb_button_cb is a function.
	%  set_settings - Surf/set_settings is a function.
	%  cb_close_fs - _Surf/cb_close_fs is a function.
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
	% PPBrainAtlas_Surf methods (operators):
	%  isequal - determines whether two PPBrainAtlas_Surf are equal (values, locked)
	%
	% PPBrainAtlas_Surf methods (display):
	%  tostring - string with information about the PPBrainAtlas_Surf
	%  disp - displays information about the PPBrainAtlas_Surf
	%  tree - displays the element of PPBrainAtlas_Surf
	%
	% PPBrainAtlas_Surf method (element list):
	%  getElementList - returns a list with all subelements of PPBrainAtlas_Surf
	%
	% PPBrainAtlas_Surf method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PPBrainAtlas_Surf
	%
	% PPBrainAtlas_Surf method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PPBrainAtlas_Surf
	%
	% PPBrainAtlas_Surf methods (copy):
	%  copy - copies the PPBrainAtlas_Surf
	%  deepclone - deep-clones the PPBrainAtlas_Surf
	%  clone - clones the PPBrainAtlas_Surf
	%
	% PPBrainAtlas_Surf methods (inspection, Static):
	%  getClass - returns PPBrainAtlas_Surf
	%  getName - returns the name of PPBrainAtlas_Surf
	%  getDescription - returns the description of PPBrainAtlas_Surf
	%  getProps - returns the property list of PPBrainAtlas_Surf
	%  getPropNumber - returns the property number of PPBrainAtlas_Surf
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
	% PPBrainAtlas_Surf methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PPBrainAtlas_Surf methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PPBrainAtlas_Surf methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PPBrainAtlas_Surf methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PPBrainAtlas_Surf properties (Constant).
	%  PBA - 8
	%  PBA_TAG - 'pba'
	%  PBA_CATEGORY - 'r'
	%  PBA_FORMAT - 'it'
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
		surf_selector_popup
		plot_brain_atlas_btn
		
		f_pba % figure for PlotBrainAtlas
	end
	properties (Constant) % properties
		PBA = PlotProp.getPropNumber() + 1;
		PBA_TAG = 'pba';
		PBA_CATEGORY = Category.RESULT;
		PBA_FORMAT = Format.ITEM;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot property of brain atlas surface.
			%
			% CLASS = PPBrainAtlas_Surf.GETCLASS() returns the class 'PPBrainAtlas_Surf'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot property of brain atlas surface PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PPBrainAtlas_Surf') returns 'PPBrainAtlas_Surf'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PPBrainAtlas_Surf';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot property of brain atlas surface.
			%
			% NAME = PPBrainAtlas_Surf.GETNAME() returns the name of the 'plot property of brain atlas surface'.
			%  Plot Property Of Brain Atlas Surface.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot property of brain atlas surface PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PPBrainAtlas_Surf') returns the name of 'PPBrainAtlas_Surf'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Property Of Brain Atlas Surface';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot property of brain atlas surface.
			%
			% STR = PPBrainAtlas_Surf.GETDESCRIPTION() returns the description of the 'plot property of brain atlas surface'.
			%  which is:
			%
			%  PPBrainAtlas_Surf plots for a brain atlas surface.
			%  
			%  CALLBACK - This is a callback function:
			%  
			%      pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain atlas figure and its settings figure
			%      pr.<strong>cb_hide</strong>() - hides the brain atlas figure and its settings figure
			%      pr.<strong>cb_close</strong>() - closes the brain atlas figure and its settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot property of brain atlas surface PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PPBrainAtlas_Surf') returns the description of 'PPBrainAtlas_Surf'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PPBrainAtlas_Surf plots for a brain atlas surface.' ...
				'' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain atlas figure and its settings figure' ...
				'    pr.<strong>cb_hide</strong>() - hides the brain atlas figure and its settings figure' ...
				'    pr.<strong>cb_close</strong>() - closes the brain atlas figure and its settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot property of brain atlas surface.
			%
			% PROPS = PPBrainAtlas_Surf.GETPROPS() returns the property list of plot property of brain atlas surface.
			%
			% PROPS = PPBrainAtlas_Surf.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot property of brain atlas surface PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PPBrainAtlas_Surf'[, CATEGORY]) returns the property list of 'PPBrainAtlas_Surf'.
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
						PPBrainAtlas_Surf.PBA
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
						PPBrainAtlas_Surf.PBA
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot property of brain atlas surface.
			%
			% N = PPBrainAtlas_Surf.GETPROPNUMBER() returns the property number of plot property of brain atlas surface.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot property of brain atlas surface PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PPBrainAtlas_Surf') returns the property number of 'PPBrainAtlas_Surf'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 8;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot property of brain atlas surface/error.
			%
			% CHECK = PPBrainAtlas_Surf.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PPBrainAtlas_Surf, PROP) checks whether PROP exists for PPBrainAtlas_Surf.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  Element.EXISTSPROP(PPBrainAtlas_Surf, PROP) throws error if PROP does NOT exist for PPBrainAtlas_Surf.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8 ]);
			else
				assert( ...
					PPBrainAtlas_Surf.existsProp(prop), ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PPBrainAtlas_Surf.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot property of brain atlas surface/error.
			%
			% CHECK = PPBrainAtlas_Surf.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PPBrainAtlas_Surf, TAG) checks whether TAG exists for PPBrainAtlas_Surf.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  Element.EXISTSTAG(PPBrainAtlas_Surf, TAG) throws error if TAG does NOT exist for PPBrainAtlas_Surf.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				ppbrainatlas_surf_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar'  'pba' };
				
				check = any(strcmpi(tag, ppbrainatlas_surf_tag_list));
			else
				assert( ...
					PPBrainAtlas_Surf.existsTag(tag), ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PPBrainAtlas_Surf'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PPBrainAtlas_Surf, POINTER) returns property number of POINTER of PPBrainAtlas_Surf.
			%  PROPERTY = PR.GETPROPPROP(PPBrainAtlas_Surf, POINTER) returns property number of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				ppbrainatlas_surf_tag_list = { 'id'  'bkgcolor'  'el'  'prop'  'title'  'enable'  'waitbar'  'pba' };
				
				tag = pointer;
				PPBrainAtlas_Surf.existsTag(tag);
				
				prop = find(strcmpi(tag, ppbrainatlas_surf_tag_list));
			else % numeric
				prop = pointer;
				PPBrainAtlas_Surf.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PPBrainAtlas_Surf, POINTER) returns tag of POINTER of PPBrainAtlas_Surf.
			%  TAG = PR.GETPROPTAG(PPBrainAtlas_Surf, POINTER) returns tag of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PPBrainAtlas_Surf.existsTag(tag);
			else % numeric
				prop = pointer;
				PPBrainAtlas_Surf.existsProp(prop);
				
				switch prop
					case PPBrainAtlas_Surf.PBA
						tag = PPBrainAtlas_Surf.PBA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PPBrainAtlas_Surf, POINTER) returns category of POINTER of PPBrainAtlas_Surf.
			%  CATEGORY = PR.GETPROPCATEGORY(PPBrainAtlas_Surf, POINTER) returns category of POINTER of PPBrainAtlas_Surf.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					prop_category = PPBrainAtlas_Surf.PBA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PPBrainAtlas_Surf, POINTER) returns format of POINTER of PPBrainAtlas_Surf.
			%  FORMAT = PR.GETPROPFORMAT(PPBrainAtlas_Surf, POINTER) returns format of POINTER of PPBrainAtlas_Surf.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					prop_format = PPBrainAtlas_Surf.PBA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PPBrainAtlas_Surf, POINTER) returns description of POINTER of PPBrainAtlas_Surf.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PPBrainAtlas_Surf, POINTER) returns description of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					prop_description = 'PBA (result, item) is a plot brain atlas.';
				case PPBrainAtlas_Surf.EL
					prop_description = 'EL (metadata, item) is the element (BrainAtlas).';
				case PPBrainAtlas_Surf.PROP
					prop_description = 'PROP (data, scalar) is the property number (BrainAtlas.SURF).';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PPBrainAtlas_Surf, POINTER) returns settings of POINTER of PPBrainAtlas_Surf.
			%  SETTINGS = PR.GETPROPSETTINGS(PPBrainAtlas_Surf, POINTER) returns settings of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					prop_settings = 'PlotBrainAtlas';
				case PPBrainAtlas_Surf.EL
					prop_settings = 'BrainAtlas';
				otherwise
					prop_settings = getPropSettings@PlotProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PPBrainAtlas_Surf.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PPBrainAtlas_Surf.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PPBrainAtlas_Surf, POINTER) returns the default value of POINTER of PPBrainAtlas_Surf.
			%  DEFAULT = PR.GETPROPDEFAULT(PPBrainAtlas_Surf, POINTER) returns the default value of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					prop_default = Format.getFormatDefault(Format.ITEM, PPBrainAtlas_Surf.getPropSettings(prop));
				case PPBrainAtlas_Surf.EL
					prop_default = BrainAtlas();
				case PPBrainAtlas_Surf.PROP
					prop_default = BrainAtlas.SURF;
				otherwise
					prop_default = getPropDefault@PlotProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PPBrainAtlas_Surf.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PPBrainAtlas_Surf.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PPBrainAtlas_Surf, POINTER) returns the conditioned default value of POINTER of PPBrainAtlas_Surf.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PPBrainAtlas_Surf, POINTER) returns the conditioned default value of POINTER of PPBrainAtlas_Surf.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			prop_default = PPBrainAtlas_Surf.conditioning(prop, PPBrainAtlas_Surf.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PPBrainAtlas_Surf, PROP, VALUE) checks VALUE format for PROP of PPBrainAtlas_Surf.
			%  CHECK = PR.CHECKPROP(PPBrainAtlas_Surf, PROP, VALUE) checks VALUE format for PROP of PPBrainAtlas_Surf.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  Element.CHECKPROP(PPBrainAtlas_Surf, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPBrainAtlas_Surf.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			%  PR.CHECKPROP(PPBrainAtlas_Surf, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PPBrainAtlas_Surf.
			%   Error id: [BRAPH2:PPBrainAtlas_Surf:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				case PPBrainAtlas_Surf.PBA
					check = Format.checkFormat(Format.ITEM, value, PPBrainAtlas_Surf.getPropSettings(prop));
				case PPBrainAtlas_Surf.EL
					check = Format.checkFormat(Format.ITEM, value, PPBrainAtlas_Surf.getPropSettings(prop));
				otherwise
					check = checkProp@PlotProp(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PPBrainAtlas_Surf:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PPBrainAtlas_Surf.getPropTag(prop) ' (' PPBrainAtlas_Surf.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PPBrainAtlas_Surf(varargin)
			% PPBrainAtlas_Surf() creates a plot property of brain atlas surface.
			%
			% PPBrainAtlas_Surf(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PPBrainAtlas_Surf(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PPBrainAtlas_Surf properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>el</strong> 	EL (metadata, item) is the element (BrainAtlas).
			%  <strong>4</strong> <strong>prop</strong> 	PROP (data, scalar) is the property number (BrainAtlas.SURF).
			%  <strong>5</strong> <strong>title</strong> 	TITLE (metadata, string) is the property title.
			%  <strong>6</strong> <strong>enable</strong> 	ENABLE (metadata, option) switches between off and inactive fields.
			%  <strong>7</strong> <strong>waitbar</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar when executing calculations.
			%  <strong>8</strong> <strong>pba</strong> 	PBA (result, item) is a plot brain atlas.
			%
			% See also Category, Format, set, check.
			
			pr = pr@PlotProp(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PPBrainAtlas_Surf.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= PlotProp.getPropNumber()
						value = conditioning@PlotProp(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop)
		
			switch prop
				case PPBrainAtlas_Surf.PBA
					rng(pr.getPropSeed(PPBrainAtlas_Surf.PBA), 'twister')
					
					ba = pr.get('el');
					pba =  PlotBrainAtlas('ATLAS', ba);
					value = pba;
					
				otherwise
					value = calculateValue@PlotProp(pr, prop);
					
			end
		end
	end
	methods % methods
		function h_panel = draw(pr, varargin)
		    %DRAW draws the panel to manage a brain atlas surface.
		    %
		    % DRAW(PR) draws the panel to manage a brain atlas surface, with a
		    %  pupupmenu to select the brain surface and a button to open it in a
		    %  separate GUI.
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
		
		    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_f_pba}, varargin{:});
		    function close_f_pba(~, ~)
		        if check_graphics(pr.f_pba, 'figure')
		            close(pr.f_pba)
		        end
		    end
		
		    pr.surf_selector_popup = uicontrol( ...
		        'Parent', pr.p, ...
		        'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.02 .1 .46 .5], ... 
		        'String', get_brain_surfaces(), ...
		        'Value', get_surf_selector_popup_value(), ...
		        'Callback', {@cb_surf_selector_popup} ...
		        );
		        function surfs = get_brain_surfaces()
		            surfs_path = [fileparts(which('braph2.m')) filesep() 'brainsurfs'];
		            files = dir(fullfile(surfs_path, '*.nv'));
		            files_array = struct2cell(files);
		            surfs = cellfun(@(x) erase(x, '.nv'), files_array(1, :), 'UniformOutput', false);
		        end
		        function value = get_surf_selector_popup_value()
		            ba = pr.get('EL');
		            ba_surf_id = erase(ba.get('SURF').get('ID'), '.nv');
		            
		            value = find(strcmp(ba_surf_id, get_brain_surfaces()));
		            if isempty(value) % ba surf is not defined, so value is empty
		                value = 6; % uses a standard brain surface
		            end
		        end
		        function cb_surf_selector_popup(~, ~)
		            brain_surfaces = get_brain_surfaces();
		            selected_surface = brain_surfaces{get(pr.surf_selector_popup, 'Value')};
		
		            ba = pr.get('EL');
		            ba.set('SURF', ImporterBrainSurfaceNV('FILE', [selected_surface '.nv']).get('SURF'));
		
		            pr.update();
		        end
		
		    pr.plot_brain_atlas_btn = uicontrol(...
		        'Style', 'pushbutton', ...
		        'Parent', pr.p, ...
		        'Units', 'normalized', ...
		        'String', 'Plot Brain Atlas', ...
		        'Position', [.52 .1 .46 .65], ...
		        'Callback', {@cb_plot_brain_atlas_btn} ...
		        );
		        function cb_plot_brain_atlas_btn(~, ~)
		            % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
		            set(pr.plot_brain_atlas_btn, 'Enable', 'off');
		            set(pr.surf_selector_popup, 'Enable', 'off');
		            drawnow()
		            
		            % determine position for figure of PlotBrainAtlas
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
		            
		            pr.f_pba = figure( ...
		                'NumberTitle', 'off', ...
		                'Units', 'normalized', ...
		                'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
		                'CloseRequestFcn', {@cb_f_pba_close} ...
		                );
		            set_braph2icon(pr.f_pba)
		            set(pr.f_pba, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
		            function cb_f_pba_close(~, ~)
		                delete(pr.f_pba) % deletes also f_settings
		                pr.update() % re-activates the surf_selector_popup and plot_brain_atlas_btn
		            end
		
		        menu_about = BRAPH2.add_menu_about(pr.f_pba);
		% % %             menu_about = uimenu(pr.f_pba, 'Label', 'About');
		% % %             uimenu(menu_about, ...
		% % %                 'Label', 'License ...', ...
		% % %                 'Callback', {@cb_license})
		% % %             function cb_license(~, ~)
		% % %                 BRAPH2.license()
		% % %             end
		% % %             uimenu(menu_about, ...
		% % %                 'Label', 'About ...', ...
		% % %                 'Callback', {@cb_about})
		% % %             function cb_about(~, ~)
		% % %                 BRAPH2.about()
		% % %             end
		
		            ui_toolbar = findall(pr.f_pba, 'Tag', 'FigureToolBar');
		            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
		            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
		
		            % Plot PlotBrainAtlas panel
		            ba = pr.get('EL');
		            surf = ba.get('SURF');
		            pba = pr.memorize('PBA');
		            pba.set('SURF', surf);
		            pba.draw('Parent', pr.f_pba)
		            
		            % Plot settings panel
		            f_settings = pba.settings();
		            set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
		            f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
		            f_settings.OuterPosition(2) = f_ba_y/screen_h;
		            
		            % updates PlotProp panel
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
		    
		    ba = pr.get('EL');
		    
		    if check_graphics(pr.f_pba, 'figure')
		        set(pr.f_pba, ...
		            'Name', ba.get('ID') ...
		            )            
		        
		        % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
		        set(pr.plot_brain_atlas_btn, 'Enable', 'off');
		        set(pr.surf_selector_popup, 'Enable', 'off');
		    else
		        % enables creation of a PlotBrainAtlas figure
		        set(pr.plot_brain_atlas_btn, 'Enable', 'on');
		        set(pr.surf_selector_popup, 'Enable', 'on');
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
		    
		    pr.redraw@PlotProp('Height', 4, varargin{:});
		end
		function update_brain_atlas(pr)
		    %UPDATE_BRAIN_ATLAS updates the brain atlas.
		    %
		    % UPDATE_BRAIN_ATLAS(PR) updates the brain atlas. Usually used
		    %  triggered by PPBrainAtlas_BRDict.
		    %
		    % See also PPBrainAtlas_BRDict.
		    
		    if isgraphics(pr.f_pba, 'figure')
		        pba = pr.get('PBA');
		        try
		            pba.draw('Parent', pr.f_pba)
		        catch e
		            if strcmp(e.identifier, 'MATLAB:badsubscript') % regions added too fast by the user
		                % do nothing
		            else
		                rethrow(e)
		            end
		        end
		    end
		end
		function cb_bring_to_front(pr)
		    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
		    %  settings figure.
		    %
		    % See also cb_hide, cb_close.
		
		    % brings to front settings panel
		    pr.cb_bring_to_front@PlotProp();
		
		    % brings to front brain atlas figure
		    children = get(pr.f_pba, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
		            pba = get(children(i), 'UserData');
		            pba.cb_bring_to_front()
		        end
		    end
		end
		function cb_hide(pr)
		    %CB_HIDE hides the brain atlas figure and its settings figure.
		    %
		    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hides settings panel
		    pr.cb_hide@PlotProp();
		
		    % hides brain atlas figure
		    children = get(pr.f_pba, 'Children');
		    for i = 1:1:length(children)
		        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
		            pba = get(children(i), 'UserData');
		            pba.cb_hide()
		        end
		    end
		end
		function cb_close(pr)
		    %CB_CLOSE closes the brain atlas figure and its settings figure.
		    %
		    % CB_CLOSE(PR) closes the brain atlas figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cd_hide.
		
		    % closes settings panel
		    pr.cb_close@PlotProp();
		
		    % closes brain atlas figure
		    if check_graphics(pr.f_pba, 'figure')
		        children = get(pr.f_pba, 'Children');
		        for i = 1:1:length(children)
		            if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
		                pba = get(children(i), 'UserData');
		                pba.cb_close()
		            end
		        end
		    end
		end
	end
end
