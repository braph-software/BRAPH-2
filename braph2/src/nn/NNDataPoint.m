classdef NNDataPoint < ConcreteElement
	%NNDataPoint is a data point for neural network analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network data point (NNDataPoint) contains a data point with its inputs and targets for neural network analysis.
	% Instances of this class should not be created. Use one of its subclasses instead.
	% Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.
	%
	% NNDataPoint methods (constructor):
	%  NNDataPoint - constructor
	%
	% NNDataPoint methods:
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
	% NNDataPoint methods (display):
	%  tostring - string with information about the neural network data point
	%  disp - displays information about the neural network data point
	%  tree - displays the tree of the neural network data point
	%
	% NNDataPoint methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network data point are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network data point
	%
	% NNDataPoint methods (save/load, Static):
	%  save - saves BRAPH2 neural network data point as b2 file
	%  load - loads a BRAPH2 neural network data point from a b2 file
	%
	% NNDataPoint method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network data point
	%
	% NNDataPoint method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network data point
	%
	% NNDataPoint methods (inspection, Static):
	%  getClass - returns the class of the neural network data point
	%  getSubclasses - returns all subclasses of NNDataPoint
	%  getProps - returns the property list of the neural network data point
	%  getPropNumber - returns the property number of the neural network data point
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
	% NNDataPoint methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint constants</a>.
	%
	%
	% See also NNData.
	
	properties (Constant) % properties
		INPUT = ConcreteElement.getPropNumber() + 1;
		INPUT_TAG = 'INPUT';
		INPUT_CATEGORY = Category.RESULT;
		INPUT_FORMAT = Format.CELL;
		
		TARGET = ConcreteElement.getPropNumber() + 2;
		TARGET_TAG = 'TARGET';
		TARGET_CATEGORY = Category.RESULT;
		TARGET_FORMAT = Format.CELL;
	end
	methods % constructor
		function dp = NNDataPoint(varargin)
			%NNDataPoint() creates a neural network data point.
			%
			% NNDataPoint(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			dp = dp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function dp_class = getClass()
			%GETCLASS returns the class of the neural network data point.
			%
			% CLASS = NNDataPoint.GETCLASS() returns the class 'NNDataPoint'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the neural network data point DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint') returns 'NNDataPoint'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network data point.
			%
			% LIST = NNDataPoint.GETSUBCLASSES() returns all subclasses of 'NNDataPoint'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the neural network data point DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint') returns all subclasses of 'NNDataPoint'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNDataPoint', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network data point.
			%
			% PROPS = NNDataPoint.GETPROPS() returns the property list of neural network data point
			%  as a row vector.
			%
			% PROPS = NNDataPoint.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the neural network data point DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint'[, CATEGORY]) returns the property list of 'NNDataPoint'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNDataPoint.INPUT ...
						NNDataPoint.TARGET ...
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
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNDataPoint.INPUT ...
						NNDataPoint.TARGET ...
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
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network data point.
			%
			% N = NNDataPoint.GETPROPNUMBER() returns the property number of neural network data point.
			%
			% N = NNDataPoint.GETPROPNUMBER(CATEGORY) returns the property number of neural network data point
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network data point DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint') returns the property number of 'NNDataPoint'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNDataPoint.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network data point/error.
			%
			% CHECK = NNDataPoint.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint, PROP) checks whether PROP exists for NNDataPoint.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint, PROP) throws error if PROP does NOT exist for NNDataPoint.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNDataPoint.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network data point/error.
			%
			% CHECK = NNDataPoint.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint, TAG) checks whether TAG exists for NNDataPoint.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint, TAG) throws error if TAG does NOT exist for NNDataPoint.
			%   Error id: [BRAPH2:NNDataPoint:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nndatapoint_tag_list = cellfun(@(x) NNDataPoint.getPropTag(x), num2cell(NNDataPoint.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nndatapoint_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint, POINTER) returns property number of POINTER of NNDataPoint.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint, POINTER) returns property number of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nndatapoint_tag_list = cellfun(@(x) NNDataPoint.getPropTag(x), num2cell(NNDataPoint.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nndatapoint_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNDataPoint, POINTER) returns tag of POINTER of NNDataPoint.
			%  TAG = DP.GETPROPTAG(NNDataPoint, POINTER) returns tag of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNDataPoint.INPUT
						tag = NNDataPoint.INPUT_TAG;
					case NNDataPoint.TARGET
						tag = NNDataPoint.TARGET_TAG;
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
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint, POINTER) returns category of POINTER of NNDataPoint.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint, POINTER) returns category of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT
					prop_category = NNDataPoint.INPUT_CATEGORY;
				case NNDataPoint.TARGET
					prop_category = NNDataPoint.TARGET_CATEGORY;
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
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint, POINTER) returns format of POINTER of NNDataPoint.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint, POINTER) returns format of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT
					prop_format = NNDataPoint.INPUT_FORMAT;
				case NNDataPoint.TARGET
					prop_format = NNDataPoint.TARGET_FORMAT;
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
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint, POINTER) returns description of POINTER of NNDataPoint.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint, POINTER) returns description of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT
					prop_description = 'INPUT (result, cell) is the input value for this data point.';
				case NNDataPoint.TARGET
					prop_description = 'TARGET (result, cell) is the target value for this data point.';
				case NNDataPoint.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNDataPoint.NAME
					prop_description = 'NAME (constant, string) is the name of the data point for neural network analysis.';
				case NNDataPoint.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the data point for neural network analysis.';
				case NNDataPoint.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the data point for neural network analysis.';
				case NNDataPoint.ID
					prop_description = 'ID (data, string) is a few-letter code for the data point for neural network analysis.';
				case NNDataPoint.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the data point for neural network analysis.';
				case NNDataPoint.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the data point for neural network analysis.';
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
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint, POINTER) returns settings of POINTER of NNDataPoint.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint, POINTER) returns settings of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataPoint.TARGET
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNDataPoint.TEMPLATE
					prop_settings = 'NNDataPoint';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint, POINTER) returns the default value of POINTER of NNDataPoint.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint, POINTER) returns the default value of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT
					prop_default = Format.getFormatDefault(Format.CELL, NNDataPoint.getPropSettings(prop));
				case NNDataPoint.TARGET
					prop_default = Format.getFormatDefault(Format.CELL, NNDataPoint.getPropSettings(prop));
				case NNDataPoint.ELCLASS
					prop_default = 'NNDataPoint';
				case NNDataPoint.NAME
					prop_default = 'NNDataPoint';
				case NNDataPoint.DESCRIPTION
					prop_default = 'A neural network data point (NNDataPoint) contains a data point with its inputs and targets for neural network analysis. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.';
				case NNDataPoint.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNDataPoint.getPropSettings(prop));
				case NNDataPoint.ID
					prop_default = 'NNDataPoint ID';
				case NNDataPoint.LABEL
					prop_default = 'NNDataPoint label';
				case NNDataPoint.NOTES
					prop_default = 'NNDataPoint notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint, POINTER) returns the conditioned default value of POINTER of NNDataPoint.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint, POINTER) returns the conditioned default value of POINTER of NNDataPoint.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			prop_default = NNDataPoint.conditioning(prop, NNDataPoint.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNDataPoint, PROP, VALUE) checks VALUE format for PROP of NNDataPoint.
			%  CHECK = DP.CHECKPROP(NNDataPoint, PROP, VALUE) checks VALUE format for PROP of NNDataPoint.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNDataPoint:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: €BRAPH2.STR€:NNDataPoint:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNDataPoint, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint.
			%   Error id: €BRAPH2.STR€:NNDataPoint:€BRAPH2.WRONG_INPUT€
			%  DP.CHECKPROP(NNDataPoint, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint.
			%   Error id: €BRAPH2.STR€:NNDataPoint:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint.getPropProp(pointer);
			
			switch prop
				case NNDataPoint.INPUT % __NNDataPoint.INPUT__
					check = Format.checkFormat(Format.CELL, value, NNDataPoint.getPropSettings(prop));
				case NNDataPoint.TARGET % __NNDataPoint.TARGET__
					check = Format.checkFormat(Format.CELL, value, NNDataPoint.getPropSettings(prop));
				case NNDataPoint.TEMPLATE % __NNDataPoint.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNDataPoint.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNDataPoint:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint.getPropTag(prop) ' (' NNDataPoint.getFormatTag(NNDataPoint.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
