classdef Plot < Element
	% Plot is a plot.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Plot is the basic element to manage graphical representations of elements.
	%  It is an empty graphical panel. It is filled with the graphical content representing 
	%  an element (typically, PlotElement) or property (typically, PlopProp and derived classes).
	%  It is then placed within another container; for example, a figure (e.g., PlotElement into GUI) 
	%  or another panel (e.g., PlotProp into PlotElement).
	% 
	% CONSTRUCTOR - To construct a Plot use the constructor:
	% 
	%     pl = Plot();
	%     pl = Plot(''ID'', ''id string'');
	% 
	% DRAW - To draw the panel call pl.draw():
	%     
	%     h = pl.<strong>draw</strong>();
	%     h = pl.<strong>draw</strong>(''Parent'', f);
	% 
	%  where h is the handle of the generated panel and f is the handle of 
	%  the parent container (a figure or another panel).
	% It is also possible to have additional Name-Value pairs accepted by uipanel:
	% 
	%     h = pl.<strong>draw</strong>(''Name'', <value>, ... );
	%  
	% The first time that it is called it generates a new panel. The subsequent times, 
	%  it updates the Name-Value pairs of the uipanel and/or returns the uipanel handle,
	%  but it does not redraw it (unless it has been deleted).
	% By default, the ''DeleteFcn'' calls the method pl.<strong>cb_close_fs</strong>(), 
	%  which closes the settings figure, when the panel is deleted.
	%  This can be easily overwritten calling 
	%  
	%     pl.<strong>draw</strong>(''DeleteFcn'', <new callback>)
	% 
	% SETTINGS FIGURE - To open the settings figure:
	% 
	%     fs = pl.<strong>settings</strong>();
	%  
	%  where fs is the handle of the generated settings figure.
	% It is also possible to have additional Name-Value pairs accepted by uipanel:
	% 
	%     fs = pl.<strong>settings</strong>(''Name'', <value>, ... );
	%  
	% The first time that it is called it generates a new settings figure. The subsequent times, 
	%  it updates the Name-Value pairs of the settings figure and/or returns the settings figure handle,
	%  but it does not regenerates it (unless it has been deleted).
	% 
	% CALLBACKS - These are callback functions:
	% 
	%     pl.<strong>cb_close_fs</strong>() - closes the settings figure
	%     pl.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the panel and the settings figure
	%     pl.<strong>cb_hide</strong>() - hides the figure containing the panel and the settings figure
	%     pl.<strong>cb_close</strong>() - closes the figure containing the panel and the settings figure
	%
	% The list of Plot properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%
	% Plot methods (constructor):
	% Plot - constructor
	%
	% Plot methods (Static):
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot/error.
	%  existsProp - checks whether property exists in plot/error.
	%  getPropNumber - returns the property number of plot.
	%  getProps - returns the property list of plot.
	%  getDescription - returns the description of the plot.
	%  getName - returns the name of the plot.
	%  getClass - returns the class of the plot.
	%
	% Plot methods:
	%  set_settings - ings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - e_fs is a function.
	%  settings - opens the settings figure.
	%  draw - draws the graphical panel.
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
	% Plot methods (operators):
	%  isequal - determines whether two Plot are equal (values, locked)
	%
	% Plot methods (display):
	%  tostring - string with information about the Plot
	%  disp - displays information about the Plot
	%  tree - displays the element of Plot
	%
	% Plot method (element list):
	%  getElementList - returns a list with all subelements of Plot
	%
	% Plot method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Plot
	%
	% Plot method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Plot
	%
	% Plot methods (copy):
	%  copy - copies the Plot
	%  deepclone - deep-clones the Plot
	%  clone - clones the Plot
	%
	% Plot methods (inspection, Static):
	%  getClass - returns Plot
	%  getName - returns the name of Plot
	%  getDescription - returns the description of Plot
	%  getProps - returns the property list of Plot
	%  getPropNumber - returns the property number of Plot
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
	% Plot methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Plot methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Plot methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Plot methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Plot properties (Constant).
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
	% See also uipanel, GUI, PlotElement, PlotProp.
	
	properties (Access = private) % element properties
		h_panel % panel graphical handle
		f_settings % settings figure handle
	end
	methods (Static) % static methods
		function r = x0(h, units, position)
		    %X0 returns the position of the left edge of a graphical element.
		    %
		    % R = X0(H) is the distance from the inner left edge of the parent
		    %  container to the outer left edge of the graphical element H 
		    %  in the units of H.
		    %
		    % R = X0(H, UNITS) is in UNITS. All valid units for H can be used
		    %  (e.g., 'normalized', 'pixels', 'characters').
		    %
		    % R = X0(H, [], POSITION) returns POSITION = 'Position' (default),
		    %  'InnerPosition' or 'OuterPosition' in the units of H.
		    %
		    % R = X0(H, UNITS, POSITION) returns the selected POSITION in UNITS.
		    %
		    % R = X0(0, UNITS) applies to the screen (0 is the root graphical
		    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
		    % 
		    % See also y0, w, h.
		
		    if nargin < 3
		        position = 'Position';
		    end
		    if nargin < 2
		        units = [];
		    end
		    
		    if h == 0 % screen (root graphical element)
		        position = 'ScreenSize';
		    end
		
		    if isempty(units)
		        r = get(h, position);
		    else
		        backup_units = get(h, 'Units');
		        set(h, 'Units', units)
		        r = get(h, position);
		        set(h, 'Units', backup_units);
		    end
		    r = r(1);
		end
		function r = y0(h, units, position)
		    %Y0 returns the position of the bottom edge of a graphical element.
		    %
		    % R = Y0(H) is the distance from the inner bottom edge of the parent 
		    %  container to the outer bottom edge of the graphical element H.
		    %  in the units of H.
		    %
		    % R = Y0(H, UNITS) is in UNITS. All valid units for H can be used
		    %  (e.g., 'normalized', 'pixels', 'characters').
		    %
		    % R = Y0(H, [], POSITION) returns POSITION = 'Position' (default),
		    %  'InnerPosition' or 'OuterPosition' in the units of H.
		    %
		    % R = Y0(H, UNITS, POSITION) returns the selected POSITION in UNITS.
		    %
		    % R = Y0(0, UNITS) applies to the screen (0 is the root graphical
		    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
		    %
		    % See also x0, w, h.
		
		    if nargin < 3
		        position = 'Position';
		    end
		    if nargin < 2
		        units = [];
		    end
		    
		    if h == 0 % screen (root graphical element)
		        position = 'ScreenSize';
		    end
		
		    if isempty(units)
		        r = get(h, position);
		    else
		        backup_units = get(h, 'Units');
		        set(h, 'Units', units)
		        r = get(h, position);
		        set(h, 'Units', backup_units);
		    end
		    r = r(2);
		end
		function r = w(h, units, position)
		    %W returns the width of a graphical element.
		    %
		    % R = W(H) is the distance between the right and left outer edges of the
		    %   graphical element H.
		    %  in the units of H.
		    %
		    % R = W(H, UNITS) is in UNITS. All valid units for H can be used
		    %  (e.g., 'normalized', 'pixels', 'characters').
		    %
		    % R = W(H, [], POSITION) returns POSITION = 'Position' (default),
		    %  'InnerPosition' or 'OuterPosition' in the units of H.
		    %
		    % R = W(H, UNITS, POSITION) returns the selected POSITION in UNITS.
		    %
		    % R = W(0, UNITS) applies to the screen (0 is the root graphical
		    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
		    %
		    % See also x0, y0, h.
		
		    if nargin < 3
		        position = 'Position';
		    end
		    if nargin < 2
		        units = [];
		    end
		    
		    if h == 0 % screen (root graphical element)
		        position = 'ScreenSize';
		    end
		
		    if isempty(units)
		        r = get(h, position);
		    else
		        backup_units = get(h, 'Units');
		        set(h, 'Units', units)
		        r = get(h, position);
		        set(h, 'Units', backup_units);
		    end
		    r = r(3);
		end
		function r = h(h, units, position)
		    %H returns the height of a graphical element.
		    %
		    % R = H(H) is the distance between the top and bottom outer edges of the
		    %  graphical element H.
		    %  in the units of H.
		    %
		    % R = H(H, UNITS) is in UNITS. All valid units for H can be used
		    %  (e.g., 'normalized', 'pixels', 'characters').
		    %
		    % R = H(H, [], POSITION) returns POSITION = 'Position' (default),
		    %  'InnerPosition' or 'OuterPosition' in the units of H.
		    %
		    % R = H(H, UNITS, POSITION) returns the selected POSITION in UNITS.
		    %
		    % R = H(0, UNITS) applies to the screen (0 is the root graphical
		    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
		    %
		    % See also x0, y0, w.
		
		    if nargin < 3
		        position = 'Position';
		    end
		    if nargin < 2
		        units = [];
		    end
		    
		    if h == 0 % screen (root graphical element)
		        position = 'ScreenSize';
		    end
		
		    if isempty(units)
		        r = get(h, position);
		    else
		        backup_units = get(h, 'Units');
		        set(h, 'Units', units)
		        r = get(h, position);
		        set(h, 'Units', backup_units);
		    end
		    r = r(4);
		end
	end
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		BKGCOLOR = 2;
		BKGCOLOR_TAG = 'bkgcolor';
		BKGCOLOR_CATEGORY = Category.METADATA;
		BKGCOLOR_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function pl_class = getClass()
			%GETCLASS returns the class of the plot.
			%
			% CLASS = Plot.GETCLASS() returns the class 'Plot'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PL.GETCLASS() returns the class of the plot PL.
			%  CLASS = Element.GETCLASS(PL) returns the class of 'PL'.
			%  CLASS = Element.GETCLASS('Plot') returns 'Plot'.
			%
			% See also getName, getDescription.
			
			pl_class = 'Plot';
		end
		function pl_name = getName()
			%GETNAME returns the name of the plot.
			%
			% NAME = Plot.GETNAME() returns the name of the 'plot'.
			%  Plot.
			%
			% Alternative forms to call this method are:
			%  NAME = PL.GETNAME() returns the name of the plot PL.
			%  NAME = Element.GETNAME(PL) returns the name of 'PL'.
			%  NAME = Element.GETNAME('Plot') returns the name of 'Plot'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pl_name = 'Plot';
		end
		function pl_description = getDescription()
			%GETDESCRIPTION returns the description of the plot.
			%
			% STR = Plot.GETDESCRIPTION() returns the description of the 'plot'.
			%  which is:
			%
			%  Plot is the basic element to manage graphical representations of elements.
			%   It is an empty graphical panel. It is filled with the graphical content representing 
			%   an element (typically, PlotElement) or property (typically, PlopProp and derived classes).
			%   It is then placed within another container; for example, a figure (e.g., PlotElement into GUI) 
			%   or another panel (e.g., PlotProp into PlotElement).
			%  
			%  CONSTRUCTOR - To construct a Plot use the constructor:
			%  
			%      pl = Plot();
			%      pl = Plot(''ID'', ''id string'');
			%  
			%  DRAW - To draw the panel call pl.draw():
			%      
			%      h = pl.<strong>draw</strong>();
			%      h = pl.<strong>draw</strong>(''Parent'', f);
			%  
			%   where h is the handle of the generated panel and f is the handle of 
			%   the parent container (a figure or another panel).
			%  It is also possible to have additional Name-Value pairs accepted by uipanel:
			%  
			%      h = pl.<strong>draw</strong>(''Name'', <value>, ... );
			%   
			%  The first time that it is called it generates a new panel. The subsequent times, 
			%   it updates the Name-Value pairs of the uipanel and/or returns the uipanel handle,
			%   but it does not redraw it (unless it has been deleted).
			%  By default, the ''DeleteFcn'' calls the method pl.<strong>cb_close_fs</strong>(), 
			%   which closes the settings figure, when the panel is deleted.
			%   This can be easily overwritten calling 
			%   
			%      pl.<strong>draw</strong>(''DeleteFcn'', <new callback>)
			%  
			%  SETTINGS FIGURE - To open the settings figure:
			%  
			%      fs = pl.<strong>settings</strong>();
			%   
			%   where fs is the handle of the generated settings figure.
			%  It is also possible to have additional Name-Value pairs accepted by uipanel:
			%  
			%      fs = pl.<strong>settings</strong>(''Name'', <value>, ... );
			%   
			%  The first time that it is called it generates a new settings figure. The subsequent times, 
			%   it updates the Name-Value pairs of the settings figure and/or returns the settings figure handle,
			%   but it does not regenerates it (unless it has been deleted).
			%  
			%  CALLBACKS - These are callback functions:
			%  
			%      pl.<strong>cb_close_fs</strong>() - closes the settings figure
			%      pl.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the panel and the settings figure
			%      pl.<strong>cb_hide</strong>() - hides the figure containing the panel and the settings figure
			%      pl.<strong>cb_close</strong>() - closes the figure containing the panel and the settings figure
			%
			% Alternative forms to call this method are:
			%  STR = PL.GETDESCRIPTION() returns the description of the plot PL.
			%  STR = Element.GETDESCRIPTION(PL) returns the description of 'PL'.
			%  STR = Element.GETDESCRIPTION('Plot') returns the description of 'Plot'.
			%
			% See also getClass, getName.
			
			pl_description = [
				'Plot is the basic element to manage graphical representations of elements.' ...
				' It is an empty graphical panel. It is filled with the graphical content representing ' ...
				' an element (typically, PlotElement) or property (typically, PlopProp and derived classes).' ...
				' It is then placed within another container; for example, a figure (e.g., PlotElement into GUI) ' ...
				' or another panel (e.g., PlotProp into PlotElement).' ...
				'' ...
				'CONSTRUCTOR - To construct a Plot use the constructor:' ...
				'' ...
				'    pl = Plot();' ...
				'    pl = Plot(''ID'', ''id string'');' ...
				'' ...
				'DRAW - To draw the panel call pl.draw():' ...
				'    ' ...
				'    h = pl.<strong>draw</strong>();' ...
				'    h = pl.<strong>draw</strong>(''Parent'', f);' ...
				'' ...
				' where h is the handle of the generated panel and f is the handle of ' ...
				' the parent container (a figure or another panel).' ...
				'It is also possible to have additional Name-Value pairs accepted by uipanel:' ...
				'' ...
				'    h = pl.<strong>draw</strong>(''Name'', <value>, ... );' ...
				' ' ...
				'The first time that it is called it generates a new panel. The subsequent times, ' ...
				' it updates the Name-Value pairs of the uipanel and/or returns the uipanel handle,' ...
				' but it does not redraw it (unless it has been deleted).' ...
				'By default, the ''DeleteFcn'' calls the method pl.<strong>cb_close_fs</strong>(), ' ...
				' which closes the settings figure, when the panel is deleted.' ...
				' This can be easily overwritten calling ' ...
				' ' ...
				'    pl.<strong>draw</strong>(''DeleteFcn'', <new callback>)' ...
				'' ...
				'SETTINGS FIGURE - To open the settings figure:' ...
				'' ...
				'    fs = pl.<strong>settings</strong>();' ...
				' ' ...
				' where fs is the handle of the generated settings figure.' ...
				'It is also possible to have additional Name-Value pairs accepted by uipanel:' ...
				'' ...
				'    fs = pl.<strong>settings</strong>(''Name'', <value>, ... );' ...
				' ' ...
				'The first time that it is called it generates a new settings figure. The subsequent times, ' ...
				' it updates the Name-Value pairs of the settings figure and/or returns the settings figure handle,' ...
				' but it does not regenerates it (unless it has been deleted).' ...
				'' ...
				'CALLBACKS - These are callback functions:' ...
				'' ...
				'    pl.<strong>cb_close_fs</strong>() - closes the settings figure' ...
				'    pl.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the panel and the settings figure' ...
				'    pl.<strong>cb_hide</strong>() - hides the figure containing the panel and the settings figure' ...
				'    pl.<strong>cb_close</strong>() - closes the figure containing the panel and the settings figure' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot.
			%
			% PROPS = Plot.GETPROPS() returns the property list of plot.
			%
			% PROPS = Plot.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PL.GETPROPS([CATEGORY]) returns the property list of the plot PL.
			%  PROPS = Element.GETPROPS(PL[, CATEGORY]) returns the property list of 'PL'.
			%  PROPS = Element.GETPROPS('Plot'[, CATEGORY]) returns the property list of 'Plot'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.BKGCOLOR
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Plot.ID
						];
				case Category.RESULT
					prop_list = [
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						Plot.ID
						Plot.BKGCOLOR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot.
			%
			% N = Plot.GETPROPNUMBER() returns the property number of plot.
			%
			% Alternative forms to call this method are:
			%  N = PL.GETPROPNUMBER() returns the property number of the plot PL.
			%  N = Element.GETPROPNUMBER(PL) returns the property number of 'PL'.
			%  N = Element.GETPROPNUMBER('Plot') returns the property number of 'Plot'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 2;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot/error.
			%
			% CHECK = Plot.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSPROP(PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PL, PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(Plot, PROP) checks whether PROP exists for Plot.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Plot:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSPROP(PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  Element.EXISTSPROP(PL, PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  Element.EXISTSPROP(Plot, PROP) throws error if PROP does NOT exist for Plot.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2 ]);
			else
				assert( ...
					Plot.existsProp(prop), ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Plot.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot/error.
			%
			% CHECK = Plot.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSTAG(TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PL, TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(Plot, TAG) checks whether TAG exists for Plot.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Plot:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSTAG(TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  Element.EXISTSTAG(PL, TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  Element.EXISTSTAG(Plot, TAG) throws error if TAG does NOT exist for Plot.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plot_tag_list = { 'id'  'bkgcolor' };
				
				check = any(strcmpi(tag, plot_tag_list));
			else
				assert( ...
					Plot.existsTag(tag), ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Plot'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Plot, POINTER) returns property number of POINTER of Plot.
			%  PROPERTY = PL.GETPROPPROP(Plot, POINTER) returns property number of POINTER of Plot.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plot_tag_list = { 'id'  'bkgcolor' };
				
				tag = pointer;
				Plot.existsTag(tag);
				
				prop = find(strcmpi(tag, plot_tag_list));
			else % numeric
				prop = pointer;
				Plot.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(Plot, POINTER) returns tag of POINTER of Plot.
			%  TAG = PL.GETPROPTAG(Plot, POINTER) returns tag of POINTER of Plot.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Plot.existsTag(tag);
			else % numeric
				prop = pointer;
				Plot.existsProp(prop);
				
				switch prop
					case Plot.ID
						tag = Plot.ID_TAG;
					case Plot.BKGCOLOR
						tag = Plot.BKGCOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Plot, POINTER) returns category of POINTER of Plot.
			%  CATEGORY = PL.GETPROPCATEGORY(Plot, POINTER) returns category of POINTER of Plot.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					prop_category = Plot.ID_CATEGORY;
				case Plot.BKGCOLOR
					prop_category = Plot.BKGCOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Plot, POINTER) returns format of POINTER of Plot.
			%  FORMAT = PL.GETPROPFORMAT(Plot, POINTER) returns format of POINTER of Plot.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					prop_format = Plot.ID_FORMAT;
				case Plot.BKGCOLOR
					prop_format = Plot.BKGCOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Plot, POINTER) returns description of POINTER of Plot.
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(Plot, POINTER) returns description of POINTER of Plot.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					prop_description = 'ID (data, string) is a few-letter code for the plot.';
				case Plot.BKGCOLOR
					prop_description = 'BKGCOLOR (metadata, rvector) is background color.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Plot, POINTER) returns settings of POINTER of Plot.
			%  SETTINGS = PL.GETPROPSETTINGS(Plot, POINTER) returns settings of POINTER of Plot.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Plot.BKGCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Plot.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Plot.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULT(Plot, POINTER) returns the default value of POINTER of Plot.
			%  DEFAULT = PL.GETPROPDEFAULT(Plot, POINTER) returns the default value of POINTER of Plot.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					prop_default = Format.getFormatDefault(Format.STRING, Plot.getPropSettings(prop));
				case Plot.BKGCOLOR
					prop_default = BRAPH2.COL_FIG;
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Plot.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Plot.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Plot, POINTER) returns the conditioned default value of POINTER of Plot.
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(Plot, POINTER) returns the conditioned default value of POINTER of Plot.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Plot.getPropProp(pointer);
			
			prop_default = Plot.conditioning(prop, Plot.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Plot, PROP, VALUE) checks VALUE format for PROP of Plot.
			%  CHECK = PL.CHECKPROP(Plot, PROP, VALUE) checks VALUE format for PROP of Plot.
			% 
			% PL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:Plot:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PL.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  Element.CHECKPROP(Plot, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Plot.
			%   Error id: [BRAPH2:Plot:WrongInput]
			%  PL.CHECKPROP(Plot, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Plot.
			%   Error id: [BRAPH2:Plot:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Plot.getPropProp(pointer);
			
			switch prop
				case Plot.ID
					check = Format.checkFormat(Format.STRING, value, Plot.getPropSettings(prop));
				case Plot.BKGCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, Plot.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Plot:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Plot.getPropTag(prop) ' (' Plot.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pl = Plot(varargin)
			% Plot() creates a plot.
			%
			% Plot(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Plot(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Plot properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%
			% See also Category, Format, set, check.
			
			pl = pl@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Plot.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pl, varargin)
		    %DRAW draws the graphical panel.
		    %
		    % DRAW(PL) draws the graphical panel.
		    %
		    % H = DRAW(PL) returns a handle to the graphical panel.
		    %
		    % DRAW(PL, 'Name', VALUE, ...) sets the properties of the graphical
		    %  panel with custom Name-Value pairs.
		    %  All standard Name-Value pairs of uipanel can be used.
		    %
		    % See also settings, uipanel.
		
		    if ~check_graphics(pl.h_panel, 'uipanel')
		        pl.h_panel = uipanel( ...
		            'Tag', 'h_panel', ...
		            'UserData', pl, ...
		            'DeleteFcn', {@cb_close_fs}, ...
		            'BorderType', 'none', ...
		            'BackgroundColor', pl.get('BKGCOLOR'), ...
		            varargin{:} ...
		            );
		    else
		        if ~isempty(varargin)
		            set(pl.h_panel, varargin{:})
		        end
		    end
		    h = pl.h_panel;
		
		    function cb_close_fs(~, ~) % (src, event)
		        pl.cb_close_fs()
		    end
		    
		    if nargout > 0
		        h_panel = h;
		    end
		end
		function f_settings = settings(pl, varargin)
		    %SETTINGS opens the settings figure.
		    %
		    % SETTINGS(PL) allows the user to edit the properties of the plot
		    %  by opening a settings figure.
		    %
		    % FS = SETTINGS(PL) returns a handle to the settings figure.
		    %
		    % SETTINGS(PL, 'Name', VALUE, ...) sets the properties of the
		    %  settings figure with custom Name-Value pairs. 
		    %  All standard plot Name-Value pairs of figure can be used.
		    %
		    % See also draw, figure.
		
		    % create a figure
		    if ~check_graphics(pl.f_settings, 'figure')
		        pl.f_settings = figure();
		        set(pl.f_settings, ...
		            'units', 'normalized', ...
		            'Position', [.70 .50 .40 .20], ... 
		            'Name', strtrim([pl.get('ID') ' Settings']), ...
		            'Color', pl.get('BKGCOLOR'), ...
		            'MenuBar', 'none', ...
		            'Toolbar', 'none', ...
		            'NumberTitle', 'off', ...
		            'DockControls', 'off', ...
		            varargin{:} ...
		            )
		    else
		        if ~isempty(varargin)
		            set(pl.f_settings, varargin{:})
		        end
		    end
		    
		    if nargout > 0
		        f_settings = pl.f_settings;
		    end
		end
		function cb_close_fs(pl)
		    %CB_CLOSE_FS closes the settings figure if it exists.
		    %
		    % CB_CLOSE_FS(PL) closes the settings figure if it exists by calling the
		    %  function close().
		    %
		    % See also settings, cb_close, cb_bring_to_front, cb_hide.
		
		    if check_graphics(pl.f_settings, 'figure')
		        close(pl.f_settings)
		    end
		end
		function cb_bring_to_front(pl)
		    %CB_BRING_TO_FRONT brings to the front the figure with the panel and the settings figure.
		    %
		    % CB_BRING_TO_FRONT(PL) brings to the front the figure with the
		    %  panel and the settings figure.
		    %
		    % See also cb_hide, cb_close, cb_close_fs.
		
		    if check_graphics(pl.h_panel, 'uipanel')
		        fig = ancestor(pl.h_panel, 'figure');
		        figure(fig)
		        set(fig, ...
		            'Visible', 'on', ...
		            'WindowState', 'normal' ...
		            )        
		    end
		
		    if check_graphics(pl.f_settings, 'figure')
		        figure(pl.f_settings)
		        set(pl.f_settings, ...
		            'Visible', 'on', ...
		            'WindowState', 'normal' ...
		            )            
		    end    
		end
		function cb_hide(pl)
		    %CB_HIDE hides the figure containing the panel and the settings figure.
		    %
		    % CB_HIDE(PL) hides the figure containing the panel and the settings figure.
		    %
		    % See also cb_bring_to_front, cb_close, cb_close_fs.
		    
		    if check_graphics(pl.h_panel, 'uipanel')
		        fig = ancestor(pl.h_panel, 'figure');
		        set(fig, 'Visible', 'off')
		    end
		
		    if check_graphics(pl.f_settings, 'figure')
		        set(pl.f_settings, 'Visible', 'off') 
		    end    
		end
		function cb_close(pl)
		    %CB_CLOSE closes the figure containing the panel and the settings figure.
		    % 
		    % CB_CLOSE(PL) closes the figure containing the panel and the settings figure.
		    %
		    % See also cb_close_fs, cb_bring_to_front, cb_hide.
		
		    if check_graphics(pl.h_panel, 'uipanel')
		        close(ancestor(pl.h_panel, 'figure'))
		    end
		
		    % pl.cb_close_fs() % this is called automatically when the panel is deleted
		end
		
		function set_settings(pl, outer_settings)
		    pl.f_settings = outer_settings;
		end
	end
end
