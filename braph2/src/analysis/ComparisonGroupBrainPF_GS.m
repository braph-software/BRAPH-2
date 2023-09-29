classdef ComparisonGroupBrainPF_GS < ComparisonGroupBrainPF
	%ComparisonGroupBrainPF_GS is the base element to plot a global superglobal group comparison on brain surface figure.
	% It is a subclass of <a href="matlab:help ComparisonGroupBrainPF">ComparisonGroupBrainPF</a>.
	%
	% ComparisonGroupBrainPF_GS manages the  % % % .
	%
	% ComparisonGroupBrainPF_GS methods (constructor):
	%  ComparisonGroupBrainPF_GS - constructor
	%
	% ComparisonGroupBrainPF_GS methods:
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
	% ComparisonGroupBrainPF_GS methods (display):
	%  tostring - string with information about the panel global superglobal group comparison on brain surface figure
	%  disp - displays information about the panel global superglobal group comparison on brain surface figure
	%  tree - displays the tree of the panel global superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_GS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel global superglobal group comparison on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel global superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_GS methods (save/load, Static):
	%  save - saves BRAPH2 panel global superglobal group comparison on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel global superglobal group comparison on brain surface figure from a b2 file
	%
	% ComparisonGroupBrainPF_GS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel global superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_GS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel global superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_GS methods (inspection, Static):
	%  getClass - returns the class of the panel global superglobal group comparison on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonGroupBrainPF_GS
	%  getProps - returns the property list of the panel global superglobal group comparison on brain surface figure
	%  getPropNumber - returns the property number of the panel global superglobal group comparison on brain surface figure
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
	% ComparisonGroupBrainPF_GS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupBrainPF_GS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupBrainPF_GS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupBrainPF_GS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupBrainPF_GS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupBrainPF_GS constants</a>.
	%
	%
	% See also ComparisonGroup.
	
	properties (Constant) % properties
		NODES = ComparisonGroupBrainPF.getPropNumber() + 1;
		NODES_TAG = 'NODES';
		NODES_CATEGORY = Category.FIGURE;
		NODES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function pf = ComparisonGroupBrainPF_GS(varargin)
			%ComparisonGroupBrainPF_GS() creates a panel global superglobal group comparison on brain surface figure.
			%
			% ComparisonGroupBrainPF_GS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupBrainPF_GS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@ComparisonGroupBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel global superglobal group comparison on brain surface figure.
			%
			% CLASS = ComparisonGroupBrainPF_GS.GETCLASS() returns the class 'ComparisonGroupBrainPF_GS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel global superglobal group comparison on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonGroupBrainPF_GS') returns 'ComparisonGroupBrainPF_GS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonGroupBrainPF_GS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel global superglobal group comparison on brain surface figure.
			%
			% LIST = ComparisonGroupBrainPF_GS.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupBrainPF_GS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel global superglobal group comparison on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupBrainPF_GS') returns all subclasses of 'ComparisonGroupBrainPF_GS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupBrainPF_GS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel global superglobal group comparison on brain surface figure.
			%
			% PROPS = ComparisonGroupBrainPF_GS.GETPROPS() returns the property list of panel global superglobal group comparison on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonGroupBrainPF_GS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel global superglobal group comparison on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonGroupBrainPF_GS'[, CATEGORY]) returns the property list of 'ComparisonGroupBrainPF_GS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ComparisonGroupBrainPF.getProps() ...
						ComparisonGroupBrainPF_GS.NODES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ComparisonGroupBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.FIGURE) ...
						ComparisonGroupBrainPF_GS.NODES ...
						];
				case Category.GUI
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel global superglobal group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF_GS.GETPROPNUMBER() returns the property number of panel global superglobal group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF_GS.GETPROPNUMBER(CATEGORY) returns the property number of panel global superglobal group comparison on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel global superglobal group comparison on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupBrainPF_GS') returns the property number of 'ComparisonGroupBrainPF_GS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupBrainPF_GS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel global superglobal group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF_GS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupBrainPF_GS, PROP) checks whether PROP exists for ComparisonGroupBrainPF_GS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupBrainPF_GS, PROP) throws error if PROP does NOT exist for ComparisonGroupBrainPF_GS.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupBrainPF_GS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupBrainPF_GS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel global superglobal group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF_GS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupBrainPF_GS, TAG) checks whether TAG exists for ComparisonGroupBrainPF_GS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupBrainPF_GS, TAG) throws error if TAG does NOT exist for ComparisonGroupBrainPF_GS.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_GS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongroupbrainpf_gs_tag_list = cellfun(@(x) ComparisonGroupBrainPF_GS.getPropTag(x), num2cell(ComparisonGroupBrainPF_GS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongroupbrainpf_gs_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupBrainPF_GS.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupBrainPF_GS, POINTER) returns property number of POINTER of ComparisonGroupBrainPF_GS.
			%  PROPERTY = PF.GETPROPPROP(ComparisonGroupBrainPF_GS, POINTER) returns property number of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongroupbrainpf_gs_tag_list = cellfun(@(x) ComparisonGroupBrainPF_GS.getPropTag(x), num2cell(ComparisonGroupBrainPF_GS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongroupbrainpf_gs_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(ComparisonGroupBrainPF_GS, POINTER) returns tag of POINTER of ComparisonGroupBrainPF_GS.
			%  TAG = PF.GETPROPTAG(ComparisonGroupBrainPF_GS, POINTER) returns tag of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupBrainPF_GS.NODES
						tag = ComparisonGroupBrainPF_GS.NODES_TAG;
					otherwise
						tag = getPropTag@ComparisonGroupBrainPF(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupBrainPF_GS, POINTER) returns category of POINTER of ComparisonGroupBrainPF_GS.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonGroupBrainPF_GS, POINTER) returns category of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES
					prop_category = ComparisonGroupBrainPF_GS.NODES_CATEGORY;
				otherwise
					prop_category = getPropCategory@ComparisonGroupBrainPF(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupBrainPF_GS, POINTER) returns format of POINTER of ComparisonGroupBrainPF_GS.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonGroupBrainPF_GS, POINTER) returns format of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES
					prop_format = ComparisonGroupBrainPF_GS.NODES_FORMAT;
				otherwise
					prop_format = getPropFormat@ComparisonGroupBrainPF(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupBrainPF_GS, POINTER) returns description of POINTER of ComparisonGroupBrainPF_GS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonGroupBrainPF_GS, POINTER) returns description of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES
					prop_description = 'NODES (figure, rvector) are the node numbers of the global group comparison figure on brain surface.';
				case ComparisonGroupBrainPF_GS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroupBrainPF_GS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison on brain surface figure value and stores it.';
				otherwise
					prop_description = getPropDescription@ComparisonGroupBrainPF(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupBrainPF_GS, POINTER) returns settings of POINTER of ComparisonGroupBrainPF_GS.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonGroupBrainPF_GS, POINTER) returns settings of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ComparisonGroupBrainPF_GS.TEMPLATE
					prop_settings = 'ComparisonGroupBrainPF_GS';
				otherwise
					prop_settings = getPropSettings@ComparisonGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF_GS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF_GS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupBrainPF_GS, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF_GS.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonGroupBrainPF_GS, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES
					prop_default = Format.getFormatDefault(Format.RVECTOR, ComparisonGroupBrainPF_GS.getPropSettings(prop));
				case ComparisonGroupBrainPF_GS.ELCLASS
					prop_default = 'ComparisonGroupBrainPF_GS';
				case ComparisonGroupBrainPF_GS.NAME
					prop_default = 'ComparisonGroupBrainPF_GS';
				case ComparisonGroupBrainPF_GS.DESCRIPTION
					prop_default = 'ComparisonGroupBrainPF_GS manages the basic functionalities to plot of a global superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_GS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupBrainPF_GS.getPropSettings(prop));
				case ComparisonGroupBrainPF_GS.ID
					prop_default = 'ComparisonGroupBrainPF_GS ID';
				case ComparisonGroupBrainPF_GS.LABEL
					prop_default = 'ComparisonGroupBrainPF_GS label';
				case ComparisonGroupBrainPF_GS.NOTES
					prop_default = 'ComparisonGroupBrainPF_GS notes';
				otherwise
					prop_default = getPropDefault@ComparisonGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF_GS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF_GS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF_GS, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF_GS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF_GS, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			prop_default = ComparisonGroupBrainPF_GS.conditioning(prop, ComparisonGroupBrainPF_GS.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(ComparisonGroupBrainPF_GS, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF_GS.
			%  CHECK = PF.CHECKPROP(ComparisonGroupBrainPF_GS, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF_GS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_GS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_GS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupBrainPF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF_GS.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_GS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonGroupBrainPF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF_GS.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_GS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_GS.NODES % __ComparisonGroupBrainPF_GS.NODES__
					check = Format.checkFormat(Format.RVECTOR, value, ComparisonGroupBrainPF_GS.getPropSettings(prop));
				case ComparisonGroupBrainPF_GS.TEMPLATE % __ComparisonGroupBrainPF_GS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupBrainPF_GS.getPropSettings(prop));
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						check = checkProp@ComparisonGroupBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_GS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupBrainPF_GS.getPropTag(prop) ' (' ComparisonGroupBrainPF_GS.getFormatTag(ComparisonGroupBrainPF_GS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case ComparisonGroupBrainPF_GS.SETUP % __ComparisonGroupBrainPF_GS.SETUP__
					%%%__WARN_TBI__
					value = [];
					
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						value = calculateValue@ComparisonGroupBrainPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
