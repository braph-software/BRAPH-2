classdef MeasureEnsemble < ConcreteElement
	%MeasureEnsemble is a graph ensemble measure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% MeasureEnsemble provides the methods necessary for a graph ensemble measure.
	%
	% MeasureEnsemble methods (constructor):
	%  MeasureEnsemble - constructor
	%
	% MeasureEnsemble methods:
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
	% MeasureEnsemble methods (display):
	%  tostring - string with information about the graph ensemble measure
	%  disp - displays information about the graph ensemble measure
	%  tree - displays the tree of the graph ensemble measure
	%
	% MeasureEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph ensemble measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph ensemble measure
	%
	% MeasureEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 graph ensemble measure as b2 file
	%  load - loads a BRAPH2 graph ensemble measure from a b2 file
	%
	% MeasureEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph ensemble measure
	%
	% MeasureEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph ensemble measure
	%
	% MeasureEnsemble methods (inspection, Static):
	%  getClass - returns the class of the graph ensemble measure
	%  getSubclasses - returns all subclasses of MeasureEnsemble
	%  getProps - returns the property list of the graph ensemble measure
	%  getPropNumber - returns the property number of the graph ensemble measure
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
	% MeasureEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemble constants</a>.
	%
	%
	% See also AnalyzeEnsemble, CompareEnsemble.
	
	properties (Constant) % properties
		MEASURE = ConcreteElement.getPropNumber() + 1;
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = Category.DATA;
		MEASURE_FORMAT = Format.CLASS;
		
		A = ConcreteElement.getPropNumber() + 2;
		A_TAG = 'A';
		A_CATEGORY = Category.DATA;
		A_FORMAT = Format.ITEM;
		
		M = ConcreteElement.getPropNumber() + 3;
		M_TAG = 'M';
		M_CATEGORY = Category.RESULT;
		M_FORMAT = Format.CELL;
		
		PFME = ConcreteElement.getPropNumber() + 4;
		PFME_TAG = 'PFME';
		PFME_CATEGORY = Category.GUI;
		PFME_FORMAT = Format.ITEM;
		
		PFBG = ConcreteElement.getPropNumber() + 5;
		PFBG_TAG = 'PFBG';
		PFBG_CATEGORY = Category.GUI;
		PFBG_FORMAT = Format.ITEM;
	end
	methods % constructor
		function me = MeasureEnsemble(varargin)
			%MeasureEnsemble() creates a graph ensemble measure.
			%
			% MeasureEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			me = me@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function me_class = getClass()
			%GETCLASS returns the class of the graph ensemble measure.
			%
			% CLASS = MeasureEnsemble.GETCLASS() returns the class 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ME.GETCLASS() returns the class of the graph ensemble measure ME.
			%  CLASS = Element.GETCLASS(ME) returns the class of 'ME'.
			%  CLASS = Element.GETCLASS('MeasureEnsemble') returns 'MeasureEnsemble'.
			%
			% Note that the Element.GETCLASS(ME) and Element.GETCLASS('MeasureEnsemble')
			%  are less computationally efficient.
			
			me_class = 'MeasureEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph ensemble measure.
			%
			% LIST = MeasureEnsemble.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = ME.GETSUBCLASSES() returns all subclasses of the graph ensemble measure ME.
			%  LIST = Element.GETSUBCLASSES(ME) returns all subclasses of 'ME'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemble') returns all subclasses of 'MeasureEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(ME) and Element.GETSUBCLASSES('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsemble', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph ensemble measure.
			%
			% PROPS = MeasureEnsemble.GETPROPS() returns the property list of graph ensemble measure
			%  as a row vector.
			%
			% PROPS = MeasureEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ME.GETPROPS([CATEGORY]) returns the property list of the graph ensemble measure ME.
			%  PROPS = Element.GETPROPS(ME[, CATEGORY]) returns the property list of 'ME'.
			%  PROPS = Element.GETPROPS('MeasureEnsemble'[, CATEGORY]) returns the property list of 'MeasureEnsemble'.
			%
			% Note that the Element.GETPROPS(ME) and Element.GETPROPS('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						MeasureEnsemble.MEASURE ...
						MeasureEnsemble.A ...
						MeasureEnsemble.M ...
						MeasureEnsemble.PFME ...
						MeasureEnsemble.PFBG ...
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
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						MeasureEnsemble.MEASURE ...
						MeasureEnsemble.A ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						MeasureEnsemble.M ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
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
						MeasureEnsemble.PFME ...
						MeasureEnsemble.PFBG ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph ensemble measure.
			%
			% N = MeasureEnsemble.GETPROPNUMBER() returns the property number of graph ensemble measure.
			%
			% N = MeasureEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of graph ensemble measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ME.GETPROPNUMBER([CATEGORY]) returns the property number of the graph ensemble measure ME.
			%  N = Element.GETPROPNUMBER(ME) returns the property number of 'ME'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemble') returns the property number of 'MeasureEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(ME) and Element.GETPROPNUMBER('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsemble.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSPROP(PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(ME, PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemble, PROP) checks whether PROP exists for MeasureEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSPROP(PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(ME, PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemble, PROP) throws error if PROP does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ME) and Element.EXISTSPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsemble.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSTAG(TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(ME, TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemble, TAG) checks whether TAG exists for MeasureEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSTAG(TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(ME, TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemble, TAG) throws error if TAG does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ME) and Element.EXISTSTAG('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemble_tag_list = cellfun(@(x) MeasureEnsemble.getPropTag(x), num2cell(MeasureEnsemble.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemble_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemble.'] ...
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
			%  PROPERTY = ME.GETPROPPROP(POINTER) returns property number of POINTER of ME.
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%  PROPERTY = ME.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPPROP(ME) and Element.GETPROPPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemble_tag_list = cellfun(@(x) MeasureEnsemble.getPropTag(x), num2cell(MeasureEnsemble.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemble_tag_list)); % tag = pointer
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
			%  TAG = ME.GETPROPTAG(POINTER) returns tag of POINTER of ME.
			%  TAG = Element.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%  TAG = ME.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPTAG(ME) and Element.GETPROPTAG('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsemble.MEASURE
						tag = MeasureEnsemble.MEASURE_TAG;
					case MeasureEnsemble.A
						tag = MeasureEnsemble.A_TAG;
					case MeasureEnsemble.M
						tag = MeasureEnsemble.M_TAG;
					case MeasureEnsemble.PFME
						tag = MeasureEnsemble.PFME_TAG;
					case MeasureEnsemble.PFBG
						tag = MeasureEnsemble.PFBG_TAG;
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
			%  CATEGORY = ME.GETPROPCATEGORY(POINTER) returns category of POINTER of ME.
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%  CATEGORY = ME.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(ME) and Element.GETPROPCATEGORY('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE
					prop_category = MeasureEnsemble.MEASURE_CATEGORY;
				case MeasureEnsemble.A
					prop_category = MeasureEnsemble.A_CATEGORY;
				case MeasureEnsemble.M
					prop_category = MeasureEnsemble.M_CATEGORY;
				case MeasureEnsemble.PFME
					prop_category = MeasureEnsemble.PFME_CATEGORY;
				case MeasureEnsemble.PFBG
					prop_category = MeasureEnsemble.PFBG_CATEGORY;
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
			%  FORMAT = ME.GETPROPFORMAT(POINTER) returns format of POINTER of ME.
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%  FORMAT = ME.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(ME) and Element.GETPROPFORMAT('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE
					prop_format = MeasureEnsemble.MEASURE_FORMAT;
				case MeasureEnsemble.A
					prop_format = MeasureEnsemble.A_FORMAT;
				case MeasureEnsemble.M
					prop_format = MeasureEnsemble.M_FORMAT;
				case MeasureEnsemble.PFME
					prop_format = MeasureEnsemble.PFME_FORMAT;
				case MeasureEnsemble.PFBG
					prop_format = MeasureEnsemble.PFBG_FORMAT;
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
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ME.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(ME) and Element.GETPROPDESCRIPTION('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE
					prop_description = 'MEASURE (data, class) is the measure class.';
				case MeasureEnsemble.A
					prop_description = 'A (data, item) is the ensemble-based graph analysis.';
				case MeasureEnsemble.M
					prop_description = 'M (result, cell) is the measure group-average result.';
				case MeasureEnsemble.PFME
					prop_description = 'PFME (gui, item) contains the panel figure of the measure.';
				case MeasureEnsemble.PFBG
					prop_description = 'PFBG (gui, item) contains the panel figure of the brain graph.';
				case MeasureEnsemble.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MeasureEnsemble.NAME
					prop_description = 'NAME (constant, string) is the name of the graph ensemble measure.';
				case MeasureEnsemble.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph ensemble measure.';
				case MeasureEnsemble.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph ensemble measure.';
				case MeasureEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph ensemble measure.';
				case MeasureEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph ensemble measure.';
				case MeasureEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph ensemble measure.';
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
			%  SETTINGS = ME.GETPROPSETTINGS(POINTER) returns settings of POINTER of ME.
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%  SETTINGS = ME.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(ME) and Element.GETPROPSETTINGS('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE
					prop_settings = 'Measure';
				case MeasureEnsemble.A
					prop_settings = 'AnalyzeEnsemble';
				case MeasureEnsemble.M
					prop_settings = Format.getFormatSettings(Format.CELL);
				case MeasureEnsemble.PFME
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case MeasureEnsemble.PFBG
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case MeasureEnsemble.TEMPLATE
					prop_settings = 'MeasureEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(ME) and Element.GETPROPDEFAULT('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE
					prop_default = Format.getFormatDefault(Format.CLASS, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.A
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.M
					prop_default = Format.getFormatDefault(Format.CELL, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.PFME
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.PFBG
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.ELCLASS
					prop_default = 'MeasureEnsemble';
				case MeasureEnsemble.NAME
					prop_default = 'MeasureEnsemble';
				case MeasureEnsemble.DESCRIPTION
					prop_default = 'MeasureEnsemble provides the methods necessary for a graph ensemble measure.';
				case MeasureEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.ID
					prop_default = 'MeasureEnsemble ID';
				case MeasureEnsemble.LABEL
					prop_default = 'MeasureEnsemble label';
				case MeasureEnsemble.NOTES
					prop_default = 'MeasureEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ME) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			prop_default = MeasureEnsemble.conditioning(prop, MeasureEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ME.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ME.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ME.
			%  CHECK = Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			%  CHECK = ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			% 
			% ME.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsemble:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ME.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ME.
			%   Error id: €BRAPH2.STR€:MeasureEnsemble:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: €BRAPH2.STR€:MeasureEnsemble:€BRAPH2.WRONG_INPUT€
			%  ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: €BRAPH2.STR€:MeasureEnsemble:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ME) and Element.CHECKPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemble.MEASURE % __MeasureEnsemble.MEASURE__
					check = Format.checkFormat(Format.CLASS, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.A % __MeasureEnsemble.A__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.M % __MeasureEnsemble.M__
					check = Format.checkFormat(Format.CELL, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.PFME % __MeasureEnsemble.PFME__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.PFBG % __MeasureEnsemble.PFBG__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				case MeasureEnsemble.TEMPLATE % __MeasureEnsemble.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemble.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemble.getPropTag(prop) ' (' MeasureEnsemble.getFormatTag(MeasureEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(me, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case MeasureEnsemble.PFME % __MeasureEnsemble.PFME__
					if isa(me.getr('PFME'), 'NoValue')
					
					    measure = me.get('MEASURE');
					
					    switch Element.getPropDefault(measure, 'SHAPE')
					        case Measure.GLOBAL % __Measure.GLOBAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    me.set('PFME', MeasureEnsemblePF_GS('ME', me))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    me.set('PFME', MeasureEnsemblePF_GU('ME', me))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    me.set('PFME', MeasureEnsemblePF_GB('ME', me))
					            end
					        case Measure.NODAL % __Measure.NODAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    me.set('PFME', MeasureEnsemblePF_NS('ME', me))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    me.set('PFME', MeasureEnsemblePF_NU('ME', me))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    me.set('PFME', MeasureEnsemblePF_NB('ME', me))
					            end
					        case Measure.BINODAL % __Measure.BINODAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    me.set('PFME', MeasureEnsemblePF_BS('ME', me))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    me.set('PFME', MeasureEnsemblePF_BU('ME', me))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    me.set('PFME', MeasureEnsemblePF_BB('ME', me))
					            end
					    end
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(me, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(me, prop, varargin)
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
				case MeasureEnsemble.M % __MeasureEnsemble.M__
					rng_settings_ = rng(); rng(me.getPropSeed(MeasureEnsemble.M), 'twister')
					
					m_list = cellfun(@(x) x.get('MEASURE', me.get('MEASURE')).get('M'), me.get('A').get('G_DICT').get('IT_LIST'), 'UniformOutput', false);
					
					if isempty(m_list)
					    m_av = {};
					else
					    m_av = cell(size(m_list{1}));
					    for i = 1:1:size(m_list{1}, 1)
					        for j = 1:1:size(m_list{1}, 2)
					            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
					            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
					        end
					    end
					end
					
					value = m_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(me, prop, varargin{:});
					else
						value = calculateValue@Element(me, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(me, prop, varargin)
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
				case MeasureEnsemble.M % __MeasureEnsemble.M__
					if me.get('A').get('G_DICT').get('LENGTH')
					    g = me.get('A').get('G_DICT').get('IT', 1);
					else
					    g = me.get('A').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					
					measure = me.get('MEASURE');
					
					pr = PanelPropCell('EL', me, 'PROP', MeasureEnsemble.M, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', s(5) ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case MeasureEnsemble.PFME % __MeasureEnsemble.PFME__
					pr = PanelPropItem('EL', me, 'PROP', MeasureEnsemble.PFME, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' me.get('MEASURE') ' Ensemble'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(me, prop, varargin{:});
					
			end
		end
	end
end
