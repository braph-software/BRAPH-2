classdef PanelPropRVectorView < PanelProp
	%PanelPropRVectorView plots the panel of a view with azimuth and elevation angles.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight.
	%  Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. 
	%   Increasing this angle corresponds to counterclockwise rotation about the z-axis 
	%   when viewing the xy plane from above.
	%  Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation 
	%   from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.
	% It works for all categories.
	%
	% PanelPropRVectorView methods (constructor):
	%  PanelPropRVectorView - constructor
	%
	% PanelPropRVectorView methods:
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
	% PanelPropRVectorView methods (display):
	%  tostring - string with information about the view prop panel
	%  disp - displays information about the view prop panel
	%  tree - displays the tree of the view prop panel
	%
	% PanelPropRVectorView methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two view prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the view prop panel
	%
	% PanelPropRVectorView methods (save/load, Static):
	%  save - saves BRAPH2 view prop panel as b2 file
	%  load - loads a BRAPH2 view prop panel from a b2 file
	%
	% PanelPropRVectorView method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the view prop panel
	%
	% PanelPropRVectorView method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the view prop panel
	%
	% PanelPropRVectorView methods (inspection, Static):
	%  getClass - returns the class of the view prop panel
	%  getSubclasses - returns all subclasses of PanelPropRVectorView
	%  getProps - returns the property list of the view prop panel
	%  getPropNumber - returns the property number of the view prop panel
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
	% PanelPropRVectorView methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropRVectorView methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropRVectorView methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropRVectorView methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropRVectorView; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropRVectorView constants</a>.
	%
	%
	% See also GUI, PanelElement, view, uieditfield, uislider.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		LABEL_AZ = PanelProp.getPropNumber() + 2;
		LABEL_AZ_TAG = 'LABEL_AZ';
		LABEL_AZ_CATEGORY = Category.EVANESCENT;
		LABEL_AZ_FORMAT = Format.HANDLE;
		
		EDITFIELD_AZ = PanelProp.getPropNumber() + 3;
		EDITFIELD_AZ_TAG = 'EDITFIELD_AZ';
		EDITFIELD_AZ_CATEGORY = Category.EVANESCENT;
		EDITFIELD_AZ_FORMAT = Format.HANDLE;
		
		SLIDER_AZ = PanelProp.getPropNumber() + 4;
		SLIDER_AZ_TAG = 'SLIDER_AZ';
		SLIDER_AZ_CATEGORY = Category.EVANESCENT;
		SLIDER_AZ_FORMAT = Format.HANDLE;
		
		LABEL_EL = PanelProp.getPropNumber() + 5;
		LABEL_EL_TAG = 'LABEL_EL';
		LABEL_EL_CATEGORY = Category.EVANESCENT;
		LABEL_EL_FORMAT = Format.HANDLE;
		
		EDITFIELD_EL = PanelProp.getPropNumber() + 6;
		EDITFIELD_EL_TAG = 'EDITFIELD_EL';
		EDITFIELD_EL_CATEGORY = Category.EVANESCENT;
		EDITFIELD_EL_FORMAT = Format.HANDLE;
		
		SLIDER_EL = PanelProp.getPropNumber() + 7;
		SLIDER_EL_TAG = 'SLIDER_EL';
		SLIDER_EL_CATEGORY = Category.EVANESCENT;
		SLIDER_EL_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropRVectorView(varargin)
			%PanelPropRVectorView() creates a view prop panel.
			%
			% PanelPropRVectorView(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropRVectorView(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the view prop panel.
			%
			% CLASS = PanelPropRVectorView.GETCLASS() returns the class 'PanelPropRVectorView'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the view prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropRVectorView') returns 'PanelPropRVectorView'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropRVectorView')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropRVectorView';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the view prop panel.
			%
			% LIST = PanelPropRVectorView.GETSUBCLASSES() returns all subclasses of 'PanelPropRVectorView'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the view prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropRVectorView') returns all subclasses of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropRVectorView', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of view prop panel.
			%
			% PROPS = PanelPropRVectorView.GETPROPS() returns the property list of view prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropRVectorView.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the view prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropRVectorView'[, CATEGORY]) returns the property list of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropRVectorView.ENABLE ...
						PanelPropRVectorView.LABEL_AZ ...
						PanelPropRVectorView.EDITFIELD_AZ ...
						PanelPropRVectorView.SLIDER_AZ ...
						PanelPropRVectorView.LABEL_EL ...
						PanelPropRVectorView.EDITFIELD_EL ...
						PanelPropRVectorView.SLIDER_EL ...
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
						PanelPropRVectorView.LABEL_AZ ...
						PanelPropRVectorView.EDITFIELD_AZ ...
						PanelPropRVectorView.SLIDER_AZ ...
						PanelPropRVectorView.LABEL_EL ...
						PanelPropRVectorView.EDITFIELD_EL ...
						PanelPropRVectorView.SLIDER_EL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropRVectorView.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of view prop panel.
			%
			% N = PanelPropRVectorView.GETPROPNUMBER() returns the property number of view prop panel.
			%
			% N = PanelPropRVectorView.GETPROPNUMBER(CATEGORY) returns the property number of view prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the view prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropRVectorView') returns the property number of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropRVectorView.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in view prop panel/error.
			%
			% CHECK = PanelPropRVectorView.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropRVectorView, PROP) checks whether PROP exists for PanelPropRVectorView.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSPROP(PanelPropRVectorView, PROP) throws error if PROP does NOT exist for PanelPropRVectorView.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropRVectorView.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropRVectorView.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in view prop panel/error.
			%
			% CHECK = PanelPropRVectorView.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropRVectorView, TAG) checks whether TAG exists for PanelPropRVectorView.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSTAG(PanelPropRVectorView, TAG) throws error if TAG does NOT exist for PanelPropRVectorView.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelproprvectorview_tag_list = cellfun(@(x) PanelPropRVectorView.getPropTag(x), num2cell(PanelPropRVectorView.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelproprvectorview_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropRVectorView.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropRVectorView, POINTER) returns property number of POINTER of PanelPropRVectorView.
			%  PROPERTY = PR.GETPROPPROP(PanelPropRVectorView, POINTER) returns property number of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelproprvectorview_tag_list = cellfun(@(x) PanelPropRVectorView.getPropTag(x), num2cell(PanelPropRVectorView.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelproprvectorview_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropRVectorView, POINTER) returns tag of POINTER of PanelPropRVectorView.
			%  TAG = PR.GETPROPTAG(PanelPropRVectorView, POINTER) returns tag of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropRVectorView.ENABLE
						tag = PanelPropRVectorView.ENABLE_TAG;
					case PanelPropRVectorView.LABEL_AZ
						tag = PanelPropRVectorView.LABEL_AZ_TAG;
					case PanelPropRVectorView.EDITFIELD_AZ
						tag = PanelPropRVectorView.EDITFIELD_AZ_TAG;
					case PanelPropRVectorView.SLIDER_AZ
						tag = PanelPropRVectorView.SLIDER_AZ_TAG;
					case PanelPropRVectorView.LABEL_EL
						tag = PanelPropRVectorView.LABEL_EL_TAG;
					case PanelPropRVectorView.EDITFIELD_EL
						tag = PanelPropRVectorView.EDITFIELD_EL_TAG;
					case PanelPropRVectorView.SLIDER_EL
						tag = PanelPropRVectorView.SLIDER_EL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropRVectorView, POINTER) returns category of POINTER of PanelPropRVectorView.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropRVectorView, POINTER) returns category of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE
					prop_category = PanelPropRVectorView.ENABLE_CATEGORY;
				case PanelPropRVectorView.LABEL_AZ
					prop_category = PanelPropRVectorView.LABEL_AZ_CATEGORY;
				case PanelPropRVectorView.EDITFIELD_AZ
					prop_category = PanelPropRVectorView.EDITFIELD_AZ_CATEGORY;
				case PanelPropRVectorView.SLIDER_AZ
					prop_category = PanelPropRVectorView.SLIDER_AZ_CATEGORY;
				case PanelPropRVectorView.LABEL_EL
					prop_category = PanelPropRVectorView.LABEL_EL_CATEGORY;
				case PanelPropRVectorView.EDITFIELD_EL
					prop_category = PanelPropRVectorView.EDITFIELD_EL_CATEGORY;
				case PanelPropRVectorView.SLIDER_EL
					prop_category = PanelPropRVectorView.SLIDER_EL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropRVectorView, POINTER) returns format of POINTER of PanelPropRVectorView.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropRVectorView, POINTER) returns format of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE
					prop_format = PanelPropRVectorView.ENABLE_FORMAT;
				case PanelPropRVectorView.LABEL_AZ
					prop_format = PanelPropRVectorView.LABEL_AZ_FORMAT;
				case PanelPropRVectorView.EDITFIELD_AZ
					prop_format = PanelPropRVectorView.EDITFIELD_AZ_FORMAT;
				case PanelPropRVectorView.SLIDER_AZ
					prop_format = PanelPropRVectorView.SLIDER_AZ_FORMAT;
				case PanelPropRVectorView.LABEL_EL
					prop_format = PanelPropRVectorView.LABEL_EL_FORMAT;
				case PanelPropRVectorView.EDITFIELD_EL
					prop_format = PanelPropRVectorView.EDITFIELD_EL_FORMAT;
				case PanelPropRVectorView.SLIDER_EL
					prop_format = PanelPropRVectorView.SLIDER_EL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropRVectorView, POINTER) returns description of POINTER of PanelPropRVectorView.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropRVectorView, POINTER) returns description of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case PanelPropRVectorView.LABEL_AZ
					prop_description = 'LABEL_AZ (evanescent, handle) is the azimuthal angle label.';
				case PanelPropRVectorView.EDITFIELD_AZ
					prop_description = 'EDITFIELD_AZ (evanescent, handle) is the azimuthal angle edit field.';
				case PanelPropRVectorView.SLIDER_AZ
					prop_description = 'SLIDER_AZ (evanescent, handle) is the azimuthal angle slider.';
				case PanelPropRVectorView.LABEL_EL
					prop_description = 'LABEL_EL (evanescent, handle) is the elevation angle label.';
				case PanelPropRVectorView.EDITFIELD_EL
					prop_description = 'EDITFIELD_EL (evanescent, handle) is the elevation angle edit field.';
				case PanelPropRVectorView.SLIDER_EL
					prop_description = 'SLIDER_EL (evanescent, handle) is the elevation angle slider.';
				case PanelPropRVectorView.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.NAME
					prop_description = 'NAME (constant, string) is the name of the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel of a view with azimuth and elevation angles.';
				case PanelPropRVectorView.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropRVectorView.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropRVectorView.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the settings position panel.';
				case PanelPropRVectorView.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropRVectorView.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case PanelPropRVectorView.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropRVectorView.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropRVectorView, POINTER) returns settings of POINTER of PanelPropRVectorView.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropRVectorView, POINTER) returns settings of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropRVectorView.LABEL_AZ
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.EDITFIELD_AZ
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.SLIDER_AZ
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.LABEL_EL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.EDITFIELD_EL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.SLIDER_EL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropRVectorView.TEMPLATE
					prop_settings = 'PanelPropRVectorView';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropRVectorView, POINTER) returns the default value of POINTER of PanelPropRVectorView.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropRVectorView, POINTER) returns the default value of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE
					prop_default = true;
				case PanelPropRVectorView.LABEL_AZ
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.EDITFIELD_AZ
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.SLIDER_AZ
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.LABEL_EL
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.EDITFIELD_EL
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.SLIDER_EL
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.ELCLASS
					prop_default = 'PanelPropRVectorView';
				case PanelPropRVectorView.NAME
					prop_default = 'View Prop Panel';
				case PanelPropRVectorView.DESCRIPTION
					prop_default = 'A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight. Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. Increasing this angle corresponds to counterclockwise rotation about the z-axis when viewing the xy plane from above. Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.It works for all categories.';
				case PanelPropRVectorView.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.ID
					prop_default = 'PanelPropRVectorView ID';
				case PanelPropRVectorView.LABEL
					prop_default = 'PanelPropRVectorView label';
				case PanelPropRVectorView.NOTES
					prop_default = 'PanelPropRVectorView notes';
				case PanelPropRVectorView.EL
					prop_default = BrainSurfacePF();
				case PanelPropRVectorView.PROP
					prop_default = BrainSurfacePF.VIEW;
				case PanelPropRVectorView.HEIGHT
					prop_default = s(6.4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropRVectorView, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorView.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropRVectorView, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			prop_default = PanelPropRVectorView.conditioning(prop, PanelPropRVectorView.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropRVectorView, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorView.
			%  CHECK = PR.CHECKPROP(PanelPropRVectorView, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorView.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropRVectorView:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorView:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropRVectorView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorView.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorView:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropRVectorView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorView.
			%   Error id: €BRAPH2.STR€:PanelPropRVectorView:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case PanelPropRVectorView.ENABLE % __PanelPropRVectorView.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.LABEL_AZ % __PanelPropRVectorView.LABEL_AZ__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.EDITFIELD_AZ % __PanelPropRVectorView.EDITFIELD_AZ__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.SLIDER_AZ % __PanelPropRVectorView.SLIDER_AZ__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.LABEL_EL % __PanelPropRVectorView.LABEL_EL__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.EDITFIELD_EL % __PanelPropRVectorView.EDITFIELD_EL__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.SLIDER_EL % __PanelPropRVectorView.SLIDER_EL__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropRVectorView.getPropSettings(prop));
				case PanelPropRVectorView.TEMPLATE % __PanelPropRVectorView.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropRVectorView.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropRVectorView:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropRVectorView.getPropTag(prop) ' (' PanelPropRVectorView.getFormatTag(PanelPropRVectorView.getPropFormat(prop)) ').'] ...
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
				case PanelPropRVectorView.LABEL_AZ % __PanelPropRVectorView.LABEL_AZ__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_az =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_AZ', ...
					    'Text', 'azimuth', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_az;
					
				case PanelPropRVectorView.EDITFIELD_AZ % __PanelPropRVectorView.EDITFIELD_AZ__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_az = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_AZ', ...
					    'Limits', [-180 180], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield_az} ...
					    );
					value = editfield_az;
					
				case PanelPropRVectorView.SLIDER_AZ % __PanelPropRVectorView.SLIDER_AZ__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_az = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_AZ', ...
					    'Limits', [-180 180], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_slider_az} ...
					    );
					value = slider_az;
					
				case PanelPropRVectorView.LABEL_EL % __PanelPropRVectorView.LABEL_EL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_el =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_EL', ...
					    'Text', 'elevation', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_el;
					
				case PanelPropRVectorView.EDITFIELD_EL % __PanelPropRVectorView.EDITFIELD_EL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_el = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_EL', ...
					    'Limits', [-90 90], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield_el} ...
					    );
					value = editfield_el;
					
				case PanelPropRVectorView.SLIDER_EL % __PanelPropRVectorView.SLIDER_EL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_el = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_EL', ...
					    'Limits', [-90 90], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_slider_el} ...
					    );
					value = slider_el;
					
				case PanelPropRVectorView.X_DRAW % __PanelPropRVectorView.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('LABEL_AZ')
					    pr.memorize('EDITFIELD_AZ')
					    pr.memorize('SLIDER_AZ')
					
					    pr.memorize('LABEL_EL')
					    pr.memorize('EDITFIELD_EL')
					    pr.memorize('SLIDER_EL')
					end
					
				case PanelPropRVectorView.UPDATE % __PanelPropRVectorView.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('EDITFIELD_AZ'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_EL'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            v = el.get(prop);
					            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
					            set(pr.get('SLIDER_AZ'), 'Value', v(1))
					            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
					            set(pr.get('SLIDER_EL'), 'Value', v(2))
					
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            v = el.get(prop);
					            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
					            set(pr.get('SLIDER_AZ'), 'Value', v(1))
					            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
					            set(pr.get('SLIDER_EL'), 'Value', v(2))
					
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
					            end
					
					        case Category.RESULT
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                v = el.getPropDefault(prop);
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Value', v(1), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), ...
					                    'Value', v(1), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Value', v(2), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), ...
					                    'Value', v(2), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                v = el.get(prop);
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Value', v(1), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), ...
					                    'Value', v(1), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Value', v(2), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), ...
					                    'Value', v(2), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case PanelPropRVectorView.REDRAW % __PanelPropRVectorView.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('LABEL_AZ'),     'Position', [s(.3)                 s(3.2)  .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_AZ'), 'Position', [s(.6)+.20*w_p         s(3.2)  .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_AZ'),    'Position', [s(.6)+.35*w_p+s(1.7)  s(4.75) .50*w_p   3]) % the height of a slider cannot be changed
					    set(pr.get('LABEL_EL'),     'Position', [s(.3)                 s(.7)   .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_EL'), 'Position', [s(.6)+.20*w_p         s(.7)   .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_EL'),    'Position', [s(.6)+.35*w_p+s(1.7)  s(2.25) .50*w_p   3]) % the height of a slider cannot be changed
					end
					
				case PanelPropRVectorView.DELETE % __PanelPropRVectorView.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('LABEL_AZ', Element.getNoValue())
					    pr.set('EDITFIELD_AZ', Element.getNoValue())
					    pr.set('SLIDER_AZ', Element.getNoValue())
					
					    pr.set('LABEL_EL', Element.getNoValue())
					    pr.set('EDITFIELD_EL', Element.getNoValue())
					    pr.set('SLIDER_EL', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield_az(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    azimuth = get(pr.get('EDITFIELD_AZ'), 'Value');
			    
			    old_v = el.get(prop);
			    elevation = old_v(2);
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_slider_az(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    azimuth = get(pr.get('SLIDER_AZ'), 'Value');
			    
			    old_v = el.get(prop);
			    elevation = old_v(2);
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_editfield_el(~, ~) % (src, event)
			    
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    old_v = el.get(prop);
			    azimuth = old_v(1);
			
			    elevation = get(pr.get('EDITFIELD_EL'), 'Value');
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_slider_el(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    old_v = el.get(prop);
			    azimuth = old_v(1);
			    
			    elevation = get(pr.get('SLIDER_EL'), 'Value');
			    
			    el.set(prop, [azimuth, elevation])
			end
		end
	end
end
