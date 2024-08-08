classdef PipelinePP_Notes < PanelPropStringTextArea
	%PipelinePP_Notes plots the panel for a pipeline notes.
	% It is a subclass of <a href="matlab:help PanelPropStringTextArea">PanelPropStringTextArea</a>.
	%
	% A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with 
	%  the pipeline notes enhnaced with a popup context menu to open the web 
	%  tutorial and the pdf tuorial, as well as to edit or clone the pipeline.
	% It should be used only with the prop NOTES of the element Pipeline.
	%
	% PipelinePP_Notes methods (constructor):
	%  PipelinePP_Notes - constructor
	%
	% PipelinePP_Notes methods:
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
	% PipelinePP_Notes methods (display):
	%  tostring - string with information about the prop panel for pipeline notes
	%  disp - displays information about the prop panel for pipeline notes
	%  tree - displays the tree of the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for pipeline notes are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for pipeline notes as b2 file
	%  load - loads a BRAPH2 prop panel for pipeline notes from a b2 file
	%
	% PipelinePP_Notes method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for pipeline notes
	%
	% PipelinePP_Notes method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (inspection, Static):
	%  getClass - returns the class of the prop panel for pipeline notes
	%  getSubclasses - returns all subclasses of PipelinePP_Notes
	%  getProps - returns the property list of the prop panel for pipeline notes
	%  getPropNumber - returns the property number of the prop panel for pipeline notes
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
	% PipelinePP_Notes methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelinePP_Notes methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelinePP_Notes methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelinePP_Notes methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelinePP_Notes; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelinePP_Notes constants</a>.
	%
	%
	% See also uitextarea, uicontextmenu, Pipeline.
	
	properties (Constant) % properties
		CONTEXTMENU = PanelPropStringTextArea.getPropNumber() + 1;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		MENUS = PanelPropStringTextArea.getPropNumber() + 2;
		MENUS_TAG = 'MENUS';
		MENUS_CATEGORY = Category.EVANESCENT;
		MENUS_FORMAT = Format.HANDLELIST;
	end
	methods % constructor
		function pr = PipelinePP_Notes(varargin)
			%PipelinePP_Notes() creates a prop panel for pipeline notes.
			%
			% PipelinePP_Notes(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelinePP_Notes(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelPropStringTextArea(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for pipeline notes.
			%
			% CLASS = PipelinePP_Notes.GETCLASS() returns the class 'PipelinePP_Notes'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for pipeline notes PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PipelinePP_Notes') returns 'PipelinePP_Notes'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PipelinePP_Notes')
			%  are less computationally efficient.
			
			pr_class = 'PipelinePP_Notes';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for pipeline notes.
			%
			% LIST = PipelinePP_Notes.GETSUBCLASSES() returns all subclasses of 'PipelinePP_Notes'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for pipeline notes PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PipelinePP_Notes') returns all subclasses of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PipelinePP_Notes', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for pipeline notes.
			%
			% PROPS = PipelinePP_Notes.GETPROPS() returns the property list of prop panel for pipeline notes
			%  as a row vector.
			%
			% PROPS = PipelinePP_Notes.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for pipeline notes PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PipelinePP_Notes'[, CATEGORY]) returns the property list of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelPropStringTextArea.getProps() ...
						PipelinePP_Notes.CONTEXTMENU ...
						PipelinePP_Notes.MENUS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelPropStringTextArea.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.EVANESCENT) ...
						PipelinePP_Notes.CONTEXTMENU ...
						PipelinePP_Notes.MENUS ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelPropStringTextArea.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for pipeline notes.
			%
			% N = PipelinePP_Notes.GETPROPNUMBER() returns the property number of prop panel for pipeline notes.
			%
			% N = PipelinePP_Notes.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for pipeline notes
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for pipeline notes PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PipelinePP_Notes') returns the property number of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PipelinePP_Notes.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for pipeline notes/error.
			%
			% CHECK = PipelinePP_Notes.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PipelinePP_Notes, PROP) checks whether PROP exists for PipelinePP_Notes.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSPROP(PipelinePP_Notes, PROP) throws error if PROP does NOT exist for PipelinePP_Notes.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PipelinePP_Notes.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelinePP_Notes.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for pipeline notes/error.
			%
			% CHECK = PipelinePP_Notes.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PipelinePP_Notes, TAG) checks whether TAG exists for PipelinePP_Notes.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSTAG(PipelinePP_Notes, TAG) throws error if TAG does NOT exist for PipelinePP_Notes.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pipelinepp_notes_tag_list = cellfun(@(x) PipelinePP_Notes.getPropTag(x), num2cell(PipelinePP_Notes.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pipelinepp_notes_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PipelinePP_Notes.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PipelinePP_Notes, POINTER) returns property number of POINTER of PipelinePP_Notes.
			%  PROPERTY = PR.GETPROPPROP(PipelinePP_Notes, POINTER) returns property number of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pipelinepp_notes_tag_list = cellfun(@(x) PipelinePP_Notes.getPropTag(x), num2cell(PipelinePP_Notes.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pipelinepp_notes_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PipelinePP_Notes, POINTER) returns tag of POINTER of PipelinePP_Notes.
			%  TAG = PR.GETPROPTAG(PipelinePP_Notes, POINTER) returns tag of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PipelinePP_Notes.CONTEXTMENU
						tag = PipelinePP_Notes.CONTEXTMENU_TAG;
					case PipelinePP_Notes.MENUS
						tag = PipelinePP_Notes.MENUS_TAG;
					otherwise
						tag = getPropTag@PanelPropStringTextArea(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PipelinePP_Notes, POINTER) returns category of POINTER of PipelinePP_Notes.
			%  CATEGORY = PR.GETPROPCATEGORY(PipelinePP_Notes, POINTER) returns category of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU
					prop_category = PipelinePP_Notes.CONTEXTMENU_CATEGORY;
				case PipelinePP_Notes.MENUS
					prop_category = PipelinePP_Notes.MENUS_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelPropStringTextArea(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PipelinePP_Notes, POINTER) returns format of POINTER of PipelinePP_Notes.
			%  FORMAT = PR.GETPROPFORMAT(PipelinePP_Notes, POINTER) returns format of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU
					prop_format = PipelinePP_Notes.CONTEXTMENU_FORMAT;
				case PipelinePP_Notes.MENUS
					prop_format = PipelinePP_Notes.MENUS_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelPropStringTextArea(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelinePP_Notes, POINTER) returns description of POINTER of PipelinePP_Notes.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PipelinePP_Notes, POINTER) returns description of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the popup context menu.';
				case PipelinePP_Notes.MENUS
					prop_description = 'MENUS (evanescent, handlelist) is the list of context menus.';
				case PipelinePP_Notes.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the prop panel for pipeline notes.';
				case PipelinePP_Notes.NAME
					prop_description = 'NAME (constant, string) is the name of the prop panel for pipeline notes.';
				case PipelinePP_Notes.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.';
				case PipelinePP_Notes.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.';
				case PipelinePP_Notes.ID
					prop_description = 'ID (data, string) is a few-letter code for the prop panel for pipeline notes.';
				case PipelinePP_Notes.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.';
				case PipelinePP_Notes.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.';
				case PipelinePP_Notes.EL
					prop_description = 'EL (data, item) is the element.';
				case PipelinePP_Notes.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PipelinePP_Notes.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the prop panel.';
				case PipelinePP_Notes.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case PipelinePP_Notes.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.';
				case PipelinePP_Notes.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case PipelinePP_Notes.TEXTAREA
					prop_description = 'TEXTAREA (evanescent, handle) is the string value text-area.';
				otherwise
					prop_description = getPropDescription@PanelPropStringTextArea(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PipelinePP_Notes, POINTER) returns settings of POINTER of PipelinePP_Notes.
			%  SETTINGS = PR.GETPROPSETTINGS(PipelinePP_Notes, POINTER) returns settings of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PipelinePP_Notes.MENUS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PipelinePP_Notes.TEMPLATE
					prop_settings = 'PipelinePP_Notes';
				case PipelinePP_Notes.EL
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@PanelPropStringTextArea(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelinePP_Notes, POINTER) returns the default value of POINTER of PipelinePP_Notes.
			%  DEFAULT = PR.GETPROPDEFAULT(PipelinePP_Notes, POINTER) returns the default value of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.MENUS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.ELCLASS
					prop_default = 'PipelinePP_Notes';
				case PipelinePP_Notes.NAME
					prop_default = 'Prop Panel for Pipeline Notes';
				case PipelinePP_Notes.DESCRIPTION
					prop_default = 'A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with the pipeline notes enhnaced with a popup context menu to open the web tutorial and the pdf tuorial, as well as to edit or clone the pipeline. It should be used only with the prop NOTES of the element Pipeline.';
				case PipelinePP_Notes.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.ID
					prop_default = 'PipelinePP_Notes ID';
				case PipelinePP_Notes.LABEL
					prop_default = 'PipelinePP_Notes label';
				case PipelinePP_Notes.NOTES
					prop_default = 'PipelinePP_Notes notes';
				case PipelinePP_Notes.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.PROP
					prop_default = Pipeline.NOTES;
				case PipelinePP_Notes.HEIGHT
					prop_default = s(10);
				otherwise
					prop_default = getPropDefault@PanelPropStringTextArea(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelinePP_Notes, POINTER) returns the conditioned default value of POINTER of PipelinePP_Notes.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PipelinePP_Notes, POINTER) returns the conditioned default value of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			prop_default = PipelinePP_Notes.conditioning(prop, PipelinePP_Notes.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PipelinePP_Notes, PROP, VALUE) checks VALUE format for PROP of PipelinePP_Notes.
			%  CHECK = PR.CHECKPROP(PipelinePP_Notes, PROP, VALUE) checks VALUE format for PROP of PipelinePP_Notes.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PipelinePP_Notes:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PipelinePP_Notes:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PipelinePP_Notes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_Notes.
			%   Error id: €BRAPH2.STR€:PipelinePP_Notes:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PipelinePP_Notes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_Notes.
			%   Error id: €BRAPH2.STR€:PipelinePP_Notes:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case PipelinePP_Notes.CONTEXTMENU % __PipelinePP_Notes.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.MENUS % __PipelinePP_Notes.MENUS__
					check = Format.checkFormat(Format.HANDLELIST, value, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.TEMPLATE % __PipelinePP_Notes.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PipelinePP_Notes.getPropSettings(prop));
				case PipelinePP_Notes.EL % __PipelinePP_Notes.EL__
					check = Format.checkFormat(Format.ITEM, value, PipelinePP_Notes.getPropSettings(prop));
				otherwise
					if prop <= PanelPropStringTextArea.getPropNumber()
						check = checkProp@PanelPropStringTextArea(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelinePP_Notes:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelinePP_Notes.getPropTag(prop) ' (' PipelinePP_Notes.getFormatTag(PipelinePP_Notes.getPropFormat(prop)) ').'] ...
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
				case PipelinePP_Notes.CONTEXTMENU % __PipelinePP_Notes.CONTEXTMENU__
					pip = pr.get('EL');
					NOTES = pr.get('PROP');
					
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'TAG', 'CONTEXTMENU' ...
					    );
					
					set(pr.get('TEXTAREA'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case PipelinePP_Notes.MENUS % __PipelinePP_Notes.MENUS__
					contextmenu = pr.get('CONTEXTMENU');
					
					menu_tut_web = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_TUT_WEB', ...
					    'Text', 'Web Tutorial ...', ...
					    'Enable', 'off', ...
					    'MenuSelectedFcn', {@cb_tut_web} ...
					    );
					menu_tut_pdf = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_TUT_PDF', ...
					    'Text', 'PDF Tutorial ...', ...
					    'Enable', 'off', ...
					    'MenuSelectedFcn', {@cb_tut_pdf} ...
					    );
					menu_pip_edit = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_PIP_EDIT', ...
					    'Text', 'Edit Pipeline ...', ...
					    'MenuSelectedFcn', {@cb_pip_edit} ...
					    );
					menu_pip_clone = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_PIP_CLONE', ...
					    'Text', 'Clone Pipeline ...', ...
					    'MenuSelectedFcn', {@cb_pip_clone} ...
					    );
					
					value = [menu_tut_web, menu_tut_pdf, menu_pip_edit, menu_pip_clone];
					
				case PipelinePP_Notes.X_DRAW % __PipelinePP_Notes.X_DRAW__
					value = calculateValue@PanelPropStringTextArea(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('MENUS')
					end
					
				case PipelinePP_Notes.UPDATE % __PipelinePP_Notes.UPDATE__
					value = calculateValue@PanelPropStringTextArea(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
					    pip = pr.get('EL');
					    NOTES = pr.get('PROP');
					    
					    notes = pip.get(NOTES);
					
					    pdf = regexp(notes, '/tutorials/pipelines/\w+/\w+\.pdf', 'match', 'once'); % note \ for compilation
					    notes = regexprep(notes, ['PDF:.*?(' newline() '|$)'], '');
					
					    md = regexp(notes, '/tutorials/pipelines/\w+/readme\.md', 'match', 'once'); % note \ for compilation
					    notes = regexprep(notes, ['README:.*?(' newline() '|$)'], '');
					
					    notes = strtrim(notes);
					
					    set(pr.get('TEXTAREA'), 'Value', strrep(notes, '\n', char(10))) % note \ for compilation
					    if pip.isLocked(NOTES)
					        set(pr.get('TEXTAREA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					    end
					
					    menus = pr.get('MENUS');
					    set(menus(1), 'Enable', ~isempty(pip.get('README'))) % menus(1) = menu_tut_web
					    set(menus(2), 'Enable', ~isempty(pip.get('PDF'))) % menus(2) = menu_tut_pdf
					end
					
				case PipelinePP_Notes.DELETE % __PipelinePP_Notes.DELETE__
					value = calculateValue@PanelPropStringTextArea(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('MENUS', Element.getNoValue())
					end
					
				case PipelinePP_Notes.TEXTAREA % __PipelinePP_Notes.TEXTAREA__
					pip = pr.get('EL');
					NOTES = pr.get('PROP');
					
					textarea = uitextarea( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXTAREA', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(pip.getPropProp(NOTES)) ' ' pip.getPropDescription(NOTES)], ...
					    'ValueChangedFcn', {@cb_textarea} ...
					    );
					
					value = textarea;
					
				otherwise
					if prop <= PanelPropStringTextArea.getPropNumber()
						value = calculateValue@PanelPropStringTextArea(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_tut_web(~, ~)
			    pip = pr.get('EL');
			
			    web([BRAPH2.GITHUB '/tree/develop' pip.get('README')]);
			end
			function cb_tut_pdf(~, ~)
			    pip = pr.get('EL');
			
			    if ismac()
			        system(['open -a Preview ' fileparts(fileparts(which('braph2'))) pip.get('PDF')]);
			    elseif isunix()
			        system(['xdg-open "' fileparts(fileparts(which('braph2'))) regexprep(pip.get('PDF'), '/', '\') '"']);
			    elseif ispc()
			        system(['start "" "' fileparts(fileparts(which('braph2'))) pip.get('PDF') '"']);
			    end
			end
			function cb_pip_edit(~, ~)
			    pip = pr.get('EL');
			
			    edit([pip.get('ID') '.braph2'])
			end
			function cb_pip_clone(~, ~)
			    pip = pr.get('EL');
			
			    pip_file_name = which([pip.get('ID') '.braph2']);
			    
			    cloned_pip = ImporterPipelineBRAPH2( ...
			        'FILE', pip_file_name, ...
			        'WAITBAR', true ...
			        ).get('PIP');
			
			    [path, name, ext] = fileparts(pip_file_name);
			    cloned_name = ['cloned_' name];
			
			    pip.set( ...
			        'ID', cloned_name, ...
			        'LABEL', ['Clone of ' cloned_pip.get('LABEL')], ...
			        'NOTES', ['This is a clone of another pipeline!' newline() ' ' newline() cloned_pip.get('NOTES')] ...
			        )
			    
			    cloned_file_name = [path filesep() cloned_name ext];
			    ExporterPipelineBRAPH2( ...
			        'PIP', cloned_pip, ...
			        'FILE', cloned_file_name, ...
			        'WAITBAR', true ...
			        ).get('SAVE')
			
			    edit(cloned_file_name)
			end
			function cb_textarea(~, ~)
			    notes = get(pr.get('TEXTAREA'), 'Value');
			
			    
			
			    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\n', value{:})) % double \ to be converted to single \ in compilation
			end
		end
	end
end
