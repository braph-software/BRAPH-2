classdef AnalyzeEnsemble < ConcreteElement
	%AnalyzeEnsemble is a ensemble-based graph analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.
	% Instances of this class should not be created. Use one of its subclasses instead.
	%
	% AnalyzeEnsemble methods (constructor):
	%  AnalyzeEnsemble - constructor
	%
	% AnalyzeEnsemble methods:
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
	% AnalyzeEnsemble methods (display):
	%  tostring - string with information about the ensemble-based graph analysis
	%  disp - displays information about the ensemble-based graph analysis
	%  tree - displays the tree of the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ensemble-based graph analysis are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 ensemble-based graph analysis as b2 file
	%  load - loads a BRAPH2 ensemble-based graph analysis from a b2 file
	%
	% AnalyzeEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ensemble-based graph analysis
	%
	% AnalyzeEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (inspection, Static):
	%  getClass - returns the class of the ensemble-based graph analysis
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble
	%  getProps - returns the property list of the ensemble-based graph analysis
	%  getPropNumber - returns the property number of the ensemble-based graph analysis
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
	% AnalyzeEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble constants</a>.
	%
	%
	% See also CompareEnsemble.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		GR = ConcreteElement.getPropNumber() + 2;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		GRAPH_TEMPLATE = ConcreteElement.getPropNumber() + 3;
		GRAPH_TEMPLATE_TAG = 'GRAPH_TEMPLATE';
		GRAPH_TEMPLATE_CATEGORY = Category.PARAMETER;
		GRAPH_TEMPLATE_FORMAT = Format.ITEM;
		
		G_DICT = ConcreteElement.getPropNumber() + 4;
		G_DICT_TAG = 'G_DICT';
		G_DICT_CATEGORY = Category.RESULT;
		G_DICT_FORMAT = Format.IDICT;
		
		ME_DICT = ConcreteElement.getPropNumber() + 5;
		ME_DICT_TAG = 'ME_DICT';
		ME_DICT_CATEGORY = Category.RESULT;
		ME_DICT_FORMAT = Format.IDICT;
		
		MEASUREENSEMBLE = ConcreteElement.getPropNumber() + 6;
		MEASUREENSEMBLE_TAG = 'MEASUREENSEMBLE';
		MEASUREENSEMBLE_CATEGORY = Category.QUERY;
		MEASUREENSEMBLE_FORMAT = Format.ITEM;
	end
	methods % constructor
		function a = AnalyzeEnsemble(varargin)
			%AnalyzeEnsemble() creates a ensemble-based graph analysis.
			%
			% AnalyzeEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			a = a@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function a_class = getClass()
			%GETCLASS returns the class of the ensemble-based graph analysis.
			%
			% CLASS = AnalyzeEnsemble.GETCLASS() returns the class 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the ensemble-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble') returns 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ensemble-based graph analysis.
			%
			% LIST = AnalyzeEnsemble.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the ensemble-based graph analysis A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble') returns all subclasses of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeEnsemble', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based graph analysis.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS() returns the property list of ensemble-based graph analysis
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the ensemble-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						AnalyzeEnsemble.WAITBAR ...
						AnalyzeEnsemble.GR ...
						AnalyzeEnsemble.GRAPH_TEMPLATE ...
						AnalyzeEnsemble.G_DICT ...
						AnalyzeEnsemble.ME_DICT ...
						AnalyzeEnsemble.MEASUREENSEMBLE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						AnalyzeEnsemble.GRAPH_TEMPLATE ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						AnalyzeEnsemble.GR ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						AnalyzeEnsemble.G_DICT ...
						AnalyzeEnsemble.ME_DICT ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						AnalyzeEnsemble.MEASUREENSEMBLE ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						AnalyzeEnsemble.WAITBAR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ensemble-based graph analysis.
			%
			% N = AnalyzeEnsemble.GETPROPNUMBER() returns the property number of ensemble-based graph analysis.
			%
			% N = AnalyzeEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of ensemble-based graph analysis
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the ensemble-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble') returns the property number of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeEnsemble.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble, PROP) checks whether PROP exists for AnalyzeEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeEnsemble.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble, TAG) checks whether TAG exists for AnalyzeEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzeensemble_tag_list = cellfun(@(x) AnalyzeEnsemble.getPropTag(x), num2cell(AnalyzeEnsemble.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzeensemble_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzeensemble_tag_list = cellfun(@(x) AnalyzeEnsemble.getPropTag(x), num2cell(AnalyzeEnsemble.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzeensemble_tag_list)); % tag = pointer
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeEnsemble.WAITBAR
						tag = AnalyzeEnsemble.WAITBAR_TAG;
					case AnalyzeEnsemble.GR
						tag = AnalyzeEnsemble.GR_TAG;
					case AnalyzeEnsemble.GRAPH_TEMPLATE
						tag = AnalyzeEnsemble.GRAPH_TEMPLATE_TAG;
					case AnalyzeEnsemble.G_DICT
						tag = AnalyzeEnsemble.G_DICT_TAG;
					case AnalyzeEnsemble.ME_DICT
						tag = AnalyzeEnsemble.ME_DICT_TAG;
					case AnalyzeEnsemble.MEASUREENSEMBLE
						tag = AnalyzeEnsemble.MEASUREENSEMBLE_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR
					prop_category = AnalyzeEnsemble.WAITBAR_CATEGORY;
				case AnalyzeEnsemble.GR
					prop_category = AnalyzeEnsemble.GR_CATEGORY;
				case AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_category = AnalyzeEnsemble.GRAPH_TEMPLATE_CATEGORY;
				case AnalyzeEnsemble.G_DICT
					prop_category = AnalyzeEnsemble.G_DICT_CATEGORY;
				case AnalyzeEnsemble.ME_DICT
					prop_category = AnalyzeEnsemble.ME_DICT_CATEGORY;
				case AnalyzeEnsemble.MEASUREENSEMBLE
					prop_category = AnalyzeEnsemble.MEASUREENSEMBLE_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR
					prop_format = AnalyzeEnsemble.WAITBAR_FORMAT;
				case AnalyzeEnsemble.GR
					prop_format = AnalyzeEnsemble.GR_FORMAT;
				case AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_format = AnalyzeEnsemble.GRAPH_TEMPLATE_FORMAT;
				case AnalyzeEnsemble.G_DICT
					prop_format = AnalyzeEnsemble.G_DICT_FORMAT;
				case AnalyzeEnsemble.ME_DICT
					prop_format = AnalyzeEnsemble.ME_DICT_FORMAT;
				case AnalyzeEnsemble.MEASUREENSEMBLE
					prop_format = AnalyzeEnsemble.MEASUREENSEMBLE_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case AnalyzeEnsemble.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class.';
				case AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_description = 'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.';
				case AnalyzeEnsemble.G_DICT
					prop_description = 'G_DICT (result, idict) is the graph ensemble obtained from this analysis.';
				case AnalyzeEnsemble.ME_DICT
					prop_description = 'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.';
				case AnalyzeEnsemble.MEASUREENSEMBLE
					prop_description = 'MEASUREENSEMBLE (query, item) returns an ensemble-based measure.';
				case AnalyzeEnsemble.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeEnsemble.NAME
					prop_description = 'NAME (constant, string) is the name of the ensemble-based graph analysis.';
				case AnalyzeEnsemble.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis.';
				case AnalyzeEnsemble.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis.';
				case AnalyzeEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the ensemble-based graph analysis.';
				case AnalyzeEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ensemble-based graph analysis.';
				case AnalyzeEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case AnalyzeEnsemble.GR
					prop_settings = 'Group';
				case AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_settings = 'Graph';
				case AnalyzeEnsemble.G_DICT
					prop_settings = 'Graph';
				case AnalyzeEnsemble.ME_DICT
					prop_settings = 'MeasureEnsemble';
				case AnalyzeEnsemble.MEASUREENSEMBLE
					prop_settings = 'MeasureEnsemble';
				case AnalyzeEnsemble.TEMPLATE
					prop_settings = 'AnalyzeEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR
					prop_default = true;
				case AnalyzeEnsemble.GR
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.G_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ME_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.MEASUREENSEMBLE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ELCLASS
					prop_default = 'AnalyzeEnsemble';
				case AnalyzeEnsemble.NAME
					prop_default = 'AnalyzeEnsemble';
				case AnalyzeEnsemble.DESCRIPTION
					prop_default = 'AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses. Instances of this class should not be created. Use one of its subclasses instead.';
				case AnalyzeEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ID
					prop_default = 'AnalyzeEnsemble ID';
				case AnalyzeEnsemble.LABEL
					prop_default = 'AnalyzeEnsemble label';
				case AnalyzeEnsemble.NOTES
					prop_default = 'AnalyzeEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble.conditioning(prop, AnalyzeEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeEnsemble:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble:€BRAPH2.WRONG_INPUT€
			%  A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemble:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemble.WAITBAR % __AnalyzeEnsemble.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.GR % __AnalyzeEnsemble.GR__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.GRAPH_TEMPLATE % __AnalyzeEnsemble.GRAPH_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.G_DICT % __AnalyzeEnsemble.G_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.ME_DICT % __AnalyzeEnsemble.ME_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.MEASUREENSEMBLE % __AnalyzeEnsemble.MEASUREENSEMBLE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble.getPropSettings(prop));
				case AnalyzeEnsemble.TEMPLATE % __AnalyzeEnsemble.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemble.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble.getPropTag(prop) ' (' AnalyzeEnsemble.getFormatTag(AnalyzeEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(a, prop)
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
				case AnalyzeEnsemble.TEMPLATE % __AnalyzeEnsemble.TEMPLATE__
					a.postset@ConcreteElement(AnalyzeEnsemble.TEMPLATE)
					
					a.get('TEMPLATE').memorize('GRAPH_TEMPLATE')
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(a, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case AnalyzeEnsemble.G_DICT % __AnalyzeEnsemble.G_DICT__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeEnsemble.G_DICT), 'twister')
					
					a.memorize('GRAPH_TEMPLATE');
					value = IndexedDictionary('IT_CLASS', 'Graph');
					
					rng(rng_settings_)
					
				case AnalyzeEnsemble.ME_DICT % __AnalyzeEnsemble.ME_DICT__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeEnsemble.ME_DICT), 'twister')
					
					a.memorize('GRAPH_TEMPLATE');
					value = IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', MeasureEnsemble.MEASURE);
					
					rng(rng_settings_)
					
				case AnalyzeEnsemble.MEASUREENSEMBLE % __AnalyzeEnsemble.MEASUREENSEMBLE__
					% ME = a.get('MEASUREENSEMBLE', MEASURE_CLASS) checks whether the 
					%  measure ensemble exists in the property ME_DICT. If not it creates a new
					%  measure M of class MEASURE_CLASS with properties defined by the graph
					%  settings. The user must call getValue() for the new measure M to
					%  retrieve the value of measure ensemble ME.
					if isempty(varargin)
					    value = MeasureEnsemble();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     [BRAPH2.STR ':' class(a)], ...
					    %     [BRAPH2.STR ':' class(a) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using Analysis.get(''MEASUREENSEMBLE'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					m_list = a.memorize('GRAPH_TEMPLATE').get('COMPATIBLE_MEASURES');
					if ~contains(measure_class, m_list)
					    error(...
					        [BRAPH2.STR ':Analysis:' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':Analysis:' BRAPH2.WRONG_INPUT ' \n' ...
					        a.getClass() ' utilizes graphs of type ' a.memorize('GRAPH_TEMPLATE').getClass() '. \n' ...
					        measure_class ' is not a compatible Measure with ' a.memorize('GRAPH_TEMPLATE').getClass() '. \n' ...
					        'Use ' a.memorize('GRAPH_TEMPLATE').getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.'])
					end
					
					g_dict = a.memorize('G_DICT');
					for i = 1:1:g_dict.get('LENGTH')
					    g_dict.get('IT', i).memorize('A');
					end
					
					me_dict = a.memorize('ME_DICT');
					if me_dict.get('CONTAINS_KEY', measure_class)
					    me = me_dict.get('IT', measure_class);
					else
					    me = MeasureEnsemble( ...
					        'ID', measure_class, ...
					        'A', a, ...
					        'MEASURE', measure_class ... % % % 'MEASURE_TEMPLATE', a.memorize('GRAPH_TEMPLATE').get('MEASURE', measure_class) ...
					        );
					    
					    me_dict.get('ADD', me);
					end
					
					value = me;
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case AnalyzeEnsemble.GR % __AnalyzeEnsemble.GR__
					pr = PanelPropItem('EL', a, 'PROP', AnalyzeEnsemble.GR, ...
					    'BUTTON_TEXT', a.get('GR').get('ID'), ...
					    varargin{:});
					
				case AnalyzeEnsemble.GRAPH_TEMPLATE % __AnalyzeEnsemble.GRAPH_TEMPLATE__
					pr = PanelPropItem('EL', a, 'PROP', AnalyzeEnsemble.GRAPH_TEMPLATE, ...
					    'BUTTON_TEXT', ['GRAPH TEMPLATE (' a.get('GRAPH_TEMPLATE').getClass() ')'], ...
					    varargin{:});
					
				case AnalyzeEnsemble.G_DICT % __AnalyzeEnsemble.G_DICT__
					pr = AnalyzeEnsemblePP_GDict('EL', a, 'PROP', AnalyzeEnsemble.G_DICT, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				case AnalyzeEnsemble.ME_DICT % __AnalyzeEnsemble.ME_DICT__
					pr = AnalyzeEnsemblePP_MeDict('EL', a, 'PROP', AnalyzeEnsemble.ME_DICT, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(a, prop, varargin{:});
					
			end
		end
	end
end
