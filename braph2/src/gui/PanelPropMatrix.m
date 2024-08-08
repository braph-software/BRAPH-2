classdef PanelPropMatrix < PanelProp
	%PanelPropMatrix plots the panel of a property matrix-like.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Matrix Prop Panel (PanelPropMatrix) plots the panel for a RVECTOR, CVECTOR, MATRIX or SMATRIX property with a table.
	% It works for all categories.
	% 
	% It can be personalized with the following props:
	%  TABLE_HEIGHT - Panel height in pixels when the table is shown.
	%  ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  MENU_EXPORT - Whether to show the export menu. To be defined before drawing.
	%
	% PanelPropMatrix methods (constructor):
	%  PanelPropMatrix - constructor
	%
	% PanelPropMatrix methods:
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
	% PanelPropMatrix methods (display):
	%  tostring - string with information about the matrix-like prop panel
	%  disp - displays information about the matrix-like prop panel
	%  tree - displays the tree of the matrix-like prop panel
	%
	% PanelPropMatrix methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two matrix-like prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the matrix-like prop panel
	%
	% PanelPropMatrix methods (save/load, Static):
	%  save - saves BRAPH2 matrix-like prop panel as b2 file
	%  load - loads a BRAPH2 matrix-like prop panel from a b2 file
	%
	% PanelPropMatrix method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the matrix-like prop panel
	%
	% PanelPropMatrix method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the matrix-like prop panel
	%
	% PanelPropMatrix methods (inspection, Static):
	%  getClass - returns the class of the matrix-like prop panel
	%  getSubclasses - returns all subclasses of PanelPropMatrix
	%  getProps - returns the property list of the matrix-like prop panel
	%  getPropNumber - returns the property number of the matrix-like prop panel
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
	% PanelPropMatrix methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropMatrix methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropMatrix methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropMatrix methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropMatrix; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropMatrix constants</a>.
	%
	%
	% See also uitable, GUI, PanelElement.
	
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
		
		TABLE = PanelProp.getPropNumber() + 6;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 7;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropMatrix(varargin)
			%PanelPropMatrix() creates a matrix-like prop panel.
			%
			% PanelPropMatrix(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropMatrix(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the matrix-like prop panel.
			%
			% CLASS = PanelPropMatrix.GETCLASS() returns the class 'PanelPropMatrix'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the matrix-like prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropMatrix') returns 'PanelPropMatrix'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropMatrix')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropMatrix';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the matrix-like prop panel.
			%
			% LIST = PanelPropMatrix.GETSUBCLASSES() returns all subclasses of 'PanelPropMatrix'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the matrix-like prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropMatrix') returns all subclasses of 'PanelPropMatrix'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropMatrix', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of matrix-like prop panel.
			%
			% PROPS = PanelPropMatrix.GETPROPS() returns the property list of matrix-like prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropMatrix.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the matrix-like prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropMatrix'[, CATEGORY]) returns the property list of 'PanelPropMatrix'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropMatrix.ENABLE ...
						PanelPropMatrix.ROWNAME ...
						PanelPropMatrix.COLUMNNAME ...
						PanelPropMatrix.MENU_EXPORT ...
						PanelPropMatrix.TABLE_HEIGHT ...
						PanelPropMatrix.TABLE ...
						PanelPropMatrix.CONTEXTMENU ...
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
						PanelPropMatrix.TABLE ...
						PanelPropMatrix.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropMatrix.ENABLE ...
						PanelPropMatrix.ROWNAME ...
						PanelPropMatrix.COLUMNNAME ...
						PanelPropMatrix.MENU_EXPORT ...
						PanelPropMatrix.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of matrix-like prop panel.
			%
			% N = PanelPropMatrix.GETPROPNUMBER() returns the property number of matrix-like prop panel.
			%
			% N = PanelPropMatrix.GETPROPNUMBER(CATEGORY) returns the property number of matrix-like prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the matrix-like prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropMatrix') returns the property number of 'PanelPropMatrix'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropMatrix.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in matrix-like prop panel/error.
			%
			% CHECK = PanelPropMatrix.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropMatrix, PROP) checks whether PROP exists for PanelPropMatrix.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%  Element.EXISTSPROP(PanelPropMatrix, PROP) throws error if PROP does NOT exist for PanelPropMatrix.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropMatrix.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropMatrix.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in matrix-like prop panel/error.
			%
			% CHECK = PanelPropMatrix.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropMatrix, TAG) checks whether TAG exists for PanelPropMatrix.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%  Element.EXISTSTAG(PanelPropMatrix, TAG) throws error if TAG does NOT exist for PanelPropMatrix.
			%   Error id: [BRAPH2:PanelPropMatrix:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropmatrix_tag_list = cellfun(@(x) PanelPropMatrix.getPropTag(x), num2cell(PanelPropMatrix.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropmatrix_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropMatrix.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropMatrix, POINTER) returns property number of POINTER of PanelPropMatrix.
			%  PROPERTY = PR.GETPROPPROP(PanelPropMatrix, POINTER) returns property number of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropmatrix_tag_list = cellfun(@(x) PanelPropMatrix.getPropTag(x), num2cell(PanelPropMatrix.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropmatrix_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropMatrix, POINTER) returns tag of POINTER of PanelPropMatrix.
			%  TAG = PR.GETPROPTAG(PanelPropMatrix, POINTER) returns tag of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropMatrix.ENABLE
						tag = PanelPropMatrix.ENABLE_TAG;
					case PanelPropMatrix.ROWNAME
						tag = PanelPropMatrix.ROWNAME_TAG;
					case PanelPropMatrix.COLUMNNAME
						tag = PanelPropMatrix.COLUMNNAME_TAG;
					case PanelPropMatrix.MENU_EXPORT
						tag = PanelPropMatrix.MENU_EXPORT_TAG;
					case PanelPropMatrix.TABLE_HEIGHT
						tag = PanelPropMatrix.TABLE_HEIGHT_TAG;
					case PanelPropMatrix.TABLE
						tag = PanelPropMatrix.TABLE_TAG;
					case PanelPropMatrix.CONTEXTMENU
						tag = PanelPropMatrix.CONTEXTMENU_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropMatrix, POINTER) returns category of POINTER of PanelPropMatrix.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropMatrix, POINTER) returns category of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE
					prop_category = PanelPropMatrix.ENABLE_CATEGORY;
				case PanelPropMatrix.ROWNAME
					prop_category = PanelPropMatrix.ROWNAME_CATEGORY;
				case PanelPropMatrix.COLUMNNAME
					prop_category = PanelPropMatrix.COLUMNNAME_CATEGORY;
				case PanelPropMatrix.MENU_EXPORT
					prop_category = PanelPropMatrix.MENU_EXPORT_CATEGORY;
				case PanelPropMatrix.TABLE_HEIGHT
					prop_category = PanelPropMatrix.TABLE_HEIGHT_CATEGORY;
				case PanelPropMatrix.TABLE
					prop_category = PanelPropMatrix.TABLE_CATEGORY;
				case PanelPropMatrix.CONTEXTMENU
					prop_category = PanelPropMatrix.CONTEXTMENU_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropMatrix, POINTER) returns format of POINTER of PanelPropMatrix.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropMatrix, POINTER) returns format of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE
					prop_format = PanelPropMatrix.ENABLE_FORMAT;
				case PanelPropMatrix.ROWNAME
					prop_format = PanelPropMatrix.ROWNAME_FORMAT;
				case PanelPropMatrix.COLUMNNAME
					prop_format = PanelPropMatrix.COLUMNNAME_FORMAT;
				case PanelPropMatrix.MENU_EXPORT
					prop_format = PanelPropMatrix.MENU_EXPORT_FORMAT;
				case PanelPropMatrix.TABLE_HEIGHT
					prop_format = PanelPropMatrix.TABLE_HEIGHT_FORMAT;
				case PanelPropMatrix.TABLE
					prop_format = PanelPropMatrix.TABLE_FORMAT;
				case PanelPropMatrix.CONTEXTMENU
					prop_format = PanelPropMatrix.CONTEXTMENU_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropMatrix, POINTER) returns description of POINTER of PanelPropMatrix.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropMatrix, POINTER) returns description of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case PanelPropMatrix.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case PanelPropMatrix.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case PanelPropMatrix.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case PanelPropMatrix.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case PanelPropMatrix.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case PanelPropMatrix.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case PanelPropMatrix.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the matrix-like property panel.';
				case PanelPropMatrix.NAME
					prop_description = 'NAME (constant, string) is the name of the matrix-like property panel.';
				case PanelPropMatrix.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the matrix-like property panel.';
				case PanelPropMatrix.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the matrix-like property panel.';
				case PanelPropMatrix.ID
					prop_description = 'ID (data, string) is a few-letter code for the matrix-like property panel.';
				case PanelPropMatrix.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the matrix-like property panel.';
				case PanelPropMatrix.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the matrix-like property panel.';
				case PanelPropMatrix.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropMatrix.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropMatrix.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropMatrix.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case PanelPropMatrix.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropMatrix.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropMatrix, POINTER) returns settings of POINTER of PanelPropMatrix.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropMatrix, POINTER) returns settings of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE
					prop_settings = {'on', 'off'};
				case PanelPropMatrix.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropMatrix.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropMatrix.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropMatrix.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropMatrix.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropMatrix.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropMatrix.TEMPLATE
					prop_settings = 'PanelPropMatrix';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropMatrix.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropMatrix.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropMatrix, POINTER) returns the default value of POINTER of PanelPropMatrix.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropMatrix, POINTER) returns the default value of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE
					prop_default = 'on';
				case PanelPropMatrix.ROWNAME
					prop_default = {'numbered'};
				case PanelPropMatrix.COLUMNNAME
					prop_default = {'numbered'};
				case PanelPropMatrix.MENU_EXPORT
					prop_default = true;
				case PanelPropMatrix.TABLE_HEIGHT
					prop_default = s(20);
				case PanelPropMatrix.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.ELCLASS
					prop_default = 'PanelPropMatrix';
				case PanelPropMatrix.NAME
					prop_default = 'Matrix Prop Panel';
				case PanelPropMatrix.DESCRIPTION
					prop_default = 'A Matrix Prop Panel (PanelPropMatrix) plots the panel for a RVECTOR, CVECTOR, MATRIX or SMATRIX property with a table. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case PanelPropMatrix.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.ID
					prop_default = 'PanelPropMatrix ID';
				case PanelPropMatrix.LABEL
					prop_default = 'PanelPropMatrix label';
				case PanelPropMatrix.NOTES
					prop_default = 'PanelPropMatrix notes';
				case PanelPropMatrix.EL
					prop_default = IndexedDictionary();
				case PanelPropMatrix.PROP
					prop_default = IndexedDictionary.REMOVE_ALL;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropMatrix.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropMatrix.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropMatrix, POINTER) returns the conditioned default value of POINTER of PanelPropMatrix.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropMatrix, POINTER) returns the conditioned default value of POINTER of PanelPropMatrix.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			prop_default = PanelPropMatrix.conditioning(prop, PanelPropMatrix.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropMatrix, PROP, VALUE) checks VALUE format for PROP of PanelPropMatrix.
			%  CHECK = PR.CHECKPROP(PanelPropMatrix, PROP, VALUE) checks VALUE format for PROP of PanelPropMatrix.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropMatrix:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropMatrix:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropMatrix, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropMatrix.
			%   Error id: €BRAPH2.STR€:PanelPropMatrix:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropMatrix, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropMatrix.
			%   Error id: €BRAPH2.STR€:PanelPropMatrix:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropMatrix')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropMatrix.getPropProp(pointer);
			
			switch prop
				case PanelPropMatrix.ENABLE % __PanelPropMatrix.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.ROWNAME % __PanelPropMatrix.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.COLUMNNAME % __PanelPropMatrix.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.MENU_EXPORT % __PanelPropMatrix.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.TABLE_HEIGHT % __PanelPropMatrix.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.TABLE % __PanelPropMatrix.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.CONTEXTMENU % __PanelPropMatrix.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropMatrix.getPropSettings(prop));
				case PanelPropMatrix.TEMPLATE % __PanelPropMatrix.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropMatrix.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropMatrix:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropMatrix.getPropTag(prop) ' (' PanelPropMatrix.getFormatTag(PanelPropMatrix.getPropFormat(prop)) ').'] ...
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
				case PanelPropMatrix.ROWNAME % __PanelPropMatrix.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case PanelPropMatrix.COLUMNNAME % __PanelPropMatrix.COLUMNNAME__
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
				case PanelPropMatrix.TABLE % __PanelPropMatrix.TABLE__
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
					
				case PanelPropMatrix.CONTEXTMENU % __PanelPropMatrix.CONTEXTMENU__
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
					
				case PanelPropMatrix.X_DRAW % __PanelPropMatrix.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case PanelPropMatrix.UPDATE % __PanelPropMatrix.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        if ispc()
					            pr.set('HEIGHT', min(s(6.5) + s(2) * size(el.get(prop), 1), pr.get('TABLE_HEIGHT')))
					        else
					            pr.set('HEIGHT', min(s(4.5) + s(2) * size(el.get(prop), 1), pr.get('TABLE_HEIGHT')))
					        end
					    end
					
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
					                'Data', el.get(prop), ...
					                'ColumnEditable', false ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('TABLE'), ...
					                'Data', el.get(prop), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('TABLE'), ...
					                'Data', el.get(prop), ...
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
					            else
					                set(pr.get('TABLE'), ...
					                    'Data', el.get(prop), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false, ...
					                    'Visible', 'on' ...
					                    )
					            end
					    end
					end
					
				case PanelPropMatrix.REDRAW % __PanelPropMatrix.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case PanelPropMatrix.DELETE % __PanelPropMatrix.DELETE__
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
			
			function cb_table(~, event)
			    i = event.Indices(1);
			    j = event.Indices(2); 
			    newdata = event.NewData;
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    value = el.get(prop);
			    value(i, j) = newdata;
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
			        rows = cellfun(@(x) ['Row ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
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
		end
	end
end
