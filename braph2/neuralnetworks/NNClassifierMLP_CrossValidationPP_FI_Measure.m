classdef NNClassifierMLP_CrossValidationPP_FI_Measure < PanelProp
	%NNClassifierMLP_CrossValidationPP_FI_Measure plots the panel of a prop cell.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (NNClassifierMLP_CrossValidationPP_FI_Measure) plots the panel for a CELL prop with a table and two sliders.
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
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (constructor):
	%  NNClassifierMLP_CrossValidationPP_FI_Measure - constructor
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods:
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
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (display):
	%  tostring - string with information about the cell prop panel
	%  disp - displays information about the cell prop panel
	%  tree - displays the tree of the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel as b2 file
	%  load - loads a BRAPH2 cell prop panel from a b2 file
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidationPP_FI_Measure
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
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidationPP_FI_Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidationPP_FI_Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidationPP_FI_Measure constants</a>.
	%
	%
	% See also uitable, uislider, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 2;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 3;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 4;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 5;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		SELECTED = PanelProp.getPropNumber() + 6;
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = Category.GUI;
		SELECTED_FORMAT = Format.CVECTOR;
		
		TABLE = PanelProp.getPropNumber() + 7;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 8;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		MAP_TO_CELL = PanelProp.getPropNumber() + 9;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pr = NNClassifierMLP_CrossValidationPP_FI_Measure(varargin)
			%NNClassifierMLP_CrossValidationPP_FI_Measure() creates a cell prop panel.
			%
			% NNClassifierMLP_CrossValidationPP_FI_Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidationPP_FI_Measure(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = NNClassifierMLP_CrossValidationPP_FI_Measure.GETCLASS() returns the class 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidationPP_FI_Measure') returns 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			
			pr_class = 'NNClassifierMLP_CrossValidationPP_FI_Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel.
			%
			% LIST = NNClassifierMLP_CrossValidationPP_FI_Measure.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPP_FI_Measure') returns all subclasses of 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_CrossValidationPP_FI_Measure', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel.
			%
			% PROPS = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPS() returns the property list of cell prop panel
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidationPP_FI_Measure'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL ...
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
						NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT ...
						NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel.
			%
			% N = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPNUMBER() returns the property number of cell prop panel.
			%
			% N = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPP_FI_Measure') returns the property number of 'NNClassifierMLP_CrossValidationPP_FI_Measure'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_CrossValidationPP_FI_Measure.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPP_FI_Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidationPP_FI_Measure.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_CrossValidationPP_FI_Measure.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidationPP_FI_Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPP_FI_Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidationPP_FI_Measure, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidationPP_FI_Measure, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidationPP_FI_Measure.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_crossvalidationpp_fi_measure_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPP_FI_Measure.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPP_FI_Measure.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_crossvalidationpp_fi_measure_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidationPP_FI_Measure.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  PROPERTY = PR.GETPROPPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_crossvalidationpp_fi_measure_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPP_FI_Measure.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPP_FI_Measure.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_crossvalidationpp_fi_measure_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  TAG = PR.GETPROPTAG(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
						tag = NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  CATEGORY = PR.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  FORMAT = PR.GETPROPFORMAT(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the  % % % .';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.NAME
					prop_description = 'NAME (constant, string) is the name of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ID
					prop_description = 'ID (data, string) is a few-letter code for the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.EL
					prop_description = 'EL (data, item) is the element.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  SETTINGS = PR.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
					prop_settings = {'on', 'off'};
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidationPP_FI_Measure';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE
					prop_default = 'on';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME
					prop_default = {'numbered'};
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME
					prop_default = {'numbered'};
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT
					prop_default = true;
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT
					prop_default = s(20);
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Measure';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.NAME
					prop_default = 'Cell Prop Panel';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.DESCRIPTION
					prop_default = 'A Cell Prop Panel (NNClassifierMLP_CrossValidationPP_FI_Measure) plots the panel for a CELL prop with a table and two sliders. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ID
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Measure ID';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.LABEL
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Measure label';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.NOTES
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Measure notes';
				case NNClassifierMLP_CrossValidationPP_FI_Measure.EL
					prop_default = NNClassifierMLP_CrossValidation();
				case NNClassifierMLP_CrossValidationPP_FI_Measure.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidationPP_FI_Measure.conditioning(prop, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED % __NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = conditioning@PanelProp(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%  CHECK = PR.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPP_FI_Measure.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Measure:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNClassifierMLP_CrossValidationPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE % __NNClassifierMLP_CrossValidationPP_FI_Measure.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME % __NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME % __NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT % __NNClassifierMLP_CrossValidationPP_FI_Measure.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT % __NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED % __NNClassifierMLP_CrossValidationPP_FI_Measure.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE % __NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU % __NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL % __NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TEMPLATE % __NNClassifierMLP_CrossValidationPP_FI_Measure.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPP_FI_Measure.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidationPP_FI_Measure.getPropTag(prop) ' (' NNClassifierMLP_CrossValidationPP_FI_Measure.getFormatTag(NNClassifierMLP_CrossValidationPP_FI_Measure.getPropFormat(prop)) ').'] ...
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
				case NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME % __NNClassifierMLP_CrossValidationPP_FI_Measure.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME % __NNClassifierMLP_CrossValidationPP_FI_Measure.COLUMNNAME__
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
				case NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE % __NNClassifierMLP_CrossValidationPP_FI_Measure.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU % __NNClassifierMLP_CrossValidationPP_FI_Measure.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Plot Selected Measures on Brain ...', ...
					    'MenuSelectedFcn', {@cb_open_mbrain} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Brain-Plots', ...
						'MenuSelectedFcn', {@cb_hide_mbrain} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL % __NNClassifierMLP_CrossValidationPP_FI_Measure.MAP_TO_CELL__
					if isempty(varargin)
					    value = {};
					    return
					end
					vector = varargin{1};
					cell_template = varargin{2};
					mappedCellArray = cell_template;
					index = 1;
					for i = 1:numel(cell_template)
					    cellData = cell_template{i};
					    if iscell(cellData)
					        % Map the vector to nested cell arrays recursively
					        nestedVector = pr.get('MAP_TO_CELL', vector(index:end), cellData);
					        mappedCellArray{i} = nestedVector;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index+numElements-1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.X_DRAW % __NNClassifierMLP_CrossValidationPP_FI_Measure.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.UPDATE % __NNClassifierMLP_CrossValidationPP_FI_Measure.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if isa(el.getr(prop), 'NoValue')
					        % don't plot anything for a result not yet calculated
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'off')
					    else
					        set_table()
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'on')
					    end
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.REDRAW % __NNClassifierMLP_CrossValidationPP_FI_Measure.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Measure.DELETE % __NNClassifierMLP_CrossValidationPP_FI_Measure.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			    
			    i = event.Indices(1);
			    
			    selected = pr.get('SELECTED');
			    if event.NewData == 1
			        pr.set('SELECTED', sort(unique([selected; i])));
			    else
			        pr.set('SELECTED', selected(selected ~= i));
			    end
			    
			    pr.get('UPDATE')
			end
			function cb_select_all(~, ~) 
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP'));
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_open_mbrain(~, ~)
			end
			function cb_hide_mbrain(~, ~)
			end
			function set_table()
			    nncv = pr.get('EL');
			
			    input_datasets = nncv.get('D');
			    input_dataset = input_datasets{1}; % TODO: create a query to get an item from this dataset list
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			
			        if any(pr.get('SELECTED') == mi)
			            data{mi, 1} = true;
			        else
			            data{mi, 1} = false;
			        end
			
			        data{mi, 2} = eval([m_list{mi} '.getPropDefault(''NAME'')']);
			
			        if Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.NODAL
			            data{mi, 3} = 'NODAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.GLOBAL
			            data{mi, 3} = 'GLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.BINODAL
			            data{mi, 3} = 'BINODAL';
			        end
			
			        if Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.SUPERGLOBAL
			            data{mi, 4} = 'SUPERGLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.UNILAYER
			            data{mi, 4} = 'UNILAYER';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.BILAYER
			            data{mi, 4} = 'BILAYER';
			        end
			        
			        data{mi, 5} = eval([m_list{mi} '.getPropDefault(''DESCRIPTION'')']);
			    
			        set(pr.get('TABLE'), ...
			            'RowName', rowname, ...
			            'Data', data ...
			            )
			    
			        % style SELECTED
			        styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			        if ~isempty(styles_row)
			            removeStyle(pr.get('TABLE'), styles_row)
			        end
			        if ~isempty(pr.get('SELECTED'))
			            addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			        end
			    end
			end
		end
	end
end
