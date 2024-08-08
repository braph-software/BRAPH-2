classdef PanelPropLogical < PanelProp
	%PanelPropLogical plots the panel of a property logical.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Logical Prop Panel (PanelPropLogical) plots the panel for a LOGICAL property with a checkbox.
	% It works for all categories.
	%
	% PanelPropLogical methods (constructor):
	%  PanelPropLogical - constructor
	%
	% PanelPropLogical methods:
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
	% PanelPropLogical methods (display):
	%  tostring - string with information about the logical prop panel
	%  disp - displays information about the logical prop panel
	%  tree - displays the tree of the logical prop panel
	%
	% PanelPropLogical methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two logical prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the logical prop panel
	%
	% PanelPropLogical methods (save/load, Static):
	%  save - saves BRAPH2 logical prop panel as b2 file
	%  load - loads a BRAPH2 logical prop panel from a b2 file
	%
	% PanelPropLogical method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the logical prop panel
	%
	% PanelPropLogical method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the logical prop panel
	%
	% PanelPropLogical methods (inspection, Static):
	%  getClass - returns the class of the logical prop panel
	%  getSubclasses - returns all subclasses of PanelPropLogical
	%  getProps - returns the property list of the logical prop panel
	%  getPropNumber - returns the property number of the logical prop panel
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
	% PanelPropLogical methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropLogical methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropLogical methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropLogical methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropLogical; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropLogical constants</a>.
	%
	%
	% See also uicheckbox, GUI, PanelElement.
	
	properties (Constant) % properties
		CHECKBOX = PanelProp.getPropNumber() + 1;
		CHECKBOX_TAG = 'CHECKBOX';
		CHECKBOX_CATEGORY = Category.EVANESCENT;
		CHECKBOX_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropLogical(varargin)
			%PanelPropLogical() creates a logical prop panel.
			%
			% PanelPropLogical(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropLogical(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the logical prop panel.
			%
			% CLASS = PanelPropLogical.GETCLASS() returns the class 'PanelPropLogical'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the logical prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropLogical') returns 'PanelPropLogical'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropLogical')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropLogical';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the logical prop panel.
			%
			% LIST = PanelPropLogical.GETSUBCLASSES() returns all subclasses of 'PanelPropLogical'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the logical prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropLogical') returns all subclasses of 'PanelPropLogical'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropLogical', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of logical prop panel.
			%
			% PROPS = PanelPropLogical.GETPROPS() returns the property list of logical prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropLogical.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the logical prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropLogical'[, CATEGORY]) returns the property list of 'PanelPropLogical'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropLogical.CHECKBOX ...
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
						PanelPropLogical.CHECKBOX ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of logical prop panel.
			%
			% N = PanelPropLogical.GETPROPNUMBER() returns the property number of logical prop panel.
			%
			% N = PanelPropLogical.GETPROPNUMBER(CATEGORY) returns the property number of logical prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the logical prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropLogical') returns the property number of 'PanelPropLogical'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropLogical.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in logical prop panel/error.
			%
			% CHECK = PanelPropLogical.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropLogical, PROP) checks whether PROP exists for PanelPropLogical.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%  Element.EXISTSPROP(PanelPropLogical, PROP) throws error if PROP does NOT exist for PanelPropLogical.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropLogical.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropLogical.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in logical prop panel/error.
			%
			% CHECK = PanelPropLogical.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropLogical, TAG) checks whether TAG exists for PanelPropLogical.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%  Element.EXISTSTAG(PanelPropLogical, TAG) throws error if TAG does NOT exist for PanelPropLogical.
			%   Error id: [BRAPH2:PanelPropLogical:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelproplogical_tag_list = cellfun(@(x) PanelPropLogical.getPropTag(x), num2cell(PanelPropLogical.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelproplogical_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropLogical.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropLogical, POINTER) returns property number of POINTER of PanelPropLogical.
			%  PROPERTY = PR.GETPROPPROP(PanelPropLogical, POINTER) returns property number of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelproplogical_tag_list = cellfun(@(x) PanelPropLogical.getPropTag(x), num2cell(PanelPropLogical.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelproplogical_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropLogical, POINTER) returns tag of POINTER of PanelPropLogical.
			%  TAG = PR.GETPROPTAG(PanelPropLogical, POINTER) returns tag of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropLogical.CHECKBOX
						tag = PanelPropLogical.CHECKBOX_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropLogical, POINTER) returns category of POINTER of PanelPropLogical.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropLogical, POINTER) returns category of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX
					prop_category = PanelPropLogical.CHECKBOX_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropLogical, POINTER) returns format of POINTER of PanelPropLogical.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropLogical, POINTER) returns format of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX
					prop_format = PanelPropLogical.CHECKBOX_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropLogical, POINTER) returns description of POINTER of PanelPropLogical.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropLogical, POINTER) returns description of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX
					prop_description = 'CHECKBOX (evanescent, handle) is the logical value checkbox.';
				case PanelPropLogical.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the logical property panel.';
				case PanelPropLogical.NAME
					prop_description = 'NAME (constant, string) is the name of the logical property panel.';
				case PanelPropLogical.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the logical property panel.';
				case PanelPropLogical.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the logical property panel.';
				case PanelPropLogical.ID
					prop_description = 'ID (data, string) is a few-letter code for the logical property panel.';
				case PanelPropLogical.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the logical property panel.';
				case PanelPropLogical.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the logical property panel.';
				case PanelPropLogical.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropLogical.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropLogical.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropLogical.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropLogical.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox.';
				case PanelPropLogical.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropLogical.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropLogical, POINTER) returns settings of POINTER of PanelPropLogical.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropLogical, POINTER) returns settings of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropLogical.TEMPLATE
					prop_settings = 'PanelPropLogical';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropLogical.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropLogical.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropLogical, POINTER) returns the default value of POINTER of PanelPropLogical.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropLogical, POINTER) returns the default value of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropLogical.getPropSettings(prop));
				case PanelPropLogical.ELCLASS
					prop_default = 'PanelPropLogical';
				case PanelPropLogical.NAME
					prop_default = 'Logical Prop Panel';
				case PanelPropLogical.DESCRIPTION
					prop_default = 'A Logical Prop Panel (PanelPropLogical) plots the panel for a LOGICAL property with a checkbox. It works for all categories.';
				case PanelPropLogical.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropLogical.getPropSettings(prop));
				case PanelPropLogical.ID
					prop_default = 'PanelPropLogical ID';
				case PanelPropLogical.LABEL
					prop_default = 'PanelPropLogical label';
				case PanelPropLogical.NOTES
					prop_default = 'PanelPropLogical notes';
				case PanelPropLogical.EL
					prop_default = PanelProp();
				case PanelPropLogical.PROP
					prop_default = PanelProp.DRAW;
				case PanelPropLogical.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropLogical.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropLogical.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropLogical, POINTER) returns the conditioned default value of POINTER of PanelPropLogical.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropLogical, POINTER) returns the conditioned default value of POINTER of PanelPropLogical.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			prop_default = PanelPropLogical.conditioning(prop, PanelPropLogical.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropLogical, PROP, VALUE) checks VALUE format for PROP of PanelPropLogical.
			%  CHECK = PR.CHECKPROP(PanelPropLogical, PROP, VALUE) checks VALUE format for PROP of PanelPropLogical.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropLogical:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropLogical:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropLogical, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropLogical.
			%   Error id: €BRAPH2.STR€:PanelPropLogical:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropLogical, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropLogical.
			%   Error id: €BRAPH2.STR€:PanelPropLogical:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropLogical')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropLogical.getPropProp(pointer);
			
			switch prop
				case PanelPropLogical.CHECKBOX % __PanelPropLogical.CHECKBOX__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropLogical.getPropSettings(prop));
				case PanelPropLogical.TEMPLATE % __PanelPropLogical.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropLogical.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropLogical:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropLogical.getPropTag(prop) ' (' PanelPropLogical.getFormatTag(PanelPropLogical.getPropFormat(prop)) ').'] ...
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
				case PanelPropLogical.CHECKBOX % __PanelPropLogical.CHECKBOX__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					checkbox = uicheckbox( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'CHECKBOX', ...
					    'Text', '', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_checkbox} ...
					    );
					
					value = checkbox;
					
				case PanelPropLogical.X_DRAW % __PanelPropLogical.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX')
					end
					
				case PanelPropLogical.UPDATE % __PanelPropLogical.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('CHECKBOX'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					
					        case Category.METADATA
					            set(pr.get('CHECKBOX'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('CHECKBOX'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('CHECKBOX'), 'Value', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('CHECKBOX'), 'Enable', 'off')
					            end
					            
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('CHECKBOX'), 'Value', el.getPropDefault(prop))
					            else
					                set(pr.get('CHECKBOX'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('CHECKBOX'), 'Enable', 'off')
					    end
					end
					
				case PanelPropLogical.REDRAW % __PanelPropLogical.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropLogical.DELETE % __PanelPropLogical.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('CHECKBOX', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_checkbox(~, ~)
			    pr.get('EL').set(pr.get('PROP'), logical(get(pr.get('CHECKBOX'), 'Value')))
			end
		end
	end
end
