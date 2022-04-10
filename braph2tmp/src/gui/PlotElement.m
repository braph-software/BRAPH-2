classdef PlotElement < Plot
	% PlotElement is a plot of an element.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% PlotElement plots all properties of an element in a resizable scrollable panel.
	%  The high-level parent panel PP has fixed dimensions and contains a scollable panel
	%  (i.e., a panel P and a slider S). P contains a series of stacked property panels,
	%  one for each property of the element EL being plotted.
	%  Each time that PP is resized or S scrolled, all contents of P are resized as well.
	% 
	% Importnat notes:
	% 1. The key methods that need to be called are draw() and reinit().
	% 2. The methods update(), redraw() and slide() are used internally by PlotElement 
	%   and typically do not need to be called explicitly.
	% 
	% CONSTRUCTOR - To construct a PlotElement use the constructor:
	% 
	%     pe = PlotElement(''EL'', <element>)
	%     
	% DRAW - To create the element panel, call pe.draw():
	% 
	%     pp = pe.<strong>draw</strong>();
	%     pp = pe.<strong>draw</strong>(''Parent'', f);
	%  
	%  Here, pp is the parent panel (see above).
	%  Typically, f is a figure where the parent panel is plotted.
	%  It is also possible to use pr.draw() to get the parent panel handle
	%   and to set its properties (as in the case of Plot and PlotProp).
	% 
	% REINIT - To reinitialize the element plot with a new element, call:
	% 
	%     pe.reinit(<new element>)
	% 
	%  This function resets both the element and the panel using the new element.
	%  Importnatly, the new element must be of exactly the same class as the old element.
	% 
	% 
	% CALLBACK - This is a callback function:
	% 
	%     pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
	%     pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
	%     pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures
	%
	% The list of PlotElement properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>dw</strong> 	DW (metadata, scalar) is the margin along the width in character units.
	%  <strong>4</strong> <strong>dh</strong> 	DH (metadata, scalar) is the margin along the height in character units.
	%  <strong>5</strong> <strong>wslider</strong> 	WSLIDER (metadata, scalar) is the slider width in character units.
	%  <strong>6</strong> <strong>mcolor</strong> 	MCOLOR (metadata, rvector) is background color of the metadata properties.
	%  <strong>7</strong> <strong>pcolor</strong> 	PCOLOR (metadata, rvector) is background color of the parameter properties.
	%  <strong>8</strong> <strong>dcolor</strong> 	DCOLOR (metadata, rvector) is background color of the data properties.
	%  <strong>9</strong> <strong>rcolor</strong> 	RCOLOR (metadata, rvector) is background color of the result properties.
	%  <strong>10</strong> <strong>fcolor</strong> 	FCOLOR (metadata, rvector) is background color of the figure properties.
	%  <strong>11</strong> <strong>gcolor</strong> 	GCOLOR (metadata, rvector) is background color of the gui properties.
	%  <strong>12</strong> <strong>el</strong> 	EL (metadata, item) is the element to be plotted.
	%  <strong>13</strong> <strong>pr_dict</strong> 	PR_DICT (result, idict) is a dictionary of the property plots.
	%
	% PlotElement methods (constructor):
	% PlotElement - constructor
	%
	% PlotElement methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot element/error.
	%  existsProp - checks whether property exists in plot element/error.
	%  getPropNumber - returns the property number of plot element.
	%  getProps - returns the property list of plot element.
	%  getDescription - returns the description of the plot element.
	%  getName - returns the name of the plot element.
	%  getClass - returns the class of the plot element.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotElement methods:
	%  cb_close - closes the figure with the element panel and its dependent figures.
	%  cb_hide - hides the figure with the element panel and its dependent figures.
	%  cb_bring_to_front - brings to front the figure with the element panel and its dependent figures.
	%  reinit - resets the element, updates and redraws the element plot.
	%  slide - ement/slide is a function.
	%  redraw - ment/redraw is a function.
	%  update - updates the content of the prop panels and their graphical objects.
	%  draw - draws the element panel.
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
	% PlotElement methods (operators):
	%  isequal - determines whether two PlotElement are equal (values, locked)
	%
	% PlotElement methods (display):
	%  tostring - string with information about the PlotElement
	%  disp - displays information about the PlotElement
	%  tree - displays the element of PlotElement
	%
	% PlotElement method (element list):
	%  getElementList - returns a list with all subelements of PlotElement
	%
	% PlotElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotElement
	%
	% PlotElement method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotElement
	%
	% PlotElement methods (copy):
	%  copy - copies the PlotElement
	%  deepclone - deep-clones the PlotElement
	%  clone - clones the PlotElement
	%
	% PlotElement methods (inspection, Static):
	%  getClass - returns PlotElement
	%  getName - returns the name of PlotElement
	%  getDescription - returns the description of PlotElement
	%  getProps - returns the property list of PlotElement
	%  getPropNumber - returns the property number of PlotElement
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
	% PlotElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotElement methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotElement methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotElement methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotElement properties (Constant).
	%  DW - 3
	%  DW_TAG - 'dw'
	%  DW_CATEGORY - 'm'
	%  DW_FORMAT - 'nn'
	%  DH - 4
	%  DH_TAG - 'dh'
	%  DH_CATEGORY - 'm'
	%  DH_FORMAT - 'nn'
	%  WSLIDER - 5
	%  WSLIDER_TAG - 'wslider'
	%  WSLIDER_CATEGORY - 'm'
	%  WSLIDER_FORMAT - 'nn'
	%  MCOLOR - 6
	%  MCOLOR_TAG - 'mcolor'
	%  MCOLOR_CATEGORY - 'm'
	%  MCOLOR_FORMAT - 'nr'
	%  PCOLOR - 7
	%  PCOLOR_TAG - 'pcolor'
	%  PCOLOR_CATEGORY - 'm'
	%  PCOLOR_FORMAT - 'nr'
	%  DCOLOR - 8
	%  DCOLOR_TAG - 'dcolor'
	%  DCOLOR_CATEGORY - 'm'
	%  DCOLOR_FORMAT - 'nr'
	%  RCOLOR - 9
	%  RCOLOR_TAG - 'rcolor'
	%  RCOLOR_CATEGORY - 'm'
	%  RCOLOR_FORMAT - 'nr'
	%  FCOLOR - 10
	%  FCOLOR_TAG - 'fcolor'
	%  FCOLOR_CATEGORY - 'm'
	%  FCOLOR_FORMAT - 'nr'
	%  GCOLOR - 11
	%  GCOLOR_TAG - 'gcolor'
	%  GCOLOR_CATEGORY - 'm'
	%  GCOLOR_FORMAT - 'nr'
	%  EL - 12
	%  EL_TAG - 'el'
	%  EL_CATEGORY - 'm'
	%  EL_FORMAT - 'it'
	%  PR_DICT - 13
	%  PR_DICT_TAG - 'pr_dict'
	%  PR_DICT_CATEGORY - 'r'
	%  PR_DICT_FORMAT - 'di'
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
	% See also GUI, PlotProp.
	
	properties (Access = private) % element properties
		pp % handle for outer (parent) panel
		p % handle for scrollable panel
		s % handle for slider
		pr_list % list of handles for prop panels
	end
	properties (Constant) % properties
		DW = Plot.getPropNumber() + 1;
		DW_TAG = 'dw';
		DW_CATEGORY = Category.METADATA;
		DW_FORMAT = Format.SCALAR;
		
		DH = Plot.getPropNumber() + 2;
		DH_TAG = 'dh';
		DH_CATEGORY = Category.METADATA;
		DH_FORMAT = Format.SCALAR;
		
		WSLIDER = Plot.getPropNumber() + 3;
		WSLIDER_TAG = 'wslider';
		WSLIDER_CATEGORY = Category.METADATA;
		WSLIDER_FORMAT = Format.SCALAR;
		
		MCOLOR = Plot.getPropNumber() + 4;
		MCOLOR_TAG = 'mcolor';
		MCOLOR_CATEGORY = Category.METADATA;
		MCOLOR_FORMAT = Format.RVECTOR;
		
		PCOLOR = Plot.getPropNumber() + 5;
		PCOLOR_TAG = 'pcolor';
		PCOLOR_CATEGORY = Category.METADATA;
		PCOLOR_FORMAT = Format.RVECTOR;
		
		DCOLOR = Plot.getPropNumber() + 6;
		DCOLOR_TAG = 'dcolor';
		DCOLOR_CATEGORY = Category.METADATA;
		DCOLOR_FORMAT = Format.RVECTOR;
		
		RCOLOR = Plot.getPropNumber() + 7;
		RCOLOR_TAG = 'rcolor';
		RCOLOR_CATEGORY = Category.METADATA;
		RCOLOR_FORMAT = Format.RVECTOR;
		
		FCOLOR = Plot.getPropNumber() + 8;
		FCOLOR_TAG = 'fcolor';
		FCOLOR_CATEGORY = Category.METADATA;
		FCOLOR_FORMAT = Format.RVECTOR;
		
		GCOLOR = Plot.getPropNumber() + 9;
		GCOLOR_TAG = 'gcolor';
		GCOLOR_CATEGORY = Category.METADATA;
		GCOLOR_FORMAT = Format.RVECTOR;
		
		EL = Plot.getPropNumber() + 10;
		EL_TAG = 'el';
		EL_CATEGORY = Category.METADATA;
		EL_FORMAT = Format.ITEM;
		
		PR_DICT = Plot.getPropNumber() + 11;
		PR_DICT_TAG = 'pr_dict';
		PR_DICT_CATEGORY = Category.RESULT;
		PR_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
		function pe_class = getClass()
			%GETCLASS returns the class of the plot element.
			%
			% CLASS = PlotElement.GETCLASS() returns the class 'PlotElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PE.GETCLASS() returns the class of the plot element PE.
			%  CLASS = Element.GETCLASS(PE) returns the class of 'PE'.
			%  CLASS = Element.GETCLASS('PlotElement') returns 'PlotElement'.
			%
			% See also getName, getDescription.
			
			pe_class = 'PlotElement';
		end
		function pe_name = getName()
			%GETNAME returns the name of the plot element.
			%
			% NAME = PlotElement.GETNAME() returns the name of the 'plot element'.
			%  Plot Element.
			%
			% Alternative forms to call this method are:
			%  NAME = PE.GETNAME() returns the name of the plot element PE.
			%  NAME = Element.GETNAME(PE) returns the name of 'PE'.
			%  NAME = Element.GETNAME('PlotElement') returns the name of 'PlotElement'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pe_name = 'Plot Element';
		end
		function pe_description = getDescription()
			%GETDESCRIPTION returns the description of the plot element.
			%
			% STR = PlotElement.GETDESCRIPTION() returns the description of the 'plot element'.
			%  which is:
			%
			%  PlotElement plots all properties of an element in a resizable scrollable panel.
			%   The high-level parent panel PP has fixed dimensions and contains a scollable panel
			%   (i.e., a panel P and a slider S). P contains a series of stacked property panels,
			%   one for each property of the element EL being plotted.
			%   Each time that PP is resized or S scrolled, all contents of P are resized as well.
			%  
			%  Importnat notes:
			%  1. The key methods that need to be called are draw() and reinit().
			%  2. The methods update(), redraw() and slide() are used internally by PlotElement 
			%    and typically do not need to be called explicitly.
			%  
			%  CONSTRUCTOR - To construct a PlotElement use the constructor:
			%  
			%      pe = PlotElement(''EL'', <element>)
			%      
			%  DRAW - To create the element panel, call pe.draw():
			%  
			%      pp = pe.<strong>draw</strong>();
			%      pp = pe.<strong>draw</strong>(''Parent'', f);
			%   
			%   Here, pp is the parent panel (see above).
			%   Typically, f is a figure where the parent panel is plotted.
			%   It is also possible to use pr.draw() to get the parent panel handle
			%    and to set its properties (as in the case of Plot and PlotProp).
			%  
			%  REINIT - To reinitialize the element plot with a new element, call:
			%  
			%      pe.reinit(<new element>)
			%  
			%   This function resets both the element and the panel using the new element.
			%   Importnatly, the new element must be of exactly the same class as the old element.
			%  
			%  
			%  CALLBACK - This is a callback function:
			%  
			%      pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
			%      pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
			%      pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures
			%
			% Alternative forms to call this method are:
			%  STR = PE.GETDESCRIPTION() returns the description of the plot element PE.
			%  STR = Element.GETDESCRIPTION(PE) returns the description of 'PE'.
			%  STR = Element.GETDESCRIPTION('PlotElement') returns the description of 'PlotElement'.
			%
			% See also getClass, getName.
			
			pe_description = [
				'PlotElement plots all properties of an element in a resizable scrollable panel.' ...
				' The high-level parent panel PP has fixed dimensions and contains a scollable panel' ...
				' (i.e., a panel P and a slider S). P contains a series of stacked property panels,' ...
				' one for each property of the element EL being plotted.' ...
				' Each time that PP is resized or S scrolled, all contents of P are resized as well.' ...
				'' ...
				'Importnat notes:' ...
				'1. The key methods that need to be called are draw() and reinit().' ...
				'2. The methods update(), redraw() and slide() are used internally by PlotElement ' ...
				'  and typically do not need to be called explicitly.' ...
				'' ...
				'CONSTRUCTOR - To construct a PlotElement use the constructor:' ...
				'' ...
				'    pe = PlotElement(''EL'', <element>)' ...
				'    ' ...
				'DRAW - To create the element panel, call pe.draw():' ...
				'' ...
				'    pp = pe.<strong>draw</strong>();' ...
				'    pp = pe.<strong>draw</strong>(''Parent'', f);' ...
				' ' ...
				' Here, pp is the parent panel (see above).' ...
				' Typically, f is a figure where the parent panel is plotted.' ...
				' It is also possible to use pr.draw() to get the parent panel handle' ...
				'  and to set its properties (as in the case of Plot and PlotProp).' ...
				'' ...
				'REINIT - To reinitialize the element plot with a new element, call:' ...
				'' ...
				'    pe.reinit(<new element>)' ...
				'' ...
				' This function resets both the element and the panel using the new element.' ...
				' Importnatly, the new element must be of exactly the same class as the old element.' ...
				'' ...
				'' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures' ...
				'    pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures' ...
				'    pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot element.
			%
			% PROPS = PlotElement.GETPROPS() returns the property list of plot element.
			%
			% PROPS = PlotElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PE.GETPROPS([CATEGORY]) returns the property list of the plot element PE.
			%  PROPS = Element.GETPROPS(PE[, CATEGORY]) returns the property list of 'PE'.
			%  PROPS = Element.GETPROPS('PlotElement'[, CATEGORY]) returns the property list of 'PlotElement'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotElement.DW
						PlotElement.DH
						PlotElement.WSLIDER
						PlotElement.MCOLOR
						PlotElement.PCOLOR
						PlotElement.DCOLOR
						PlotElement.RCOLOR
						PlotElement.FCOLOR
						PlotElement.GCOLOR
						PlotElement.EL
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						];
				case Category.RESULT
					prop_list = [
						Plot.getProps(Category.RESULT)
						PlotElement.PR_DICT
						];
				case Category.FIGURE
					prop_list = [
						Plot.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						Plot.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						Plot.getProps()
						PlotElement.DW
						PlotElement.DH
						PlotElement.WSLIDER
						PlotElement.MCOLOR
						PlotElement.PCOLOR
						PlotElement.DCOLOR
						PlotElement.RCOLOR
						PlotElement.FCOLOR
						PlotElement.GCOLOR
						PlotElement.EL
						PlotElement.PR_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot element.
			%
			% N = PlotElement.GETPROPNUMBER() returns the property number of plot element.
			%
			% Alternative forms to call this method are:
			%  N = PE.GETPROPNUMBER() returns the property number of the plot element PE.
			%  N = Element.GETPROPNUMBER(PE) returns the property number of 'PE'.
			%  N = Element.GETPROPNUMBER('PlotElement') returns the property number of 'PlotElement'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 13;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot element/error.
			%
			% CHECK = PlotElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSPROP(PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PE, PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PlotElement, PROP) checks whether PROP exists for PlotElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSPROP(PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  Element.EXISTSPROP(PE, PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  Element.EXISTSPROP(PlotElement, PROP) throws error if PROP does NOT exist for PlotElement.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13 ]);
			else
				assert( ...
					PlotElement.existsProp(prop), ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotElement.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot element/error.
			%
			% CHECK = PlotElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSTAG(TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PE, TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PlotElement, TAG) checks whether TAG exists for PlotElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSTAG(TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  Element.EXISTSTAG(PE, TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  Element.EXISTSTAG(PlotElement, TAG) throws error if TAG does NOT exist for PlotElement.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotelement_tag_list = { 'id'  'bkgcolor'  'dw'  'dh'  'wslider'  'mcolor'  'pcolor'  'dcolor'  'rcolor'  'fcolor'  'gcolor'  'el'  'pr_dict' };
				
				check = any(strcmpi(tag, plotelement_tag_list));
			else
				assert( ...
					PlotElement.existsTag(tag), ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotElement'] ...
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
			%  PROPERTY = PE.GETPROPPROP(POINTER) returns property number of POINTER of PE.
			%  PROPERTY = Element.GETPROPPROP(PlotElement, POINTER) returns property number of POINTER of PlotElement.
			%  PROPERTY = PE.GETPROPPROP(PlotElement, POINTER) returns property number of POINTER of PlotElement.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotelement_tag_list = { 'id'  'bkgcolor'  'dw'  'dh'  'wslider'  'mcolor'  'pcolor'  'dcolor'  'rcolor'  'fcolor'  'gcolor'  'el'  'pr_dict' };
				
				tag = pointer;
				PlotElement.existsTag(tag);
				
				prop = find(strcmpi(tag, plotelement_tag_list));
			else % numeric
				prop = pointer;
				PlotElement.existsProp(prop);
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
			%  TAG = PE.GETPROPTAG(POINTER) returns tag of POINTER of PE.
			%  TAG = Element.GETPROPTAG(PlotElement, POINTER) returns tag of POINTER of PlotElement.
			%  TAG = PE.GETPROPTAG(PlotElement, POINTER) returns tag of POINTER of PlotElement.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotElement.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotElement.existsProp(prop);
				
				switch prop
					case PlotElement.DW
						tag = PlotElement.DW_TAG;
					case PlotElement.DH
						tag = PlotElement.DH_TAG;
					case PlotElement.WSLIDER
						tag = PlotElement.WSLIDER_TAG;
					case PlotElement.MCOLOR
						tag = PlotElement.MCOLOR_TAG;
					case PlotElement.PCOLOR
						tag = PlotElement.PCOLOR_TAG;
					case PlotElement.DCOLOR
						tag = PlotElement.DCOLOR_TAG;
					case PlotElement.RCOLOR
						tag = PlotElement.RCOLOR_TAG;
					case PlotElement.FCOLOR
						tag = PlotElement.FCOLOR_TAG;
					case PlotElement.GCOLOR
						tag = PlotElement.GCOLOR_TAG;
					case PlotElement.EL
						tag = PlotElement.EL_TAG;
					case PlotElement.PR_DICT
						tag = PlotElement.PR_DICT_TAG;
					otherwise
						tag = getPropTag@Plot(prop);
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
			%  CATEGORY = PE.GETPROPCATEGORY(POINTER) returns category of POINTER of PE.
			%  CATEGORY = Element.GETPROPCATEGORY(PlotElement, POINTER) returns category of POINTER of PlotElement.
			%  CATEGORY = PE.GETPROPCATEGORY(PlotElement, POINTER) returns category of POINTER of PlotElement.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					prop_category = PlotElement.DW_CATEGORY;
				case PlotElement.DH
					prop_category = PlotElement.DH_CATEGORY;
				case PlotElement.WSLIDER
					prop_category = PlotElement.WSLIDER_CATEGORY;
				case PlotElement.MCOLOR
					prop_category = PlotElement.MCOLOR_CATEGORY;
				case PlotElement.PCOLOR
					prop_category = PlotElement.PCOLOR_CATEGORY;
				case PlotElement.DCOLOR
					prop_category = PlotElement.DCOLOR_CATEGORY;
				case PlotElement.RCOLOR
					prop_category = PlotElement.RCOLOR_CATEGORY;
				case PlotElement.FCOLOR
					prop_category = PlotElement.FCOLOR_CATEGORY;
				case PlotElement.GCOLOR
					prop_category = PlotElement.GCOLOR_CATEGORY;
				case PlotElement.EL
					prop_category = PlotElement.EL_CATEGORY;
				case PlotElement.PR_DICT
					prop_category = PlotElement.PR_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@Plot(prop);
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
			%  FORMAT = PE.GETPROPFORMAT(POINTER) returns format of POINTER of PE.
			%  FORMAT = Element.GETPROPFORMAT(PlotElement, POINTER) returns format of POINTER of PlotElement.
			%  FORMAT = PE.GETPROPFORMAT(PlotElement, POINTER) returns format of POINTER of PlotElement.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					prop_format = PlotElement.DW_FORMAT;
				case PlotElement.DH
					prop_format = PlotElement.DH_FORMAT;
				case PlotElement.WSLIDER
					prop_format = PlotElement.WSLIDER_FORMAT;
				case PlotElement.MCOLOR
					prop_format = PlotElement.MCOLOR_FORMAT;
				case PlotElement.PCOLOR
					prop_format = PlotElement.PCOLOR_FORMAT;
				case PlotElement.DCOLOR
					prop_format = PlotElement.DCOLOR_FORMAT;
				case PlotElement.RCOLOR
					prop_format = PlotElement.RCOLOR_FORMAT;
				case PlotElement.FCOLOR
					prop_format = PlotElement.FCOLOR_FORMAT;
				case PlotElement.GCOLOR
					prop_format = PlotElement.GCOLOR_FORMAT;
				case PlotElement.EL
					prop_format = PlotElement.EL_FORMAT;
				case PlotElement.PR_DICT
					prop_format = PlotElement.PR_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@Plot(prop);
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
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotElement, POINTER) returns description of POINTER of PlotElement.
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(PlotElement, POINTER) returns description of POINTER of PlotElement.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					prop_description = 'DW (metadata, scalar) is the margin along the width in character units.';
				case PlotElement.DH
					prop_description = 'DH (metadata, scalar) is the margin along the height in character units.';
				case PlotElement.WSLIDER
					prop_description = 'WSLIDER (metadata, scalar) is the slider width in character units.';
				case PlotElement.MCOLOR
					prop_description = 'MCOLOR (metadata, rvector) is background color of the metadata properties.';
				case PlotElement.PCOLOR
					prop_description = 'PCOLOR (metadata, rvector) is background color of the parameter properties.';
				case PlotElement.DCOLOR
					prop_description = 'DCOLOR (metadata, rvector) is background color of the data properties.';
				case PlotElement.RCOLOR
					prop_description = 'RCOLOR (metadata, rvector) is background color of the result properties.';
				case PlotElement.FCOLOR
					prop_description = 'FCOLOR (metadata, rvector) is background color of the figure properties.';
				case PlotElement.GCOLOR
					prop_description = 'GCOLOR (metadata, rvector) is background color of the gui properties.';
				case PlotElement.EL
					prop_description = 'EL (metadata, item) is the element to be plotted.';
				case PlotElement.PR_DICT
					prop_description = 'PR_DICT (result, idict) is a dictionary of the property plots.';
				otherwise
					prop_description = getPropDescription@Plot(prop);
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
			%  SETTINGS = PE.GETPROPSETTINGS(POINTER) returns settings of POINTER of PE.
			%  SETTINGS = Element.GETPROPSETTINGS(PlotElement, POINTER) returns settings of POINTER of PlotElement.
			%  SETTINGS = PE.GETPROPSETTINGS(PlotElement, POINTER) returns settings of POINTER of PlotElement.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotElement.DH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotElement.WSLIDER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotElement.MCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.PCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.DCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.RCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.FCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.GCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotElement.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotElement.PR_DICT
					prop_settings = 'PlotProp';
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotElement, POINTER) returns the default value of POINTER of PlotElement.
			%  DEFAULT = PE.GETPROPDEFAULT(PlotElement, POINTER) returns the default value of POINTER of PlotElement.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					prop_default = 1;
				case PlotElement.DH
					prop_default = .5;
				case PlotElement.WSLIDER
					prop_default = 5;
				case PlotElement.MCOLOR
					prop_default = BRAPH2.COL_M;
				case PlotElement.PCOLOR
					prop_default = BRAPH2.COL_P;
				case PlotElement.DCOLOR
					prop_default = BRAPH2.COL_D;
				case PlotElement.RCOLOR
					prop_default = BRAPH2.COL_R;
				case PlotElement.FCOLOR
					prop_default = BRAPH2.COL_F;
				case PlotElement.GCOLOR
					prop_default = BRAPH2.COL_G;
				case PlotElement.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PlotElement.getPropSettings(prop));
				case PlotElement.PR_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PlotElement.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotElement, POINTER) returns the conditioned default value of POINTER of PlotElement.
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(PlotElement, POINTER) returns the conditioned default value of POINTER of PlotElement.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotElement.getPropProp(pointer);
			
			prop_default = PlotElement.conditioning(prop, PlotElement.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PE.
			%  CHECK = Element.CHECKPROP(PlotElement, PROP, VALUE) checks VALUE format for PROP of PlotElement.
			%  CHECK = PE.CHECKPROP(PlotElement, PROP, VALUE) checks VALUE format for PROP of PlotElement.
			% 
			% PE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotElement:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PE.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  Element.CHECKPROP(PlotElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotElement.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			%  PE.CHECKPROP(PlotElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotElement.
			%   Error id: [BRAPH2:PlotElement:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				case PlotElement.DW
					check = Format.checkFormat(Format.SCALAR, value, PlotElement.getPropSettings(prop));
				case PlotElement.DH
					check = Format.checkFormat(Format.SCALAR, value, PlotElement.getPropSettings(prop));
				case PlotElement.WSLIDER
					check = Format.checkFormat(Format.SCALAR, value, PlotElement.getPropSettings(prop));
				case PlotElement.MCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.PCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.DCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.RCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.FCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.GCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotElement.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotElement.EL
					check = Format.checkFormat(Format.ITEM, value, PlotElement.getPropSettings(prop));
				case PlotElement.PR_DICT
					check = Format.checkFormat(Format.IDICT, value, PlotElement.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotElement.getPropTag(prop) ' (' PlotElement.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pe = PlotElement(varargin)
			% PlotElement() creates a plot element.
			%
			% PlotElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotElement(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotElement properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>dw</strong> 	DW (metadata, scalar) is the margin along the width in character units.
			%  <strong>4</strong> <strong>dh</strong> 	DH (metadata, scalar) is the margin along the height in character units.
			%  <strong>5</strong> <strong>wslider</strong> 	WSLIDER (metadata, scalar) is the slider width in character units.
			%  <strong>6</strong> <strong>mcolor</strong> 	MCOLOR (metadata, rvector) is background color of the metadata properties.
			%  <strong>7</strong> <strong>pcolor</strong> 	PCOLOR (metadata, rvector) is background color of the parameter properties.
			%  <strong>8</strong> <strong>dcolor</strong> 	DCOLOR (metadata, rvector) is background color of the data properties.
			%  <strong>9</strong> <strong>rcolor</strong> 	RCOLOR (metadata, rvector) is background color of the result properties.
			%  <strong>10</strong> <strong>fcolor</strong> 	FCOLOR (metadata, rvector) is background color of the figure properties.
			%  <strong>11</strong> <strong>gcolor</strong> 	GCOLOR (metadata, rvector) is background color of the gui properties.
			%  <strong>12</strong> <strong>el</strong> 	EL (metadata, item) is the element to be plotted.
			%  <strong>13</strong> <strong>pr_dict</strong> 	PR_DICT (result, idict) is a dictionary of the property plots.
			%
			% See also Category, Format, set, check.
			
			pe = pe@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotElement.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Plot.getPropNumber()
						value = conditioning@Plot(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pe, prop)
		
			switch prop
				case PlotElement.PR_DICT
					rng(pe.getPropSeed(PlotElement.PR_DICT), 'twister')
					
					el = pe.get('EL');
					
					[order, title, visible] = load_layout(el);
					number_visible_prop = sum(visible);
					
					pr_list = cell(1, number_visible_prop);
					for prop = 1:1:el.getPropNumber()
					    if visible(prop)
					        switch el.getPropCategory(prop)
					            case Category.METADATA
					                color = pe.get('MCOLOR');
					            case Category.PARAMETER
					                color = pe.get('PCOLOR');
					            case Category.DATA
					                color = pe.get('DCOLOR');
					            case Category.RESULT
					                color = pe.get('RCOLOR');
					        end
					
					        pr_list{order(prop)} = el.getPlotProp(prop, ...
					            'ID', el.getPropTag(prop), ...
					            'TITLE', title{prop}, ...
					            'BKGCOLOR', color);
					    end
					end
					
					value = IndexedDictionary( ...
					    'ID', el.tostring(), ...
					    'IT_CLASS', 'PlotProp', ...
					    'IT_KEY', 1, ...
					    'IT_LIST', pr_list ...
					    );
					
				otherwise
					value = calculateValue@Plot(pe, prop);
					
			end
		end
	end
	methods % methods
		function h_panel = draw(pe, varargin)
		    %DRAW draws the element panel.
		    %
		    % DRAW(PE) draws the element parent panel, which contains a panel that
		    %  is crollable using a slider.
		    %
		    % H = DRAW(PE) returns a handle to the element parent panel.
		    %
		    % DRAW(PE, 'Property', VALUE, ...) sets the properties of the parent
		    %  panel with custom Name-Value pairs.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle H of the parent panel.
		    %
		    % See also update, redraw, slide, reinit, uipanel.
		
		    % initialization
		    pe.pp = draw@Plot(pe, ...
		        'Visible', 'off', ...
		        varargin{:}, ...
		        'SizeChangedFcn', {@redraw} ...
		        );
		    function redraw(~, ~)
		        pe.redraw()
		    end
		
		    if ~check_graphics(pe.p, 'uipanel')
		        pe.p = uipanel( ...
		            'Parent', pe.pp, ...
		            'Tag', 'scrollable panel', ...
		            'Units', 'character', ...
		            'BackgroundColor', pe.get('BKGCOLOR'), ...
		            'BorderType', 'none' ...
		            );
		    end
		
		    if isempty(pe.s) || ~isgraphics(pe.s, 'uicontrol') || ~strcmpi(get(pe.s, 'Style'), 'slider')
		        pe.s = uicontrol( ...
		            'Style', 'slider', ...
		            'Tag', 'scrollable panel slider', ...
		            'Parent', pe.pp, ....
		            'Units', 'character', ...
		            'Min', -eps, ...
		            'Max', 0, ...
		            'Value', 0, ...            
		            'Callback', {@slide} ...
		            );
		    end
		    function slide(~, ~)
		        pe.slide()
		    end
		
		    if isempty(pe.pr_list) || any(cellfun(@(x) ~check_graphics(x, 'uipanel'), pe.pr_list))
		        pe.pr_list = cellfun(@(x) x.draw( ...
		            'Parent', pe.p, ...
		            'Units', 'character' ...
		            ), ...
		            pe.memorize('PR_DICT').getItems(), 'UniformOutput', false);
		    end
		
		    pe.update()
		    set(pe.pp, 'Visible', 'on') % calls also redraw() and slide()
		    
		    % output
		    if nargout > 0
		        h_panel = pe.pp;
		    end
		end
		function update(pe)
		    %UPDATE updates the content of the prop panels and their graphical objects.
		    %
		    % UPDATE(PE) updates the content of the prop panels and their graphical objects.
		    %
		    % Important note:
		    % 1. UPDATE() does not need to be explicitly called from outside code,
		    %  as it is called internally by PlotElement when needed.
		    %
		    % See also draw, redraw, slide.
		
		    for prop = 1:1:pe.get('PR_DICT').length()
		        pe.get('PR_DICT').getItem(prop).update()
		    end
		end
		function redraw(pe)
		    %RESIZE resizes, repositions and slides the prop panels.
		    %
		    % RESIZE(PE) resizes the property panels and repositions their
		    %  graphical objects, and slides the element panel.
		    %
		    % Important note:
		    % 1. REDRAW() does not need to be explicitly called from outside code,
		    %  as it is called internally by PlotElement when needed.
		    %
		    % See also draw, update, slide.
		
		    pp = pe.pp;
		    pr_list = pe.pr_list;
		    
		    % redraw prop panels
		    dw = pe.get('DW');   
		    w_s = pe.get('WSLIDER');
		    for prop = 1:1:length(pr_list)
		        pe.get('PR_DICT').getItem(prop).redraw('Width', w(pp) - 2 * dw - w_s)
		    end
		    
		    % redraw panel and place prop panels
		    dh = pe.get('DH');
		
		    h_pp = cellfun(@(x) h(x), pr_list);
		    x0_pp = dw;
		    y0_pp = sum(h_pp + dh) - cumsum(h_pp + dh) + dh;
		
		    % p, s
		    h_p = sum(h_pp + dh) + dh;
		    if h_p > h(pp)
		        for prop = 1:1:length(pr_list)
		            pr = pr_list{prop};
		            set(pr, 'Position', [x0_pp y0_pp(prop) w(pr) h(pr)])
		        end
		    else
		        for prop = 1:1:length(pr_list)
		            pr = pr_list{prop};
		            set(pr, 'Position', [x0_pp y0_pp(prop)+h(pp)-h_p w(pr) h(pr)])
		        end
		    end    
		    
		    % slide and adjust panel
		    pe.slide()
		    
		    % auxiliary functions
		    function r = x0(h)
		        r = Plot.x0(h, 'characters');
		    end
		    function r = y0(h)
		        r = Plot.y0(h, 'characters');
		    end
		    function r = w(h)
		        r = Plot.w(h, 'characters');
		    end
		    function r = h(h)
		        r = Plot.h(h, 'characters');
		    end
		end
		function slide(pe)
		    %SLIDE slides the panel vertically.
		    %
		    % SLIDE(PE) slides the panel vertically, without redrawing the prop panels.
		    %
		    % Important note:
		    % 1. SLIDE() does not need to be explicitly called from outside code,
		    %  as it is called internally by PlotElement when needed.
		    %
		    % See also draw, update, redraw.
		
		    pp = pe.pp;
		    p = pe.p;
			s = pe.s;
		    pr_list = pe.pr_list;
		
		    w_s = pe.get('WSLIDER');
		
		    dh = pe.get('DH');
		    h_pp = cellfun(@(x) h(x), pr_list);
		    h_p = sum(h_pp + dh) + dh;
		
		    if h_p > h(pp)
		        offset = get(s, 'Value');
		        set(p, 'Position', [0 h(pp)-h_p-offset w(pp) h_p])
		
		        set(s, ...
		            'Position', [w(pp)-w_s 0 w_s h(pp)], ...
		            'Visible', 'on', ...
		            'Min', h(pp) - h(p), ...
		            'Value', max(get(s, 'Value'), h(pp) - h(p)) ...
		            );
		    else
		        set(p, 'Position', [0 0 w(pp) h(pp)])
		
		        set(s, 'Visible', 'off')            
		    end
		    
		    % auxiliary functions
		    function r = x0(h)
		        r = Plot.x0(h, 'characters');
		    end
		    function r = y0(h)
		        r = Plot.y0(h, 'characters');
		    end
		    function r = w(h)
		        r = Plot.w(h, 'characters');
		    end
		    function r = h(h)
		        r = Plot.h(h, 'characters');
		    end
		end
		function reinit(pe, el)
		    %REINIT resets the element, updates and redraws the element plot.
		    %
		    % REINIT(PE, EL) reinitializes the plot element.Specifically:
		    %  1. sets EL as the new element of the PlotElement
		    %  2. reinizalizes PR_DICT
		    %  3. deletes all prop panels
		    %  4. draws anew, updates and redraws
		    % 
		    % Important note:
		    % 1. EL must be of the same class as the previous element in the
		    %  PlotElement, otherwise an error is thrown.
		    %  Error id: [BRAPH2:PlotElement:WrongInput].
		    %
		    % See also update, draw, redraw.
		
		    assert( ...
		        strcmp(pe.get('EL').getClass(), el.getClass()), ...
		        [BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT], ...
		        [BRAPH2.STR ':PlotElement:' BRAPH2.WRONG_INPUT ' ' ...
		        'The class of the new element (' el.getClass() ') must be exactly the same as that of the old element (' pe.get('EL').getClass() ').'] ...
		        )    
		
		    pe.set('EL', el)
		    pe.set('PR_DICT', NoValue.getNoValue())
		
		    delete(get(pe.p, 'Children'))
		
		    pe.draw()
		    pe.update()
		    pe.redraw()
		end
		function cb_bring_to_front(pe)
		    %CB_BRING_TO_FRONT brings to front the figure with the element panel and its dependent figures.
		    %
		    % CB_BRING_TO_FRONT(PE) brings to front the figure with the element and
		    %  its dependent figures by calling the methods cb_bring_to_front() for
		    %  all the PlotProp panels of the PlotElement.
		    %  
		    % Note that it will draw a new the figure if the element panel is currently not plotted. 
		    %
		    % See also cb_hide, cb_close.
		
		    pe.cb_bring_to_front@Plot();
		    
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_bring_to_front()
		    end
		end
		function cb_hide(pe)
		    %CB_HIDE hides the figure with the element panel and its dependent figures.
		    %
		    % CB_HIDE(PE) hides the figure with the element panel and its dependent figures 
		    %  by calling the methods cb_hide() for all the PlotProp panels of the PlotElement.
		    %  
		    % See also cb_bring_to_front, cb_close.
		
		    pe.cb_hide@Plot();
		    
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_hide()
		    end
		end
		function cb_close(pe)
		    %CB_CLOSE closes the figure with the element panel and its dependent figures.
		    %
		    % CB_CLOSE(PE) closes the figure with the element panel and its dependent figures 
		    %  by calling the methods cb_close() for all the PlotProp panels of the PlotElement.
		    %  
		    % See also cb_bring_to_front, cb_hide.
		
		    pe.cb_close@Plot();
		    
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_close()
		    end
		end
	end
end
