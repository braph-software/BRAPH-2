classdef NNClassifierMLP_CrossValidationPP_FI_Data < PanelProp
	%NNClassifierMLP_CrossValidationPP_FI_Data plots the panel of a prop cell.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (NNClassifierMLP_CrossValidationPP_FI_Data) plots the panel for a CELL prop with a table and two sliders.
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
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (constructor):
	%  NNClassifierMLP_CrossValidationPP_FI_Data - constructor
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods:
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
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (display):
	%  tostring - string with information about the cell prop panel
	%  disp - displays information about the cell prop panel
	%  tree - displays the tree of the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel as b2 file
	%  load - loads a BRAPH2 cell prop panel from a b2 file
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidationPP_FI_Data
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
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidationPP_FI_Data methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidationPP_FI_Data; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidationPP_FI_Data constants</a>.
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
		
		MAP_TO_CELL = PanelProp.getPropNumber() + 17;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pr = NNClassifierMLP_CrossValidationPP_FI_Data(varargin)
			%NNClassifierMLP_CrossValidationPP_FI_Data() creates a cell prop panel.
			%
			% NNClassifierMLP_CrossValidationPP_FI_Data(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidationPP_FI_Data(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = NNClassifierMLP_CrossValidationPP_FI_Data.GETCLASS() returns the class 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidationPP_FI_Data') returns 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			
			pr_class = 'NNClassifierMLP_CrossValidationPP_FI_Data';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel.
			%
			% LIST = NNClassifierMLP_CrossValidationPP_FI_Data.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPP_FI_Data') returns all subclasses of 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_CrossValidationPP_FI_Data', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel.
			%
			% PROPS = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPS() returns the property list of cell prop panel
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidationPP_FI_Data'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK ...
						NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT ...
						NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT ...
						NNClassifierMLP_CrossValidationPP_FI_Data.TABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU ...
						NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL ...
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
						NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER ...
						NNClassifierMLP_CrossValidationPP_FI_Data.TABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS ...
						NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH ...
						NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK ...
						NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE ...
						NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME ...
						NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT ...
						NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel.
			%
			% N = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPNUMBER() returns the property number of cell prop panel.
			%
			% N = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPP_FI_Data') returns the property number of 'NNClassifierMLP_CrossValidationPP_FI_Data'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_CrossValidationPP_FI_Data.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPP_FI_Data.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidationPP_FI_Data.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_CrossValidationPP_FI_Data.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidationPP_FI_Data.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel/error.
			%
			% CHECK = NNClassifierMLP_CrossValidationPP_FI_Data.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidationPP_FI_Data, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidationPP_FI_Data, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidationPP_FI_Data.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidationPP_FI_Data:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_crossvalidationpp_fi_data_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPP_FI_Data.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPP_FI_Data.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_crossvalidationpp_fi_data_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidationPP_FI_Data.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  PROPERTY = PR.GETPROPPROP(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_crossvalidationpp_fi_data_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidationPP_FI_Data.getPropTag(x), num2cell(NNClassifierMLP_CrossValidationPP_FI_Data.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_crossvalidationpp_fi_data_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  TAG = PR.GETPROPTAG(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU_TAG;
					case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
						tag = NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  CATEGORY = PR.GETPROPCATEGORY(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU_CATEGORY;
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
					prop_category = NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  FORMAT = PR.GETPROPFORMAT(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU_FORMAT;
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
					prop_format = NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
					prop_description = 'XSLIDERSHOW (gui, logical) determines whether to show the xslider.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
					prop_description = 'XSLIDERLABELS (gui, stringlist) determines the xslider labels.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
					prop_description = 'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
					prop_description = 'XSLIDER (evanescent, handle) is the x-slider.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
					prop_description = 'YSLIDERSHOW (gui, logical) determines whether to show the yslider.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
					prop_description = 'YSLIDERLABELS (gui, stringlist) determines the yslider labels.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
					prop_description = 'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
					prop_description = 'YSLIDER (evanescent, handle) is the y-slider.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
					prop_description = 'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
					prop_description = 'TABLE (evanescent, handle) is the alpha value edit field.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the % % % .';
				case NNClassifierMLP_CrossValidationPP_FI_Data.NAME
					prop_description = 'NAME (constant, string) is the name of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.ID
					prop_description = 'ID (data, string) is a few-letter code for the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cell prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.EL
					prop_description = 'EL (data, item) is the element.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  SETTINGS = PR.GETPROPSETTINGS(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
					prop_settings = {'on', 'off'};
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNClassifierMLP_CrossValidationPP_FI_Data.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidationPP_FI_Data';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  DEFAULT = PR.GETPROPDEFAULT(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW
					prop_default = true;
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT
					prop_default = s(3);
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW
					prop_default = true;
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH
					prop_default = s(3);
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK
					prop_default = false;
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE
					prop_default = 'on';
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME
					prop_default = {'numbered'};
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME
					prop_default = {'numbered'};
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT
					prop_default = true;
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT
					prop_default = s(20);
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Data';
				case NNClassifierMLP_CrossValidationPP_FI_Data.NAME
					prop_default = 'Cell Prop Panel';
				case NNClassifierMLP_CrossValidationPP_FI_Data.DESCRIPTION
					prop_default = 'A Cell Prop Panel (NNClassifierMLP_CrossValidationPP_FI_Data) plots the panel for a CELL prop with a table and two sliders. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case NNClassifierMLP_CrossValidationPP_FI_Data.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.ID
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Data ID';
				case NNClassifierMLP_CrossValidationPP_FI_Data.LABEL
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Data label';
				case NNClassifierMLP_CrossValidationPP_FI_Data.NOTES
					prop_default = 'NNClassifierMLP_CrossValidationPP_FI_Data notes';
				case NNClassifierMLP_CrossValidationPP_FI_Data.EL
					prop_default = NNClassifierMLP_CrossValidation();
				case NNClassifierMLP_CrossValidationPP_FI_Data.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidationPP_FI_Data.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidationPP_FI_Data, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidationPP_FI_Data.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidationPP_FI_Data.conditioning(prop, NNClassifierMLP_CrossValidationPP_FI_Data.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPP_FI_Data.
			%  CHECK = PR.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidationPP_FI_Data.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Data:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Data:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPP_FI_Data.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Data:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNClassifierMLP_CrossValidationPP_FI_Data, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidationPP_FI_Data.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidationPP_FI_Data:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNClassifierMLP_CrossValidationPP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidationPP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW % __NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS % __NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT % __NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDERHEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER % __NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW % __NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS % __NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH % __NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDERWIDTH__
					check = Format.checkFormat(Format.SIZE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER % __NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK % __NNClassifierMLP_CrossValidationPP_FI_Data.XYSLIDERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE % __NNClassifierMLP_CrossValidationPP_FI_Data.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME % __NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME % __NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT % __NNClassifierMLP_CrossValidationPP_FI_Data.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT % __NNClassifierMLP_CrossValidationPP_FI_Data.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE % __NNClassifierMLP_CrossValidationPP_FI_Data.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU % __NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL % __NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				case NNClassifierMLP_CrossValidationPP_FI_Data.TEMPLATE % __NNClassifierMLP_CrossValidationPP_FI_Data.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidationPP_FI_Data.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidationPP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidationPP_FI_Data.getPropTag(prop) ' (' NNClassifierMLP_CrossValidationPP_FI_Data.getFormatTag(NNClassifierMLP_CrossValidationPP_FI_Data.getPropFormat(prop)) ').'] ...
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
				case NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME % __NNClassifierMLP_CrossValidationPP_FI_Data.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME % __NNClassifierMLP_CrossValidationPP_FI_Data.COLUMNNAME__
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
				case NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER % __NNClassifierMLP_CrossValidationPP_FI_Data.XSLIDER__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER % __NNClassifierMLP_CrossValidationPP_FI_Data.YSLIDER__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.TABLE % __NNClassifierMLP_CrossValidationPP_FI_Data.TABLE__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU % __NNClassifierMLP_CrossValidationPP_FI_Data.CONTEXTMENU__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL % __NNClassifierMLP_CrossValidationPP_FI_Data.MAP_TO_CELL__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.X_DRAW % __NNClassifierMLP_CrossValidationPP_FI_Data.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.UPDATE % __NNClassifierMLP_CrossValidationPP_FI_Data.UPDATE__
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
					    
					    input_datasets = el.get('D');
					    input_dataset = input_datasets{1}; % TODO: create a query to get an item from this dataset list 
					    
					    sub = input_dataset.get('DP_DICT').get('IT', 1).get('SUB');
					    pr.set('TABLE_HEIGHT', s(40), ...
					        'XSLIDERSHOW', true, ...
					        'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
					        'YSLIDERSHOW', false, ...
					        'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					        'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					        varargin{:});
					
					    rowname = pr.get('ROWNAME');
					    if isempty(rowname)
					        rowname = 'numbered';
					    end
					    columnname = pr.get('COLUMNNAME');
					    if isempty(rowname)
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.REDRAW % __NNClassifierMLP_CrossValidationPP_FI_Data.REDRAW__
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
					
				case NNClassifierMLP_CrossValidationPP_FI_Data.DELETE % __NNClassifierMLP_CrossValidationPP_FI_Data.DELETE__
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
			        value_vectored = el.get(prop);
			
			        cell_template = el.get('D_LIST_IT', 1).get('DP_DICT').get('IT', 1).get('INPUT');
			        value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
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
			    
			    t = array2table(data, ...
			        'VariableNames', columns, ...
			        'RowNames', rows ...
			        );
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function value = set_sliders_and_get_value()
			    value_vectored = el.get(prop);
			    
			    cell_template = el.get('D_LIST_IT', 1).get('DP_DICT').get('IT', 1).get('INPUT');
			    value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
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
