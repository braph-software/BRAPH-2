classdef PlotEnsembleMPLine < Plot
	% PlotEnsembleMPLine is a line plot of the multilayer measure values.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% Plot is the line plot of the multilayer measure values.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	%
	% The list of PlotEnsembleMPLine properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
	%  <strong>4</strong> <strong>a</strong> 	A(data, item) to set ensemble line information.
	%  <strong>5</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range.
	%  <strong>6</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label.
	%  <strong>7</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label.
	%  <strong>8</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas.
	%  <strong>9</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure.
	%  <strong>10</strong> <strong>layer</strong> 	LAYER (metadata, scalar) to set plot line layer.
	%  <strong>11</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil.
	%  <strong>12</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu.
	%  <strong>13</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1.
	%  <strong>14</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2.
	%  <strong>15</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color.
	%  <strong>16</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style.
	%  <strong>17</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width.
	%  <strong>18</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style.
	%  <strong>19</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size.
	%  <strong>20</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
	%  <strong>21</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
	%
	% PlotEnsembleMPLine methods (constructor):
	% PlotEnsembleMPLine - constructor
	%
	% PlotEnsembleMPLine methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot graph mp/error.
	%  existsProp - checks whether property exists in plot graph mp/error.
	%  getPropNumber - returns the property number of plot graph mp.
	%  getProps - returns the property list of plot graph mp.
	%  getDescription - returns the description of the plot graph mp.
	%  getName - returns the name of the plot graph mp.
	%  getClass - returns the class of the plot graph mp.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotEnsembleMPLine methods:
	%  plotline - bleMPLine/plotline is a function.
	%  update_plot - MPLine/update_plot is a function.
	%  settings - opens the property editor GUI.
	%  draw - draws the plot line.
	%  set_settings - PLine/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - MPLine/cb_close_fs is a function.
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
	% PlotEnsembleMPLine methods (operators):
	%  isequal - determines whether two PlotEnsembleMPLine are equal (values, locked)
	%
	% PlotEnsembleMPLine methods (display):
	%  tostring - string with information about the PlotEnsembleMPLine
	%  disp - displays information about the PlotEnsembleMPLine
	%  tree - displays the element of PlotEnsembleMPLine
	%
	% PlotEnsembleMPLine method (element list):
	%  getElementList - returns a list with all subelements of PlotEnsembleMPLine
	%
	% PlotEnsembleMPLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotEnsembleMPLine
	%
	% PlotEnsembleMPLine method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotEnsembleMPLine
	%
	% PlotEnsembleMPLine methods (copy):
	%  copy - copies the PlotEnsembleMPLine
	%  deepclone - deep-clones the PlotEnsembleMPLine
	%  clone - clones the PlotEnsembleMPLine
	%
	% PlotEnsembleMPLine methods (inspection, Static):
	%  getClass - returns PlotEnsembleMPLine
	%  getName - returns the name of PlotEnsembleMPLine
	%  getDescription - returns the description of PlotEnsembleMPLine
	%  getProps - returns the property list of PlotEnsembleMPLine
	%  getPropNumber - returns the property number of PlotEnsembleMPLine
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
	% PlotEnsembleMPLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotEnsembleMPLine methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotEnsembleMPLine methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotEnsembleMPLine methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotEnsembleMPLine properties (Constant).
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
	%  LAYER - 10
	%  LAYER_TAG - 'layer'
	%  LAYER_CATEGORY - 'm'
	%  LAYER_FORMAT - 'nn'
	%  CIL - 11
	%  CIL_TAG - 'cil'
	%  CIL_CATEGORY - 'm'
	%  CIL_FORMAT - 'll'
	%  CIU - 12
	%  CIU_TAG - 'ciu'
	%  CIU_CATEGORY - 'm'
	%  CIU_FORMAT - 'll'
	%  NODE1 - 13
	%  NODE1_TAG - 'node1'
	%  NODE1_CATEGORY - 'm'
	%  NODE1_FORMAT - 'nn'
	%  NODE2 - 14
	%  NODE2_TAG - 'node2'
	%  NODE2_CATEGORY - 'm'
	%  NODE2_FORMAT - 'nn'
	%  COLOR - 15
	%  COLOR_TAG - 'color'
	%  COLOR_CATEGORY - 'm'
	%  COLOR_FORMAT - 'nr'
	%  LINESTYLE - 16
	%  LINESTYLE_TAG - 'linestyle'
	%  LINESTYLE_CATEGORY - 'm'
	%  LINESTYLE_FORMAT - 'st'
	%  LINEWIDTH - 17
	%  LINEWIDTH_TAG - 'linewidth'
	%  LINEWIDTH_CATEGORY - 'm'
	%  LINEWIDTH_FORMAT - 'nn'
	%  MARKER - 18
	%  MARKER_TAG - 'marker'
	%  MARKER_CATEGORY - 'm'
	%  MARKER_FORMAT - 'st'
	%  MARKERSIZE - 19
	%  MARKERSIZE_TAG - 'markersize'
	%  MARKERSIZE_CATEGORY - 'm'
	%  MARKERSIZE_FORMAT - 'nn'
	%  MARKEREDGECOLOR - 20
	%  MARKEREDGECOLOR_TAG - 'markeredgecolor'
	%  MARKEREDGECOLOR_CATEGORY - 'm'
	%  MARKEREDGECOLOR_FORMAT - 'nr'
	%  MARKERFACECOLOR - 21
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
		
		LAYER = Plot.getPropNumber() + 8;
		LAYER_TAG = 'layer';
		LAYER_CATEGORY = Category.METADATA;
		LAYER_FORMAT = Format.SCALAR;
		
		CIL = Plot.getPropNumber() + 9;
		CIL_TAG = 'cil';
		CIL_CATEGORY = Category.METADATA;
		CIL_FORMAT = Format.CELL;
		
		CIU = Plot.getPropNumber() + 10;
		CIU_TAG = 'ciu';
		CIU_CATEGORY = Category.METADATA;
		CIU_FORMAT = Format.CELL;
		
		NODE1 = Plot.getPropNumber() + 11;
		NODE1_TAG = 'node1';
		NODE1_CATEGORY = Category.METADATA;
		NODE1_FORMAT = Format.SCALAR;
		
		NODE2 = Plot.getPropNumber() + 12;
		NODE2_TAG = 'node2';
		NODE2_CATEGORY = Category.METADATA;
		NODE2_FORMAT = Format.SCALAR;
		
		COLOR = Plot.getPropNumber() + 13;
		COLOR_TAG = 'color';
		COLOR_CATEGORY = Category.METADATA;
		COLOR_FORMAT = Format.RVECTOR;
		
		LINESTYLE = Plot.getPropNumber() + 14;
		LINESTYLE_TAG = 'linestyle';
		LINESTYLE_CATEGORY = Category.METADATA;
		LINESTYLE_FORMAT = Format.STRING;
		
		LINEWIDTH = Plot.getPropNumber() + 15;
		LINEWIDTH_TAG = 'linewidth';
		LINEWIDTH_CATEGORY = Category.METADATA;
		LINEWIDTH_FORMAT = Format.SCALAR;
		
		MARKER = Plot.getPropNumber() + 16;
		MARKER_TAG = 'marker';
		MARKER_CATEGORY = Category.METADATA;
		MARKER_FORMAT = Format.STRING;
		
		MARKERSIZE = Plot.getPropNumber() + 17;
		MARKERSIZE_TAG = 'markersize';
		MARKERSIZE_CATEGORY = Category.METADATA;
		MARKERSIZE_FORMAT = Format.SCALAR;
		
		MARKEREDGECOLOR = Plot.getPropNumber() + 18;
		MARKEREDGECOLOR_TAG = 'markeredgecolor';
		MARKEREDGECOLOR_CATEGORY = Category.METADATA;
		MARKEREDGECOLOR_FORMAT = Format.RVECTOR;
		
		MARKERFACECOLOR = Plot.getPropNumber() + 19;
		MARKERFACECOLOR_TAG = 'markerfacecolor';
		MARKERFACECOLOR_CATEGORY = Category.METADATA;
		MARKERFACECOLOR_FORMAT = Format.RVECTOR;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot graph mp.
			%
			% CLASS = PlotEnsembleMPLine.GETCLASS() returns the class 'PlotEnsembleMPLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot graph mp PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotEnsembleMPLine') returns 'PlotEnsembleMPLine'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotEnsembleMPLine';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot graph mp.
			%
			% NAME = PlotEnsembleMPLine.GETNAME() returns the name of the 'plot graph mp'.
			%  Plot Graph Mp.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot graph mp PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotEnsembleMPLine') returns the name of 'PlotEnsembleMPLine'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Graph Mp';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot graph mp.
			%
			% STR = PlotEnsembleMPLine.GETDESCRIPTION() returns the description of the 'plot graph mp'.
			%  which is:
			%
			%  Plot is the line plot of the multilayer measure values.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot graph mp PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotEnsembleMPLine') returns the description of 'PlotEnsembleMPLine'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'Plot is the line plot of the multilayer measure values.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot graph mp.
			%
			% PROPS = PlotEnsembleMPLine.GETPROPS() returns the property list of plot graph mp.
			%
			% PROPS = PlotEnsembleMPLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot graph mp PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotEnsembleMPLine'[, CATEGORY]) returns the property list of 'PlotEnsembleMPLine'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotEnsembleMPLine.PLOTTITLE
						PlotEnsembleMPLine.XLABEL
						PlotEnsembleMPLine.YLABEL
						PlotEnsembleMPLine.LAYER
						PlotEnsembleMPLine.CIL
						PlotEnsembleMPLine.CIU
						PlotEnsembleMPLine.NODE1
						PlotEnsembleMPLine.NODE2
						PlotEnsembleMPLine.COLOR
						PlotEnsembleMPLine.LINESTYLE
						PlotEnsembleMPLine.LINEWIDTH
						PlotEnsembleMPLine.MARKER
						PlotEnsembleMPLine.MARKERSIZE
						PlotEnsembleMPLine.MARKEREDGECOLOR
						PlotEnsembleMPLine.MARKERFACECOLOR
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotEnsembleMPLine.A
						PlotEnsembleMPLine.X
						PlotEnsembleMPLine.PLOTVALUE
						PlotEnsembleMPLine.MEASURE
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
						PlotEnsembleMPLine.PLOTTITLE
						PlotEnsembleMPLine.A
						PlotEnsembleMPLine.X
						PlotEnsembleMPLine.XLABEL
						PlotEnsembleMPLine.YLABEL
						PlotEnsembleMPLine.PLOTVALUE
						PlotEnsembleMPLine.MEASURE
						PlotEnsembleMPLine.LAYER
						PlotEnsembleMPLine.CIL
						PlotEnsembleMPLine.CIU
						PlotEnsembleMPLine.NODE1
						PlotEnsembleMPLine.NODE2
						PlotEnsembleMPLine.COLOR
						PlotEnsembleMPLine.LINESTYLE
						PlotEnsembleMPLine.LINEWIDTH
						PlotEnsembleMPLine.MARKER
						PlotEnsembleMPLine.MARKERSIZE
						PlotEnsembleMPLine.MARKEREDGECOLOR
						PlotEnsembleMPLine.MARKERFACECOLOR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot graph mp.
			%
			% N = PlotEnsembleMPLine.GETPROPNUMBER() returns the property number of plot graph mp.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot graph mp PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotEnsembleMPLine') returns the property number of 'PlotEnsembleMPLine'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 21;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot graph mp/error.
			%
			% CHECK = PlotEnsembleMPLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotEnsembleMPLine, PROP) checks whether PROP exists for PlotEnsembleMPLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  Element.EXISTSPROP(PlotEnsembleMPLine, PROP) throws error if PROP does NOT exist for PlotEnsembleMPLine.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 ]);
			else
				assert( ...
					PlotEnsembleMPLine.existsProp(prop), ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotEnsembleMPLine.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot graph mp/error.
			%
			% CHECK = PlotEnsembleMPLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotEnsembleMPLine, TAG) checks whether TAG exists for PlotEnsembleMPLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  Element.EXISTSTAG(PlotEnsembleMPLine, TAG) throws error if TAG does NOT exist for PlotEnsembleMPLine.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotensemblempline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'a'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'layer'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				check = any(strcmpi(tag, plotensemblempline_tag_list));
			else
				assert( ...
					PlotEnsembleMPLine.existsTag(tag), ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotEnsembleMPLine'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotEnsembleMPLine, POINTER) returns property number of POINTER of PlotEnsembleMPLine.
			%  PROPERTY = PR.GETPROPPROP(PlotEnsembleMPLine, POINTER) returns property number of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotensemblempline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'a'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'layer'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				tag = pointer;
				PlotEnsembleMPLine.existsTag(tag);
				
				prop = find(strcmpi(tag, plotensemblempline_tag_list));
			else % numeric
				prop = pointer;
				PlotEnsembleMPLine.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotEnsembleMPLine, POINTER) returns tag of POINTER of PlotEnsembleMPLine.
			%  TAG = PR.GETPROPTAG(PlotEnsembleMPLine, POINTER) returns tag of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotEnsembleMPLine.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotEnsembleMPLine.existsProp(prop);
				
				switch prop
					case PlotEnsembleMPLine.PLOTTITLE
						tag = PlotEnsembleMPLine.PLOTTITLE_TAG;
					case PlotEnsembleMPLine.A
						tag = PlotEnsembleMPLine.A_TAG;
					case PlotEnsembleMPLine.X
						tag = PlotEnsembleMPLine.X_TAG;
					case PlotEnsembleMPLine.XLABEL
						tag = PlotEnsembleMPLine.XLABEL_TAG;
					case PlotEnsembleMPLine.YLABEL
						tag = PlotEnsembleMPLine.YLABEL_TAG;
					case PlotEnsembleMPLine.PLOTVALUE
						tag = PlotEnsembleMPLine.PLOTVALUE_TAG;
					case PlotEnsembleMPLine.MEASURE
						tag = PlotEnsembleMPLine.MEASURE_TAG;
					case PlotEnsembleMPLine.LAYER
						tag = PlotEnsembleMPLine.LAYER_TAG;
					case PlotEnsembleMPLine.CIL
						tag = PlotEnsembleMPLine.CIL_TAG;
					case PlotEnsembleMPLine.CIU
						tag = PlotEnsembleMPLine.CIU_TAG;
					case PlotEnsembleMPLine.NODE1
						tag = PlotEnsembleMPLine.NODE1_TAG;
					case PlotEnsembleMPLine.NODE2
						tag = PlotEnsembleMPLine.NODE2_TAG;
					case PlotEnsembleMPLine.COLOR
						tag = PlotEnsembleMPLine.COLOR_TAG;
					case PlotEnsembleMPLine.LINESTYLE
						tag = PlotEnsembleMPLine.LINESTYLE_TAG;
					case PlotEnsembleMPLine.LINEWIDTH
						tag = PlotEnsembleMPLine.LINEWIDTH_TAG;
					case PlotEnsembleMPLine.MARKER
						tag = PlotEnsembleMPLine.MARKER_TAG;
					case PlotEnsembleMPLine.MARKERSIZE
						tag = PlotEnsembleMPLine.MARKERSIZE_TAG;
					case PlotEnsembleMPLine.MARKEREDGECOLOR
						tag = PlotEnsembleMPLine.MARKEREDGECOLOR_TAG;
					case PlotEnsembleMPLine.MARKERFACECOLOR
						tag = PlotEnsembleMPLine.MARKERFACECOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotEnsembleMPLine, POINTER) returns category of POINTER of PlotEnsembleMPLine.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotEnsembleMPLine, POINTER) returns category of POINTER of PlotEnsembleMPLine.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					prop_category = PlotEnsembleMPLine.PLOTTITLE_CATEGORY;
				case PlotEnsembleMPLine.A
					prop_category = PlotEnsembleMPLine.A_CATEGORY;
				case PlotEnsembleMPLine.X
					prop_category = PlotEnsembleMPLine.X_CATEGORY;
				case PlotEnsembleMPLine.XLABEL
					prop_category = PlotEnsembleMPLine.XLABEL_CATEGORY;
				case PlotEnsembleMPLine.YLABEL
					prop_category = PlotEnsembleMPLine.YLABEL_CATEGORY;
				case PlotEnsembleMPLine.PLOTVALUE
					prop_category = PlotEnsembleMPLine.PLOTVALUE_CATEGORY;
				case PlotEnsembleMPLine.MEASURE
					prop_category = PlotEnsembleMPLine.MEASURE_CATEGORY;
				case PlotEnsembleMPLine.LAYER
					prop_category = PlotEnsembleMPLine.LAYER_CATEGORY;
				case PlotEnsembleMPLine.CIL
					prop_category = PlotEnsembleMPLine.CIL_CATEGORY;
				case PlotEnsembleMPLine.CIU
					prop_category = PlotEnsembleMPLine.CIU_CATEGORY;
				case PlotEnsembleMPLine.NODE1
					prop_category = PlotEnsembleMPLine.NODE1_CATEGORY;
				case PlotEnsembleMPLine.NODE2
					prop_category = PlotEnsembleMPLine.NODE2_CATEGORY;
				case PlotEnsembleMPLine.COLOR
					prop_category = PlotEnsembleMPLine.COLOR_CATEGORY;
				case PlotEnsembleMPLine.LINESTYLE
					prop_category = PlotEnsembleMPLine.LINESTYLE_CATEGORY;
				case PlotEnsembleMPLine.LINEWIDTH
					prop_category = PlotEnsembleMPLine.LINEWIDTH_CATEGORY;
				case PlotEnsembleMPLine.MARKER
					prop_category = PlotEnsembleMPLine.MARKER_CATEGORY;
				case PlotEnsembleMPLine.MARKERSIZE
					prop_category = PlotEnsembleMPLine.MARKERSIZE_CATEGORY;
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					prop_category = PlotEnsembleMPLine.MARKEREDGECOLOR_CATEGORY;
				case PlotEnsembleMPLine.MARKERFACECOLOR
					prop_category = PlotEnsembleMPLine.MARKERFACECOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotEnsembleMPLine, POINTER) returns format of POINTER of PlotEnsembleMPLine.
			%  FORMAT = PR.GETPROPFORMAT(PlotEnsembleMPLine, POINTER) returns format of POINTER of PlotEnsembleMPLine.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					prop_format = PlotEnsembleMPLine.PLOTTITLE_FORMAT;
				case PlotEnsembleMPLine.A
					prop_format = PlotEnsembleMPLine.A_FORMAT;
				case PlotEnsembleMPLine.X
					prop_format = PlotEnsembleMPLine.X_FORMAT;
				case PlotEnsembleMPLine.XLABEL
					prop_format = PlotEnsembleMPLine.XLABEL_FORMAT;
				case PlotEnsembleMPLine.YLABEL
					prop_format = PlotEnsembleMPLine.YLABEL_FORMAT;
				case PlotEnsembleMPLine.PLOTVALUE
					prop_format = PlotEnsembleMPLine.PLOTVALUE_FORMAT;
				case PlotEnsembleMPLine.MEASURE
					prop_format = PlotEnsembleMPLine.MEASURE_FORMAT;
				case PlotEnsembleMPLine.LAYER
					prop_format = PlotEnsembleMPLine.LAYER_FORMAT;
				case PlotEnsembleMPLine.CIL
					prop_format = PlotEnsembleMPLine.CIL_FORMAT;
				case PlotEnsembleMPLine.CIU
					prop_format = PlotEnsembleMPLine.CIU_FORMAT;
				case PlotEnsembleMPLine.NODE1
					prop_format = PlotEnsembleMPLine.NODE1_FORMAT;
				case PlotEnsembleMPLine.NODE2
					prop_format = PlotEnsembleMPLine.NODE2_FORMAT;
				case PlotEnsembleMPLine.COLOR
					prop_format = PlotEnsembleMPLine.COLOR_FORMAT;
				case PlotEnsembleMPLine.LINESTYLE
					prop_format = PlotEnsembleMPLine.LINESTYLE_FORMAT;
				case PlotEnsembleMPLine.LINEWIDTH
					prop_format = PlotEnsembleMPLine.LINEWIDTH_FORMAT;
				case PlotEnsembleMPLine.MARKER
					prop_format = PlotEnsembleMPLine.MARKER_FORMAT;
				case PlotEnsembleMPLine.MARKERSIZE
					prop_format = PlotEnsembleMPLine.MARKERSIZE_FORMAT;
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					prop_format = PlotEnsembleMPLine.MARKEREDGECOLOR_FORMAT;
				case PlotEnsembleMPLine.MARKERFACECOLOR
					prop_format = PlotEnsembleMPLine.MARKERFACECOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotEnsembleMPLine, POINTER) returns description of POINTER of PlotEnsembleMPLine.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotEnsembleMPLine, POINTER) returns description of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					prop_description = 'PLOTTITLE(metadata, string) to set plot line title.';
				case PlotEnsembleMPLine.A
					prop_description = 'A(data, item) to set ensemble line information.';
				case PlotEnsembleMPLine.X
					prop_description = 'X(data, rvector) to set plot line graph x range.';
				case PlotEnsembleMPLine.XLABEL
					prop_description = 'XLABEL(metadata, string) to set plot line x label.';
				case PlotEnsembleMPLine.YLABEL
					prop_description = 'YLABEL(metadata, string) to set plot line y label.';
				case PlotEnsembleMPLine.PLOTVALUE
					prop_description = 'PLOTVALUE(data, cell) to set plot line atlas.';
				case PlotEnsembleMPLine.MEASURE
					prop_description = 'MEASURE(data, string) to set plot line measure.';
				case PlotEnsembleMPLine.LAYER
					prop_description = 'LAYER (metadata, scalar) to set plot line layer.';
				case PlotEnsembleMPLine.CIL
					prop_description = 'CIL (metadata, CELL) to set plot line cil.';
				case PlotEnsembleMPLine.CIU
					prop_description = 'CIU (metadata, CELL) to set plot line ciu.';
				case PlotEnsembleMPLine.NODE1
					prop_description = 'NODE1 (metadata, scalar) to set plot line node 1.';
				case PlotEnsembleMPLine.NODE2
					prop_description = 'NODE2 (metadata, scalar) to set plot line node 2.';
				case PlotEnsembleMPLine.COLOR
					prop_description = 'COLOR (metadata, rvector) to set plot line color.';
				case PlotEnsembleMPLine.LINESTYLE
					prop_description = 'LINESTYLE (metadata, string) to set plot line style.';
				case PlotEnsembleMPLine.LINEWIDTH
					prop_description = 'LINEWIDTH (metadata, scalar) to set plot line width.';
				case PlotEnsembleMPLine.MARKER
					prop_description = 'MARKER (metadata, string) to set plot marker style.';
				case PlotEnsembleMPLine.MARKERSIZE
					prop_description = 'MARKERSIZE (metadata, scalar) to set plot marker size.';
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					prop_description = 'MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.';
				case PlotEnsembleMPLine.MARKERFACECOLOR
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotEnsembleMPLine, POINTER) returns settings of POINTER of PlotEnsembleMPLine.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotEnsembleMPLine, POINTER) returns settings of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.A
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotEnsembleMPLine.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleMPLine.XLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.YLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.PLOTVALUE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleMPLine.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleMPLine.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleMPLine.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotEnsembleMPLine.NODE1
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleMPLine.NODE2
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleMPLine.COLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleMPLine.LINESTYLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleMPLine.MARKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotEnsembleMPLine.MARKERSIZE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotEnsembleMPLine.MARKERFACECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotEnsembleMPLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotEnsembleMPLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotEnsembleMPLine, POINTER) returns the default value of POINTER of PlotEnsembleMPLine.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotEnsembleMPLine, POINTER) returns the default value of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.A
					prop_default = Format.getFormatDefault(Format.ITEM, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.XLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.YLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.PLOTVALUE
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.LAYER
					prop_default = 1;
				case PlotEnsembleMPLine.CIL
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.CIU
					prop_default = Format.getFormatDefault(Format.CELL, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.NODE1
					prop_default = 1;
				case PlotEnsembleMPLine.NODE2
					prop_default = 2;
				case PlotEnsembleMPLine.COLOR
					prop_default = [0 0 0];
				case PlotEnsembleMPLine.LINESTYLE
					prop_default = '-';
				case PlotEnsembleMPLine.LINEWIDTH
					prop_default = 0.5;
				case PlotEnsembleMPLine.MARKER
					prop_default = 'none';
				case PlotEnsembleMPLine.MARKERSIZE
					prop_default = 6;
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					prop_default = [0 0 0];
				case PlotEnsembleMPLine.MARKERFACECOLOR
					prop_default = [0 0 0];
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotEnsembleMPLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotEnsembleMPLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotEnsembleMPLine, POINTER) returns the conditioned default value of POINTER of PlotEnsembleMPLine.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotEnsembleMPLine, POINTER) returns the conditioned default value of POINTER of PlotEnsembleMPLine.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			prop_default = PlotEnsembleMPLine.conditioning(prop, PlotEnsembleMPLine.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotEnsembleMPLine, PROP, VALUE) checks VALUE format for PROP of PlotEnsembleMPLine.
			%  CHECK = PR.CHECKPROP(PlotEnsembleMPLine, PROP, VALUE) checks VALUE format for PROP of PlotEnsembleMPLine.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  Element.CHECKPROP(PlotEnsembleMPLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotEnsembleMPLine.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			%  PR.CHECKPROP(PlotEnsembleMPLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotEnsembleMPLine.
			%   Error id: [BRAPH2:PlotEnsembleMPLine:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotEnsembleMPLine.PLOTTITLE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.A
					check = Format.checkFormat(Format.ITEM, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.X
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.XLABEL
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.YLABEL
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.PLOTVALUE
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MEASURE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.LAYER
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.CIL
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.CIU
					check = Format.checkFormat(Format.CELL, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.NODE1
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.NODE2
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.COLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.LINESTYLE
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.LINEWIDTH
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MARKER
					check = Format.checkFormat(Format.STRING, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MARKERSIZE
					check = Format.checkFormat(Format.SCALAR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MARKEREDGECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleMPLine.getPropSettings(prop));
				case PlotEnsembleMPLine.MARKERFACECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotEnsembleMPLine.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotEnsembleMPLine.getPropTag(prop) ' (' PlotEnsembleMPLine.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotEnsembleMPLine(varargin)
			% PlotEnsembleMPLine() creates a plot graph mp.
			%
			% PlotEnsembleMPLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotEnsembleMPLine(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotEnsembleMPLine properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
			%  <strong>4</strong> <strong>a</strong> 	A(data, item) to set ensemble line information.
			%  <strong>5</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range.
			%  <strong>6</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label.
			%  <strong>7</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label.
			%  <strong>8</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas.
			%  <strong>9</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure.
			%  <strong>10</strong> <strong>layer</strong> 	LAYER (metadata, scalar) to set plot line layer.
			%  <strong>11</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil.
			%  <strong>12</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu.
			%  <strong>13</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1.
			%  <strong>14</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2.
			%  <strong>15</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color.
			%  <strong>16</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style.
			%  <strong>17</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width.
			%  <strong>18</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style.
			%  <strong>19</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size.
			%  <strong>20</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.
			%  <strong>21</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color.
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotEnsembleMPLine.getPropProp(pointer);
			
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
		
		    plot_properties_panel = uipanel(pr.h_settings, ...
		        'Units', 'normalized', ...
		        'BackgroundColor', [1 .9725 .929], ...
		        'Position', [0 0 1 1]);
		    
		    measure_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .85 .98 .14] ...
		        );
		
		    % line properties
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
		
		    layer_selector_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Layer Selection', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.66 .02 .1 .8]);
		
		    graph = pr.m.get('A').get('G_Dict').getItem(1);
		    layer_number = size(graph.get('B'), 2);
		    layer_popup = uicontrol('Parent', measure_panel,...
		        'Style', 'popupmenu',...
		        'Units', 'normalized', ...
		        'String', arrayfun(@(x) [num2str(x)], [1:layer_number], 'UniformOutput', false));
		    init_layer_section()
		        function init_layer_section()
		            set(layer_popup, 'Position', [.77 .02 .1 .8], ...
		                'Value', pr.get('LAYER'), ...
		                'Callback', {@layer_popup_selector});
		
		        end
		        function layer_popup_selector(src, ~)
		            layer_to_plot = double(src.Value);
		            pr.set('LAYER', layer_to_plot)
		            update();
		        end
		    
		    plot_style_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .01 .98 .84] ...
		        );
		
		    line_style_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .72 .32 .1]);
		
		    ui_line_style = uicontrol(plot_style_panel, ...
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
		
		    line_color_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .6 .32 .1]);
		
		    ui_line_color = uicontrol(plot_style_panel, ...
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
		
		    line_width_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Line Width', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .48 .32 .1]);
		    ui_line_width = uicontrol(plot_style_panel, ...
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
		    narker_style_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .36 .32 .1]);
		    ui_marker_style = uicontrol(plot_style_panel, ...
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
		
		    marker_width_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Width', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .12 .32 .1]);
		    ui_marker_size = uicontrol(plot_style_panel, ...
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
		
		    marker_edge_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Edge Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .24 .32 .1]);
		    ui_marker_edge_color = uicontrol(plot_style_panel, ...
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
		
		    marker_face_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Marker Face Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .01 .32 .1]);
		    ui_marker_face_color = uicontrol(plot_style_panel, ...
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
		    graph = pr.m.get('A').get('G_Dict').getItem(1);
		    layer_number = size(graph.get('B'), 2);
		    choosen_layer = pr.get('LAYER');
		
		    if Measure.is_global(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % global
		        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		        if any(is_inf_vector)
		            f = warndlg('The measure cannot be plotted because it contains Inf values.');
		            set_braph2icon(f);
		            return;
		        end
		        y_ = [plot_value{choosen_layer:layer_number:end}];
		    elseif Measure.is_nodal(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % nodal
		        tmp_index = 1;
		        for l = choosen_layer:layer_number:length(plot_value)
		            tmp = plot_value{l};
		            tmp_y = tmp(pr.get('NODE1'));
		            if isinf(tmp_y)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_(tmp_index) = tmp_y; %#ok<AGROW>
		            tmp_index = tmp_index + 1;
		        end
		    elseif  Measure.is_binodal(pr.m.get('Measure')) && ~Measure.is_superglobal(pr.m.get('Measure')) % binodal
		        tmp_index = 1;
		        for l = choosen_layer:layer_number:length(plot_value)
		            tmp = plot_value{l};
		            tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
		            if isinf(tmp_y)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_(tmp_index) = tmp_y; %#ok<AGROW>
		            tmp_index = tmp_index + 1;
		        end
		    elseif Measure.is_superglobal(pr.m.get('Measure')) % superglobal
		        if Measure.is_global(pr.m.get('Measure'))
		            is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		            if any(is_inf_vector)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_ = [plot_value{:}];
		        elseif Measure.is_nodal(pr.m.get('Measure'))
		            tmp_index = 1;
		            for l = 1:length(plot_value)
		                tmp = plot_value{l};
		                tmp_y = tmp(pr.get('NODE1'));
		                if isinf(tmp_y)
		                    f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                    set_braph2icon(f);
		                    return;
		                end
		                y_(tmp_index) = tmp_y; %#ok<AGROW>
		                tmp_index = tmp_index + 1;
		            end
		        else
		            tmp_index = 1;
		            for l = 1:length(plot_value)
		                tmp = plot_value{l};
		                tmp_y = tmp(pr.get('NODE1'), pr.get('NODE2'));
		                if isinf(tmp_y)
		                    f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                    set_braph2icon(f);
		                    return;
		                end
		                y_(tmp_index) = tmp_y; %#ok<AGROW>
		                tmp_index = tmp_index + 1;
		            end
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
