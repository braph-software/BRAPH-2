classdef PlotEnsembleLine < Plot
	% PlotEnsembleLine is a line plot of the measure values.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% Plot is the line plot of the measure values.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	%
	% The list of PlotEnsembleLine properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
	%  <strong>4</strong> <strong>a</strong> 	A(data, item) to set ensemble line information.
	%  <strong>5</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range.
	%  <strong>6</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label.
	%  <strong>7</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label.
	%  <strong>8</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas.
	%  <strong>9</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure.
	%  <strong>10</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil.
	%  <strong>11</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu.
	%  <strong>12</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1.
	%  <strong>13</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2.
	%  <strong>14</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color.
	%  <strong>15</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style.
	%  <strong>16</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width.
	%  <strong>17</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style.
	%  <strong>18</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size.
	%  <strong>19</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
	%  <strong>20</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
	%
	% PlotEnsembleLine methods (constructor):
	% PlotEnsembleLine - constructor
	%
	% PlotEnsembleLine methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot graph/error.
	%  existsProp - checks whether property exists in plot graph/error.
	%  getPropNumber - returns the property number of plot graph.
	%  getProps - returns the property list of plot graph.
	%  getDescription - returns the description of the plot graph.
	%  getName - returns the name of the plot graph.
	%  getClass - returns the class of the plot graph.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotEnsembleLine methods:
	%  plotline - bleLine/plotline is a function.
	%  update_plot - Line/update_plot is a function.
	%  settings - opens the property editor GUI.
	%  draw - draws the plot line.
	%  set_settings - ine/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - Line/cb_close_fs is a function.
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
	% PlotEnsembleLine methods (operators):
	%  isequal - determines whether two PlotEnsembleLine are equal (values, locked)
	%
	% PlotEnsembleLine methods (display):
	%  tostring - string with information about the PlotEnsembleLine
	%  disp - displays information about the PlotEnsembleLine
	%  tree - displays the element of PlotEnsembleLine
	%
	% PlotEnsembleLine method (element list):
	%  getElementList - returns a list with all subelements of PlotEnsembleLine
	%
	% PlotEnsembleLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotEnsembleLine
	%
	% PlotEnsembleLine method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotEnsembleLine
	%
	% PlotEnsembleLine methods (copy):
	%  copy - copies the PlotEnsembleLine
	%  deepclone - deep-clones the PlotEnsembleLine
	%  clone - clones the PlotEnsembleLine
	%
	% PlotEnsembleLine methods (inspection, Static):
	%  getClass - returns PlotEnsembleLine
	%  getName - returns the name of PlotEnsembleLine
	%  getDescription - returns the description of PlotEnsembleLine
	%  getProps - returns the property list of PlotEnsembleLine
	%  getPropNumber - returns the property number of PlotEnsembleLine
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
	% PlotEnsembleLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotEnsembleLine methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotEnsembleLine methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotEnsembleLine methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotEnsembleLine properties (Constant).
	%  PLOTTITLE - 3
	%  PLOTTITLE_TAG - 'plottitle'
	%  PLOTTITLE_CATEGORY - 'm'
	%  PLOTTITLE_FORMAT - 'st'
	%  A - 4
	%  A_TAG - 'a'
	%  A_CATEGORY - 'd'
	%  A_FORMAT - 'it'
	%  X - 5
	%  X_TAG - 'x'
	%  X_CATEGORY - 'd'
	%  X_FORMAT - 'nr'
	%  XLABEL - 6
	%  XLABEL_TAG - 'xlabel'
	%  XLABEL_CATEGORY - 'm'
	%  XLABEL_FORMAT - 'st'
	%  YLABEL - 7
	%  YLABEL_TAG - 'ylabel'
	%  YLABEL_CATEGORY - 'm'
	%  YLABEL_FORMAT - 'st'
	%  PLOTVALUE - 8
	%  PLOTVALUE_TAG - 'plotvalue'
	%  PLOTVALUE_CATEGORY - 'd'
	%  PLOTVALUE_FORMAT - 'll'
	%  MEASURE - 9
	%  MEASURE_TAG - 'measure'
	%  MEASURE_CATEGORY - 'd'
	%  MEASURE_FORMAT - 'st'
	%  CIL - 10
	%  CIL_TAG - 'cil'
	%  CIL_CATEGORY - 'm'
	%  CIL_FORMAT - 'll'
	%  CIU - 11
	%  CIU_TAG - 'ciu'
	%  CIU_CATEGORY - 'm'
	%  CIU_FORMAT - 'll'
	%  NODE1 - 12
	%  NODE1_TAG - 'node1'
	%  NODE1_CATEGORY - 'm'
	%  NODE1_FORMAT - 'nn'
	%  NODE2 - 13
	%  NODE2_TAG - 'node2'
	%  NODE2_CATEGORY - 'm'
	%  NODE2_FORMAT - 'nn'
	%  COLOR - 14
	%  COLOR_TAG - 'color'
	%  COLOR_CATEGORY - 'm'
	%  COLOR_FORMAT - 'nr'
	%  LINESTYLE - 15
	%  LINESTYLE_TAG - 'linestyle'
	%  LINESTYLE_CATEGORY - 'm'
	%  LINESTYLE_FORMAT - 'st'
	%  LINEWIDTH - 16
	%  LINEWIDTH_TAG - 'linewidth'
	%  LINEWIDTH_CATEGORY - 'm'
	%  LINEWIDTH_FORMAT - 'nn'
	%  MARKER - 17
	%  MARKER_TAG - 'marker'
	%  MARKER_CATEGORY - 'm'
	%  MARKER_FORMAT - 'st'
	%  MARKERSIZE - 18
	%  MARKERSIZE_TAG - 'markersize'
	%  MARKERSIZE_CATEGORY - 'm'
	%  MARKERSIZE_FORMAT - 'nn'
	%  MARKEREDGECOLOR - 19
	%  MARKEREDGECOLOR_TAG - 'markeredgecolor'
	%  MARKEREDGECOLOR_CATEGORY - 'm'
	%  MARKEREDGECOLOR_FORMAT - 'nr'
	%  MARKERFACECOLOR - 20
	%  MARKERFACECOLOR_TAG - 'markerfacecolor'
	%  MARKERFACECOLOR_CATEGORY - 'm'
	%  MARKERFACECOLOR_FORMAT - 'nr'
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
	% See also uipanel, ishandle, isgraphics, figure.
	
	properties (Access = private) % element properties
		h_figure % panel graphical handle
		h_axes % axes handle
		h_plot % plot handle
		pp
		h_settings
		m % measure
	end
	properties (Constant) % properties
		PLOTTITLE = Plot.getPropNumber() + 1;
		PLOTTITLE_TAG = 'plottitle';
		PLOTTITLE_CATEGORY = Category.METADATA;
		PLOTTITLE_FORMAT = Format.STRING;
		
		A = Plot.getPropNumber() + 2;
		A_TAG = 'a';
		A_CATEGORY = Category.DATA;
		A_FORMAT = Format.ITEM;
		
		X = Plot.getPropNumber() + 3;
		X_TAG = 'x';
		X_CATEGORY = Category.DATA;
		X_FORMAT = Format.RVECTOR;
		
		XLABEL = Plot.getPropNumber() + 4;
		XLABEL_TAG = 'xlabel';
		XLABEL_CATEGORY = Category.METADATA;
		XLABEL_FORMAT = Format.STRING;
		
		YLABEL = Plot.getPropNumber() + 5;
		YLABEL_TAG = 'ylabel';
		YLABEL_CATEGORY = Category.METADATA;
		YLABEL_FORMAT = Format.STRING;
		
		PLOTVALUE = Plot.getPropNumber() + 6;
		PLOTVALUE_TAG = 'plotvalue';
		PLOTVALUE_CATEGORY = Category.DATA;
		PLOTVALUE_FORMAT = Format.CELL;
		
		MEASURE = Plot.getPropNumber() + 7;
		MEASURE_TAG = 'measure';
		MEASURE_CATEGORY = Category.DATA;
		MEASURE_FORMAT = Format.STRING;
		
		CIL = Plot.getPropNumber() + 8;
		CIL_TAG = 'cil';
		CIL_CATEGORY = Category.METADATA;
		CIL_FORMAT = Format.CELL;
		
		CIU = Plot.getPropNumber() + 9;
		CIU_TAG = 'ciu';
		CIU_CATEGORY = Category.METADATA;
		CIU_FORMAT = Format.CELL;
		
		NODE1 = Plot.getPropNumber() + 10;
		NODE1_TAG = 'node1';
		NODE1_CATEGORY = Category.METADATA;
		NODE1_FORMAT = Format.SCALAR;
		
		NODE2 = Plot.getPropNumber() + 11;
		NODE2_TAG = 'node2';
		NODE2_CATEGORY = Category.METADATA;
		NODE2_FORMAT = Format.SCALAR;
		
		COLOR = Plot.getPropNumber() + 12;
		COLOR_TAG = 'color';
		COLOR_CATEGORY = Category.METADATA;
		COLOR_FORMAT = Format.RVECTOR;
		
		LINESTYLE = Plot.getPropNumber() + 13;
		LINESTYLE_TAG = 'linestyle';
		LINESTYLE_CATEGORY = Category.METADATA;
		LINESTYLE_FORMAT = Format.STRING;
		
		LINEWIDTH = Plot.getPropNumber() + 14;
		LINEWIDTH_TAG = 'linewidth';
		LINEWIDTH_CATEGORY = Category.METADATA;
		LINEWIDTH_FORMAT = Format.SCALAR;
		
		MARKER = Plot.getPropNumber() + 15;
		MARKER_TAG = 'marker';
		MARKER_CATEGORY = Category.METADATA;
		MARKER_FORMAT = Format.STRING;
		
		MARKERSIZE = Plot.getPropNumber() + 16;
		MARKERSIZE_TAG = 'markersize';
		MARKERSIZE_CATEGORY = Category.METADATA;
		MARKERSIZE_FORMAT = Format.SCALAR;
		
		MARKEREDGECOLOR = Plot.getPropNumber() + 17;
		MARKEREDGECOLOR_TAG = 'markeredgecolor';
		MARKEREDGECOLOR_CATEGORY = Category.METADATA;
		MARKEREDGECOLOR_FORMAT = Format.RVECTOR;
		
		MARKERFACECOLOR = Plot.getPropNumber() + 18;
		MARKERFACECOLOR_TAG = 'markerfacecolor';
		MARKERFACECOLOR_CATEGORY = Category.METADATA;
		MARKERFACECOLOR_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot graph.
			%
			% CLASS = PlotEnsembleLine.GETCLASS() returns the class 'PlotEnsembleLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotEnsembleLine') returns 'PlotEnsembleLine'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotEnsembleLine';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot graph.
			%
			% NAME = PlotEnsembleLine.GETNAME() returns the name of the 'plot graph'.
			%  Plot Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotEnsembleLine') returns the name of 'PlotEnsembleLine'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot graph.
			%
			% STR = PlotEnsembleLine.GETDESCRIPTION() returns the description of the 'plot graph'.
			%  which is:
			%
			%  Plot is the line plot of the measure values.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotEnsembleLine') returns the description of 'PlotEnsembleLine'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'Plot is the line plot of the measure values.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot graph.
			%
			% PROPS = PlotEnsembleLine.GETPROPS() returns the property list of plot graph.
			%
			% PROPS = PlotEnsembleLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotEnsembleLine'[, CATEGORY]) returns the property list of 'PlotEnsembleLine'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotEnsembleLine.PLOTTITLE
						PlotEnsembleLine.XLABEL
						PlotEnsembleLine.YLABEL
						PlotEnsembleLine.CIL
						PlotEnsembleLine.CIU
						PlotEnsembleLine.NODE1
						PlotEnsembleLine.NODE2
						PlotEnsembleLine.COLOR
						PlotEnsembleLine.LINESTYLE
						PlotEnsembleLine.LINEWIDTH
						PlotEnsembleLine.MARKER
						PlotEnsembleLine.MARKERSIZE
						PlotEnsembleLine.MARKEREDGECOLOR
						PlotEnsembleLine.MARKERFACECOLOR
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotEnsembleLine.A
						PlotEnsembleLine.X
						PlotEnsembleLine.PLOTVALUE
						PlotEnsembleLine.MEASURE
						];
				case Category.RESULT
					prop_list = [
						Plot.getProps(Category.RESULT)
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
						PlotEnsembleLine.PLOTTITLE
						PlotEnsembleLine.A
						PlotEnsembleLine.X
						PlotEnsembleLine.XLABEL
						PlotEnsembleLine.YLABEL
						PlotEnsembleLine.PLOTVALUE
						PlotEnsembleLine.MEASURE
						PlotEnsembleLine.CIL
						PlotEnsembleLine.CIU
						PlotEnsembleLine.NODE1
						PlotEnsembleLine.NODE2
						PlotEnsembleLine.COLOR
						PlotEnsembleLine.LINESTYLE
						PlotEnsembleLine.LINEWIDTH
						PlotEnsembleLine.MARKER
						PlotEnsembleLine.MARKERSIZE
						PlotEnsembleLine.MARKEREDGECOLOR
						PlotEnsembleLine.MARKERFACECOLOR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot graph.
			%
			% N = PlotEnsembleLine.GETPROPNUMBER() returns the property number of plot graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotEnsembleLine') returns the property number of 'PlotEnsembleLine'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 20;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot graph/error.
			%
			% CHECK = PlotEnsembleLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotEnsembleLine, PROP) checks whether PROP exists for PlotEnsembleLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  Element.EXISTSPROP(PlotEnsembleLine, PROP) throws error if PROP does NOT exist for PlotEnsembleLine.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 ]);
			else
				assert( ...
					PlotEnsembleLine.existsProp(prop), ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotEnsembleLine.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot graph/error.
			%
			% CHECK = PlotEnsembleLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotEnsembleLine, TAG) checks whether TAG exists for PlotEnsembleLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  Element.EXISTSTAG(PlotEnsembleLine, TAG) throws error if TAG does NOT exist for PlotEnsembleLine.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotensembleline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'a'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				check = any(strcmpi(tag, plotensembleline_tag_list));
			else
				assert( ...
					PlotEnsembleLine.existsTag(tag), ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotEnsembleLine'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotEnsembleLine, POINTER) returns property number of POINTER of PlotEnsembleLine.
			%  PROPERTY = PR.GETPROPPROP(PlotEnsembleLine, POINTER) returns property number of POINTER of PlotEnsembleLine.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotensembleline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'a'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				tag = pointer;
				PlotEnsembleLine.existsTag(tag);
				
				prop = find(strcmpi(tag, plotensembleline_tag_list));
			else % numeric
				prop = pointer;
				PlotEnsembleLine.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotEnsembleLine, POINTER) returns tag of POINTER of PlotEnsembleLine.
			%  TAG = PR.GETPROPTAG(PlotEnsembleLine, POINTER) returns tag of POINTER of PlotEnsembleLine.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotEnsembleLine.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotEnsembleLine.existsProp(prop);
				
				switch prop
					case PlotEnsembleLine.PLOTTITLE
						tag = PlotEnsembleLine.PLOTTITLE_TAG;
					case PlotEnsembleLine.A
						tag = PlotEnsembleLine.A_TAG;
					case PlotEnsembleLine.X
						tag = PlotEnsembleLine.X_TAG;
					case PlotEnsembleLine.XLABEL
						tag = PlotEnsembleLine.XLABEL_TAG;
					case PlotEnsembleLine.YLABEL
						tag = PlotEnsembleLine.YLABEL_TAG;
					case PlotEnsembleLine.PLOTVALUE
						tag = PlotEnsembleLine.PLOTVALUE_TAG;
					case PlotEnsembleLine.MEASURE
						tag = PlotEnsembleLine.MEASURE_TAG;
					case PlotEnsembleLine.CIL
						tag = PlotEnsembleLine.CIL_TAG;
					case PlotEnsembleLine.CIU
						tag = PlotEnsembleLine.CIU_TAG;
					case PlotEnsembleLine.NODE1
						tag = PlotEnsembleLine.NODE1_TAG;
					case PlotEnsembleLine.NODE2
						tag = PlotEnsembleLine.NODE2_TAG;
					case PlotEnsembleLine.COLOR
						tag = PlotEnsembleLine.COLOR_TAG;
					case PlotEnsembleLine.LINESTYLE
						tag = PlotEnsembleLine.LINESTYLE_TAG;
					case PlotEnsembleLine.LINEWIDTH
						tag = PlotEnsembleLine.LINEWIDTH_TAG;
					case PlotEnsembleLine.MARKER
						tag = PlotEnsembleLine.MARKER_TAG;
					case PlotEnsembleLine.MARKERSIZE
						tag = PlotEnsembleLine.MARKERSIZE_TAG;
					case PlotEnsembleLine.MARKEREDGECOLOR
						tag = PlotEnsembleLine.MARKEREDGECOLOR_TAG;
					case PlotEnsembleLine.MARKERFACECOLOR
						tag = PlotEnsembleLine.MARKERFACECOLOR_TAG;
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(PlotEnsembleLine, POINTER) returns category of POINTER of PlotEnsembleLine.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotEnsembleLine, POINTER) returns category of POINTER of PlotEnsembleLine.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					prop_category = PlotEnsembleLine.PLOTTITLE_CATEGORY;
				case PlotEnsembleLine.A
					prop_category = PlotEnsembleLine.A_CATEGORY;
				case PlotEnsembleLine.X
					prop_category = PlotEnsembleLine.X_CATEGORY;
				case PlotEnsembleLine.XLABEL
					prop_category = PlotEnsembleLine.XLABEL_CATEGORY;
				case PlotEnsembleLine.YLABEL
					prop_category = PlotEnsembleLine.YLABEL_CATEGORY;
				case PlotEnsembleLine.PLOTVALUE
					prop_category = PlotEnsembleLine.PLOTVALUE_CATEGORY;
				case PlotEnsembleLine.MEASURE
					prop_category = PlotEnsembleLine.MEASURE_CATEGORY;
				case PlotEnsembleLine.CIL
					prop_category = PlotEnsembleLine.CIL_CATEGORY;
				case PlotEnsembleLine.CIU
					prop_category = PlotEnsembleLine.CIU_CATEGORY;
				case PlotEnsembleLine.NODE1
					prop_category = PlotEnsembleLine.NODE1_CATEGORY;
				case PlotEnsembleLine.NODE2
					prop_category = PlotEnsembleLine.NODE2_CATEGORY;
				case PlotEnsembleLine.COLOR
					prop_category = PlotEnsembleLine.COLOR_CATEGORY;
				case PlotEnsembleLine.LINESTYLE
					prop_category = PlotEnsembleLine.LINESTYLE_CATEGORY;
				case PlotEnsembleLine.LINEWIDTH
					prop_category = PlotEnsembleLine.LINEWIDTH_CATEGORY;
				case PlotEnsembleLine.MARKER
					prop_category = PlotEnsembleLine.MARKER_CATEGORY;
				case PlotEnsembleLine.MARKERSIZE
					prop_category = PlotEnsembleLine.MARKERSIZE_CATEGORY;
				case PlotEnsembleLine.MARKEREDGECOLOR
					prop_category = PlotEnsembleLine.MARKEREDGECOLOR_CATEGORY;
				case PlotEnsembleLine.MARKERFACECOLOR
					prop_category = PlotEnsembleLine.MARKERFACECOLOR_CATEGORY;
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(PlotEnsembleLine, POINTER) returns format of POINTER of PlotEnsembleLine.
			%  FORMAT = PR.GETPROPFORMAT(PlotEnsembleLine, POINTER) returns format of POINTER of PlotEnsembleLine.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					prop_format = PlotEnsembleLine.PLOTTITLE_FORMAT;
				case PlotEnsembleLine.A
					prop_format = PlotEnsembleLine.A_FORMAT;
				case PlotEnsembleLine.X
					prop_format = PlotEnsembleLine.X_FORMAT;
				case PlotEnsembleLine.XLABEL
					prop_format = PlotEnsembleLine.XLABEL_FORMAT;
				case PlotEnsembleLine.YLABEL
					prop_format = PlotEnsembleLine.YLABEL_FORMAT;
				case PlotEnsembleLine.PLOTVALUE
					prop_format = PlotEnsembleLine.PLOTVALUE_FORMAT;
				case PlotEnsembleLine.MEASURE
					prop_format = PlotEnsembleLine.MEASURE_FORMAT;
				case PlotEnsembleLine.CIL
					prop_format = PlotEnsembleLine.CIL_FORMAT;
				case PlotEnsembleLine.CIU
					prop_format = PlotEnsembleLine.CIU_FORMAT;
				case PlotEnsembleLine.NODE1
					prop_format = PlotEnsembleLine.NODE1_FORMAT;
				case PlotEnsembleLine.NODE2
					prop_format = PlotEnsembleLine.NODE2_FORMAT;
				case PlotEnsembleLine.COLOR
					prop_format = PlotEnsembleLine.COLOR_FORMAT;
				case PlotEnsembleLine.LINESTYLE
					prop_format = PlotEnsembleLine.LINESTYLE_FORMAT;
				case PlotEnsembleLine.LINEWIDTH
					prop_format = PlotEnsembleLine.LINEWIDTH_FORMAT;
				case PlotEnsembleLine.MARKER
					prop_format = PlotEnsembleLine.MARKER_FORMAT;
				case PlotEnsembleLine.MARKERSIZE
					prop_format = PlotEnsembleLine.MARKERSIZE_FORMAT;
				case PlotEnsembleLine.MARKEREDGECOLOR
					prop_format = PlotEnsembleLine.MARKEREDGECOLOR_FORMAT;
				case PlotEnsembleLine.MARKERFACECOLOR
					prop_format = PlotEnsembleLine.MARKERFACECOLOR_FORMAT;
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotEnsembleLine, POINTER) returns description of POINTER of PlotEnsembleLine.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotEnsembleLine, POINTER) returns description of POINTER of PlotEnsembleLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					prop_description = 'PLOTTITLE(metadata, string) to set plot line title.';
				case PlotEnsembleLine.A
					prop_description = 'A(data, item) to set ensemble line information.';
				case PlotEnsembleLine.X
					prop_description = 'X(data, rvector) to set plot line graph x range.';
				case PlotEnsembleLine.XLABEL
					prop_description = 'XLABEL(metadata, string) to set plot line x label.';
				case PlotEnsembleLine.YLABEL
					prop_description = 'YLABEL(metadata, string) to set plot line y label.';
				case PlotEnsembleLine.PLOTVALUE
					prop_description = 'PLOTVALUE(data, cell) to set plot line atlas.';
				case PlotEnsembleLine.MEASURE
					prop_description = 'MEASURE(data, string) to set plot line measure.';
				case PlotEnsembleLine.CIL
					prop_description = 'CIL (metadata, CELL) to set plot line cil.';
				case PlotEnsembleLine.CIU
					prop_description = 'CIU (metadata, CELL) to set plot line ciu.';
				case PlotEnsembleLine.NODE1
					prop_description = 'NODE1 (metadata, scalar) to set plot line node 1.';
				case PlotEnsembleLine.NODE2
					prop_description = 'NODE2 (metadata, scalar) to set plot line node 2.';
				case PlotEnsembleLine.COLOR
					prop_description = 'COLOR (metadata, rvector) to set plot line color.';
				case PlotEnsembleLine.LINESTYLE
					prop_description = 'LINESTYLE (metadata, string) to set plot line style.';
				case PlotEnsembleLine.LINEWIDTH
					prop_description = 'LINEWIDTH (metadata, scalar) to set plot line width.';
				case PlotEnsembleLine.MARKER
					prop_description = 'MARKER (metadata, string) to set plot marker style.';
				case PlotEnsembleLine.MARKERSIZE
					prop_description = 'MARKERSIZE (metadata, scalar) to set plot marker size.';
				case PlotEnsembleLine.MARKEREDGECOLOR
					prop_description = 'MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.';
				case PlotEnsembleLine.MARKERFACECOLOR
					prop_description = 'MARKERFACECOLOR (metadata, rvector) to set plot marker face color.';
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(PlotEnsembleLine, POINTER) returns settings of POINTER of PlotEnsembleLine.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotEnsembleLine, POINTER) returns settings of POINTER of PlotEnsembleLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.A
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotEnsembleLine.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleLine.XLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.YLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.PLOTVALUE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleLine.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleLine.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleLine.NODE1
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleLine.NODE2
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleLine.COLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleLine.LINESTYLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleLine.MARKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleLine.MARKERSIZE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleLine.MARKEREDGECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleLine.MARKERFACECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotEnsembleLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotEnsembleLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotEnsembleLine, POINTER) returns the default value of POINTER of PlotEnsembleLine.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotEnsembleLine, POINTER) returns the default value of POINTER of PlotEnsembleLine.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.A
					prop_default = Format.getFormatDefault(Format.ITEM, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.XLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.YLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.PLOTVALUE
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.CIL
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.CIU
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.NODE1
					prop_default = 1;
				case PlotEnsembleLine.NODE2
					prop_default = 2;
				case PlotEnsembleLine.COLOR
					prop_default = [0 0 0];
				case PlotEnsembleLine.LINESTYLE
					prop_default = '-';
				case PlotEnsembleLine.LINEWIDTH
					prop_default = 0.5;
				case PlotEnsembleLine.MARKER
					prop_default = 'none';
				case PlotEnsembleLine.MARKERSIZE
					prop_default = 6;
				case PlotEnsembleLine.MARKEREDGECOLOR
					prop_default = [0 0 0];
				case PlotEnsembleLine.MARKERFACECOLOR
					prop_default = [0 0 0];
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotEnsembleLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotEnsembleLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotEnsembleLine, POINTER) returns the conditioned default value of POINTER of PlotEnsembleLine.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotEnsembleLine, POINTER) returns the conditioned default value of POINTER of PlotEnsembleLine.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			prop_default = PlotEnsembleLine.conditioning(prop, PlotEnsembleLine.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotEnsembleLine, PROP, VALUE) checks VALUE format for PROP of PlotEnsembleLine.
			%  CHECK = PR.CHECKPROP(PlotEnsembleLine, PROP, VALUE) checks VALUE format for PROP of PlotEnsembleLine.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  Element.CHECKPROP(PlotEnsembleLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotEnsembleLine.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			%  PR.CHECKPROP(PlotEnsembleLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotEnsembleLine.
			%   Error id: [BRAPH2:PlotEnsembleLine:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleLine.PLOTTITLE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.A
					check = Format.checkFormat(Format.ITEM, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.X
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.XLABEL
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.YLABEL
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.PLOTVALUE
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MEASURE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.CIL
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.CIU
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.NODE1
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.NODE2
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.COLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.LINESTYLE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.LINEWIDTH
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MARKER
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MARKERSIZE
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MARKEREDGECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleLine.getPropSettings(prop));
				case PlotEnsembleLine.MARKERFACECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleLine.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotEnsembleLine.getPropTag(prop) ' (' PlotEnsembleLine.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotEnsembleLine(varargin)
			% PlotEnsembleLine() creates a plot graph.
			%
			% PlotEnsembleLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotEnsembleLine(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotEnsembleLine properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
			%  <strong>4</strong> <strong>a</strong> 	A(data, item) to set ensemble line information.
			%  <strong>5</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range.
			%  <strong>6</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label.
			%  <strong>7</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label.
			%  <strong>8</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas.
			%  <strong>9</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure.
			%  <strong>10</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil.
			%  <strong>11</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu.
			%  <strong>12</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1.
			%  <strong>13</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2.
			%  <strong>14</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color.
			%  <strong>15</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style.
			%  <strong>16</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width.
			%  <strong>17</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style.
			%  <strong>18</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size.
			%  <strong>19</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
			%  <strong>20</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotEnsembleLine.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Plot.getPropNumber()
						value = conditioning@Plot(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_figure = draw(pr, varargin)
		    %DRAW draws the plot line.
		    %
		    % DRAW(PR) draws the plot line.
		    %
		    % H = DRAW(PR) returns a handle to the plot line.
		    %
		    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the plot line
		    %  with custom property-value couples.
		    %  All standard plot properties of plot line can be used.
		    %
		    % see also settings, uipanel, isgraphics, Plot.
		
		
		    pr.pp = draw@Plot(pr, varargin{:});
		    pr.h_figure = get(pr.pp, 'Parent');
		    subpanel = uipanel(pr.h_figure, ...
		        'BackGroundColor', 'w', ...
		        'Units', 'normalized', ...
		        'Position', [.0 .0 1 1] ...
		        );
		
		    pr.h_axes = axes(subpanel);
		
		    if nargout > 0
		        h_figure = pr.h_figure;
		    end
		end
		function f_settings = settings(pr, varargin)
		    %SETTINGS opens the property editor GUI.
		    %
		    % SETTINGS(PR) allows the user to specify the properties of the plot
		    %  by opening a GUI property editor.
		    %
		    % F = SETTINGS(PR) returns a handle to the property editor GUI.
		    %
		    % SETTINGS(PR, 'Property', VALUE, ...) sets the properties of the
		    %  property editor GUI with custom property-value couples.
		    %  All standard plot properties of figure can be used.
		    %
		    % See also draw, figure, isgraphics.
		
		    pr.h_settings = settings@Plot(pr, varargin{:});
		    set_braph2icon(pr.h_settings);
		
		    % constants
		    line_style = {'-', '--', ':', ':.', 'none'}; % TODO: move to BRAPH2
		    marker_style = {'o', '+', '*', '.', 'x', ...
		        '_', '|', 'square', 'diamond', '^', ...
		        '>', '<', 'pentagram', 'hexagram', 'none'}; % TODO: move to BRAPH2
		    % values
		    analyze_ensemble = pr.get('A');
		    me_dict = analyze_ensemble.get('ME_DICT');
		    pr.m = me_dict.getItem(1); % its a cell;
		
		    % atlas
		    sub = analyze_ensemble.get('GR').get('SUB_DICT').getItem(1);
		    atlas = sub.get('BA');
		    node_labels = cellfun(@(x) x.get('ID') , atlas.get('BR_DICT').getItems(), 'UniformOutput', false);
		
		    % measure list
		    measure_list = me_dict.getKeys();
		
		    ui_plot_properties_panel = uipanel(pr.h_settings, ...
		        'Units', 'normalized', ...
		        'BackgroundColor', [1 .9725 .929], ...
		        'Position', [0 0 1 1]);
		
		    % measures
		
		    measure_panel = uipanel(ui_plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .85 .98 .14] ...
		        );
		
		    measure_list_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Measure', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .01 .1 .8]);
		
		    measure_list_popup = uicontrol(measure_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.11 .02 .1 .8], ...
		        'String', measure_list, ...
		        'TooltipString', 'Plot Line Style', ...
		        'Callback', {@cb_measure_selection} ...
		        );
		
		        function cb_measure_selection(~,~)
		            val = measure_list_popup.Value;
		            str = measure_list_popup.String;
		            pr.m = me_dict.getItem(val);
		            pr.set('YLABEL', pr.m.get('MEASURE'))
		            rules_node_popmenu_deactivation()
		            pr.update_plot()
		        end
		
		    node_1_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Brain Region 1', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.22 .01 .1 .8]);
		    node_2_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Brain Region 2', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.44 .01 .1 .9]);
		    ui_node1_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);
		    ui_node2_popmenu  = uicontrol('Parent', measure_panel, 'Style', 'popupmenu', 'String', node_labels);
		
		        function update()
		            pr.update_plot();
		        end
		        function init_measure_plot_area()
		            set(ui_node1_popmenu, ...
		                'Units', 'normalized', ...
		                'Tooltip', 'Select the Node to be Plotted.', ...
		                'String', node_labels, ...
		                'Value', pr.get('NODE1'), ...
		                'Position', [.33 .02 .1 .8], ...
		                'Callback', {@cb_node_1} ...
		                );
		            set(ui_node2_popmenu, ...
		                'Units', 'normalized', ...
		                'Tooltip', 'Select the Node to be Plotted.', ...
		                'String', node_labels, ...
		                'Value', pr.get('NODE2'), ...
		                'Position', [.55 .02 .1 .8], ...
		                'Callback', {@cb_node_2} ...
		                );
		            rules_node_popmenu_deactivation()
		        end
		        function rules_node_popmenu_deactivation()
		            if Measure.is_global(pr.m.get('Measure'))
		                set(ui_node1_popmenu, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		                set(ui_node2_popmenu, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		                set(node_1_id, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		                set(node_2_id, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		
		            elseif Measure.is_nodal(pr.m.get('Measure'))
		                set(ui_node1_popmenu, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                set(ui_node2_popmenu, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		                set(node_1_id, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                set(node_2_id, ...
		                    'Visible', 'off', ...
		                    'Enable', 'off' ...
		                    )
		                node_1_id.String = 'Brain Region';
		            else
		                set(ui_node1_popmenu, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                set(ui_node2_popmenu, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                set(node_1_id, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                set(node_2_id, ...
		                    'Visible', 'on', ...
		                    'Enable', 'on' ...
		                    )
		                node_1_id.String = 'Brain Region 1';
		            end
		        end
		        function cb_node_1(source, ~)
		            node1_to_plot = double(source.Value);
		            pr.set('NODE1', node1_to_plot)
		            update();
		        end
		        function cb_node_2(source, ~)
		            node2_to_plot = double(source.Value);
		            pr.set('NODE2', node2_to_plot)
		            update();
		        end
		
		    if ~isempty(pr.get('CIL')) && ~isempty(pr.get('CIU'))
		        ui_confidence_interval_min_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized');
		        ui_confidence_interval_max_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized');
		        h_p_min = [];
		        h_p_max = [];
		        init_cil_panel()
		    end
		        function init_cil_panel()
		            set(ui_confidence_interval_min_checkbox, 'Position', [.04 .4 .2 .12]);
		            set(ui_confidence_interval_min_checkbox, 'String', 'Show Lower Confidence Interval');
		            set(ui_confidence_interval_min_checkbox, 'Value', false);
		            set(ui_confidence_interval_min_checkbox, 'Callback', {@cb_show_confidence_interval_min})
		
		            set(ui_confidence_interval_max_checkbox, 'Position', [.04 .027 .2 .12]);
		            set(ui_confidence_interval_max_checkbox, 'String', 'Show Upper Confidence Interval');
		            set(ui_confidence_interval_max_checkbox, 'Value', false);
		            set(ui_confidence_interval_max_checkbox, 'Callback', {@cb_show_confidence_interval_max})
		        end
		        function cb_show_confidence_interval_min(src, ~)
		            if src.Value == true
		                cil = obtain_cil_ciu_value(pr.get('CIL'));
		                x_ = pr.get('X');
		                hold(pr.h_axes, 'on')
		                h_p_min = plot(pr.h_axes, ...
		                    x_, ...
		                    cil, ...
		                    'Marker', 'x', ...
		                    'MarkerSize', 10, ...
		                    'MarkerEdgeColor', [0 0 1], ...
		                    'MarkerFaceColor', [.3 .4 .5], ...
		                    'LineStyle', '-', ...
		                    'LineWidth', 1, ...
		                    'Color', [0 1 1]);
		                h_p_min.Visible = true;
		            else
		                h_p_min.Visible = false;
		            end
		        end
		        function cb_show_confidence_interval_max(src, ~)
		            if src.Value == true
		                hold(pr.h_axes, 'on')
		                x_ = pr.get('X');
		                ciu = obtain_cil_ciu_value(pr.get('CIU'));
		                h_p_max = plot(pr.h_axes, ...
		                    x_, ...
		                    ciu, ...
		                    'Marker', 'x', ...
		                    'MarkerSize', 10, ...
		                    'MarkerEdgeColor', [0 0 1], ...
		                    'MarkerFaceColor', [.3 .4 .5], ...
		                    'LineStyle', '-', ...
		                    'LineWidth', 1, ...
		                    'Color', [0 1 1]);
		                h_p_max.Visible = true;
		            else
		                h_p_max.Visible = false;
		            end
		        end
		        function limit = obtain_cil_ciu_value(array)
		            node1_to_plot = pr.get('NODE1');
		            node2_to_plot = pr.get('NODE2');
		
		            if Measure.is_global(pr.m.get('Measure')) % global
		                is_inf_vector = cellfun(@(x) isinf(x), array);
		                if any(is_inf_vector)
		                    return;
		                end
		                limit = [array{:}];
		            elseif Measure.is_nodal(pr.m.get('Measure')) % nodal
		                for l = 1:length(array)
		                    tmp = array{l};
		                    tmp_y = tmp(node1_to_plot);
		                    if isinf(tmp_y)
		                        return;
		                    end
		                    limit(l) = tmp_y; %#ok<AGROW>
		                end
		            else  % binodal
		                for l = 1:length(array)
		                    tmp = array{l};
		                    tmp_y = tmp(node1_to_plot, node2_to_plot);
		                    if isinf(tmp_y)
		                        return;
		                    end
		                    limit(l) = tmp_y; %#ok<AGROW>
		                end
		            end
		        end
		
		    % line
		    comparison_plot_style_panel = uipanel(ui_plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .01 .98 .84] ...
		        );
		
		    line_style_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .72 .32 .1]);
		
		    ui_line_style = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.34 .72 .64 .1], ...
		        'String', line_style, ...
		        'TooltipString', 'Plot Line Style', ...
		        'Callback', {@cb_line_style});
		
		        function cb_line_style(~, ~)  % (src, event)
		            val = ui_line_style.Value;
		            str = ui_line_style.String;
		            pr.set('LINESTYLE', str{val})
		            update()
		        end
		
		    line_color_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .6 .32 .1]);
		
		    ui_line_color = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'pushbutton', ...
		        'Units','normalized', ...
		        'Position', [.34 .6 .64 .1], ...
		        'String', 'Line Color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Plot Line Color', ...
		        'Callback', {@cb_line_color});
		
		        function cb_line_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pr.set('COLOR', color)
		                update()
		            end
		        end
		
		    line_width_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Width', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .48 .32 .1]);
		    ui_line_width = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'edit', ...
		        'Units', 'normalized', ...
		        'Position', [.34 .48 .64 .1], ...
		        'String', '5', ...
		        'TooltipString', 'Plot Line Width', ...
		        'Callback', {@cb_line_width});
		
		        function cb_line_width(~, ~)  % (src, event)
		            value = str2num(ui_line_width.String);
		            pr.set('LINEWIDTH', value)
		            update()
		        end
		
		    % markers
		    narker_style_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .36 .32 .1]);
		    ui_marker_style = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.34 .36 .64 .1], ...
		        'String', marker_style, ...
		        'TooltipString', 'Plot Marker Style', ...
		        'Callback', {@cb_marker_style});
		
		        function cb_marker_style(~, ~)  % (src, event)
		            val = ui_marker_style.Value;
		            str = ui_marker_style.String;
		            pr.set('MARKER', str{val})
		            update()
		        end
		
		    marker_width_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Width', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .12 .32 .1]);
		    ui_marker_size = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'edit', ...
		        'Units', 'normalized', ...
		        'Position', [.34 .12 .64 .1], ...
		        'String', '5', ...
		        'TooltipString', 'Marker Line Width', ...
		        'Callback', {@cb_marker_size});
		
		        function cb_marker_size(~, ~)  % (src, event)
		            value = str2num(ui_line_width.String);
		            pr.set('MARKERSIZE', value)
		            update()
		        end
		
		    marker_edge_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Edge Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .24 .32 .1]);
		    ui_marker_edge_color = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'pushbutton', ...
		        'Units','normalized', ...
		        'Position', [.34 .24 .64 .1], ...
		        'String', 'Marker Edge Color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Marker Edge Color', ...
		        'Callback', {@cb_marker_edge_color});
		
		        function cb_marker_edge_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pr.set('MARKEREDGECOLOR', color)
		                update()
		            end
		        end
		
		    marker_face_id = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Face Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .01 .32 .1]);
		    ui_marker_face_color = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'pushbutton', ...
		        'Units','normalized', ...
		        'Position', [.34 .01 .64 .1], ...
		        'String', 'Marker Face Color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Marker Face Color', ...
		        'Callback', {@cb_marker_face_color});
		
		        function cb_marker_face_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pr.set('MARKERFACECOLOR', color)
		                update()
		            end
		        end
		
		    init_measure_plot_area()
		
		    if nargin > 0
		        f_settings = pr.h_settings;
		    end
		end
		function update_plot(pr)
		    measure = pr.m;
		    plot_value = measure.get('M');
		    if Measure.is_global(pr.m.get('Measure')) % global
		        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		        if any(is_inf_vector)
		            f = warndlg('The measure cannot be plotted because it contains Inf values.');
		            set_braph2icon(f);
		            return;
		        end
		        y_ = [plot_value{:}];
		    elseif Measure.is_nodal(pr.m.get('Measure')) % nodal
		        for l = 1:length(plot_value)
		            tmp = plot_value{l};
		            tmp_y = tmp(pr.get('NODE1'));
		            if isinf(tmp_y)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_(l) = tmp_y; %#ok<AGROW>
		        end
		    else  % binodal
		        for l = 1:length(plot_value)
		            tmp = plot_value{l};
		            tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
		            if isinf(tmp_y)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_(l) = tmp_y; %#ok<AGROW>
		        end
		    end
		    pr.plotline(pr.get('X'), y_)
		end
		function plotline(pr, x, y)
		    pr.h_plot = plot( ...
		        pr.h_axes, ...
		        x, ...
		        y, ...
		        'Marker', pr.get('MARKER'), ...
		        'MarkerSize', pr.get('MARKERSIZE'), ...
		        'MarkerEdgeColor', pr.get('MARKEREDGECOLOR'), ...
		        'MarkerFaceColor', pr.get('MARKERFACECOLOR'), ...
		        'LineStyle', pr.get('LINESTYLE'), ...
		        'LineWidth', pr.get('LINEWIDTH'), ...
		        'Color', pr.get('COLOR') ...
		        );
		
		    title(pr.h_axes, pr.get('PLOTTITLE'))
		    xlabel(pr.h_axes, pr.get('XLABEL'))
		    ylabel(pr.h_axes, pr.get('YLABEL'))
		end
	end
end
