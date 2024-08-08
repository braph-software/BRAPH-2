classdef MeasureEnsembleBrainPF_xSPP_Layer < PanelProp
	%MeasureEnsembleBrainPF_xSPP_Layer plots the panel to select a layer.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% MeasureEnsembleBrainPF_xSPP_Layer plots the panel to select a layer from a drop-down list.
	% It is supposed to be used with the property LAYER of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (constructor):
	%  MeasureEnsembleBrainPF_xSPP_Layer - constructor
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods:
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
	% MeasureEnsembleBrainPF_xSPP_Layer methods (display):
	%  tostring - string with information about the panel property layer
	%  disp - displays information about the panel property layer
	%  tree - displays the tree of the panel property layer
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property layer are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property layer
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (save/load, Static):
	%  save - saves BRAPH2 panel property layer as b2 file
	%  load - loads a BRAPH2 panel property layer from a b2 file
	%
	% MeasureEnsembleBrainPF_xSPP_Layer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property layer
	%
	% MeasureEnsembleBrainPF_xSPP_Layer method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property layer
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (inspection, Static):
	%  getClass - returns the class of the panel property layer
	%  getSubclasses - returns all subclasses of MeasureEnsembleBrainPF_xSPP_Layer
	%  getProps - returns the property list of the panel property layer
	%  getPropNumber - returns the property number of the panel property layer
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
	% MeasureEnsembleBrainPF_xSPP_Layer methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsembleBrainPF_xSPP_Layer methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsembleBrainPF_xSPP_Layer; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsembleBrainPF_xSPP_Layer constants</a>.
	%
	%
	% See also uidropdown, GUI, ComparisonGroupPF_NU, ComparisonGroupPF_NS, ComparisonGroupPF_NB.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = MeasureEnsembleBrainPF_xSPP_Layer(varargin)
			%MeasureEnsembleBrainPF_xSPP_Layer() creates a panel property layer.
			%
			% MeasureEnsembleBrainPF_xSPP_Layer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsembleBrainPF_xSPP_Layer(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel property layer.
			%
			% CLASS = MeasureEnsembleBrainPF_xSPP_Layer.GETCLASS() returns the class 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property layer PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('MeasureEnsembleBrainPF_xSPP_Layer') returns 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			
			pr_class = 'MeasureEnsembleBrainPF_xSPP_Layer';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property layer.
			%
			% LIST = MeasureEnsembleBrainPF_xSPP_Layer.GETSUBCLASSES() returns all subclasses of 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property layer PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsembleBrainPF_xSPP_Layer') returns all subclasses of 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsembleBrainPF_xSPP_Layer', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property layer.
			%
			% PROPS = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPS() returns the property list of panel property layer
			%  as a row vector.
			%
			% PROPS = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property layer PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('MeasureEnsembleBrainPF_xSPP_Layer'[, CATEGORY]) returns the property list of 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN ...
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
						MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN ...
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
			%GETPROPNUMBER returns the property number of panel property layer.
			%
			% N = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPNUMBER() returns the property number of panel property layer.
			%
			% N = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPNUMBER(CATEGORY) returns the property number of panel property layer
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property layer PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('MeasureEnsembleBrainPF_xSPP_Layer') returns the property number of 'MeasureEnsembleBrainPF_xSPP_Layer'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsembleBrainPF_xSPP_Layer.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property layer/error.
			%
			% CHECK = MeasureEnsembleBrainPF_xSPP_Layer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP) checks whether PROP exists for MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP) throws error if PROP does NOT exist for MeasureEnsembleBrainPF_xSPP_Layer.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsembleBrainPF_xSPP_Layer.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsembleBrainPF_xSPP_Layer.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property layer/error.
			%
			% CHECK = MeasureEnsembleBrainPF_xSPP_Layer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(MeasureEnsembleBrainPF_xSPP_Layer, TAG) checks whether TAG exists for MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsembleBrainPF_xSPP_Layer, TAG) throws error if TAG does NOT exist for MeasureEnsembleBrainPF_xSPP_Layer.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_xSPP_Layer:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblebrainpf_xspp_layer_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_xSPP_Layer.getPropTag(x), num2cell(MeasureEnsembleBrainPF_xSPP_Layer.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblebrainpf_xspp_layer_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsembleBrainPF_xSPP_Layer.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  PROPERTY = PR.GETPROPPROP(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblebrainpf_xspp_layer_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_xSPP_Layer.getPropTag(x), num2cell(MeasureEnsembleBrainPF_xSPP_Layer.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblebrainpf_xspp_layer_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  TAG = PR.GETPROPTAG(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
						tag = MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  CATEGORY = PR.GETPROPCATEGORY(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
					prop_category = MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  FORMAT = PR.GETPROPFORMAT(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
					prop_format = MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the dropdown for the layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MeasureEnsembleBrainPF_xSPP_Layer.NAME
					prop_description = 'NAME (constant, string) is the name of the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel property layer.';
				case MeasureEnsembleBrainPF_xSPP_Layer.EL
					prop_description = 'EL (data, item) is the element.';
				case MeasureEnsembleBrainPF_xSPP_Layer.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case MeasureEnsembleBrainPF_xSPP_Layer.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case MeasureEnsembleBrainPF_xSPP_Layer.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case MeasureEnsembleBrainPF_xSPP_Layer.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case MeasureEnsembleBrainPF_xSPP_Layer.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case MeasureEnsembleBrainPF_xSPP_Layer.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  SETTINGS = PR.GETPROPSETTINGS(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsembleBrainPF_xSPP_Layer.TEMPLATE
					prop_settings = 'MeasureEnsembleBrainPF_xSPP_Layer';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  DEFAULT = PR.GETPROPDEFAULT(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsembleBrainPF_xSPP_Layer.getPropSettings(prop));
				case MeasureEnsembleBrainPF_xSPP_Layer.ELCLASS
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer';
				case MeasureEnsembleBrainPF_xSPP_Layer.NAME
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer';
				case MeasureEnsembleBrainPF_xSPP_Layer.DESCRIPTION
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer plots the panel to select a layer from a drop-down list. It is supposed to be used with the property LAYER of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.';
				case MeasureEnsembleBrainPF_xSPP_Layer.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsembleBrainPF_xSPP_Layer.getPropSettings(prop));
				case MeasureEnsembleBrainPF_xSPP_Layer.ID
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer ID';
				case MeasureEnsembleBrainPF_xSPP_Layer.LABEL
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer label';
				case MeasureEnsembleBrainPF_xSPP_Layer.NOTES
					prop_default = 'MeasureEnsembleBrainPF_xSPP_Layer notes';
				case MeasureEnsembleBrainPF_xSPP_Layer.EL
					prop_default = MeasureEnsembleBrainPF_NS();
				case MeasureEnsembleBrainPF_xSPP_Layer.PROP
					prop_default = MeasureEnsembleBrainPF_NS.LAYER;
				case MeasureEnsembleBrainPF_xSPP_Layer.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_xSPP_Layer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_xSPP_Layer, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_xSPP_Layer.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			prop_default = MeasureEnsembleBrainPF_xSPP_Layer.conditioning(prop, MeasureEnsembleBrainPF_xSPP_Layer.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_xSPP_Layer.
			%  CHECK = PR.CHECKPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_xSPP_Layer.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_xSPP_Layer:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_xSPP_Layer:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_xSPP_Layer.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_xSPP_Layer:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(MeasureEnsembleBrainPF_xSPP_Layer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_xSPP_Layer.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_xSPP_Layer:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('MeasureEnsembleBrainPF_xSPP_Layer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsembleBrainPF_xSPP_Layer.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN % __MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsembleBrainPF_xSPP_Layer.getPropSettings(prop));
				case MeasureEnsembleBrainPF_xSPP_Layer.TEMPLATE % __MeasureEnsembleBrainPF_xSPP_Layer.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsembleBrainPF_xSPP_Layer.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_xSPP_Layer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsembleBrainPF_xSPP_Layer.getPropTag(prop) ' (' MeasureEnsembleBrainPF_xSPP_Layer.getFormatTag(MeasureEnsembleBrainPF_xSPP_Layer.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN % __MeasureEnsembleBrainPF_xSPP_Layer.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case MeasureEnsembleBrainPF_xSPP_Layer.X_DRAW % __MeasureEnsembleBrainPF_xSPP_Layer.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case MeasureEnsembleBrainPF_xSPP_Layer.UPDATE % __MeasureEnsembleBrainPF_xSPP_Layer.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    LAYER = pr.get('PROP');
					    
					    g_dict = pf.get('ME').get('A').get('G_DICT');
					    if g_dict.get('LENGTH')
					        g = g_dict.get('IT', 1);
					    else
					        g = pf.get('ME').get('A').get('GRAPH_TEMPLATE');
					    end
					    keys = g.get('APARTITIONLABELS');
					
					    if isempty(keys)
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    else
					        set(pr.get('DROPDOWN'), ...
					            'Items', keys, ...
					            'ItemsData', [1:1:length(keys)], ...
					            'Value', pf.get(LAYER) ...
					            )
					    end
					
					    prop_value = pf.getr(LAYER);
					    if pf.isLocked(LAYER) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case MeasureEnsembleBrainPF_xSPP_Layer.REDRAW % __MeasureEnsembleBrainPF_xSPP_Layer.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case MeasureEnsembleBrainPF_xSPP_Layer.DELETE % __MeasureEnsembleBrainPF_xSPP_Layer.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end
