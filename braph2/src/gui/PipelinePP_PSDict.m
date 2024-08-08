classdef PipelinePP_PSDict < PanelProp
	%PipelinePP_PSDict manages the dictionary of pipeline panel plots.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order.
	% It opens PanelFig elements using GUIFig, and all other elements using GUIElement.
	% It should be used only with the prop PS_DICT of the element Pipeline.
	%
	% PipelinePP_PSDict methods (constructor):
	%  PipelinePP_PSDict - constructor
	%
	% PipelinePP_PSDict methods:
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
	% PipelinePP_PSDict methods (display):
	%  tostring - string with information about the pipeline plot
	%  disp - displays information about the pipeline plot
	%  tree - displays the tree of the pipeline plot
	%
	% PipelinePP_PSDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline plot
	%
	% PipelinePP_PSDict methods (save/load, Static):
	%  save - saves BRAPH2 pipeline plot as b2 file
	%  load - loads a BRAPH2 pipeline plot from a b2 file
	%
	% PipelinePP_PSDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline plot
	%
	% PipelinePP_PSDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline plot
	%
	% PipelinePP_PSDict methods (inspection, Static):
	%  getClass - returns the class of the pipeline plot
	%  getSubclasses - returns all subclasses of PipelinePP_PSDict
	%  getProps - returns the property list of the pipeline plot
	%  getPropNumber - returns the property number of the pipeline plot
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
	% PipelinePP_PSDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelinePP_PSDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelinePP_PSDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelinePP_PSDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelinePP_PSDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelinePP_PSDict constants</a>.
	%
	%
	% See also Pipeline.
	
	properties (Constant) % properties
		HEIGHT_MIN = PanelProp.getPropNumber() + 1;
		HEIGHT_MIN_TAG = 'HEIGHT_MIN';
		HEIGHT_MIN_CATEGORY = Category.GUI;
		HEIGHT_MIN_FORMAT = Format.SCALAR;
		
		HEIGHT_PS_HEADER = PanelProp.getPropNumber() + 2;
		HEIGHT_PS_HEADER_TAG = 'HEIGHT_PS_HEADER';
		HEIGHT_PS_HEADER_CATEGORY = Category.GUI;
		HEIGHT_PS_HEADER_FORMAT = Format.SCALAR;
		
		HEIGHT_PC = PanelProp.getPropNumber() + 3;
		HEIGHT_PC_TAG = 'HEIGHT_PC';
		HEIGHT_PC_CATEGORY = Category.GUI;
		HEIGHT_PC_FORMAT = Format.SCALAR;
		
		HEIGHT_PS_FOOTER = PanelProp.getPropNumber() + 4;
		HEIGHT_PS_FOOTER_TAG = 'HEIGHT_PS_FOOTER';
		HEIGHT_PS_FOOTER_CATEGORY = Category.GUI;
		HEIGHT_PS_FOOTER_FORMAT = Format.SCALAR;
		
		HEIGHT_PS_MARGIN = PanelProp.getPropNumber() + 5;
		HEIGHT_PS_MARGIN_TAG = 'HEIGHT_PS_MARGIN';
		HEIGHT_PS_MARGIN_CATEGORY = Category.GUI;
		HEIGHT_PS_MARGIN_FORMAT = Format.SCALAR;
		
		HANDLES = PanelProp.getPropNumber() + 6;
		HANDLES_TAG = 'HANDLES';
		HANDLES_CATEGORY = Category.EVANESCENT;
		HANDLES_FORMAT = Format.HANDLELIST;
		
		PS_PANEL = PanelProp.getPropNumber() + 7;
		PS_PANEL_TAG = 'PS_PANEL';
		PS_PANEL_CATEGORY = Category.QUERY;
		PS_PANEL_FORMAT = Format.HANDLE;
		
		PC_BTN = PanelProp.getPropNumber() + 8;
		PC_BTN_TAG = 'PC_BTN';
		PC_BTN_CATEGORY = Category.QUERY;
		PC_BTN_FORMAT = Format.HANDLE;
		
		PC_CLEAR_BTN = PanelProp.getPropNumber() + 9;
		PC_CLEAR_BTN_TAG = 'PC_CLEAR_BTN';
		PC_CLEAR_BTN_CATEGORY = Category.QUERY;
		PC_CLEAR_BTN_FORMAT = Format.HANDLE;
		
		GUI_PC_DICT = PanelProp.getPropNumber() + 10;
		GUI_PC_DICT_TAG = 'GUI_PC_DICT';
		GUI_PC_DICT_CATEGORY = Category.GUI;
		GUI_PC_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = PipelinePP_PSDict(varargin)
			%PipelinePP_PSDict() creates a pipeline plot.
			%
			% PipelinePP_PSDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelinePP_PSDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the pipeline plot.
			%
			% CLASS = PipelinePP_PSDict.GETCLASS() returns the class 'PipelinePP_PSDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the pipeline plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PipelinePP_PSDict') returns 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PipelinePP_PSDict')
			%  are less computationally efficient.
			
			pr_class = 'PipelinePP_PSDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline plot.
			%
			% LIST = PipelinePP_PSDict.GETSUBCLASSES() returns all subclasses of 'PipelinePP_PSDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the pipeline plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PipelinePP_PSDict') returns all subclasses of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PipelinePP_PSDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline plot.
			%
			% PROPS = PipelinePP_PSDict.GETPROPS() returns the property list of pipeline plot
			%  as a row vector.
			%
			% PROPS = PipelinePP_PSDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the pipeline plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PipelinePP_PSDict'[, CATEGORY]) returns the property list of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PipelinePP_PSDict.HEIGHT_MIN ...
						PipelinePP_PSDict.HEIGHT_PS_HEADER ...
						PipelinePP_PSDict.HEIGHT_PC ...
						PipelinePP_PSDict.HEIGHT_PS_FOOTER ...
						PipelinePP_PSDict.HEIGHT_PS_MARGIN ...
						PipelinePP_PSDict.HANDLES ...
						PipelinePP_PSDict.PS_PANEL ...
						PipelinePP_PSDict.PC_BTN ...
						PipelinePP_PSDict.PC_CLEAR_BTN ...
						PipelinePP_PSDict.GUI_PC_DICT ...
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
						PipelinePP_PSDict.PS_PANEL ...
						PipelinePP_PSDict.PC_BTN ...
						PipelinePP_PSDict.PC_CLEAR_BTN ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						PipelinePP_PSDict.HANDLES ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PipelinePP_PSDict.HEIGHT_MIN ...
						PipelinePP_PSDict.HEIGHT_PS_HEADER ...
						PipelinePP_PSDict.HEIGHT_PC ...
						PipelinePP_PSDict.HEIGHT_PS_FOOTER ...
						PipelinePP_PSDict.HEIGHT_PS_MARGIN ...
						PipelinePP_PSDict.GUI_PC_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline plot.
			%
			% N = PipelinePP_PSDict.GETPROPNUMBER() returns the property number of pipeline plot.
			%
			% N = PipelinePP_PSDict.GETPROPNUMBER(CATEGORY) returns the property number of pipeline plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PipelinePP_PSDict') returns the property number of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PipelinePP_PSDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline plot/error.
			%
			% CHECK = PipelinePP_PSDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PipelinePP_PSDict, PROP) checks whether PROP exists for PipelinePP_PSDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSPROP(PipelinePP_PSDict, PROP) throws error if PROP does NOT exist for PipelinePP_PSDict.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PipelinePP_PSDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelinePP_PSDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline plot/error.
			%
			% CHECK = PipelinePP_PSDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PipelinePP_PSDict, TAG) checks whether TAG exists for PipelinePP_PSDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSTAG(PipelinePP_PSDict, TAG) throws error if TAG does NOT exist for PipelinePP_PSDict.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pipelinepp_psdict_tag_list = cellfun(@(x) PipelinePP_PSDict.getPropTag(x), num2cell(PipelinePP_PSDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pipelinepp_psdict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PipelinePP_PSDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PipelinePP_PSDict, POINTER) returns property number of POINTER of PipelinePP_PSDict.
			%  PROPERTY = PR.GETPROPPROP(PipelinePP_PSDict, POINTER) returns property number of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pipelinepp_psdict_tag_list = cellfun(@(x) PipelinePP_PSDict.getPropTag(x), num2cell(PipelinePP_PSDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pipelinepp_psdict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PipelinePP_PSDict, POINTER) returns tag of POINTER of PipelinePP_PSDict.
			%  TAG = PR.GETPROPTAG(PipelinePP_PSDict, POINTER) returns tag of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PipelinePP_PSDict.HEIGHT_MIN
						tag = PipelinePP_PSDict.HEIGHT_MIN_TAG;
					case PipelinePP_PSDict.HEIGHT_PS_HEADER
						tag = PipelinePP_PSDict.HEIGHT_PS_HEADER_TAG;
					case PipelinePP_PSDict.HEIGHT_PC
						tag = PipelinePP_PSDict.HEIGHT_PC_TAG;
					case PipelinePP_PSDict.HEIGHT_PS_FOOTER
						tag = PipelinePP_PSDict.HEIGHT_PS_FOOTER_TAG;
					case PipelinePP_PSDict.HEIGHT_PS_MARGIN
						tag = PipelinePP_PSDict.HEIGHT_PS_MARGIN_TAG;
					case PipelinePP_PSDict.HANDLES
						tag = PipelinePP_PSDict.HANDLES_TAG;
					case PipelinePP_PSDict.PS_PANEL
						tag = PipelinePP_PSDict.PS_PANEL_TAG;
					case PipelinePP_PSDict.PC_BTN
						tag = PipelinePP_PSDict.PC_BTN_TAG;
					case PipelinePP_PSDict.PC_CLEAR_BTN
						tag = PipelinePP_PSDict.PC_CLEAR_BTN_TAG;
					case PipelinePP_PSDict.GUI_PC_DICT
						tag = PipelinePP_PSDict.GUI_PC_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PipelinePP_PSDict, POINTER) returns category of POINTER of PipelinePP_PSDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PipelinePP_PSDict, POINTER) returns category of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN
					prop_category = PipelinePP_PSDict.HEIGHT_MIN_CATEGORY;
				case PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_category = PipelinePP_PSDict.HEIGHT_PS_HEADER_CATEGORY;
				case PipelinePP_PSDict.HEIGHT_PC
					prop_category = PipelinePP_PSDict.HEIGHT_PC_CATEGORY;
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_category = PipelinePP_PSDict.HEIGHT_PS_FOOTER_CATEGORY;
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_category = PipelinePP_PSDict.HEIGHT_PS_MARGIN_CATEGORY;
				case PipelinePP_PSDict.HANDLES
					prop_category = PipelinePP_PSDict.HANDLES_CATEGORY;
				case PipelinePP_PSDict.PS_PANEL
					prop_category = PipelinePP_PSDict.PS_PANEL_CATEGORY;
				case PipelinePP_PSDict.PC_BTN
					prop_category = PipelinePP_PSDict.PC_BTN_CATEGORY;
				case PipelinePP_PSDict.PC_CLEAR_BTN
					prop_category = PipelinePP_PSDict.PC_CLEAR_BTN_CATEGORY;
				case PipelinePP_PSDict.GUI_PC_DICT
					prop_category = PipelinePP_PSDict.GUI_PC_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PipelinePP_PSDict, POINTER) returns format of POINTER of PipelinePP_PSDict.
			%  FORMAT = PR.GETPROPFORMAT(PipelinePP_PSDict, POINTER) returns format of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN
					prop_format = PipelinePP_PSDict.HEIGHT_MIN_FORMAT;
				case PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_format = PipelinePP_PSDict.HEIGHT_PS_HEADER_FORMAT;
				case PipelinePP_PSDict.HEIGHT_PC
					prop_format = PipelinePP_PSDict.HEIGHT_PC_FORMAT;
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_format = PipelinePP_PSDict.HEIGHT_PS_FOOTER_FORMAT;
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_format = PipelinePP_PSDict.HEIGHT_PS_MARGIN_FORMAT;
				case PipelinePP_PSDict.HANDLES
					prop_format = PipelinePP_PSDict.HANDLES_FORMAT;
				case PipelinePP_PSDict.PS_PANEL
					prop_format = PipelinePP_PSDict.PS_PANEL_FORMAT;
				case PipelinePP_PSDict.PC_BTN
					prop_format = PipelinePP_PSDict.PC_BTN_FORMAT;
				case PipelinePP_PSDict.PC_CLEAR_BTN
					prop_format = PipelinePP_PSDict.PC_CLEAR_BTN_FORMAT;
				case PipelinePP_PSDict.GUI_PC_DICT
					prop_format = PipelinePP_PSDict.GUI_PC_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelinePP_PSDict, POINTER) returns description of POINTER of PipelinePP_PSDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PipelinePP_PSDict, POINTER) returns description of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN
					prop_description = 'HEIGHT_MIN (gui, scalar) is the default (minumum) height.';
				case PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_description = 'HEIGHT_PS_HEADER (gui, scalar) is the height section header.';
				case PipelinePP_PSDict.HEIGHT_PC
					prop_description = 'HEIGHT_PC (gui, scalar) is the height code button.';
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_description = 'HEIGHT_PS_FOOTER (gui, scalar) is the height section footer.';
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_description = 'HEIGHT_PS_MARGIN (gui, scalar) is the height section margin.';
				case PipelinePP_PSDict.HANDLES
					prop_description = 'HANDLES (evanescent, handlelist) is the list of section panels and buttons.';
				case PipelinePP_PSDict.PS_PANEL
					prop_description = 'PS_PANEL (query, handle) returns graphics handle of a section panel.';
				case PipelinePP_PSDict.PC_BTN
					prop_description = 'PC_BTN (query, handle) returns graphics handle of a button.';
				case PipelinePP_PSDict.PC_CLEAR_BTN
					prop_description = 'PC_CLEAR_BTN (query, handle) returns graphics handle of a clear button.';
				case PipelinePP_PSDict.GUI_PC_DICT
					prop_description = 'GUI_PC_DICT (gui, idict) contains the GUIs for the element/buttons.';
				case PipelinePP_PSDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.NAME
					prop_description = 'NAME (constant, string) is the name of the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline panel plot dictionary.';
				case PipelinePP_PSDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline plot.';
				case PipelinePP_PSDict.EL
					prop_description = 'EL (data, item) is the element.';
				case PipelinePP_PSDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PipelinePP_PSDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PipelinePP_PSDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case PipelinePP_PSDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PipelinePP_PSDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figures of the elements/buttons.';
				case PipelinePP_PSDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figures of the elements/buttons.';
				case PipelinePP_PSDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case PipelinePP_PSDict.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PipelinePP_PSDict, POINTER) returns settings of POINTER of PipelinePP_PSDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PipelinePP_PSDict, POINTER) returns settings of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PipelinePP_PSDict.HEIGHT_PC
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PipelinePP_PSDict.HANDLES
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PipelinePP_PSDict.PS_PANEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PipelinePP_PSDict.PC_BTN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PipelinePP_PSDict.PC_CLEAR_BTN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PipelinePP_PSDict.GUI_PC_DICT
					prop_settings = 'GUI';
				case PipelinePP_PSDict.TEMPLATE
					prop_settings = 'PipelinePP_PSDict';
				case PipelinePP_PSDict.EL
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelinePP_PSDict, POINTER) returns the default value of POINTER of PipelinePP_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PipelinePP_PSDict, POINTER) returns the default value of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN
					prop_default = s(2);
				case PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_default = s(2);
				case PipelinePP_PSDict.HEIGHT_PC
					prop_default = s(2.5);
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_default = s(.5);
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_default = s(.5);
				case PipelinePP_PSDict.HANDLES
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PS_PANEL
					prop_default = Format.getFormatDefault(Format.HANDLE, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PC_BTN
					prop_default = Format.getFormatDefault(Format.HANDLE, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PC_CLEAR_BTN
					prop_default = Format.getFormatDefault(Format.HANDLE, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.GUI_PC_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.ELCLASS
					prop_default = 'PipelinePP_PSDict';
				case PipelinePP_PSDict.NAME
					prop_default = 'Pipeline Plot';
				case PipelinePP_PSDict.DESCRIPTION
					prop_default = 'A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order. It opens PanelFig elements using GUIFig, and all other elements using GUIElement. It should be used only with the prop PS_DICT of the element Pipeline.';
				case PipelinePP_PSDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.ID
					prop_default = 'PipelinePP_PSDict ID';
				case PipelinePP_PSDict.LABEL
					prop_default = 'PipelinePP_PSDict label';
				case PipelinePP_PSDict.NOTES
					prop_default = 'PipelinePP_PSDict notes';
				case PipelinePP_PSDict.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PROP
					prop_default = Pipeline.PS_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelinePP_PSDict, POINTER) returns the conditioned default value of POINTER of PipelinePP_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PipelinePP_PSDict, POINTER) returns the conditioned default value of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			prop_default = PipelinePP_PSDict.conditioning(prop, PipelinePP_PSDict.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) checks VALUE format for PROP of PipelinePP_PSDict.
			%  CHECK = PR.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) checks VALUE format for PROP of PipelinePP_PSDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PipelinePP_PSDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PipelinePP_PSDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_PSDict.
			%   Error id: €BRAPH2.STR€:PipelinePP_PSDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_PSDict.
			%   Error id: €BRAPH2.STR€:PipelinePP_PSDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case PipelinePP_PSDict.HEIGHT_MIN % __PipelinePP_PSDict.HEIGHT_MIN__
					check = Format.checkFormat(Format.SCALAR, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.HEIGHT_PS_HEADER % __PipelinePP_PSDict.HEIGHT_PS_HEADER__
					check = Format.checkFormat(Format.SCALAR, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.HEIGHT_PC % __PipelinePP_PSDict.HEIGHT_PC__
					check = Format.checkFormat(Format.SCALAR, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.HEIGHT_PS_FOOTER % __PipelinePP_PSDict.HEIGHT_PS_FOOTER__
					check = Format.checkFormat(Format.SCALAR, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.HEIGHT_PS_MARGIN % __PipelinePP_PSDict.HEIGHT_PS_MARGIN__
					check = Format.checkFormat(Format.SCALAR, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.HANDLES % __PipelinePP_PSDict.HANDLES__
					check = Format.checkFormat(Format.HANDLELIST, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PS_PANEL % __PipelinePP_PSDict.PS_PANEL__
					check = Format.checkFormat(Format.HANDLE, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PC_BTN % __PipelinePP_PSDict.PC_BTN__
					check = Format.checkFormat(Format.HANDLE, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.PC_CLEAR_BTN % __PipelinePP_PSDict.PC_CLEAR_BTN__
					check = Format.checkFormat(Format.HANDLE, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.GUI_PC_DICT % __PipelinePP_PSDict.GUI_PC_DICT__
					check = Format.checkFormat(Format.IDICT, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.TEMPLATE % __PipelinePP_PSDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PipelinePP_PSDict.getPropSettings(prop));
				case PipelinePP_PSDict.EL % __PipelinePP_PSDict.EL__
					check = Format.checkFormat(Format.ITEM, value, PipelinePP_PSDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_PSDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelinePP_PSDict.getPropTag(prop) ' (' PipelinePP_PSDict.getFormatTag(PipelinePP_PSDict.getPropFormat(prop)) ').'] ...
					)
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
				case PipelinePP_PSDict.HANDLES % __PipelinePP_PSDict.HANDLES__
					pip = pr.get('EL');
					
					ps_dict = pip.get('PS_DICT');
					ps_panels = cell(1, ps_dict.get('LENGTH'));
					pc_btns = cell(1, ps_dict.get('LENGTH'));
					for sec = 1:1:ps_dict.get('LENGTH')
					    ps = ps_dict.get('IT', sec);
					
					    ps_panels{sec} = uipanel( ...
					        'Parent', pr.get('H'), ...
					        'Tag', int2str(sec), ... % Tag used by PS_PANEL
					        'Title', [ps.get('ID') '. ' ps.get('LABEL')], ... 
					        'Tooltip', ps.get('DESCRIPTION'), ...
					        'FontSize', BRAPH2.FONTSIZE, ...
					        'BorderType', 'none' ...
					        );
					
					        pc_dict = ps.get('PC_DICT');
					        pc_btns{sec} = cell(1, pc_dict.get('LENGTH'));
					        for cl = 1:1:pc_dict.get('LENGTH')
					            pc = pc_dict.get('IT', cl);
					
					            pc_btns{sec}{cl} = uibutton( ...
					                'Parent', ps_panels{sec}, ... 
					                'Tag', [int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN 
					                'Tooltip', pc.get('DESCRIPTION'), ...
					                'Enable', 'off', ...
					                'Text', pc.get('TEXT_BEFORE_EXEC'), ...
					                'FontAngle', 'italic', ...
					                'FontSize', BRAPH2.FONTSIZE, ...
					                'UserData', [sec cl], ...
					                'ButtonPushedFcn', {@cb_pc_btn}, ...
					                'Interruptible', 'off', ...
					                'BusyAction', 'cancel' ...
					                );
					
					            pc_delete_btns{sec}{cl} = uibutton( ...
					                'Parent', ps_panels{sec}, ... 
					                'Tag', ['delete ' int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN
					                'Tooltip', ['Delete ' pc.get('MONIKER')], ...
					                'Enable', 'off', ...
					                'Text', 'D', ...
					                'FontSize', BRAPH2.FONTSIZE, ...
					                'FontWeight', 'bold', ...
					                'UserData', [sec cl], ...
					                'ButtonPushedFcn', {@cb_pc_clear_btn}, ...
					                'Interruptible', 'off', ...
					                'BusyAction', 'cancel' ...
					                );
					        end
					end
					
					% output value
					handles = {};
					for sec = 1:1:length(ps_panels)
					    handles = [handles ps_panels(sec) pc_btns{sec}(:)' pc_delete_btns{sec}(:)'];
					end
					value = handles;
					
				case PipelinePP_PSDict.PS_PANEL % __PipelinePP_PSDict.PS_PANEL__
					% H = pr.get('PS_PANEL', SEC) returns the hande H of the section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uipanel') && strcmpi(handles{i}.get('Tag'), int2str(sec)) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case PipelinePP_PSDict.PC_BTN % __PipelinePP_PSDict.PC_BTN__
					% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
					% line CL of section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					cl = varargin{2};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), [int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case PipelinePP_PSDict.PC_CLEAR_BTN % __PipelinePP_PSDict.PC_CLEAR_BTN__
					% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
					% line CL of section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					cl = varargin{2};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), ['delete ' int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case PipelinePP_PSDict.X_DRAW % __PipelinePP_PSDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('HANDLES')
					end
					
				case PipelinePP_PSDict.UPDATE % __PipelinePP_PSDict.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pip = pr.get('EL');
					
					    ps_dict = pip.get('PS_DICT');
					    ps_number = ps_dict.get('LENGTH');
					    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
					    pr.set('HEIGHT', pr.get('HEIGHT_MIN') + (pr.get('HEIGHT_PS_MARGIN') + pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PS_FOOTER')) * ps_number + pr.get('HEIGHT_PC') * sum(pc_numbers));
					    
					    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
					    c_selected = get_from_varargin(0, 'Code', varargin); % selected code
					
					    to_be_executed = {};
					    
					    s_to_be_calculated = 1;
					    s_dict = pip.get('PS_DICT');
					    for sec = 1:1:s_dict.get('LENGTH')
					        section = s_dict.get('IT', sec);
					        
					        code_dict = section.get('PC_DICT');
					        for cl = 1:1:code_dict.get('LENGTH')
					            code = code_dict.get('IT', cl);
					            moniker = code.get('MONIKER');
					            if strcmpi(moniker, 'varargin')
					                error( ...
					                    [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT], ...
					                    [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT '\n' ...
					                    'The moniker should not be ''varagin''.'] ...
					                    )
					            end
					            
					            % callback code -- CALCULATE
					            if sec == s_selected && cl == c_selected && isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
					                try
					                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'off')
					                    x_pip_update(to_be_executed{:}, ...
					                        {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
					                        {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
					                catch e
					                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'on')
					
					                    if isempty(regexp(e.message, ['^' BRAPH2.STR ':.*:' BRAPH2.CANCEL_IO '$'], 'once'))
					                        %TODO make this with braph2message
					                        warndlg(['An error occurred while trying to execute the code:' newline() ...
					                            newline() ...
					                            moniker ' = ' code.get('CODE') ';' newline() ...
					                            newline() ...
					                            'Error message:' newline() ...
					                            newline() ...
					                            e.message newline()], 'Warning');
					                    end
					                end
					            end
					
					            % If a code has already been executed and the relative element exists, 
					            % 1. loads the calculated element to the workspace
					            % 2. updates the ID in the btn
					            % 3. calculates whether to move to the next section
					            if ~isa(code.getr('EL'), 'NoValue')
					                to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code
					
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'on', ...
					                    'Text', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
					                    'FontAngle', 'normal', ...
					                    'FontWeight', 'normal' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'on')
					
					                % if all section codes calculated, updates the section to be calculated
					                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.get('IT_LIST')))
					                    s_to_be_calculated = sec + 1;
					                end
					                
					                % disables clear buttons of previous section
					                if sec > 1
					                    for cl_tmp = 1:1:s_dict.get('IT', sec - 1).get('PC_DICT').get('LENGTH')
					                        set(pr.get('PC_CLEAR_BTN', sec - 1, cl_tmp), 'Enable', 'off')
					                    end
					                end
					            end
					            
					            % activates the next section that can be calculated
					            % (only the codes that have not been calculated yet)
					            if sec == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'on', ...
					                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
					                    'FontAngle', 'normal', ...
					                    'FontWeight', 'bold' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
					            end
					            
					            % deactivates the subsequent sections
					            if sec > s_to_be_calculated 
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'off', ...
					                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
					                    'FontAngle', 'italic', ...
					                    'FontWeight', 'normal' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
					            end
					            
					            % callback code -- GUI
					            if sec == s_selected && cl == c_selected && ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
					                key = [int2str(sec) '.' int2str(cl)];
					                gui_pc_dict = pr.memorize('GUI_PC_DICT');
					                if ~gui_pc_dict.get('CONTAINS_KEY', key)
					                    f_pip = ancestor(pr.get('H'), 'Figure'); % Pipeline GUI
					
					                    if isa(code.get('EL'), 'PanelFig')
					                        gui = GUIFig( ...
					                            'ID', key, ... % this is the dictionary key
					                            'PF', code.get('EL'), ...
					                            'POSITION', [ ...
					                                x0(f_pip, 'normalized')+w(f_pip, 'normalized') ...
					                                y0(f_pip, 'normalized') ...
					                                w(0,'normalized')-x0(f_pip, 'normalized')-w(f_pip, 'normalized') ...
					                                h(f_pip, 'normalized') ...
					                                ], ...
					                            'WAITBAR', pr.getCallback('WAITBAR'), ...
					                            'CLOSEREQ', false ...
					                            );
					                    else
					                        gui = GUIElement( ...
					                            'ID', key, ... % this is the dictionary key
					                            'PE', code.get('EL'), ...
					                            'POSITION', [ ...
					                                x0(f_pip, 'normalized') + w(f_pip) ...
					                                y0(f_pip, 'normalized') ...
					                                w(f_pip) ...
					                                h(f_pip, 'normalized') ...
					                                ], ...
					                            'WAITBAR', pr.getCallback('WAITBAR'), ...
					                            'CLOSEREQ', false ...
					                            );
					                    end
					                    gui_pc_dict.get('ADD', gui)
					                end
					
					                gui = gui_pc_dict.get('IT', key);
					                if ~gui.get('DRAWN')
					                    gui.get('DRAW')
					                end
					                if get(gui.get('H'), 'Visible')
					                    gui.get('HIDE')
					                else
					                    gui.get('SHOW')
					                end
					            end
					        end
					    end
					end
					
				case PipelinePP_PSDict.REDRAW % __PipelinePP_PSDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    pip = pr.get('EL');
					    ps_dict = pip.get('PS_DICT');
					        
					    ps_number = ps_dict.get('LENGTH');
					    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
					    
					    for sec = 1:1:ps_number
					        ps_y = pr.get('HEIGHT_PS_HEADER') * (ps_number - sec) ...
					            + pr.get('HEIGHT_PC') * sum(pc_numbers(sec+1:end)) ...
					            + pr.get('HEIGHT_PS_FOOTER') * (ps_number - sec) ...
					            + pr.get('HEIGHT_PS_MARGIN') * (ps_number - sec + 1);
					        ps_h = pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PC') * pc_numbers(sec) + pr.get('HEIGHT_PS_FOOTER');
					        
					        set(pr.get('PS_PANEL', sec), ...
					            'Units', 'pixels', ...
					            'Position', [s(.3) ps_y w_p-s(.6) ps_h] ...
					            )
					        
					        for cl = 1:1:pc_numbers(sec)
					            set(pr.get('PC_BTN', sec, cl), 'Position', [s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.9) pr.get('HEIGHT_PC')])
					            set(pr.get('PC_CLEAR_BTN', sec, cl), 'Position', [w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) pr.get('HEIGHT_PC') pr.get('HEIGHT_PC')])
					        end
					    end
					end
					
				case PipelinePP_PSDict.SHOW % __PipelinePP_PSDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % % figures for elements/buttons, currently not in use
					    % gui_pc_dict = pr.get('GUI_PC_DICT');
					    % for i = 1:1:gui_pc_dict.get('LENGTH')
					    %     gui = gui_pc_dict.get('IT', i);
					    %     if gui.get('DRAWN')
					    %         gui.get('SHOW')
					    %     end
					    % end
					end
					
				case PipelinePP_PSDict.HIDE % __PipelinePP_PSDict.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_pc_dict = pr.get('GUI_PC_DICT');
					    for i = 1:1:gui_pc_dict.get('LENGTH')
					        gui = gui_pc_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case PipelinePP_PSDict.DELETE % __PipelinePP_PSDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('HANDLES', Element.getNoValue())
					end
					
				case PipelinePP_PSDict.CLOSE % __PipelinePP_PSDict.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_pc_dict = pr.get('GUI_PC_DICT');
					    for i = 1:1:gui_pc_dict.get('LENGTH')
					        gui = gui_pc_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_pc_btn(src, ~)
			    userdata = get(src, 'UserData');
			    sec = userdata(1);
			    cl = userdata(2);
			
			    pr.get('UPDATE', 'Section', sec, 'Code', cl)
			end
			function cb_pc_clear_btn(src, ~)
			
			    userdata = get(src, 'UserData');
			    sec = userdata(1);
			    cl = userdata(2);
			    
			    % resets the code eliminating element
			    pc_dict = pip.get('PS_DICT').get('IT', sec).get('PC_DICT');
			    code = pc_dict.get('IT', cl);
			    code_new = PipelineCode( ...
			        'TEMPLATE', code.get('TEMPLATE'), ...
			        'ID', code.get('ID'), ...
			        'LABEL', code.get('LABEL'), ...
			        'NOTES', code.get('NOTES'), ...
			        'TEMPLATE', code.get('TEMPLATE'), ...
			        'TEXT_BEFORE_EXEC', code.get('TEXT_BEFORE_EXEC'), ...
			        'TEXT_AFTER_EXEC', code.get('TEXT_AFTER_EXEC'), ...
			        'MONIKER', code.get('MONIKER'), ...
			        'CODE', code.get('CODE') ...
			        );
			    pc_dict.get('REPLACE_IT', code, code_new)
			    
			    % closes and removes the GUI
			    key = [int2str(sec) '.' int2str(cl)];
			    gui_pc_dict = pr.get('GUI_PC_DICT');
			    if gui_pc_dict.get('CONTAINS_KEY', key)
			        gui_pc = gui_pc_dict.get('IT', key);
			        if gui_pc.get('DRAWN')
			            gui_pc.get('CLOSE')
			        end
			        gui_pc_dict.get('REMOVE', key)
			    end
			    
			    pr.get('UPDATE')
			end
		end
	end
end
