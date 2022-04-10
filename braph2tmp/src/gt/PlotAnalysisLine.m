classdef PlotAnalysisLine < Plot
	% PlotAnalysisLine is a line plot of the measure values.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% PlotAnalysisLine is the line plot of the measure values.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	%
	% The list of PlotAnalysisLine properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
	%  <strong>4</strong> <strong>graph</strong> 	GRAPH(data, item) to set plot line title.
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
	% PlotAnalysisLine methods (constructor):
	% PlotAnalysisLine - constructor
	%
	% PlotAnalysisLine methods (Static):
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
	% PlotAnalysisLine methods:
	%  plotline - sisLine/plotline is a function.
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
	% PlotAnalysisLine methods (operators):
	%  isequal - determines whether two PlotAnalysisLine are equal (values, locked)
	%
	% PlotAnalysisLine methods (display):
	%  tostring - string with information about the PlotAnalysisLine
	%  disp - displays information about the PlotAnalysisLine
	%  tree - displays the element of PlotAnalysisLine
	%
	% PlotAnalysisLine method (element list):
	%  getElementList - returns a list with all subelements of PlotAnalysisLine
	%
	% PlotAnalysisLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotAnalysisLine
	%
	% PlotAnalysisLine method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotAnalysisLine
	%
	% PlotAnalysisLine methods (copy):
	%  copy - copies the PlotAnalysisLine
	%  deepclone - deep-clones the PlotAnalysisLine
	%  clone - clones the PlotAnalysisLine
	%
	% PlotAnalysisLine methods (inspection, Static):
	%  getClass - returns PlotAnalysisLine
	%  getName - returns the name of PlotAnalysisLine
	%  getDescription - returns the description of PlotAnalysisLine
	%  getProps - returns the property list of PlotAnalysisLine
	%  getPropNumber - returns the property number of PlotAnalysisLine
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
	% PlotAnalysisLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotAnalysisLine methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotAnalysisLine methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotAnalysisLine methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotAnalysisLine properties (Constant).
	%  PLOTTITLE - 3
	%  PLOTTITLE_TAG - 'plottitle'
	%  PLOTTITLE_CATEGORY - 'm'
	%  PLOTTITLE_FORMAT - 'st'
	%  GRAPH - 4
	%  GRAPH_TAG - 'graph'
	%  GRAPH_CATEGORY - 'd'
	%  GRAPH_FORMAT - 'it'
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
		
		GRAPH = Plot.getPropNumber() + 2;
		GRAPH_TAG = 'graph';
		GRAPH_CATEGORY = Category.DATA;
		GRAPH_FORMAT = Format.ITEM;
		
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
			% CLASS = PlotAnalysisLine.GETCLASS() returns the class 'PlotAnalysisLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotAnalysisLine') returns 'PlotAnalysisLine'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotAnalysisLine';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot graph.
			%
			% NAME = PlotAnalysisLine.GETNAME() returns the name of the 'plot graph'.
			%  Plot Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotAnalysisLine') returns the name of 'PlotAnalysisLine'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot graph.
			%
			% STR = PlotAnalysisLine.GETDESCRIPTION() returns the description of the 'plot graph'.
			%  which is:
			%
			%  PlotAnalysisLine is the line plot of the measure values.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotAnalysisLine') returns the description of 'PlotAnalysisLine'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'PlotAnalysisLine is the line plot of the measure values.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot graph.
			%
			% PROPS = PlotAnalysisLine.GETPROPS() returns the property list of plot graph.
			%
			% PROPS = PlotAnalysisLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotAnalysisLine'[, CATEGORY]) returns the property list of 'PlotAnalysisLine'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotAnalysisLine.PLOTTITLE
						PlotAnalysisLine.XLABEL
						PlotAnalysisLine.YLABEL
						PlotAnalysisLine.CIL
						PlotAnalysisLine.CIU
						PlotAnalysisLine.NODE1
						PlotAnalysisLine.NODE2
						PlotAnalysisLine.COLOR
						PlotAnalysisLine.LINESTYLE
						PlotAnalysisLine.LINEWIDTH
						PlotAnalysisLine.MARKER
						PlotAnalysisLine.MARKERSIZE
						PlotAnalysisLine.MARKEREDGECOLOR
						PlotAnalysisLine.MARKERFACECOLOR
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotAnalysisLine.GRAPH
						PlotAnalysisLine.X
						PlotAnalysisLine.PLOTVALUE
						PlotAnalysisLine.MEASURE
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
						PlotAnalysisLine.PLOTTITLE
						PlotAnalysisLine.GRAPH
						PlotAnalysisLine.X
						PlotAnalysisLine.XLABEL
						PlotAnalysisLine.YLABEL
						PlotAnalysisLine.PLOTVALUE
						PlotAnalysisLine.MEASURE
						PlotAnalysisLine.CIL
						PlotAnalysisLine.CIU
						PlotAnalysisLine.NODE1
						PlotAnalysisLine.NODE2
						PlotAnalysisLine.COLOR
						PlotAnalysisLine.LINESTYLE
						PlotAnalysisLine.LINEWIDTH
						PlotAnalysisLine.MARKER
						PlotAnalysisLine.MARKERSIZE
						PlotAnalysisLine.MARKEREDGECOLOR
						PlotAnalysisLine.MARKERFACECOLOR
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot graph.
			%
			% N = PlotAnalysisLine.GETPROPNUMBER() returns the property number of plot graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotAnalysisLine') returns the property number of 'PlotAnalysisLine'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 20;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot graph/error.
			%
			% CHECK = PlotAnalysisLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotAnalysisLine, PROP) checks whether PROP exists for PlotAnalysisLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  Element.EXISTSPROP(PlotAnalysisLine, PROP) throws error if PROP does NOT exist for PlotAnalysisLine.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 ]);
			else
				assert( ...
					PlotAnalysisLine.existsProp(prop), ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotAnalysisLine.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot graph/error.
			%
			% CHECK = PlotAnalysisLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotAnalysisLine, TAG) checks whether TAG exists for PlotAnalysisLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  Element.EXISTSTAG(PlotAnalysisLine, TAG) throws error if TAG does NOT exist for PlotAnalysisLine.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotanalysisline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'graph'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				check = any(strcmpi(tag, plotanalysisline_tag_list));
			else
				assert( ...
					PlotAnalysisLine.existsTag(tag), ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotAnalysisLine'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotAnalysisLine, POINTER) returns property number of POINTER of PlotAnalysisLine.
			%  PROPERTY = PR.GETPROPPROP(PlotAnalysisLine, POINTER) returns property number of POINTER of PlotAnalysisLine.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotanalysisline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'graph'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'cil'  'ciu'  'node1'  'node2'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor' };
				
				tag = pointer;
				PlotAnalysisLine.existsTag(tag);
				
				prop = find(strcmpi(tag, plotanalysisline_tag_list));
			else % numeric
				prop = pointer;
				PlotAnalysisLine.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotAnalysisLine, POINTER) returns tag of POINTER of PlotAnalysisLine.
			%  TAG = PR.GETPROPTAG(PlotAnalysisLine, POINTER) returns tag of POINTER of PlotAnalysisLine.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotAnalysisLine.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotAnalysisLine.existsProp(prop);
				
				switch prop
					case PlotAnalysisLine.PLOTTITLE
						tag = PlotAnalysisLine.PLOTTITLE_TAG;
					case PlotAnalysisLine.GRAPH
						tag = PlotAnalysisLine.GRAPH_TAG;
					case PlotAnalysisLine.X
						tag = PlotAnalysisLine.X_TAG;
					case PlotAnalysisLine.XLABEL
						tag = PlotAnalysisLine.XLABEL_TAG;
					case PlotAnalysisLine.YLABEL
						tag = PlotAnalysisLine.YLABEL_TAG;
					case PlotAnalysisLine.PLOTVALUE
						tag = PlotAnalysisLine.PLOTVALUE_TAG;
					case PlotAnalysisLine.MEASURE
						tag = PlotAnalysisLine.MEASURE_TAG;
					case PlotAnalysisLine.CIL
						tag = PlotAnalysisLine.CIL_TAG;
					case PlotAnalysisLine.CIU
						tag = PlotAnalysisLine.CIU_TAG;
					case PlotAnalysisLine.NODE1
						tag = PlotAnalysisLine.NODE1_TAG;
					case PlotAnalysisLine.NODE2
						tag = PlotAnalysisLine.NODE2_TAG;
					case PlotAnalysisLine.COLOR
						tag = PlotAnalysisLine.COLOR_TAG;
					case PlotAnalysisLine.LINESTYLE
						tag = PlotAnalysisLine.LINESTYLE_TAG;
					case PlotAnalysisLine.LINEWIDTH
						tag = PlotAnalysisLine.LINEWIDTH_TAG;
					case PlotAnalysisLine.MARKER
						tag = PlotAnalysisLine.MARKER_TAG;
					case PlotAnalysisLine.MARKERSIZE
						tag = PlotAnalysisLine.MARKERSIZE_TAG;
					case PlotAnalysisLine.MARKEREDGECOLOR
						tag = PlotAnalysisLine.MARKEREDGECOLOR_TAG;
					case PlotAnalysisLine.MARKERFACECOLOR
						tag = PlotAnalysisLine.MARKERFACECOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotAnalysisLine, POINTER) returns category of POINTER of PlotAnalysisLine.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotAnalysisLine, POINTER) returns category of POINTER of PlotAnalysisLine.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					prop_category = PlotAnalysisLine.PLOTTITLE_CATEGORY;
				case PlotAnalysisLine.GRAPH
					prop_category = PlotAnalysisLine.GRAPH_CATEGORY;
				case PlotAnalysisLine.X
					prop_category = PlotAnalysisLine.X_CATEGORY;
				case PlotAnalysisLine.XLABEL
					prop_category = PlotAnalysisLine.XLABEL_CATEGORY;
				case PlotAnalysisLine.YLABEL
					prop_category = PlotAnalysisLine.YLABEL_CATEGORY;
				case PlotAnalysisLine.PLOTVALUE
					prop_category = PlotAnalysisLine.PLOTVALUE_CATEGORY;
				case PlotAnalysisLine.MEASURE
					prop_category = PlotAnalysisLine.MEASURE_CATEGORY;
				case PlotAnalysisLine.CIL
					prop_category = PlotAnalysisLine.CIL_CATEGORY;
				case PlotAnalysisLine.CIU
					prop_category = PlotAnalysisLine.CIU_CATEGORY;
				case PlotAnalysisLine.NODE1
					prop_category = PlotAnalysisLine.NODE1_CATEGORY;
				case PlotAnalysisLine.NODE2
					prop_category = PlotAnalysisLine.NODE2_CATEGORY;
				case PlotAnalysisLine.COLOR
					prop_category = PlotAnalysisLine.COLOR_CATEGORY;
				case PlotAnalysisLine.LINESTYLE
					prop_category = PlotAnalysisLine.LINESTYLE_CATEGORY;
				case PlotAnalysisLine.LINEWIDTH
					prop_category = PlotAnalysisLine.LINEWIDTH_CATEGORY;
				case PlotAnalysisLine.MARKER
					prop_category = PlotAnalysisLine.MARKER_CATEGORY;
				case PlotAnalysisLine.MARKERSIZE
					prop_category = PlotAnalysisLine.MARKERSIZE_CATEGORY;
				case PlotAnalysisLine.MARKEREDGECOLOR
					prop_category = PlotAnalysisLine.MARKEREDGECOLOR_CATEGORY;
				case PlotAnalysisLine.MARKERFACECOLOR
					prop_category = PlotAnalysisLine.MARKERFACECOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotAnalysisLine, POINTER) returns format of POINTER of PlotAnalysisLine.
			%  FORMAT = PR.GETPROPFORMAT(PlotAnalysisLine, POINTER) returns format of POINTER of PlotAnalysisLine.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					prop_format = PlotAnalysisLine.PLOTTITLE_FORMAT;
				case PlotAnalysisLine.GRAPH
					prop_format = PlotAnalysisLine.GRAPH_FORMAT;
				case PlotAnalysisLine.X
					prop_format = PlotAnalysisLine.X_FORMAT;
				case PlotAnalysisLine.XLABEL
					prop_format = PlotAnalysisLine.XLABEL_FORMAT;
				case PlotAnalysisLine.YLABEL
					prop_format = PlotAnalysisLine.YLABEL_FORMAT;
				case PlotAnalysisLine.PLOTVALUE
					prop_format = PlotAnalysisLine.PLOTVALUE_FORMAT;
				case PlotAnalysisLine.MEASURE
					prop_format = PlotAnalysisLine.MEASURE_FORMAT;
				case PlotAnalysisLine.CIL
					prop_format = PlotAnalysisLine.CIL_FORMAT;
				case PlotAnalysisLine.CIU
					prop_format = PlotAnalysisLine.CIU_FORMAT;
				case PlotAnalysisLine.NODE1
					prop_format = PlotAnalysisLine.NODE1_FORMAT;
				case PlotAnalysisLine.NODE2
					prop_format = PlotAnalysisLine.NODE2_FORMAT;
				case PlotAnalysisLine.COLOR
					prop_format = PlotAnalysisLine.COLOR_FORMAT;
				case PlotAnalysisLine.LINESTYLE
					prop_format = PlotAnalysisLine.LINESTYLE_FORMAT;
				case PlotAnalysisLine.LINEWIDTH
					prop_format = PlotAnalysisLine.LINEWIDTH_FORMAT;
				case PlotAnalysisLine.MARKER
					prop_format = PlotAnalysisLine.MARKER_FORMAT;
				case PlotAnalysisLine.MARKERSIZE
					prop_format = PlotAnalysisLine.MARKERSIZE_FORMAT;
				case PlotAnalysisLine.MARKEREDGECOLOR
					prop_format = PlotAnalysisLine.MARKEREDGECOLOR_FORMAT;
				case PlotAnalysisLine.MARKERFACECOLOR
					prop_format = PlotAnalysisLine.MARKERFACECOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotAnalysisLine, POINTER) returns description of POINTER of PlotAnalysisLine.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotAnalysisLine, POINTER) returns description of POINTER of PlotAnalysisLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					prop_description = 'PLOTTITLE(metadata, string) to set plot line title.';
				case PlotAnalysisLine.GRAPH
					prop_description = 'GRAPH(data, item) to set plot line title.';
				case PlotAnalysisLine.X
					prop_description = 'X(data, rvector) to set plot line graph x range.';
				case PlotAnalysisLine.XLABEL
					prop_description = 'XLABEL(metadata, string) to set plot line x label.';
				case PlotAnalysisLine.YLABEL
					prop_description = 'YLABEL(metadata, string) to set plot line y label.';
				case PlotAnalysisLine.PLOTVALUE
					prop_description = 'PLOTVALUE(data, cell) to set plot line atlas.';
				case PlotAnalysisLine.MEASURE
					prop_description = 'MEASURE(data, string) to set plot line measure.';
				case PlotAnalysisLine.CIL
					prop_description = 'CIL (metadata, CELL) to set plot line cil.';
				case PlotAnalysisLine.CIU
					prop_description = 'CIU (metadata, CELL) to set plot line ciu.';
				case PlotAnalysisLine.NODE1
					prop_description = 'NODE1 (metadata, scalar) to set plot line node 1.';
				case PlotAnalysisLine.NODE2
					prop_description = 'NODE2 (metadata, scalar) to set plot line node 2.';
				case PlotAnalysisLine.COLOR
					prop_description = 'COLOR (metadata, rvector) to set plot line color.';
				case PlotAnalysisLine.LINESTYLE
					prop_description = 'LINESTYLE (metadata, string) to set plot line style.';
				case PlotAnalysisLine.LINEWIDTH
					prop_description = 'LINEWIDTH (metadata, scalar) to set plot line width.';
				case PlotAnalysisLine.MARKER
					prop_description = 'MARKER (metadata, string) to set plot marker style.';
				case PlotAnalysisLine.MARKERSIZE
					prop_description = 'MARKERSIZE (metadata, scalar) to set plot marker size.';
				case PlotAnalysisLine.MARKEREDGECOLOR
					prop_description = 'MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color.';
				case PlotAnalysisLine.MARKERFACECOLOR
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotAnalysisLine, POINTER) returns settings of POINTER of PlotAnalysisLine.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotAnalysisLine, POINTER) returns settings of POINTER of PlotAnalysisLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.GRAPH
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotAnalysisLine.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotAnalysisLine.XLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.YLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.PLOTVALUE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotAnalysisLine.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotAnalysisLine.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotAnalysisLine.NODE1
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotAnalysisLine.NODE2
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotAnalysisLine.COLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotAnalysisLine.LINESTYLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotAnalysisLine.MARKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotAnalysisLine.MARKERSIZE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotAnalysisLine.MARKEREDGECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotAnalysisLine.MARKERFACECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotAnalysisLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotAnalysisLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotAnalysisLine, POINTER) returns the default value of POINTER of PlotAnalysisLine.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotAnalysisLine, POINTER) returns the default value of POINTER of PlotAnalysisLine.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					prop_default = Format.getFormatDefault(Format.STRING, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.GRAPH
					prop_default = Format.getFormatDefault(Format.ITEM, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.XLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.YLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.PLOTVALUE
					prop_default = Format.getFormatDefault(Format.CELL, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.CIL
					prop_default = Format.getFormatDefault(Format.CELL, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.CIU
					prop_default = Format.getFormatDefault(Format.CELL, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.NODE1
					prop_default = 1;
				case PlotAnalysisLine.NODE2
					prop_default = 2;
				case PlotAnalysisLine.COLOR
					prop_default = [0 0 0];
				case PlotAnalysisLine.LINESTYLE
					prop_default = '-';
				case PlotAnalysisLine.LINEWIDTH
					prop_default = 0.5;
				case PlotAnalysisLine.MARKER
					prop_default = 'none';
				case PlotAnalysisLine.MARKERSIZE
					prop_default = 6;
				case PlotAnalysisLine.MARKEREDGECOLOR
					prop_default = [0 0 0];
				case PlotAnalysisLine.MARKERFACECOLOR
					prop_default = [0 0 0];
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotAnalysisLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotAnalysisLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotAnalysisLine, POINTER) returns the conditioned default value of POINTER of PlotAnalysisLine.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotAnalysisLine, POINTER) returns the conditioned default value of POINTER of PlotAnalysisLine.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			prop_default = PlotAnalysisLine.conditioning(prop, PlotAnalysisLine.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotAnalysisLine, PROP, VALUE) checks VALUE format for PROP of PlotAnalysisLine.
			%  CHECK = PR.CHECKPROP(PlotAnalysisLine, PROP, VALUE) checks VALUE format for PROP of PlotAnalysisLine.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  Element.CHECKPROP(PlotAnalysisLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotAnalysisLine.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			%  PR.CHECKPROP(PlotAnalysisLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotAnalysisLine.
			%   Error id: [BRAPH2:PlotAnalysisLine:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotAnalysisLine.getPropProp(pointer);
			
			switch prop
				case PlotAnalysisLine.PLOTTITLE
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.GRAPH
					check = Format.checkFormat(Format.ITEM, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.X
					check = Format.checkFormat(Format.RVECTOR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.XLABEL
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.YLABEL
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.PLOTVALUE
					check = Format.checkFormat(Format.CELL, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MEASURE
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.CIL
					check = Format.checkFormat(Format.CELL, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.CIU
					check = Format.checkFormat(Format.CELL, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.NODE1
					check = Format.checkFormat(Format.SCALAR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.NODE2
					check = Format.checkFormat(Format.SCALAR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.COLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.LINESTYLE
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.LINEWIDTH
					check = Format.checkFormat(Format.SCALAR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MARKER
					check = Format.checkFormat(Format.STRING, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MARKERSIZE
					check = Format.checkFormat(Format.SCALAR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MARKEREDGECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotAnalysisLine.getPropSettings(prop));
				case PlotAnalysisLine.MARKERFACECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotAnalysisLine.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotAnalysisLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotAnalysisLine.getPropTag(prop) ' (' PlotAnalysisLine.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotAnalysisLine(varargin)
			% PlotAnalysisLine() creates a plot graph.
			%
			% PlotAnalysisLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotAnalysisLine(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotAnalysisLine properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title.
			%  <strong>4</strong> <strong>graph</strong> 	GRAPH(data, item) to set plot line title.
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
			prop = PlotAnalysisLine.getPropProp(pointer);
			
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
		    graph = pr.get('GRAPH');
		    measure_dict = graph.get('M_DICT');
		    pr.m = measure_dict.getItem(1); % it has at least 1 measure
		    measure_list = measure_dict.getKeys();
		    atlas = graph.get('BRAINATLAS');
		    node_labels = cellfun(@(x) x.get('ID') , atlas.get('BR_DICT').getItems(), 'UniformOutput', false);
		
		    ui_plot_properties_panel = uipanel(pr.h_settings, ...
		        'Units', 'normalized', ...
		        'BackgroundColor', [1 .9725 .929], ...
		        'Position', [0 0 1 1]);
		    
		    measure_panel = uipanel(ui_plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .85 .98 .14] ...
		        );
		
		    % line properties
		    measure_list_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'Measure', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .01 .1 .9]);
		    measure_list_popup = uicontrol(measure_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.11 .1 .1 .8], ...
		        'String', measure_list, ...
		        'TooltipString', 'Plot Line Style', ...
		        'Callback', {@cb_measure_selection} ...
		        );
		
		        function cb_measure_selection(~,~)
		            val = measure_list_popup.Value;
		            str = measure_list_popup.String;
		            pr.m = measure_dict.getItem(val);
		            pr.set('YLABEL', pr.m.get('ID'))
		            rules_node_popmenu_deactivation()
		            pr.update_plot()
		        end
		
		    node_1_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'Brain Region 1', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.22 .01 .1 0.9]);
		    node_2_id = uicontrol(measure_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
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
		                'Position', [.33 .1 .1 .8], ...
		                'Callback', {@cb_node_1} ...
		                );
		            set(ui_node2_popmenu, ...
		                'Units', 'normalized', ...
		                'Tooltip', 'Select the Node to be Plotted.', ...
		                'String', node_labels, ...
		                'Value', pr.get('NODE2'), ...
		                'Position', [.55 .1 .1 .8], ...
		                'Callback', {@cb_node_2} ...
		                );
		            rules_node_popmenu_deactivation()
		        end
		        function rules_node_popmenu_deactivation()
		            if Measure.is_global(pr.m)
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
		
		            elseif Measure.is_nodal(pr.m)
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
		        ui_confidence_interval_min_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized', 'BackgroundColor', pr.h_settings.Color);
		        ui_confidence_interval_max_checkbox = uicontrol('Parent', ui_plot_properties_panel, 'Style', 'checkbox', 'Units', 'normalized', 'BackgroundColor', pr.h_settings.Color);
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
		
		            if Measure.is_global(pr.m) % global
		                is_inf_vector = cellfun(@(x) isinf(x), array);
		                if any(is_inf_vector)
		                    return;
		                end
		                limit = [array{:}];
		            elseif Measure.is_nodal(pr.m) % nodal
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
		    
		     plot_style_panel = uipanel(ui_plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .01 .32 .84] ...
		        );
		
		    line_style_id = uicontrol(plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'Line Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .72 .32 .1]);
		
		    ui_line_style = uicontrol(ui_plot_properties_panel, ...
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
		        'HorizontalAlignment', 'left', ...
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
		        'HorizontalAlignment', 'left', ...
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
		        'HorizontalAlignment', 'left', ...
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
		        'HorizontalAlignment', 'left', ...
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
		        'HorizontalAlignment', 'left', ...
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
		        'HorizontalAlignment', 'left', ...
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
		    cb_measure_selection()
		
		    if nargin > 0
		        f_settings = pr.h_settings;
		    end
		end
		function update_plot(pr)
		    measure = pr.m;
		    plot_value = measure.get('M');
		    if Measure.is_global(pr.m) % global
		        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		        if any(is_inf_vector)
		            f = warndlg('The measure cannot be plotted because it contains Inf values.');
		            set_braph2icon(f);
		            return;
		        end
		        y_ = [plot_value{:}];
		    elseif Measure.is_nodal(pr.m) % nodal
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
