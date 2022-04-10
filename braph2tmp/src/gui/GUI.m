classdef GUI < Element
	% GUI is a GUI for an element.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% GUI plots an element in a figure.
	% 
	% CONSTRUCTOR - To construct a GUI use the constructor:
	% 
	%     gui = GUI(''PE'', <element>)
	%     
	% DRAW - To create the element figure, call gui.draw():
	% 
	%     f = gui.<strong>draw</strong>();
	%  
	%  Here, f is the figure.
	%  It is also possible to use pr.draw() to get the figure handle and to set its properties.
	%   
	% CALLBACK - This is a callback function:
	% 
	%     gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
	%     gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
	%     gui.<strong>cb_close</strong>() - closes the figure and its dependent figures
	%
	% The list of GUI properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the GUI.
	%  <strong>2</strong> <strong>pe</strong> 	PE (metadata, item) is the plot element.
	%  <strong>3</strong> <strong>file</strong> 	FILE (data, string) is the B2 file where the element is saved.
	%  <strong>4</strong> <strong>menubar</strong> 	MENUBAR (metadata, logical) determines whether to show the menubar.
	%  <strong>5</strong> <strong>menu_file</strong> 	MENU_FILE (metadata, logical) determines whether to show the menu file.
	%  <strong>6</strong> <strong>menu_import</strong> 	MENU_IMPORT (metadata, logical) determines whether to show the menu import.
	%  <strong>7</strong> <strong>menu_export</strong> 	MENU_EXPORT (metadata, logical) determines whether to show the menu export.
	%  <strong>8</strong> <strong>menu_personalize</strong> 	MENU_PERSONALIZE (metadata, logical) determines whether to show the menu personalize.
	%  <strong>9</strong> <strong>menu_about</strong> 	MENU_ABOUT (metadata, logical) determines whether to show the menu about.
	%  <strong>10</strong> <strong>toolbar</strong> 	TOOLBAR (metadata, logical) determines whether to show the toolbar.
	%  <strong>11</strong> <strong>tool_fig</strong> 	TOOL_FIG (metadata, logical) determines whether to show the toolbar figure buttons.
	%  <strong>12</strong> <strong>tool_file</strong> 	TOOL_FILE (metadata, logical) determines whether to show the toolbar file buttons.
	%  <strong>13</strong> <strong>tool_about</strong> 	TOOL_ABOUT (metadata, logical) determines whether to show the toolbar about buttons.
	%  <strong>14</strong> <strong>name</strong> 	NAME (metadata, string) is the name of the GUI.
	%  <strong>15</strong> <strong>position</strong> 	POSITION (metadata, rvector) is the normalized position of the GUI on the screen.
	%  <strong>16</strong> <strong>closereq</strong> 	CLOSEREQ (metadata, logical) determines whether to confirm close.
	%
	% GUI methods (constructor):
	% GUI - constructor
	%
	% GUI methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graphical user interface/error.
	%  existsProp - checks whether property exists in graphical user interface/error.
	%  getPropNumber - returns the property number of graphical user interface.
	%  getProps - returns the property list of graphical user interface.
	%  getDescription - returns the description of the graphical user interface.
	%  getName - returns the name of the graphical user interface.
	%  getClass - returns the class of the graphical user interface.
	%
	% GUI methods:
	%  cb_close - if gui.get('CLOSEREQ')
	%  cb_hide - hides the figure and its dependent figures.
	%  cb_bring_to_front - brings to front the figure and its dependent figures.
	%  draw - creates and displays the GUI figure for an element.
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
	% GUI methods (operators):
	%  isequal - determines whether two GUI are equal (values, locked)
	%
	% GUI methods (display):
	%  tostring - string with information about the GUI
	%  disp - displays information about the GUI
	%  tree - displays the element of GUI
	%
	% GUI method (element list):
	%  getElementList - returns a list with all subelements of GUI
	%
	% GUI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the GUI
	%
	% GUI method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the GUI
	%
	% GUI methods (copy):
	%  copy - copies the GUI
	%  deepclone - deep-clones the GUI
	%  clone - clones the GUI
	%
	% GUI methods (inspection, Static):
	%  getClass - returns GUI
	%  getName - returns the name of GUI
	%  getDescription - returns the description of GUI
	%  getProps - returns the property list of GUI
	%  getPropNumber - returns the property number of GUI
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
	% GUI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUI methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% GUI methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% GUI methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% GUI properties (Constant).
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  PE - 2
	%  PE_TAG - 'pe'
	%  PE_CATEGORY - 'm'
	%  PE_FORMAT - 'it'
	%  FILE - 3
	%  FILE_TAG - 'file'
	%  FILE_CATEGORY - 'd'
	%  FILE_FORMAT - 'st'
	%  MENUBAR - 4
	%  MENUBAR_TAG - 'menubar'
	%  MENUBAR_CATEGORY - 'm'
	%  MENUBAR_FORMAT - 'lo'
	%  MENU_FILE - 5
	%  MENU_FILE_TAG - 'menu_file'
	%  MENU_FILE_CATEGORY - 'm'
	%  MENU_FILE_FORMAT - 'lo'
	%  MENU_IMPORT - 6
	%  MENU_IMPORT_TAG - 'menu_import'
	%  MENU_IMPORT_CATEGORY - 'm'
	%  MENU_IMPORT_FORMAT - 'lo'
	%  MENU_EXPORT - 7
	%  MENU_EXPORT_TAG - 'menu_export'
	%  MENU_EXPORT_CATEGORY - 'm'
	%  MENU_EXPORT_FORMAT - 'lo'
	%  MENU_PERSONALIZE - 8
	%  MENU_PERSONALIZE_TAG - 'menu_personalize'
	%  MENU_PERSONALIZE_CATEGORY - 'm'
	%  MENU_PERSONALIZE_FORMAT - 'lo'
	%  MENU_ABOUT - 9
	%  MENU_ABOUT_TAG - 'menu_about'
	%  MENU_ABOUT_CATEGORY - 'm'
	%  MENU_ABOUT_FORMAT - 'lo'
	%  TOOLBAR - 10
	%  TOOLBAR_TAG - 'toolbar'
	%  TOOLBAR_CATEGORY - 'm'
	%  TOOLBAR_FORMAT - 'lo'
	%  TOOL_FIG - 11
	%  TOOL_FIG_TAG - 'tool_fig'
	%  TOOL_FIG_CATEGORY - 'm'
	%  TOOL_FIG_FORMAT - 'lo'
	%  TOOL_FILE - 12
	%  TOOL_FILE_TAG - 'tool_file'
	%  TOOL_FILE_CATEGORY - 'm'
	%  TOOL_FILE_FORMAT - 'lo'
	%  TOOL_ABOUT - 13
	%  TOOL_ABOUT_TAG - 'tool_about'
	%  TOOL_ABOUT_CATEGORY - 'm'
	%  TOOL_ABOUT_FORMAT - 'lo'
	%  NAME - 14
	%  NAME_TAG - 'name'
	%  NAME_CATEGORY - 'm'
	%  NAME_FORMAT - 'st'
	%  POSITION - 15
	%  POSITION_TAG - 'position'
	%  POSITION_CATEGORY - 'm'
	%  POSITION_FORMAT - 'nr'
	%  CLOSEREQ - 16
	%  CLOSEREQ_TAG - 'closereq'
	%  CLOSEREQ_CATEGORY - 'm'
	%  CLOSEREQ_FORMAT - 'lo'
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
	% See also Element, PlotElement.
	
	properties (Access = private) % element properties
		f % handle for figure 
		pp % handle for parent panel of the element panel
		text_filename % handle for text field filename
		
		toolbar
		menu_file
		menu_import
		menu_export
		menu_personalize
		menu_about
		
		f_layout % handle to figure with panel to manage layout
	end
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		PE = 2;
		PE_TAG = 'pe';
		PE_CATEGORY = Category.METADATA;
		PE_FORMAT = Format.ITEM;
		
		FILE = 3;
		FILE_TAG = 'file';
		FILE_CATEGORY = Category.DATA;
		FILE_FORMAT = Format.STRING;
		
		MENUBAR = 4;
		MENUBAR_TAG = 'menubar';
		MENUBAR_CATEGORY = Category.METADATA;
		MENUBAR_FORMAT = Format.LOGICAL;
		
		MENU_FILE = 5;
		MENU_FILE_TAG = 'menu_file';
		MENU_FILE_CATEGORY = Category.METADATA;
		MENU_FILE_FORMAT = Format.LOGICAL;
		
		MENU_IMPORT = 6;
		MENU_IMPORT_TAG = 'menu_import';
		MENU_IMPORT_CATEGORY = Category.METADATA;
		MENU_IMPORT_FORMAT = Format.LOGICAL;
		
		MENU_EXPORT = 7;
		MENU_EXPORT_TAG = 'menu_export';
		MENU_EXPORT_CATEGORY = Category.METADATA;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		MENU_PERSONALIZE = 8;
		MENU_PERSONALIZE_TAG = 'menu_personalize';
		MENU_PERSONALIZE_CATEGORY = Category.METADATA;
		MENU_PERSONALIZE_FORMAT = Format.LOGICAL;
		
		MENU_ABOUT = 9;
		MENU_ABOUT_TAG = 'menu_about';
		MENU_ABOUT_CATEGORY = Category.METADATA;
		MENU_ABOUT_FORMAT = Format.LOGICAL;
		
		TOOLBAR = 10;
		TOOLBAR_TAG = 'toolbar';
		TOOLBAR_CATEGORY = Category.METADATA;
		TOOLBAR_FORMAT = Format.LOGICAL;
		
		TOOL_FIG = 11;
		TOOL_FIG_TAG = 'tool_fig';
		TOOL_FIG_CATEGORY = Category.METADATA;
		TOOL_FIG_FORMAT = Format.LOGICAL;
		
		TOOL_FILE = 12;
		TOOL_FILE_TAG = 'tool_file';
		TOOL_FILE_CATEGORY = Category.METADATA;
		TOOL_FILE_FORMAT = Format.LOGICAL;
		
		TOOL_ABOUT = 13;
		TOOL_ABOUT_TAG = 'tool_about';
		TOOL_ABOUT_CATEGORY = Category.METADATA;
		TOOL_ABOUT_FORMAT = Format.LOGICAL;
		
		NAME = 14;
		NAME_TAG = 'name';
		NAME_CATEGORY = Category.METADATA;
		NAME_FORMAT = Format.STRING;
		
		POSITION = 15;
		POSITION_TAG = 'position';
		POSITION_CATEGORY = Category.METADATA;
		POSITION_FORMAT = Format.RVECTOR;
		
		CLOSEREQ = 16;
		CLOSEREQ_TAG = 'closereq';
		CLOSEREQ_CATEGORY = Category.METADATA;
		CLOSEREQ_FORMAT = Format.LOGICAL;
	end
	methods (Static) % inspection methods
		function gui_class = getClass()
			%GETCLASS returns the class of the graphical user interface.
			%
			% CLASS = GUI.GETCLASS() returns the class 'GUI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the graphical user interface GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUI') returns 'GUI'.
			%
			% See also getName, getDescription.
			
			gui_class = 'GUI';
		end
		function gui_name = getName()
			%GETNAME returns the name of the graphical user interface.
			%
			% NAME = GUI.GETNAME() returns the name of the 'graphical user interface'.
			%  Graphical User Interface.
			%
			% Alternative forms to call this method are:
			%  NAME = GUI.GETNAME() returns the name of the graphical user interface GUI.
			%  NAME = Element.GETNAME(GUI) returns the name of 'GUI'.
			%  NAME = Element.GETNAME('GUI') returns the name of 'GUI'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			gui_name = 'Graphical User Interface';
		end
		function gui_description = getDescription()
			%GETDESCRIPTION returns the description of the graphical user interface.
			%
			% STR = GUI.GETDESCRIPTION() returns the description of the 'graphical user interface'.
			%  which is:
			%
			%  GUI plots an element in a figure.
			%  
			%  CONSTRUCTOR - To construct a GUI use the constructor:
			%  
			%      gui = GUI(''PE'', <element>)
			%      
			%  DRAW - To create the element figure, call gui.draw():
			%  
			%      f = gui.<strong>draw</strong>();
			%   
			%   Here, f is the figure.
			%   It is also possible to use pr.draw() to get the figure handle and to set its properties.
			%    
			%  CALLBACK - This is a callback function:
			%  
			%      gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
			%      gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
			%      gui.<strong>cb_close</strong>() - closes the figure and its dependent figures
			%
			% Alternative forms to call this method are:
			%  STR = GUI.GETDESCRIPTION() returns the description of the graphical user interface GUI.
			%  STR = Element.GETDESCRIPTION(GUI) returns the description of 'GUI'.
			%  STR = Element.GETDESCRIPTION('GUI') returns the description of 'GUI'.
			%
			% See also getClass, getName.
			
			gui_description = [
				'GUI plots an element in a figure.' ...
				'' ...
				'CONSTRUCTOR - To construct a GUI use the constructor:' ...
				'' ...
				'    gui = GUI(''PE'', <element>)' ...
				'    ' ...
				'DRAW - To create the element figure, call gui.draw():' ...
				'' ...
				'    f = gui.<strong>draw</strong>();' ...
				' ' ...
				' Here, f is the figure.' ...
				' It is also possible to use pr.draw() to get the figure handle and to set its properties.' ...
				'  ' ...
				'CALLBACK - This is a callback function:' ...
				'' ...
				'    gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures' ...
				'    gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures' ...
				'    gui.<strong>cb_close</strong>() - closes the figure and its dependent figures' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graphical user interface.
			%
			% PROPS = GUI.GETPROPS() returns the property list of graphical user interface.
			%
			% PROPS = GUI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the graphical user interface GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUI'[, CATEGORY]) returns the property list of 'GUI'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						GUI.PE
						GUI.MENUBAR
						GUI.MENU_FILE
						GUI.MENU_IMPORT
						GUI.MENU_EXPORT
						GUI.MENU_PERSONALIZE
						GUI.MENU_ABOUT
						GUI.TOOLBAR
						GUI.TOOL_FIG
						GUI.TOOL_FILE
						GUI.TOOL_ABOUT
						GUI.NAME
						GUI.POSITION
						GUI.CLOSEREQ
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						GUI.ID
						GUI.FILE
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
						GUI.ID
						GUI.PE
						GUI.FILE
						GUI.MENUBAR
						GUI.MENU_FILE
						GUI.MENU_IMPORT
						GUI.MENU_EXPORT
						GUI.MENU_PERSONALIZE
						GUI.MENU_ABOUT
						GUI.TOOLBAR
						GUI.TOOL_FIG
						GUI.TOOL_FILE
						GUI.TOOL_ABOUT
						GUI.NAME
						GUI.POSITION
						GUI.CLOSEREQ
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graphical user interface.
			%
			% N = GUI.GETPROPNUMBER() returns the property number of graphical user interface.
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER() returns the property number of the graphical user interface GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUI') returns the property number of 'GUI'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 16;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 ]);
			else
				assert( ...
					GUI.existsProp(prop), ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUI.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				gui_tag_list = { 'id'  'pe'  'file'  'menubar'  'menu_file'  'menu_import'  'menu_export'  'menu_personalize'  'menu_about'  'toolbar'  'tool_fig'  'tool_file'  'tool_about'  'name'  'position'  'closereq' };
				
				check = any(strcmpi(tag, gui_tag_list));
			else
				assert( ...
					GUI.existsTag(tag), ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for GUI'] ...
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
			%  PROPERTY = GUI.GETPROPPROP(POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = Element.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = GUI.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				gui_tag_list = { 'id'  'pe'  'file'  'menubar'  'menu_file'  'menu_import'  'menu_export'  'menu_personalize'  'menu_about'  'toolbar'  'tool_fig'  'tool_file'  'tool_about'  'name'  'position'  'closereq' };
				
				tag = pointer;
				GUI.existsTag(tag);
				
				prop = find(strcmpi(tag, gui_tag_list));
			else % numeric
				prop = pointer;
				GUI.existsProp(prop);
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
			%  TAG = GUI.GETPROPTAG(POINTER) returns tag of POINTER of GUI.
			%  TAG = Element.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%  TAG = GUI.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				GUI.existsTag(tag);
			else % numeric
				prop = pointer;
				GUI.existsProp(prop);
				
				switch prop
					case GUI.ID
						tag = GUI.ID_TAG;
					case GUI.PE
						tag = GUI.PE_TAG;
					case GUI.FILE
						tag = GUI.FILE_TAG;
					case GUI.MENUBAR
						tag = GUI.MENUBAR_TAG;
					case GUI.MENU_FILE
						tag = GUI.MENU_FILE_TAG;
					case GUI.MENU_IMPORT
						tag = GUI.MENU_IMPORT_TAG;
					case GUI.MENU_EXPORT
						tag = GUI.MENU_EXPORT_TAG;
					case GUI.MENU_PERSONALIZE
						tag = GUI.MENU_PERSONALIZE_TAG;
					case GUI.MENU_ABOUT
						tag = GUI.MENU_ABOUT_TAG;
					case GUI.TOOLBAR
						tag = GUI.TOOLBAR_TAG;
					case GUI.TOOL_FIG
						tag = GUI.TOOL_FIG_TAG;
					case GUI.TOOL_FILE
						tag = GUI.TOOL_FILE_TAG;
					case GUI.TOOL_ABOUT
						tag = GUI.TOOL_ABOUT_TAG;
					case GUI.NAME
						tag = GUI.NAME_TAG;
					case GUI.POSITION
						tag = GUI.POSITION_TAG;
					case GUI.CLOSEREQ
						tag = GUI.CLOSEREQ_TAG;
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
			%  CATEGORY = GUI.GETPROPCATEGORY(POINTER) returns category of POINTER of GUI.
			%  CATEGORY = Element.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					prop_category = GUI.ID_CATEGORY;
				case GUI.PE
					prop_category = GUI.PE_CATEGORY;
				case GUI.FILE
					prop_category = GUI.FILE_CATEGORY;
				case GUI.MENUBAR
					prop_category = GUI.MENUBAR_CATEGORY;
				case GUI.MENU_FILE
					prop_category = GUI.MENU_FILE_CATEGORY;
				case GUI.MENU_IMPORT
					prop_category = GUI.MENU_IMPORT_CATEGORY;
				case GUI.MENU_EXPORT
					prop_category = GUI.MENU_EXPORT_CATEGORY;
				case GUI.MENU_PERSONALIZE
					prop_category = GUI.MENU_PERSONALIZE_CATEGORY;
				case GUI.MENU_ABOUT
					prop_category = GUI.MENU_ABOUT_CATEGORY;
				case GUI.TOOLBAR
					prop_category = GUI.TOOLBAR_CATEGORY;
				case GUI.TOOL_FIG
					prop_category = GUI.TOOL_FIG_CATEGORY;
				case GUI.TOOL_FILE
					prop_category = GUI.TOOL_FILE_CATEGORY;
				case GUI.TOOL_ABOUT
					prop_category = GUI.TOOL_ABOUT_CATEGORY;
				case GUI.NAME
					prop_category = GUI.NAME_CATEGORY;
				case GUI.POSITION
					prop_category = GUI.POSITION_CATEGORY;
				case GUI.CLOSEREQ
					prop_category = GUI.CLOSEREQ_CATEGORY;
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
			%  FORMAT = GUI.GETPROPFORMAT(POINTER) returns format of POINTER of GUI.
			%  FORMAT = Element.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%  FORMAT = GUI.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					prop_format = GUI.ID_FORMAT;
				case GUI.PE
					prop_format = GUI.PE_FORMAT;
				case GUI.FILE
					prop_format = GUI.FILE_FORMAT;
				case GUI.MENUBAR
					prop_format = GUI.MENUBAR_FORMAT;
				case GUI.MENU_FILE
					prop_format = GUI.MENU_FILE_FORMAT;
				case GUI.MENU_IMPORT
					prop_format = GUI.MENU_IMPORT_FORMAT;
				case GUI.MENU_EXPORT
					prop_format = GUI.MENU_EXPORT_FORMAT;
				case GUI.MENU_PERSONALIZE
					prop_format = GUI.MENU_PERSONALIZE_FORMAT;
				case GUI.MENU_ABOUT
					prop_format = GUI.MENU_ABOUT_FORMAT;
				case GUI.TOOLBAR
					prop_format = GUI.TOOLBAR_FORMAT;
				case GUI.TOOL_FIG
					prop_format = GUI.TOOL_FIG_FORMAT;
				case GUI.TOOL_FILE
					prop_format = GUI.TOOL_FILE_FORMAT;
				case GUI.TOOL_ABOUT
					prop_format = GUI.TOOL_ABOUT_FORMAT;
				case GUI.NAME
					prop_format = GUI.NAME_FORMAT;
				case GUI.POSITION
					prop_format = GUI.POSITION_FORMAT;
				case GUI.CLOSEREQ
					prop_format = GUI.CLOSEREQ_FORMAT;
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
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					prop_description = 'ID (data, string) is a few-letter code for the GUI.';
				case GUI.PE
					prop_description = 'PE (metadata, item) is the plot element.';
				case GUI.FILE
					prop_description = 'FILE (data, string) is the B2 file where the element is saved.';
				case GUI.MENUBAR
					prop_description = 'MENUBAR (metadata, logical) determines whether to show the menubar.';
				case GUI.MENU_FILE
					prop_description = 'MENU_FILE (metadata, logical) determines whether to show the menu file.';
				case GUI.MENU_IMPORT
					prop_description = 'MENU_IMPORT (metadata, logical) determines whether to show the menu import.';
				case GUI.MENU_EXPORT
					prop_description = 'MENU_EXPORT (metadata, logical) determines whether to show the menu export.';
				case GUI.MENU_PERSONALIZE
					prop_description = 'MENU_PERSONALIZE (metadata, logical) determines whether to show the menu personalize.';
				case GUI.MENU_ABOUT
					prop_description = 'MENU_ABOUT (metadata, logical) determines whether to show the menu about.';
				case GUI.TOOLBAR
					prop_description = 'TOOLBAR (metadata, logical) determines whether to show the toolbar.';
				case GUI.TOOL_FIG
					prop_description = 'TOOL_FIG (metadata, logical) determines whether to show the toolbar figure buttons.';
				case GUI.TOOL_FILE
					prop_description = 'TOOL_FILE (metadata, logical) determines whether to show the toolbar file buttons.';
				case GUI.TOOL_ABOUT
					prop_description = 'TOOL_ABOUT (metadata, logical) determines whether to show the toolbar about buttons.';
				case GUI.NAME
					prop_description = 'NAME (metadata, string) is the name of the GUI.';
				case GUI.POSITION
					prop_description = 'POSITION (metadata, rvector) is the normalized position of the GUI on the screen.';
				case GUI.CLOSEREQ
					prop_description = 'CLOSEREQ (metadata, logical) determines whether to confirm close.';
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
			%  SETTINGS = GUI.GETPROPSETTINGS(POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = Element.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUI.PE
					prop_settings = 'PlotElement';
				case GUI.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUI.MENUBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.MENU_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.MENU_IMPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.MENU_ABOUT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TOOLBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TOOL_FIG
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TOOL_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TOOL_ABOUT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.NAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUI.POSITION
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case GUI.CLOSEREQ
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					prop_default = Format.getFormatDefault(Format.STRING, GUI.getPropSettings(prop));
				case GUI.PE
					prop_default = Format.getFormatDefault(Format.ITEM, GUI.getPropSettings(prop));
				case GUI.FILE
					prop_default = Format.getFormatDefault(Format.STRING, GUI.getPropSettings(prop));
				case GUI.MENUBAR
					prop_default = true;
				case GUI.MENU_FILE
					prop_default = true;
				case GUI.MENU_IMPORT
					prop_default = true;
				case GUI.MENU_EXPORT
					prop_default = true;
				case GUI.MENU_PERSONALIZE
					prop_default = true;
				case GUI.MENU_ABOUT
					prop_default = true;
				case GUI.TOOLBAR
					prop_default = true;
				case GUI.TOOL_FIG
					prop_default = false;
				case GUI.TOOL_FILE
					prop_default = true;
				case GUI.TOOL_ABOUT
					prop_default = true;
				case GUI.NAME
					prop_default = Format.getFormatDefault(Format.STRING, GUI.getPropSettings(prop));
				case GUI.POSITION
					prop_default = [.00 .00 .20 1.00];
				case GUI.CLOSEREQ
					prop_default = true;
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			prop_default = GUI.conditioning(prop, GUI.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GUI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GUI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = Element.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = GUI.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:GUI:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  GUI.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.ID
					check = Format.checkFormat(Format.STRING, value, GUI.getPropSettings(prop));
				case GUI.PE
					check = Format.checkFormat(Format.ITEM, value, GUI.getPropSettings(prop));
				case GUI.FILE
					check = Format.checkFormat(Format.STRING, value, GUI.getPropSettings(prop));
				case GUI.MENUBAR
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.MENU_FILE
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.MENU_IMPORT
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.MENU_EXPORT
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.MENU_PERSONALIZE
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.MENU_ABOUT
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TOOLBAR
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TOOL_FIG
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TOOL_FILE
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TOOL_ABOUT
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.NAME
					check = Format.checkFormat(Format.STRING, value, GUI.getPropSettings(prop));
				case GUI.POSITION
					check = Format.checkFormat(Format.RVECTOR, value, GUI.getPropSettings(prop));
					if check
						check = (length(value) == 4) && all(value(3:4) >= 0);
					end
				case GUI.CLOSEREQ
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUI.getPropTag(prop) ' (' GUI.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function gui = GUI(varargin)
			% GUI() creates a graphical user interface.
			%
			% GUI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUI(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GUI properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the GUI.
			%  <strong>2</strong> <strong>pe</strong> 	PE (metadata, item) is the plot element.
			%  <strong>3</strong> <strong>file</strong> 	FILE (data, string) is the B2 file where the element is saved.
			%  <strong>4</strong> <strong>menubar</strong> 	MENUBAR (metadata, logical) determines whether to show the menubar.
			%  <strong>5</strong> <strong>menu_file</strong> 	MENU_FILE (metadata, logical) determines whether to show the menu file.
			%  <strong>6</strong> <strong>menu_import</strong> 	MENU_IMPORT (metadata, logical) determines whether to show the menu import.
			%  <strong>7</strong> <strong>menu_export</strong> 	MENU_EXPORT (metadata, logical) determines whether to show the menu export.
			%  <strong>8</strong> <strong>menu_personalize</strong> 	MENU_PERSONALIZE (metadata, logical) determines whether to show the menu personalize.
			%  <strong>9</strong> <strong>menu_about</strong> 	MENU_ABOUT (metadata, logical) determines whether to show the menu about.
			%  <strong>10</strong> <strong>toolbar</strong> 	TOOLBAR (metadata, logical) determines whether to show the toolbar.
			%  <strong>11</strong> <strong>tool_fig</strong> 	TOOL_FIG (metadata, logical) determines whether to show the toolbar figure buttons.
			%  <strong>12</strong> <strong>tool_file</strong> 	TOOL_FILE (metadata, logical) determines whether to show the toolbar file buttons.
			%  <strong>13</strong> <strong>tool_about</strong> 	TOOL_ABOUT (metadata, logical) determines whether to show the toolbar about buttons.
			%  <strong>14</strong> <strong>name</strong> 	NAME (metadata, string) is the name of the GUI.
			%  <strong>15</strong> <strong>position</strong> 	POSITION (metadata, rvector) is the normalized position of the GUI on the screen.
			%  <strong>16</strong> <strong>closereq</strong> 	CLOSEREQ (metadata, logical) determines whether to confirm close.
			%
			% See also Category, Format, set, check.
			
			gui = gui@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.PE
					if ~isa(value, 'PlotElement')
					    value = PlotElement('EL', value, 'ID', ['Plot of ' value.tostring()]);
					end
					
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods % methods
		function f_out = draw(gui, varargin)
		    %GUI creates and displays the GUI figure for an element.
		    %
		    % GUI() creates and displays the GUI figure for an element.
		    %
		    % F = DRAW(GUI) returns a handle to the GUI figure.
		    %
		    % DRAW(GUI, 'Property', VALUE, ...) sets the properties of the parent
		    %  panel with custom Name-Value pairs.
		    %  All standard plot properties of figure can be used.
		    %
		    % It is possible to access the properties of the various graphical
		    %  objects from the handle F of the GUI figure.
		    %
		    % The GUI, PlotElement and Element can be retrieved as 
		    %  GUI = get(F, 'UserData')
		    %  PE = GUI.get('PE')
		    %  EL = PE.get('EL')
		    %
		    % See also cb_bring_to_front, figure.
		
		    pe = gui.get('pe');
		    el = pe.get('el');
		
		    %% Figure
		    % draw figure
		    if ~check_graphics(gui.f, 'figure')
		        gui.f = figure( ...
		            'Visible', 'off', ...
		            'NumberTitle', 'off', ...
		            'MenuBar', 'none', ...
		            'DockControls', 'off', ...
		            'SizeChangedFcn', {@cb_resize}, ...
		            'CloseRequestFcn', {@cb_close} ...
		            );
		        set_braph2icon(gui.f)
		    end
		    if ~isempty(varargin)
		        set(gui.f, varargin{:})
		    end
		    
		    % update figure
		    name = gui.get('NAME');
		    if isempty(name)
		        if el.existsTag('ID')
		            name = el.get('ID');
		        else
		            name = el.tostring();
		        end
		    end
		    set(gui.f, ...
		        'UserData', gui, ... % handle to retrieve gui, pe and el from figure
		        'Name', [el.getClass() ' - ' name ' - ' BRAPH2.STR], ...
		        'Units', 'normalized', ...
		        'Position', gui.get('POSITION'), ...
		        'Color', pe.get('BKGCOLOR') ...
		        )
		    
		    % callback on close request
		    function cb_close(~, ~)
		% % %         if gui.get('CLOSEREQ')
		% % %             selection = questdlg(['Do you want to close ' name '?'], ...
		% % %                 ['Close ' name], ...
		% % %                 'Yes', 'No', 'Yes');
		% % %         else
		% % %             selection = 'Yes';
		% % %         end
		% % %         switch selection
		% % %             case 'Yes'
		% % %                 delete(gui.f)
		% % %                 if check_graphics(gui.f_layout, 'figure')
		% % %                     close(gui.f_layout)
		% % %                 end
		% % %             case 'No'
		% % %                 return
		% % %         end
		        gui.cb_close()
		    end
		
		    % callback on resize
		    function cb_resize(~, ~)
		        set(gui.pp, ...
		            'Units', 'characters', ...
		            'Position', [0 1 Plot.w(gui.f, 'characters') Plot.h(gui.f, 'characters')-1] ...
		            );
		        set(gui.text_filename, ...
		            'Position', [0 0 Plot.w(gui.f, 'characters') 1] ...
		            )
		    end
		
		    %% FILENAME
		    % draw text filename
		    if ~check_graphics(gui.text_filename, 'text')
		        gui.text_filename = uicontrol( ...
		            'Parent', gui.f, ...
		            'Tag', 'text_filename', ...
		            'Style','text', ...
		            'Units', 'character', ...
		            'HorizontalAlignment', 'left', ...
		            'String', gui.get('FILE') ...
		            );
		    end
		% FIXME: check whether to bring out the update filename    
		    function update_filename()
		        set(gui.text_filename, 'String', gui.get('FILE'))
		    end
		
		    %% ELEMENT PANEL
		    % draw element parent panel
		    if ~check_graphics(gui.pp, 'uipanel')
		        gui.pp = uipanel( ...
		            'Parent', gui.f, ...
		            'Tag', 'pp', ...
		            'BorderType', 'none' ...
		            );
		    end
		    pe.draw('Parent', gui.pp)
		    
		    %% Menu
		    if gui.get('MENUBAR') && gui.get('MENU_FILE') && ~check_graphics(gui.menu_file, 'uimenu')
		        gui.menu_file = uimenu(gui.f, 'Label', 'File');
		        uimenu(gui.menu_file, ...
		            'Label', 'Open ...', ...
		            'Accelerator', 'O', ...
		            'Callback', {@cb_open})
		        uimenu(gui.menu_file, ...
		            'Label', 'Save', ...
		            'Accelerator', 'S', ...
		            'Callback', {@cb_save})
		        uimenu(gui.menu_file, ...
		            'Label', 'Save as ...', ...
		            'Accelerator', 'A', ...
		            'Callback', {@cb_saveas})
		        uimenu(gui.menu_file, ...
		            'Separator', 'on', ...
		            'Label', 'Close', ...
		            'Accelerator', 'C', ...
		            'Callback', {@cb_close})
		    end
		    function cb_open(~, ~)
		        % select file
		        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
		        if filterindex
		            filename = fullfile(path, file);
		            tmp = load(filename, '-mat', 'el');
		            if strcmp(tmp.el.getClass(), el.getClass())
		                pe.reinit(tmp.el)
		                el = tmp.el; % update local variable 'el' to synchronize it with pe 'el'  
		                gui.draw()
		            else
		                GUI('PE', tmp.el, 'FILE', filename).draw()
		            end
		        end
		    end
		    function cb_save(~, ~)
		        filename = gui.get('FILE');
		        if isfile(filename)
		            build = BRAPH2.BUILD;
		            save(filename, 'el', 'build');
		        else
		            cb_saveas();
		        end
		    end
		    function cb_saveas(~, ~)
		        % select file
		        [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
		        % save file
		        if filterindex
		            filename = fullfile(path, file);
		            build = BRAPH2.BUILD;
		            save(filename, 'el', 'build');
		            gui.set('FILE', filename)
		            update_filename();
		        end
		    end
		    
		    if gui.get('MENUBAR') && gui.get('MENU_IMPORT') && ~check_graphics(gui.menu_import, 'uimenu') 
		        gui.menu_import = uimenu(gui.f, ...
		            'Label', 'Import', ...
		            'Callback', {@cb_refresh_import_menu});
		    end
		    function cb_refresh_import_menu(~,~)
		        im_menus = get(gui.menu_import, 'Children');
		        for i = 1:1:length(im_menus)
		            delete(im_menus(i));
		        end
		        eval([el.getClass() '.getGUIMenuImport(el, gui.menu_import, pe)']);
		    end    
		
		    if gui.get('MENUBAR') && gui.get('MENU_EXPORT') && ~check_graphics(gui.menu_export, 'uimenu') 
		        gui.menu_export = uimenu(gui.f, ...
		            'Label', 'Export', ...
		            'Callback', {@cb_refresh_export_menu});
		    end
		    function cb_refresh_export_menu(~,~)
		        ex_menus = get(gui.menu_export, 'Children');
		        for i = 1:length(ex_menus)
		            delete(ex_menus(i));
		        end
		        eval([el.getClass() '.getGUIMenuExport(el, gui.menu_export, pe)']);
		    end
		
		    if gui.get('MENUBAR') && gui.get('MENU_PERSONALIZE') && ~check_graphics(gui.menu_personalize, 'uimenu') 
		        gui.menu_personalize = uimenu(gui.f, 'Label', 'Personalize');
		        uimenu(gui.menu_personalize, ...
		            'Label', 'Layout ...', ...
		            'Callback', {@cb_layout});
		    end
		    function cb_layout(~, ~)
		        if isgraphics(gui.f_layout, 'figure')
		            delete(gui.f_layout)
		        end
		        
		        gui.f_layout = figure( ...
		            'Visible', 'off', ...
		            'NumberTitle', 'off', ...
		            'Name', ['Layout ' el.getClass() ' - ' BRAPH2.STR], ...
		            'Units', get(gui.f, 'Units'), ...
		            'Position', [Plot.x0(gui.f)+Plot.w(gui.f) Plot.y0(gui.f)+Plot.h(gui.f)*2/3 Plot.w(gui.f) Plot.h(gui.f)/3], ...
		            'Units', 'character', ...
		            'MenuBar', 'none', ...
		            'DockControls', 'off', ...
		            'Color', pe.get('BKGCOLOR') ...
		            );
		        set_braph2icon(gui.f_layout);
		
		        edit_table = uitable('Parent', gui.f_layout, ...
		            'Units', 'normalized', ...
		            'Position', [.02 .2 .9 .7], ...
		            'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
		            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
		            'ColumnEditable', [true true true false false false], ...
		            'CellEditCallback', {@cb_edit_tb} ...
		            );
		        save_edit_btn = uicontrol('Parent', gui.f_layout, ...
		            'Units', 'normalized', ...
		            'Position', [.49 .02 .24 .1], ...
		            'String', 'Save', ...
		            'Callback', {@cb_save_edit} ...
		            );
		        cancel_edit_btn =  uicontrol('Parent', gui.f_layout, ...
		            'Units', 'normalized', ...
		            'Position', [.74 .02 .24 .1], ...
		            'String', 'Cancel', ...
		            'Callback', {@cb_cancel_edit} ...
		            );
		
		        [order, title, visible] = load_layout(el);
		        VISIBLE = 1;
		        ORDER = 2;
		        TITLE = 3;
		        TAG = 4;
		        CATEGORY = 5;
		        FORMAT = 6;
		        data = cell(el.getPropNumber(), 6);
		        for prop = 1:1:el.getPropNumber()
		            data{prop, VISIBLE} = visible(prop);
		            data{prop, ORDER} = order(prop);
		            data{prop, TITLE} = title{prop};
		            data{prop, TAG} = upper(el.getPropTag(prop));
		            data{prop, CATEGORY} = el.getPropCategory(prop);
		            data{prop, FORMAT} = el.getPropFormat(prop);
		        end        
		        set(edit_table, 'Data', data);
		
		        set(gui.f_layout, 'Visible', 'on');
		        
		        function cb_edit_tb(~, event)
		            prop = event.Indices(1);
		            col = event.Indices(2);
		            newdata = event.NewData;
		            data = get(edit_table, 'Data');
		
		            if col == VISIBLE
		                if newdata == true
		                    if any(~isnan(cell2mat(data(:, ORDER))))
		                        data{prop, ORDER} = max(cell2mat(data(:, ORDER))) + 1;
		                    else % all NaN (edge case)
		                        data{prop, ORDER} = 1;
		                    end
		                else % newdata == false
		                    for i = data{prop, ORDER} + 1:1:max(cell2mat(data(:, ORDER)))
		                        data{cell2mat(data(:, ORDER)) == i, ORDER} = i - 1;
		                    end
		                    data{prop, ORDER} = NaN;
		                end
		            end
		
		            if col == ORDER
		                if isnan(newdata)
		                    data{prop, VISIBLE} = false;
		                else
		                    data{prop, VISIBLE} = true;
		                end
		                
		                order = cell2mat(data(:, ORDER)) + .00301040106;
		                order(prop) = newdata;
		                for i = 1:1:numel(order) - sum(isnan(order))
		                    min_order_index = find(order == min(order));
		                    data{min_order_index, ORDER} = i;
		                    order(min_order_index) = NaN;
		                end
		            end
		
		            set(edit_table, 'Data', data);
		        end
		        function cb_save_edit(~, ~)
		            data = get(edit_table, 'Data');
		            order = cell2mat(data(:, 2))';
		            title = data(:, 3); title = title';
		            save_layout(el, order, title)
		
		            pe.reinit(el);
		            gui.draw()
		        end
		        function cb_cancel_edit(~, ~)
		            close(gui.f_layout)
		        end
		    end
		
		    if gui.get('MENUBAR') && gui.get('MENU_ABOUT') && ~check_graphics(gui.menu_about, 'uimenu') 
		% % %         gui.menu_about = uimenu(gui.f, 'Label', 'About');
		% % %         uimenu(gui.menu_about, ...
		% % %             'Label', 'BRAPH.org ...', ...
		% % %             'Callback', {@cb_web})
		% % %         uimenu(gui.menu_about, ...
		% % %             'Label', 'Forum...', ...
		% % %             'Callback', {@cb_forum})
		% % %         uimenu(gui.menu_about, ...
		% % %             'Label', 'Twitter ...', ...
		% % %             'Callback', {@cb_twitter})
		% % %         uimenu(gui.menu_about, ...
		% % %             'Label', 'License ...', ...
		% % %             'Callback', {@cb_license})
		% % %         uimenu(gui.menu_about, ...
		% % %             'Label', 'Credits ...', ...
		% % %             'Callback', {@cb_credits})
		        gui.menu_about = BRAPH2.add_menu_about(gui.f);
		    end
		% % %     function cb_web(~, ~)
		% % %         BRAPH2.web()
		% % %     end
		% % %     function cb_forum(~, ~)
		% % %         BRAPH2.forum()
		% % %     end
		% % %     function cb_twitter(~, ~)
		% % %         BRAPH2.twitter()
		% % %     end
		% % %     function cb_license(~, ~)
		% % %         BRAPH2.license()
		% % %     end
		% % %     function cb_credits(~, ~)
		% % %         BRAPH2.credits()
		% % %     end
		
		    %% Toolbar
		    if gui.get('TOOLBAR') && ~check_graphics(gui.toolbar, 'uitoolbar')
		        set(gui.f, 'Toolbar', 'figure')
		
		        gui.toolbar = findall(gui.f, 'Tag', 'FigureToolBar');
		
		        delete(findall(gui.toolbar, 'Tag', 'Standard.NewFigure'))
		        
		        if ~gui.get('TOOL_FIG')
		            delete(findall(gui.toolbar, 'Tag', 'Standard.PrintFigure'))
		            delete(findall(gui.toolbar, 'Tag', 'Standard.EditPlot'))
		            delete(findall(gui.toolbar, 'Tag', 'Standard.OpenInspector'))
		            delete(findall(gui.toolbar, 'Tag', 'Exploration.Brushing'))
		            delete(findall(gui.toolbar, 'Tag', 'DataManager.Linking'))
		            delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertColorbar'))
		            delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertLegend'))
		            delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOff'))
		            delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOn'))
		        else
		            toolbar_print = findall(gui.toolbar, 'Tag', 'Standard.PrintFigure');
		            set(toolbar_print, ...
		                'Separator', 'on' ...
		                )
		        end
		
		        if gui.get('TOOL_FILE')
		            % Open
		            toolbar_open = findall(gui.toolbar, 'Tag', 'Standard.FileOpen');
		            set(toolbar_open, ...
		                'Tag', 'BRAPH2.FileOpen', ...
		                'TooltipString', ['Open ' el.getName()], ...
		                'ClickedCallback', {@cb_open})
		            % Save
		            toolbar_save = findall(gui.toolbar, 'Tag', 'Standard.SaveFigure');
		            set(toolbar_save, ...
		                'Tag', 'BRAPH2.SaveFigure', ...
		                'TooltipString', ['Save ' el.getName()], ...
		                'ClickedCallback', {@cb_save})
		        else
		            toolbar_open = findall(gui.toolbar, 'Tag', 'Standard.FileOpen');
		            delete(findall(gui.toolbar, 'Tag', 'Standard.SaveFigure'))
		        end
		        
		        if gui.get('TOOL_ABOUT')
		% % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
		% % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
		% % % 
		% % %             % Website
		% % %             toolbar_web = uipushtool(gui.toolbar, ...
		% % %                 'Separator', 'on', ...
		% % %                 'TooltipString', 'Link to braph.org', ...
		% % %                 'CData', imresize(imread('icon_web.png'), [24 24]), ...
		% % %                 'ClickedCallback', {@cb_web});
		% % % 
		% % %             % Forum
		% % %             toolbar_web = uipushtool(gui.toolbar, ...
		% % %                 'Separator', 'off', ...
		% % %                 'TooltipString', 'Link to the BRAPH 2.0 forum', ...
		% % %                 'CData', imresize(imread('icon_forum.png'), [24 24]), ...
		% % %                 'ClickedCallback', {@cb_forum});
		% % % 
		% % %             % Twitter
		% % %             toolbar_web = uipushtool(gui.toolbar, ...
		% % %                 'Separator', 'off', ...
		% % %                 'TooltipString', 'Link to the BRAPH 2.0 Twitter', ...
		% % %                 'CData', imresize(imread('icon_twitter.png'), [24 24]), ...
		% % %                 'ClickedCallback', {@cb_twitter});
		% % % 
		% % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
		% % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
		% % % 
		% % %             % License
		% % %             toolbar_web = uipushtool(gui.toolbar, ...
		% % %                 'Separator', 'on', ...
		% % %                 'TooltipString', 'BRAPH 2.0 License', ...
		% % %                 'CData', imresize(imread('icon_license.png'), [24 24]), ...
		% % %                 'ClickedCallback', {@cb_license});
		% % % 
		% % %             % About
		% % %             toolbar_web = uipushtool(gui.toolbar, ...
		% % %                 'Separator', 'off', ...
		% % %                 'TooltipString', 'Informtion about BRAPH 2.0 and credits', ...
		% % %                 'CData', imresize(imread('icon_about.png'), [24 24]), ...
		% % %                 'ClickedCallback', {@cb_about});
		            BRAPH2.add_tool_about(gui.toolbar)
		        end
		    end
		
		    %% SHOW and OUTPUT
		    % show figure
		    set(gui.f, 'Visible', 'on')
		    
		    % output
		    if nargout > 0
		        f_out = gui.f;
		    end
		end
		function cb_bring_to_front(gui)
		    %CB_BRING_TO_FRONT brings to front the figure and its dependent figures.
		    %
		    % CB_BRING_TO_FRONT(GUI) brings to front the figure and its dependent figures 
		    %  by calling the methods cb_bring_to_front() for all the PlotProp
		    %  panels of the PlotElement. 
		    %  
		    % Note that it will draw anew the figure if it has been closed.
		    %
		    % See also cb_hide, cb_close.
		
		    % brings to front the main GUI
		    if check_graphics(gui.f, 'figure')
		        figure(gui.f) 
		        set(gui.f, ...
		            'Visible', 'on', ...
		            'WindowState', 'normal' ...
		            )
		    end
		    
		    % brings to front the other panels
		    pe = gui.get('PE');
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_bring_to_front()
		    end
		end
		function cb_hide(gui)
		    %CB_HIDE hides the figure and its dependent figures.
		    %
		    % CB_HIDE(GUI) hides the figure and its dependent figures 
		    %  by calling the methods cb_hide() for all the PlotProp
		    %  panels of the PlotElement. 
		    %
		    % See also cb_bring_to_front, cb_close.
		
		    % hides the main GUI
		    if check_graphics(gui.f, 'figure')
		        figure(gui.f)
		    end
		    
		    % hides the other panels
		    pe = gui.get('PE');
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_hide()
		    end
		end
		function cb_close(gui)
		    %CB_CLOSE closes the figure and its dependent figures.
		    %
		    % CB_CLOSE(GUI) closes the figure and its dependent figures 
		    %  by calling the methods cb_close() for all the PlotProp
		    %  panels of the PlotElement. 
		    %  
		    % See also cb_bring_to_front, cb_hide.
		
		    % determines GUI name
		    name = gui.get('NAME');
		    if isempty(name)
		        pe = gui.get('pe');
		        el = pe.get('el');
		        if el.existsTag('ID')
		            name = el.get('ID');
		        else
		            name = el.tostring();
		        end
		    end
		    
		    % closes the main GUI
		    if check_graphics(gui.f, 'figure')
		        if gui.get('CLOSEREQ')
		            selection = questdlg(['Do you want to close ' name '?'], ...
		                ['Close ' name], ...
		                'Yes', 'No', 'Yes');
		        else
		            selection = 'Yes';
		        end
		        switch selection
		            case 'Yes'
		                delete(gui.f)
		                if check_graphics(gui.f_layout, 'figure')
		                    close(gui.f_layout)
		                end
		            case 'No'
		                return
		        end
		    end
		    
		    % closes the other panels
		    pe = gui.get('PE');
		    pr_dict = pe.get('PR_DICT');
		    for prop = 1:1:pr_dict.length()
		        pr = pr_dict.getItem(prop);
		        pr.cb_close()
		    end
		end
	end
end
