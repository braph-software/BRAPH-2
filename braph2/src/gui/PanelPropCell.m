classdef PanelPropCell < PanelProp
	%PanelPropCell plots the panel of a property cell.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (PanelPropCell) plots the panel for a CELL property with a table and two sliders.
	% It works for all categories.
	% 
	% It can be personalized with the following props:
	%  TABLE_HEIGHT - Panel height in pixels when the table is shown.
	%  XSLIDERSHOW - Whether to show the x-slider.
	%  XSLIDERLABELS - Labels for the x-slider.
	%  XSLIDERHEIGHT - Height of x-slider in pixels.
	%  YSLIDERSHOW - Whether to show the y-slider.
	%  YSLIDERLABELS - Labels for the y-slider.
	%  YSLIDERWIDTH - Width of y-slider in pixels.
	%  XYSLIDERLOCK - Whether the sliders are locked so that only the diagonal is shown.
	%  ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  MENU_EXPORT - Whether to show the export menu. To be defined before drawing.
	%
	% PanelPropCell methods (constructor):
	%  PanelPropCell - constructor
	%
	% PanelPropCell methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% PanelPropCell methods (display):
	%  tostring - string with information about the cell prop panel
	%  disp - displays information about the cell prop panel
	%  tree - displays the tree of the cell prop panel
	%
	% PanelPropCell methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel
	%
	% PanelPropCell methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel as b2 file
	%  load - loads a BRAPH2 cell prop panel from a b2 file
	%
	% PanelPropCell method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel
	%
	% PanelPropCell method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel
	%
	% PanelPropCell methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel
	%  getSubclasses - returns all subclasses of PanelPropCell
	%  getProps - returns the property list of the cell prop panel
	%  getPropNumber - returns the property number of the cell prop panel
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% PanelPropCell methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropCell methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropCell methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropCell methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropCell; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropCell constants</a>.
	%
	%
	% See also uitable, uislider, GUI, PanelElement.
	
	properties (Constant) % properties
		XSLIDERSHOW = PanelProp.getPropNumber() + 1;
		XSLIDERSHOW_TAG = 'XSLIDERSHOW';
		XSLIDERSHOW_CATEGORY = Category.GUI;
		XSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		XSLIDERLABELS = PanelProp.getPropNumber() + 2;
		XSLIDERLABELS_TAG = 'XSLIDERLABELS';
		XSLIDERLABELS_CATEGORY = Category.GUI;
		XSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		XSLIDERHEIGHT = PanelProp.getPropNumber() + 3;
		XSLIDERHEIGHT_TAG = 'XSLIDERHEIGHT';
		XSLIDERHEIGHT_CATEGORY = Category.GUI;
		XSLIDERHEIGHT_FORMAT = Format.SIZE;
		
		XSLIDER = PanelProp.getPropNumber() + 4;
		XSLIDER_TAG = 'XSLIDER';
		XSLIDER_CATEGORY = Category.EVANESCENT;
		XSLIDER_FORMAT = Format.HANDLE;
		
		YSLIDERSHOW = PanelProp.getPropNumber() + 5;
		YSLIDERSHOW_TAG = 'YSLIDERSHOW';
		YSLIDERSHOW_CATEGORY = Category.GUI;
		YSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		YSLIDERLABELS = PanelProp.getPropNumber() + 6;
		YSLIDERLABELS_TAG = 'YSLIDERLABELS';
		YSLIDERLABELS_CATEGORY = Category.GUI;
		YSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		YSLIDERWIDTH = PanelProp.getPropNumber() + 7;
		YSLIDERWIDTH_TAG = 'YSLIDERWIDTH';
		YSLIDERWIDTH_CATEGORY = Category.GUI;
		YSLIDERWIDTH_FORMAT = Format.SIZE;
		
		YSLIDER = PanelProp.getPropNumber() + 8;
		YSLIDER_TAG = 'YSLIDER';
		YSLIDER_CATEGORY = Category.EVANESCENT;
		YSLIDER_FORMAT = Format.HANDLE;
		
		XYSLIDERLOCK = PanelProp.getPropNumber() + 9;
		XYSLIDERLOCK_TAG = 'XYSLIDERLOCK';
		XYSLIDERLOCK_CATEGORY = Category.GUI;
		XYSLIDERLOCK_FORMAT = Format.LOGICAL;
		
		ENABLE = PanelProp.getPropNumber() + 10;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 11;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 12;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 13;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 14;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		TABLE = PanelProp.getPropNumber() + 15;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 16;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropCell(varargin)
			%PanelPropCell() creates a cell prop panel.
			%
			% PanelPropCell(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropCell(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the cell prop panel.
			%
			% CLASS = PanelPropCell.GETCLASS() returns the class 'PanelPropCell'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropCell') returns 'PanelPropCell'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropCell')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropCell';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel.
			%
			% LIST = PanelPropCell.GETSUBCLASSES() returns all subclasses of 'PanelPropCell'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropCell') returns all subclasses of 'PanelPropCell'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropCell', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel.
			%
			% PROPS = PanelPropCell.GETPROPS() returns the property list of cell prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropCell.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropCell'[, CATEGORY]) returns the property list of 'PanelPropCell'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropCell.XSLIDERSHOW ...
						PanelPropCell.XSLIDERLABELS ...
						PanelPropCell.XSLIDERHEIGHT ...
						PanelPropCell.XSLIDER ...
						PanelPropCell.YSLIDERSHOW ...
						PanelPropCell.YSLIDERLABELS ...
						PanelPropCell.YSLIDERWIDTH ...
						PanelPropCell.YSLIDER ...
						PanelPropCell.XYSLIDERLOCK ...
						PanelPropCell.ENABLE ...
						PanelPropCell.ROWNAME ...
						PanelPropCell.COLUMNNAME ...
						PanelPropCell.MENU_EXPORT ...
						PanelPropCell.TABLE_HEIGHT ...
						PanelPropCell.TABLE ...
						PanelPropCell.CONTEXTMENU ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						PanelPropCell.XSLIDER ...
						PanelPropCell.YSLIDER ...
						PanelPropCell.TABLE ...
						PanelPropCell.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropCell.XSLIDERSHOW ...
						PanelPropCell.XSLIDERLABELS ...
						PanelPropCell.XSLIDERHEIGHT ...
						PanelPropCell.YSLIDERSHOW ...
						PanelPropCell.YSLIDERLABELS ...
						PanelPropCell.YSLIDERWIDTH ...
						PanelPropCell.XYSLIDERLOCK ...
						PanelPropCell.ENABLE ...
						PanelPropCell.ROWNAME ...
						PanelPropCell.COLUMNNAME ...
						PanelPropCell.MENU_EXPORT ...
						PanelPropCell.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel.
			%
			% N = PanelPropCell.GETPROPNUMBER() returns the property number of cell prop panel.
			%
			% N = PanelPropCell.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropCell') returns the property number of 'PanelPropCell'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropCell.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel/error.
			%
			% CHECK = PanelPropCell.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropCell, PROP) checks whether PROP exists for PanelPropCell.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropCell:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%  Element.EXISTSPROP(PanelPropCell, PROP) throws error if PROP does NOT exist for PanelPropCell.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropCell.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropCell.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel/error.
			%
			% CHECK = PanelPropCell.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropCell, TAG) checks whether TAG exists for PanelPropCell.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropCell:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%  Element.EXISTSTAG(PanelPropCell, TAG) throws error if TAG does NOT exist for PanelPropCell.
			%   Error id: [BRAPH2:PanelPropCell:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropcell_tag_list = cellfun(@(x) PanelPropCell.getPropTag(x), num2cell(PanelPropCell.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropcell_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropCell.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropCell, POINTER) returns property number of POINTER of PanelPropCell.
			%  PROPERTY = PR.GETPROPPROP(PanelPropCell, POINTER) returns property number of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropcell_tag_list = cellfun(@(x) PanelPropCell.getPropTag(x), num2cell(PanelPropCell.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropcell_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
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
			%  TAG = Element.GETPROPTAG(PanelPropCell, POINTER) returns tag of POINTER of PanelPropCell.
			%  TAG = PR.GETPROPTAG(PanelPropCell, POINTER) returns tag of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropCell.XSLIDERSHOW
						tag = PanelPropCell.XSLIDERSHOW_TAG;
					case PanelPropCell.XSLIDERLABELS
						tag = PanelPropCell.XSLIDERLABELS_TAG;
					case PanelPropCell.XSLIDERHEIGHT
						tag = PanelPropCell.XSLIDERHEIGHT_TAG;
					case PanelPropCell.XSLIDER
						tag = PanelPropCell.XSLIDER_TAG;
					case PanelPropCell.YSLIDERSHOW
						tag = PanelPropCell.YSLIDERSHOW_TAG;
					case PanelPropCell.YSLIDERLABELS
						tag = PanelPropCell.YSLIDERLABELS_TAG;
					case PanelPropCell.YSLIDERWIDTH
						tag = PanelPropCell.YSLIDERWIDTH_TAG;
					case PanelPropCell.YSLIDER
						tag = PanelPropCell.YSLIDER_TAG;
					case PanelPropCell.XYSLIDERLOCK
						tag = PanelPropCell.XYSLIDERLOCK_TAG;
					case PanelPropCell.ENABLE
						tag = PanelPropCell.ENABLE_TAG;
					case PanelPropCell.ROWNAME
						tag = PanelPropCell.ROWNAME_TAG;
					case PanelPropCell.COLUMNNAME
						tag = PanelPropCell.COLUMNNAME_TAG;
					case PanelPropCell.MENU_EXPORT
						tag = PanelPropCell.MENU_EXPORT_TAG;
					case PanelPropCell.TABLE_HEIGHT
						tag = PanelPropCell.TABLE_HEIGHT_TAG;
					case PanelPropCell.TABLE
						tag = PanelPropCell.TABLE_TAG;
					case PanelPropCell.CONTEXTMENU
						tag = PanelPropCell.CONTEXTMENU_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropCell, POINTER) returns category of POINTER of PanelPropCell.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropCell, POINTER) returns category of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW
					prop_category = PanelPropCell.XSLIDERSHOW_CATEGORY;
				case PanelPropCell.XSLIDERLABELS
					prop_category = PanelPropCell.XSLIDERLABELS_CATEGORY;
				case PanelPropCell.XSLIDERHEIGHT
					prop_category = PanelPropCell.XSLIDERHEIGHT_CATEGORY;
				case PanelPropCell.XSLIDER
					prop_category = PanelPropCell.XSLIDER_CATEGORY;
				case PanelPropCell.YSLIDERSHOW
					prop_category = PanelPropCell.YSLIDERSHOW_CATEGORY;
				case PanelPropCell.YSLIDERLABELS
					prop_category = PanelPropCell.YSLIDERLABELS_CATEGORY;
				case PanelPropCell.YSLIDERWIDTH
					prop_category = PanelPropCell.YSLIDERWIDTH_CATEGORY;
				case PanelPropCell.YSLIDER
					prop_category = PanelPropCell.YSLIDER_CATEGORY;
				case PanelPropCell.XYSLIDERLOCK
					prop_category = PanelPropCell.XYSLIDERLOCK_CATEGORY;
				case PanelPropCell.ENABLE
					prop_category = PanelPropCell.ENABLE_CATEGORY;
				case PanelPropCell.ROWNAME
					prop_category = PanelPropCell.ROWNAME_CATEGORY;
				case PanelPropCell.COLUMNNAME
					prop_category = PanelPropCell.COLUMNNAME_CATEGORY;
				case PanelPropCell.MENU_EXPORT
					prop_category = PanelPropCell.MENU_EXPORT_CATEGORY;
				case PanelPropCell.TABLE_HEIGHT
					prop_category = PanelPropCell.TABLE_HEIGHT_CATEGORY;
				case PanelPropCell.TABLE
					prop_category = PanelPropCell.TABLE_CATEGORY;
				case PanelPropCell.CONTEXTMENU
					prop_category = PanelPropCell.CONTEXTMENU_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropCell, POINTER) returns format of POINTER of PanelPropCell.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropCell, POINTER) returns format of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW
					prop_format = PanelPropCell.XSLIDERSHOW_FORMAT;
				case PanelPropCell.XSLIDERLABELS
					prop_format = PanelPropCell.XSLIDERLABELS_FORMAT;
				case PanelPropCell.XSLIDERHEIGHT
					prop_format = PanelPropCell.XSLIDERHEIGHT_FORMAT;
				case PanelPropCell.XSLIDER
					prop_format = PanelPropCell.XSLIDER_FORMAT;
				case PanelPropCell.YSLIDERSHOW
					prop_format = PanelPropCell.YSLIDERSHOW_FORMAT;
				case PanelPropCell.YSLIDERLABELS
					prop_format = PanelPropCell.YSLIDERLABELS_FORMAT;
				case PanelPropCell.YSLIDERWIDTH
					prop_format = PanelPropCell.YSLIDERWIDTH_FORMAT;
				case PanelPropCell.YSLIDER
					prop_format = PanelPropCell.YSLIDER_FORMAT;
				case PanelPropCell.XYSLIDERLOCK
					prop_format = PanelPropCell.XYSLIDERLOCK_FORMAT;
				case PanelPropCell.ENABLE
					prop_format = PanelPropCell.ENABLE_FORMAT;
				case PanelPropCell.ROWNAME
					prop_format = PanelPropCell.ROWNAME_FORMAT;
				case PanelPropCell.COLUMNNAME
					prop_format = PanelPropCell.COLUMNNAME_FORMAT;
				case PanelPropCell.MENU_EXPORT
					prop_format = PanelPropCell.MENU_EXPORT_FORMAT;
				case PanelPropCell.TABLE_HEIGHT
					prop_format = PanelPropCell.TABLE_HEIGHT_FORMAT;
				case PanelPropCell.TABLE
					prop_format = PanelPropCell.TABLE_FORMAT;
				case PanelPropCell.CONTEXTMENU
					prop_format = PanelPropCell.CONTEXTMENU_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropCell, POINTER) returns description of POINTER of PanelPropCell.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropCell, POINTER) returns description of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW
					prop_description = 'XSLIDERSHOW (gui, logical) determines whether to show the xslider.';
				case PanelPropCell.XSLIDERLABELS
					prop_description = 'XSLIDERLABELS (gui, stringlist) determines the xslider labels.';
				case PanelPropCell.XSLIDERHEIGHT
					prop_description = 'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.';
				case PanelPropCell.XSLIDER
					prop_description = 'XSLIDER (evanescent, handle) is the x-slider.';
				case PanelPropCell.YSLIDERSHOW
					prop_description = 'YSLIDERSHOW (gui, logical) determines whether to show the yslider.';
				case PanelPropCell.YSLIDERLABELS
					prop_description = 'YSLIDERLABELS (gui, stringlist) determines the yslider labels.';
				case PanelPropCell.YSLIDERWIDTH
					prop_description = 'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.';
				case PanelPropCell.YSLIDER
					prop_description = 'YSLIDER (evanescent, handle) is the y-slider.';
				case PanelPropCell.XYSLIDERLOCK
					prop_description = 'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.';
				case PanelPropCell.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case PanelPropCell.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case PanelPropCell.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case PanelPropCell.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case PanelPropCell.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case PanelPropCell.TABLE
					prop_description = 'TABLE (evanescent, handle) is the alpha value edit field.';
				case PanelPropCell.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case PanelPropCell.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the cell property panel.';
				case PanelPropCell.NAME
					prop_description = 'NAME (constant, string) is the name of the cell property panel.';
				case PanelPropCell.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cell property panel.';
				case PanelPropCell.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cell property panel.';
				case PanelPropCell.ID
					prop_description = 'ID (data, string) is a few-letter code for the cell property panel.';
				case PanelPropCell.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cell property panel.';
				case PanelPropCell.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cell property panel.';
				case PanelPropCell.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropCell.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropCell.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropCell.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case PanelPropCell.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropCell.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropCell, POINTER) returns settings of POINTER of PanelPropCell.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropCell, POINTER) returns settings of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCell.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCell.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCell.XSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCell.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCell.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCell.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCell.YSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCell.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCell.ENABLE
					prop_settings = {'on', 'off'};
				case PanelPropCell.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCell.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCell.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCell.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCell.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCell.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCell.TEMPLATE
					prop_settings = 'PanelPropCell';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropCell.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCell.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropCell, POINTER) returns the default value of POINTER of PanelPropCell.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropCell, POINTER) returns the default value of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW
					prop_default = true;
				case PanelPropCell.XSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XSLIDERHEIGHT
					prop_default = s(3);
				case PanelPropCell.XSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDERSHOW
					prop_default = true;
				case PanelPropCell.YSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDERWIDTH
					prop_default = s(3);
				case PanelPropCell.YSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XYSLIDERLOCK
					prop_default = false;
				case PanelPropCell.ENABLE
					prop_default = 'on';
				case PanelPropCell.ROWNAME
					prop_default = {'numbered'};
				case PanelPropCell.COLUMNNAME
					prop_default = {'numbered'};
				case PanelPropCell.MENU_EXPORT
					prop_default = true;
				case PanelPropCell.TABLE_HEIGHT
					prop_default = s(20);
				case PanelPropCell.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.ELCLASS
					prop_default = 'PanelPropCell';
				case PanelPropCell.NAME
					prop_default = 'Cell Prop Panel';
				case PanelPropCell.DESCRIPTION
					prop_default = 'A Cell Prop Panel (PanelPropCell) plots the panel for a CELL property with a table and two sliders. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case PanelPropCell.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.ID
					prop_default = 'PanelPropCell ID';
				case PanelPropCell.LABEL
					prop_default = 'PanelPropCell label';
				case PanelPropCell.NOTES
					prop_default = 'PanelPropCell notes';
				case PanelPropCell.EL
					prop_default = Graph();
				case PanelPropCell.PROP
					prop_default = Graph.A;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropCell.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCell.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropCell, POINTER) returns the conditioned default value of POINTER of PanelPropCell.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropCell, POINTER) returns the conditioned default value of POINTER of PanelPropCell.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			prop_default = PanelPropCell.conditioning(prop, PanelPropCell.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(PanelPropCell, PROP, VALUE) checks VALUE format for PROP of PanelPropCell.
			%  CHECK = PR.CHECKPROP(PanelPropCell, PROP, VALUE) checks VALUE format for PROP of PanelPropCell.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropCell:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropCell:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropCell, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCell.
			%   Error id: €BRAPH2.STR€:PanelPropCell:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropCell, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCell.
			%   Error id: €BRAPH2.STR€:PanelPropCell:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropCell')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropCell.getPropProp(pointer);
			
			switch prop
				case PanelPropCell.XSLIDERSHOW % __PanelPropCell.XSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XSLIDERLABELS % __PanelPropCell.XSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XSLIDERHEIGHT % __PanelPropCell.XSLIDERHEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XSLIDER % __PanelPropCell.XSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDERSHOW % __PanelPropCell.YSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDERLABELS % __PanelPropCell.YSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDERWIDTH % __PanelPropCell.YSLIDERWIDTH__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.YSLIDER % __PanelPropCell.YSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.XYSLIDERLOCK % __PanelPropCell.XYSLIDERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.ENABLE % __PanelPropCell.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.ROWNAME % __PanelPropCell.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.COLUMNNAME % __PanelPropCell.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.MENU_EXPORT % __PanelPropCell.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.TABLE_HEIGHT % __PanelPropCell.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.TABLE % __PanelPropCell.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.CONTEXTMENU % __PanelPropCell.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCell.getPropSettings(prop));
				case PanelPropCell.TEMPLATE % __PanelPropCell.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropCell.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCell:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropCell.getPropTag(prop) ' (' PanelPropCell.getFormatTag(PanelPropCell.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case PanelPropCell.ROWNAME % __PanelPropCell.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case PanelPropCell.COLUMNNAME % __PanelPropCell.COLUMNNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						postset@PanelProp(pr, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case PanelPropCell.XSLIDER % __PanelPropCell.XSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					xslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'XSLIDER', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_xslider} ...
					    );
					
					value = xslider;
					
				case PanelPropCell.YSLIDER % __PanelPropCell.YSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					yslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'YSLIDER', ...
					    'Orientation', 'vertical', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_yslider} ...
					    );
					
					value = yslider;
					
				case PanelPropCell.TABLE % __PanelPropCell.TABLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TABLE', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					value = table;
					
				case PanelPropCell.CONTEXTMENU % __PanelPropCell.CONTEXTMENU__
					contextmenu = uicontextmenu(...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_export_to_xls = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_EXPORT_TO_XLS', ...
					    'Text', 'Export to XLS', ...
					    'MenuSelectedFcn', {@cb_export_to_xls} ...
					    );
					if pr.get('MENU_EXPORT')
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					value = contextmenu;
					
				case PanelPropCell.X_DRAW % __PanelPropCell.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case PanelPropCell.UPDATE % __PanelPropCell.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        pr.set('HEIGHT', pr.get('TABLE_HEIGHT'))
					    end
					    
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    % % % %TODO Add the management of the cases where the names are different for each cell
					    rowname = pr.get('ROWNAME');
					    if isequal(rowname, {'numbered'})
					        rowname = 'numbered';
					    end
					    columnname = pr.get('COLUMNNAME');
					    if isequal(columnname, {'numbered'})
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', false ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('TABLE'), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                % don't plot anything for a result not yet calculated
					                set(pr.get('TABLE'), 'Visible', 'off')
					                set(pr.get('XSLIDER'), 'Visible', 'off')
					                set(pr.get('YSLIDER'), 'Visible', 'off')
					            else
					                set(pr.get('TABLE'), ...
					                    'Data', set_sliders_and_get_value(), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false, ...
					                    'Visible', 'on' ...
					                    )
					            end
					            
					% % %                 if (isa(el, 'ComparisonGroup') | isa(el, 'ComparisonEnsemble')) && el.existsTag('QVALUE')
					% % %                     
					% % %                     tmp_data = get_p_value();
					% % %                     
					% % %                     if size(tmp_data, 1) > size(tmp_data, 2)
					% % %                         tmp_data = tmp_data';
					% % %                     end
					% % %                     
					% % %                     [~, mask] = fdr(tmp_data, el.get('QVALUE'));
					% % %                     [cols, rows] = find(mask);
					% % %                     
					% % %                     if ~isempty(rows) && ~isempty(cols)
					% % %                         s = uistyle('BackgroundColor',[146/255 179/255 175/255]);
					% % %                         addStyle(pr.table, s, 'cell', [rows', cols']);
					% % %                     else
					% % %                         non_sign = ones(size(mask));
					% % %                         [cols, rows] = find(non_sign - mask);
					% % %                         s = uistyle('BackgroundColor', [1 1 1]); % default color, no significance
					% % %                         addStyle(pr.table, s, 'cell', [rows', cols']);
					% % %                     end
					% % %                 end
					% % %             end
					    end
					end
					
				case PanelPropCell.REDRAW % __PanelPropCell.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    if ~pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2))])
					    elseif pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3) max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)) 3])
					    elseif ~pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2))])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2))])
					    else % pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) 3])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2)-s(.6)-pr.get('XSLIDERHEIGHT'))])
					    end
					end
					
				case PanelPropCell.DELETE % __PanelPropCell.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('XSLIDER', Element.getNoValue())
					    pr.set('YSLIDER', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_xslider(~, ~)
			    set(pr.get('XSLIDER'), 'Value', round(get(pr.get('XSLIDER'), 'Value')))
			    
			    % if pr.get('XYSLIDERLOCK')
			    %     el = pr.get('EL');
			    %     prop = pr.get('PROP');
			    %     value = el.get(prop);
			    %     [R, C] = size(value);
			    % 
			    %     R = max(R, 1); % to manage the case in which C = R = 0 (empty cell)
			    % 
			    %     set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			    % end
			    
			    pr.get('UPDATE')
			end
			function cb_yslider(~, ~)
			    set(pr.get('YSLIDER'), 'Value', round(get(pr.get('YSLIDER'), 'Value')))
			    
			    if pr.get('XYSLIDERLOCK')
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        value = el.get(prop);
			        [R, C] = size(value);
			        
			        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)
			
			        set(pr.get('XSLIDER'), 'Value', C + 1 - get(pr.get('YSLIDER'), 'Value'))
			    end
			
			    pr.get('UPDATE')
			end
			function cb_table(~, event)
			    i = event.Indices(1);
			    j = event.Indices(2); 
			    newdata = event.NewData;
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    value = el.get(prop);
			    [R, C] = size(value);
			    
			    r = R + 1 - get(pr.get('YSLIDER'), 'Value');
			    c = get(pr.get('XSLIDER'), 'Value');
			    
			    value_rc = value{r, c};
			    value_rc(i, j) = newdata;
			    value{r, c} = value_rc;
			    el.set(prop, value)
			end
			function cb_export_to_xls(~, ~)
			    table = pr.get('TABLE');
			    data = table.Data;
			    
			    columns = table.ColumnName;
			    if isempty(columns)
			        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    elseif isequal(columns, 'numbered')
			        columns = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    end
			    
			    rows = table.RowName;
			    if isempty(rows)
			        rows = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    elseif isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    end
			    
			    t = cell2table([rows, num2cell(data)], ...
			        'VariableNames', [' '; columns] ...
			        );
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function value = set_sliders_and_get_value()
			    value = el.get(prop);
			    if isempty(value)
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			    else
			        [R, C] = size(value);
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 C+.4], ...
			            'MajorTicks', [1:1:C], ...
			            'MajorTickLabels', pr.get('XSLIDERLABELS'), ...
			            'Value', max(1, min(round(get(pr.get('XSLIDER'), 'Value'), C))), ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 R+.4], ...
			            'MajorTicks', [1:1:R], ...
			            'MajorTickLabels', flip(pr.get('YSLIDERLABELS')), ...
			            'Value', max(1, min(round(get(pr.get('YSLIDER'), 'Value'), R))), ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			
			        if pr.get('XYSLIDERLOCK')
			            set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			        end
			
			        value = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
			    end
			end
			% % %     function pval = get_p_value()
			% % %         value = el.get('P2');
			% % %         [R, ~] = size(value);
			% % %         pval = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
			% % %     end
		end
	end
end
