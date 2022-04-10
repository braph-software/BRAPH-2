classdef PlotBrainAtlas < PlotBrainSurface
	% PlotBrainAtlas is a plot of a brain atlas.
	% It is a subclass of <a href="matlab:help PlotBrainSurface">PlotBrainSurface</a>.
	%
	% PlotBrainAtlas manages the plot of the brain regions symbols,
	% spheres, ids and labels. PlotBrainAtlas utilizes the surface created
	% from PlotBrainSurface to integrate the regions to a brain surface.
	%
	% The list of PlotBrainAtlas properties is:
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
	%  <strong>22</strong> <strong>atlas</strong> 	ATLAS (metadata, item) is the brain atlas with the brain regions.
	%  <strong>23</strong> <strong>parent</strong> 	Parent (data, item) is the plot parent figure
	%  <strong>24</strong> <strong>syms</strong> 	SYMS (metadata, cvector) is symbol visibility.
	%  <strong>25</strong> <strong>syms_size</strong> 	SYMS_SIZE (metadata, cvector) is the symbol size.
	%  <strong>26</strong> <strong>syms_marker</strong> 	SYMS_MARKER (metadata, cvector) is the symbol option.
	%  <strong>27</strong> <strong>syms_face_color</strong> 	SYMS_FACE_COLOR (metadata, matrix) is the symbol face color.
	%  <strong>28</strong> <strong>syms_edge_color</strong> 	SYMS_EDGE_COLOR (metadata, matrix) is the symbol edge color.
	%  <strong>29</strong> <strong>sphs</strong> 	SPHS (metadata, cvector) is sphere visibility.
	%  <strong>30</strong> <strong>sphs_size</strong> 	SPHS_SIZE (metadata, cvector) is the sphere size.
	%  <strong>31</strong> <strong>sphs_edge_color</strong> 	SPHS_EDGE_COLOR (metadata, matrix) is the sphere edge color.
	%  <strong>32</strong> <strong>sphs_face_color</strong> 	SPHS_FACE_COLOR (metadata, matrix) is the sphere face color.
	%  <strong>33</strong> <strong>sphs_edge_alpha</strong> 	SPHS_EDGE_ALPHA (metadata, cvector) is the sphere alpha.
	%  <strong>34</strong> <strong>sphs_face_alpha</strong> 	SPHS_FACE_ALPHA (metadata, cvector) is the sphere alpha.
	%  <strong>35</strong> <strong>ids</strong> 	IDS (metadata, cvector) is the ids visibility.
	%  <strong>36</strong> <strong>ids_size</strong> 	IDS_SIZE (metadata, cvector) is the ids size.
	%  <strong>37</strong> <strong>ids_font_color</strong> 	IDS_FONT_COLOR (metadata, matrix) is the ids font color.
	%  <strong>38</strong> <strong>ids_font_name</strong> 	IDS_FONT_NAME (metadata, string) is the ids font name.
	%  <strong>39</strong> <strong>ids_font_interpreter</strong> 	IDS_FONT_INTERPRETER (metadata, cvector) is the ids font interpreter.
	%  <strong>40</strong> <strong>labs</strong> 	LABS (metadata, cvector) is the labs visibility.
	%  <strong>41</strong> <strong>labs_size</strong> 	LABS_SIZE (metadata, cvector) is the labs size.
	%  <strong>42</strong> <strong>labs_font_color</strong> 	LABS_FONT_COLOR (metadata, matrix) is the labs font color.
	%  <strong>43</strong> <strong>labs_font_name</strong> 	LABS_FONT_NAME (metadata, string) is the labs font name.
	%  <strong>44</strong> <strong>labs_font_interpreter</strong> 	LABS_FONT_INTERPRETER (metadata, cvector) is the labs font interpreter.
	%
	% PlotBrainAtlas methods (constructor):
	% PlotBrainAtlas - constructor
	%
	% PlotBrainAtlas methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in plot brain atlas/error.
	%  existsProp - checks whether property exists in plot brain atlas/error.
	%  getPropNumber - returns the property number of plot brain atlas.
	%  getProps - returns the property list of plot brain atlas.
	%  getDescription - returns the description of the plot brain atlas.
	%  getName - returns the name of the plot brain atlas.
	%  getClass - returns the class of the plot brain atlas.
	%  h - returns the height of a graphical element.
	%  w - returns the width of a graphical element.
	%  y0 - returns the position of the bottom edge of a graphical element.
	%  x0 - returns the position of the left edge of a graphical element.
	%
	% PlotBrainAtlas methods:
	%  cb_hide - hides the figure containing the panel and the settings figure.
	%  cb_bring_to_front - brings to front the brain atlas figure and its settings figure.
	%  labs_settings - S panel to set labels properties
	%  ids_settings - S panel to set ids properties
	%  sphs_settings - S panel to set spheres properties
	%  syms_settings - S panel to set symbols properties
	%  settings - opens the brain surface property editor GUI.
	%  draw - draws the brain atlas graphical panel.
	%  set_settings - s/set_settings is a function.
	%  cb_close - closes the figure containing the panel and the settings figure.
	%  cb_close_fs - as/cb_close_fs is a function.
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
	% PlotBrainAtlas methods (operators):
	%  isequal - determines whether two PlotBrainAtlas are equal (values, locked)
	%
	% PlotBrainAtlas methods (display):
	%  tostring - string with information about the PlotBrainAtlas
	%  disp - displays information about the PlotBrainAtlas
	%  tree - displays the element of PlotBrainAtlas
	%
	% PlotBrainAtlas method (element list):
	%  getElementList - returns a list with all subelements of PlotBrainAtlas
	%
	% PlotBrainAtlas method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the PlotBrainAtlas
	%
	% PlotBrainAtlas method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the PlotBrainAtlas
	%
	% PlotBrainAtlas methods (copy):
	%  copy - copies the PlotBrainAtlas
	%  deepclone - deep-clones the PlotBrainAtlas
	%  clone - clones the PlotBrainAtlas
	%
	% PlotBrainAtlas methods (inspection, Static):
	%  getClass - returns PlotBrainAtlas
	%  getName - returns the name of PlotBrainAtlas
	%  getDescription - returns the description of PlotBrainAtlas
	%  getProps - returns the property list of PlotBrainAtlas
	%  getPropNumber - returns the property number of PlotBrainAtlas
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
	% PlotBrainAtlas methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PlotBrainAtlas methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% PlotBrainAtlas methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% PlotBrainAtlas methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% PlotBrainAtlas properties (Constant).
	%  PLOT_SYMBOL_NAME - cell[1 14] { 'point' 'circle' 'x-mark' 'plus' 'star' 'square' 'diamond' 'triangle (down)' 'triangle (up)' 'triangle (left)' 'triangle (right)' 'pentagram' 'hexagram' 'none' }
	%  PLOT_SYMBOL_TAG - cell[1 14] { '.' 'o' 'x' '+' '*' 's' 'd' 'v' '^' '>' '<' 'p' 'h' 'none' }
	%  PLOT_ID_FONT_INTREPETER - cell[1 3] { 'none' 'tex' 'latex' }
	%  ATLAS - 22
	%  ATLAS_TAG - 'atlas'
	%  ATLAS_CATEGORY - 'm'
	%  ATLAS_FORMAT - 'it'
	%  PARENT - 23
	%  PARENT_TAG - 'parent'
	%  PARENT_CATEGORY - 'd'
	%  PARENT_FORMAT - 'it'
	%  SYMS - 24
	%  SYMS_TAG - 'syms'
	%  SYMS_CATEGORY - 'm'
	%  SYMS_FORMAT - 'nc'
	%  SYMS_SIZE - 25
	%  SYMS_SIZE_TAG - 'syms_size'
	%  SYMS_SIZE_CATEGORY - 'm'
	%  SYMS_SIZE_FORMAT - 'nc'
	%  SYMS_MARKER - 26
	%  SYMS_MARKER_TAG - 'syms_marker'
	%  SYMS_MARKER_CATEGORY - 'm'
	%  SYMS_MARKER_FORMAT - 'nc'
	%  SYMS_FACE_COLOR - 27
	%  SYMS_FACE_COLOR_TAG - 'syms_face_color'
	%  SYMS_FACE_COLOR_CATEGORY - 'm'
	%  SYMS_FACE_COLOR_FORMAT - 'nm'
	%  SYMS_EDGE_COLOR - 28
	%  SYMS_EDGE_COLOR_TAG - 'syms_edge_color'
	%  SYMS_EDGE_COLOR_CATEGORY - 'm'
	%  SYMS_EDGE_COLOR_FORMAT - 'nm'
	%  SPHS - 29
	%  SPHS_TAG - 'sphs'
	%  SPHS_CATEGORY - 'm'
	%  SPHS_FORMAT - 'nc'
	%  SPHS_SIZE - 30
	%  SPHS_SIZE_TAG - 'sphs_size'
	%  SPHS_SIZE_CATEGORY - 'm'
	%  SPHS_SIZE_FORMAT - 'nc'
	%  SPHS_EDGE_COLOR - 31
	%  SPHS_EDGE_COLOR_TAG - 'sphs_edge_color'
	%  SPHS_EDGE_COLOR_CATEGORY - 'm'
	%  SPHS_EDGE_COLOR_FORMAT - 'nm'
	%  SPHS_FACE_COLOR - 32
	%  SPHS_FACE_COLOR_TAG - 'sphs_face_color'
	%  SPHS_FACE_COLOR_CATEGORY - 'm'
	%  SPHS_FACE_COLOR_FORMAT - 'nm'
	%  SPHS_EDGE_ALPHA - 33
	%  SPHS_EDGE_ALPHA_TAG - 'sphs_edge_alpha'
	%  SPHS_EDGE_ALPHA_CATEGORY - 'm'
	%  SPHS_EDGE_ALPHA_FORMAT - 'nc'
	%  SPHS_FACE_ALPHA - 34
	%  SPHS_FACE_ALPHA_TAG - 'sphs_face_alpha'
	%  SPHS_FACE_ALPHA_CATEGORY - 'm'
	%  SPHS_FACE_ALPHA_FORMAT - 'nc'
	%  IDS - 35
	%  IDS_TAG - 'ids'
	%  IDS_CATEGORY - 'm'
	%  IDS_FORMAT - 'nc'
	%  IDS_SIZE - 36
	%  IDS_SIZE_TAG - 'ids_size'
	%  IDS_SIZE_CATEGORY - 'm'
	%  IDS_SIZE_FORMAT - 'nc'
	%  IDS_FONT_COLOR - 37
	%  IDS_FONT_COLOR_TAG - 'ids_font_color'
	%  IDS_FONT_COLOR_CATEGORY - 'm'
	%  IDS_FONT_COLOR_FORMAT - 'nm'
	%  IDS_FONT_NAME - 38
	%  IDS_FONT_NAME_TAG - 'ids_font_name'
	%  IDS_FONT_NAME_CATEGORY - 'm'
	%  IDS_FONT_NAME_FORMAT - 'st'
	%  IDS_FONT_INTERPRETER - 39
	%  IDS_FONT_INTERPRETER_TAG - 'ids_font_interpreter'
	%  IDS_FONT_INTERPRETER_CATEGORY - 'm'
	%  IDS_FONT_INTERPRETER_FORMAT - 'nc'
	%  LABS - 40
	%  LABS_TAG - 'labs'
	%  LABS_CATEGORY - 'm'
	%  LABS_FORMAT - 'nc'
	%  LABS_SIZE - 41
	%  LABS_SIZE_TAG - 'labs_size'
	%  LABS_SIZE_CATEGORY - 'm'
	%  LABS_SIZE_FORMAT - 'nc'
	%  LABS_FONT_COLOR - 42
	%  LABS_FONT_COLOR_TAG - 'labs_font_color'
	%  LABS_FONT_COLOR_CATEGORY - 'm'
	%  LABS_FONT_COLOR_FORMAT - 'nm'
	%  LABS_FONT_NAME - 43
	%  LABS_FONT_NAME_TAG - 'labs_font_name'
	%  LABS_FONT_NAME_CATEGORY - 'm'
	%  LABS_FONT_NAME_FORMAT - 'st'
	%  LABS_FONT_INTERPRETER - 44
	%  LABS_FONT_INTERPRETER_TAG - 'labs_font_interpreter'
	%  LABS_FONT_INTERPRETER_CATEGORY - 'm'
	%  LABS_FONT_INTERPRETER_FORMAT - 'nc'
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
	% See also Plot, BrainSurface, PlotBrainSurface.
	
	properties (Constant) % constants
		PLOT_SYMBOL_NAME = { ...
		    'point' ...
		    'circle' ...
		    'x-mark' ...
		    'plus' ...
		    'star' ...
		    'square' ...
		    'diamond' ...
		    'triangle (down)' ...
		    'triangle (up)' ...
		    'triangle (left)' ...
		    'triangle (right)' ...
		    'pentagram' ...
		    'hexagram' ...
		    'none' ...
		    }
		
		PLOT_SYMBOL_TAG = { ...
		    '.' ...
		    'o' ...
		    'x' ...
		    '+' ...
		    '*' ...
		    's' ...
		    'd' ...
		    'v' ...
		    '^' ...
		    '>' ...
		    '<' ...
		    'p' ...
		    'h' ...
		    'none' ...
		    }
		
		PLOT_ID_FONT_INTREPETER = { ...
		    'none' ...
		    'tex' ...
		    'latex' ...
		    }
	end
	properties (Access = private) % element properties
		h_syms % handle for the symbols 
		h_sphs % handle for the spheres 
		h_ids % handle for the id 
		h_labs % handle for the labs 
		
		f_settings
		f_settings_buttons
		f_syms_settings
		f_sphs_settings
		f_ids_settings
		f_labs_settings
		
		pp
		h_axes
	end
	properties (Constant) % properties
		ATLAS = PlotBrainSurface.getPropNumber() + 1;
		ATLAS_TAG = 'atlas';
		ATLAS_CATEGORY = Category.METADATA;
		ATLAS_FORMAT = Format.ITEM;
		
		PARENT = PlotBrainSurface.getPropNumber() + 2;
		PARENT_TAG = 'parent';
		PARENT_CATEGORY = Category.DATA;
		PARENT_FORMAT = Format.ITEM;
		
		SYMS = PlotBrainSurface.getPropNumber() + 3;
		SYMS_TAG = 'syms';
		SYMS_CATEGORY = Category.METADATA;
		SYMS_FORMAT = Format.CVECTOR;
		
		SYMS_SIZE = PlotBrainSurface.getPropNumber() + 4;
		SYMS_SIZE_TAG = 'syms_size';
		SYMS_SIZE_CATEGORY = Category.METADATA;
		SYMS_SIZE_FORMAT = Format.CVECTOR;
		
		SYMS_MARKER = PlotBrainSurface.getPropNumber() + 5;
		SYMS_MARKER_TAG = 'syms_marker';
		SYMS_MARKER_CATEGORY = Category.METADATA;
		SYMS_MARKER_FORMAT = Format.CVECTOR;
		
		SYMS_FACE_COLOR = PlotBrainSurface.getPropNumber() + 6;
		SYMS_FACE_COLOR_TAG = 'syms_face_color';
		SYMS_FACE_COLOR_CATEGORY = Category.METADATA;
		SYMS_FACE_COLOR_FORMAT = Format.MATRIX;
		
		SYMS_EDGE_COLOR = PlotBrainSurface.getPropNumber() + 7;
		SYMS_EDGE_COLOR_TAG = 'syms_edge_color';
		SYMS_EDGE_COLOR_CATEGORY = Category.METADATA;
		SYMS_EDGE_COLOR_FORMAT = Format.MATRIX;
		
		SPHS = PlotBrainSurface.getPropNumber() + 8;
		SPHS_TAG = 'sphs';
		SPHS_CATEGORY = Category.METADATA;
		SPHS_FORMAT = Format.CVECTOR;
		
		SPHS_SIZE = PlotBrainSurface.getPropNumber() + 9;
		SPHS_SIZE_TAG = 'sphs_size';
		SPHS_SIZE_CATEGORY = Category.METADATA;
		SPHS_SIZE_FORMAT = Format.CVECTOR;
		
		SPHS_EDGE_COLOR = PlotBrainSurface.getPropNumber() + 10;
		SPHS_EDGE_COLOR_TAG = 'sphs_edge_color';
		SPHS_EDGE_COLOR_CATEGORY = Category.METADATA;
		SPHS_EDGE_COLOR_FORMAT = Format.MATRIX;
		
		SPHS_FACE_COLOR = PlotBrainSurface.getPropNumber() + 11;
		SPHS_FACE_COLOR_TAG = 'sphs_face_color';
		SPHS_FACE_COLOR_CATEGORY = Category.METADATA;
		SPHS_FACE_COLOR_FORMAT = Format.MATRIX;
		
		SPHS_EDGE_ALPHA = PlotBrainSurface.getPropNumber() + 12;
		SPHS_EDGE_ALPHA_TAG = 'sphs_edge_alpha';
		SPHS_EDGE_ALPHA_CATEGORY = Category.METADATA;
		SPHS_EDGE_ALPHA_FORMAT = Format.CVECTOR;
		
		SPHS_FACE_ALPHA = PlotBrainSurface.getPropNumber() + 13;
		SPHS_FACE_ALPHA_TAG = 'sphs_face_alpha';
		SPHS_FACE_ALPHA_CATEGORY = Category.METADATA;
		SPHS_FACE_ALPHA_FORMAT = Format.CVECTOR;
		
		IDS = PlotBrainSurface.getPropNumber() + 14;
		IDS_TAG = 'ids';
		IDS_CATEGORY = Category.METADATA;
		IDS_FORMAT = Format.CVECTOR;
		
		IDS_SIZE = PlotBrainSurface.getPropNumber() + 15;
		IDS_SIZE_TAG = 'ids_size';
		IDS_SIZE_CATEGORY = Category.METADATA;
		IDS_SIZE_FORMAT = Format.CVECTOR;
		
		IDS_FONT_COLOR = PlotBrainSurface.getPropNumber() + 16;
		IDS_FONT_COLOR_TAG = 'ids_font_color';
		IDS_FONT_COLOR_CATEGORY = Category.METADATA;
		IDS_FONT_COLOR_FORMAT = Format.MATRIX;
		
		IDS_FONT_NAME = PlotBrainSurface.getPropNumber() + 17;
		IDS_FONT_NAME_TAG = 'ids_font_name';
		IDS_FONT_NAME_CATEGORY = Category.METADATA;
		IDS_FONT_NAME_FORMAT = Format.STRING;
		
		IDS_FONT_INTERPRETER = PlotBrainSurface.getPropNumber() + 18;
		IDS_FONT_INTERPRETER_TAG = 'ids_font_interpreter';
		IDS_FONT_INTERPRETER_CATEGORY = Category.METADATA;
		IDS_FONT_INTERPRETER_FORMAT = Format.CVECTOR;
		
		LABS = PlotBrainSurface.getPropNumber() + 19;
		LABS_TAG = 'labs';
		LABS_CATEGORY = Category.METADATA;
		LABS_FORMAT = Format.CVECTOR;
		
		LABS_SIZE = PlotBrainSurface.getPropNumber() + 20;
		LABS_SIZE_TAG = 'labs_size';
		LABS_SIZE_CATEGORY = Category.METADATA;
		LABS_SIZE_FORMAT = Format.CVECTOR;
		
		LABS_FONT_COLOR = PlotBrainSurface.getPropNumber() + 21;
		LABS_FONT_COLOR_TAG = 'labs_font_color';
		LABS_FONT_COLOR_CATEGORY = Category.METADATA;
		LABS_FONT_COLOR_FORMAT = Format.MATRIX;
		
		LABS_FONT_NAME = PlotBrainSurface.getPropNumber() + 22;
		LABS_FONT_NAME_TAG = 'labs_font_name';
		LABS_FONT_NAME_CATEGORY = Category.METADATA;
		LABS_FONT_NAME_FORMAT = Format.STRING;
		
		LABS_FONT_INTERPRETER = PlotBrainSurface.getPropNumber() + 23;
		LABS_FONT_INTERPRETER_TAG = 'labs_font_interpreter';
		LABS_FONT_INTERPRETER_CATEGORY = Category.METADATA;
		LABS_FONT_INTERPRETER_FORMAT = Format.CVECTOR;
	end
	methods (Static) % inspection methods
		function pl_class = getClass()
			%GETCLASS returns the class of the plot brain atlas.
			%
			% CLASS = PlotBrainAtlas.GETCLASS() returns the class 'PlotBrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PL.GETCLASS() returns the class of the plot brain atlas PL.
			%  CLASS = Element.GETCLASS(PL) returns the class of 'PL'.
			%  CLASS = Element.GETCLASS('PlotBrainAtlas') returns 'PlotBrainAtlas'.
			%
			% See also getName, getDescription.
			
			pl_class = 'PlotBrainAtlas';
		end
		function pl_name = getName()
			%GETNAME returns the name of the plot brain atlas.
			%
			% NAME = PlotBrainAtlas.GETNAME() returns the name of the 'plot brain atlas'.
			%  Plot Brain Atlas.
			%
			% Alternative forms to call this method are:
			%  NAME = PL.GETNAME() returns the name of the plot brain atlas PL.
			%  NAME = Element.GETNAME(PL) returns the name of 'PL'.
			%  NAME = Element.GETNAME('PlotBrainAtlas') returns the name of 'PlotBrainAtlas'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			pl_name = 'Plot Brain Atlas';
		end
		function pl_description = getDescription()
			%GETDESCRIPTION returns the description of the plot brain atlas.
			%
			% STR = PlotBrainAtlas.GETDESCRIPTION() returns the description of the 'plot brain atlas'.
			%  which is:
			%
			%  PlotBrainAtlas manages the plot of the brain regions symbols,
			%  spheres, ids and labels. PlotBrainAtlas utilizes the surface created
			%  from PlotBrainSurface to integrate the regions to a brain surface.
			%
			% Alternative forms to call this method are:
			%  STR = PL.GETDESCRIPTION() returns the description of the plot brain atlas PL.
			%  STR = Element.GETDESCRIPTION(PL) returns the description of 'PL'.
			%  STR = Element.GETDESCRIPTION('PlotBrainAtlas') returns the description of 'PlotBrainAtlas'.
			%
			% See also getClass, getName.
			
			pl_description = [
				'PlotBrainAtlas manages the plot of the brain regions symbols,' ...
				'spheres, ids and labels. PlotBrainAtlas utilizes the surface created' ...
				'from PlotBrainSurface to integrate the regions to a brain surface.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of plot brain atlas.
			%
			% PROPS = PlotBrainAtlas.GETPROPS() returns the property list of plot brain atlas.
			%
			% PROPS = PlotBrainAtlas.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PL.GETPROPS([CATEGORY]) returns the property list of the plot brain atlas PL.
			%  PROPS = Element.GETPROPS(PL[, CATEGORY]) returns the property list of 'PL'.
			%  PROPS = Element.GETPROPS('PlotBrainAtlas'[, CATEGORY]) returns the property list of 'PlotBrainAtlas'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						PlotBrainSurface.getProps(Category.METADATA)
						PlotBrainAtlas.ATLAS
						PlotBrainAtlas.SYMS
						PlotBrainAtlas.SYMS_SIZE
						PlotBrainAtlas.SYMS_MARKER
						PlotBrainAtlas.SYMS_FACE_COLOR
						PlotBrainAtlas.SYMS_EDGE_COLOR
						PlotBrainAtlas.SPHS
						PlotBrainAtlas.SPHS_SIZE
						PlotBrainAtlas.SPHS_EDGE_COLOR
						PlotBrainAtlas.SPHS_FACE_COLOR
						PlotBrainAtlas.SPHS_EDGE_ALPHA
						PlotBrainAtlas.SPHS_FACE_ALPHA
						PlotBrainAtlas.IDS
						PlotBrainAtlas.IDS_SIZE
						PlotBrainAtlas.IDS_FONT_COLOR
						PlotBrainAtlas.IDS_FONT_NAME
						PlotBrainAtlas.IDS_FONT_INTERPRETER
						PlotBrainAtlas.LABS
						PlotBrainAtlas.LABS_SIZE
						PlotBrainAtlas.LABS_FONT_COLOR
						PlotBrainAtlas.LABS_FONT_NAME
						PlotBrainAtlas.LABS_FONT_INTERPRETER
						];
				case Category.PARAMETER
					prop_list = [
						PlotBrainSurface.getProps(Category.PARAMETER)
						];
				case Category.DATA
					prop_list = [
						PlotBrainSurface.getProps(Category.DATA)
						PlotBrainAtlas.PARENT
						];
				case Category.RESULT
					prop_list = [
						PlotBrainSurface.getProps(Category.RESULT)
						];
				case Category.FIGURE
					prop_list = [
						PlotBrainSurface.getProps(Category.FIGURE)
						];
				case Category.GUI
					prop_list = [
						PlotBrainSurface.getProps(Category.GUI)
						];
				otherwise
					prop_list = [
						PlotBrainSurface.getProps()
						PlotBrainAtlas.ATLAS
						PlotBrainAtlas.PARENT
						PlotBrainAtlas.SYMS
						PlotBrainAtlas.SYMS_SIZE
						PlotBrainAtlas.SYMS_MARKER
						PlotBrainAtlas.SYMS_FACE_COLOR
						PlotBrainAtlas.SYMS_EDGE_COLOR
						PlotBrainAtlas.SPHS
						PlotBrainAtlas.SPHS_SIZE
						PlotBrainAtlas.SPHS_EDGE_COLOR
						PlotBrainAtlas.SPHS_FACE_COLOR
						PlotBrainAtlas.SPHS_EDGE_ALPHA
						PlotBrainAtlas.SPHS_FACE_ALPHA
						PlotBrainAtlas.IDS
						PlotBrainAtlas.IDS_SIZE
						PlotBrainAtlas.IDS_FONT_COLOR
						PlotBrainAtlas.IDS_FONT_NAME
						PlotBrainAtlas.IDS_FONT_INTERPRETER
						PlotBrainAtlas.LABS
						PlotBrainAtlas.LABS_SIZE
						PlotBrainAtlas.LABS_FONT_COLOR
						PlotBrainAtlas.LABS_FONT_NAME
						PlotBrainAtlas.LABS_FONT_INTERPRETER
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of plot brain atlas.
			%
			% N = PlotBrainAtlas.GETPROPNUMBER() returns the property number of plot brain atlas.
			%
			% Alternative forms to call this method are:
			%  N = PL.GETPROPNUMBER() returns the property number of the plot brain atlas PL.
			%  N = Element.GETPROPNUMBER(PL) returns the property number of 'PL'.
			%  N = Element.GETPROPNUMBER('PlotBrainAtlas') returns the property number of 'PlotBrainAtlas'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 44;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in plot brain atlas/error.
			%
			% CHECK = PlotBrainAtlas.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSPROP(PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PL, PROP) checks whether PROP exists for PL.
			%  CHECK = Element.EXISTSPROP(PlotBrainAtlas, PROP) checks whether PROP exists for PlotBrainAtlas.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSPROP(PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  Element.EXISTSPROP(PL, PROP) throws error if PROP does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  Element.EXISTSPROP(PlotBrainAtlas, PROP) throws error if PROP does NOT exist for PlotBrainAtlas.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44 ]);
			else
				assert( ...
					PlotBrainAtlas.existsProp(prop), ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PlotBrainAtlas.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in plot brain atlas/error.
			%
			% CHECK = PlotBrainAtlas.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PL.EXISTSTAG(TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PL, TAG) checks whether TAG exists for PL.
			%  CHECK = Element.EXISTSTAG(PlotBrainAtlas, TAG) checks whether TAG exists for PlotBrainAtlas.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PL.EXISTSTAG(TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  Element.EXISTSTAG(PL, TAG) throws error if TAG does NOT exist for PL.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  Element.EXISTSTAG(PlotBrainAtlas, TAG) throws error if TAG does NOT exist for PlotBrainAtlas.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainatlas_tag_list = { 'id'  'bkgcolor'  'surf'  'axescolor'  'view'  'hold'  'grid'  'axis'  'equal'  'tight'  'brain'  'edgecolor'  'edgealpha'  'facecolor'  'facealpha'  'lighting'  'material'  'camlight'  'shading'  'colormap'  'colormapstring'  'atlas'  'parent'  'syms'  'syms_size'  'syms_marker'  'syms_face_color'  'syms_edge_color'  'sphs'  'sphs_size'  'sphs_edge_color'  'sphs_face_color'  'sphs_edge_alpha'  'sphs_face_alpha'  'ids'  'ids_size'  'ids_font_color'  'ids_font_name'  'ids_font_interpreter'  'labs'  'labs_size'  'labs_font_color'  'labs_font_name'  'labs_font_interpreter' };
				
				check = any(strcmpi(tag, plotbrainatlas_tag_list));
			else
				assert( ...
					PlotBrainAtlas.existsTag(tag), ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for PlotBrainAtlas'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PlotBrainAtlas, POINTER) returns property number of POINTER of PlotBrainAtlas.
			%  PROPERTY = PL.GETPROPPROP(PlotBrainAtlas, POINTER) returns property number of POINTER of PlotBrainAtlas.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				plotbrainatlas_tag_list = { 'id'  'bkgcolor'  'surf'  'axescolor'  'view'  'hold'  'grid'  'axis'  'equal'  'tight'  'brain'  'edgecolor'  'edgealpha'  'facecolor'  'facealpha'  'lighting'  'material'  'camlight'  'shading'  'colormap'  'colormapstring'  'atlas'  'parent'  'syms'  'syms_size'  'syms_marker'  'syms_face_color'  'syms_edge_color'  'sphs'  'sphs_size'  'sphs_edge_color'  'sphs_face_color'  'sphs_edge_alpha'  'sphs_face_alpha'  'ids'  'ids_size'  'ids_font_color'  'ids_font_name'  'ids_font_interpreter'  'labs'  'labs_size'  'labs_font_color'  'labs_font_name'  'labs_font_interpreter' };
				
				tag = pointer;
				PlotBrainAtlas.existsTag(tag);
				
				prop = find(strcmpi(tag, plotbrainatlas_tag_list));
			else % numeric
				prop = pointer;
				PlotBrainAtlas.existsProp(prop);
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
			%  TAG = Element.GETPROPTAG(PlotBrainAtlas, POINTER) returns tag of POINTER of PlotBrainAtlas.
			%  TAG = PL.GETPROPTAG(PlotBrainAtlas, POINTER) returns tag of POINTER of PlotBrainAtlas.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				PlotBrainAtlas.existsTag(tag);
			else % numeric
				prop = pointer;
				PlotBrainAtlas.existsProp(prop);
				
				switch prop
					case PlotBrainAtlas.ATLAS
						tag = PlotBrainAtlas.ATLAS_TAG;
					case PlotBrainAtlas.PARENT
						tag = PlotBrainAtlas.PARENT_TAG;
					case PlotBrainAtlas.SYMS
						tag = PlotBrainAtlas.SYMS_TAG;
					case PlotBrainAtlas.SYMS_SIZE
						tag = PlotBrainAtlas.SYMS_SIZE_TAG;
					case PlotBrainAtlas.SYMS_MARKER
						tag = PlotBrainAtlas.SYMS_MARKER_TAG;
					case PlotBrainAtlas.SYMS_FACE_COLOR
						tag = PlotBrainAtlas.SYMS_FACE_COLOR_TAG;
					case PlotBrainAtlas.SYMS_EDGE_COLOR
						tag = PlotBrainAtlas.SYMS_EDGE_COLOR_TAG;
					case PlotBrainAtlas.SPHS
						tag = PlotBrainAtlas.SPHS_TAG;
					case PlotBrainAtlas.SPHS_SIZE
						tag = PlotBrainAtlas.SPHS_SIZE_TAG;
					case PlotBrainAtlas.SPHS_EDGE_COLOR
						tag = PlotBrainAtlas.SPHS_EDGE_COLOR_TAG;
					case PlotBrainAtlas.SPHS_FACE_COLOR
						tag = PlotBrainAtlas.SPHS_FACE_COLOR_TAG;
					case PlotBrainAtlas.SPHS_EDGE_ALPHA
						tag = PlotBrainAtlas.SPHS_EDGE_ALPHA_TAG;
					case PlotBrainAtlas.SPHS_FACE_ALPHA
						tag = PlotBrainAtlas.SPHS_FACE_ALPHA_TAG;
					case PlotBrainAtlas.IDS
						tag = PlotBrainAtlas.IDS_TAG;
					case PlotBrainAtlas.IDS_SIZE
						tag = PlotBrainAtlas.IDS_SIZE_TAG;
					case PlotBrainAtlas.IDS_FONT_COLOR
						tag = PlotBrainAtlas.IDS_FONT_COLOR_TAG;
					case PlotBrainAtlas.IDS_FONT_NAME
						tag = PlotBrainAtlas.IDS_FONT_NAME_TAG;
					case PlotBrainAtlas.IDS_FONT_INTERPRETER
						tag = PlotBrainAtlas.IDS_FONT_INTERPRETER_TAG;
					case PlotBrainAtlas.LABS
						tag = PlotBrainAtlas.LABS_TAG;
					case PlotBrainAtlas.LABS_SIZE
						tag = PlotBrainAtlas.LABS_SIZE_TAG;
					case PlotBrainAtlas.LABS_FONT_COLOR
						tag = PlotBrainAtlas.LABS_FONT_COLOR_TAG;
					case PlotBrainAtlas.LABS_FONT_NAME
						tag = PlotBrainAtlas.LABS_FONT_NAME_TAG;
					case PlotBrainAtlas.LABS_FONT_INTERPRETER
						tag = PlotBrainAtlas.LABS_FONT_INTERPRETER_TAG;
					otherwise
						tag = getPropTag@PlotBrainSurface(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PlotBrainAtlas, POINTER) returns category of POINTER of PlotBrainAtlas.
			%  CATEGORY = PL.GETPROPCATEGORY(PlotBrainAtlas, POINTER) returns category of POINTER of PlotBrainAtlas.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					prop_category = PlotBrainAtlas.ATLAS_CATEGORY;
				case PlotBrainAtlas.PARENT
					prop_category = PlotBrainAtlas.PARENT_CATEGORY;
				case PlotBrainAtlas.SYMS
					prop_category = PlotBrainAtlas.SYMS_CATEGORY;
				case PlotBrainAtlas.SYMS_SIZE
					prop_category = PlotBrainAtlas.SYMS_SIZE_CATEGORY;
				case PlotBrainAtlas.SYMS_MARKER
					prop_category = PlotBrainAtlas.SYMS_MARKER_CATEGORY;
				case PlotBrainAtlas.SYMS_FACE_COLOR
					prop_category = PlotBrainAtlas.SYMS_FACE_COLOR_CATEGORY;
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					prop_category = PlotBrainAtlas.SYMS_EDGE_COLOR_CATEGORY;
				case PlotBrainAtlas.SPHS
					prop_category = PlotBrainAtlas.SPHS_CATEGORY;
				case PlotBrainAtlas.SPHS_SIZE
					prop_category = PlotBrainAtlas.SPHS_SIZE_CATEGORY;
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					prop_category = PlotBrainAtlas.SPHS_EDGE_COLOR_CATEGORY;
				case PlotBrainAtlas.SPHS_FACE_COLOR
					prop_category = PlotBrainAtlas.SPHS_FACE_COLOR_CATEGORY;
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					prop_category = PlotBrainAtlas.SPHS_EDGE_ALPHA_CATEGORY;
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					prop_category = PlotBrainAtlas.SPHS_FACE_ALPHA_CATEGORY;
				case PlotBrainAtlas.IDS
					prop_category = PlotBrainAtlas.IDS_CATEGORY;
				case PlotBrainAtlas.IDS_SIZE
					prop_category = PlotBrainAtlas.IDS_SIZE_CATEGORY;
				case PlotBrainAtlas.IDS_FONT_COLOR
					prop_category = PlotBrainAtlas.IDS_FONT_COLOR_CATEGORY;
				case PlotBrainAtlas.IDS_FONT_NAME
					prop_category = PlotBrainAtlas.IDS_FONT_NAME_CATEGORY;
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					prop_category = PlotBrainAtlas.IDS_FONT_INTERPRETER_CATEGORY;
				case PlotBrainAtlas.LABS
					prop_category = PlotBrainAtlas.LABS_CATEGORY;
				case PlotBrainAtlas.LABS_SIZE
					prop_category = PlotBrainAtlas.LABS_SIZE_CATEGORY;
				case PlotBrainAtlas.LABS_FONT_COLOR
					prop_category = PlotBrainAtlas.LABS_FONT_COLOR_CATEGORY;
				case PlotBrainAtlas.LABS_FONT_NAME
					prop_category = PlotBrainAtlas.LABS_FONT_NAME_CATEGORY;
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					prop_category = PlotBrainAtlas.LABS_FONT_INTERPRETER_CATEGORY;
				otherwise
					prop_category = getPropCategory@PlotBrainSurface(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PlotBrainAtlas, POINTER) returns format of POINTER of PlotBrainAtlas.
			%  FORMAT = PL.GETPROPFORMAT(PlotBrainAtlas, POINTER) returns format of POINTER of PlotBrainAtlas.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					prop_format = PlotBrainAtlas.ATLAS_FORMAT;
				case PlotBrainAtlas.PARENT
					prop_format = PlotBrainAtlas.PARENT_FORMAT;
				case PlotBrainAtlas.SYMS
					prop_format = PlotBrainAtlas.SYMS_FORMAT;
				case PlotBrainAtlas.SYMS_SIZE
					prop_format = PlotBrainAtlas.SYMS_SIZE_FORMAT;
				case PlotBrainAtlas.SYMS_MARKER
					prop_format = PlotBrainAtlas.SYMS_MARKER_FORMAT;
				case PlotBrainAtlas.SYMS_FACE_COLOR
					prop_format = PlotBrainAtlas.SYMS_FACE_COLOR_FORMAT;
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					prop_format = PlotBrainAtlas.SYMS_EDGE_COLOR_FORMAT;
				case PlotBrainAtlas.SPHS
					prop_format = PlotBrainAtlas.SPHS_FORMAT;
				case PlotBrainAtlas.SPHS_SIZE
					prop_format = PlotBrainAtlas.SPHS_SIZE_FORMAT;
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					prop_format = PlotBrainAtlas.SPHS_EDGE_COLOR_FORMAT;
				case PlotBrainAtlas.SPHS_FACE_COLOR
					prop_format = PlotBrainAtlas.SPHS_FACE_COLOR_FORMAT;
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					prop_format = PlotBrainAtlas.SPHS_EDGE_ALPHA_FORMAT;
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					prop_format = PlotBrainAtlas.SPHS_FACE_ALPHA_FORMAT;
				case PlotBrainAtlas.IDS
					prop_format = PlotBrainAtlas.IDS_FORMAT;
				case PlotBrainAtlas.IDS_SIZE
					prop_format = PlotBrainAtlas.IDS_SIZE_FORMAT;
				case PlotBrainAtlas.IDS_FONT_COLOR
					prop_format = PlotBrainAtlas.IDS_FONT_COLOR_FORMAT;
				case PlotBrainAtlas.IDS_FONT_NAME
					prop_format = PlotBrainAtlas.IDS_FONT_NAME_FORMAT;
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					prop_format = PlotBrainAtlas.IDS_FONT_INTERPRETER_FORMAT;
				case PlotBrainAtlas.LABS
					prop_format = PlotBrainAtlas.LABS_FORMAT;
				case PlotBrainAtlas.LABS_SIZE
					prop_format = PlotBrainAtlas.LABS_SIZE_FORMAT;
				case PlotBrainAtlas.LABS_FONT_COLOR
					prop_format = PlotBrainAtlas.LABS_FONT_COLOR_FORMAT;
				case PlotBrainAtlas.LABS_FONT_NAME
					prop_format = PlotBrainAtlas.LABS_FONT_NAME_FORMAT;
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					prop_format = PlotBrainAtlas.LABS_FONT_INTERPRETER_FORMAT;
				otherwise
					prop_format = getPropFormat@PlotBrainSurface(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PlotBrainAtlas, POINTER) returns description of POINTER of PlotBrainAtlas.
			%  DESCRIPTION = PL.GETPROPDESCRIPTION(PlotBrainAtlas, POINTER) returns description of POINTER of PlotBrainAtlas.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					prop_description = 'ATLAS (metadata, item) is the brain atlas with the brain regions.';
				case PlotBrainAtlas.PARENT
					prop_description = 'Parent (data, item) is the plot parent figure';
				case PlotBrainAtlas.SYMS
					prop_description = 'SYMS (metadata, cvector) is symbol visibility.';
				case PlotBrainAtlas.SYMS_SIZE
					prop_description = 'SYMS_SIZE (metadata, cvector) is the symbol size.';
				case PlotBrainAtlas.SYMS_MARKER
					prop_description = 'SYMS_MARKER (metadata, cvector) is the symbol option.';
				case PlotBrainAtlas.SYMS_FACE_COLOR
					prop_description = 'SYMS_FACE_COLOR (metadata, matrix) is the symbol face color.';
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					prop_description = 'SYMS_EDGE_COLOR (metadata, matrix) is the symbol edge color.';
				case PlotBrainAtlas.SPHS
					prop_description = 'SPHS (metadata, cvector) is sphere visibility.';
				case PlotBrainAtlas.SPHS_SIZE
					prop_description = 'SPHS_SIZE (metadata, cvector) is the sphere size.';
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					prop_description = 'SPHS_EDGE_COLOR (metadata, matrix) is the sphere edge color.';
				case PlotBrainAtlas.SPHS_FACE_COLOR
					prop_description = 'SPHS_FACE_COLOR (metadata, matrix) is the sphere face color.';
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					prop_description = 'SPHS_EDGE_ALPHA (metadata, cvector) is the sphere alpha.';
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					prop_description = 'SPHS_FACE_ALPHA (metadata, cvector) is the sphere alpha.';
				case PlotBrainAtlas.IDS
					prop_description = 'IDS (metadata, cvector) is the ids visibility.';
				case PlotBrainAtlas.IDS_SIZE
					prop_description = 'IDS_SIZE (metadata, cvector) is the ids size.';
				case PlotBrainAtlas.IDS_FONT_COLOR
					prop_description = 'IDS_FONT_COLOR (metadata, matrix) is the ids font color.';
				case PlotBrainAtlas.IDS_FONT_NAME
					prop_description = 'IDS_FONT_NAME (metadata, string) is the ids font name.';
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					prop_description = 'IDS_FONT_INTERPRETER (metadata, cvector) is the ids font interpreter.';
				case PlotBrainAtlas.LABS
					prop_description = 'LABS (metadata, cvector) is the labs visibility.';
				case PlotBrainAtlas.LABS_SIZE
					prop_description = 'LABS_SIZE (metadata, cvector) is the labs size.';
				case PlotBrainAtlas.LABS_FONT_COLOR
					prop_description = 'LABS_FONT_COLOR (metadata, matrix) is the labs font color.';
				case PlotBrainAtlas.LABS_FONT_NAME
					prop_description = 'LABS_FONT_NAME (metadata, string) is the labs font name.';
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					prop_description = 'LABS_FONT_INTERPRETER (metadata, cvector) is the labs font interpreter.';
				otherwise
					prop_description = getPropDescription@PlotBrainSurface(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PlotBrainAtlas, POINTER) returns settings of POINTER of PlotBrainAtlas.
			%  SETTINGS = PL.GETPROPSETTINGS(PlotBrainAtlas, POINTER) returns settings of POINTER of PlotBrainAtlas.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					prop_settings = 'BrainAtlas';
				case PlotBrainAtlas.PARENT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PlotBrainAtlas.SYMS
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.SYMS_SIZE
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.SYMS_MARKER
					prop_settings = 1:length(PlotBrainAtlas.PLOT_SYMBOL_TAG);
				case PlotBrainAtlas.SYMS_FACE_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.SPHS
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.SPHS_SIZE
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.SPHS_FACE_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.IDS
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.IDS_SIZE
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.IDS_FONT_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.IDS_FONT_NAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					prop_settings = 1:length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
				case PlotBrainAtlas.LABS
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.LABS_SIZE
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PlotBrainAtlas.LABS_FONT_COLOR
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case PlotBrainAtlas.LABS_FONT_NAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					prop_settings = 1:length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
				otherwise
					prop_settings = getPropSettings@PlotBrainSurface(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PlotBrainAtlas.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainAtlas.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULT(PlotBrainAtlas, POINTER) returns the default value of POINTER of PlotBrainAtlas.
			%  DEFAULT = PL.GETPROPDEFAULT(PlotBrainAtlas, POINTER) returns the default value of POINTER of PlotBrainAtlas.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					prop_default = Format.getFormatDefault(Format.ITEM, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.PARENT
					prop_default = Format.getFormatDefault(Format.ITEM, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS
					prop_default = 1;
				case PlotBrainAtlas.SYMS_SIZE
					prop_default = 10;
				case PlotBrainAtlas.SYMS_MARKER
					prop_default = 2;
				case PlotBrainAtlas.SYMS_FACE_COLOR
					prop_default = [.90 .56 .15];
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					prop_default = [.90 .56 .15];
				case PlotBrainAtlas.SPHS
					prop_default = 0;
				case PlotBrainAtlas.SPHS_SIZE
					prop_default = 1;
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					prop_default = [0 0 0];
				case PlotBrainAtlas.SPHS_FACE_COLOR
					prop_default = [0 0 0];
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					prop_default = .5;
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					prop_default = .5;
				case PlotBrainAtlas.IDS
					prop_default = 0;
				case PlotBrainAtlas.IDS_SIZE
					prop_default = 13;
				case PlotBrainAtlas.IDS_FONT_COLOR
					prop_default = [0 0 0];
				case PlotBrainAtlas.IDS_FONT_NAME
					prop_default = 'Helvetica';
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					prop_default = 1;
				case PlotBrainAtlas.LABS
					prop_default = 0;
				case PlotBrainAtlas.LABS_SIZE
					prop_default = 13;
				case PlotBrainAtlas.LABS_FONT_COLOR
					prop_default = [0 0 0];
				case PlotBrainAtlas.LABS_FONT_NAME
					prop_default = 'Helvetica';
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					prop_default = 1;
				otherwise
					prop_default = getPropDefault@PlotBrainSurface(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PlotBrainAtlas.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PlotBrainAtlas.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PlotBrainAtlas, POINTER) returns the conditioned default value of POINTER of PlotBrainAtlas.
			%  DEFAULT = PL.GETPROPDEFAULTCONDITIONED(PlotBrainAtlas, POINTER) returns the conditioned default value of POINTER of PlotBrainAtlas.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			prop_default = PlotBrainAtlas.conditioning(prop, PlotBrainAtlas.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PlotBrainAtlas, PROP, VALUE) checks VALUE format for PROP of PlotBrainAtlas.
			%  CHECK = PL.CHECKPROP(PlotBrainAtlas, PROP, VALUE) checks VALUE format for PROP of PlotBrainAtlas.
			% 
			% PL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PL.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  Element.CHECKPROP(PlotBrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainAtlas.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			%  PL.CHECKPROP(PlotBrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PlotBrainAtlas.
			%   Error id: [BRAPH2:PlotBrainAtlas:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.ATLAS
					check = Format.checkFormat(Format.ITEM, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.PARENT
					check = Format.checkFormat(Format.ITEM, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS_SIZE
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS_MARKER
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS_FACE_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS_SIZE
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS_FACE_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.IDS
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.IDS_SIZE
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.IDS_FONT_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.IDS_FONT_NAME
					check = Format.checkFormat(Format.STRING, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.LABS
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.LABS_SIZE
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.LABS_FONT_COLOR
					check = Format.checkFormat(Format.MATRIX, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.LABS_FONT_NAME
					check = Format.checkFormat(Format.STRING, value, PlotBrainAtlas.getPropSettings(prop));
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					check = Format.checkFormat(Format.CVECTOR, value, PlotBrainAtlas.getPropSettings(prop));
				otherwise
					check = checkProp@PlotBrainSurface(prop, value);
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PlotBrainAtlas:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PlotBrainAtlas.getPropTag(prop) ' (' PlotBrainAtlas.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function pl = PlotBrainAtlas(varargin)
			% PlotBrainAtlas() creates a plot brain atlas.
			%
			% PlotBrainAtlas(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PlotBrainAtlas(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PlotBrainAtlas properties is:
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
			%  <strong>22</strong> <strong>atlas</strong> 	ATLAS (metadata, item) is the brain atlas with the brain regions.
			%  <strong>23</strong> <strong>parent</strong> 	Parent (data, item) is the plot parent figure
			%  <strong>24</strong> <strong>syms</strong> 	SYMS (metadata, cvector) is symbol visibility.
			%  <strong>25</strong> <strong>syms_size</strong> 	SYMS_SIZE (metadata, cvector) is the symbol size.
			%  <strong>26</strong> <strong>syms_marker</strong> 	SYMS_MARKER (metadata, cvector) is the symbol option.
			%  <strong>27</strong> <strong>syms_face_color</strong> 	SYMS_FACE_COLOR (metadata, matrix) is the symbol face color.
			%  <strong>28</strong> <strong>syms_edge_color</strong> 	SYMS_EDGE_COLOR (metadata, matrix) is the symbol edge color.
			%  <strong>29</strong> <strong>sphs</strong> 	SPHS (metadata, cvector) is sphere visibility.
			%  <strong>30</strong> <strong>sphs_size</strong> 	SPHS_SIZE (metadata, cvector) is the sphere size.
			%  <strong>31</strong> <strong>sphs_edge_color</strong> 	SPHS_EDGE_COLOR (metadata, matrix) is the sphere edge color.
			%  <strong>32</strong> <strong>sphs_face_color</strong> 	SPHS_FACE_COLOR (metadata, matrix) is the sphere face color.
			%  <strong>33</strong> <strong>sphs_edge_alpha</strong> 	SPHS_EDGE_ALPHA (metadata, cvector) is the sphere alpha.
			%  <strong>34</strong> <strong>sphs_face_alpha</strong> 	SPHS_FACE_ALPHA (metadata, cvector) is the sphere alpha.
			%  <strong>35</strong> <strong>ids</strong> 	IDS (metadata, cvector) is the ids visibility.
			%  <strong>36</strong> <strong>ids_size</strong> 	IDS_SIZE (metadata, cvector) is the ids size.
			%  <strong>37</strong> <strong>ids_font_color</strong> 	IDS_FONT_COLOR (metadata, matrix) is the ids font color.
			%  <strong>38</strong> <strong>ids_font_name</strong> 	IDS_FONT_NAME (metadata, string) is the ids font name.
			%  <strong>39</strong> <strong>ids_font_interpreter</strong> 	IDS_FONT_INTERPRETER (metadata, cvector) is the ids font interpreter.
			%  <strong>40</strong> <strong>labs</strong> 	LABS (metadata, cvector) is the labs visibility.
			%  <strong>41</strong> <strong>labs_size</strong> 	LABS_SIZE (metadata, cvector) is the labs size.
			%  <strong>42</strong> <strong>labs_font_color</strong> 	LABS_FONT_COLOR (metadata, matrix) is the labs font color.
			%  <strong>43</strong> <strong>labs_font_name</strong> 	LABS_FONT_NAME (metadata, string) is the labs font name.
			%  <strong>44</strong> <strong>labs_font_interpreter</strong> 	LABS_FONT_INTERPRETER (metadata, cvector) is the labs font interpreter.
			%
			% See also Category, Format, set, check.
			
			pl = pl@PlotBrainSurface(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = PlotBrainAtlas.getPropProp(pointer);
			
			switch prop
				case PlotBrainAtlas.SYMS_SIZE
					value = abs(value);
					
				case PlotBrainAtlas.SPHS_SIZE
					value = abs(value);
					
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					value = abs(value);
					
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					value = abs(value);
					
				case PlotBrainAtlas.IDS_SIZE
					value = abs(value);
					
				case PlotBrainAtlas.LABS_SIZE
					value = abs(value);
					
				otherwise
					if prop <= PlotBrainSurface.getPropNumber()
						value = conditioning@PlotBrainSurface(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(pl, prop, value)
			check = true;
			msg = ['Error while checking' tostring(pl) ' ' pl.getPropTag(prop) '.'];
			
			switch prop
				case PlotBrainAtlas.SYMS
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.SYMS_SIZE
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					if check 
					    msg = 'All ok!';
					else
					    msg = ['SYMS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
					end
					
				case PlotBrainAtlas.SYMS_MARKER
					check = 1 <= value && value <= length(PlotBrainAtlas.PLOT_SYMBOL_TAG);
					
				case PlotBrainAtlas.SYMS_FACE_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.SYMS_EDGE_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.SPHS
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.SPHS_SIZE
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					if check 
					    msg = 'All ok!';
					else
					    msg = ['SPHS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
					end
					
				case PlotBrainAtlas.SPHS_EDGE_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.SPHS_FACE_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.SPHS_EDGE_ALPHA
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.SPHS_FACE_ALPHA
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.IDS
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.IDS_SIZE
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					if check 
					    msg = 'All ok!';
					else
					    msg = ['IDS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
					end
					
				case PlotBrainAtlas.IDS_FONT_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.IDS_FONT_INTERPRETER
					check = 1 <= value &&  value <= length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
					
				case PlotBrainAtlas.LABS
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					
				case PlotBrainAtlas.LABS_SIZE
					check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
					if check 
					    msg = 'All ok!';
					else
					    msg = ['LABS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
					end
					
				case PlotBrainAtlas.LABS_FONT_COLOR
					check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
					
				case PlotBrainAtlas.LABS_FONT_INTERPRETER
					check = 1 <= value &&  value <= length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
					
				otherwise
					[check, msg] = checkValue@PlotBrainSurface(pl, prop, value);
					
			end
		end
	end
	methods % methods
		function h_panel = draw(pl, varargin)
		    %DRAW draws the brain atlas graphical panel.
		    %
		    % DRAW(PL) draws the brain atlas graphical panel.
		    %
		    % H = DRAW(PL) returns a handle to the brain atlas graphical panel.
		    %
		    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
		    %  panel with custom property-value couples.
		    %  All standard plot properties of uipanel can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle to the brain atlas graphical panel H.
		    %
		    % see also settings, uipanel, isgraphics.
		
		    pl.pp = draw@PlotBrainSurface(pl, varargin{:});
		
		    if isempty(pl.h_axes) || ~isgraphics(pl.h_axes, 'axes')
		        pl.h_axes =  get(pl.pp, 'Children');
		    end
		
		    % close function
		    set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
		        varargin{:})
		
		        function close_f_settings(~, ~)
		            if ~isempty(pl.f_settings) && isgraphics(pl.f_settings, 'figure')
		                close(pl.f_settings)
		            end
		            if ~isempty(pl.f_settings_buttons) && isgraphics(pl.f_settings_buttons, 'figure')
		                close(pl.f_settings_buttons)
		            end
		            if ~isempty(pl.f_syms_settings) && isgraphics(pl.f_syms_settings, 'figure')
		                close(pl.f_syms_settings)
		            end
		            if ~isempty(pl.f_sphs_settings) && isgraphics(pl.f_sphs_settings, 'figure')
		                close(pl.f_sphs_settings)
		            end
		            if ~isempty(pl.f_ids_settings) && isgraphics(pl.f_ids_settings, 'figure')
		                close(pl.f_ids_settings)
		            end
		            if ~isempty(pl.f_labs_settings) && isgraphics(pl.f_labs_settings, 'figure')
		                close(pl.f_labs_settings)
		            end
		        end
		
		    % initialization
		    if isempty(pl.h_syms) || length(pl.h_syms.h) ~= pl.get('ATLAS').get('BR_DICT').length
		        pl.h_syms.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
		    end
		
		    if isempty(pl.h_sphs) || length(pl.h_sphs.h) ~= pl.get('ATLAS').get('BR_DICT').length
		        pl.h_sphs.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
		    end
		
		    if isempty(pl.h_ids) || length(pl.h_ids.h) ~= pl.get('ATLAS').get('BR_DICT').length
		        pl.h_ids.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
		    end
		
		    if isempty(pl.h_labs) || length(pl.h_labs.h) ~= pl.get('ATLAS').get('BR_DICT').length
		        pl.h_labs.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
		    end
		
		    % get coordinates
		    X = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
		    Y = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
		    Z = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
		    ID = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
		    LABS = cellfun(@(x) x.get('LABEL'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
		
		    % get values & complete vector size
		    % symbols
		    SYMS_SHOW = pl.get('SYMS');
		    if any(SYMS_SHOW) && length(SYMS_SHOW) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SYMS_SHOW = repmat(SYMS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SYMS_SIZE = pl.get('SYMS_SIZE');
		    if any(SYMS_SIZE) && length(SYMS_SIZE) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SYMS_SIZE = repmat(SYMS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SYMS_FACE_COLOR = pl.get('SYMS_FACE_COLOR');
		    if any(any(SYMS_FACE_COLOR)) && length(SYMS_FACE_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SYMS_FACE_COLOR = repmat(SYMS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SYMS_EDGE_COLOR = pl.get('SYMS_EDGE_COLOR');
		    if any(any(SYMS_EDGE_COLOR)) && length(SYMS_EDGE_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SYMS_EDGE_COLOR = repmat(SYMS_EDGE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    % spheres
		    SPHS_SHOW = pl.get('SPHS');
		    if any(SPHS_SHOW) && length(SPHS_SHOW) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_SHOW = repmat(SPHS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SPHS_SIZE = pl.get('SPHS_SIZE');
		    if any(SPHS_SIZE) && length(SPHS_SIZE) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_SIZE = repmat(SPHS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SPHS_FACE_COLOR = pl.get('SPHS_FACE_COLOR');
		    if any(any(SPHS_FACE_COLOR)) && length(SPHS_FACE_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_FACE_COLOR = repmat(SPHS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SPHS_EDGE_COLOR = pl.get('SPHS_FACE_COLOR');
		    if any(any(SPHS_EDGE_COLOR)) && length(SPHS_EDGE_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_EDGE_COLOR = repmat(SPHS_EDGE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SPHS_EDGE_ALPHA = pl.get('SPHS_EDGE_ALPHA');
		    if any(SPHS_EDGE_ALPHA) && length(SPHS_EDGE_ALPHA) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_EDGE_ALPHA = repmat(SPHS_EDGE_ALPHA, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    SPHS_FACE_ALPHA = pl.get('SPHS_FACE_ALPHA');
		    if any(SPHS_FACE_ALPHA) && length(SPHS_FACE_ALPHA) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        SPHS_FACE_ALPHA = repmat(SPHS_FACE_ALPHA, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    % ids
		    IDS_SHOW = pl.get('IDS');
		    if any(IDS_SHOW) && length(IDS_SHOW) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        IDS_SHOW = repmat(IDS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    IDS_SIZE = pl.get('IDS_SIZE');
		    if any(IDS_SIZE) && length(IDS_SIZE) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        IDS_SIZE = repmat(IDS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    IDS_FONT_COLOR = pl.get('IDS_FONT_COLOR');
		    if any(any(IDS_FONT_COLOR)) && length(IDS_FONT_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        IDS_FONT_COLOR = repmat(IDS_FONT_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    % labs
		    LABS_SHOW = pl.get('LABS');
		    if any(LABS_SHOW) && length(LABS_SHOW) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        LABS_SHOW = repmat(LABS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    LABS_SIZE = pl.get('LABS_SIZE');
		    if any(LABS_SIZE) && length(LABS_SIZE) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        LABS_SIZE = repmat(LABS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    LABS_FONT_COLOR = pl.get('LABS_FONT_COLOR');
		    if any(any(LABS_FONT_COLOR)) && length(LABS_FONT_COLOR) == pl.get('ATLAS').get('BR_DICT').length
		        % pass the vector as it is
		    else
		        LABS_FONT_COLOR = repmat(LABS_FONT_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
		    end
		
		    % for loop for plots and sets
		    for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
		        % symbols
		        if SYMS_SHOW(i)
		            % plotting
		            m = PlotBrainAtlas.PLOT_SYMBOL_TAG(pl.get('syms_marker'));
		            if ~ishandle(pl.h_syms.h(i))
		                pl.h_syms.h(i) = plot3(pl.h_axes, X{i}, Y{i}, Z{i});
		                set(pl.h_syms.h(i), ...
		                    'Visible', 'on', ...
		                    'Marker', m{1}, ...
		                    'MarkerSize', SYMS_SIZE(i), ...
		                    'MarkerFaceColor', SYMS_FACE_COLOR(i, :), ...
		                    'MarkerEdgeColor', SYMS_EDGE_COLOR(i, :) ...
		                    );
		            else
		                if X{i} ~= get(pl.h_syms.h(i), 'Xdata') || ...
		                        Y{i} ~= get(pl.h_syms.h(i), 'Ydata') || ...
		                        Z{i} ~= get(pl.h_syms.h(i), 'Zdata')
		                    set(pl.h_syms.h(i), 'Xdata', X{i}, 'Ydata', Y{i}, 'Zdata', Z{i})
		                end
		            end
		            if m{1} ~= get(pl.h_syms.h(i), 'Marker')  || ...
		                    SYMS_SIZE(i) ~= get(pl.h_syms.h(i), 'MarkerSize')  || ...
		                    any(isequal(SYMS_FACE_COLOR(i, :), get(pl.h_syms.h(i), 'MarkerFaceColor')))  || ...
		                    any(isequal(SYMS_EDGE_COLOR(i, :), get(pl.h_syms.h(i), 'MarkerEdgeColor')))
		                % set
		                set(pl.h_syms.h(i), ...
		                    'Visible', 'on', ...
		                    'Marker', m{1}, ...
		                    'MarkerSize', SYMS_SIZE(i), ...
		                    'MarkerFaceColor', SYMS_FACE_COLOR(i, :), ...
		                    'MarkerEdgeColor', SYMS_EDGE_COLOR(i, :) ...
		                    );
		            end
		        else
		            if ishandle(pl.h_syms.h(i))  && ~isempty(pl.h_syms.h(i))
		                set(pl.h_syms.h(i), ...
		                    'Visible', 'off');
		            end
		        end
		
		        % spheres
		        if SPHS_SHOW(i)
		            [sx, sy, sz] = sphere();
		            % plotting
		            if ~ishandle(pl.h_sphs.h(i))
		                pl.h_sphs.h(i) = surf(pl.h_axes, X{i} + SPHS_SIZE(i) * sx, Y{i} + SPHS_SIZE(i) * sy, ...
		                    Z{i} + SPHS_SIZE(i) * sz);
		                set(pl.h_sphs.h(i), ...
		                    'Visible', 'on', ...
		                    'EdgeColor', SPHS_EDGE_COLOR(i, :), ...
		                    'EdgeAlpha', SPHS_EDGE_ALPHA(i), ...
		                    'FaceColor', SPHS_FACE_COLOR(i, :), ...
		                    'FaceAlpha', SPHS_FACE_ALPHA(i) ...
		                    );
		
		            else
		                if any(any(X{i} + SPHS_SIZE(i) * sx ~= get(pl.h_sphs.h(i), 'Xdata'))) || ...
		                        any(any(Y{i} + SPHS_SIZE(i) * sy ~= get(pl.h_sphs.h(i), 'Ydata'))) || ...
		                        any(any(Z{i} + SPHS_SIZE(i) * sz ~= get(pl.h_sphs.h(i), 'Zdata')))
		
		                    set(pl.h_sphs.h(i), 'XData', X{i} + SPHS_SIZE(i) * sx);
		                    set(pl.h_sphs.h(i), 'YData', Y{i} + SPHS_SIZE(i) * sy);
		                    set(pl.h_sphs.h(i), 'ZData', Z{i} + SPHS_SIZE(i) * sz);
		
		                end
		            end
		            if any(isequal(SPHS_EDGE_COLOR(i, :) , get(pl.h_sphs.h(i), 'EdgeColor'))) || ...
		                    SPHS_EDGE_ALPHA(i, :) ~= get(pl.h_sphs.h(i), 'EdgeAlpha') || ...
		                    any(isequal(SPHS_FACE_COLOR(i, :), get(pl.h_sphs.h(i), 'FaceColor'))) || ...
		                    SPHS_FACE_ALPHA(i, :) ~= get(pl.h_sphs.h(i), 'FaceAlpha')
		                % set
		                set(pl.h_sphs.h(i), ...
		                    'Visible', 'on', ...
		                    'EdgeColor', SPHS_EDGE_COLOR(i, :), ...
		                    'EdgeAlpha', SPHS_EDGE_ALPHA(i), ...
		                    'FaceColor', SPHS_FACE_COLOR(i, :), ...
		                    'FaceAlpha', SPHS_FACE_ALPHA(i) ...
		                    );
		            end
		        else
		            if ishandle(pl.h_sphs.h(i))  && ~isempty(pl.h_sphs.h(i))
		                set(pl.h_sphs.h(i), ...
		                    'Visible', 'off');
		            end
		        end
		
		        % ids
		        if IDS_SHOW(i)
		            % plotting
		            int_ids = PlotBrainAtlas.PLOT_ID_FONT_INTREPETER(pl.get('IDS_FONT_INTERPRETER'));
		            if ~ishandle(pl.h_ids.h(i))
		                pl.h_ids.h(i) = text(X{i}, Y{i}, Z{i}, ID{i}, 'Parent', pl.h_axes);
		                set(pl.h_ids.h(i), ...
		                    'Visible', 'on', ...
		                    'FontSize', IDS_SIZE(i), ...
		                    'Color' , IDS_FONT_COLOR(i, :), ...
		                    'Position', [X{i}, Y{i}, Z{i}], ...
		                    'String', ID{i}, ...
		                    'FontName', pl.get('IDS_FONT_NAME'), ...
		                    'Interpreter', int_ids{1} ...
		                    );
		            else
		                position = get(pl.h_ids.h(i), 'Position');
		                if X{i} ~= position(1) || ...
		                        Y{i} ~= position(2) || ...
		                        Z{i} ~= position(3) || ...
		                        ~isequal(ID{i}, get(pl.h_ids.h(i), 'String'))
		                    delete(pl.h_ids.h(i))
		                    pl.h_ids.h(i) = text(X{i}, Y{i}, Z{i}, ID{i}, ...
		                        'Parent', pl.h_axes, ...
		                        'Visible', 'on', ...
		                        'FontSize', IDS_SIZE(i), ...
		                        'Color' , IDS_FONT_COLOR(i, :), ...
		                        'FontName', pl.get('IDS_FONT_NAME'), ...
		                        'Interpreter', int_ids{1} ...
		                        );
		                end
		            end
		            % set
		            if IDS_SIZE(i) ~= get(pl.h_ids.h(i), 'FontSize') || ...
		                    any(isequal(IDS_FONT_COLOR(i, :), get(pl.h_ids.h(i), 'Color'))) || ...
		                    any(pl.get('IDS_FONT_NAME') ~= get(pl.h_ids.h(i), 'FontName')) || ...
		                    ~strcmp(int_ids{1},  get(pl.h_ids.h(i), 'Interpreter'))
		
		                set(pl.h_ids.h(i), ...
		                    'Visible', 'on', ...
		                    'FontSize', IDS_SIZE(i), ...
		                    'Color' , IDS_FONT_COLOR(i, :), ...
		                    'FontName', pl.get('IDS_FONT_NAME'), ...
		                    'Interpreter', int_ids{1} ...
		                    );
		            end
		        else
		            if ishandle(pl.h_ids.h(i))  && ~isempty(pl.h_ids.h(i))
		                set(pl.h_ids.h(i), ...
		                    'Visible', 'off');
		            end
		        end
		
		        % labs
		        if LABS_SHOW(i)
		            % plotting
		            int_labs = PlotBrainAtlas.PLOT_ID_FONT_INTREPETER(pl.get('LABS_FONT_INTERPRETER'));
		            if ~ishandle(pl.h_labs.h(i))
		                pl.h_labs.h(i) = text(X{i}, Y{i}, Z{i}, LABS{i}, 'Parent', pl.h_axes);
		                set(pl.h_labs.h(i), ...
		                    'Visible', 'on', ...
		                    'FontSize', LABS_SIZE(i), ...
		                    'Color' , LABS_FONT_COLOR(i, :), ...
		                    'FontName', pl.get('LABS_FONT_NAME'), ...
		                    'Interpreter', int_labs{1} ...
		                    );
		            else
		                position = get(pl.h_labs.h(i), 'Position');
		                if X{i} ~= position(1) || ...
		                        Y{i} ~= position(2) || ...
		                        Z{i} ~= position(3) || ...
		                        ~isequal(LABS{i}, get(pl.h_labs.h(i), 'String'))
		                    delete(pl.h_labs.h(i))
		                    pl.h_labs.h(i) = text(X{i}, Y{i}, Z{i}, LABS{i}, ...
		                        'Parent', pl.h_axes, ...
		                        'Visible', 'on', ...
		                        'FontSize', LABS_SIZE(i), ...
		                        'Color' , LABS_FONT_COLOR(i, :), ...
		                        'FontName', pl.get('LABS_FONT_NAME'), ...
		                        'Interpreter', int_labs{1} ...
		                        );
		                end
		            end
		            % set
		            if LABS_SIZE(i) ~= get(pl.h_labs.h(i), 'FontSize') || ...
		                    ~any(isequal(LABS_FONT_COLOR(i, :), get(pl.h_labs.h(i), 'Color'))) || ...
		                    any(pl.get('LABS_FONT_NAME') ~= get(pl.h_labs.h(i), 'FontName')) || ...
		                    ~strcmp(int_labs{1},  get(pl.h_labs.h(i), 'Interpreter'))
		
		                set(pl.h_labs.h(i), ...
		                    'Visible', 'on', ...
		                    'FontSize', LABS_SIZE(i), ...
		                    'Color' , LABS_FONT_COLOR(i, :), ...
		                    'FontName', pl.get('LABS_FONT_NAME'), ...
		                    'Interpreter', int_labs{1} ...
		                    );
		            end
		        else
		            if ishandle(pl.h_labs.h(i))  && ~isempty(pl.h_labs.h(i))
		                set(pl.h_labs.h(i), ...
		                    'Visible', 'off');
		            end
		        end
		
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
		    %  atlas plot by opening a GUI property editor.
		    %
		    % F = SETTINGS(PL) returns a handle to the brain atlas property editor GUI.
		    %
		    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the brain
		    %  atlas property editor GUI with custom property-value couples.
		    %  All standard plot properties of figure can be used.
		    %
		    % See also draw, figure, isgraphics.
		
		    f_settings = settings@PlotBrainSurface(pl, varargin{:}); 
		
		    ui_toolbar = findall(f_settings, 'Tag', 'FigureToolBar');
		    
		    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
		    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
		
		    ui_toolbar_symbols = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', 'Symbols Panel', ...
		        'CData', imread('icon_symbol.png'), ...
		        'ClickedCallback', {@cb_syms_figure_settings});
		
		    ui_toolbar_spheres = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', 'Spheres Panel', ...
		        'CData', imread('icon_sphere.png'), ...
		        'ClickedCallback', {@cb_sphs_figure_settings});
		
		    ui_toolbar_labels = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', 'Labels Panel', ...
		        'CData', imread('icon_label.png'), ...
		        'ClickedCallback', {@cb_labs_figure_settings});
		
		    ui_toolbar_ids = uipushtool(ui_toolbar, ...
		        'Separator', 'off', ...
		        'TooltipString', 'Ids Panel', ...
		        'CData', imread('icon_id.png'), ...
		        'ClickedCallback', {@cb_ids_figure_settings});
		    
		    pl.f_settings = f_settings;
		    set(pl.f_settings, 'NAME', [pl.get('ATLAS').get('ID') ' - Plot Settings'])
		
		    % callback functions
		        function cb_syms_figure_settings(~, ~) % (src, event)
		            pl.f_syms_settings = pl.syms_settings();
		        end
		        function cb_sphs_figure_settings(~, ~) % (src, event)
		            pl.f_sphs_settings = pl.sphs_settings();
		        end
		        function cb_ids_figure_settings(~, ~) % (src, event)
		            pl.f_ids_settings = pl.ids_settings();
		        end
		        function cb_labs_figure_settings(~, ~) % (src, event)
		            pl.f_labs_settings = pl.labs_settings();
		        end
		end
		function f_out = syms_settings(pl)
		    % SYMS_SETTINGS panel to set symbols properties
		    %
		    % SYMS_SETTINGS(PL) allows the user to interactively
		    % change the symbols settings via a graphical user interface.
		    %
		    % SYMS_SETTINGS(PL, 'Property', VALUE, ...) sets
		    % the property of the GUI's Property to VALUE.
		    % Admissible properties are:
		    %     FigPosition  -   normalized position of the GUI on the screen
		    %                      [X0 Y0 DX DY]
		    %     FigColor     -   background color of the GUI
		    %     FigName      -   name of the GUI
		    %
		    % see also settings, sphs_settings, ids_settings, las_settings.
		    
		        if isempty(pl.f_syms_settings) || ~isgraphics(pl.f_syms_settings, 'figure')
		            pl.f_syms_settings = figure();
		        end
		
		        f = pl.f_syms_settings;
		
		        set(f, 'units', 'normalized', ...
		            'Position', [.60 .50 .30 .30], ...
		            'Color', [1 .9725 .929], ...
		            'Name','Brain Region Symbol Settings', ...
		            'MenuBar', 'none', ...
		            'Toolbar', 'none', ...
		            'NumberTitle', 'off', ...
		            'DockControls', 'off')
		
		        % Initialization
		        ui_list = uicontrol(f, 'Style', 'listbox');
		        set(ui_list, 'Units', 'normalized')
		        set(ui_list, 'BackgroundColor', [.95 .95 .95])
		        set(ui_list, 'Value', [])
		        set(ui_list, 'Max', 2, 'Min',0)
		        set(ui_list, 'BackgroundColor', [1 1 1])
		        set(ui_list, 'Position', [.05 .15 .40 .80])
		        set(ui_list, 'TooltipString', 'Select brain regions');
		        set(ui_list, 'Callback', {@cb_list});
		
		        ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
		        set(ui_checkbox_id, 'Units', 'normalized')
		        set(ui_checkbox_id, 'BackgroundColor', [1 .9725 .929])
		        set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
		        set(ui_checkbox_id, 'String', 'id')
		        set(ui_checkbox_id, 'Value', true)
		        set(ui_checkbox_id, 'FontWeight', 'bold')
		        set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
		        set(ui_checkbox_id, 'Callback', {@cb_id})
		
		        ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
		        set(ui_checkbox_label, 'Units', 'normalized')
		        set(ui_checkbox_label, 'BackgroundColor', [1 .9725 .929])
		        set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
		        set(ui_checkbox_label, 'String', 'label')
		        set(ui_checkbox_label, 'Value', false)
		        set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
		        set(ui_checkbox_label, 'Callback', {@cb_label})
		
		        ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
		        set(ui_checkbox_xyz, 'Units', 'normalized')
		        set(ui_checkbox_xyz, 'BackgroundColor', [1 .9725 .929])
		        set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
		        set(ui_checkbox_xyz, 'String', 'xyz')
		        set(ui_checkbox_xyz, 'Value', false)
		        set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
		        set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
		
		        ui_button_show = uicontrol(f, 'Style', 'pushbutton');
		        set(ui_button_show, 'Units','normalized')
		        set(ui_button_show, 'Position', [.50 .85 .45 .10])
		        set(ui_button_show, 'String', 'Show Regions')
		        set(ui_button_show, 'TooltipString', 'Show selected brain regions')
		        set(ui_button_show, 'Callback', {@cb_show})
		
		        ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
		        set(ui_button_hide, 'Units', 'normalized')
		        set(ui_button_hide, 'Position', [.50 .75 .45 .10])
		        set(ui_button_hide, 'String', 'Hide Regions')
		        set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
		        set(ui_button_hide, 'Callback', {@cb_hide})
		
		        ui_popup_marker = uicontrol(f, 'Style', 'popup', 'String', {''});
		        set(ui_popup_marker, 'Units', 'normalized')
		        set(ui_popup_marker, 'BackgroundColor', [1 .9725 .929])
		        set(ui_popup_marker, 'Position', [.50 .50 .45 .10])
		        set(ui_popup_marker, 'String', PlotBrainAtlas.PLOT_SYMBOL_NAME)
		        set(ui_popup_marker, 'Value', 2)
		        set(ui_popup_marker, 'TooltipString', 'Select symbol');
		        set(ui_popup_marker, 'Callback', {@cb_marker})
		
		        ui_text_size = uicontrol(f, 'Style', 'text');
		        set(ui_text_size, 'Units', 'normalized')
		        set(ui_text_size, 'BackgroundColor', [1 .9725 .929])
		        set(ui_text_size, 'Position', [.50 .375 .20 .10])
		        set(ui_text_size, 'String', 'symbol size ')
		        set(ui_text_size, 'HorizontalAlignment', 'left')
		        set(ui_text_size, 'FontWeight', 'bold')
		
		        ui_edit_size = uicontrol(f, 'Style', 'edit');
		        set(ui_edit_size, 'Units','normalized')
		        set(ui_edit_size, 'BackgroundColor', [1 .9725 .929])
		        set(ui_edit_size, 'Position', [.70 .40 .25 .10])
		        set(ui_edit_size, 'HorizontalAlignment', 'center')
		        set(ui_edit_size, 'FontWeight', 'bold')
		        set(ui_edit_size, 'String', '1')
		        set(ui_edit_size, 'Callback', {@cb_size})
		
		        ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
		        set(ui_button_facecolor, 'Units', 'normalized')
		        set(ui_button_facecolor, 'Position', [.50 .25 .45 .10])
		        set(ui_button_facecolor, 'String', 'Symbol Color')
		        set(ui_button_facecolor, 'TooltipString', 'Select symbol color')
		        set(ui_button_facecolor, 'Callback', {@cb_facecolor})
		
		        ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
		        set(ui_button_edgecolor, 'Units', 'normalized')
		        set(ui_button_edgecolor, 'Position', [.50 .15 .45 .10])
		        set(ui_button_edgecolor, 'String', 'Edge Color')
		        set(ui_button_edgecolor, 'TooltipString', 'Select symbol edge color')
		        set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})
		
		        update_list()
		        set(f, 'Visible', 'on')
		
		            function update_list()
		                % get info
		                ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		                labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		                xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		                ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		                zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		
		                % Set list names
		                if get(ui_checkbox_id, 'Value')
		                    set(ui_list, 'String', ids_)
		                elseif get(ui_checkbox_label, 'Value')
		                    set(ui_list, 'String', labels)
		                elseif get(ui_checkbox_xyz, 'Value')
		                    xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
		                    for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
		                        xyz{j} = [num2str(xs{j}) '   ' ...
		                            num2str(ys{j}) '   ' ...
		                            num2str(zs{j})];
		                    end
		                    set(ui_list, 'String', xyz)
		                end
		            end
		            function cb_list(~, ~)  % (src, event)
		                update_list()
		            end
		            function cb_id(~,~)  % (src,event)
		                set(ui_checkbox_id, 'Value', true)
		                set(ui_checkbox_id, 'FontWeight', 'bold')
		
		                set(ui_checkbox_label, 'Value', false)
		                set(ui_checkbox_label, 'FontWeight', 'normal')
		
		                set(ui_checkbox_xyz, 'Value', false)
		                set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		                update_list()
		            end
		            function cb_label(~, ~)  % (src, event)
		                set(ui_checkbox_id, 'Value', false)
		                set(ui_checkbox_id, 'FontWeight', 'normal')
		
		                set(ui_checkbox_label, 'Value', true)
		                set(ui_checkbox_label, 'FontWeight', 'bold')
		
		                set(ui_checkbox_xyz, 'Value', false)
		                set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		                update_list()
		            end
		            function cb_xyz(~, ~)  % (src, event)
		                set(ui_checkbox_id, 'Value', false)
		                set(ui_checkbox_id, 'FontWeight', 'normal')
		
		                set(ui_checkbox_label, 'Value', false)
		                set(ui_checkbox_label, 'FontWeight', 'normal')
		
		                set(ui_checkbox_xyz, 'Value', true)
		                set(ui_checkbox_xyz, 'FontWeight', 'bold')
		
		                update_list()
		            end
		            function cb_show(~, ~)  % (src, event)
		                syms_to_show = get_br_list();
		                all_brs_show = pl.get('SYMS');
		                if length(all_brs_show) == 1
		                    all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		                end
		                for i = 1:length(syms_to_show)
		                    s_m = syms_to_show(i);
		                    all_brs_show(s_m) = 1;
		                end
		
		                pl.set('SYMS', all_brs_show);
		                pl.draw();
		            end
		            function cb_hide(~, ~)  % (src, event)
		                syms_to_show = get_br_list();
		                all_brs_show = pl.get('SYMS');
		                if length(all_brs_show) == 1
		                    all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		                end
		                for i = 1:length(syms_to_show)
		                    s_m = syms_to_show(i);
		                    all_brs_show(s_m) = 0;
		                end
		                pl.set('SYMS', all_brs_show);
		                pl.draw();
		            end
		            function cb_marker(~, ~)  % (src, event)
		                symbol = get(ui_popup_marker, 'Value');
		                pl.set('syms_marker', symbol);
		                pl.draw();
		            end
		            function cb_size(~, ~)  % (src, event)
		                size = real(str2double(get(ui_edit_size, 'String')));
		
		                if isempty(size) || size <= 1
		                    set(ui_edit_size, 'String', '1')
		                    size = 1;
		                end
		                
		                syms_modified = get_br_list();
		                all_brs_sizes = pl.get('SYMS_SIZE');
		                if length(all_brs_sizes) == 1
		                    all_brs_sizes = repmat(all_brs_sizes, pl.get('ATLAS').get('BR_DICT').length, 1);
		                end
		                for i = 1:length(syms_modified)
		                    s_m = syms_modified(i);
		                    all_brs_sizes(s_m) = size;
		                end
		                pl.set('SYMS_SIZE', all_brs_sizes);
		                pl.draw();
		            end
		            function cb_facecolor(~, ~)  % (src, event)
		                color = uisetcolor();
		                original_color = pl.get('SYMS_FACE_COLOR');
		                syms_to_change = get_br_list();
		                if size(original_color, 1) == 1
		                    original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		                end
		                for i = 1:length(syms_to_change)
		                    s_m = syms_to_change(i);
		                    original_color(s_m, :) = color;
		                end
		                pl.set('SYMS_FACE_COLOR', original_color);
		                pl.draw();
		            end
		            function cb_edgecolor(~, ~)  % (src, event)
		                color = uisetcolor();
		                original_color = pl.get('SYMS_EDGE_COLOR');
		                syms_to_change = get_br_list();
		                if size(original_color, 1) == 1
		                    original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		                end
		                
		                for i = 1:length(syms_to_change)
		                    s_m = syms_to_change(i);
		                    original_color(s_m, :) = color;
		                end
		                pl.set('SYMS_EDGE_COLOR', original_color);
		                pl.draw();
		            end
		            function bri = get_br_list()
		                if pl.get('ATLAS').get('BR_DICT').length()>0
		                    bri = get(ui_list, 'Value');
		                else
		                    bri = [];
		                end
		            end
		
		        if nargout > 0
		            f_out = f;
		        end
		    end
		function f_out = sphs_settings(pl)
		    % SPHS_SETTINGS panel to set spheres properties
		    %
		    % SPHS_SETTINGS(PL) allows the user to interactively
		    % change the spheres settings via a graphical user interface.
		    %
		    % SPHS_SETTINGS(PL, 'Property', VALUE, ...) sets
		    % the property of the GUI's Property to VALUE.
		    % Admissible properties are:
		    %     FigPosition  -   normalized position of the GUI on the screen
		    %                      [X0 Y0 DX DY]
		    %     FigColor     -   background color of the GUI
		    %     FigName      -   name of the GUI
		    %
		    % see also settings, symbols_settings, f_ids_settings, labels_settings.
		
		    if isempty(pl.f_sphs_settings) || ~isgraphics(pl.f_sphs_settings, 'figure')
		        pl.f_sphs_settings = figure();
		    end
		
		    f = pl.f_sphs_settings;
		
		    set(f, 'units', 'normalized', ...
		        'Position', [.60 .45 .30 .30], ...
		        'Color', [1 .9725 .929], ...
		        'Name','Brain Region Sphere Settings', ...
		        'MenuBar', 'none', ...
		        'Toolbar', 'none', ...
		        'NumberTitle', 'off', ...
		        'DockControls', 'off')
		
		    % Initialization
		    ui_list = uicontrol(f, 'Style', 'listbox');
		    set(ui_list, 'Units','normalized')
		    set(ui_list, 'BackgroundColor', [.95 .95 .95])
		    set(ui_list, 'Value', [])
		    set(ui_list, 'Max', 2, 'Min', 0)
		    set(ui_list, 'BackgroundColor', [1 1 1])
		    set(ui_list, 'Position', [.05 .15 .40 .80])
		    set(ui_list, 'TooltipString', 'Select brain regions');
		    set(ui_list, 'Callback', {@cb_list});
		
		    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_id, 'Units','normalized')
		    set(ui_checkbox_id, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
		    set(ui_checkbox_id, 'String', 'id')
		    set(ui_checkbox_id, 'Value', true)
		    set(ui_checkbox_id, 'FontWeight', 'bold')
		    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by name')
		    set(ui_checkbox_id, 'Callback', {@cb_id})
		
		    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_label, 'Units','normalized')
		    set(ui_checkbox_label, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
		    set(ui_checkbox_label, 'String', 'label')
		    set(ui_checkbox_label, 'Value', false)
		    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
		    set(ui_checkbox_label, 'Callback', {@cb_label})
		
		    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_xyz, 'Units','normalized')
		    set(ui_checkbox_xyz, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
		    set(ui_checkbox_xyz, 'String', 'xyz')
		    set(ui_checkbox_xyz, 'Value', false)
		    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by position')
		    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
		
		    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_show, 'Units','normalized')
		    set(ui_button_show, 'Position', [.50 .85 .45 .10])
		    set(ui_button_show, 'String', 'Show Regions')
		    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
		    set(ui_button_show, 'Callback', {@cb_show})
		
		    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_hide, 'Units','normalized')
		    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
		    set(ui_button_hide, 'String', 'Hide Regions')
		    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
		    set(ui_button_hide, 'Callback', {@cb_hide})
		
		    ui_text = uicontrol(f, 'Style', 'text');
		    set(ui_text, 'Units','normalized')
		    set(ui_text, 'BackgroundColor', [1 .9725 .929])
		    set(ui_text, 'String', 'transparency')
		    set(ui_text, 'Position', [.70 .60 .25 .10])
		    set(ui_text, 'HorizontalAlignment', 'center')
		    set(ui_text, 'FontWeight', 'bold')
		
		    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_color, 'Units','normalized')
		    set(ui_button_color, 'Position', [.50 .50 .15 .10])
		    set(ui_button_color, 'String', 'sphere color')
		    set(ui_button_color, 'HorizontalAlignment', 'center')
		    set(ui_button_color, 'TooltipString', 'Brain region color (applied both to faces and edges)')
		    set(ui_button_color, 'Callback', {@cb_color})
		
		    ui_slider_alpha = uicontrol(f, 'Style', 'slider');
		    set(ui_slider_alpha, 'Units','normalized')
		    set(ui_slider_alpha, 'BackgroundColor', [1 .9725 .929])
		    set(ui_slider_alpha, 'Position', [.70 .475 .25 .10])
		    set(ui_slider_alpha, 'String', 'Brain region transparency')
		    set(ui_slider_alpha, 'Min', 0, 'Max',1, 'Value',.5);
		    set(ui_slider_alpha, 'TooltipString','Brain region transparency (applied both to faces and edges)')
		    set(ui_slider_alpha, 'Callback',{@cb_alpha})
		
		    ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_facecolor, 'Units','normalized')
		    set(ui_button_facecolor, 'Position', [.50 .35 .15 .10])
		    set(ui_button_facecolor, 'String', 'face color')
		    set(ui_button_facecolor, 'HorizontalAlignment', 'center')
		    set(ui_button_facecolor, 'TooltipString', 'Brain region face color')
		    set(ui_button_facecolor, 'Callback', {@cb_facecolor})
		
		    ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
		    set(ui_slider_facealpha, 'Units', 'normalized')
		    set(ui_slider_facealpha, 'BackgroundColor', [1 .9725 .929])
		    set(ui_slider_facealpha, 'Position', [.70 .325 .25 .10])
		    set(ui_slider_facealpha, 'String', 'Brain region transparency')
		    set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', .5)
		    set(ui_slider_facealpha, 'TooltipString', 'Brain region face transparency')
		    set(ui_slider_facealpha, 'Callback', {@cb_facealpha})
		
		    ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_edgecolor, 'Units', 'normalized')
		    set(ui_button_edgecolor, 'Position', [.50 .20 .15 .10])
		    set(ui_button_edgecolor, 'String', 'edge color')
		    set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
		    set(ui_button_edgecolor, 'TooltipString', 'Brain region edge color')
		    set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})
		
		    ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
		    set(ui_slider_edgealpha, 'Units', 'normalized')
		    set(ui_slider_edgealpha, 'BackgroundColor', [1 .9725 .929])
		    set(ui_slider_edgealpha, 'Position', [.70 .175 .25 .10])
		    set(ui_slider_edgealpha, 'String', 'Brain transparency')
		    set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', .5)
		    set(ui_slider_edgealpha, 'TooltipString', 'Brain region edge transparency')
		    set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})
		
		    ui_text_radius = uicontrol(f, 'Style', 'text');
		    set(ui_text_radius, 'Units', 'normalized')
		    set(ui_text_radius, 'BackgroundColor', [1 .9725 .929])
		    set(ui_text_radius, 'Position', [.50 .025 .20 .10])
		    set(ui_text_radius, 'String', 'sphere radius ')
		    set(ui_text_radius, 'HorizontalAlignment', 'left')
		    set(ui_text_radius, 'FontWeight', 'bold')
		
		    ui_edit_radius = uicontrol(f, 'Style', 'edit');
		    set(ui_edit_radius, 'Units', 'normalized')
		    set(ui_edit_radius, 'BackgroundColor', [1 .9725 .929])
		    set(ui_edit_radius, 'Position', [.70 .05 .25 .10])
		    set(ui_edit_radius, 'HorizontalAlignment', 'center')
		    set(ui_edit_radius, 'FontWeight', 'bold')
		    set(ui_edit_radius, 'TooltipString', 'Brain region sphere radius')
		    set(ui_edit_radius, 'String', '1')
		    set(ui_edit_radius, 'Callback', {@cb_radius})
		
		    update_list()
		    set(f,'Visible','on');
		
		        function update_list()
		            % get info
		            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		
		            % Set list names
		            if get(ui_checkbox_id, 'Value')
		                set(ui_list, 'String', ids_)
		            elseif get(ui_checkbox_label, 'Value')
		                set(ui_list, 'String', labels)
		            elseif get(ui_checkbox_xyz, 'Value')
		                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
		                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
		                    xyz{j} = [num2str(xs{j}) '   ' ...
		                        num2str(ys{j}) '   ' ...
		                        num2str(zs{j})];
		                end
		                set(ui_list, 'String', xyz)
		            end
		        end
		        function cb_list(~, ~)  % (src, event)
		            update_list()
		        end
		        function cb_id(~,~)  % (src,event)
		            set(ui_checkbox_id, 'Value', true)
		            set(ui_checkbox_id, 'FontWeight', 'bold')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_label(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', true)
		            set(ui_checkbox_label, 'FontWeight', 'bold')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_xyz(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', true)
		            set(ui_checkbox_xyz, 'FontWeight', 'bold')
		
		            update_list()
		        end
		        function cb_show(~, ~)  % (src, event)
		            sphs_to_show = get_br_list();
		            all_brs_show = pl.get('SPHS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_brs_show(s_m) = 1;
		            end
		            pl.set('SPHS', all_brs_show);
		            pl.draw();
		        end
		        function cb_hide(~, ~)  % (src, event)
		            sphs_to_show = get_br_list();
		            all_brs_show = pl.get('SPHS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_brs_show(s_m) = 0;
		            end
		            pl.set('SPHS', all_brs_show);
		            pl.draw();
		        end
		        function cb_color(~, ~)  %  (src, event)
		            color = uisetcolor();
		            original_color = pl.get('SPHS_FACE_COLOR');
		            sphs_to_show = get_br_list();
		            if size(original_color, 1) == 1
		                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                original_color(s_m, :) = color;
		            end
		
		            pl.set('SPHS_FACE_COLOR', original_color);
		            pl.set('SPHS_EDGE_COLOR', original_color);
		            pl.draw();
		        end
		        function cb_facecolor(~, ~)  % (src, event)
		            color = uisetcolor();
		            original_color = pl.get('SPHS_FACE_COLOR');
		            sphs_to_show = get_br_list();
		            if size(original_color, 1) == 1
		                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                original_color(s_m, :) = color;
		            end
		            pl.set('SPHS_FACE_COLOR', original_color);
		            pl.draw();
		        end
		        function cb_edgecolor(~, ~)  % (src, event)
		            color = uisetcolor();
		            original_color = pl.get('SPHS_EDGE_COLOR');
		            sphs_to_show = get_br_list();
		            if size(original_color, 1) == 1
		                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                original_color(s_m, :) = color;
		            end
		            pl.set('SPHS_EDGE_COLOR', original_color);
		            pl.draw();
		        end
		        function cb_alpha(~, ~)  % (src, event)
		            new_value = get(ui_slider_alpha, 'Value');
		            sphs_to_show = get_br_list();
		            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
		            if length(all_alphas_show) == 1
		                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_alphas_show(s_m) = new_value;
		            end
		
		            pl.set('SPHS_FACE_ALPHA', all_alphas_show)
		            pl.set('SPHS_EDGE_ALPHA', all_alphas_show)
		            pl.draw();
		
		            set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
		            set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
		        end
		        function cb_facealpha(~, ~)  % (src, event)
		            new_value = get(ui_slider_alpha, 'Value');
		            sphs_to_show = get_br_list();
		            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
		            if length(all_alphas_show) == 1
		                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_alphas_show(s_m) = new_value;
		            end
		            pl.set('SPHS_FACE_ALPHA', all_alphas_show)
		            pl.draw();
		        end
		        function cb_edgealpha(~, ~)  % (src, event)
		            new_value = get(ui_slider_alpha, 'Value');
		            sphs_to_show = get_br_list();
		            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
		            if length(all_alphas_show) == 1
		                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_alphas_show(s_m) = new_value;
		            end
		            pl.set('SPHS_EDGE_ALPHA', all_alphas_show)
		            pl.draw();
		        end
		        function cb_radius(~, ~)  % (src, event)
		            R = real(str2double(get(ui_edit_radius, 'String')));
		
		            if isempty(R) || R <= 0
		                set(ui_edit_radius, 'String', '1')
		                R = 1;
		            end
		
		            sphs_to_show = get_br_list();
		            all_brs_show = pl.get('SPHS_SIZE');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(sphs_to_show)
		                s_m = sphs_to_show(i);
		                all_brs_show(s_m) = R;
		            end
		
		            pl.set('SPHS_SIZE', all_brs_show);
		            pl.draw();
		        end
		        function bri = get_br_list()
		            if pl.get('atlas').get('BR_DICT').length() > 0
		                bri = get(ui_list, 'Value');
		            else
		                bri = [];
		            end
		        end
		    if nargout > 0
		        f_out = f;
		    end
		end
		function f_out = ids_settings(pl)
		    % IDS_SETTINGS panel to set ids properties
		    %
		    % IDS_SETTINGS(PL) allows the user to interactively
		    % change the ids settings via a graphical user interface.
		    %
		    % IDS_SETTINGS(PL, 'Property', VALUE, ...) sets
		    % the property of the GUI's Property to VALUE.
		    % Admissible properties are:
		    %     FigPosition  -   normalized position of the GUI on the screen
		    %                      [X0 Y0 DX DY]
		    %     FigColor     -   background color of the GUI
		    %     FigName      -   name of the GUI
		    %
		    % see also settings, symbols_settings, spheres_settings, labels_settings.
		
		    if isempty(pl.f_ids_settings) || ~isgraphics(pl.f_ids_settings, 'figure')
		        pl.f_ids_settings = figure();
		    end
		
		    f = pl.f_ids_settings;
		
		    set(f, 'units', 'normalized', ...
		        'Position', [.60 .35 .30 .30], ...
		        'Color', [1 .9725 .929], ...
		        'Name','Brain Region Ids Settings', ...
		        'MenuBar', 'none', ...
		        'Toolbar', 'none', ...
		        'NumberTitle', 'off', ...
		        'DockControls', 'off')
		
		    % Initialization
		    ui_list = uicontrol(f, 'Style', 'listbox');
		    set(ui_list, 'Units', 'normalized')
		    set(ui_list, 'BackgroundColor', [.95 .95 .95])
		    set(ui_list, 'Value', [])
		    set(ui_list, 'Max', 2, 'Min',0)
		    set(ui_list, 'BackgroundColor', [1 1 1])
		    set(ui_list, 'Position', [.05 .15 .40 .80])
		    set(ui_list, 'TooltipString', 'Select brain regions');
		    set(ui_list, 'Callback', {@cb_list});
		
		    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_id, 'Units', 'normalized')
		    set(ui_checkbox_id, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
		    set(ui_checkbox_id, 'String', 'id')
		    set(ui_checkbox_id, 'Value', true)
		    set(ui_checkbox_id, 'FontWeight', 'bold')
		    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
		    set(ui_checkbox_id, 'Callback', {@cb_id})
		
		    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_label, 'Units', 'normalized')
		    set(ui_checkbox_label, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
		    set(ui_checkbox_label, 'String', 'label')
		    set(ui_checkbox_label, 'Value', false)
		    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
		    set(ui_checkbox_label, 'Callback', {@cb_label})
		
		    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_xyz, 'Units', 'normalized')
		    set(ui_checkbox_xyz, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
		    set(ui_checkbox_xyz, 'String', 'xyz')
		    set(ui_checkbox_xyz, 'Value', false)
		    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
		    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
		
		    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_show, 'Units','normalized')
		    set(ui_button_show, 'Position', [.50 .85 .45 .10])
		    set(ui_button_show, 'String', 'Show Regions')
		    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
		    set(ui_button_show, 'Callback', {@cb_show})
		
		    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_hide, 'Units', 'normalized')
		    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
		    set(ui_button_hide, 'String', 'Hide Regions')
		    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
		    set(ui_button_hide, 'Callback', {@cb_hide})
		
		    ui_button_font = uicontrol(f,'Style', 'pushbutton');
		    set(ui_button_font, 'Units', 'normalized')
		    set(ui_button_font,'Position',[.50 .50 .45 .10])
		    set(ui_button_font,'String','Font')
		    set(ui_button_font,'TooltipString','Brain regions ids font')
		    set(ui_button_font,'Callback',{@cb_font})
		
		    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_color, 'Units', 'normalized')
		    set(ui_button_color, 'Position' ,[.50 .35 .45 .10])
		    set(ui_button_color, 'String', 'Font Color')
		    set(ui_button_color, 'TooltipString', 'Brain regions ids color')
		    set(ui_button_color, 'Callback', {@cb_color})
		
		    ui_text_interpreter = uicontrol(f, 'Style', 'text');
		    set(ui_text_interpreter, 'Units', 'normalized')
		    set(ui_text_interpreter, 'BackgroundColor', [1 .9725 .929])
		    set(ui_text_interpreter, 'Position', [.50 .175 .20 .10])
		    set(ui_text_interpreter, 'String', 'interpreter')
		    set(ui_text_interpreter, 'HorizontalAlignment', 'left')
		    set(ui_text_interpreter, 'FontWeight', 'bold')
		
		    ui_popup_interpreter = uicontrol(f, 'Style', 'popup', 'String', {''});
		    set(ui_popup_interpreter, 'Units', 'normalized')
		    set(ui_popup_interpreter, 'BackgroundColor', [1 .9725 .929])
		    set(ui_popup_interpreter, 'Position', [.75 .20 .20 .10])
		    set(ui_popup_interpreter, 'String', {'none', 'tex', 'latex'})
		    set(ui_popup_interpreter, 'Value', 2)
		    set(ui_popup_interpreter, 'TooltipString', 'Brain regions ids interpreter');
		    set(ui_popup_interpreter, 'Callback', {@cb_interpreter})
		
		    update_list()
		    set(f,'Visible','on')
		
		        function update_list()
		            % get info
		            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		
		            % Set list names
		            if get(ui_checkbox_id, 'Value')
		                set(ui_list, 'String', ids_)
		            elseif get(ui_checkbox_label, 'Value')
		                set(ui_list, 'String', labels)
		            elseif get(ui_checkbox_xyz, 'Value')
		                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
		                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
		                    xyz{j} = [num2str(xs{j}) '   ' ...
		                        num2str(ys{j}) '   ' ...
		                        num2str(zs{j})];
		                end
		                set(ui_list, 'String', xyz)
		            end
		        end
		        function cb_list(~, ~)  % (src, event)
		            update_list()
		        end
		        function cb_id(~,~)  % (src,event)
		            set(ui_checkbox_id, 'Value', true)
		            set(ui_checkbox_id, 'FontWeight', 'bold')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_label(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', true)
		            set(ui_checkbox_label, 'FontWeight', 'bold')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_xyz(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', true)
		            set(ui_checkbox_xyz, 'FontWeight', 'bold')
		
		            update_list()
		        end
		        function cb_show(~, ~)  % (src, event)
		            ids_to_show = get_br_list();
		            all_brs_show = pl.get('IDS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                all_brs_show(s_m) = 1;
		            end
		
		            pl.set('IDS', all_brs_show);
		            pl.draw();
		        end
		        function cb_hide(~, ~)  % (src, event)
		            ids_to_show = get_br_list();
		            all_brs_show = pl.get('IDS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                all_brs_show(s_m) = 0;
		            end
		            pl.set('IDS', all_brs_show);
		            pl.draw();
		        end
		        function cb_color(~, ~)  % (src, event)
		            color = uisetcolor();
		            original_color = pl.get('IDS_FONT_COLOR');
		            ids_to_show = get_br_list();
		            if size(original_color, 1) == 1
		                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                original_color(s_m, :) = color;
		            end
		
		            pl.set('IDS_FONT_COLOR', original_color);
		            pl.draw();
		        end
		        function cb_font(~,~)  % (src,event)
		            font = uisetfont;
		
		            pl.set('IDS_FONT_NAME', font.FontName);
		            pl.draw();
		        end
		        function cb_interpreter(~,~)  %  (src,event)
		            value = get(ui_popup_interpreter, 'Value');
		
		            pl.set('IDS_FONT_INTERPRETER', value)
		            pl.draw();
		        end
		        function bri = get_br_list()
		            if pl.get('atlas').get('BR_DICT').length() > 0
		                bri = get(ui_list, 'Value');
		            else
		                bri = [];
		            end
		        end
		    if nargout > 0
		        f_out = f;
		    end
		end
		function f_out = labs_settings(pl)
		    % LABS_SETTINGS panel to set labels properties
		    %
		    % LABS_SETTINGS(PL) allows the user to interactively
		    % change the label settings via a graphical user interface.
		    %
		    % LABS_SETTINGS(PL, 'Property', VALUE, ...) sets
		    % the property of the GUI's Property to VALUE.
		    % Admissible properties are:
		    %     FigPosition  -   normalized position of the GUI on the screen
		    %                      [X0 Y0 DX DY]
		    %     FigColor     -   background color of the GUI
		    %     FigName      -   name of the GUI
		    %
		    % see also settings, symbols_settings, spheres_settings, identificators_settings.
		    
		    if isempty(pl.f_labs_settings) || ~isgraphics(pl.f_labs_settings, 'figure')
		        pl.f_labs_settings = figure();
		    end
		
		    f = pl.f_labs_settings;
		
		    set(f, 'units', 'normalized', ...
		        'Position', [.60 .40 .30 .30], ...
		        'Color', [1 .9725 .929], ...
		        'Name','Brain Region Labels Settings', ...
		        'MenuBar', 'none', ...
		        'Toolbar', 'none', ...
		        'NumberTitle', 'off', ...
		        'DockControls', 'off')
		
		    % Initialization
		    ui_list = uicontrol(f, 'Style', 'listbox');
		    set(ui_list, 'Units', 'normalized')
		    set(ui_list, 'BackgroundColor', [.95 .95 .95])
		    set(ui_list, 'Value', [])
		    set(ui_list, 'Max', 2, 'Min',0)
		    set(ui_list, 'BackgroundColor', [1 1 1])
		    set(ui_list, 'Position', [.05 .15 .40 .80])
		    set(ui_list, 'TooltipString', 'Select brain regions');
		    set(ui_list, 'Callback', {@cb_list});
		
		    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_id, 'Units', 'normalized')
		    set(ui_checkbox_id, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
		    set(ui_checkbox_id, 'String', 'id')
		    set(ui_checkbox_id, 'Value', true)
		    set(ui_checkbox_id, 'FontWeight', 'bold')
		    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
		    set(ui_checkbox_id, 'Callback', {@cb_id})
		
		    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_label, 'Units', 'normalized')
		    set(ui_checkbox_label, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
		    set(ui_checkbox_label, 'String', 'label')
		    set(ui_checkbox_label, 'Value', false)
		    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
		    set(ui_checkbox_label, 'Callback', {@cb_label})
		
		    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
		    set(ui_checkbox_xyz, 'Units', 'normalized')
		    set(ui_checkbox_xyz, 'BackgroundColor', [1 .9725 .929])
		    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
		    set(ui_checkbox_xyz, 'String', 'xyz')
		    set(ui_checkbox_xyz, 'Value', false)
		    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
		    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
		
		    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_show, 'Units','normalized')
		    set(ui_button_show, 'Position', [.50 .85 .45 .10])
		    set(ui_button_show, 'String', 'Show Regions')
		    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
		    set(ui_button_show, 'Callback', {@cb_show})
		
		    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_hide, 'Units', 'normalized')
		    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
		    set(ui_button_hide, 'String', 'Hide Regions')
		    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
		    set(ui_button_hide, 'Callback', {@cb_hide})
		
		    ui_button_font = uicontrol(f,'Style', 'pushbutton');
		    set(ui_button_font, 'Units', 'normalized')
		    set(ui_button_font,'Position',[.50 .50 .45 .10])
		    set(ui_button_font,'String','Font')
		    set(ui_button_font,'TooltipString','Brain regions labels font')
		    set(ui_button_font,'Callback',{@cb_font})
		
		    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
		    set(ui_button_color, 'Units', 'normalized')
		    set(ui_button_color, 'Position' ,[.50 .35 .45 .10])
		    set(ui_button_color, 'String', 'Font Color')
		    set(ui_button_color, 'TooltipString', 'Brain regions labels color')
		    set(ui_button_color, 'Callback', {@cb_color})
		
		    ui_text_interpreter = uicontrol(f, 'Style', 'text');
		    set(ui_text_interpreter, 'Units', 'normalized')
		    set(ui_text_interpreter, 'BackgroundColor', [1 .9725 .929])
		    set(ui_text_interpreter, 'Position', [.50 .175 .20 .10])
		    set(ui_text_interpreter, 'String', 'interpreter')
		    set(ui_text_interpreter, 'HorizontalAlignment', 'left')
		    set(ui_text_interpreter, 'FontWeight', 'bold')
		
		    ui_popup_interpreter = uicontrol(f, 'Style', 'popup', 'String', {''});
		    set(ui_popup_interpreter, 'Units', 'normalized')
		    set(ui_popup_interpreter, 'BackgroundColor', [1 .9725 .929])
		    set(ui_popup_interpreter, 'Position', [.75 .20 .20 .10])
		    set(ui_popup_interpreter, 'String', {'none', 'tex', 'latex'})
		    set(ui_popup_interpreter, 'Value', 2)
		    set(ui_popup_interpreter, 'TooltipString', 'Brain regions labels interpreter');
		    set(ui_popup_interpreter, 'Callback', {@cb_interpreter})
		
		    update_list()
		    set(f,'Visible','on')
		
		        function update_list()
		            % get info
		            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
		
		            % Set list names
		            if get(ui_checkbox_id, 'Value')
		                set(ui_list, 'String', ids_)
		            elseif get(ui_checkbox_label, 'Value')
		                set(ui_list, 'String', labels)
		            elseif get(ui_checkbox_xyz, 'Value')
		                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
		                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
		                    xyz{j} = [num2str(xs{j}) '   ' ...
		                        num2str(ys{j}) '   ' ...
		                        num2str(zs{j})];
		                end
		                set(ui_list, 'String', xyz)
		            end
		        end
		        function cb_list(~, ~)  % (src, event)
		            update_list()
		        end
		        function cb_id(~,~)  % (src,event)
		            set(ui_checkbox_id, 'Value', true)
		            set(ui_checkbox_id, 'FontWeight', 'bold')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_label(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', true)
		            set(ui_checkbox_label, 'FontWeight', 'bold')
		
		            set(ui_checkbox_xyz, 'Value', false)
		            set(ui_checkbox_xyz, 'FontWeight', 'normal')
		
		            update_list()
		        end
		        function cb_xyz(~, ~)  % (src, event)
		            set(ui_checkbox_id, 'Value', false)
		            set(ui_checkbox_id, 'FontWeight', 'normal')
		
		            set(ui_checkbox_label, 'Value', false)
		            set(ui_checkbox_label, 'FontWeight', 'normal')
		
		            set(ui_checkbox_xyz, 'Value', true)
		            set(ui_checkbox_xyz, 'FontWeight', 'bold')
		
		            update_list()
		        end
		        function cb_show(~, ~)  % (src, event)
		            ids_to_show = get_br_list();
		            all_brs_show = pl.get('LABS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                all_brs_show(s_m) = 1;
		            end
		
		            pl.set('LABS', all_brs_show);
		            pl.draw();
		        end
		        function cb_hide(~, ~)  % (src, event)
		            ids_to_show = get_br_list();
		            all_brs_show = pl.get('LABS');
		            if length(all_brs_show) == 1
		                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                all_brs_show(s_m) = 0;
		            end
		            pl.set('LABS', all_brs_show);
		            pl.draw();
		        end
		        function cb_color(~, ~)  % (src, event)
		            color = uisetcolor();
		            original_color = pl.get('LABS_FONT_COLOR');
		            ids_to_show = get_br_list();
		            if size(original_color, 1) == 1
		                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
		            end
		            for i = 1:length(ids_to_show)
		                s_m = ids_to_show(i);
		                original_color(s_m, :) = color;
		            end
		
		            pl.set('LABS_FONT_COLOR', original_color);
		            pl.draw();
		        end
		        function cb_font(~,~)  % (src,event)
		            font = uisetfont;
		
		            pl.set('LABS_FONT_NAME', font.FontName);
		            pl.draw();
		        end
		        function cb_interpreter(~,~)  %  (src,event)
		            value = get(ui_popup_interpreter, 'Value');
		            
		            pl.set('LABS_FONT_INTERPRETER', value)
		            pl.draw();
		        end
		        function bri = get_br_list()
		            if pl.get('atlas').get('BR_DICT').length() > 0
		                bri = get(ui_list, 'Value');
		            else
		                bri = [];
		            end
		        end
		
		    if nargout > 0
		        f_out = f;
		    end
		end
		function cb_bring_to_front(pl)
		    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
		    %
		    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
		    %  settings figure.
		    %
		    % See also cb_hide, cb_close.
		
		    pl.cb_bring_to_front@Plot();
		    
		    if check_graphics(pl.f_syms_settings, 'figure')
		        set(pl.f_syms_settings, 'Visible' , 'on', 'WindowState', 'normal');
		    end
		    if  check_graphics(pl.f_sphs_settings, 'figure')
		        set(pl.f_sphs_settings, 'Visible' , 'on', 'WindowState', 'normal');
		    end
		    if check_graphics(pl.f_ids_settings, 'figure')
		        set(pl.f_ids_settings, 'Visible' , 'on', 'WindowState', 'normal');
		    end
		    if check_graphics(pl.f_labs_settings, 'figure')
		        set(pl.f_labs_settings, 'Visible' , 'on', 'WindowState', 'normal');
		    end
		end
		function cb_hide(pl)
		    %CB_HIDE hides the brain atlas figure and its settings figure.
		    %
		    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
		    %
		    % See also cb_bring_to_front, cb_close.
		    
		    pl.cb_hide@Plot();
		    
		    if check_graphics(pl.f_syms_settings, 'figure')
		        set(pl.f_syms_settings, 'Visible' , 'off');
		    end
		    if check_graphics(pl.f_sphs_settings, 'figure')
		        set(pl.f_sphs_settings, 'Visible' , 'off');
		    end
		    if check_graphics(pl.f_ids_settings, 'figure')
		        set(pl.f_ids_settings, 'Visible' , 'off');
		    end
		    if check_graphics(pl.f_labs_settings, 'figure')
		        set(pl.f_labs_settings, 'Visible' , 'off');
		    end
		end
	end
end
