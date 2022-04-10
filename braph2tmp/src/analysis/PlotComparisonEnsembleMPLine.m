classdef PlotComparisonEnsembleMPLine < Plot
	% PlotComparisonEnsembleMPLine is a line plot of the comparison ensemble values.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% Plot is the line plot of the comparison ensembles values.
	% It is a graphical figure with empty axes, which should be filled by derived element.
	% To generate the plot, call pr.draw().
	%
	% The list of PlotComparisonEnsembleMPLine properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title
	%  <strong>4</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range
	%  <strong>5</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label
	%  <strong>6</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label
	%  <strong>7</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas
	%  <strong>8</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure
	%  <strong>9</strong> <strong>comparison</strong> 	COMPARISON(data, IDICT) to set the comparison dictionary
	%  <strong>10</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil
	%  <strong>11</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu
	%  <strong>12</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1
	%  <strong>13</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2
	%  <strong>14</strong> <strong>layer</strong> 	LAYER (metadata, scalar) to set plot line layer
	%  <strong>15</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color
	%  <strong>16</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style
	%  <strong>17</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width
	%  <strong>18</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style
	%  <strong>19</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size
	%  <strong>20</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color
	%  <strong>21</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color
	%  <strong>22</strong> <strong>fillcolor</strong> 	FILLCOLOR (metadata, rvector) to set plot patch face color
	%  <strong>23</strong> <strong>fillalpha</strong> 	FILLALPHA (metadata, scalar) to set plot patch face color alpha
	%  <strong>24</strong> <strong>cicolor</strong> 	CICOLOR (metadata, rvector) to set confidence interval plot line color
	%  <strong>25</strong> <strong>cilinestyle</strong> 	CILINESTYLE (metadata, string) to set confidence interval plot line style
	%  <strong>26</strong> <strong>cilinewidth</strong> 	CILINEWIDTH (metadata, scalar) to set confidence interval plot line width
	%
	% PlotComparisonEnsembleMPLine methods (constructor):
	% PlotComparisonEnsembleMPLine - constructor
	%
	% PlotComparisonEnsembleMPLine methods (Static):
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
	% PlotComparisonEnsembleMPLine methods:
	%  plotline - risonEnsembleMPLine/plotline is a function.
	%  update_plot - onEnsembleMPLine/update_plot is a function.
	%  settings - opens the property editor GUI.
	%  draw - draws the plot line.
	%  set_settings - nEnsembleMPLine/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - onEnsembleMPLine/cb_close_fs is a function.
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
	% PlotComparisonEnsembleMPLine methods (operators):
	%  isequal - determines whether two PlotComparisonEnsembleMPLine are equal (values, locked)
	%
	% PlotComparisonEnsembleMPLine methods (display):
	%  tostring - string with information about the PlotComparisonEnsembleMPLine
	%  disp - displays information about the PlotComparisonEnsembleMPLine
	%  tree - displays the element of PlotComparisonEnsembleMPLine
	%
	% PlotComparisonEnsembleMPLine method (element list):
	%  getElementList - returns a list with all subelements of PlotComparisonEnsembleMPLine
	%
	% PlotComparisonEnsembleMPLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotComparisonEnsembleMPLine
	%
	% PlotComparisonEnsembleMPLine method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotComparisonEnsembleMPLine
	%
	% PlotComparisonEnsembleMPLine methods (copy):
	%  copy - copies the PlotComparisonEnsembleMPLine
	%  deepclone - deep-clones the PlotComparisonEnsembleMPLine
	%  clone - clones the PlotComparisonEnsembleMPLine
	%
	% PlotComparisonEnsembleMPLine methods (inspection, Static):
	%  getClass - returns PlotComparisonEnsembleMPLine
	%  getName - returns the name of PlotComparisonEnsembleMPLine
	%  getDescription - returns the description of PlotComparisonEnsembleMPLine
	%  getProps - returns the property list of PlotComparisonEnsembleMPLine
	%  getPropNumber - returns the property number of PlotComparisonEnsembleMPLine
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
	% PlotComparisonEnsembleMPLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotComparisonEnsembleMPLine methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotComparisonEnsembleMPLine methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotComparisonEnsembleMPLine methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotComparisonEnsembleMPLine properties (Constant).
	%  PLOTTITLE - 3
	%  PLOTTITLE_TAG - 'plottitle'
	%  PLOTTITLE_CATEGORY - 'm'
	%  PLOTTITLE_FORMAT - 'st'
	%  X - 4
	%  X_TAG - 'x'
	%  X_CATEGORY - 'd'
	%  X_FORMAT - 'nr'
	%  XLABEL - 5
	%  XLABEL_TAG - 'xlabel'
	%  XLABEL_CATEGORY - 'm'
	%  XLABEL_FORMAT - 'st'
	%  YLABEL - 6
	%  YLABEL_TAG - 'ylabel'
	%  YLABEL_CATEGORY - 'm'
	%  YLABEL_FORMAT - 'st'
	%  PLOTVALUE - 7
	%  PLOTVALUE_TAG - 'plotvalue'
	%  PLOTVALUE_CATEGORY - 'd'
	%  PLOTVALUE_FORMAT - 'll'
	%  MEASURE - 8
	%  MEASURE_TAG - 'measure'
	%  MEASURE_CATEGORY - 'd'
	%  MEASURE_FORMAT - 'st'
	%  COMPARISON - 9
	%  COMPARISON_TAG - 'comparison'
	%  COMPARISON_CATEGORY - 'd'
	%  COMPARISON_FORMAT - 'di'
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
	%  LAYER - 14
	%  LAYER_TAG - 'layer'
	%  LAYER_CATEGORY - 'm'
	%  LAYER_FORMAT - 'nn'
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
	%  FILLCOLOR - 22
	%  FILLCOLOR_TAG - 'fillcolor'
	%  FILLCOLOR_CATEGORY - 'm'
	%  FILLCOLOR_FORMAT - 'nr'
	%  FILLALPHA - 23
	%  FILLALPHA_TAG - 'fillalpha'
	%  FILLALPHA_CATEGORY - 'm'
	%  FILLALPHA_FORMAT - 'nn'
	%  CICOLOR - 24
	%  CICOLOR_TAG - 'cicolor'
	%  CICOLOR_CATEGORY - 'm'
	%  CICOLOR_FORMAT - 'nr'
	%  CILINESTYLE - 25
	%  CILINESTYLE_TAG - 'cilinestyle'
	%  CILINESTYLE_CATEGORY - 'm'
	%  CILINESTYLE_FORMAT - 'st'
	%  CILINEWIDTH - 26
	%  CILINEWIDTH_TAG - 'cilinewidth'
	%  CILINEWIDTH_CATEGORY - 'm'
	%  CILINEWIDTH_FORMAT - 'nn'
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
		cp % measure
	end
	properties (Constant) % properties
		PLOTTITLE = Plot.getPropNumber() + 1;
		PLOTTITLE_TAG = 'plottitle';
		PLOTTITLE_CATEGORY = Category.METADATA;
		PLOTTITLE_FORMAT = Format.STRING;
		
		X = Plot.getPropNumber() + 2;
		X_TAG = 'x';
		X_CATEGORY = Category.DATA;
		X_FORMAT = Format.RVECTOR;
		
		XLABEL = Plot.getPropNumber() + 3;
		XLABEL_TAG = 'xlabel';
		XLABEL_CATEGORY = Category.METADATA;
		XLABEL_FORMAT = Format.STRING;
		
		YLABEL = Plot.getPropNumber() + 4;
		YLABEL_TAG = 'ylabel';
		YLABEL_CATEGORY = Category.METADATA;
		YLABEL_FORMAT = Format.STRING;
		
		PLOTVALUE = Plot.getPropNumber() + 5;
		PLOTVALUE_TAG = 'plotvalue';
		PLOTVALUE_CATEGORY = Category.DATA;
		PLOTVALUE_FORMAT = Format.CELL;
		
		MEASURE = Plot.getPropNumber() + 6;
		MEASURE_TAG = 'measure';
		MEASURE_CATEGORY = Category.DATA;
		MEASURE_FORMAT = Format.STRING;
		
		COMPARISON = Plot.getPropNumber() + 7;
		COMPARISON_TAG = 'comparison';
		COMPARISON_CATEGORY = Category.DATA;
		COMPARISON_FORMAT = Format.IDICT;
		
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
		
		LAYER = Plot.getPropNumber() + 12;
		LAYER_TAG = 'layer';
		LAYER_CATEGORY = Category.METADATA;
		LAYER_FORMAT = Format.SCALAR;
		
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
		
		FILLCOLOR = Plot.getPropNumber() + 20;
		FILLCOLOR_TAG = 'fillcolor';
		FILLCOLOR_CATEGORY = Category.METADATA;
		FILLCOLOR_FORMAT = Format.RVECTOR;
		
		FILLALPHA = Plot.getPropNumber() + 21;
		FILLALPHA_TAG = 'fillalpha';
		FILLALPHA_CATEGORY = Category.METADATA;
		FILLALPHA_FORMAT = Format.SCALAR;
		
		CICOLOR = Plot.getPropNumber() + 22;
		CICOLOR_TAG = 'cicolor';
		CICOLOR_CATEGORY = Category.METADATA;
		CICOLOR_FORMAT = Format.RVECTOR;
		
		CILINESTYLE = Plot.getPropNumber() + 23;
		CILINESTYLE_TAG = 'cilinestyle';
		CILINESTYLE_CATEGORY = Category.METADATA;
		CILINESTYLE_FORMAT = Format.STRING;
		
		CILINEWIDTH = Plot.getPropNumber() + 24;
		CILINEWIDTH_TAG = 'cilinewidth';
		CILINEWIDTH_CATEGORY = Category.METADATA;
		CILINEWIDTH_FORMAT = Format.SCALAR;
	end
	methods (Static) % inspection methods
		function pr_class = getClass()
			%GETCLASS returns the class of the plot graph.
			%
			% CLASS = PlotComparisonEnsembleMPLine.GETCLASS() returns the class 'PlotComparisonEnsembleMPLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the plot graph PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PlotComparisonEnsembleMPLine') returns 'PlotComparisonEnsembleMPLine'.
			%
			% See also getName, getDescription.
			
			pr_class = 'PlotComparisonEnsembleMPLine';
		end
		function pr_name = getName()
			%GETNAME returns the name of the plot graph.
			%
			% NAME = PlotComparisonEnsembleMPLine.GETNAME() returns the name of the 'plot graph'.
			%  Plot Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = PR.GETNAME() returns the name of the plot graph PR.
			%  NAME = Element.GETNAME(PR) returns the name of 'PR'.
			%  NAME = Element.GETNAME('PlotComparisonEnsembleMPLine') returns the name of 'PlotComparisonEnsembleMPLine'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pr_name = 'Plot Graph';
		end
		function pr_description = getDescription()
			%GETDESCRIPTION returns the description of the plot graph.
			%
			% STR = PlotComparisonEnsembleMPLine.GETDESCRIPTION() returns the description of the 'plot graph'.
			%  which is:
			%
			%  Plot is the line plot of the comparison ensembles values.
			%  It is a graphical figure with empty axes, which should be filled by derived element.
			%  To generate the plot, call pr.draw().
			%
			% Alternative forms to call this method are:
			%  STR = PR.GETDESCRIPTION() returns the description of the plot graph PR.
			%  STR = Element.GETDESCRIPTION(PR) returns the description of 'PR'.
			%  STR = Element.GETDESCRIPTION('PlotComparisonEnsembleMPLine') returns the description of 'PlotComparisonEnsembleMPLine'.
			%
			% See also getClass, getName.
			
			pr_description = [
				'Plot is the line plot of the comparison ensembles values.' ...
				'It is a graphical figure with empty axes, which should be filled by derived element.' ...
				'To generate the plot, call pr.draw().' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot graph.
			%
			% PROPS = PlotComparisonEnsembleMPLine.GETPROPS() returns the property list of plot graph.
			%
			% PROPS = PlotComparisonEnsembleMPLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the plot graph PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PlotComparisonEnsembleMPLine'[, CATEGORY]) returns the property list of 'PlotComparisonEnsembleMPLine'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotComparisonEnsembleMPLine.PLOTTITLE
						PlotComparisonEnsembleMPLine.XLABEL
						PlotComparisonEnsembleMPLine.YLABEL
						PlotComparisonEnsembleMPLine.CIL
						PlotComparisonEnsembleMPLine.CIU
						PlotComparisonEnsembleMPLine.NODE1
						PlotComparisonEnsembleMPLine.NODE2
						PlotComparisonEnsembleMPLine.LAYER
						PlotComparisonEnsembleMPLine.COLOR
						PlotComparisonEnsembleMPLine.LINESTYLE
						PlotComparisonEnsembleMPLine.LINEWIDTH
						PlotComparisonEnsembleMPLine.MARKER
						PlotComparisonEnsembleMPLine.MARKERSIZE
						PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
						PlotComparisonEnsembleMPLine.MARKERFACECOLOR
						PlotComparisonEnsembleMPLine.FILLCOLOR
						PlotComparisonEnsembleMPLine.FILLALPHA
						PlotComparisonEnsembleMPLine.CICOLOR
						PlotComparisonEnsembleMPLine.CILINESTYLE
						PlotComparisonEnsembleMPLine.CILINEWIDTH
						];
				case Category.PARAMETER
					prop_list = [
						Plot.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						Plot.getProps(Category.DATA)
						PlotComparisonEnsembleMPLine.X
						PlotComparisonEnsembleMPLine.PLOTVALUE
						PlotComparisonEnsembleMPLine.MEASURE
						PlotComparisonEnsembleMPLine.COMPARISON
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
						PlotComparisonEnsembleMPLine.PLOTTITLE
						PlotComparisonEnsembleMPLine.X
						PlotComparisonEnsembleMPLine.XLABEL
						PlotComparisonEnsembleMPLine.YLABEL
						PlotComparisonEnsembleMPLine.PLOTVALUE
						PlotComparisonEnsembleMPLine.MEASURE
						PlotComparisonEnsembleMPLine.COMPARISON
						PlotComparisonEnsembleMPLine.CIL
						PlotComparisonEnsembleMPLine.CIU
						PlotComparisonEnsembleMPLine.NODE1
						PlotComparisonEnsembleMPLine.NODE2
						PlotComparisonEnsembleMPLine.LAYER
						PlotComparisonEnsembleMPLine.COLOR
						PlotComparisonEnsembleMPLine.LINESTYLE
						PlotComparisonEnsembleMPLine.LINEWIDTH
						PlotComparisonEnsembleMPLine.MARKER
						PlotComparisonEnsembleMPLine.MARKERSIZE
						PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
						PlotComparisonEnsembleMPLine.MARKERFACECOLOR
						PlotComparisonEnsembleMPLine.FILLCOLOR
						PlotComparisonEnsembleMPLine.FILLALPHA
						PlotComparisonEnsembleMPLine.CICOLOR
						PlotComparisonEnsembleMPLine.CILINESTYLE
						PlotComparisonEnsembleMPLine.CILINEWIDTH
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot graph.
			%
			% N = PlotComparisonEnsembleMPLine.GETPROPNUMBER() returns the property number of plot graph.
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER() returns the property number of the plot graph PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PlotComparisonEnsembleMPLine') returns the property number of 'PlotComparisonEnsembleMPLine'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 26;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot graph/error.
			%
			% CHECK = PlotComparisonEnsembleMPLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PlotComparisonEnsembleMPLine, PROP) checks whether PROP exists for PlotComparisonEnsembleMPLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  Element.EXISTSPROP(PlotComparisonEnsembleMPLine, PROP) throws error if PROP does NOT exist for PlotComparisonEnsembleMPLine.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 ]);
			else
				assert( ...
					PlotComparisonEnsembleMPLine.existsProp(prop), ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotComparisonEnsembleMPLine.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot graph/error.
			%
			% CHECK = PlotComparisonEnsembleMPLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PlotComparisonEnsembleMPLine, TAG) checks whether TAG exists for PlotComparisonEnsembleMPLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  Element.EXISTSTAG(PlotComparisonEnsembleMPLine, TAG) throws error if TAG does NOT exist for PlotComparisonEnsembleMPLine.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotcomparisonensemblempline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'comparison'  'cil'  'ciu'  'node1'  'node2'  'layer'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor'  'fillcolor'  'fillalpha'  'cicolor'  'cilinestyle'  'cilinewidth' };
				
				check = any(strcmpi(tag, plotcomparisonensemblempline_tag_list));
			else
				assert( ...
					PlotComparisonEnsembleMPLine.existsTag(tag), ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotComparisonEnsembleMPLine'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotComparisonEnsembleMPLine, POINTER) returns property number of POINTER of PlotComparisonEnsembleMPLine.
			%  PROPERTY = PR.GETPROPPROP(PlotComparisonEnsembleMPLine, POINTER) returns property number of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotcomparisonensemblempline_tag_list = { 'id'  'bkgcolor'  'plottitle'  'x'  'xlabel'  'ylabel'  'plotvalue'  'measure'  'comparison'  'cil'  'ciu'  'node1'  'node2'  'layer'  'color'  'linestyle'  'linewidth'  'marker'  'markersize'  'markeredgecolor'  'markerfacecolor'  'fillcolor'  'fillalpha'  'cicolor'  'cilinestyle'  'cilinewidth' };
				
				tag = pointer;
				PlotComparisonEnsembleMPLine.existsTag(tag);
				
				prop = find(strcmpi(tag, plotcomparisonensemblempline_tag_list));
			else % numeric
				prop = pointer;
				PlotComparisonEnsembleMPLine.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotComparisonEnsembleMPLine, POINTER) returns tag of POINTER of PlotComparisonEnsembleMPLine.
			%  TAG = PR.GETPROPTAG(PlotComparisonEnsembleMPLine, POINTER) returns tag of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotComparisonEnsembleMPLine.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotComparisonEnsembleMPLine.existsProp(prop);
				
				switch prop
					case PlotComparisonEnsembleMPLine.PLOTTITLE
						tag = PlotComparisonEnsembleMPLine.PLOTTITLE_TAG;
					case PlotComparisonEnsembleMPLine.X
						tag = PlotComparisonEnsembleMPLine.X_TAG;
					case PlotComparisonEnsembleMPLine.XLABEL
						tag = PlotComparisonEnsembleMPLine.XLABEL_TAG;
					case PlotComparisonEnsembleMPLine.YLABEL
						tag = PlotComparisonEnsembleMPLine.YLABEL_TAG;
					case PlotComparisonEnsembleMPLine.PLOTVALUE
						tag = PlotComparisonEnsembleMPLine.PLOTVALUE_TAG;
					case PlotComparisonEnsembleMPLine.MEASURE
						tag = PlotComparisonEnsembleMPLine.MEASURE_TAG;
					case PlotComparisonEnsembleMPLine.COMPARISON
						tag = PlotComparisonEnsembleMPLine.COMPARISON_TAG;
					case PlotComparisonEnsembleMPLine.CIL
						tag = PlotComparisonEnsembleMPLine.CIL_TAG;
					case PlotComparisonEnsembleMPLine.CIU
						tag = PlotComparisonEnsembleMPLine.CIU_TAG;
					case PlotComparisonEnsembleMPLine.NODE1
						tag = PlotComparisonEnsembleMPLine.NODE1_TAG;
					case PlotComparisonEnsembleMPLine.NODE2
						tag = PlotComparisonEnsembleMPLine.NODE2_TAG;
					case PlotComparisonEnsembleMPLine.LAYER
						tag = PlotComparisonEnsembleMPLine.LAYER_TAG;
					case PlotComparisonEnsembleMPLine.COLOR
						tag = PlotComparisonEnsembleMPLine.COLOR_TAG;
					case PlotComparisonEnsembleMPLine.LINESTYLE
						tag = PlotComparisonEnsembleMPLine.LINESTYLE_TAG;
					case PlotComparisonEnsembleMPLine.LINEWIDTH
						tag = PlotComparisonEnsembleMPLine.LINEWIDTH_TAG;
					case PlotComparisonEnsembleMPLine.MARKER
						tag = PlotComparisonEnsembleMPLine.MARKER_TAG;
					case PlotComparisonEnsembleMPLine.MARKERSIZE
						tag = PlotComparisonEnsembleMPLine.MARKERSIZE_TAG;
					case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
						tag = PlotComparisonEnsembleMPLine.MARKEREDGECOLOR_TAG;
					case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
						tag = PlotComparisonEnsembleMPLine.MARKERFACECOLOR_TAG;
					case PlotComparisonEnsembleMPLine.FILLCOLOR
						tag = PlotComparisonEnsembleMPLine.FILLCOLOR_TAG;
					case PlotComparisonEnsembleMPLine.FILLALPHA
						tag = PlotComparisonEnsembleMPLine.FILLALPHA_TAG;
					case PlotComparisonEnsembleMPLine.CICOLOR
						tag = PlotComparisonEnsembleMPLine.CICOLOR_TAG;
					case PlotComparisonEnsembleMPLine.CILINESTYLE
						tag = PlotComparisonEnsembleMPLine.CILINESTYLE_TAG;
					case PlotComparisonEnsembleMPLine.CILINEWIDTH
						tag = PlotComparisonEnsembleMPLine.CILINEWIDTH_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotComparisonEnsembleMPLine, POINTER) returns category of POINTER of PlotComparisonEnsembleMPLine.
			%  CATEGORY = PR.GETPROPCATEGORY(PlotComparisonEnsembleMPLine, POINTER) returns category of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					prop_category = PlotComparisonEnsembleMPLine.PLOTTITLE_CATEGORY;
				case PlotComparisonEnsembleMPLine.X
					prop_category = PlotComparisonEnsembleMPLine.X_CATEGORY;
				case PlotComparisonEnsembleMPLine.XLABEL
					prop_category = PlotComparisonEnsembleMPLine.XLABEL_CATEGORY;
				case PlotComparisonEnsembleMPLine.YLABEL
					prop_category = PlotComparisonEnsembleMPLine.YLABEL_CATEGORY;
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					prop_category = PlotComparisonEnsembleMPLine.PLOTVALUE_CATEGORY;
				case PlotComparisonEnsembleMPLine.MEASURE
					prop_category = PlotComparisonEnsembleMPLine.MEASURE_CATEGORY;
				case PlotComparisonEnsembleMPLine.COMPARISON
					prop_category = PlotComparisonEnsembleMPLine.COMPARISON_CATEGORY;
				case PlotComparisonEnsembleMPLine.CIL
					prop_category = PlotComparisonEnsembleMPLine.CIL_CATEGORY;
				case PlotComparisonEnsembleMPLine.CIU
					prop_category = PlotComparisonEnsembleMPLine.CIU_CATEGORY;
				case PlotComparisonEnsembleMPLine.NODE1
					prop_category = PlotComparisonEnsembleMPLine.NODE1_CATEGORY;
				case PlotComparisonEnsembleMPLine.NODE2
					prop_category = PlotComparisonEnsembleMPLine.NODE2_CATEGORY;
				case PlotComparisonEnsembleMPLine.LAYER
					prop_category = PlotComparisonEnsembleMPLine.LAYER_CATEGORY;
				case PlotComparisonEnsembleMPLine.COLOR
					prop_category = PlotComparisonEnsembleMPLine.COLOR_CATEGORY;
				case PlotComparisonEnsembleMPLine.LINESTYLE
					prop_category = PlotComparisonEnsembleMPLine.LINESTYLE_CATEGORY;
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					prop_category = PlotComparisonEnsembleMPLine.LINEWIDTH_CATEGORY;
				case PlotComparisonEnsembleMPLine.MARKER
					prop_category = PlotComparisonEnsembleMPLine.MARKER_CATEGORY;
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					prop_category = PlotComparisonEnsembleMPLine.MARKERSIZE_CATEGORY;
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					prop_category = PlotComparisonEnsembleMPLine.MARKEREDGECOLOR_CATEGORY;
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					prop_category = PlotComparisonEnsembleMPLine.MARKERFACECOLOR_CATEGORY;
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					prop_category = PlotComparisonEnsembleMPLine.FILLCOLOR_CATEGORY;
				case PlotComparisonEnsembleMPLine.FILLALPHA
					prop_category = PlotComparisonEnsembleMPLine.FILLALPHA_CATEGORY;
				case PlotComparisonEnsembleMPLine.CICOLOR
					prop_category = PlotComparisonEnsembleMPLine.CICOLOR_CATEGORY;
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					prop_category = PlotComparisonEnsembleMPLine.CILINESTYLE_CATEGORY;
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					prop_category = PlotComparisonEnsembleMPLine.CILINEWIDTH_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PlotComparisonEnsembleMPLine, POINTER) returns format of POINTER of PlotComparisonEnsembleMPLine.
			%  FORMAT = PR.GETPROPFORMAT(PlotComparisonEnsembleMPLine, POINTER) returns format of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					prop_format = PlotComparisonEnsembleMPLine.PLOTTITLE_FORMAT;
				case PlotComparisonEnsembleMPLine.X
					prop_format = PlotComparisonEnsembleMPLine.X_FORMAT;
				case PlotComparisonEnsembleMPLine.XLABEL
					prop_format = PlotComparisonEnsembleMPLine.XLABEL_FORMAT;
				case PlotComparisonEnsembleMPLine.YLABEL
					prop_format = PlotComparisonEnsembleMPLine.YLABEL_FORMAT;
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					prop_format = PlotComparisonEnsembleMPLine.PLOTVALUE_FORMAT;
				case PlotComparisonEnsembleMPLine.MEASURE
					prop_format = PlotComparisonEnsembleMPLine.MEASURE_FORMAT;
				case PlotComparisonEnsembleMPLine.COMPARISON
					prop_format = PlotComparisonEnsembleMPLine.COMPARISON_FORMAT;
				case PlotComparisonEnsembleMPLine.CIL
					prop_format = PlotComparisonEnsembleMPLine.CIL_FORMAT;
				case PlotComparisonEnsembleMPLine.CIU
					prop_format = PlotComparisonEnsembleMPLine.CIU_FORMAT;
				case PlotComparisonEnsembleMPLine.NODE1
					prop_format = PlotComparisonEnsembleMPLine.NODE1_FORMAT;
				case PlotComparisonEnsembleMPLine.NODE2
					prop_format = PlotComparisonEnsembleMPLine.NODE2_FORMAT;
				case PlotComparisonEnsembleMPLine.LAYER
					prop_format = PlotComparisonEnsembleMPLine.LAYER_FORMAT;
				case PlotComparisonEnsembleMPLine.COLOR
					prop_format = PlotComparisonEnsembleMPLine.COLOR_FORMAT;
				case PlotComparisonEnsembleMPLine.LINESTYLE
					prop_format = PlotComparisonEnsembleMPLine.LINESTYLE_FORMAT;
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					prop_format = PlotComparisonEnsembleMPLine.LINEWIDTH_FORMAT;
				case PlotComparisonEnsembleMPLine.MARKER
					prop_format = PlotComparisonEnsembleMPLine.MARKER_FORMAT;
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					prop_format = PlotComparisonEnsembleMPLine.MARKERSIZE_FORMAT;
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					prop_format = PlotComparisonEnsembleMPLine.MARKEREDGECOLOR_FORMAT;
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					prop_format = PlotComparisonEnsembleMPLine.MARKERFACECOLOR_FORMAT;
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					prop_format = PlotComparisonEnsembleMPLine.FILLCOLOR_FORMAT;
				case PlotComparisonEnsembleMPLine.FILLALPHA
					prop_format = PlotComparisonEnsembleMPLine.FILLALPHA_FORMAT;
				case PlotComparisonEnsembleMPLine.CICOLOR
					prop_format = PlotComparisonEnsembleMPLine.CICOLOR_FORMAT;
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					prop_format = PlotComparisonEnsembleMPLine.CILINESTYLE_FORMAT;
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					prop_format = PlotComparisonEnsembleMPLine.CILINEWIDTH_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotComparisonEnsembleMPLine, POINTER) returns description of POINTER of PlotComparisonEnsembleMPLine.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PlotComparisonEnsembleMPLine, POINTER) returns description of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					prop_description = 'PLOTTITLE(metadata, string) to set plot line title';
				case PlotComparisonEnsembleMPLine.X
					prop_description = 'X(data, rvector) to set plot line graph x range';
				case PlotComparisonEnsembleMPLine.XLABEL
					prop_description = 'XLABEL(metadata, string) to set plot line x label';
				case PlotComparisonEnsembleMPLine.YLABEL
					prop_description = 'YLABEL(metadata, string) to set plot line y label';
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					prop_description = 'PLOTVALUE(data, cell) to set plot line atlas';
				case PlotComparisonEnsembleMPLine.MEASURE
					prop_description = 'MEASURE(data, string) to set plot line measure';
				case PlotComparisonEnsembleMPLine.COMPARISON
					prop_description = 'COMPARISON(data, IDICT) to set the comparison dictionary';
				case PlotComparisonEnsembleMPLine.CIL
					prop_description = 'CIL (metadata, CELL) to set plot line cil';
				case PlotComparisonEnsembleMPLine.CIU
					prop_description = 'CIU (metadata, CELL) to set plot line ciu';
				case PlotComparisonEnsembleMPLine.NODE1
					prop_description = 'NODE1 (metadata, scalar) to set plot line node 1';
				case PlotComparisonEnsembleMPLine.NODE2
					prop_description = 'NODE2 (metadata, scalar) to set plot line node 2';
				case PlotComparisonEnsembleMPLine.LAYER
					prop_description = 'LAYER (metadata, scalar) to set plot line layer';
				case PlotComparisonEnsembleMPLine.COLOR
					prop_description = 'COLOR (metadata, rvector) to set plot line color';
				case PlotComparisonEnsembleMPLine.LINESTYLE
					prop_description = 'LINESTYLE (metadata, string) to set plot line style';
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					prop_description = 'LINEWIDTH (metadata, scalar) to set plot line width';
				case PlotComparisonEnsembleMPLine.MARKER
					prop_description = 'MARKER (metadata, string) to set plot marker style';
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					prop_description = 'MARKERSIZE (metadata, scalar) to set plot marker size';
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					prop_description = 'MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color';
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					prop_description = 'MARKERFACECOLOR (metadata, rvector) to set plot marker face color';
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					prop_description = 'FILLCOLOR (metadata, rvector) to set plot patch face color';
				case PlotComparisonEnsembleMPLine.FILLALPHA
					prop_description = 'FILLALPHA (metadata, scalar) to set plot patch face color alpha';
				case PlotComparisonEnsembleMPLine.CICOLOR
					prop_description = 'CICOLOR (metadata, rvector) to set confidence interval plot line color';
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					prop_description = 'CILINESTYLE (metadata, string) to set confidence interval plot line style';
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					prop_description = 'CILINEWIDTH (metadata, scalar) to set confidence interval plot line width';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotComparisonEnsembleMPLine, POINTER) returns settings of POINTER of PlotComparisonEnsembleMPLine.
			%  SETTINGS = PR.GETPROPSETTINGS(PlotComparisonEnsembleMPLine, POINTER) returns settings of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.XLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.YLABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotComparisonEnsembleMPLine.MEASURE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.COMPARISON
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case PlotComparisonEnsembleMPLine.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotComparisonEnsembleMPLine.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
				case PlotComparisonEnsembleMPLine.NODE1
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.NODE2
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.COLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.LINESTYLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.MARKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.FILLALPHA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotComparisonEnsembleMPLine.CICOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotComparisonEnsembleMPLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotComparisonEnsembleMPLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotComparisonEnsembleMPLine, POINTER) returns the default value of POINTER of PlotComparisonEnsembleMPLine.
			%  DEFAULT = PR.GETPROPDEFAULT(PlotComparisonEnsembleMPLine, POINTER) returns the default value of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					prop_default = Format.getFormatDefault(Format.STRING, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.XLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.YLABEL
					prop_default = Format.getFormatDefault(Format.STRING, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					prop_default = Format.getFormatDefault(Format.CELL, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MEASURE
					prop_default = Format.getFormatDefault(Format.STRING, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.COMPARISON
					prop_default = Format.getFormatDefault(Format.IDICT, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CIL
					prop_default = Format.getFormatDefault(Format.CELL, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CIU
					prop_default = Format.getFormatDefault(Format.CELL, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.NODE1
					prop_default = 1;
				case PlotComparisonEnsembleMPLine.NODE2
					prop_default = 2;
				case PlotComparisonEnsembleMPLine.LAYER
					prop_default = 1;
				case PlotComparisonEnsembleMPLine.COLOR
					prop_default = [0 0 0];
				case PlotComparisonEnsembleMPLine.LINESTYLE
					prop_default = '-';
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					prop_default = 0.5;
				case PlotComparisonEnsembleMPLine.MARKER
					prop_default = 'none';
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					prop_default = 6;
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					prop_default = [0 0 0];
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					prop_default = [0 0 0];
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					prop_default = [0 0 0];
				case PlotComparisonEnsembleMPLine.FILLALPHA
					prop_default = 0;
				case PlotComparisonEnsembleMPLine.CICOLOR
					prop_default = [0 0 0];
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					prop_default = '-';
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					prop_default = 0.5;
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotComparisonEnsembleMPLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotComparisonEnsembleMPLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotComparisonEnsembleMPLine, POINTER) returns the conditioned default value of POINTER of PlotComparisonEnsembleMPLine.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PlotComparisonEnsembleMPLine, POINTER) returns the conditioned default value of POINTER of PlotComparisonEnsembleMPLine.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			prop_default = PlotComparisonEnsembleMPLine.conditioning(prop, PlotComparisonEnsembleMPLine.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotComparisonEnsembleMPLine, PROP, VALUE) checks VALUE format for PROP of PlotComparisonEnsembleMPLine.
			%  CHECK = PR.CHECKPROP(PlotComparisonEnsembleMPLine, PROP, VALUE) checks VALUE format for PROP of PlotComparisonEnsembleMPLine.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  Element.CHECKPROP(PlotComparisonEnsembleMPLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotComparisonEnsembleMPLine.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			%  PR.CHECKPROP(PlotComparisonEnsembleMPLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotComparisonEnsembleMPLine.
			%   Error id: [BRAPH2:PlotComparisonEnsembleMPLine:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
			switch prop
				case PlotComparisonEnsembleMPLine.PLOTTITLE
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.X
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.XLABEL
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.YLABEL
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.PLOTVALUE
					check = Format.checkFormat(Format.CELL, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MEASURE
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.COMPARISON
					check = Format.checkFormat(Format.IDICT, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CIL
					check = Format.checkFormat(Format.CELL, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CIU
					check = Format.checkFormat(Format.CELL, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.NODE1
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.NODE2
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.LAYER
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.COLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.LINESTYLE
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.LINEWIDTH
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MARKER
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MARKERSIZE
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MARKEREDGECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.MARKERFACECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.FILLCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.FILLALPHA
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
					if check
						check = value >= 0 && value <= 1;
					end
				case PlotComparisonEnsembleMPLine.CICOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CILINESTYLE
					check = Format.checkFormat(Format.STRING, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				case PlotComparisonEnsembleMPLine.CILINEWIDTH
					check = Format.checkFormat(Format.SCALAR, value, PlotComparisonEnsembleMPLine.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotComparisonEnsembleMPLine:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotComparisonEnsembleMPLine.getPropTag(prop) ' (' PlotComparisonEnsembleMPLine.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pr = PlotComparisonEnsembleMPLine(varargin)
			% PlotComparisonEnsembleMPLine() creates a plot graph.
			%
			% PlotComparisonEnsembleMPLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotComparisonEnsembleMPLine(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotComparisonEnsembleMPLine properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>plottitle</strong> 	PLOTTITLE(metadata, string) to set plot line title
			%  <strong>4</strong> <strong>x</strong> 	X(data, rvector) to set plot line graph x range
			%  <strong>5</strong> <strong>xlabel</strong> 	XLABEL(metadata, string) to set plot line x label
			%  <strong>6</strong> <strong>ylabel</strong> 	YLABEL(metadata, string) to set plot line y label
			%  <strong>7</strong> <strong>plotvalue</strong> 	PLOTVALUE(data, cell) to set plot line atlas
			%  <strong>8</strong> <strong>measure</strong> 	MEASURE(data, string) to set plot line measure
			%  <strong>9</strong> <strong>comparison</strong> 	COMPARISON(data, IDICT) to set the comparison dictionary
			%  <strong>10</strong> <strong>cil</strong> 	CIL (metadata, CELL) to set plot line cil
			%  <strong>11</strong> <strong>ciu</strong> 	CIU (metadata, CELL) to set plot line ciu
			%  <strong>12</strong> <strong>node1</strong> 	NODE1 (metadata, scalar) to set plot line node 1
			%  <strong>13</strong> <strong>node2</strong> 	NODE2 (metadata, scalar) to set plot line node 2
			%  <strong>14</strong> <strong>layer</strong> 	LAYER (metadata, scalar) to set plot line layer
			%  <strong>15</strong> <strong>color</strong> 	COLOR (metadata, rvector) to set plot line color
			%  <strong>16</strong> <strong>linestyle</strong> 	LINESTYLE (metadata, string) to set plot line style
			%  <strong>17</strong> <strong>linewidth</strong> 	LINEWIDTH (metadata, scalar) to set plot line width
			%  <strong>18</strong> <strong>marker</strong> 	MARKER (metadata, string) to set plot marker style
			%  <strong>19</strong> <strong>markersize</strong> 	MARKERSIZE (metadata, scalar) to set plot marker size
			%  <strong>20</strong> <strong>markeredgecolor</strong> 	MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color
			%  <strong>21</strong> <strong>markerfacecolor</strong> 	MARKERFACECOLOR (metadata, rvector) to set plot marker face color
			%  <strong>22</strong> <strong>fillcolor</strong> 	FILLCOLOR (metadata, rvector) to set plot patch face color
			%  <strong>23</strong> <strong>fillalpha</strong> 	FILLALPHA (metadata, scalar) to set plot patch face color alpha
			%  <strong>24</strong> <strong>cicolor</strong> 	CICOLOR (metadata, rvector) to set confidence interval plot line color
			%  <strong>25</strong> <strong>cilinestyle</strong> 	CILINESTYLE (metadata, string) to set confidence interval plot line style
			%  <strong>26</strong> <strong>cilinewidth</strong> 	CILINEWIDTH (metadata, scalar) to set confidence interval plot line width
			%
			% See also Category, Format, set, check.
			
			pr = pr@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotComparisonEnsembleMPLine.getPropProp(pointer);
			
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
		    % see also settings, uipanel, isgraphics, PlotGraph.    
		        
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
		    cp_dict = pr.get('Comparison');
		    pr.cp = cp_dict.getItem(1); % it has at least 1 measure
		    measure_list = cellfun(@(x) x.get('MEASURE'), cp_dict.getItems(), 'UniformOutput', false);
		    a1 = pr.cp.get('C').get('A1').get('g_dict').getItem(1);
		    atlas = a1.get('BRAINATLAS');
		    node_labels = cellfun(@(x) x.get('ID') , atlas.get('BR_DICT').getItems(), 'UniformOutput', false);
		
		    h_p_min = [];
		    h_fill_area = [];
		    h_p_max = [];
		    
		    plot_properties_panel = uipanel(pr.h_settings, ...
		        'Units', 'normalized', ...
		        'BackgroundColor', [1 .9725 .929], ...
		        'Position', [0 0 1 1]);
		    
		    % measures panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    measure_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .85 .98 .14] ...
		        );
		
		    % line properties
		    measure_list_id = uicontrol(plot_properties_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Measure', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .01 .1 .8]);
		    
		    measure_list_popup = uicontrol(plot_properties_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.11 .01 .1 .8], ...
		        'String', measure_list, ...
		        'TooltipString', 'Plot Line Style', ...
		        'Callback', {@cb_measure_selection} ...
		        );
		
		        function cb_measure_selection(~,~)
		            val = measure_list_popup.Value;
		            str = measure_list_popup.String;
		            pr.cp = cp_dict.getItem(val);
		            pr.set('YLABEL', pr.cp.get('MEASURE'));
		            pr.set('CIL', pr.cp.get('CIL'));
		            pr.set('CIU', pr.cp.get('CIU'));
		            rules_node_popmenu_deactivation()
		            pr.update_plot()
		        end
		
		    node_1_id = uicontrol(plot_properties_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Brain Region 1', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.22 .01 .1 .8]);
		    node_2_id = uicontrol(plot_properties_panel, ...
		        'Style', 'text', ...
		        'Units', 'normalized', ...
		        'String', 'Brain Region 2', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.44 .01 .1 .8]);
		    ui_node1_popmenu  = uicontrol('Parent', plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);
		    ui_node2_popmenu  = uicontrol('Parent', plot_properties_panel, 'Style', 'popupmenu', 'String', node_labels);
		
		        function update()
		             if comp_plot_checkbox.Value
		                pr.update_plot()
		            else
		                set(pr.h_plot, 'Visible', 'off');
		            end
		            if confidence_interval_min_checkbox.Value
		                cb_show_confidence_interval_min()
		            else
		                set(h_p_min, 'Visible', 'off')
		            end
		            if confidence_interval_max_checkbox.Value
		                cb_show_confidence_interval_max()
		            else
		                set(h_p_max, 'Visible', 'off')
		            end
		            if area_fill_checkbox.Value
		                area_fill(h_p_min, h_p_max)
		            else
		                set(h_fill_area, 'Visible', 'off');
		            end
		        end
		        function init_measure_plot_area()
		            set(ui_node1_popmenu, ...
		                'Units', 'normalized', ...
		                'Tooltip', 'Select the Node to be Plotted.', ...
		                'String', node_labels, ...
		                'Value', pr.get('NODE1'), ...
		                'Position', [.33 .01 .1 .8], ...
		                'Callback', {@cb_node_1} ...
		                );
		            set(ui_node2_popmenu, ...
		                'Units', 'normalized', ...
		                'Tooltip', 'Select the Node to be Plotted.', ...
		                'String', node_labels, ...
		                'Value', pr.get('NODE2'), ...
		                'Position', [.55 .01 .1 .8], ...
		                'Callback', {@cb_node_2} ...
		                );
		            rules_node_popmenu_deactivation()
		        end
		        function rules_node_popmenu_deactivation()
		            if Measure.is_global(pr.cp.get('MEASURE'))
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
		
		            elseif Measure.is_nodal(pr.cp.get('MEASURE'))
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
		            clear_axes()
		            node1_to_plot = double(source.Value);
		            pr.set('NODE1', node1_to_plot)
		            update();
		        end
		        function cb_node_2(source, ~)
		            clear_axes()
		            node2_to_plot = double(source.Value);
		            pr.set('NODE2', node2_to_plot)
		            update();
		        end
		    
		      layer_id = uicontrol(plot_properties_panel, ...
		            'Style', 'text', ...
		            'Units', 'normalized', ...
		            'String', 'Layer Selection', ...
		            'BackgroundColor', pr.h_settings.Color, ...
		            'Position', [.66 .01 .1 .8]);
		    
		        tmp_g = pr.cp.get('C').get('A1').get('G_DICT').getItem(1);
		        layer_number = size(tmp_g.get('B'), 2);
		        layer_popup = uicontrol('Parent', plot_properties_panel,...
		            'Style', 'popupmenu',...
		            'Units', 'normalized', ...
		            'String', arrayfun(@(x) [num2str(x)], [1:layer_number], 'UniformOutput', false));
		        init_layer_section()
		        function init_layer_section()
		            set(layer_popup, 'Position', [.77 .01 .1 .8], ...
		                'Value', pr.get('LAYER'), ...
		                'Callback', {@layer_popup_selector});
		
		        end
		        function layer_popup_selector(src, ~)
		            layer_to_plot = double(src.Value);
		            pr.set('LAYER', layer_to_plot)
		            update();
		        end
		    
		    comparison_plot_style_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.01 .01 .32 .84] ...
		        );
		    
		    comp_plot_checkbox = uicontrol(comparison_plot_style_panel, ...
		        'Style', 'checkbox', ...
		        'Units', 'normalized', ...
		        'Position', [.01 .84 .4 .1], ...
		        'String', 'Comparison Plot', ...
		        'Value', true, ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Callback', {@cb_show_comparison_plot});
		
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
		    
		     % cil ciu panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    cil_ciu_plot_style_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.34 .01 .32 .84] ...
		        );
		    
		    
		    confidence_interval_min_checkbox = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'checkbox', ...
		        'Units', 'normalized', ...
		        'Position', [.01 .84 .4 .1], ...
		        'String', 'Confidence Interval Min', ...
		        'Value', false, ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Callback', {@cb_show_confidence_interval_min});
		    
		        function cb_show_confidence_interval_min(src, ~)
		            % enable/disable cil line panel
		
		            % plot
		            if confidence_interval_min_checkbox.Value
		                x_ = pr.get('X');
		                tmp_g = pr.cp.get('C').get('A1').get('G_DICT').getItem(1);
		                layer_number = size(tmp_g.get('B'), 2);
		                choosen_layer = pr.get('LAYER');
		                cil = [cil(choosen_layer:layer_number:end)];
		                if ~check_graphics(h_p_min, 'line')
		                    h_p_min = plot(pr.h_axes, ...
		                        x_, ...
		                        cil, ...
		                        'Marker', 'x', ...
		                        'MarkerSize', 10, ...
		                        'MarkerEdgeColor', [0 0 1], ...
		                        'MarkerFaceColor', [.3 .4 .5], ...
		                        'LineStyle', pr.get('CILINESTYLE'), ...
		                        'LineWidth', pr.get('CILINEWIDTH'), ...
		                        'Color', pr.get('CICOLOR'));
		                else
		                    set(h_p_min, ...
		                        'LineStyle', pr.get('CILINESTYLE'), ...
		                        'LineWidth', pr.get('CILINEWIDTH'), ...
		                        'Color', pr.get('CICOLOR') )
		                end
		                h_p_min.Visible = true;
		            else
		                h_p_min.Visible = false;
		            end
		        end
		    
		    confidence_interval_max_checkbox = uicontrol(cil_ciu_plot_style_panel, ...
		        'Units', 'normalized', ...
		        'Style', 'checkbox', ...
		        'Position', [.51 .84 .4 .1], ...
		        'String', 'Confidence Interval Max', ...
		        'Value', false, ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Callback', {@cb_show_confidence_interval_max});
		
		        function cb_show_confidence_interval_max(src, ~)
		            % enable/disable cil line panel
		
		            % plot
		            if confidence_interval_max_checkbox.Value
		                hold(pr.h_axes, 'on')
		                x_ = pr.get('X');
		                ciu = obtain_cil_ciu_value(pr.get('CIU'));
		                tmp_g = pr.cp.get('C').get('A1').get('G_DICT').getItem(1);
		                layer_number = size(tmp_g.get('B'), 2);
		                choosen_layer = pr.get('LAYER');
		                ciu = [ciu(choosen_layer:layer_number:end)];
		                if ~check_graphics(h_p_max, 'line')
		                    h_p_max = plot(pr.h_axes, ...
		                        x_, ...
		                        ciu, ...
		                        'Marker', 'x', ...
		                        'MarkerSize', 10, ...
		                        'MarkerEdgeColor', [0 0 1], ...
		                        'MarkerFaceColor', [.3 .4 .5], ...
		                        'LineStyle', pr.get('CILINESTYLE'), ...
		                        'LineWidth', pr.get('CILINEWIDTH'), ...
		                        'Color', pr.get('CICOLOR'));
		                else
		                    set(h_p_max, ...
		                        'LineStyle', pr.get('CILINESTYLE'), ...
		                        'LineWidth', pr.get('CILINEWIDTH'), ...
		                        'Color', pr.get('CICOLOR') )
		                end
		                h_p_max.Visible = true;
		            else
		                h_p_max.Visible = false;
		            end
		        end
		        function limit = obtain_cil_ciu_value(array)
		            node1_to_plot = pr.get('NODE1');
		            node2_to_plot = pr.get('NODE2');
		
		            if Measure.is_global(pr.cp.get('MEASURE')) % global
		                is_inf_vector = cellfun(@(x) isinf(x), array);
		                if any(is_inf_vector)
		                    return;
		                end
		                limit = [array{:}];
		            elseif Measure.is_nodal(pr.cp.get('MEASURE')) % nodal
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
		    
		    CI_style_id = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'CI Line Style', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .72 .32 .1]);
		
		    cil_ciu_style = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'popupmenu', ...
		        'Units','normalized', ...
		        'Position', [.34 .72 .64 .1], ...
		        'String', line_style, ...
		        'TooltipString', 'Plot CIL and CIU Style', ...
		        'Callback', {@cb_minmax_line_style});
		
		        function cb_minmax_line_style(src, ~)  % (src, event)
		            val = src.Value;
		            str = src.String;
		            set(h_p_min, 'LineStyle', str{val})
		            set(h_p_max, 'LineStyle', str{val})
		            pr.set('CILINESTYLE', str{val})
		        end
		
		    CI_color_id = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'CI Line Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .6 .32 .1]);
		
		    cil_ciu_line_color = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'pushbutton', ...
		        'Units','normalized', ...
		        'Position', [.34 .6 .64 .1], ...
		        'String', 'Line Color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Plot CIL and CIU Color', ...
		        'Callback', {@cb_minmax_color});
		
		        function cb_minmax_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                set(h_p_min, 'COLOR', color)
		                set(h_p_max, 'COLOR', color)
		                pr.set('CICOLOR', value)
		            end
		        end
		
		    CI_width_id = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'CI Line Width', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .48 .32 .1]);
		
		    cil_ciu_line_width = uicontrol(cil_ciu_plot_style_panel, ...
		        'Style', 'edit', ...
		        'Units', 'normalized', ...
		        'Position', [.34 .48 .64 .1], ...
		        'String', '5', ...
		        'TooltipString', 'Plot Line Width', ...
		        'Callback', {@cb_minmax_line_width});
		
		        function cb_minmax_line_width(~, ~)  % (src, event)
		            value = str2num(cil_ciu_line_width.String);
		            set(h_p_min, 'LINEWIDTH', value)
		            set(h_p_max, 'LINEWIDTH', value)
		            pr.set('CILINEWIDTH', value)
		        end
		     % area fill %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		    fill_plot_style_panel = uipanel(plot_properties_panel, ...
		        'Units', 'normalized', ...
		        'BackgroundColor',  pr.h_settings.Color, ...
		        'Position', [.67 .01 .32 .84] ...
		        );
		
		    area_fill_checkbox = uicontrol(fill_plot_style_panel, ...
		        'Units', 'normalized', ...
		        'Style', 'checkbox', ...
		        'Position', [.01 .84 .4 .1], ...
		        'String', 'Fill area', ...
		        'Value', false, ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Callback', {@cb_fill_area});
		
		        function cb_fill_area(~, ~)
		            update()
		            % disable enable
		        end
		
		    fill_alpha_id = uicontrol(fill_plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'Fill Area Alpha', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .72 .32 .1]);
		
		    fill_area_alpha = uicontrol(fill_plot_style_panel, ...
		        'Style', 'slider', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.34 .72 .64 .1], ...
		        'String', 'Area Alpha', ...
		        'Min', 0, 'Max', 1, 'Value', max(pr.get('FILLALPHA'), 0.5), ...
		        'TooltipString', 'Plot Area Color Transparency', ...
		        'Callback', {@cb_fill_alpha});
		
		        function cb_fill_alpha(~, ~)  % (src, event)
		            pr.set('FILLALPHA', get(fill_area_alpha, 'Value'))
		            update()
		        end
		
		    fill_alpha_id = uicontrol(fill_plot_style_panel, ...
		        'Style', 'text', ...
		        'HorizontalAlignment', 'left', ...
		        'Units', 'normalized', ...
		        'String', 'Fill Area Color', ...
		        'BackgroundColor', pr.h_settings.Color, ...
		        'Position', [.01 .6 .32 .1]);
		
		    fill_area_color = uicontrol(fill_plot_style_panel, ...
		        'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.34 .6 .64 .1], ...
		        'String', 'Area Color', ...
		        'TooltipString', 'Plot Area Color', ...
		        'Callback', {@cb_fill_color});
		
		        function cb_fill_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pr.set('FILLCOLOR', color)
		                update()
		            end
		        end
		        function area_fill(X, Y)
		            x_data = get(X, 'XData');
		            y1_data = get(X, 'YData');
		            y2_data = get(Y, 'YData');
		            if area_fill_checkbox.Value
		                h_fill_area = [];
		                h_fill_area = fill(pr.h_axes, [x_data, fliplr(x_data)], [y1_data, fliplr(y2_data)], pr.get('FILLCOLOR'), 'FaceAlpha', pr.get('FILLALPHA'));
		            end
		        end
		    
		    init_measure_plot_area()
		    cb_measure_selection()
		
		    if nargin > 0
		        f_settings = pr.h_settings;
		    end
		end
		function update_plot(pr)
		    comparison = pr.cp;
		    plot_value = comparison.get('DIFF');
		    tmp_g = pr.cp.get('C').get('A1').get('G_DICT').getItem(1);
		    layer_number = size(tmp_g.get('B'), 2);
		    choosen_layer = pr.get('LAYER');
		
		    %pr.cp.get('MEASURE')
		    if Measure.is_global(pr.cp.get('MEASURE')) && ~Measure.is_superglobal(pr.cp.get('MEASURE')) % global
		        is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		        if any(is_inf_vector)
		            f = warndlg('The measure cannot be plotted because it contains Inf values.');
		            set_braph2icon(f);
		            return;
		        end
		        y_ = [plot_value{choosen_layer:layer_number:end}];
		    elseif Measure.is_nodal(pr.cp.get('MEASURE')) && ~Measure.is_superglobal(pr.cp.get('MEASURE')) % nodal
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
		    elseif  Measure.is_binodal(pr.cp.get('MEASURE')) && ~Measure.is_superglobal(pr.cp.get('MEASURE')) % binodal
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
		    elseif Measure.is_superglobal(pr.cp.get('MEASURE')) % superglobal
		        if Measure.is_global(pr.cp.get('MEASURE'))
		            is_inf_vector = cellfun(@(x) isinf(x), plot_value);
		            if any(is_inf_vector)
		                f = warndlg('The measure cannot be plotted because it contains Inf values.');
		                set_braph2icon(f);
		                return;
		            end
		            y_ = [plot_value{:}];
		        elseif Measure.is_nodal(pr.cp.get('MEASURE'))
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
		    if ~check_graphics(pr.h_plot, 'line')
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
		    else
		        set(pr.h_plot, ...
		            'XDATA', x, ...
		            'YDATA', y, ...
		            'Visible', 'on', ...
		            'Marker', pr.get('MARKER'), ...
		            'MarkerSize', pr.get('MARKERSIZE'), ...
		            'MarkerEdgeColor', pr.get('MARKEREDGECOLOR'), ...
		            'MarkerFaceColor', pr.get('MARKERFACECOLOR'), ...
		            'LineStyle', pr.get('LINESTYLE'), ...
		            'LineWidth', pr.get('LINEWIDTH'), ...
		            'Color', pr.get('COLOR') ...
		            );
		    end
		    uistack(pr.h_plot,'top')
		    title(pr.h_axes, pr.get('PLOTTITLE'))
		    xlabel(pr.h_axes, pr.get('XLABEL'))
		    ylabel(pr.h_axes, pr.get('YLABEL'))
		end
	end
end
