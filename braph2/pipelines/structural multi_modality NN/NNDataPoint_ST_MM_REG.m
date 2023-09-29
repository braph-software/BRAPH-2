classdef NNDataPoint_ST_MM_REG < NNDataPoint
	%NNDataPoint_ST_MM_REG is a data point for regression with structural multimodality data.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) 
	%  contains the input and target for neural network analysis with a subject 
	%  with structural multiplex data (SubjectST_MP).
	% The input is the structural multiplex data of the subject.
	% The target is obtained from the variables of interest of the subject.
	%
	% NNDataPoint_ST_MM_REG methods (constructor):
	%  NNDataPoint_ST_MM_REG - constructor
	%
	% NNDataPoint_ST_MM_REG methods:
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
	% NNDataPoint_ST_MM_REG methods (display):
	%  tostring - string with information about the structural multimodality regression data point
	%  disp - displays information about the structural multimodality regression data point
	%  tree - displays the tree of the structural multimodality regression data point
	%
	% NNDataPoint_ST_MM_REG methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two structural multimodality regression data point are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the structural multimodality regression data point
	%
	% NNDataPoint_ST_MM_REG methods (save/load, Static):
	%  save - saves BRAPH2 structural multimodality regression data point as b2 file
	%  load - loads a BRAPH2 structural multimodality regression data point from a b2 file
	%
	% NNDataPoint_ST_MM_REG method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the structural multimodality regression data point
	%
	% NNDataPoint_ST_MM_REG method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the structural multimodality regression data point
	%
	% NNDataPoint_ST_MM_REG methods (inspection, Static):
	%  getClass - returns the class of the structural multimodality regression data point
	%  getSubclasses - returns all subclasses of NNDataPoint_ST_MM_REG
	%  getProps - returns the property list of the structural multimodality regression data point
	%  getPropNumber - returns the property number of the structural multimodality regression data point
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
	% NNDataPoint_ST_MM_REG methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint_ST_MM_REG methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint_ST_MM_REG methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint_ST_MM_REG methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint_ST_MM_REG; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint_ST_MM_REG constants</a>.
	%
	%
	% See also SubjectST_MP.
	
	properties (Constant) % properties
		SUB = NNDataPoint.getPropNumber() + 1;
		SUB_TAG = 'SUB';
		SUB_CATEGORY = Category.DATA;
		SUB_FORMAT = Format.ITEM;
		
		TARGET_IDS = NNDataPoint.getPropNumber() + 2;
		TARGET_IDS_TAG = 'TARGET_IDS';
		TARGET_IDS_CATEGORY = Category.PARAMETER;
		TARGET_IDS_FORMAT = Format.STRINGLIST;
	end
	methods % constructor
		function dp = NNDataPoint_ST_MM_REG(varargin)
			%NNDataPoint_ST_MM_REG() creates a structural multimodality regression data point.
			%
			% NNDataPoint_ST_MM_REG(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint_ST_MM_REG(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function dp_class = getClass()
			%GETCLASS returns the class of the structural multimodality regression data point.
			%
			% CLASS = NNDataPoint_ST_MM_REG.GETCLASS() returns the class 'NNDataPoint_ST_MM_REG'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the structural multimodality regression data point DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint_ST_MM_REG') returns 'NNDataPoint_ST_MM_REG'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint_ST_MM_REG';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the structural multimodality regression data point.
			%
			% LIST = NNDataPoint_ST_MM_REG.GETSUBCLASSES() returns all subclasses of 'NNDataPoint_ST_MM_REG'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the structural multimodality regression data point DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint_ST_MM_REG') returns all subclasses of 'NNDataPoint_ST_MM_REG'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDataPoint_ST_MM_REG', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of structural multimodality regression data point.
			%
			% PROPS = NNDataPoint_ST_MM_REG.GETPROPS() returns the property list of structural multimodality regression data point
			%  as a row vector.
			%
			% PROPS = NNDataPoint_ST_MM_REG.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the structural multimodality regression data point DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint_ST_MM_REG'[, CATEGORY]) returns the property list of 'NNDataPoint_ST_MM_REG'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNDataPoint.getProps() ...
						NNDataPoint_ST_MM_REG.SUB ...
						NNDataPoint_ST_MM_REG.TARGET_IDS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNDataPoint.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNDataPoint.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNDataPoint.getProps(Category.PARAMETER) ...
						NNDataPoint_ST_MM_REG.TARGET_IDS ...
						];
				case Category.DATA
					prop_list = [ ...
						NNDataPoint.getProps(Category.DATA) ...
						NNDataPoint_ST_MM_REG.SUB ...
						];
				case Category.RESULT
					prop_list = [
						NNDataPoint.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNDataPoint.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNDataPoint.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNDataPoint.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNDataPoint.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of structural multimodality regression data point.
			%
			% N = NNDataPoint_ST_MM_REG.GETPROPNUMBER() returns the property number of structural multimodality regression data point.
			%
			% N = NNDataPoint_ST_MM_REG.GETPROPNUMBER(CATEGORY) returns the property number of structural multimodality regression data point
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the structural multimodality regression data point DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint_ST_MM_REG') returns the property number of 'NNDataPoint_ST_MM_REG'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDataPoint_ST_MM_REG.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in structural multimodality regression data point/error.
			%
			% CHECK = NNDataPoint_ST_MM_REG.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint_ST_MM_REG, PROP) checks whether PROP exists for NNDataPoint_ST_MM_REG.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint_ST_MM_REG, PROP) throws error if PROP does NOT exist for NNDataPoint_ST_MM_REG.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDataPoint_ST_MM_REG.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint_ST_MM_REG.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in structural multimodality regression data point/error.
			%
			% CHECK = NNDataPoint_ST_MM_REG.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint_ST_MM_REG, TAG) checks whether TAG exists for NNDataPoint_ST_MM_REG.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint_ST_MM_REG, TAG) throws error if TAG does NOT exist for NNDataPoint_ST_MM_REG.
			%   Error id: [BRAPH2:NNDataPoint_ST_MM_REG:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndatapoint_st_mm_reg_tag_list = cellfun(@(x) NNDataPoint_ST_MM_REG.getPropTag(x), num2cell(NNDataPoint_ST_MM_REG.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndatapoint_st_mm_reg_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint_ST_MM_REG.'] ...
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
			%  PROPERTY = DP.GETPROPPROP(POINTER) returns property number of POINTER of DP.
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint_ST_MM_REG, POINTER) returns property number of POINTER of NNDataPoint_ST_MM_REG.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint_ST_MM_REG, POINTER) returns property number of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndatapoint_st_mm_reg_tag_list = cellfun(@(x) NNDataPoint_ST_MM_REG.getPropTag(x), num2cell(NNDataPoint_ST_MM_REG.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndatapoint_st_mm_reg_tag_list)); % tag = pointer
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
			%  TAG = DP.GETPROPTAG(POINTER) returns tag of POINTER of DP.
			%  TAG = Element.GETPROPTAG(NNDataPoint_ST_MM_REG, POINTER) returns tag of POINTER of NNDataPoint_ST_MM_REG.
			%  TAG = DP.GETPROPTAG(NNDataPoint_ST_MM_REG, POINTER) returns tag of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDataPoint_ST_MM_REG.SUB
						tag = NNDataPoint_ST_MM_REG.SUB_TAG;
					case NNDataPoint_ST_MM_REG.TARGET_IDS
						tag = NNDataPoint_ST_MM_REG.TARGET_IDS_TAG;
					otherwise
						tag = getPropTag@NNDataPoint(prop);
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
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint_ST_MM_REG, POINTER) returns category of POINTER of NNDataPoint_ST_MM_REG.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint_ST_MM_REG, POINTER) returns category of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB
					prop_category = NNDataPoint_ST_MM_REG.SUB_CATEGORY;
				case NNDataPoint_ST_MM_REG.TARGET_IDS
					prop_category = NNDataPoint_ST_MM_REG.TARGET_IDS_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNDataPoint(prop);
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
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint_ST_MM_REG, POINTER) returns format of POINTER of NNDataPoint_ST_MM_REG.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint_ST_MM_REG, POINTER) returns format of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB
					prop_format = NNDataPoint_ST_MM_REG.SUB_FORMAT;
				case NNDataPoint_ST_MM_REG.TARGET_IDS
					prop_format = NNDataPoint_ST_MM_REG.TARGET_IDS_FORMAT;
				otherwise
					prop_format = getPropFormat@NNDataPoint(prop);
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
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint_ST_MM_REG, POINTER) returns description of POINTER of NNDataPoint_ST_MM_REG.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint_ST_MM_REG, POINTER) returns description of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB
					prop_description = 'SUB (data, item) is a subject with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.TARGET_IDS
					prop_description = 'TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.';
				case NNDataPoint_ST_MM_REG.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNDataPoint_ST_MM_REG.NAME
					prop_description = 'NAME (constant, string) is the name of a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.ID
					prop_description = 'ID (data, string) is a few-letter code for a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about a data point for regression with structural multimodality data.';
				case NNDataPoint_ST_MM_REG.INPUT
					prop_description = 'INPUT (result, cell) is the input value for this data point.';
				case NNDataPoint_ST_MM_REG.TARGET
					prop_description = 'TARGET (result, cell) is the target value for this data point.';
				otherwise
					prop_description = getPropDescription@NNDataPoint(prop);
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
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint_ST_MM_REG, POINTER) returns settings of POINTER of NNDataPoint_ST_MM_REG.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint_ST_MM_REG, POINTER) returns settings of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB
					prop_settings = 'SubjectST_MP';
				case NNDataPoint_ST_MM_REG.TARGET_IDS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNDataPoint_ST_MM_REG.TEMPLATE
					prop_settings = 'NNDataPoint_ST_MM_REG';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint_ST_MM_REG.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_ST_MM_REG.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint_ST_MM_REG, POINTER) returns the default value of POINTER of NNDataPoint_ST_MM_REG.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint_ST_MM_REG, POINTER) returns the default value of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				case NNDataPoint_ST_MM_REG.TARGET_IDS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				case NNDataPoint_ST_MM_REG.ELCLASS
					prop_default = 'NNDataPoint_ST_MM_REG';
				case NNDataPoint_ST_MM_REG.NAME
					prop_default = 'NNDataPoint_ST_MM_REG';
				case NNDataPoint_ST_MM_REG.DESCRIPTION
					prop_default = 'A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) contains the input and target for neural network analysis with a subject with structural multiplex data (SubjectST_MP). The input is the structural multiplex data of the subject. The target is obtained from the variables of interest of the subject.';
				case NNDataPoint_ST_MM_REG.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				case NNDataPoint_ST_MM_REG.ID
					prop_default = 'NNDataPoint_ST_MM_REG ID';
				case NNDataPoint_ST_MM_REG.LABEL
					prop_default = 'NNDataPoint_ST_MM_REG label';
				case NNDataPoint_ST_MM_REG.NOTES
					prop_default = 'NNDataPoint_ST_MM_REG notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint_ST_MM_REG.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_ST_MM_REG.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint_ST_MM_REG, POINTER) returns the conditioned default value of POINTER of NNDataPoint_ST_MM_REG.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint_ST_MM_REG, POINTER) returns the conditioned default value of POINTER of NNDataPoint_ST_MM_REG.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			prop_default = NNDataPoint_ST_MM_REG.conditioning(prop, NNDataPoint_ST_MM_REG.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DP.
			%  CHECK = Element.CHECKPROP(NNDataPoint_ST_MM_REG, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_ST_MM_REG.
			%  CHECK = DP.CHECKPROP(NNDataPoint_ST_MM_REG, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_ST_MM_REG.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDataPoint_ST_MM_REG:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: €BRAPH2.STR€:NNDataPoint_ST_MM_REG:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDataPoint_ST_MM_REG, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_ST_MM_REG.
			%   Error id: €BRAPH2.STR€:NNDataPoint_ST_MM_REG:€BRAPH2.WRONG_INPUT€
			%  DP.CHECKPROP(NNDataPoint_ST_MM_REG, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_ST_MM_REG.
			%   Error id: €BRAPH2.STR€:NNDataPoint_ST_MM_REG:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint_ST_MM_REG')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint_ST_MM_REG.getPropProp(pointer);
			
			switch prop
				case NNDataPoint_ST_MM_REG.SUB % __NNDataPoint_ST_MM_REG.SUB__
					check = Format.checkFormat(Format.ITEM, value, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				case NNDataPoint_ST_MM_REG.TARGET_IDS % __NNDataPoint_ST_MM_REG.TARGET_IDS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				case NNDataPoint_ST_MM_REG.TEMPLATE % __NNDataPoint_ST_MM_REG.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDataPoint_ST_MM_REG.getPropSettings(prop));
				otherwise
					if prop <= NNDataPoint.getPropNumber()
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint_ST_MM_REG.getPropTag(prop) ' (' NNDataPoint_ST_MM_REG.getFormatTag(NNDataPoint_ST_MM_REG.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dp, prop, varargin)
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
				case NNDataPoint_ST_MM_REG.INPUT % __NNDataPoint_ST_MM_REG.INPUT__
					rng_settings_ = rng(); rng(dp.getPropSeed(NNDataPoint_ST_MM_REG.INPUT), 'twister')
					
					value = dp.get('SUB').get('ST_MP');
					
					rng(rng_settings_)
					
				case NNDataPoint_ST_MM_REG.TARGET % __NNDataPoint_ST_MM_REG.TARGET__
					rng_settings_ = rng(); rng(dp.getPropSeed(NNDataPoint_ST_MM_REG.TARGET), 'twister')
					
					value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNDataPoint.getPropNumber()
						value = calculateValue@NNDataPoint(dp, prop, varargin{:});
					else
						value = calculateValue@Element(dp, prop, varargin{:});
					end
			end
			
		end
	end
end
