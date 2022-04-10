classdef PlotBrainSurface < Plot
	% PlotBrainSurface is a plot of a brain surfce.
	% It is a subclass of <a href="matlab:help Plot">Plot</a>.
	%
	% PlotBrainSurface manages the brain surface choosen by the user. 
	% A collection of brain surfaces in NV format can be found in the folder 
	% ./braph2/brainsurfs/.
	% This class provides the common methods needed to manage the plot of 
	% the surface, via a custom panel called ''Brain Surface Settings'' where
	% the user can change lighting, material, camlight, shadning, colormap,
	% facecolor, brain color, face color, edge color, and background color.
	%
	% The list of PlotBrainSurface properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
	%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
	%  <strong>3</strong> <strong>surf</strong> 	SURF (metadata, item) is the brain surface to be plotted.
	%  <strong>4</strong> <strong>axescolor</strong> 	AXESCOLOR (metadata, rvector) is axes background color.
	%  <strong>5</strong> <strong>view</strong> 	VIEW (metadata, rvector) sets the desired view.
	%  <strong>6</strong> <strong>hold</strong> 	HOLD (metadata, logical) determines whether hold is on or offf.
	%  <strong>7</strong> <strong>grid</strong> 	GRID (metadata, logical) determines whether the grid is shown.
	%  <strong>8</strong> <strong>axis</strong> 	AXIS (metadata, logical) determines whether the axis is shown.
	%  <strong>9</strong> <strong>equal</strong> 	EQUAL (metadata, logical) determines whether the axis are equal.
	%  <strong>10</strong> <strong>tight</strong> 	TIGHT (metadata, logical) determines whether the axis are tight.
	%  <strong>11</strong> <strong>brain</strong> 	BRAIN (metadata, logical) determines whether the brain surface is shown.
	%  <strong>12</strong> <strong>edgecolor</strong> 	EDGECOLOR (metadata, rvector) is the RGB edge color.
	%  <strong>13</strong> <strong>edgealpha</strong> 	EDGEALPHA (metadata, scalar) is the edge transparency.
	%  <strong>14</strong> <strong>facecolor</strong> 	FACECOLOR (metadata, rvector) is the RGB face color.
	%  <strong>15</strong> <strong>facealpha</strong> 	FACEALPHA (metadata, scalar) is the face transparency.
	%  <strong>16</strong> <strong>lighting</strong> 	LIGHTING (metadata, option) is the lighting value.
	%  <strong>17</strong> <strong>material</strong> 	MATERIAL (metadata, option) is the material value.
	%  <strong>18</strong> <strong>camlight</strong> 	CAMLIGHT (metadata, option) is the camlight value.
	%  <strong>19</strong> <strong>shading</strong> 	SHADING (metadata, option) is the shading value.
	%  <strong>20</strong> <strong>colormap</strong> 	COLORMAP (metadata, matrix) is the colormap.
	%  <strong>21</strong> <strong>colormapstring</strong> 	COLORMAPSTRING (metadata, string) is the colormap string value.
	%
	% PlotBrainSurface methods (constructor):
	% PlotBrainSurface - constructor
	%
	% PlotBrainSurface methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot brain surface/error.
	%  existsProp - checks whether property exists in plot brain surface/error.
	%  getPropNumber - returns the property number of plot brain surface.
	%  getProps - returns the property list of plot brain surface.
	%  getDescription - returns the description of the plot brain surface.
	%  getName - returns the name of the plot brain surface.
	%  getClass - returns the class of the plot brain surface.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotBrainSurface methods:
	%  settings - opens the brain surface property editor GUI.
	%  draw - draws the brain surface graphical panel.
	%  set_settings - ace/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to the front the figure with the panel and the settings figure.
	%  cb_close_fs - face/cb_close_fs is a function.
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
	% PlotBrainSurface methods (operators):
	%  isequal - determines whether two PlotBrainSurface are equal (values, locked)
	%
	% PlotBrainSurface methods (display):
	%  tostring - string with information about the PlotBrainSurface
	%  disp - displays information about the PlotBrainSurface
	%  tree - displays the element of PlotBrainSurface
	%
	% PlotBrainSurface method (element list):
	%  getElementList - returns a list with all subelements of PlotBrainSurface
	%
	% PlotBrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotBrainSurface
	%
	% PlotBrainSurface method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotBrainSurface
	%
	% PlotBrainSurface methods (copy):
	%  copy - copies the PlotBrainSurface
	%  deepclone - deep-clones the PlotBrainSurface
	%  clone - clones the PlotBrainSurface
	%
	% PlotBrainSurface methods (inspection, Static):
	%  getClass - returns PlotBrainSurface
	%  getName - returns the name of PlotBrainSurface
	%  getDescription - returns the description of PlotBrainSurface
	%  getProps - returns the property list of PlotBrainSurface
	%  getPropNumber - returns the property number of PlotBrainSurface
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
	% PlotBrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotBrainSurface methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotBrainSurface methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotBrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotBrainSurface properties (Constant).
	%  VIEW_3D - 1
	%  VIEW_3D_CMD - '3D'
	%  VIEW_3D_AZEL - num[1 2] [ -37.5           30 ]
	%  VIEW_SL - 2
	%  VIEW_SL_CMD - 'Sagittal left'
	%  VIEW_SL_AZEL - num[1 2] [ -90   0 ]
	%  VIEW_SR - 3
	%  VIEW_SR_CMD - 'Sagittal right'
	%  VIEW_SR_AZEL - num[1 2] [ 90   0 ]
	%  VIEW_AD - 4
	%  VIEW_AD_CMD - 'Axial dorsal'
	%  VIEW_AD_AZEL - num[1 2] [ 0  90 ]
	%  VIEW_AV - 5
	%  VIEW_AV_CMD - 'Axial ventral'
	%  VIEW_AV_AZEL - num[1 2] [ 0 -90 ]
	%  VIEW_CA - 6
	%  VIEW_CA_CMD - 'Coronal anterior'
	%  VIEW_CA_AZEL - num[1 2] [ 180    0 ]
	%  VIEW_CP - 7
	%  VIEW_CP_CMD - 'Coronal posterior'
	%  VIEW_CP_AZEL - num[1 2] [ 0  0 ]
	%  VIEW_CMD - cell[1 7] { '3D' 'Sagittal left' 'Sagittal right' 'Axial dorsal' 'Axial ventral' 'Coronal anterior' 'Coronal posterior' }
	%  VIEW_AZEL - cell[1 7] { num[1 2] [ -37.5           30 ] num[1 2] [ -90   0 ] num[1 2] [ 90   0 ] num[1 2] [ 0  90 ] num[1 2] [ 0 -90 ] num[1 2] [ 180    0 ] num[1 2] [ 0  0 ] }
	%  SURF - 3
	%  SURF_TAG - 'surf'
	%  SURF_CATEGORY - 'm'
	%  SURF_FORMAT - 'it'
	%  AXESCOLOR - 4
	%  AXESCOLOR_TAG - 'axescolor'
	%  AXESCOLOR_CATEGORY - 'm'
	%  AXESCOLOR_FORMAT - 'nr'
	%  VIEW - 5
	%  VIEW_TAG - 'view'
	%  VIEW_CATEGORY - 'm'
	%  VIEW_FORMAT - 'nr'
	%  HOLD - 6
	%  HOLD_TAG - 'hold'
	%  HOLD_CATEGORY - 'm'
	%  HOLD_FORMAT - 'lo'
	%  GRID - 7
	%  GRID_TAG - 'grid'
	%  GRID_CATEGORY - 'm'
	%  GRID_FORMAT - 'lo'
	%  AXIS - 8
	%  AXIS_TAG - 'axis'
	%  AXIS_CATEGORY - 'm'
	%  AXIS_FORMAT - 'lo'
	%  EQUAL - 9
	%  EQUAL_TAG - 'equal'
	%  EQUAL_CATEGORY - 'm'
	%  EQUAL_FORMAT - 'lo'
	%  TIGHT - 10
	%  TIGHT_TAG - 'tight'
	%  TIGHT_CATEGORY - 'm'
	%  TIGHT_FORMAT - 'lo'
	%  BRAIN - 11
	%  BRAIN_TAG - 'brain'
	%  BRAIN_CATEGORY - 'm'
	%  BRAIN_FORMAT - 'lo'
	%  EDGECOLOR - 12
	%  EDGECOLOR_TAG - 'edgecolor'
	%  EDGECOLOR_CATEGORY - 'm'
	%  EDGECOLOR_FORMAT - 'nr'
	%  EDGEALPHA - 13
	%  EDGEALPHA_TAG - 'edgealpha'
	%  EDGEALPHA_CATEGORY - 'm'
	%  EDGEALPHA_FORMAT - 'nn'
	%  FACECOLOR - 14
	%  FACECOLOR_TAG - 'facecolor'
	%  FACECOLOR_CATEGORY - 'm'
	%  FACECOLOR_FORMAT - 'nr'
	%  FACEALPHA - 15
	%  FACEALPHA_TAG - 'facealpha'
	%  FACEALPHA_CATEGORY - 'm'
	%  FACEALPHA_FORMAT - 'nn'
	%  LIGHTING - 16
	%  LIGHTING_TAG - 'lighting'
	%  LIGHTING_CATEGORY - 'm'
	%  LIGHTING_FORMAT - 'op'
	%  MATERIAL - 17
	%  MATERIAL_TAG - 'material'
	%  MATERIAL_CATEGORY - 'm'
	%  MATERIAL_FORMAT - 'op'
	%  CAMLIGHT - 18
	%  CAMLIGHT_TAG - 'camlight'
	%  CAMLIGHT_CATEGORY - 'm'
	%  CAMLIGHT_FORMAT - 'op'
	%  SHADING - 19
	%  SHADING_TAG - 'shading'
	%  SHADING_CATEGORY - 'm'
	%  SHADING_FORMAT - 'op'
	%  COLORMAP - 20
	%  COLORMAP_TAG - 'colormap'
	%  COLORMAP_CATEGORY - 'm'
	%  COLORMAP_FORMAT - 'nm'
	%  COLORMAPSTRING - 21
	%  COLORMAPSTRING_TAG - 'colormapstring'
	%  COLORMAPSTRING_CATEGORY - 'm'
	%  COLORMAPSTRING_FORMAT - 'st'
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
	% See also Plot, BrainSurface.
	
	properties (Constant) % constants
		% fixed 3d view
		VIEW_3D	= 1 % 3D view numeric code
		VIEW_3D_CMD = '3D' % 3D view name
		VIEW_3D_AZEL = [-37.5 30] % 3D view azimutal and polar angles
		
		% sagittal left view
		VIEW_SL	= 2 % sagittal left view numeric code
		VIEW_SL_CMD = 'Sagittal left' % sagittal left view name
		VIEW_SL_AZEL = [-90 0] % sagittal left view azimutal and polar angles
		
		% sagittal right view
		VIEW_SR	= 3 % sagittal right view numeric code
		VIEW_SR_CMD = 'Sagittal right' % sagittal right view name
		VIEW_SR_AZEL = [90 0] % sagittal right view azimutal and polar angles 
		
		% axial dorsal view
		VIEW_AD = 4 % axial dorsal view numeric code
		VIEW_AD_CMD = 'Axial dorsal' % axial dorsal view name
		VIEW_AD_AZEL = [0 90] % axial dorsal view azimutal and polar angles
		
		% axial ventral view
		VIEW_AV = 5 % axial ventral view numeric code
		VIEW_AV_CMD = 'Axial ventral' % axial ventral view name
		VIEW_AV_AZEL = [0 -90] % axial ventral view azimutal and polar angles
		
		% coronal anterior view
		VIEW_CA = 6 % coronal anterior view numeric code
		VIEW_CA_CMD = 'Coronal anterior' % coronal anterior view name
		VIEW_CA_AZEL = [180 0] % coronal anterior view azimutal and polar angles
		
		% coronal posterior view
		VIEW_CP = 7 % coronal posterior view numeric code
		VIEW_CP_CMD = 'Coronal posterior' % coronal posterior view name
		VIEW_CP_AZEL = [0 0] % coronal posterior view azimutal and polar angles
		
		VIEW_CMD = { ... % vector of view names
		    PlotBrainSurface.VIEW_3D_CMD ...
		    PlotBrainSurface.VIEW_SL_CMD ...
		    PlotBrainSurface.VIEW_SR_CMD ...
		    PlotBrainSurface.VIEW_AD_CMD ...
		    PlotBrainSurface.VIEW_AV_CMD ...
		    PlotBrainSurface.VIEW_CA_CMD ...
		    PlotBrainSurface.VIEW_CP_CMD ...
		    }
		
		VIEW_AZEL = { ... % vector of view azimutal and polar angle
		    PlotBrainSurface.VIEW_3D_AZEL ...
		    PlotBrainSurface.VIEW_SL_AZEL ...
		    PlotBrainSurface.VIEW_SR_AZEL ...
		    PlotBrainSurface.VIEW_AD_AZEL ...
		    PlotBrainSurface.VIEW_AV_AZEL ...
		    PlotBrainSurface.VIEW_CA_AZEL ...
		    PlotBrainSurface.VIEW_CP_AZEL ...
		    }
	end
	properties (Access = private) % element properties
		h_axes % handle for the axes
		h_brain % handle for brain surface
		pp  % handle for panel
	end
	properties (Constant) % properties
		SURF = Plot.getPropNumber() + 1;
		SURF_TAG = 'surf';
		SURF_CATEGORY = Category.METADATA;
		SURF_FORMAT = Format.ITEM;
		
		AXESCOLOR = Plot.getPropNumber() + 2;
		AXESCOLOR_TAG = 'axescolor';
		AXESCOLOR_CATEGORY = Category.METADATA;
		AXESCOLOR_FORMAT = Format.RVECTOR;
		
		VIEW = Plot.getPropNumber() + 3;
		VIEW_TAG = 'view';
		VIEW_CATEGORY = Category.METADATA;
		VIEW_FORMAT = Format.RVECTOR;
		
		HOLD = Plot.getPropNumber() + 4;
		HOLD_TAG = 'hold';
		HOLD_CATEGORY = Category.METADATA;
		HOLD_FORMAT = Format.LOGICAL;
		
		GRID = Plot.getPropNumber() + 5;
		GRID_TAG = 'grid';
		GRID_CATEGORY = Category.METADATA;
		GRID_FORMAT = Format.LOGICAL;
		
		AXIS = Plot.getPropNumber() + 6;
		AXIS_TAG = 'axis';
		AXIS_CATEGORY = Category.METADATA;
		AXIS_FORMAT = Format.LOGICAL;
		
		EQUAL = Plot.getPropNumber() + 7;
		EQUAL_TAG = 'equal';
		EQUAL_CATEGORY = Category.METADATA;
		EQUAL_FORMAT = Format.LOGICAL;
		
		TIGHT = Plot.getPropNumber() + 8;
		TIGHT_TAG = 'tight';
		TIGHT_CATEGORY = Category.METADATA;
		TIGHT_FORMAT = Format.LOGICAL;
		
		BRAIN = Plot.getPropNumber() + 9;
		BRAIN_TAG = 'brain';
		BRAIN_CATEGORY = Category.METADATA;
		BRAIN_FORMAT = Format.LOGICAL;
		
		EDGECOLOR = Plot.getPropNumber() + 10;
		EDGECOLOR_TAG = 'edgecolor';
		EDGECOLOR_CATEGORY = Category.METADATA;
		EDGECOLOR_FORMAT = Format.RVECTOR;
		
		EDGEALPHA = Plot.getPropNumber() + 11;
		EDGEALPHA_TAG = 'edgealpha';
		EDGEALPHA_CATEGORY = Category.METADATA;
		EDGEALPHA_FORMAT = Format.SCALAR;
		
		FACECOLOR = Plot.getPropNumber() + 12;
		FACECOLOR_TAG = 'facecolor';
		FACECOLOR_CATEGORY = Category.METADATA;
		FACECOLOR_FORMAT = Format.RVECTOR;
		
		FACEALPHA = Plot.getPropNumber() + 13;
		FACEALPHA_TAG = 'facealpha';
		FACEALPHA_CATEGORY = Category.METADATA;
		FACEALPHA_FORMAT = Format.SCALAR;
		
		LIGHTING = Plot.getPropNumber() + 14;
		LIGHTING_TAG = 'lighting';
		LIGHTING_CATEGORY = Category.METADATA;
		LIGHTING_FORMAT = Format.OPTION;
		
		MATERIAL = Plot.getPropNumber() + 15;
		MATERIAL_TAG = 'material';
		MATERIAL_CATEGORY = Category.METADATA;
		MATERIAL_FORMAT = Format.OPTION;
		
		CAMLIGHT = Plot.getPropNumber() + 16;
		CAMLIGHT_TAG = 'camlight';
		CAMLIGHT_CATEGORY = Category.METADATA;
		CAMLIGHT_FORMAT = Format.OPTION;
		
		SHADING = Plot.getPropNumber() + 17;
		SHADING_TAG = 'shading';
		SHADING_CATEGORY = Category.METADATA;
		SHADING_FORMAT = Format.OPTION;
		
		COLORMAP = Plot.getPropNumber() + 18;
		COLORMAP_TAG = 'colormap';
		COLORMAP_CATEGORY = Category.METADATA;
		COLORMAP_FORMAT = Format.MATRIX;
		
		COLORMAPSTRING = Plot.getPropNumber() + 19;
		COLORMAPSTRING_TAG = 'colormapstring';
		COLORMAPSTRING_CATEGORY = Category.METADATA;
		COLORMAPSTRING_FORMAT = Format.STRING;
	end
	methods (Static) % inspection methods
		function pl_class = getClass()
			%GETCLASS returns the class of the plot brain surface.
			%
			% CLASS = PlotBrainSurface.GETCLASS() returns the class 'PlotBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PL.GETCLASS() returns the class of the plot brain surface PL.
			%  CLASS = Element.GETCLASS(PL) returns the class of 'PL'.
			%  CLASS = Element.GETCLASS('PlotBrainSurface') returns 'PlotBrainSurface'.
			%
			% See also getName, getDescription.
			
			pl_class = 'PlotBrainSurface';
		end
		function pl_name = getName()
			%GETNAME returns the name of the plot brain surface.
			%
			% NAME = PlotBrainSurface.GETNAME() returns the name of the 'plot brain surface'.
			%  Plot Brain Surface.
			%
			% Alternative forms to call this method are:
			%  NAME = PL.GETNAME() returns the name of the plot brain surface PL.
			%  NAME = Element.GETNAME(PL) returns the name of 'PL'.
			%  NAME = Element.GETNAME('PlotBrainSurface') returns the name of 'PlotBrainSurface'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pl_name = 'Plot Brain Surface';
		end
		function pl_description = getDescription()
			%GETDESCRIPTION returns the description of the plot brain surface.
			%
			% STR = PlotBrainSurface.GETDESCRIPTION() returns the description of the 'plot brain surface'.
			%  which is:
			%
			%  PlotBrainSurface manages the brain surface choosen by the user. 
			%  A collection of brain surfaces in NV format can be found in the folder 
			%  ./braph2/brainsurfs/.
			%  This class provides the common methods needed to manage the plot of 
			%  the surface, via a custom panel called ''Brain Surface Settings'' where
			%  the user can change lighting, material, camlight, shadning, colormap,
			%  facecolor, brain color, face color, edge color, and background color.
			%
			% Alternative forms to call this method are:
			%  STR = PL.GETDESCRIPTION() returns the description of the plot brain surface PL.
			%  STR = Element.GETDESCRIPTION(PL) returns the description of 'PL'.
			%  STR = Element.GETDESCRIPTION('PlotBrainSurface') returns the description of 'PlotBrainSurface'.
			%
			% See also getClass, getName.
			
			pl_description = [
				'PlotBrainSurface manages the brain surface choosen by the user. ' ...
				'A collection of brain surfaces in NV format can be found in the folder ' ...
				'./braph2/brainsurfs/.' ...
				'This class provides the common methods needed to manage the plot of ' ...
				'the surface, via a custom panel called ''Brain Surface Settings'' where' ...
				'the user can change lighting, material, camlight, shadning, colormap,' ...
				'facecolor, brain color, face color, edge color, and background color.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot brain surface.
			%
			% PROPS = PlotBrainSurface.GETPROPS() returns the property list of plot brain surface.
			%
			% PROPS = PlotBrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PL.GETPROPS([CATEGORY]) returns the property list of the plot brain surface PL.
			%  PROPS = Element.GETPROPS(PL[, CATEGORY]) returns the property list of 'PL'.
			%  PROPS = Element.GETPROPS('PlotBrainSurface'[, CATEGORY]) returns the property list of 'PlotBrainSurface'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Plot.getProps(Category.METADATA)
						PlotBrainSurface.SURF
						PlotBrainSurface.AXESCOLOR
						PlotBrainSurface.VIEW
						PlotBrainSurface.HOLD
						PlotBrainSurface.GRID
						PlotBrainSurface.AXIS
						PlotBrainSurface.EQUAL
						PlotBrainSurface.TIGHT
						PlotBrainSurface.BRAIN
						PlotBrainSurface.EDGECOLOR
						PlotBrainSurface.EDGEALPHA
						PlotBrainSurface.FACECOLOR
						PlotBrainSurface.FACEALPHA
						PlotBrainSurface.LIGHTING
						PlotBrainSurface.MATERIAL
						PlotBrainSurface.CAMLIGHT
						PlotBrainSurface.SHADING
						PlotBrainSurface.COLORMAP
						PlotBrainSurface.COLORMAPSTRING
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
						PlotBrainSurface.SURF
						PlotBrainSurface.AXESCOLOR
						PlotBrainSurface.VIEW
						PlotBrainSurface.HOLD
						PlotBrainSurface.GRID
						PlotBrainSurface.AXIS
						PlotBrainSurface.EQUAL
						PlotBrainSurface.TIGHT
						PlotBrainSurface.BRAIN
						PlotBrainSurface.EDGECOLOR
						PlotBrainSurface.EDGEALPHA
						PlotBrainSurface.FACECOLOR
						PlotBrainSurface.FACEALPHA
						PlotBrainSurface.LIGHTING
						PlotBrainSurface.MATERIAL
						PlotBrainSurface.CAMLIGHT
						PlotBrainSurface.SHADING
						PlotBrainSurface.COLORMAP
						PlotBrainSurface.COLORMAPSTRING
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot brain surface.
			%
			% N = PlotBrainSurface.GETPROPNUMBER() returns the property number of plot brain surface.
			%
			% Alternative forms to call this method are:
			%  N = PL.GETPROPNUMBER() returns the property number of the plot brain surface PL.
			%  N = Element.GETPROPNUMBER(PL) returns the property number of 'PL'.
			%  N = Element.GETPROPNUMBER('PlotBrainSurface') returns the property number of 'PlotBrainSurface'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 21;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot brain surface/error.
			%
			% CHECK = PlotBrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSPROP(PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PL, PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PlotBrainSurface, PROP) checks whether PROP exists for PlotBrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSPROP(PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  Element.EXISTSPROP(PL, PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  Element.EXISTSPROP(PlotBrainSurface, PROP) throws error if PROP does NOT exist for PlotBrainSurface.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21 ]);
			else
				assert( ...
					PlotBrainSurface.existsProp(prop), ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotBrainSurface.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot brain surface/error.
			%
			% CHECK = PlotBrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSTAG(TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PL, TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PlotBrainSurface, TAG) checks whether TAG exists for PlotBrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSTAG(TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  Element.EXISTSTAG(PL, TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  Element.EXISTSTAG(PlotBrainSurface, TAG) throws error if TAG does NOT exist for PlotBrainSurface.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainsurface_tag_list = { 'id'  'bkgcolor'  'surf'  'axescolor'  'view'  'hold'  'grid'  'axis'  'equal'  'tight'  'brain'  'edgecolor'  'edgealpha'  'facecolor'  'facealpha'  'lighting'  'material'  'camlight'  'shading'  'colormap'  'colormapstring' };
				
				check = any(strcmpi(tag, plotbrainsurface_tag_list));
			else
				assert( ...
					PlotBrainSurface.existsTag(tag), ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotBrainSurface'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotBrainSurface, POINTER) returns property number of POINTER of PlotBrainSurface.
			%  PROPERTY = PL.GETPROPPROP(PlotBrainSurface, POINTER) returns property number of POINTER of PlotBrainSurface.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainsurface_tag_list = { 'id'  'bkgcolor'  'surf'  'axescolor'  'view'  'hold'  'grid'  'axis'  'equal'  'tight'  'brain'  'edgecolor'  'edgealpha'  'facecolor'  'facealpha'  'lighting'  'material'  'camlight'  'shading'  'colormap'  'colormapstring' };
				
				tag = pointer;
				PlotBrainSurface.existsTag(tag);
				
				prop = find(strcmpi(tag, plotbrainsurface_tag_list));
			else % numeric
				prop = pointer;
				PlotBrainSurface.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotBrainSurface, POINTER) returns tag of POINTER of PlotBrainSurface.
			%  TAG = PL.GETPROPTAG(PlotBrainSurface, POINTER) returns tag of POINTER of PlotBrainSurface.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotBrainSurface.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotBrainSurface.existsProp(prop);
				
				switch prop
					case PlotBrainSurface.SURF
						tag = PlotBrainSurface.SURF_TAG;
					case PlotBrainSurface.AXESCOLOR
						tag = PlotBrainSurface.AXESCOLOR_TAG;
					case PlotBrainSurface.VIEW
						tag = PlotBrainSurface.VIEW_TAG;
					case PlotBrainSurface.HOLD
						tag = PlotBrainSurface.HOLD_TAG;
					case PlotBrainSurface.GRID
						tag = PlotBrainSurface.GRID_TAG;
					case PlotBrainSurface.AXIS
						tag = PlotBrainSurface.AXIS_TAG;
					case PlotBrainSurface.EQUAL
						tag = PlotBrainSurface.EQUAL_TAG;
					case PlotBrainSurface.TIGHT
						tag = PlotBrainSurface.TIGHT_TAG;
					case PlotBrainSurface.BRAIN
						tag = PlotBrainSurface.BRAIN_TAG;
					case PlotBrainSurface.EDGECOLOR
						tag = PlotBrainSurface.EDGECOLOR_TAG;
					case PlotBrainSurface.EDGEALPHA
						tag = PlotBrainSurface.EDGEALPHA_TAG;
					case PlotBrainSurface.FACECOLOR
						tag = PlotBrainSurface.FACECOLOR_TAG;
					case PlotBrainSurface.FACEALPHA
						tag = PlotBrainSurface.FACEALPHA_TAG;
					case PlotBrainSurface.LIGHTING
						tag = PlotBrainSurface.LIGHTING_TAG;
					case PlotBrainSurface.MATERIAL
						tag = PlotBrainSurface.MATERIAL_TAG;
					case PlotBrainSurface.CAMLIGHT
						tag = PlotBrainSurface.CAMLIGHT_TAG;
					case PlotBrainSurface.SHADING
						tag = PlotBrainSurface.SHADING_TAG;
					case PlotBrainSurface.COLORMAP
						tag = PlotBrainSurface.COLORMAP_TAG;
					case PlotBrainSurface.COLORMAPSTRING
						tag = PlotBrainSurface.COLORMAPSTRING_TAG;
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
			%  CATEGORY = PL.GETPROPCATEGORY(POINTER) returns category of POINTER of PL.
			%  CATEGORY = Element.GETPROPCATEGORY(PlotBrainSurface, POINTER) returns category of POINTER of PlotBrainSurface.
			%  CATEGORY = PL.GETPROPCATEGORY(PlotBrainSurface, POINTER) returns category of POINTER of PlotBrainSurface.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					prop_category = PlotBrainSurface.SURF_CATEGORY;
				case PlotBrainSurface.AXESCOLOR
					prop_category = PlotBrainSurface.AXESCOLOR_CATEGORY;
				case PlotBrainSurface.VIEW
					prop_category = PlotBrainSurface.VIEW_CATEGORY;
				case PlotBrainSurface.HOLD
					prop_category = PlotBrainSurface.HOLD_CATEGORY;
				case PlotBrainSurface.GRID
					prop_category = PlotBrainSurface.GRID_CATEGORY;
				case PlotBrainSurface.AXIS
					prop_category = PlotBrainSurface.AXIS_CATEGORY;
				case PlotBrainSurface.EQUAL
					prop_category = PlotBrainSurface.EQUAL_CATEGORY;
				case PlotBrainSurface.TIGHT
					prop_category = PlotBrainSurface.TIGHT_CATEGORY;
				case PlotBrainSurface.BRAIN
					prop_category = PlotBrainSurface.BRAIN_CATEGORY;
				case PlotBrainSurface.EDGECOLOR
					prop_category = PlotBrainSurface.EDGECOLOR_CATEGORY;
				case PlotBrainSurface.EDGEALPHA
					prop_category = PlotBrainSurface.EDGEALPHA_CATEGORY;
				case PlotBrainSurface.FACECOLOR
					prop_category = PlotBrainSurface.FACECOLOR_CATEGORY;
				case PlotBrainSurface.FACEALPHA
					prop_category = PlotBrainSurface.FACEALPHA_CATEGORY;
				case PlotBrainSurface.LIGHTING
					prop_category = PlotBrainSurface.LIGHTING_CATEGORY;
				case PlotBrainSurface.MATERIAL
					prop_category = PlotBrainSurface.MATERIAL_CATEGORY;
				case PlotBrainSurface.CAMLIGHT
					prop_category = PlotBrainSurface.CAMLIGHT_CATEGORY;
				case PlotBrainSurface.SHADING
					prop_category = PlotBrainSurface.SHADING_CATEGORY;
				case PlotBrainSurface.COLORMAP
					prop_category = PlotBrainSurface.COLORMAP_CATEGORY;
				case PlotBrainSurface.COLORMAPSTRING
					prop_category = PlotBrainSurface.COLORMAPSTRING_CATEGORY;
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
			%  FORMAT = PL.GETPROPFORMAT(POINTER) returns format of POINTER of PL.
			%  FORMAT = Element.GETPROPFORMAT(PlotBrainSurface, POINTER) returns format of POINTER of PlotBrainSurface.
			%  FORMAT = PL.GETPROPFORMAT(PlotBrainSurface, POINTER) returns format of POINTER of PlotBrainSurface.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					prop_format = PlotBrainSurface.SURF_FORMAT;
				case PlotBrainSurface.AXESCOLOR
					prop_format = PlotBrainSurface.AXESCOLOR_FORMAT;
				case PlotBrainSurface.VIEW
					prop_format = PlotBrainSurface.VIEW_FORMAT;
				case PlotBrainSurface.HOLD
					prop_format = PlotBrainSurface.HOLD_FORMAT;
				case PlotBrainSurface.GRID
					prop_format = PlotBrainSurface.GRID_FORMAT;
				case PlotBrainSurface.AXIS
					prop_format = PlotBrainSurface.AXIS_FORMAT;
				case PlotBrainSurface.EQUAL
					prop_format = PlotBrainSurface.EQUAL_FORMAT;
				case PlotBrainSurface.TIGHT
					prop_format = PlotBrainSurface.TIGHT_FORMAT;
				case PlotBrainSurface.BRAIN
					prop_format = PlotBrainSurface.BRAIN_FORMAT;
				case PlotBrainSurface.EDGECOLOR
					prop_format = PlotBrainSurface.EDGECOLOR_FORMAT;
				case PlotBrainSurface.EDGEALPHA
					prop_format = PlotBrainSurface.EDGEALPHA_FORMAT;
				case PlotBrainSurface.FACECOLOR
					prop_format = PlotBrainSurface.FACECOLOR_FORMAT;
				case PlotBrainSurface.FACEALPHA
					prop_format = PlotBrainSurface.FACEALPHA_FORMAT;
				case PlotBrainSurface.LIGHTING
					prop_format = PlotBrainSurface.LIGHTING_FORMAT;
				case PlotBrainSurface.MATERIAL
					prop_format = PlotBrainSurface.MATERIAL_FORMAT;
				case PlotBrainSurface.CAMLIGHT
					prop_format = PlotBrainSurface.CAMLIGHT_FORMAT;
				case PlotBrainSurface.SHADING
					prop_format = PlotBrainSurface.SHADING_FORMAT;
				case PlotBrainSurface.COLORMAP
					prop_format = PlotBrainSurface.COLORMAP_FORMAT;
				case PlotBrainSurface.COLORMAPSTRING
					prop_format = PlotBrainSurface.COLORMAPSTRING_FORMAT;
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
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotBrainSurface, POINTER) returns description of POINTER of PlotBrainSurface.
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(PlotBrainSurface, POINTER) returns description of POINTER of PlotBrainSurface.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					prop_description = 'SURF (metadata, item) is the brain surface to be plotted.';
				case PlotBrainSurface.AXESCOLOR
					prop_description = 'AXESCOLOR (metadata, rvector) is axes background color.';
				case PlotBrainSurface.VIEW
					prop_description = 'VIEW (metadata, rvector) sets the desired view.';
				case PlotBrainSurface.HOLD
					prop_description = 'HOLD (metadata, logical) determines whether hold is on or offf.';
				case PlotBrainSurface.GRID
					prop_description = 'GRID (metadata, logical) determines whether the grid is shown.';
				case PlotBrainSurface.AXIS
					prop_description = 'AXIS (metadata, logical) determines whether the axis is shown.';
				case PlotBrainSurface.EQUAL
					prop_description = 'EQUAL (metadata, logical) determines whether the axis are equal.';
				case PlotBrainSurface.TIGHT
					prop_description = 'TIGHT (metadata, logical) determines whether the axis are tight.';
				case PlotBrainSurface.BRAIN
					prop_description = 'BRAIN (metadata, logical) determines whether the brain surface is shown.';
				case PlotBrainSurface.EDGECOLOR
					prop_description = 'EDGECOLOR (metadata, rvector) is the RGB edge color.';
				case PlotBrainSurface.EDGEALPHA
					prop_description = 'EDGEALPHA (metadata, scalar) is the edge transparency.';
				case PlotBrainSurface.FACECOLOR
					prop_description = 'FACECOLOR (metadata, rvector) is the RGB face color.';
				case PlotBrainSurface.FACEALPHA
					prop_description = 'FACEALPHA (metadata, scalar) is the face transparency.';
				case PlotBrainSurface.LIGHTING
					prop_description = 'LIGHTING (metadata, option) is the lighting value.';
				case PlotBrainSurface.MATERIAL
					prop_description = 'MATERIAL (metadata, option) is the material value.';
				case PlotBrainSurface.CAMLIGHT
					prop_description = 'CAMLIGHT (metadata, option) is the camlight value.';
				case PlotBrainSurface.SHADING
					prop_description = 'SHADING (metadata, option) is the shading value.';
				case PlotBrainSurface.COLORMAP
					prop_description = 'COLORMAP (metadata, matrix) is the colormap.';
				case PlotBrainSurface.COLORMAPSTRING
					prop_description = 'COLORMAPSTRING (metadata, string) is the colormap string value.';
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
			%  SETTINGS = PL.GETPROPSETTINGS(POINTER) returns settings of POINTER of PL.
			%  SETTINGS = Element.GETPROPSETTINGS(PlotBrainSurface, POINTER) returns settings of POINTER of PlotBrainSurface.
			%  SETTINGS = PL.GETPROPSETTINGS(PlotBrainSurface, POINTER) returns settings of POINTER of PlotBrainSurface.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					prop_settings = 'BrainSurface';
				case PlotBrainSurface.AXESCOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotBrainSurface.VIEW
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotBrainSurface.HOLD
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.GRID
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.AXIS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.EQUAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.TIGHT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.BRAIN
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PlotBrainSurface.EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotBrainSurface.EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotBrainSurface.FACECOLOR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PlotBrainSurface.FACEALPHA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PlotBrainSurface.LIGHTING
					prop_settings = {'phong' 'flat' 'gouraud' 'none'};
				case PlotBrainSurface.MATERIAL
					prop_settings = {'shiny' 'dull' 'metal'};
				case PlotBrainSurface.CAMLIGHT
					prop_settings = {'headlight' 'right' 'left'};
				case PlotBrainSurface.SHADING
					prop_settings = {'interp' 'flat' 'faceted' 'none'};
				case PlotBrainSurface.COLORMAP
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainSurface.COLORMAPSTRING
					prop_settings = Format.getFormatSettings(Format.STRING);
				otherwise
					prop_settings = getPropSettings@Plot(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotBrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotBrainSurface, POINTER) returns the default value of POINTER of PlotBrainSurface.
			%  DEFAULT = PL.GETPROPDEFAULT(PlotBrainSurface, POINTER) returns the default value of POINTER of PlotBrainSurface.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					prop_default = BrainAtlas.getPropDefault('SURF');
				case PlotBrainSurface.AXESCOLOR
					prop_default = [1 1 1];
				case PlotBrainSurface.VIEW
					prop_default = PlotBrainSurface.VIEW_3D_AZEL;
				case PlotBrainSurface.HOLD
					prop_default = true;
				case PlotBrainSurface.GRID
					prop_default = true;
				case PlotBrainSurface.AXIS
					prop_default = true;
				case PlotBrainSurface.EQUAL
					prop_default = true;
				case PlotBrainSurface.TIGHT
					prop_default = false;
				case PlotBrainSurface.BRAIN
					prop_default = true;
				case PlotBrainSurface.EDGECOLOR
					prop_default = [0 0 0];
				case PlotBrainSurface.EDGEALPHA
					prop_default = 0;
				case PlotBrainSurface.FACECOLOR
					prop_default = [.5 .5 .5];
				case PlotBrainSurface.FACEALPHA
					prop_default = .5;
				case PlotBrainSurface.LIGHTING
					prop_default = Format.getFormatDefault(Format.OPTION, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.MATERIAL
					prop_default = Format.getFormatDefault(Format.OPTION, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.CAMLIGHT
					prop_default = Format.getFormatDefault(Format.OPTION, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.SHADING
					prop_default = Format.getFormatDefault(Format.OPTION, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.COLORMAP
					prop_default = white;
				case PlotBrainSurface.COLORMAPSTRING
					prop_default = 'white';
				otherwise
					prop_default = getPropDefault@Plot(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotBrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotBrainSurface, POINTER) returns the conditioned default value of POINTER of PlotBrainSurface.
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(PlotBrainSurface, POINTER) returns the conditioned default value of POINTER of PlotBrainSurface.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			prop_default = PlotBrainSurface.conditioning(prop, PlotBrainSurface.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotBrainSurface, PROP, VALUE) checks VALUE format for PROP of PlotBrainSurface.
			%  CHECK = PL.CHECKPROP(PlotBrainSurface, PROP, VALUE) checks VALUE format for PROP of PlotBrainSurface.
			% 
			% PL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PL.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  Element.CHECKPROP(PlotBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainSurface.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			%  PL.CHECKPROP(PlotBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainSurface.
			%   Error id: [BRAPH2:PlotBrainSurface:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				case PlotBrainSurface.SURF
					check = Format.checkFormat(Format.ITEM, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.AXESCOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotBrainSurface.VIEW
					check = Format.checkFormat(Format.RVECTOR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = length(value) == 2;
					end
				case PlotBrainSurface.HOLD
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.GRID
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.AXIS
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.EQUAL
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.TIGHT
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.BRAIN
					check = Format.checkFormat(Format.LOGICAL, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.EDGECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotBrainSurface.EDGEALPHA
					check = Format.checkFormat(Format.SCALAR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = value >= 0 && value <= 1;
					end
				case PlotBrainSurface.FACECOLOR
					check = Format.checkFormat(Format.RVECTOR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = (length(value) == 3) && all(value >= 0 & value <= 1);
					end
				case PlotBrainSurface.FACEALPHA
					check = Format.checkFormat(Format.SCALAR, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = value >= 0 && value <= 1;
					end
				case PlotBrainSurface.LIGHTING
					check = Format.checkFormat(Format.OPTION, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.MATERIAL
					check = Format.checkFormat(Format.OPTION, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.CAMLIGHT
					check = Format.checkFormat(Format.OPTION, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.SHADING
					check = Format.checkFormat(Format.OPTION, value, PlotBrainSurface.getPropSettings(prop));
				case PlotBrainSurface.COLORMAP
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainSurface.getPropSettings(prop));
					if check
						check = size(value, 2) == 3;
					end
				case PlotBrainSurface.COLORMAPSTRING
					check = Format.checkFormat(Format.STRING, value, PlotBrainSurface.getPropSettings(prop));
				otherwise
					check = checkProp@Plot(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainSurface:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotBrainSurface.getPropTag(prop) ' (' PlotBrainSurface.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pl = PlotBrainSurface(varargin)
			% PlotBrainSurface() creates a plot brain surface.
			%
			% PlotBrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotBrainSurface(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotBrainSurface properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the plot.
			%  <strong>2</strong> <strong>bkgcolor</strong> 	BKGCOLOR (metadata, rvector) is background color.
			%  <strong>3</strong> <strong>surf</strong> 	SURF (metadata, item) is the brain surface to be plotted.
			%  <strong>4</strong> <strong>axescolor</strong> 	AXESCOLOR (metadata, rvector) is axes background color.
			%  <strong>5</strong> <strong>view</strong> 	VIEW (metadata, rvector) sets the desired view.
			%  <strong>6</strong> <strong>hold</strong> 	HOLD (metadata, logical) determines whether hold is on or offf.
			%  <strong>7</strong> <strong>grid</strong> 	GRID (metadata, logical) determines whether the grid is shown.
			%  <strong>8</strong> <strong>axis</strong> 	AXIS (metadata, logical) determines whether the axis is shown.
			%  <strong>9</strong> <strong>equal</strong> 	EQUAL (metadata, logical) determines whether the axis are equal.
			%  <strong>10</strong> <strong>tight</strong> 	TIGHT (metadata, logical) determines whether the axis are tight.
			%  <strong>11</strong> <strong>brain</strong> 	BRAIN (metadata, logical) determines whether the brain surface is shown.
			%  <strong>12</strong> <strong>edgecolor</strong> 	EDGECOLOR (metadata, rvector) is the RGB edge color.
			%  <strong>13</strong> <strong>edgealpha</strong> 	EDGEALPHA (metadata, scalar) is the edge transparency.
			%  <strong>14</strong> <strong>facecolor</strong> 	FACECOLOR (metadata, rvector) is the RGB face color.
			%  <strong>15</strong> <strong>facealpha</strong> 	FACEALPHA (metadata, scalar) is the face transparency.
			%  <strong>16</strong> <strong>lighting</strong> 	LIGHTING (metadata, option) is the lighting value.
			%  <strong>17</strong> <strong>material</strong> 	MATERIAL (metadata, option) is the material value.
			%  <strong>18</strong> <strong>camlight</strong> 	CAMLIGHT (metadata, option) is the camlight value.
			%  <strong>19</strong> <strong>shading</strong> 	SHADING (metadata, option) is the shading value.
			%  <strong>20</strong> <strong>colormap</strong> 	COLORMAP (metadata, matrix) is the colormap.
			%  <strong>21</strong> <strong>colormapstring</strong> 	COLORMAPSTRING (metadata, string) is the colormap string value.
			%
			% See also Category, Format, set, check.
			
			pl = pl@Plot(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotBrainSurface.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Plot.getPropNumber()
						value = conditioning@Plot(pointer, value);
					end
			end
		end
	end
	methods % methods
		function h_panel = draw(pl, varargin)
		    %DRAW draws the brain surface graphical panel.
		    %
		    % DRAW(PL) draws the brain surface graphical panel.
		    %
		    % H = DRAW(PL) returns a handle to the brain surface graphical panel.
		    %
		    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
		    %  panel with custom property-value couples.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle to the brain surface graphical panel H.
		    %
		    % see also settings, uipanel, isgraphics.
		
		    pl.pp = draw@Plot(pl, varargin{:});
		
		    % axes
		    if isempty(pl.h_axes) || ~isgraphics(pl.h_axes, 'axes')
		        pl.h_axes = axes(pl.pp);
		    end
		    
		    % brain
		    if pl.get('BRAIN')
		        if isempty(pl.h_brain) || ~isgraphics(pl.h_brain, 'patch')
		            triangles = pl.get('SURF').get('TRIANGLES');
		            coordinates = pl.get('SURF').get('COORDINATES');
		            pl.h_brain = trisurf( ...
		                triangles, ...
		                coordinates(:, 1), ...
		                coordinates(:, 2), ...
		                coordinates(:, 3), ...
		                'Parent', pl.h_axes ...
		                );
		            xlabel(pl.h_axes, 'Sagital')
		            ylabel(pl.h_axes, 'Axial')
		            zlabel(pl.h_axes, 'Coronal')
		            h_3d = rotate3d(pl.h_axes);
		            h_3d.ActionPostCallback = @cb_rotate_3d;
		        end
		        has_background = get_from_varargin([], 'Backgroundcolor', varargin{:});
		        if isempty(has_background)
		            set(pl.pp, 'Backgroundcolor', 'w');
		        end
		        set(pl.h_brain, ...
		            'Visible', 'on', ...
		            'EdgeColor', pl.get('EDGECOLOR'), ...
		            'EdgeAlpha', pl.get('EDGEALPHA'), ...
		            'FaceColor', pl.get('FACECOLOR'), ...
		            'FaceAlpha', pl.get('FACEALPHA') ...
		            )
		        lighting(pl.h_axes, pl.get('LIGHTING'))
		
		        material(pl.h_axes, pl.get('MATERIAL'))
		
		    else
		        if ~isempty(pl.h_brain) && isgraphics(pl.h_brain, 'patch')
		            set(pl.h_brain, 'Visible', 'off')
		        end
		    end
		    
		    % plot settings
		    set(pl.h_axes, 'Color', pl.get('AXESCOLOR'))
		
		    view(pl.h_axes, pl.get('VIEW'))
		    
		    delete(findall(pl.h_axes, 'Type', 'light'));
		    camlight(pl.h_axes, pl.get('CAMLIGHT'))
		    
		    colormap(pl.h_axes, pl.get('COLORMAP'))
		    
		    if ~strcmpi(pl.get('SHADING'), 'none')
		        shading(pl.h_axes, pl.get('SHADING'))
		    end
		    
		    if pl.get('HOLD')
		        hold(pl.h_axes, 'on')
		    else
		        hold(pl.h_axes, 'off')
		    end
		
		    if pl.get('GRID')
		        grid(pl.h_axes, 'on')
		    else
		        grid(pl.h_axes, 'off')
		    end
		
		    if pl.get('AXIS')
		        axis(pl.h_axes, 'on')
		    else
		        axis(pl.h_axes, 'off')
		    end
		    
		    if pl.get('EQUAL')
		        daspect(pl.h_axes, [1 1 1])
		    end
		    
		    if pl.get('TIGHT')
		        axis(pl.h_axes, 'tight')
		    end
		    
		    function cb_rotate_3d(~, ~)
		        view_3d = get(pl.h_axes, 'view');
		        pl.set('View', view_3d);
		    end
		    
		    % output
		    if nargout > 0
		        h_panel = pl.pp;
		    end
		end
		function f_settings = settings(pl, varargin)
		    %SETTINGS opens the brain surface property editor GUI.
		    %
		    % SETTINGS(PL) allows the user to specify the properties of the brain
		    %  surface plot by opening a GUI property editor.
		    %
		    % F = SETTINGS(PL) returns a handle to the brain surface property editor GUI.
		    %
		    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the brain
		    %  surface property editor GUI with custom property-value couples.
		    %  All standard plot properties of figure can be used.
		    %
		    % See also draw, figure, isgraphics.
		
		    f = settings@Plot(pl, varargin{:});    
		    set_braph2icon(f);
		
		    % toolbar
		    set(f, 'Toolbar', 'figure')
		
		    ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
		    ui_toolbar_3D = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_3D_CMD, ...
		        'CData', imread('icon_view_3d.png'), ...
		        'ClickedCallback', {@cb_toolbar_3D});
		
		        function cb_toolbar_3D(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_3D_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_SL = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_SL_CMD, ...
		        'CData', imread('icon_view_sl.png'), ...
		        'ClickedCallback', {@cb_toolbar_SL});
		
		        function cb_toolbar_SL(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_SL_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_SR = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_SR_CMD, ...
		        'CData', imread('icon_view_sr.png'), ...
		        'ClickedCallback', {@cb_toolbar_SR});
		
		        function cb_toolbar_SR(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_SR_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_AD = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_AD_CMD, ...
		        'CData', imread('icon_view_ad.png'), ...
		        'ClickedCallback', {@cb_toolbar_AD});
		
		        function cb_toolbar_AD(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_AD_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_AV = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_AV_CMD, ...
		        'CData', imread('icon_view_av.png'), ...
		        'ClickedCallback', {@cb_toolbar_AV});
		
		        function cb_toolbar_AV(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_AV_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_CA = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_CA_CMD, ...
		        'CData', imread('icon_view_ca.png'), ...
		        'ClickedCallback', {@cb_toolbar_CA});
		
		        function cb_toolbar_CA(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_CA_AZEL)
		            pl.draw()
		        end
		
		    ui_toolbar_CP = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', PlotBrainSurface.VIEW_CP_CMD, ...
		        'CData', imread('icon_view_cp.png'), ...
		        'ClickedCallback', {@cb_toolbar_CP});
		
		        function cb_toolbar_CP(~, ~)  % (src, event)
		            pl.set('VIEW', PlotBrainSurface.VIEW_CP_AZEL)
		            pl.draw()
		        end
		    
		    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
		    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
		
		    if pl.get('BRAIN')
		        ui_toolbar_brain_state = 'on';
		    else
		        ui_toolbar_brain_state = 'off';
		    end        
		    ui_toolbar_brain = uitoggletool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'State', ui_toolbar_brain_state, ...
		        'TooltipString', 'Show Brain', ...
		        'CData', imread('icon_brain.png'), ...
		        'OnCallback', {@cb_toolbar_brain_on}, ...
		        'OffCallback', {@cb_toolbar_brain_off});
		
		        function cb_toolbar_brain_on(~, ~)  % (src, event)
		            pl.set('BRAIN', true)
		            pl.draw()
		        end
		        function cb_toolbar_brain_off(~, ~)  % (src, event)
		            pl.set('BRAIN', false)
		            pl.draw()
		        end
		
		    if pl.get('AXIS')
		        ui_toolbar_axis_state = 'on';
		    else
		        ui_toolbar_axis_state = 'off';
		    end        
		    ui_toolbar_axis = uitoggletool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'State', ui_toolbar_axis_state, ...
		        'TooltipString', 'Show axis', ...
		        'CData', imread('icon_axis.png'), ...
		        'OnCallback', {@cb_toolbar_axis_on}, ...
		        'OffCallback', {@cb_toolbar_axis_off});
		
		        function cb_toolbar_axis_on(~, ~)  % (src, event)
		            pl.set('axis', true);
		            pl.draw();
		        end
		        function cb_toolbar_axis_off(~, ~)  % (src, event)
		            pl.set('axis', false);
		            pl.draw();
		        end
		
		    if pl.get('GRID')
		        ui_toolbar_grid_state = 'on';
		    else
		        ui_toolbar_grid_state = 'off';
		    end        
		    ui_toolbar_grid = uitoggletool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'State', ui_toolbar_grid_state, ...
		        'TooltipString', 'Show grid', ...
		        'CData', imread('icon_grid.png'), ...
		        'OnCallback', {@cb_toolbar_grid_on}, ...
		        'OffCallback', {@cb_toolbar_grid_off});
		
		        function cb_toolbar_grid_on(~, ~)  % (src, event)
		            pl.set('grid', true);
		            pl.draw();
		        end
		        function cb_toolbar_grid_off(~, ~)  % (src, event)
		            pl.set('grid', false);
		            pl.draw();
		        end
		
		    init_toolbar()
		        function init_toolbar()
		            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
		            delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
		            delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
		            delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
		            delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
		            delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
		            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
		            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
		            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
		            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
		            delete(findall(ui_toolbar, 'ToolTipString', 'Save Figure'))
		            delete(findall(ui_toolbar, 'ToolTipString', 'Open File'))
		        end
		
		    % panel
		    ui_surface_panel = uipanel(f, ...
		        'Units', 'normalized', ...
		        'BackgroundColor', [1 .9725 .929], ...
		        'Position', [0 0 1 1]);
		    % background color
		    ui_button_backgroundcolor = uicontrol(ui_surface_panel, 'Style', 'pushbutton', ...
		        'Units','normalized', ...
		        'Position', [.05 .75 .20 .20], ...
		        'String', 'background color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Image background color', ...
		        'Callback', {@cb_backgroundcolor});
		
		        function cb_backgroundcolor(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pl.set('AXESCOLOR', color)
		                pl.draw()
		            end
		        end
		
		    % brain color and transparency
		    ui_text_transparency = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'transparency', ...
		        'Position', [.25 .60 .35 .20], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		
		    ui_button_color = uicontrol(ui_surface_panel, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.05 .50 .15 .20], ...
		        'String', 'brain color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Brain surface color (applied both to faces and edges)', ...
		        'Callback', {@cb_color});
		
		    ui_slider_alpha = uicontrol(ui_surface_panel, 'Style', 'slider', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'Position', [.25 .50 .35 .15], ...
		        'String', 'Brain transparency', ...
		        'Min', 0, 'Max', 1, 'Value', max(pl.get('FACEALPHA'), pl.get('EDGEALPHA')), ...
		        'TooltipString', 'Brain surface transparency (applied both to faces and edges)', ...
		        'Callback', {@cb_alpha});
		
		    ui_button_facecolor = uicontrol(ui_surface_panel, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.05 .30 .15 .20], ...
		        'String', 'face color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Brain surface face color', ...
		        'Callback', {@cb_facecolor});
		
		    ui_slider_facealpha = uicontrol(ui_surface_panel, 'Style', 'slider', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'Position', [.25 .30 .35 .15], ...
		        'String', 'Brain transparency', ...
		        'Min', 0, 'Max', 1, 'Value', pl.get('FACEALPHA'), ...
		        'TooltipString', 'Brain surface face transparency', ...
		        'Callback', {@cb_facealpha});
		
		    ui_button_edgecolor = uicontrol(ui_surface_panel, 'Style', 'pushbutton', ...
		        'Units', 'normalized', ...
		        'Position', [.05 .10 .15 .20], ...
		        'String', 'edge color', ...
		        'HorizontalAlignment', 'center', ...
		        'TooltipString', 'Brain surface edge color', ...
		        'Callback', {@cb_edgecolor});
		
		    ui_slider_edgealpha = uicontrol(ui_surface_panel, 'Style', 'slider', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'Position', [.25 .10 .35 .15], ...
		        'String', 'Brain transparency', ...
		        'Min', 0, 'Max', 1, 'Value', pl.get('EDGEALPHA'), ...
		        'TooltipString', 'Brain surface edge transparency', ...
		        'Callback', {@cb_edgealpha});
		
		        function cb_color(~, ~) % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pl.set('FACECOLOR', color, 'EDGECOLOR', color)
		                set(pl.h_brain, 'FACECOLOR', color, 'EDGECOLOR', color)
		            end
		        end
		        function cb_alpha(~, ~)  % (src, event)
		            pl.set('FACEALPHA', get(ui_slider_alpha, 'Value'), 'EDGEALPHA', get(ui_slider_alpha, 'Value'))
		            pl.draw()
		            set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
		            set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
		        end
		        function cb_facecolor(~, ~)  % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pl.set('FACECOLOR', color)
		                set(pl.h_brain, 'FACECOLOR', color)
		            end
		        end
		        function cb_facealpha(~, ~)  % (src, event)
		            pl.set('FACEALPHA', get(ui_slider_facealpha, 'Value'))
		            pl.draw()
		        end
		        function cb_edgecolor(~, ~)  % (src, event)
		            color = uisetcolor;
		            if length(color) == 3
		                pl.set('EDGECOLOR', color)
		                set(pl.h_brain, 'EDGECOLOR', color)
		            end
		        end
		        function cb_edgealpha(~, ~)  % (src, event)
		            pl.set('EDGEALPHA', get(ui_slider_edgealpha, 'Value'))
		            pl.draw()
		        end
		
		    % lightining
		    ui_text_lighting = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units','normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'lighting', ...
		        'Position', [.65 .70 .10 .15], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		
		    ui_popup_lighting = uicontrol(ui_surface_panel, 'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.75 .70 .20 .15], ...
		        'String', PlotBrainSurface.getPropSettings('LIGHTING'), ...
		        'Value', find(strcmpi(pl.get('LIGHTING'), PlotBrainSurface.getPropSettings('LIGHTING'))), ...
		        'HorizontalAlignment', 'center', ...
		        'Callback', {@cb_lighting});
		
		        function cb_lighting(~, ~)  % (src, event)
		            val = ui_popup_lighting.Value;
		            str = ui_popup_lighting.String;
		            pl.set('LIGHTING', str{val})
		            pl.draw()
		        end
		
		    % material
		    ui_text_material = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'material', ...
		        'Position', [.65 .55 .10 .15], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		
		    ui_popup_material = uicontrol(ui_surface_panel, 'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.75 .55 .20 .15], ...
		        'String', PlotBrainSurface.getPropSettings('MATERIAL'), ...
		        'Value', find(strcmpi(pl.get('MATERIAL'), PlotBrainSurface.getPropSettings('MATERIAL'))), ...
		        'HorizontalAlignment', 'center', ...
		        'Callback', {@cb_material});
		
		        function cb_material(~, ~)  % (src, event)
		            val = ui_popup_material.Value;
		            str = ui_popup_material.String;
		            pl.set('MATERIAL', str{val})
		            pl.draw()
		        end
		
		    % camlight
		    ui_text_camlight = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'camlight', ...
		        'Position', [.65 .40 .10 .15], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		
		    ui_popup_camlight = uicontrol(ui_surface_panel, 'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.75 .40 .20 .15], ...
		        'String', PlotBrainSurface.getPropSettings('CAMLIGHT'), ...
		        'Value', find(strcmpi(pl.get('CAMLIGHT'), PlotBrainSurface.getPropSettings('CAMLIGHT'))), ...
		        'HorizontalAlignment', 'center', ...
		        'Callback', {@cb_camlight});
		
		        function cb_camlight(~, ~)  % (src, event)
		            val = ui_popup_camlight.Value;
		            str = ui_popup_camlight.String;
		            pl.set('CAMLIGHT', str{val})
		            pl.draw()
		        end
		
		    % shading
		    ui_text_shading = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'shading', ...
		        'Position', [.65 .25 .10 .15], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		
		    ui_popup_shading = uicontrol(ui_surface_panel, 'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.75 .25 .20 .15], ...
		        'String', PlotBrainSurface.getPropSettings('SHADING'), ...
		        'Value', find(strcmpi(pl.get('SHADING'), PlotBrainSurface.getPropSettings('SHADING'))), ...
		        'HorizontalAlignment', 'center', ...
		        'Callback', {@cb_shading});
		
		        function cb_shading(~, ~)  % (src, event)
		            val = ui_popup_shading.Value;
		            str = ui_popup_shading.String;
		            pl.set('SHADING', str{val})
		            pl.draw()
		        end
		
		    % colormap
		    ui_text_colormap = uicontrol(ui_surface_panel, 'Style', 'text', ...
		        'Units', 'normalized', ...
		        'BackgroundColor', pl.get('BKGCOLOR'), ...
		        'String', 'colormap', ...
		        'Position', [.65 .10 .10 .15], ...
		        'HorizontalAlignment', 'center', ...
		        'FontWeight', 'bold');
		    
		    cm_values = {'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', ...
		        'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', ...
		        'pink', 'lines', 'colorcube', 'prism', 'flag', 'white'};
		
		    ui_popup_colormap = uicontrol(ui_surface_panel, 'Style', 'popupmenu', ...
		        'Units', 'normalized', ...
		        'Position', [.75 .10 .20 .15], ...
		        'String', cm_values, ... % set(ui_popup_colormap, 'Value', find(strcmpi(bs.Colormap, get(ui_popup_colormap, 'String'))))
		        'HorizontalAlignment', 'center', ...
		        'Value',  find(strcmpi(pl.get('COLORMAPSTRING'), cm_values)),...
		        'Callback', {@cb_colormap});
		
		        function cb_colormap(~, ~)  % (src, event)
		            val = ui_popup_colormap.Value;
		            str = ui_popup_colormap.String;
		            pl.set('COLORMAPSTRING', str{val})
		            pl.set('COLORMAP', eval(str{val}))
		            pl.draw()
		        end
		
		    % output
		    if nargout > 0
		        f_settings = f;
		    end
		end
	end
end
