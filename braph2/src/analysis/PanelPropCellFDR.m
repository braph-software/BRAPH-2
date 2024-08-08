classdef PanelPropCellFDR < PanelProp
	%PanelPropCellFDR plots the panel of a prop cell with fdr values.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (PanelPropCellFDR) plots the panel for a CELL prop with a table and two sliders.
	%   Paints of green color those cells that survive FDR correction. It works for all categories.
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
	% PanelPropCellFDR methods (constructor):
	%  PanelPropCellFDR - constructor
	%
	% PanelPropCellFDR methods:
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
	% PanelPropCellFDR methods (display):
	%  tostring - string with information about the cell prop panel fdr
	%  disp - displays information about the cell prop panel fdr
	%  tree - displays the tree of the cell prop panel fdr
	%
	% PanelPropCellFDR methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel fdr are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel fdr
	%
	% PanelPropCellFDR methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel fdr as b2 file
	%  load - loads a BRAPH2 cell prop panel fdr from a b2 file
	%
	% PanelPropCellFDR method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel fdr
	%
	% PanelPropCellFDR method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel fdr
	%
	% PanelPropCellFDR methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel fdr
	%  getSubclasses - returns all subclasses of PanelPropCellFDR
	%  getProps - returns the property list of the cell prop panel fdr
	%  getPropNumber - returns the property number of the cell prop panel fdr
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
	% PanelPropCellFDR methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropCellFDR methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropCellFDR methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropCellFDR methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropCellFDR; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropCellFDR constants</a>.
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
		
		TABLEQVALUE = PanelProp.getPropNumber() + 15;
		TABLEQVALUE_TAG = 'TABLEQVALUE';
		TABLEQVALUE_CATEGORY = Category.GUI;
		TABLEQVALUE_FORMAT = Format.SCALAR;
		
		TABLEFDR = PanelProp.getPropNumber() + 16;
		TABLEFDR_TAG = 'TABLEFDR';
		TABLEFDR_CATEGORY = Category.GUI;
		TABLEFDR_FORMAT = Format.LOGICAL;
		
		TABLE = PanelProp.getPropNumber() + 17;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 18;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropCellFDR(varargin)
			%PanelPropCellFDR() creates a cell prop panel fdr.
			%
			% PanelPropCellFDR(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropCellFDR(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the cell prop panel fdr.
			%
			% CLASS = PanelPropCellFDR.GETCLASS() returns the class 'PanelPropCellFDR'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel fdr PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropCellFDR') returns 'PanelPropCellFDR'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropCellFDR')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropCellFDR';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel fdr.
			%
			% LIST = PanelPropCellFDR.GETSUBCLASSES() returns all subclasses of 'PanelPropCellFDR'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel fdr PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropCellFDR') returns all subclasses of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropCellFDR', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel fdr.
			%
			% PROPS = PanelPropCellFDR.GETPROPS() returns the property list of cell prop panel fdr
			%  as a row vector.
			%
			% PROPS = PanelPropCellFDR.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel fdr PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropCellFDR'[, CATEGORY]) returns the property list of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropCellFDR.XSLIDERSHOW ...
						PanelPropCellFDR.XSLIDERLABELS ...
						PanelPropCellFDR.XSLIDERHEIGHT ...
						PanelPropCellFDR.XSLIDER ...
						PanelPropCellFDR.YSLIDERSHOW ...
						PanelPropCellFDR.YSLIDERLABELS ...
						PanelPropCellFDR.YSLIDERWIDTH ...
						PanelPropCellFDR.YSLIDER ...
						PanelPropCellFDR.XYSLIDERLOCK ...
						PanelPropCellFDR.ENABLE ...
						PanelPropCellFDR.ROWNAME ...
						PanelPropCellFDR.COLUMNNAME ...
						PanelPropCellFDR.MENU_EXPORT ...
						PanelPropCellFDR.TABLE_HEIGHT ...
						PanelPropCellFDR.TABLEQVALUE ...
						PanelPropCellFDR.TABLEFDR ...
						PanelPropCellFDR.TABLE ...
						PanelPropCellFDR.CONTEXTMENU ...
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
						PanelPropCellFDR.XSLIDER ...
						PanelPropCellFDR.YSLIDER ...
						PanelPropCellFDR.TABLE ...
						PanelPropCellFDR.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropCellFDR.XSLIDERSHOW ...
						PanelPropCellFDR.XSLIDERLABELS ...
						PanelPropCellFDR.XSLIDERHEIGHT ...
						PanelPropCellFDR.YSLIDERSHOW ...
						PanelPropCellFDR.YSLIDERLABELS ...
						PanelPropCellFDR.YSLIDERWIDTH ...
						PanelPropCellFDR.XYSLIDERLOCK ...
						PanelPropCellFDR.ENABLE ...
						PanelPropCellFDR.ROWNAME ...
						PanelPropCellFDR.COLUMNNAME ...
						PanelPropCellFDR.MENU_EXPORT ...
						PanelPropCellFDR.TABLE_HEIGHT ...
						PanelPropCellFDR.TABLEQVALUE ...
						PanelPropCellFDR.TABLEFDR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel fdr.
			%
			% N = PanelPropCellFDR.GETPROPNUMBER() returns the property number of cell prop panel fdr.
			%
			% N = PanelPropCellFDR.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel fdr
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel fdr PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropCellFDR') returns the property number of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropCellFDR.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel fdr/error.
			%
			% CHECK = PanelPropCellFDR.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropCellFDR, PROP) checks whether PROP exists for PanelPropCellFDR.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSPROP(PanelPropCellFDR, PROP) throws error if PROP does NOT exist for PanelPropCellFDR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropCellFDR.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropCellFDR.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel fdr/error.
			%
			% CHECK = PanelPropCellFDR.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropCellFDR, TAG) checks whether TAG exists for PanelPropCellFDR.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSTAG(PanelPropCellFDR, TAG) throws error if TAG does NOT exist for PanelPropCellFDR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropcellfdr_tag_list = cellfun(@(x) PanelPropCellFDR.getPropTag(x), num2cell(PanelPropCellFDR.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropcellfdr_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropCellFDR.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropCellFDR, POINTER) returns property number of POINTER of PanelPropCellFDR.
			%  PROPERTY = PR.GETPROPPROP(PanelPropCellFDR, POINTER) returns property number of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropcellfdr_tag_list = cellfun(@(x) PanelPropCellFDR.getPropTag(x), num2cell(PanelPropCellFDR.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropcellfdr_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropCellFDR, POINTER) returns tag of POINTER of PanelPropCellFDR.
			%  TAG = PR.GETPROPTAG(PanelPropCellFDR, POINTER) returns tag of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropCellFDR.XSLIDERSHOW
						tag = PanelPropCellFDR.XSLIDERSHOW_TAG;
					case PanelPropCellFDR.XSLIDERLABELS
						tag = PanelPropCellFDR.XSLIDERLABELS_TAG;
					case PanelPropCellFDR.XSLIDERHEIGHT
						tag = PanelPropCellFDR.XSLIDERHEIGHT_TAG;
					case PanelPropCellFDR.XSLIDER
						tag = PanelPropCellFDR.XSLIDER_TAG;
					case PanelPropCellFDR.YSLIDERSHOW
						tag = PanelPropCellFDR.YSLIDERSHOW_TAG;
					case PanelPropCellFDR.YSLIDERLABELS
						tag = PanelPropCellFDR.YSLIDERLABELS_TAG;
					case PanelPropCellFDR.YSLIDERWIDTH
						tag = PanelPropCellFDR.YSLIDERWIDTH_TAG;
					case PanelPropCellFDR.YSLIDER
						tag = PanelPropCellFDR.YSLIDER_TAG;
					case PanelPropCellFDR.XYSLIDERLOCK
						tag = PanelPropCellFDR.XYSLIDERLOCK_TAG;
					case PanelPropCellFDR.ENABLE
						tag = PanelPropCellFDR.ENABLE_TAG;
					case PanelPropCellFDR.ROWNAME
						tag = PanelPropCellFDR.ROWNAME_TAG;
					case PanelPropCellFDR.COLUMNNAME
						tag = PanelPropCellFDR.COLUMNNAME_TAG;
					case PanelPropCellFDR.MENU_EXPORT
						tag = PanelPropCellFDR.MENU_EXPORT_TAG;
					case PanelPropCellFDR.TABLE_HEIGHT
						tag = PanelPropCellFDR.TABLE_HEIGHT_TAG;
					case PanelPropCellFDR.TABLEQVALUE
						tag = PanelPropCellFDR.TABLEQVALUE_TAG;
					case PanelPropCellFDR.TABLEFDR
						tag = PanelPropCellFDR.TABLEFDR_TAG;
					case PanelPropCellFDR.TABLE
						tag = PanelPropCellFDR.TABLE_TAG;
					case PanelPropCellFDR.CONTEXTMENU
						tag = PanelPropCellFDR.CONTEXTMENU_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropCellFDR, POINTER) returns category of POINTER of PanelPropCellFDR.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropCellFDR, POINTER) returns category of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW
					prop_category = PanelPropCellFDR.XSLIDERSHOW_CATEGORY;
				case PanelPropCellFDR.XSLIDERLABELS
					prop_category = PanelPropCellFDR.XSLIDERLABELS_CATEGORY;
				case PanelPropCellFDR.XSLIDERHEIGHT
					prop_category = PanelPropCellFDR.XSLIDERHEIGHT_CATEGORY;
				case PanelPropCellFDR.XSLIDER
					prop_category = PanelPropCellFDR.XSLIDER_CATEGORY;
				case PanelPropCellFDR.YSLIDERSHOW
					prop_category = PanelPropCellFDR.YSLIDERSHOW_CATEGORY;
				case PanelPropCellFDR.YSLIDERLABELS
					prop_category = PanelPropCellFDR.YSLIDERLABELS_CATEGORY;
				case PanelPropCellFDR.YSLIDERWIDTH
					prop_category = PanelPropCellFDR.YSLIDERWIDTH_CATEGORY;
				case PanelPropCellFDR.YSLIDER
					prop_category = PanelPropCellFDR.YSLIDER_CATEGORY;
				case PanelPropCellFDR.XYSLIDERLOCK
					prop_category = PanelPropCellFDR.XYSLIDERLOCK_CATEGORY;
				case PanelPropCellFDR.ENABLE
					prop_category = PanelPropCellFDR.ENABLE_CATEGORY;
				case PanelPropCellFDR.ROWNAME
					prop_category = PanelPropCellFDR.ROWNAME_CATEGORY;
				case PanelPropCellFDR.COLUMNNAME
					prop_category = PanelPropCellFDR.COLUMNNAME_CATEGORY;
				case PanelPropCellFDR.MENU_EXPORT
					prop_category = PanelPropCellFDR.MENU_EXPORT_CATEGORY;
				case PanelPropCellFDR.TABLE_HEIGHT
					prop_category = PanelPropCellFDR.TABLE_HEIGHT_CATEGORY;
				case PanelPropCellFDR.TABLEQVALUE
					prop_category = PanelPropCellFDR.TABLEQVALUE_CATEGORY;
				case PanelPropCellFDR.TABLEFDR
					prop_category = PanelPropCellFDR.TABLEFDR_CATEGORY;
				case PanelPropCellFDR.TABLE
					prop_category = PanelPropCellFDR.TABLE_CATEGORY;
				case PanelPropCellFDR.CONTEXTMENU
					prop_category = PanelPropCellFDR.CONTEXTMENU_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropCellFDR, POINTER) returns format of POINTER of PanelPropCellFDR.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropCellFDR, POINTER) returns format of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW
					prop_format = PanelPropCellFDR.XSLIDERSHOW_FORMAT;
				case PanelPropCellFDR.XSLIDERLABELS
					prop_format = PanelPropCellFDR.XSLIDERLABELS_FORMAT;
				case PanelPropCellFDR.XSLIDERHEIGHT
					prop_format = PanelPropCellFDR.XSLIDERHEIGHT_FORMAT;
				case PanelPropCellFDR.XSLIDER
					prop_format = PanelPropCellFDR.XSLIDER_FORMAT;
				case PanelPropCellFDR.YSLIDERSHOW
					prop_format = PanelPropCellFDR.YSLIDERSHOW_FORMAT;
				case PanelPropCellFDR.YSLIDERLABELS
					prop_format = PanelPropCellFDR.YSLIDERLABELS_FORMAT;
				case PanelPropCellFDR.YSLIDERWIDTH
					prop_format = PanelPropCellFDR.YSLIDERWIDTH_FORMAT;
				case PanelPropCellFDR.YSLIDER
					prop_format = PanelPropCellFDR.YSLIDER_FORMAT;
				case PanelPropCellFDR.XYSLIDERLOCK
					prop_format = PanelPropCellFDR.XYSLIDERLOCK_FORMAT;
				case PanelPropCellFDR.ENABLE
					prop_format = PanelPropCellFDR.ENABLE_FORMAT;
				case PanelPropCellFDR.ROWNAME
					prop_format = PanelPropCellFDR.ROWNAME_FORMAT;
				case PanelPropCellFDR.COLUMNNAME
					prop_format = PanelPropCellFDR.COLUMNNAME_FORMAT;
				case PanelPropCellFDR.MENU_EXPORT
					prop_format = PanelPropCellFDR.MENU_EXPORT_FORMAT;
				case PanelPropCellFDR.TABLE_HEIGHT
					prop_format = PanelPropCellFDR.TABLE_HEIGHT_FORMAT;
				case PanelPropCellFDR.TABLEQVALUE
					prop_format = PanelPropCellFDR.TABLEQVALUE_FORMAT;
				case PanelPropCellFDR.TABLEFDR
					prop_format = PanelPropCellFDR.TABLEFDR_FORMAT;
				case PanelPropCellFDR.TABLE
					prop_format = PanelPropCellFDR.TABLE_FORMAT;
				case PanelPropCellFDR.CONTEXTMENU
					prop_format = PanelPropCellFDR.CONTEXTMENU_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropCellFDR, POINTER) returns description of POINTER of PanelPropCellFDR.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropCellFDR, POINTER) returns description of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW
					prop_description = 'XSLIDERSHOW (gui, logical) determines whether to show the xslider.';
				case PanelPropCellFDR.XSLIDERLABELS
					prop_description = 'XSLIDERLABELS (gui, stringlist) determines the xslider labels.';
				case PanelPropCellFDR.XSLIDERHEIGHT
					prop_description = 'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.';
				case PanelPropCellFDR.XSLIDER
					prop_description = 'XSLIDER (evanescent, handle) is the x-slider.';
				case PanelPropCellFDR.YSLIDERSHOW
					prop_description = 'YSLIDERSHOW (gui, logical) determines whether to show the yslider.';
				case PanelPropCellFDR.YSLIDERLABELS
					prop_description = 'YSLIDERLABELS (gui, stringlist) determines the yslider labels.';
				case PanelPropCellFDR.YSLIDERWIDTH
					prop_description = 'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.';
				case PanelPropCellFDR.YSLIDER
					prop_description = 'YSLIDER (evanescent, handle) is the y-slider.';
				case PanelPropCellFDR.XYSLIDERLOCK
					prop_description = 'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.';
				case PanelPropCellFDR.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case PanelPropCellFDR.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case PanelPropCellFDR.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case PanelPropCellFDR.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case PanelPropCellFDR.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case PanelPropCellFDR.TABLEQVALUE
					prop_description = 'TABLEQVALUE (gui, scalar) is the mask value of the table use in fdr';
				case PanelPropCellFDR.TABLEFDR
					prop_description = 'TABLEFDR (gui, logical) is the mask value of the table use in fdr';
				case PanelPropCellFDR.TABLE
					prop_description = 'TABLE (evanescent, handle) is the alpha value edit field.';
				case PanelPropCellFDR.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case PanelPropCellFDR.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the cell prop panel.';
				case PanelPropCellFDR.NAME
					prop_description = 'NAME (constant, string) is the name of the cell prop panel.';
				case PanelPropCellFDR.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cell prop panel.';
				case PanelPropCellFDR.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cell prop panel.';
				case PanelPropCellFDR.ID
					prop_description = 'ID (data, string) is a few-letter code for the cell prop panel.';
				case PanelPropCellFDR.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cell prop panel.';
				case PanelPropCellFDR.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cell prop panel.';
				case PanelPropCellFDR.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropCellFDR.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case PanelPropCellFDR.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case PanelPropCellFDR.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case PanelPropCellFDR.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropCellFDR.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropCellFDR, POINTER) returns settings of POINTER of PanelPropCellFDR.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropCellFDR, POINTER) returns settings of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCellFDR.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCellFDR.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCellFDR.XSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCellFDR.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCellFDR.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCellFDR.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCellFDR.YSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCellFDR.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCellFDR.ENABLE
					prop_settings = {'on', 'off'};
				case PanelPropCellFDR.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCellFDR.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropCellFDR.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCellFDR.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropCellFDR.TABLEQVALUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PanelPropCellFDR.TABLEFDR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropCellFDR.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCellFDR.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropCellFDR.TEMPLATE
					prop_settings = 'PanelPropCellFDR';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropCellFDR, POINTER) returns the default value of POINTER of PanelPropCellFDR.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropCellFDR, POINTER) returns the default value of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW
					prop_default = true;
				case PanelPropCellFDR.XSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XSLIDERHEIGHT
					prop_default = s(3);
				case PanelPropCellFDR.XSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDERSHOW
					prop_default = true;
				case PanelPropCellFDR.YSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDERWIDTH
					prop_default = s(3);
				case PanelPropCellFDR.YSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XYSLIDERLOCK
					prop_default = false;
				case PanelPropCellFDR.ENABLE
					prop_default = 'on';
				case PanelPropCellFDR.ROWNAME
					prop_default = {'numbered'};
				case PanelPropCellFDR.COLUMNNAME
					prop_default = {'numbered'};
				case PanelPropCellFDR.MENU_EXPORT
					prop_default = true;
				case PanelPropCellFDR.TABLE_HEIGHT
					prop_default = s(20);
				case PanelPropCellFDR.TABLEQVALUE
					prop_default = 0.05;
				case PanelPropCellFDR.TABLEFDR
					prop_default = false;
				case PanelPropCellFDR.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.ELCLASS
					prop_default = 'PanelPropCellFDR';
				case PanelPropCellFDR.NAME
					prop_default = 'Cell Prop Panel FDR';
				case PanelPropCellFDR.DESCRIPTION
					prop_default = 'A Cell Prop Panel (PanelPropCellFDR) plots the panel for a CELL prop with a table and two sliders. Paints of green color those cells that survive FDR correction. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case PanelPropCellFDR.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.ID
					prop_default = 'PanelPropCellFDR ID';
				case PanelPropCellFDR.LABEL
					prop_default = 'PanelPropCellFDR label';
				case PanelPropCellFDR.NOTES
					prop_default = 'PanelPropCellFDR notes';
				case PanelPropCellFDR.EL
					prop_default = Graph();
				case PanelPropCellFDR.PROP
					prop_default = Graph.A;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropCellFDR, POINTER) returns the conditioned default value of POINTER of PanelPropCellFDR.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropCellFDR, POINTER) returns the conditioned default value of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			prop_default = PanelPropCellFDR.conditioning(prop, PanelPropCellFDR.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropCellFDR, PROP, VALUE) checks VALUE format for PROP of PanelPropCellFDR.
			%  CHECK = PR.CHECKPROP(PanelPropCellFDR, PROP, VALUE) checks VALUE format for PROP of PanelPropCellFDR.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropCellFDR:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropCellFDR:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropCellFDR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCellFDR.
			%   Error id: €BRAPH2.STR€:PanelPropCellFDR:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropCellFDR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCellFDR.
			%   Error id: €BRAPH2.STR€:PanelPropCellFDR:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case PanelPropCellFDR.XSLIDERSHOW % __PanelPropCellFDR.XSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XSLIDERLABELS % __PanelPropCellFDR.XSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XSLIDERHEIGHT % __PanelPropCellFDR.XSLIDERHEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XSLIDER % __PanelPropCellFDR.XSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDERSHOW % __PanelPropCellFDR.YSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDERLABELS % __PanelPropCellFDR.YSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDERWIDTH % __PanelPropCellFDR.YSLIDERWIDTH__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.YSLIDER % __PanelPropCellFDR.YSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.XYSLIDERLOCK % __PanelPropCellFDR.XYSLIDERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.ENABLE % __PanelPropCellFDR.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.ROWNAME % __PanelPropCellFDR.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.COLUMNNAME % __PanelPropCellFDR.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.MENU_EXPORT % __PanelPropCellFDR.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.TABLE_HEIGHT % __PanelPropCellFDR.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.TABLEQVALUE % __PanelPropCellFDR.TABLEQVALUE__
					check = Format.checkFormat(Format.SCALAR, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.TABLEFDR % __PanelPropCellFDR.TABLEFDR__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.TABLE % __PanelPropCellFDR.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.CONTEXTMENU % __PanelPropCellFDR.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropCellFDR.getPropSettings(prop));
				case PanelPropCellFDR.TEMPLATE % __PanelPropCellFDR.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropCellFDR.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropCellFDR:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropCellFDR.getPropTag(prop) ' (' PanelPropCellFDR.getFormatTag(PanelPropCellFDR.getPropFormat(prop)) ').'] ...
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
				case PanelPropCellFDR.ROWNAME % __PanelPropCellFDR.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case PanelPropCellFDR.COLUMNNAME % __PanelPropCellFDR.COLUMNNAME__
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
				case PanelPropCellFDR.XSLIDER % __PanelPropCellFDR.XSLIDER__
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
					
				case PanelPropCellFDR.YSLIDER % __PanelPropCellFDR.YSLIDER__
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
					
				case PanelPropCellFDR.TABLE % __PanelPropCellFDR.TABLE__
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
					
				case PanelPropCellFDR.CONTEXTMENU % __PanelPropCellFDR.CONTEXTMENU__
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
					
				case PanelPropCellFDR.X_DRAW % __PanelPropCellFDR.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case PanelPropCellFDR.UPDATE % __PanelPropCellFDR.UPDATE__
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
					    end
					
					    % fdr
					    tmp_val = get(pr.get('TABLE'), 'DATA');
					    if size(tmp_val, 2) == 1
					        tmp_val = tmp_val';
					    end
					    if pr.get('TABLEFDR')
					        [~, mask] = fdr(tmp_val, pr.get('TABLEQVALUE'));
					        s = uistyle("BackgroundColor", BRAPH2.COL_FDR);
					        if size(mask, 1) == 1
					            mask = mask';
					        end
					        [row, col] = find(mask);
					        addStyle(pr.get('TABLE'), s, "cell", [row, col]);
					    end
					end
					
				case PanelPropCellFDR.REDRAW % __PanelPropCellFDR.REDRAW__
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
					
				case PanelPropCellFDR.DELETE % __PanelPropCellFDR.DELETE__
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
		end
	end
end
